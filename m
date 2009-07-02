Subject: Re: [PATCH v2] setfiles converted to fts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Liu <tliu@redhat.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1246480778.2771.0.camel@Ares>
References: <1246480778.2771.0.camel@Ares>
Content-Type: text/plain
Date: Thu, 02 Jul 2009 08:13:13 -0400
Message-Id: <1246536793.13464.251.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-07-01 at 16:39 -0400, Thomas Liu wrote:
> Here is an updated version of the fts setfiles patch.
> 
> I have confirmed that the stat struct that fts returns for a symlink when using
> the FTS_PHYSICAL flag is in fact the stat struct for the symlink, not the file
> it points to (st_size is 8 bytes).
> 
> Instead of using fts_path for getfilecon/setfilecon it now uses fts_accpath,
> which should be more efficient since fts walks the file hierarchy for us.
> 
> FreeBSD setfsmac uses fts in a similar way to how this patch does and one
> thing that I took from it was to pass the FTSENT pointer around instead of
> the names, because although fts_accpath is more efficient for get/setfilecon,
> it is less helpful in verbose output (fts_path will give the entire path).
> 
> Here is the output from running restorecon on /
> 
> (nftw version)
> restorecon -Rv / 2>/dev/null
> restorecon reset /dev/pts/ptmx context system_u:object_r:devpts_t:s0->system_u:object_r:ptmx_t:s0
> 
> (new version)
> ./restorecon -Rv / 2>/dev/null
> ./restorecon reset /dev/pts/ptmx context system_u:object_r:devpts_t:s0->system_u:object_r:ptmx_t:s0

I tried invoking it as setfiles, which also checks for multiple hard
links to the same file with conflicting context specifications.  And saw
this:
./setfiles -v /etc/selinux/targeted/contexts/files/file_contexts /
filespec_add:  conflicting specifications for /usr/share/m17n/pa-jhelum.mim and /dev, using system_u:object_r:device_t:s0.
./setfiles reset /nfshome context system_u:object_r:nfs_t:s0->system_u:object_r:default_t:s0
./setfiles set context /nfshome->system_u:object_r:default_t:s0 failed:'Operation not supported'
filespec_add:  conflicting specifications for /boot and /, using system_u:object_r:root_t:s0.
filespec_add:  conflicting specifications for /etc/grub.conf and /nfshome, using system_u:object_r:default_t:s0.
filespec_eval:  hash table stats: 339774 elements, 65536/65536 buckets used, longest chain length 6

So something has gone wrong there.

