Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vBIHb0Wp018995
 for <selinux@tycho.nsa.gov>; Mon, 18 Dec 2017 12:37:00 -0500
From: "Arnold, Paul C CTR USARMY PEO STRI (US)" <paul.c.arnold4.ctr@mail.mil>
To: =?windows-1256?B?U0VMaW51eCD9W3NlbGludXhAdHljaG8ubnNhLmdvdl39?=
 <selinux@tycho.nsa.gov>
Date: Mon, 18 Dec 2017 17:36:22 +0000
Message-ID: <7322D64AC622D441BC921DE15D30CD21A2082E61@UGUNHPAFH.easf.csd.disa.mil>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=sha1; boundary="_88F49B24-2846-47E3-8376-E079BA971602_"
MIME-Version: 1.0
Subject: Object range_transition issue when type_transition is involved
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_88F49B24-2846-47E3-8376-E079BA971602_
Content-Type: multipart/alternative;
	boundary="_FAF66C2C-A748-4341-AA1B-90909FA70BE5_"

--_FAF66C2C-A748-4341-AA1B-90909FA70BE5_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

P { MARGIN-BOTTOM: 0px; MARGIN-TOP: 0px }  =20


All,

=20

I am experiencing some issues using range_transition on objects when type_t=
ransition is also involved on the object.  Specifically, a range_transition=
 rule on a target object with a "final" type (e.g. a type which went throug=
h a type_transition) does not seem to perform the range transition.

=20

=20

For example, using a private var log type (uses a type_transition from var_=
log_t) does not perform the range transition:

=20

range_transition mydomain_t mypriv_var_log_t:file mySystemHigh;

=20

=20

I am confident my source domain is correct, I believe the issue is with the=
 target object.  Policy version is 24.

=20

=20

Regards,

=20


--
Paul Arnold, CISSP
Cole Engineering Services, Inc.

=20

--_FAF66C2C-A748-4341-AA1B-90909FA70BE5_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr"><head>=0A=
=0A=
<style id=3D"owaParaStyle">P {=0A=
	MARGIN-BOTTOM: 0px; MARGIN-TOP: 0px=0A=
}=0A=
</style>=0A=
</head>=0A=
<body ocsi=3D"0" fpstyle=3D"1">=0A=
<div style=3D"color: rgb(0, 0, 0); font-family: Tahoma; font-size: 10pt; di=
rection: ltr;">=0A=
<div>=0A=
<p>All,</p>=0A=
<p>&nbsp;</p>=0A=
<p>I am experiencing some issues using range_transition&nbsp;on objects whe=
n type_transition is also&nbsp;involved on the object.&nbsp; Specifically, =
a range_transition rule on a target object&nbsp;with a&nbsp;"final" type (e=
.g. a type which went through a type_transition) does not seem to perform t=
he range transition.</p>=0A=
<p>&nbsp;</p>=0A=
<p>&nbsp;</p>=0A=
<p>For example, using a private var log type (uses a type_transition from v=
ar_log_t) does not perform the range transition:</p>=0A=
<p>&nbsp;</p>=0A=
<p>range_transition mydomain_t mypriv_var_log_t:file mySystemHigh;</p>=0A=
<p>&nbsp;</p>=0A=
<p>&nbsp;</p>=0A=
<p>I am confident my source domain is&nbsp;correct, I believe the issue is =
with the target object.&nbsp; Policy version is 24.</p>=0A=
<p>&nbsp;</p>=0A=
<p>&nbsp;</p>=0A=
<p>Regards,</p>=0A=
<p>&nbsp;</p>=0A=
<div style=3D"font-family: Tahoma; font-size: 13px;">=0A=
<div style=3D"font-family: Tahoma; font-size: 13px;"><font face=3D"Courier =
New"><font color=3D"#999999">--<br>Paul Arnold, CISSP<br>Cole Engineering S=
ervices, Inc.</font></font></div>=0A=
<div style=3D"font-family: Tahoma; font-size: 13px;"><font color=3D"#999999=
" face=3D"Courier New"></font>&nbsp;</div></div></div></div></body></html>

--_FAF66C2C-A748-4341-AA1B-90909FA70BE5_--

