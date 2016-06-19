Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5JJdD9C030510
 for <selinux@tycho.nsa.gov>; Sun, 19 Jun 2016 15:39:13 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH V2 3/3] policycoreutils: setfiles - Modify to use
 selinux_restorecon
Date: Sun, 19 Jun 2016 20:38:58 +0100
Message-Id: <1466365138-8141-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Modify setfiles and restorecon to make use of the libselinux
selinux_restorecon* set of functions.

The output from these commands should be much the same as before
with some minor wording changes, the only exception being that
a -I option has been added to ignore the digest.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V2 changes as per http://marc.info/?l=selinux&m=146470720008392&w=2

 policycoreutils/setfiles/restore.c    | 718 ++++------------------------------
 policycoreutils/setfiles/restore.h    |  51 +--
 policycoreutils/setfiles/restorecon.8 |  74 +++-
 policycoreutils/setfiles/setfiles.8   |  75 +++-
 policycoreutils/setfiles/setfiles.c   | 198 +++++-----
 5 files changed, 329 insertions(+), 787 deletions(-)

diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfiles/restore.c
index 2a7cfa3..b09307d 100644
--- a/policycoreutils/setfiles/restore.c
+++ b/policycoreutils/setfiles/restore.c
@@ -1,704 +1,128 @@
 #include "restore.h"
 #include <glob.h>
-#include <selinux/context.h>
 
-#define SKIP -2
-#define ERR -1
-#define MAX_EXCLUDES 1000
+char **exclude_list;
+int exclude_count;
 
-/*
- * The hash table of associations, hashed by inode number.
- * Chaining is used for collisions, with elements ordered
- * by inode number in each bucket.  Each hash bucket has a dummy 
- * header.
- */
-#define HASH_BITS 16
-#define HASH_BUCKETS (1 << HASH_BITS)
-#define HASH_MASK (HASH_BUCKETS-1)
+struct restore_opts *r_opts;
 
-/*
- * An association between an inode and a context.
- */
-typedef struct file_spec {
-	ino_t ino;		/* inode number */
-	char *con;		/* matched context */
-	char *file;		/* full pathname */
-	struct file_spec *next;	/* next association in hash bucket chain */
-} file_spec_t;
-
-struct edir {
-	char *directory;
-	size_t size;
-};
-
-
-static file_spec_t *fl_head;
-static int filespec_add(ino_t ino, const security_context_t con, const char *file);
-struct restore_opts *r_opts = NULL;
-static void filespec_destroy(void);
-static void filespec_eval(void);
-static int excludeCtr = 0;
-static struct edir excludeArray[MAX_EXCLUDES];
-
-void remove_exclude(const char *directory)
+void restore_init(struct restore_opts *opts)
 {
-	int i = 0;
-	for (i = 0; i < excludeCtr; i++) {
-		if (strcmp(directory, excludeArray[i].directory) == 0) {
-			free(excludeArray[i].directory);
-			if (i != excludeCtr-1)
-				excludeArray[i] = excludeArray[excludeCtr-1];
-			excludeCtr--;
-			return;
-		}
-	}
-	return;
-}
+	int rc;
 
