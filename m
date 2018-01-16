From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Tue, 16 Jan 2018 21:23:17 +0100
Message-Id: <20180116202327.23253-5-marcus.folkesson@gmail.com>
In-Reply-To: <20180116202327.23253-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180116202327.23253-1-marcus.folkesson@gmail.com>
Subject: [PATCH v2 04/14] checkpolicy: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch solves the following issues:
- DESTDIR is needed during compile time to compute library
  and header paths which it should not.
- Installing with both DESTDIR and PREFIX set gives us odd paths
- Make usage of DESTDIR and PREFIX more standard

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 checkpolicy/Makefile      | 9 ++++-----
 checkpolicy/test/Makefile | 7 +++----
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index 68e11f2a..0c341d02 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -1,11 +1,10 @@
 #
 # Makefile for building the checkpolicy program
 #
-PREFIX ?= $(DESTDIR)/usr
-BINDIR ?= $(PREFIX)/bin
-MANDIR ?= $(PREFIX)/share/man
-LIBDIR ?= $(PREFIX)/lib
-INCLUDEDIR ?= $(PREFIX)/include
+PREFIX ?= /usr
+BINDIR ?= $(DESTDIR)$(PREFIX)/bin
+MANDIR ?= $(DESTDIR)$(PREFIX)/share/man
+LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
 LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 TARGETS = checkpolicy checkmodule
 
diff --git a/checkpolicy/test/Makefile b/checkpolicy/test/Makefile
index 59fa4460..8f4393d2 100644
--- a/checkpolicy/test/Makefile
+++ b/checkpolicy/test/Makefile
@@ -1,10 +1,9 @@
 #
 # Makefile for building the dispol program
 #
-PREFIX ?= $(DESTDIR)/usr
-BINDIR ?= $(PREFIX)/bin
-LIBDIR ?= $(PREFIX)/lib
-INCLUDEDIR ?= $(PREFIX)/include
+PREFIX ?= /usr
+BINDIR ?= $(DESTDIR)$(PREFIX)/bin
+LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
 LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 
 CFLAGS ?= -g -Wall -W -Werror -O2 -pipe
-- 
2.15.1
