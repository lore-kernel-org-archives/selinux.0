MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C3292A.863D437F"
Subject: How to get rid of avc denied messages
Date: Mon, 2 Jun 2003 10:15:11 -0700
Message-ID: <DB4BA538D0DA21479C610B2466EEF64616273E@sjmail.global.com>
From: "Paul Loo" <PaulL@comglobal.com>
To: <SELinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3292A.863D437F
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

After installing selinux on a Mandrake 8.1 system.=20

Why do these "AVC DENIED" messages appears during bootup and how do I
get rid of them ?

=20

un  2 17:07:22 gfcp kernel: avc:  denied  { read write } for  pid=3D1723
exe=3D/usr/sbin/sshd path=3D/dev/ptmx dev=3D03:01 ino=3D14202
scontext=3Dsystem_u:system_r:sshd_t tcontext=3Dsystem_u:object_r:file_t
tclass=3Dchr_file

Jun  2 17:07:22 gfcp kernel:=20

Jun  2 17:07:22 gfcp kernel: avc:  denied  { ioctl } for  pid=3D1723
exe=3D/usr/sbin/sshd path=3D/dev/ptmx dev=3D03:01 ino=3D14202
scontext=3Dsystem_u:system_r:sshd_t tcontext=3Dsystem_u:object_r:file_t
tclass=3Dchr_file

Jun  2 17:07:22 gfcp sshd(pam_unix)[1723]: session opened for user tcip
by (uid=3D0)

Jun  2 17:07:22 gfcp kernel:=20

Jun  2 17:07:22 gfcp kernel: avc:  denied  { write } for  pid=3D1725
exe=3D/usr/sbin/sshd path=3D/var/run/utmp dev=3D03:01 ino=3D28697
scontext=3Dsystem_u:system_r:sshd_t
tcontext=3Dsystem_u:object_r:init_var_run_t tclass=3Dfile

Jun  2 17:07:22 gfcp kernel:=20

Jun  2 17:07:22 gfcp kernel: avc:  denied  { read write } for  =
pid=3D1726
exe=3D/bin/bash path=3D/dev/tty dev=3D03:01 ino=3D27191
scontext=3Dsystem_u:system_r:user_t tcontext=3Dsystem_u:object_r:file_t
tclass=3Dchr_file

Jun  2 17:07:22 gfcp kernel:=20

Jun  2 17:07:22 gfcp kernel: avc:  denied  { read write } for  =
pid=3D1725
exe=3D/bin/bash path=3D/dev/tty dev=3D03:01 ino=3D27191
scontext=3Dtcip:user_r:user_t tcontext=3Dsystem_u:object_r:file_t
tclass=3Dchr_file

Jun  2 17:07:29 gfcp kernel:=20

Jun  2 17:07:29 gfcp kernel: avc:  denied  { write } for  pid=3D1751
exe=3D/bin/su path=3D/var/run/utmp dev=3D03:01 ino=3D28697
scontext=3Dtcip:user_r:user_su_t =
tcontext=3Dsystem_u:object_r:init_var_run_t
tclass=3Dfile

Jun  2 17:07:29 gfcp kernel:=20

Jun  2 17:07:29 gfcp kernel: avc:  denied  { write } for  pid=3D1751
exe=3D/bin/su path=3D/dev/log dev=3D03:01 ino=3D28395
scontext=3Dtcip:user_r:user_su_t tcontext=3Dsystem_u:object_r:file_t
tclass=3Dsock_file

