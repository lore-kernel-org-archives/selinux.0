Subject: [PATCH 4/5] libselinux: labeling API simple backend
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
In-Reply-To: <1163643926.15225.55.camel@moss-huskies.epoch.ncsc.mil>
References: <1163643926.15225.55.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-UhubDxCKdi/4jcAZrBjs"
Date: Thu, 16 Nov 2006 17:55:13 -0500
Message-Id: <1163717713.15225.143.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-UhubDxCKdi/4jcAZrBjs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is a simple, generic example labeling backend.  It expects files
stored under "<selinux_contexts_path>/<class_name>/<prefix>.contexts"
and right now just does a simple string compare from top to bottom until
a match is found or the "*" key is encountered.

More featureful wildcarding or regexp matching can be added in the
future if needed.

---
 libselinux/src/label_backend_simple.c |  281 ++++++++++++++++++
 1 file changed, 281 insertions(+)



-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--=-UhubDxCKdi/4jcAZrBjs
Content-Description: 
Content-Disposition: inline; filename=label4.patch
Content-Type: text/x-patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/src/label_backend_simple.c
===================================================================
--- libselinux/src/label_backend_simple.c	(revision 0)
+++ libselinux/src/label_backend_simple.c	(revision 0)
@@ -0,0 +1,281 @@
+/*
+ * Generic backend for labeling system
+ *
+ * Author : Eamon Walsh <ewalsh@tycho.nsa.gov>
+ */
+
+#include <sys/stat.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdio_ext.h>
+#include <ctype.h>
+#include <errno.h>
+#include <limits.h>
+#include <selinux/flask.h>
+#include <selinux/selinux.h>
+#include <selinux/label.h>
+#include <selinux/label_backend.h>
+#include "label_internal.h"
+
+/*
+ * Internals
+ */
+/*
+ * A context specification.
+ */
+typedef struct spec {
+	char *key_str;		/* key string */
+	char *context;		/* context string */
+	int context_valid;	/* context string has been validated */
+	int translated;		/* context string has been translated */
+	int matches;		/* number of matches made during operation */
+} spec_t;
+
+struct saved_conf {
+	security_class_t cls;
+	char prefix[LABEL_PREFIX_SIZE];
+	unsigned int flags;
+	unsigned int nspec;
+	spec_t *spec_arr;
+};
+
+static int process_line(const char *path, char *line_buf, int pass,
+			unsigned lineno, struct saved_conf *conf)
+{
+	int items, len;
+	char *buf_p;
+	char *key, *context;
+	len = strlen(line_buf);
+	if (line_buf[len - 1] == '\n')
+		line_buf[len - 1] = 0;
+	buf_p = line_buf;
+	while (isspace(*buf_p))
+		buf_p++;
+	/* Skip comment lines and empty lines. */
+	if (*buf_p == '#' || *buf_p == 0)
+		return 0;
+	items = sscanf(line_buf, "%as %as", &key, &context);
+	if (items < 2) {
+		label_log(LABEL_WARNING,
+			  "%s:  line %d is missing fields, skipping\n", path,
+			  lineno);
+		return 0;
+	}
+
+	if (pass == 1) {
+		/* On the second pass, store the specification in spec. */
+		if (conf->flags & LABEL_VALIDATE) {
+		    if (label_validate(conf->cls, &context)) {
+			label_log(LABEL_INVALIDCON,
+				  "%s:  line %u has invalid context %s\n",
+				  path, lineno, context);
+			return 0;
+		    }
+		    conf->spec_arr[conf->nspec].context_valid = 1;
+		}
+		conf->spec_arr[conf->nspec].key_str = key;
+		conf->spec_arr[conf->nspec].context = context;
+	}
+
+	conf->nspec++;
+	if (pass == 0) {
+		free(key);
+		free(context);
+	}
+	return 0;
+}
+
+/*
+ * Backend interface routines
+ */
+static void destroy(struct label_ops *ops)
+{
+	struct saved_conf *conf = (struct saved_conf *)ops->data;
+	struct spec *spec, *spec_arr = conf->spec_arr;
+	unsigned int i;
+
+	for (i = 0; i < conf->nspec; i++) {
+		spec = &spec_arr[i];
+		free(spec->key_str);
+		free(spec->context);
+	}
+	free(spec_arr);
+	conf->spec_arr = NULL;
+	conf->nspec = 0;
+}
+
+int configure(struct label_ops *ops, int flags, void *arg)
+{
+	FILE *fp;
+	struct saved_conf *conf = (struct saved_conf *)ops->data;
+	char path[PATH_MAX + 1];
+	char *line_buf = NULL;
+	size_t line_len = 0;
+	int status = -1;
+	unsigned int lineno, pass, maxnspec;
+	struct stat sb;
+
+	/* Reset previous configuration */
+	destroy(ops);
+	conf->flags = flags;
+
+	/* Open the specification file. */
+	if (arg)
+		strncpy(path, (char *)arg, PATH_MAX);
+	else
+		snprintf(path, PATH_MAX + 1, "%s/%s/%s.contexts", 
+			 selinux_contexts_path(),
+			 security_class_to_string(conf->cls),
+			 conf->prefix);
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
+	 * Perform two passes over the specification file.
+	 * The first pass counts the number of specifications and
+	 * performs simple validation of the input.  At the end
+	 * of the first pass, the spec array is allocated.
+	 * The second pass performs detailed validation of the input
+	 * and fills in the spec array.
+	 */
+	maxnspec = UINT_MAX / sizeof(spec_t);
+	for (pass = 0; pass < 2; pass++) {
+		lineno = 0;
+		conf->nspec = 0;
+		while (getline(&line_buf, &line_len, fp) > 0
+		       && conf->nspec < maxnspec) {
+			if (process_line(path, line_buf, pass, ++lineno, conf))
+				goto finish;
+		}
+		lineno = 0;
+
+		if (pass == 0) {
+			if (conf->nspec == 0) {
+				status = 0;
+				goto finish;
+			}
+			conf->spec_arr = malloc(sizeof(spec_t)*conf->nspec);
+			if (conf->spec_arr == NULL)
+				goto finish;
+			memset(conf->spec_arr, 0, sizeof(spec_t)*conf->nspec);
+			maxnspec = conf->nspec;
+			rewind(fp);
+		}
+	}
+	free(line_buf);
+
+	status = 0;
+finish:
+	fclose(fp);
+	return status;
+}
+
+static int lookup(struct label_ops *ops,
+		  const char *key, security_context_t *con)
+{
+	struct saved_conf *conf = (struct saved_conf *)ops->data;
+	unsigned int i, nspec = conf->nspec;
+	spec_t *spec_arr = conf->spec_arr;
+
+	for (i = 0; i < nspec; i++) {
+		if (!strncmp(spec_arr[i].key_str, key, strlen(key) + 1))
+			break;
+		if (!strncmp(spec_arr[i].key_str, "*", 2))
+			break;
+	}
+
+	if (i >= nspec) {
+		/* No matching specification. */
+		errno = ENOENT;
+		return -1;
+	}
+
+	spec_arr[i].matches++;
+	if (!spec_arr[i].context_valid && conf->flags & LABEL_VALIDATE) {
+		if (label_validate(conf->cls, &spec_arr[i].context)) {
+			label_log(LABEL_INVALIDCON,
+				  "%s:  line %u has invalid context %s\n",
+				  key, 0, spec_arr[i].context);
+			goto bad;
+		}
+		spec_arr[i].context_valid = 1;
+	}
+
+	if (!spec_arr[i].translated && conf->flags & LABEL_TRANS) {
+		char *tmpcon = NULL;
+		if (selinux_raw_to_trans_context(spec_arr[i].context, &tmpcon))
+			return -1;
+		free(spec_arr[i].context);
+		spec_arr[i].context = tmpcon;
+		spec_arr[i].translated = 1;
+	}
+
+	*con = strdup(spec_arr[i].context);
+	if (!(*con))
+		return -1;
+
+	return 0;
+
+bad:
+	errno = EINVAL;
+	return -1;
+}
+
+static void cache_stats(struct label_ops *ops)
+{
+	struct saved_conf *conf = (struct saved_conf *)ops->data;
+	unsigned int i, total = 0;
+
+	for (i = 0; i < conf->nspec; i++) {
+		total += strlen(conf->spec_arr[i].key_str) + 1;
+		total += strlen(conf->spec_arr[i].context) + 1;
+	}
+
+	label_log(LABEL_INFO, "%s: class %s, %u entries, %u bytes used.\n",
+		  conf->prefix, security_class_to_string(conf->cls),
+		  conf->nspec, conf->nspec*sizeof(spec_t) + total);
+}
+
+static void op_stats(struct label_ops *ops)
+{
+	struct saved_conf *conf = (struct saved_conf *)ops->data;
+	unsigned int i, total = 0;
+
+	for (i = 0; i < conf->nspec; i++)
+		total += conf->spec_arr[i].matches;
+
+	label_log(LABEL_INFO, "%s: class %s, %u entries, %u matches made\n",
+		  conf->prefix, security_class_to_string(conf->cls),
+		  conf->nspec, total);
+}
+
+int backend_simple_init(security_class_t cls, const char *prefix,
+			struct label_ops *ops)
+{
+	struct saved_conf *conf;
+
+	conf = (struct saved_conf *)label_malloc(sizeof(*conf));
+	if (!conf)
+		return -1;
+
+	memset(conf, 0, sizeof(*conf));
+	conf->cls = cls;
+	strncpy(conf->prefix, prefix, LABEL_PREFIX_SIZE - 1);
+
+	ops->data = conf;
+	ops->func_configure = &configure;
+	ops->func_destroy = &destroy;
+	ops->func_lookup = &lookup;
+	ops->func_cache_stats = &cache_stats;
+	ops->func_op_stats = &op_stats;
+
+	return 0;
+}

--=-UhubDxCKdi/4jcAZrBjs--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
