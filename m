Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4CJAisC028012
	for <selinux@tycho.nsa.gov>; Wed, 12 May 2010 15:10:44 -0400
Received: from imr1.ericy.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o4CJA5I3018140
	for <selinux@tycho.nsa.gov>; Wed, 12 May 2010 19:10:05 GMT
Received: from eusaamw0707.eamcs.ericsson.se ([147.117.20.32])
	by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o4CJGHkl021868
	for <selinux@tycho.nsa.gov>; Wed, 12 May 2010 14:16:17 -0500
From: Alan Rouse <alan.rouse@ericsson.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Wed, 12 May 2010 15:10:37 -0400
Subject: Restorecond and .xsession-errors
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F52E5DBDC84@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: multipart/alternative;
	boundary="_000_5A5E55DF96F73844AF7DFB0F48721F0F52E5DBDC84EUSAACMS0703e_"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_000_5A5E55DF96F73844AF7DFB0F48721F0F52E5DBDC84EUSAACMS0703e_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm down to one AVC left booting to a desktop in OpenSUSE 11.3 milestone 6.

type=3DAVC msg=3Daudit(127369094.093:8): avc: denied { relabelfrom } for pi=
d=3D3089 comm=3D"restorecond" name=3D".xsession-errors" dev=3Dsda3 ino=3D12=
7759 scontext=3Duser_u:user_r:user_t:s0 tcontext=3Dsystem_u:object_r:xauth_=
home_t:s0 tclass=3Dfile

It looks to me like somewhere late in the boot, a windowing error occurs an=
d it attempts to log it to .xsession-errors.  For some reason at that point=
 in time it attempts to relabel that file and is denied.

The file context on .xsession-errors in the unprivileged user's home direct=
ory is user_u:object_r:user_home_t:s0

However, when I run audit2allow on that avc, it says "This avc is a constra=
int violation.  You will need to add an attribute to either the source or t=
arget type to make it work."

Should I relabel .xsession-errors?  If so, to what?


--_000_5A5E55DF96F73844AF7DFB0F48721F0F52E5DBDC84EUSAACMS0703e_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial, sans-serif" size=3D"2">
<div>I'm down to one AVC left booting to a desktop in OpenSUSE 11.3 milesto=
ne 6.&nbsp;&nbsp; </div>
<div>&nbsp;</div>
<div>type=3DAVC msg=3Daudit(127369094.093:8): avc: denied { relabelfrom } f=
or pid=3D3089 comm=3D&quot;restorecond&quot; name=3D&quot;.xsession-errors&=
quot; dev=3Dsda3 ino=3D127759 scontext=3Duser_u:user_r:user_t:s0 tcontext=
=3Dsystem_u:object_r:xauth_home_t:s0 tclass=3Dfile</div>
<div>&nbsp;</div>
<div>It looks to me like somewhere late in the boot, a windowing error occu=
rs and it attempts to log it to .xsession-errors.&nbsp; For some reason at =
that point in time it attempts to relabel that file and is denied. </div>
<div>&nbsp;</div>
<div>The file context on .xsession-errors in the unprivileged user's home d=
irectory is user_u:object_r:user_home_t:s0</div>
<div>&nbsp;</div>
<div>However, when I run audit2allow on that avc, it says &quot;This avc is=
 a constraint violation.&nbsp; You will need to add an attribute to either =
the source or target type to make it work.&quot;</div>
<div>&nbsp;</div>
<div>Should I relabel .xsession-errors?&nbsp; If so, to what?&nbsp;&nbsp; <=
/div>
<div>&nbsp;</div>
</font>
</body>
</html>

--_000_5A5E55DF96F73844AF7DFB0F48721F0F52E5DBDC84EUSAACMS0703e_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
