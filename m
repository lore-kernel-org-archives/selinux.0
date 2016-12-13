Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBDJtbw9009526
 for <selinux@tycho.nsa.gov>; Tue, 13 Dec 2016 14:55:38 -0500
From: "Parker, Michael D." <Michael.D.Parker@ga.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Possible SELinux problem on Fedora 25 Install
Date: Tue, 13 Dec 2016 19:55:34 +0000
Message-ID: <fc9b755857cd4bffa582fcac7ea2e574@ASGEXCPWP01.ga.com>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=SHA1; boundary="----=_NextPart_000_001E_01D25537.C61569A0"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

------=_NextPart_000_001E_01D25537.C61569A0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_001F_01D25537.C61569A0"


------=_NextPart_001_001F_01D25537.C61569A0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I am getting the following messages during the last update concerning
SELinux packages...I do a pretty much vanilla install here and have not
modified any SELinux functionality...should I be concerned?

 

  Upgrading   : selinux-policy-3.13.1-225.3.fc25.noarch
1/38

Re-declaration of boolean virt_sandbox_use_fusefs

Failed to create node

Bad boolean declaration at
/var/lib/selinux/targeted/tmp/modules/100/virt/cil:152

semodule:  Failed!

  Upgrading   : samba-common-2:4.5.2-0.fc25.noarch
2/38

  Upgrading   : libwbclient-2:4.5.2-0.fc25.x86_64
3/38

  Upgrading   : samba-client-libs-2:4.5.2-0.fc25.x86_64
4/38

  Installing  : kernel-core-4.8.13-300.fc25.x86_64
5/38

  Installing  : kernel-modules-4.8.13-300.fc25.x86_64
6/38

  Upgrading   : selinux-policy-targeted-3.13.1-225.3.fc25.noarch
7/38

Re-declaration of boolean virt_sandbox_use_fusefs

Failed to create node

Bad boolean declaration at
/var/lib/selinux/targeted/tmp/modules/100/virt/cil:152

/usr/sbin/semodule:  Failed!

  Upgrading   : pcsc-lite-libs-1.8.19-1.fc25.x86_64
8/38

  Upgrading   : pcsc-lite-1.8.19-1.fc25.x86_64
9/38

  Upgrading   : selinux-policy-sandbox-3.13.1-225.3.fc25.noarch
10/38

Re-declaration of boolean virt_sandbox_use_fusefs

Failed to create node

Bad boolean declaration at
/var/lib/selinux/targeted/tmp/modules/100/virt/cil:152

semodule:  Failed!

  Installing  : kernel-4.8.13-300.fc25.x86_64
11/38

  Upgrading   : libsmbclient-2:4.5.2-0.fc25.x86_64
12/38

  Upgrading   : selinux-policy-mls-3.13.1-225.3.fc25.noarch
13/38

  Upgrading   : selinux-policy-minimum-3.13.1-225.3.fc25.noarch
14/38

Failed to resolve typeattributeset statement at
/var/lib/selinux/minimum/tmp/modules/100/xserver/cil:472

/usr/sbin/semodule:  Failed!

 

***** ***** *****

Michael D. Parker

General Atomics - ElectroMagnetics Systems Division (EMS)

 <mailto:Michael.d.parker@ga.com> Michael.d.parker@ga.com  <<<<< NOTE:
Remember to include my middle initial >>>>>

+1 858 964 6675 / Office 86-1319 / Cell +1 858 376 7474

16969 Mesamint Street / San Diego / CA / 92127

 


------=_NextPart_001_001F_01D25537.C61569A0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 15 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Comic Sans MS";
	panose-1:3 15 7 2 3 3 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US =
