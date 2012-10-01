Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q91GWubj017392
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2012 12:33:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id C27071AAD9
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:32 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xPPMKyWKNdL4 for <selinux@tycho.nsa.gov>;
	Mon,  1 Oct 2012 18:32:31 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id B44261A095
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:30 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 09/15] libselinux: Do not use LDFLAGS to set -lpcre
Date: Mon,  1 Oct 2012 18:31:51 +0200
Message-Id: <1349109117-593-10-git-send-email-bigon@debian.org>
In-Reply-To: <1349109117-593-1-git-send-email-bigon@debian.org>
References: <1349109117-593-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

This is breaking build if LDFLAGS is redefined.

This is the case on Debian where hardening flags are passed
automatically by the build system.
---
 libselinux/src/Makefile |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 7fe4207..9287658 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -20,8 +20,6 @@ RUBYINC ?= $(shell pkg-config --cflags ruby-$(RUBYLIBVER))
 RUBYINSTALL ?= $(LIBDIR)/ruby/site_ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
 LIBBASE ?= $(shell basename $(LIBDIR))
 
-LDFLAGS ?= -lpcre
-
 VERSION = $(shell cat ../VERSION)
 LIBVERSION = 1
 
@@ -116,7 +114,7 @@ $(LIBA): $(OBJS)
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -ldl -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lpcre -ldl -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
 	ln -sf $@ $(TARGET) 
 
 $(LIBPC): $(LIBPC).in ../VERSION
-- 
1.7.10.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
