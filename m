Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA08439
	for <selinux@tycho.nsa.gov>; Mon, 3 Sep 2001 00:36:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id EAA24095
	for <selinux@tycho.nsa.gov>; Mon, 3 Sep 2001 04:36:07 GMT
Received: from windowpane.com (ip56.gte1.rb1.bel.nwlink.com [209.20.131.56])
	by jazzband.ncsc.mil  with ESMTP id EAA24091
	for <selinux@tycho.nsa.gov>; Mon, 3 Sep 2001 04:36:06 GMT
Message-ID: <003401c13432$00288830$3a8314d1@nwlink.com>
Reply-To: "Conan Callen" <ccallen@windowpane.com>
From: "Conan Callen" <ccallen@windowpane.com>
To: <selinux@tycho.nsa.gov>
Subject: checkpolicy creates core file
Date: Sun, 2 Sep 2001 21:36:29 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0031_01C133F7.538FB470"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0031_01C133F7.538FB470
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I get a core file whenever checkpolicy is executed. While running step 4 =
(build and install the example policy configuration) the core occurs.

During the first install, today, I got this error. I thought I may had =
made a mistake, so I started over from scrath (deleted (rm -rf) both =
/root/lsm & /root/selinux then untared the distribution again). Once =
again I got the same error.=20

Im going to continue with the install. I brought the core up in gdb, but =
its going to take a while for me to figure out whats going on. Im hoping =
that I can fix it after I get it installed.=20

I started with =
http://www.nsa.gov/selinux/lsm/archives/lsm-200108221537.tgz. I just =
installed a fresh RedHat 7.1.=20


I had installed selinux successfully before, but I got a "Kernel Panic" =
that looked like it was caused by a harddisk error. So I started with a =
new couple new harddrives and reinstalled linux.=20

------=_NextPart_000_0031_01C133F7.538FB470
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
<DIV><FONT face=3DArial size=3D2>I get a core file whenever checkpolicy =
is executed.=20
While running step 4 (build and install the example policy =
configuration) the=20
core occurs.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>During the first install,&nbsp;today, =
I&nbsp;got=20
this error. I thought I may had made a mistake, so I started over from =
scrath=20
(deleted (rm -rf)&nbsp;both /root/lsm &amp; /root/selinux then untared =
the=20
distribution again). Once again I got the same error. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Im going to continue with the install. =
I brought=20
the core up in gdb, but its going to take a while for me to figure out =
whats=20
going on. Im hoping that I can fix it after I get it installed. =
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I started with <A=20
href=3D"http://www.nsa.gov/selinux/lsm/archives/lsm-200108221537.tgz">htt=
p://www.nsa.gov/selinux/lsm/archives/lsm-200108221537.tgz</A>.=20
I just installed a fresh RedHat 7.1. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I had installed selinux successfully =
before, but I=20
got a "Kernel Panic" that looked like it was caused by a harddisk error. =
So I=20
started with a new couple new harddrives and reinstalled linux.=20
</FONT></DIV></BODY></HTML>

------=_NextPart_000_0031_01C133F7.538FB470--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
