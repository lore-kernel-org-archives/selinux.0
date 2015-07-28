Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6SIoxab022598
 for <selinux@tycho.nsa.gov>; Tue, 28 Jul 2015 14:51:00 -0400
From: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH v2] libsepol: Replace sscanf in module_to_cil
Date: Tue, 28 Jul 2015 14:50:38 -0400
Message-ID: <1438109438-50812-1-git-send-email-ykhodorkovskiy@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Some platforms do not have %ms support in sscanf. This adds a tokenize()
function to be used instead of sscanf. tokenize() has the ability to split on any
delimiter. All whitespace delimiters will be squashed.

Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
---

Changes from v1:
- drop the libselinux patch altogether.
- remove the squash_delim flag. All whitespace is now squashed and all other delimiters are not.
- made tokenize() hidden which meant including dso.h in util.c.
- changed len to be of type size_t

 libsepol/include/sepol/policydb/util.h |  6 +++
 libsepol/src/module_to_cil.c           | 61 +++++++++++++++++----
 libsepol/src/util.c                    | 98 ++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+), 11 deletions(-)

diff --git a/libsepol/include/sepol/policydb/util.h b/libsepol/include/sepol/policydb/util.h
index ef1c90d..cb97ccf 100644
--- a/libsepol/include/sepol/policydb/util.h
+++ b/libsepol/include/sepol/policydb/util.h
@@ -32,5 +32,11 @@ extern int add_i_to_a(uint32_t i, uint32_t * cnt, uint32_t ** a);
 extern char *sepol_av_to_string(policydb_t * policydbp, uint32_t tclass,
 				sepol_access_vector_t av);
 
+/*
+ * The tokenize function may be used to
+ * replace sscanf
+ */
+extern int tokenize(char *line_buf, char delim, int num_args, ...);
+
 __END_DECLS
 #endif
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 2d8046c..18ec6b9 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2859,7 +2859,7 @@ static int level_string_to_cil(char *levelstr)
 	char *token = NULL;
 	char *ranged = NULL;
 
