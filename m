From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 14 Feb 2018 10:57:17 +0100
Message-Id: <20180214095717.1050-16-marcus.folkesson@gmail.com>
In-Reply-To: <20180214095717.1050-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180214095717.1050-1-marcus.folkesson@gmail.com>
Subject: [PATCH v5 15/15] build: setup buildpaths if DESTDIR is
 specified
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v4:
    	- add LIBDIR to LDFLAGS if DESTDIR is specified
    	- export LIBSEPOLA  if DESTDIR is specified
    
    v3:
    	- Add default prefix

 Makefile | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 6da7f7b7..c238dbc8 100644
--- a/Makefile
+++ b/Makefile
@@ -1,3 +1,4 @@
+PREFIX ?= /usr
 OPT_SUBDIRS ?= dbus gui mcstrans python restorecond sandbox semodule-utils
 SUBDIRS=libsepol libselinux libsemanage checkpolicy secilc policycoreutils $(OPT_SUBDIRS)
 PYSUBDIRS=libselinux libsemanage
@@ -19,10 +20,14 @@ else
 endif
 
 ifneq ($(DESTDIR),)
-	CFLAGS += -I$(DESTDIR)/usr/include
-	LDFLAGS += -L$(DESTDIR)/usr/lib
+	LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
+	LIBSEPOLA ?= $(LIBDIR)/libsepol.a
+
+	CFLAGS += -I$(DESTDIR)$(PREFIX)/include
+	LDFLAGS += -L$(DESTDIR)$(PREFIX)/lib -L$(LIBDIR)
 	export CFLAGS
 	export LDFLAGS
+	export LIBSEPOLA
 endif
 
 all install relabel clean test indent:
-- 
2.15.1
