Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8SJ5xeF026306
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 15:05:59 -0400
From: Raj Srinivasan <raj@bivio.net>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Question on restricting file access
Date: Wed, 28 Sep 2016 19:05:53 +0000
Message-ID: <DM5PR01MB257160569D7A4541EB83024FA9CF0@DM5PR01MB2571.prod.exchangelabs.com>
Content-Type: multipart/alternative;
 boundary="_000_DM5PR01MB257160569D7A4541EB83024FA9CF0DM5PR01MB2571prod_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_DM5PR01MB257160569D7A4541EB83024FA9CF0DM5PR01MB2571prod_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I have just started with Selinux, and was trying (unsuccessfully) to restri=
ct the sysadm role as my first exercise.

I am using RHEL 7.1, and running Selinux with the minimum configuration in =
enforcing mode.

I have a user called "admin" with the context "sysadm_u:sysadm_r:sysadm_t:s=
0-s0:c0.c1023", and uid 1000. When I login as admin and use su to become ro=
ot, the context still remains the same, as one would expect.

I created a simple policy to restrict the sysadm_r role for testing purpose=
s, and was able to compile and load it.

policy_module(localpolicy, 1.0.0)

gen_require(`
  type sysadm_t;
  type sshd_key_t;
')

allow sysadm_t sshd_key_t:file { create_file_perms write_file_perms };

The idea was to prevent the sysadm_r role from being able to read a file wi=
th the sshd_key_t type even if the uid is changed to root via the su comman=
d, by allowing "create" and "write" permissions, but not "read" permission.

I would appreciate it very much if anyone could let me know what I am missi=
ng, or if there is an easy way to troubleshoot. I tried to use the "neveral=
low" directive (with "read" permission) but after waiting for 10 minutes, t=
he policy did not even load. I suspect there is some other rule in effect t=
hat grants read permission that I am not able to see using "sesearch -A".

Thanks,
Raj


--_000_DM5PR01MB257160569D7A4541EB83024FA9CF0DM5PR01MB2571prod_
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
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have just started with Selinux, and was trying (un=
successfully) to restrict the sysadm role as my first exercise.<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am using RHEL 7.1, and running Selinux with the mi=
nimum configuration in enforcing mode.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have a user called &#8220;admin&#8221; with the co=
ntext &#8220;sysadm_u:sysadm_r:sysadm_t:s0-s0:c0.c1023&#8221;, and uid 1000=
. When I login as admin and use su to become root, the context still remain=
s the same, as one would expect.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I created a simple policy to restrict the sysadm_r r=
ole for testing purposes, and was able to compile and load it.<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Courier New&quot;">policy_module(localpolicy, 1.0.0)<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Courier New&quot;">gen_require(`<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Courier New&quot;">&nbsp; type sysadm_t;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Courier New&quot;">&nbsp; type sshd_key_t;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Courier New&quot;">')<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-famil=
y:&quot;Courier New&quot;">allow sysadm_t sshd_key_t:file { create_file_per=
ms write_file_perms };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The idea was to prevent the sysadm_r role from being=
 able to read a file with the sshd_key_t type even if the uid is changed to=
 root via the su command, by allowing &#8220;create&#8221; and &#8220;write=
&#8221; permissions, but not &#8220;read&#8221; permission.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I would appreciate it very much if anyone could let =
me know what I am missing, or if there is an easy way to troubleshoot. I tr=
ied to use the &#8220;neverallow&#8221; directive (with &#8220;read&#8221; =
permission) but after waiting for 10 minutes, the policy did
 not even load. I suspect there is some other rule in effect that grants re=
ad permission that I am not able to see using &#8220;sesearch -A&#8221;.<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Raj<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM5PR01MB257160569D7A4541EB83024FA9CF0DM5PR01MB2571prod_--
