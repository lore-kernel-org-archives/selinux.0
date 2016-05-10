Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u4AFMgDG026264
 for <selinux@tycho.nsa.gov>; Tue, 10 May 2016 11:22:42 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/3] libselinux: Evaluate inodes in selinux_restorecon(3)
Date: Tue, 10 May 2016 16:22:14 +0100
Message-Id: <1462893734-9509-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch transfers matchpathcon.c inode evaluation services to
selinux_restorecon.c and modifies them to also support setfiles(8)
inode services.

The overall objective is to modify restorecon(8) and setfiles(8)
to use selinux_restorecon(3) services and then, when ready
remove the deprecated matchpathcon services from libselinux.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/include/selinux/restorecon.h  |   4 +
 libselinux/man/man3/selinux_restorecon.3 |   5 +-
 libselinux/src/matchpathcon.c            | 139 +------------
 libselinux/src/selinux_restorecon.c      | 333 ++++++++++++++++++++++++++++---
 libselinux/utils/selinux_restorecon.c    |  14 +-
 5 files changed, 330 insertions(+), 165 deletions(-)

diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include/selinux/restorecon.h
index ba1232e..0b93b0c 100644
--- a/libselinux/include/selinux/restorecon.h
+++ b/libselinux/include/selinux/restorecon.h
@@ -46,6 +46,10 @@ extern int selinux_restorecon(const char *pathname,
 /* Prevent descending into directories that have a different
  * device number than the pathname from which the descent began */
 #define SELINUX_RESTORECON_XDEV				128
+/* Attempt to add an association between an inode and a context.
+ * If there is a different context that matched the inode,
+ * then use the first context that matched. */
+#define SELINUX_RESTORECON_ADD_ASSOC			256
 
 /**
  * selinux_restorecon_set_sehandle - Set the global fc handle.
diff --git a/libselinux/man/man3/selinux_restorecon.3 b/libselinux/man/man3/selinux_restorecon.3
index 0293c4d..bbb6721 100644
--- a/libselinux/man/man3/selinux_restorecon.3
+++ b/libselinux/man/man3/selinux_restorecon.3
@@ -68,7 +68,6 @@ If set, reset the files label to match the default specfile context.
 If not set only reset the files "type" component of the context to match the
 default specfile context.
 .br
-
 .sp
 .B SELINUX_RESTORECON_RECURSE
 change file and directory labels recursively (descend directories)
@@ -103,6 +102,10 @@ prevent descending into directories that have a different device number than
 the
 .I pathname
 entry from which the descent began.
+.sp
+.B SELINUX_RESTORECON_ADD_ASSOC
+attempt to add an association between an inode and a context. If there is a
+different context that matched the inode, then use the first context that matched.
 .RE
 .sp
 The behavior regarding the checking and updating of the SHA1 digest described
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 5b495a0..6020737 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -12,7 +12,7 @@ static __thread struct selabel_handle *hnd;
 /*
  * An array for mapping integers to contexts
  */
-static __thread char **con_array;
+__thread char **con_array;
 static __thread int con_array_size;
 static __thread int con_array_used;
 
@@ -131,27 +131,11 @@ void set_matchpathcon_flags(unsigned int flags)
 	notrans = flags & MATCHPATHCON_NOTRANS;
 }
 
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
-static file_spec_t *fl_head;
+/* Ensure add_assoc and verbose are false when calling from matchpathcon */
+extern int restorecon_filespec_add1(ino_t ino, int specind, const char *con,
+			    const char *file, bool add_assoc, bool verbose);
+extern void restorecon_filespec_eval(bool add_assoc, bool verbose);
+extern void restorecon_filespec_destroy(bool add_assoc);
 
 /*
  * Try to add an association between an inode and
@@ -162,71 +146,7 @@ static file_spec_t *fl_head;
  */
 int matchpathcon_filespec_add(ino_t ino, int specind, const char *file)
 {
-	file_spec_t *prevfl, *fl;
-	int h, ret;
-	struct stat sb;
-
-	if (!fl_head) {
-		fl_head = malloc(sizeof(file_spec_t) * HASH_BUCKETS);
-		if (!fl_head)
-			goto oom;
-		memset(fl_head, 0, sizeof(file_spec_t) * HASH_BUCKETS);
-	}
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
-				if (!fl->file)
-					goto oom;
-				strcpy(fl->file, file);
-				return fl->specind;
-
-			}
-
-			if (!strcmp(con_array[fl->specind],
-				    con_array[specind]))
-				return fl->specind;
-
-			myprintf
-			    ("%s:  conflicting specifications for %s and %s, using %s.\n",
-			     __FUNCTION__, file, fl->file,
-			     con_array[fl->specind]);
-			free(fl->file);
-			fl->file = malloc(strlen(file) + 1);
-			if (!fl->file)
-				goto oom;
-			strcpy(fl->file, file);
-			return fl->specind;
-		}
-
-		if (ino > fl->ino)
-			break;
-	}
-
-	fl = malloc(sizeof(file_spec_t));
-	if (!fl)
-		goto oom;
-	fl->ino = ino;
-	fl->specind = specind;
-	fl->file = malloc(strlen(file) + 1);
-	if (!fl->file)
-		goto oom_freefl;
-	strcpy(fl->file, file);
-	fl->next = prevfl->next;
-	prevfl->next = fl;
-	return fl->specind;
-      oom_freefl:
-	free(fl);
-      oom:
-	myprintf("%s:  insufficient memory for file label entry for %s\n",
-		 __FUNCTION__, file);
-	return -1;
+	return restorecon_filespec_add1(ino, specind, NULL, file, 0, 0);
 }
 
 /*
@@ -234,30 +154,7 @@ int matchpathcon_filespec_add(ino_t ino, int specind, const char *file)
  */
 void matchpathcon_filespec_eval(void)
 {
-	file_spec_t *fl;
-	int h, used, nel, len, longest;
-
-	if (!fl_head)
-		return;
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
-	myprintf
-	    ("%s:  hash table stats: %d elements, %d/%d buckets used, longest chain length %d\n",
-	     __FUNCTION__, nel, used, HASH_BUCKETS, longest);
+	return restorecon_filespec_eval(0, 0);
 }
 
 /*
@@ -265,26 +162,8 @@ void matchpathcon_filespec_eval(void)
  */
 void matchpathcon_filespec_destroy(void)
 {
-	file_spec_t *fl, *tmp;
-	int h;
-
 	free_array_elts();
-
-	if (!fl_head)
-		return;
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
-	free(fl_head);
-	fl_head = NULL;
+	restorecon_filespec_destroy(0);
 }
 
 static void matchpathcon_thread_destructor(void __attribute__((unused)) *ptr)
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 17ed6fe..2794659 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -42,6 +42,19 @@ static const char **fc_exclude_list = NULL;
 static size_t fc_count = 0;
 #define STAR_COUNT 1000
 
