Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0SITwsj026050
	for <selinux@tycho.nsa.gov>; Fri, 28 Jan 2005 13:29:58 -0500 (EST)
Subject: [PATCH 2/2] Rewrite setfiles to use matchpathcon
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: Daniel J Walsh <dwalsh@redhat.com>, Russell Coker <russell@coker.com.au>
In-Reply-To: <1106936140.32737.88.camel@moss-spartans.epoch.ncsc.mil>
References: <1106935580.32737.78.camel@moss-spartans.epoch.ncsc.mil>
	 <1106936140.32737.88.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-SIvo1SQhspcED0Ac2bBH"
Message-Id: <1106936616.32737.95.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 28 Jan 2005 13:23:36 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-SIvo1SQhspcED0Ac2bBH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch for policycoreutils rewrites setfiles(1) to use the
generalized matchpathcon(3) and the new interfaces exported by
libselinux 1.21.5.  Merged into sourceforge CVS as of policycoreutils
1.21.8.  Note that the policycoreutils spec file needs to depend on the
new version of libselinux for this update.  Also, this means that we can
revert the change to fixfiles to concatenate file_contexts and
file_contexts.local, as setfiles will now pick up both files via
matchpathcon.

 setfiles/setfiles.c |  741 ++++------------------------------------------------
 1 files changed, 69 insertions(+), 672 deletions(-)

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-SIvo1SQhspcED0Ac2bBH
Content-Disposition: attachment; filename=policycoreutils-matchpathcon.patch
Content-Type: text/x-patch; name=policycoreutils-matchpathcon.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: policycoreutils/setfiles/setfiles.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/setfiles/setfiles.c,v
retrieving revision 1.28
diff -u -p -r1.28 setfiles.c
--- policycoreutils/setfiles/setfiles.c	27 Jan 2005 19:05:27 -0000	1.28
+++ policycoreutils/setfiles/setfiles.c	28 Jan 2005 16:31:30 -0000
@@ -94,7 +94,6 @@ static char *policyfile = NULL;
 static int debug = 0;
 static int change = 1;
 static int quiet = 0;
-#define QPRINTF(args...) do { if (!quiet) printf(args); } while (0)
 static int use_stdin = 0;
 static int verbose = 0;
 static int log = 0;
@@ -102,57 +101,19 @@ static int warn_no_match = 0;
 static char *rootpath = NULL;
 static int rootpathlen = 0;
 
-/*
- * Program name and error message buffer.
- */
 static char *progname;
