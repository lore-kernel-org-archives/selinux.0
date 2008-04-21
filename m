Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3LFltth031278
	for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2008 11:47:55 -0400
Received: from smtp103.sbc.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m3LFlsr9006134
	for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2008 15:47:55 GMT
Cc: SE Linux <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>
Message-Id: <75F5689B-C03A-4840-A560-B77AF2DCBDFB@nall.com>
From: Joe Nall <joe@nall.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <1208785055.15796.40.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; boundary=Apple-Mail-53-704876755; micalg=sha1; protocol="application/pkcs7-signature"
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: avc_init & avc_open
Date: Mon, 21 Apr 2008 10:47:06 -0500
References: <7A092CE0-19C7-4686-96CF-698A69267BBA@nall.com> <1208785055.15796.40.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-53-704876755
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit


On Apr 21, 2008, at 8:37 AM, Stephen Smalley wrote:

>
> On Mon, 2008-04-21 at 08:21 -0500, Joe Nall wrote:
>> I have a userspace object manager that I would like to specify the  
>> log
>> callback and the enforcing mode for simultaneously. The enforcing  
>> mode
>> can be set with avc_open (no man page) and the callbacks with
>> avc_init(3). What is the best strategy?
>
> avc_init() was the old interface.
> selinux_set_callback() + avc_open() is the new interface.

Do you know what rawhide rpm SELABEL_CB_LOG and friends might be in?  
They are not in <selinux/selinux.h> or in /usr/include on a current  
rawhide with libselinux-devel.

joe




