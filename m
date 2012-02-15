From: "Alain Toussaint" <alain.toussaint@securivm.ca>
To: <SELinux@tycho.nsa.gov>
Subject: selinux system with configfs and cgroup support
Date: Wed, 15 Feb 2012 18:32:44 -0500
Message-ID: <239A49D254CA40949F6B96DCB4C5D819@AlainPC>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0003_01CCEC10.36032770"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0003_01CCEC10.36032770
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

      I recently build a gentoo hardened selinux system with cgroup and
configfs support but on bootup, I am getting these error:

 

Configfs:

 

Feb 15 17:30:37 johnson kernel: type=1400 audit(1329327031.306:10): avc:
denied  { setattr } for  pid=104 comm="mount" name="/" dev="configfs" ino=94
scontext=system_u:system_r:mount_t:s0
tcontext=system_u:object_r:configfs_t:s0 tclass=dir

Feb 15 17:45:48 johnson kernel: type=1400 audit(1329327937.356:4): avc:
denied  { write } for  pid=104 comm="mount" name="/" dev="configfs" ino=94
scontext=system_u:system_r:mount_t:s0
tcontext=system_u:object_r:configfs_t:s0 tclass=dir

 

 

Cgroups:

 

Feb 14 14:02:36 localhost kernel: type=1400 audit(1329242585.276:8): avc:
denied  { search } for  pid=113 comm="mount" name="/" dev="cgroup" ino=205
scontext=system_u:system_r:kernel_t:s0
tcontext=system_u:object_r:unlabeled_t:s0 tclass=dir

Feb 14 14:04:02 localhost kernel: type=1400 audit(1329246233.189:8): avc:
denied  { search } for  pid=113 comm="mount" name="/" dev="cgroup" ino=194
scontext=system_u:system_r:kernel_t:s0
tcontext=system_u:object_r:unlabeled_t:s0 tclass=dir

Feb 14 16:48:30 johnson kernel: type=1400 audit(1329238099.103:8): avc:
denied  { search } for  pid=113 comm="mount" name="/" dev="cgroup" ino=197
scontext=system_u:system_r:kernel_t:s0
tcontext=system_u:object_r:unlabeled_t:s0 tclass=dir

Feb 14 22:22:56 johnson kernel: type=1400 audit(1329258167.143:8): avc:
denied  { search } for  pid=113 comm="mount" name="/" dev="cgroup" ino=193
scontext=system_u:system_r:kernel_t:s0
tcontext=system_u:object_r:unlabeled_t:s0 tclass=dir

Feb 15 00:17:55 johnson kernel: type=1400 audit(1329265064.356:8): avc:
denied  { search } for  pid=113 comm="mount" name="/" dev="cgroup" ino=195
scontext=system_u:system_r:kernel_t:s0
tcontext=system_u:object_r:unlabeled_t:s0 tclass=dir

Feb 15 17:45:49 johnson kernel: type=1400 audit(1329327937.426:8): avc:
denied  { search } for  pid=113 comm="mount" name="/" dev="cgroup" ino=198
scontext=system_u:system_r:kernel_t:s0
tcontext=system_u:object_r:unlabeled_t:s0 tclass=dir

Feb 15 17:51:39 johnson kernel: type=1400 audit(1329328288.173:8): avc:
denied  { search } for  pid=113 comm="mount" name="/" dev="cgroup" ino=195
scontext=system_u:system_r:kernel_t:s0
tcontext=system_u:object_r:unlabeled_t:s0 tclass=dir

Feb 15 18:08:14 johnson kernel: type=1400 audit(1329329282.219:8): avc:
denied  { search } for  pid=113 comm="mount" name="/" dev="cgroup" ino=201
scontext=system_u:system_r:kernel_t:s0
tcontext=system_u:object_r:unlabeled_t:s0 tclass=dir

 

Other than that, the system run fine but for the moment, I am running in
permissive mode with Multi-Category Security and I'd like to fix these
errors before going into enforcing mode but I don't know what to look for in
my system to fix these error.

 

Thanks

Alain

 


