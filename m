Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5IJjC0w014167
 for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2018 15:45:12 -0400
From: Mike Hughes <mike@visionary.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Mon, 18 Jun 2018 19:44:10 +0000
Message-ID: <DM6PR19MB22817204E97BC6C6F1F71870D1710@DM6PR19MB2281.namprd19.prod.outlook.com>
Content-Type: multipart/alternative;
 boundary="_000_DM6PR19MB22817204E97BC6C6F1F71870D1710DM6PR19MB2281namp_"
MIME-Version: 1.0
Subject: 'setsebool -P' works but throws errors;
 changes not permanent
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_DM6PR19MB22817204E97BC6C6F1F71870D1710DM6PR19MB2281namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We use Yubikey for two-factor ssh authentication which requires enabling a =
Boolean called "authlogin_yubikey". It has been working fine until a few we=
eks ago. Errors appear when attempting to set the policy:

--
[Cent-7:root@my_server home]# getsebool authlogin_yubikey
authlogin_yubikey --> off

[Cent-7:root@my_server home]# setsebool -P authlogin_yubikey on
libsepol.context_from_record: type gpio_device_t is not defined
libsepol.context_from_record: could not create context structure
libsepol.context_from_string: could not create context structure
libsepol.sepol_context_to_sid: could not convert system_u:object_r:gpio_dev=
ice_t:s0 to sid
invalid context system_u:object_r:gpio_device_t:s0

[Cent-7:root@my_server home]# getsebool authlogin_yubikey
authlogin_yubikey --> on
---

The system accepts two-factor while the above is set to "on". After some un=
determined time (or immediately after a reboot) the Boolean toggles off. Th=
is can be confirmed since semanage shows that the default is still set to "=
off":

--
[Cent-7:root@my_server ~]# semanage boolean -l | grep "authlogin_yubikey"
SELinux boolean                State  Default Description
...
authlogin_yubikey              (on   ,  off)  Allow authlogin to yubikey
--

It looks similar to the following bug on Fedora:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1559174

--_000_DM6PR19MB22817204E97BC6C6F1F71870D1710DM6PR19MB2281namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
	{mso-style-type:export-only;}
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
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">We use Yubikey for two-factor ssh authentication whi=
ch requires enabling a Boolean called &#8220;authlogin_yubikey&#8221;. It h=
as been working fine until a few weeks ago. Errors appear when attempting t=
o set the policy:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">--<o:p></o:p></p>
<p class=3D"MsoNormal">[Cent-7:root@my_server home]# getsebool authlogin_yu=
bikey<o:p></o:p></p>
<p class=3D"MsoNormal">authlogin_yubikey --&gt; off<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[Cent-7:root@my_server home]# setsebool -P authlogin=
_yubikey on<o:p></o:p></p>
<p class=3D"MsoNormal">libsepol.context_from_record: type gpio_device_t is =
not defined<o:p></o:p></p>
<p class=3D"MsoNormal">libsepol.context_from_record: could not create conte=
xt structure<o:p></o:p></p>
<p class=3D"MsoNormal">libsepol.context_from_string: could not create conte=
xt structure<o:p></o:p></p>
<p class=3D"MsoNormal">libsepol.sepol_context_to_sid: could not convert sys=
tem_u:object_r:gpio_device_t:s0 to sid<o:p></o:p></p>
<p class=3D"MsoNormal">invalid context system_u:object_r:gpio_device_t:s0<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[Cent-7:root@my_server home]# getsebool authlogin_yu=
bikey<o:p></o:p></p>
<p class=3D"MsoNormal">authlogin_yubikey --&gt; on<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The system accepts two-factor while the above is set=
 to &#8220;on&#8221;. After some undetermined time (or immediately after a =
reboot) the Boolean toggles off. This can be confirmed since semanage shows=
 that the default is still set to &#8220;off&#8221;:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">--<o:p></o:p></p>
<p class=3D"MsoNormal">[Cent-7:root@my_server ~]# semanage boolean -l | gre=
p &quot;authlogin_yubikey&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">SELinux boolean&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; State&nbsp; Default D=
escription<o:p></o:p></p>
<p class=3D"MsoNormal">...<o:p></o:p></p>
<p class=3D"MsoNormal">authlogin_yubikey&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (on&nbsp;&nbsp; ,&nbsp; off)&nb=
sp; Allow authlogin to yubikey<o:p></o:p></p>
<p class=3D"MsoNormal">--<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">It looks similar to the following bug on Fedora:<o:p=
></o:p></p>
<p class=3D"MsoNormal">https://bugzilla.redhat.com/show_bug.cgi?id=3D155917=
4<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR19MB22817204E97BC6C6F1F71870D1710DM6PR19MB2281namp_--
