From: =?iso-8859-1?Q?Gr=E9gory_Vanuxem?= <g.vanuxem@wanadoo.fr>
To: "SELinux Mailing" <SELinux@tycho.nsa.gov>
Subject: TR: logging messages
Date: Fri, 14 Mar 2003 11:52:41 +0100
MIME-Version: 1.0
Message-ID: <ADEEIKPBIEHIINPOFGAOOEJHCHAA.g.vanuxem@wanadoo.fr>
Content-Type: multipart/signed;
	boundary="----=_NextPart_000_0089_01C2EA20.34143DB0";
	protocol="application/x-pkcs7-signature";
	micalg=SHA1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0089_01C2EA20.34143DB0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



-----Message d'origine-----
De : Gr=E9gory Vanuxem [mailto:g.vanuxem@wanadoo.fr]
Envoy=E9 : vendredi 14 mars 2003 11:52
=C0 : Russell Coker
Objet : RE: logging messages


You can use
sysctl -w kernel.printk=3D4

I think.

	Cheers.
PS : You can use /etc/sysctl.conf as well

> -----Message d'origine-----
> De : owner-selinux@tycho.nsa.gov =
[mailto:owner-selinux@tycho.nsa.gov]De
> la part de Russell Coker
> Envoy=E9 : jeudi 13 mars 2003 22:11
> =C0 : SE Linux
> Objet : logging messages
>=20
>=20
> People have been asking how to turn off the SE Linux console=20
> messages (it gets=20
> annoying having thousands of messages scrolling by while you're=20
> trying to fix=20
> a problem).
>=20
> The following command will direct all messages of default=20
> priority away from=20
> the console.  The default is "7 4 1 7".  The second number is the=20
> priority of=20
> default messages, setting it to 7 makes default messages of too low a=20
> priority to be on the console.
> echo "7 7 1 7" > /proc/sys/kernel/printk
>=20
> It would be good if we had a tunable option in SE Linux to specify the
> priority of the messages.
>=20
> --
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux =
packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
>=20
>=20
> --
> This message was distributed to subscribers of the selinux mailing =
list.
> If you no longer wish to subscribe, send mail to=20
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
------=_NextPart_000_0089_01C2EA20.34143DB0
Content-Type: application/x-pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIFwjCCAoIw
ggHroAMCAQICAwl2WjANBgkqhkiG9w0BAQQFADCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdl
c3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsT
FENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAw
MC44LjMwMB4XDTAzMDMwODE1MjkwOFoXDTA0MDMwNzE1MjkwOFowRjEfMB0GA1UEAxMWVGhhd3Rl
IEZyZWVtYWlsIE1lbWJlcjEjMCEGCSqGSIb3DQEJARYUZy52YW51eGVtQHdhbmFkb28uZnIwgZ8w
DQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAM9Pm0hj9s4gQRRslTUjGHzljzEon+gtujrnCwnM911S
pYa7AkdP99CiDi01AB45ZhzQyLKJ0hY+QhWA+3hGC7JcTC/IvD8IgrIeJIWPwxj3NtrFZhxNr8EP
r/e1W72kggsOxraHtdMz1VRw4Erv82AgMWe+q3REoNQQr95NDkIhAgMBAAGjMTAvMB8GA1UdEQQY
MBaBFGcudmFudXhlbUB3YW5hZG9vLmZyMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEA
H0SbjkHLf/+9jgzsc2ItAZz9ojqNY2c0dnZQu1pUddiZKY1zqI/qMoxyNkiD6FE8OmBpP4EL/EIV
uBxXBh17UTxKtOvVrIG2JGFi1VELSyLkZrhkEYWc97yU8x2IkdB7Zs/oW1m6gCgiGzkjBr33L6ep
aa4HUox2L8ANrPxjJhgwggM4MIICoaADAgECAhBmRXK3zHT1z2N2RYTQLpEBMA0GCSqGSIb3DQEB
BAUAMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBl
IFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9u
IFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0Ex
KzApBgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDAwODMwMDAw
MDAwWhcNMDQwODI3MjM1OTU5WjCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2Fw
ZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsTFENlcnRpZmlj
YXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAwMC44LjMwMIGf
MA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDeMzKmY8cJJUU+0m54J2eBxdqIGYKXDuNEKYpjNSpt
cDz63K737nRvMLwzkH/5NHGgo22Y8cNPomXbDfpL8dbdYaX5hc1VmjUanZJ1qCeu2HL5ugL217CR
3hzpq+AYA6h8Q0JQUYeDPPA5tJtUihOH/7ObnUlmAC0JieyUa+mhaQIDAQABo04wTDApBgNVHREE
IjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMS0yOTcwEgYDVR0TAQH/BAgwBgEB/wIBADAL
BgNVHQ8EBAMCAQYwDQYJKoZIhvcNAQEEBQADgYEAMbFLR135AXHl9VNsXXnWPZjAJhNigSKnEvgi
legbSbcnewQ5uvzm8iTrkfq97A0qOPdQVahs9w2tTBu8A/S166JHn2yiDFiNMUIJEWywGmnRKxKy
QF1q+XnQ6i4l3Yrk/NsNH50C81rbyjz2ROomaYd/SJ7OpZ/nhNjJYmKtBcYxggH7MIIB9wIBATCB
mjCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBU
b3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYD
VQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAwMC44LjMwAgMJdlowCQYFKw4DAhoFAKCBtzAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wMzAzMTQxMDUyMzVaMCMG
CSqGSIb3DQEJBDEWBBQUANnUepTg2IQBUQWsqS9oWc78vzBYBgkqhkiG9w0BCQ8xSzBJMA4GCCqG
SIb3DQMCAgIAgDAKBggqhkiG9w0DBzAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDAHBgUrDgMCGjAK
BggqhkiG9w0CBTANBgkqhkiG9w0BAQEFAASBgETNLz4LkpG5T5ceHpxcQ3bUMQTUBejUZrfkeoEe
Uz7kjfPDVA4Od9fgbTTpqctBOt4edFhPSaB87yjENUk47Pq6qgTMeKgCl5mfwpTLzdYp2Qwoa5Jr
b73HUPr+k4QcI9FOhLWoIBQlCarYhIpKgQynrrAYfryOsLQyfsH5Z1dUAAAAAAAA

------=_NextPart_000_0089_01C2EA20.34143DB0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
