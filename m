Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8PHb2om012481
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2013 13:37:02 -0400
Received: by mail-wi0-f181.google.com with SMTP id ex4so5955929wid.2
        for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2013 10:37:00 -0700 (PDT)
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] Support user-provided RANLIB
Date: Wed, 25 Sep 2013 19:36:42 +0200
Message-Id: <1380130602-29843-1-git-send-email-sven.vermeulen@siphos.be>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>
---
 libsepol/src/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index cd8e767..9b1f260 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -3,6 +3,7 @@ PREFIX ?= $(DESTDIR)/usr
 INCLUDEDIR ?= $(PREFIX)/include
 LIBDIR ?= $(PREFIX)/lib
 SHLIBDIR ?= $(DESTDIR)/lib
+RANLIB ?= ranlib
 LIBBASE=$(shell basename $(LIBDIR))
 
 VERSION = $(shell cat ../VERSION)
@@ -21,7 +22,7 @@ all: $(LIBA) $(LIBSO) $(LIBPC)
 
 $(LIBA):  $(OBJS)
 	$(AR) rcs $@ $^
-	ranlib $@
+	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
 	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -Wl,-soname,$(LIBSO),--version-script=libsepol.map,-z,defs
-- 
1.8.1.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
