Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4LEgtp9009463
	for <selinux@tycho.nsa.gov>; Fri, 21 May 2010 10:42:56 -0400
Received: from imr1.ericy.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o4LEiCWx002518
	for <selinux@tycho.nsa.gov>; Fri, 21 May 2010 14:44:13 GMT
Received: from eusaamw0711.eamcs.ericsson.se ([147.117.20.178])
	by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o4LEmlc4024065
	for <selinux@tycho.nsa.gov>; Fri, 21 May 2010 09:48:47 -0500
From: Alan Rouse <alan.rouse@ericsson.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Fri, 21 May 2010 10:42:44 -0400
Subject: Yast and selinux
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F52EE1DB39C@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: multipart/alternative;
	boundary="_000_5A5E55DF96F73844AF7DFB0F48721F0F52EE1DB39CEUSAACMS0703e_"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_000_5A5E55DF96F73844AF7DFB0F48721F0F52EE1DB39CEUSAACMS0703e_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

After loggin in to OpenSUSE desktop (kde) as an unprivileged user, with sel=
inux in permissive mode, I open yast. It prompts for the root password, and=
 after I enter it the yast ui opens.  I immediately close yast.

During that process, avc's were logged:

type=3DAVC msg=3Daudit(1274452313.558:5): avc:  denied  { remove_name } for=
  pid=3D4461 comm=3D"su" name=3D".xauthFrgbnl" dev=3Dsda2 ino=3D55456 scont=
ext=3Duser_u:user_r:user_su_t:s0 tcontext=3Dsystem_u:object_r:admin_home_t:=
s0 tclass=3Ddir
type=3DAVC msg=3Daudit(1274452313.558:6): avc:  denied  { unlink } for  pid=
=3D4461 comm=3D"su" name=3D".xauthFrgbnl" dev=3Dsda2 ino=3D55456 scontext=
=3Duser_u:user_r:user_su_t:s0 tcontext=3Duser_u:object_r:admin_home_t:s0 tc=
lass=3Dfile
type=3DAVC msg=3Daudit(1274452315.321:7): avc:  denied  { lock } for  pid=
=3D4506 comm=3D"y2controlcenter" path=3D"/root/.config/Trolltech.conf" dev=
=3Dsda2 ino=3D42643 scontext=3Duser_u:user_r:user_t:s0 tcontext=3Dsystem_u:=
object_r:admin_home_t:s0 tclass=3Dfile
type=3DAVC msg=3Daudit(1274452315.397:8): avc:  denied  { search } for  pid=
=3D4509 comm=3D"dbus-daemon" name=3D"root" dev=3Dsda2 ino=3D237 scontext=3D=
user_u:user_r:user_dbusd_t:s0 tcontext=3Dsystem_u:object_r:admin_home_t:s0 =
tclass=3Ddir
type=3DAVC msg=3Daudit(1274452315.435:9): avc:  denied  { write } for  pid=
=3D4507 comm=3D"dbus-launch" name=3D"4ddb5cab9a9543d629c6f0e90000041b-0" de=
v=3Dsda2 ino=3D42675 scontext=3Duser_u:user_r:user_t:s0 tcontext=3Dsystem_u=
:object_r:admin_home_t:s0 tclass=3Dfile
type=3DAVC msg=3Daudit(1274452315.452:10): avc:  denied  { write } for  pid=
=3D4506 comm=3D"y2controlcenter" name=3D"config" dev=3Dsda2 ino=3D42678 sco=
ntext=3Duser_u:user_r:user_t:s0 tcontext=3Dsystem_u:object_r:admin_home_t:s=
0 tclass=3Ddir
type=3DAVC msg=3Daudit(1274452315.479:11): avc:  denied  { read } for  pid=
=3D4506 comm=3D"y2controlcenter" name=3D"cache-linux" dev=3Dsda2 ino=3D4267=
9 scontext=3Duser_u:user_r:user_t:s0 tcontext=3Dsystem_u:object_r:admin_hom=
e_t:s0 tclass=3Dlnk_file

It appears that yast is trying to create a new .xauth* file in the root hom=
e directory, and removing an old one, under user_su_t.  Then it is trying t=
o get a lock in y2controlcenter and do some other things as user_u.

Maybe it is ok for user_su_t to have access to root's home dir (I'm not sur=
e) but I doubt it is ok to give permission to user_t for those other access=
es.  It looks to me as if yast needs some selinux patches.  Do patches exis=
t?

How does Fedora handle things like this?


