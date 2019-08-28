resource "oci_core_virtual_network" "IaasimovVCN" {
  cidr_block     = "10.1.0.0/16"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "IaasimovVCN"
  dns_label      = "IaasimovVCN"
}

resource "oci_core_subnet" "Iaasimov_Subnet" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  cidr_block          = "10.1.20.0/24"
  display_name        = "Iaasimov_Subnet"
  dns_label           = "IaasimovSubnet"

  security_list_ids = ["${oci_core_virtual_network.IaasimovVCN.default_security_list_id}",
    "${oci_core_security_list.IaasimovSecurityList.id}",
  ]

  compartment_id  = "${var.compartment_ocid}"
  vcn_id          = "${oci_core_virtual_network.IaasimovVCN.id}"
  route_table_id  = "${oci_core_route_table.IaasimovRT.id}"
  dhcp_options_id = "${oci_core_virtual_network.IaasimovVCN.default_dhcp_options_id}"
}

resource "oci_core_internet_gateway" "IaasimovIG" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "IaasimovGateway"
  vcn_id         = "${oci_core_virtual_network.IaasimovVCN.id}"
}

resource "oci_core_route_table" "IaasimovRT" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.IaasimovVCN.id}"
  display_name   = "IaasimovRouteTable"

  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.IaasimovIG.id}"
  }
}

resource "oci_core_security_list" "IaasimovSecurityList" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.IaasimovVCN.id}"
  display_name   = "IaasimovSecurityList"

  # ICMP Rules
  ingress_security_rules {
    protocol  = 1
    source    = "0.0.0.0/0"
    stateless = true

    icmp_options = {
      "type" = 3
      "code" = 4
    }
  }

  // Port 9000 for Docker-Portainer, Registry, RegistryUI
  ingress_security_rules {
    protocol  = "6"         // tcp
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options = {
      // These values correspond to the destination port range.
      "min" = 5000
      "max" = 5002
    }
  }

  // Port 8080 for Iaasimov
  ingress_security_rules {
    protocol  = "6"         // tcp
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options = {
      // These values correspond to the destination port range.
      "min" = 8080
      "max" = 8080
    }
  }
  
  // Port 8888 for Iaasimov
  ingress_security_rules {
    protocol  = "6"         // tcp
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options = {
      // These values correspond to the destination port range.
      "min" = 8888
      "max" = 8888
    }
  }  

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6"         // tcp
  }
}
