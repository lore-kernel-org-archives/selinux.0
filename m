Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4RCJJNU003537
 for <selinux@tycho.nsa.gov>; Tue, 27 May 2014 08:19:19 -0400
Received: from ferret (fw5540.nrl.navy.mil [132.250.196.100])
 by ccs.nrl.navy.mil (8.14.4/8.14.4) with ESMTP id s4RCJJMD018174
 for <selinux@tycho.nsa.gov>; Tue, 27 May 2014 08:19:19 -0400
From: "Kim Lawson-Jenkins" <kim.lawson-jenkins@nrl.navy.mil>
To: <selinux@tycho.nsa.gov>
Subject: AVCs errors generated when CLI comands executed
Date: Tue, 27 May 2014 08:21:48 -0400
Message-ID: <001c01cf79a6$3ba6e880$b2f4b980$@nrl.navy.mil>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_001D_01CF7984.B4954880"
Reply-To: kim.lawson-jenkins@nrl.navy.mil
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multipart message in MIME format.

------=_NextPart_000_001D_01CF7984.B4954880
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

We're running SELinux on an embedded system using a reference policy from
the Yocto project.   RAM, which is used instead of flash, is mounted after
SELinux relabeling completes and the files have default labels after a
reboot.  I've added restorecon -R /dev to a rc.init  to set the contexts
correctly but the files on RAM still have the default label.  After logging
in, I'm able to execute SELinux commands to modify the policy and fix the
labels, but avcs are generated for every command.  Here are some examples -

 

May 20 20:04:16 guard kernel: type=1400 audit(1400616256.808:53): avc:
denied  { relabelto } for  pid=1536 comm="restorecon" name="sipc_mq1 "
dev="ram1" ino=14341 scontext=root:sysadm_r:setfiles_t:s0-s15:c0.c1023
tcontext=system_u:object_r:ioi_orch_cq_t:s0 tclass=file

May 20 20:04:16 guard kernel: type=1400 audit(1400616256.839:54): avc:
denied  { associate } for  pid=1536 comm="restorecon" name="sipc_mq2 "
dev="ram1" ino=14341 scontext=system_u:object_r:ioi_orch_cq_t:s0
tcontext=system_u:object_r:fs_t:s0 tclass=filesystem

May 20 20:04:16 guard kernel: type=1400 audit(1400616256.864:55): avc:
denied  { relabelto } for  pid=1536 comm="restorecon" name="sipc_mq3 "
dev="ram1" ino=14342 scontext=root:sysadm_r:setfiles_t:s0-s15:c0.c1023
tcontext=system_u:object_r:orch_ioi_cq_t:s0 tclass=file

May 20 20:04:16 guard kernel: type=1400 audit(1400616256.888:56): avc:
denied  { associate } for  pid=1536 comm="restorecon" name="sipc_mq4"
dev="ram1" ino=14342 scontext=system_u:object_r:orch_ioi_cq_t:s0
tcontext=system_u:object_r:fs_t:s0 tclass=filesystem

May 20 20:04:16 guard kernel: type=1400 audit(1400616256.907:57): avc:
denied  { relabelto } for  pid=1536 comm="restorecon" name="sipc_mq5"
dev="ram1" ino=14343 scontext=root:sysadm_r:setfiles_t:s0-s15:c0.c1023
tcontext=system_u:object_r:ioi_orch_dq_t:s0 tclass=file

 

I don't understand why the restorecon does not apply the correct labels when
the init script is executed but it does when I execute the command as admin.
Also, I don't know why the AVC errors are generated when I execute the
commands as admin.  Any feedback would be greatly appreciated.

 

 

Kim

 


