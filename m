Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DD4270054
	for <selinux@vger.kernel.org>; Thu, 27 Feb 2025 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691963; cv=none; b=F4AKrvKkhCZ2jlEyVZel6KK6MkFNjqqzfSDkTrr4u+ub+9JAUMSJqTsXjVMiklzCY9gIR35h5C1b2WWA2NZyQ/afoK7xG/Qehx9OohQbR7cYh4ntoBLggRATNXxOFdL2pbFe09bXOiXG5s6FJ4gOukcpD17rklzXGNKYgMUT8sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691963; c=relaxed/simple;
	bh=B8tSdwhUmEXjU9oJp2MBebRetK2+h4xhWfGIeTmRFMQ=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O1gfCzlrzCZHoelYv2XwwO2k2VWI2auT6asAC0xAF1fyFUXYCipYv1AFc8aR9RUq92uCEs07v3hDhztlWgyRlru8e+nkRhQjFhoPOOspxQVnC2MOAqOy0UzrL9RPAZPEMnT2J9VQ66SywBWUPVnBiurjDqySZ5CgLzsvd53qGGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=X1WwXwYc; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="X1WwXwYc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1740691955;
	bh=B8tSdwhUmEXjU9oJp2MBebRetK2+h4xhWfGIeTmRFMQ=;
	h=Date:From:Cc:Subject:From;
	b=X1WwXwYcpr85648lPDsMffGLy4Q530vVGablRa4tQAfWSuhBduJ2G123zfThflfXb
	 dNyE/gcfQ772vEVqJVl4dHOoFT2lhuQvueWNaQXYmc29dr7MxpYW2RtwuaQIlAoyo6
	 9bhCOZP/zIZgT39usj2I/UpQq8psA3w6juxxCUDUNhQi8UhT3ABoX6AgYi+43H01Vt
	 t89zJ8gqD+pkBwhAMmDWjWQRaHr0LjhNGRozF4Jn/k/TzUIN18Alq8lncPFafdDZhh
	 rNlVwtxUzNc0kLqcuCp01CN/VwdPuwDLOnEgiJxW+E6m7568yfODSRj4GZgYnZpmG3
	 3RqFK5QOrKhYw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 8C6AFA360
	for <selinux@vger.kernel.org>; Thu, 27 Feb 2025 22:32:35 +0100 (CET)
Date: Thu, 27 Feb 2025 22:32:35 +0100
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: selinux@vger.kernel.org
Subject: [PATCH] Insert -I../../libselinux/include and -L../../libselinux/src
 into subprograms where needed
Message-ID: <kwnnb3dirxubncipnklpimiv34bmetaxchzvzkoztsw62kx7zd@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bg5po75vmn5wt3ud"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--bg5po75vmn5wt3ud
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

These subprograms (sublibraries) use plain
  #include <selinux/selinux.h>
  cc ... -lselinux ...
&c. which includes/links to the system libselinux.

Naturally, this doesn't work if you don't have one.

All of these fell out of a plain make invocation,
yielding errors like
  cc  -O2 -Werror -Wall -Wextra -Wfloat-equal -Wformat=3D2 -Winit-self -Wmi=
ssing-format-attribute -Wmissing-noreturn -Wmissing-prototypes -Wnull-deref=
erence -Wpointer-arith -Wshadow -Wstrict-prototypes -Wundef -Wunused -Wwrit=
e-strings -fno-common -I../include -D_GNU_SOURCE -c -o boolean_record.o boo=
lean_record.c
  boolean_record.c:26:10: fatal error: selinux/selinux.h: No such file or d=
irectory
     26 | #include <selinux/selinux.h>
        |          ^~~~~~~~~~~~~~~~~~~
  compilation terminated.

  make[2]: Entering directory '/tmp/selinux/policycoreutils/sestatus'
  cc -O2 -Werror -Wall -Wextra -Wfloat-equal -Wformat=3D2 -Winit-self -Wmis=
sing-format-attribute -Wmissing-noreturn -Wmissing-prototypes -Wnull-derefe=
rence -Wpointer-arith -Wshadow -Wstrict-prototypes -Wundef -Wunused -Wwrite=
-strings -fno-common -D_FILE_OFFSET_BITS=3D64   -c -o sestatus.o sestatus.c
  sestatus.c:12:10: fatal error: selinux/selinux.h: No such file or directo=
ry
     12 | #include <selinux/selinux.h>
        |          ^~~~~~~~~~~~~~~~~~~
  compilation terminated.

