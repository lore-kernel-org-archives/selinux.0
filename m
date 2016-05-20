Subject: Re: [PATCH 1/3] libselinux: Evaluate inodes in selinux_restorecon(3)
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <1462893734-9509-1-git-send-email-richard_c_haines@btinternet.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <08abe881-e195-92d0-fa20-87eadaccf645@tycho.nsa.gov>
Date: Fri, 20 May 2016 12:26:25 -0400
MIME-Version: 1.0
In-Reply-To: <1462893734-9509-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/10/2016 11:22 AM, Richard Haines wrote:
> This patch transfers matchpathcon.c inode evaluation services to
> selinux_restorecon.c and modifies them to also support setfiles(8)
> inode services.
> 
> The overall objective is to modify restorecon(8) and setfiles(8)
> to use selinux_restorecon(3) services and then, when ready
> remove the deprecated matchpathcon services from libselinux.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  libselinux/include/selinux/restorecon.h  |   4 +
>  libselinux/man/man3/selinux_restorecon.3 |   5 +-
>  libselinux/src/matchpathcon.c            | 139 +------------
>  libselinux/src/selinux_restorecon.c      | 333 ++++++++++++++++++++++++++++---
>  libselinux/utils/selinux_restorecon.c    |  14 +-
>  5 files changed, 330 insertions(+), 165 deletions(-)
> 
> diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include/selinux/restorecon.h
> index ba1232e..0b93b0c 100644
> --- a/libselinux/include/selinux/restorecon.h
> +++ b/libselinux/include/selinux/restorecon.h
> @@ -46,6 +46,10 @@ extern int selinux_restorecon(const char *pathname,
>  /* Prevent descending into directories that have a different
>   * device number than the pathname from which the descent began */
>  #define SELINUX_RESTORECON_XDEV				128
> +/* Attempt to add an association between an inode and a context.
> + * If there is a different context that matched the inode,
> + * then use the first context that matched. */
> +#define SELINUX_RESTORECON_ADD_ASSOC			256

IIRC, the (original) behavior in setfiles was to use the higher priority
entry, i.e. the last matching specification in file_contexts, in the
case of a conflict.  Not sure if that is still the case.

>  
>  /**
>   * selinux_restorecon_set_sehandle - Set the global fc handle.
> diff --git a/libselinux/man/man3/selinux_restorecon.3 b/libselinux/man/man3/selinux_restorecon.3
> index 0293c4d..bbb6721 100644
> --- a/libselinux/man/man3/selinux_restorecon.3
> +++ b/libselinux/man/man3/selinux_restorecon.3
> @@ -68,7 +68,6 @@ If set, reset the files label to match the default specfile context.
>  If not set only reset the files "type" component of the context to match the
>  default specfile context.
>  .br
> -
>  .sp
>  .B SELINUX_RESTORECON_RECURSE
>  change file and directory labels recursively (descend directories)
> @@ -103,6 +102,10 @@ prevent descending into directories that have a different device number than
>  the
>  .I pathname
>  entry from which the descent began.
> +.sp
> +.B SELINUX_RESTORECON_ADD_ASSOC
> +attempt to add an association between an inode and a context. If there is a
> +different context that matched the inode, then use the first context that matched.

Ditto.

>  .RE
>  .sp
>  The behavior regarding the checking and updating of the SHA1 digest described
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
> index 5b495a0..6020737 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -12,7 +12,7 @@ static __thread struct selabel_handle *hnd;
>  /*
>   * An array for mapping integers to contexts
>   */
> -static __thread char **con_array;
> +__thread char **con_array;

We should keep it static and provide helpers to access it if necessary
from other files.  But see below.

>  static __thread int con_array_size;
>  static __thread int con_array_used;
>  
> @@ -131,27 +131,11 @@ void set_matchpathcon_flags(unsigned int flags)
>  	notrans = flags & MATCHPATHCON_NOTRANS;
>  }
>  
> -/*
> - * An association between an inode and a 
> - * specification.  
> - */
> -typedef struct file_spec {
> -	ino_t ino;		/* inode number */
> -	int specind;		/* index of specification in spec */
> -	char *file;		/* full pathname for diagnostic messages about conflicts */
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
> +/* Ensure add_assoc and verbose are false when calling from matchpathcon */
> +extern int restorecon_filespec_add1(ino_t ino, int specind, const char *con,
> +			    const char *file, bool add_assoc, bool verbose);
> +extern void restorecon_filespec_eval(bool add_assoc, bool verbose);
> +extern void restorecon_filespec_destroy(bool add_assoc);

These should go in a private header, e.g. restorecon_internal.h, that is
included by both restorecon.c and this file.  But see below.

>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
> index 17ed6fe..2794659 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -42,6 +42,19 @@ static const char **fc_exclude_list = NULL;
>  static size_t fc_count = 0;
>  #define STAR_COUNT 1000
>  
> +/* restorecon_flags for passing to restorecon_sb() */
> +struct rest_flags {
> +	bool nochange;
> +	bool verbose;
> +	bool progress;
> +	bool specctx;
> +	bool add_assoc;
> +	bool ignore;
> +	bool recurse;
> +	bool userealpath;
> +	bool xdev;
> +};
> +
>  static void restorecon_init(void)
>  {
>  	struct selabel_handle *sehandle = NULL;
> @@ -66,6 +79,239 @@ static int check_excluded(const char *file)
>  	return 0;
>  }
>  
> +/*
> + * Support filespec services for selinux_restorecon(3) and matchpathcon(3).
> + * The matchpathcon services are deprecated and at some stage will be removed,
> + * the matchpathcon specific code here can then also be removed.
> + *
> + * selinux_restorecon(3) uses filespec services when the
> + * SELINUX_RESTORECON_ADD_ASSOC flag is set for adding associations between
> + * an inode and a context.
> + */
> +
> +/* Support for matchpathcon myprint() */
> +extern int myprintf_compat;
> +extern void __attribute__ ((format(printf, 1, 2)))
> +(*myprintf) (const char *fmt, ...);
> +#define COMPAT_LOG(type, fmt...) if (myprintf_compat)	  \
> +		myprintf(fmt);				  \
> +	else						  \
> +		selinux_log(type, fmt);

I hate the idea of carrying compat goo into a new file and function.
Also, these are defined in label_internal.h so you can include that
rather than redefining them here.

> +
> +/* Reference the con_array specified in matchpathcon.c */
> +extern __thread char **con_array;
> +
> +int restorecon_filespec_add(ino_t ino, const char *con,
> +			    const char *file, bool add_assoc, bool verbose);
> +int restorecon_filespec_add1(ino_t ino, int specind, const char *con,
> +			    const char *file, bool add_assoc, bool verbose);
> +void restorecon_filespec_eval(bool add_assoc, bool verbose);
> +void restorecon_filespec_destroy(bool add_assoc);

Belong in an internal header.

> +
> +/*
> + * Hold an association between an inode and a context or specification.
> + */
> +typedef struct file_spec {
> +	ino_t ino;	/* inode number */
> +	int specind;	/* index of specification in spec (matchpathcon) */
> +	char *con;	/* matched context (selinux_restorecon)*/
> +	char *file;	/* full pathname */
> +	struct file_spec *next;	/* next association in hash bucket chain */
> +} file_spec_t;

I'm trying to remember the history of filespec_add and friends.
First they existed only in setfiles.  Then I ported them to libselinux
as matchpathcon_filespec_*() and rewrote setfiles to use them.  Then a
revised implementation was added back to setfiles as part of the
conversion to selabel_open() and friends, and the matchpathcon versions
were just left for ABI compatibility but unused.  So I am unsure about
moving these over to restorecon.

> +
> +/*
> + * The hash table of associations, hashed by inode number.
> + * Chaining is used for collisions, with elements ordered
> + * by inode number in each bucket.  Each hash bucket has
> + * a dummy header.
> + */
> +#define HASH_BITS 16
> +#define HASH_BUCKETS (1 << HASH_BITS)
> +#define HASH_MASK (HASH_BUCKETS-1)
> +static file_spec_t *fl_head;
> +
> +/*
> + * Try to add an association between an inode and a context.
> + * If there is a different context that matched the inode,
> + * then use the first context that matched.
> + */
> +int hidden restorecon_filespec_add(ino_t ino, const char *con,
> +			    const char *file, bool add_assoc, bool verbose)
> +{
> +	return restorecon_filespec_add1(ino, -1, con, file, add_assoc, verbose);

What does -1 mean?

> +}
> +
> +int hidden restorecon_filespec_add1(ino_t ino, int specind,
> +				    const char *con,
> +				    const char *file, bool add_assoc,
> +				    bool verbose __attribute__((unused)))
> +{
> +	file_spec_t *prevfl, *fl;
> +	int h, ret;
> +	struct stat64 sb;
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
> +			ret = lstat64(fl->file, &sb);
> +			if (ret < 0 || sb.st_ino != ino) {
> +				if (add_assoc)
> +					free(fl->con);
> +				free(fl->file);
> +				fl->file = strdup(file);
> +				if (!fl->file)
> +					goto oom;
> +
> +				if (add_assoc) {
> +					fl->con = strdup(con);
> +					if (!fl->con)
> +						goto oom;
> +					return 1;
> +				} else {
> +					return fl->specind;
> +				}
> +			}
> +
> +			if (add_assoc) {
> +				if (strcmp(fl->con, con) == 0)
> +					return 1;
> +
> +				selinux_log(SELINUX_ERROR,
> +					"%s:  conflicting specifications for %s and %s, using %s.\n",
> +					__func__, file, fl->file, fl->con);
> +				free(fl->file);
> +				fl->file = strdup(file);
> +				if (!fl->file)
> +					goto oom;
> +				return 1;
> +			} else {
> +				if (!strcmp(con_array[fl->specind],
> +					    con_array[specind]))

What happens when specind was passed as -1 above?

Maybe we ought to just leave the matchpathcon ones alone (aside from
deprecating and ultimately removing them), and bring over the versions
added to setfiles when it was converted to using selabel_open().
