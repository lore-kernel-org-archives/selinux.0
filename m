Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i95M1lrT000490
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 18:01:47 -0400 (EDT)
Received: from maat.darkhonor.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i95M1j7h012865
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 22:01:46 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4AB27.5943CF50"
Subject: LVM/PostgreSQL/Sendmail AVC Messages
Date: Tue, 5 Oct 2004 18:04:56 -0400
Message-ID: <A52BEA1D8EE8634B9196A136333637B130E8@maat.darkhonor.net>
From: "Alex Ackerman" <alex@darkhonor.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4AB27.5943CF50
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thank you to everyone who assisted me. I managed to get my FC2 system up
and running.  Now I'm into the fine-tuning part.  I received the
following avc messages in my syslog and I was wondering if there are
patches out to correct, or is this an area where I can contribute my own
policy patch?

=20

LVM AVC Errors:

Oct  5 17:37:03 baal kernel: audit(1097012179.383:0): avc:  denied  {
getattr } for  pid=3D892 exe=3D/sbin/lvm.static path=3D/dev/shm =
dev=3Dhda3
ino=3D391699 scontext=3Dsystem_u:system_r:lvm_t
tcontext=3Dsystem_u:object_r:file_t tclass=3Ddir

=20

Sendmail AVC Errors:

Oct  5 17:37:15 baal kernel: audit(1097012235.639:0): avc:  denied  {
read write } for  pid=3D1735 exe=3D/usr/sbin/sendmail.sendmail =
name=3Dutmp
dev=3Dhda3 ino=3D783370 scontext=3Dsystem_u:system_r:sendmail_t
tcontext=3Dsystem_u:object_r:initrc_var_run_t tclass=3Dfile

Oct  5 17:37:15 baal kernel: audit(1097012235.649:0): avc:  denied  {
read } for  pid=3D1735 exe=3D/usr/sbin/sendmail.sendmail name=3Dutmp =
dev=3Dhda3
ino=3D783370 scontext=3Dsystem_u:system_r:sendmail_t
tcontext=3Dsystem_u:object_r:initrc_var_run_t tclass=3Dfile

Oct  5 17:37:15 baal kernel: audit(1097012235.659:0): avc:  denied  {
read write } for  pid=3D1735 exe=3D/usr/sbin/sendmail.sendmail =
name=3Dutmp
dev=3Dhda3 ino=3D783370 scontext=3Dsystem_u:system_r:sendmail_t
tcontext=3Dsystem_u:object_r:initrc_var_run_t tclass=3Dfile

Oct  5 17:37:15 baal kernel: audit(1097012235.670:0): avc:  denied  {
read } for  pid=3D1735 exe=3D/usr/sbin/sendmail.sendmail name=3Dutmp =
dev=3Dhda3
ino=3D783370 scontext=3Dsystem_u:system_r:sendmail_t
tcontext=3Dsystem_u:object_r:initrc_var_run_t tclass=3Dfile

=20

PostgreSQL AVC Errors:

Oct  5 17:37:18 baal kernel: audit(1097012238.340:0): avc:  denied  {
sys_admin } for  pid=3D1774 exe=3D/sbin/consoletype capability=3D21
scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:system_r:postgresql_t tclass=3Dcapability

Oct  5 17:37:18 baal kernel: audit(1097012238.662:0): avc:  denied  {
search } for  pid=3D1782 exe=3D/bin/su name=3Dselinux dev=3Dhda3 =
ino=3D2434464
scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:selinux_config_t tclass=3Ddir

Oct  5 17:37:18 baal kernel: audit(1097012238.825:0): avc:  denied  {
search } for  pid=3D1782 exe=3D/bin/su dev=3Dselinuxfs ino=3D1005
scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:security_t tclass=3Ddir

Oct  5 17:37:18 baal kernel: audit(1097012238.840:0): avc:  denied  {
search } for  pid=3D1782 exe=3D/bin/su dev=3Dselinuxfs ino=3D1005
scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:security_t tclass=3Ddir

