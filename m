MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C2FAEB.D1B258A0"
Subject: spassword
Date: Fri, 4 Apr 2003 15:50:26 -0500
Message-ID: <8A61167D13CED411B3E500B0D079784703AAEE@mailserver.itac.reston>
From: "Matthew R. Singer" <msinger@itac.com>
To: <SELinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C2FAEB.D1B258A0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable


Running spasswd fails with:

/usr/local/selinux/bin/spasswd:  Unix identity root does not match Flask
identity system_u

/var/log/messages contains:

localhost kernel: security_compute_sid:  invalid context
system_u:system_r:passwd_t for scontext=3Dsystem_u:system_r:sysadm_t
tcontext=3Dsystem_u:object_r:passwd_exec_t tclass=3Dprocess

How do I fix this?



------_=_NextPart_001_01C2FAEB.D1B258A0
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
<TITLE>spassword</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Running spasswd fails with:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">/usr/local/selinux/bin/spasswd:&nbsp; =
Unix identity root does not match Flask identity system_u</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">/var/log/messages contains:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">localhost kernel: =
security_compute_sid:&nbsp; invalid context system_u:system_r:passwd_t =
for scontext=3Dsystem_u:system_r:sysadm_t =
tcontext=3Dsystem_u:object_r:passwd_exec_t tclass=3Dprocess</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">How do I fix this?</FONT>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C2FAEB.D1B258A0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
