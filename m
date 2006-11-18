Subject: [PATCH 0/5] libselinux: one large patch
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
In-Reply-To: <1163643926.15225.55.camel@moss-huskies.epoch.ncsc.mil>
References: <1163643926.15225.55.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-LZKQTVbOqP8Xaz7NUsGD"
Date: Fri, 17 Nov 2006 19:46:30 -0500
Message-Id: <1163810790.15225.162.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-LZKQTVbOqP8Xaz7NUsGD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

One large patch containing everything; applies to repository root with
-p0.

---
 libselinux/include/selinux/label.h              |  181 +
 libselinux/include/selinux/label_backend.h      |   20 
 libselinux/include/selinux/label_backend_file.h |   54 
 libselinux/include/selinux/selinux.h            |    3 
 libselinux/src/avc.c                            |    8 
 libselinux/src/label.c                          |  234 ++
 libselinux/src/label_backend_file.c             | 1013 ++++++++++
 libselinux/src/label_backend_simple.c           |  281 ++
 libselinux/src/label_internal.c                 |   25 
 libselinux/src/label_internal.h                 |  128 +
 10 files changed, 1946 insertions(+), 1 deletion(-)


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--=-LZKQTVbOqP8Xaz7NUsGD
Content-Description: 
Content-Disposition: inline; filename=label.patch
Content-Type: text/x-patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/include/selinux/label.h
===================================================================
--- libselinux/include/selinux/label.h	(revision 0)
+++ libselinux/include/selinux/label.h	(revision 0)
@@ -0,0 +1,181 @@
+/*
+ * Labeling interface for userspace object managers and others.
+ *
+ * Author : Eamon Walsh <ewalsh@tycho.nsa.gov>
+ */
+#ifndef _SELINUX_LABEL_H_
+#define _SELINUX_LABEL_H_
+
+#include <sys/types.h>
+#include <selinux/selinux.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * User-provided callbacks for memory, logging, locking, and extra actions
+ */
+
+/* These structures are passed by reference to label_init().  Passing
+ * a NULL reference will cause a default to be used.  The default
+ * memory callbacks are malloc() and free().  The default logging method
+ * is to print on stderr.  The default validation callback is based on
+ * selinux_check_context().  If no locking callbacks are passed, no locking
+ * will take place.
+ */
+	struct label_memory_callback {
+		/* malloc() equivalent. */
+		void *(*func_malloc) (size_t size);
+		/* free() equivalent. */
+		void (*func_free) (void *ptr);
+		/* Note that these functions should set errno on failure.
+		   If not, some routines may return -1 without errno set. */
+	};
+
+	struct label_log_callback {
+		/* log the printf-style format and arguments,
+		   with the type code indicating the type of message */
+		int (*func_log) (int type, const char *fmt, ...);
+	};
+
+	struct label_action_callback {
+		/* validate the supplied context, making changes if necessary,
+		   returning 0 if valid or -1 with errno set otherwise. */
+		int (*func_validate) (security_class_t cls, char **context);
+	};
+
+	struct label_lock_callback {
+		/* create a lock and return an opaque pointer to it. */
+		void *(*func_alloc_lock) (void);
+		/* obtain a given lock, blocking if necessary. */
+		void (*func_get_lock) (void *lock);
+		/* release a given lock. */
+		void (*func_release_lock) (void *lock);
+		/* destroy a given lock (free memory, etc.) */
+		void (*func_free_lock) (void *lock);
+	};
+
+/* Logging type codes, passed to the logging callback */
+#define LABEL_ERROR		0
+#define LABEL_WARNING		1
+#define LABEL_INFO		2
+#define LABEL_INVALIDCON	3
+
+/*
+ * Label operations
+ */
+
+/**
+ * label_init - Initialize the labeling system.
+ * @prefix: used by the backend for selecting a configuration or package
+ * @mem_callbacks: user-supplied memory callbacks
+ * @log_callbacks: user-supplied logging callbacks
+ * @action_callbacks: user-supplied validation callbacks
+ * @lock_callbacks: user-supplied locking callbacks
+ *
+ * Initialize the labeling subsystem.  Return %0 on success or -%1 with @errno
+ * set on failure.  Argument @name must not be NULL or empty.  If any callback 
+ * structure references are NULL, use default methods for those callbacks (see
+ * the definition of the callback structures above).
+ */
+	int label_init(const char *prefix,
+		       const struct label_memory_callback *mem_callbacks,
+		       const struct label_log_callback *log_callbacks,
+		       const struct label_action_callback *action_callbacks,
+		       const struct label_lock_callback *lock_callbacks);
+
+/**
+ * label_change_name - Change system prefix
+ * @prefix: used by the backend for selecting a configuration or package
+ *
+ * Change the prefix string used by the labeling system on future calls.  This
+ * function may be called multiple times.  Backend configurations are kept
+ * separately by prefix, meaning that after a call to this function, calls to
+ * label_configure() may be necessary to re-initialize backends.  However, 
+ * switching back to a prefix will preserve any configuration made previously
+ * while that prefix was in effect.
+ */
+	void label_change_name(const char *prefix);
+
+/**
+ * label_configure - Configure specific labeling backend.
+ * @cls: specifies the backend to configure
+ * @flags: global and/or backend-specific configuration flags
+ * @arg: additional backend-specific configuration data
+ *
+ * Configure a specific labeling backend.  This function should be called
+ * after a successful call to label_init and is optional; it will be called
+ * automatically with default arguments by label_lookup if necessary.  The
+ * result of the call depends on the specific flags and the backend, although
+ * typically the backend will reset its internal state.  Return %0 on success
+ * or -%1 with @errno set on failure.  
+ */
+	int label_configure(security_class_t cls,
+			    int flags,
+			    void *arg);
+
+/* Global flags available for use on all backends.  Note that the first 16
+ * bits are reserved for this purpose, while the next 16 are for backend flags.
+ */
+#define LABEL_BASEONLY		1 /* Don't use local configuration overrides */
+#define LABEL_TRANS		2 /* Translate contexts */
+#define LABEL_VALIDATE		4 /* Validate/canonicalize contexts */ 
+
+/**
+ * label_reset - Configure specific labeling backend using the defaults.
+ * @cls: specifies the backend to configure
+ *
+ * Configure a specific labeling backend.  Equivalent to calling 
+ * label_configure with a flags argument of %0 and an arg of NULL.
+ * Return %0 on success or -%1 with @errno set on failure.
+ */
+	int label_reset(security_class_t cls);
+
+/**
+ * label_destroy - Free all labeling structures.
+ *
+ * Destroy all labeling structures, close all backends, and free all allocated
+ * memory.  User-supplied callbacks will be retained, but any backend 
+ * configuration will not.  User must call label_init() if further use
+ * of labeling subsystem is desired.
+ */
+	void label_destroy(void);
+
+/**
+ * label_lookup - Perform labeling lookup operation.
+ * @key: backend-specific string representation of object being labeled
+ * @cls: class of object being labeled; along with prefix, selects backend
+ * @con: returns the appropriate context with which to label the object
+ *
+ * Perform a labeling lookup operation.  Return %0 on success, -%1 with
+ * @errno set on failure.  Some backends may return additional, positive
+ * values indicating qualified success.
+ */
+	int label_lookup(const char *key, security_class_t cls,
+			 security_context_t * con);
+
+/**
+ * label_cache_stats - log caching or other internal memory usage statistics.
+ * @cls: selects backend to query
+ *
+ * Log a message with information about internal caching, memory usage,
+ * table efficiency, or other such statistics.  Message is backend-specific,
+ * some backends may not output a message.  Intended for debugging purposes.
+ */
+	void label_cache_stats(security_class_t cls);
+
+/**
+ * label_op_stats - log labeling operation statistics.
+ * @cls: selects backend to query
+ *
+ * Log a message with information about the number of queries performed,
+ * number of unused matching entries, or other operational statistics.
+ * Message is backend-specific, some backends may not output a message.
+ */
+	void label_op_stats(security_class_t cls);
+
+#ifdef __cplusplus
+}
+#endif
+#endif				/* _SELINUX_LABEL_H_ */
Index: libselinux/include/selinux/label_backend_file.h
===================================================================
--- libselinux/include/selinux/label_backend_file.h	(revision 0)
+++ libselinux/include/selinux/label_backend_file.h	(revision 0)
@@ -0,0 +1,54 @@
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
+/* file contexts with inode tracking, used for relabeling, e.g. by setfiles */
+#define INODE_CONTEXTS "_inode_contexts"
+/* media contexts mode */
+#define MEDIA_CONTEXTS "_media_contexts"
+
+
+/*
+ * Additional configuration argument for this backend, if not NULL.
+ */
+	struct label_file_opts {
+		char *path;	/* base path of configuration to use */
+		char *prefix;	/* optimize lookups by using path prefix */
+		char *rootpath;	/* strip this prefix from lookup keys */
+	};
+
+
+/*
+ * Extra configuration flags available with this backend.
+ */
+
+/* Just reset the inode table.  Used in inode tracking mode. */
+#define LABEL_FILE_INODERESET	(1<<16)
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
Index: libselinux/include/selinux/label_backend.h
===================================================================
--- libselinux/include/selinux/label_backend.h	(revision 0)
+++ libselinux/include/selinux/label_backend.h	(revision 0)
@@ -0,0 +1,20 @@
+/*
+ * Labeling interface for userspace object managers and others.
+ * Backend-specific things are kept here.
+ *
+ * Author : Eamon Walsh <ewalsh@tycho.nsa.gov>
+ */
+#ifndef _SELINUX_LABEL_BACKEND_H_
+#define _SELINUX_LABEL_BACKEND_H_
+
+/*
+ * Generic labeling backend
+ */
+/* coming soon */
+
+/*
+ * File contexts backend
+ */
+#include <selinux/label_backend_file.h>
+
+#endif				/* _SELINUX_LABEL_BACKEND_H_ */
Index: libselinux/include/selinux/selinux.h
===================================================================
--- libselinux/include/selinux/selinux.h	(revision 2092)
+++ libselinux/include/selinux/selinux.h	(working copy)
@@ -277,8 +277,9 @@
 
 /* Common helpers */
 
