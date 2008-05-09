Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m49GpoW5002121
	for <selinux@tycho.nsa.gov>; Fri, 9 May 2008 12:51:50 -0400
Received: from az25ege01.gdc4s.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m49GpmDT010640
	for <selinux@tycho.nsa.gov>; Fri, 9 May 2008 16:51:49 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8B1F4.F85E9D82"
Subject: Compat_net an pam login problem.
Date: Fri, 9 May 2008 09:51:47 -0700
Message-ID: <2B0195B08BA41748A38C4D58ADF44F2C02654731@AZ25EXM01.gddsi.com>
From: "Scally, Katrina-P54861" <Katrina.Scally@gdc4s.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8B1F4.F85E9D82
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


My original problem was With the default pam options, pam_selinux is=20
unable to get the user context, during login it would default to=20
system_u:system_r:local_login_t context. I got around this problem for=20
some time by changing /etc/pam.d/login line to=20
Session required pam_selinux.so open verbose select_context

I found in the mailing list archives to update to
pam-0.1.99.6.2-3.26.el5.i386.rpm
I did this as well as updating my reference policy to the latest on the
Tresys site.
I am now running into the problem below:


I am logging in via console, what I have found is this:
I have selinux_compat_net=3D1 in my grub.conf file. If I remove this=20
from the file I can indeed login with the latest reference policy and=20
pam-0.1.99.6.2-3.26.el5.i386.rpm.
But I, of course, need to use legacy packet control. I have been=20
searching around online and see that I can bypass doing this at boot=20
and possibly set compat_net at runtime. I am wondering why having this=20
on boot would cause login problems, I don't see the connection.
I am trying to see if I have the same problem when I set compat_net=20
during runtime.

Thanks in advance for any input,
-K

> This email message is for the sole use of the intended recipient(s)
> and may contain GDC4S confidential or privileged information. Any
> unauthorized review, use, disclosure or distribution is prohibited. If
> you are not an intended recipient, please contact the sender by reply
> email and destroy all copies of the original message.
>=20

------_=_NextPart_001_01C8B1F4.F85E9D82
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>Compat_net an pam login problem.</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->
<BR>

<P><FONT SIZE=3D2 FACE=3D"Courier New">My original problem was With the =
default pam options, pam_selinux is </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">unable to get the user context, =
during login it would default to </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">system_u:system_r:local_login_t =
context. I got around this problem for </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">some time by changing =
/etc/pam.d/login line to </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">Session required pam_selinux.so =
open verbose select_context</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">I found in the mailing list =
archives to update to pam-0.1.99.6.2-3.26.el5.i386.rpm</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">I did this as well as updating =
my reference policy to the latest on the Tresys site.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">I am now running into the =
problem below:</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Courier New">I am logging in via console, what =
I have found is this:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">I have selinux_compat_net=3D1 in =
my grub.conf file. If I remove this </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">from the file I can indeed login =
with the latest reference policy and </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier =
New">pam-0.1.99.6.2-3.26.el5.i386.rpm.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">But I, of course, need to use =
legacy packet control. I have been </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">searching around online and see =
that I can bypass doing this at boot </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">and possibly set compat_net at =
runtime. I am wondering why having this </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">on boot would cause login =
problems, I don't see the connection.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">I am trying to see if I have the =
same problem when I set compat_net </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">during runtime.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Thanks in advance for any =
input,</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">-K</FONT>
</P>

<P><I><FONT SIZE=3D2 FACE=3D"Arial">This email message is for the sole =
use of the intended recipient(s) and may contain GDC4S confidential or =
privileged information. Any unauthorized review, use, disclosure or =
distribution is prohibited. If you are not an intended recipient, please =
contact the sender by reply email and destroy all copies of the original =
message.</FONT></I></P>

</BODY>
</HTML>
------_=_NextPart_001_01C8B1F4.F85E9D82--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
