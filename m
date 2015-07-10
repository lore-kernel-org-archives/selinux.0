Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6AFsLgh010661
 for <selinux@tycho.nsa.gov>; Fri, 10 Jul 2015 11:54:22 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: Add const to selinux_opt for label backends.
Date: Fri, 10 Jul 2015 16:53:54 +0100
Message-Id: <1436543634-24498-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Change selabel_open and label backends to take a
'const struct selinux_opt' argument. This work has already
been done for the Android version components.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/include/selinux/label.h      |  3 ++-
 libselinux/man/man3/selabel_open.3      |  2 +-
 libselinux/src/label.c                  |  9 ++++++---
 libselinux/src/label_android_property.c |  4 ++--
 libselinux/src/label_db.c               |  5 +++--
 libselinux/src/label_file.c             |  7 ++++---
 libselinux/src/label_internal.h         | 21 +++++++++++++--------
 libselinux/src/label_media.c            |  7 ++++---
 libselinux/src/label_x.c                |  4 ++--
 9 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index 7a94a92..8d013d8 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -69,7 +69,8 @@ struct selabel_handle;
  * @errno set on failure.
  */
 struct selabel_handle *selabel_open(unsigned int backend,
-				    struct selinux_opt *opts, unsigned nopts);
+				    const struct selinux_opt *opts,
+				    unsigned nopts);
 
 /**
  * selabel_close - Close a labeling handle.
diff --git a/libselinux/man/man3/selabel_open.3 b/libselinux/man/man3/selabel_open.3
index 00f2828..405b6ec 100644
--- a/libselinux/man/man3/selabel_open.3
+++ b/libselinux/man/man3/selabel_open.3
@@ -12,7 +12,7 @@ selabel_open, selabel_close \- userspace SELinux labeling interface
 .sp
 .BI "struct selabel_handle *selabel_open(int " backend , 
 .in +\w'struct selabel_handle *selabel_open('u
-.BI "struct selinux_opt *" options ,
+.BI "const struct selinux_opt *" options ,
 .br
 .BI "unsigned " nopt ");"
 .in
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 759a3fa..adc0722 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -17,7 +17,8 @@
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 typedef int (*selabel_initfunc)(struct selabel_handle *rec,
-				struct selinux_opt *opts, unsigned nopts);
+				const struct selinux_opt *opts,
+				unsigned nopts);
 
 static selabel_initfunc initfuncs[] = {
 	&selabel_file_init,
@@ -128,7 +129,8 @@ err:
  * Validation functions
  */
 
-static inline int selabel_is_validate_set(struct selinux_opt *opts, unsigned n)
+static inline int selabel_is_validate_set(const struct selinux_opt *opts,
+					  unsigned n)
 {
 	while (n--)
 		if (opts[n].type == SELABEL_OPT_VALIDATE)
@@ -251,7 +253,8 @@ selabel_lookup_bm_common(struct selabel_handle *rec, int translating,
  */
 
 struct selabel_handle *selabel_open(unsigned int backend,
-				    struct selinux_opt *opts, unsigned nopts)
+				    const struct selinux_opt *opts,
+				    unsigned nopts)
 {
 	struct selabel_handle *rec = NULL;
 
diff --git a/libselinux/src/label_android_property.c b/libselinux/src/label_android_property.c
index cf1cd7b..4af9896 100644
--- a/libselinux/src/label_android_property.c
+++ b/libselinux/src/label_android_property.c
@@ -135,7 +135,7 @@ static int process_line(struct selabel_handle *rec,
 	return 0;
 }
 
-static int init(struct selabel_handle *rec, struct selinux_opt *opts,
+static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 		unsigned n)
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
@@ -278,7 +278,7 @@ static void stats(struct selabel_handle __attribute__((unused)) *rec)
 }
 
 int selabel_property_init(struct selabel_handle *rec,
-			  struct selinux_opt *opts,
+			  const struct selinux_opt *opts,
 			  unsigned nopts)
 {
 	struct saved_data *data;
diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
index 1b48735..6820ae3 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -234,7 +234,8 @@ db_stats(struct selabel_handle *rec)
  * selabel_open() handler
  */
 static catalog_t *
-db_init(struct selinux_opt *opts, unsigned nopts, struct selabel_handle *rec)
+db_init(const struct selinux_opt *opts, unsigned nopts,
+			    struct selabel_handle *rec)
 {
 	catalog_t      *catalog;
 	FILE	       *filp;
@@ -332,7 +333,7 @@ out_error:
  * Initialize selabel_handle and load the entries of specfile
  */
 int selabel_db_init(struct selabel_handle *rec,
-		    struct selinux_opt *opts, unsigned nopts)
+		    const struct selinux_opt *opts, unsigned nopts)
 {
 	rec->func_close = &db_close;
 	rec->func_lookup = &db_lookup;
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index b4ee15d..b927681 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -450,7 +450,7 @@ out:
 	return rc;
 }
 
-static int init(struct selabel_handle *rec, struct selinux_opt *opts,
+static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 		unsigned n)
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
@@ -759,8 +759,9 @@ static void stats(struct selabel_handle *rec)
 	}
 }
 
