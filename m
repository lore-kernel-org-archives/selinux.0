Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9IFkerT022101
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 11:46:40 -0400 (EDT)
Received: from maat.darkhonor.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9IFkchM002677
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 15:46:39 GMT
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4B52A.1C65CDC0"
Subject: MySQL Policy Patch
Date: Mon, 18 Oct 2004 11:49:53 -0400
Message-ID: <A52BEA1D8EE8634B9196A136333637B130F3@maat.darkhonor.net>
From: "Alex Ackerman" <alex@darkhonor.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4B52A.1C65CDC0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C4B52A.1C65CDC0"


------_=_NextPart_002_01C4B52A.1C65CDC0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

While working on my system, I found the strict policy was inhibiting the
creation of the initial MySQL database files on the system. Because of
this, it was unable to start. I captured the following in my log files:

=20

Oct 18 11:20:09 baal kernel: audit(1098112809.602:0): avc:  denied  {
read } for  pid=3D5150 exe=3D/usr/libexec/mysqld =
path=3D/tmp/sh-thd-1098096392
(deleted) dev=3Dhda3 ino=3D1827940 scontext=3Droot:system_r:mysqld_t
tcontext=3Droot:object_r:sysadm_tmp_t tclass=3Dfile

Oct 18 11:20:09 baal kernel: audit(1098112809.611:0): avc:  denied  {
search } for  pid=3D5150 exe=3D/usr/libexec/mysqld name=3Droot =
dev=3Dhda3
ino=3D1044481 scontext=3Droot:system_r:mysqld_t
tcontext=3Droot:object_r:staff_home_dir_t tclass=3Ddir

Oct 18 11:20:09 baal kernel: audit(1098112809.615:0): avc:  denied  {
getattr } for  pid=3D5152 exe=3D/usr/libexec/mysqld
path=3D/tmp/sh-thd-1098096392 (deleted) dev=3Dhda3 ino=3D1827940
scontext=3Droot:system_r:mysqld_t tcontext=3Droot:object_r:sysadm_tmp_t
tclass=3Dfile

=20

I set the enforcing to 0 and retried the /usr/bin/mysql_install_db
script and everything worked as expected. With enforcing =3D 1, nothing
was created in /var/lib/mysql/mysql. Running audit2allow on these
messages, it suggested the fixes included in this patch. Basically, add
the following lines to the mysqld.te file:

=20

allow mysqld_t staff_home_dir_t:dir { search };

allow mysqld_t sysadm_tmp_t:file { getattr read };

=20

For some reason, MySQL is still trying to access staff home directories
in the search for my.cnf. The second rule is for trying to read tmp
files.  After reloading the policy with these changes, running
/usr/bin/mysql_install_db works while in enforcing mode. =20

=20

Comments?

Alex

=20

Sorry if the patch isn't in the right format, I'm still learning how to
do this.


------_=_NextPart_002_01C4B52A.1C65CDC0
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
font-family:Arial'>While working on my system, I found the strict policy =
was
inhibiting the creation of the initial MySQL database files on the =
system.
Because of this, it was unable to start. I captured the following in my =
log
files:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oct 18 11:20:09 baal kernel: audit(1098112809.602:0): =
avc:&nbsp;
denied&nbsp; { read } for&nbsp; pid=3D5150 exe=3D/usr/libexec/mysqld
path=3D/tmp/sh-thd-1098096392 (deleted) dev=3Dhda3 ino=3D1827940
scontext=3Droot:system_r:mysqld_t tcontext=3Droot:object_r:sysadm_tmp_t =
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oct 18 11:20:09 baal kernel: audit(1098112809.611:0): =
avc:&nbsp;
denied&nbsp; { search } for&nbsp; pid=3D5150 exe=3D/usr/libexec/mysqld =
name=3Droot dev=3Dhda3
ino=3D1044481 scontext=3Droot:system_r:mysqld_t
tcontext=3Droot:object_r:staff_home_dir_t =
tclass=3Ddir<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Oct 18 11:20:09 baal kernel: audit(1098112809.615:0): =
avc:&nbsp;
denied&nbsp; { getattr } for&nbsp; pid=3D5152 exe=3D/usr/libexec/mysqld
path=3D/tmp/sh-thd-1098096392 (deleted) dev=3Dhda3 ino=3D1827940
scontext=3Droot:system_r:mysqld_t tcontext=3Droot:object_r:sysadm_tmp_t =
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I set the enforcing to 0 and retried the =
/usr/bin/mysql_install_db
script and everything worked as expected. With enforcing =3D 1, nothing =
was
created in /var/lib/mysql/mysql. Running audit2allow on these messages, =
it
suggested the fixes included in this patch. Basically, add the following =
lines
to the mysqld.te file:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>allow mysqld_t
staff_home_dir_t:dir { search };<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>allow mysqld_t sysadm_tmp_t:file { getattr =
read };<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>For some reason, MySQL is still trying to =
access
staff home directories in the search for my.cnf. The second rule is for =
trying
to read tmp files.&nbsp; After reloading the policy with these changes, =
running /usr/bin/mysql_install_db
works while in enforcing mode.&nbsp; <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Comments?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Alex<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:10.0pt;
font-family:"Courier New"'>Sorry if the patch isn&#8217;t in the right =
format,
I&#8217;m still learning how to do this.</span></font><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

</div>

</body>

</html>

------_=_NextPart_002_01C4B52A.1C65CDC0--

------_=_NextPart_001_01C4B52A.1C65CDC0
Content-Type: application/octet-stream;
	name="diff"
Content-Transfer-Encoding: base64
Content-Description: diff
Content-Disposition: attachment;
	filename="diff"

LS0tIC9ldGMvc2VsaW51eC9zdHJpY3Qvc3JjL3BvbGljeS9kb21haW5zL3Byb2dyYW0vbXlzcWxk
LnRlCTIwMDQtMTAtMTIgMTE6MzE6NDkuOTU1MTY3MTg0IC0wNDAwCisrKyBteXNxbGQudGUJMjAw
NC0xMC0xOCAxMToyNjozMC4wNzM3OTY1NDQgLTA0MDAKQEAgLTYxLDYgKzYxLDggQEAKICMgZm9y
IC9yb290Ly5teS5jbmYgLSBzaG91bGQgbm90IGJlIG5lZWRlZAogYWxsb3cgbXlzcWxkX3Qgc3lz
YWRtX2hvbWVfZGlyX3Q6ZGlyIHNlYXJjaDsKIGFsbG93IG15c3FsZF90IHN5c2FkbV9ob21lX3Q6
ZmlsZSB7IHJlYWQgZ2V0YXR0ciB9OworYWxsb3cgbXlzcWxkX3Qgc3RhZmZfaG9tZV9kaXJfdDpk
aXIgeyBzZWFyY2ggfTsKK2FsbG93IG15c3FsZF90IHN5c2FkbV90bXBfdDpmaWxlIHsgZ2V0YXR0
ciByZWFkIH07CiAKIGlmZGVmKGBsb2dyb3RhdGUudGUnLCBgCiByX2Rpcl9maWxlKGxvZ3JvdGF0
ZV90LCBteXNxbGRfZXRjX3QpCg==

------_=_NextPart_001_01C4B52A.1C65CDC0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