link=3D"#0563C1" vlink=3D"#954F72"><div class=3DWordSection1><p =
class=3DMsoNormal>I am getting the following messages during the last =
update concerning SELinux packages&#8230;..I do a pretty much vanilla =
install here and have not modified any SELinux =
functionality&#8230;..should I be concerned?<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><b><span =
style=3D'font-family:"Courier New";color:red'>&nbsp; =
Upgrading&nbsp;&nbsp; : selinux-policy-3.13.1-225.3.fc25.noarch&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1/38<o:p></o:p></s=
pan></b></p><p class=3DMsoNormal><b><span style=3D'font-family:"Courier =
New";color:red'>Re-declaration of boolean =
virt_sandbox_use_fusefs<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span style=3D'font-family:"Courier =
New";color:red'>Failed to create node<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span style=3D'font-family:"Courier =
New";color:red'>Bad boolean declaration at =
/var/lib/selinux/targeted/tmp/modules/100/virt/cil:152<o:p></o:p></span><=
/b></p><p class=3DMsoNormal><b><span style=3D'font-family:"Courier =
New";color:red'>semodule:&nbsp; Failed!<o:p></o:p></span></b></p><p =
class=3DMsoNormal><span style=3D'font-family:"Courier New"'>&nbsp; =
Upgrading&nbsp;&nbsp; : =
samba-common-2:4.5.2-0.fc25.noarch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2/38<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-family:"Courier New"'>&nbsp; Upgrading&nbsp;&nbsp; : =
libwbclient-2:4.5.2-0.fc25.x86_64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3/38<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-family:"Courier New"'>&nbsp; Upgrading&nbsp;&nbsp; : =
samba-client-libs-2:4.5.2-0.fc25.x86_64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 4/38<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'font-family:"Courier New"'>&nbsp; =
Installing&nbsp; : =
kernel-core-4.8.13-300.fc25.x86_64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;5/38<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-family:"Courier New"'>&nbsp; Installing&nbsp; : =
kernel-modules-4.8.13-300.fc25.x86_64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6/38<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'font-family:"Courier New"'>&nbsp; =
<b><span style=3D'color:red'>Upgrading&nbsp;&nbsp; : =
selinux-policy-targeted-3.13.1-225.3.fc25.noarch&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7/38<o:=
p></o:p></span></b></span></p><p class=3DMsoNormal><b><span =
style=3D'font-family:"Courier New";color:red'>Re-declaration of boolean =
virt_sandbox_use_fusefs<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span style=3D'font-family:"Courier =
New";color:red'>Failed to create node<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span style=3D'font-family:"Courier =
New";color:red'>Bad boolean declaration at =
/var/lib/selinux/targeted/tmp/modules/100/virt/cil:152<o:p></o:p></span><=
/b></p><p class=3DMsoNormal><b><span style=3D'font-family:"Courier =
New";color:red'>/usr/sbin/semodule:&nbsp; =
Failed!<o:p></o:p></span></b></p><p class=3DMsoNormal><span =
style=3D'font-family:"Courier New"'>&nbsp; Upgrading&nbsp;&nbsp; : =
pcsc-lite-libs-1.8.19-1.fc25.x86_64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8/38<o:p></o:p></s=
pan></p><p class=3DMsoNormal><span style=3D'font-family:"Courier =
New"'>&nbsp; Upgrading&nbsp;&nbsp; : =
pcsc-lite-1.8.19-1.fc25.x86_64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
9/38<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-family:"Courier New"'>&nbsp; <b><span =
style=3D'color:red'>Upgrading&nbsp;&nbsp; : =
selinux-policy-sandbox-3.13.1-225.3.fc25.noarch&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
10/38<o:p></o:p></span></b></span></p><p class=3DMsoNormal><b><span =
style=3D'font-family:"Courier New";color:red'>Re-declaration of boolean =
virt_sandbox_use_fusefs<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span style=3D'font-family:"Courier =
New";color:red'>Failed to create node<o:p></o:p></span></b></p><p =
class=3DMsoNormal><b><span style=3D'font-family:"Courier =
New";color:red'>Bad boolean declaration at =
/var/lib/selinux/targeted/tmp/modules/100/virt/cil:152<o:p></o:p></span><=
/b></p><p class=3DMsoNormal><b><span style=3D'font-family:"Courier =
New";color:red'>semodule:&nbsp; Failed!<o:p></o:p></span></b></p><p =
class=3DMsoNormal><span style=3D'font-family:"Courier New"'>&nbsp; =
Installing&nbsp; : =
kernel-4.8.13-300.fc25.x86_64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11/38<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-family:"Courier New"'>&nbsp; Upgrading&nbsp;&nbsp; : =
libsmbclient-2:4.5.2-0.fc25.x86_64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;12/38<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-family:"Courier New"'>&nbsp; Upgrading&nbsp;&nbsp; : =
selinux-policy-mls-3.13.1-225.3.fc25.noarch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 13/38<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-family:"Courier New"'>&nbsp; <b><span =
style=3D'color:red'>Upgrading&nbsp;&nbsp; : =
selinux-policy-minimum-3.13.1-225.3.fc25.noarch&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;14/38<o:p></o=
:p></span></b></span></p><p class=3DMsoNormal><b><span =
style=3D'font-family:"Courier New";color:red'>Failed to resolve =
typeattributeset statement at =
/var/lib/selinux/minimum/tmp/modules/100/xserver/cil:472<o:p></o:p></span=
></b></p><p class=3DMsoNormal><b><span style=3D'font-family:"Courier =
New";color:red'>/usr/sbin/semodule:&nbsp; =
Failed!<o:p></o:p></span></b></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><span =
style=3D'font-family:"Comic Sans MS"'>***** ***** =
*****<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-family:"Comic Sans MS"'>Michael D. =
Parker<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-family:"Comic Sans MS"'>General Atomics &#8211; =
ElectroMagnetics Systems Division (EMS)<o:p></o:p></span></p><p =
class=3DMsoNormal><span style=3D'font-family:"Comic Sans MS"'><a =
href=3D"mailto:Michael.d.parker@ga.com"><span =
style=3D'color:#0563C1'>Michael.d.parker@ga.com</span></a>&nbsp; =
<b>&lt;&lt;&lt;&lt;&lt; NOTE: Remember to include my middle initial =
&gt;&gt;&gt;&gt;&gt;<o:p></o:p></b></span></p><p class=3DMsoNormal><span =
style=3D'font-family:"Comic Sans MS"'>+1 858 964 6675 / Office 86-1319 / =
Cell +1 858 376 7474<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-family:"Comic Sans MS"'>16969 Mesamint Street / San Diego =
/ CA / 92127<o:p></o:p></span></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_001_001F_01D25537.C61569A0--

