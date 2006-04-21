Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3LJo2wx030591
	for <selinux@tycho.nsa.gov>; Fri, 21 Apr 2006 15:50:02 -0400
Received: from xcgca812.northgrum.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3LJo1r1011515
	for <selinux@tycho.nsa.gov>; Fri, 21 Apr 2006 19:50:01 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6657C.C1CEEFFD"
Subject: login error with strict modular ref pol in RHEL4
Date: Fri, 21 Apr 2006 15:49:52 -0400
Message-ID: <85A664F2F3F2D1409EE003C7D3D52EE40389FE8B@xcgoh901.northgrum.com>
From: "Dinardo, Michael \(Xetron\)" <Michael.Dinardo@ngc.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6657C.C1CEEFFD
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi list,

I am having trouble logging in after building and loading strict modular
reference policy in RHEL4.  Just wondering if anyone else has
encountered this and might have a suggestion on how to fix.   =20

I cannot log in (even if I boot in permissive mode) once the system
boots.  This is for both run level 3 and 5.  Run level 1 is fine.  My
selinux toolchain and policy source are from
ftp://people.redhat.com/dwalsh/SELinux-RHEL4_MODULAR.  The messages I am
receiving when attempting graphical and console logins are as follows:

GRAPHICAL LOGIN MESSAGE:=20
Error! Unable to set executable context

CONSOLE LOGIN DIALOGS:
login: root
password: *******
Would you like to enter a security context? [y] Y
role: sysadm_r
type: sysadm_t
Not a valid security context.

After telling me I have entered an invalid security context the system
brings me back to the initial login screen.  I've tried many variations
of role/type at the above login prompt to no avail.  Does this mean I
just need to set up proper security contexts for my users?  Or, could it
be that I am missing some type of user security context file?  Has
anyone else encountered this type of error?

Thanks,
Mike.

------_=_NextPart_001_01C6657C.C1CEEFFD
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7232.7">
<TITLE>login error with strict modular ref pol in RHEL4</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Courier New">Hi list,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">I am having trouble logging in =
after building and loading strict modular reference policy in =
RHEL4.&nbsp; Just wondering if anyone else has encountered this and =
might have a suggestion on how to fix.&nbsp;&nbsp;&nbsp; </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">I cannot log in (even if I boot =
in permissive mode) once the system boots.&nbsp; This is for both run =
level 3 and 5.&nbsp; Run level 1 is fine.&nbsp; My selinux toolchain and =
policy source are from </FONT><A =
HREF=3D"ftp://people.redhat.com/dwalsh/SELinux-RHEL4_MODULAR"><U><FONT =
COLOR=3D"#0000FF" SIZE=3D2 FACE=3D"Courier =
New">ftp://people.redhat.com/dwalsh/SELinux-RHEL4_MODULAR</FONT></U></A><=
FONT SIZE=3D2 FACE=3D"Courier New">.&nbsp; The messages I am receiving =
when attempting graphical and console logins are as follows:</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">GRAPHICAL LOGIN MESSAGE: </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Error! Unable to set executable =
context</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">CONSOLE LOGIN DIALOGS:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">login: root</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">password: *******</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Would you like to enter a =
security context? [y] Y</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">role: sysadm_r</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">type: sysadm_t</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Not a valid security =
context.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">After telling me I have entered =
an invalid security context the system brings me back to the initial =
login screen.&nbsp; I've tried many variations of role/type at the above =
login prompt to no avail.&nbsp; Does this mean I just need to set up =
proper security contexts for my users?&nbsp; Or, could it be that I am =
missing some type of user security context file?&nbsp; Has anyone else =
encountered this type of error?</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Thanks,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Mike.</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6657C.C1CEEFFD--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
