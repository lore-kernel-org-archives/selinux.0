Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KLJdWt023120
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 17:19:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9KLJR0p008437
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 21:19:27 GMT
Received: from extern.mail.waldi.eu.org (wavehammer.waldi.eu.org [82.139.196.55])
	by jazzswing.ncsc.mil  with ESMTP id h9KLJQr7008429
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 21:19:26 GMT
Date: Mon, 20 Oct 2003 23:19:31 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux-1
Message-ID: <20031020211931.GA2179@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi folks

this patch fixes following problems:
- Build static lib with non-PIC files
files: src/Makefile

bastian

-- 
The heart is not a logical organ.
		-- Dr. Janet Wallace, "The Deadly Years", stardate 3479.4

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=libselinux-1

Index: src/Makefile
===================================================================
--- src/Makefile	(.../upstream/current/libselinux)	(revision 21)
+++ src/Makefile	(.../trunk/libselinux)	(revision 21)
@@ -9,8 +9,9 @@
 TARGET=libselinux.so
 LIBSO=$(TARGET).$(LIBVERSION)
 OBJS= $(patsubst %.c,%.o,$(wildcard *.c))
+LOBJS= $(patsubst %.c,%.lo,$(wildcard *.c))
 CFLAGS = -Wall
-override CFLAGS += -fPIC -I../include 
+override CFLAGS += -I../include 
 
 all: $(LIBA) $(LIBSO)
 
@@ -18,13 +19,16 @@
 	$(AR) rcs $@ $^
 	ranlib $@
 
-$(LIBSO): $(OBJS)
+$(LIBSO): $(LOBJS)
 	$(CC) $(LDFLAGS) -shared -o $@ $^ -lattr -Wl,-soname,$(LIBSO) 
 	ln -sf $@ $(TARGET) 
 
 %.o:  %.c
 	$(CC) -o $@ -c $(CFLAGS) $<
 
+%.lo:  %.c
+	$(CC) -o $@ -c -fPIC $(CFLAGS) $<
+
 install: all
 	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)
 	install -m 644 $(LIBA) $(LIBDIR)
@@ -32,5 +36,5 @@
 	cd $(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
 
 clean: 
-	rm -f $(OBJS) $(LIBA) $(LIBSO) $(TARGET) 
+	rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) 
 

--r5Pyd7+fXNt84Ff3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