+/* restorecon_flags for passing to restorecon_sb() */
+struct rest_flags {
+	bool nochange;
+	bool verbose;
+	bool progress;
+	bool specctx;
+	bool add_assoc;
+	bool ignore;
+	bool recurse;
+	bool userealpath;
+	bool xdev;
+};
+
 static void restorecon_init(void)
 {
 	struct selabel_handle *sehandle = NULL;
@@ -66,6 +79,239 @@ static int check_excluded(const char *file)
 	return 0;
 }
 
+/*
+ * Support filespec services for selinux_restorecon(3) and matchpathcon(3).
+ * The matchpathcon services are deprecated and at some stage will be removed,
+ * the matchpathcon specific code here can then also be removed.
+ *
+ * selinux_restorecon(3) uses filespec services when the
+ * SELINUX_RESTORECON_ADD_ASSOC flag is set for adding associations between
+ * an inode and a context.
+ */
+
+/* Support for matchpathcon myprint() */
+extern int myprintf_compat;
+extern void __attribute__ ((format(printf, 1, 2)))
+(*myprintf) (const char *fmt, ...);
+#define COMPAT_LOG(type, fmt...) if (myprintf_compat)	  \
+		myprintf(fmt);				  \
+	else						  \
+		selinux_log(type, fmt);
+
+/* Reference the con_array specified in matchpathcon.c */
+extern __thread char **con_array;
+
+int restorecon_filespec_add(ino_t ino, const char *con,
+			    const char *file, bool add_assoc, bool verbose);
+int restorecon_filespec_add1(ino_t ino, int specind, const char *con,
+			    const char *file, bool add_assoc, bool verbose);
+void restorecon_filespec_eval(bool add_assoc, bool verbose);
+void restorecon_filespec_destroy(bool add_assoc);
+
+/*
+ * Hold an association between an inode and a context or specification.
+ */
+typedef struct file_spec {
+	ino_t ino;	/* inode number */
+	int specind;	/* index of specification in spec (matchpathcon) */
+	char *con;	/* matched context (selinux_restorecon)*/
+	char *file;	/* full pathname */
+	struct file_spec *next;	/* next association in hash bucket chain */
+} file_spec_t;
+
+/*
+ * The hash table of associations, hashed by inode number.
+ * Chaining is used for collisions, with elements ordered
+ * by inode number in each bucket.  Each hash bucket has
+ * a dummy header.
+ */
+#define HASH_BITS 16
+#define HASH_BUCKETS (1 << HASH_BITS)
+#define HASH_MASK (HASH_BUCKETS-1)
+static file_spec_t *fl_head;
+
+/*
+ * Try to add an association between an inode and a context.
+ * If there is a different context that matched the inode,
+ * then use the first context that matched.
+ */
+int hidden restorecon_filespec_add(ino_t ino, const char *con,
+			    const char *file, bool add_assoc, bool verbose)
+{
+	return restorecon_filespec_add1(ino, -1, con, file, add_assoc, verbose);
+}
+
+int hidden restorecon_filespec_add1(ino_t ino, int specind,
+				    const char *con,
+				    const char *file, bool add_assoc,
+				    bool verbose __attribute__((unused)))
+{
+	file_spec_t *prevfl, *fl;
+	int h, ret;
+	struct stat64 sb;
+
+	if (!fl_head) {
+		fl_head = malloc(sizeof(file_spec_t) * HASH_BUCKETS);
+		if (!fl_head)
+			goto oom;
+		memset(fl_head, 0, sizeof(file_spec_t) * HASH_BUCKETS);
+	}
+
+	h = (ino + (ino >> HASH_BITS)) & HASH_MASK;
+	for (prevfl = &fl_head[h], fl = fl_head[h].next; fl;
+	     prevfl = fl, fl = fl->next) {
+		if (ino == fl->ino) {
+			ret = lstat64(fl->file, &sb);
+			if (ret < 0 || sb.st_ino != ino) {
+				if (add_assoc)
+					free(fl->con);
+				free(fl->file);
+				fl->file = strdup(file);
+				if (!fl->file)
+					goto oom;
+
+				if (add_assoc) {
+					fl->con = strdup(con);
+					if (!fl->con)
+						goto oom;
+					return 1;
+				} else {
+					return fl->specind;
+				}
+			}
+
+			if (add_assoc) {
+				if (strcmp(fl->con, con) == 0)
+					return 1;
+
+				selinux_log(SELINUX_ERROR,
+					"%s:  conflicting specifications for %s and %s, using %s.\n",
+					__func__, file, fl->file, fl->con);
+				free(fl->file);
+				fl->file = strdup(file);
+				if (!fl->file)
+					goto oom;
+				return 1;
+			} else {
+				if (!strcmp(con_array[fl->specind],
+					    con_array[specind]))
+					return fl->specind;
+
+				myprintf("matchpathcon_filespec_add:  conflicting specifications for %s and %s, using %s.\n",
+				     file, fl->file, con_array[fl->specind]);
+				free(fl->file);
+				fl->file = strdup(file);
+				if (!fl->file)
+					goto oom;
+				return fl->specind;
+			}
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
+
+	if (add_assoc) {
+		fl->con = strdup(con);
+		if (!fl->con)
+			goto oom_freefl;
+	} else {
+		fl->specind = specind;
+	}
+
+	fl->file = strdup(file);
+	if (!fl->file)
+		goto oom_freefl;
+	fl->next = prevfl->next;
+	prevfl->next = fl;
+
+	if (add_assoc)
+		return 0;
+	return fl->specind;
+
+
+oom_freefl:
+	free(fl);
+oom:
+	if (add_assoc)
+		selinux_log(SELINUX_ERROR,
+			"%s:  insufficient memory for file label entry for %s\n",
+			__func__, file);
+	else
+		myprintf("matchpathcon_filespec_add:  insufficient memory for file label entry for %s\n", file);
+
+	return -1;
+}
+
+/*
+ * Evaluate the association hash table distribution.
+ */
+void hidden restorecon_filespec_eval(bool add_assoc, bool verbose)
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
+		for (fl = fl_head[h].next; fl; fl = fl->next)
+			len++;
+
+		if (len)
+			used++;
+		if (len > longest)
+			longest = len;
+		nel += len;
+	}
+
+	if (!add_assoc) {
+		myprintf("matchpathcon_filespec_eval:  hash table stats: %d elements, %d/%d buckets used, longest chain length %d\n",
+		    nel, used, HASH_BUCKETS, longest);
+	} else if (verbose) {
+		selinux_log(SELINUX_INFO,
+		    "%s:  hash table stats: %d elements, %d/%d buckets used, longest chain length %d\n",
+		     __func__, nel, used, HASH_BUCKETS, longest);
+	}
+}
+
+/*
+ * Destroy the association hash table.
+ */
+void hidden restorecon_filespec_destroy(bool add_assoc)
+{
+	file_spec_t *fl, *tmp;
+	int h;
+
+	if (!fl_head)
+		return;
+
+	for (h = 0; h < HASH_BUCKETS; h++) {
+		fl = fl_head[h].next;
+		while (fl) {
+			tmp = fl;
+			fl = fl->next;
+			if (add_assoc)
+				free(tmp->con);
+			free(tmp->file);
+			free(tmp);
+		}
+		fl_head[h].next = NULL;
+	}
+	free(fl_head);
+	fl_head = NULL;
+}
+/* End filespec services */
+
 /* Called if SELINUX_RESTORECON_SET_SPECFILE_CTX is not set to check if
  * the type components differ, updating newtypecon if so. */
 static int compare_types(char *curcon, char *newcon, char **newtypecon)