Signed-off-by: =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczleweli.xyz>
---
 libsemanage/src/Makefile             | 4 ++--
 mcstrans/src/Makefile                | 2 ++
 mcstrans/utils/Makefile              | 3 +++
 policycoreutils/load_policy/Makefile | 2 +-
 policycoreutils/newrole/Makefile     | 3 ++-
 policycoreutils/run_init/Makefile    | 3 ++-
 policycoreutils/secon/Makefile       | 3 ++-
 policycoreutils/semodule/Makefile    | 2 ++
 policycoreutils/sestatus/Makefile    | 3 ++-
 policycoreutils/setfiles/Makefile    | 2 ++
 policycoreutils/setsebool/Makefile   | 2 ++
 policycoreutils/unsetfiles/Makefile  | 3 ++-
 python/audit2allow/Makefile          | 2 ++
 restorecond/Makefile                 | 4 ++--
 14 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index 8dfbd762..4db45aad 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -60,7 +60,7 @@ CFLAGS ?=3D -Werror -Wall -W -Wundef -Wshadow -Wmissing-n=
oreturn -Wmissing-format-
 SWIG_CFLAGS +=3D -Wno-error -Wno-unused-but-set-variable -Wno-unused-varia=
ble -Wno-shadow \
 		-Wno-unused-parameter -Wno-missing-prototypes
=20
-override CFLAGS +=3D -I../include -D_GNU_SOURCE
+override CFLAGS +=3D -I../include -I../../libselinux/include -D_GNU_SOURCE
 RANLIB ?=3D ranlib
=20
 SWIG =3D swig -Wall -python -o $(SWIGCOUT) -outdir ./
@@ -90,7 +90,7 @@ $(LIBA): $(OBJS)
 	$(RANLIB) $@
=20
 $(LIBSO): $(LOBJS)
-	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -laudit -=
lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=3Dlibsemanage.map,-z,d=
efs
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L../../libselinu=
x/src -lsepol -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=
=3Dlibsemanage.map,-z,defs
 	ln -sf $@ $(TARGET)
=20
 $(LIBPC): $(LIBPC).in ../VERSION
diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
index 89dbac16..88487068 100644
--- a/mcstrans/src/Makefile
+++ b/mcstrans/src/Makefile
@@ -16,6 +16,8 @@ PROG_OBJS=3D $(patsubst %.c,%.o,$(PROG_SRC))
 PROG=3Dmcstransd
 INITSCRIPT=3Dmcstrans
 CFLAGS ?=3D -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
+override CFLAGS +=3D -I../../libselinux/include
+override LDFLAGS+=3D -L../../libselinux/src
=20
 all: $(PROG)
=20
diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
index eec714f1..57a73932 100644
--- a/mcstrans/utils/Makefile
+++ b/mcstrans/utils/Makefile
@@ -2,6 +2,9 @@
 PREFIX ?=3D /usr
 SBINDIR ?=3D $(PREFIX)/sbin
=20
+override CFLAGS +=3D -I../../libselinux/include
+override LDFLAGS+=3D -L../../libselinux/src
+
 TARGETS=3Dtranscon untranscon
=20
 # If no specific libsepol.a is specified, fall back on LDFLAGS search path
diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/load_po=
licy/Makefile
index ad80d500..6b2fa880 100644
--- a/policycoreutils/load_policy/Makefile
+++ b/policycoreutils/load_policy/Makefile
@@ -6,7 +6,7 @@ MANDIR ?=3D $(PREFIX)/share/man
 LOCALEDIR ?=3D $(DESTDIR)$(PREFIX)/share/locale
=20
 CFLAGS ?=3D -Werror -Wall -W
-override CFLAGS +=3D $(LDFLAGS) -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR)\""=
 -DPACKAGE=3D"\"policycoreutils\""
+override CFLAGS +=3D $(LDFLAGS) -I../../libselinux/include -L../../libseli=
nux/src -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR)\"" -DPACKAGE=3D"\"policycor=
eutils\""
 override LDLIBS +=3D -lsepol -lselinux
=20
 TARGETS=3D$(patsubst %.c,%,$(sort $(wildcard *.c)))
diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/Mak=
efile
index 4b8145d3..308e92dc 100644
--- a/policycoreutils/newrole/Makefile
+++ b/policycoreutils/newrole/Makefile
@@ -24,7 +24,8 @@ VERSION =3D $(shell cat ../VERSION)
=20
 CFLAGS ?=3D -Werror -Wall -W
 EXTRA_OBJS =3D
-override CFLAGS +=3D -DVERSION=3D\"$(VERSION)\" -DUSE_NLS -DLOCALEDIR=3D"\=
"$(LOCALEDIR)\"" -DPACKAGE=3D"\"policycoreutils\""
+override CFLAGS +=3D -I../../libselinux/include -DVERSION=3D\"$(VERSION)\"=
 -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR)\"" -DPACKAGE=3D"\"policycoreutils\=
