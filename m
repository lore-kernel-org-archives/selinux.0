Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9TEEjJN023666
	for <selinux@tycho.nsa.gov>; Thu, 29 Oct 2009 10:14:45 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9TEDldR012285
	for <selinux@tycho.nsa.gov>; Thu, 29 Oct 2009 14:13:47 GMT
Message-ID: <4AE9A351.7070602@redhat.com>
Date: Thu, 29 Oct 2009 10:14:41 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: selinux@tycho.nsa.gov, kangchao@WPI.EDU, Thomas Liu <tliu@redhat.com>
Subject: Re: [PATCH 1/2] policycoreutils: share setfiles restore function
 with restorecond
References: <1250711250.2835.24.camel@Hephaestus> <1256760199-29171-1-git-send-email-csellers@tresys.com>
In-Reply-To: <1256760199-29171-1-git-send-email-csellers@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/28/2009 04:03 PM, Chad Sellers wrote:
> I've rebased this so that it will apply to current trunk (which is included below). Looks pretty good to me, though I have 2 questions:
> 
> 1) Why remove the free() call in remove_exclude()?
> 2) Why the new check at the beginning of match()?
> 
> Other than that, let me know if anyone spots a rebasing error.
> 
> Rebased patch:
> 
> This is the first of two patches.
> 
> This patch splits all of the restore functionality in setfiles
> into another two files, restore.c and restore.h.
> 
> The reason for this is shown in the next patch, which patches
> restorecond to share this code.
> 
> To use it, instantiate a restore_opts struct with the proper options
> and then pass a pointer to it into restore_init, and call restore_destroy
> later.
> 
> Signed-off-by: Thomas Liu <tliu@redhat.com>
> Signed-off-by: Dan Walsh <dwalsh@redhat.com>
> 
> ---
>  policycoreutils/setfiles/Makefile   |    4 +-
>  policycoreutils/setfiles/restore.c  |  605 ++++++++++++++++++++++++++++
>  policycoreutils/setfiles/restore.h  |   50 +++
>  policycoreutils/setfiles/setfiles.c |  741 ++++-------------------------------
>  4 files changed, 735 insertions(+), 665 deletions(-)
>  create mode 100644 policycoreutils/setfiles/restore.c
>  create mode 100644 policycoreutils/setfiles/restore.h
> 
> diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles/Makefile
> index 8600f58..26a965f 100644
> --- a/policycoreutils/setfiles/Makefile
> +++ b/policycoreutils/setfiles/Makefile
> @@ -5,7 +5,7 @@ MANDIR = $(PREFIX)/share/man
>  LIBDIR ?= $(PREFIX)/lib
>  AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
>  
> -CFLAGS = -Werror -Wall -W
> +CFLAGS = -g -Werror -Wall -W
>  override CFLAGS += -I$(PREFIX)/include
>  LDLIBS = -lselinux -lsepol -L$(LIBDIR)
>  
> @@ -16,7 +16,7 @@ endif
>  
>  all: setfiles restorecon
>  
> -setfiles:  setfiles.o 
> +setfiles:  setfiles.o restore.o
>  
>  restorecon: setfiles
>  	ln -sf setfiles restorecon
> diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfiles/restore.c
> new file mode 100644
> index 0000000..d37fe22
> --- /dev/null
> +++ b/policycoreutils/setfiles/restore.c
> @@ -0,0 +1,605 @@
> +#include "restore.h"
> +
> +#define SKIP -2
> +#define ERR -1
> +#define MAX_EXCLUDES 1000
> +
> +/*
> + * The hash table of associations, hashed by inode number.
> + * Chaining is used for collisions, with elements ordered
> + * by inode number in each bucket.  Each hash bucket has a dummy 
> + * header.
> + */
> +#define HASH_BITS 16
> +#define HASH_BUCKETS (1 << HASH_BITS)
> +#define HASH_MASK (HASH_BUCKETS-1)
> +
> +/*
> + * An association between an inode and a context.
> + */
> +typedef struct file_spec {
> +	ino_t ino;		/* inode number */
> +	char *con;		/* matched context */
> +	char *file;		/* full pathname */
> +	struct file_spec *next;	/* next association in hash bucket chain */
> +} file_spec_t;
> +
> +struct edir {
> +	char *directory;
> +	size_t size;
> +};
> +
> +
> +static file_spec_t *fl_head;
> +static int exclude(const char *file);
> +static int filespec_add(ino_t ino, const security_context_t con, const char *file);
> +static int only_changed_user(const char *a, const char *b);
> +struct restore_opts *r_opts = NULL;
> +static void filespec_destroy(void);
> +static void filespec_eval(void);
> +static int excludeCtr = 0;
> +static struct edir excludeArray[MAX_EXCLUDES];
> +
> +void remove_exclude(const char *directory)
> +{
> +	int i = 0;
> +	for (i = 0; i < excludeCtr; i++) {
> +		if (strcmp(directory, excludeArray[i].directory) == 0) {
> +			if (i != excludeCtr-1)
> +				excludeArray[i] = excludeArray[excludeCtr-1];
> +			excludeCtr--;
> +			return;
> +		}
> +	}
> +	return;
> +
> +}
> +
> +void restore_init(struct restore_opts *opts)
> +{	
> +	r_opts = opts;
> +	struct selinux_opt selinux_opts[] = {
> +		{ SELABEL_OPT_VALIDATE, r_opts->selabel_opt_validate },
> +		{ SELABEL_OPT_PATH, r_opts->selabel_opt_path }
> +	};
> +	r_opts->hnd = selabel_open(SELABEL_CTX_FILE, selinux_opts, 2);
> +	if (!r_opts->hnd) {
> +		perror(r_opts->selabel_opt_path);
> +		exit(1);
> +	}	
> +}
> +
> +void restore_finish()
> +{
> +	int i;
> +	for (i = 0; i < excludeCtr; i++) {
> +		free(excludeArray[i].directory);
> +	}
> +}
> +
> +static int match(const char *name, struct stat *sb, char **con)
> +{
> +	if (!(r_opts->hard_links) && !S_ISDIR(sb->st_mode) && (sb->st_nlink > 1)) {
> +		fprintf(stderr, "Warning! %s refers to a hard link, not fixing hard links.\n",
> +					name);
> +		return -1;
> +	}
> +	
> +	if (NULL != r_opts->rootpath) {
> +		if (0 != strncmp(r_opts->rootpath, name, r_opts->rootpathlen)) {
> +			fprintf(stderr, "%s:  %s is not located in %s\n",
> +				r_opts->progname, name, r_opts->rootpath);
> +			return -1;
> +		}
> +		name += r_opts->rootpathlen;
> +	}
> +
> +	if (r_opts->rootpath != NULL && name[0] == '\0')
> +		/* this is actually the root dir of the alt root */
> +		return selabel_lookup_raw(r_opts->hnd, con, "/", sb->st_mode);
> +	else
> +		return selabel_lookup_raw(r_opts->hnd, con, name, sb->st_mode);
> +}
> +static int restore(FTSENT *ftsent)
> +{
> +	char *my_file = strdupa(ftsent->fts_path);
> +	int ret;
> +	char *context, *newcon;
> +	int user_only_changed = 0;
> +
> +	if (match(my_file, ftsent->fts_statp, &newcon) < 0)
> +		/* Check for no matching specification. */
> +		return (errno == ENOENT) ? 0 : -1;
> +
> +	if (r_opts->progress) {
> +		r_opts->count++;
> +		if (r_opts->count % (80 * STAR_COUNT) == 0) {
> +			fprintf(stdout, "\n");
> +			fflush(stdout);
> +		}
> +		if (r_opts->count % STAR_COUNT == 0) {
> +			fprintf(stdout, "*");
> +			fflush(stdout);
> +		}
> +	}
> +
> +	/*
> +	 * Try to add an association between this inode and
> +	 * this specification.  If there is already an association
> +	 * for this inode and it conflicts with this specification,
> +	 * then use the last matching specification.
> +	 */
> +	if (r_opts->add_assoc) {
> +		ret = filespec_add(ftsent->fts_statp->st_ino, newcon, my_file);
> +		if (ret < 0)
> +			goto err;
> +
> +		if (ret > 0)
> +			/* There was already an association and it took precedence. */
> +			goto out;
> +	}
> +
> +	if (r_opts->debug) {
> +		printf("%s:  %s matched by %s\n", r_opts->progname, my_file, newcon);
> +	}
> +
> +	/* Get the current context of the file. */
> +	ret = lgetfilecon_raw(ftsent->fts_accpath, &context);
> +	if (ret < 0) {
> +		if (errno == ENODATA) {
> +			context = NULL;
> +		} else {
> +			fprintf(stderr, "%s get context on %s failed: '%s'\n",
> +				r_opts->progname, my_file, strerror(errno));
> +			goto err;
> +		}
> +		user_only_changed = 0;
> +	} else
> +		user_only_changed = only_changed_user(context, newcon);
> +	/* lgetfilecon returns number of characters and ret needs to be reset
> +	 * to 0.
> +	 */
> +	ret = 0;
> +
> +	/*
> +	 * Do not relabel the file if the matching specification is 
> +	 * <<none>> or the file is already labeled according to the 
> +	 * specification.
> +	 */
> +	if ((strcmp(newcon, "<<none>>") == 0) ||
> +	    (context && (strcmp(context, newcon) == 0))) {
> +		freecon(context);
> +		goto out;
> +	}
> +
> +	if (!r_opts->force && context && (is_context_customizable(context) > 0)) {
> +		if (r_opts->verbose > 1) {
> +			fprintf(stderr,
> +				"%s: %s not reset customized by admin to %s\n",
> +				r_opts->progname, my_file, context);
> +		}
> +		freecon(context);
> +		goto out;
> +	}
> +
> +	if (r_opts->verbose) {
> +		/* If we're just doing "-v", trim out any relabels where
> +		 * the user has r_opts->changed but the role and type are the
> +		 * same.  For "-vv", emit everything. */
> +		if (r_opts->verbose > 1 || !user_only_changed) {
> +			printf("%s reset %s context %s->%s\n",
> +			       r_opts->progname, my_file, context ?: "", newcon);
> +		}
> +	}
> +
> +	if (r_opts->logging && !user_only_changed) {
> +		if (context)
> +			syslog(LOG_INFO, "relabeling %s from %s to %s\n",
> +			       my_file, context, newcon);
> +		else
> +			syslog(LOG_INFO, "labeling %s to %s\n",
> +			       my_file, newcon);
> +	}
> +
> +	if (r_opts->outfile && !user_only_changed)
> +		fprintf(r_opts->outfile, "%s\n", my_file);
> +
> +	if (context)
> +		freecon(context);
> +
> +	/*
> +	 * Do not relabel the file if -n was used.
> +	 */
> +	if (!r_opts->change || user_only_changed)
> +		goto out;
> +
> +	/*
> +	 * Relabel the file to the specified context.
> +	 */
> +	ret = lsetfilecon(ftsent->fts_accpath, newcon);
> +	if (ret) {
> +		fprintf(stderr, "%s set context %s->%s failed:'%s'\n",
> +			r_opts->progname, my_file, newcon, strerror(errno));
> +		goto skip;
> +	}
> +	ret = 1;
> +out:
> +	freecon(newcon);
> +	return ret;
> +skip:
> +	freecon(newcon);
> +	return SKIP;
> +err:
> +	freecon(newcon);
> +	return ERR;
> +}
> +/*
> + * Apply the last matching specification to a file.
> + * This function is called by fts on each file during
> + * the directory traversal.
> + */
> +static int apply_spec(FTSENT *ftsent)
> +{
> +	if (ftsent->fts_info == FTS_DNR) {
> +		fprintf(stderr, "%s:  unable to read directory %s\n",
> +			r_opts->progname, ftsent->fts_path);
> +		return SKIP;
> +	}
> +	
> +	int rc = restore(ftsent);
> +	if (rc == ERR) {
> +		if (!r_opts->abort_on_error)
> +			return SKIP;
> +	}
> +	return rc;
> +}
> +
> +static int symlink_realpath(char *name, char *path)
> +{
> +	char *p = NULL, *file_sep;
> +	char *tmp_path = strdupa(name);
> +	size_t len = 0;
> +
> +	if (!tmp_path) {
> +		fprintf(stderr, "strdupa on %s failed:  %s\n", name,
> +			strerror(errno));
> +		return -1;
> +	}
> +	file_sep = strrchr(tmp_path, '/');
> +	if (file_sep == tmp_path) {
> +		file_sep++;
> +		p = strcpy(path, "");
> +	} else if (file_sep) {
> +		*file_sep = 0;
> +		file_sep++;
> +		p = realpath(tmp_path, path);
> +	} else {
> +		file_sep = tmp_path;
> +		p = realpath("./", path);
> +	}
> +	if (p)
> +		len = strlen(p);
> +	if (!p || len + strlen(file_sep) + 2 > PATH_MAX) {
> +		fprintf(stderr, "symlink_realpath(%s) failed %s\n", name,
> +			strerror(errno));
> +		return -1;
> +	}
> +	p += len;
> +	/* ensure trailing slash of directory name */
> +	if (len == 0 || *(p - 1) != '/') {
> +		*p = '/';
> +		p++;
> +	}
> +	strcpy(p, file_sep);
> +	return 0;
> +}
> +
> +static int process_one(char *name, int recurse_this_path)
> +{
> +	int rc = 0;
> +	const char *namelist[2] = {name, NULL};
> +	dev_t dev_num = 0;
> +	FTS *fts_handle;
> +	FTSENT *ftsent;
> +
> +	fts_handle = fts_open((char **)namelist, r_opts->fts_flags, NULL);
> +	if (fts_handle  == NULL) {
> +		fprintf(stderr,
> +			"%s: error while labeling %s:  %s\n",
> +			r_opts->progname, namelist[0], strerror(errno));
> +		goto err;
> +	}
> +
> +
> +	ftsent = fts_read(fts_handle);
> +	if (ftsent != NULL) {
> +		/* Keep the inode of the first one. */
> +		dev_num = ftsent->fts_statp->st_dev;
> +	}
> +
> +	do {
> +		rc = 0;
> +		/* Skip the post order nodes. */
> +		if (ftsent->fts_info == FTS_DP)
> +			continue;
> +		/* If the XDEV flag is set and the device is different */
> +		if (ftsent->fts_statp->st_dev != dev_num &&
> +		    FTS_XDEV == (r_opts->fts_flags & FTS_XDEV))
> +			continue;
> +		if (excludeCtr > 0) {
> +			if (exclude(ftsent->fts_path)) {
> +				fts_set(fts_handle, ftsent, FTS_SKIP);
> +				continue;
> +			}
> +		}
> +		rc = apply_spec(ftsent);
> +		if (rc == SKIP)
> +			fts_set(fts_handle, ftsent, FTS_SKIP);
> +		if (rc == ERR)
> +			goto err;
> +		if (!recurse_this_path)
> +			break;
> +	} while ((ftsent = fts_read(fts_handle)) != NULL);
> +
> +out:
> +	if (r_opts->add_assoc) {
> +		if (!r_opts->quiet)
> +			filespec_eval();
> +		filespec_destroy();
> +	}
> +	if (fts_handle)
> +		fts_close(fts_handle);
> +	return rc;
> +
> +err:
> +	rc = -1;
> +	goto out;
> +}
> +
> +int process_one_realpath(char *name, int recurse)
> +{
> +	int rc = 0;
> +	char *p;
> +	struct stat sb;
> +
> +	if (r_opts == NULL){
> +		fprintf(stderr,
> +			"Must call initialize first!");
> +		return -1;
> +	}
> +
> +	if (!r_opts->expand_realpath) {
> +		return process_one(name, recurse);
> +	} else {
> +		rc = lstat(name, &sb);
> +		if (rc < 0) {
> +			fprintf(stderr, "%s:  lstat(%s) failed:  %s\n",
> +				r_opts->progname, name,	strerror(errno));
> +			return -1;
> +		}
> +
> +		if (S_ISLNK(sb.st_mode)) {
> +			char path[PATH_MAX + 1];
> +
> +			rc = symlink_realpath(name, path);
> +			if (rc < 0)
> +				return rc;
> +			rc = process_one(path, 0);
> +			if (rc < 0)
> +				return rc;
> +
> +			p = realpath(name, NULL);
> +			if (p) {
> +				rc = process_one(p, recurse);
> +				free(p);
> +			}
> +			return rc;
> +		} else {
> +			p = realpath(name, NULL);
> +			if (!p) {
> +				fprintf(stderr, "realpath(%s) failed %s\n", name,
> +					strerror(errno));
> +				return -1;
> +			}
> +			rc = process_one(p, recurse);
> +			free(p);
> +			return rc;
> +		}
> +	}
> +}
> +
> +static int exclude(const char *file)
> +{
> +	int i = 0;
> +	for (i = 0; i < excludeCtr; i++) {
> +		if (strncmp
> +		    (file, excludeArray[i].directory,
> +		     excludeArray[i].size) == 0) {
> +			if (file[excludeArray[i].size] == 0
> +			    || file[excludeArray[i].size] == '/') {
> +				return 1;
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +
> +int add_exclude(const char *directory)
> +{
> +	size_t len = 0;
> +
> +	if (directory == NULL || directory[0] != '/') {
> +		fprintf(stderr, "Full path required for exclude: %s.\n",
> +			directory);
> +		return 1;
> +	}
> +	if (excludeCtr == MAX_EXCLUDES) {
> +		fprintf(stderr, "Maximum excludes %d exceeded.\n",
> +			MAX_EXCLUDES);
> +		return 1;
> +	}
> +
> +	len = strlen(directory);
> +	while (len > 1 && directory[len - 1] == '/') {
> +		len--;
> +	}
> +	excludeArray[excludeCtr].directory = strndup(directory, len);
> +
> +	if (excludeArray[excludeCtr].directory == NULL) {
> +		fprintf(stderr, "Out of memory.\n");
> +		return 1;
> +	}
> +	excludeArray[excludeCtr++].size = len;
> +
> +	return 0;
> +}
> +
> +/* Compare two contexts to see if their differences are "significant",
> + * or whether the only difference is in the user. */
> +static int only_changed_user(const char *a, const char *b)
> +{
> +	char *rest_a, *rest_b;	/* Rest of the context after the user */
> +	if (r_opts->force)
> +		return 0;
> +	if (!a || !b)
> +		return 0;
> +	rest_a = strchr(a, ':');
> +	rest_b = strchr(b, ':');
> +	if (!rest_a || !rest_b)
> +		return 0;
> +	return (strcmp(rest_a, rest_b) == 0);
> +}
> +
> +/*
> + * Evaluate the association hash table distribution.
> + */
> +static void filespec_eval(void)
> +{
> +	file_spec_t *fl;
> +	int h, used, nel, len, longest;
> +
> +	if (!fl_head)
> +		return;
> +
> +	used = 0;
> +	longest = 0;
> +	nel = 0;
> +	for (h = 0; h < HASH_BUCKETS; h++) {
> +		len = 0;
> +		for (fl = fl_head[h].next; fl; fl = fl->next) {
> +			len++;
> +		}
> +		if (len)
> +			used++;
> +		if (len > longest)
> +			longest = len;
> +		nel += len;
> +	}
> +
> +	if (r_opts->verbose > 1)
> +		printf
> +		    ("%s:  hash table stats: %d elements, %d/%d buckets used, longest chain length %d\n",
> +		     __FUNCTION__, nel, used, HASH_BUCKETS, longest);
> +}
> +
> +/*
> + * Destroy the association hash table.
> + */
> +static void filespec_destroy(void)
> +{
> +	file_spec_t *fl, *tmp;
> +	int h;
> +
> +	if (!fl_head)
> +		return;
> +
> +	for (h = 0; h < HASH_BUCKETS; h++) {
> +		fl = fl_head[h].next;
> +		while (fl) {
> +			tmp = fl;
> +			fl = fl->next;
> +			freecon(tmp->con);
> +			free(tmp->file);
> +			free(tmp);
> +		}
> +		fl_head[h].next = NULL;
> +	}
> +	free(fl_head);
> +	fl_head = NULL;
> +}
> +/*
> + * Try to add an association between an inode and a context.
> + * If there is a different context that matched the inode,
> + * then use the first context that matched.
> + */
> +static int filespec_add(ino_t ino, const security_context_t con, const char *file)
> +{
> +	file_spec_t *prevfl, *fl;
> +	int h, ret;
> +	struct stat sb;
> +
> +	if (!fl_head) {
> +		fl_head = malloc(sizeof(file_spec_t) * HASH_BUCKETS);
> +		if (!fl_head)
> +			goto oom;
> +		memset(fl_head, 0, sizeof(file_spec_t) * HASH_BUCKETS);
> +	}
> +
> +	h = (ino + (ino >> HASH_BITS)) & HASH_MASK;
> +	for (prevfl = &fl_head[h], fl = fl_head[h].next; fl;
> +	     prevfl = fl, fl = fl->next) {
> +		if (ino == fl->ino) {
> +			ret = lstat(fl->file, &sb);
> +			if (ret < 0 || sb.st_ino != ino) {
> +				freecon(fl->con);
> +				free(fl->file);
> +				fl->file = strdup(file);
> +				if (!fl->file)
> +					goto oom;
> +				fl->con = strdup(con);
> +				if (!fl->con)
> +					goto oom;
> +				return 1;
> +			}
> +
> +			if (strcmp(fl->con, con) == 0)
> +				return 1;
> +
> +			fprintf(stderr,
> +				"%s:  conflicting specifications for %s and %s, using %s.\n",
> +				__FUNCTION__, file, fl->file, fl->con);
> +			free(fl->file);
> +			fl->file = strdup(file);
> +			if (!fl->file)
> +				goto oom;
> +			return 1;
> +		}
> +
> +		if (ino > fl->ino)
> +			break;
> +	}
> +
> +	fl = malloc(sizeof(file_spec_t));
> +	if (!fl)
> +		goto oom;
> +	fl->ino = ino;
> +	fl->con = strdup(con);
> +	if (!fl->con)
> +		goto oom_freefl;
> +	fl->file = strdup(file);
> +	if (!fl->file)
> +		goto oom_freefl;
> +	fl->next = prevfl->next;
> +	prevfl->next = fl;
> +	return 0;
> +      oom_freefl:
> +	free(fl);
> +      oom:
> +	fprintf(stderr,
> +		"%s:  insufficient memory for file label entry for %s\n",
> +		__FUNCTION__, file);
> +	return -1;
> +}
> +
> +
> +
> diff --git a/policycoreutils/setfiles/restore.h b/policycoreutils/setfiles/restore.h
> new file mode 100644
> index 0000000..03b82e8
> --- /dev/null
> +++ b/policycoreutils/setfiles/restore.h
> @@ -0,0 +1,50 @@
> +#ifndef RESTORE_H
> +#define RESTORE_H
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +#include <fts.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <syslog.h>
> +#include <sys/stat.h>
> +#include <sepol/sepol.h>
> +#include <selinux/selinux.h>
> +#include <selinux/label.h>
> +#include <stdlib.h>
> +#include <limits.h>
> +
> +#define STAR_COUNT 1000
> +
> +/* Things that need to be init'd */
> +struct restore_opts {
> +	int add_assoc; /* Track inode associations for conflict detection. */
> +	int progress;
> +	unsigned long long count;
> +	int debug;
> +	int change;
> +	int hard_links;
> +	int verbose;
> +	int logging;
> +	char *rootpath;
> +	int rootpathlen;
> +	char *progname;
> +	FILE *outfile;
> +	int force;
> +	struct selabel_handle *hnd;
> +	int expand_realpath;  /* Expand paths via realpath. */
> +	int abort_on_error; /* Abort the file tree walk upon an error. */
> +	int quiet;
> +	int fts_flags; /* Flags to fts, e.g. follow links, follow mounts */
> +	const char *selabel_opt_validate;
> +	const char *selabel_opt_path;
> +};
> +
> +void restore_init(struct restore_opts *opts);
> +void restore_finish();
> +int add_exclude(const char *directory);
> +void remove_exclude(const char *directory);
> +int process_one_realpath(char *name, int recurse);
> +
> +#endif
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
> index db2857f..8f4f663 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -1,26 +1,12 @@
> -#ifndef _GNU_SOURCE
> -#define _GNU_SOURCE
> -#endif
> +#include "restore.h"
>  #include <unistd.h>
> -#include <stdlib.h>
>  #include <fcntl.h>
> -#include <stdio.h>
>  #include <stdio_ext.h>
> -#include <string.h>
> -#include <errno.h>
>  #include <ctype.h>
>  #include <regex.h>
>  #include <sys/vfs.h>
>  #include <sys/utsname.h>
>  #define __USE_XOPEN_EXTENDED 1	/* nftw */
> -#define SKIP -2
> -#define ERR -1
> -#include <fts.h>
> -#include <limits.h>
> -#include <sepol/sepol.h>
> -#include <selinux/selinux.h>
> -#include <selinux/label.h>
> -#include <syslog.h>
>  #include <libgen.h>
>  #ifdef USE_AUDIT
>  #include <libaudit.h>
> @@ -32,287 +18,28 @@
>  static int mass_relabel;
>  static int mass_relabel_errs;
>  
> -#define STAR_COUNT 1000
> -
> -static FILE *outfile = NULL;
> -static int force = 0;
> -#define STAT_BLOCK_SIZE 1
> -static int progress = 0;
> -static unsigned long long count = 0;
>  
> -#define MAX_EXCLUDES 1000
> -static int excludeCtr = 0;
> -struct edir {
> -	char *directory;
> -	size_t size;
> -};
> -static struct edir excludeArray[MAX_EXCLUDES];
> +/* cmdline opts*/
>  
> -/*
> - * Command-line options.
> - */
>  static char *policyfile = NULL;
> -static int debug = 0;
> -static int change = 1;
> -static int quiet = 0;
> -static int ignore_enoent;
> -static int verbose = 0;
> -static int logging = 0;
>  static int warn_no_match = 0;
>  static int null_terminated = 0;
> -static char *rootpath = NULL;
> -static int rootpathlen = 0;
> -static int recurse; /* Recursive descent. */
>  static int errors;
> +static int ignore_enoent;
> +static struct restore_opts r_opts;
> +
> +#define STAT_BLOCK_SIZE 1
> +
>  
> -static char *progname;
>  
>  #define SETFILES "setfiles"
>  #define RESTORECON "restorecon"
>  static int iamrestorecon;
>  
>  /* Behavior flags determined based on setfiles vs. restorecon */
> -static int expand_realpath;  /* Expand paths via realpath. */
> -static int abort_on_error; /* Abort the file tree walk upon an error. */
> -static int add_assoc; /* Track inode associations for conflict detection. */
> -static int fts_flags; /* Flags to fts, e.g. follow links, follow mounts */
>  static int ctx_validate; /* Validate contexts */
>  static const char *altpath; /* Alternate path to file_contexts */
>  
> -/* Label interface handle */
> -static struct selabel_handle *hnd;
> -
> -/*
> - * An association between an inode and a context.
> - */
> -typedef struct file_spec {
> -	ino_t ino;		/* inode number */
> -	char *con;		/* matched context */
> -	char *file;		/* full pathname */
> -	struct file_spec *next;	/* next association in hash bucket chain */
> -} file_spec_t;
> -
> -/*
> - * The hash table of associations, hashed by inode number.
> - * Chaining is used for collisions, with elements ordered
> - * by inode number in each bucket.  Each hash bucket has a dummy 
> - * header.
> - */
> -#define HASH_BITS 16
> -#define HASH_BUCKETS (1 << HASH_BITS)
> -#define HASH_MASK (HASH_BUCKETS-1)
> -static file_spec_t *fl_head;
> -
> -/*
> - * Try to add an association between an inode and a context.
> - * If there is a different context that matched the inode,
> - * then use the first context that matched.
> - */
> -int filespec_add(ino_t ino, const security_context_t con, const char *file)
> -{
> -	file_spec_t *prevfl, *fl;
> -	int h, ret;
> -	struct stat sb;
> -
> -	if (!fl_head) {
> -		fl_head = malloc(sizeof(file_spec_t) * HASH_BUCKETS);
> -		if (!fl_head)
> -			goto oom;
> -		memset(fl_head, 0, sizeof(file_spec_t) * HASH_BUCKETS);
> -	}
> -
> -	h = (ino + (ino >> HASH_BITS)) & HASH_MASK;
> -	for (prevfl = &fl_head[h], fl = fl_head[h].next; fl;
> -	     prevfl = fl, fl = fl->next) {
> -		if (ino == fl->ino) {
> -			ret = lstat(fl->file, &sb);
> -			if (ret < 0 || sb.st_ino != ino) {
> -				freecon(fl->con);
> -				free(fl->file);
> -				fl->file = strdup(file);
> -				if (!fl->file)
> -					goto oom;
> -				fl->con = strdup(con);
> -				if (!fl->con)
> -					goto oom;
> -				return 1;
> -			}
> -
> -			if (strcmp(fl->con, con) == 0)
> -				return 1;
> -
> -			fprintf(stderr,
> -				"%s:  conflicting specifications for %s and %s, using %s.\n",
> -				__FUNCTION__, file, fl->file, fl->con);
> -			free(fl->file);
> -			fl->file = strdup(file);
> -			if (!fl->file)
> -				goto oom;
> -			return 1;
> -		}
> -
> -		if (ino > fl->ino)
> -			break;
> -	}
> -
> -	fl = malloc(sizeof(file_spec_t));
> -	if (!fl)
> -		goto oom;
> -	fl->ino = ino;
> -	fl->con = strdup(con);
> -	if (!fl->con)
> -		goto oom_freefl;
> -	fl->file = strdup(file);
> -	if (!fl->file)
> -		goto oom_freefl;
> -	fl->next = prevfl->next;
> -	prevfl->next = fl;
> -	return 0;
> -      oom_freefl:
> -	free(fl);
> -      oom:
> -	fprintf(stderr,
> -		"%s:  insufficient memory for file label entry for %s\n",
> -		__FUNCTION__, file);
> -	return -1;
> -}
> -
> -/*
> - * Evaluate the association hash table distribution.
> - */
> -void filespec_eval(void)
> -{
> -	file_spec_t *fl;
> -	int h, used, nel, len, longest;
> -
> -	if (!fl_head)
> -		return;
> -
> -	used = 0;
> -	longest = 0;
> -	nel = 0;
> -	for (h = 0; h < HASH_BUCKETS; h++) {
> -		len = 0;
> -		for (fl = fl_head[h].next; fl; fl = fl->next) {
> -			len++;
> -		}
> -		if (len)
> -			used++;
> -		if (len > longest)
> -			longest = len;
> -		nel += len;
> -	}
> -
> -	printf
> -	    ("%s:  hash table stats: %d elements, %d/%d buckets used, longest chain length %d\n",
> -	     __FUNCTION__, nel, used, HASH_BUCKETS, longest);
> -}
> -
> -/*
> - * Destroy the association hash table.
> - */
> -void filespec_destroy(void)
> -{
> -	file_spec_t *fl, *tmp;
> -	int h;
> -
> -	if (!fl_head)
> -		return;
> -
> -	for (h = 0; h < HASH_BUCKETS; h++) {
> -		fl = fl_head[h].next;
> -		while (fl) {
> -			tmp = fl;
> -			fl = fl->next;
> -			freecon(tmp->con);
> -			free(tmp->file);
> -			free(tmp);
> -		}
> -		fl_head[h].next = NULL;
> -	}
> -	free(fl_head);
> -	fl_head = NULL;
> -}
> -
> -static int add_exclude(const char *directory)
> -{
> -	size_t len = 0;
> -
> -	if (directory == NULL || directory[0] != '/') {
> -		fprintf(stderr, "Full path required for exclude: %s.\n",
> -			directory);
> -		return 1;
> -	}
> -	if (excludeCtr == MAX_EXCLUDES) {
> -		fprintf(stderr, "Maximum excludes %d exceeded.\n",
> -			MAX_EXCLUDES);
> -		return 1;
> -	}
> -
> -	len = strlen(directory);
> -	while (len > 1 && directory[len - 1] == '/') {
> -		len--;
> -	}
> -	excludeArray[excludeCtr].directory = strndup(directory, len);
> -
> -	if (excludeArray[excludeCtr].directory == NULL) {
> -		fprintf(stderr, "Out of memory.\n");
> -		return 1;
> -	}
> -	excludeArray[excludeCtr++].size = len;
> -
> -	return 0;
> -}
> -
> -static void remove_exclude(const char *directory)
> -{
> -	int i = 0;
> -	for (i = 0; i < excludeCtr; i++) {
> -		if (strcmp(directory, excludeArray[i].directory) == 0) {
> -			free(excludeArray[i].directory);
> -			if (i != excludeCtr-1)
> -				excludeArray[i] = excludeArray[excludeCtr-1];
> -			excludeCtr--;
> -			return;
> -		}
> -	}
> -	return;
> -}
> -
> -static int exclude(const char *file)
> -{
> -	int i = 0;
> -	for (i = 0; i < excludeCtr; i++) {
> -		if (strncmp
> -		    (file, excludeArray[i].directory,
> -		     excludeArray[i].size) == 0) {
> -			if (file[excludeArray[i].size] == 0
> -			    || file[excludeArray[i].size] == '/') {
> -				return 1;
> -			}
> -		}
> -	}
> -	return 0;
> -}
> -
> -int match(const char *name, struct stat *sb, char **con)
> -{
> -	if (NULL != rootpath) {
> -		if (0 != strncmp(rootpath, name, rootpathlen)) {
> -			fprintf(stderr, "%s:  %s is not located in %s\n",
> -				progname, name, rootpath);
> -			return -1;
> -		}
> -		name += rootpathlen;
> -	}
> -
> -	if (rootpath != NULL && name[0] == '\0')
> -		/* this is actually the root dir of the alt root */
> -		return selabel_lookup_raw(hnd, con, "/", sb->st_mode);
> -	else
> -		return selabel_lookup_raw(hnd, con, name, sb->st_mode);
> -}
> -
>  void usage(const char *const name)
>  {
>  	if (iamrestorecon) {
> @@ -334,194 +61,30 @@ static int nerr = 0;
>  void inc_err()
>  {
>  	nerr++;
> -	if (nerr > 9 && !debug) {
> +	if (nerr > 9 && !r_opts.debug) {
>  		fprintf(stderr, "Exiting after 10 errors.\n");
>  		exit(1);
>  	}
>  }
>  
> -/* Compare two contexts to see if their differences are "significant",
> - * or whether the only difference is in the user. */
> -static int only_changed_user(const char *a, const char *b)
> -{
> -	char *rest_a, *rest_b;	/* Rest of the context after the user */
> -	if (force)
> -		return 0;
> -	if (!a || !b)
> -		return 0;
> -	rest_a = strchr(a, ':');
> -	rest_b = strchr(b, ':');
> -	if (!rest_a || !rest_b)
> -		return 0;
> -	return (strcmp(rest_a, rest_b) == 0);
> -}
> -
> -static int restore(FTSENT *ftsent)
> -{
> -	char *my_file = strdupa(ftsent->fts_path);
> -	int ret;
> -	char *context, *newcon;
> -	int user_only_changed = 0;
> -
> -	if (match(my_file, ftsent->fts_statp, &newcon) < 0)
> -		/* Check for no matching specification. */
> -		return (errno == ENOENT) ? 0 : -1;
> -
> -	if (progress) {
> -		count++;
> -		if (count % (80 * STAR_COUNT) == 0) {
> -			fprintf(stdout, "\n");
> -			fflush(stdout);
> -		}
> -		if (count % STAR_COUNT == 0) {
> -			fprintf(stdout, "*");
> -			fflush(stdout);
> -		}
> -	}
> -
> -	/*
> -	 * Try to add an association between this inode and
> -	 * this specification.  If there is already an association
> -	 * for this inode and it conflicts with this specification,
> -	 * then use the last matching specification.
> -	 */
> -	if (add_assoc) {
> -		ret = filespec_add(ftsent->fts_statp->st_ino, newcon, my_file);
> -		if (ret < 0)
> -			goto err;
> -
> -		if (ret > 0)
> -			/* There was already an association and it took precedence. */
> -			goto out;
> -	}
> -
> -	if (debug) {
> -		printf("%s:  %s matched by %s\n", progname, my_file, newcon);
> -	}
> -
> -	/* Get the current context of the file. */
> -	ret = lgetfilecon_raw(ftsent->fts_accpath, &context);
> -	if (ret < 0) {
> -		if (errno == ENODATA) {
> -			context = NULL;
> -		} else {
> -			fprintf(stderr, "%s get context on %s failed: '%s'\n",
> -				progname, my_file, strerror(errno));
> -			goto err;
> -		}
> -		user_only_changed = 0;
> -	} else
> -		user_only_changed = only_changed_user(context, newcon);
> -
> -	/*
> -	 * Do not relabel the file if the matching specification is 
> -	 * <<none>> or the file is already labeled according to the 
> -	 * specification.
> -	 */
> -	if ((strcmp(newcon, "<<none>>") == 0) ||
> -	    (context && (strcmp(context, newcon) == 0))) {
> -		freecon(context);
> -		goto out;
> -	}
> -
> -	if (!force && context && (is_context_customizable(context) > 0)) {
> -		if (verbose > 1) {
> -			fprintf(stderr,
> -				"%s: %s not reset customized by admin to %s\n",
> -				progname, my_file, context);
> -		}
> -		freecon(context);
> -		goto out;
> -	}
> -
> -	if (verbose) {
> -		/* If we're just doing "-v", trim out any relabels where
> -		 * the user has changed but the role and type are the
> -		 * same.  For "-vv", emit everything. */
> -		if (verbose > 1 || !user_only_changed) {
> -			printf("%s reset %s context %s->%s\n",
> -			       progname, my_file, context ?: "", newcon);
> -		}
> -	}
> -
> -	if (logging && !user_only_changed) {
> -		if (context)
> -			syslog(LOG_INFO, "relabeling %s from %s to %s\n",
> -			       my_file, context, newcon);
> -		else
> -			syslog(LOG_INFO, "labeling %s to %s\n",
> -			       my_file, newcon);
> -	}
> -
> -	if (outfile && !user_only_changed)
> -		fprintf(outfile, "%s\n", my_file);
> -
> -	if (context)
> -		freecon(context);
> -
> -	/*
> -	 * Do not relabel the file if -n was used.
> -	 */
> -	if (!change || user_only_changed)
> -		goto out;
> -
> -	/*
> -	 * Relabel the file to the specified context.
> -	 */
> -	ret = lsetfilecon(ftsent->fts_accpath, newcon);
> -	if (ret) {
> -		fprintf(stderr, "%s set context %s->%s failed:'%s'\n",
> -			progname, my_file, newcon, strerror(errno));
> -		goto skip;
> -	}
> -out:
> -	freecon(newcon);
> -	return 0;
> -skip:
> -	freecon(newcon);
> -	return SKIP;
> -err:
> -	freecon(newcon);
> -	return ERR;
> -}
> -
> -/*
> - * Apply the last matching specification to a file.
> - * This function is called by fts on each file during
> - * the directory traversal.
> - */
> -static int apply_spec(FTSENT *ftsent)
> -{
> -	if (ftsent->fts_info == FTS_DNR) {
> -		fprintf(stderr, "%s:  unable to read directory %s\n",
> -			progname, ftsent->fts_path);
> -		return SKIP;
> -	}
>  
> -	int rc = restore(ftsent);
> -	if (rc == ERR) {
> -		if (!abort_on_error)
> -			return SKIP;
> -	}
> -	return rc;
> -}
>  
>  void set_rootpath(const char *arg)
>  {
>  	int len;
>  
> -	rootpath = strdup(arg);
> -	if (NULL == rootpath) {
> -		fprintf(stderr, "%s:  insufficient memory for rootpath\n",
> -			progname);
> +	r_opts.rootpath = strdup(arg);
> +	if (NULL == r_opts.rootpath) {
> +		fprintf(stderr, "%s:  insufficient memory for r_opts.rootpath\n",
> +			r_opts.progname);
>  		exit(1);
>  	}
>  
>  	/* trim trailing /, if present */
> -	len = strlen(rootpath);
> -	while (len && ('/' == rootpath[len - 1]))
> -		rootpath[--len] = 0;
> -	rootpathlen = len;
> +	len = strlen(r_opts.rootpath);
> +	while (len && ('/' == r_opts.rootpath[len - 1]))
> +		r_opts.rootpath[--len] = 0;
> +	r_opts.rootpathlen = len;
>  }
>  
>  int canoncon(char **contextp)
> @@ -545,163 +108,6 @@ int canoncon(char **contextp)
>  	return rc;
>  }
>  
> -static int symlink_realpath(char *name, char *path)
> -{
> -	char *p = NULL, *file_sep;
> -	char *tmp_path = strdupa(name);
> -	size_t len = 0;
> -
> -	if (!tmp_path) {
> -		fprintf(stderr, "strdupa on %s failed:  %s\n", name,
> -			strerror(errno));
> -		return -1;
> -	}
> -	file_sep = strrchr(tmp_path, '/');
> -	if (file_sep == tmp_path) {
> -		file_sep++;
> -		p = strcpy(path, "");
> -	} else if (file_sep) {
> -		*file_sep = 0;
> -		file_sep++;
> -		p = realpath(tmp_path, path);
> -	} else {
> -		file_sep = tmp_path;
> -		p = realpath("./", path);
> -	}
> -	if (p)
> -		len = strlen(p);
> -	if (!p || len + strlen(file_sep) + 2 > PATH_MAX) {
> -		fprintf(stderr, "symlink_realpath(%s) failed %s\n", name,
> -			strerror(errno));
> -		return -1;
> -	}
> -	p += len;
> -	/* ensure trailing slash of directory name */
> -	if (len == 0 || *(p - 1) != '/') {
> -		*p = '/';
> -		p++;
> -	}
> -	strcpy(p, file_sep);
> -	return 0;
> -}
> -
> -static int process_one(char *name, int recurse_this_path)
> -{
> -	int rc = 0;
> -	const char *namelist[2];
> -	dev_t dev_num = 0;
> -	FTS *fts_handle;
> -	FTSENT *ftsent;
> -
> -	if (!strcmp(name, "/"))
> -		mass_relabel = 1;
> -
> -	namelist[0] = name;
> -	namelist[1] = NULL;
> -	fts_handle = fts_open((char **)namelist, fts_flags, NULL);
> -	if (fts_handle  == NULL) {
> -		fprintf(stderr,
> -			"%s: error while labeling %s:  %s\n",
> -			progname, namelist[0], strerror(errno));
> -		goto err;
> -	}
> -
> -
> -	ftsent = fts_read(fts_handle);
> -	if (ftsent != NULL) {
> -		/* Keep the inode of the first one. */
> -		dev_num = ftsent->fts_statp->st_dev;
> -	}
> -
> -	do {
> -		/* Skip the post order nodes. */
> -		if (ftsent->fts_info == FTS_DP)
> -			continue;
> -		/* If the XDEV flag is set and the device is different */
> -		if (ftsent->fts_statp->st_dev != dev_num &&
> -		    FTS_XDEV == (fts_flags & FTS_XDEV))
> -			continue;
> -		if (excludeCtr > 0) {
> -			if (exclude(ftsent->fts_path)) {
> -				fts_set(fts_handle, ftsent, FTS_SKIP);
> -				continue;
> -			}
> -		}
> -		int rc = apply_spec(ftsent);
> -		if (rc == SKIP)
> -			fts_set(fts_handle, ftsent, FTS_SKIP);
> -		if (rc == ERR)
> -			goto err;
> -		if (!recurse_this_path)
> -			break;
> -	} while ((ftsent = fts_read(fts_handle)) != NULL);
> -
> -	if (!strcmp(name, "/"))
> -		mass_relabel_errs = 0;
> -
> -out:
> -	if (add_assoc) {
> -		if (!quiet)
> -			filespec_eval();
> -		filespec_destroy();
> -	}
> -	if (fts_handle)
> -		fts_close(fts_handle);
> -	return rc;
> -
> -err:
> -	if (!strcmp(name, "/"))
> -		mass_relabel_errs = 1;
> -	rc = -1;
> -	goto out;
> -}
> -
> -static int process_one_realpath(char *name)
> -{
> -	int rc = 0;
> -	char *p;
> -	struct stat sb;
> -
> -	if (!expand_realpath) {
> -		return process_one(name, recurse);
> -	} else {
> -		rc = lstat(name, &sb);
> -		if (rc < 0) {
> -			fprintf(stderr, "%s:  lstat(%s) failed:  %s\n",
> -				progname, name,	strerror(errno));
> -			return -1;
> -		}
> -
> -		if (S_ISLNK(sb.st_mode)) {
> -			char path[PATH_MAX + 1];
> -
> -			rc = symlink_realpath(name, path);
> -			if (rc < 0)
> -				return rc;
> -			rc = process_one(path, 0);
> -			if (rc < 0)
> -				return rc;
> -
> -			p = realpath(name, NULL);
> -			if (p) {
> -				rc = process_one(p, recurse);
> -				free(p);
> -			}
> -			return rc;
> -		} else {
> -			p = realpath(name, NULL);
> -			if (!p) {
> -				fprintf(stderr, "realpath(%s) failed %s\n", name,
> -					strerror(errno));
> -				return -1;
> -			}
> -			rc = process_one(p, recurse);
> -			free(p);
> -			return rc;
> -		}
> -	}
> -}
> -
>  #ifndef USE_AUDIT
>  static void maybe_audit_mass_relabel(void)
>  {
> @@ -803,21 +209,32 @@ int main(int argc, char **argv)
>  	int use_input_file = 0;
>  	char *buf = NULL;
>  	size_t buf_len;
> +	int recurse; /* Recursive descent. */
>  	char *base;
> -	struct selinux_opt opts[] = {
> -		{ SELABEL_OPT_VALIDATE, NULL },
> -		{ SELABEL_OPT_PATH, NULL }
> -	};
> +	
> +	memset(&r_opts, 0, sizeof(r_opts));
> +
> +	/* Initialize variables */
> +	r_opts.progress = 0;
> +	r_opts.count = 0;
> +	r_opts.debug = 0;
> +	r_opts.change = 1;
> +	r_opts.verbose = 0;
> +	r_opts.logging = 0;
> +	r_opts.rootpath = NULL;
> +	r_opts.rootpathlen = 0;
> +	r_opts.outfile = NULL;
> +	r_opts.force = 0;
> +	r_opts.hard_links = 1;
>  
> -	memset(excludeArray, 0, sizeof(excludeArray));
>  	altpath = NULL;
>  
> -	progname = strdup(argv[0]);
> -	if (!progname) {
> +	r_opts.progname = strdup(argv[0]);
> +	if (!r_opts.progname) {
>  		fprintf(stderr, "%s:  Out of memory!\n", argv[0]);
>  		exit(1);
>  	}
> -	base = basename(progname);
> +	base = basename(r_opts.progname);
>  	
>  	if (!strcmp(base, SETFILES)) {
>  		/* 
> @@ -831,10 +248,10 @@ int main(int argc, char **argv)
>  		 */
>  		iamrestorecon = 0;
>  		recurse = 1;
> -		expand_realpath = 0;
> -		abort_on_error = 1;
> -		add_assoc = 1;
> -		fts_flags = FTS_PHYSICAL | FTS_XDEV;
> +		r_opts.expand_realpath = 0;
> +		r_opts.abort_on_error = 1;
> +		r_opts.add_assoc = 1;
> +		r_opts.fts_flags = FTS_PHYSICAL | FTS_XDEV;
>  		ctx_validate = 1;
>  	} else {
>  		/*
> @@ -846,14 +263,14 @@ int main(int argc, char **argv)
>  		 * Follows mounts,
>  		 * Does lazy validation of contexts upon use. 
>  		 */
> -		if (strcmp(base, RESTORECON) && !quiet) 
> +		if (strcmp(base, RESTORECON) && !r_opts.quiet) 
>  			printf("Executed with an unrecognized name (%s), defaulting to %s behavior.\n", base, RESTORECON);
>  		iamrestorecon = 1;
>  		recurse = 0;
> -		expand_realpath = 1;
> -		abort_on_error = 0;
> -		add_assoc = 0;
> -		fts_flags = FTS_PHYSICAL;
> +		r_opts.expand_realpath = 1;
> +		r_opts.abort_on_error = 0;
> +		r_opts.add_assoc = 0;
> +		r_opts.fts_flags = FTS_PHYSICAL;
>  		ctx_validate = 0;
>  
>  		/* restorecon only:  silent exit if no SELinux.
> @@ -915,37 +332,37 @@ int main(int argc, char **argv)
>  			input_filename = optarg;
>  			break;			
>  		case 'd':
> -			debug = 1;
> +			r_opts.debug = 1;
>  			break;
>  		case 'i':
>  			ignore_enoent = 1;
>  			break;
>  		case 'l':
> -			logging = 1;
> +			r_opts.logging = 1;
>  			break;
>  		case 'F':
> -			force = 1;
> +			r_opts.force = 1;
>  			break;
>  		case 'n':
> -			change = 0;
> +			r_opts.change = 0;
>  			break;
>  		case 'o':
>  			if (strcmp(optarg, "-") == 0) {
> -				outfile = stdout;
> +				r_opts.outfile = stdout;
>  				break;
>  			}
>  
> -			outfile = fopen(optarg, "w");
> -			if (!outfile) {
> +			r_opts.outfile = fopen(optarg, "w");
> +			if (!r_opts.outfile) {
>  				fprintf(stderr, "Error opening %s: %s\n",
>  					optarg, strerror(errno));
>  
>  				usage(argv[0]);
>  			}
> -			__fsetlocking(outfile, FSETLOCKING_BYCALLER);
> +			__fsetlocking(r_opts.outfile, FSETLOCKING_BYCALLER);
>  			break;
>  		case 'q':
> -			quiet = 1;
> +			r_opts.quiet = 1;
>  			break;
>  		case 'R':
>  		case 'r':
> @@ -954,11 +371,11 @@ int main(int argc, char **argv)
>  				break;
>  			}
>  			if (optind + 1 >= argc) {
> -				fprintf(stderr, "usage:  %s -r rootpath\n",
> +				fprintf(stderr, "usage:  %s -r r_opts.rootpath\n",
>  					argv[0]);
>  				exit(1);
>  			}
> -			if (NULL != rootpath) {
> +			if (NULL != r_opts.rootpath) {
>  				fprintf(stderr,
>  					"%s: only one -r can be specified\n",
>  					argv[0]);
> @@ -969,23 +386,23 @@ int main(int argc, char **argv)
>  		case 's':
>  			use_input_file = 1;
>  			input_filename = "-";
> -			add_assoc = 0;
> +			r_opts.add_assoc = 0;
>  			break;
>  		case 'v':
> -			if (progress) {
> +			if (r_opts.progress) {
>  				fprintf(stderr,
>  					"Progress and Verbose mutually exclusive\n");
>  				exit(1);
>  			}
> -			verbose++;
> +			r_opts.verbose++;
>  			break;
>  		case 'p':
> -			if (verbose) {
> +			if (r_opts.verbose) {
>  				fprintf(stderr,
>  					"Progress and Verbose mutually exclusive\n");
>  				usage(argv[0]);
>  			}
> -			progress = 1;
> +			r_opts.progress = 1;
>  			break;
>  		case 'W':
>  			warn_no_match = 1;
> @@ -1033,18 +450,13 @@ int main(int argc, char **argv)
>  	}
>  
>  	/* Load the file contexts configuration and check it. */
> -	opts[0].value = (ctx_validate ? (char*)1 : NULL);
> -	opts[1].value = altpath;
> -
> -	hnd = selabel_open(SELABEL_CTX_FILE, opts, 2);
> -	if (!hnd) {
> -		perror(altpath);
> -		exit(1);
> -	}
> +	r_opts.selabel_opt_validate = (ctx_validate ? (char *)1 : NULL);
> +	r_opts.selabel_opt_path = altpath;
>  
>  	if (nerr)
>  		exit(1);
>  
> +	restore_init(&r_opts);
>  	if (use_input_file) {
>  		FILE *f = stdin;
>  		ssize_t len;
> @@ -1061,31 +473,34 @@ int main(int argc, char **argv)
>  		delim = (null_terminated != 0) ? '\0' : '\n';
>  		while ((len = getdelim(&buf, &buf_len, delim, f)) > 0) {
>  			buf[len - 1] = 0;
> -			errors |= process_one_realpath(buf);
> +			if (!strcmp(buf, "/"))
> +				mass_relabel = 1;
> +			errors |= process_one_realpath(buf, recurse) < 0;
>  		}
>  		if (strcmp(input_filename, "-") != 0)
>  			fclose(f);
>  	} else {
>  		for (i = optind; i < argc; i++) {
> -			errors |= process_one_realpath(argv[i]);
> +			if (!strcmp(argv[i], "/"))
> +				mass_relabel = 1;
> +			errors |= process_one_realpath(argv[i], recurse) < 0;
>  		}
>  	}
> -
> +	
> +	if (mass_relabel)
> +		mass_relabel_errs = errors;
>  	maybe_audit_mass_relabel();
>  
>  	if (warn_no_match)
> -		selabel_stats(hnd);
> +		selabel_stats(r_opts.hnd);
>  
> -	selabel_close(hnd);
> +	selabel_close(r_opts.hnd);
> +	restore_finish();
>  
> -	if (outfile)
> -		fclose(outfile);
> -
> -	for (i = 0; i < excludeCtr; i++) {
> -		free(excludeArray[i].directory);
> -	}
> +	if (r_opts.outfile)
> +		fclose(r_opts.outfile);
>  
> -       if (progress && count >= STAR_COUNT)
> +       if (r_opts.progress && r_opts.count >= STAR_COUNT)
>                 printf("\n");
>  	exit(errors);
>  }
Chad, once you have patch 1 in I will send you the restorecond patch, with all the missing files.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
