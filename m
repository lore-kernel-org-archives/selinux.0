Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9SKJsXZ002932
	for <selinux@tycho.nsa.gov>; Thu, 28 Oct 2004 16:19:54 -0400 (EDT)
Received: from maat.darkhonor.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9SKIYba026915
	for <selinux@tycho.nsa.gov>; Thu, 28 Oct 2004 20:18:36 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4BD2C.12743A70"
Subject: make policy complains on file_contexts
Date: Thu, 28 Oct 2004 16:24:05 -0400
Message-ID: <A52BEA1D8EE8634B9196A136333637B1DAF0@maat.darkhonor.net>
From: "Alex Ackerman" <alex@darkhonor.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4BD2C.12743A70
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I'm trying to build a policy for Eclipse (http://www.eclipse.org) and =
I'm using the existing policy for Mozilla as a guide. However, I am =
finding problems when trying to compile the policy.  The error I receive =
is:

Building file_contexts ...
/usr/bin/checkpolicy -o policy.18 policy.conf
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
security:  6 users, 6 roles, 1204 types, 28 bools
security:  53 classes, 265518 rules
/usr/bin/checkpolicy:  policy configuration loaded
/usr/bin/checkpolicy:  writing binary representation (version 18) to =
policy.18
Validating file_contexts ...
/usr/sbin/setfiles -q -c policy.18 file_contexts/file_contexts
/usr/sbin/setfiles:  invalid context system_u:object_r:user_eclipse_rw_t =
on line number 898
make: *** [policy.18] Error 1

The line in question in file_contexts/program/eclipse.fc is:
HOME_DIR/\.eclipse(/.*)?        system_u:object_r:ROLE_eclipse_rw_t

Eclipse stores user configuration and workspace information in the =
user's home directory (.eclipse and workspace). So I followed the =
Mozilla model exactly (actually, just cut and pasted into the new file =
and renamed mozilla -> eclipse).  Any ideas how to decipher solve this =
one?

Alex
http://www.darkhonor.com
=20

------_=_NextPart_001_01C4BD2C.12743A70
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.6944.0">
<TITLE>make policy complains on file_contexts</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>I'm trying to build a policy for Eclipse (<A =
HREF=3D"http://www.eclipse.org">http://www.eclipse.org</A>) and I'm =
using the existing policy for Mozilla as a guide. However, I am finding =
problems when trying to compile the policy.&nbsp; The error I receive =
is:<BR>
<BR>
Building file_contexts ...<BR>
/usr/bin/checkpolicy -o policy.18 policy.conf<BR>
/usr/bin/checkpolicy:&nbsp; loading policy configuration from =
policy.conf<BR>
security:&nbsp; 6 users, 6 roles, 1204 types, 28 bools<BR>
security:&nbsp; 53 classes, 265518 rules<BR>
/usr/bin/checkpolicy:&nbsp; policy configuration loaded<BR>
/usr/bin/checkpolicy:&nbsp; writing binary representation (version 18) =
to policy.18<BR>
Validating file_contexts ...<BR>
/usr/sbin/setfiles -q -c policy.18 file_contexts/file_contexts<BR>
/usr/sbin/setfiles:&nbsp; invalid context =
system_u:object_r:user_eclipse_rw_t on line number 898<BR>
make: *** [policy.18] Error 1<BR>
<BR>
The line in question in file_contexts/program/eclipse.fc is:<BR>
HOME_DIR/\.eclipse(/.*)?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
system_u:object_r:ROLE_eclipse_rw_t<BR>
<BR>
Eclipse stores user configuration and workspace information in the =
user's home directory (.eclipse and workspace). So I followed the =
Mozilla model exactly (actually, just cut and pasted into the new file =
and renamed mozilla -&gt; eclipse).&nbsp; Any ideas how to decipher =
solve this one?<BR>
<BR>
Alex<BR>
<A HREF=3D"http://www.darkhonor.com">http://www.darkhonor.com</A><BR>
&nbsp;</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C4BD2C.12743A70--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
