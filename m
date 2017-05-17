Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4HKr0aO023924
 for <selinux@tycho.nsa.gov>; Wed, 17 May 2017 16:53:00 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 82915564753
 for <selinux@tycho.nsa.gov>; Wed, 17 May 2017 22:52:22 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libselinux: rework selabel_subs_init() to avoid
 use-after-free
Date: Wed, 17 May 2017 22:51:45 +0200
Message-Id: <20170517205146.18315-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In selabel_subs_init(), when digest_add_specfile() fails, the returned
value is a pointer to data which has been freed (because label "err"
frees variable "sub" which is equals to the returned variable, "list").

Moreover since since commit fd56c5230cea ("Separate out the calling of
local subs and dist subs in selabel_sub"), argument "list" of
selabel_subs_init() has always been NULL (rec->subs and rec->dist_subs
are both initialized to NULL in selabel_open() before
selabel_file_init() is called).

Drop selabel_file_init()'s "list" argument and free all the list items
which have been allocated in this function, when the code encounters an
error.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/label.c          | 14 +++++++++++---
 libselinux/src/label_file.c     | 10 ++++------
 libselinux/src/label_internal.h |  1 -
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 71a273bdeb2a..70f6809ead2f 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -92,12 +92,11 @@ static char *selabel_sub(struct selabel_sub *ptr, const char *src)
 }
 
 struct selabel_sub *selabel_subs_init(const char *path,
-					    struct selabel_sub *list,
-					    struct selabel_digest *digest)
+				      struct selabel_digest *digest)
 {
 	char buf[1024];
 	FILE *cfg = fopen(path, "re");
-	struct selabel_sub *sub = NULL;
+	struct selabel_sub *list = NULL, *sub = NULL;
 	struct stat sb;
 
 	if (!cfg)
@@ -146,6 +145,7 @@ struct selabel_sub *selabel_subs_init(const char *path,
 		sub->slen = strlen(src);
 		sub->next = list;
 		list = sub;
+		sub = NULL;
 	}
 
 	if (digest_add_specfile(digest, cfg, NULL, sb.st_size, path) < 0)
@@ -158,6 +158,14 @@ err:
 	if (sub)
 		free(sub->src);
 	free(sub);
+	while (list) {
+		sub = list->next;
+		free(list->src);
+		free(list->dst);
+		free(list);
+		list = sub;
+	}
+	list = NULL;
 	goto out;
 }
 
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 0d4029bb3670..3ff759032cc1 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -589,17 +589,15 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	if (!path) {
 		rec->dist_subs =
 		    selabel_subs_init(selinux_file_context_subs_dist_path(),
-		    rec->dist_subs, rec->digest);
+		    rec->digest);
 		rec->subs = selabel_subs_init(selinux_file_context_subs_path(),
-		    rec->subs, rec->digest);
+		    rec->digest);
 		path = selinux_file_context_path();
 	} else {
 		snprintf(subs_file, sizeof(subs_file), "%s.subs_dist", path);
-		rec->dist_subs = selabel_subs_init(subs_file, rec->dist_subs,
-							    rec->digest);
+		rec->dist_subs = selabel_subs_init(subs_file, rec->digest);
 		snprintf(subs_file, sizeof(subs_file), "%s.subs", path);
-		rec->subs = selabel_subs_init(subs_file, rec->subs,
-							    rec->digest);
+		rec->subs = selabel_subs_init(subs_file, rec->digest);
 	}
 
 #endif
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 3d7ff7488cf8..b03652ebc477 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -76,7 +76,6 @@ extern int digest_add_specfile(struct selabel_digest *digest, FILE *fp,
 extern void digest_gen_hash(struct selabel_digest *digest);
 
 extern struct selabel_sub *selabel_subs_init(const char *path,
-				    struct selabel_sub *list,
 				    struct selabel_digest *digest);
 
 struct selabel_lookup_rec {
-- 
2.13.0
