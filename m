From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sun, 21 Jan 2018 22:46:14 +0100
Message-Id: <20180121214617.8975-12-marcus.folkesson@gmail.com>
In-Reply-To: <20180121214617.8975-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180121214617.8975-1-marcus.folkesson@gmail.com>
Subject: [PATCH v3 11/14] secilc: build: follow standard semantics
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