> Here are some benchmarks each was run twice from a fresh
> boot in single user mode (shown are the second runs).
> 
> (nftw version)
> restorecon -Rv /usr
> real	1m56.392s
> user	1m49.559s
> sys	0m6.012s
> 
> (new version)
> ./restorecon -Rv /usr
> real	1m55.102s
> user	1m50.427s
> sys	0m4.656s
> 
> So not much of a change, though some work has been pushed from kernel space
> to user space.
> 
> Finally the exclude functionality has been edited to work with fts so that
> fts will not go down paths that the user wanted to exclude.
> 
> We're looking into skipping folders that are mounted under file systems
> that do not have the seclabel flag for the next patch.
> 
> Signed-off-by: Thomas Liu <tliu@redhat.com>
> ---
> diff -up setfiles/Makefile.old setfiles/Makefile
> --- setfiles/Makefile.old	2009-06-30 15:28:17.031437301 -0400
> +++ setfiles/Makefile	2009-06-30 15:08:11.057436336 -0400
> @@ -3,11 +3,10 @@ PREFIX ?= ${DESTDIR}/usr
>  SBINDIR ?= $(DESTDIR)/sbin
>  MANDIR = $(PREFIX)/share/man
>  LIBDIR ?= $(PREFIX)/lib
> -
>  AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
>  
>  CFLAGS = -Werror -Wall -W
> -override CFLAGS += -D_FILE_OFFSET_BITS=64 -I$(PREFIX)/include
> +override CFLAGS += -I$(PREFIX)/include
>  LDLIBS = -lselinux -lsepol -L$(LIBDIR)
>  
>  ifeq (${AUDITH}, /usr/include/libaudit.h)
> diff -up setfiles/setfiles.c.old setfiles/setfiles.c
> --- setfiles/setfiles.c.old	2009-06-30 15:28:24.899436710 -0400
> +++ setfiles/setfiles.c	2009-07-01 16:35:17.851501571 -0400
> @@ -12,7 +12,9 @@
>  #include <regex.h>
>  #include <sys/vfs.h>
>  #define __USE_XOPEN_EXTENDED 1	/* nftw */
> -#include <ftw.h>
> +#define SKIP -2
> +#define ERR -1
> +#include <fts.h>
>  #include <limits.h>
>  #include <sepol/sepol.h>
>  #include <selinux/selinux.h>
> @@ -34,7 +36,6 @@ static int mass_relabel_errs;
>  static FILE *outfile = NULL;
>  static int force = 0;
>  #define STAT_BLOCK_SIZE 1
> -static int pipe_fds[2] = { -1, -1 };
>  static int progress = 0;
>  static unsigned long long count = 0;
>  
> @@ -73,7 +74,7 @@ static int iamrestorecon;
>  static int expand_realpath;  /* Expand paths via realpath. */
>  static int abort_on_error; /* Abort the file tree walk upon an error. */
>  static int add_assoc; /* Track inode associations for conflict detection. */
> -static int nftw_flags; /* Flags to nftw, e.g. follow links, follow mounts */
> +static int fts_flags; /* Flags to fts, e.g. follow links, follow mounts */
>  static int ctx_validate; /* Validate contexts */
>  static const char *altpath; /* Alternate path to file_contexts */
>  
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
>  
>  	if (expand_realpath) {
>  		if (S_ISLNK(sb->st_mode)) {
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
>  
> -	/* Skip the extra slashes at the beginning and end, if present. */
> -	if (file[0] == '/' && file[1] == '/')
> -		my_file++;
> -	if (len > 1 && my_file[len - 1] == '/')
> -		my_file[len - 1] = 0;
> -
> -	if (match(my_file, &my_sb, &newcon) < 0)
> +	if (match(my_file, ftsent->fts_statp, &newcon) < 0)
>  		/* Check for no matching specification. */
>  		return (errno == ENOENT) ? 0 : -1;
>  
> @@ -463,7 +444,7 @@ static int restore(const char *file)
>  	 * then use the last matching specification.
>  	 */
>  	if (add_assoc) {
> -		ret = filespec_add(my_sb.st_ino, newcon, my_file);
> +		ret = filespec_add(ftsent->fts_statp->st_ino, newcon, my_file);
>  		if (ret < 0)
>  			goto err;
>  
> @@ -477,7 +458,7 @@ static int restore(const char *file)
>  	}
>  
>  	/* Get the current context of the file. */
> -	ret = lgetfilecon_raw(my_file, &context);
> +	ret = lgetfilecon_raw(ftsent->fts_accpath, &context);
>  	if (ret < 0) {
>  		if (errno == ENODATA) {
>  			context = NULL;
> @@ -545,46 +526,43 @@ static int restore(const char *file)
>  	/*
>  	 * Relabel the file to the specified context.
>  	 */
> -	ret = lsetfilecon(my_file, newcon);
> +	ret = lsetfilecon(ftsent->fts_accpath, newcon);
>  	if (ret) {
>  		fprintf(stderr, "%s set context %s->%s failed:'%s'\n",
>  			progname, my_file, newcon, strerror(errno));
> -		goto out;
> +		goto skip;
>  	}
>        out:
>  	freecon(newcon);
>  	return 0;
> +      skip:
> +	freecon(newcon);
> +	return SKIP; 
> +
>        err:
>  	freecon(newcon);
> -	return -1;
> +	return ERR;
>  }
>  
>  /*
>   * Apply the last matching specification to a file.
> - * This function is called by nftw on each file during
> + * This function is called by fts on each file during
>   * the directory traversal.
>   */
> -static int apply_spec(const char *file,
> -		      const struct stat *sb_unused __attribute__ ((unused)),
> -		      int flag, struct FTW *s_unused __attribute__ ((unused)))
> -{
> -	char buf[STAT_BLOCK_SIZE];
> -	if (pipe_fds[0] != -1
> -	    && read(pipe_fds[0], buf, STAT_BLOCK_SIZE) != STAT_BLOCK_SIZE) {
> -		fprintf(stderr, "Read error on pipe.\n");
> -		pipe_fds[0] = -1;
> -	}
> -
> -	if (flag == FTW_DNR) {
> +static int apply_spec(FTSENT *ftsent)
> +{
> +	if (ftsent->fts_info == FTS_DNR) {
>  		fprintf(stderr, "%s:  unable to read directory %s\n",
> -			progname, file);
> -		return 0;
> +			progname, ftsent->fts_path);
> +		return SKIP;
>  	}
>  
> -	errors |= restore(file);
> -	if (abort_on_error && errors)
> -		return -1;
> -	return 0;
> +	int rc = restore(ftsent);
> +	if (rc == ERR) {
> +		if(!abort_on_error) 
> +			return SKIP;
> +	}		
> +	return rc;
>  }
>  
>  void set_rootpath(const char *arg)
> @@ -626,67 +604,40 @@ int canoncon(char **contextp)
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
>  
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
> +	FTSENT *ftsent;
> +	while ((ftsent = fts_read(fts_handle)) != NULL){
> +		// Skip the post order nodes.
> +		if (ftsent->fts_info == FTS_DP)
> +			continue;
> +		if (excludeCtr > 0) {
> +			if (exclude(ftsent->fts_path)) {
> +				fts_set(fts_handle, ftsent, FTS_SKIP);
> +				continue;
> +			}
>  		}
> -	} else {
> -		rc = restore(name);
> -		if (rc)
> +		int rc = apply_spec(ftsent);
> +		if (rc == SKIP)
> +			fts_set(fts_handle, ftsent, FTS_SKIP);
> +		if (rc == ERR)
>  			goto err;
> +		if (!recurse)
> +			break;
>  	}
>  
>  	if (!strcmp(name, "/"))
> @@ -698,8 +649,9 @@ out:
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
> @@ -777,7 +729,7 @@ int main(int argc, char **argv)
>  		expand_realpath = 0;
>  		abort_on_error = 1;
>  		add_assoc = 1;
> -		nftw_flags = FTW_PHYS | FTW_MOUNT;
> +		fts_flags = FTS_PHYSICAL | FTS_XDEV;
>  		ctx_validate = 1;
>  	} else {
>  		/*
> @@ -796,7 +748,7 @@ int main(int argc, char **argv)
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