-static char errbuf[255 + 1];
-
-/*
- * A file security context specification.
- */
-typedef struct spec {
-	char *regex_str;	/* regular expession string for diagnostic messages */
-	char *type_str;		/* type string for diagnostic messages */
-	char *context;		/* context string */
-	regex_t regex;		/* compiled regular expression */
-	mode_t mode;		/* mode format value */
-	int matches;		/* number of matching pathnames */
-	int hasMetaChars; 	/* indicates whether the RE has 
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
-stem_t *stem_arr = NULL;
-int num_stems = 0;
-int alloc_stems = 0;
-
-const char * const regex_chars = ".^$?*+|[({";
 
-/* Return the length of the text that can be considered the stem, returns 0
- * if there is no identifiable stem */
-int get_stem_from_spec(const char * const buf)
-{
-	const char *tmp = strchr(buf + 1, '/');
-	const char *ind;
-
-	if(!tmp)
-		return 0;
-
-	for(ind = buf; ind < tmp; ind++)
-	{
-		if(strchr(regex_chars, (int)*ind))
-			return 0;
-	}
-	return tmp - buf;
+static void 
+#ifdef __GNUC__
+__attribute__ ((format (printf, 1, 2)))
+#endif
+qprintf(const char *fmt, ...) 
+{
+	va_list ap;
+	va_start(ap, fmt);
+	if (!quiet)
+		vfprintf(stdout, fmt, ap);
+	va_end(ap);
 }
 
 static int exclude(const char *file) {
@@ -167,244 +128,10 @@ static int exclude(const char *file) {
 	}
 	return 0;
 }
-/* return the length of the text that is the stem of a file name */
-int get_stem_from_file_name(const char * const buf)
-{
-	const char *tmp = strchr(buf + 1, '/');
-
-	if(!tmp)
-		return 0;
-	return tmp - buf;
-}
-
-/* find the stem of a file spec, returns the index into stem_arr for a new
- * or existing stem, (or -1 if there is no possible stem - IE for a file in
- * the root directory or a regex that is too complex for us).  Makes buf
- * point to the text AFTER the stem. */
-int find_stem_from_spec(const char **buf)
-{
-	int i;
-	int stem_len = get_stem_from_spec(*buf);
-
-	if(!stem_len)
-		return -1;
-	for(i = 0; i < num_stems; i++)
-	{
-		if(stem_len == stem_arr[i].len && !strncmp(*buf, stem_arr[i].buf, stem_len))
-		{
-			*buf += stem_len;
-			return i;
-		}
-	}
-	if(num_stems == alloc_stems)
-	{
-		alloc_stems = alloc_stems * 2 + 16;
-		stem_arr = realloc(stem_arr, sizeof(stem_t) * alloc_stems);
-		if(!stem_arr) {
-			fprintf(stderr, "Unable to grow stem array to %d entries:  out of memory.\n", alloc_stems);
-			exit(1);
-		}
-	}
-	stem_arr[num_stems].len = stem_len;
-	stem_arr[num_stems].buf = malloc(stem_len + 1);
-	if(!stem_arr[num_stems].buf) {
-		fprintf(stderr, "Unable to allocate new stem of length %d:  out of memory.\n", stem_len+1);
-		exit(1);
-	}
-	memcpy(stem_arr[num_stems].buf, *buf, stem_len);
-	stem_arr[num_stems].buf[stem_len] = '\0';
-	num_stems++;
-	*buf += stem_len;
-	return num_stems - 1;
-}
 
-/* find the stem of a file name, returns the index into stem_arr (or -1 if
- * there is no match - IE for a file in the root directory or a regex that is
- * too complex for us).  Makes buf point to the text AFTER the stem. */
-int find_stem_from_file(const char **buf)
+int match(const char *name, struct stat *sb, char **con)
 {
-	int i;
-	int stem_len = get_stem_from_file_name(*buf);
-
-	if(!stem_len)
-		return -1;
-	for(i = 0; i < num_stems; i++)
-	{
-		if(stem_len == stem_arr[i].len && !strncmp(*buf, stem_arr[i].buf, stem_len))
-		{
-			*buf += stem_len;
-			return i;
-		}
-	}
-	return -1;
-}
-
-/*
- * The array of specifications, initially in the
- * same order as in the specification file.
- * Sorting occurs based on hasMetaChars
- */
-static spec_t *spec_arr;
-static unsigned int nspec;
-
-/*
- * An association between an inode and a 
- * specification.  
- */
-typedef struct file_spec {
-	ino_t ino;		/* inode number */
-	int specind;		/* index of specification in spec */
-	char *file;		/* full pathname for diagnostic messages about conflicts */
-	struct file_spec *next;	/* next association in hash bucket chain */
-} file_spec_t;
-
-/*
- * The hash table of associations, hashed by inode number.
- * Chaining is used for collisions, with elements ordered
- * by inode number in each bucket.  Each hash bucket has a dummy 
- * header.
- */
-#define HASH_BITS 16
-#define HASH_BUCKETS (1 << HASH_BITS)
-#define HASH_MASK (HASH_BUCKETS-1)
-static file_spec_t fl_head[HASH_BUCKETS];
-
-/*
- * Try to add an association between an inode and
- * a specification.  If there is already an association
- * for the inode and it conflicts with this specification,
- * then use the specification that occurs later in the
- * specification array.
- */
-static file_spec_t *file_spec_add(ino_t ino, int specind, const char *file)
-{
-	file_spec_t *prevfl, *fl;
-	int h, no_conflict, ret;
-	struct stat sb;
-
-	h = (ino + (ino >> HASH_BITS)) & HASH_MASK;
-	for (prevfl = &fl_head[h], fl = fl_head[h].next; fl;
-	     prevfl = fl, fl = fl->next) {
-		if (ino == fl->ino) {
-			ret = lstat(fl->file, &sb);
-			if (ret < 0 || sb.st_ino != ino) {
-				fl->specind = specind;
-				free(fl->file);
-				fl->file = malloc(strlen(file) + 1);
-				if (!fl->file) {
-					fprintf(stderr,
-						"%s:  insufficient memory for file label entry for %s\n",
-						progname, file);
-					return NULL;
-				}
-				strcpy(fl->file, file);
-				return fl;
-
-			}
-
-			no_conflict = (strcmp(spec_arr[fl->specind].context,spec_arr[specind].context) == 0);
-			if (no_conflict)
-				return fl;
-
-			fprintf(stderr,
-				"%s:  conflicting specifications for %s and %s, using %s.\n",
-				progname, file, fl->file,
-				((specind > fl->specind) ? spec_arr[specind].
-				 context : spec_arr[fl->specind].context));
-			fl->specind =
-			    (specind >
-			     fl->specind) ? specind : fl->specind;
-			free(fl->file);
-			fl->file = malloc(strlen(file) + 1);
-			if (!fl->file) {
-				fprintf(stderr,
-					"%s:  insufficient memory for file label entry for %s\n",
-					progname, file);
-				return NULL;
-			}
-			strcpy(fl->file, file);
-			return fl;
-		}
-
-		if (ino > fl->ino)
-			break;
-	}
-
-	fl = malloc(sizeof(file_spec_t));
-	if (!fl) {
-		fprintf(stderr,
-			"%s:  insufficient memory for file label entry for %s\n",
-			progname, file);
-		return NULL;
-	}
-	fl->ino = ino;
-	fl->specind = specind;
-	fl->file = malloc(strlen(file) + 1);
-	if (!fl->file) {
-		fprintf(stderr,
-			"%s:  insufficient memory for file label entry for %s\n",
-			progname, file);
-		return NULL;
-	}
-	strcpy(fl->file, file);
-	fl->next = prevfl->next;
-	prevfl->next = fl;
-	return fl;
-}
-
-/*
- * Evaluate the association hash table distribution.
- */
-static void file_spec_eval(void)
-{
-	file_spec_t *fl;
-	int h, used, nel, len, longest;
-
-	used = 0;
-	longest = 0;
-	nel = 0;
-	for (h = 0; h < HASH_BUCKETS; h++) {
-		len = 0;
-		for (fl = fl_head[h].next; fl; fl = fl->next) {
-			len++;
-		}
-		if (len)
-			used++;
-		if (len > longest)
-			longest = len;
-		nel += len;
-	}
-
-	QPRINTF
-	    ("%s:  hash table stats: %d elements, %d/%d buckets used, longest chain length %d\n",
-	     progname, nel, used, HASH_BUCKETS, longest);
-}
-
-
-/*
- * Destroy the association hash table.
- */
-static void file_spec_destroy(void)
-{
-	file_spec_t *fl, *tmp;
-	int h;
-
-	for (h = 0; h < HASH_BUCKETS; h++) {
-		fl = fl_head[h].next;
-		while (fl) {
-			tmp = fl;
-			fl = fl->next;
-			free(tmp->file);
-			free(tmp);
-		}
-		fl_head[h].next = NULL;
-	}
-}
-
-
-int match(const char *name, struct stat *sb)
-{
-	int i, ret, file_stem;
+	int ret;
 	const char *fullname = name;
 	const char *buf = name;
 
@@ -432,86 +159,7 @@ int match(const char *name, struct stat 
 		return -1;
 	}
 
-	file_stem = find_stem_from_file(&buf);
-
-	/* 
-	 * Check for matching specifications in reverse order, so that
-	 * the last matching specification is used.
-	 */
-	for (i = nspec - 1; i >= 0; i--)
-	{
-		/* if the spec in question matches no stem or has the same
-		 * stem as the file AND if the spec in question has no mode
-		 * specified or if the mode matches the file mode then we do
-		 * a regex check	*/
-		if( (spec_arr[i].stem_id == -1 || spec_arr[i].stem_id == file_stem)
-		  && (!spec_arr[i].mode || ( (sb->st_mode & S_IFMT) == spec_arr[i].mode ) ) )
-		{
-			if(spec_arr[i].stem_id == -1)
-				ret = regexec(&spec_arr[i].regex, name, 0, NULL, 0);
-			else
-				ret = regexec(&spec_arr[i].regex, buf, 0, NULL, 0);
-			if (ret == 0)
-				break;
-
-			if (ret == REG_NOMATCH)
-				continue;
-			/* else it's an error */
-			regerror(ret, &spec_arr[i].regex, errbuf, sizeof errbuf);
-			fprintf(stderr,
-				"%s:  unable to match %s against %s:  %s\n",
-				progname, name, spec_arr[i].regex_str, errbuf);
-			return -1;
-		}
-	}
-
-	if (i < 0)
-		/* No matching specification. */
-		return -1;
-
-	spec_arr[i].matches++;
-
-	return i;
-}
-
-/*
- * Check for duplicate specifications. If a duplicate specification is found 
- * and the context is the same, give a warning to the user. If a duplicate 
- * specification is found and the context is different, give a warning
- * to the user (This could be changed to error). Return of non-zero is an error.
- */
-int nodups_specs()
-{
-	int ii, jj;
-	struct spec *curr_spec;
-
-	for (ii = 0; ii < nspec; ii++) {
-		curr_spec = &spec_arr[ii];
-		for (jj = ii + 1; jj < nspec; jj++) { 
-				/* Check if same RE string */
-			if ((!strcmp(spec_arr[jj].regex_str, curr_spec->regex_str))
-									&&
-				(!spec_arr[jj].mode || !curr_spec->mode 
-				 || spec_arr[jj].mode == curr_spec->mode)) {
-				/* Same RE string found */
-				if (strcmp(spec_arr[jj].context, curr_spec->context)) {
-					/* If different contexts, give warning */
-					fprintf(stderr,
-					"ERROR: Multiple different specifications for %s  (%s and %s).\n",
-						curr_spec->regex_str, 
-						spec_arr[jj].context,
-						curr_spec->context);
-				}
-				else {
-					/* If same contexts give warning */
-					QPRINTF(
-					"WARNING: Multiple same specifications for %s.\n",
-						curr_spec->regex_str);
-				}
-			}
-		}
-	}
-	return 0;
+	return matchpathcon_index(buf, sb->st_mode, con);
 }
 
 void usage(const char * const name)
@@ -535,49 +183,6 @@ void inc_err()
 	}
 }
 