""
+override LDFLAGS+=3D -L../../libselinux/src
 override LDLIBS +=3D -lselinux
 ifeq ($(PAMH), y)
 	override CFLAGS +=3D -DUSE_PAM
diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_init/M=
akefile
index 619ebc1d..6c92fda1 100644
--- a/policycoreutils/run_init/Makefile
+++ b/policycoreutils/run_init/Makefile
@@ -10,7 +10,8 @@ PAMH ?=3D $(shell test -f /usr/include/security/pam_appl.=
h && echo y)
 AUDITH ?=3D $(shell test -f /usr/include/libaudit.h && echo y)
=20
 CFLAGS ?=3D -Werror -Wall -W
-override CFLAGS +=3D -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR)\"" -DPACKAGE=
=3D"\"policycoreutils\""
+override CFLAGS +=3D -I../../libselinux/include -DUSE_NLS -DLOCALEDIR=3D"\=
"$(LOCALEDIR)\"" -DPACKAGE=3D"\"policycoreutils\""
+override LDFLAGS+=3D -L../../libselinux/src
 override LDLIBS +=3D -lselinux
 ifeq ($(PAMH), y)
 	override CFLAGS +=3D -DUSE_PAM
diff --git a/policycoreutils/secon/Makefile b/policycoreutils/secon/Makefile
index 440503a1..c2102606 100644
--- a/policycoreutils/secon/Makefile
+++ b/policycoreutils/secon/Makefile
@@ -7,7 +7,8 @@ MANDIR ?=3D $(PREFIX)/share/man
 WARNS=3D-Werror -W -Wall -Wundef -Wshadow -Wpointer-arith -Wbad-function-c=
ast -Wcast-align -Wwrite-strings -Waggregate-return -Wstrict-prototypes -Wm=
issing-prototypes -Wmissing-declarations -Wnested-externs -Wno-format-zero-=
length -Wformat-nonliteral -Wformat-security -Wfloat-equal
 VERSION =3D $(shell cat ../VERSION)
 CFLAGS ?=3D $(WARNS) -O1
-override CFLAGS +=3D -DVERSION=3D\"$(VERSION)\"
+override CFLAGS +=3D -I../../libselinux/include -DVERSION=3D\"$(VERSION)\"
+override LDFLAGS+=3D -L../../libselinux/src
 override LDLIBS +=3D -lselinux
=20
 all: secon
diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/M=
akefile
index 9fbf99d6..31cb2670 100644
--- a/policycoreutils/semodule/Makefile
+++ b/policycoreutils/semodule/Makefile
@@ -5,6 +5,8 @@ SBINDIR ?=3D $(PREFIX)/sbin
 MANDIR =3D $(PREFIX)/share/man
=20
 CFLAGS ?=3D -Werror -Wall -W
+override CFLAGS +=3D -I../../libselinux/include -I../../libsemanage/include
+override LDFLAGS+=3D -L../../libselinux/src     -L../../libsemanage/src
 override LDLIBS +=3D -lsepol -lselinux -lsemanage
 SEMODULE_OBJS =3D semodule.o
=20
diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/M=
akefile
index aebf050c..70748157 100644
--- a/policycoreutils/sestatus/Makefile
+++ b/policycoreutils/sestatus/Makefile
@@ -7,7 +7,8 @@ MANDIR =3D $(PREFIX)/share/man
 ETCDIR ?=3D /etc
=20
 CFLAGS ?=3D -Werror -Wall -W
-override CFLAGS +=3D -D_FILE_OFFSET_BITS=3D64
+override CFLAGS +=3D -I../../libselinux/include -D_FILE_OFFSET_BITS=3D64
+override LDFLAGS+=3D -L../../libselinux/src
 override LDLIBS +=3D -lselinux
=20
 all: sestatus
diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles/M=
akefile
index 84ffb08b..8e589a30 100644
--- a/policycoreutils/setfiles/Makefile
+++ b/policycoreutils/setfiles/Makefile
@@ -6,6 +6,8 @@ MANDIR =3D $(PREFIX)/share/man
 AUDITH ?=3D $(shell test -f /usr/include/libaudit.h && echo y)
=20
 CFLAGS ?=3D -g -Werror -Wall -W
+override CFLAGS +=3D -I../../libselinux/include
+override LDFLAGS+=3D -L../../libselinux/src
 override LDLIBS +=3D -lselinux -lsepol -lpthread
=20
 ifeq ($(AUDITH), y)
diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebool=
/Makefile
index fc5b4ff6..54489ba3 100644
--- a/policycoreutils/setsebool/Makefile
+++ b/policycoreutils/setsebool/Makefile
@@ -6,6 +6,8 @@ MANDIR =3D $(PREFIX)/share/man
 BASHCOMPLETIONDIR ?=3D $(PREFIX)/share/bash-completion/completions
=20
 CFLAGS ?=3D -Werror -Wall -W
+override CFLAGS +=3D -I../../libselinux/include -I../../libsemanage/include
+override LDFLAGS+=3D -L../../libselinux/src     -L../../libsemanage/src
 override LDLIBS +=3D -lselinux -lsemanage
 SETSEBOOL_OBJS =3D setsebool.o
=20
diff --git a/policycoreutils/unsetfiles/Makefile b/policycoreutils/unsetfil=
es/Makefile
index 9e5edc04..08fa1abb 100644
--- a/policycoreutils/unsetfiles/Makefile
+++ b/policycoreutils/unsetfiles/Makefile
@@ -2,7 +2,8 @@ PREFIX ?=3D /usr
 SBINDIR ?=3D $(PREFIX)/sbin
 MANDIR ?=3D $(PREFIX)/share/man
=20
-override CFLAGS +=3D -D_GNU_SOURCE
+override CFLAGS +=3D -I../../libselinux/include -D_GNU_SOURCE
+override LDFLAGS+=3D -L../../libselinux/src
 override LDLIBS +=3D -lselinux
=20
=20
diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
index fb04b8bd..28b8f7f2 100644
--- a/python/audit2allow/Makefile
+++ b/python/audit2allow/Makefile
@@ -8,6 +8,8 @@ BINDIR ?=3D $(PREFIX)/bin
 MANDIR ?=3D $(PREFIX)/share/man
=20
 CFLAGS ?=3D -Werror -Wall -W
+override CFLAGS +=3D -I../../libselinux/include
+override LDFLAGS+=3D -L../../libselinux/src
=20
 # If no specific libsepol.a is specified, fall back on LDFLAGS search path
 # Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
diff --git a/restorecond/Makefile b/restorecond/Makefile
index 1ddfcc92..b8b86eb4 100644
--- a/restorecond/Makefile
+++ b/restorecond/Makefile
@@ -18,8 +18,8 @@ GIO_CFLAGS =3D -DHAVE_DBUS $(shell $(PKG_CONFIG) --cflags=
 gio-2.0)
 GIO_LIBS =3D $(shell $(PKG_CONFIG) --libs gio-2.0)
=20
 CFLAGS ?=3D -g -Werror -Wall -W
-override CFLAGS +=3D $(GIO_CFLAGS)
-
+override CFLAGS +=3D -I../../libselinux/include $(GIO_CFLAGS)
+override LDFLAGS+=3D -L../../libselinux/src
 override LDLIBS +=3D -lselinux $(GIO_LIBS)
=20
 all: restorecond
--=20
2.39.5

--bg5po75vmn5wt3ud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmfA2fMACgkQvP0LAY0m
WPFWHA/8DqKgZQvJo1wGfKpC+uKewKEANhLDsu7D9CjOnS6NiMUJ44DSnc3MjL49
XDaYsgmM4udXSWR2Eidz4g+oiLox0Xs9lFMkXDJ71AIFdlTXCRjwlTrCbzm+AKdd
j0hE/Kusw/+ML6Y9D5HKQyx9/a5RztITScuVLkYQY1EQieW/EkkfyFyGc6LKqedj
NvzXSTzcgUaKSd+q87+yrjzy8Qp1Ys1J0sncPWHcdo1iDyCj4tEpNhQ4/z9cTWwo
YezzdLXza/C/999h5rzpG5EtXmO7L9PAdlWPHpMWu25Joo079Svb/cP1w8iun5u7
qFQ2ZV7POVDpa8D6FRfAohSes7Zz7iuKOBG6fJTTCScErGur53TypxDhGjtypiK+
R32a3QCNiLBLVF1+0LBf3jbRTQlXcf5p7ORuvY9CJafMwZzpUVGv5d+5W9X3TDCI
O6TIthaDGbfjoem+HlCSqud6FnVBE60E4bpTHxnVlXnIOOTnJVJUTc5IjWBhJXko
i2kzUzbsED3/VhqoLBKXXMKHNQlf2DV2+lCY6Y4JyBKYbV+RBBDnXgiyI0iQTUn1
b7ryo34Vzok2s5PBnsf7ppBJT7vOfcX9DLesUk8tcwHs/V3RSWjgB+vV+pBI+0ks
TeuO/i3FWk8D0j1pEKpzcLWzdqSl4lwfj6NMDLjEsn6dbg8SnII=
=Q7vQ
-----END PGP SIGNATURE-----

--bg5po75vmn5wt3ud--
