Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q91GWube017392
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2012 12:32:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 17B741AAEE
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:18 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cLxvRHxIZg5Z for <selinux@tycho.nsa.gov>;
	Mon,  1 Oct 2012 18:32:16 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id CF5F11A095
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:15 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 03/15] policycoreutils: Allow overriding CFLAGS in setfiles and sestatus Makefiles
Date: Mon,  1 Oct 2012 18:31:45 +0200
Message-Id: <1349109117-593-4-git-send-email-bigon@debian.org>
In-Reply-To: <1349109117-593-1-git-send-email-bigon@debian.org>
References: <1349109117-593-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Simon Ruderich <simon@ruderich.org>

This is required to be able to pass hardening flags in Debian.
---
 policycoreutils/sestatus/Makefile |    2 +-
 policycoreutils/setfiles/Makefile |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/Makefile
index c5db7a3..c04ff00 100644
--- a/policycoreutils/sestatus/Makefile
+++ b/policycoreutils/sestatus/Makefile
@@ -5,7 +5,7 @@ MANDIR = $(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
 LIBDIR ?= $(PREFIX)/lib
 
-CFLAGS = -Werror -Wall -W
+CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
 LDLIBS = -lselinux -L$(LIBDIR)
 
diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles/Makefile
index 4b44b3c..98f4f7d 100644
--- a/policycoreutils/setfiles/Makefile
+++ b/policycoreutils/setfiles/Makefile
@@ -8,7 +8,7 @@ AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 PROGRESS_STEP=$(shell grep "^\#define STAR_COUNT" restore.h | awk -S '{ print $$3 }')
 ABORT_ON_ERRORS=$(shell grep "^\#define ABORT_ON_ERRORS" setfiles.c | awk -S '{ print $$3 }')
 
-CFLAGS = -g -Werror -Wall -W
+CFLAGS ?= -g -Werror -Wall -W
 override CFLAGS += -I$(PREFIX)/include
 LDLIBS = -lselinux -lsepol -L$(LIBDIR)
 
-- 
1.7.10.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
