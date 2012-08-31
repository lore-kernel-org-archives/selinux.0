From: Eric Paris <eparis@redhat.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH 13/18] libselinux: label_file: new process_file function
Date: Fri, 31 Aug 2012 10:49:49 -0700
Message-Id: <1346435394-1954-13-git-send-email-eparis@redhat.com>
In-Reply-To: <1346435394-1954-1-git-send-email-eparis@redhat.com>
References: <1346435394-1954-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We currently duplicate code 3 times for the main file, the homedirs, and
the local file.  Just put that stuff in its own function so we don't
have to deal with it multiple times.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/src/label_file.c | 123 +++++++++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 64 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index d53bc21..0815d12 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -243,6 +243,53 @@ static int process_line(struct selabel_handle *rec,
 	return 0;
 }
 
+static int process_file(const char *path, const char *suffix, struct selabel_handle *rec, const char **prefix_array)
+{
+	FILE *fp;
+	struct stat sb;
+	unsigned int lineno;
+	size_t line_len;
+	char *line_buf = NULL;
+	int rc;
+	char stack_path[PATH_MAX + 1];
+
+	/* append the path suffix if we have one */
+	if (suffix) {
+		rc = snprintf(stack_path, sizeof(stack_path), "%s.%s", path, suffix);
+		if (rc >= sizeof(stack_path)) {
+			errno = ENAMETOOLONG;
+			return -1;
+		}
+		path = stack_path;
+	}
+
+	/* Open the specification file. */
+	if ((fp = fopen(path, "r")) == NULL)
+		return -1;
+	__fsetlocking(fp, FSETLOCKING_BYCALLER);
+
+	if (fstat(fileno(fp), &sb) < 0)
+		return -1;
+	if (!S_ISREG(sb.st_mode)) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	/* 
+	 * The do detailed validation of the input and fill the spec array
+	 */
+	lineno = 0;
+	while (getline(&line_buf, &line_len, fp) > 0) {
+		rc = process_line(rec, path, prefix_array, line_buf, ++lineno);
+		if (rc)
+			return rc;
+	}
+	free(line_buf);
+	fclose(fp);
+
+	return 0;
+}
+
 static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 		unsigned n)
 {
@@ -250,17 +297,8 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 	const char *path = NULL;
 	const char *static_prefix_array[2] = {NULL, };
 	const char **prefix_array = static_prefix_array;
-	FILE *fp;
-	FILE *localfp = NULL;
-	FILE *homedirfp = NULL;
-	char local_path[PATH_MAX + 1];
-	char homedir_path[PATH_MAX + 1];
 	char subs_file[PATH_MAX + 1];
-	char *line_buf = NULL;
-	size_t line_len = 0;
-	unsigned int lineno;
 	int status = -1, baseonly = 0;
-	struct stat sb;
 
 	/* Process arguments */
 	while (n--)
@@ -283,6 +321,7 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 	if (!path) {
 		rec->subs = selabel_subs_init(selinux_file_context_subs_dist_path(), rec->subs);
 		rec->subs = selabel_subs_init(selinux_file_context_subs_path(), rec->subs);
+		path = selinux_file_context_path();
 	} else {
 		snprintf(subs_file, sizeof(subs_file), "%s.subs_dist", path);
 		rec->subs = selabel_subs_init(subs_file, rec->subs);
@@ -290,45 +329,14 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 		rec->subs = selabel_subs_init(subs_file, rec->subs);
 	}
 
-	/* Open the specification file. */
-	if (!path)
-		path = selinux_file_context_path();
-	if ((fp = fopen(path, "r")) == NULL)
-		return -1;
-	__fsetlocking(fp, FSETLOCKING_BYCALLER);
-
-	if (fstat(fileno(fp), &sb) < 0)
-		return -1;
-	if (!S_ISREG(sb.st_mode)) {
-		errno = EINVAL;
-		return -1;
-	}
-
-	if (!baseonly) {
-		snprintf(homedir_path, sizeof(homedir_path), "%s.homedirs",
-			 path);
-		homedirfp = fopen(homedir_path, "r");
-		if (homedirfp != NULL)
-			__fsetlocking(homedirfp, FSETLOCKING_BYCALLER);
-
-		snprintf(local_path, sizeof(local_path), "%s.local", path);
-		localfp = fopen(local_path, "r");
-		if (localfp != NULL)
-			__fsetlocking(localfp, FSETLOCKING_BYCALLER);
-	}
 	rec->spec_file = strdup(path);
 
 	/* 
 	 * The do detailed validation of the input and fill the spec array
 	 */
-	data->nspec = 0;
-
-	lineno = 0;
-	while (getline(&line_buf, &line_len, fp) > 0) {
-		status = process_line(rec, path, prefix_array, line_buf, ++lineno);
-		if (status)
-			goto finish;
-	}
+	status = process_file(path, NULL, rec, prefix_array);
+	if (status)
+		goto finish;
 
 	if (rec->validating) {
 		status = nodups_specs(data, path);
@@ -336,35 +344,22 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 			goto finish;
 	}
 
-	lineno = 0;
-	if (homedirfp)
-		while (getline(&line_buf, &line_len, homedirfp) > 0) {
-			status = process_line(rec, homedir_path, prefix_array, line_buf, ++lineno);
-			if (status)
-				goto finish;
-		}
-
-	lineno = 0;
-	if (localfp)
-		while (getline(&line_buf, &line_len, localfp) > 0) {
-			status = process_line(rec, local_path, prefix_array, line_buf, ++lineno);
-			if (status)
-				goto finish;
-		}
+	if (!baseonly) {
+		status = process_file(path, "homedirs", rec, prefix_array);
+		if (status && errno != ENOENT)
+			goto finish;
 
-	free(line_buf);
+		status = process_file(path, "local", rec, prefix_array);
+		if (status && errno != ENOENT)
+			goto finish;
+	}
 
 	status = sort_specs(data);
 
 	status = 0;
 finish:
-	fclose(fp);
 	if (status)
 		free(data->spec_arr);
-	if (homedirfp)
-		fclose(homedirfp);
-	if (localfp)
-		fclose(localfp);
 	return status;
 }
 
-- 
1.7.11.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
