Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p2JFTav2018543
	for <selinux@tycho.nsa.gov>; Sat, 19 Mar 2011 11:29:41 -0400
Received: from nm1-vm0.bullet.mail.ird.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p2JFTZ1l023816
	for <selinux@tycho.nsa.gov>; Sat, 19 Mar 2011 15:29:35 GMT
Message-ID: <101131.45317.qm@web87012.mail.ird.yahoo.com>
Date: Sat, 19 Mar 2011 15:29:31 +0000 (GMT)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/1] selabel_open fix for processing the substitution file
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've produced this patch so that the substitution process now works correctly for the files backend. I'm not sure whether the other backends would need this functionality but they could implement if needed.

I've tested using libselinux 2.0.98 and 2.0.100 with all selabel backends and also matchpathcon (as that uses selabel functions).

Fix description:
libselinux selabel_open function always processed a substitution file (if installed) from the active policy contexts/files/file_contexts.subs irrespective of the backend type or SELABEL_OPT_PATH setting. This fix now processes the right subs file when SELABEL_CTX_FILE is selected in selabel_file.c. The other backends could also process a substitution file if needed in their own areas.

The patch:
---
 selinux/libselinux/src/label.c      |   13 ++++++++++---
 selinux/libselinux/src/label_file.c |   14 ++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/selinux/libselinux/src/label.c b/selinux/libselinux/src/label.c
index 2fd19c5..1457a77 100644
--- a/selinux/libselinux/src/label.c
+++ b/selinux/libselinux/src/label.c
@@ -56,10 +56,10 @@ static char *selabel_sub(struct selabel_sub *ptr, const char *src)
 	return NULL;
 }
 
-static struct selabel_sub *selabel_subs_init(void)
+struct selabel_sub *selabel_subs_init(char *subs_file)
 {
 	char buf[1024];
-	FILE *cfg = fopen(selinux_file_context_subs_path(), "r");
+	FILE *cfg = fopen(subs_file, "r");
 	struct selabel_sub *sub;
 	struct selabel_sub *list = NULL;
 
@@ -106,6 +106,9 @@ static struct selabel_sub *selabel_subs_init(void)
 		}
 		fclose(cfg);
 	}
+	else
+		/* This is an optional file so if not found reset errno */
+		errno = 0;
 	return list;
 }
 
@@ -160,7 +163,11 @@ struct selabel_handle *selabel_open(unsigned int backend,
 	memset(rec, 0, sizeof(*rec));
 	rec->backend = backend;
 	rec->validating = selabel_is_validate_set(opts, nopts);
-	rec->subs = selabel_subs_init();
+	/* 
+	 * Set subs to NULL and then let each backend process the substitution
+	 * file as they need.
+	 */
+	rec->subs = NULL;
 
 	if ((*initfuncs[backend])(rec, opts, nopts)) {
 		free(rec);
diff --git a/selinux/libselinux/src/label_file.c b/selinux/libselinux/src/label_file.c
index 937e509..4d801b0 100644
--- a/selinux/libselinux/src/label_file.c
+++ b/selinux/libselinux/src/label_file.c
@@ -395,6 +395,9 @@ static int process_line(struct selabel_handle *rec,
 	return 0;
 }
 
+/* Used to initialise the substitution file in label.c */
+extern struct selabel_sub *selabel_subs_init(char *subs_file);
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
@@ -427,6 +431,16 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 			break;
 		}
 
+	/* Get the substitution file name to use */
+	if (!path)
+		snprintf(subs_file, sizeof(subs_file), "%s", 
+								selinux_file_context_subs_path());
+	else
+		snprintf(subs_file, sizeof(subs_file), "%s.subs", path);
+
+	/* Then set up substitutions if present */	
+	rec->subs = selabel_subs_init(subs_file);
+
 	/* Open the specification file. */
 	if (!path)
 		path = selinux_file_context_path();
---

Richard


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
