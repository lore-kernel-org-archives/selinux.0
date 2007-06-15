Message-ID: <4673243E.30304@tycho.nsa.gov>
Date: Fri, 15 Jun 2007 19:43:58 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: [PATCH 6/7] libselinux: labeling support (try 4)
References: <467320D6.5040703@tycho.nsa.gov>
In-Reply-To: <467320D6.5040703@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch rebases the matchpathcon code to use the new interface.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 matchpathcon.c |  803 +++++++--------------------------------------------------
 1 file changed, 112 insertions(+), 691 deletions(-)


Index: libselinux/src/matchpathcon.c
===================================================================
--- libselinux/src/matchpathcon.c	(revision 2474)
+++ libselinux/src/matchpathcon.c	(working copy)
@@ -1,19 +1,54 @@
-#include <unistd.h>
-#include <fcntl.h>
 #include <sys/stat.h>
 #include <string.h>
-#include "selinux_internal.h"
-#include <stdio.h>
-#include <stdio_ext.h>
-#include <stdlib.h>
-#include <ctype.h>
 #include <errno.h>
-#include <limits.h>
-#include <regex.h>
-#include <stdarg.h>
-#include "policy.h"
-#include "context_internal.h"
+#include <stdio.h>
+#include "selinux_internal.h"
+#include "label_internal.h"
+#include "callbacks.h"
 
+static __thread struct selabel_handle *hnd;
+
+/*
+ * An array for mapping integers to contexts
+ */
+static __thread char **con_array;
+static __thread int con_array_size;
+static __thread int con_array_used;
+
+static int add_array_elt(char *con)
+{
+	if (con_array_size) {
+		while (con_array_used >= con_array_size) {
+			con_array_size *= 2;
+			con_array = (char **)realloc(con_array, sizeof(char*) *
+						     con_array_size);
+			if (!con_array) {
+				con_array_size = con_array_used = 0;
+				return -1;
+			}
+		}
+	} else {
+		con_array_size = 1000;
+		con_array = (char **)malloc(sizeof(char*) * con_array_size);
+		if (!con_array) {
+			con_array_size = con_array_used = 0;
+			return -1;
+		}
+	}
+
+	con_array[con_array_used] = strdup(con);
+	if (!con_array[con_array_used])
+		return -1;
+	return con_array_used++;
+}
+
+static void free_array_elts(void)
+{
+	con_array_size = con_array_used = 0;
+	free(con_array);
+	con_array = NULL;
+}
+
 static void
 #ifdef __GNUC__
     __attribute__ ((format(printf, 1, 2)))
@@ -26,11 +61,11 @@
 	va_end(ap);
 }
 
-static void
+void
 #ifdef __GNUC__
     __attribute__ ((format(printf, 1, 2)))
 #endif
-    (*myprintf) (const char *fmt,...) = &default_printf;
+    (*myprintf) (const char *fmt,...);
 
 void set_matchpathcon_printf(void (*f) (const char *fmt, ...))
 {
@@ -66,7 +101,7 @@
 }
 
 static int (*mycanoncon) (const char *p, unsigned l, char **c) =
-    &default_canoncon;
+    NULL;
 
 void set_matchpathcon_canoncon(int (*f) (const char *p, unsigned l, char **c))
 {
@@ -76,137 +111,23 @@
 		mycanoncon = &default_canoncon;
 }
 
