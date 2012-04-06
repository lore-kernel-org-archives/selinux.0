Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q39DNjh3006288
	for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2012 09:23:45 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.5/8.14.5) with ESMTP id q39DOZG1002919
	for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2012 09:24:35 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.5/8.14.5/Submit) id q39DOYZx002918
	for selinux@tycho.nsa.gov; Mon, 9 Apr 2012 09:24:34 -0400
Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q36KJh0d008197
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2012 16:19:43 -0400
Message-ID: <4F7F4FD5.30108@tycho.ncsc.mil>
Date: Fri, 06 Apr 2012 16:19:33 -0400
From: rpcraig <rpcraig@tycho.ncsc.mil>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: libselinux: Provide new labeling backend
Content-Type: multipart/mixed;
 boundary="------------070109080202070301050805"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070109080202070301050805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have attached a patch which provides a new labeling backend
directed at the Android property service keys.

--------------070109080202070301050805
Content-Type: text/x-patch;
 name="0001-New-Android-property-labeling-backend.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-New-Android-property-labeling-backend.patch"

>From 1116054b1b9f6ab51f197613fa2a6e0d739e6ec8 Mon Sep 17 00:00:00 2001
From: rpcraig <rpcraig@tycho.ncsc.mil>
Date: Fri, 6 Apr 2012 15:54:29 -0400
Subject: [PATCH] New Android property labeling backend

---
 libselinux/include/selinux/label.h      |    2 +
 libselinux/src/label.c                  |    1 +
 libselinux/src/label_android_property.c |  296 +++++++++++++++++++++++++++++++
 libselinux/src/label_internal.h         |    2 +
 4 files changed, 301 insertions(+), 0 deletions(-)
 create mode 100644 libselinux/src/label_android_property.c

diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index 1a54307..8263f32 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -31,6 +31,8 @@ struct selabel_handle;
 #define SELABEL_CTX_X		2
 /* db objects */
 #define SELABEL_CTX_DB		3
