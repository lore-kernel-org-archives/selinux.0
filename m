Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6Q8i4ad004999
 for <selinux@tycho.nsa.gov>; Tue, 26 Jul 2016 04:44:04 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH V3 1/4] libselinux: Evaluate inodes in selinux_restorecon(3)
Date: Tue, 26 Jul 2016 09:43:27 +0100
Message-Id: <1469522607-3082-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch adds inode evaluation services from policycoreutiles/setfiles
to selinux_restorecon.c

The overall objective is to modify restorecon(8) and setfiles(8)
to use selinux_restorecon(3) services.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V2 changes as per http://marc.info/?l=selinux&m=146470027405908&w=2
V3 No changes.

 libselinux/include/selinux/restorecon.h  |  62 ++++---
 libselinux/man/man3/selinux_restorecon.3 |   7 +-
 libselinux/src/selinux_restorecon.c      | 269 +++++++++++++++++++++++++++----
 libselinux/utils/selinux_restorecon.c    |  14 +-
 4 files changed, 292 insertions(+), 60 deletions(-)

diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include/selinux/restorecon.h
index ba1232e..6ea328d 100644
--- a/libselinux/include/selinux/restorecon.h
+++ b/libselinux/include/selinux/restorecon.h
@@ -26,26 +26,48 @@ extern int selinux_restorecon(const char *pathname,
 /*
  * restorecon_flags options
  */
-/* Force the checking of labels even if the stored SHA1
- * digest matches the specfiles SHA1 digest. */
-#define SELINUX_RESTORECON_IGNORE_DIGEST		1
-/* Do not change file labels */
-#define SELINUX_RESTORECON_NOCHANGE			2
-/* If set set change file label to that in spec file.
- * If not only change type component to that in spec file. */
-#define SELINUX_RESTORECON_SET_SPECFILE_CTX		4
-/* Recursively descend directories */
-#define SELINUX_RESTORECON_RECURSE			8
-/* Log changes to selinux log. Note that if VERBOSE and
- * PROGRESS are set, then PROGRESS will take precedence. */
-#define SELINUX_RESTORECON_VERBOSE			16
-/* Show progress by printing * to stdout every 1000 files */
-#define SELINUX_RESTORECON_PROGRESS			32
-/* Convert passed-in pathname to canonical pathname */
-#define SELINUX_RESTORECON_REALPATH			64
-/* Prevent descending into directories that have a different
- * device number than the pathname from which the descent began */
-#define SELINUX_RESTORECON_XDEV				128
+/*
+ * Force the checking of labels even if the stored SHA1
+ * digest matches the specfiles SHA1 digest.
+ */
+#define SELINUX_RESTORECON_IGNORE_DIGEST		0x0001
+/*
+ * Do not change file labels.
+ */
+#define SELINUX_RESTORECON_NOCHANGE			0x0002
+/*
+ * If set set change file label to that in spec file.
+ * If not only change type component to that in spec file.
+ */
+#define SELINUX_RESTORECON_SET_SPECFILE_CTX		0x0004
+/*
+ * Recursively descend directories.
+ */
+#define SELINUX_RESTORECON_RECURSE			0x0008
+/*
+ * Log changes to selinux log. Note that if VERBOSE and
+ * PROGRESS are set, then PROGRESS will take precedence.
+ */
+#define SELINUX_RESTORECON_VERBOSE			0x0010
+/*
+ * Show progress by printing * to stdout every 1000 files.
+ */
+#define SELINUX_RESTORECON_PROGRESS			0x0020
+/*
+ * Convert passed-in pathname to canonical pathname.
+ */
+#define SELINUX_RESTORECON_REALPATH			0x0040
+/*
+ * Prevent descending into directories that have a different
+ * device number than the pathname from which the descent began.
+ */
+#define SELINUX_RESTORECON_XDEV				0x0080
+/*
+ * Attempt to add an association between an inode and a specification.
+ * If there is already an association for the inode and it conflicts
+ * with the specification, then use the last matching specification.
+ */
+#define SELINUX_RESTORECON_ADD_ASSOC			0x0100
 
 /**
  * selinux_restorecon_set_sehandle - Set the global fc handle.
diff --git a/libselinux/man/man3/selinux_restorecon.3 b/libselinux/man/man3/selinux_restorecon.3
index 0293c4d..e5a5a87 100644
--- a/libselinux/man/man3/selinux_restorecon.3
+++ b/libselinux/man/man3/selinux_restorecon.3
@@ -67,8 +67,6 @@ extended attribute.
 If set, reset the files label to match the default specfile context.
 If not set only reset the files "type" component of the context to match the
 default specfile context.
-.br
-
 .sp
 .B SELINUX_RESTORECON_RECURSE
 change file and directory labels recursively (descend directories)
@@ -103,6 +101,11 @@ prevent descending into directories that have a different device number than
 the
 .I pathname
 entry from which the descent began.
+.sp
+.B SELINUX_RESTORECON_ADD_ASSOC
+attempt to add an association between an inode and a specification. If there
+is already an association for the inode and it conflicts with the
+specification, then use the last matching specification.
 .RE
 .sp
 The behavior regarding the checking and updating of the SHA1 digest described
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 17ed6fe..7a355e7 100644
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
+	bool set_specctx;
+	bool add_assoc;
+	bool ignore_digest;
+	bool recurse;
+	bool userealpath;
+	bool set_xdev;
+};
+
 static void restorecon_init(void)
 {
 	struct selabel_handle *sehandle = NULL;
@@ -66,8 +79,166 @@ static int check_excluded(const char *file)
 	return 0;
 }
 
-/* Called if SELINUX_RESTORECON_SET_SPECFILE_CTX is not set to check if
- * the type components differ, updating newtypecon if so. */
+/*
+ * Support filespec services. selinux_restorecon(3) uses filespec services
+ * when the SELINUX_RESTORECON_ADD_ASSOC flag is set for adding associations
+ * between an inode and a context.
+ */
+
+/*
+ * The hash table of associations, hashed by inode number. Chaining is used
+ * for collisions, with elements ordered by inode number in each bucket.
+ * Each hash bucket has a dummy header.
+ */
+#define HASH_BITS 16
+#define HASH_BUCKETS (1 << HASH_BITS)
+#define HASH_MASK (HASH_BUCKETS-1)
+
+/*
+ * An association between an inode and a context.
+ */
+typedef struct file_spec {
+	ino_t ino;		/* inode number */
+	char *con;		/* matched context */
+	char *file;		/* full pathname */
+	struct file_spec *next;	/* next association in hash bucket chain */
+} file_spec_t;
+
+static file_spec_t *fl_head;
+
+/*
+ * Try to add an association between an inode and a context. If there is a
+ * different context that matched the inode, then use the first context
+ * that matched.
+ */
+static int filespec_add(ino_t ino, const char *con, const char *file)
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
+				freecon(fl->con);
+				free(fl->file);
+				fl->file = strdup(file);
+				if (!fl->file)
+					goto oom;
+				fl->con = strdup(con);
+				if (!fl->con)
+					goto oom;
+				return 1;
+			}
+
+			if (strcmp(fl->con, con) == 0)
+				return 1;
+
+			selinux_log(SELINUX_ERROR,
+				"conflicting specifications for %s and %s, using %s.\n",
+				file, fl->file, fl->con);
+			free(fl->file);
+			fl->file = strdup(file);
+			if (!fl->file)
+				goto oom;
+			return 1;
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
+	fl->con = strdup(con);
+	if (!fl->con)
+		goto oom_freefl;
+	fl->file = strdup(file);
+	if (!fl->file)
+		goto oom_freefl;
+	fl->next = prevfl->next;
+	prevfl->next = fl;
+	return 0;
+
+oom_freefl:
+	free(fl);
+oom:
+	selinux_log(SELINUX_ERROR, "%s:  Out of memory\n", __func__);
+	return -1;
+}
+
+/*
+ * Evaluate the association hash table distribution.
+ */
+static void filespec_eval(void)
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
+		if (len)
+			used++;
+		if (len > longest)
+			longest = len;
+		nel += len;
+	}
+
+	selinux_log(SELINUX_INFO,
+		     "filespec hash table stats: %d elements, %d/%d buckets used, longest chain length %d\n",
+		     nel, used, HASH_BUCKETS, longest);
+}
+
+/*
+ * Destroy the association hash table.
+ */
+static void filespec_destroy(void)
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
+			freecon(tmp->con);
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
+ * Called if SELINUX_RESTORECON_SET_SPECFILE_CTX is not set to check if
+ * the type components differ, updating newtypecon if so.
+ */
 static int compare_types(char *curcon, char *newcon, char **newtypecon)
 {
 	int types_differ = 0;
@@ -109,8 +280,7 @@ out:
 }
 
 static int restorecon_sb(const char *pathname, const struct stat *sb,
-					    bool nochange, bool verbose,
-					    bool progress, bool specctx)
+			    struct rest_flags *flags)
 {
 	char *newcon = NULL;
 	char *curcon = NULL;
@@ -121,6 +291,23 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 	if (selabel_lookup_raw(fc_sehandle, &newcon, pathname, sb->st_mode) < 0)
 		return 0; /* no match, but not an error */
 
+	if (flags->add_assoc) {
+		rc = filespec_add(sb->st_ino, newcon, pathname);
+
+		if (rc < 0) {
+			selinux_log(SELINUX_ERROR,
+				    "filespec_add error: %s\n", pathname);
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
@@ -128,7 +315,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 		curcon = NULL;
 	}
 
-	if (progress) {
+	if (flags->progress) {
 		fc_count++;
 		if (fc_count % STAR_COUNT == 0) {
 			fprintf(stdout, "*");
@@ -137,9 +324,9 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 	}
 
 	if (strcmp(curcon, newcon) != 0) {
-		if (!specctx && curcon &&
+		if (!flags->set_specctx && curcon &&
 				    (is_context_customizable(curcon) > 0)) {
-			if (verbose) {
+			if (flags->verbose) {
 				selinux_log(SELINUX_INFO,
 				 "%s not reset as customized by admin to %s\n",
 							    pathname, curcon);
@@ -147,7 +334,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 			}
 		}
 
-		if (!specctx && curcon) {
+		if (!flags->set_specctx && curcon) {
 			/* If types different then update newcon. */
 			rc = compare_types(curcon, newcon, &newtypecon);
 			if (rc)
@@ -161,13 +348,13 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
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
@@ -196,22 +383,27 @@ err:
 int selinux_restorecon(const char *pathname_orig,
 				    unsigned int restorecon_flags)
 {
-	bool ignore = (restorecon_flags &
+	struct rest_flags flags;
+
+	flags.ignore_digest = (restorecon_flags &
 		    SELINUX_RESTORECON_IGNORE_DIGEST) ? true : false;
-	bool nochange = (restorecon_flags &
+	flags.nochange = (restorecon_flags &
 		    SELINUX_RESTORECON_NOCHANGE) ? true : false;
-	bool verbose = (restorecon_flags &
+	flags.verbose = (restorecon_flags &
 		    SELINUX_RESTORECON_VERBOSE) ? true : false;
-	bool progress = (restorecon_flags &
+	flags.progress = (restorecon_flags &
 		    SELINUX_RESTORECON_PROGRESS) ? true : false;
-	bool recurse = (restorecon_flags &
+	flags.recurse = (restorecon_flags &
 		    SELINUX_RESTORECON_RECURSE) ? true : false;
-	bool specctx = (restorecon_flags &
+	flags.set_specctx = (restorecon_flags &
 		    SELINUX_RESTORECON_SET_SPECFILE_CTX) ? true : false;
-	bool userealpath = (restorecon_flags &
+	flags.userealpath = (restorecon_flags &
 		   SELINUX_RESTORECON_REALPATH) ? true : false;
-	bool xdev = (restorecon_flags &
+	flags.set_xdev = (restorecon_flags &
 		   SELINUX_RESTORECON_XDEV) ? true : false;
+	flags.add_assoc = (restorecon_flags &
+		   SELINUX_RESTORECON_ADD_ASSOC) ? true : false;
+
 	bool issys;
 	bool setrestoreconlast = true; /* TRUE = set xattr RESTORECON_LAST
 					* FALSE = don't use xattr */
@@ -226,8 +418,8 @@ int selinux_restorecon(const char *pathname_orig,
 	char *xattr_value = NULL;
 	ssize_t size;
 
-	if (verbose && progress)
-		verbose = false;
+	if (flags.verbose && flags.progress)
+		flags.verbose = false;
 
 	__selinux_once(fc_once, restorecon_init);
 
@@ -244,7 +436,7 @@ int selinux_restorecon(const char *pathname_orig,
 	 * Convert passed-in pathname to canonical pathname by resolving
 	 * realpath of containing dir, then appending last component name.
 	 */
-	if (userealpath) {
+	if (flags.userealpath) {
 		pathbname = basename((char *)pathname_orig);
 		if (!strcmp(pathbname, "/") || !strcmp(pathbname, ".") ||
 					    !strcmp(pathbname, "..")) {
@@ -284,9 +476,8 @@ int selinux_restorecon(const char *pathname_orig,
 	if ((sb.st_mode & S_IFDIR) != S_IFDIR)
 		setrestoreconlast = false;
 
-	if (!recurse) {
-		error = restorecon_sb(pathname, &sb, nochange, verbose,
-						    progress, specctx);
+	if (!flags.recurse) {
+		error = restorecon_sb(pathname, &sb, &flags);
 		goto cleanup;
 	}
 
@@ -304,7 +495,7 @@ int selinux_restorecon(const char *pathname_orig,
 		size = getxattr(pathname, RESTORECON_LAST, xattr_value,
 							    fc_digest_len);
 
-		if (!ignore && size == fc_digest_len &&
+		if (!flags.ignore_digest && size == fc_digest_len &&
 			    memcmp(fc_digest, xattr_value, fc_digest_len)
 								    == 0) {
 			selinux_log(SELINUX_INFO,
@@ -315,7 +506,7 @@ int selinux_restorecon(const char *pathname_orig,
 		}
 	}
 
-	if (xdev)
+	if (flags.set_xdev)
 		fts_flags = FTS_PHYSICAL | FTS_NOCHDIR | FTS_XDEV;
 	else
 		fts_flags = FTS_PHYSICAL | FTS_NOCHDIR;
@@ -375,17 +566,16 @@ int selinux_restorecon(const char *pathname_orig,
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
@@ -395,16 +585,23 @@ out:
 	(void) fts_close(fts);
 	errno = sverrno;
 cleanup:
+	if (flags.add_assoc) {
+		if (flags.verbose)
+			filespec_eval();
+		filespec_destroy();
+	}
 	free(pathdnamer);
 	free(pathname);
 	free(xattr_value);
 	return error;
+
 oom:
 	sverrno = errno;
 	selinux_log(SELINUX_ERROR, "%s:  Out of memory\n", __func__);
 	errno = sverrno;
 	error = -1;
 	goto cleanup;
+
 realpatherr:
 	sverrno = errno;
 	selinux_log(SELINUX_ERROR,
@@ -456,8 +653,10 @@ void selinux_restorecon_set_sehandle(struct selabel_handle *hndl)
 	free(sha1_buf);
 }
 
-/* selinux_restorecon_default_handle(3) is called to set the global restorecon
- * handle by a process if the default params are required. */
+/*
+ * selinux_restorecon_default_handle(3) is called to set the global restorecon
+ * handle by a process if the default params are required.
+ */
 struct selabel_handle *selinux_restorecon_default_handle(void)
 {
 	struct selabel_handle *sehandle;
@@ -478,8 +677,10 @@ struct selabel_handle *selinux_restorecon_default_handle(void)
 	return sehandle;
 }
 
-/* selinux_restorecon_set_exclude_list(3) is called to set a NULL terminated
- * list of files/directories to exclude. */
+/*
+ * selinux_restorecon_set_exclude_list(3) is called to set a NULL terminated
+ * list of files/directories to exclude.
+ */
 void selinux_restorecon_set_exclude_list(const char **exclude_list)
 {
 	fc_exclude_list = exclude_list;
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
2.7.4