-static __thread unsigned int myflags;
+static __thread struct selabel_opt options[SELABEL_NOPT];
+static __thread int notrans;
 
 void set_matchpathcon_flags(unsigned int flags)
 {
-	myflags = flags;
-}
-
-/*
- * A file security context specification.
- */
-typedef struct spec {
-	char *regex_str;	/* regular expession string for diagnostic messages */
-	char *type_str;		/* type string for diagnostic messages */
-	char *context;		/* context string */
-	int context_valid;	/* context string has been validated/canonicalized */
-	int translated;		/* context string has been translated */
-	regex_t regex;		/* compiled regular expression */
-	mode_t mode;		/* mode format value */
-	int matches;		/* number of matching pathnames */
-	int hasMetaChars;	/* indicates whether the RE has 
-				   any meta characters.  
-				   0 = no meta chars 
-				   1 = has one or more meta chars */
-	int stem_id;		/* indicates which of the stem-compression
-				 * items it matches */
-} spec_t;
-
-typedef struct stem {
-	char *buf;
-	int len;
-} stem_t;
-
-static stem_t *stem_arr = NULL;
-static int num_stems = 0;
-static int alloc_stems = 0;
-
-static const char *const regex_chars = ".^$?*+|[({";
-
-/* Return the length of the text that can be considered the stem, returns 0
- * if there is no identifiable stem */
-static int get_stem_from_spec(const char *const buf)
-{
-	const char *tmp = strchr(buf + 1, '/');
-	const char *ind;
-
-	if (!tmp)
-		return 0;
-
-	for (ind = buf; ind < tmp; ind++) {
-		if (strchr(regex_chars, (int)*ind))
-			return 0;
-	}
-	return tmp - buf;
-}
-
-/* return the length of the text that is the stem of a file name */
-static int get_stem_from_file_name(const char *const buf)
-{
-	const char *tmp = strchr(buf + 1, '/');
-
-	if (!tmp)
-		return 0;
-	return tmp - buf;
-}
-
-/* find the stem of a file spec, returns the index into stem_arr for a new
- * or existing stem, (or -1 if there is no possible stem - IE for a file in
- * the root directory or a regex that is too complex for us).  Makes buf
- * point to the text AFTER the stem. */
-static int find_stem_from_spec(const char **buf)
-{
 	int i;
-	int stem_len = get_stem_from_spec(*buf);
-
-	if (!stem_len)
-		return -1;
-	for (i = 0; i < num_stems; i++) {
-		if (stem_len == stem_arr[i].len
-		    && !strncmp(*buf, stem_arr[i].buf, stem_len)) {
-			*buf += stem_len;
-			return i;
-		}
-	}
-	if (num_stems == alloc_stems) {
-		stem_t *tmp_arr;
-		alloc_stems = alloc_stems * 2 + 16;
-		tmp_arr = realloc(stem_arr, sizeof(stem_t) * alloc_stems);
-		if (!tmp_arr)
-			return -1;
-		stem_arr = tmp_arr;
-	}
-	stem_arr[num_stems].len = stem_len;
-	stem_arr[num_stems].buf = malloc(stem_len + 1);
-	if (!stem_arr[num_stems].buf)
-		return -1;
-	memcpy(stem_arr[num_stems].buf, *buf, stem_len);
-	stem_arr[num_stems].buf[stem_len] = '\0';
-	num_stems++;
-	*buf += stem_len;
-	return num_stems - 1;
+	memset(options, 0, sizeof(options));
+	i = SELABEL_OPT_BASEONLY;
+	options[i].type = i;
+	options[i].value = (char *)(flags & MATCHPATHCON_BASEONLY);
+	i = SELABEL_OPT_VALIDATE;
+	options[i].type = i;
+	options[i].value = (char *)(flags & MATCHPATHCON_VALIDATE);
+	notrans = flags & MATCHPATHCON_NOTRANS;
 }
 
-/* find the stem of a file name, returns the index into stem_arr (or -1 if
- * there is no match - IE for a file in the root directory or a regex that is
- * too complex for us).  Makes buf point to the text AFTER the stem. */
-static int find_stem_from_file(const char **buf)
-{
-	int i;
-	int stem_len = get_stem_from_file_name(*buf);
-
-	if (!stem_len)
-		return -1;
-	for (i = 0; i < num_stems; i++) {
-		if (stem_len == stem_arr[i].len
-		    && !strncmp(*buf, stem_arr[i].buf, stem_len)) {
-			*buf += stem_len;
-			return i;
-		}
-	}
-	return -1;
-}
-
 /*
- * The array of specifications, initially in the
- * same order as in the specification file.
- * Sorting occurs based on hasMetaChars
- */
-static spec_t *spec_arr;
-static unsigned int nspec;
-
-/*
  * An association between an inode and a 
  * specification.  
  */
