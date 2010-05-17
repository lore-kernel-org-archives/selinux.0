Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4HJBSDb030269
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2010 15:11:28 -0400
Received: from imr1.ericy.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o4HJCfqm005828
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2010 19:12:41 GMT
Received: from eusaamw0711.eamcs.ericsson.se ([147.117.20.178])
	by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o4HJHGeW030793
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2010 14:17:16 -0500
From: Alan Rouse <alan.rouse@ericsson.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Mon, 17 May 2010 15:11:25 -0400
Subject: Two constraint violations
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F52EDF441A0@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: multipart/alternative;
	boundary="_000_5A5E55DF96F73844AF7DFB0F48721F0F52EDF441A0EUSAACMS0703e_"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_000_5A5E55DF96F73844AF7DFB0F48721F0F52EDF441A0EUSAACMS0703e_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

1.  When I boot to a desktop as user_t, then open a terminal, and execute '=
su' to login as root, a file is created in the /root directory called .xaut=
h0SiF7t.  That produces the following AVC:

type=3DAVC msg=3Daudit(1274122005.740:4): avc: denied { create } for pid=3D=
4410 comm=3D"su" name=3D".xauth0SiF7t" scontext=3Duser_u:user_r:user_su_t:s=
0 tcontext=3Dsystem_u:object_r:default_t:s0 tclass=3Dfile

Audit2allow generates the an allow rule but tells me it is a constraint vio=
lation.

allow user_su_t default_t:file create;

Any insights into why this is happening / what I should do to fix it?

2.  Note, I'm still also getting this AVC during system boot, for which aud=
it2allow also generates a rule which is a constraint violation:

type=3DAVC msg=3Daudit(1274121983.953:3): avc: denied { relablefrom } for p=
id=3D4335 comm=3D"restorecond" name=3D".xsession-errors" dev=3Dsda3 ino=3D1=
27759 scontext=3Duser_u:user_r:user_t:s0 tcontext=3Dsystem_u:object_r:xauth=
_home_t:s0 tclass=3Dfile

Any insights into why this is happening / what I should do to fix it?






--_000_5A5E55DF96F73844AF7DFB0F48721F0F52EDF441A0EUSAACMS0703e_
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
<div>1.&nbsp; When I boot to a desktop as user_t, then open a terminal, and=
 execute 'su' to login as root, a file is created in the /root directory ca=
lled .xauth0SiF7t.&nbsp; That produces the following AVC:</div>
<div>&nbsp;</div>
<div style=3D"padding-left: 38pt; ">type=3DAVC msg=3Daudit(1274122005.740:4=
): avc: denied { create } for pid=3D4410 comm=3D&quot;su&quot; name=3D&quot=
;.xauth0SiF7t&quot; scontext=3Duser_u:user_r:user_su_t:s0 tcontext=3Dsystem=
_u:object_r:default_t:s0 tclass=3Dfile</div>
<div style=3D"padding-left: 19pt; ">&nbsp;</div>
<div style=3D"padding-left: 19pt; ">Audit2allow generates the an allow rule=
 but tells me it is a constraint violation.</div>
<div style=3D"padding-left: 19pt; ">&nbsp;</div>
<div style=3D"padding-left: 38pt; ">allow user_su_t default_t:file create;<=
/div>
<div style=3D"padding-left: 19pt; ">&nbsp;</div>
<div style=3D"padding-left: 19pt; ">Any insights into why this is happening=
 / what I should do to fix it?</div>
<div>&nbsp;</div>
<div>2.&nbsp; Note, I'm still also getting this AVC during system boot, for=
 which audit2allow also generates a rule which is a constraint violation:</=
div>
<div>&nbsp;</div>
<div style=3D"padding-left: 38pt; ">type=3DAVC msg=3Daudit(1274121983.953:3=
): avc: denied { relablefrom } for pid=3D4335 comm=3D&quot;restorecond&quot=
; name=3D&quot;.xsession-errors&quot; dev=3Dsda3 ino=3D127759 scontext=3Dus=
er_u:user_r:user_t:s0 tcontext=3Dsystem_u:object_r:xauth_home_t:s0 tclass=
=3Dfile</div>
<div style=3D"padding-left: 19pt; ">&nbsp;</div>
<div style=3D"padding-left: 19pt; ">Any insights into why this is happening=
 / what I should do to fix it?</div>
<div style=3D"padding-left: 19pt; ">&nbsp;</div>
<div>&nbsp;</div>
<div style=3D"padding-left: 19pt; ">&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
</font>
</body>
</html>

--_000_5A5E55DF96F73844AF7DFB0F48721F0F52EDF441A0EUSAACMS0703e_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
