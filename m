Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3GDfHI4001738
	for <selinux@tycho.nsa.gov>; Wed, 16 Apr 2003 09:41:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3GDbUOv019118
	for <selinux@tycho.nsa.gov>; Wed, 16 Apr 2003 13:37:30 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [144.51.25.14])
	by jazzswing.ncsc.mil  with ESMTP id h3GDbUY1019115
	for <selinux@tycho.nsa.gov>; Wed, 16 Apr 2003 13:37:30 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [127.0.0.1])
	by moss-sooners.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3GDfDCo016863
	for <selinux@tycho.nsa.gov>; Wed, 16 Apr 2003 09:41:13 -0400
Received: (from hdholm@localhost)
	by moss-sooners.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h3GDfDMi016861
	for selinux@tycho.nsa.gov; Wed, 16 Apr 2003 09:41:13 -0400
Message-ID: <000801c303a8$4622a310$3700a8c0@wind>
From: "Christof Rath" <rath@sbox.tu-graz.ac.at>
To: <SELinux@tycho.nsa.gov>
Subject: installing SELinux on Trustix
Date: Wed, 16 Apr 2003 01:39:32 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0005_01C303B9.07C41570"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0005_01C303B9.07C41570
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I have done the 'make quickinstall' and got some problems while =
executing 'sdf' but I expected this would not be a problem if I just =
want to restart with the new kernel.
But when I started with the new kernel I got the following messages:

[snip]
INIT: version 2.78 booting

avc: denied { getattr } for pid=3D1 exe=3D/sbin/init path=3D/dev/initctl =
dev=3D08:07 ino=3D22610 scontext=3Dsystem_u:system_r:kernel_t =
tcontext=3Dsystem_u:objecr_r:file_t tclass=3Dfifo_file

avc: denied { read } for pid=3D8 exe=3D/sbin/init path=3D/bin/sh =
dev=3D08:07 ino=3D55138 scontext=3Dsystem_u:system_r:kernel_t =
tcontext=3Dsystem_u:objecr_r:file_t tclass=3Dlnk_file
[snip]

and some more of them and at the end I got a list of=20

[snip]
INIT: cannot execute "/sbin/mingetty"
INIT: cannot execute "/sbin/mingetty"
INIT: cannot execute "/sbin/mingetty"
[snip]

I hope someone can tell me a solution...

nice day
Christof
------=_NextPart_000_0005_01C303B9.07C41570
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1141" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have done the 'make quickinstall' and =
got some=20
problems while executing 'sdf' but I expected this would not be a =
problem if I=20
just want to restart with the new kernel.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>But when I started with the new kernel =
I got the=20
following messages:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>[snip]</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2>INIT: version 2.78 =
booting</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>avc: denied { getattr&nbsp;} =
for pid=3D1=20
exe=3D/sbin/init path=3D/dev/initctl dev=3D08:07 ino=3D22610=20
scontext=3Dsystem_u:system_r:kernel_t =
tcontext=3Dsystem_u:objecr_r:file_t=20
tclass=3Dfifo_file</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>avc: denied { read } for =
pid=3D8=20
exe=3D/sbin/init path=3D/bin/sh dev=3D08:07 ino=3D55138=20
scontext=3Dsystem_u:system_r:kernel_t =
tcontext=3Dsystem_u:objecr_r:file_t=20
tclass=3Dlnk_file</FONT></DIV>
<DIV><FONT face=3D"Courier New" size=3D2>[snip]</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>and some more of them and at the end I =
got a list=20
of </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>[snip]</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3D"Courier New" size=3D2>INIT: cannot execute =
"/sbin/mingetty"
<DIV><FONT face=3D"Courier New" size=3D2>INIT: cannot execute =
"/sbin/mingetty"
<DIV><FONT face=3D"Courier New" size=3D2>INIT: cannot execute=20
"/sbin/mingetty"</FONT></DIV>
<DIV>[snip]</DIV>
<DIV><FONT face=3DArial></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial>I hope someone can tell me a =
solution...</FONT></DIV>
<DIV><FONT face=3DArial></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial>nice day</FONT></DIV>
<DIV><FONT=20
face=3DArial>Christof</FONT></DIV></FONT></DIV></FONT></DIV></FONT></DIV>=
</BODY></HTML>

------=_NextPart_000_0005_01C303B9.07C41570--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
