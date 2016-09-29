Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8TBeAUx026602
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 07:40:11 -0400
Received: by mail-wm0-f41.google.com with SMTP id b4so22267912wmb.0
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 04:39:28 -0700 (PDT)
From: Janis Danisevskis <jdanis@android.com>
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov,
 jwcart2@tycho.nsa.gov
Cc: Janis Danisevskis <jdanis@android.com>
Subject: [PATCH 3/3] libselinux: makes android label back ends configurable
Date: Thu, 29 Sep 2016 12:39:19 +0100
Message-Id: <1475149159-21757-3-git-send-email-jdanis@android.com>
In-Reply-To: <1475149159-21757-1-git-send-email-jdanis@android.com>
References: <1475149159-21757-1-git-send-email-jdanis@android.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Android label back ends are not configurable by NO_ANDROID_BACKEND,
which is set if on ANDROID_HOST != y.

Signed-off-by: Janis Danisevskis <jdanis@android.com>
---
 libselinux/src/Makefile |  3 +++
 libselinux/src/label.c  | 10 ++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index cba8383..7169230 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -87,6 +87,9 @@ DISABLE_FLAGS+= -DNO_MEDIA_BACKEND -DNO_DB_BACKEND -DNO_X_BACKEND \
 SRCS= callbacks.c freecon.c label.c label_file.c \
 	label_backends_android.c regex.c label_support.c \
 	matchpathcon.c setrans_client.c sha1.c
+else
+DISABLE_FLAGS+= -DNO_ANDROID_BACKEND
+SRCS:= $(filter-out label_backends_android.c, $(SRCS))
 endif
 
 SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./ $(DISABLE_FLAGS)
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index eb0e766..60639cf 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -35,6 +35,12 @@
 #define CONFIG_DB_BACKEND(fnptr) &fnptr
 #endif
 
+#ifdef NO_ANDROID_BACKEND
+#define CONFIG_ANDROID_BACKEND(fnptr) NULL
+#else
+#define CONFIG_ANDROID_BACKEND(fnptr) (&(fnptr))
+#endif
+
 typedef int (*selabel_initfunc)(struct selabel_handle *rec,
 				const struct selinux_opt *opts,
 				unsigned nopts);
@@ -44,8 +50,8 @@ static selabel_initfunc initfuncs[] = {
 	CONFIG_MEDIA_BACKEND(selabel_media_init),
 	CONFIG_X_BACKEND(selabel_x_init),
 	CONFIG_DB_BACKEND(selabel_db_init),
-	&selabel_property_init,
-	&selabel_service_init,
+	CONFIG_ANDROID_BACKEND(selabel_property_init),
+	CONFIG_ANDROID_BACKEND(selabel_service_init),
 };
 
 static void selabel_subs_fini(struct selabel_sub *ptr)
-- 
1.9.1