-/* Return the security class value for a given class name. */
+/* Convert between security class values and string class names */
 	extern security_class_t string_to_security_class(const char *name);
+	extern const char *security_class_to_string(security_class_t cls);
 
 /* Return an access vector for a given class and permission name. */
 	extern access_vector_t string_to_av_perm(security_class_t tclass,
Index: libselinux/src/avc.c
===================================================================
--- libselinux/src/avc.c	(revision 2092)
+++ libselinux/src/avc.c	(working copy)
@@ -149,6 +149,14 @@
 #undef S_
 };
 
+#define CLASS_UPPER_BOUND (sizeof(class_to_string)/sizeof(u16))
+
+const char *security_class_to_string(security_class_t cls)
+{
+	cls = (cls > 0 && cls < CLASS_UPPER_BOUND) ? cls : 0;
+	return class_to_string_data.str + class_to_string[cls];
+}
+
 #define AVC_CACHE_SLOTS		512
 #define AVC_CACHE_MAXNODES	410
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
Index: libselinux/src/label_backend_file.c
===================================================================
--- libselinux/src/label_backend_file.c	(revision 0)
+++ libselinux/src/label_backend_file.c	(revision 0)
@@ -0,0 +1,1013 @@
+/*
+ * File contexts backend for labeling system
+ *
+ * Author : Eamon Walsh <ewalsh@tycho.nsa.gov>
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
+	security_class_t cls;
+	char prefix[LABEL_PREFIX_SIZE];
+	unsigned int flags;
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
+static int process_line(struct saved_conf *conf,
+			const char *path, const char *prefix,
+			char *line_buf, int pass, unsigned lineno)
+{
+	int items, len, regerr, flags = conf->flags;
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
+static int lookup_common(struct saved_conf *conf, const char *key, mode_t mode)
+{
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
+static void destroy(struct label_ops *ops)
+{
+	struct saved_conf *conf = (struct saved_conf *)ops->data;
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
+	free(conf->spec_arr);
+	conf->spec_arr = NULL;
+	conf->nspec = 0;
+
+	for (i = 0; i < (unsigned int)conf->num_stems; i++) {
+		stem = &conf->stem_arr[i];
+		free(stem->buf);
+	}
+	free(conf->stem_arr);
+	conf->stem_arr = NULL;
+	conf->num_stems = 0;
+	conf->alloc_stems = 0;
+}
+
+static int lookup_index(struct label_ops *ops,
+			const char *name, security_context_t *con)
+{
+	struct saved_conf *conf = (struct saved_conf *)ops->data;
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
+	i = lookup_common(conf, name, sb.st_mode);
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
+static int lookup(struct label_ops *ops,
+		  const char *key, security_context_t *con)
+{
+	struct saved_conf *conf = (struct saved_conf *)ops->data;
+	spec_t *spec_arr = conf->spec_arr;
+	int i = lookup_common(conf, key, mode_from_class(conf->cls));
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
+static int configure(struct label_ops *ops, int flags, void *arg)
+{
+	struct saved_conf *conf = (struct saved_conf *)ops->data;
+	const char *path = NULL, *prefix = NULL;
+	FILE *fp;
+	FILE *localfp = NULL;
+	FILE *homedirfp = NULL;
+	char local_path[PATH_MAX + 1];
+	char homedir_path[PATH_MAX + 1];
+	char *line_buf = NULL;
+	size_t line_len = 0;
+	unsigned int lineno, pass, i, j, maxnspec;
+	spec_t *spec_copy = NULL;
+	int status = -1;
+	struct stat sb;
+
+	/* Reset previous configuration */
+	if (flags & LABEL_FILE_INODERESET) {
+		filespec_destroy(conf);
+		return 0;
+	}
+	destroy(ops);
+	conf->flags = flags;
+
+	/* Argument processing */
+	if (arg) {
+		struct label_file_opts *ptr = (struct label_file_opts *)arg;
+		if (ptr->path) {
+			path = strdup(ptr->path);
+			if (!path)
+				return -1;
+		}
+		if (ptr->prefix) {
+			prefix = strdup(ptr->prefix);
+			if (!prefix)
+				return -1;
+		}
+		if (ptr->rootpath) {
+			conf->rootpath = strdup(ptr->rootpath);
+			if (!conf->rootpath)
+				return -1;
+			conf->rootpathlen = strlen(conf->rootpath);
+		}
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
+			if (process_line(conf, path, prefix, line_buf,
+					 pass, ++lineno) != 0)
+				goto finish;
+		}
+		lineno = 0;
+		if (homedirfp)
+			while (getline(&line_buf, &line_len, homedirfp) > 0
+			       && conf->nspec < maxnspec) {
+				if (process_line
+				    (conf, homedir_path, prefix, line_buf,
+				     pass, ++lineno) != 0)
+					goto finish;
+			}
+
+		lineno = 0;
+		if (localfp)
+			while (getline(&line_buf, &line_len, localfp) > 0
+			       && conf->nspec < maxnspec) {
+				if (process_line
+				    (conf, local_path, prefix, line_buf, pass,
+				     ++lineno) != 0)
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
+static void cache_stats(struct label_ops *ops)
+{
+	struct saved_conf *conf = (struct saved_conf *)ops->data;
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
+static void op_stats(struct label_ops *ops)
+{
+	struct saved_conf *conf = (struct saved_conf *)ops->data;
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
+/*
+ * Media backend - this should be transitioned to the simple backend eventually
+ */
+static int configure_media(struct label_ops *ops __attribute__ ((unused)),
+			   int flags __attribute__ ((unused)),
+			   void *arg __attribute__ ((unused)))
+{
+	return 0;
+}
+
+static int lookup_media(struct label_ops *ops __attribute__ ((unused)),
+			const char *media, security_context_t *con)
+{
+	const char *path = selinux_media_context_path();
+	FILE *infile;
+	char *ptr, *ptr2 = NULL;
+	int found = 0;
+	char current_line[PATH_MAX];
+	if ((infile = fopen(path, "r")) == NULL)
+		return -1;
+	while (!feof_unlocked(infile)) {
+		if (!fgets_unlocked(current_line, sizeof(current_line), infile)) {
+			return -1;
+		}
+		if (current_line[strlen(current_line) - 1])
+			current_line[strlen(current_line) - 1] = 0;
+		/* Skip leading whitespace before the partial context. */
+		ptr = current_line;
+		while (*ptr && isspace(*ptr))
+			ptr++;
+
+		if (!(*ptr))
+			continue;
+
+		/* Find the end of the media context. */
+		ptr2 = ptr;
+		while (*ptr2 && !isspace(*ptr2))
+			ptr2++;
+		if (!(*ptr2))
+			continue;
+
+		*ptr2++ = 0;
+		if (strcmp(media, ptr) == 0) {
+			found = 1;
+			break;
+		}
+	}
+	if (!found)
+		return -1;
+
+	/* Skip whitespace. */
+	while (*ptr2 && isspace(*ptr2))
+		ptr2++;
+	if (!(*ptr2)) {
+		return -1;
+	}
+
+	if (selinux_raw_to_trans_context(ptr2, con)) {
+		*con = NULL;
+		return -1;
+	}
+
+	return 0;
+}
+
+static void stub_media(struct label_ops *ops __attribute__ ((unused)))
+{
+}
+
+int backend_file_init(security_class_t cls, const char *prefix,
+		      struct label_ops *ops)
+{
+	struct saved_conf *conf;
+
+	conf = (struct saved_conf *)label_malloc(sizeof(*conf));
+	if (!conf)
+		return -1;
+
+	/* start by perpetuating this here */
+	memset(conf, 0, sizeof(*conf));
+	conf->cls = cls;
+	strncpy(conf->prefix, prefix, LABEL_PREFIX_SIZE - 1);
+	ops->data = conf;
+
+	if (!strncmp(prefix, MEDIA_CONTEXTS, sizeof(MEDIA_CONTEXTS))) {
+		ops->func_configure = &configure_media;
+		ops->func_destroy = &stub_media;
+		ops->func_lookup = &lookup_media;
+		ops->func_cache_stats = &stub_media;
+		ops->func_op_stats = &stub_media;
+	} else if (!strncmp(prefix, INODE_CONTEXTS, sizeof(INODE_CONTEXTS))) {
+		ops->func_configure = &configure;
+		ops->func_destroy = &destroy;
+		ops->func_lookup = &lookup_index;
+		ops->func_cache_stats = &cache_stats;
+		ops->func_op_stats = &op_stats;
+	} else {
+		ops->func_configure = &configure;
+		ops->func_destroy = &destroy;
+		ops->func_lookup = &lookup;
+		ops->func_cache_stats = &cache_stats;
+		ops->func_op_stats = &op_stats;
+	}
+
+	return 0;
+}
Index: libselinux/src/label_internal.c
===================================================================
--- libselinux/src/label_internal.c	(revision 0)
+++ libselinux/src/label_internal.c	(revision 0)
@@ -0,0 +1,25 @@
+/*
+ * Callbacks for user-supplied memory allocation, supplemental
+ * auditing, and locking routines.
+ *
+ * Author : Eamon Walsh <ewalsh@epoch.ncsc.mil>
+ */
+
+#include <sys/types.h>
+#include <stdlib.h>
+#include <selinux/selinux.h>
+#include "label_internal.h"
+
+/* callback pointers */
+void *(*label_func_malloc) (size_t) = NULL;
+void (*label_func_free) (void *) = NULL;
+
+int (*label_func_log) (int, const char *, ...) = NULL;
+
+int (*label_func_validate) (security_class_t cls, char **ctx) = NULL;
+
+void *(*label_func_alloc_lock) (void) = NULL;
+void (*label_func_get_lock) (void *) = NULL;
+void (*label_func_release_lock) (void *) = NULL;
+void (*label_func_free_lock) (void *) = NULL;
+
Index: libselinux/src/label.c
===================================================================
--- libselinux/src/label.c	(revision 0)
+++ libselinux/src/label.c	(revision 0)
@@ -0,0 +1,234 @@
+/*
+ * Generalized labeling frontend for userspace object managers.
+ *
+ * Author : Eamon Walsh <ewalsh@epoch.ncsc.mil>
+ */
+
+#include <sys/types.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <selinux/flask.h>
+#include <selinux/label.h>
+#include "label_internal.h"
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+struct label_backend_rec {
+	security_class_t cls;
+	char name[LABEL_PREFIX_SIZE];
+	int configured;
+	struct label_ops ops;
+	struct label_backend_rec *next;
+};
+
+static char label_prefix[LABEL_PREFIX_SIZE] = "";
+static struct label_backend_rec *open_backends = NULL;
+static struct label_backend_rec *last_backend = NULL;
+static void *label_lock = NULL;
+static void *label_log_lock = NULL;
+
+struct label_backend backends[] = {
+	{SECCLASS_FILE, &backend_file_init},
+	{SECCLASS_XEXTENSION, &backend_simple_init}
+};
+
+static int open_backend(struct label_backend *backend)
+{
+	int rc = 0;
+	struct label_backend_rec *rec;
+
+	rec = (struct label_backend_rec *)label_malloc(sizeof(*rec));
+	if (!rec) {
+		rc = -1;
+		goto out;
+	}
+
+	memset(rec, 0, sizeof(*rec));
+	rc = backend->func_init(backend->cls, label_prefix, &rec->ops);
+	if (rc) {
+		label_log(LABEL_ERROR,
+			  "failed to open labeling backend for class %d\n",
+			  backend->cls);
+		label_free(rec);
+		goto out;
+	}
+
+	rec->cls = backend->cls;
+	strncpy(rec->name, label_prefix, LABEL_PREFIX_SIZE - 1);
+	rec->next = open_backends;
+	open_backends = last_backend = rec;
+out:
+	return rc;
+}
+
+static inline int match_backend(struct label_backend_rec *rec,
+				security_class_t cls)
+{
+	return (rec->cls == cls) && 
+		!strncmp(rec->name, label_prefix, LABEL_PREFIX_SIZE);
+}
+
+static int get_backend(security_class_t cls, struct label_backend_rec **rec)
+{
+	int rc = 0;
+	unsigned int i;
+
+	label_get_lock(label_lock);
+
+	if (last_backend && match_backend(last_backend, cls)) {
+		*rec = last_backend;
+		goto out;
+	}
+
+	last_backend = open_backends;
+	while (last_backend) {
+		if (match_backend(last_backend, cls)) {
+			*rec = last_backend;
+			goto out;
+		}
+		last_backend = last_backend->next;
+	}
+
+	/* need to open backend at this point */
+	for (i = 0; i < ARRAY_SIZE(backends); i++)
+		if (backends[i].cls == cls) {
+			rc = open_backend(backends+i);
+			if (!rc)
+				*rec = last_backend;
+			goto out;
+		}
+
+	/* backend not supported! this is highly irregular */
+	rc = -1;
+	errno = ENOENT;
+	label_log(LABEL_ERROR,
+		  "no labeling backend is available for class %d\n",
+		  cls);
+out:
+	label_release_lock(label_lock);
+	return rc;
+}
+
+int label_init(const char *prefix,
+	       const struct label_memory_callback *mem_cb,
+	       const struct label_log_callback *log_cb,
+	       const struct label_action_callback *action_cb,
+	       const struct label_lock_callback *lock_cb)
+{
+	int rc = 0;
+
+	if (prefix == NULL || prefix[0] == '\0') {
+		errno = EINVAL;
+		rc = -1;
+		goto out;
+	}
+	strncpy(label_prefix, prefix, LABEL_PREFIX_SIZE - 1);
+
+	set_callbacks(mem_cb, log_cb, action_cb, lock_cb);
+
+	label_lock = label_alloc_lock();
+	label_log_lock = label_alloc_lock();
+out:
+	return rc;
+}
+
+void label_change_name(const char *prefix)
+{
+	if (prefix == NULL || prefix[0] == '\0')
+		return;
+
+	label_get_lock(label_lock);
+
+	memset(label_prefix, 0, LABEL_PREFIX_SIZE);
+	strncpy(label_prefix, prefix, LABEL_PREFIX_SIZE - 1);
+
+	label_release_lock(label_lock);
+}
+
+int label_configure(security_class_t cls, int flags, void *arg)
+{
+	struct label_backend_rec *rec;
+	int rc = 0;
+
+	rc = get_backend(cls, &rec);
+	if (rc)
+		goto out;
+
+	rc = rec->ops.func_configure(&rec->ops, flags, arg);
+	if (!rc)
+		rec->configured = 1;
+
+out:
+	return rc;
+}
+
+int label_reset(security_class_t cls)
+{
+	return label_configure(cls, 0, NULL);
+}
+
+int label_lookup(const char *key, security_class_t cls,
+		  security_context_t *con)
+{
+	struct label_backend_rec *rec;
+	int rc = 0;
+
+	rc = get_backend(cls, &rec);
+	if (rc)
+		goto out;
+
+	if (!rec->configured) {
+		rc = rec->ops.func_configure(&rec->ops, 0, NULL);
+		if (rc)
+			goto out;
+		else
+			rec->configured = 1;
+	}
+
+	rc = rec->ops.func_lookup(&rec->ops, key, con);
+out:
+	return rc;
+}
+
+void label_destroy(void)
+{
+	struct label_backend_rec *be = open_backends;
+
+	label_get_lock(label_lock);
+
+	while (be) {
+		last_backend = be;
+		be->ops.func_destroy(&be->ops);
+		be = be->next;
+		label_free(last_backend);
+	}
+
+	open_backends = last_backend = NULL;
+	memset(label_prefix, 0, LABEL_PREFIX_SIZE);
+	label_release_lock(label_lock);
+
+	label_free_lock(label_lock);
+	label_free_lock(label_log_lock);
+}
+
+void label_cache_stats(security_class_t cls)
+{
+	struct label_backend_rec *rec;
+
+	if (get_backend(cls, &rec))
+		return;
+
+	rec->ops.func_cache_stats(&rec->ops);
+}
+
+void label_op_stats(security_class_t cls)
+{
+	struct label_backend_rec *rec;
+
+	if (get_backend(cls, &rec))
+		return;
+
+	rec->ops.func_op_stats(&rec->ops);
+}
Index: libselinux/src/label_internal.h
===================================================================
--- libselinux/src/label_internal.h	(revision 0)
+++ libselinux/src/label_internal.h	(revision 0)
@@ -0,0 +1,128 @@
+/*
+ * This file describes the internal interface used by the labeler
+ * for calling the user-supplied memory allocation, validation,
+ * and locking routine.
+ *
+ * Author : Eamon Walsh <ewalsh@epoch.ncsc.mil>
+ */
+#ifndef _SELINUX_LABEL_INTERNAL_H_
+#define _SELINUX_LABEL_INTERNAL_H_
+
+#include <stdlib.h>
+#include <selinux/selinux.h>
+#include <selinux/label.h>
+#include "dso.h"
+
+/* backend interface */
+struct label_ops {
+	int (*func_configure) (struct label_ops *h, int flags, void *arg);
+	void (*func_destroy) (struct label_ops *h);
+	int (*func_lookup) (struct label_ops *h,
+			    const char *key, security_context_t *ctx);
+	void (*func_cache_stats) (struct label_ops *h);
+	void (*func_op_stats) (struct label_ops *h);
+
+	void *data;
+};
+
+struct label_backend {
+	security_class_t cls;
+	int (*func_init) (security_class_t cls, const char *prefix,
+			  struct label_ops *ops);
+};
+
+/* installed backends */
+int backend_file_init(security_class_t cls, const char *name,
+		      struct label_ops *ops) hidden;
+
+int backend_simple_init(security_class_t cls, const char *name,
+			struct label_ops *ops) hidden;
+
+/* callback pointers */
+extern void *(*label_func_malloc) (size_t) hidden;
+extern void (*label_func_free) (void *) hidden;
+
+extern int (*label_func_log) (int type, const char *, ...) hidden;
+
+extern int (*label_func_validate) (security_class_t cls, char **ctx) hidden;
+
+extern void *(*label_func_alloc_lock) (void) hidden;
+extern void (*label_func_get_lock) (void *) hidden;
+extern void (*label_func_release_lock) (void *) hidden;
+extern void (*label_func_free_lock) (void *) hidden;
+
+static inline void set_callbacks(const struct label_memory_callback *mem_cb,
+				 const struct label_log_callback *log_cb,
+				 const struct label_action_callback *action_cb,
+				 const struct label_lock_callback *lock_cb)
+{
+	if (mem_cb) {
+		label_func_malloc = mem_cb->func_malloc;
+		label_func_free = mem_cb->func_free;
+	}
+	if (log_cb) {
+		label_func_log = log_cb->func_log;
+	}
+	if (action_cb) {
+		label_func_validate = action_cb->func_validate;
+	}
+	if (lock_cb) {
+		label_func_alloc_lock = lock_cb->func_alloc_lock;
+		label_func_get_lock = lock_cb->func_get_lock;
+		label_func_release_lock = lock_cb->func_release_lock;
+		label_func_free_lock = lock_cb->func_free_lock;
+	}
+}
+
+/* prefix size */
+#define LABEL_PREFIX_SIZE 128
+
+/* user-supplied callback interface for avc */
+static inline void *label_malloc(size_t size)
+{
+	return label_func_malloc ? label_func_malloc(size) : malloc(size);
+}
+
+static inline void label_free(void *ptr)
+{
+	if (label_func_free)
+		label_func_free(ptr);
+	else
+		free(ptr);
+}
+
+/* this is a macro in order to use the variadic capability. */
+#define label_log(type, format...)				\
+	(label_func_log ? label_func_log(type, format) :	\
+	 fprintf(stderr, format))
+
+static inline int label_validate(security_class_t cls, char **ctx)
+{
+	return label_func_validate ? 
+		label_func_validate(cls, ctx) : security_check_context(*ctx);
+}
+
+static inline void *label_alloc_lock(void)
+{
+	return label_func_alloc_lock ? label_func_alloc_lock() : NULL;
+}
+
+static inline void label_get_lock(void *lock)
+{
+	if (label_func_get_lock)
+		label_func_get_lock(lock);
+}
+
+static inline void label_release_lock(void *lock)
+{
+	if (label_func_release_lock)
+		label_func_release_lock(lock);
+}
+
+static inline void label_free_lock(void *lock)
+{
+	if (label_func_free_lock)
+		label_func_free_lock(lock);
+}
+
+#endif				/* _SELINUX_LABEL_INTERNAL_H_ */
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

--=-LZKQTVbOqP8Xaz7NUsGD--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
