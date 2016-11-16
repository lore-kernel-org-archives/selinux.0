Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAGMHHwr003655
 for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2016 17:17:19 -0500
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id B2C5E564721
 for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2016 23:17:13 +0100 (CET)
Received: by mail-wm0-f41.google.com with SMTP id t79so104538790wmt.0
 for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2016 14:17:13 -0800 (PST)
MIME-Version: 1.0
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Wed, 16 Nov 2016 23:17:12 +0100
Message-ID: <CAJfZ7=nN_w9kNKTWmFX01=0KZGm4cN1A-rut6=arH-M+Nydbog@mail.gmail.com>
Subject: Using "override CFLAGS += -I$(PREFIX)/include" in mcstrans?
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a114a75a0556e490541726f44
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114a75a0556e490541726f44
Content-Type: text/plain; charset=UTF-8

Hello,

A few weeks ago I configured Travis-CI to build the SELinux userspace
projects with several configurations (gcc and clang compilers, several
Python and Ruby versions...). Since the merge of splitpolicycoreutils the
builds I have done failed because of at least two things (cf. [1] for the
raw result):

- sandbox test contains "if selinux.security_getenforce() == 1:" to skip
the test on systems where SELinux is in enforcing mode. This fails with a
FileNotFoundError on a system without SELinux (like Travis-CI build
environments). To fix this I wrote a patch [1] that I'll send once I get
the tests running fine again.

- When building mcstrans with a "make install" in the root directory, the
compiler complains with "fatal error: selinux/selinux.h: No such file or
directory". Other subdirectories have "override CFLAGS +=
-I$(PREFIX)/include" to include files installed in $DESTDIR. This makes
"make DESTDIR=/tmp/xxxx install" work on systems without SELinux. Moreover
mcstrans/src/Makefile uses "override CFLAGS += -I../include" but
mcstrans/include/ does not exist. I feel like this line should be modified
to "...-I$(PREFIX)..." but it makes me quite uneasy so before writing a
patch, I would like to be sure I am not missing something I have not seen
in my quick reading of the files. This is why I am writing this email:
could you please take a look at mcstrans Makefiles?

Thanks,
Nicolas

[1] https://travis-ci.org/fishilico/selinux/jobs/176506142
[2]
https://github.com/fishilico/selinux/commit/1c3cae4a984a6dc9a5ba5190a69bf4e7a2362623

--001a114a75a0556e490541726f44
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>A few weeks ago I configured Tra=
vis-CI to build the SELinux userspace projects with several configurations =
(gcc and clang compilers, several Python and Ruby versions...). Since the m=
erge of=C2=A0splitpolicycoreutils the builds I have done failed because of =
at least two things (cf. [1] for the raw result):</div><div><br></div><div>=
- sandbox test contains &quot;if selinux.security_getenforce() =3D=3D 1:&qu=
ot; to skip the test on systems where SELinux is in enforcing mode. This fa=
ils with a FileNotFoundError on a system without SELinux (like Travis-CI bu=
ild environments). To fix this I wrote a patch [1] that I&#39;ll send once =
I get the tests running fine again.<br></div><div><br></div><div>- When bui=
lding=C2=A0mcstrans with a &quot;make install&quot; in the root directory, =
the compiler complains with &quot;fatal error: selinux/selinux.h: No such f=
ile or directory&quot;. Other subdirectories have &quot;override CFLAGS +=
=3D -I$(PREFIX)/include&quot; to include files installed in $DESTDIR. This =
makes &quot;make DESTDIR=3D/tmp/xxxx install&quot; work on systems without =
SELinux. Moreover mcstrans/src/Makefile uses &quot;override CFLAGS +=3D -I.=
./include&quot; but mcstrans/include/ does not exist. I feel like this line=
 should be modified to &quot;...-I$(PREFIX)...&quot; but it makes me quite =
uneasy so before writing a patch, I would like to be sure I am not missing =
something I have not seen in my quick reading of the files. This is why I a=
m writing this email: could you please take a look at mcstrans Makefiles?</=
div><div><br></div><div>Thanks,</div><div>Nicolas</div><div><br></div><div>=
[1] <a href=3D"https://travis-ci.org/fishilico/selinux/jobs/176506142">http=
s://travis-ci.org/fishilico/selinux/jobs/176506142</a></div><div>[2]=C2=A0<=
a href=3D"https://github.com/fishilico/selinux/commit/1c3cae4a984a6dc9a5ba5=
190a69bf4e7a2362623">https://github.com/fishilico/selinux/commit/1c3cae4a98=
4a6dc9a5ba5190a69bf4e7a2362623</a></div></div>

--001a114a75a0556e490541726f44--