-void restore_init(struct restore_opts *opts)
-{	
 	r_opts = opts;
 	struct selinux_opt selinux_opts[] = {
 		{ SELABEL_OPT_VALIDATE, r_opts->selabel_opt_validate },
-		{ SELABEL_OPT_PATH, r_opts->selabel_opt_path }
+		{ SELABEL_OPT_PATH, r_opts->selabel_opt_path },
+		{ SELABEL_OPT_DIGEST, r_opts->selabel_opt_digest }
 	};
-	r_opts->hnd = selabel_open(SELABEL_CTX_FILE, selinux_opts, 2);
+
+	r_opts->hnd = selabel_open(SELABEL_CTX_FILE, selinux_opts, 3);
 	if (!r_opts->hnd) {
 		perror(r_opts->selabel_opt_path);
 		exit(1);
-	}	
-}
-
-void restore_finish()
-{
-	int i;
-	for (i = 0; i < excludeCtr; i++) {
-		free(excludeArray[i].directory);
-	}
-}
-
-static int match(const char *name, struct stat *sb, char **con)
-{
-	if (!(r_opts->hard_links) && !S_ISDIR(sb->st_mode) && (sb->st_nlink > 1)) {
-		fprintf(stderr, "Warning! %s refers to a file with more than one hard link, not fixing hard links.\n",
-					name);
-		return -1;
-	}
-	
-	if (NULL != r_opts->rootpath) {
-		if (0 != strncmp(r_opts->rootpath, name, r_opts->rootpathlen)) {
-			fprintf(stderr, "%s:  %s is not located in %s\n",
-				r_opts->progname, name, r_opts->rootpath);
-			return -1;
-		}
-		name += r_opts->rootpathlen;
 	}
 
-	if (r_opts->rootpath != NULL && name[0] == '\0')
-		/* this is actually the root dir of the alt root */
-		return selabel_lookup_raw(r_opts->hnd, con, "/", sb->st_mode);
-	else
-		return selabel_lookup_raw(r_opts->hnd, con, name, sb->st_mode);
-}
-static int restore(FTSENT *ftsent, int recurse)
-{
-	char *my_file = strdupa(ftsent->fts_path);
-	int ret = -1;
-	security_context_t curcon = NULL, newcon = NULL;
-	float progress;
-	if (match(my_file, ftsent->fts_statp, &newcon) < 0) {
-		if ((errno == ENOENT) && ((!recurse) || (r_opts->verbose)))
-			fprintf(stderr, "%s:  Warning no default label for %s\n", r_opts->progname, my_file);
+	r_opts->restorecon_flags = 0;
+	r_opts->restorecon_flags = r_opts->nochange | r_opts->verbose |
+			   r_opts->progress | r_opts->set_specctx  |
+			   r_opts->add_assoc | r_opts->ignore_digest |
+			   r_opts->recurse | r_opts->userealpath |
+			   r_opts->xdev | r_opts->abort_on_error |
+			   r_opts->syslog_changes | r_opts->log_matches |
+			   r_opts->ignore_enoent;
 
-		/* Check for no matching specification. */
-		return (errno == ENOENT) ? 0 : -1;
-	}
+	/* Use setfiles/restorecon own handle */
+	selinux_restorecon_set_sehandle(r_opts->hnd);
 
-	if (r_opts->progress) {
-		r_opts->count++;
-		if (r_opts->count % STAR_COUNT == 0) {
-			if (r_opts->progress == 1) {
-				fprintf(stdout, "\r%luk", (size_t) r_opts->count / STAR_COUNT );
-			} else {
-				if (r_opts->nfile > 0) {
-					progress = (r_opts->count < r_opts->nfile) ? (100.0 * r_opts->count / r_opts->nfile) : 100;
-					fprintf(stdout, "\r%-.1f%%", progress);
-				}
-			}
-			fflush(stdout);
+	if (r_opts->rootpath) {
+		rc = selinux_restorecon_set_alt_rootpath(r_opts->rootpath);
+		if (rc) {
+			fprintf(stderr, "selinux_restorecon_set_alt_rootpath error: %s.\n",
+				strerror(errno));
+			exit(-1);
 		}
 	}
 
-	/*
-	 * Try to add an association between this inode and
-	 * this specification.  If there is already an association
-	 * for this inode and it conflicts with this specification,
-	 * then use the last matching specification.
-	 */
-	if (r_opts->add_assoc) {
-		ret = filespec_add(ftsent->fts_statp->st_ino, newcon, my_file);
-		if (ret < 0)
-			goto err;
-
-		if (ret > 0)
-			/* There was already an association and it took precedence. */
-			goto out;
-	}
-
-	if (r_opts->debug) {
-		printf("%s:  %s matched by %s\n", r_opts->progname, my_file, newcon);
-	}
-
-	/*
-	 * Do not relabel if their is no default specification for this file
-	 */
-
-	if (strcmp(newcon, "<<none>>") == 0) {
-		goto out;
-	}
-
-	/* Get the current context of the file. */
-	ret = lgetfilecon_raw(ftsent->fts_accpath, &curcon);
-	if (ret < 0) {
-		if (errno == ENODATA) {
-			curcon = NULL;
-		} else {
-			fprintf(stderr, "%s get context on %s failed: '%s'\n",
-				r_opts->progname, my_file, strerror(errno));
-			goto err;
+	if (exclude_list) {
+		rc = selinux_restorecon_set_exclude_list
+						 ((const char **)exclude_list);
+		if (rc) {
+			fprintf(stderr, "selinux_restorecon_set_exclude_list error: %s.\n",
+				strerror(errno));
+			exit(-1);
 		}
 	}
-
-	/* lgetfilecon returns number of characters and ret needs to be reset
-	 * to 0.
-	 */
-	ret = 0;
-
-	/*
-	 * Do not relabel the file if the file is already labeled according to
-	 * the specification.
-	 */
-	if (curcon && (strcmp(curcon, newcon) == 0)) {
-		goto out;
-	}
-
-	if (!r_opts->force && curcon && (is_context_customizable(curcon) > 0)) {
-		if (r_opts->verbose > 1) {
-			fprintf(stderr,
-				"%s: %s not reset customized by admin to %s\n",
-				r_opts->progname, my_file, curcon);
-		}
-		goto out;
-	}
-
-	/*
-	 *  Do not change label unless this is a force or the type is different
-	 */
-	if (!r_opts->force && curcon) {
-		int types_differ = 0;
-		context_t cona;
-		context_t conb;
-		int err = 0;
-		cona = context_new(curcon);
-		if (! cona) {
-			goto out;
-		}
-		conb = context_new(newcon);
-		if (! conb) {
-			context_free(cona);
-			goto out;
-		}
-
-		types_differ = strcmp(context_type_get(cona), context_type_get(conb));
-		if (types_differ) {
-			err |= context_user_set(conb, context_user_get(cona));
-			err |= context_role_set(conb, context_role_get(cona));
-			err |= context_range_set(conb, context_range_get(cona));
-			if (!err) {
-				freecon(newcon);
-				newcon = strdup(context_str(conb));
-			}
-		}
-		context_free(cona);
-		context_free(conb);
-
-		if (!types_differ || err) {
-			goto out;
-		}
-	}
-
-	if (r_opts->verbose) {
-		printf("%s reset %s context %s->%s\n",
-		       r_opts->progname, my_file, curcon ?: "", newcon);
-	}
-
-	if (r_opts->logging && r_opts->change) {
-		if (curcon)
-			syslog(LOG_INFO, "relabeling %s from %s to %s\n",
-			       my_file, curcon, newcon);
-		else
-			syslog(LOG_INFO, "labeling %s to %s\n",
-			       my_file, newcon);
-	}
-
-	if (r_opts->outfile)
-		fprintf(r_opts->outfile, "%s\n", my_file);
-
-	/*
-	 * Do not relabel the file if -n was used.
-	 */
-	if (!r_opts->change)
-		goto out;
-
-	/*
-	 * Relabel the file to the specified context.
-	 */
-	ret = lsetfilecon(ftsent->fts_accpath, newcon);
-	if (ret) {
-		fprintf(stderr, "%s set context %s->%s failed:'%s'\n",
-			r_opts->progname, my_file, newcon, strerror(errno));
-		goto skip;
-	}
-	ret = 0;
-out:
-	freecon(curcon);
-	freecon(newcon);
-	return ret;
-skip:
-	freecon(curcon);
-	freecon(newcon);
-	return SKIP;
-err:
-	freecon(curcon);
-	freecon(newcon);
-	return ERR;
-}
-/*
- * Apply the last matching specification to a file.
- * This function is called by fts on each file during
- * the directory traversal.
- */
-static int apply_spec(FTSENT *ftsent, int recurse)
-{
-	if (ftsent->fts_info == FTS_DNR) {
-		fprintf(stderr, "%s:  unable to read directory %s\n",
-			r_opts->progname, ftsent->fts_path);
-		return SKIP;
-	}
-	
-	int rc = restore(ftsent, recurse);
-	if (rc == ERR) {
-		if (!r_opts->abort_on_error)
-			return SKIP;
-	}
-	return rc;
 }
 
-#include <sys/statvfs.h>
-
-static int process_one(char *name, int recurse_this_path)
+void restore_finish(void)
 {
-	int rc = 0;
-	const char *namelist[2] = {name, NULL};
-	dev_t dev_num = 0;
-	FTS *fts_handle = NULL;
-	FTSENT *ftsent = NULL;
-
-	if (r_opts == NULL){
-		fprintf(stderr,
-			"Must call initialize first!");
-		goto err;
-	}
-
-	fts_handle = fts_open((char **)namelist, r_opts->fts_flags, NULL);
-	if (fts_handle  == NULL) {
-		fprintf(stderr,
-			"%s: error while labeling %s:  %s\n",
-			r_opts->progname, namelist[0], strerror(errno));
-		goto err;
-	}
-
-
-	ftsent = fts_read(fts_handle);
-	if (ftsent == NULL) {
-		fprintf(stderr,
-			"%s: error while labeling %s:  %s\n",
-			r_opts->progname, namelist[0], strerror(errno));
-		goto err;
-	}
-
-	/* Keep the inode of the first one. */
-	dev_num = ftsent->fts_statp->st_dev;
-
-	do {
-		rc = 0;
-		/* Skip the post order nodes. */
-		if (ftsent->fts_info == FTS_DP)
-			continue;
-		/* If the XDEV flag is set and the device is different */
-		if (ftsent->fts_statp->st_dev != dev_num &&
-		    FTS_XDEV == (r_opts->fts_flags & FTS_XDEV))
-			continue;
-		if (excludeCtr > 0) {
-			if (exclude(ftsent->fts_path)) {
-				fts_set(fts_handle, ftsent, FTS_SKIP);
-				continue;
-			}
-		}
-
-		rc = apply_spec(ftsent, recurse_this_path);
-		if (rc == SKIP)
-			fts_set(fts_handle, ftsent, FTS_SKIP);
-		if (rc == ERR)
-			goto err;
-		if (!recurse_this_path)
-			break;
-	} while ((ftsent = fts_read(fts_handle)) != NULL);
+	int i;
 
-out:
-	if (r_opts->add_assoc) {
-		if (!r_opts->quiet)
-			filespec_eval();
-		filespec_destroy();
+	if (exclude_list) {
+		for (i = 0; exclude_list[i]; i++)
+			free(exclude_list[i]);
+		free(exclude_list);
 	}
-	if (fts_handle)
-		fts_close(fts_handle);
-	return rc;
-
-err:
-	rc = -1;
-	goto out;
 }
 
-int process_glob(char *name, int recurse) {
+int process_glob(char *name, struct restore_opts *opts)
+{
 	glob_t globbuf;
 	size_t i = 0;
-	int errors;
+	int len, rc, errors;
+
+	r_opts = opts;
 	memset(&globbuf, 0, sizeof(globbuf));
-	errors = glob(name, GLOB_TILDE | GLOB_PERIOD | GLOB_NOCHECK | GLOB_BRACE, NULL, &globbuf);
-	if (errors) 
+
+	errors = glob(name, GLOB_TILDE | GLOB_PERIOD |
+			  GLOB_NOCHECK | GLOB_BRACE, NULL, &globbuf);
+	if (errors)
 		return errors;
 
 	for (i = 0; i < globbuf.gl_pathc; i++) {
-		int len = strlen(globbuf.gl_pathv[i]) -2;
+		len = strlen(globbuf.gl_pathv[i]) - 2;
 		if (len > 0 && strcmp(&globbuf.gl_pathv[i][len--], "/.") == 0)
 			continue;
 		if (len > 0 && strcmp(&globbuf.gl_pathv[i][len], "/..") == 0)
 			continue;
-		int rc = process_one_realpath(globbuf.gl_pathv[i], recurse);
+		rc = selinux_restorecon(globbuf.gl_pathv[i], r_opts->restorecon_flags);
 		if (rc < 0)
 			errors = rc;
 	}
-	globfree(&globbuf);
-	return errors;
-}
-
-int process_one_realpath(char *name, int recurse)
-{
-	int rc = 0;
-	char *p;
-	struct stat64 sb;
-
-	if (r_opts == NULL){
-		fprintf(stderr,
-			"Must call initialize first!");
-		return -1;
-	}
-
-	if (!r_opts->expand_realpath) {
-		return process_one(name, recurse);
-	} else {
-		rc = lstat64(name, &sb);
-		if (rc < 0) {
-			if (r_opts->ignore_enoent && errno == ENOENT)
-				return 0;
-			fprintf(stderr, "%s:  lstat(%s) failed:  %s\n",
-				r_opts->progname, name,	strerror(errno));
-			return -1;
-		}
-
-		if (S_ISLNK(sb.st_mode)) {
-			char path[PATH_MAX + 1];
 
-			rc = realpath_not_final(name, path);
-			if (rc < 0)
-				return rc;
-			rc = process_one(path, 0);
-			if (rc < 0)
-				return rc;
-
-			p = realpath(name, NULL);
-			if (p) {
-				rc = process_one(p, recurse);
-				free(p);
-			}
-			return rc;
-		} else {
-			p = realpath(name, NULL);
-			if (!p) {
-				fprintf(stderr, "realpath(%s) failed %s\n", name,
-					strerror(errno));
-				return -1;
-			}
-			rc = process_one(p, recurse);
-			free(p);
-			return rc;
-		}
-	}
-}
+	globfree(&globbuf);
 
-int exclude(const char *file)
-{
-	int i = 0;
-	for (i = 0; i < excludeCtr; i++) {
-		if (strncmp
-		    (file, excludeArray[i].directory,
-		     excludeArray[i].size) == 0) {
-			if (file[excludeArray[i].size] == 0
-			    || file[excludeArray[i].size] == '/') {
-				return 1;
-			}
-		}
-	}
-	return 0;
+	return errors;
 }
 
-int add_exclude(const char *directory)
+void add_exclude(const char *directory)
 {
-	size_t len = 0;
+	char **tmp_list;
 
 	if (directory == NULL || directory[0] != '/') {
 		fprintf(stderr, "Full path required for exclude: %s.\n",
-			directory);
-		return 1;
-	}
-	if (excludeCtr == MAX_EXCLUDES) {
-		fprintf(stderr, "Maximum excludes %d exceeded.\n",
-			MAX_EXCLUDES);
-		return 1;
+			    directory);
+		exit(-1);
 	}
 
-	len = strlen(directory);
-	while (len > 1 && directory[len - 1] == '/') {
-		len--;
-	}
-	excludeArray[excludeCtr].directory = strndup(directory, len);
-
-	if (excludeArray[excludeCtr].directory == NULL) {
-		fprintf(stderr, "Out of memory.\n");
-		return 1;
-	}
-	excludeArray[excludeCtr++].size = len;
-
-	return 0;
-}
-
-/*
- * Evaluate the association hash table distribution.
- */
-static void filespec_eval(void)
-{
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
-	if (r_opts->verbose > 1)
-		printf
-		    ("%s:  hash table stats: %d elements, %d/%d buckets used, longest chain length %d\n",
-		     __FUNCTION__, nel, used, HASH_BUCKETS, longest);
-}
-
-/*
- * Destroy the association hash table.
- */
-static void filespec_destroy(void)
-{
-	file_spec_t *fl, *tmp;
-	int h;
-
-	if (!fl_head)
-		return;
-
-	for (h = 0; h < HASH_BUCKETS; h++) {
-		fl = fl_head[h].next;
-		while (fl) {
-			tmp = fl;
-			fl = fl->next;
-			freecon(tmp->con);
-			free(tmp->file);
-			free(tmp);
-		}
-		fl_head[h].next = NULL;
-	}
-	free(fl_head);
-	fl_head = NULL;
-}
-/*
- * Try to add an association between an inode and a context.
- * If there is a different context that matched the inode,
- * then use the first context that matched.
- */
-static int filespec_add(ino_t ino, const security_context_t con, const char *file)
-{
-	file_spec_t *prevfl, *fl;
-	int h, ret;
-	struct stat64 sb;
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
-			ret = lstat64(fl->file, &sb);
-			if (ret < 0 || sb.st_ino != ino) {
-				freecon(fl->con);
-				free(fl->file);
-				fl->file = strdup(file);
-				if (!fl->file)
-					goto oom;
-				fl->con = strdup(con);
-				if (!fl->con)
-					goto oom;
-				return 1;
-			}
-
-			if (strcmp(fl->con, con) == 0)
-				return 1;
-
-			fprintf(stderr,
-				"%s:  conflicting specifications for %s and %s, using %s.\n",
-				__FUNCTION__, file, fl->file, fl->con);
-			free(fl->file);
-			fl->file = strdup(file);
-			if (!fl->file)
-				goto oom;
-			return 1;
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
-	fl->con = strdup(con);
-	if (!fl->con)
-		goto oom_freefl;
-	fl->file = strdup(file);
-	if (!fl->file)
-		goto oom_freefl;
-	fl->next = prevfl->next;
-	prevfl->next = fl;
-	return 0;
-      oom_freefl:
-	free(fl);
-      oom:
-	fprintf(stderr,
-		"%s:  insufficient memory for file label entry for %s\n",
-		__FUNCTION__, file);
-	return -1;
-}
-
-#include <sys/utsname.h>
-int file_system_count(char *name) {
-	struct statvfs statvfs_buf;
-	int nfile = 0;
-	memset(&statvfs_buf, 0, sizeof(statvfs_buf));
-	if (!statvfs(name, &statvfs_buf)) {
-		nfile = statvfs_buf.f_files - statvfs_buf.f_ffree;
+	/* Add another two entries, one for directory, and the other to
+	 * terminate the list.
+	 */
+	tmp_list = realloc(exclude_list, sizeof(char *) * (exclude_count + 2));
+	if (!tmp_list) {
+		fprintf(stderr, "realloc failed while excluding %s.\n",
+			    directory);
+		exit(-1);
 	}
-	return nfile;
-}
-
-/*
-   Search /proc/mounts for all file systems that do not support extended
-   attributes and add them to the exclude directory table.  File systems
-   that support security labels have the seclabel option, return total file count
-*/
-int exclude_non_seclabel_mounts()
-{
-	struct utsname uts;
-	FILE *fp;
-	size_t len;
-	ssize_t num;
-	int index = 0, found = 0;
-	char *mount_info[4];
-	char *buf = NULL, *item;
-	int nfile = 0;
-	/* Check to see if the kernel supports seclabel */
-	if (uname(&uts) == 0 && strverscmp(uts.release, "2.6.30") < 0)
-		return 0;
-	if (is_selinux_enabled() <= 0)
-		return 0;
-
-	fp = fopen("/proc/mounts", "r");
-	if (!fp)
-		return 0;
+	exclude_list = tmp_list;
 
-	while ((num = getline(&buf, &len, fp)) != -1) {
-		found = 0;
-		index = 0;
-		item = strtok(buf, " ");
-		while (item != NULL) {
-			mount_info[index] = item;
-			if (index == 3)
-				break;
-			index++;
-			item = strtok(NULL, " ");
-		}
-		if (index < 3) {
-			fprintf(stderr,
-				"/proc/mounts record \"%s\" has incorrect format.\n",
-				buf);
-			continue;
-		}
-
-		/* remove pre-existing entry */
-		remove_exclude(mount_info[1]);
-
-		item = strtok(mount_info[3], ",");
-		while (item != NULL) {
-			if (strcmp(item, "seclabel") == 0) {
-				found = 1;
-				nfile += file_system_count(mount_info[1]);
-				break;
-			}
-			item = strtok(NULL, ",");
-		}
-
-		/* exclude mount points without the seclabel option */
-		if (!found)
-			add_exclude(mount_info[1]);
+	exclude_list[exclude_count] = strdup(directory);
+	if (!exclude_list[exclude_count]) {
+		fprintf(stderr, "strdup failed while excluding %s.\n",
+			    directory);
+		exit(-1);
 	}
-
-	free(buf);
-	fclose(fp);
-	/* return estimated #Files + 5% for directories and hard links */
-	return nfile * 1.05;
+	exclude_count++;
+	exclude_list[exclude_count] = NULL;
 }
-
diff --git a/policycoreutils/setfiles/restore.h b/policycoreutils/setfiles/restore.h
index b55de81..f3f4672 100644
--- a/policycoreutils/setfiles/restore.h
+++ b/policycoreutils/setfiles/restore.h
@@ -12,45 +12,48 @@
 #include <sepol/sepol.h>
 #include <selinux/selinux.h>
 #include <selinux/label.h>
+#include <selinux/restorecon.h>
 #include <stdlib.h>
 #include <limits.h>
 #include <stdint.h>
 
-#define STAR_COUNT 1024
+/*
+ * STAR_COUNT is also defined in libselinux/src/selinux_restorecon.c where it
+ * is used to output "*" for each number of files processed. Defined here for
+ * inclusion in man pages.
+*/
+#define STAR_COUNT 1000
 
 /* Things that need to be init'd */
 struct restore_opts {
-	int add_assoc; /* Track inode associations for conflict detection. */
-	int progress;
-	uint64_t count;  /* Number of files processed so far */
-	uint64_t nfile;  /* Estimated total number of files */
-	int debug;
-	int change;
-	int hard_links;
-	int verbose;
-	int logging;
-	int ignore_enoent;
+	unsigned int nochange;
+	unsigned int verbose;
+	unsigned int progress;
+	unsigned int set_specctx;
+	unsigned int add_assoc;
+	unsigned int ignore_digest;
+	unsigned int recurse;
+	unsigned int userealpath;
+	unsigned int xdev;
+	unsigned int abort_on_error;
+	unsigned int syslog_changes;
+	unsigned int log_matches;
+	unsigned int ignore_enoent;
+	/* restorecon_flags holds | of above for restore_init() */
+	unsigned int restorecon_flags;
 	char *rootpath;
-	int rootpathlen;
 	char *progname;
-	FILE *outfile;
-	int force;
 	struct selabel_handle *hnd;
-	int expand_realpath;  /* Expand paths via realpath. */
-	int abort_on_error; /* Abort the file tree walk upon an error. */
-	int quiet;
-	int fts_flags; /* Flags to fts, e.g. follow links, follow mounts */
 	const char *selabel_opt_validate;
 	const char *selabel_opt_path;
+	const char *selabel_opt_digest;
+	int debug;
+	FILE *outfile;
 };
 
 void restore_init(struct restore_opts *opts);
 void restore_finish(void);
-int add_exclude(const char *directory);
-int exclude(const char *path);
-void remove_exclude(const char *directory);
-int process_one_realpath(char *name, int recurse);
-int process_glob(char *name, int recurse);
-int exclude_non_seclabel_mounts(void);
+void add_exclude(const char *directory);
+int process_glob(char *name, struct restore_opts *opts);
 
 #endif
diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index 900def5..3423a45 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -1,13 +1,13 @@
-.TH "restorecon" "8" "2002031409" "" ""
+.TH "restorecon" "8" "10 June 2016" "" "SELinux User Command"
 .SH "NAME"
 restorecon \- restore file(s) default SELinux security contexts.
 
 .SH "SYNOPSIS"
 .B restorecon
-.I [\-R] [\-n] [\-p] [\-v] [\-e directory] pathname...
+.I [\-R] [\-n] [\-p] [\-v] [\-I] [\-e directory] pathname...
 .P
 .B restorecon
-.I \-f infilename [\-e directory] [\-R] [\-n] [\-p] [\-v] [\-F]
+.I \-f infilename [\-e directory] [\-R] [\-n] [\-p] [\-v] [\-F] [\-I]
 
 .SH "DESCRIPTION"
 This manual page describes the
@@ -49,6 +49,12 @@ display usage information and exit.
 .B \-i
 ignore files that do not exist.
 .TP
+.B \-I
+ignore digest, force checking of labels even if the stored SHA1 digest
+matches the specfiles SHA1 digest (see the
+.B NOTES
+section for details).
+.TP
 .B \-n
 don't change any file labels (passive check).  To display the files whose labels would be changed, add \-v.
 .TP
@@ -56,15 +62,28 @@ don't change any file labels (passive check).  To display the files whose labels
 Deprecated, SELinux policy will probably block this access.  Use shell redirection to save list of files with incorrect context in filename.
 .TP
 .B \-p
-show progress by printing * every STAR_COUNT files.  (If you relabel the entire OS, this will show you the percentage complete.)
+show progress by printing * every STAR_COUNT files unless relabeling the entire
+OS, that will then show the approximate percentage complete. Note that the
+.B \-p
+and
+.B \-v
+options are mutually exclusive.
 .TP
 .B \-R, \-r
 change files and directories file labels recursively (descend directories).
 .br
-.B Note: restorecon reports warnings on paths without default labels only if called non-recursively or in verbose mode.
 .TP
 .B \-v
-show changes in file labels, if type or role are going to be changed.
+show changes in file labels. Note that the
+.B \-v
+and
+.B \-p
+options are mutually exclusive.
+.TP
+.B \-W
+display warnings about entries that had no matching files by outputting the
+.BR selabel_stats (3)
+results.
 .TP
 .B \-0
 the separator for the input items is assumed to be the null character
@@ -81,9 +100,48 @@ produces input suitable for this mode.
 .SH "ARGUMENTS"
 .B pathname...
 The pathname for the file(s) to be relabeled.
-.SH NOTE
-restorecon does not follow symbolic links and by default it does not
+.SH "NOTES"
+.IP "1." 4
+.B restorecon
+does not follow symbolic links and by default it does not
 operate recursively on directories.
+.IP "2." 4
+If the
+.B pathname
+specifies the root directory and the
+.B \-vR
+or
+.B \-vr
+options are set and the audit system is running, then an audit event is
+automatically logged stating that a "mass relabel" took place using the
+message label
+.BR FS_RELABEL .
+.IP "3." 4
+To improve performance when relabeling file systems recursively (i.e. the
+.B \-R
+or
+.B \-r
+option is set),
+.B restorecon
+will write an SHA1 digest of the default specfiles set to an extended
+attribute named
+.IR security.restorecon_last
+to the directory specified in each
+.B pathname...
+once the relabeling has been completed successfully. This digest will be
+checked should
+.B restorecon
+be rerun with the same
+.B pathname
+parameters. See
+.BR selinux_restorecon (3)
+for further details.
+.sp
+The
+.B \-I
+option will ignore the SHA1 digest and provided the
+.B \-n
+option is NOT set, files will be relabeled as required.
 
 .SH "AUTHOR"
 This man page was written by Dan Walsh <dwalsh@redhat.com>.
diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index 57067d2..3907bf5 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -1,10 +1,10 @@
-.TH "setfiles" "8" "2002031409" "" ""
+.TH "setfiles" "8" "10 June 2016" "" "SELinux User Command"
 .SH "NAME"
 setfiles \- set SELinux file security contexts.
 
 .SH "SYNOPSIS"
 .B setfiles
-.I [\-c policy] [\-d] [\-l] [\-n] [\-e directory] [\-o filename] [\-p] [\-q] [\-s] [\-v] [\-W] [\-F] spec_file pathname...
+.I [\-c policy] [\-d] [\-l] [\-n] [\-e directory] [\-o filename] [\-p] [\-q] [\-s] [\-v] [\-W] [\-F] [\-I] spec_file pathname...
 .SH "DESCRIPTION"
 This manual page describes the
 .BR setfiles
@@ -50,6 +50,12 @@ display usage information and exit.
 .B \-i
 ignore files that do not exist.
 .TP
+.B \-I
+ignore digest, force checking of labels even if the stored SHA1 digest
+matches the specfiles SHA1 digest (see the
+.B NOTES
+section for details).
+.TP
 .B \-l
 log changes in file labels to syslog.
 .TP
@@ -60,23 +66,38 @@ don't change any file labels (passive check).
 Deprecated, SELinux policy will probably block this access.  Use shell redirection to save list of files with incorrect context in filename.
 .TP
 .B \-p
-show progress by printing * every STAR_COUNT files.  (If you relabel the entire OS, this will show you the percentage complete.)
+show progress by printing * every STAR_COUNT files unless relabeling the entire
+OS, that will then show the approximate percentage complete. Note that the
+.B \-p
+and
+.B \-v
+options are mutually exclusive.
 .TP 
 .B \-q
-suppress non-error output.
+Deprecated, was only used to stop printing inode association parameters.
 .TP 
 .B \-r rootpath
-use an alternate root path.
+use an alternate root path. Used in meta-selinux for OpenEmbedded/Yocto builds
+to label files under
+.B rootpath
+as if they were at /
 .TP 
 .B \-s
 take a list of files from standard input instead of using a pathname from the
 command line (equivalent to \-f \-).
 .TP
 .B \-v
-show changes in file labels.
+show changes in file labels and output any inode association parameters.
+Note that the
+.B \-v
+and
+.B \-p
+options are mutually exclusive.
 .TP 
 .B \-W
-display warnings about entries that had no matching files.
+display warnings about entries that had no matching files by outputting the
+.BR selabel_stats (3)
+results.
 .TP 
 .B \-0
 the separator for the input items is assumed to be the null character
@@ -121,6 +142,46 @@ or the
 .B \-s
 option is used.
 
+.SH "NOTES"
+.IP "1." 4
+.B setfiles
+follows symbolic links and operates recursively on directories.
+.IP "2." 4
+If the
+.B pathname
+specifies the root directory and the
+.B \-v
+option is set and the audit system is running, then an audit event is
+automatically logged stating that a "mass relabel" took place using the
+message label
+.BR FS_RELABEL .
+.IP "3." 4
+To improve performance when relabeling file systems recursively
+.B setfiles
+will write an SHA1 digest of the
+.B spec_file
+set to an extended attribute named
+.IR security.restorecon_last
+to the directory specified in each
+.B pathname...
+once the relabeling has been completed successfully. This digest will be
+checked should
+.B setfiles
+be rerun
+with the same
+.B spec_file
+and
+.B pathname
+parameters. See
+.BR selinux_restorecon (3)
+for further details.
+.sp
+The
+.B \-I
+option will ignore the SHA1 digest and provided the
+.B \-n
+option is NOT set, files will be relabeled as required.
+
 .SH "AUTHOR"
 This man page was written by Russell Coker <russell@coker.com.au>.
 The program was written by Stephen Smalley <sds@epoch.ncsc.mil>
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 9ac3ebd..e12c10f 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -5,7 +5,6 @@
 #include <ctype.h>
 #include <regex.h>
 #include <sys/vfs.h>
-#define __USE_XOPEN_EXTENDED 1	/* nftw */
 #include <libgen.h>
 #ifdef USE_AUDIT
 #include <libaudit.h>
@@ -15,13 +14,11 @@
 #endif
 #endif
 
-
-/* cmdline opts*/
-
-static char *policyfile = NULL;
-static int warn_no_match = 0;
-static int null_terminated = 0;
+static char *policyfile;
+static int warn_no_match;
+static int null_terminated;
 static struct restore_opts r_opts;
+static int nerr;
 
 #define STAT_BLOCK_SIZE 1
 
@@ -45,22 +42,20 @@ void usage(const char *const name)
 {
 	if (iamrestorecon) {
 		fprintf(stderr,
-			"usage:  %s [-iFnprRv0] [-e excludedir] pathname...\n"
-			"usage:  %s [-iFnprRv0] [-e excludedir] -f filename\n",
+			"usage:  %s [-iIFnprRv0] [-e excludedir] pathname...\n"
+			"usage:  %s [-iIFnprRv0] [-e excludedir] -f filename\n",
 			name, name);
 	} else {
 		fprintf(stderr,
-			"usage:  %s [-dilnpqvFW] [-e excludedir] [-r alt_root_path] spec_file pathname...\n"
-			"usage:  %s [-dilnpqvFW] [-e excludedir] [-r alt_root_path] spec_file -f filename\n"
-			"usage:  %s -s [-dilnpqvFW] spec_file\n"
+			"usage:  %s [-diIlnpqvFW] [-e excludedir] [-r alt_root_path] spec_file pathname...\n"
+			"usage:  %s [-diIlnpqvFW] [-e excludedir] [-r alt_root_path] spec_file -f filename\n"
+			"usage:  %s -s [-diIlnpqvFW] spec_file\n"
 			"usage:  %s -c policyfile spec_file\n",
 			name, name, name, name);
 	}
 	exit(-1);
 }
 
-static int nerr = 0;
-
 void inc_err(void)
 {
 	nerr++;
@@ -70,24 +65,21 @@ void inc_err(void)
 	}
 }
 
-
-
 void set_rootpath(const char *arg)
 {
-	int len;
+	if (strlen(arg) == 1 && strncmp(arg, "/", 1) == 0) {
+		fprintf(stderr, "%s:  invalid alt_rootpath: %s\n",
+			r_opts.progname, arg);
+		exit(-1);
+	}
 
 	r_opts.rootpath = strdup(arg);
-	if (NULL == r_opts.rootpath) {
-		fprintf(stderr, "%s:  insufficient memory for r_opts.rootpath\n",
+	if (!r_opts.rootpath) {
+		fprintf(stderr,
+			"%s:  insufficient memory for r_opts.rootpath\n",
 			r_opts.progname);
 		exit(-1);
 	}
-
-	/* trim trailing /, if present */
-	len = strlen(r_opts.rootpath);
-	while (len && ('/' == r_opts.rootpath[len - 1]))
-		r_opts.rootpath[--len] = 0;
-	r_opts.rootpathlen = len;
 }
 
 int canoncon(char **contextp)
@@ -113,7 +105,7 @@ int canoncon(char **contextp)
 
 #ifndef USE_AUDIT
 static void maybe_audit_mass_relabel(int mass_relabel __attribute__((unused)),
-				     int mass_relabel_errs __attribute__((unused)))
+				int mass_relabel_errs __attribute__((unused)))
 {
 #else
 static void maybe_audit_mass_relabel(int mass_relabel, int mass_relabel_errs)
@@ -132,11 +124,14 @@ static void maybe_audit_mass_relabel(int mass_relabel, int mass_relabel_errs)
 	}
 
 	rc = audit_log_user_message(audit_fd, AUDIT_FS_RELABEL,
-				    "op=mass relabel", NULL, NULL, NULL, !mass_relabel_errs);
+				    "op=mass relabel",
+				    NULL, NULL, NULL, !mass_relabel_errs);
 	if (rc <= 0) {
 		fprintf(stderr, "Error sending audit message: %s.\n",
 			strerror(errno));
-		/* exit(-1); -- don't exit atm. as fix for eff_cap isn't in most kernels */
+		/* exit(-1); -- don't exit atm. as fix for eff_cap isn't
+		 * in most kernels.
+		 */
 	}
 	audit_close(audit_fd);
 #endif
@@ -150,30 +145,19 @@ int main(int argc, char **argv)
 	int use_input_file = 0;
 	char *buf = NULL;
 	size_t buf_len;
-	int recurse; /* Recursive descent. */
 	const char *base;
 	int mass_relabel = 0, errors = 0;
-	const char *ropts = "e:f:hilno:pqrsvFRW0";
-	const char *sopts = "c:de:f:hilno:pqr:svFR:W0";
+	const char *ropts = "e:f:hiIlno:pqrsvFRW0";
+	const char *sopts = "c:de:f:hiIlno:pqr:svFR:W0";
 	const char *opts;
-	
-	memset(&r_opts, 0, sizeof(r_opts));
 
 	/* Initialize variables */
-	r_opts.progress = 0;
-	r_opts.count = 0;
-	r_opts.nfile = 0;
-	r_opts.debug = 0;
-	r_opts.change = 1;
-	r_opts.verbose = 0;
-	r_opts.logging = 0;
-	r_opts.rootpath = NULL;
-	r_opts.rootpathlen = 0;
-	r_opts.outfile = NULL;
-	r_opts.force = 0;
-	r_opts.hard_links = 1;
-
+	memset(&r_opts, 0, sizeof(r_opts));
 	altpath = NULL;
+	null_terminated = 0;
+	warn_no_match = 0;
+	policyfile = NULL;
+	nerr = 0;
 
 	r_opts.progname = strdup(argv[0]);
 	if (!r_opts.progname) {
@@ -181,55 +165,56 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
 	base = basename(r_opts.progname);
-	
+
 	if (!strcmp(base, SETFILES)) {
-		/* 
-		 * setfiles:  
+		/*
+		 * setfiles:
 		 * Recursive descent,
-		 * Does not expand paths via realpath, 
-		 * Aborts on errors during the file tree walk, 
+		 * Does not expand paths via realpath,
+		 * Aborts on errors during the file tree walk,
 		 * Try to track inode associations for conflict detection,
 		 * Does not follow mounts,
-		 * Validates all file contexts at init time. 
+		 * Validates all file contexts at init time.
 		 */
 		iamrestorecon = 0;
-		recurse = 1;
-		r_opts.expand_realpath = 0;
-		r_opts.abort_on_error = 1;
-		r_opts.add_assoc = 1;
-		r_opts.fts_flags = FTS_PHYSICAL | FTS_XDEV;
+		r_opts.recurse = SELINUX_RESTORECON_RECURSE;
+		r_opts.userealpath = 0; /* SELINUX_RESTORECON_REALPATH */
+		r_opts.abort_on_error = SELINUX_RESTORECON_ABORT_ON_ERROR;
+		r_opts.add_assoc = SELINUX_RESTORECON_ADD_ASSOC;
+		/* FTS_PHYSICAL and FTS_NOCHDIR are always set by selinux_restorecon(3) */
+		r_opts.xdev = SELINUX_RESTORECON_XDEV;
 		ctx_validate = 1;
 		opts = sopts;
 	} else {
 		/*
-		 * restorecon:  
+		 * restorecon:
 		 * No recursive descent unless -r/-R,
-		 * Expands paths via realpath, 
+		 * Expands paths via realpath,
 		 * Do not abort on errors during the file tree walk,
 		 * Do not try to track inode associations for conflict detection,
 		 * Follows mounts,
-		 * Does lazy validation of contexts upon use. 
+		 * Does lazy validation of contexts upon use.
 		 */
-		if (strcmp(base, RESTORECON) && !r_opts.quiet) 
-			printf("Executed with an unrecognized name (%s), defaulting to %s behavior.\n", base, RESTORECON);
+		if (strcmp(base, RESTORECON))
+			fprintf(stderr, "Executed with unrecognized name (%s), defaulting to %s behavior.\n",
+				base, RESTORECON);
+
 		iamrestorecon = 1;
-		recurse = 0;
-		r_opts.expand_realpath = 1;
+		r_opts.recurse = 0;
+		r_opts.userealpath = SELINUX_RESTORECON_REALPATH;
 		r_opts.abort_on_error = 0;
 		r_opts.add_assoc = 0;
-		r_opts.fts_flags = FTS_PHYSICAL;
+		r_opts.xdev = 0;
 		ctx_validate = 0;
 		opts = ropts;
 
 		/* restorecon only:  silent exit if no SELinux.
-		   Allows unconditional execution by scripts. */
+		 * Allows unconditional execution by scripts.
+		 */
 		if (is_selinux_enabled() <= 0)
 			exit(0);
 	}
 
-	/* This must happen before getopt. */
-	r_opts.nfile = exclude_non_seclabel_mounts();
-
 	/* Process any options. */
 	while ((opt = getopt(argc, argv, opts)) > 0) {
 		switch (opt) {
@@ -252,8 +237,8 @@ int main(int argc, char **argv)
 				__fsetlocking(policystream,
 					      FSETLOCKING_BYCALLER);
 
-				if (sepol_set_policydb_from_file(policystream) <
-				    0) {
+				if (sepol_set_policydb_from_file(policystream)
+									< 0) {
 					fprintf(stderr,
 						"Error reading policy %s: %s\n",
 						policyfile, strerror(errno));
@@ -262,41 +247,42 @@ int main(int argc, char **argv)
 				fclose(policystream);
 
 				ctx_validate = 1;
-
 				break;
 			}
 		case 'e':
-			remove_exclude(optarg);
 			if (lstat(optarg, &sb) < 0 && errno != EACCES) {
 				fprintf(stderr, "Can't stat exclude path \"%s\", %s - ignoring.\n",
 					optarg, strerror(errno));
 				break;
 			}
-			if (add_exclude(optarg))
-				exit(-1);
+			add_exclude(optarg);
 			break;
 		case 'f':
 			use_input_file = 1;
 			input_filename = optarg;
-			break;			
+			break;
 		case 'd':
 			if (iamrestorecon)
 				usage(argv[0]);
 			r_opts.debug = 1;
+			r_opts.log_matches = SELINUX_RESTORECON_LOG_MATCHES;
 			break;
 		case 'i':
-			r_opts.ignore_enoent = 1;
+			r_opts.ignore_enoent = SELINUX_RESTORECON_IGNORE_NOENTRY;
+			break;
+		case 'I':
+			r_opts.ignore_digest = SELINUX_RESTORECON_IGNORE_DIGEST;
 			break;
 		case 'l':
-			r_opts.logging = 1;
+			r_opts.syslog_changes = SELINUX_RESTORECON_SYSLOG_CHANGES;
 			break;
 		case 'F':
-			r_opts.force = 1;
+			r_opts.set_specctx = SELINUX_RESTORECON_SET_SPECFILE_CTX;
 			break;
 		case 'n':
-			r_opts.change = 0;
+			r_opts.nochange = SELINUX_RESTORECON_NOCHANGE;
 			break;
-		case 'o':
+		case 'o': /* Deprecated */
 			if (strcmp(optarg, "-") == 0) {
 				r_opts.outfile = stdout;
 				break;
@@ -312,15 +298,24 @@ int main(int argc, char **argv)
 			__fsetlocking(r_opts.outfile, FSETLOCKING_BYCALLER);
 			break;
 		case 'q':
-			r_opts.quiet = 1;
+			/* Deprecated - Was only used to say whether print
+			 * filespec_eval() params. Now uses verbose flag.
+			 */
 			break;
 		case 'R':
 		case 'r':
 			if (iamrestorecon) {
-				recurse = 1;
+				r_opts.recurse = SELINUX_RESTORECON_RECURSE;
 				break;
 			}
-			if (NULL != r_opts.rootpath) {
+
+			if (lstat(optarg, &sb) < 0 && errno != EACCES) {
+				fprintf(stderr, "Can't stat alt_root_path \"%s\", %s\n",
+					optarg, strerror(errno));
+				exit(-1);
+			}
+
+			if (r_opts.rootpath) {
 				fprintf(stderr,
 					"%s: only one -r can be specified\n",
 					argv[0]);
@@ -337,9 +332,9 @@ int main(int argc, char **argv)
 			if (r_opts.progress) {
 				fprintf(stderr,
 					"Progress and Verbose mutually exclusive\n");
-				exit(-1);
+				usage(argv[0]);
 			}
-			r_opts.verbose++;
+			r_opts.verbose = SELINUX_RESTORECON_VERBOSE;
 			break;
 		case 'p':
 			if (r_opts.verbose) {
@@ -347,10 +342,10 @@ int main(int argc, char **argv)
 					"Progress and Verbose mutually exclusive\n");
 				usage(argv[0]);
 			}
-			r_opts.progress++;
+			r_opts.progress = SELINUX_RESTORECON_PROGRESS;
 			break;
 		case 'W':
-			warn_no_match = 1;
+			warn_no_match = 1; /* Print selabel_stats() */
 			break;
 		case '0':
 			null_terminated = 1;
@@ -362,11 +357,8 @@ int main(int argc, char **argv)
 	}
 
 	for (i = optind; i < argc; i++) {
-		if (!strcmp(argv[i], "/")) {
+		if (!strcmp(argv[i], "/"))
 			mass_relabel = 1;
-			if (r_opts.progress)
-				r_opts.progress++;
-		}
 	}
 
 	if (!iamrestorecon) {
@@ -384,8 +376,9 @@ int main(int argc, char **argv)
 		}
 
 		/* Use our own invalid context checking function so that
-		   we can support either checking against the active policy or
-		   checking against a binary policy file. */
+		 * we can support either checking against the active policy or
+		 * checking against a binary policy file.
+		 */
 		selinux_set_callback(SELINUX_CB_VALIDATE,
 				     (union selinux_callback)&canoncon);
 
@@ -406,20 +399,25 @@ int main(int argc, char **argv)
 
 	/* Load the file contexts configuration and check it. */
 	r_opts.selabel_opt_validate = (ctx_validate ? (char *)1 : NULL);
+	r_opts.selabel_opt_digest = (r_opts.ignore_digest ? NULL : (char *)1);
 	r_opts.selabel_opt_path = altpath;
 
 	if (nerr)
 		exit(-1);
 
 	restore_init(&r_opts);
+
 	if (use_input_file) {
 		FILE *f = stdin;
 		ssize_t len;
 		int delim;
+
 		if (strcmp(input_filename, "-") != 0)
 			f = fopen(input_filename, "r");
+
 		if (f == NULL) {
-			fprintf(stderr, "Unable to open %s: %s\n", input_filename,
+			fprintf(stderr, "Unable to open %s: %s\n",
+				input_filename,
 				strerror(errno));
 			usage(argv[0]);
 		}
@@ -430,15 +428,15 @@ int main(int argc, char **argv)
 			buf[len - 1] = 0;
 			if (!strcmp(buf, "/"))
 				mass_relabel = 1;
-			errors |= process_glob(buf, recurse) < 0;
+			errors |= process_glob(buf, &r_opts) < 0;
 		}
 		if (strcmp(input_filename, "-") != 0)
 			fclose(f);
 	} else {
 		for (i = optind; i < argc; i++)
-			errors |= process_glob(argv[i], recurse) < 0;
+			errors |= process_glob(argv[i], &r_opts) < 0;
 	}
-	
+
 	maybe_audit_mass_relabel(mass_relabel, errors);
 
 	if (warn_no_match)
@@ -450,7 +448,5 @@ int main(int argc, char **argv)
 	if (r_opts.outfile)
 		fclose(r_opts.outfile);
 
-	if (r_opts.progress && r_opts.count >= STAR_COUNT)
-		printf("\n");
-	exit(errors ? -1: 0);
+	exit(errors ? -1 : 0);
 }
-- 
2.5.5
