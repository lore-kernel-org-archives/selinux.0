Message-ID: <010501c0df17$ee102050$24b8dcd1@hemisphere>
Reply-To: "Sean Rolinson" <snowdog@bigfoot.com>
From: "Sean Rolinson" <snowdog@bigfoot.com>
To: <SELinux@tycho.nsa.gov>
Subject: Problems compiling: SELinux 200104121417 on Alpha (config/flash.h: No such file or directory)
Date: Thu, 17 May 2001 17:25:43 -0400
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0102_01C0DEF6.66E44190"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0102_01C0DEF6.66E44190
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I am having a problem compiling SELinux with a 2.4 kernel on an
alpha.  I am using the complete downloaded package,
slinux-200104121417-release.tgz (i.e. NOT the patches).

When doing a `make dep; make` I get the following error:

gcc -D__KERNEL__ -I/home/snowdog/src/slinux/kernel-2.4/include -Wall
- - -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
- - -pipe -mno-fp-regs -ffixed-8 -mcpu=3Dev5 -Wa,-mev6   -c -o
init/main.o
init/main.c
In file included from
/home/snowdog/src/slinux/kernel-2.4/include/linux/mm.h:4,
                 from
/home/snowdog/src/slinux/kernel-2.4/include/linux/slab.h:14,
                 from
/home/snowdog/src/slinux/kernel-2.4/include/linux/proc_fs.h:9,
                 from init/main.c:18:
/home/snowdog/src/slinux/kernel-2.4/include/linux/sched.h:35:26:
config/flask.h: No such file or directory

I saw an article in the archives talking about this
(http://www.nsa.gov/selinux/list-archive/0003.html), but it said this
shouldn't happen if I was doing a normal kernel build from the
sources, which I was.

I then proceeded to do the following:

[snowdog@alpha kernel]$ cd flask
[snowdog@alpha flask]$ export TOPDIR=3D..
[snowdog@alpha flask]$ make
/bin/sh ./mkflask.sh awk security_classes initial_sids
cp flask.h class_to_string.h initial_sid_to_string.h
../include/linux/flask
/bin/sh ./mkaccess_vector.sh awk access_vectors
cp av_inherit.h common_perm_to_string.h av_perm_to_string.h
av_permissions.h ../include/linux/flask
[snowdog@alpha flask]$

I assume the above part is normally done during the kernel build. =20

I then edited the file "include/linux/sched.h" and changed line 35
FROM "#include <config/flask.h>" TO "#include <linux/flask/flask.h>".

Finally, I changed to the kernel root directory and typed "make" and
it proceeded to compile the kernel with no additional errors.=20

Am I doing something wrong or did I miss an important step from the
docs? I read through the docs and didn't see any pre-compile stuff
that needed to be done for the kernel to build properly.

The above method is probably not the cleanest or most ideal way to
get this to compile.  Any thoughts or suggestions??

Thanks...

Sean Rolinson
snowdog@bigfoot.com

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.8 for non-commercial use <http://www.pgp.com>

iQA/AwUBOwRB1gZ8QuEIBpz3EQLdMQCcD4djruOnWsG+Cf8KDsSDBAzR7FIAoNIb
OcCUfouNbR7dwSMAaFfGn4YK
=3DhSjY
-----END PGP SIGNATURE-----


------=_NextPart_000_0102_01C0DEF6.66E44190
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" =
http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.3315.2870" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>-----BEGIN PGP SIGNED =
MESSAGE-----<BR>Hash:=20
SHA1</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Hello,</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am having a problem compiling SELinux =
with a 2.4=20
kernel on an<BR>alpha.&nbsp; I am using the complete downloaded=20
package,<BR>slinux-200104121417-release.tgz (i.e. NOT the =
patches).</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>When doing a `make dep; make` I get the =
following=20
error:</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>gcc -D__KERNEL__=20
-I/home/snowdog/src/slinux/kernel-2.4/include -Wall<BR>- - =
-Wstrict-prototypes=20
-O2 -fomit-frame-pointer -fno-strict-aliasing<BR>- - -pipe -mno-fp-regs=20
-ffixed-8 -mcpu=3Dev5 -Wa,-mev6&nbsp;&nbsp; -c=20
-o<BR>init/main.o<BR>init/main.c<BR>In file included=20
from<BR>/home/snowdog/src/slinux/kernel-2.4/include/linux/mm.h:4,<BR>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;=20
from<BR>/home/snowdog/src/slinux/kernel-2.4/include/linux/slab.h:14,<BR>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=20
from<BR>/home/snowdog/src/slinux/kernel-2.4/include/linux/proc_fs.h:9,<BR=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;=20
from=20
init/main.c:18:<BR>/home/snowdog/src/slinux/kernel-2.4/include/linux/sche=
d.h:35:26:<BR>config/flask.h:=20
No such file or directory</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I saw an article in the archives =
talking about=20
this<BR>(<A=20
href=3D"http://www.nsa.gov/selinux/list-archive/0003.html">http://www.nsa=
.gov/selinux/list-archive/0003.html</A>),=20
but it said this<BR>shouldn't happen if I was doing a normal kernel =
build from=20
the<BR>sources, which I was.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I then proceeded to do the =
following:</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>[snowdog@alpha kernel]$ cd =
flask<BR>[snowdog@alpha=20
flask]$ export TOPDIR=3D..<BR>[snowdog@alpha flask]$ make<BR>/bin/sh =
./mkflask.sh=20
awk security_classes initial_sids<BR>cp flask.h class_to_string.h=20
initial_sid_to_string.h<BR>../include/linux/flask<BR>/bin/sh=20
./mkaccess_vector.sh awk access_vectors<BR>cp av_inherit.h=20
common_perm_to_string.h av_perm_to_string.h<BR>av_permissions.h=20
../include/linux/flask<BR>[snowdog@alpha flask]$</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I assume the above part is normally =
done during the=20
kernel build.&nbsp; </FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I then edited the file =
"include/linux/sched.h" and=20
changed line 35<BR>FROM "#include &lt;config/flask.h&gt;" TO "#include=20
&lt;linux/flask/flask.h&gt;".</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Finally, I changed to the kernel root =
directory and=20
typed "make" and<BR>it proceeded to compile the kernel with no =
additional=20
errors. </FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Am I doing something wrong or did I =
miss an=20
important step from the<BR>docs? I read through the docs and didn't see =
any=20
pre-compile stuff<BR>that needed to be done for the kernel to build=20
properly.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>The above method is probably not the =
cleanest or=20
most ideal way to<BR>get this to compile.&nbsp; Any thoughts or=20
suggestions??</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks...</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Sean Rolinson<BR><A=20
href=3D"mailto:snowdog@bigfoot.com">snowdog@bigfoot.com</A></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>-----BEGIN PGP =
SIGNATURE-----<BR>Version:=20
PGPfreeware 6.5.8 for non-commercial use &lt;<A=20
href=3D"http://www.pgp.com">http://www.pgp.com</A>&gt;</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>iQA/AwUBOwRB1gZ8QuEIBpz3EQLdMQCcD4djruOnWsG+Cf8KDsSDBAzR7FIAoNIb=
<BR>OcCUfouNbR7dwSMAaFfGn4YK<BR>=3DhSjY<BR>-----END=20
PGP SIGNATURE-----<BR></FONT></DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_0102_01C0DEF6.66E44190--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
