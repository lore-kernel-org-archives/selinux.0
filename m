Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2R9hZYD016828
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 05:43:35 -0400
Received: from IReS.in2p3.fr (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2R9hXMV018417
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 09:43:33 GMT
Received: from [193.48.90.58] (sbgat75.in2p3.fr [193.48.90.58])
	by IReS.in2p3.fr (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l2R9hX0a007805
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 11:43:33 +0200
Message-ID: <4608E744.20405@IReS.in2p3.fr>
Date: Tue, 27 Mar 2007 11:43:32 +0200
From: Sylviane Molinet <Sylviane.Molinet@IReS.in2p3.fr>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
Subject: nscd errors
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms080001060808000107000908"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a cryptographically signed message in MIME format.

--------------ms080001060808000107000908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I've installed redhat ES 4 server with nis authentification. But I have 
following errors in /var/log/messages :
nscd:

Mar 27 09:36:52 nscd: Can't send to audit system: USER_AVC pid=25562 
uid=28 loginuid=-1 message=avc:  denied  { getgrp } for  
scontext=root:system_r:unconfined_t tcontext=root:system_r:initrc_t 
tclass=nscd
Mar 27 09:36:52  nscd: Can't send to audit system: USER_AVC pid=25562 
uid=28 loginuid=-1 message=avc:  denied  { shmempwd } for  
scontext=root:system_r:unconfined_t tcontext=root:system_r:initrc_t 
tclass=nscd
Mar 27 09:36:52 nscd: Can't send to audit system: USER_AVC pid=25562 
uid=28 loginuid=-1 message=avc:  denied  { getpwd } for  
scontext=root:system_r:unconfined_t tcontext=root:system_r:initrc_t 
tclass=nscd

map exported are passwd group and hosts.

The files for these maps aren't located in /etc but in /var/yp/nis.

File /etc/selinux/conf is configured like this :
SELINUX=enforcing
SELINUXTYPE=targeted

When I run fixfiles I get following messages :

fixfiles -R nscd check

/sbin/restorecon:  error while labeling files under /var/run/nscd/group

/sbin/restorecon:  error while labeling files under /var/run/nscd/hosts

/sbin/restorecon:  error while labeling files under /var/run/nscd/passwd

But this files doesn't exist.

Thanks in advance for your help, I apoligized if this question has been asked before but I didn't find this topic in the archive mailing list.


-- 
Sylviane MOLINET


--------------ms080001060808000107000908
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIINTCC
A20wggJVoAMCAQICAQIwDQYJKoZIhvcNAQEEBQAwKzELMAkGA1UEBhMCRlIxDTALBgNVBAoT
BENOUlMxDTALBgNVBAMTBENOUlMwHhcNMDEwNDI3MDU0NjQ5WhcNMTEwNDI1MDU0NjQ5WjA0
MQswCQYDVQQGEwJGUjENMAsGA1UEChMEQ05SUzEWMBQGA1UEAxMNQ05SUy1TdGFuZGFyZDCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANzhHiE9BovqvV60iNsPk5e0bQc9hmIA
Lcr/tUqO51akj2Es8aAqq/Yq3Xwsv+91VQusCU7nTmHA5wzwkBVFEgLCjOvDEmTiYxAYLssH
MdmB5dwpgpsxVuKBHopvp+ipWBFEVoNds054cC3ftv1ygUXV8e5Nzu++1T0MkCBFmgmArw9M
2iAOgL86s+sngMC5D8ChTkDcOv1qKr9A1SxxgPn4umvk6ioAqy++mvCndm2YKZwPL/BC8hiX
W8n2zBlfusK+EtJcsJCUwLfLBgTvjzDtMi16SveTu6AJpLTuM8vQg5u1tbOQ3o6QHlmcINVL
Hu3XTE+G+hw6KqHprAWgnb8CAwEAAaOBkjCBjzAMBgNVHRMEBTADAQH/MB0GA1UdDgQWBBRn
WaXlB3RJA+8Fz8wupBjVEMiePDBTBgNVHSMETDBKgBRW62i50lx+mLWlU8ORb2NYxPlrt6Ev
pC0wKzELMAkGA1UEBhMCRlIxDTALBgNVBAoTBENOUlMxDTALBgNVBAMTBENOUlOCAQAwCwYD
VR0PBAQDAgEGMA0GCSqGSIb3DQEBBAUAA4IBAQAGA0eDckWQwk7hIderF6kBVQbKQG1Voh1e
6+IUI1nkCeKQ9jyNNgYPS6cmI2XC6gaacru4jMuKX+95NiV+ANfzBpT7g0QpJjfH7umHzmyG
gBtxPdJir/bNYmxTD+Z6kwCMey4z4EEdqr5lmHbxlQd0s+Y/U3XVSwY2SynE9tyOE4BAEHOC
rRV7BHFQtTcz8shku6EQfjbGra9vcFKm0a7MzLqw6FkSj2INrQPdSyroiTmIUS/tYei3MIfb
J1VtZoejUQmAYXFRBb4THdlBMPx1XwqWmxj/vpCBtBPAchEI/Wqaage99IMstGA2ZAf6PWqn
sJAEdoPdM8s04heYBAuhMIIEwDCCA6igAwIBAgICT/YwDQYJKoZIhvcNAQEFBQAwNDELMAkG
A1UEBhMCRlIxDTALBgNVBAoTBENOUlMxFjAUBgNVBAMTDUNOUlMtU3RhbmRhcmQwHhcNMDcw
MjA1MTQxMjAwWhcNMDgwMjA1MTQxMjAwWjB4MQswCQYDVQQGEwJGUjENMAsGA1UEChMEQ05S
UzEQMA4GA1UECxMHVU1SNzE3ODEZMBcGA1UEAxMQU3lsdmlhbmUgTW9saW5ldDEtMCsGCSqG
SIb3DQEJARYec3lsdmlhbmUubW9saW5ldEBpcmVzLmluMnAzLmZyMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAyNvlQU5tuO7NrZ3F26e5cd8/lkY0IBDr9SSZ4vX4LKFekdUk
DuUaAxlnW2KtTmRQq7K7729jblzwC2o7kaDZfV7GhdPIOtgSbrK/pmeKX9AfP5FhWzQLUHSd
TzfH6XkT/YPBmvlPj7PcAyVi6TokWg026izbgMfXHQD7JAEhxYFNskxLN8RqP5PYu+xe9L9E
WjBDC1UAF2uvO15S4dv11bXG3adopXhLjf114n/2Xe//hbs6kcaoJb33yGTelZoItA6s+bZ8
S68jYpTelVxUvwT4Km5GEsNA+xYEbfaJIuaktJP6vRYwViPAfAo/RXZoKvWfrtiNvLNMBAAY
aXWmswIDAQABo4IBljCCAZIwDAYDVR0TAQH/BAIwADARBglghkgBhvhCAQEEBAMCBLAwDgYD
VR0PAQH/BAQDAgXgMHgGCWCGSAGG+EIBDQRrFmlDZXJ0aWZpY2F0IENOUlMtU3RhbmRhcmQu
IFBvdXIgdG91dGUgaW5mb3JtYXRpb24gc2UgcmVwb3J0ZXIg4CBodHRwOi8vaWdjLnNlcnZp
Y2VzLmNucnMuZnIvQ05SUy1TdGFuZGFyZC8wHQYDVR0OBBYEFO7jfBOFY9+L8Zmp7xhGyNua
HIgoMFMGA1UdIwRMMEqAFGdZpeUHdEkD7wXPzC6kGNUQyJ48oS+kLTArMQswCQYDVQQGEwJG
UjENMAsGA1UEChMEQ05SUzENMAsGA1UEAxMEQ05SU4IBAjApBgNVHREEIjAggR5zeWx2aWFu
ZS5tb2xpbmV0QGlyZXMuaW4ycDMuZnIwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybHMu
c2VydmljZXMuY25ycy5mci9DTlJTLVN0YW5kYXJkL2dldGRlci5jcmwwDQYJKoZIhvcNAQEF
BQADggEBABuIETIq3jEQpngf/JdJ6PU0X9fhgL2oZKwbnM99lFm/ykLshnyXtS6SySctROGp
YZT9VJjOsf5wPsaZGRPmhZNRh66ZBbvJcZLGINqiYDzqXGHC5xYK1l3aiY/i8rl2SLAwxvR0
MVXvzQO/DNgQDuqYWTkunbN89tATPkqaT3moC+J161mRhNbMd1NaW6+/Ro/tzdA7cu4EKu0T
PXUjrqQmJlCIyNjDX/Ky3ZCiF4O0fByJI9FBRma5e5AB0z2YIL3hAR8PMbHC8IHS62Xo7Hbj
tonzR+SgvXyyd5ZJw6GXFW2bkLKU+OexrCW9Gw0hwAoL6I25+nZrKyGlKzedNc8xggIVMIIC
EQIBATA6MDQxCzAJBgNVBAYTAkZSMQ0wCwYDVQQKEwRDTlJTMRYwFAYDVQQDEw1DTlJTLVN0
YW5kYXJkAgJP9jAJBgUrDgMCGgUAoIGxMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTA3MDMyNzA5NDMzMlowIwYJKoZIhvcNAQkEMRYEFBqkcmyPjXJ4vNSk
U+ru9ykAMP/yMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUA
BIIBAIRRWZmzoo+BYQ+FUG36oaXZtHYARJYqPbUXeHMXLLoU9MZHZZPLTPBCZnG00c77BTMS
ySna83T4ha3Z2CHppocXSEaqKgoX0Yz2bGVvUT2neMeRw2y22uylQciUz/pL7n+43bJ7I4Dl
Re0lCD04KQe4d5IogPZMDmpQV1EY4qkaEwNFxe0DxDka4WaVjZ7Do01qQqboyhKiXcJgk9Bp
inHPJv4HSOPX/uL877T+DcMomM/V+Y1BupdzYNT4h+DPvazmhfdHYkTdshpakQq4kUj09GPr
c4hLMjKQVo4w8uMrvLkWAn5aCJKd8qyvB9XJyJv1UI9wmnDmhk/uqxGV3zYAAAAAAAA=
--------------ms080001060808000107000908--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
