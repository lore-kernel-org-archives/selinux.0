From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 24 Jan 2018 10:27:33 +0100
Message-Id: <20180124092736.8432-13-marcus.folkesson@gmail.com>
In-Reply-To: <20180124092736.8432-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180124092736.8432-1-marcus.folkesson@gmail.com>
Subject: [PATCH v4 12/15] secilc: build: follow standard semantics
 for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 secilc/Makefile | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/secilc/Makefile b/secilc/Makefile
index 1cac53e4..5b0a4852 100644
--- a/secilc/Makefile
+++ b/secilc/Makefile
@@ -1,8 +1,6 @@
-PREFIX ?= $(DESTDIR)/usr
-BINDIR ?= $(PREFIX)/bin
-MANDIR ?= $(PREFIX)/share/man
-LIBDIR ?= $(PREFIX)/lib
-INCLUDEDIR ?= $(PREFIX)/include
+PREFIX ?= /usr
+BINDIR ?= $(DESTDIR)$(PREFIX)/bin
+MANDIR ?= $(DESTDIR)$(PREFIX)/share/man
 
 SECILC = secilc
 SECILC_SRCS := secilc.c
-- 
2.15.1
