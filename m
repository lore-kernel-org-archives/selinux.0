Message-ID: <007c01c13569$47bfb9b0$3a8314d1@nwlink.com>
Reply-To: "Conan Callen" <ccallen@windowpane.com>
From: "Conan Callen" <ccallen@windowpane.com>
To: <SELinux@tycho.nsa.gov>
Subject: Re: checkpolicy creates core file
Date: Tue, 4 Sep 2001 10:44:43 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0079_01C1352E.9B5018D0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0079_01C1352E.9B5018D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This could be. The first time I built the system  I selected Pentium =
Classic, and everything ran fine. This last time I did not touch this =
setting (left it at Pentium III) and the checkpolicy utlity failed.=20

I just started the build process (from the beginning) and selected =
Pentium Classic.

Conan
  ----- Original Message -----=20
  From: Conan Callen=20
  To: selinux@tycho.nsa.gov=20
  Sent: Sunday, September 02, 2001 9:36 PM
  Subject: checkpolicy creates core file


  I get a core file whenever checkpolicy is executed. While running step =
4 (build and install the example policy configuration) the core occurs.

  During the first install, today, I got this error. I thought I may had =
made a mistake, so I started over from scrath (deleted (rm -rf) both =
/root/lsm & /root/selinux then untared the distribution again). Once =
again I got the same error.=20

  Im going to continue with the install. I brought the core up in gdb, =
but its going to take a while for me to figure out whats going on. Im =
hoping that I can fix it after I get it installed.=20

  I started with =
http://www.nsa.gov/selinux/lsm/archives/lsm-200108221537.tgz. I just =
installed a fresh RedHat 7.1.=20


  I had installed selinux successfully before, but I got a "Kernel =
Panic" that looked like it was caused by a harddisk error. So I started =
with a new couple new harddrives and reinstalled linux.=20

------=_NextPart_000_0079_01C1352E.9B5018D0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 5.50.4522.1800" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>This could be. The first time I built =
the=20
system&nbsp; I selected Pentium Classic, and everything ran fine. This =
last time=20
I did not touch this setting (left it at Pentium III)&nbsp;and the =
checkpolicy=20
utlity failed. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I just started the build process (from =
the=20
beginning) and selected Pentium Classic.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Conan</FONT></DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dccallen@windowpane.com =
href=3D"mailto:ccallen@windowpane.com">Conan=20
  Callen</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A =
title=3Dselinux@tycho.nsa.gov=20
  href=3D"mailto:selinux@tycho.nsa.gov">selinux@tycho.nsa.gov</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Sunday, September 02, =
2001 9:36=20
  PM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> checkpolicy creates =
core=20
  file</DIV>
  <DIV><BR></DIV>
  <DIV><FONT face=3DArial size=3D2>I get a core file whenever =
checkpolicy is=20
  executed. While running step 4 (build and install the example policy=20
  configuration) the core occurs.</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>During the first install,&nbsp;today, =
I&nbsp;got=20
  this error. I thought I may had made a mistake, so I started over from =
scrath=20
  (deleted (rm -rf)&nbsp;both /root/lsm &amp; /root/selinux then untared =
the=20
  distribution again). Once again I got the same error. </FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>Im going to continue with the =
install. I brought=20
  the core up in gdb, but its going to take a while for me to figure out =
whats=20
  going on. Im hoping that I can fix it after I get it installed. =
</FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>I started with <A=20
  =
href=3D"http://www.nsa.gov/selinux/lsm/archives/lsm-200108221537.tgz">htt=
p://www.nsa.gov/selinux/lsm/archives/lsm-200108221537.tgz</A>.=20
  I just installed a fresh RedHat 7.1. </FONT></DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial size=3D2>I had installed selinux successfully =
before, but=20
  I got a "Kernel Panic" that looked like it was caused by a harddisk =
error. So=20
  I started with a new couple new harddrives and reinstalled linux.=20
</FONT></DIV></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_0079_01C1352E.9B5018D0--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
