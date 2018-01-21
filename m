From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sun, 21 Jan 2018 22:46:17 +0100
Message-Id: <20180121214617.8975-15-marcus.folkesson@gmail.com>
In-Reply-To: <20180121214617.8975-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180121214617.8975-1-marcus.folkesson@gmail.com>
Subject: [PATCH v3 14/14] build: add prefix for includes in top
 Makefile
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 6da7f7b7..6baea148 100644
--- a/Makefile
+++ b/Makefile
@@ -1,3 +1,4 @@
+PREFIX ?= /usr
 OPT_SUBDIRS ?= dbus gui mcstrans python restorecond sandbox semodule-utils
 SUBDIRS=libsepol libselinux libsemanage checkpolicy secilc policycoreutils $(OPT_SUBDIRS)
 PYSUBDIRS=libselinux libsemanage
@@ -19,8 +20,8 @@ else
 endif
 
 ifneq ($(DESTDIR),)
-	CFLAGS += -I$(DESTDIR)/usr/include
-	LDFLAGS += -L$(DESTDIR)/usr/lib
+	CFLAGS += -I$(DESTDIR)$(PREFIX)/include
+	LDFLAGS += -L$(DESTDIR)$(PREFIX)/lib
 	export CFLAGS
 	export LDFLAGS
 endif
-- 
2.15.1