@@ -238,7 +159,7 @@
 int matchpathcon_filespec_add(ino_t ino, int specind, const char *file)
 {
 	file_spec_t *prevfl, *fl;
-	int h, no_conflict, ret;
+	int h, ret;
 	struct stat sb;
 
 	if (!fl_head) {
@@ -264,21 +185,14 @@
 
 			}
 
-			no_conflict =
-			    (strcmp
-			     (spec_arr[fl->specind].context,
-			      spec_arr[specind].context) == 0);
-			if (no_conflict)
+			if (!strcmp(con_array[fl->specind],
+				    con_array[specind]))
 				return fl->specind;
 
 			myprintf
 			    ("%s:  conflicting specifications for %s and %s, using %s.\n",
 			     __FUNCTION__, file, fl->file,
-			     ((specind >
-			       fl->specind) ? spec_arr[specind].
-			      context : spec_arr[fl->specind].context));
-			fl->specind =
-			    (specind > fl->specind) ? specind : fl->specind;
+			     con_array[fl->specind]);
 			free(fl->file);
 			fl->file = malloc(strlen(file) + 1);
 			if (!fl->file)
@@ -350,6 +264,8 @@
 	file_spec_t *fl, *tmp;
 	int h;
 
+	free_array_elts();
+
 	if (!fl_head)
 		return;
 
@@ -367,393 +283,20 @@
 	fl_head = NULL;
 }
 
-/*
- * Warn about duplicate specifications.
- */
-static void nodups_specs(const char *path)
+int matchpathcon_init_prefix(const char *path, const char *subset)
 {
-	unsigned int ii, jj;
-	struct spec *curr_spec;
+	if (!mycanoncon)
+		mycanoncon = default_canoncon;
 
-	for (ii = 0; ii < nspec; ii++) {
-		curr_spec = &spec_arr[ii];
-		for (jj = ii + 1; jj < nspec; jj++) {
-			if ((!strcmp
-			     (spec_arr[jj].regex_str, curr_spec->regex_str))
-			    && (!spec_arr[jj].mode || !curr_spec->mode
-				|| spec_arr[jj].mode == curr_spec->mode)) {
-				if (strcmp
-				    (spec_arr[jj].context,
-				     curr_spec->context)) {
-					myprintf
-					    ("%s: Multiple different specifications for %s  (%s and %s).\n",
-					     path, curr_spec->regex_str,
-					     spec_arr[jj].context,
-					     curr_spec->context);
-				} else {
-					myprintf
-					    ("%s: Multiple same specifications for %s.\n",
-					     path, curr_spec->regex_str);
-				}
-			}
-		}
-	}
-}
+	options[SELABEL_OPT_SUBSET].type = SELABEL_OPT_SUBSET;
+	options[SELABEL_OPT_SUBSET].value = subset;
+	options[SELABEL_OPT_PATH].type = SELABEL_OPT_PATH;
+	options[SELABEL_OPT_PATH].value = path;
 
-/* Determine if the regular expression specification has any meta characters. */
-static void spec_hasMetaChars(struct spec *spec)
-{
-	char *c;
-	int len;
-	char *end;
-
-	c = spec->regex_str;
-	len = strlen(spec->regex_str);
-	end = c + len;
-
-	spec->hasMetaChars = 0;
-
-	/* Look at each character in the RE specification string for a 
-	 * meta character. Return when any meta character reached. */
-	while (c != end) {
-		switch (*c) {
-		case '.':
-		case '^':
-		case '$':
-		case '?':
-		case '*':
-		case '+':
-		case '|':
-		case '[':
-		case '(':
-		case '{':
-			spec->hasMetaChars = 1;
-			return;
-		case '\\':	/* skip the next character */
-			c++;
-			break;
-		default:
-			break;
-
-		}
-		c++;
-	}
-	return;
+	hnd = selabel_open(SELABEL_CTX_FILE, options, SELABEL_NOPT);
+	return hnd ? 0 : -1;
 }
