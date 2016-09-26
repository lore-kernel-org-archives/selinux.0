Subject: Re: [PATCH 2/2] libselinux: add ifdef'ing for ANDROID and BUILD_HOST
To: william.c.roberts@intel.com, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov
References: <1474911219-20465-1-git-send-email-william.c.roberts@intel.com>
 <1474911219-20465-3-git-send-email-william.c.roberts@intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c6e68a13-7569-e792-b9b8-8fd4a21aaa54@tycho.nsa.gov>
Date: Mon, 26 Sep 2016 15:22:09 -0400
MIME-Version: 1.0
In-Reply-To: <1474911219-20465-3-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/26/2016 01:33 PM, william.c.roberts@intel.com wrote:
> From: William Roberts <william.c.roberts@intel.com>
> 
> On Android, certain discrepancies arise for unused functionality or
> for dealing with the differences in Bionic libc. This patch includes
> all the "ifdef'ing" required and introduces the BUILD_HOST define.
> 
> The BUILD_HOST define removes functionality not needed when building
> libselinux for the Android build host machine.
> 
> Note that not all the libselinux src files are used to build
> the host and target libraries on Android.
> 
> Change-Id: I7984e7b769c4dfa627d6cf311411fa2c93bb7ef7
> Signed-off-by: William Roberts <william.c.roberts@intel.com>

Thanks, applied both.

