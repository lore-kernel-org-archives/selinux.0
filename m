From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH 1/2] libselinux: introduce configurable backends
Date: Mon, 26 Sep 2016 10:33:38 -0700
Message-Id: <1474911219-20465-2-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1474911219-20465-1-git-send-email-william.c.roberts@intel.com>
References: <1474911219-20465-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

On Android for both the host build, and the target, certain
backends are not needed:
 - X Backend
 - DB Backend
 - Media Backend

Introduce the following defines for removing them from the
built library:

 - NO_X_BACKEND
 - NO_DB_BACKEND
 - NO_MEDIA_BACKEND

When configured with these options and an attempt
is made to use them, selabel_open() will return
ENOTSUP.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/label.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 963bfcb..96a4ff1 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -17,15 +17,33 @@
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
+#ifdef NO_MEDIA_BACKEND
+#define CONFIG_MEDIA_BACKEND(fnptr) NULL
+#else
+#define CONFIG_MEDIA_BACKEND(fnptr) &fnptr
+#endif
+
+#ifdef NO_X_BACKEND
+#define CONFIG_X_BACKEND(fnptr) NULL
+#else
+#define CONFIG_X_BACKEND(fnptr) &fnptr
+#endif
+
+#ifdef NO_DB_BACKEND
+#define CONFIG_DB_BACKEND(fnptr) NULL
+#else
+#define CONFIG_DB_BACKEND(fnptr) &fnptr
+#endif
+
 typedef int (*selabel_initfunc)(struct selabel_handle *rec,
 				const struct selinux_opt *opts,
 				unsigned nopts);
 
 static selabel_initfunc initfuncs[] = {
 	&selabel_file_init,
-	&selabel_media_init,
-	&selabel_x_init,
-	&selabel_db_init,
+	CONFIG_MEDIA_BACKEND(selabel_media_init),
+	CONFIG_X_BACKEND(selabel_x_init),
+	CONFIG_DB_BACKEND(selabel_db_init),
 	&selabel_property_init,
 };
 
@@ -325,6 +343,11 @@ struct selabel_handle *selabel_open(unsigned int backend,
 		goto out;
 	}
 
+	if (!initfuncs[backend]) {
+		errno = ENOTSUP;
+		goto out;
+	}
+
 	rec = (struct selabel_handle *)malloc(sizeof(*rec));
 	if (!rec)
 		goto out;
-- 
1.9.1