@@ -109,8 +355,7 @@ out:
 }
 
 static int restorecon_sb(const char *pathname, const struct stat *sb,
-					    bool nochange, bool verbose,
-					    bool progress, bool specctx)
+			    struct rest_flags *flags)
 {
 	char *newcon = NULL;
 	char *curcon = NULL;
@@ -121,6 +366,25 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 	if (selabel_lookup_raw(fc_sehandle, &newcon, pathname, sb->st_mode) < 0)
 		return 0; /* no match, but not an error */
 
+	if (flags->add_assoc) {
+		rc = restorecon_filespec_add(sb->st_ino, newcon, pathname,
+					     flags->add_assoc, flags->verbose);
+
+		if (rc < 0) {
+			selinux_log(SELINUX_ERROR,
+				    "restorecon_filespec_add error: %s\n",
+				    pathname);
+			freecon(newcon);
+			return -1;
+		}
+
+		if (rc > 0) {
+			/* Already an association and it took precedence. */
+			freecon(newcon);
+			return 0;
+		}
+	}
+
 	if (lgetfilecon_raw(pathname, &curcon) < 0) {
 		if (errno != ENODATA)
 			goto err;
@@ -128,7 +392,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 		curcon = NULL;
 	}
 
-	if (progress) {
+	if (flags->progress) {
 		fc_count++;
 		if (fc_count % STAR_COUNT == 0) {
 			fprintf(stdout, "*");
@@ -137,9 +401,9 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 	}
 
 	if (strcmp(curcon, newcon) != 0) {
-		if (!specctx && curcon &&
+		if (!flags->specctx && curcon &&
 				    (is_context_customizable(curcon) > 0)) {
-			if (verbose) {
+			if (flags->verbose) {
 				selinux_log(SELINUX_INFO,
 				 "%s not reset as customized by admin to %s\n",
 							    pathname, curcon);
@@ -147,7 +411,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 			}
 		}
 
-		if (!specctx && curcon) {
+		if (!flags->specctx && curcon) {
 			/* If types different then update newcon. */
 			rc = compare_types(curcon, newcon, &newtypecon);
 			if (rc)
@@ -161,13 +425,13 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 			}
 		}
 
-		if (!nochange) {
+		if (!flags->nochange) {
 			if (lsetfilecon(pathname, newcon) < 0)
 				goto err;
 			updated = true;
 		}
 
-		if (verbose)
+		if (flags->verbose)
 			selinux_log(SELINUX_INFO,
 				    "%s %s from %s to %s\n",
 				    updated ? "Relabeled" : "Would relabel",
@@ -196,22 +460,27 @@ err:
 int selinux_restorecon(const char *pathname_orig,
 				    unsigned int restorecon_flags)
 {
-	bool ignore = (restorecon_flags &
-		    SELINUX_RESTORECON_IGNORE_DIGEST) ? true : false;
-	bool nochange = (restorecon_flags &
+	struct rest_flags flags;
+
+	flags.nochange = (restorecon_flags &
 		    SELINUX_RESTORECON_NOCHANGE) ? true : false;
-	bool verbose = (restorecon_flags &
+	flags.verbose = (restorecon_flags &
 		    SELINUX_RESTORECON_VERBOSE) ? true : false;
-	bool progress = (restorecon_flags &
+	flags.progress = (restorecon_flags &
 		    SELINUX_RESTORECON_PROGRESS) ? true : false;
-	bool recurse = (restorecon_flags &
-		    SELINUX_RESTORECON_RECURSE) ? true : false;
-	bool specctx = (restorecon_flags &
+	flags.specctx = (restorecon_flags &
 		    SELINUX_RESTORECON_SET_SPECFILE_CTX) ? true : false;
-	bool userealpath = (restorecon_flags &
+	flags.add_assoc = (restorecon_flags &
+		   SELINUX_RESTORECON_ADD_ASSOC) ? true : false;
+	flags.ignore = (restorecon_flags &
+		    SELINUX_RESTORECON_IGNORE_DIGEST) ? true : false;
+	flags.recurse = (restorecon_flags &
+		    SELINUX_RESTORECON_RECURSE) ? true : false;
+	flags.userealpath = (restorecon_flags &
 		   SELINUX_RESTORECON_REALPATH) ? true : false;
-	bool xdev = (restorecon_flags &
+	flags.xdev = (restorecon_flags &
 		   SELINUX_RESTORECON_XDEV) ? true : false;
+
 	bool issys;
 	bool setrestoreconlast = true; /* TRUE = set xattr RESTORECON_LAST
 					* FALSE = don't use xattr */
@@ -226,8 +495,8 @@ int selinux_restorecon(const char *pathname_orig,
 	char *xattr_value = NULL;
 	ssize_t size;
 
-	if (verbose && progress)
-		verbose = false;
+	if (flags.verbose && flags.progress)
+		flags.verbose = false;
 
 	__selinux_once(fc_once, restorecon_init);
 
@@ -244,7 +513,7 @@ int selinux_restorecon(const char *pathname_orig,
 	 * Convert passed-in pathname to canonical pathname by resolving
 	 * realpath of containing dir, then appending last component name.
 	 */
-	if (userealpath) {
+	if (flags.userealpath) {
 		pathbname = basename((char *)pathname_orig);
 		if (!strcmp(pathbname, "/") || !strcmp(pathbname, ".") ||
 					    !strcmp(pathbname, "..")) {
@@ -284,9 +553,8 @@ int selinux_restorecon(const char *pathname_orig,
 	if ((sb.st_mode & S_IFDIR) != S_IFDIR)
 		setrestoreconlast = false;
 
-	if (!recurse) {
-		error = restorecon_sb(pathname, &sb, nochange, verbose,
-						    progress, specctx);
+	if (!flags.recurse) {
+		error = restorecon_sb(pathname, &sb, &flags);
 		goto cleanup;
 	}
 
@@ -304,7 +572,7 @@ int selinux_restorecon(const char *pathname_orig,
 		size = getxattr(pathname, RESTORECON_LAST, xattr_value,
 							    fc_digest_len);
 
-		if (!ignore && size == fc_digest_len &&
+		if (!flags.ignore && size == fc_digest_len &&
 			    memcmp(fc_digest, xattr_value, fc_digest_len)
 								    == 0) {
 			selinux_log(SELINUX_INFO,
@@ -315,7 +583,7 @@ int selinux_restorecon(const char *pathname_orig,
 		}
 	}
 
-	if (xdev)
+	if (flags.xdev)
 		fts_flags = FTS_PHYSICAL | FTS_NOCHDIR | FTS_XDEV;
 	else
 		fts_flags = FTS_PHYSICAL | FTS_NOCHDIR;
@@ -375,22 +643,27 @@ int selinux_restorecon(const char *pathname_orig,
 			}
 
 			error |= restorecon_sb(ftsent->fts_path,
-				    ftsent->fts_statp, nochange,
-				    verbose, progress, specctx);
+					       ftsent->fts_statp, &flags);
 			break;
 		}
 	}
 
 	/* Labeling successful. Mark the top level directory as completed. */
-	if (setrestoreconlast && !nochange && !error) {
+	if (setrestoreconlast && !flags.nochange && !error) {
 		error = setxattr(pathname, RESTORECON_LAST, fc_digest,
 						    fc_digest_len, 0);
-		if (!error && verbose)
+		if (!error && flags.verbose)
 			selinux_log(SELINUX_INFO,
 				   "Updated digest for: %s\n", pathname);
 	}
 
 out:
+	if (flags.add_assoc) {
+		if (flags.verbose)
+			restorecon_filespec_eval(flags.add_assoc,
+						    flags.verbose);
+		restorecon_filespec_destroy(flags.add_assoc);
+	}
 	sverrno = errno;
 	(void) fts_close(fts);
 	errno = sverrno;
diff --git a/libselinux/utils/selinux_restorecon.c b/libselinux/utils/selinux_restorecon.c
index 52352c5..2552d63 100644
--- a/libselinux/utils/selinux_restorecon.c
+++ b/libselinux/utils/selinux_restorecon.c
@@ -37,7 +37,7 @@ static int validate_context(char **contextp)
 static void usage(const char *progname)
 {
 	fprintf(stderr,
-		"\nusage: %s [-FCnRrdei] [-v|-P] [-p policy] [-f specfile] "
+		"\nusage: %s [-FCnRrdeia] [-v|-P] [-p policy] [-f specfile] "
 		"pathname ...\n"
 		"Where:\n\t"
 		"-F  Set the label to that in specfile.\n\t"
@@ -55,8 +55,11 @@ static void usage(const char *progname)
 		"different\n\t    device number than the pathname from  which "
 		"the descent began.\n\t"
 		"-e  Exclude this file/directory (add multiple -e entries).\n\t"
-		"-i  Do not set SELABEL_OPT_VALIDATE option in selabel_open(3)"
-		" then call\n\t    selinux_restorecon_set_sehandle(3).\n\t"
+		"-i  Do not set SELABEL_OPT_DIGEST option when calling "
+		" selabel_open(3).\n\t"
+		"-a  Add an association between an inode and a context.\n\t"
+		"    If there is a different context that matched the inode,\n\t"
+		"    then use the first context that matched.\n\t"
 		"-p  Optional binary policy file (also sets validate context "
 		"option).\n\t"
 		"-f  Optional file contexts file.\n\t"
@@ -115,7 +118,7 @@ int main(int argc, char **argv)
 	exclude_list = NULL;
 	exclude_count = 0;
 
-	while ((opt = getopt(argc, argv, "iFCnRvPrde:f:p:")) > 0) {
+	while ((opt = getopt(argc, argv, "iFCnRvPrdae:f:p:")) > 0) {
 		switch (opt) {
 		case 'F':
 			restorecon_flags |=
@@ -187,6 +190,9 @@ int main(int argc, char **argv)
 		case 'i':
 			ignore_digest = true;
 			break;
+		case 'a':
+			restorecon_flags |= SELINUX_RESTORECON_ADD_ASSOC;
+			break;
 		default:
 			usage(argv[0]);
 		}
-- 
2.5.5
