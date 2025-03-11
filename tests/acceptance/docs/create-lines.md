# Create Lines

Include lines in [Users.json](https://github.com/Telefonica/baikal-global-mocks/blob/master/api/provision/tenants/globalint/users.json)<br>
**All the ids must be unique**

## Id used to reserve line.
The IDs of ES users must consist of a string of numbers and uppercase letters with 40 characters. <br>
![line reserve id](./images/line-reserve-id.png)

## Id_document -> value 

It must have the DNI or NIE characteristics but must be unique. <br>
![line id document](./images/id-document.png)

## Identities -> phone_number                            

Include expected roles, basic ones - owner, admin, basic.<br>
![roles](./images/roles.png)

## IPTV service
![IPTV service](./images/iptv-service.png)

## Authentication
Same as `Id used to reserve line`

![line reserve id auth](./images/line-reserve-id-auth.png)<br>

 
## [Example](https://github.com/Telefonica/baikal-global-mocks/pull/1679/files)

 
**[Go Back to QA Readme](../README.md)**