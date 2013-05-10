Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4ACk2PB015840
	for <selinux@tycho.nsa.gov>; Fri, 10 May 2013 08:46:05 -0400
From: Laurent Bigonville <bigon@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: [PATCH 08/16] libselinux: Do not use LDFLAGS to set -lpcre and -lpthread
Date: Fri, 10 May 2013 14:45:16 +0200
Message-Id: <1368189924-8501-9-git-send-email-bigon@debian.org>
In-Reply-To: <1368189924-8501-1-git-send-email-bigon@debian.org>
References: <1368189924-8501-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

This is breaking build if LDFLAGS is redefined.

This is the case on Debian where hardening flags are passed
automatically by the build system.
---
 libselinux/src/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 2c29277..8f557a1 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -20,8 +20,6 @@ RUBYINC ?= $(shell pkg-config --cflags ruby)
 RUBYINSTALL ?= $(LIBDIR)/ruby/site_ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
 LIBBASE ?= $(shell basename $(LIBDIR))
 
-LDFLAGS ?= -lpcre -lpthread
-
 VERSION = $(shell cat ../VERSION)
 LIBVERSION = 1
 
@@ -116,7 +114,7 @@ $(LIBA): $(OBJS)
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) -shared -o $@ $^ -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
+	$(CC) $(CFLAGS) -shared -o $@ $^ -lpcre -lpthread -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
 	ln -sf $@ $(TARGET) 
 
 $(LIBPC): $(LIBPC).in ../VERSION
-- 
1.8.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