-/* Determine if the regular expression specification has any meta characters. */
-void spec_hasMetaChars(struct spec *spec)
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
-		switch(*c) {
-			case '.':
-			case '^':
-			case '$':
-			case '?':
-			case '*':
-			case '+':
-			case '|':
-			case '[':
-			case '(':
-			case '{':
-				spec->hasMetaChars = 1;
-				return;
-			case '\\':		/* skip the next character */
-				c++;
-				break;
-			default:
-				break;
-
-		}
-		c++;
-	}
-	return;
-}
-
-#define SZ 255
-
 /* Compare two contexts to see if their differences are "significant",
  * or whether the only difference is in the user. */
 static int only_changed_user(const char *a, const char *b)
@@ -600,10 +205,9 @@ static int apply_spec(const char *file,
 		      const struct stat *sb_unused, int flag, struct FTW *s_unused)
 {
 	const char *my_file;
-	file_spec_t *fl;
 	struct stat my_sb;
-	int i, ret;
-	char *context; 
+	int i, j, ret;
+	char *context, *newcon; 
 	int user_only_changed=0;
 
 	/* Skip the extra slash at the beginning, if present. */
@@ -618,7 +222,7 @@ static int apply_spec(const char *file,
 		return 0;
 	}
 
-	i = match(my_file, &my_sb);
+	i = match(my_file, &my_sb, &newcon);
 	if (i < 0)
 		/* No matching specification. */
 		return 0;
@@ -630,26 +234,19 @@ static int apply_spec(const char *file,
 	 * then use the last matching specification.
 	 */
 	if (add_assoc) {
-		fl = file_spec_add(my_sb.st_ino, i, my_file);
-		if (!fl)
-			/* Insufficient memory to proceed. */
-			return 1;
+		j = matchpathcon_filespec_add(my_sb.st_ino, i, my_file);
+		if (j < 0) 
+			goto err;
 
-		if (fl->specind != i)
+		if (j != i) {
 			/* There was already an association and it took precedence. */
-			return 0;
+			goto out;
+		}
 	}
 
 	if (debug) {
-		if (spec_arr[i].type_str) {
-			printf("%s:  %s matched by (%s,%s,%s)\n", progname,
-			       my_file, spec_arr[i].regex_str,
-			       spec_arr[i].type_str, spec_arr[i].context);
-		} else {
-			printf("%s:  %s matched by (%s,%s)\n", progname,
-			       my_file, spec_arr[i].regex_str,
-			       spec_arr[i].context);
-		}
+		printf("%s:  %s matched by %s\n", progname,
+		       my_file, newcon);
 	}
 
 	/* Get the current context of the file. */
@@ -662,21 +259,21 @@ static int apply_spec(const char *file,
 			perror(my_file);
 			fprintf(stderr, "%s:  unable to obtain attribute for file %s\n", 
 				progname, my_file);
-			return -1;
+			goto err;
 		}
 	}
 
-	user_only_changed=only_changed_user(context, spec_arr[i].context);
+	user_only_changed=only_changed_user(context, newcon);
 
 	/*
 	 * Do not relabel the file if the matching specification is 
 	 * <<none>> or the file is already labeled according to the 
 	 * specification.
 	 */
-	if ((strcmp(spec_arr[i].context, "<<none>>") == 0) || 
-	    (strcmp(context,spec_arr[i].context) == 0)) {
+	if ((strcmp(newcon, "<<none>>") == 0) || 
+	    (strcmp(context,newcon) == 0)) {
 		freecon(context);
-		return 0;
+		goto out;
 	}
 
 	if (! force && 
@@ -685,7 +282,7 @@ static int apply_spec(const char *file,
 			fprintf(stderr,"%s: %s not reset customized by admin to %s\n",
 				progname, my_file, context);
 		}
-		return 0;
+		goto out;
 	}
 
 	if (verbose) {
@@ -694,13 +291,13 @@ static int apply_spec(const char *file,
 		 * same.  For "-vv", emit everything. */
 		if (verbose > 1 || !user_only_changed) {
 			printf("%s:  relabeling %s from %s to %s\n", progname,
-			       my_file, context, spec_arr[i].context);
+			       my_file, context, newcon);
 		}
 	}
 
 	if ( log && !user_only_changed ) {
 		syslog(LOG_INFO, "relabeling %s from %s to %s\n", 
-		       my_file, context, spec_arr[i].context);
+		       my_file, context, newcon);
 	}
 
 	if (outfile && !user_only_changed)
@@ -712,20 +309,24 @@ static int apply_spec(const char *file,
 	 * Do not relabel the file if -n was used.
 	 */
 	if (!change || user_only_changed) 
-		return 0;
+		goto out;
 
 	/*
 	 * Relabel the file to the specified context.
 	 */
-	ret = lsetfilecon(my_file, spec_arr[i].context);
+	ret = lsetfilecon(my_file, newcon);
 	if (ret) {
 		perror(my_file);
 		fprintf(stderr, "%s:  unable to relabel %s to %s\n",
-			progname, my_file, spec_arr[i].context);
-		return 0;
+			progname, my_file, newcon);
+		goto out;
 	}
-
+out:
+	freecon(newcon);
 	return 0;
+err:
+	freecon(newcon);
+	return -1;
 }
 
 void set_rootpath(const char *arg)
