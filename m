Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t48EpZ0B026522
 for <selinux@tycho.nsa.gov>; Fri, 8 May 2015 10:51:35 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH v4] Replace fmemopen() with internal function in libsepol.
Date: Fri,  8 May 2015 10:51:09 -0400
Message-Id: <1431096669-14399-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Created a new function, get_line(), to replace the use of fmemopen()
and getline() in module_to_cil.c since fmemopen() is not available
on Darwin.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/src/module_to_cil.c | 122 +++++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 57 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index d1d2efe..8d16d3e 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -107,6 +107,44 @@ static void cil_println(int indent, const char *fmt, ...)
 	}
 }
 
+static int get_line(char **start, char *end, char **line)
+{
+	int rc = 1;
+	char *p = NULL;
+	size_t len = 0;
+
+	*line = NULL;
+
+	for (p = *start; p < end && isspace(*p); p++);
+
+	*start = p;
+
+	for (len = 0; p < end && *p != '\n' && *p != '\0'; p++, len++);
+
+	if (len == 0) {
+		rc = 0;
+		goto exit;
+	}
+
+	*line = malloc(len+1);
+	if (*line == NULL) {
+		log_err("Out of memory");
+		rc = -1;
+		goto exit;
+	}
+
+	memcpy(*line, *start, len);
+	(*line)[len] = '\0';
+
+	*start = p;
+
+	return rc;
+
+exit:
+	*start = NULL;
+	return rc;
+}
+
 struct map_args {
 	struct policydb *pdb;
 	struct avrule_block *block;
@@ -2907,14 +2945,11 @@ exit:
 static int seusers_to_cil(struct sepol_module_package *mod_pkg)
 {
 	int rc = -1;
-	FILE *fp = NULL;
 	char *seusers = sepol_module_package_get_seusers(mod_pkg);
 	size_t seusers_len = sepol_module_package_get_seusers_len(mod_pkg);
-	size_t len = 0;
+	char *cur = seusers;
+	char *end = seusers + seusers_len;
 	char *line = NULL;
-	ssize_t line_len = 0;
-	char *buf = NULL;
-
 	char *user = NULL;
 	char *seuser = NULL;
 	char *level = NULL;
@@ -2924,19 +2959,12 @@ static int seusers_to_cil(struct sepol_module_package *mod_pkg)
 		return 0;
 	}
 
-	fp = fmemopen(seusers, seusers_len, "r");
-
-	while ((line_len = getline(&line, &len, fp)) != -1) {
-		buf = line;
-		buf[line_len - 1] = '\0';
-		while (*buf && isspace(buf[0])) {
-			buf++;
-		}
-		if (buf[0] == '#' || buf[0] == '\0') {
+	while ((rc = get_line(&cur, end, &line)) > 0) {
+		if (line[0] == '#') {
 			continue;
 		}
 
-		matched = sscanf(buf, "%m[^:]:%m[^:]:%ms", &user, &seuser, &level);
+		matched = sscanf(line, "%m[^:]:%m[^:]:%ms", &user, &seuser, &level);
 
 		if (matched < 2 || matched > 3) {
 			log_err("Invalid seuser line: %s", line);
@@ -2964,20 +2992,17 @@ static int seusers_to_cil(struct sepol_module_package *mod_pkg)
 		free(user);
 		free(seuser);
 		free(level);
+		free(line);
 		user = seuser = level = NULL;
 	}
-	if (ferror(fp)) {
+
+	if (rc == -1) {
 		cil_printf("Failed to read seusers\n");
-		rc = -1;
 		goto exit;
 	}
 
 	rc = 0;
-
 exit:
-	if (fp != NULL) {
-		fclose(fp);
-	}
 	free(line);
 	free(user);
 	free(seuser);
@@ -3002,10 +3027,9 @@ static int user_extra_to_cil(struct sepol_module_package *mod_pkg)
 	int rc = -1;
 	char *userx = sepol_module_package_get_user_extra(mod_pkg);
 	size_t userx_len = sepol_module_package_get_user_extra_len(mod_pkg);
-	FILE *fp = NULL;
-	size_t len = 0;
-	char *line = NULL;
-	ssize_t line_len = 0;
+	char *cur = userx;
+	char *end = userx + userx_len;
+	char *line;
 	int matched;
 	char *user = NULL;
 	char *prefix = NULL;
@@ -3014,10 +3038,10 @@ static int user_extra_to_cil(struct sepol_module_package *mod_pkg)
 		return 0;
 	}
 
-	fp = fmemopen(userx, userx_len, "r");
-
-	while ((line_len = getline(&line, &len, fp)) != -1) {
-		line[line_len - 1] = '\0';
+	while ((rc = get_line(&cur, end, &line)) > 0) {
+		if (line[0] == '#') {
+			continue;
+		}
 
 		matched = sscanf(line, "user %ms prefix %m[^;];", &user, &prefix);
 		if (matched != 2) {
@@ -3029,20 +3053,17 @@ static int user_extra_to_cil(struct sepol_module_package *mod_pkg)
 		cil_println(0, "(userprefix %s %s)", user, prefix);
 		free(user);
 		free(prefix);
-		user = prefix = NULL;
+		free(line);
+		user = prefix = line = NULL;
 	}
 
-	if (ferror(fp)) {
+	if (rc == -1) {
 		cil_printf("Failed to read user_extra\n");
-		rc = -1;
 		goto exit;
 	}
 
 	rc = 0;
 exit:
-	if (fp != NULL) {
-		fclose(fp);
-	}
 	free(line);
 	free(user);
 	free(prefix);
@@ -3055,11 +3076,9 @@ static int file_contexts_to_cil(struct sepol_module_package *mod_pkg)
 	int rc = -1;
 	char *fc = sepol_module_package_get_file_contexts(mod_pkg);
 	size_t fc_len = sepol_module_package_get_file_contexts_len(mod_pkg);
-	FILE *fp = NULL;
-	size_t len = 0;
+	char *cur = fc;
+	char *end = fc + fc_len;
 	char *line = NULL;
-	char *buf = NULL;
-	ssize_t line_len = 0;
 	int matched;
 	char *regex = NULL;
 	char *mode = NULL;
@@ -3070,20 +3089,12 @@ static int file_contexts_to_cil(struct sepol_module_package *mod_pkg)
 		return 0;
 	}
 
-	fp = fmemopen(fc, fc_len, "r");
-	while ((line_len = getline(&line, &len, fp)) != -1) {
-		buf = line;
-		if (buf[line_len - 1] == '\n') {
-			buf[line_len - 1] = '\0';
-		}
-		while (*buf && isspace(buf[0])) {
-			buf++;
-		}
-		if (buf[0] == '#' || buf[0] == '\0') {
+	while ((rc = get_line(&cur, end, &line)) > 0) {
+		if (line[0] == '#') {
 			continue;
 		}
 
-		matched = sscanf(buf, "%ms %ms %ms", &regex, &mode, &context);
+		matched = sscanf(line, "%ms %ms %ms", &regex, &mode, &context);
 		if (matched < 2 || matched > 3) {
 			rc = -1;
 			log_err("Invalid file context line: %s", line);
@@ -3130,12 +3141,12 @@ static int file_contexts_to_cil(struct sepol_module_package *mod_pkg)
 		free(regex);
 		free(mode);
 		free(context);
-		regex = mode = context = NULL;
+		free(line);
+		regex = mode = context = line = NULL;
 	}
 
-	if (ferror(fp)) {
-		cil_printf("Failed to read user_extra\n");
-		rc = -1;
+	if (rc == -1) {
+		cil_printf("Failed to read file_contexts_to_cil\n");
 		goto exit;
 	}
 
@@ -3145,9 +3156,6 @@ exit:
 	free(regex);
 	free(mode);
 	free(context);
-	if (fp != NULL) {
-		fclose(fp);
-	}
 
 	return rc;
 }
-- 
1.9.3
