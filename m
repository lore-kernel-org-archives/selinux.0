Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8TBdVHk026058
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 07:39:33 -0400
Received: by mail-wm0-f44.google.com with SMTP id w72so21346375wmf.1
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 04:39:26 -0700 (PDT)
From: Janis Danisevskis <jdanis@android.com>
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov,
 jwcart2@tycho.nsa.gov
Cc: Janis Danisevskis <jdanis@android.com>
Subject: [PATCH 1/3] libselinux: renamed andriod label backend source file
Date: Thu, 29 Sep 2016 12:39:17 +0100
Message-Id: <1475149159-21757-1-git-send-email-jdanis@android.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Janis Danisevskis <jdanis@android.com>
---
 libselinux/src/Makefile                 |   2 +-
 libselinux/src/label_android_property.c | 304 --------------------------------
 libselinux/src/label_backends_android.c | 304 ++++++++++++++++++++++++++++++++
 3 files changed, 305 insertions(+), 305 deletions(-)
 delete mode 100644 libselinux/src/label_android_property.c
 create mode 100644 libselinux/src/label_backends_android.c

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 2c61fad..cba8383 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -85,7 +85,7 @@ ifeq ($(ANDROID_HOST),y)
 DISABLE_FLAGS+= -DNO_MEDIA_BACKEND -DNO_DB_BACKEND -DNO_X_BACKEND \
 	-DBUILD_HOST
 SRCS= callbacks.c freecon.c label.c label_file.c \
-	label_android_property.c regex.c label_support.c \
+	label_backends_android.c regex.c label_support.c \
 	matchpathcon.c setrans_client.c sha1.c
 endif
 