@@ -746,8 +347,7 @@ void set_rootpath(const char *arg)
 	rootpathlen = len;
 }
 
-void validate_context(const char *context, const char *progname,
-		      int lineno)
+int invalidcon(const char *path, unsigned lineno, char *context)
 {
 	int valid = 1;
 
@@ -759,29 +359,20 @@ void validate_context(const char *contex
 	}
 
 	if (!valid) {
-		fprintf(stderr, "%s:  invalid context %s on line number %d\n",
-			progname, context, lineno);
+		fprintf(stderr, "%s:  line %u has invalid context %s\n",
+			path, lineno, context);
 
 		/* Exit immediately if we're in checking mode. */
 		if (policyfile)
 			exit(1);
 	}
+
+	return !valid;
 }
 
 int main(int argc, char **argv)
 {
-	FILE *fp;
-	/* 
-	   For now switching up to BUFSIZ, but this should be allocated
-	   on the fly.
-	*/
-	   
-	char line_buf[BUFSIZ + 1], *buf_p;
-	char *regex, *type, *context;
-	char *anchored_regex;
-	int opt, items, regerr;
-	unsigned int len, lineno, pass, i, j, maxnspec;
-	spec_t *spec_copy;
+	int opt, rc, i;
 
 	memset(excludeArray,0, sizeof(excludeArray));
 
@@ -907,205 +498,23 @@ int main(int argc, char **argv)
 		if (optind > (argc - 2))
 			usage(argv[0]);
 	}
