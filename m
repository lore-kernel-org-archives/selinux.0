From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: is_selinux_enabled: Add /etc/selinux/config test.
Date: Mon, 11 May 2015 10:20:39 -0400
Message-Id: <1431354039-7523-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

To avoid regressions such as the one reported in:
https://bugzilla.redhat.com/show_bug.cgi?id=1219045
add a test for /etc/selinux/config to is_selinux_enabled().

This ensures that systems that do not install selinux-policy
will continue to return 0 from is_selinux_enabled().

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/enabled.c          | 4 ++++
 libselinux/src/init.c             | 5 +++++
 libselinux/src/selinux_config.c   | 2 --
 libselinux/src/selinux_internal.h | 5 +++++
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/enabled.c b/libselinux/src/enabled.c
index 1731ac3..bb659a9 100644
--- a/libselinux/src/enabled.c
+++ b/libselinux/src/enabled.c
@@ -14,7 +14,11 @@ int is_selinux_enabled(void)
 	/* init_selinuxmnt() gets called before this function. We
  	 * will assume that if a selinux file system is mounted, then
  	 * selinux is enabled. */
+#ifdef ANDROID
 	return (selinux_mnt ? 1 : 0);
+#else
+	return (selinux_mnt && has_selinux_config);
+#endif
 }
 
 hidden_def(is_selinux_enabled)
diff --git a/libselinux/src/init.c b/libselinux/src/init.c
index 179e0d0..3db4de0 100644
--- a/libselinux/src/init.c
+++ b/libselinux/src/init.c
@@ -22,6 +22,8 @@ char *selinux_mnt = NULL;
 int selinux_page_size = 0;
 int obj_class_compat = 1;
 
+int has_selinux_config = 0;
+
 /* Verify the mount point for selinux file system has a selinuxfs.
    If the file system:
    * Exist,
@@ -165,6 +167,9 @@ static void init_lib(void)
 {
 	selinux_page_size = sysconf(_SC_PAGE_SIZE);
 	init_selinuxmnt();
+#ifndef ANDROID
+	has_selinux_config = (access(SELINUXCONFIG, F_OK) == 0);
+#endif
 }
 
 static void fini_lib(void) __attribute__ ((destructor));
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 30e9dc7..0a80141 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -13,8 +13,6 @@
 #include "selinux_internal.h"
 #include "get_default_type_internal.h"
 
-#define SELINUXDIR "/etc/selinux/"
-#define SELINUXCONFIG SELINUXDIR "config"
 #define SELINUXDEFAULT "targeted"
 #define SELINUXTYPETAG "SELINUXTYPE="
 #define SELINUXTAG "SELINUX="
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index afb2170..0abf1b4 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -137,3 +137,8 @@ extern int selinux_page_size hidden;
 		if (pthread_setspecific != NULL)		\
 			pthread_setspecific(KEY, VALUE);	\
 	} while (0)
+
+#define SELINUXDIR "/etc/selinux/"
+#define SELINUXCONFIG SELINUXDIR "config"
+
+extern int has_selinux_config hidden;
-- 
2.1.0
