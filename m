Message-ID: <00bb01c11497$e75180a0$020144c0@windows>
From: "Eric Peters" <eric@peters.org>
To: <SELinux@tycho.nsa.gov>
Subject: Can't do a make relabel...
Date: Tue, 24 Jul 2001 16:25:11 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00B8_01C1145D.36016660"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_00B8_01C1145D.36016660
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I've got a fresh RedHat 7.1 install, and trying to make relabel but it =
seems the 'setfiles' program doesn't have permission to transition the =
e2fsck files from the sbin_t to fsadm_exec_t

Anyone know what I'm talking about?

The box isn't online but if it would help to get a more verbose error I =
surely can.

Thanks,

Eric

------=_NextPart_000_00B8_01C1145D.36016660
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 5.50.4616.200" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>I've got a fresh RedHat 7.1 install, =
and trying to=20
make relabel but it seems the 'setfiles' program doesn't have permission =
to=20
transition the e2fsck files from the sbin_t to fsadm_exec_t</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Anyone know what I'm talking =
about?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>The box isn't online but if it would =
help to get a=20
more verbose error I surely can.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Eric</FONT></DIV></BODY></HTML>

------=_NextPart_000_00B8_01C1145D.36016660--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