-static int process_line(const char *path, const char *prefix, char *line_buf,
-			int pass, unsigned lineno)
-{
-	int items, len, regerr, ret;
-	char *buf_p, *ptr;
-	char *regex=NULL, *type=NULL, *context=NULL;
-	const char *reg_buf;
-	char *anchored_regex = NULL;
 
-	ret = 0;
-	len = strlen(line_buf);
-	if (line_buf[len - 1] == '\n')
-		line_buf[len - 1] = 0;
-	buf_p = line_buf;
-	while (isspace(*buf_p))
-		buf_p++;
-	/* Skip comment lines and empty lines. */
-	if (*buf_p == '#' || *buf_p == 0)
-		return 0;
-
-	items = 0;
-	regex = strtok_r(buf_p, " \t", &ptr);
-	if (regex)
-		items += 1;
-	type = strtok_r(NULL, " \t", &ptr);
-	if (type)
-		items += 1;
-	context = strtok_r(NULL, " \t", &ptr);
-	if (context)
-		items += 1;
-	
-	if (items < 2) {
-		myprintf("%s:  line %d is missing fields, skipping\n", path,
-			 lineno);
-		return 0;
-	} else if (items == 2) {
-		/* The type field is optional. */
-		context = type;
-		type = NULL;
-	}
-
-	regex = strdup(regex);
-	if (!regex) {
-		return -1;
-	}
-	if (type) {
-		type = strdup(type);
-		if (!type) {
-			free(regex);
-			return -1;
-		}
-	}
-	context = strdup(context);
-	if (!context) {
-		ret = -1;
-		goto finish;
-	}
-
-	reg_buf = regex;
-	len = get_stem_from_spec(reg_buf);
-	if (len && prefix && strncmp(prefix, regex, len)) {
-		/* Stem of regex does not match requested prefix, discard. */
-		goto finish;
-	}
-
-	if (pass == 1) {
-		/* On the second pass, compile and store the specification in spec. */
-		char *cp;
-		spec_arr[nspec].stem_id = find_stem_from_spec(&reg_buf);
-		spec_arr[nspec].regex_str = regex;
-
-		/* Anchor the regular expression. */
-		len = strlen(reg_buf);
-		cp = anchored_regex = malloc(len + 3);
-		if (!anchored_regex) {
-			ret = -1;
-			goto finish;
-		}
-		/* Create ^...$ regexp.  */
-		*cp++ = '^';
-		cp = mempcpy(cp, reg_buf, len);
-		*cp++ = '$';
-		*cp = '\0';
-
-		/* Compile the regular expression. */
-		regerr =
-		    regcomp(&spec_arr[nspec].regex,
-			    anchored_regex, REG_EXTENDED | REG_NOSUB);
-		if (regerr != 0) {
-			size_t errsz = 0;
-			char *errbuf = NULL;
-			errsz = regerror(regerr, &spec_arr[nspec].regex,
-					 errbuf, errsz);
-			if (errsz)
-				errbuf = malloc(errsz);
-			if (errbuf)
-				(void)regerror(regerr,
-					       &spec_arr[nspec].regex,
-					       errbuf, errsz);
-			myprintf("%s:  line %d has invalid regex %s:  %s\n",
-				 path, lineno, anchored_regex,
-				 (errbuf ? errbuf : "out of memory"));
-			free(anchored_regex);
-			anchored_regex = NULL;
-			free(errbuf);
-			goto finish;
-		}
-		free(anchored_regex);
-		anchored_regex = NULL;
-
-		/* Convert the type string to a mode format */
-		spec_arr[nspec].type_str = type;
-		spec_arr[nspec].mode = 0;
-		if (!type)
-			goto skip_type;
-		len = strlen(type);
-		if (type[0] != '-' || len != 2) {
-			myprintf("%s:  line %d has invalid file type %s\n",
-				 path, lineno, type);
-			goto finish;
-		}
-		switch (type[1]) {
-		case 'b':
-			spec_arr[nspec].mode = S_IFBLK;
-			break;
-		case 'c':
-			spec_arr[nspec].mode = S_IFCHR;
-			break;
-		case 'd':
-			spec_arr[nspec].mode = S_IFDIR;
-			break;
-		case 'p':
-			spec_arr[nspec].mode = S_IFIFO;
-			break;
-		case 'l':
-			spec_arr[nspec].mode = S_IFLNK;
-			break;
-		case 's':
-			spec_arr[nspec].mode = S_IFSOCK;
-			break;
-		case '-':
-			spec_arr[nspec].mode = S_IFREG;
-			break;
-		default:
-			myprintf("%s:  line %d has invalid file type %s\n",
-				 path, lineno, type);
-			goto finish;
-		}
-
-	      skip_type:
-		if (strcmp(context, "<<none>>")) {
-			if (myflags & MATCHPATHCON_VALIDATE) {
-				if (myinvalidcon) {
-					/* Old-style validation of context. */
-					if (myinvalidcon(path, lineno, context))
-						goto finish;
-				} else {
-					/* New canonicalization of context. */
-					if (mycanoncon(path, lineno, &context))
-						goto finish;
-				}
-				spec_arr[nspec].context_valid = 1;
-			}
-		}
-
-		spec_arr[nspec].context = context;
-
-		/* Determine if specification has 
-		 * any meta characters in the RE */
-		spec_hasMetaChars(&spec_arr[nspec]);
-
-		/* Prevent stored strings from being freed. */
-		regex = NULL;
-		type = NULL;
-		context = NULL;
-	}
-
-	nspec++;
-finish:
-	free(regex);
-	free(type);
-	free(context);
-	return ret;
-}
-
-int matchpathcon_init_prefix(const char *path, const char *prefix)
-{
-	FILE *fp;
-	FILE *localfp = NULL;
-	FILE *homedirfp = NULL;
-	char local_path[PATH_MAX + 1];
-	char homedir_path[PATH_MAX + 1];
-	char *line_buf = NULL;
-	size_t line_len = 0;
-	unsigned int lineno, pass, i, j, maxnspec;
-	spec_t *spec_copy = NULL;
-	int status = -1;
-	struct stat sb;
-
-	/* Open the specification file. */
-	if (!path)
-		path = selinux_file_context_path();
-	if ((fp = fopen(path, "r")) == NULL)
-		return -1;
-	__fsetlocking(fp, FSETLOCKING_BYCALLER);
-
-	if (fstat(fileno(fp), &sb) < 0)
-		return -1;
-	if (!S_ISREG(sb.st_mode)) {
-		errno = EINVAL;
-		return -1;
-	}
-
-	if ((myflags & MATCHPATHCON_BASEONLY) == 0) {
-		snprintf(homedir_path, sizeof(homedir_path), "%s.homedirs",
-			 path);
-		homedirfp = fopen(homedir_path, "r");
-		if (homedirfp != NULL)
-			__fsetlocking(homedirfp, FSETLOCKING_BYCALLER);
-
-		snprintf(local_path, sizeof(local_path), "%s.local", path);
-		localfp = fopen(local_path, "r");
-		if (localfp != NULL)
-			__fsetlocking(localfp, FSETLOCKING_BYCALLER);
-	}
-
-	/* 
-	 * Perform two passes over the specification file.
-	 * The first pass counts the number of specifications and
-	 * performs simple validation of the input.  At the end
-	 * of the first pass, the spec array is allocated.
-	 * The second pass performs detailed validation of the input
-	 * and fills in the spec array.
-	 */
-	maxnspec = UINT_MAX / sizeof(spec_t);
-	for (pass = 0; pass < 2; pass++) {
-		lineno = 0;
-		nspec = 0;
-		while (getline(&line_buf, &line_len, fp) > 0
-		       && nspec < maxnspec) {
-			if (process_line(path, prefix, line_buf, pass, ++lineno)
-			    != 0)
-				goto finish;
-		}
-		lineno = 0;
-		if (homedirfp)
-			while (getline(&line_buf, &line_len, homedirfp) > 0
-			       && nspec < maxnspec) {
-				if (process_line
-				    (homedir_path, prefix, line_buf, pass,
-				     ++lineno) != 0)
-					goto finish;
-			}
-
-		lineno = 0;
-		if (localfp)
-			while (getline(&line_buf, &line_len, localfp) > 0
-			       && nspec < maxnspec) {
-				if (process_line
-				    (local_path, prefix, line_buf, pass,
-				     ++lineno) != 0)
-					goto finish;
-			}
-
-		if (pass == 0) {
-			if (nspec == 0) {
-				status = 0;
-				goto finish;
-			}
-			if ((spec_arr = malloc(sizeof(spec_t) * nspec)) == NULL)
-				goto finish;
-			memset(spec_arr, '\0', sizeof(spec_t) * nspec);
-			maxnspec = nspec;
-			rewind(fp);
-			if (homedirfp)
-				rewind(homedirfp);
-			if (localfp)
-				rewind(localfp);
-		}
-	}
-	free(line_buf);
-	line_buf = NULL;
-
-	/* Move exact pathname specifications to the end. */
-	spec_copy = malloc(sizeof(spec_t) * nspec);
-	if (!spec_copy)
-		goto finish;
-	j = 0;
-	for (i = 0; i < nspec; i++) {
-		if (spec_arr[i].hasMetaChars)
-			memcpy(&spec_copy[j++], &spec_arr[i], sizeof(spec_t));
-	}
-	for (i = 0; i < nspec; i++) {
-		if (!spec_arr[i].hasMetaChars)
-			memcpy(&spec_copy[j++], &spec_arr[i], sizeof(spec_t));
-	}
-	free(spec_arr);
-	spec_arr = spec_copy;
-
-	nodups_specs(path);
-
-	status = 0;
-      finish:
-	fclose(fp);
-	free(line_buf);
-	if (spec_arr != spec_copy)
-		free(spec_arr);
-	if (homedirfp)
-		fclose(homedirfp);
-	if (localfp)
-		fclose(localfp);
-	return status;
-}
-
 hidden_def(matchpathcon_init_prefix)
 
 int matchpathcon_init(const char *path)
