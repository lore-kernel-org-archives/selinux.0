Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h63Mb5Ha004495
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2003 18:37:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h63MawH5001478
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2003 22:36:58 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id h63MawRX001473 for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2003 22:36:58 GMT
Subject: build patches for checkpolicy, libselinux, policycoreutils
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Cc: Russell Coker <russell@coker.com.au>
Content-Type: multipart/mixed; boundary="=-msKd4DvGPXb8S7UegmOY"
Message-Id: <1057271791.24843.13.camel@columbia>
Mime-Version: 1.0
Date: 03 Jul 2003 18:36:32 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-msKd4DvGPXb8S7UegmOY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi, 

I'm working on getting a 2.5 SELinux system going so I can update my
coreutils patch, and as part of that I'm making Debian packages of the
various bits at:
http://www.nsa.gov/selinux/lk/

I've so far only got packages of checkpolicy, selinux, and
policycoreutils, but if anyone's interested, they're up at:

http://web.verbum.org/selinux/

I'm going to work on updating the various other Debian packages with the
SELinux patches next.

One thing I ran into is that my Debian package build system
automatically passes CFLAGS to make like:  
make CFLAGS='-g -Wall -O2'

However the various makefiles have important things like -I../includes
in CFLAGS, which would otherwise be overridden by the command line
argument.  Thus the fix is to use the 'override' keyword so the include
flags are always added, while the other CFLAGS like -Wall can be changed
by the user.

Also one Makefile was calling /sbin/ldconfig in the install rule, which
broke my Debian package builds.  Admins should just have to know to run
ldconfig after installing libraries.  Or maybe we could turn it into a
libtool-style notice.

Finally, newrole.c was missing an #include <errno.h>, and we need to
create $(DESTDIR)/etc/pam.d if it doesn't exist.

There should be 5 patches attached.


--=-msKd4DvGPXb8S7UegmOY
Content-Disposition: attachment; filename=checkpolicy-makefile.patch
Content-Type: text/x-makefile; name=checkpolicy-makefile.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- Makefile	2003-06-03 16:50:53.000000000 -0400
+++ Makefile.new	2003-07-03 17:18:17.000000000 -0400
@@ -4,7 +4,8 @@
 PREFIX ?=3D ${DESTDIR}/usr
 BINDIR ?=3D $(PREFIX)/bin
=20
-CFLAGS =3D -g -Wall -O2 -pipe -include global.h -I. -Iinclude
+CFLAGS =3D -g -Wall -O2
+INCLUDES =3D -include global.h -I. -Iinclude
=20
 OBJS =3D ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services=
.o y.tab.o lex.yy.o queue.o write.o checkpolicy.o
=20
@@ -16,13 +17,13 @@
 	$(CC) -o $@ $^ $(LIBS)
=20
 %.o: %.c=20
-	$(CC) $(CFLAGS) -o $@ -c $<
+	$(CC) $(CFLAGS) $(INCLUDES) -o $@ -c $<
=20
 y.tab.o: y.tab.c
-	$(CC) $(CFLAGS) -o $@ -c $<
+	$(CC) $(CFLAGS) $(INCLUDES) -o $@ -c $<
=20
 lex.yy.o: lex.yy.c
-	$(CC) $(CFLAGS) -o $@ -c $<
+	$(CC) $(CFLAGS) $(INCLUDES) -o $@ -c $<
=20
 y.tab.c: policy_parse.y
 	$(YACC) -d policy_parse.y

--=-msKd4DvGPXb8S7UegmOY
Content-Disposition: attachment; filename=libselinux-buildfixes.patch
Content-Type: text/plain; name=libselinux-buildfixes.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- utils/Makefile~	2003-06-12 15:31:47.000000000 -0400
+++ utils/Makefile	2003-07-03 17:26:44.000000000 -0400
@@ -2,7 +2,8 @@
 PREFIX ?=3D $(DESTDIR)/usr
 BINDIR ?=3D $(PREFIX)/bin
=20
-CFLAGS +=3D -Wall -I../include
+CFLAGS =3D -Wall
+override CFLAGS +=3D -I../include
 LDLIBS +=3D -L../src -lselinux -lattr
=20
 TARGETS=3D$(patsubst %.c,%,$(wildcard *.c))
--- src/Makefile~	2003-06-09 15:22:57.000000000 -0400
+++ src/Makefile	2003-07-03 17:45:32.000000000 -0400
@@ -9,7 +9,8 @@
 TARGET=3Dlibselinux.so
 LIBSO=3D$(TARGET).$(LIBVERSION)
 OBJS=3D $(patsubst %.c,%.o,$(wildcard *.c))
