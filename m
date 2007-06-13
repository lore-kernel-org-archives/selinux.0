Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5DHW53L015320
	for <selinux@tycho.nsa.gov>; Wed, 13 Jun 2007 13:32:05 -0400
Received: from neve.di.ubi.pt (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5DHW2qp021504
	for <selinux@tycho.nsa.gov>; Wed, 13 Jun 2007 17:32:04 GMT
Received: from sdfsdksf ([10.0.1.253])
	(authenticated bits=0)
	by neve.di.ubi.pt (8.13.1/8.13.1) with ESMTP id l5DHbtBV032286
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <selinux@tycho.nsa.gov>; Wed, 13 Jun 2007 18:38:00 +0100
Message-ID: <049d01c7ade0$d28ca260$fd01000a@ubi.pt>
From: "david carvalho" <david@di.ubi.pt>
To: <selinux@tycho.nsa.gov>
Subject: selinux backups
Date: Wed, 13 Jun 2007 18:32:26 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0498_01C7ADE9.31550870"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0498_01C7ADE9.31550870
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Good afternoon.
Wich is the best way to make a backup of a system running lvm and =
selinux ?
It seems that with lvm systems, the best way is to take a snapshot (wich =
seems a waste
of space in a Volume Group). But with Selinux ?  tar-1.15 doesn't apply =
the right=20
permissions when extracting (at least of what I tested).=20
I've bee using "dump" for a while, and I tested it right now and it =
preserves the "extended attributes" so it seems to be the right option =
for me since the scripts I'm using, use "dump"
Is it possible/preferable to use tar or star ?

Thanks.
Regards
David
------=_NextPart_000_0498_01C7ADE9.31550870
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1555" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial>
<DIV><FONT face=3DArial>Good afternoon.</FONT></DIV>
<DIV><FONT face=3DArial>Wich is the best way to make a backup of a =
system running=20
lvm and selinux ?</FONT></DIV>
<DIV><FONT face=3DArial>It seems that with lvm systems, the best way is =
to take a=20
snapshot (wich seems a waste</FONT></DIV>
<DIV><FONT face=3DArial>of space in a Volume Group). But with Selinux =
?&nbsp;=20
tar-1.15 doesn't apply the right </FONT></DIV>
<DIV><FONT face=3DArial>permissions when extracting (at least of what I =
tested).=20
</FONT></DIV>
<DIV>I've bee using "dump" for a while, and I tested it right now and it =

preserves the "extended attributes" so it seems to be the right option =
for me=20
since the scripts I'm using, use "dump"</DIV>
<DIV>Is it possible/preferable to use tar or star ?</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial>Thanks.</FONT></DIV>
<DIV><FONT face=3DArial>Regards</FONT></DIV>
<DIV><FONT face=3DArial>David</FONT></DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_0498_01C7ADE9.31550870--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