--_88F49B24-2846-47E3-8376-E079BA971602_
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJ1zCCBMIw
ggOqoAMCAQICAwzc2zANBgkqhkiG9w0BAQUFADBdMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5T
LiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNEb0QxDDAKBgNVBAsTA1BLSTEYMBYGA1UEAxMPRE9EIEVN
QUlMIENBLTM0MB4XDTE2MDYwOTAwMDAwMFoXDTE5MDYwNjIzNTk1OVowgYExCzAJBgNVBAYTAlVT
MRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0RvRDEMMAoGA1UECxMDUEtJMRMw
EQYDVQQLEwpDT05UUkFDVE9SMScwJQYDVQQDEx5BUk5PTEQuUEFVTC5DSEFSTEVTLjE0MTA3Njcy
NTkwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCpdVXPrlIHFMu+6hDPPCS6Jh9GPe6N
dEmvUIzSXxhYZesay1OmWKjffdc596ZPJVUq2eYUFo9aOJB13Zx/HPOHWVvaixNVwRsnY0Bh9Yym
chNuY5Wln7u9iZTFNMrraJB4Wmjtgigl0+oUOdznaQUuMh+TtsdGv0IyDtWQiSCnfbGfvefp6i9H
OSK79uk5RiLrmHGCCwL1hdyBbEMwl1g6CRcsmvqf8YRwj7il3vfxucjUC+Yba3CB5Arj2TnSK52O
Ih6ibul5FLQhE29D1lu1DYvxDGSUG/uPPy+YP3UJftTUggQvyBoG8FrHYk9iebVYHgNLg4Sqjt/m
ijAkrHTFAgMBAAGjggFkMIIBYDAfBgNVHSMEGDAWgBQPhll+4/rnE/sxO8E5DHxgi0DC3TA6BgNV
HR8EMzAxMC+gLaArhilodHRwOi8vY3JsLmRpc2EubWlsL2NybC9ET0RFTUFJTENBXzM0LmNybDAO
BgNVHQ8BAf8EBAMCBSAwIwYDVR0gBBwwGjALBglghkgBZQIBCwkwCwYJYIZIAWUCAQsTMB0GA1Ud
DgQWBBQXR1cFhngb9Pak20NjlBa1Fgg9ATBoBggrBgEFBQcBAQRcMFowNgYIKwYBBQUHMAKGKmh0
dHA6Ly9jcmwuZGlzYS5taWwvc2lnbi9ET0RFTUFJTENBXzM0LmNlcjAgBggrBgEFBQcwAYYUaHR0
cDovL29jc3AuZGlzYS5taWwwJgYDVR0RBB8wHYEbcGF1bC5jLmFybm9sZDQuY3RyQG1haWwubWls
MBsGA1UdCQQUMBIwEAYIKwYBBQUHCQQxBBMCVVMwDQYJKoZIhvcNAQEFBQADggEBAET324Vyidol
NI3lUzOZKtbiZTVt+ok/DXm1LW4hgMeImJFtQ0xMZomeXds5VR8ZnSLtCCMZxhfjnS/ucvMFXYgC
bbNFxalU8n0tu8boNKiNkkr1lNGPfmV0xHCJY/x8rELzVKDs8KtfUoOBdqt0oT/x6v49exQpARfe
+OA7vEmi6IKTePW7Hb0rTgw+QvuRzm5wNeLgPrJ3Ik/g0u3+gr30geXZcJf6bRx9YtqY6fuZ8kh6
nDeh6gVms978ewqZJBawqXLb6PxGCdD78f9edG0qjYkK0epNSK0iR5Srv89gKnG9vVsqG6s2/fmy
wOha9pQnJatV/cTfIC3ClfTbD7IwggUNMIID9aADAgECAgMM3NowDQYJKoZIhvcNAQEFBQAwXTEL
MAkGA1UEBhMCVVMxGDAWBgNVBAoTD1UuUy4gR292ZXJubWVudDEMMAoGA1UECxMDRG9EMQwwCgYD
VQQLEwNQS0kxGDAWBgNVBAMTD0RPRCBFTUFJTCBDQS0zNDAeFw0xNjA2MDkwMDAwMDBaFw0xOTA2
MDYyMzU5NTlaMIGBMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYD
VQQLEwNEb0QxDDAKBgNVBAsTA1BLSTETMBEGA1UECxMKQ09OVFJBQ1RPUjEnMCUGA1UEAxMeQVJO
T0xELlBBVUwuQ0hBUkxFUy4xNDEwNzY3MjU5MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEA620f7tRXsLRe16Na5VhsChavVczLwOt3/w877NiurSKIfJiAIy8x7JurFXmdhnSrX/AvkbKo
qbF+WwRhEw6lFI+vxiz++AdEi89AcuCJoXOkH9DuhzD5zUVHsZ2EJ4SWp18fL3TqzR1samLxf5N8
PQeZepHEG1OKq8qbrUMRJyCp+T3VfPLO+gkSa1SOAXxizbEyL4aaBzjJ8T6XG+3je6Cxk8QjoYtt
+FMHY35dg+Ql9qq8Ej7/8Xr+/6v+PEjP5vwmDXl8OcryKvHQ1YRJDMuXX5X8Skrpw7GfIE8+MAMb
X6Hh+konNK8TSJTC2AkukK/p1OG5gcuuel7eLxriCwIDAQABo4IBrzCCAaswHwYDVR0jBBgwFoAU
D4ZZfuP65xP7MTvBOQx8YItAwt0wOgYDVR0fBDMwMTAvoC2gK4YpaHR0cDovL2NybC5kaXNhLm1p
bC9jcmwvRE9ERU1BSUxDQV8zNC5jcmwwDgYDVR0PAQH/BAQDAgbAMCMGA1UdIAQcMBowCwYJYIZI
AWUCAQsJMAsGCWCGSAFlAgELEzAdBgNVHQ4EFgQUJUL2ItFFF8E/U0AeaAGL+s+LnTowaAYIKwYB
BQUHAQEEXDBaMDYGCCsGAQUFBzAChipodHRwOi8vY3JsLmRpc2EubWlsL3NpZ24vRE9ERU1BSUxD
QV8zNC5jZXIwIAYIKwYBBQUHMAGGFGh0dHA6Ly9vY3NwLmRpc2EubWlsMEYGA1UdEQQ/MD2BG3Bh
dWwuYy5hcm5vbGQ0LmN0ckBtYWlsLm1pbKAeBgorBgEEAYI3FAIDoBAMDjE0MTA3NjcyNTlAbWls
MBsGA1UdCQQUMBIwEAYIKwYBBQUHCQQxBBMCVVMwKQYDVR0lBCIwIAYKKwYBBAGCNxQCAgYIKwYB
BQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBBQUAA4IBAQA5XLXUS87sLfoUkXOxKbiyl052P8d8
+Ayja1PPL9sV+TiJpd4KtqPZrTcHn+NFXJrpmIF+p4CJHvLcFtvtROIv/Z6vRp6OQ8zobVC5Xy7k
eKxAmJxD5rY3ij7knngORjrtY/NtGIPQQd6xtJ5SMHvT0+hTVJZ+ycgFsBq+6s11tpZJVRvjdNLD
bWBALWUcYmDR+aLDcMdvi/tsqiX7R8tR56GJum5150RYij5pau32bMV4iQd5Sdgu/h7ZQFbjX3HF
SM6zxpp7d44sqn5l74xe0GVauSGaTcEdrlwHuTOWCpX75NYGWqlov1YLbQ/AOTbc+qRcJK6Jf5+W
eJSC850NMYIC2DCCAtQCAQEwZDBdMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5t
ZW50MQwwCgYDVQQLEwNEb0QxDDAKBgNVBAsTA1BLSTEYMBYGA1UEAxMPRE9EIEVNQUlMIENBLTM0
AgMM3NowCQYFKw4DAhoFAKCCAUkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMTcxMjE4MTczNjE4WjAjBgkqhkiG9w0BCQQxFgQU6InZBDk/MKjrZCjVwO9S5ucq7R4w
cwYJKwYBBAGCNxAEMWYwZDBdMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50
MQwwCgYDVQQLEwNEb0QxDDAKBgNVBAsTA1BLSTEYMBYGA1UEAxMPRE9EIEVNQUlMIENBLTM0AgMM
3NswdQYLKoZIhvcNAQkQAgsxZqBkMF0xCzAJBgNVBAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVy
bm1lbnQxDDAKBgNVBAsTA0RvRDEMMAoGA1UECxMDUEtJMRgwFgYDVQQDEw9ET0QgRU1BSUwgQ0Et
MzQCAwzc2zANBgkqhkiG9w0BAQEFAASCAQCkzbU3FmEb7lWkPstEi+HLxIzOVTCof6zfTnuotjov
gRyuNBpiTIglLl32H4AZWkWoZLXFdf06WS7TgOY9BG8VNP0nvUQ9z0+8zq06vELuGJycwov1xqPw
SoV8umjJHcCWTTEOhZt9zXG5VBB27hkF3+rBKGEXPQ4B/TplE0VqboBJ3MmNVcydAwB4Qvf8bP+1
FaRAJYLqCm/s9fkjPQ2RSK4fzrJmgwVc5tkeklyR2hiC7Xh/BwbQMER756x/r+zehuN9bz63l+aO
myZaAyaz5skJ9ebr4WtslvpuZ9yNpX9iHAMiLxmClBRY6YJN16z6/M0ECyu36QaF0TOr2bv4AAAA
AAAA

--_88F49B24-2846-47E3-8376-E079BA971602_--
