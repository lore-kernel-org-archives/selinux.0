Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4ACk2P9015840
	for <selinux@tycho.nsa.gov>; Fri, 10 May 2013 08:46:04 -0400
From: Laurent Bigonville <bigon@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: [PATCH 07/16] libselinux: Allow overriding LIBBASE in src/Makefile
Date: Fri, 10 May 2013 14:45:15 +0200
Message-Id: <1368189924-8501-8-git-send-email-bigon@debian.org>
In-Reply-To: <1368189924-8501-1-git-send-email-bigon@debian.org>
References: <1368189924-8501-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

---
 libselinux/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index c4f5d4c..2c29277 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -18,7 +18,7 @@ RUBYLIBVER ?= $(shell $(RUBY) -e 'print RUBY_VERSION.split(".")[0..1].join(".")'
 RUBYPLATFORM ?= $(shell $(RUBY) -e 'print RUBY_PLATFORM')
 RUBYINC ?= $(shell pkg-config --cflags ruby)
 RUBYINSTALL ?= $(LIBDIR)/ruby/site_ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
-LIBBASE=$(shell basename $(LIBDIR))
+LIBBASE ?= $(shell basename $(LIBDIR))
 
 LDFLAGS ?= -lpcre -lpthread
 
-- 
1.8.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
