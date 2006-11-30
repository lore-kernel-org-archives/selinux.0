Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAU4J5pf012532
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 23:19:05 -0500
Received: from facesaver.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAU4HNtE022454
	for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2006 04:17:23 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies [144.51.25.7])
	by facesaver.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAU4E018015258
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 23:14:00 -0500
Subject: [PATCH 4/5] libselinux: labeling API simple backend
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: selinux@tycho.nsa.gov
In-Reply-To: <1164858471.2794.192.camel@moss-huskies.epoch.ncsc.mil>
References: <1164858471.2794.192.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-N1maQZ5U117wju8x7aEX"
Date: Wed, 29 Nov 2006 23:19:05 -0500
Message-Id: <1164860345.2794.213.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-N1maQZ5U117wju8x7aEX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is a simple, generic example labeling backend.  It expects files
stored under "<selinux_contexts_path>/<class_name>/<prefix>.contexts"
and right now just does a simple string compare from top to bottom until
a match is found or the "*" key is encountered.

More featureful wildcarding or regexp matching can be added in the
future if needed.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>

---
 libselinux/src/label_backend_generic.c |  273 +++++++++++++++++
 1 file changed, 273 insertions(+)


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--=-N1maQZ5U117wju8x7aEX
Content-Description: 
Content-Disposition: inline; filename=label4.patch
Content-Type: text/x-patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/src/label_backend_generic.c
===================================================================
--- libselinux/src/label_backend_generic.c	(revision 0)
+++ libselinux/src/label_backend_generic.c	(revision 0)
@@ -0,0 +1,273 @@
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
+	unsigned int nspec;
+	spec_t *spec_arr;
+};
+
+static int process_line(const char *path, char *line_buf, int pass,
+			unsigned lineno, struct label_rec *rec)
+{
+	struct saved_conf *conf = (struct saved_conf *)rec->data;
+	int items, len;
+	char *buf_p;
+	char *key, *context;
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
+		if (rec->flags & LABEL_VALIDATE) {
+		    if (label_validate(rec->cls, &context)) {
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
+static int init(struct label_rec *rec, const char *path_arg)
+{
+	FILE *fp;
+	struct saved_conf *conf = (struct saved_conf *)rec->data;
+	char path[PATH_MAX + 1];
+	char *line_buf = NULL;
+	size_t line_len = 0;
+	int status = -1;
+	unsigned int lineno, pass, maxnspec;
+	struct stat sb;
+
+	/* Open the specification file. */
+	if (path_arg)
+		strncpy(path, path_arg, PATH_MAX);
+	else
+		snprintf(path, PATH_MAX + 1, "%s/%s/%s.contexts", 
+			 selinux_contexts_path(),
+			 security_class_to_string(rec->cls),
+			 rec->name);
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
+			if (process_line(path, line_buf, pass, ++lineno, rec))
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
+/*
+ * Backend interface routines
+ */
+static void destroy(struct label_rec *rec)
+{
+	struct saved_conf *conf = (struct saved_conf *)rec->data;
+	struct spec *spec, *spec_arr = conf->spec_arr;
+	unsigned int i;
+
+	for (i = 0; i < conf->nspec; i++) {
+		spec = &spec_arr[i];
+		free(spec->key_str);
+		free(spec->context);
+	}
+
+	if (spec_arr)
+	    free(spec_arr);
+
+	memset(conf, 0, sizeof(*conf));
+}
+
+static int lookup(struct label_rec *rec, const char *key,
+		  security_class_t cls, security_context_t *con)
+{
+	struct saved_conf *conf = (struct saved_conf *)rec->data;
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
+	if (!spec_arr[i].context_valid && rec->flags & LABEL_VALIDATE) {
+		if (label_validate(cls, &spec_arr[i].context)) {
+			label_log(LABEL_INVALIDCON,
+				  "%s:  line %u has invalid context %s\n",
+				  key, 0, spec_arr[i].context);
+			goto bad;
+		}
+		spec_arr[i].context_valid = 1;
+	}
+
+	if (!spec_arr[i].translated && rec->flags & LABEL_TRANS) {
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
+static void cache_stats(struct label_rec *rec)
+{
+	struct saved_conf *conf = (struct saved_conf *)rec->data;
+	unsigned int i, total = 0;
+
+	for (i = 0; i < conf->nspec; i++) {
+		total += strlen(conf->spec_arr[i].key_str) + 1;
+		total += strlen(conf->spec_arr[i].context) + 1;
+	}
+
+	label_log(LABEL_INFO, "%s: class %s, %u entries, %u bytes used.\n",
+		  rec->name, security_class_to_string(rec->cls),
+		  conf->nspec, conf->nspec*sizeof(spec_t) + total);
+}
+
+static void op_stats(struct label_rec *rec)
+{
+	struct saved_conf *conf = (struct saved_conf *)rec->data;
+	unsigned int i, total = 0;
+
+	for (i = 0; i < conf->nspec; i++)
+		total += conf->spec_arr[i].matches;
+
+	label_log(LABEL_INFO, "%s: class %s, %u entries, %u matches made\n",
+		  rec->name, security_class_to_string(rec->cls),
+		  conf->nspec, total);
+}
+
+int backend_generic_init(struct label_rec *rec, void *arg)
+{
+	struct saved_conf *conf;
+
+	conf = (struct saved_conf *)label_malloc(sizeof(*conf));
+	if (!conf)
+		return -1;
+	memset(conf, 0, sizeof(*conf));
+
+	rec->data = conf;
+	rec->func_destroy = &destroy;
+	rec->func_lookup = &lookup;
+	rec->func_cache_stats = &cache_stats;
+	rec->func_op_stats = &op_stats;
+
+	return init(rec, (char *)arg);
+}

--=-N1maQZ5U117wju8x7aEX--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
