Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1N0fDsr008245
	for <selinux@tycho.nsa.gov>; Wed, 22 Feb 2006 19:41:14 -0500
Received: from arc.nasa.gov (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1N0fBHJ023524
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2006 00:41:12 GMT
Received: from [128.102.103.36] (HELO imtserv1)
  by pony1pub.arc.nasa.gov (CommuniGate Pro SMTP 4.3.7)
  with SMTP id 24980292 for selinux@tycho.nsa.gov; Wed, 22 Feb 2006 16:41:11 -0800
From: "Andrew JH Ring" <aring@mail.arc.nasa.gov>
To: <selinux@tycho.nsa.gov>
Subject: Apache/PHP module boot restriction?
Date: Wed, 22 Feb 2006 16:41:10 -0800
Message-ID: <NPENJIPGPDNEOOPGDIFGCEEICBAA.aring@mail.arc.nasa.gov>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0000_01C637CE.C91E13A0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C637CE.C91E13A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I've recently set up a Fedora Core 4 web server running Apache 2.2.0 with
PHP 5.1.2.  I've managed to get Apache loading the module, after setting
libphp5.so to shlib_t, however Apache seems to still be unable to access the
module during boot.  I'm getting a Cannot load libphp5 cannot restore
segment prot after reloc.  Is this a known problem, and if so, how is it
fixed?

Thanks for the help.
----------------------------------------

Andrew J H Ring
Engineer/System Administrator
Code TI
NASA Ames Research Center



------=_NextPart_000_0000_01C637CE.C91E13A0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.3790.2577" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D066523200-23022006><FONT face=3DArial size=3D2>I've =
recently set up=20
a Fedora Core 4 web server running Apache 2.2.0 with PHP 5.1.2.&nbsp; =
I've=20
managed to get Apache loading the module, after setting libphp5.so to =
shlib_t,=20
however Apache seems to still be unable to access the module during =
boot.&nbsp;=20
I'm getting a Cannot load libphp5 cannot restore segment prot after =
reloc.&nbsp;=20
Is this a known problem, and if so, how is it fixed?</FONT></SPAN></DIV>
<DIV><SPAN class=3D066523200-23022006></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D066523200-23022006><FONT face=3DArial size=3D2>Thanks =
for the=20
help.</FONT></SPAN></DIV>
<P align=3Dleft><FONT=20
size=3D2>----------------------------------------<BR></FONT><FONT=20
size=3D2><BR>Andrew J H Ring<BR>Engineer/System Administrator<BR>Code =
TI<BR>NASA=20
Ames Research Center<BR></P></FONT>
<DIV>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0000_01C637CE.C91E13A0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
