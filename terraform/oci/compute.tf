resource "oci_core_instance" "Iaasimov_Instance" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "${var.InstanceName}"
  image               = "${var.InstanceImageOCID[var.region]}"
  shape               = "${var.InstanceShape}"

  create_vnic_details {
    subnet_id        = "${oci_core_subnet.Iaasimov_Subnet.id}"
    display_name     = "PrimaryVNIC"
    assign_public_ip = true
    hostname_label   = "${var.InstanceName}"
  }

  metadata {
    ssh_authorized_keys = "${file(var.compute_ssh_public_key)}"
  }

  timeouts {
    create = "60m"
  }
}