@@ -763,172 +306,33 @@
 
 void matchpathcon_fini(void)
 {
-	struct spec *spec;
-	struct stem *stem;
-	unsigned int i;
-
-	for (i = 0; i < nspec; i++) {
-		spec = &spec_arr[i];
-		free(spec->regex_str);
-		free(spec->type_str);
-		free(spec->context);
-		regfree(&spec->regex);
-	}
-	free(spec_arr);
-	spec_arr = NULL;
-	nspec = 0;
-
-	for (i = 0; i < (unsigned int)num_stems; i++) {
-		stem = &stem_arr[i];
-		free(stem->buf);
-	}
-	free(stem_arr);
-	stem_arr = NULL;
-	num_stems = 0;
-	alloc_stems = 0;
+	selabel_close(hnd);
+	hnd = NULL;
 }
 
-static int matchpathcon_common(const char *name, mode_t mode)
-{
-	int i, ret, file_stem;
-	const char *buf = name;
-
-	if (!nspec) {
-		ret = matchpathcon_init_prefix(NULL, NULL);
-		if (ret < 0)
-			return ret;
-		if (!nspec) {
-			errno = ENOENT;
-			return -1;
-		}
-	}
-
-	file_stem = find_stem_from_file(&buf);
-
-	mode &= S_IFMT;
-
-	/* 
-	 * Check for matching specifications in reverse order, so that
-	 * the last matching specification is used.
-	 */
-	for (i = nspec - 1; i >= 0; i--) {
-		/* if the spec in question matches no stem or has the same
-		 * stem as the file AND if the spec in question has no mode
-		 * specified or if the mode matches the file mode then we do
-		 * a regex check        */
-		if ((spec_arr[i].stem_id == -1
-		     || spec_arr[i].stem_id == file_stem)
-		    && (!mode || !spec_arr[i].mode
-			|| ((mode & S_IFMT) == spec_arr[i].mode))) {
-			if (spec_arr[i].stem_id == -1)
-				ret =
-				    regexec(&spec_arr[i].regex, name, 0, NULL,
-					    0);
-			else
-				ret =
-				    regexec(&spec_arr[i].regex, buf, 0, NULL,
-					    0);
-			if (ret == 0)
-				break;
-
-			if (ret == REG_NOMATCH)
-				continue;
-			/* else it's an error */
-			return -1;
-		}
-	}
-
-	if (i < 0) {
-		/* No matching specification. */
-		errno = ENOENT;
-		return -1;
-	}
-
-	spec_arr[i].matches++;
-
-	return i;
-
-}
-
 int matchpathcon(const char *name, mode_t mode, security_context_t * con)
 {
-	int i = matchpathcon_common(name, mode);
+	if (!mycanoncon)
+		mycanoncon = default_canoncon;
 
-	if (i < 0)
-		return -1;
-
-	if (strcmp(spec_arr[i].context, "<<none>>") == 0) {
-		errno = ENOENT;
-		return -1;
-	}
-
-	if (!spec_arr[i].context_valid) {
-		if (myinvalidcon) {
-			/* Old-style validation of context. */
-			if (myinvalidcon
-			    ("file_contexts", 0, spec_arr[i].context))
-				goto bad;
-		} else {
-			/* New canonicalization of context. */
-			if (mycanoncon
-			    ("file_contexts", 0, &spec_arr[i].context))
-				goto bad;
-		}
-		spec_arr[i].context_valid = 1;
-	}
-
-	if (!spec_arr[i].translated && !(myflags & MATCHPATHCON_NOTRANS)) {
-		char *tmpcon = NULL;
-		if (selinux_raw_to_trans_context(spec_arr[i].context, &tmpcon))
-			return -1;
-		free(spec_arr[i].context);
-		spec_arr[i].context = tmpcon;
-		spec_arr[i].translated = 1;
-	}
-
-	*con = strdup(spec_arr[i].context);
-	if (!(*con))
-		return -1;
-
-	return 0;
-
-      bad:
-	errno = EINVAL;
-	return -1;
+	return notrans ?
+		selabel_lookup_raw(hnd, con, name, mode) :
+		selabel_lookup(hnd, con, name, mode);
 }
 
 int matchpathcon_index(const char *name, mode_t mode, security_context_t * con)
 {
-	int i = matchpathcon_common(name, mode);
+	int i = matchpathcon(name, mode, con);
 
 	if (i < 0)
 		return -1;
 
-	*con = strdup(spec_arr[i].context);
-	if (!(*con))
-		return -1;
-
-	return i;
+	return add_array_elt(*con);
 }
 
