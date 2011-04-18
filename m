Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3IFflcs021514
	for <selinux@tycho.nsa.gov>; Mon, 18 Apr 2011 11:41:47 -0400
Received: from nm3-vm0.bt.bullet.mail.ird.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p3IFfila022418
	for <selinux@tycho.nsa.gov>; Mon, 18 Apr 2011 15:41:46 GMT
Message-ID: <810623.94598.qm@web87005.mail.ird.yahoo.com>
Date: Mon, 18 Apr 2011 16:41:40 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/1] selabel_open fix processing of substitution files (update)
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch replaces the previous patch (sent 19th March) as libselinux 2.0.102 now has an additional subs file that this patch will now handle.

Patch details:
libselinux selabel_open function always processed the substitution files (if installed) from the active policy contexts/files/file_contexts.subs and subs_dist irrespective of the backend type or SELABEL_OPT_PATH setting. This patch now processes the correct subs files when selabel_open is called with SELABEL_CTX_FILE. The other backends could also process their own substitution files if needed in their own areas.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/src/label.c      |    4 +---
 libselinux/src/label_file.c |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index ba316df..7d71e72 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -56,7 +56,7 @@ static char *selabel_sub(struct selabel_sub *ptr, const char *src)
 	return NULL;
 }
 
-static struct selabel_sub *selabel_subs_init(const char *path,struct selabel_sub *list)
+struct selabel_sub *selabel_subs_init(const char *path,struct selabel_sub *list)
 {
 	char buf[1024];
 	FILE *cfg = fopen(path, "r");
@@ -161,8 +161,6 @@ struct selabel_handle *selabel_open(unsigned int backend,
 	rec->validating = selabel_is_validate_set(opts, nopts);
 
 	rec->subs = NULL;
-	rec->subs = selabel_subs_init(selinux_file_context_subs_dist_path(), rec->subs);
-	rec->subs = selabel_subs_init(selinux_file_context_subs_path(), rec->subs);
 
 	if ((*initfuncs[backend])(rec, opts, nopts)) {
 		free(rec);
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 937e509..619c435 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -395,6 +395,9 @@ static int process_line(struct selabel_handle *rec,
 	return 0;
 }
 
+/* Used to initialise the substitution files in label.c */
+extern struct selabel_sub *selabel_subs_init(const char *path, struct selabel_sub *list);
+
 static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 		unsigned n)
 {
@@ -406,6 +409,7 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 	FILE *homedirfp = NULL;
 	char local_path[PATH_MAX + 1];
 	char homedir_path[PATH_MAX + 1];
+	char subs_file[PATH_MAX + 1];
 	char *line_buf = NULL;
 	size_t line_len = 0;
 	unsigned int lineno, pass, i, j, maxnspec;
@@ -427,6 +431,17 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 			break;
 		}
 
+	/* Process local and distribution substitution files */
+	if (!path) {
+		rec->subs = selabel_subs_init(selinux_file_context_subs_dist_path(), rec->subs);
+		rec->subs = selabel_subs_init(selinux_file_context_subs_path(), rec->subs);
+	} else {
+		snprintf(subs_file, sizeof(subs_file), "%s.subs_dist", path);
+		rec->subs = selabel_subs_init(subs_file, rec->subs);
+		snprintf(subs_file, sizeof(subs_file), "%s.subs", path);
+		rec->subs = selabel_subs_init(subs_file, rec->subs);
+	}
+
 	/* Open the specification file. */
 	if (!path)
 		path = selinux_file_context_path();
-- 
1.7.3.2


Richard





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
