Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3779AI4014201
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2003 03:09:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3775TOv024647
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2003 07:05:30 GMT
Received: from windowpane.com (ip57.gte1.rb1.bel.nwlink.com [209.20.131.57])
	by jazzswing.ncsc.mil  with ESMTP id h3775SY1024644
	for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2003 07:05:29 GMT
Message-ID: <007501c2fcd5$057f2f10$398314d1@windowpane.com>
From: "ccallen" <ccallen@windowpane.com>
To: <selinux@tycho.nsa.gov>
Subject: boot error (lsm-2.5)
Date: Mon, 7 Apr 2003 00:12:16 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0072_01C2FC9A.58CC43A0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0072_01C2FC9A.58CC43A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I recieved a kernel panic at boot. The call stack was:

proc_get_inode
proc_fil_super
get_sb_single
do_kern_mount
proc_fill_super
stext
kern_mount

It also said something about a synchronizating. I have just a typical PC =
(P4, AOpen case). Has one hard drive and one ide cd, nothing fancy.

I built the kernel the first time without making any changes in =
menuconfig other then those called out in README (none of the =
experimental features) and got the boot error.=20

I rebuilt the kernel, unselecting the sound support and hot-swap =
support. And recieved the same boot error.

For now I'm going to roll back to the lsm-2.4 package. In the mean time =
I have been reading through the selinux archives to see if theres any =
patches or figure out where I went wrong (any pointers?). I saw the Dec =
16, lsm-2.5 synchro patch but haven't tryed it yet. I'll pull the latest =
source out of sourceforge cvs and give that a try.

Conan
------=_NextPart_000_0072_01C2FC9A.58CC43A0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1106" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>I recieved a kernel panic at boot. The =
call stack=20
was:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>proc_get_inode</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>proc_fil_super</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>get_sb_single</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>do_kern_mount</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>proc_fill_super</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>stext</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>kern_mount</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>It also said something about a =
synchronizating. I=20
have just a typical PC (P4, AOpen case). Has&nbsp;one hard drive and one =
ide cd,=20
nothing fancy.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I built the kernel the first time =
without making=20
any changes in menuconfig other then those called out in =
README&nbsp;(none of=20
the experimental features) and got the boot error. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I rebuilt the kernel,&nbsp;unselecting =
the sound=20
support and hot-swap support. And recieved the same boot =
error.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>For now I'm going to roll back to the =
lsm-2.4=20
package. In the mean time I&nbsp;have been reading through the selinux =
archives=20
to see if theres any patches or figure out where I went wrong (any =
pointers?). I=20
saw the Dec 16, lsm-2.5 synchro patch but haven't tryed it =
yet.&nbsp;I'll pull=20
the latest source out of sourceforge cvs and give that a =
try.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Conan</FONT></DIV></BODY></HTML>

------=_NextPart_000_0072_01C2FC9A.58CC43A0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
