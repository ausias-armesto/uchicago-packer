# Packer MySQL Image
=======

Creates a MySQL Packer AMI on AWS


## Requirements Local
------------

- Packer installed
- Make sure your local system has the AWS CLI installed and working

## Build Locally
------------

Run the packer build, which will take a few minutes:

```
packer build --debug packer.json
AMI_ID=$(jq -r '.builds[-1].artifact_id' manifest.json | cut -d ":" -f2)  
```


## Build Github
------------

On every push to branch master or develop a new image is created, with some predefined values.
For the demo purposes the the AMI tagging has not been completely defined and some default values has been hardcoded like the environment

See them on [Github Actions](https://github.com/ausias-armesto/uchicago-packer/actions)
