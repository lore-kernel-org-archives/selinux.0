Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0SIM2sj025976
	for <selinux@tycho.nsa.gov>; Fri, 28 Jan 2005 13:22:02 -0500 (EST)
Subject: [PATCH 1/2] Rewrite setfiles to use matchpathcon
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: Daniel J Walsh <dwalsh@redhat.com>, Russell Coker <russell@coker.com.au>
In-Reply-To: <1106935580.32737.78.camel@moss-spartans.epoch.ncsc.mil>
References: <1106935580.32737.78.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-NX0EAMedADZWx67swhA9"
Message-Id: <1106936140.32737.88.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 28 Jan 2005 13:15:40 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-NX0EAMedADZWx67swhA9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch for libselinux generalizes the matchpathcon(3) internals,
exports further interfaces related to it, and moves additional code from
setfiles into libselinux so that setfiles can directly use
matchpathcon.  Merged into sourceforge CVS as of libselinux 1.21.5.

 include/selinux/selinux.h |   53 ++++++++-
 src/Makefile              |    2 
 src/matchpathcon.c        |  255 +++++++++++++++++++++++++++++++++++++++++++---
 src/selinux_internal.h    |    1 
 4 files changed, 293 insertions(+), 18 deletions(-)

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-NX0EAMedADZWx67swhA9
Content-Disposition: attachment; filename=libselinux-matchpathcon.patch
Content-Type: text/x-patch; name=libselinux-matchpathcon.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/include/selinux/selinux.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/include/selinux/selinux.h,v
retrieving revision 1.34
diff -u -p -r1.34 selinux.h
--- libselinux/include/selinux/selinux.h	19 Jan 2005 16:09:36 -0000	1.34
+++ libselinux/include/selinux/selinux.h	28 Jan 2005 16:21:59 -0000
@@ -182,18 +182,61 @@ extern access_vector_t string_to_av_perm
 /* Display an access vector in a string representation. */
 extern void print_access_vector(security_class_t tclass, access_vector_t av);
 
-/* Set the function used by matchpathcon when displaying
+/* Set the function used by matchpathcon_init when displaying
    errors about the file_contexts configuration.  If not set,
    then this defaults to fprintf(stderr, fmt, ...). */
