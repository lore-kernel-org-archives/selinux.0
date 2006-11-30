Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAU4Morx012648
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 23:22:50 -0500
Received: from facesaver.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAU4L7tE022937
	for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2006 04:21:07 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies [144.51.25.7])
	by facesaver.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAU4HiY5015413
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 23:17:44 -0500
Subject: [PATCH 5/5] libselinux: labeling API file_contexts backend
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: selinux@tycho.nsa.gov
In-Reply-To: <1164858471.2794.192.camel@moss-huskies.epoch.ncsc.mil>
References: <1164858471.2794.192.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-OnCKBc28m1FS6xMIgpek"
Date: Wed, 29 Nov 2006 23:22:49 -0500
Message-Id: <1164860569.2794.217.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-OnCKBc28m1FS6xMIgpek
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This backend fully replicates the matchpathcon and matchmediacon
interfaces through the labeling front-end.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>

---
 libselinux/include/selinux/label_backend_file.h |   67 
 libselinux/src/label_backend_file.c             |  932 ++++++++++
 2 files changed, 999 insertions(+)


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--=-OnCKBc28m1FS6xMIgpek
Content-Description: 
Content-Disposition: inline; filename=label5.patch
Content-Type: text/x-patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/include/selinux/label_backend_file.h
===================================================================
--- libselinux/include/selinux/label_backend_file.h	(revision 0)
+++ libselinux/include/selinux/label_backend_file.h	(revision 0)
@@ -0,0 +1,67 @@
+/*
+ * Labeling interface for userspace object managers and others.
+ * File labeling backend specific things are kept here.
+ *
+ * Author : Eamon Walsh <ewalsh@tycho.nsa.gov>
+ */
+#ifndef _SELINUX_LABEL_BACKEND_FILE_H_
+#define _SELINUX_LABEL_BACKEND_FILE_H_
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * Pre-defined prefix arguments for use with this backend.
+ */
+	
+/* regular file contexts mode */
+#define FILE_CONTEXTS "_file_contexts"
+/* media contexts mode */
+#define MEDIA_CONTEXTS "_media_contexts"
+
+
+/*
+ * Extra configuration flags available with this backend.
+ */
+
+/* Enables inode tracking for use in relabeling operations, e.g. by setfiles */
+#define LABEL_FILE_INODE (1<<16)
+
+
+/*
+ * Additional configuration argument for this backend.
+ */
+	struct label_file_opts {
+		char *path;	/* base path of configuration to use */
+		char *prefix;	/* optimize lookups by using path prefix */
+		char *rootpath;	/* strip this prefix from lookup keys */
+	};
+
+
+/*
+ * Extra routines for this backend
+ */
+
+/**
+ * label_file_reset_inodes - Reset inode associations when tracking inodes.
+ * @handle: labeling handle, which must be associated with the file backend
+ *
+ * This function should only be called on labeling handles associated with the
+ * file backend and with the INODE_CONTEXTS configuration.  Clears the inode
+ * table in preparation for the next filesystem.
+ */
+	void label_file_reset_inodes(label_handle_t handle);
+
+
+/* 
+ * Extra values returned from label_lookup().
+ */
+
+/* A previous, conflicting match was found that dominates the current one */
+#define LABEL_FILE_CONFLICT	1
+
+#ifdef __cplusplus
+}
+#endif
+#endif				/* _SELINUX_LABEL_BACKEND_FILE_H_ */
Index: libselinux/src/label_backend_file.c
===================================================================
--- libselinux/src/label_backend_file.c	(revision 0)
+++ libselinux/src/label_backend_file.c	(revision 0)
@@ -0,0 +1,932 @@
+/*
+ * File contexts backend for labeling system
+ *
+ * Author : Eamon Walsh <ewalsh@tycho.nsa.gov>
+ * Author : Stephen Smalley <sds@tycho.nsa.gov>
+ *
+ * This library derived in part from setfiles and the setfiles.pl script
+ * developed by Secure Computing Corporation.
+ */
+
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdio_ext.h>
+#include <ctype.h>
+#include <errno.h>
+#include <limits.h>
+#include <regex.h>
+#include <selinux/flask.h>
+#include <selinux/selinux.h>
+#include <selinux/label.h>
+#include <selinux/label_backend_file.h>
+#include "label_internal.h"
+
+/*
+ * Internals, mostly moved over from matchpathcon.c
+ */
+
+/* A file security context specification. */
+typedef struct spec {
+	char *regex_str;	/* regular expession string for diagnostics */
+	char *type_str;		/* type string for diagnostic messages */
+	char *context;		/* context string */
+	int context_valid;	/* context string has been validated */
+	int translated;		/* context string has been translated */
+	regex_t regex;		/* compiled regular expression */
+	mode_t mode;		/* mode format value */
+	int matches;		/* number of matching pathnames */
+	int hasMetaChars;	/* regular expression has meta-chars */
+	int stem_id;		/* indicates which of the stem-compression
+				 * items it matches */
+} spec_t;
+
+/* An association between an inode and a specification. */
+#define HASH_BITS 16
+#define HASH_BUCKETS (1 << HASH_BITS)
+#define HASH_MASK (HASH_BUCKETS-1)
+
+typedef struct ino_spec {
+	ino_t ino;		/* inode number */
+	int specind;		/* index of specification in spec_arr */
+	char *file;		/* full pathname for conflict messages */
+	struct ino_spec *next;	/* next association in hash bucket chain */
+} ino_spec_t;
+
+/* A regular expression stem */
+typedef struct stem {
+	char *buf;
+	int len;
+} stem_t;
+
+/* Our stored configuration */
+struct saved_conf {
+	/*
+	 * The chroot'ed path option
+	 * path options.
+	 */
+	char *rootpath;
+	unsigned int rootpathlen;
+
+	/*
+	 * The array of specifications, initially in the same order as in 
+	 * the specification file. Sorting occurs based on hasMetaChars.
+	 */
+	spec_t *spec_arr;
+	unsigned int nspec;
+
+	/*
+	 * The array of regular expression stems.
+	 */
+	stem_t *stem_arr;
+	int num_stems;
+	int alloc_stems;
+
+	/*
+	 * The hash table of associations, hashed by inode number.
+	 * Chaining is used for collisions, with elements ordered by inode
+	 * number in each bucket.  Each hash bucket has a dummy header.
+	 */
+	ino_spec_t *fl_head;
+};
+
+/* Return the length of the text that can be considered the stem, returns 0
+ * if there is no identifiable stem */
+static int get_stem_from_spec(const char *const buf)
+{
+	const char *tmp = strchr(buf + 1, '/');
+	const char *ind;
+
+	if (!tmp)
+		return 0;
+
+	for (ind = buf; ind < tmp; ind++) {
+		if (strchr(".^$?*+|[({", (int)*ind))
+			return 0;
+	}
+	return tmp - buf;
+}
+
+/* return the length of the text that is the stem of a file name */
+static int get_stem_from_file_name(const char *const buf)
+{
+	const char *tmp = strchr(buf + 1, '/');
+
+	if (!tmp)
+		return 0;
+	return tmp - buf;
+}
+
+/* find the stem of a file spec, returns the index into stem_arr for a new
+ * or existing stem, (or -1 if there is no possible stem - IE for a file in
+ * the root directory or a regex that is too complex for us).  Makes buf
+ * point to the text AFTER the stem. */
+static int find_stem_from_spec(struct saved_conf *conf, const char **buf)
+{
+	int i, num = conf->num_stems;
+	int stem_len = get_stem_from_spec(*buf);
+
+	if (!stem_len)
+		return -1;
+	for (i = 0; i < num; i++) {
+		if (stem_len == conf->stem_arr[i].len
+		    && !strncmp(*buf, conf->stem_arr[i].buf, stem_len)) {
+			*buf += stem_len;
+			return i;
+		}
+	}
+	if (conf->alloc_stems == num) {
+		stem_t *tmp_arr;
+		conf->alloc_stems = conf->alloc_stems * 2 + 16;
+		tmp_arr = realloc(conf->stem_arr,
+				  sizeof(stem_t) * conf->alloc_stems);
+		if (!tmp_arr)
+			return -1;
+		conf->stem_arr = tmp_arr;
+	}
+	conf->stem_arr[num].len = stem_len;
+	conf->stem_arr[num].buf = malloc(stem_len + 1);
+	if (!conf->stem_arr[num].buf)
+		return -1;
+	memcpy(conf->stem_arr[num].buf, *buf, stem_len);
+	conf->stem_arr[num].buf[stem_len] = '\0';
+	conf->num_stems++;
+	*buf += stem_len;
+	return num;
+}
+
+/* find the stem of a file name, returns the index into stem_arr (or -1 if
+ * there is no match - IE for a file in the root directory or a regex that is
+ * too complex for us).  Makes buf point to the text AFTER the stem. */
+static int find_stem_from_file(struct saved_conf *conf, const char **buf)
+{
+	int i;
+	int stem_len = get_stem_from_file_name(*buf);
+
+	if (!stem_len)
+		return -1;
+	for (i = 0; i < conf->num_stems; i++) {
+		if (stem_len == conf->stem_arr[i].len
+		    && !strncmp(*buf, conf->stem_arr[i].buf, stem_len)) {
+			*buf += stem_len;
+			return i;
+		}
+	}
+	return -1;
+}
+
+/*
+ * Warn about duplicate specifications.
+ */
+static void nodups_specs(struct saved_conf *conf, const char *path)
+{
+	unsigned int ii, jj;
+	struct spec *curr_spec, *spec_arr = conf->spec_arr;
+
+	for (ii = 0; ii < conf->nspec; ii++) {
+		curr_spec = &spec_arr[ii];
+		for (jj = ii + 1; jj < conf->nspec; jj++) {
+			if ((!strcmp
+			     (spec_arr[jj].regex_str, curr_spec->regex_str))
+			    && (!spec_arr[jj].mode || !curr_spec->mode
+				|| spec_arr[jj].mode == curr_spec->mode)) {
+				if (strcmp
+				    (spec_arr[jj].context,
+				     curr_spec->context)) {
+					label_log
+						(LABEL_WARNING,
+						 "%s: Multiple different specifications for %s  (%s and %s).\n",
+						 path, curr_spec->regex_str,
+						 spec_arr[jj].context,
+						 curr_spec->context);
+				} else {
+					label_log
+						(LABEL_WARNING,
+						 "%s: Multiple same specifications for %s.\n",
+						 path, curr_spec->regex_str);
+				}
+			}
+		}
+	}
+}
+
+/* Determine if the regular expression specification has any meta characters. */
+static void spec_hasMetaChars(struct spec *spec)
+{
+	char *c;
+	int len;
+	char *end;
+
+	c = spec->regex_str;
+	len = strlen(spec->regex_str);
+	end = c + len;
+
+	spec->hasMetaChars = 0;
+
+	/* Look at each character in the RE specification string for a 
+	 * meta character. Return when any meta character reached. */
+	while (c != end) {
+		switch (*c) {
+		case '.':
+		case '^':
+		case '$':
+		case '?':
+		case '*':
+		case '+':
+		case '|':
+		case '[':
+		case '(':
+		case '{':
+			spec->hasMetaChars = 1;
+			return;
+		case '\\':	/* skip the next character */
+			c++;
+			break;
+		default:
+			break;
+
+		}
+		c++;
+	}
+	return;
+}
+
+static mode_t mode_from_class(security_class_t cls)
+{
+	switch (cls) {
+	case SECCLASS_LNK_FILE:		return S_IFLNK;
+	case SECCLASS_CHR_FILE:		return S_IFCHR;
+	case SECCLASS_BLK_FILE:		return S_IFBLK;
+	case SECCLASS_SOCK_FILE:	return S_IFSOCK;
+	case SECCLASS_FIFO_FILE:	return S_IFIFO;
+	case SECCLASS_DIR:		return S_IFDIR;
+	default:			return S_IFREG;
+	}
+}
+
+static int process_line(struct saved_conf *conf, int flags,
+			const char *path, const char *prefix,
+			char *line_buf, int pass, unsigned lineno)
+{
+	int items, len, regerr;
+	char *buf_p, *regex, *anchored_regex, *type, *context;
+	const char *reg_buf;
+	spec_t *spec_arr = conf->spec_arr;
+	unsigned int nspec = conf->nspec;
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
+	items = sscanf(line_buf, "%as %as %as", &regex, &type, &context);
+	if (items < 2) {
+		label_log(LABEL_WARNING,
+			  "%s:  line %d is missing fields, skipping\n", path,
+			  lineno);
+		return 0;
+	} else if (items == 2) {
+		/* The type field is optional. */
+		free(context);
+		context = type;
+		type = 0;
+	}
+
+	reg_buf = regex;
+	len = get_stem_from_spec(reg_buf);
+	if (len && prefix && strncmp(prefix, regex, len)) {
+		/* Stem of regex does not match requested prefix, discard. */
+		free(regex);
+		free(type);
+		free(context);
+		return 0;
+	}
+
+	if (pass == 1) {
+		/* On the second pass, compile and store the specification in spec. */
+		char *cp;
+		spec_arr[nspec].stem_id = find_stem_from_spec(conf, &reg_buf);
+		spec_arr[nspec].regex_str = regex;
+
+		/* Anchor the regular expression. */
+		len = strlen(reg_buf);
+		cp = anchored_regex = malloc(len + 3);
+		if (!anchored_regex)
+			return -1;
+		/* Create ^...$ regexp.  */
+		*cp++ = '^';
+		cp = mempcpy(cp, reg_buf, len);
+		*cp++ = '$';
+		*cp = '\0';
+
+		/* Compile the regular expression. */
+		regerr =
+			regcomp(&spec_arr[nspec].regex,
+				anchored_regex, REG_EXTENDED | REG_NOSUB);
+		if (regerr != 0) {
+			size_t errsz = 0;
+			char *errbuf = NULL;
+			errsz = regerror(regerr, &spec_arr[nspec].regex,
+					 errbuf, errsz);
+			if (errsz)
+				errbuf = malloc(errsz);
+			if (errbuf)
+				(void)regerror(regerr,
+					       &spec_arr[nspec].regex,
+					       errbuf, errsz);
+			label_log(LABEL_WARNING,
+				  "%s:  line %d has invalid regex %s:  %s\n",
+				  path, lineno, anchored_regex,
+				  (errbuf ? errbuf : "out of memory"));
+			free(anchored_regex);
+			return 0;
+		}
+		free(anchored_regex);
+
+		/* Convert the type string to a mode format */
+		spec_arr[nspec].type_str = type;
+		spec_arr[nspec].mode = 0;
+		if (!type)
+			goto skip_type;
+		len = strlen(type);
+		if (type[0] != '-' || len != 2) {
+			label_log(LABEL_WARNING,
+				  "%s:  line %d has invalid file type %s\n",
+				  path, lineno, type);
+			return 0;
+		}
+		switch (type[1]) {
+		case 'b':
+			spec_arr[nspec].mode = S_IFBLK;
+			break;
+		case 'c':
+			spec_arr[nspec].mode = S_IFCHR;
+			break;
+		case 'd':
+			spec_arr[nspec].mode = S_IFDIR;
+			break;
+		case 'p':
+			spec_arr[nspec].mode = S_IFIFO;
+			break;
+		case 'l':
+			spec_arr[nspec].mode = S_IFLNK;
+			break;
+		case 's':
+			spec_arr[nspec].mode = S_IFSOCK;
+			break;
+		case '-':
+			spec_arr[nspec].mode = S_IFREG;
+			break;
+		default:
+			label_log(LABEL_WARNING,
+				  "%s:  line %d has invalid file type %s\n",
+				  path, lineno, type);
+			return 0;
+		}
+
+	skip_type:
+		if (flags & LABEL_VALIDATE && strcmp(context, "<<none>>")) {
+			if (label_validate(SECCLASS_FILE, &context)) {
+				label_log(LABEL_INVALIDCON,
+					  "%s:  line %u has invalid context %s\n",
+					  path, lineno, context);
+				return 0;
+			}
+			spec_arr[nspec].context_valid = 1;
+		}
+
+		spec_arr[nspec].context = context;
+
+		/* Determine if specification has 
+		 * any meta characters in the RE */
+		spec_hasMetaChars(&spec_arr[nspec]);
+	}
+
+	conf->nspec = ++nspec;
+	if (pass == 0) {
+		free(regex);
+		if (type)
+			free(type);
+		free(context);
+	}
+	return 0;
+}
+
+static int init(struct label_rec *rec, struct label_file_opts *opts)
+{
+	struct saved_conf *conf = (struct saved_conf *)rec->data;
+	const char *path, *prefix;
+	FILE *fp;
+	FILE *localfp = NULL;
+	FILE *homedirfp = NULL;
+	char local_path[PATH_MAX + 1];
+	char homedir_path[PATH_MAX + 1];
+	char *line_buf = NULL;
+	size_t line_len = 0;
+	unsigned int lineno, pass, i, j, maxnspec;
+	spec_t *spec_copy = NULL;
+	int status = -1, flags = rec->flags;
+	struct stat sb;
+
+	/* Process arguments */
+	path = opts->path ? opts->path : NULL;
+	prefix = opts->prefix ? opts->prefix : NULL;
+	if (opts->rootpath) {
+		conf->rootpathlen = strlen(opts->rootpath);
+		conf->rootpath = strdup(opts->rootpath);
+		if (!conf->rootpath)
+			return -1;
+	}
+
+	/* Open the specification file. */
+	if (!path)
+		path = selinux_file_context_path();
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
+	if ((flags & LABEL_BASEONLY) == 0) {
+		snprintf(homedir_path, sizeof(homedir_path), "%s.homedirs",
+			 path);
+		homedirfp = fopen(homedir_path, "r");
+		if (homedirfp != NULL)
+			__fsetlocking(homedirfp, FSETLOCKING_BYCALLER);
+
+		snprintf(local_path, sizeof(local_path), "%s.local", path);
+		localfp = fopen(local_path, "r");
+		if (localfp != NULL)
+			__fsetlocking(localfp, FSETLOCKING_BYCALLER);
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
+			if (process_line(conf, flags, path, prefix, line_buf,
+					 pass, ++lineno) != 0)
+				goto finish;
+		}
+		lineno = 0;
+		if (homedirfp)
+			while (getline(&line_buf, &line_len, homedirfp) > 0
+			       && conf->nspec < maxnspec) {
+				if (process_line
+				    (conf, flags, homedir_path, prefix,
+				     line_buf, pass, ++lineno) != 0)
+					goto finish;
+			}
+
+		lineno = 0;
+		if (localfp)
+			while (getline(&line_buf, &line_len, localfp) > 0
+			       && conf->nspec < maxnspec) {
+				if (process_line
+				    (conf, flags, local_path, prefix, line_buf,
+				     pass, ++lineno) != 0)
+					goto finish;
+			}
+
+		if (pass == 0) {
+			if (conf->nspec == 0) {
+				status = 0;
+				goto finish;
+			}
+			if (NULL == (conf->spec_arr =
+				     malloc(sizeof(spec_t) * conf->nspec)))
+				goto finish;
+			memset(conf->spec_arr, 0, sizeof(spec_t)*conf->nspec);
+			maxnspec = conf->nspec;
+			rewind(fp);
+			if (homedirfp)
+				rewind(homedirfp);
+			if (localfp)
+				rewind(localfp);
+		}
+	}
+	free(line_buf);
+
+	/* Move exact pathname specifications to the end. */
+	spec_copy = malloc(sizeof(spec_t) * conf->nspec);
+	if (!spec_copy)
+		goto finish;
+	j = 0;
+	for (i = 0; i < conf->nspec; i++)
+		if (conf->spec_arr[i].hasMetaChars)
+			memcpy(&spec_copy[j++],
+			       &conf->spec_arr[i], sizeof(spec_t));
+	for (i = 0; i < conf->nspec; i++)
+		if (!conf->spec_arr[i].hasMetaChars)
+			memcpy(&spec_copy[j++],
+			       &conf->spec_arr[i], sizeof(spec_t));
+	free(conf->spec_arr);
+	conf->spec_arr = spec_copy;
+
+	nodups_specs(conf, path);
+
+	status = 0;
+finish:
+	fclose(fp);
+	if (conf->spec_arr != spec_copy)
+		free(conf->spec_arr);
+	if (homedirfp)
+		fclose(homedirfp);
+	if (localfp)
+		fclose(localfp);
+	return status;
+}
+
+static int lookup_common(struct label_rec *rec, const char *key, mode_t mode)
+{
+	struct saved_conf *conf = (struct saved_conf *)rec->data;
+	int i, rc, file_stem;
+	const char *buf = key;
+	spec_t *spec_arr = conf->spec_arr;
+
+	if (!conf->nspec) {
+		errno = ENOENT;
+		return -1;
+	}
+
+	file_stem = find_stem_from_file(conf, &buf);
+
+	mode &= S_IFMT;
+
+	/* 
+	 * Check for matching specifications in reverse order, so that
+	 * the last matching specification is used.
+	 */
+	for (i = conf->nspec - 1; i >= 0; i--) {
+		/* if the spec in question matches no stem or has the same
+		 * stem as the file AND if the spec in question has no mode
+		 * specified or if the mode matches the file mode then we do
+		 * a regex check        */
+		if ((spec_arr[i].stem_id == -1
+		     || spec_arr[i].stem_id == file_stem)
+		    && (!mode || !spec_arr[i].mode
+			|| ((mode & S_IFMT) == spec_arr[i].mode))) {
+			if (spec_arr[i].stem_id == -1)
+				rc = regexec(&spec_arr[i].regex, key, 0, 0, 0);
+			else
+				rc = regexec(&spec_arr[i].regex, buf, 0, 0, 0);
+			if (rc == 0)
+				break;
+
+			if (rc == REG_NOMATCH)
+				continue;
+			/* else it's an error */
+			return -1;
+		}
+	}
+
+	if (i < 0) {
+		/* No matching specification. */
+		errno = ENOENT;
+		return -1;
+	}
+
+	spec_arr[i].matches++;
+
+	return i;
+}
+
+/*
+ * Try to add an association between an inode and
+ * a specification.  If there is already an association
+ * for the inode and it conflicts with this specification,
+ * then use the specification that occurs later in the
+ * specification array.
+ */
+static int filespec_add(struct saved_conf *conf, ino_t ino,
+			int specind, const char *file)
+{
+	ino_spec_t *prevfl, *fl;
+	int h, no_conflict, ret;
+	struct stat sb;
+	spec_t *spec_arr = conf->spec_arr;
+
+	if (!conf->fl_head) {
+		conf->fl_head = malloc(sizeof(ino_spec_t) * HASH_BUCKETS);
+		if (!conf->fl_head)
+			goto oom;
+		memset(conf->fl_head, 0, sizeof(ino_spec_t) * HASH_BUCKETS);
+	}
+
+	h = (ino + (ino >> HASH_BITS)) & HASH_MASK;
+	for (prevfl = &conf->fl_head[h], fl = conf->fl_head[h].next; fl;
+	     prevfl = fl, fl = fl->next) {
+		if (ino == fl->ino) {
+			ret = lstat(fl->file, &sb);
+			if (ret < 0 || sb.st_ino != ino) {
+				fl->specind = specind;
+				free(fl->file);
+				fl->file = malloc(strlen(file) + 1);
+				if (!fl->file)
+					goto oom;
+				strcpy(fl->file, file);
+				return fl->specind;
+
+			}
+
+			no_conflict =
+				(strcmp
+				 (spec_arr[fl->specind].context,
+				  spec_arr[specind].context) == 0);
+			if (no_conflict)
+				return fl->specind;
+
+			label_log(LABEL_WARNING,
+				  "%s:  conflicting specifications for %s and %s, using %s.\n",
+				  __FUNCTION__, file, fl->file,
+				  ((specind >
+				    fl->specind) ? spec_arr[specind].
+				   context : spec_arr[fl->specind].context));
+			fl->specind =
+			    (specind > fl->specind) ? specind : fl->specind;
+			free(fl->file);
+			fl->file = malloc(strlen(file) + 1);
+			if (!fl->file)
+				goto oom;
+			strcpy(fl->file, file);
+			return fl->specind;
+		}
+
+		if (ino > fl->ino)
+			break;
+	}
+
+	fl = malloc(sizeof(ino_spec_t));
+	if (!fl)
+		goto oom;
+	fl->ino = ino;
+	fl->specind = specind;
+	fl->file = malloc(strlen(file) + 1);
+	if (!fl->file)
+		goto oom_freefl;
+	strcpy(fl->file, file);
+	fl->next = prevfl->next;
+	prevfl->next = fl;
+	return fl->specind;
+oom_freefl:
+	free(fl);
+oom:
+	label_log(LABEL_ERROR,
+		  "%s:  insufficient memory for file label entry for %s\n",
+		  __FUNCTION__, file);
+	return -1;
+}
+
+/* Destroy the association hash table. */
+static void filespec_destroy(struct saved_conf *conf)
+{
+	ino_spec_t *fl, *tmp;
+	int h;
+
+	if (!conf->fl_head)
+		return;
+
+	for (h = 0; h < HASH_BUCKETS; h++) {
+		fl = conf->fl_head[h].next;
+		while (fl) {
+			tmp = fl;
+			fl = fl->next;
+			free(tmp->file);
+			free(tmp);
+		}
+		conf->fl_head[h].next = NULL;
+	}
+	free(conf->fl_head);
+	conf->fl_head = NULL;
+}
+
+/*
+ * Backend interface routines
+ */
+static void destroy(struct label_rec *rec)
+{
+	struct saved_conf *conf = (struct saved_conf *)rec->data;
+	struct spec *spec;
+	struct stem *stem;
+	unsigned int i;
+
+	filespec_destroy(conf);
+
+	for (i = 0; i < conf->nspec; i++) {
+		spec = &conf->spec_arr[i];
+		free(spec->regex_str);
+		free(spec->type_str);
+		free(spec->context);
+		regfree(&spec->regex);
+	}
+
+	for (i = 0; i < (unsigned int)conf->num_stems; i++) {
+		stem = &conf->stem_arr[i];
+		free(stem->buf);
+	}
+
+	if (conf->spec_arr)
+		free(conf->spec_arr);
+	if (conf->stem_arr)
+		free(conf->stem_arr);
+	if (conf->rootpath)
+		free(conf->rootpath);
+	
+	memset(conf, 0, sizeof(*conf));
+}
+
+static int lookup_index(struct label_rec *rec, const char *name,
+			security_class_t cls __attribute__ ((unused)),
+			security_context_t *con)
+{
+	struct saved_conf *conf = (struct saved_conf *)rec->data;
+	int i, rc;
+	struct stat sb;
+	const char *fullname = name;
+
+	/* fullname will be the real file that gets labeled
+	 * name will be what is matched in the policy */
+	if (NULL != conf->rootpath) {
+		if (0 != strncmp(conf->rootpath, name, conf->rootpathlen)) {
+			fprintf(stderr, "%s is not located in %s\n",
+				name, conf->rootpath);
+			return -1;
+		}
+		name += conf->rootpathlen;
+	}
+	if(lstat(fullname, &sb)) {
+		label_log(LABEL_ERROR, "unable to stat file %s\n", fullname);
+		return -1;
+	}
+	if (conf->rootpath != NULL && name[0] == '\0')
+		/* this is actually the root dir of the alt root */
+		name = "/";
+
+	i = lookup_common(rec, name, sb.st_mode);
+	if (i < 0)
+		return -1;
+
+	rc = filespec_add(conf, sb.st_ino, i, fullname);
+	if (rc < 0)
+		return rc;
+	if (rc > 0 && rc != i)
+		return LABEL_FILE_CONFLICT;
+
+	*con = strdup(conf->spec_arr[i].context);
+	if (!(*con))
+		return -1;
+
+	return 0;
+}
+
+static int lookup(struct label_rec *rec, const char *key,
+		  security_class_t cls, security_context_t *con)
+{
+	struct saved_conf *conf = (struct saved_conf *)rec->data;
+	spec_t *spec_arr = conf->spec_arr;
+	int i = lookup_common(rec, key, mode_from_class(cls));
+	if (i < 0)
+		return -1;
+
+	if (strcmp(spec_arr[i].context, "<<none>>") == 0) {
+		errno = ENOENT;
+		return -1;
+	}
+
+	if (!spec_arr[i].context_valid) {
+		if (label_validate(SECCLASS_FILE, &spec_arr[i].context)) {
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
+	ino_spec_t *fl;
+	int h, used, nel, len, longest;
+
+	if (!conf->fl_head)
+		return;
+
+	used = 0;
+	longest = 0;
+	nel = 0;
+	for (h = 0; h < HASH_BUCKETS; h++) {
+		len = 0;
+		for (fl = conf->fl_head[h].next; fl; fl = fl->next) {
+			len++;
+		}
+		if (len)
+			used++;
+		if (len > longest)
+			longest = len;
+		nel += len;
+	}
+
+	label_log(LABEL_INFO,
+		  "%s:  hash table stats: %d elements, %d/%d buckets used, longest chain length %d\n",
+		  __FUNCTION__, nel, used, HASH_BUCKETS, longest);
+}
+
+static void op_stats(struct label_rec *rec)
+{
+	struct saved_conf *conf = (struct saved_conf *)rec->data;
+	unsigned int i, nspec = conf->nspec;
+	spec_t *spec_arr = conf->spec_arr;
+
+	for (i = 0; i < nspec; i++) {
+		if (spec_arr[i].matches == 0) {
+			if (spec_arr[i].type_str) {
+				label_log(LABEL_WARNING,
+				    "Warning!  No matches for (%s, %s, %s)\n",
+				    spec_arr[i].regex_str,
+				    spec_arr[i].type_str, spec_arr[i].context);
+			} else {
+				label_log(LABEL_WARNING,
+				    "Warning!  No matches for (%s, %s)\n",
+				    spec_arr[i].regex_str,
+				    spec_arr[i].context);
+			}
+		}
+	}
+}
+
+int backend_file_init(struct label_rec *rec, void *arg)
+{
+	struct saved_conf *conf;
+	struct label_file_opts defaults = {NULL, NULL, NULL};
+
+	/* redirect media contexts configuration to the media backend */
+	if (!strncmp(rec->name, MEDIA_CONTEXTS, sizeof(MEDIA_CONTEXTS)))
+		return backend_media_init(rec, arg);
+
+	/*
+	 * at this point it is assumed that rec->name is FILE_CONTEXTS;
+	 * something special could be done here by package name, etc.
+	 */
+	conf = (struct saved_conf *)label_malloc(sizeof(*conf));
+	if (!conf)
+		return -1;
+	memset(conf, 0, sizeof(*conf));
+
+	rec->data = conf;
+	rec->func_destroy = &destroy;
+	rec->func_cache_stats = &cache_stats;
+	rec->func_op_stats = &op_stats;
+	rec->func_lookup = (rec->flags & LABEL_FILE_INODE) ?
+		&lookup_index : &lookup;
+
+	return init(rec, arg ? (struct label_file_opts *)arg : &defaults);
+}
+
+/*
+ * Backend public routines
+ */
+void label_file_reset_inodes(struct label_rec *rec)
+{
+	filespec_destroy((struct saved_conf *)rec->data);
+}

--=-OnCKBc28m1FS6xMIgpek--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
