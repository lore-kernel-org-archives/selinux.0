Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5MErWdE009575
	for <selinux@tycho.nsa.gov>; Fri, 22 Jun 2007 10:53:33 -0400
Received: from neve.di.ubi.pt (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5MErGhQ025717
	for <selinux@tycho.nsa.gov>; Fri, 22 Jun 2007 14:53:26 GMT
Received: from sdfsdksf ([10.0.1.253])
	(authenticated bits=0)
	by neve.di.ubi.pt (8.13.1/8.13.1) with ESMTP id l5MF0VXJ020356
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <selinux@tycho.nsa.gov>; Fri, 22 Jun 2007 16:00:32 +0100
Message-ID: <078701c7b4dd$009d7640$fd01000a@ubi.pt>
From: "david carvalho" <david@di.ubi.pt>
To: <selinux@tycho.nsa.gov>
Subject: backups in fedora 
Date: Fri, 22 Jun 2007 15:52:48 +0100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0784_01C7B4E5.6199AC40"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0784_01C7B4E5.6199AC40
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi !
after I run a few tests, I've verified that "dump" can backup/restore =
files
with selinu attributes. Later "tar" versions seem to do this also, but =
when I extract
a tar archive with "--xattr" or "--selinux", the attributes aren't =
there.
So there are 2 options. Or they aren't been created whith these =
attributes, or it's
on the extraction stage.
Could you please provide me a simple example of tar creation and =
extraction for=20
selinux/extended attributes ?
Thanks !
regards
David

------=_NextPart_000_0784_01C7B4E5.6199AC40
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
<DIV><FONT face=3DArial>Hi !</FONT></DIV>
<DIV><FONT face=3DArial>after I run a few tests, I've verified that =
"dump" can=20
backup/restore files</FONT></DIV>
<DIV><FONT face=3DArial>with selinu attributes. Later "tar" versions =
seem to do=20
this also, but when I extract</FONT></DIV>
<DIV><FONT face=3DArial>a tar archive with "--xattr" or "--selinux", the =

attributes aren't there.</FONT></DIV>
<DIV><FONT face=3DArial>So there are 2 options. Or they aren't been =
created whith=20
these attributes, or it's</FONT></DIV>
<DIV><FONT face=3DArial>on the extraction stage.</FONT></DIV>
<DIV><FONT face=3DArial>Could you please provide me a simple example of =
tar=20
creation and extraction for </FONT></DIV>
<DIV><FONT face=3DArial>selinux/extended attributes ?</FONT></DIV>
<DIV><FONT face=3DArial>Thanks !</FONT></DIV>
<DIV><FONT face=3DArial>regards</FONT></DIV>
<DIV><FONT face=3DArial>David</FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0784_01C7B4E5.6199AC40--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
