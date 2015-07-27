Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6RDLPQE005762
 for <selinux@tycho.nsa.gov>; Mon, 27 Jul 2015 09:21:26 -0400
From: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
To: <selinux@tycho.nsa.gov>
Subject: [PATCH 1/2] libselinux: generalize read_spec_entries for any delimiter
Date: Mon, 27 Jul 2015 09:21:02 -0400
Message-ID: <1438003263-65455-2-git-send-email-ykhodorkovskiy@tresys.com>
In-Reply-To: <1438003263-65455-1-git-send-email-ykhodorkovskiy@tresys.com>
References: <1438003263-65455-1-git-send-email-ykhodorkovskiy@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch allows the tokenizer previously introduced for libselinux to
use any delimiter for tokenization. Delimiters may be squashed by
setting the squash_delim flag to 1. When any whitespace delimiter is used,
isspace() allows any whitespace character to be used as the delimiter.

Previously, read_spec_entries() trimmed whitespace and ignored comments and
empty lines. This functionality has been removed as is now the
responsiblity of the caller to implement.

Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
---
 libselinux/src/label_android_property.c |  11 ++-
 libselinux/src/label_file.h             |  10 ++-
 libselinux/src/label_internal.h         |   7 +-
 libselinux/src/label_support.c          | 129 +++++++++++++++++++-------------
 4 files changed, 97 insertions(+), 60 deletions(-)

