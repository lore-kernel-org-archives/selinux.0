Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i165uqRb021044
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 00:56:52 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i165upOi004005
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 05:56:51 GMT
Received: from winnie.urbanrage.com (host30-5.btbx.net [199.86.30.5])
        by jazzband.ncsc.mil  with ESMTP id i165uoWW003996 for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 05:56:51 GMT
Received: from localhost (localhost [127.0.0.1])
	by winnie.urbanrage.com (Postfix) with ESMTP id 63757419F9
	for <selinux@tycho.nsa.gov>; Thu,  5 Feb 2004 23:56:32 -0600 (CST)
Received: from winnie.urbanrage.com ([127.0.0.1])
	by localhost (winnie [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 01493-07 for <selinux@tycho.nsa.gov>;
	Thu, 5 Feb 2004 23:56:30 -0600 (CST)
Received: from urbanrage.com (piglet.urbanrage.com [192.168.20.4])
	by winnie.urbanrage.com (Postfix) with ESMTP id 515D9419A2
	for <selinux@tycho.nsa.gov>; Thu,  5 Feb 2004 23:56:29 -0600 (CST)
Message-ID: <40232CBB.7020607@urbanrage.com>
Date: Thu, 05 Feb 2004 23:57:15 -0600
From: Eric Estabrooks <eric@urbanrage.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: selinux-policy-default
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms010803030800000701000007"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a cryptographically signed message in MIME format.

--------------ms010803030800000701000007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm running debian unstable with a 2.6.2 kernel se-enabled.  I was 
following the new selinux how to ( 
http://sourceforge.net/docman/display_doc.php?docid=20372&group_id=21266 
) and I've gotten stuck on the selinux-policy-default install.  It seems 
that the types for xxx_locate_t aren't defined.

[ snip lots of yes/no questions ]
Installing the new SE Linux policy
/usr/bin/checkpolicy:  loading policy configuration from 
/etc/security/selinux/src/policy.conf
domains/admin.te:32:ERROR 'unknown type sysadm_locate_t' at token ';' on 
line 5974:
allow sysadm_locate_t { sysadm_mozilla_ro_t sysadm_mozilla_rw_t }:dir { 
getattr
search };

I searched for type lines for sysadm_locate_t but couldn't find any in 
any of the .te files and I don't know what they should look like to 
generate my own.  Can someone point me to documentation that would 
explain these types?

Thanks,

Eric

--------------ms010803030800000701000007
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIII7TCC
AtEwggI6oAMCAQICAwtmjzANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDQwMTAxMTk0NDQzWhcNMDQxMjMxMTk0NDQz
WjBEMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSEwHwYJKoZIhvcNAQkBFhJl
cmljQHVyYmFucmFnZS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC23sjE
rSEPsDIdCPBsfkClgHSwWxHKws1kKYyOY+I5YKOddKYRbGMSTwh9xu99t1dCtwzFxyE4SQaj
vprABuHzZtosdajfSSPRqwwalqc/P+55zZTcQymRmUgUf5jRtboYg+rOMMc59tehq4QhFoqo
drC2cZmdOsdNMTUd0ic/jx9Z2ISPxurTmqkjHZw2V5mu4ukhlGoqsu3RnMZoUHDjNMiwMWS9
DV4H5XX6zLPhbdtvl1bRvHMkgIcHMWTobO5KQXD6QHZ5ki49uSBNCEcP6gh3qr/rA1UA9VGg
qo/izk7YSCD3mYWY/UPAXniizK0DvpDLOhcKC989JcjmGwSXAgMBAAGjLzAtMB0GA1UdEQQW
MBSBEmVyaWNAdXJiYW5yYWdlLmNvbTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBAUAA4GB
AL4KidWBdiNXFWbzuwmtBLEjSQBAg3/asOGaSPo5RzPbzOtj5WZA/qiEQveUQ6YBJ5Qk/F/N
b4SvjXCyIp7q+ieUg1x7tTTceq1YK2AndAzDxnt1exl6syny+7UQPF3LievHxEcOqYcLGLuu
AytN+GULhRpgEMPBHYnetd64vyAbMIIC0TCCAjqgAwIBAgIDC2aPMA0GCSqGSIb3DQEBBAUA
MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQu
MSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTAeFw0wNDAx
MDExOTQ0NDNaFw0wNDEyMzExOTQ0NDNaMEQxHzAdBgNVBAMTFlRoYXd0ZSBGcmVlbWFpbCBN
ZW1iZXIxITAfBgkqhkiG9w0BCQEWEmVyaWNAdXJiYW5yYWdlLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALbeyMStIQ+wMh0I8Gx+QKWAdLBbEcrCzWQpjI5j4jlgo510
phFsYxJPCH3G7323V0K3DMXHIThJBqO+msAG4fNm2ix1qN9JI9GrDBqWpz8/7nnNlNxDKZGZ
SBR/mNG1uhiD6s4wxzn216GrhCEWiqh2sLZxmZ06x00xNR3SJz+PH1nYhI/G6tOaqSMdnDZX
ma7i6SGUaiqy7dGcxmhQcOM0yLAxZL0NXgfldfrMs+Ft22+XVtG8cySAhwcxZOhs7kpBcPpA
dnmSLj25IE0IRw/qCHeqv+sDVQD1UaCqj+LOTthIIPeZhZj9Q8BeeKLMrQO+kMs6FwoL3z0l
yOYbBJcCAwEAAaMvMC0wHQYDVR0RBBYwFIESZXJpY0B1cmJhbnJhZ2UuY29tMAwGA1UdEwEB
/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEAvgqJ1YF2I1cVZvO7Ca0EsSNJAECDf9qw4ZpI+jlH
M9vM62PlZkD+qIRC95RDpgEnlCT8X81vhK+NcLIinur6J5SDXHu1NNx6rVgrYCd0DMPGe3V7
GXqzKfL7tRA8XcuJ68fERw6phwsYu64DK034ZQuFGmAQw8Edid613ri/IBswggM/MIICqKAD
AgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVy
biBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5n
MSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZy
ZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQsw
CQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcN
AQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHy
v1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsY
Pge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0T
AQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20v
VGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQe
MBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD
6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZ
GwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC
3CEZNd4ksdMdRv9dX2VPMYIDOzCCAzcCAQEwaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMc
VGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFs
IEZyZWVtYWlsIElzc3VpbmcgQ0ECAwtmjzAJBgUrDgMCGgUAoIIBpzAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNDAyMDYwNTU3MTVaMCMGCSqGSIb3DQEJ
BDEWBBSuXlY9wGvq3OVpJj7SrUbb2T/EgjBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMH
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIB
KDB4BgkrBgEEAYI3EAQxazBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwg
SXNzdWluZyBDQQIDC2aPMHoGCyqGSIb3DQEJEAILMWugaTBiMQswCQYDVQQGEwJaQTElMCMG
A1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAwtmjzANBgkqhkiG9w0BAQEFAASCAQApBtll
ZK+kwg4y3d8PUOFXAeHnoYcGasFhCaI0ZCsnYpU9Gc2Hyd4bEcnsuRMPMiay8CP6EO9KjhsA
Q0K4sAoIQ8ffgvbb6TcGLn7md8TCKm+GYhsmYPhRJEvM/UN+l10Y7ZAlB3W287MZRHHzF7M1
8jxBgHDpOtsbF2poHpSK8PNIt7KEKso6ZbyK31dkn9nvB+has7sPJR/4qdZaYOhqJLufHRqy
EjFZUQbVjtr15aqIfeFjbnzzvS51Gh8GtSybB9gqC0KP1Xd10QX9GyZ2qDu3l2Fhf9as+9ir
sYUHx3DlStb442VlusSsAEbTCQgGa+oICF1dQqqUEyEDLgkPAAAAAAAA
--------------ms010803030800000701000007--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
