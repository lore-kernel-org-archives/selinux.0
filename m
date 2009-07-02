Subject: Re: [PATCH v3] setfiles converted to fts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Liu <tliu@redhat.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1246548607.2480.3.camel@Ares>
References: <1246480778.2771.0.camel@Ares>
	 <1246536793.13464.251.camel@moss-pluto.epoch.ncsc.mil>
	 <1246548607.2480.3.camel@Ares>
Content-Type: text/plain
Date: Thu, 02 Jul 2009 13:00:22 -0400
Message-Id: <1246554022.13464.348.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-07-02 at 11:30 -0400, Thomas Liu wrote:
> First email didn't go out to the list, sorry.
> 
> Here is version 3 of the setfiles to fts patch.
> 
> It turns out setting the FTS_XDEV flag tells fts not to descend into 
> directories with different device numbers, but fts will still give back the
> actual directory.  I think nftw would completely avoid the directories as well
> as their contents.
> 
> This patch fixed this issue by saving the device number of the directory
> that was passed to setfiles and then skipping all action on any directories
> with a different device number when the FTS_XDEV flag is set.

Thanks.  For the patch description, we want the original text along with
change log for any changes (or changes folded into the original text
description as appropriate) so that it gets included in the commit.

Running setfiles -v worked correctly here, although I do note some
changes by both the unpatched and patched versions against a vanilla
F11, which suggests a policy problem (Dan's issue, not yours).

For the patch, note the following minor cleanups below, and also
have a look at the Linux kernel CodingStyle document and checkpatch.pl
script, which will warn you about style violations.

> Signed-off-by: Thomas Liu <tliu@redhat.com>
> ---

Add diffstat -p1 output here so that reviewers can quickly see what
files are changed and how large the changes are.

> diff -up setfiles/setfiles.c.old setfiles/setfiles.c
> --- setfiles/setfiles.c.old	2009-06-30 15:28:24.899436710 -0400
> +++ setfiles/setfiles.c	2009-07-02 11:23:19.805525618 -0400
> @@ -292,22 +293,10 @@ static int exclude(const char *file)
>  
>  int match(const char *name, struct stat *sb, char **con)
>  {
> -	int ret;
>  	char path[PATH_MAX + 1];
>  
> -	if (excludeCtr > 0) {
> -		if (exclude(name)) {
> -			return -1;
> -		}
> -	}
> -	ret = lstat(name, sb);
> -	if (ret) {
> -		if (ignore_enoent && errno == ENOENT)
> -			return 0;
> -		fprintf(stderr, "%s:  unable to stat file %s: %s\n", progname,
> -			name, strerror(errno));
> -		return -1;
> -	}
> +
> +	

Remove these additional empty lines, likely artifacts of earlier
versions of the patch.

> @@ -425,22 +414,14 @@ static int only_changed_user(const char 
>  	return (strcmp(rest_a, rest_b) == 0);
>  }
>  
> -static int restore(const char *file)
> +static int restore(FTSENT *ftsent)
>  {
> -	char *my_file = strdupa(file);
> -	struct stat my_sb;
> +	char *my_file = strdupa(ftsent->fts_path);
>  	int ret;
>  	char *context, *newcon;
>  	int user_only_changed = 0;
> -	size_t len = strlen(my_file);
> -
> -	/* Skip the extra slashes at the beginning and end, if present. */
> -	if (file[0] == '/' && file[1] == '/')
> -		my_file++;
> -	if (len > 1 && my_file[len - 1] == '/')
> -		my_file[len - 1] = 0;

Not sure why this was added originally, but are you sure it isn't still
needed by some callers to remove extraneous slashes?

> @@ -463,7 +444,9 @@ static int restore(const char *file)
>  	 * then use the last matching specification.
>  	 */
>  	if (add_assoc) {
> -		ret = filespec_add(my_sb.st_ino, newcon, my_file);
> +
> +//		printf("file: %s, ino: %d\n", my_file, (int)ftsent->fts_statp->st_ino);

Remove debugging printfs.

> +		ret = filespec_add(ftsent->fts_statp->st_ino, newcon, my_file);
>  		if (ret < 0)
>  			goto err;
>  

> @@ -626,68 +606,51 @@ int canoncon(char **contextp)
>  	return rc;
>  }
>  
> -static int pre_stat(const char *file_unused __attribute__ ((unused)),
> -		    const struct stat *sb_unused __attribute__ ((unused)),
> -		    int flag_unused __attribute__ ((unused)),
> -		    struct FTW *s_unused __attribute__ ((unused)))
> -{
> -	char buf[STAT_BLOCK_SIZE];
> -	if (write(pipe_fds[1], buf, STAT_BLOCK_SIZE) != STAT_BLOCK_SIZE) {
> -		fprintf(stderr, "Error writing to stat pipe, child exiting.\n");
> -		exit(1);
> -	}
> -	return 0;
> -}
> -
>  static int process_one(char *name)
>  {
> -	struct stat sb;
> -	int rc;
> -
> +	int rc = 0;	
> +	FTS *fts_handle = NULL;
> +	const char * namelist[2] = {NULL, NULL}; 
> +	namelist[0] = name;

You can directly handle the assignment in the declaration, right?
And put an empty line between local var decls and first statement.

>  	if (!strcmp(name, "/"))
>  		mass_relabel = 1;
>  
> -	rc = lstat(name, &sb);
> -	if (rc < 0) {
> -		if (ignore_enoent && errno == ENOENT)
> -			return 0;
> -		fprintf(stderr, "%s:  stat error on %s:  %s\n",
> -			progname, name, strerror(errno));
> +	if ((fts_handle = fts_open((char **)namelist, fts_flags, NULL)) == NULL) { 
> +		fprintf(stderr,
> +			"%s: error while labeling %s:  %s\n",
> +			progname, namelist[0], strerror(errno));
>  		goto err;
>  	}
> -
> -	if (S_ISDIR(sb.st_mode) && recurse) {
> -		if (pipe(pipe_fds) < 0) {
> -			fprintf(stderr, "%s:  pipe error on %s:  %s\n",
> -				progname, name, strerror(errno));
> -			goto err;
> -		}
> -		rc = fork();
> -		if (rc < 0) {
> -			fprintf(stderr, "%s:  fork error on %s:  %s\n",
> -				progname, name, strerror(errno));
> -			goto err;
> -		}
> -		if (rc == 0) {
> -			/* Child:  pre-stat the files. */
> -			close(pipe_fds[0]);
> -			nftw(name, pre_stat, 1024, nftw_flags);
> -			exit(0);
> -		}
> -		/* Parent:  Check and label the files. */
> -		rc = 0;
> -		close(pipe_fds[1]);
> -		if (nftw(name, apply_spec, 1024, nftw_flags)) {
> -			fprintf(stderr,
> -				"%s:  error while labeling %s:  %s\n",
> -				progname, name, strerror(errno));
> -			goto err;
> -		}
> -	} else {
> -		rc = restore(name);
> -		if (rc)
> +	
> +	dev_t dev_ino = 0;
> +	FTSENT *ftsent;
> +	// Read the first one

Use C-style comments /* */ rather than C++-style.

> +	if ((ftsent = fts_read(fts_handle)) != NULL){
> +		// Keep the inode of the first one.
> +		dev_ino = ftsent->fts_statp->st_dev;
> +	}
> +
> +	do {
> +		// Skip the post order nodes.
> +		if (ftsent->fts_info == FTS_DP)
> +			continue;
> +		// If the XDEV flag is set and the inode is different from the top directory
> +		if (ftsent->fts_statp->st_dev != dev_ino && FTS_XDEV == (fts_flags & FTS_XDEV))
> +			continue;
> +		if (excludeCtr > 0) {
> +			if (exclude(ftsent->fts_path)) {
> +				fts_set(fts_handle, ftsent, FTS_SKIP);
> +				continue;
> +			}
> +		}
> +		int rc = apply_spec(ftsent);
> +		if (rc == SKIP)
> +			fts_set(fts_handle, ftsent, FTS_SKIP);
> +		if (rc == ERR)
>  			goto err;
> -	}
> +		if (!recurse)
> +			break;
> +	} while ((ftsent = fts_read(fts_handle)) != NULL);
>  
>  	if (!strcmp(name, "/"))
>  		mass_relabel_errs = 0;
> @@ -698,8 +661,9 @@ out:
>  			filespec_eval();
>  		filespec_destroy();
>  	}
> -
> -	return rc;
> +	if (fts_handle)
> +		fts_close(fts_handle);
> +	return rc; 
>  
>  err:
>  	if (!strcmp(name, "/"))
> @@ -777,7 +741,7 @@ int main(int argc, char **argv)
>  		expand_realpath = 0;
>  		abort_on_error = 1;
>  		add_assoc = 1;
> -		nftw_flags = FTW_PHYS | FTW_MOUNT;
> +		fts_flags = FTS_PHYSICAL | FTS_XDEV;
>  		ctx_validate = 1;
>  	} else {
>  		/*
> @@ -796,7 +760,7 @@ int main(int argc, char **argv)
>  		expand_realpath = 1;
>  		abort_on_error = 0;
>  		add_assoc = 0;
> -		nftw_flags = FTW_PHYS;
> +		fts_flags = FTS_PHYSICAL;
>  		ctx_validate = 0;
>  
>  		/* restorecon only:  silent exit if no SELinux.
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