-void set_matchpathcon_printf(void (*f)(const char *fmt, ...));
+extern void set_matchpathcon_printf(void (*f)(const char *fmt, ...));
+
+/* Set the function used by matchpathcon_init when checking the
+   validity of a context in the file contexts configuration.  If not set,
+   then this defaults to a test based on security_check_context().  
+   The function is also responsible for reporting any such error, and
+   may include the 'path' and 'lineno' in such error messages. */
+extern void set_matchpathcon_invalidcon(int (*f)(const char *path, 
+						 unsigned lineno, 
+						 char *context));
+
+/* Load the file contexts configuration specified by 'path'
+   into memory for use by subsequent matchpathcon calls.  
+   If 'path' is NULL, then load the active file contexts configuration,
+   i.e. the path returned by selinux_file_context_path().
+   Also checks for a 'path'.local file and loads additional 
+   specifications from it if present. */
+extern int matchpathcon_init(const char *path);
 
 /* Match the specified pathname and mode against the file contexts
    configuration and set *con to refer to the resulting context.
    'mode' can be 0 to disable mode matching.
-   Caller must free via freecon. */
+   Caller must free via freecon.
+   If matchpathcon_init has not already been called, then this function
+   will call it upon its first invocation with a NULL path. */
 extern int matchpathcon(const char *path,
-		 mode_t mode,
-		 security_context_t *con);
+			mode_t mode,
+			security_context_t *con);
+
+/* Same as above, but return a specification index for 
+   later use in a matchpathcon_filespec_add() call - see below. */
+extern int matchpathcon_index(const char *path,
+			      mode_t mode,
+			      security_context_t *con);
+
+/* Maintain an association between an inode and a specification index,
+   and check whether a conflicting specification is already associated
+   with the same inode (e.g. due to multiple hard links).  If so, then
+   use the latter of the two specifications based on their order in the 
+   file contexts configuration.  Return the used specification index. */
+extern int matchpathcon_filespec_add(ino_t ino, int specind, const char *file);
+
+/* Destroy any inode associations that have been added, e.g. to restart
+   for a new filesystem. */
+extern void matchpathcon_filespec_destroy(void);
+
+/* Display statistics on the hash table usage for the associations. */
+extern void matchpathcon_filespec_eval(void);
+
+/* Check to see whether any specifications had no matches and report them.
+   The 'str' is used as a prefix for any warning messages. */
+extern void matchpathcon_checkmatches(char *str);
 
 /* Match the specified media and against the media contexts 
    configuration and set *con to refer to the resulting context.
Index: libselinux/src/Makefile
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/Makefile,v
retrieving revision 1.23
diff -u -p -r1.23 Makefile
--- libselinux/src/Makefile	4 Nov 2004 19:08:12 -0000	1.23
+++ libselinux/src/Makefile	28 Jan 2005 16:12:59 -0000
@@ -12,7 +12,7 @@ LIBSO=$(TARGET).$(LIBVERSION)
 OBJS= $(patsubst %.c,%.o,$(wildcard *.c))
 LOBJS= $(patsubst %.c,%.lo,$(wildcard *.c))
 CFLAGS = -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
-override CFLAGS += -I../include -D_GNU_SOURCE
+override CFLAGS += -I../include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
 RANLIB=ranlib
 
 all: $(LIBA) $(LIBSO)
Index: libselinux/src/matchpathcon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/matchpathcon.c,v
retrieving revision 1.15
diff -u -p -r1.15 matchpathcon.c
--- libselinux/src/matchpathcon.c	27 Jan 2005 19:19:16 -0000	1.15
+++ libselinux/src/matchpathcon.c	28 Jan 2005 16:43:41 -0000
@@ -31,6 +31,22 @@ void set_matchpathcon_printf(void (*f)(c
 	myprintf = f;
 }
 
+static int default_invalidcon(const char *path, unsigned lineno, char *context)
+{
+	if (security_check_context(context) < 0 && errno != ENOENT) {
+		myprintf("%s:  line %u has invalid context %s\n", path, lineno, context);
+		return 1;
+	}
+	return 0;
+}
+
+static int (*myinvalidcon)(const char *p, unsigned l, char *c) = &default_invalidcon;
+
+void set_matchpathcon_invalidcon(int (*f)(const char *p, unsigned l, char *c))
+{
+	myinvalidcon = f;
+}
+
 /*
  * A file security context specification.
  */
@@ -167,6 +183,178 @@ typedef struct file_spec {
 	struct file_spec *next;	/* next association in hash bucket chain */
 } file_spec_t;
 
