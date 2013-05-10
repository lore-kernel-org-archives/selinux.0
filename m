Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4ACk3np015860
	for <selinux@tycho.nsa.gov>; Fri, 10 May 2013 08:46:04 -0400
From: Laurent Bigonville <bigon@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: [PATCH 05/16] libsepol: Allow overriding LIBBASE in src/Makefile
Date: Fri, 10 May 2013 14:45:13 +0200
Message-Id: <1368189924-8501-6-git-send-email-bigon@debian.org>
In-Reply-To: <1368189924-8501-1-git-send-email-bigon@debian.org>
References: <1368189924-8501-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

---
 libsepol/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index cd8e767..79de6dc 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -3,7 +3,7 @@ PREFIX ?= $(DESTDIR)/usr
 INCLUDEDIR ?= $(PREFIX)/include
 LIBDIR ?= $(PREFIX)/lib
 SHLIBDIR ?= $(DESTDIR)/lib
-LIBBASE=$(shell basename $(LIBDIR))
+LIBBASE ?= $(shell basename $(LIBDIR))
 
 VERSION = $(shell cat ../VERSION)
 LIBVERSION = 1
-- 
1.8.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