Oct  5 17:37:19 baal kernel: audit(1097012239.058:0): avc:  denied  {
read } for  pid=3D1782 exe=3D/bin/su name=3Dshadow dev=3Dhda3 =
ino=3D2434295
scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:shadow_t tclass=3Dfile

Oct  5 17:37:19 baal kernel: audit(1097012239.074:0): avc:  denied  {
read } for  pid=3D1782 exe=3D/bin/su name=3Dshadow dev=3Dhda3 =
ino=3D2434295
scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:shadow_t tclass=3Dfile

Oct  5 17:37:19 baal kernel: audit(1097012239.091:0): avc:  denied  {
read } for  pid=3D1782 exe=3D/bin/su name=3Dshadow dev=3Dhda3 =
ino=3D2434295
scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:shadow_t tclass=3Dfile

Oct  5 17:37:19 baal kernel: audit(1097012239.109:0): avc:  denied  {
read } for  pid=3D1782 exe=3D/bin/su name=3Dshadow dev=3Dhda3 =
ino=3D2434295
scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:shadow_t tclass=3Dfile

Oct  5 17:37:19 baal kernel: audit(1097012239.128:0): avc:  denied  {
read } for  pid=3D1782 exe=3D/bin/su name=3Dshadow dev=3Dhda3 =
ino=3D2434295
scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:shadow_t tclass=3Dfile

Oct  5 17:37:19 baal kernel: audit(1097012239.147:0): avc:  denied  {
read } for  pid=3D1782 exe=3D/bin/su name=3Dshadow dev=3Dhda3 =
ino=3D2434295
scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:shadow_t tclass=3Dfile

Oct  5 17:37:19 baal kernel: audit(1097012239.168:0): avc:  denied  {
read } for  pid=3D1782 exe=3D/bin/su name=3Dshadow dev=3Dhda3 =
ino=3D2434295
scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:shadow_t tclass=3Dfile

Oct  5 17:37:19 baal kernel: audit(1097012239.189:0): avc:  denied  {
read } for  pid=3D1782 exe=3D/bin/su name=3Dshadow dev=3Dhda3 =
ino=3D2434295
scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:shadow_t tclass=3Dfile

Oct  5 17:37:19 baal kernel: audit(1097012239.235:0): avc:  denied  {
execute } for  pid=3D1783 exe=3D/bin/su name=3Dunix_chkpwd dev=3Dhda3 =
ino=3D32696
scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:chkpwd_exec_t tclass=3Dfile

=20

System details are:

Fedora Core 2

2.6.8-1.521 kernel

enforcing=3Dtrue

=20

checkpolicy-1.17.5-1

libselinux-1.17.13-3

selinux-policy-strict-1.17.26-3

postgresql-7.4.2-1

sendmail-8.12.11-4.6

=20

I upgraded mkinitrd because of a message I noticed in Bugzilla
(https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D133236) to
4.1.14-1, but haven't upgraded the initrd image for the running kernel.
/dev/shm is mounted (per a response
http://www.redhat.com/archives/fedora-selinux-list/2004-June/msg00178.ht
ml) according to my /etc/fstab file and the results of mount.



I'm willing to try coming up with a policy patch for the postgres.te and
postgres.tc files, but I'd like to know if anyone else is seeing these
errors first.

=20

Thoughts?  Thank you ahead of time.

Alex Ackerman

http://www.darkhonor.com <http://www.darkhonor.com/>=20

=20


