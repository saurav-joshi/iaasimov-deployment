node('Iaasimov-BuildNode')
{  
    properties([
      parameters([
        string(
            name: 'CLOUD_ACCOUNT_NAME', 
            defaultValue: 'apaciaas',
            description: 'The account name of the cloud account to deploy to.'
        ),
        string(
            name: 'INSTANCE_NAME', 
            defaultValue: '',
            description: 'Iaasimov Instance Name'
        ),
      ])
    ])
 
  env.ENV_DIR="$IAASIMOV_DEPLOY_DIR/${params.CLOUD_ACCOUNT_NAME}"
  env.INSTANCE_TF_DIR="${env.ENV_DIR}/${params.INSTANCE_NAME}"
  def tfHome = tool name: 'Terraform', type: 'org.jenkinsci.plugins.terraform.TerraformInstallation'
  env.PATH = "${tfHome}:${env.PATH}"  

  stage('Init') {

    sh '''
      if [ -z "${INSTANCE_NAME} ] ; then
        echo "[ERROR] Missing Parameter value : INSTANCE_NAME"
        exit 1
      fi

      if [ -z "${CLOUD_ACCOUNT_NAME}" ] ; then
        echo "[ERROR] Missing Paramter value : CLOUD_ACCOUNT_NAME"
        exit 1
      fi

      echo "OCI Settings : ${ENV_DIR}"
      echo "Terraform Instance Working Directory : ${INSTANCE_TF_DIR}"
      
      if [ ! -f "${ENV_DIR}/credentials/oci_env" ] ; then
        echo "Credentials File Not Found. Will not be able to provision to this cloud account"
        exit 1
      else
        echo "Credentials check ok"
      fi
      
      if [ -d "${INSTANCE_TF_DIR}" ]; then
        echo "Demo instance working found."
        cd ${INSTANCE_TF_DIR}
        if [ -f ${INSTANCE_NAME}.tfvar -a -f terraform.tfstate ] ; then
          echo "[INFO]  Found existing environment files. Will destroy existing instance"
          terraform init -plugin-dir=/opt/terraform/plugins
          terraform destroy -var-file=${INSTANCE_TF_DIR}/${INSTANCE_NAME}.tfvar -force
          if [ $? -ne "0" ] ; then
            echo "[ERROR] Error destroying environment. Terraform has thrown an error"
            exit 1
          fi
          cd ..
          rm -rf ${INSTANCE_TF_DIR}
          echo "[INFO]  Workspace is cleared. Existing environment destroyed"
        else
          echo "[INFO]  No state or variables files found. No existing instance information."
        fi
      fi
      
      echo "[INFO]  Creating a new backend"
      mkdir -p "${INSTANCE_TF_DIR}"
      
    '''
    
    checkout scm

    sh '''      
      sh $WORKSPACE/terraform/oci/scripts/generateTerraformVariables.sh "${ENV_DIR}" "${INSTANCE_NAME}"
    '''
  }

  stage('Provision') {
    sh '''
      cd $WORKSPACE/terraform/oci
      terraform init -plugin-dir=/opt/terraform/plugins
      terraform apply -var-file=${INSTANCE_TF_DIR}/${INSTANCE_NAME}.tfvar -state=${INSTANCE_TF_DIR}/terraform.tfstate -backup=${INSTANCE_TF_DIR} -auto-approve -input=false

      # Copy all the terraform files over to the INSTANCE_TF_DIR so we can destroy it directly without scm checkout
      cp -r *.tf ${INSTANCE_TF_DIR}
    '''            
  }

  stage('Test') {
    // Check that mySQL DB is working

    // Check that docker containers is working
  }

  stage('Notify') {

  }

}
