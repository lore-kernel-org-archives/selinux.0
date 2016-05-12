Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4CKdiWq004693
 for <selinux@tycho.nsa.gov>; Thu, 12 May 2016 16:39:44 -0400
From: Julien Pivotto <roidelapluie@inuits.eu>
To: cpebenito@tresys.com, setools@tresys.com, selinux@tycho.nsa.gov
Subject: [PATCH] libqpol: Make Makefile AR overwritable
Date: Thu, 12 May 2016 22:39:22 +0200
Message-Id: <1463085562-25824-1-git-send-email-roidelapluie@inuits.eu>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 configure.ac            | 2 ++
 libqpol/src/Makefile.am | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index ae20da7..8de2b7e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -73,6 +73,8 @@ AC_C_BIGENDIAN
 AC_CHECK_FUNCS(rand_r)
 AC_SYS_LARGEFILE
 
+AC_CHECK_TOOL([AR], [ar])
+
 AC_CACHE_SAVE
 
 if test "x${enable_shared}" = xyes; then
diff --git a/libqpol/src/Makefile.am b/libqpol/src/Makefile.am
index 77213f4..61ed495 100644
--- a/libqpol/src/Makefile.am
+++ b/libqpol/src/Makefile.am
@@ -67,7 +67,7 @@ $(tmp_sepol): $(sepol_srcdir)/libsepol.a
 	mkdir -p $@
 	rm -f $@/*
 	cp $< $@
-	(cd $@; ar x libsepol.a)
+	(cd $@; $(AR) x libsepol.a)
 
 $(qpolso_DATA): $(tmp_sepol) $(libqpol_so_OBJS) libqpol.map
 	$(CC) -shared -o $@ $(libqpol_so_OBJS) $(AM_LDFLAGS) $(LDFLAGS) -Wl,-soname,$(LIBQPOL_SONAME),--version-script=$(srcdir)/libqpol.map,-z,defs -Wl,--whole-archive $(sepol_srcdir)/libsepol.a -Wl,--no-whole-archive @SELINUX_LIB_FLAG@ -lselinux -lsepol -lbz2
-- 
2.6.1
