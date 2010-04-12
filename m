Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3CJOIi8012843
	for <selinux@tycho.nsa.gov>; Mon, 12 Apr 2010 15:24:18 -0400
Received: from imr2.ericy.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3CJP9LZ012329
	for <selinux@tycho.nsa.gov>; Mon, 12 Apr 2010 19:25:10 GMT
Received: from eusaamw0712.eamcs.ericsson.se ([147.117.20.181])
	by imr2.ericy.com (8.13.1/8.13.1) with ESMTP id o3CJSKdu028436
	for <selinux@tycho.nsa.gov>; Mon, 12 Apr 2010 14:28:28 -0500
From: Alan Rouse <alan.rouse@ericsson.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Date: Mon, 12 Apr 2010 15:24:11 -0400
Subject: AVC accesing shadow during gnome login
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F52E48FE523@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: multipart/alternative;
	boundary="_000_5A5E55DF96F73844AF7DFB0F48721F0F52E48FE523EUSAACMS0703e_"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_000_5A5E55DF96F73844AF7DFB0F48721F0F52E48FE523EUSAACMS0703e_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm getting the following when I log in via the gnome login gui (OpenSUSE 1=
1.2) with dontaudit turned off:

type=3DAVC msg=3Daudit(1271099674.777:3): avc:  denied  { read } for  pid=
=3D2475 comm=3D"gdm-session-wor" name=3D"shadow" dev=3Dsda2 ino=3D129609 sc=
ontext=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:object_=
r:shadow_t:s0 tclass=3Dfile
type=3DAVC msg=3Daudit(1271099674.780:4): avc:  denied  { open } for  pid=
=3D2475 comm=3D"gdm-session-wor" name=3D"shadow" dev=3Dsda2 ino=3D129609 sc=
ontext=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:object_=
r:shadow_t:s0 tclass=3Dfile
type=3DAVC msg=3Daudit(1271099674.792:5): avc:  denied  { getattr } for  pi=
d=3D2475 comm=3D"gdm-session-wor" path=3D"/etc/shadow" dev=3Dsda2 ino=3D129=
609 scontext=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:o=
bject_r:shadow_t:s0 tclass=3Dfile

But I think the required access is prohibited via 'neverallow'.   Suggestio=
ns welcome.

Thanks




--_000_5A5E55DF96F73844AF7DFB0F48721F0F52E48FE523EUSAACMS0703e_
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
<div>I'm getting the following when I log in via the gnome login gui (OpenS=
USE 11.2) with dontaudit turned off:</div>
<div>&nbsp;</div>
<div>type=3DAVC msg=3Daudit(1271099674.777:3): avc:&nbsp; denied&nbsp; { re=
ad } for&nbsp; pid=3D2475 comm=3D&quot;gdm-session-wor&quot; name=3D&quot;s=
hadow&quot; dev=3Dsda2 ino=3D129609 scontext=3Dsystem_u:system_r:xdm_t:s0-s=
0:c0.c1023 tcontext=3Dsystem_u:object_r:shadow_t:s0 tclass=3Dfile</div>
<div>type=3DAVC msg=3Daudit(1271099674.780:4): avc:&nbsp; denied&nbsp; { op=
en } for&nbsp; pid=3D2475 comm=3D&quot;gdm-session-wor&quot; name=3D&quot;s=
hadow&quot; dev=3Dsda2 ino=3D129609 scontext=3Dsystem_u:system_r:xdm_t:s0-s=
0:c0.c1023 tcontext=3Dsystem_u:object_r:shadow_t:s0 tclass=3Dfile</div>
<div>type=3DAVC msg=3Daudit(1271099674.792:5): avc:&nbsp; denied&nbsp; { ge=
tattr } for&nbsp; pid=3D2475 comm=3D&quot;gdm-session-wor&quot; path=3D&quo=
t;/etc/shadow&quot; dev=3Dsda2 ino=3D129609 scontext=3Dsystem_u:system_r:xd=
m_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:object_r:shadow_t:s0 tclass=3Dfile</=
div>
<div>&nbsp;</div>
<div>But I think the required access is prohibited via 'neverallow'.&nbsp;&=
nbsp; Suggestions welcome.</div>
<div>&nbsp;</div>
<div>Thanks</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
</font>
</body>
</html>

--_000_5A5E55DF96F73844AF7DFB0F48721F0F52E48FE523EUSAACMS0703e_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