--Apple-Mail-53-704876755
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIIqzCCBDIw
ggMaoAMCAQICAR0wDQYJKoZIhvcNAQEFBQAwWzELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD1UuUy4g
R292ZXJubWVudDEMMAoGA1UECxMDRG9EMQwwCgYDVQQLEwNQS0kxFjAUBgNVBAMTDURvRCBSb290
IENBIDIwHhcNMDYwNjE0MTcwNDAzWhcNMTIwNjE0MTYwNDAzWjBdMQswCQYDVQQGEwJVUzEYMBYG
A1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNEb0QxDDAKBgNVBAsTA1BLSTEYMBYGA1UE
AxMPRE9EIEVNQUlMIENBLTE2MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDhLwdkjsbyObA
y1xFSIN58Ffu5Uvt8Fvnf/2kW27pjGkSnkoOH0Y0/xJFJcS5bDDb//kz3eojDlhn906fVccBuoZ7
mWLptyXcPRIfFDzdykorWcdHn8+EKSD80ylXnsjxVPpFm6qio9GvHFK8ceMXGbnXBDlrDZMiICQl
m84kTwIDAQABo4IBgTCCAX0wDgYDVR0PAQH/BAQDAgGGMB8GA1UdIwQYMBaAFEl0uwxeunr+AlTv
e6DGlcYJgHCWMB0GA1UdDgQWBBRHk8ejIzy0Me7MQnzdaBPLAZqPLTAMBgNVHSQEBTADgAEAMA8G
A1UdEwEB/wQFMAMBAf8wMAYDVR0gBCkwJzALBglghkgBZQIBCwUwCwYJYIZIAWUCAQsJMAsGCWCG
SAFlAgELCjCB2QYDVR0fBIHRMIHOMDigNqA0hjJodHRwOi8vY3JsLmdkcy5kaXNhLm1pbC9nZXRj
cmw/RG9EJTIwUm9vdCUyMENBJTIwMjCBkaCBjqCBi4aBiGxkYXA6Ly9jcmwuZ2RzLmRpc2EubWls
L2NuJTNkRG9EJTIwUm9vdCUyMENBJTIwMiUyY291JTNkUEtJJTJjb3UlM2REb0QlMmNvJTNkVS5T
LiUyMEdvdmVybm1lbnQlMmNjJTNkVVM/Y2VydGlmaWNhdGVyZXZvY2F0aW9ubGlzdDtiaW5hcnkw
DQYJKoZIhvcNAQEFBQADggEBAAZhhKwoETryrmbMiJj6Tr6XxadbI42CLQEnkTDqxiLJVzQ6h/n4
Blv6Zm2xie3Tm0NigASlKlNoWNRrVojLahSiTn10G2c6iwe1LOSgICe/SGfo8+nJaZ9/AUhh+8En
d3uPvq7SQtEMMSQmndcakfONrP5vky3gHk/HOQR/cR8up8nnP+hx3iq30KwRC27qizWjdZU9rmcI
F92GGPpIkhsALmEXqWxURGlJIBctWQqbAepDRKDnV9JUhBcT400kANiueiDX40qPN8R/vLGhgyF+
c3E3aJHbReL/2BrtEGBauWHMwAA8pW3MuZz+xp3HGp7AcE2CwTn4hsrBoA/Q+ekwggRxMIID2qAD
AgECAgMJCIswDQYJKoZIhvcNAQEFBQAwXTELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD1UuUy4gR292
ZXJubWVudDEMMAoGA1UECxMDRG9EMQwwCgYDVQQLEwNQS0kxGDAWBgNVBAMTD0RPRCBFTUFJTCBD
QS0xNjAeFw0wNzA1MjEwMDAwMDBaFw0wOTAxMzEyMzU5NTlaMHsxCzAJBgNVBAYTAlVTMRgwFgYD
VQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0RvRDEMMAoGA1UECxMDUEtJMRMwEQYDVQQL
EwpDT05UUkFDVE9SMSEwHwYDVQQDExhOQUxMLkpPU0VQSC5ELjEyNjUwODIwNTYwgZ8wDQYJKoZI
hvcNAQEBBQADgY0AMIGJAoGBAIQaYg7wCON3AccvTUkzRHFGkA7lrHchWPxvsIhLwXvku/a0ltwk
eQJMomHL/3GQQ/Y3eEPTklFQyGoJkx6uaQu6v6eOlWqzf4RnOpoR57LHZpE50evy0RnZfEepSRzW
K4uL5tp0k/sTcuESdyt7g4hhob1DBdOntehdBcRm3Hl3AgMBAAGjggIfMIICGzAOBgNVHQ8BAf8E
BAMCBsAwHwYDVR0jBBgwFoAUR5PHoyM8tDHuzEJ83WgTywGajy0wHQYDVR0OBBYEFB+HBoRJ6sDm
KYkyzdyMq1dRO3ZWMBYGA1UdIAQPMA0wCwYJYIZIAWUCAQsJMIHZBgNVHR8EgdEwgc4wOKA2oDSG
Mmh0dHA6Ly9jcmwuZ2RzLmRpc2EubWlsL2dldGNybD9ET0QlMjBFTUFJTCUyMENBLTE2MIGRoIGO
oIGLhoGIbGRhcDovL2NybC5nZHMuZGlzYS5taWwvY24lM2RET0QlMjBFTUFJTCUyMENBLTE2JTJj
b3UlM2RQS0klMmNvdSUzZERvRCUyY28lM2RVLlMuJTIwR292ZXJubWVudCUyY2MlM2RVUz9jZXJ0
aWZpY2F0ZVJldm9jYXRpb25MaXN0O2JpbmFyeTApBgNVHSUEIjAgBgorBgEEAYI3FAICBggrBgEF
BQcDBAYIKwYBBQUHAwIwNwYDVR0RBDAwLoEMam9lQG5hbGwuY29toB4GCisGAQQBgjcUAgOgEAwO
MTI2NTA4MjA1NkBtaWwwcQYIKwYBBQUHAQEEZTBjMD8GCCsGAQUFBzAChjNodHRwOi8vY3JsLmdk
cy5kaXNhLm1pbC9nZXRzaWduP0RPRCUyMEVNQUlMJTIwQ0EtMTYwIAYIKwYBBQUHMAGGFGh0dHA6
Ly9vY3NwLmRpc2EubWlsMA0GCSqGSIb3DQEBBQUAA4GBAGyIAqWQ5N0DQL4HRnIZsZohhrq//qdz
XLVCRjLMQuWIGzuZheD6fvksx+dcDdPu8vcJLUUis2Kp8cGATA3dmXWI018hv534HvJnKtHvizpe
PIxHmZAacVhBV//BBJU8h3E2lKRkUuyKtAYgpXWy73UhcUoIKAPmGFgpKGQNJVSJMYICVzCCAlMC
AQEwZDBdMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNE
b0QxDDAKBgNVBAsTA1BLSTEYMBYGA1UEAxMPRE9EIEVNQUlMIENBLTE2AgMJCIswCQYFKw4DAhoF
AKCCAUkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDgwNDIxMTU0
NzA2WjAjBgkqhkiG9w0BCQQxFgQU/45l2Kk6YjEXZusoAVlNlrcZpdYwcwYJKwYBBAGCNxAEMWYw
ZDBdMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNEb0Qx
DDAKBgNVBAsTA1BLSTEYMBYGA1UEAxMPRE9EIEVNQUlMIENBLTE2AgMJCIswdQYLKoZIhvcNAQkQ
AgsxZqBkMF0xCzAJBgNVBAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsT
A0RvRDEMMAoGA1UECxMDUEtJMRgwFgYDVQQDEw9ET0QgRU1BSUwgQ0EtMTYCAwkIizANBgkqhkiG
9w0BAQEFAASBgAMN4mM8HdYax2UylN06pwC0MfjJ9AmKna0EVhRcOSOaecPrHlFMLAT42VILAJju
QqovOPBBoWDoxe1u5BzR7CwX6VzSFvzuAZXZePLxoY0VEo94VMBiLl3qQSfAE8/6G1TcY9oagilD
MUQvVf48v1mBF/Luvujm89yCUU+MJz2mAAAAAAAA

--Apple-Mail-53-704876755--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