-void matchpathcon_checkmatches(char *str)
+void matchpathcon_checkmatches(char *str __attribute__((unused)))
 {
-	unsigned int i;
-	for (i = 0; i < nspec; i++) {
-		if (spec_arr[i].matches == 0) {
-			if (spec_arr[i].type_str) {
-				myprintf
-				    ("%s:  Warning!  No matches for (%s, %s, %s)\n",
-				     str, spec_arr[i].regex_str,
-				     spec_arr[i].type_str, spec_arr[i].context);
-			} else {
-				myprintf
-				    ("%s:  Warning!  No matches for (%s, %s)\n",
-				     str, spec_arr[i].regex_str,
-				     spec_arr[i].context);
-			}
-		}
-	}
+	selabel_stats(hnd);
 }
 
 /* Compare two contexts to see if their differences are "significant",
@@ -958,7 +362,6 @@
 {
 	security_context_t con = NULL;
 	security_context_t fcontext = NULL;
-	unsigned int localflags = myflags;
 	int rc = 0;
 
 	rc = lgetfilecon_raw(path, &con);
@@ -969,15 +372,14 @@
 			return 0;
 	}
 
-	set_matchpathcon_flags(myflags | MATCHPATHCON_NOTRANS);
-	if (matchpathcon(path, mode, &fcontext) != 0) {
+	if (selabel_lookup_raw(hnd, &fcontext, path, mode) != 0) {
 		if (errno != ENOENT)
 			rc = 1;
 		else
 			rc = 0;
 	} else
 		rc = (selinux_file_context_cmp(fcontext, con) == 0);
-	set_matchpathcon_flags(localflags);
+
 	freecon(con);
 	freecon(fcontext);
 	return rc;
@@ -988,21 +390,40 @@
 	struct stat st;
 	int rc = -1;
 	security_context_t scontext = NULL;
-	unsigned int localflags = myflags;
 	if (lstat(path, &st) != 0)
 		return rc;
 
-	set_matchpathcon_flags(myflags | MATCHPATHCON_NOTRANS);
-
 	/* If there's an error determining the context, or it has none, 
 	   return to allow default context */
-	if (matchpathcon(path, st.st_mode, &scontext)) {
+	if (selabel_lookup_raw(hnd, &scontext, path, st.st_mode)) {
 		if (errno == ENOENT)
 			rc = 0;
 	} else {
 		rc = lsetfilecon_raw(path, scontext);
 		freecon(scontext);
 	}
-	set_matchpathcon_flags(localflags);
 	return rc;
 }
+
+int compat_validate(struct selabel_handle *rec,
+		    struct selabel_lookup_rec *contexts,
+		    const char *path, unsigned lineno)
+{
+	int rc;
+	char **ctx = &contexts->ctx_raw;
+
+	if (myinvalidcon)
+		rc = myinvalidcon(path, lineno, *ctx);
+	else if (mycanoncon)
+		rc = mycanoncon(path, lineno, ctx);
+	else {
+		rc = selabel_validate(rec, contexts);
+		if (rc < 0) {
+			COMPAT_LOG(SELINUX_WARNING,
+				    "%s:  line %d has invalid context %s\n",
+				    path, lineno, *ctx);
+		}
+	}
+
+	return rc ? -1 : 0;
+}


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
