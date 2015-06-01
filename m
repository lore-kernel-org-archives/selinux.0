Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t51EXX7T002091
 for <selinux@tycho.nsa.gov>; Mon, 1 Jun 2015 10:33:39 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [RFC PATCH] libselinux: Add read_spec_entries function to replace
 sscanf
Date: Mon,  1 Jun 2015 15:33:26 +0100
Message-Id: <1433169206-5031-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Currently sscanf is used with %ms parameters that are not supported
on all platforms. The new read_spec_entries function may be used
to replace these where required. This patch updates
sefcontext_compile, label_file and label_android_property services
to use the new function.

The file and property services have been tested on Android emulator
and the file service on Fedora 21.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/src/label_android_property.c | 18 ++-----
 libselinux/src/label_file.c             | 16 ++----
 libselinux/src/label_internal.h         |  6 +++
 libselinux/src/label_support.c          | 89 +++++++++++++++++++++++++++++++++
 libselinux/utils/sefcontext_compile.c   | 35 ++++++-------
 5 files changed, 120 insertions(+), 44 deletions(-)
 create mode 100644 libselinux/src/label_support.c

diff --git a/libselinux/src/label_android_property.c b/libselinux/src/label_android_property.c
index 1a29356..dadb160 100644
--- a/libselinux/src/label_android_property.c
+++ b/libselinux/src/label_android_property.c
@@ -82,23 +82,15 @@ static int process_line(struct selabel_handle *rec,
 			const char *path, char *line_buf,
 			int pass, unsigned lineno)
 {
-	int items, len;
-	char buf1[BUFSIZ], buf2[BUFSIZ];
-	char *buf_p, *prop = buf1, *context = buf2;
+	int items;
+	char *prop = NULL, *context = NULL;
 	struct saved_data *data = (struct saved_data *)rec->data;
 	spec_t *spec_arr = data->spec_arr;
 	unsigned int nspec = data->nspec;
 
-	len = strlen(line_buf);
-	if (line_buf[len - 1] == '\n')
-		line_buf[len - 1] = 0;
-	buf_p = line_buf;
-	while (isspace(*buf_p))
-		buf_p++;
-	/* Skip comment lines and empty lines. */
-	if (*buf_p == '#' || *buf_p == 0)
-		return 0;
-	items = sscanf(line_buf, "%255s %255s", prop, context);
+	items = read_spec_entries(line_buf, 2, &prop, &context);
+	if (items <= 0)
+		return items;
 	if (items != 2) {
 		selinux_log(SELINUX_WARNING,
 			    "%s:  line %u is missing fields, skipping\n", path,
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index bfb64af..b8061f4 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -154,22 +154,16 @@ static int process_line(struct selabel_handle *rec,
 			char *line_buf, unsigned lineno)
 {
 	int items, len, rc;
-	char *buf_p, *regex, *type, *context;
+	char *regex = NULL, *type = NULL, *context = NULL;
 	struct saved_data *data = (struct saved_data *)rec->data;
 	struct spec *spec_arr;
 	unsigned int nspec = data->nspec;
 	const char *errbuf = NULL;
 
-	len = strlen(line_buf);
-	if (line_buf[len - 1] == '\n')
-		line_buf[len - 1] = 0;
-	buf_p = line_buf;
-	while (isspace(*buf_p))
-		buf_p++;
-	/* Skip comment lines and empty lines. */
-	if (*buf_p == '#' || *buf_p == 0)
-		return 0;
-	items = sscanf(line_buf, "%ms %ms %ms", &regex, &type, &context);
+	items = read_spec_entries(line_buf, 3, &regex, &type, &context);
+	if (items <= 0)
+		return items;
+
 	if (items < 2) {
 		COMPAT_LOG(SELINUX_WARNING,
 			    "%s:  line %u is missing fields, skipping\n", path,
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index ef6ad26..0e582b6 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -102,4 +102,10 @@ compat_validate(struct selabel_handle *rec,
 		struct selabel_lookup_rec *contexts,
 		const char *path, unsigned lineno) hidden;
 
+/*
+ * The read_spec_entries function may be used to
+ * replace sscanf to read entries from spec files.
+ */
+extern int read_spec_entries(char *line_buf, int num_args, ...);
+
 #endif				/* _SELABEL_INTERNAL_H_ */
diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
new file mode 100644
index 0000000..bcde883
--- /dev/null
+++ b/libselinux/src/label_support.c
@@ -0,0 +1,89 @@
+/*
+ * This file contains helper functions for labeling support.
+ *
+ * Author : Richard Haines <richard_c_haines@btinternet.com>
+ */
+
+#include <stdlib.h>
+#include <stdarg.h>
+#include <ctype.h>
+#include <string.h>
+#include "label_internal.h"
+
+/*
+ * The read_spec_entries and read_spec_entry functions may be used to
+ * replace sscanf to read entries from spec files. The file and
+ * property services now use these.
+ */
+
+/* Read an entry from a spec file (e.g. file_contexts) */
+static inline int read_spec_entry(char **entry, char **ptr)
+{
+	int entry_len = 0;
+	*entry = NULL;
+	char *tmp_buf = NULL;
+
+	while (isspace(**ptr) && **ptr != '\0')
+		(*ptr)++;
+
+	tmp_buf = *ptr;
+
+	while (!isspace(**ptr) && **ptr != '\0') {
+		(*ptr)++;
+		entry_len++;
+	}
+
+	*entry = strndup(tmp_buf, entry_len);
+	if (!*entry)
+		return -1;
+
+	return 0;
+}
+
+/*
+ * line_buf - Buffer containing the spec entries .
+ * num_args - The number of spec parameter entries to process.
+ * ...      - A 'char **spec_entry' for each parameter.
+ * returns  - The number of items processed.
+ *
+ * This function calls read_spec_entry() to do the actual string processing.
+ */
+int read_spec_entries(char *line_buf, int num_args, ...)
+{
+	char **spec_entry, *buf_p;
+	int len, rc, items;
+	va_list ap;
+
+	len = strlen(line_buf);
+	if (line_buf[len - 1] == '\n')
+		line_buf[len - 1] = '\0';
+
+	buf_p = line_buf;
+	while (isspace(*buf_p))
+		buf_p++;
+
+	/* Skip comment lines and empty lines. */
+	if (*buf_p == '#' || *buf_p == '\0')
+		return 0;
+
+	/* Process the spec file entries */
+	va_start(ap, num_args);
+
+	for (items = 0; items < num_args; items++) {
+		spec_entry = va_arg(ap, char **);
+
+		if (len - 1 == buf_p - line_buf) {
+			va_end(ap);
+			return items;
+		}
+
+		rc = read_spec_entry(spec_entry, &buf_p);
+		if (rc < 0) {
+			va_end(ap);
+			return rc;
+		}
+	}
+	va_end(ap);
+	return items;
+}
+
diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 33a4a42..03bc0a7 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -29,11 +29,10 @@ static int process_file(struct saved_data *data, const char *filename)
 
 	line_num = 0;
 	while ((len = getline(&line_buf, &line_len, context_file)) != -1) {
-		char *context;
-		char *mode;
-		char *regex;
+		char *context = NULL;
+		char *mode = NULL;
+		char *regex = NULL;
 		char *cp, *anchored_regex;
-		char *buf_p;
 		pcre *re;
 		pcre_extra *sd;
 		const char *err;
@@ -41,23 +40,20 @@ static int process_file(struct saved_data *data, const char *filename)
 		size_t regex_len;
 		int32_t stem_id;
 
-		len = strlen(line_buf);
-		if (line_buf[len - 1] == '\n')
-			line_buf[len - 1] = 0;
-		buf_p = line_buf;
-		while (isspace(*buf_p))
-			buf_p++;
-		/* Skip comment lines and empty lines. */
-		if (*buf_p == '#' || *buf_p == 0)
-			continue;
+		line_num++;
 
-		items = sscanf(line_buf, "%ms %ms %ms", &regex, &mode, &context);
-		if (items < 2 || items > 3) {
-			fprintf(stderr, "invalid entry, skipping:%s", line_buf);
-			continue;
-		}
+		items = read_spec_entries(line_buf, 3, &regex, &mode, &context);
+		if (items < 0)
+			return -1;
 
-		if (items == 2) {
+		if (items == 0)
+			continue;
+		else if (items == 1) {
+			fprintf(stderr,
+				 "line: %u has invalid entry - skipping: %s\n",
+				 line_num, line_buf);
+			continue;
+		} else if (items == 2) {
 			context = mode;
 			mode = NULL;
 		}
@@ -115,7 +111,6 @@ static int process_file(struct saved_data *data, const char *filename)
 		free(anchored_regex);
 		spec->sd = sd;
 
-		line_num++;
 		data->nspec++;
 	}
 
-- 
2.1.0
