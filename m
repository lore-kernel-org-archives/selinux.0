From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Tue, 16 Jan 2018 21:23:18 +0100
Message-Id: <20180116202327.23253-6-marcus.folkesson@gmail.com>
In-Reply-To: <20180116202327.23253-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180116202327.23253-1-marcus.folkesson@gmail.com>
Subject: [PATCH v2 05/14] gui: build: follow standard semantics for
 DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 gui/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/gui/Makefile b/gui/Makefile
index cfe47405..5efd17d7 100644
--- a/gui/Makefile
+++ b/gui/Makefile
@@ -1,9 +1,9 @@
 # Installation directories.
-PREFIX ?= ${DESTDIR}/usr
-BINDIR ?= $(PREFIX)/bin
-SHAREDIR ?= $(PREFIX)/share/system-config-selinux
-DATADIR ?= $(PREFIX)/share
-MANDIR ?= $(PREFIX)/share/man
+PREFIX ?= /usr
+BINDIR ?= $(DESTDIR)$(PREFIX)/bin
+SHAREDIR ?= $(DESTDIR)$(PREFIX)/share/system-config-selinux
+DATADIR ?= $(DESTDIR)$(PREFIX)/share
+MANDIR ?= $(DESTDIR)$(PREFIX)/share/man
 
 TARGETS= \
 booleansPage.py \
-- 
2.15.1