+/*
+ * The hash table of associations, hashed by inode number.
+ * Chaining is used for collisions, with elements ordered
+ * by inode number in each bucket.  Each hash bucket has a dummy 
+ * header.
+ */
+#define HASH_BITS 16
+#define HASH_BUCKETS (1 << HASH_BITS)
+#define HASH_MASK (HASH_BUCKETS-1)
+static file_spec_t *fl_head;
+
+/*
+ * Try to add an association between an inode and
+ * a specification.  If there is already an association
+ * for the inode and it conflicts with this specification,
+ * then use the specification that occurs later in the
+ * specification array.
+ */
+int matchpathcon_filespec_add(ino_t ino, int specind, const char *file)
+{
+	file_spec_t *prevfl, *fl;
+	int h, no_conflict, ret;
+	struct stat sb;
+
+	if (!fl_head) {
+		fl_head = malloc(sizeof(file_spec_t)*HASH_BUCKETS);
+		if (!fl_head)
+			goto oom;
+	}
+
+	h = (ino + (ino >> HASH_BITS)) & HASH_MASK;
+	for (prevfl = &fl_head[h], fl = fl_head[h].next; fl;
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
+			no_conflict = (strcmp(spec_arr[fl->specind].context,spec_arr[specind].context) == 0);
+			if (no_conflict)
+				return fl->specind;
+
+			myprintf("%s:  conflicting specifications for %s and %s, using %s.\n",
+				__FUNCTION__, file, fl->file,
+				((specind > fl->specind) ? spec_arr[specind].
+				 context : spec_arr[fl->specind].context));
+			fl->specind =
+			    (specind >
+			     fl->specind) ? specind : fl->specind;
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
+	fl = malloc(sizeof(file_spec_t));
+	if (!fl)
+		goto oom;
+	fl->ino = ino;
+	fl->specind = specind;
+	fl->file = malloc(strlen(file) + 1);
+	if (!fl->file)
+		goto oom;
+	strcpy(fl->file, file);
+	fl->next = prevfl->next;
+	prevfl->next = fl;
+	return fl->specind;
+oom:
+	myprintf("%s:  insufficient memory for file label entry for %s\n",
+		 __FUNCTION__, file);
+	return -1;
+}
+
+/*
+ * Evaluate the association hash table distribution.
+ */
+void matchpathcon_filespec_eval(void)
+{
+	file_spec_t *fl;
+	int h, used, nel, len, longest;
+
+	if (!fl_head)
+		return;
+
+	used = 0;
+	longest = 0;
+	nel = 0;
+	for (h = 0; h < HASH_BUCKETS; h++) {
+		len = 0;
+		for (fl = fl_head[h].next; fl; fl = fl->next) {
+			len++;
+		}
+		if (len)
+			used++;
+		if (len > longest)
+			longest = len;
+		nel += len;
+	}
+
+	myprintf
+	    ("%s:  hash table stats: %d elements, %d/%d buckets used, longest chain length %d\n",
+	     __FUNCTION__, nel, used, HASH_BUCKETS, longest);
+}
+
+/*
+ * Destroy the association hash table.
+ */
+void matchpathcon_filespec_destroy(void)
+{
+	file_spec_t *fl, *tmp;
+	int h;
+
+	for (h = 0; h < HASH_BUCKETS; h++) {
+		fl = fl_head[h].next;
+		while (fl) {
+			tmp = fl;
+			fl = fl->next;
+			free(tmp->file);
+			free(tmp);
+		}
+		fl_head[h].next = NULL;
+	}
+	free(fl_head);
+	fl_head = NULL;
+}
+
+/*
+ * Warn about duplicate specifications.
+ */
+static void nodups_specs(const char *path)
+{
+	unsigned int ii, jj;
+	struct spec *curr_spec;
+
+	for (ii = 0; ii < nspec; ii++) {
+		curr_spec = &spec_arr[ii];
+		for (jj = ii + 1; jj < nspec; jj++) { 
+			if ((!strcmp(spec_arr[jj].regex_str, curr_spec->regex_str))
+									&&
+				(!spec_arr[jj].mode || !curr_spec->mode 
+				 || spec_arr[jj].mode == curr_spec->mode)) {
+				if (strcmp(spec_arr[jj].context, curr_spec->context)) {
+					myprintf(
+					"%s: Multiple different specifications for %s  (%s and %s).\n",
+						path, curr_spec->regex_str, 
+						spec_arr[jj].context,
+						curr_spec->context);
+				}
+				else {
+					myprintf(
+					"%s: Multiple same specifications for %s.\n",
+						path, curr_spec->regex_str);
+				}
+			}
+		}
+	}
+}
+
 /* Determine if the regular expression specification has any meta characters. */
 static void spec_hasMetaChars(struct spec *spec)
 {
@@ -207,7 +395,7 @@ static void spec_hasMetaChars(struct spe
 	}
 	return;
 }
-static int process_line( const char *path, char *line_buf, int pass, int lineno) {
+static int process_line( const char *path, char *line_buf, int pass, unsigned lineno) {
 	int items, len, regerr;
 	char *buf_p;
 	char *regex, *type, *context;
@@ -308,10 +496,8 @@ static int process_line( const char *pat
 		spec_arr[nspec].context = context;
 		
 		if (strcmp(context, "<<none>>")) {
-			if (security_check_context(context) < 0 && errno != ENOENT) {
-				myprintf("%s:  line %d has invalid context %s\n", path, lineno, context); 
+			if (myinvalidcon(path, lineno, context))
 				return 0;
-			}
 		}
 		
 		/* Determine if specification has 
@@ -328,10 +514,10 @@ static int process_line( const char *pat
 	}
 	return 0;
 }
-static int matchpathcon_init(void)
+
+int matchpathcon_init(const char *path)
 {
 	FILE *fp;
-	const char *path;
 	FILE *localfp;
 	char local_path[PATH_MAX + 1];
 	char line_buf[BUFSIZ + 1];
@@ -339,7 +525,8 @@ static int matchpathcon_init(void)
 	spec_t *spec_copy;
 
 	/* Open the specification file. */
-	path = selinux_file_context_path();
+	if (!path)
+		path = selinux_file_context_path();
 	if ((fp = fopen(path, "r")) == NULL)
 		return -1;
 
@@ -399,19 +586,20 @@ static int matchpathcon_init(void)
 	free(spec_arr);
 	spec_arr = spec_copy;
 
+	nodups_specs(path);
+
 	return 0;
 }
+hidden_def(matchpathcon_init)
 
-
-int matchpathcon(const char *name, 
-		 mode_t mode,
-		 security_context_t *con)
+static int matchpathcon_common(const char *name, 
+			       mode_t mode)
 {
 	int i, ret, file_stem;
 	const char *buf = name;
 
 	if (!nspec) {
-		ret = matchpathcon_init();
+		ret = matchpathcon_init(NULL);
 		if (ret < 0)
 			return ret;
 		if (!nspec) {
@@ -457,6 +645,16 @@ int matchpathcon(const char *name, 
 
 	spec_arr[i].matches++;
 
+	return i;
+
+}
+
+int matchpathcon(const char *name, 
+		 mode_t mode,
+		 security_context_t *con)
+{
+	int i = matchpathcon_common(name, mode);
+
 	if (strcmp(spec_arr[i].context, "<<none>>") == 0) {
 		errno = ENOENT;
 		return -1;
@@ -465,6 +663,39 @@ int matchpathcon(const char *name, 
 	*con = strdup(spec_arr[i].context);
 	if (!(*con))
 		return -1;
+
 	return 0;
 }
 
+int matchpathcon_index(const char *name, 
+		       mode_t mode,
+		       security_context_t *con)
+{
+	int i = matchpathcon_common(name, mode);
+
+	*con = strdup(spec_arr[i].context);
+	if (!(*con))
+		return -1;
+
+	return i;
+}
+
+void matchpathcon_checkmatches(char *str)
+{
+	unsigned int i;
+	for (i = 0; i < nspec; i++) {
+		if (spec_arr[i].matches == 0) {
+			if (spec_arr[i].type_str) {
+				myprintf
+					("%s:  Warning!  No matches for (%s, %s, %s)\n",
+					 str, spec_arr[i].regex_str,
+					 spec_arr[i].type_str, spec_arr[i].context);
+			} else {
+				myprintf
+					("%s:  Warning!  No matches for (%s, %s)\n",
+					 str, spec_arr[i].regex_str,
+					 spec_arr[i].context);
+			}
+		}
+	}
+}
Index: libselinux/src/selinux_internal.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/selinux_internal.h,v
retrieving revision 1.4
diff -u -p -r1.4 selinux_internal.h
--- libselinux/src/selinux_internal.h	26 Jan 2005 13:48:29 -0000	1.4
+++ libselinux/src/selinux_internal.h	28 Jan 2005 15:57:33 -0000
@@ -25,3 +25,4 @@ hidden_proto(selinux_user_contexts_path)
 hidden_proto(selinux_booleans_path)
 hidden_proto(selinux_customizable_types_path)
 hidden_proto(selinux_media_context_path)
+hidden_proto(matchpathcon_init)

--=-NX0EAMedADZWx67swhA9--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
