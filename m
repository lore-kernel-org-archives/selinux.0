Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7O1SgrT022967
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 21:28:42 -0400 (EDT)
Received: from mail.mvalent.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7O1Sewb018796
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 01:28:40 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C48979.B0BC1298"
Subject: Users writting to home directory
Date: Mon, 23 Aug 2004 21:28:42 -0400
Message-ID: <E6E16A6D4277CD459BBDE6713766033CA51515@exchange.mvalent.local>
From: "James R. Marcus" <jmarcus@mvalent.net>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C48979.B0BC1298
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20

=20

=20

            I'm trying to understand how to let a user write to their
home directory.

=20

I created the user with:

useradd -g users -d /usr/people/jmarcus -m -s /bin/bash -c "James R.
Marcus" jmarcus

=20

In permissive mode I see these messages:

=20

Aug 21 07:35:55 ftp useradd[3985]: new user: name=3Djmarcus, uid=3D1000,
gid=3D100, home=3D/usr/people/jmarcus, shell=3D/bin/bash

=20

Aug 21 07:35:55 ftp audit(1093088155.035:0): avc:  denied  { add_name }
for  pid=3D3985 exe=3D/usr/sbin/useradd name=3Djmarcus
scontext=3Droot:staff_r:staff_t tcontext=3Droot:object_r:usr_t =
tclass=3Ddir

=20

Aug 21 07:35:55 ftp audit(1093088155.036:0): avc:  denied  { setattr }
for  pid=3D3985 exe=3D/usr/sbin/useradd name=3Djmarcus dev=3Dhda3 =
ino=3D1907247
scontext=3Droot:staff_r:staff_t tcontext=3Droot:object_r:usr_t =
tclass=3Ddir

=20

Aug 21 07:35:55 ftp audit(1093088155.066:0): avc:  denied  { write } for
pid=3D3985 exe=3D/usr/sbin/useradd =
path=3D/usr/people/jmarcus/.bash_profile
dev=3Dhda3 ino=3D1907248 scontext=3Droot:staff_r:staff_t
tcontext=3Droot:object_r:usr_t tclass=3Dfile

=20

Aug 23 12:05:36 ftp audit(1093277136.698:0): avc:  denied  { write } for
pid=3D7909 exe=3D/bin/nano path=3D/usr/people/jmarcus/test.txt =
dev=3Dhda3
ino=3D1907251 scontext=3Duser_u:user_r:user_t =
tcontext=3Duser_u:object_r:usr_t
tclass=3Dfile

=20

Aug 23 12:05:36 ftp audit(1093277136.698:0): avc:  denied  { write } for
pid=3D7909 exe=3D/bin/nano path=3D/usr/people/jmarcus/test.txt =
dev=3Dhda3
ino=3D1907251 scontext=3Duser_u:user_r:user_t =
tcontext=3Duser_u:object_r:usr_t
tclass=3Dfile

=20

=20

Edited the users file in /etc/security/selinux/src/policy

=20

# add your users and roles for which they are allowed here

=20

user jmarcus roles { user_r };

=20

Ran:

ftp policy # make load

=20

At this point I could write to my home directory. Then I switched to
enforcing mode

=20

Read the Policy.conf which has my user listed

=20

# add your users and roles for which they are allowed here

=20

user jmarcus roles { user_r };

=20

=20

thanks,

James

=20


------_=_NextPart_001_01C48979.B0BC1298
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
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; I&#8217;m trying to understand how to let a user
write to their home directory.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I created the user with:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>useradd -g users -d /usr/people/jmarcus -m -s =
/bin/bash -c
&quot;James R. Marcus&quot; jmarcus<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>In permissive mode I see these =
messages:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Aug 21 07:35:55 ftp useradd[3985]: new user: =
name=3Djmarcus,
uid=3D1000, gid=3D100, home=3D/usr/people/jmarcus, =
shell=3D/bin/bash<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Aug 21 07:35:55 ftp audit(1093088155.035:0): =
avc:&nbsp;
denied&nbsp; { add_name } for&nbsp; pid=3D3985 exe=3D/usr/sbin/useradd =
name=3Djmarcus
scontext=3Droot:staff_r:staff_t tcontext=3Droot:object_r:usr_t =
tclass=3Ddir<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Aug 21 07:35:55 ftp audit(1093088155.036:0): =
avc:&nbsp;
denied&nbsp; { setattr } for&nbsp; pid=3D3985 exe=3D/usr/sbin/useradd =
name=3Djmarcus
dev=3Dhda3 ino=3D1907247 scontext=3Droot:staff_r:staff_t =
tcontext=3Droot:object_r:usr_t
tclass=3Ddir<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Aug 21 07:35:55 ftp audit(1093088155.066:0): =
avc:&nbsp;
denied&nbsp; { write } for&nbsp; pid=3D3985 exe=3D/usr/sbin/useradd
path=3D/usr/people/jmarcus/.bash_profile dev=3Dhda3 ino=3D1907248
scontext=3Droot:staff_r:staff_t tcontext=3Droot:object_r:usr_t =
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Aug 23 12:05:36 ftp audit(1093277136.698:0): =
avc:&nbsp;
denied&nbsp; { write } for&nbsp; pid=3D7909 exe=3D/bin/nano
path=3D/usr/people/jmarcus/test.txt dev=3Dhda3 ino=3D1907251
scontext=3Duser_u:user_r:user_t tcontext=3Duser_u:object_r:usr_t =
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Aug 23 12:05:36 ftp audit(1093277136.698:0): =
avc:&nbsp;
denied&nbsp; { write } for&nbsp; pid=3D7909 exe=3D/bin/nano
path=3D/usr/people/jmarcus/test.txt dev=3Dhda3 ino=3D1907251
scontext=3Duser_u:user_r:user_t tcontext=3Duser_u:object_r:usr_t =
tclass=3Dfile<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Edited the users file in =
/etc/security/selinux/src/policy<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'># add your users and roles for which they are allowed =
here<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user jmarcus roles { user_r =
};<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Ran:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>ftp policy # make load<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>At this point I could write to my home directory. =
Then I
switched to enforcing mode<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Read the Policy.conf which has my user =
listed<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'># add your users and roles for which they are allowed =
here<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>user jmarcus roles { user_r =
};<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>James<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C48979.B0BC1298--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
