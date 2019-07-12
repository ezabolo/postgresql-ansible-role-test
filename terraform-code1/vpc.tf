# Prod vpc
resource "aws_vpc" "vpc-prod" {
    cidr_block = "172.16.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
        Name = "vpcprod"
    }
}


# Subnets
resource "aws_subnet" "prod-public-1" {
    vpc_id = "${aws_vpc.vpc-prod.id}"
    cidr_block = "172.16.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"

    tags {
        Name = "prod-public-1"
    }
}
resource "aws_subnet" "prod-public-2" {
    vpc_id = "${aws_vpc.vpc-prod.id}"
    cidr_block = "172.16.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"

    tags {
        Name = "prod-public-2"
    }
}
resource "aws_subnet" "prod-public-3" {
    vpc_id = "${aws_vpc.vpc-prod.id}"
    cidr_block = "172.16.3.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1c"

    tags {
        Name = "prod-public-3"
    }
}
resource "aws_subnet" "prod-private-1" {
    vpc_id = "${aws_vpc.vpc-prod.id}"
    cidr_block = "172.16.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1a"

    tags {
        Name = "prod-private-1"
    }
}
resource "aws_subnet" "prod-private-2" {
    vpc_id = "${aws_vpc.vpc-prod.id}"
    cidr_block = "172.16.5.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1b"

    tags {
        Name = "prod-private-2"
    }
}
resource "aws_subnet" "prod-private-3" {
    vpc_id = "${aws_vpc.vpc-prod.id}"
    cidr_block = "172.16.6.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1c"

    tags {
        Name = "prod-private-3"
    }
}

# Internet GW
resource "aws_internet_gateway" "prod-gw" {
    vpc_id = "${aws_vpc.vpc-prod.id}"

    tags {
        Name = "prod-gw"
    }
}

# route tables
resource "aws_route_table" "prod-public" {
    vpc_id = "${aws_vpc.vpc-prod.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.prod-gw.id}"
    }

    tags {
        Name = "prod-public-route"
    }
}

# route associations public
resource "aws_route_table_association" "prod-public-1-a" {
    subnet_id = "${aws_subnet.prod-public-1.id}"
    route_table_id = "${aws_route_table.prod-public.id}"
}
resource "aws_route_table_association" "prod-public-2-a" {
    subnet_id = "${aws_subnet.prod-public-2.id}"
    route_table_id = "${aws_route_table.prod-public.id}"
}
resource "aws_route_table_association" "prod-public-3-a" {
    subnet_id = "${aws_subnet.prod-public-3.id}"
    route_table_id = "${aws_route_table.prod-public.id}"
}


#VPC for Dev environment
# Dev vpc
resource "aws_vpc" "vpc-dev" {
    cidr_block = "172.17.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
        Name = "vpcdev"
    }
}


# Subnets
resource "aws_subnet" "dev-public-1" {
    vpc_id = "${aws_vpc.vpc-dev.id}"
    cidr_block = "172.17.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"

    tags {
        Name = "dev-public-1"
    }
}
resource "aws_subnet" "dev-public-2" {
    vpc_id = "${aws_vpc.vpc-dev.id}"
    cidr_block = "172.17.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"

    tags {
        Name = "dev-public-2"
    }
}
resource "aws_subnet" "dev-public-3" {
    vpc_id = "${aws_vpc.vpc-dev.id}"
    cidr_block = "172.17.3.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1c"

    tags {
        Name = "dev-public-3"
    }
}
resource "aws_subnet" "dev-private-1" {
    vpc_id = "${aws_vpc.vpc-dev.id}"
    cidr_block = "172.17.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1a"

    tags {
        Name = "dev-private-1"
    }
}
resource "aws_subnet" "dev-private-2" {
    vpc_id = "${aws_vpc.vpc-dev.id}"
    cidr_block = "172.17.5.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1b"

    tags {
        Name = "dev-private-2"
    }
}
resource "aws_subnet" "dev-private-3" {
    vpc_id = "${aws_vpc.vpc-dev.id}"
    cidr_block = "172.17.6.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1c"

    tags {
        Name = "dev-private-3"
    }
}

# Internet GW
resource "aws_internet_gateway" "dev-gw" {
    vpc_id = "${aws_vpc.vpc-dev.id}"

    tags {
        Name = "dev-gw"
    }
}

# route tables
resource "aws_route_table" "dev-public" {
    vpc_id = "${aws_vpc.vpc-dev.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.dev-gw.id}"
    }

    tags {
        Name = "dev-public-route"
    }
}

# route associations public
resource "aws_route_table_association" "dev-public-1-a" {
    subnet_id = "${aws_subnet.dev-public-1.id}"
    route_table_id = "${aws_route_table.dev-public.id}"
}
resource "aws_route_table_association" "dev-public-2-a" {
    subnet_id = "${aws_subnet.dev-public-2.id}"
    route_table_id = "${aws_route_table.dev-public.id}"
}
resource "aws_route_table_association" "dev-public-3-a" {
    subnet_id = "${aws_subnet.dev-public-3.id}"
    route_table_id = "${aws_route_table.dev-public.id}"
}