------=_NextPart_000_0003_01CCEC10.36032770
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 77.95pt 72.0pt 77.95pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DFR-CA link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I recently build a gentoo =
hardened selinux system with cgroup and
configfs support but on bootup, I am getting these =
error:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Configfs:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Feb 15 17:30:37 johnson kernel: type=3D1400 =
audit(1329327031.306:10):
avc:&nbsp; denied&nbsp; { setattr } for &nbsp;pid=3D104 =
comm=3D&quot;mount&quot;
name=3D&quot;/&quot; dev=3D&quot;configfs&quot; ino=3D94
scontext=3Dsystem_u:system_r:mount_t:s0 =
tcontext=3Dsystem_u:object_r:configfs_t:s0
tclass=3Ddir<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Feb 15 17:45:48 johnson kernel: type=3D1400 =
audit(1329327937.356:4):
avc:&nbsp; denied&nbsp; { write } for&nbsp; pid=3D104 =
comm=3D&quot;mount&quot; name=3D&quot;/&quot;
dev=3D&quot;configfs&quot; ino=3D94 =
scontext=3Dsystem_u:system_r:mount_t:s0
tcontext=3Dsystem_u:object_r:configfs_t:s0 =
tclass=3Ddir<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Cgroups:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Feb 14 14:02:36 localhost kernel: type=3D1400 =
audit(1329242585.276:8):
avc:&nbsp; denied&nbsp; { search } for&nbsp; pid=3D113 =
comm=3D&quot;mount&quot; name=3D&quot;/&quot;
dev=3D&quot;cgroup&quot; ino=3D205 =
scontext=3Dsystem_u:system_r:kernel_t:s0
tcontext=3Dsystem_u:object_r:unlabeled_t:s0 =
tclass=3Ddir<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Feb 14 14:04:02 localhost kernel: type=3D1400 =
audit(1329246233.189:8):
avc:&nbsp; denied&nbsp; { search } for&nbsp; pid=3D113 =
comm=3D&quot;mount&quot; name=3D&quot;/&quot;
dev=3D&quot;cgroup&quot; ino=3D194 =
scontext=3Dsystem_u:system_r:kernel_t:s0
tcontext=3Dsystem_u:object_r:unlabeled_t:s0 =
tclass=3Ddir<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Feb 14 16:48:30 johnson kernel: type=3D1400 =
audit(1329238099.103:8):
avc:&nbsp; denied&nbsp; { search } for&nbsp; pid=3D113 =
comm=3D&quot;mount&quot; name=3D&quot;/&quot;
dev=3D&quot;cgroup&quot; ino=3D197 =
scontext=3Dsystem_u:system_r:kernel_t:s0
tcontext=3Dsystem_u:object_r:unlabeled_t:s0 =
tclass=3Ddir<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Feb 14 22:22:56 johnson kernel: type=3D1400 =
audit(1329258167.143:8):
avc:&nbsp; denied&nbsp; { search } for&nbsp; pid=3D113 =
comm=3D&quot;mount&quot; name=3D&quot;/&quot;
dev=3D&quot;cgroup&quot; ino=3D193 =
scontext=3Dsystem_u:system_r:kernel_t:s0
tcontext=3Dsystem_u:object_r:unlabeled_t:s0 =
tclass=3Ddir<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Feb 15 00:17:55 johnson kernel: type=3D1400 =
audit(1329265064.356:8):
avc:&nbsp; denied&nbsp; { search } for&nbsp; pid=3D113 =
comm=3D&quot;mount&quot; name=3D&quot;/&quot;
dev=3D&quot;cgroup&quot; ino=3D195 =
scontext=3Dsystem_u:system_r:kernel_t:s0
tcontext=3Dsystem_u:object_r:unlabeled_t:s0 =
tclass=3Ddir<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Feb 15 17:45:49 johnson kernel: type=3D1400 =
audit(1329327937.426:8):
avc:&nbsp; denied&nbsp; { search } for&nbsp; pid=3D113 =
comm=3D&quot;mount&quot; name=3D&quot;/&quot;
dev=3D&quot;cgroup&quot; ino=3D198 =
scontext=3Dsystem_u:system_r:kernel_t:s0
tcontext=3Dsystem_u:object_r:unlabeled_t:s0 =
tclass=3Ddir<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Feb 15 17:51:39 johnson kernel: type=3D1400 =
audit(1329328288.173:8):
avc:&nbsp; denied&nbsp; { search } for&nbsp; pid=3D113 =
comm=3D&quot;mount&quot; name=3D&quot;/&quot;
dev=3D&quot;cgroup&quot; ino=3D195 =
scontext=3Dsystem_u:system_r:kernel_t:s0
tcontext=3Dsystem_u:object_r:unlabeled_t:s0 =
tclass=3Ddir<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Feb 15 18:08:14 johnson kernel: type=3D1400 =
audit(1329329282.219:8):
avc:&nbsp; denied&nbsp; { search } for&nbsp; pid=3D113 =
comm=3D&quot;mount&quot; name=3D&quot;/&quot;
dev=3D&quot;cgroup&quot; ino=3D201 =
scontext=3Dsystem_u:system_r:kernel_t:s0
tcontext=3Dsystem_u:object_r:unlabeled_t:s0 =
tclass=3Ddir<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Other than that, the system run fine but for the moment, I am =
running
in permissive mode with Multi-Category Security and I'd like to fix =
these
errors before going into enforcing mode but I don't know what to look =
for in my
system to fix these error.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Thanks<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Alain<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0003_01CCEC10.36032770--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