------=_NextPart_000_001E_01D25537.C61569A0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
BgNVHQ8BAf8EBAMCAYYwMwYDVR0gBCwwKjAMBgpghkgBZQMCAQwBMAwGCmCGSAFlAwIBDAIwDAYK
YIZIAWUDAgEMAzA3BgNVHR8EMDAuMCygKqAohiZodHRwOi8vY3JsLmRpc2EubWlsL2NybC9FQ0FS
T09UQ0EyLmNybDBKBggrBgEFBQcBAQQ+MDwwOgYIKwYBBQUHMAKGLmh0dHA6Ly9jcmwuZGlzYS5t
aWwvaXNzdWVkdG8vRUNBUk9PVENBMl9JVC5wN2MwDQYJKoZIhvcNAQEFBQADggEBAI9Ho4myU/iZ
8M5D1SSTqT6L5q6E82psbYq7sXkaJ8pUFsknMMyD2kKM/95AUd7OsnKdy3d0MwpHzlfalsg0Epl+
b6TiS5wo0TzFrzme4ykM0Ar4l05YhFTPqYlQh8Wqjo8pj+B4P/N1er/P30jLvEoSTpy3MGC1jH+H
2mcVxanP5ELYYjvA1uNC3SGOFQlTSH0muW+siKRiUCD6CPs5SuSOtnb7CzC/0Y1KLMvIVzg6ZFwM
mq+frelswrB5HeMD56S+uXj7geBJZqLRL+GvNQK5i1SJxzbWyIxkMJ34vq1eVJe8b43XXaBc9i7K
D0YDgZZCTyE4MsgM2SHv+6DgeNUwggWTMIIEe6ADAgECAhAWIsbEzwDpQl5YvBPjUdY2MA0GCSqG
SIb3DQEBBQUAMIGZMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYD
VQQLEwNFQ0ExIjAgBgNVBAsTGUNlcnRpZmljYXRpb24gQXV0aG9yaXRpZXMxPjA8BgNVBAMTNVN5
bWFudGVjIENsaWVudCBFeHRlcm5hbCBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSAtIEc0MB4XDTE2
MDgxOTAwMDAwMFoXDTE3MDgxOTIzNTk1OVowgZwxCzAJBgNVBAYTAlVTMRgwFgYDVQQKEw9VLlMu
IEdvdmVybm1lbnQxDDAKBgNVBAsTA0VDQTEXMBUGA1UECxMOVmVyaVNpZ24sIEluYy4xMzAxBgNV
BAsMKkdlbmVyYWwgQXRvbWljcyBBZXJvbmF1dGljYWwgU3lzdGVtcywgSW5jLjEXMBUGA1UEAxMO
TWljaGFlbCBQYXJrZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDb3P2KxIhjh6BY
1mRqBAdQ+89fvi1S9W6DZfJMm21ResbQj4w6R62yQHjnECqEczPsKPRnD/I03ZGcty7gV2p+ocrq
vDp02xoB9maLMuee4bVRXRY8pKBQzfZgoHP4B0bxyUHiMVoYVP3cBln9Tshawj7TvKbZLCHJpL4P
uhm36Gdeg0YTpeyhqo86bgJbYRl34JgYEhZnFIn7SmnytHz2Av5W82jdWXPYdtr9s1oWD7Hjk0ru
QEBgIMAU2rZs0qPk2UHda51OPSB74m09spmD1dyfG4LgaebbgRsf+Vikhq6TJLk3tv7MkYdG3XUt
AXqQEvd4Qdqi+pbp1RUA0RZ7AgMBAAGjggHQMIIBzDBYBgNVHR8EUTBPME2gS6BJhkdodHRwOi8v
ZWNhLWNsaWVudC1jcmwucGtpLnN5bWFudGVjLmNvbS9WZXJpU2lnbkVDQTIwNDgvTGF0ZXN0Q1JM
LUczLmNybDAOBgNVHQ8BAf8EBAMCBSAwHQYDVR0OBBYEFC07Rciu63Q/P0GRmc0/o7tqtj9tMB8G
A1UdIwQYMBaAFABH8CX1LA3ckyaqAJi/9JU0hVDbMCIGA1UdEQQbMBmBF21pY2hhZWwuZC5wYXJr
ZXJAZ2EuY29tMIGKBggrBgEFBQcBAQR+MHwwRQYIKwYBBQUHMAKGOWh0dHA6Ly9lY2EyMDQ4LnBr
aS5zeW1hbnRlYy5jb20vQ0EvU3ltYW50ZWNFQ0EyMDQ4LUc0LmNlcjAzBggrBgEFBQcwAYYnaHR0
cDovL2VjYS1jbGllbnQtb2NzcC5wa2kuc3ltYW50ZWMuY29tMFIGA1UdIARLMEkwRwYKYIZIAWUD
AgEMATA5MDcGCCsGAQUFBwIBFitodHRwczovL3d3dy52ZXJpc2lnbi5jb20vcmVwb3NpdG9yeS9l
Y2EvY3BzMBsGA1UdCQQUMBIwEAYIKwYBBQUHCQQxBBMCVVMwDQYJKoZIhvcNAQEFBQADggEBAHwz
62X738/ANcSum3JpMOcBq3ftAsRUvBmq/+QtbDkdof3IHJXra8/zYOoPa4phWb++dnFRy5+ddm33
nywEiU7ZY4TsHelyCW4m3eBOCqrcJaW5VHEM7TKRXrL3sK+wZ5GgQgl3z3tbkwcasduYW1PiYn89
nx0QeWDORNCrYXnfjGVXirp3Su84Rm3s7UbUkvtlmtKnhS/JcbhDXz1LdlSfaQJVuYypuToLoMZ0
OFFxKa04tRaVsE7n2h/S+kIxPKjQBqKlfva32zORfoXFur9GadckdI08R3PpYA8tJGty9JZ43qMQ
vaOVS8tjk/XYQw4hn1eeS28AlWTRAeYDzgMwggWTMIIEe6ADAgECAhB/HzlbWCgEOoRwielIn/vP
MA0GCSqGSIb3DQEBBQUAMIGZMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50
MQwwCgYDVQQLEwNFQ0ExIjAgBgNVBAsTGUNlcnRpZmljYXRpb24gQXV0aG9yaXRpZXMxPjA8BgNV
BAMTNVN5bWFudGVjIENsaWVudCBFeHRlcm5hbCBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSAtIEc0
MB4XDTE2MDgxOTAwMDAwMFoXDTE3MDgxOTIzNTk1OVowgZwxCzAJBgNVBAYTAlVTMRgwFgYDVQQK
Ew9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0VDQTEXMBUGA1UECxMOVmVyaVNpZ24sIEluYy4x
MzAxBgNVBAsMKkdlbmVyYWwgQXRvbWljcyBBZXJvbmF1dGljYWwgU3lzdGVtcywgSW5jLjEXMBUG
A1UEAxMOTWljaGFlbCBQYXJrZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCE3uLF
4ip/uQ6Px9UHxF1ibHLrNGeNCrJBvclSxOyU0b3zxx7OlhbmNERNlqOhQOpAJSnIwy6Pk3N3EO2D
6H71R1UKSPzcWPpQZ2rhKvDT8QqRVAXNyKlua0t1GxGFqMzGSEGV/9FqX6LVvva3UccLt88KM4jr
Vpfjo7mRJDVEhmdYEMF5ZSDcbmbAntwJphCEJVmLf/HyvkTYq5kXWHqhZmOcchk5OBg14Jk9kCmm
a+TebY5p2/Xba3w9y4sTES/+LsuAVfdZnGe018Vf2riBSMzf3JFmVrQYY1Nh/oFjcg1LPUpk6vB8
jtbEErlwA+OJbVrxF8qSh2vVI8ysuG2jAgMBAAGjggHQMIIBzDBYBgNVHR8EUTBPME2gS6BJhkdo
dHRwOi8vZWNhLWNsaWVudC1jcmwucGtpLnN5bWFudGVjLmNvbS9WZXJpU2lnbkVDQTIwNDgvTGF0
ZXN0Q1JMLUczLmNybDAOBgNVHQ8BAf8EBAMCBsAwHQYDVR0OBBYEFCZ16reGweqwgJmrZYD3pa7D
E8EyMB8GA1UdIwQYMBaAFABH8CX1LA3ckyaqAJi/9JU0hVDbMCIGA1UdEQQbMBmBF21pY2hhZWwu
ZC5wYXJrZXJAZ2EuY29tMIGKBggrBgEFBQcBAQR+MHwwRQYIKwYBBQUHMAKGOWh0dHA6Ly9lY2Ey
MDQ4LnBraS5zeW1hbnRlYy5jb20vQ0EvU3ltYW50ZWNFQ0EyMDQ4LUc0LmNlcjAzBggrBgEFBQcw
AYYnaHR0cDovL2VjYS1jbGllbnQtb2NzcC5wa2kuc3ltYW50ZWMuY29tMFIGA1UdIARLMEkwRwYK
YIZIAWUDAgEMATA5MDcGCCsGAQUFBwIBFitodHRwczovL3d3dy52ZXJpc2lnbi5jb20vcmVwb3Np
dG9yeS9lY2EvY3BzMBsGA1UdCQQUMBIwEAYIKwYBBQUHCQQxBBMCVVMwDQYJKoZIhvcNAQEFBQAD
ggEBAHemt/RL67yBv1cg3TFkWkP7cC/A2CUwn6FYKYe00QPb83g52PBZIrZg/x21de+Q7GloKscH
TimmJr7ztduw2a5WBWCU7w+w04fdi5C1Hv5tY/dLxuaPPuwDnrhVDNbMjlj5ie5guFnOavu67jpH
3QpMta79pZva9q6sy8GJXRacNgdWwSovbqrFI6eqQilbMUrm04u8f+9ELGINw8SToCboymEHh2CP
MOAUk5gh7ChbXARRBAhwXFQul9zTkELN2o236FxsnSCOb1rAGOjX4v2o8JOSHnUkk9yZ/FdSDls+
kwBsttYjPdh3FEaaK3ZbKqJR+NJ5maprjmBj9C9EiusxggRTMIIETwIBATCBrjCBmTELMAkGA1UE
BhMCVVMxGDAWBgNVBAoTD1UuUy4gR292ZXJubWVudDEMMAoGA1UECxMDRUNBMSIwIAYDVQQLExlD
ZXJ0aWZpY2F0aW9uIEF1dGhvcml0aWVzMT4wPAYDVQQDEzVTeW1hbnRlYyBDbGllbnQgRXh0ZXJu
YWwgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgLSBHNAIQfx85W1goBDqEcInpSJ/7zzAJBgUrDgMC
GgUAoIICeTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNjEyMTMx
OTU1MThaMCMGCSqGSIb3DQEJBDEWBBSHi+T/erffzrXE9Wuzi8Zh7S+Z0jCBkwYJKoZIhvcNAQkP
MYGFMIGCMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCgYIKoZIhvcNAwcwCwYJYIZIAWUDBAEC
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCGjALBglghkgBZQMEAgMwCwYJ
YIZIAWUDBAICMAsGCWCGSAFlAwQCATCBvwYJKwYBBAGCNxAEMYGxMIGuMIGZMQswCQYDVQQGEwJV
UzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNFQ0ExIjAgBgNVBAsTGUNlcnRp
ZmljYXRpb24gQXV0aG9yaXRpZXMxPjA8BgNVBAMTNVN5bWFudGVjIENsaWVudCBFeHRlcm5hbCBD
ZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSAtIEc0AhAWIsbEzwDpQl5YvBPjUdY2MIHBBgsqhkiG9w0B
CRACCzGBsaCBrjCBmTELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD1UuUy4gR292ZXJubWVudDEMMAoG
A1UECxMDRUNBMSIwIAYDVQQLExlDZXJ0aWZpY2F0aW9uIEF1dGhvcml0aWVzMT4wPAYDVQQDEzVT
eW1hbnRlYyBDbGllbnQgRXh0ZXJuYWwgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgLSBHNAIQFiLG
xM8A6UJeWLwT41HWNjANBgkqhkiG9w0BAQEFAASCAQAVRKqoLUP03f1Nqfmiz1EHWOwrVZfodiQQ
ZNFM0PV/l3F7edIo3cvxayj66N3+C3dlMk7cnk4MGvV3Iaz8bo4z8X+C7km5c7qOxkbupcddt0wg
N+eolFhTS3E8eittYUZM+Ao2JD/OUuK7lgQOQFlt2jvEPshRMmME1RCN2KCD/1M47CMj4jCBs7co
1gTkPCkX3wl4IyBFYNEnJzg/P60an7Shf39yYCz9n44+gBjFb4kSe2w9UqAmP3SCGsUUa8fHGCho
VlWkuwVFVKaZJ8+MqwPhVruylkTmBuf01UsHrGAX+g1zKb8uLnM8hB/PIbunQKEGf7kaQ+hY0YsI
Ae7cAAAAAAAA

------=_NextPart_000_001E_01D25537.C61569A0--