Jun  2 17:07:29 gfcp su(pam


------_=_NextPart_001_01C3292A.863D437F
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>After installing selinux on a Mandrake 8.1 system. =
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Why do these &#8220;AVC DENIED&#8221; messages =
appears
during bootup and how do I get rid of them ?</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>un&nbsp; 2 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>17:07:22</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> gfcp =
kernel: avc:&nbsp;
denied&nbsp; { read write } for&nbsp; pid=3D1723 exe=3D/usr/sbin/sshd =
path=3D/dev/ptmx
dev=3D</span></font><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
 font-family:Arial'>03:01</span></font><font size=3D2 face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'> ino=3D14202 =
scontext=3Dsystem_u:system_r:sshd_t
tcontext=3Dsystem_u:object_r:file_t tclass=3Dchr_file</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Jun&nbsp; 2 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>17:07:22</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> gfcp =
kernel: </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Jun&nbsp; 2 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>17:07:22</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> gfcp =
kernel: avc:&nbsp;
denied&nbsp; { ioctl } for&nbsp; pid=3D1723 exe=3D/usr/sbin/sshd =
path=3D/dev/ptmx
dev=3D</span></font><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
 font-family:Arial'>03:01</span></font><font size=3D2 face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'> ino=3D14202 =
scontext=3Dsystem_u:system_r:sshd_t
tcontext=3Dsystem_u:object_r:file_t tclass=3Dchr_file</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Jun&nbsp; 2 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>17:07:22</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> gfcp =
sshd(pam_unix)[1723]:
session opened for user tcip by (uid=3D0)</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Jun&nbsp; 2 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>17:07:22</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> gfcp =
kernel: </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Jun&nbsp; 2 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>17:07:22</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> gfcp =
kernel: avc:&nbsp;
denied&nbsp; { write } for&nbsp; pid=3D1725 exe=3D/usr/sbin/sshd =
path=3D/var/run/utmp
dev=3D</span></font><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
 font-family:Arial'>03:01</span></font><font size=3D2 face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'> ino=3D28697 =
scontext=3Dsystem_u:system_r:sshd_t
tcontext=3Dsystem_u:object_r:init_var_run_t =
tclass=3Dfile</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Jun&nbsp; 2 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>17:07:22</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> gfcp =
kernel: </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Jun&nbsp; 2 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>17:07:22</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> gfcp =
kernel: avc:&nbsp;
denied&nbsp; { read write } for&nbsp; pid=3D1726 exe=3D/bin/bash =
path=3D/dev/tty dev=3D</span></font><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>03:01</span></font><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> ino=3D27191 =
scontext=3Dsystem_u:system_r:user_t
tcontext=3Dsystem_u:object_r:file_t tclass=3Dchr_file</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Jun&nbsp; 2 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>17:07:22</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> gfcp =
kernel: </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Jun&nbsp; 2 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>17:07:22</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> gfcp =
kernel: avc:&nbsp;
denied&nbsp; { read write } for&nbsp; pid=3D1725 exe=3D/bin/bash =
path=3D/dev/tty dev=3D</span></font><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>03:01</span></font><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> ino=3D27191 =
scontext=3Dtcip:user_r:user_t
tcontext=3Dsystem_u:object_r:file_t tclass=3Dchr_file</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Jun&nbsp; 2 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>17:07:29</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> gfcp =
kernel: </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Jun&nbsp; 2 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>17:07:29</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> gfcp =
kernel: avc:&nbsp;
denied&nbsp; { write } for&nbsp; pid=3D1751 exe=3D/bin/su =
path=3D/var/run/utmp dev=3D</span></font><font size=3D2 =
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>03:01</span></font><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> ino=3D28697 =
scontext=3Dtcip:user_r:user_su_t
tcontext=3Dsystem_u:object_r:init_var_run_t =
tclass=3Dfile</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Jun&nbsp; 2 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>17:07:29</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> gfcp =
kernel: </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Jun&nbsp; 2 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>17:07:29</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> gfcp =
kernel: avc:&nbsp;
denied&nbsp; { write } for&nbsp; pid=3D1751 exe=3D/bin/su =
path=3D/dev/log dev=3D</span></font><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>03:01</span></font><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'> ino=3D28395 =
scontext=3Dtcip:user_r:user_su_t
tcontext=3Dsystem_u:object_r:file_t tclass=3Dsock_file</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Jun&nbsp; 2 </span></font><font size=3D2 =
face=3DArial><span
 =
style=3D'font-size:10.0pt;font-family:Arial'>17:07:29</span></font><font =
size=3D2
face=3DArial><span style=3D'font-size:10.0pt;font-family:Arial'> gfcp =
su(pam</span></font></p>

</div>

</body>

</html>
=00
------_=_NextPart_001_01C3292A.863D437F--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