diff --git a/libselinux/src/label_android_property.c b/libselinux/src/label_android_property.c
index 4af9896..5c06ed3 100644
--- a/libselinux/src/label_android_property.c
+++ b/libselinux/src/label_android_property.c
@@ -90,9 +90,14 @@ static int process_line(struct selabel_handle *rec,
 	spec_t *spec_arr = data->spec_arr;
 	unsigned int nspec = data->nspec;
 
-	items = read_spec_entries(line_buf, 2, &prop, &context);
-	if (items <= 0)
-		return items;
+	trim_buf(&line_buf);
+
+	/* Skip comment lines and empty lines. */
+	if (*line_buf == '#' || *line_buf == '\0') {
+		return 0;
+	}
+
+	items = tokenize(line_buf, 1, ' ', 2, &prop, &context);
 	if (items != 2) {
 		selinux_log(SELINUX_WARNING,
 			    "%s:  line %u is missing fields, skipping\n", path,
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index db961ba..3499da1 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -387,10 +387,14 @@ static inline int process_line(struct selabel_handle *rec,
 	unsigned int nspec = data->nspec;
 	const char *errbuf = NULL;
 
-	items = read_spec_entries(line_buf, 3, &regex, &type, &context);
-	if (items <= 0)
-		return items;
+	trim_buf(&line_buf);
 
+	/* Skip comment lines and empty lines. */
+	if (*line_buf == '#' || *line_buf == '\0') {
+		return 0;
+	}
+
+	items = tokenize(line_buf, 1, ' ', 3, &regex, &type, &context);
 	if (items < 2) {
 		COMPAT_LOG(SELINUX_WARNING,
 			    "%s:  line %u is missing fields, skipping\n", path,
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 861eca1..81a4f37 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -108,9 +108,10 @@ compat_validate(struct selabel_handle *rec,
 		const char *path, unsigned lineno) hidden;
 
 /*
- * The read_spec_entries function may be used to
- * replace sscanf to read entries from spec files.
+ * The tokenize function may be used to
+ * replace sscanf.
  */
-extern int read_spec_entries(char *line_buf, int num_args, ...);
+extern int tokenize(char *line_buf, int squash_delim, char delim, int num_args, ...);
+extern void trim_buf(char **buf);
 
 #endif				/* _SELABEL_INTERNAL_H_ */
diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index b3ab8ab..08ef303 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -11,88 +11,115 @@
 #include "label_internal.h"
 
 /*
- * The read_spec_entries and read_spec_entry functions may be used to
- * replace sscanf to read entries from spec files. The file and
- * property services now use these.
+ * The tokenize and tokenize_str functions may be used to
+ * replace sscanf to read tokens from buffers.
  */
 
-/* Read an entry from a spec file (e.g. file_contexts) */
-static inline int read_spec_entry(char **entry, char **ptr, int *len)
+/* Read a token from a buffer */
+static inline int tokenize_str(int squash_delim, char delim, char **str, char **ptr, int *len)
 {
-	*entry = NULL;
-	char *tmp_buf = NULL;
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
 
-	while (isspace(**ptr) && **ptr != '\0')
 		(*ptr)++;
+	}
 
-	tmp_buf = *ptr;
-	*len = 0;
+	*len = *ptr - tmp_buf;
+	/* If the end of the string has not been reached, this will ensure the
+	 * delimiter is not included when returning the token.
+	 */
+	if (**ptr != '\0') {
+		(*len)--;
+	}
 
-	while (!isspace(**ptr) && **ptr != '\0') {
-		(*ptr)++;
-		(*len)++;
+	*str = strndup(tmp_buf, *len);
+	if (!*str) {
+		return -1;
 	}
 
-	if (*len) {
-		*entry = strndup(tmp_buf, *len);
-		if (!*entry)
-			return -1;
+	while (**ptr != '\0' && squash_delim == 1) {
+		if (isspace(delim) && isspace(**ptr)) {
+			(*ptr)++;
+		} else if (!isspace(delim) && **ptr == delim) {
+			(*ptr)++;
+		} else {
+			break;
+		}
 	}
 
 	return 0;
 }
 
 /*
- * line_buf - Buffer containing the spec entries .
- * num_args - The number of spec parameter entries to process.
- * ...      - A 'char **spec_entry' for each parameter.
+ * line_buf - Buffer containing string to tokenize.
+ * squash_delim - Whether or not to squash repeating delimiters in input data.
+ *		   Set to 1 to squash_delimiter or 0 to disable squashing delimiter.
+ * delim - The delimiter used to tokenize line_buf. A whitespace delimiter will
+ *	    be tokenized using isspace().
+ * num_args - The number of parameter entries to process.
+ * ...      - A 'char **' for each parameter.
  * returns  - The number of items processed.
  *
- * This function calls read_spec_entry() to do the actual string processing.
+ * This function calls tokenize_str() to do the actual string processing. The
+ * caller is responsible for calling free() on each additional argument. The
+ * function will not tokenize more than num_args and the last argument will
+ * contain the remaining content of line_buf.
  */
-int hidden read_spec_entries(char *line_buf, int num_args, ...)
+int tokenize(char *line_buf, int squash_delim, char delim, int num_args, ...)
 {
-	char **spec_entry, *buf_p;
-	int len, rc, items, entry_len = 0;
+	char **arg, *buf_p;
+	int rc, items, arg_len = 0;
 	va_list ap;
 
-	len = strlen(line_buf);
-	if (line_buf[len - 1] == '\n')
-		line_buf[len - 1] = '\0';
-	else
-		/* Handle case if line not \n terminated by bumping
-		 * the len for the check below (as the line is NUL
-		 * terminated by getline(3)) */
-		len++;
-
 	buf_p = line_buf;
-	while (isspace(*buf_p))
-		buf_p++;
 
-	/* Skip comment lines and empty lines. */
-	if (*buf_p == '#' || *buf_p == '\0')
-		return 0;
-
-	/* Process the spec file entries */
+	/* Process the arguments */
 	va_start(ap, num_args);
 
-	items = 0;
-	while (items < num_args) {
-		spec_entry = va_arg(ap, char **);
+	for (items = 0; items < num_args && *buf_p != '\0'; items++) {
+		arg = va_arg(ap, char **);
+
+		/* Save the remainder of the string in arg */
+		if (items == num_args - 1) {
+			*arg = strdup(buf_p);
+			if (*arg == NULL) {
+				goto exit;
+			}
 
-		if (len - 1 == buf_p - line_buf) {
-			va_end(ap);
-			return items;
+			continue;
 		}
 
-		rc = read_spec_entry(spec_entry, &buf_p, &entry_len);
+		rc = tokenize_str(squash_delim, delim, arg, &buf_p, &arg_len);
 		if (rc < 0) {
-			va_end(ap);
-			return rc;
+			goto exit;
 		}
-		if (entry_len)
-			items++;
 	}
+
+exit:
 	va_end(ap);
 	return items;
 }
+
+/* This function removes leading whitespace. If the buffer ends in a newline,
+ * the newline is removed.
+ */
+void trim_buf(char **buf)
+{
+	int len = strlen(*buf);
+	if ((*buf)[len - 1] == '\n') {
+		(*buf)[len - 1] = '\0';
+	}
+
+	while (isspace(**buf)) {
+		(*buf)++;
+	}
+}
-- 
1.9.3