-	matched = sscanf(levelstr, "%m[^:]:%ms", &sens, &cats);
+	matched = tokenize(levelstr, ':', 2, &sens, &cats);
 	if (matched < 1 || matched > 2) {
 		log_err("Invalid level: %s", levelstr);
 		rc = -1;
@@ -2924,7 +2924,7 @@ static int context_string_to_cil(char *contextstr)
 	char *type = NULL;
 	char *level = NULL;
 
-	matched = sscanf(contextstr, "%m[^:]:%m[^:]:%m[^:]:%ms", &user, &role, &type, &level);
+	matched = tokenize(contextstr, ':', 4, &user, &role, &type, &level);
 	if (matched < 3 || matched > 4) {
 		log_err("Invalid context: %s", contextstr);
 		rc = -1;
@@ -2965,6 +2965,7 @@ static int seusers_to_cil(struct sepol_module_package *mod_pkg)
 	char *user = NULL;
 	char *seuser = NULL;
 	char *level = NULL;
+	char *tmp = NULL;
 	int matched;
 
 	if (seusers_len == 0) {
@@ -2972,11 +2973,18 @@ static int seusers_to_cil(struct sepol_module_package *mod_pkg)
 	}
 
 	while ((rc = get_line(&cur, end, &line)) > 0) {
-		if (line[0] == '#') {
+		tmp = line;
+		while (isspace(*tmp)) {
+			tmp++;
+		}
+
+		if (tmp[0] == '#' || tmp[0] == '\0') {
+			free(line);
+			line = NULL;
 			continue;
 		}
 
-		matched = sscanf(line, "%m[^:]:%m[^:]:%ms", &user, &seuser, &level);
+		matched = tokenize(tmp, ':', 3, &user, &seuser, &level);
 
 		if (matched < 2 || matched > 3) {
 			log_err("Invalid seuser line: %s", line);
@@ -3045,28 +3053,51 @@ static int user_extra_to_cil(struct sepol_module_package *mod_pkg)
 	int matched;
 	char *user = NULL;
 	char *prefix = NULL;
+	int prefix_len = 0;
+	char *user_str = NULL;
+	char *prefix_str = NULL;
+	char *eol = NULL;
+	char *tmp = NULL;
 
 	if (userx_len == 0) {
 		return 0;
 	}
 
 	while ((rc = get_line(&cur, end, &line)) > 0) {
-		if (line[0] == '#') {
+		tmp = line;
+		while (isspace(*tmp)) {
+			tmp++;
+		}
+
+		if (tmp[0] == '#' || tmp[0] == '\0') {
+			free(line);
+			line = NULL;
 			continue;
 		}
 
-		matched = sscanf(line, "user %ms prefix %m[^;];", &user, &prefix);
-		if (matched != 2) {
+		matched = tokenize(tmp, ' ', 4, &user_str, &user, &prefix_str, &prefix);
+		if (matched != 4) {
 			rc = -1;
-			log_err("Invalid file context line: %s", line);
+			log_err("Invalid user extra line: %s", line);
 			goto exit;
 		}
 
+		prefix_len = strlen(prefix);
+		eol = prefix + prefix_len - 1;
+		if (*eol != ';' || strcmp(user_str, "user") || strcmp(prefix_str, "prefix")) {
+			rc = -1;
+			log_err("Invalid user extra line: %s", line);
+			goto exit;
+		}
+		*eol = '\0';
+
 		cil_println(0, "(userprefix %s %s)", user, prefix);
 		free(user);
 		free(prefix);
 		free(line);
-		user = prefix = line = NULL;
+		free(user_str);
+		free(prefix_str);
+		user = prefix = line = user_str = prefix_str = NULL;
 	}
 
 	if (rc == -1) {
@@ -3096,17 +3127,25 @@ static int file_contexts_to_cil(struct sepol_module_package *mod_pkg)
 	char *mode = NULL;
 	char *context = NULL;
 	const char *cilmode;
+	char *tmp = NULL;
 
 	if (fc_len == 0) {
 		return 0;
 	}
 
 	while ((rc = get_line(&cur, end, &line)) > 0) {
-		if (line[0] == '#') {
+		tmp = line;
+		while (isspace(*tmp)) {
+			tmp++;
+		}
+
+		if (tmp[0] == '#' || tmp[0] == '\0') {
+			free(line);
+			line = NULL;
 			continue;
 		}
 
-		matched = sscanf(line, "%ms %ms %ms", &regex, &mode, &context);
+		matched = tokenize(tmp, ' ', 3, &regex, &mode, &context);
 		if (matched < 2 || matched > 3) {
 			rc = -1;
 			log_err("Invalid file context line: %s", line);
diff --git a/libsepol/src/util.c b/libsepol/src/util.c
index a824e61..6e285d5 100644
--- a/libsepol/src/util.c
+++ b/libsepol/src/util.c
@@ -19,11 +19,15 @@
  */
 
 #include <assert.h>
+#include <ctype.h>
+#include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
 
 #include <sepol/policydb/flask_types.h>
 #include <sepol/policydb/policydb.h>
+#include <sepol/policydb/util.h>
+#include <dso.h>
 
 struct val_to_name {
 	unsigned int val;
@@ -114,3 +118,97 @@ char *sepol_av_to_string(policydb_t * policydbp, uint32_t tclass,
 
 	return avbuf;
 }
+
+/*
+ * The tokenize and tokenize_str functions may be used to
+ * replace sscanf to read tokens from buffers.
+ */
+
+/* Read a token from a buffer */
+static inline int tokenize_str(char delim, char **str, char **ptr, size_t *len)
+{
+	char *tmp_buf = *ptr;
+	*str = NULL;
+
+	while (**ptr != '\0') {
+		if (isspace(delim) && isspace(**ptr)) {
+			(*ptr)++;
+			break;
+		} else if (!isspace(delim) && **ptr == delim) {
+			(*ptr)++;
+			break;
+		}
+
+		(*ptr)++;
+	}
+
+	*len = *ptr - tmp_buf;
+	/* If the end of the string has not been reached, this will ensure the
+	 * delimiter is not included when returning the token.
+	 */
+	if (**ptr != '\0') {
+		(*len)--;
+	}
+
+	*str = strndup(tmp_buf, *len);
+	if (!*str) {
+		return -1;
+	}
+
+	/* Squash spaces if the delimiter is a whitespace character */
+	while (**ptr != '\0' && isspace(delim) && isspace(**ptr)) {
+		(*ptr)++;
+	}
+
+	return 0;
+}
+
+/*
+ * line_buf - Buffer containing string to tokenize.
+ * delim - The delimiter used to tokenize line_buf. A whitespace delimiter will
+ *	    be tokenized using isspace().
+ * num_args - The number of parameter entries to process.
+ * ...      - A 'char **' for each parameter.
+ * returns  - The number of items processed.
+ *
+ * This function calls tokenize_str() to do the actual string processing. The
+ * caller is responsible for calling free() on each additional argument. The
+ * function will not tokenize more than num_args and the last argument will
+ * contain the remaining content of line_buf. If the delimiter is any whitespace
+ * character, then all whitespace will be squashed.
+ */
+int hidden tokenize(char *line_buf, char delim, int num_args, ...)
+{
+	char **arg, *buf_p;
+	int rc, items;
+	size_t arg_len = 0;
+	va_list ap;
+
+	buf_p = line_buf;
+
+	/* Process the arguments */
+	va_start(ap, num_args);
+
+	for (items = 0; items < num_args && *buf_p != '\0'; items++) {
+		arg = va_arg(ap, char **);
+
+		/* Save the remainder of the string in arg */
+		if (items == num_args - 1) {
+			*arg = strdup(buf_p);
+			if (*arg == NULL) {
+				goto exit;
+			}
+
+			continue;
+		}
+
+		rc = tokenize_str(delim, arg, &buf_p, &arg_len);
+		if (rc < 0) {
+			goto exit;
+		}
+	}
+
+exit:
+	va_end(ap);
+	return items;
+}
-- 
1.9.3