------=_NextPart_000_001D_01CF7984.B4954880
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 14 (filtered =
medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
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
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p =
class=3DMsoNormal>Hi,<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>We&#8217;re =
running SELinux on an embedded system using a reference policy from the =
Yocto project.&nbsp;&nbsp; RAM, which is used instead of flash, is =
mounted after SELinux relabeling completes and the files have default =
labels after a reboot.&nbsp; I&#8217;ve added restorecon -R /dev to a =
rc.init &nbsp;to set the contexts correctly but the files on RAM still =
have the default label.&nbsp; After logging in, I&#8217;m able to =
execute SELinux commands to modify the policy and fix the labels, but =
avcs are generated for every command.&nbsp; Here are some examples =
&#8211;<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>May 20 20:04:16 guard kernel: type=3D1400 =
audit(1400616256.808:53): avc:&nbsp; denied&nbsp; { relabelto } =
for&nbsp; pid=3D1536 comm=3D&quot;restorecon&quot; name=3D&quot;sipc_mq1 =
&quot; dev=3D&quot;ram1&quot; ino=3D14341 =
scontext=3Droot:sysadm_r:setfiles_t:s0-s15:c0.c1023 =
tcontext=3Dsystem_u:object_r:ioi_orch_cq_t:s0 =
tclass=3Dfile<o:p></o:p></p><p class=3DMsoNormal>May 20 20:04:16 guard =
kernel: type=3D1400 audit(1400616256.839:54): avc:&nbsp; denied&nbsp; { =
associate } for&nbsp; pid=3D1536 comm=3D&quot;restorecon&quot; =
name=3D&quot;sipc_mq2 &quot; dev=3D&quot;ram1&quot; ino=3D14341 =
scontext=3Dsystem_u:object_r:ioi_orch_cq_t:s0 =
tcontext=3Dsystem_u:object_r:fs_t:s0 =
tclass=3Dfilesystem<o:p></o:p></p><p class=3DMsoNormal>May 20 20:04:16 =
guard kernel: type=3D1400 audit(1400616256.864:55): avc:&nbsp; =
denied&nbsp; { relabelto } for&nbsp; pid=3D1536 =
comm=3D&quot;restorecon&quot; name=3D&quot;sipc_mq3 &quot; =
dev=3D&quot;ram1&quot; ino=3D14342 =
scontext=3Droot:sysadm_r:setfiles_t:s0-s15:c0.c1023 =
tcontext=3Dsystem_u:object_r:orch_ioi_cq_t:s0 =
tclass=3Dfile<o:p></o:p></p><p class=3DMsoNormal>May 20 20:04:16 guard =
kernel: type=3D1400 audit(1400616256.888:56): avc:&nbsp; denied&nbsp; { =
associate } for&nbsp; pid=3D1536 comm=3D&quot;restorecon&quot; =
name=3D&quot;sipc_mq4&quot; dev=3D&quot;ram1&quot; ino=3D14342 =
scontext=3Dsystem_u:object_r:orch_ioi_cq_t:s0 =
tcontext=3Dsystem_u:object_r:fs_t:s0 =
tclass=3Dfilesystem<o:p></o:p></p><p class=3DMsoNormal>May 20 20:04:16 =
guard kernel: type=3D1400 audit(1400616256.907:57): avc:&nbsp; =
denied&nbsp; { relabelto } for&nbsp; pid=3D1536 =
comm=3D&quot;restorecon&quot; name=3D&quot;sipc_mq5&quot; =
dev=3D&quot;ram1&quot; ino=3D14343 =
scontext=3Droot:sysadm_r:setfiles_t:s0-s15:c0.c1023 =
tcontext=3Dsystem_u:object_r:ioi_orch_dq_t:s0 =
tclass=3Dfile<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>I don&#8217;t understand why the restorecon does not =
apply the correct labels when the init script is executed but it does =
when I execute the command as admin.&nbsp; Also, I don&#8217;t know why =
the AVC errors are generated when I execute the commands as admin.&nbsp; =
Any feedback would be greatly appreciated.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Kim<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------=_NextPart_000_001D_01CF7984.B4954880--
