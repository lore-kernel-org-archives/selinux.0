Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9QM5122002439
 for <selinux@tycho.nsa.gov>; Wed, 26 Oct 2016 18:05:01 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id CF08A1A1A8
 for <selinux@tycho.nsa.gov>; Thu, 27 Oct 2016 00:04:33 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 1YX-9MaphyAs for <selinux@tycho.nsa.gov>;
 Thu, 27 Oct 2016 00:04:31 +0200 (CEST)
Received: from fornost.bigon.be (unknown
 [IPv6:2a02:a03f:6c:e500:edf:2fd8:fc0a:f176])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 0C2C41A06E
 for <selinux@tycho.nsa.gov>; Thu, 27 Oct 2016 00:04:31 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: Allow overriding libsepol.a location during build
Date: Thu, 27 Oct 2016 00:04:30 +0200
Message-Id: <20161026220430.2403-1-bigon@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

Signed-off-by: Laurent Bigonville <bigon@bigon.be>
---
 libselinux/src/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index c9f35b1..ae40f80 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -18,6 +18,7 @@ RUBYLIBVER ?= $(shell $(RUBY) -e 'print RUBY_VERSION.split(".")[0..1].join(".")'
 RUBYINC ?= $(shell $(PKG_CONFIG) --exists ruby-$(RUBYLIBVER) && $(PKG_CONFIG) --cflags ruby-$(RUBYLIBVER) || $(PKG_CONFIG) --cflags ruby)
 RUBYINSTALL ?= $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
 LIBBASE ?= $(shell basename $(LIBDIR))
+LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 
 VERSION = $(shell cat ../VERSION)
 LIBVERSION = 1
@@ -146,7 +147,7 @@ $(AUDIT2WHYLOBJ): audit2why.c
 	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
-	$(CC) $(CFLAGS) -shared -o $@ $^ -L. $(LDFLAGS) -lselinux $(LIBDIR)/libsepol.a -L$(LIBDIR)
+	$(CC) $(CFLAGS) -shared -o $@ $^ -L. $(LDFLAGS) -lselinux $(LIBSEPOLA) -L$(LIBDIR)
 
 %.o:  %.c policy.h
 	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
-- 
2.10.1
