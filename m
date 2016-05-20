Subject: Re: [PATCH 2/3] libselinux: Add setfiles support to
 selinux_restorecon(3)
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <1462893798-9559-1-git-send-email-richard_c_haines@btinternet.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <62da4e33-16dd-aa01-cf9c-792f74c804d0@tycho.nsa.gov>
Date: Fri, 20 May 2016 13:03:18 -0400
MIME-Version: 1.0
In-Reply-To: <1462893798-9559-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/10/2016 11:23 AM, Richard Haines wrote:
> Add additional error handling, flags, xdev and alt_rootpath
> support for setfiles(8) functionality.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  libselinux/include/selinux/restorecon.h            |  17 +++
>  libselinux/man/man3/selinux_restorecon.3           |  13 +++
>  .../man/man3/selinux_restorecon_set_alt_rootpath.3 |  34 ++++++
>  libselinux/src/selinux_restorecon.c                | 126 +++++++++++++++++----
>  libselinux/utils/selinux_restorecon.c              |  28 ++++-
>  5 files changed, 197 insertions(+), 21 deletions(-)
>  create mode 100644 libselinux/man/man3/selinux_restorecon_set_alt_rootpath.3
> 
> diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include/selinux/restorecon.h
> index 0b93b0c..6b3e0f1 100644
> --- a/libselinux/include/selinux/restorecon.h
> +++ b/libselinux/include/selinux/restorecon.h
> @@ -50,6 +50,14 @@ extern int selinux_restorecon(const char *pathname,
>   * If there is a different context that matched the inode,
>   * then use the first context that matched. */
>  #define SELINUX_RESTORECON_ADD_ASSOC			256
> +/* Abort on errors during the file tree walk. */
> +#define SELINUX_RESTORECON_ABORT_ON_ERROR		512
> +/* Log any label changes to syslog. */
> +#define SELINUX_RESTORECON_SYSLOG_CHANGES		1024
> +/* Log what spec matched each file. */
> +#define SELINUX_RESTORECON_LOG_MATCHES			2048
> +/* Ignore files that do not exist. */
> +#define SELINUX_RESTORECON_IGNORE_NOENTRY		4096

Maybe we should express these as hex values since they are flags.

> diff --git a/libselinux/man/man3/selinux_restorecon_set_alt_rootpath.3 b/libselinux/man/man3/selinux_restorecon_set_alt_rootpath.3
> new file mode 100644
> index 0000000..79223eb
> --- /dev/null
> +++ b/libselinux/man/man3/selinux_restorecon_set_alt_rootpath.3
> @@ -0,0 +1,34 @@
> +.TH "selinux_restorecon_set_alt_rootpath" "3" "28 April 2016" "Security Enhanced Linux" "SELinux API documentation"
> +
> +.SH "NAME"
> +selinux_restorecon_set_alt_rootpath \- set an alternate rootpath.
> +.
> +.SH "SYNOPSIS"
> +.B #include <selinux/restorecon.h>
> +.sp
> +.BI "void selinux_restorecon_set_alt_rootpath(const char *" alt_rootpath ");"
> +.in +\w'void selinux_restorecon_set_alt_rootpath('u
> +.
> +.SH "DESCRIPTION"
> +.BR selinux_restorecon_set_alt_rootpath ()
> +passes to
> +.BR selinux_restorecon (3)
> +a pointer containing an alternate rootpath
> +.IR alt_rootpath .
> +.br
> +The path MUST NOT be terminated with a trailing '/'.
> +.br
> +The path MUST NOT be '/' (i.e. the root path).

Any particular reason we can't just handle this in the implementation?

> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
> index 2794659..11ae8a0 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -22,6 +22,7 @@
>  #include <sys/vfs.h>
>  #include <linux/magic.h>
>  #include <libgen.h>
> +#include <syslog.h>
>  #include <selinux/selinux.h>
>  #include <selinux/context.h>
>  #include <selinux/label.h>
> @@ -39,6 +40,8 @@ static struct selabel_handle *fc_sehandle = NULL;
>  static unsigned char *fc_digest = NULL;
>  static size_t fc_digest_len = 0;
>  static const char **fc_exclude_list = NULL;
> +static const char *rootpath = NULL;
> +static int rootpathlen;
>  static size_t fc_count = 0;
>  #define STAR_COUNT 1000
>  
> @@ -47,12 +50,16 @@ struct rest_flags {
>  	bool nochange;
>  	bool verbose;
>  	bool progress;
> -	bool specctx;
> +	bool set_specctx;
>  	bool add_assoc;
> -	bool ignore;
> +	bool ignore_digest;
>  	bool recurse;
>  	bool userealpath;
>  	bool xdev;
> +	bool abort_on_error;
> +	bool syslog_changes;
> +	bool log_matches;
> +	bool ignore_enoent;
>  };
>  
>  static void restorecon_init(void)
> @@ -67,13 +74,15 @@ static void restorecon_init(void)
>  
>  static pthread_once_t fc_once = PTHREAD_ONCE_INIT;
>  
> -
>  static int check_excluded(const char *file)
>  {
>  	int i;
> +	size_t len;
>  
>  	for (i = 0; fc_exclude_list[i]; i++) {
> -		if (strcmp(file, fc_exclude_list[i]) == 0)
> +		len = strlen(fc_exclude_list[i]);
> +		/* Check if 'file' is in an excluded directory. */
> +		if (strncmp(file, fc_exclude_list[i], len) == 0)
>  				return 1;

Simple prefix match could give you a false positive, e.g. if /foo/bar is
on the exclude list and there is a file /foo/barfoo.
Any particular reason you aren't using setfiles restore.c exclude() logic?
However, is it even possible to reach /foo/bar/baz if we are checking
the exclude list on each component and pruning the tree walk on a match
of /foo/bar?


>  	}
>  	return 0;
> @@ -360,10 +369,29 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
>  	char *newcon = NULL;
>  	char *curcon = NULL;
>  	char *newtypecon = NULL;
> -	int rc = 0;
> +	int rc;
>  	bool updated = false;
> +	const char *tmp_pathname = pathname;

Maybe call it lookup_path or something more descriptive.

> +
> +	if (rootpath) {
> +		if (strncmp(rootpath, tmp_pathname, rootpathlen) != 0) {
> +			selinux_log(SELINUX_ERROR,
> +				    "%s is not located in alt_rootpath %s\n",
> +				    tmp_pathname, rootpath);
> +			return -1;
> +		}
> +		tmp_pathname += rootpathlen;
> +	}
>  
> -	if (selabel_lookup_raw(fc_sehandle, &newcon, pathname, sb->st_mode) < 0)
> +	if (rootpath != NULL && tmp_pathname[0] == '\0')
> +		/* this is actually the root dir of the alt root. */
> +		rc = selabel_lookup_raw(fc_sehandle, &newcon, "/",
> +						    sb->st_mode);
> +	else
> +		rc = selabel_lookup_raw(fc_sehandle, &newcon, tmp_pathname,
> +						    sb->st_mode);
> +
> +	if (rc < 0)
>  		return 0; /* no match, but not an error */
>  
>  	if (flags->add_assoc) {


> @@ -436,6 +468,16 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
>  				    "%s %s from %s to %s\n",
>  				    updated ? "Relabeled" : "Would relabel",
>  				    pathname, curcon, newcon);
> +
> +		if (flags->syslog_changes && !flags->nochange) {
> +			if (curcon)
> +				syslog(LOG_INFO,
> +					    "relabeling %s from %s to %s\n",
> +					    pathname, curcon, newcon);
> +			else
> +				syslog(LOG_INFO, "labeling %s to %s\n",
> +					    pathname, newcon);
> +		}

Wondering if this could be handled by the caller just specifying a log
callback that calls syslog rather than doing it here, but probably would
conflict with other logging.

> @@ -589,13 +649,22 @@ int selinux_restorecon(const char *pathname_orig,
>  		fts_flags = FTS_PHYSICAL | FTS_NOCHDIR;
>  
>  	fts = fts_open(paths, fts_flags, NULL);
> -	if (!fts) {
> -		error = -1;
> -		goto cleanup;
> -	}
> +	if (!fts)
> +		goto fts_err;
> +
> +	ftsent = fts_read(fts);
> +	if (!ftsent)
> +		goto fts_err;
> +
> +	/* Keep the inode of the first device. */
> +	dev_num = ftsent->fts_statp->st_dev;
>  
>  	error = 0;
> -	while ((ftsent = fts_read(fts)) != NULL) {
> +	do {
> +		/* If the XDEV flag is set and the device is different */
> +		if (flags.xdev && ftsent->fts_statp->st_dev != dev_num)
> +			continue;

Why is this necessary given that we already set FTS_XDEV above?

> +
>  		switch (ftsent->fts_info) {
>  		case FTS_DC:
>  			selinux_log(SELINUX_ERROR,
> @@ -644,9 +713,12 @@ int selinux_restorecon(const char *pathname_orig,
>  
>  			error |= restorecon_sb(ftsent->fts_path,
>  					       ftsent->fts_statp, &flags);
> +
> +			if (error && flags.abort_on_error)
> +				goto out;
>  			break;
>  		}
> -	}
> +	} while ((ftsent = fts_read(fts)) != NULL);
>  
>  	/* Labeling successful. Mark the top level directory as completed. */
>  	if (setrestoreconlast && !flags.nochange && !error) {
> @@ -672,12 +744,14 @@ cleanup:
>  	free(pathname);
>  	free(xattr_value);
>  	return error;
> +
>  oom:
>  	sverrno = errno;
>  	selinux_log(SELINUX_ERROR, "%s:  Out of memory\n", __func__);
>  	errno = sverrno;
>  	error = -1;
>  	goto cleanup;
> +
>  realpatherr:
>  	sverrno = errno;
>  	selinux_log(SELINUX_ERROR,
> @@ -686,6 +760,13 @@ realpatherr:
>  	errno = sverrno;
>  	error = -1;
>  	goto cleanup;
> +
> +fts_err:
> +	selinux_log(SELINUX_ERROR,
> +		    "fts error while labeling %s: %s\n",
> +		    paths[0], strerror(errno));
> +	error = -1;
> +	goto cleanup;
>  }
>  
>  /* selinux_restorecon_set_sehandle(3) is called to set the global fc handle */
> @@ -757,3 +838,10 @@ void selinux_restorecon_set_exclude_list(const char **exclude_list)
>  {
>  	fc_exclude_list = exclude_list;
>  }
> +
> +/* selinux_restorecon_set_alt_rootpath(3) sets an alternate rootpath. */
> +void selinux_restorecon_set_alt_rootpath(const char *alt_rootpath)
> +{
> +	rootpath = alt_rootpath;

Should we be strdup()'ing this in case the caller is passing a local
variable or other transient memory that won't stay around necessarily
for later restorecon() calls?

> +	rootpathlen = strlen(rootpath);
> +}
> diff --git a/libselinux/utils/selinux_restorecon.c b/libselinux/utils/selinux_restorecon.c
> index 2552d63..da59fcd 100644
> --- a/libselinux/utils/selinux_restorecon.c
> +++ b/libselinux/utils/selinux_restorecon.c
> @@ -37,7 +37,7 @@ static int validate_context(char **contextp)
>  static void usage(const char *progname)
>  {
>  	fprintf(stderr,
> -		"\nusage: %s [-FCnRrdeia] [-v|-P] [-p policy] [-f specfile] "
> +		"\nusage: %s [-FCnRrdeiIaAsl] [-v|-P] [-x alt_rootpath] [-p policy] [-f specfile] "
>  		"pathname ...\n"
>  		"Where:\n\t"
>  		"-F  Set the label to that in specfile.\n\t"
> @@ -57,9 +57,14 @@ static void usage(const char *progname)
>  		"-e  Exclude this file/directory (add multiple -e entries).\n\t"
>  		"-i  Do not set SELABEL_OPT_DIGEST option when calling "
>  		" selabel_open(3).\n\t"
> +		"-I  Ignore files that do not exist.\n\t"
>  		"-a  Add an association between an inode and a context.\n\t"
>  		"    If there is a different context that matched the inode,\n\t"
>  		"    then use the first context that matched.\n\t"
> +		"-A  Abort on errors during the file tree walk.\n\t"
> +		"-s  Log any label changes to syslog(3).\n\t"
> +		"-l  Log what specfile context matched each file.\n\t"
> +		"-x  Set alternate rootpath.\n\t"
>  		"-p  Optional binary policy file (also sets validate context "
>  		"option).\n\t"
>  		"-f  Optional file contexts file.\n\t"
> @@ -101,6 +106,7 @@ int main(int argc, char **argv)
>  	int opt, i;
>  	unsigned int restorecon_flags = 0;
>  	char *path = NULL, *digest = NULL, *validate = NULL;
> +	char *alt_rootpath = NULL;
>  	FILE *policystream;
>  	bool ignore_digest = false, require_selinux = true;
>  	bool verbose = false, progress = false;
> @@ -118,7 +124,7 @@ int main(int argc, char **argv)
>  	exclude_list = NULL;
>  	exclude_count = 0;
>  
> -	while ((opt = getopt(argc, argv, "iFCnRvPrdae:f:p:")) > 0) {
> +	while ((opt = getopt(argc, argv, "iIFCnRvPrdaAsle:f:p:x:")) > 0) {
>  		switch (opt) {
>  		case 'F':
>  			restorecon_flags |=
> @@ -190,9 +196,24 @@ int main(int argc, char **argv)
>  		case 'i':
>  			ignore_digest = true;
>  			break;
> +		case 'I':
> +			restorecon_flags |= SELINUX_RESTORECON_IGNORE_NOENTRY;
> +			break;
>  		case 'a':
>  			restorecon_flags |= SELINUX_RESTORECON_ADD_ASSOC;
>  			break;
> +		case 'A':
> +			restorecon_flags |= SELINUX_RESTORECON_ABORT_ON_ERROR;
> +			break;
> +		case 's':
> +			restorecon_flags |= SELINUX_RESTORECON_SYSLOG_CHANGES;
> +			break;
> +		case 'l':
> +			restorecon_flags |= SELINUX_RESTORECON_LOG_MATCHES;
> +			break;
> +		case 'x':
> +			alt_rootpath = optarg;
> +			break;
>  		default:
>  			usage(argv[0]);
>  		}
> @@ -247,6 +268,9 @@ int main(int argc, char **argv)
>  		selinux_restorecon_set_exclude_list
>  						 ((const char **)exclude_list);
>  
> +	if (alt_rootpath)
> +		selinux_restorecon_set_alt_rootpath(alt_rootpath);
> +
>  	/* Call restorecon for each path in list */
>  	for (i = optind; i < argc; i++) {
>  		if (selinux_restorecon(argv[i], restorecon_flags) < 0) {
> 
