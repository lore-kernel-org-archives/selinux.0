Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pBJGpas3011998
	for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2011 11:51:37 -0500
Received: from nm1-vm0.bt.bullet.mail.ukl.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id pBJGpZ0f013659
	for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2011 16:51:35 GMT
Message-ID: <1324313489.25277.YahooMailClassic@web87010.mail.ird.yahoo.com>
Date: Mon, 19 Dec 2011 16:51:29 +0000 (GMT)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/1] libselinux - correct selabel invalid context logging
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When selabel_lookup found an invalid context with validation enabled, it
always stated it was 'file_contexts' whether media, x, db or file.
The fix is to store the spec file name in the selabel_lookup_rec on
selabel_open and use this as output for logs. Also a minor fix if key is
NULL to stop seg faults.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/src/label.c          |    9 ++++++++-
 libselinux/src/label_db.c       |    5 +++--
 libselinux/src/label_file.c     |    1 +
 libselinux/src/label_internal.h |    6 ++++++
 libselinux/src/label_media.c    |    1 +
 libselinux/src/label_x.c        |    1 +
 libselinux/src/matchpathcon.c   |   11 ++++++++---
 7 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index f1c9a25..a9e0853 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -184,6 +184,12 @@ selabel_lookup_common(struct selabel_handle *rec, int translating,
 		      const char *key, int type)
 {
 	struct selabel_lookup_rec *lr;
+
+	if (key == NULL) {
+		errno = EINVAL;
+		return NULL;
+	}
+
 	char *ptr = selabel_sub(rec->subs, key);
 	if (ptr) {
 		lr = rec->func_lookup(rec, ptr, type); 
@@ -194,7 +200,7 @@ selabel_lookup_common(struct selabel_handle *rec, int translating,
 	if (!lr)
 		return NULL;
 
-	if (compat_validate(rec, lr, "file_contexts", 0))
+	if (compat_validate(rec, lr, rec->spec_file, 0))
 		return NULL;
 
 	if (translating && !lr->ctx_trans &&
@@ -234,6 +240,7 @@ void selabel_close(struct selabel_handle *rec)
 {
 	selabel_subs_fini(rec->subs);
 	rec->func_close(rec);
+	free(rec->spec_file);
 	free(rec);
 }
 
diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
index 7afacf0..ab0696a 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -230,7 +230,7 @@ db_stats(struct selabel_handle *rec)
  * selabel_open() handler
  */
 static catalog_t *
-db_init(struct selinux_opt *opts, unsigned nopts)
+db_init(struct selinux_opt *opts, unsigned nopts, struct selabel_handle *rec)
 {
 	catalog_t      *catalog;
 	FILE	       *filp;
@@ -275,6 +275,7 @@ db_init(struct selinux_opt *opts, unsigned nopts)
 		free(catalog);
 		return NULL;
 	}
+	rec->spec_file = strdup(path);
 
 	/*
 	 * Parse for each lines
@@ -332,7 +333,7 @@ int selabel_db_init(struct selabel_handle *rec,
 	rec->func_close = &db_close;
 	rec->func_lookup = &db_lookup;
 	rec->func_stats = &db_stats;
-	rec->data = db_init(opts, nopts);
+	rec->data = db_init(opts, nopts, rec);
 
 	return !rec->data ? -1 : 0;
 }
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index ac11b37..7bc46cc 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -462,6 +462,7 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 		if (localfp != NULL)
 			__fsetlocking(localfp, FSETLOCKING_BYCALLER);
 	}
+	rec->spec_file = strdup(path);
 
 	/* 
 	 * Perform two passes over the specification file.
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 02dbe73..79d5495 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -59,6 +59,12 @@ struct selabel_handle {
 	/* supports backend-specific state information */
 	void *data;
 
+	/*
+	 * The main spec file used. Note for file contexts the local and/or
+	 * homedirs could also have been used to resolve a context.
+	 */
+	char *spec_file;
+
 	/* substitution support */
 	struct selabel_sub *subs;
 };
diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index f8986e4..227785f 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -100,6 +100,7 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 		errno = EINVAL;
 		return -1;
 	}
+	rec->spec_file = strdup(path);
 
 	/* 
 	 * Perform two passes over the specification file.
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index a9bfaa5..896ef02 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -127,6 +127,7 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 		errno = EINVAL;
 		return -1;
 	}
+	rec->spec_file = strdup(path);
 
 	/* 
 	 * Perform two passes over the specification file.
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index c396add..48f7a11 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -531,9 +531,14 @@ int compat_validate(struct selabel_handle *rec,
 	else {
 		rc = selabel_validate(rec, contexts);
 		if (rc < 0) {
-			COMPAT_LOG(SELINUX_WARNING,
-				    "%s:  line %d has invalid context %s\n",
-				    path, lineno, *ctx);
+			if (lineno) {
+				COMPAT_LOG(SELINUX_WARNING,
+					    "%s: line %d has invalid context %s\n",
+						path, lineno, *ctx);
+			} else {
+				COMPAT_LOG(SELINUX_WARNING,
+					    "%s: has invalid context %s\n", path, *ctx);
+			}
 		}
 	}
 
-- 
1.7.7.1





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