--_000_5A5E55DF96F73844AF7DFB0F48721F0F52EE1DB39CEUSAACMS0703e_
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
<div>After loggin in to OpenSUSE desktop (kde) as an unprivileged user, wit=
h selinux in permissive mode, I open yast. It prompts for the root password=
, and after I enter it the yast ui opens.&nbsp; I immediately close yast.</=
div>
<div>&nbsp;</div>
<div>During that process, avc's were logged:</div>
<div>&nbsp;</div>
<div>type=3DAVC msg=3Daudit(1274452313.558:5): avc:&nbsp; denied&nbsp; { re=
move_name } for&nbsp; pid=3D4461 comm=3D&quot;su&quot; name=3D&quot;.xauthF=
rgbnl&quot; dev=3Dsda2 ino=3D55456 scontext=3Duser_u:user_r:user_su_t:s0 tc=
ontext=3Dsystem_u:object_r:admin_home_t:s0 tclass=3Ddir</div>
<div>type=3DAVC msg=3Daudit(1274452313.558:6): avc:&nbsp; denied&nbsp; { un=
link } for&nbsp; pid=3D4461 comm=3D&quot;su&quot; name=3D&quot;.xauthFrgbnl=
&quot; dev=3Dsda2 ino=3D55456 scontext=3Duser_u:user_r:user_su_t:s0 tcontex=
t=3Duser_u:object_r:admin_home_t:s0 tclass=3Dfile</div>
<div>type=3DAVC msg=3Daudit(1274452315.321:7): avc:&nbsp; denied&nbsp; { lo=
ck } for&nbsp; pid=3D4506 comm=3D&quot;y2controlcenter&quot; path=3D&quot;/=
root/.config/Trolltech.conf&quot; dev=3Dsda2 ino=3D42643 scontext=3Duser_u:=
user_r:user_t:s0 tcontext=3Dsystem_u:object_r:admin_home_t:s0 tclass=3Dfile=
</div>
<div>type=3DAVC msg=3Daudit(1274452315.397:8): avc:&nbsp; denied&nbsp; { se=
arch } for&nbsp; pid=3D4509 comm=3D&quot;dbus-daemon&quot; name=3D&quot;roo=
t&quot; dev=3Dsda2 ino=3D237 scontext=3Duser_u:user_r:user_dbusd_t:s0 tcont=
ext=3Dsystem_u:object_r:admin_home_t:s0 tclass=3Ddir</div>
<div>type=3DAVC msg=3Daudit(1274452315.435:9): avc:&nbsp; denied&nbsp; { wr=
ite } for&nbsp; pid=3D4507 comm=3D&quot;dbus-launch&quot; name=3D&quot;4ddb=
5cab9a9543d629c6f0e90000041b-0&quot; dev=3Dsda2 ino=3D42675 scontext=3Duser=
_u:user_r:user_t:s0 tcontext=3Dsystem_u:object_r:admin_home_t:s0 tclass=3Df=
ile</div>
<div>type=3DAVC msg=3Daudit(1274452315.452:10): avc:&nbsp; denied&nbsp; { w=
rite } for&nbsp; pid=3D4506 comm=3D&quot;y2controlcenter&quot; name=3D&quot=
;config&quot; dev=3Dsda2 ino=3D42678 scontext=3Duser_u:user_r:user_t:s0 tco=
ntext=3Dsystem_u:object_r:admin_home_t:s0 tclass=3Ddir</div>
<div>type=3DAVC msg=3Daudit(1274452315.479:11): avc:&nbsp; denied&nbsp; { r=
ead } for&nbsp; pid=3D4506 comm=3D&quot;y2controlcenter&quot; name=3D&quot;=
cache-linux&quot; dev=3Dsda2 ino=3D42679 scontext=3Duser_u:user_r:user_t:s0=
 tcontext=3Dsystem_u:object_r:admin_home_t:s0 tclass=3Dlnk_file</div>
<div>&nbsp;</div>
<div>It appears that yast is trying to create a new .xauth* file in the roo=
t home directory, and removing an old one, under user_su_t.&nbsp; Then it i=
s trying to get a lock in y2controlcenter and do some other things as user_=
u.&nbsp; </div>
<div>&nbsp;</div>
<div>Maybe it is ok for user_su_t to have access to root's home dir (I'm no=
t sure) but I doubt it is ok to give permission to user_t for those other a=
ccesses.&nbsp; It looks to me as if yast needs some selinux patches.&nbsp; =
Do patches exist? </div>
<div>&nbsp;</div>
<div>How does Fedora handle things like this?</div>
<div>&nbsp;</div>
</font>
</body>
</html>

--_000_5A5E55DF96F73844AF7DFB0F48721F0F52EE1DB39CEUSAACMS0703e_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