diff --git a/libselinux/src/label_android_property.c b/libselinux/src/label_android_property.c
deleted file mode 100644
index 290b438..0000000
--- a/libselinux/src/label_android_property.c
+++ /dev/null
@@ -1,304 +0,0 @@
-/*
- * Property Service contexts backend for labeling Android
- * property keys
- */
-
-#include <stdarg.h>
-#include <string.h>
-#include <ctype.h>
-#include <errno.h>
-#include <limits.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include "callbacks.h"
-#include "label_internal.h"
-
-/* A property security context specification. */
-typedef struct spec {
-	struct selabel_lookup_rec lr;	/* holds contexts for lookup result */
-	char *property_key;		/* property key string */
-} spec_t;
-
-/* Our stored configuration */
-struct saved_data {
-	/*
-	 * The array of specifications is sorted for longest
-	 * prefix match
-	 */
-	spec_t *spec_arr;
-	unsigned int nspec;	/* total number of specifications */
-};
-
-static int cmp(const void *A, const void *B)
-{
-	const struct spec *sp1 = A, *sp2 = B;
-
-	if (strncmp(sp1->property_key, "*", 1) == 0)
-		return 1;
-	if (strncmp(sp2->property_key, "*", 1) == 0)
-		return -1;
-
-	size_t L1 = strlen(sp1->property_key);
-	size_t L2 = strlen(sp2->property_key);
-
-	return (L1 < L2) - (L1 > L2);
-}
-
-/*
- * Warn about duplicate specifications.
- */
-static int nodups_specs(struct saved_data *data, const char *path)
-{
-	int rc = 0;
-	unsigned int ii, jj;
-	struct spec *curr_spec, *spec_arr = data->spec_arr;
-
-	for (ii = 0; ii < data->nspec; ii++) {
-		curr_spec = &spec_arr[ii];
-		for (jj = ii + 1; jj < data->nspec; jj++) {
-			if (!strcmp(spec_arr[jj].property_key,
-					    curr_spec->property_key)) {
-				rc = -1;
-				errno = EINVAL;
-				if (strcmp(spec_arr[jj].lr.ctx_raw,
-						    curr_spec->lr.ctx_raw)) {
-					selinux_log
-						(SELINUX_ERROR,
-						 "%s: Multiple different specifications for %s  (%s and %s).\n",
-						 path, curr_spec->property_key,
-						 spec_arr[jj].lr.ctx_raw,
-						 curr_spec->lr.ctx_raw);
-				} else {
-					selinux_log
-						(SELINUX_ERROR,
-						 "%s: Multiple same specifications for %s.\n",
-						 path, curr_spec->property_key);
-				}
-			}
-		}
-	}
-	return rc;
-}
-
-static int process_line(struct selabel_handle *rec,
-			const char *path, char *line_buf,
-			int pass, unsigned lineno)
-{
-	int items;
-	char *prop = NULL, *context = NULL;
-	struct saved_data *data = (struct saved_data *)rec->data;
-	spec_t *spec_arr = data->spec_arr;
-	unsigned int nspec = data->nspec;
-	const char *errbuf = NULL;
-
-	items = read_spec_entries(line_buf, &errbuf, 2, &prop, &context);
-	if (items < 0) {
-		items = errno;
-		selinux_log(SELINUX_ERROR,
-			"%s:  line %u error due to: %s\n", path,
-			lineno, errbuf ?: strerror(errno));
-		errno = items;
-		return -1;
-	}
-
-	if (items == 0)
-		return items;
-
-	if (items != 2) {
-		selinux_log(SELINUX_ERROR,
-			    "%s:  line %u is missing fields\n", path,
-			    lineno);
-		free(prop);
-		errno = EINVAL;
-		return -1;
-	}
-
-	if (pass == 0) {
-		free(prop);
-		free(context);
-	} else if (pass == 1) {
-		/* On the second pass, process and store the specification in spec. */
-		spec_arr[nspec].property_key = prop;
-		spec_arr[nspec].lr.ctx_raw = context;
-
-		if (rec->validating) {
-			if (selabel_validate(rec, &spec_arr[nspec].lr) < 0) {
-				selinux_log(SELINUX_ERROR,
-					    "%s:  line %u has invalid context %s\n",
-					    path, lineno, spec_arr[nspec].lr.ctx_raw);
-				errno = EINVAL;
-				return -1;
-			}
-		}
-	}
-
-	data->nspec = ++nspec;
-	return 0;
-}
-
-static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
-		unsigned n)
-{
-	struct saved_data *data = (struct saved_data *)rec->data;
-	const char *path = NULL;
-	FILE *fp;
-	char line_buf[BUFSIZ];
-	unsigned int lineno, maxnspec, pass;
-	int status = -1;
-	struct stat sb;
-
-	/* Process arguments */
-	while (n--)
-		switch (opts[n].type) {
-		case SELABEL_OPT_PATH:
-			path = opts[n].value;
-			break;
-		}
-
-	if (!path)
-		return -1;
-
-	/* Open the specification file. */
-	if ((fp = fopen(path, "r")) == NULL)
-		return -1;
-
-	if (fstat(fileno(fp), &sb) < 0)
-		goto finish;
-	errno = EINVAL;
-	if (!S_ISREG(sb.st_mode))
-		goto finish;
-
-	/*
-	 * Two passes of the specification file. First is to get the size.
-	 * After the first pass, the spec array is malloced to the appropriate
-	 * size. Second pass is to populate the spec array and check for
-	 * dups.
-	 */
-	maxnspec = UINT_MAX / sizeof(spec_t);
-	for (pass = 0; pass < 2; pass++) {
-		data->nspec = 0;
-		lineno = 0;
-
-		while (fgets(line_buf, sizeof(line_buf) - 1, fp)
-		       && data->nspec < maxnspec) {
-			if (process_line(rec, path, line_buf, pass, ++lineno)
-									  != 0)
-				goto finish;
-		}
-
-		if (pass == 1) {
-			status = nodups_specs(data, path);
-
-			if (status)
-				goto finish;
-		}
-
-		if (pass == 0) {
-			if (data->nspec == 0) {
-				status = 0;
-				goto finish;
-			}
-
-			if (NULL == (data->spec_arr =
-				     malloc(sizeof(spec_t) * data->nspec)))
-				goto finish;
-
-			memset(data->spec_arr, 0, sizeof(spec_t) * data->nspec);
-			maxnspec = data->nspec;
-			rewind(fp);
-		}
-	}
-
-	qsort(data->spec_arr, data->nspec, sizeof(struct spec), cmp);
-
-	status = digest_add_specfile(rec->digest, fp, NULL, sb.st_size, path);
-	if (status)
-		goto finish;
-
-	digest_gen_hash(rec->digest);
-
-finish:
-	fclose(fp);
-	return status;
-}
-
-/*
- * Backend interface routines
- */
-static void closef(struct selabel_handle *rec)
-{
-	struct saved_data *data = (struct saved_data *)rec->data;
-	struct spec *spec;
-	unsigned int i;
-
-	for (i = 0; i < data->nspec; i++) {
-		spec = &data->spec_arr[i];
-		free(spec->property_key);
-		free(spec->lr.ctx_raw);
-		free(spec->lr.ctx_trans);
-	}
-
-	if (data->spec_arr)
-		free(data->spec_arr);
-
-	free(data);
-}
-
-static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
-					 const char *key,
-					 int __attribute__((unused)) type)
-{
-	struct saved_data *data = (struct saved_data *)rec->data;
-	spec_t *spec_arr = data->spec_arr;
-	unsigned int i;
-	struct selabel_lookup_rec *ret = NULL;
-
-	if (!data->nspec) {
-		errno = ENOENT;
-		goto finish;
-	}
-
-	for (i = 0; i < data->nspec; i++) {
-		if (strncmp(spec_arr[i].property_key, key,
-			    strlen(spec_arr[i].property_key)) == 0) {
-			break;
-		}
-		if (strncmp(spec_arr[i].property_key, "*", 1) == 0)
-			break;
-	}
-
-	if (i >= data->nspec) {
-		/* No matching specification. */
-		errno = ENOENT;
-		goto finish;
-	}
-
-	ret = &spec_arr[i].lr;
-
-finish:
-	return ret;
-}
-
-static void stats(struct selabel_handle __attribute__((unused)) *rec)
-{
-	selinux_log(SELINUX_WARNING, "'stats' functionality not implemented.\n");
-}
-
-int selabel_property_init(struct selabel_handle *rec,
-			  const struct selinux_opt *opts,
-			  unsigned nopts)
-{
-	struct saved_data *data;
-
-	data = (struct saved_data *)malloc(sizeof(*data));
-	if (!data)
-		return -1;
-	memset(data, 0, sizeof(*data));
-
-	rec->data = data;
-	rec->func_close = &closef;
-	rec->func_stats = &stats;
-	rec->func_lookup = &lookup;
-
-	return init(rec, opts, nopts);
-}
diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
new file mode 100644
index 0000000..290b438
--- /dev/null
+++ b/libselinux/src/label_backends_android.c
@@ -0,0 +1,304 @@
+/*
+ * Property Service contexts backend for labeling Android
+ * property keys
+ */
+
+#include <stdarg.h>
+#include <string.h>
+#include <ctype.h>
+#include <errno.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include "callbacks.h"
+#include "label_internal.h"
+
+/* A property security context specification. */
+typedef struct spec {
+	struct selabel_lookup_rec lr;	/* holds contexts for lookup result */
+	char *property_key;		/* property key string */
+} spec_t;
+
+/* Our stored configuration */
+struct saved_data {
+	/*
+	 * The array of specifications is sorted for longest
+	 * prefix match
+	 */
+	spec_t *spec_arr;
+	unsigned int nspec;	/* total number of specifications */
+};
+
+static int cmp(const void *A, const void *B)
+{
+	const struct spec *sp1 = A, *sp2 = B;
+
+	if (strncmp(sp1->property_key, "*", 1) == 0)
+		return 1;
+	if (strncmp(sp2->property_key, "*", 1) == 0)
+		return -1;
+
+	size_t L1 = strlen(sp1->property_key);
+	size_t L2 = strlen(sp2->property_key);
+
+	return (L1 < L2) - (L1 > L2);
+}
+
+/*
+ * Warn about duplicate specifications.
+ */
+static int nodups_specs(struct saved_data *data, const char *path)
+{
+	int rc = 0;
+	unsigned int ii, jj;
+	struct spec *curr_spec, *spec_arr = data->spec_arr;
+
+	for (ii = 0; ii < data->nspec; ii++) {
+		curr_spec = &spec_arr[ii];
+		for (jj = ii + 1; jj < data->nspec; jj++) {
+			if (!strcmp(spec_arr[jj].property_key,
+					    curr_spec->property_key)) {
+				rc = -1;
+				errno = EINVAL;
+				if (strcmp(spec_arr[jj].lr.ctx_raw,
+						    curr_spec->lr.ctx_raw)) {
+					selinux_log
+						(SELINUX_ERROR,
+						 "%s: Multiple different specifications for %s  (%s and %s).\n",
+						 path, curr_spec->property_key,
+						 spec_arr[jj].lr.ctx_raw,
+						 curr_spec->lr.ctx_raw);
+				} else {
+					selinux_log
+						(SELINUX_ERROR,
+						 "%s: Multiple same specifications for %s.\n",
+						 path, curr_spec->property_key);
+				}
+			}
+		}
+	}
+	return rc;
+}
+
+static int process_line(struct selabel_handle *rec,
+			const char *path, char *line_buf,
+			int pass, unsigned lineno)
+{
+	int items;
+	char *prop = NULL, *context = NULL;
+	struct saved_data *data = (struct saved_data *)rec->data;
+	spec_t *spec_arr = data->spec_arr;
+	unsigned int nspec = data->nspec;
+	const char *errbuf = NULL;
+
+	items = read_spec_entries(line_buf, &errbuf, 2, &prop, &context);
+	if (items < 0) {
+		items = errno;
+		selinux_log(SELINUX_ERROR,
+			"%s:  line %u error due to: %s\n", path,
+			lineno, errbuf ?: strerror(errno));
+		errno = items;
+		return -1;
+	}
+
+	if (items == 0)
+		return items;
+
+	if (items != 2) {
+		selinux_log(SELINUX_ERROR,
+			    "%s:  line %u is missing fields\n", path,
+			    lineno);
+		free(prop);
+		errno = EINVAL;
+		return -1;
+	}
+
+	if (pass == 0) {
+		free(prop);
+		free(context);
+	} else if (pass == 1) {
+		/* On the second pass, process and store the specification in spec. */
+		spec_arr[nspec].property_key = prop;
+		spec_arr[nspec].lr.ctx_raw = context;
+
+		if (rec->validating) {
+			if (selabel_validate(rec, &spec_arr[nspec].lr) < 0) {
+				selinux_log(SELINUX_ERROR,
+					    "%s:  line %u has invalid context %s\n",
+					    path, lineno, spec_arr[nspec].lr.ctx_raw);
+				errno = EINVAL;
+				return -1;
+			}
+		}
+	}
+
+	data->nspec = ++nspec;
+	return 0;
+}
+
+static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
+		unsigned n)
+{
+	struct saved_data *data = (struct saved_data *)rec->data;
+	const char *path = NULL;
+	FILE *fp;
+	char line_buf[BUFSIZ];
+	unsigned int lineno, maxnspec, pass;
+	int status = -1;
+	struct stat sb;
+
+	/* Process arguments */
+	while (n--)
+		switch (opts[n].type) {
+		case SELABEL_OPT_PATH:
+			path = opts[n].value;
+			break;
+		}
+
+	if (!path)
+		return -1;
+
+	/* Open the specification file. */
+	if ((fp = fopen(path, "r")) == NULL)
+		return -1;
+
+	if (fstat(fileno(fp), &sb) < 0)
+		goto finish;
+	errno = EINVAL;
+	if (!S_ISREG(sb.st_mode))
+		goto finish;
+
+	/*
+	 * Two passes of the specification file. First is to get the size.
+	 * After the first pass, the spec array is malloced to the appropriate
+	 * size. Second pass is to populate the spec array and check for
+	 * dups.
+	 */
+	maxnspec = UINT_MAX / sizeof(spec_t);
+	for (pass = 0; pass < 2; pass++) {
+		data->nspec = 0;
+		lineno = 0;
+
+		while (fgets(line_buf, sizeof(line_buf) - 1, fp)
+		       && data->nspec < maxnspec) {
+			if (process_line(rec, path, line_buf, pass, ++lineno)
+									  != 0)
+				goto finish;
+		}
+
+		if (pass == 1) {
+			status = nodups_specs(data, path);
+
+			if (status)
+				goto finish;
+		}
+
+		if (pass == 0) {
+			if (data->nspec == 0) {
+				status = 0;
+				goto finish;
+			}
+
+			if (NULL == (data->spec_arr =
+				     malloc(sizeof(spec_t) * data->nspec)))
+				goto finish;
+
+			memset(data->spec_arr, 0, sizeof(spec_t) * data->nspec);
+			maxnspec = data->nspec;
+			rewind(fp);
+		}
+	}
+
+	qsort(data->spec_arr, data->nspec, sizeof(struct spec), cmp);
+
+	status = digest_add_specfile(rec->digest, fp, NULL, sb.st_size, path);
+	if (status)
+		goto finish;
+
+	digest_gen_hash(rec->digest);
+
+finish:
+	fclose(fp);
+	return status;
+}
+
+/*
+ * Backend interface routines
+ */
+static void closef(struct selabel_handle *rec)
+{
+	struct saved_data *data = (struct saved_data *)rec->data;
+	struct spec *spec;
+	unsigned int i;
+
+	for (i = 0; i < data->nspec; i++) {
+		spec = &data->spec_arr[i];
+		free(spec->property_key);
+		free(spec->lr.ctx_raw);
+		free(spec->lr.ctx_trans);
+	}
+
+	if (data->spec_arr)
+		free(data->spec_arr);
+
+	free(data);
+}
+
+static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
+					 const char *key,
+					 int __attribute__((unused)) type)
+{
+	struct saved_data *data = (struct saved_data *)rec->data;
+	spec_t *spec_arr = data->spec_arr;
+	unsigned int i;
+	struct selabel_lookup_rec *ret = NULL;
+
+	if (!data->nspec) {
+		errno = ENOENT;
+		goto finish;
+	}
+
+	for (i = 0; i < data->nspec; i++) {
+		if (strncmp(spec_arr[i].property_key, key,
+			    strlen(spec_arr[i].property_key)) == 0) {
+			break;
+		}
+		if (strncmp(spec_arr[i].property_key, "*", 1) == 0)
+			break;
+	}
+
+	if (i >= data->nspec) {
+		/* No matching specification. */
+		errno = ENOENT;
+		goto finish;
+	}
+
+	ret = &spec_arr[i].lr;
+
+finish:
+	return ret;
+}
+
+static void stats(struct selabel_handle __attribute__((unused)) *rec)
+{
+	selinux_log(SELINUX_WARNING, "'stats' functionality not implemented.\n");
+}
+
+int selabel_property_init(struct selabel_handle *rec,
+			  const struct selinux_opt *opts,
+			  unsigned nopts)
+{
+	struct saved_data *data;
+
+	data = (struct saved_data *)malloc(sizeof(*data));
+	if (!data)
+		return -1;
+	memset(data, 0, sizeof(*data));
+
+	rec->data = data;
+	rec->func_close = &closef;
+	rec->func_stats = &stats;
+	rec->func_lookup = &lookup;
+
+	return init(rec, opts, nopts);
+}
-- 
1.9.1
