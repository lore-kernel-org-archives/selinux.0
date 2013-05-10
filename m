Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4ACk3no015860
	for <selinux@tycho.nsa.gov>; Fri, 10 May 2013 08:46:03 -0400
From: Laurent Bigonville <bigon@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: [PATCH 03/16] policycoreutils: Allow overriding CFLAGS in setfiles and sestatus Makefiles
Date: Fri, 10 May 2013 14:45:11 +0200
Message-Id: <1368189924-8501-4-git-send-email-bigon@debian.org>
In-Reply-To: <1368189924-8501-1-git-send-email-bigon@debian.org>
References: <1368189924-8501-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Simon Ruderich <simon@ruderich.org>

This is required to be able to pass hardening flags in Debian.
---
 policycoreutils/sestatus/Makefile | 2 +-
 policycoreutils/setfiles/Makefile | 2 +-
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
1.8.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
