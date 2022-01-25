terraform {
    required_providers {
        ncloud = {
            source = "NaverCloudPlatform/ncloud"
        }
    }
    required_version = ">= 0.13"
}
resource "ncloud_init_script" "init_script" {
    name    = var.script-name
    content = "#!/bin/bash\nyum -y remove mariadb-libs\nyum -y install httpd php mysql php-mysql\nsystemctl enable httpd\ncd /var/www/html\nwget http://211.249.50.207/lab/lab.tgz\ntar xvfz lab.tgz\ncat phpadd >> /etc/httpd/conf/httpd.conf\nsystemctl start httpd \n"
}