-CFLAGS =3D -fPIC -Wall -I../include=20
+CFLAGS =3D -Wall
+override CFLAGS +=3D -fPIC -I../include=20
=20
 all: $(LIBA) $(LIBSO)
=20
@@ -29,7 +30,6 @@
 	install -m 644 -o root -g root $(LIBA) $(LIBDIR)
 	install -m 755 -o root -g root $(LIBSO) $(LIBDIR)
 	cd $(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
-	/sbin/ldconfig
=20
 clean:=20
 	rm -f $(OBJS) $(LIBA) $(LIBSO) $(TARGET)=20

--=-msKd4DvGPXb8S7UegmOY
Content-Disposition: attachment; filename=newrole-includes.patch
Content-Type: text/plain; name=newrole-includes.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- newrole/newrole.c~	2003-06-13 10:15:54.000000000 -0400
+++ newrole/newrole.c	2003-07-03 18:08:15.000000000 -0400
@@ -57,6 +57,7 @@
 #include <getopt.h>               /* for getopt_long() form of getopt() */
 #include <fcntl.h>
 #include <string.h>
+#include <errno.h>
 #include <selinux/selinux.h>      /* for is_selinux_enabled() */
 #include <selinux/flask.h>        /* for SECCLASS_CHR_FILE */
 #include <selinux/context.h>      /* for context-mangling functions */

--=-msKd4DvGPXb8S7UegmOY
Content-Disposition: attachment; filename=newrole-makefile.patch
Content-Type: text/x-makefile; name=newrole-makefile.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- newrole/Makefile~	2003-06-19 15:33:12.000000000 -0400
+++ newrole/Makefile	2003-07-03 18:09:29.000000000 -0400
@@ -4,7 +4,8 @@
 MANDIR ?=3D $(PREFIX)/share/man
 ETCDIR ?=3D $(DESTDIR)/etc
=20
-CFLAGS +=3D -Wall -DUSE_PAM
+CFLAGS =3D -Wall=20
+override CFLAGS +=3D -DUSE_PAM
 LDLIBS +=3D -lselinux -lattr -ldl -lpam -lpam_misc
=20
 TARGETS=3D$(patsubst %.c,%,$(wildcard *.c))
@@ -13,6 +14,7 @@
=20
 install: all
 	test -d $(BINDIR)      || install -m 755 -o root -g root -d $(BINDIR)
+	test -d $(ETCDIR)/pam.d || install -m 755 -o root -g root -d $(ETCDIR)/pa=
m.d
 	test -d $(MANDIR)/man1 || install -m 755 -o root -g root -d $(MANDIR)/man=
1
 	install -m 555 -o root -g root newrole $(BINDIR)
 	install -m 644 -o root -g root newrole.1 $(MANDIR)/man1/

--=-msKd4DvGPXb8S7UegmOY
Content-Disposition: attachment; filename=policycoreutils-cflags.patch
Content-Type: text/plain; name=policycoreutils-cflags.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- load_policy/Makefile~	2003-06-03 16:50:56.000000000 -0400
+++ load_policy/Makefile	2003-07-03 17:51:02.000000000 -0400
@@ -2,7 +2,7 @@
 PREFIX ?=3D ${DESTDIR}/usr
 SBINDIR ?=3D $(PREFIX)/sbin
=20
-CFLAGS +=3D -Wall=20
+CFLAGS =3D -Wall=20
 LDLIBS +=3D -lselinux
=20
 # Build static so that we can put it on an initrd.
--- run_init/Makefile~	2003-06-19 15:36:02.000000000 -0400
+++ run_init/Makefile	2003-07-03 17:51:20.000000000 -0400
@@ -4,7 +4,8 @@
 MANDIR ?=3D $(PREFIX)/share/man
 ETCDIR ?=3D $(DESTDIR)/etc
=20
-CFLAGS +=3D -Wall -DUSE_PAM
+CFLAGS =3D -Wall
+override CFLAGS +=3D -DUSE_PAM
 LDLIBS +=3D -lselinux -lattr -ldl -lpam -lpam_misc
=20
 TARGETS=3D$(patsubst %.c,%,$(wildcard *.c))
--- setfiles/Makefile~	2003-06-19 15:33:14.000000000 -0400
+++ setfiles/Makefile	2003-07-03 17:51:50.000000000 -0400
@@ -3,7 +3,8 @@
 SBINDIR ?=3D $(PREFIX)/sbin
 MANDIR =3D $(PREFIX)/share/man
=20
-CFLAGS +=3D -Wall -D_FILE_OFFSET_BITS=3D64
+CFLAGS =3D -Wall
+override CFLAGS +=3D -D_FILE_OFFSET_BITS=3D64
 LDLIBS +=3D -lselinux -lattr
=20
 all: setfiles

--=-msKd4DvGPXb8S7UegmOY--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