> ---
>  libselinux/src/callbacks.c      |   5 ++
>  libselinux/src/label_file.c     |   2 +
>  libselinux/src/label_internal.h |   5 ++
>  libselinux/src/load_policy.c    |   4 ++
>  libselinux/src/matchpathcon.c   | 116 ++++++++++++++++++++--------------------
>  libselinux/src/procattr.c       |   3 ++
>  6 files changed, 78 insertions(+), 57 deletions(-)
> 
> diff --git a/libselinux/src/callbacks.c b/libselinux/src/callbacks.c
> index c3cf98b..c18ccc5 100644
> --- a/libselinux/src/callbacks.c
> +++ b/libselinux/src/callbacks.c
> @@ -34,7 +34,12 @@ default_selinux_audit(void *ptr __attribute__((unused)),
>  static int
>  default_selinux_validate(char **ctx)
>  {
> +#ifndef BUILD_HOST
>  	return security_check_context(*ctx);
> +#else
> +	(void) ctx;
> +	return 0;
> +#endif
>  }
>  
>  static int
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 8ff1170..5ba6a22 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -543,6 +543,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
>  			break;
>  		}
>  
> +#if !defined(BUILD_HOST) && !defined(ANDROID)
>  	/* Process local and distribution substitution files */
>  	if (!path) {
>  		rec->dist_subs =
> @@ -560,6 +561,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
>  							    rec->digest);
>  	}
>  
> +#endif
>  	rec->spec_file = strdup(path);
>  
>  	/*
> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
> index 0827ef6..7c55531 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -16,6 +16,11 @@
>  #include "dso.h"
>  #include "sha1.h"
>  
> +#ifdef ANDROID
> +// Android does not have fgets_unlocked()
> +#define fgets_unlocked(buf, size, fp) fgets(buf, size, fp)
> +#endif
> +
>  /*
>   * Installed backends
>   */
> diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
> index 4f39fc7..249f82f 100644
> --- a/libselinux/src/load_policy.c
> +++ b/libselinux/src/load_policy.c
> @@ -11,8 +11,10 @@
>  #include <string.h>
>  #include <errno.h>
>  #include "selinux_internal.h"
> +#ifndef ANDROID
>  #include <sepol/sepol.h>
>  #include <sepol/policydb.h>
> +#endif
>  #include <dlfcn.h>
>  #include "policy.h"
>  #include <limits.h>
> @@ -45,6 +47,7 @@ int security_load_policy(void *data, size_t len)
>  
>  hidden_def(security_load_policy)
>  
> +#ifndef ANDROID
>  int load_setlocaldefs hidden = 1;
>  
>  #undef max
> @@ -465,3 +468,4 @@ int selinux_init_load_policy(int *enforce)
>  	 */
>  	return -1;
>  }
> +#endif
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
> index 4764ab7..724eb65 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -7,6 +7,64 @@
>  #include "callbacks.h"
>  #include <limits.h>
>  
> +static int (*myinvalidcon) (const char *p, unsigned l, char *c) = NULL;
> +static int (*mycanoncon) (const char *p, unsigned l, char **c) =  NULL;
> +
> +static void
> +#ifdef __GNUC__
> +    __attribute__ ((format(printf, 1, 2)))
> +#endif
> +    default_printf(const char *fmt, ...)
> +{
> +	va_list ap;
> +	va_start(ap, fmt);
> +	vfprintf(stderr, fmt, ap);
> +	va_end(ap);
> +}
> +
> +void
> +#ifdef __GNUC__
> +    __attribute__ ((format(printf, 1, 2)))
> +#endif
> +    (*myprintf) (const char *fmt,...) = &default_printf;
> +int myprintf_compat = 0;
> +
> +void set_matchpathcon_printf(void (*f) (const char *fmt, ...))
> +{
> +	myprintf = f ? f : &default_printf;
> +	myprintf_compat = 1;
> +}
> +
> +int compat_validate(struct selabel_handle *rec,
> +		    struct selabel_lookup_rec *contexts,
> +		    const char *path, unsigned lineno)
> +{
> +	int rc;
> +	char **ctx = &contexts->ctx_raw;
> +
> +	if (myinvalidcon)
> +		rc = myinvalidcon(path, lineno, *ctx);
> +	else if (mycanoncon)
> +		rc = mycanoncon(path, lineno, ctx);
> +	else {
> +		rc = selabel_validate(rec, contexts);
> +		if (rc < 0) {
> +			if (lineno) {
> +				COMPAT_LOG(SELINUX_WARNING,
> +					    "%s: line %u has invalid context %s\n",
> +						path, lineno, *ctx);
> +			} else {
> +				COMPAT_LOG(SELINUX_WARNING,
> +					    "%s: has invalid context %s\n", path, *ctx);
> +			}
> +		}
> +	}
> +
> +	return rc ? -1 : 0;
> +}
> +
> +#ifndef BUILD_HOST
> +
>  static __thread struct selabel_handle *hnd;
>  
>  /*
> @@ -54,33 +112,6 @@ static void free_array_elts(void)
>  	con_array = NULL;
>  }
>  
> -static void
> -#ifdef __GNUC__
> -    __attribute__ ((format(printf, 1, 2)))
> -#endif
> -    default_printf(const char *fmt, ...)
> -{
> -	va_list ap;
> -	va_start(ap, fmt);
> -	vfprintf(stderr, fmt, ap);
> -	va_end(ap);
> -}
> -
> -void
> -#ifdef __GNUC__
> -    __attribute__ ((format(printf, 1, 2)))
> -#endif
> -    (*myprintf) (const char *fmt,...) = &default_printf;
> -int myprintf_compat = 0;
> -
> -void set_matchpathcon_printf(void (*f) (const char *fmt, ...))
> -{
> -	myprintf = f ? f : &default_printf;
> -	myprintf_compat = 1;
> -}
> -
> -static int (*myinvalidcon) (const char *p, unsigned l, char *c) = NULL;
> -
>  void set_matchpathcon_invalidcon(int (*f) (const char *p, unsigned l, char *c))
>  {
>  	myinvalidcon = f;
> @@ -104,9 +135,6 @@ static int default_canoncon(const char *path, unsigned lineno, char **context)
>  	return 0;
>  }
>  
> -static int (*mycanoncon) (const char *p, unsigned l, char **c) =
> -    NULL;
> -
>  void set_matchpathcon_canoncon(int (*f) (const char *p, unsigned l, char **c))
>  {
>  	if (f)
> @@ -536,30 +564,4 @@ int selinux_lsetfilecon_default(const char *path)
>  	return rc;
>  }
>  
> -int compat_validate(struct selabel_handle *rec,
> -		    struct selabel_lookup_rec *contexts,
> -		    const char *path, unsigned lineno)
> -{
> -	int rc;
> -	char **ctx = &contexts->ctx_raw;
> -
> -	if (myinvalidcon)
> -		rc = myinvalidcon(path, lineno, *ctx);
> -	else if (mycanoncon)
> -		rc = mycanoncon(path, lineno, ctx);
> -	else {
> -		rc = selabel_validate(rec, contexts);
> -		if (rc < 0) {
> -			if (lineno) {
> -				COMPAT_LOG(SELINUX_WARNING,
> -					    "%s: line %u has invalid context %s\n",
> -						path, lineno, *ctx);
> -			} else {
> -				COMPAT_LOG(SELINUX_WARNING,
> -					    "%s: has invalid context %s\n", path, *ctx);
> -			}
> -		}
> -	}
> -
> -	return rc ? -1 : 0;
> -}
> +#endif
> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> index eee4612..7efcd7e 100644
> --- a/libselinux/src/procattr.c
> +++ b/libselinux/src/procattr.c
> @@ -22,10 +22,13 @@ static pthread_key_t destructor_key;
>  static int destructor_key_initialized = 0;
>  static __thread char destructor_initialized;
>  
> +#ifndef ANDROID
> +/* Android declares this in unistd.h and has a definition for it */
>  static pid_t gettid(void)
>  {
>  	return syscall(__NR_gettid);
>  }
> +#endif
>  
>  static void procattr_thread_destructor(void __attribute__((unused)) *unused)
>  {
> 