+/* Android property service contexts */
+#define SELABEL_CTX_ANDROID_PROP 4
 
 /*
  * Available options
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index a9e0853..0a5bc39 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -24,6 +24,7 @@ static selabel_initfunc initfuncs[] = {
 	&selabel_media_init,
 	&selabel_x_init,
 	&selabel_db_init,
+	&selabel_property_init,
 };
 
 static void selabel_subs_fini(struct selabel_sub *ptr)
diff --git a/libselinux/src/label_android_property.c b/libselinux/src/label_android_property.c
new file mode 100644
index 0000000..2a4c3b0
--- /dev/null
+++ b/libselinux/src/label_android_property.c
@@ -0,0 +1,296 @@
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
+	struct selabel_lookup_rec lr;    /* holds contexts for lookup result */
+	char *property_key;              /* property key string */
+} spec_t;
+
+/* Our stored configuration */
+struct saved_data {
+	/*
+	 * The array of specifications is sorted for longest
+	 * prefix match
+	 */
+	spec_t *spec_arr;
+	unsigned int nspec; /* total number of specifications */
+};
+
+static int cmp(const void *A, const void *B)
+{
+	const struct spec *sp1 = A, *sp2 = B;
+
+	if (strncmp(sp1->property_key,"*",1) == 0)
+		return 1;
+	if (strncmp(sp2->property_key,"*",1) == 0)
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
+			if ((!strcmp(spec_arr[jj].property_key, curr_spec->property_key))) {
+				rc = -1;
+				errno = EINVAL;
+				if (strcmp
+				    (spec_arr[jj].lr.ctx_raw,
+				     curr_spec->lr.ctx_raw)) {
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
+	int items, len;
+	char buf1[BUFSIZ], buf2[BUFSIZ];
+	char *buf_p, *prop = buf1, *context = buf2;
+	struct saved_data *data = (struct saved_data *)rec->data;
+	spec_t *spec_arr = data->spec_arr;
+	unsigned int nspec = data->nspec;
+
+	len = strlen(line_buf);
+	if (line_buf[len - 1] == '\n')
+		line_buf[len - 1] = 0;
+	buf_p = line_buf;
+	while (isspace(*buf_p))
+		buf_p++;
+	/* Skip comment lines and empty lines. */
+	if (*buf_p == '#' || *buf_p == 0)
+		return 0;
+	items = sscanf(line_buf, "%255s %255s", prop, context);
+	if (items != 2) {
+		selinux_log(SELINUX_WARNING,
+			    "%s:  line %d is missing fields, skipping\n", path,
+			    lineno);
+		return 0;
+	}
+
+	if (pass == 1) {
+		/* On the second pass, process and store the specification in spec. */
+		spec_arr[nspec].property_key = strdup(prop);
+		if (!spec_arr[nspec].property_key) {
+			selinux_log(SELINUX_WARNING,
+				    "%s:  out of memory at line %d on prop %s\n",
+				    path, lineno, prop);
+		return -1;
+	    
+		}
+
+		spec_arr[nspec].lr.ctx_raw = strdup(context);
+		if (!spec_arr[nspec].lr.ctx_raw) {
+			selinux_log(SELINUX_WARNING,
+				    "%s:  out of memory at line %d on context %s\n",
+				    path, lineno, context);
+		return -1;
+		}
+     	}
+
+	data->nspec = ++nspec;
+	return 0;
+}
+
+static int init(struct selabel_handle *rec, struct selinux_opt *opts,
+		unsigned n)
+{
+	struct saved_data *data = (struct saved_data *)rec->data;
+	const char *path = NULL;
+	FILE *fp;
+	char line_buf[BUFSIZ];
+	unsigned int lineno = 0, maxnspec, pass;
+	int status = -1;
+	struct stat sb;
+
+	/* Process arguments */
+	while (n--)
+		switch (opts[n].type) {
+		case SELABEL_OPT_PATH:
+			path = opts[n].value;
+			break;
+		default:
+			selinux_log(SELINUX_WARNING,
+				    "Argument type (%d) not recognized. Skipping\n", opts[n].type);
+			break;
+		}
+
+	/* Open the specification file. */
+	if ((fp = fopen(path, "r")) == NULL)
+		return -1;
+
+	if (fstat(fileno(fp), &sb) < 0)
+		return -1;
+	if (!S_ISREG(sb.st_mode)) {
+		errno = EINVAL;
+		return -1;
+	}
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
+
+		while (fgets(line_buf, sizeof line_buf - 1, fp)
+		       && data->nspec < maxnspec) {
+			if (process_line(rec, path, line_buf, pass, ++lineno) != 0) {
+				goto finish;
+			}
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
+
+			if (data->nspec == 0) {
+				status = 0;
+				goto finish;
+			}
+
+			if (NULL == (data->spec_arr =
+				     malloc(sizeof(spec_t) * data->nspec)))
+				goto finish;
+
+			memset(data->spec_arr, 0, sizeof(spec_t)*data->nspec);
+			maxnspec = data->nspec;
+			rewind(fp);
+		}
+	}
+
+	qsort(data->spec_arr, data->nspec, sizeof(struct spec), cmp);
+
+	status = 0;
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
+		    strlen(spec_arr[i].property_key)) == 0) {
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
+int selabel_property_init(struct selabel_handle *rec, struct selinux_opt *opts,
+		      unsigned nopts)
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
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 79d5495..435ecf2 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -25,6 +25,8 @@ int selabel_x_init(struct selabel_handle *rec, struct selinux_opt *opts,
 		   unsigned nopts) hidden;
 int selabel_db_init(struct selabel_handle *rec,
 		    struct selinux_opt *opts, unsigned nopts) hidden;
+int selabel_property_init(struct selabel_handle *rec,
+			  struct selinux_opt *opts, unsigned nopts) hidden;
 
 /*
  * Labeling internal structures
-- 
1.7.5.4


--------------070109080202070301050805--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
