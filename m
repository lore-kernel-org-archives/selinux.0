MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C2FE05.93D4B4FC"
Subject: Unlabeled files
Date: Tue, 8 Apr 2003 15:32:22 -0400
Message-ID: <8A61167D13CED411B3E500B0D079784703AAF1@mailserver.itac.reston>
From: "Matthew R. Singer" <msinger@itac.com>
To: <SELinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C2FE05.93D4B4FC
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Can anyone tell me what selinux thinks is unlabeled below?

Thanks

Apr  8 14:07:11 localhost kernel: avc:  denied  { transition } for
pid=3D902 exe=3D/usr/bin/kdm path=3D/etc/X11/xdm/Xsession dev=3D08:02 =
ino=3D314289
scontext=3Droot:sysadm_r:sysadm_t =
tcontext=3Dsystem_u:object_r:unlabeled_t
tclass=3Dprocess
Apr  8 14:07:11 localhost kernel:=20
Apr  8 14:07:11 localhost kernel: avc:  denied  { transition } for
pid=3D902 exe=3D/usr/bin/kdm path=3D/bin/bash dev=3D08:02 ino=3D49420
scontext=3Droot:sysadm_r:sysadm_t =
tcontext=3Dsystem_u:object_r:unlabeled_t
tclass=3Dprocess

------_=_NextPart_001_01C2FE05.93D4B4FC
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6249.1">
<TITLE>Unlabeled files</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Can anyone tell me what selinux thinks =
is unlabeled below?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Apr&nbsp; 8 14:07:11 localhost kernel: =
avc:&nbsp; denied&nbsp; { transition } for&nbsp; pid=3D902 =
exe=3D/usr/bin/kdm path=3D/etc/X11/xdm/Xsession dev=3D08:02 ino=3D314289 =
scontext=3Droot:sysadm_r:sysadm_t =
tcontext=3Dsystem_u:object_r:unlabeled_t tclass=3Dprocess</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Apr&nbsp; 8 14:07:11 localhost kernel: =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Apr&nbsp; 8 14:07:11 localhost kernel: =
avc:&nbsp; denied&nbsp; { transition } for&nbsp; pid=3D902 =
exe=3D/usr/bin/kdm path=3D/bin/bash dev=3D08:02 ino=3D49420 =
scontext=3Droot:sysadm_r:sysadm_t =
tcontext=3Dsystem_u:object_r:unlabeled_t tclass=3Dprocess</FONT></P>

</BODY>
</HTML>
------_=_NextPart_001_01C2FE05.93D4B4FC--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