-
-	/* Open the specification file. */
-	if ((fp = fopen(argv[optind], "r")) == NULL) {
+	
+	/* Use our own invalid context checking function so that
+	   we can support either checking against the active policy or
+	   checking against a binary policy file. */
+	set_matchpathcon_invalidcon(&invalidcon);
+
+	/* Load the file contexts configuration and check it. */
+	rc = matchpathcon_init(argv[optind]);
+	if (rc < 0) {
 		perror(argv[optind]);
 		exit(1);
 	}
-	optind++;
 
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
-		while (fgets(line_buf, sizeof line_buf, fp) && nspec < maxnspec) {
-			lineno++;
-			len = strlen(line_buf);
-			if (line_buf[len - 1] != '\n') {
-				fprintf(stderr,
-					"%s:  no newline on line number %d (only read %s)\n",
-					argv[0], lineno, line_buf);
-				inc_err();
-				continue;
-			}
-			line_buf[len - 1] = 0;
-			buf_p = line_buf;
-			while (isspace(*buf_p))
-				buf_p++;
-			/* Skip comment lines and empty lines. */
-			if (*buf_p == '#' || *buf_p == 0)
-				continue;
-			items =
-			    sscanf(line_buf, "%as %as %as", &regex, &type,
-				   &context);
-			if (items < 2) {
-				fprintf(stderr,
-					"%s:  line number %d is missing fields (only read %s)\n",
-					argv[0], lineno, line_buf);
-				inc_err();
-				if (items == 1)
-					free(regex);
-				continue;
-			} else if (items == 2) {
-				/* The type field is optional. */
-				free(context);
-				context = type;
-				type = 0;
-			}
-
-			if (pass == 1) {
-				/* On the second pass, compile and store the specification in spec. */
-				const char *reg_buf = regex;
-				spec_arr[nspec].stem_id = find_stem_from_spec(&reg_buf);
-				spec_arr[nspec].regex_str = regex;
-
-				/* Anchor the regular expression. */
-				len = strlen(reg_buf);
-				anchored_regex = malloc(len + 3);
-				if (!anchored_regex) {
-					fprintf(stderr,
-						"%s:  insufficient memory for anchored regexp on line %d\n",
-						argv[0], lineno);
-					exit(1);
-				}
-				sprintf(anchored_regex, "^%s$", reg_buf);
-
-				/* Compile the regular expression. */
-				regerr =
-				    regcomp(&spec_arr[nspec].regex,
-					    anchored_regex,
-					    REG_EXTENDED | REG_NOSUB);
-				if (regerr < 0) {
-					regerror(regerr,
-						 &spec_arr[nspec].regex,
-						 errbuf, sizeof errbuf);
-					fprintf(stderr,
-						"%s:  unable to compile regular expression %s on line number %d:  %s\n",
-						argv[0], regex, lineno,
-						errbuf);
-					inc_err();
-				}
-				free(anchored_regex);
-
-				/* Convert the type string to a mode format */
-				spec_arr[nspec].type_str = type;
-				spec_arr[nspec].mode = 0;
-				if (!type)
-					goto skip_type;
-				len = strlen(type);
-				if (type[0] != '-' || len != 2) {
-					fprintf(stderr,
-						"%s:  invalid type specifier %s on line number %d\n",
-						argv[0], type, lineno);
-					inc_err();
-					goto skip_type;
-				}
-				switch (type[1]) {
-				case 'b':
-					spec_arr[nspec].mode = S_IFBLK;
-					break;
-				case 'c':
-					spec_arr[nspec].mode = S_IFCHR;
-					break;
-				case 'd':
-					spec_arr[nspec].mode = S_IFDIR;
-					break;
-				case 'p':
-					spec_arr[nspec].mode = S_IFIFO;
-					break;
-				case 'l':
-					spec_arr[nspec].mode = S_IFLNK;
-					break;
-				case 's':
-					spec_arr[nspec].mode = S_IFSOCK;
-					break;
-				case '-':
-					spec_arr[nspec].mode = S_IFREG;
-					break;
-				default:
-					fprintf(stderr,
-						"%s:  invalid type specifier %s on line number %d\n",
-						argv[0], type, lineno);
-					inc_err();
-				}
-
-			      skip_type:
-
-				spec_arr[nspec].context = context;
-
-				if (strcmp(context, "<<none>>")) {
-					validate_context(context, argv[0], lineno);
-				}
-
-				/* Determine if specification has 
-				 * any meta characters in the RE */
-				spec_hasMetaChars(&spec_arr[nspec]);
-			}
-
-			nspec++;
-			if (pass == 0) {
-				free(regex);
-				if (type)
-					free(type);
-				free(context);
-			}
-		}
-
-		if (nerr)
-			exit(1);
-
-		if (pass == 0) {
-			QPRINTF("%s:  read %d specifications\n", argv[0],
-			       nspec);
-			if (nspec == 0)
-				exit(0);
-			if ((spec_arr = malloc(sizeof(spec_t) * nspec)) ==
-			    NULL) {
-				fprintf(stderr,
-					"%s:  insufficient memory for specifications\n",
-					argv[0]);
-				exit(1);
-			}
-			bzero(spec_arr, sizeof(spec_t) * nspec);
-			maxnspec = nspec;
-			rewind(fp);
-		}
-	}
-	fclose(fp);
-
-	/* Move exact pathname specifications to the end. */
-	spec_copy = malloc(sizeof(spec_t) * nspec);
-	if (!spec_copy) {
-		fprintf(stderr,
-			"%s:  insufficient memory for specifications\n",
-			argv[0]);
-		exit(1);
-	}
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
+	optind++;
 
