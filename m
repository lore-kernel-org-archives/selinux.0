Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBAHS2Q4019654
 for <selinux@tycho.nsa.gov>; Thu, 10 Dec 2015 12:28:02 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 by mx1.redhat.com (Postfix) with ESMTPS id BC7E28C1A5
 for <selinux@tycho.nsa.gov>; Thu, 10 Dec 2015 17:27:56 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: Don't wrap rpm_execcon with DISABLE_RPM
Date: Thu, 10 Dec 2015 18:27:48 +0100
Message-Id: <1449768468-16765-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

a2737333 commit introduced a possibility to build libselinux without
rpm_execcon() when DISABLE_RPM is set. However, it didn't cover SWIG
bindings. With this commit the rpm_execcon() bindings are not created.

Fixes:
ImportError: /usr/lib64/python3.5/site-packages/selinux/_selinux.so: undefined symbol: rpm_execcon
Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/include/selinux/selinux.h | 2 ++
 libselinux/src/Makefile              | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 4beb170..2262086 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -601,10 +601,12 @@ void fini_selinuxmnt(void);
  * program, falling back to a new context with the specified type. */
 extern int setexecfilecon(const char *filename, const char *fallback_type);
 
+#ifndef DISABLE_RPM
 /* Execute a helper for rpm in an appropriate security context. */
 extern int rpm_execcon(unsigned int verified,
 		       const char *filename,
 		       char *const argv[], char *const envp[]);
+#endif
 
 /* Returns whether a file context is customizable, and should not 
    be relabeled . */
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index feab561..79d50d2 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -85,9 +85,9 @@ ifneq (,$(filter i386,$(ARCH)))
 TLSFLAGS += -mno-tls-direct-seg-refs
 endif
 
-SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
+SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./ $(EMFLAGS)
 
-SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./
+SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(EMFLAGS)
 
 all: $(LIBA) $(LIBSO) $(LIBPC)
 
-- 
2.6.3
