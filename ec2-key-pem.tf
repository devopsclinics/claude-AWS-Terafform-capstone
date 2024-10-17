# Generate an EC2 key pair
resource "aws_key_pair" "my_key" {
  # Name of the key pair
  key_name   = var.key_name
  # Attach the generated public key to the key pair  
  public_key = tls_private_key.my_key.public_key_openssh  
}

# Generate the private key
resource "tls_private_key" "my_key" {
  algorithm = "RSA"  # Specify algorithm (RSA only works)
  rsa_bits  = 2048   # Key size (relevant only for RSA)
}

# Output the private key in PEM format
output "private_key_pem" {
  value     = tls_private_key.my_key.private_key_pem
  sensitive = true  # Hide the key from the output log
}

# Save the private key to a local file in PEM format
resource "local_file" "private_key" {
  filename = "${path.module}/${var.key_name}.pem"
  content  = tls_private_key.my_key.private_key_pem
  file_permission = "0400"  # Secure file permissions
}