-int selabel_file_init(struct selabel_handle *rec, struct selinux_opt *opts,
-		      unsigned nopts)
+int selabel_file_init(struct selabel_handle *rec,
+				    const struct selinux_opt *opts,
+				    unsigned nopts)
 {
 	struct saved_data *data;
 
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 5300319..861eca1 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -17,16 +17,21 @@
 /*
  * Installed backends
  */
-int selabel_file_init(struct selabel_handle *rec, struct selinux_opt *opts,
-		      unsigned nopts) hidden;
-int selabel_media_init(struct selabel_handle *rec, struct selinux_opt *opts,
-		      unsigned nopts) hidden;
-int selabel_x_init(struct selabel_handle *rec, struct selinux_opt *opts,
-		   unsigned nopts) hidden;
+int selabel_file_init(struct selabel_handle *rec,
+			    const struct selinux_opt *opts,
+			    unsigned nopts) hidden;
+int selabel_media_init(struct selabel_handle *rec,
+			    const struct selinux_opt *opts,
+			    unsigned nopts) hidden;
+int selabel_x_init(struct selabel_handle *rec,
+			    const struct selinux_opt *opts,
+			    unsigned nopts) hidden;
 int selabel_db_init(struct selabel_handle *rec,
-		    struct selinux_opt *opts, unsigned nopts) hidden;
+			    const struct selinux_opt *opts,
+			    unsigned nopts) hidden;
 int selabel_property_init(struct selabel_handle *rec,
-			  struct selinux_opt *opts, unsigned nopts) hidden;
+			    const struct selinux_opt *opts,
+			    unsigned nopts) hidden;
 
 /*
  * Labeling internal structures
diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index a09486b..725d5bd 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -67,7 +67,7 @@ static int process_line(const char *path, char *line_buf, int pass,
 	return 0;
 }
 
-static int init(struct selabel_handle *rec, struct selinux_opt *opts,
+static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 		unsigned n)
 {
 	FILE *fp;
@@ -201,8 +201,9 @@ static void stats(struct selabel_handle *rec)
 		  data->nspec, total);
 }
 
-int selabel_media_init(struct selabel_handle *rec, struct selinux_opt *opts,
-		       unsigned nopts)
+int selabel_media_init(struct selabel_handle *rec,
+				    const struct selinux_opt *opts,
+				    unsigned nopts)
 {
 	struct saved_data *data;
 
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index 8435b76..3f2ee1c 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -94,7 +94,7 @@ static int process_line(const char *path, char *line_buf, int pass,
 	return 0;
 }
 
-static int init(struct selabel_handle *rec, struct selinux_opt *opts,
+static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 		unsigned n)
 {
 	FILE *fp;
@@ -227,7 +227,7 @@ static void stats(struct selabel_handle *rec)
 		  data->nspec, total);
 }
 
-int selabel_x_init(struct selabel_handle *rec, struct selinux_opt *opts,
+int selabel_x_init(struct selabel_handle *rec, const struct selinux_opt *opts,
 		   unsigned nopts)
 {
 	struct saved_data *data;
-- 
2.1.0