-	/* Verify no exact duplicates */
-	if (nodups_specs() != 0) {
+	if (nerr)
 		exit(1);
-	}
 
 	/*
 	 * Apply the specifications to the file systems.
@@ -1144,11 +553,11 @@ int main(int argc, char **argv)
 	else for (; optind < argc; optind++)
 	{
 		if (NULL != rootpath) {
-			QPRINTF("%s:  labeling files, pretending %s is /\n",
+			qprintf("%s:  labeling files, pretending %s is /\n",
 				argv[0], rootpath);
 		}
 
-		QPRINTF("%s:  labeling files under %s\n", argv[0],
+		qprintf("%s:  labeling files under %s\n", argv[0],
 			argv[optind]);
 		
 		/* Walk the file tree, calling apply_spec on each file. */
@@ -1165,29 +574,17 @@ int main(int argc, char **argv)
 		 * Evaluate the association hash table distribution for the
 		 * directory tree just traversed.
 		 */
-		file_spec_eval();
+		set_matchpathcon_printf(&qprintf);
+		matchpathcon_filespec_eval();
+		set_matchpathcon_printf(NULL);
 
 		/* Reset the association hash table for the next directory tree. */
-		file_spec_destroy();
+		matchpathcon_filespec_destroy();
 	}
 
-	if (warn_no_match) {
-		for (i = 0; i < nspec; i++) {
-			if (spec_arr[i].matches == 0) {
-				if (spec_arr[i].type_str) {
-					printf
-						("%s:  Warning!  No matches for (%s, %s, %s)\n",
-						 argv[0], spec_arr[i].regex_str,
-						 spec_arr[i].type_str, spec_arr[i].context);
-				} else {
-					printf
-						("%s:  Warning!  No matches for (%s, %s)\n",
-						 argv[0], spec_arr[i].regex_str,
-						 spec_arr[i].context);
-				}
-			}
-		}
-	}
+	if (warn_no_match)
+		matchpathcon_checkmatches(argv[0]);
+
 	if (outfile) 
 		fclose(outfile);
 
@@ -1195,7 +592,7 @@ int main(int argc, char **argv)
 		free(excludeArray[i].directory);
 	}
 
-	QPRINTF("%s:  Done.\n", argv[0]);
+	qprintf("%s:  Done.\n", argv[0]);
 
 	exit(0);
 }

--=-SIvo1SQhspcED0Ac2bBH--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