------_=_NextPart_001_01C4AB27.5943CF50
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
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
	{mso-style-type:personal-compose;
	font-family:Arial;
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
font-family:Arial'>Thank you to everyone who assisted me. I managed to =
get my
FC2 system up and running.&nbsp; Now I&#8217;m into the fine-tuning =
part.&nbsp;
I received the following avc messages in my syslog and I was wondering =
if there
are patches out to correct, or is this an area where I can contribute my =
own policy
patch?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>LVM AVC Errors:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oct&nbsp; 5 17:37:03 baal kernel: =
audit(1097012179.383:0):
avc:&nbsp; denied&nbsp; { getattr } for&nbsp; pid=3D892 =
exe=3D/sbin/lvm.static
path=3D/dev/shm dev=3Dhda3 ino=3D391699 =
scontext=3Dsystem_u:system_r:lvm_t
tcontext=3Dsystem_u:object_r:file_t =
tclass=3Ddir<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Sendmail AVC Errors:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oct&nbsp; 5 17:37:15 baal kernel: =
audit(1097012235.639:0):
avc:&nbsp; denied&nbsp; { read write } for&nbsp; pid=3D1735
exe=3D/usr/sbin/sendmail.sendmail name=3Dutmp dev=3Dhda3 ino=3D783370
scontext=3Dsystem_u:system_r:sendmail_t =
tcontext=3Dsystem_u:object_r:initrc_var_run_t
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oct&nbsp; 5 17:37:15 baal kernel: =
audit(1097012235.649:0):
avc:&nbsp; denied&nbsp; { read } for&nbsp; pid=3D1735
exe=3D/usr/sbin/sendmail.sendmail name=3Dutmp dev=3Dhda3 ino=3D783370
scontext=3Dsystem_u:system_r:sendmail_t
tcontext=3Dsystem_u:object_r:initrc_var_run_t =
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oct&nbsp; 5 17:37:15 baal kernel: =
audit(1097012235.659:0):
avc:&nbsp; denied&nbsp; { read write } for&nbsp; pid=3D1735
exe=3D/usr/sbin/sendmail.sendmail name=3Dutmp dev=3Dhda3 ino=3D783370
scontext=3Dsystem_u:system_r:sendmail_t
tcontext=3Dsystem_u:object_r:initrc_var_run_t =
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oct&nbsp; 5 17:37:15 baal kernel: =
audit(1097012235.670:0):
avc:&nbsp; denied&nbsp; { read } for&nbsp; pid=3D1735
exe=3D/usr/sbin/sendmail.sendmail name=3Dutmp dev=3Dhda3 ino=3D783370
scontext=3Dsystem_u:system_r:sendmail_t
tcontext=3Dsystem_u:object_r:initrc_var_run_t =
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PostgreSQL AVC Errors:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oct&nbsp; 5 17:37:18 baal kernel: =
audit(1097012238.340:0):
avc:&nbsp; denied&nbsp; { sys_admin } for&nbsp; pid=3D1774 =
exe=3D/sbin/consoletype
capability=3D21 scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:system_r:postgresql_t =
tclass=3Dcapability<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oct&nbsp; 5 17:37:18 baal kernel: =
audit(1097012238.662:0):
avc:&nbsp; denied&nbsp; { search } for&nbsp; pid=3D1782 exe=3D/bin/su =
name=3Dselinux
dev=3Dhda3 ino=3D2434464 scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:selinux_config_t =
tclass=3Ddir<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oct&nbsp; 5 17:37:18 baal kernel: =
audit(1097012238.825:0):
avc:&nbsp; denied&nbsp; { search } for&nbsp; pid=3D1782 exe=3D/bin/su =
dev=3Dselinuxfs
ino=3D1005 scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:security_t =
tclass=3Ddir<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oct&nbsp; 5 17:37:18 baal kernel: =
audit(1097012238.840:0):
avc:&nbsp; denied&nbsp; { search } for&nbsp; pid=3D1782 exe=3D/bin/su =
dev=3Dselinuxfs
ino=3D1005 scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:security_t =
tclass=3Ddir<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oct&nbsp; 5 17:37:19 baal kernel: =
audit(1097012239.058:0):
avc:&nbsp; denied&nbsp; { read } for&nbsp; pid=3D1782 exe=3D/bin/su =
name=3Dshadow
dev=3Dhda3 ino=3D2434295 scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:shadow_t =
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oct&nbsp; 5 17:37:19 baal kernel: =
audit(1097012239.074:0):
avc:&nbsp; denied&nbsp; { read } for&nbsp; pid=3D1782 exe=3D/bin/su =
name=3Dshadow
dev=3Dhda3 ino=3D2434295 scontext=3Dsystem_u:system_r:postgresql_t =
tcontext=3Dsystem_u:object_r:shadow_t
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oct&nbsp; 5 17:37:19 baal kernel: =
audit(1097012239.091:0):
avc:&nbsp; denied&nbsp; { read } for&nbsp; pid=3D1782 exe=3D/bin/su =
name=3Dshadow
dev=3Dhda3 ino=3D2434295 scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:shadow_t =
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oct&nbsp; 5 17:37:19 baal kernel: =
audit(1097012239.109:0):
avc:&nbsp; denied&nbsp; { read } for&nbsp; pid=3D1782 exe=3D/bin/su =
name=3Dshadow
dev=3Dhda3 ino=3D2434295 scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:shadow_t =
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oct&nbsp; 5 17:37:19 baal kernel: =
audit(1097012239.128:0):
avc:&nbsp; denied&nbsp; { read } for&nbsp; pid=3D1782 exe=3D/bin/su =
name=3Dshadow
dev=3Dhda3 ino=3D2434295 scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:shadow_t =
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oct&nbsp; 5 17:37:19 baal kernel: =
audit(1097012239.147:0): avc:&nbsp;
denied&nbsp; { read } for&nbsp; pid=3D1782 exe=3D/bin/su name=3Dshadow =
dev=3Dhda3
ino=3D2434295 scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:shadow_t =
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oct&nbsp; 5 17:37:19 baal kernel: =
audit(1097012239.168:0):
avc:&nbsp; denied&nbsp; { read } for&nbsp; pid=3D1782 exe=3D/bin/su =
name=3Dshadow
dev=3Dhda3 ino=3D2434295 scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:shadow_t =
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oct&nbsp; 5 17:37:19 baal kernel: =
audit(1097012239.189:0):
avc:&nbsp; denied&nbsp; { read } for&nbsp; pid=3D1782 exe=3D/bin/su =
name=3Dshadow dev=3Dhda3
ino=3D2434295 scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:shadow_t =
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oct&nbsp; 5 17:37:19 baal kernel: =
audit(1097012239.235:0):
avc:&nbsp; denied&nbsp; { execute } for&nbsp; pid=3D1783 exe=3D/bin/su
name=3Dunix_chkpwd dev=3Dhda3 ino=3D32696 =
scontext=3Dsystem_u:system_r:postgresql_t
tcontext=3Dsystem_u:object_r:chkpwd_exec_t =
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>System details are:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Fedora Core 2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>2.6.8-1.521 kernel<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>enforcing=3Dtrue<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>checkpolicy-1.17.5-1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>libselinux-1.17.13-3<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>selinux-policy-strict-1.17.26-3<o:p></o:p></span></fon=
t></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>postgresql-7.4.2-1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>sendmail-8.12.11-4.6<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I upgraded mkinitrd because of a message I noticed in
Bugzilla (<a =
href=3D"https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D133236">ht=
tps://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D133236</a>)
to 4.1.14-1, but haven&#8217;t upgraded the initrd image for the running
kernel.&nbsp; /dev/shm is mounted (per a response <a
href=3D"http://www.redhat.com/archives/fedora-selinux-list/2004-June/msg0=
0178.html">http://www.redhat.com/archives/fedora-selinux-list/2004-June/m=
sg00178.html</a>)
according to my /etc/fstab file and the results of mount.<br>
<br>
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m willing to try coming up with a policy =
patch for
the postgres.te and postgres.tc files, but I&#8217;d like to know if =
anyone
else is seeing these errors first.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thoughts?&nbsp; Thank you ahead of =
time.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Alex Ackerman<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><a =
href=3D"http://www.darkhonor.com/">http://www.darkhonor.com</a><o:p></o:p=
></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C4AB27.5943CF50--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
