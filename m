Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RCsvNs021723
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 08:54:58 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RCnXpk004140
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 12:49:33 GMT
Message-Id: <200509271249.j8RCnfYs026088@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: [PATCH] semanage-functionality 11/17
Date: Tue, 27 Sep 2005 08:49:41 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_002E_01C5C340.665CD3D0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_002E_01C5C340.665CD3D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Makefile changes to build a shared libsemanage library.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_002E_01C5C340.665CD3D0
Content-Type: application/octet-stream;
	name="libsemanage_src_Makefile.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="libsemanage_src_Makefile.diff"

diff -purN -x .svn libsemanage/src/Makefile libsemanage/src/Makefile=0A=
--- libsemanage/src/Makefile	2005-09-26 14:02:40.000000000 -0400=0A=
+++ libsemanage/src/Makefile	2005-09-19 09:11:07.000000000 -0400=0A=
@@ -4,7 +4,12 @@ LIBDIR ?=3D $(PREFIX)/lib=0A=
 SHLIBDIR ?=3D $(DESTDIR)/lib=0A=
 INCLUDEDIR ?=3D $(PREFIX)/include=0A=
 =0A=
-DEFAULT_SEMOD_CONF_LOCATION=3D/usr/share/semod/semod.conf=0A=
+DEFAULT_SEMANAGE_CONF_LOCATION=3D$(PREFIX)/share/semanage/semanage.conf=0A=
+=0A=
+ifeq ($(DEBUG),1)=0A=
+	export CFLAGS =3D -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow=0A=
+	export LDFLAGS =3D -g=0A=
+endif=0A=
 =0A=
 LEX =3D flex=0A=
 LFLAGS =3D -s=0A=
@@ -13,19 +18,26 @@ YFLAGS =3D -d=0A=
 =0A=
 LIBVERSION =3D 1=0A=
 =0A=
-LIBA=3Dlibsemanage.a =0A=
+LIBA=3Dlibsemanage.a=0A=
+TARGET=3Dlibsemanage.so=0A=
+LIBSO=3D$(TARGET).$(LIBVERSION)=0A=
 OBJS=3D $(patsubst %.c,%.o,$(wildcard *.c)) conf-scan.o conf-parse.o=0A=
+LOBJS=3D $(patsubst %.c,%.lo,$(wildcard *.c)) conf-scan.lo conf-parse.lo=0A=
 CFLAGS ?=3D -Wall -W -Wundef -Wmissing-noreturn =
-Wmissing-format-attribute=0A=
 =0A=
-override CFLAGS +=3D -I. -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE \=0A=
+override CFLAGS +=3D -Iinclude -I../include -I$(INCLUDEDIR) =
-D_GNU_SOURCE \=0A=
                    =
-DDEFAULT_SEMOD_CONF_LOCATION=3D'"$(DEFAULT_SEMOD_CONF_LOCATION)"'=0A=
 =0A=
-all: $(LIBA)=0A=
+all: $(LIBA) $(LIBSO)=0A=
 =0A=
 $(LIBA): $(OBJS)=0A=
 	$(AR) rcs $@ $^=0A=
 	ranlib $@=0A=
 =0A=
+$(LIBSO): $(LOBJS)=0A=
+	$(CC) $(LDFLAGS) -shared -o $@ $^ -Wl,-soname,$(LIBSO)=0A=
+	ln -sf $@ $(TARGET)=0A=
+=0A=
 conf-scan.c: conf-scan.l conf-parse.h=0A=
 	$(LEX) $(LFLAGS) -t $< > $@=0A=
 =0A=
@@ -37,11 +49,18 @@ conf-parse.h: conf-parse.c=0A=
 %.o:  %.c =0A=
 	$(CC) $(CFLAGS) -c -o $@ $<=0A=
 =0A=
+%.lo:  %.c=0A=
+	$(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<=0A=
+=0A=
 install: all=0A=
 	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)=0A=
 	install -m 644 $(LIBA) $(LIBDIR)=0A=
-	install -m 644 -D semod.conf $(DESTDIR)/$(DEFAULT_SEMOD_CONF_LOCATION)=0A=
+	test -d $(SHLIBDIR) || install -m 755 -d $(SHLIBDIR)=0A=
+	install -m 755 $(LIBSO) $(SHLIBDIR)=0A=
+	install -m 644 -D semanage.conf $(DEFAULT_SEMANAGE_CONF_LOCATION)=0A=
+	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)=0A=
 =0A=
 clean: =0A=
-	rm -f $(OBJS) $(LIBA) conf-scan.c conf-parse.c conf-parse.h=0A=
+	rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) conf-parse.c =
conf-parse.h conf-scan.c=0A=
 =0A=
+.PHONY: clean=0A=

------=_NextPart_000_002E_01C5C340.665CD3D0--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
