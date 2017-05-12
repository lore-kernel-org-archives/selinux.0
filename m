Message-ID: <1494595373.9454.2.camel@tycho.nsa.gov>
Subject: Re: [PATCH] procattr.c: Use __BIONIC__ instead of __ANDROID__
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tom Cherry <tomcherry@google.com>, selinux@tycho.nsa.gov
Cc: enh@google.com, William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 12 May 2017 09:22:53 -0400
In-Reply-To: <20170511235002.26468-1-tomcherry@google.com>
References: <20170511235002.26468-1-tomcherry@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-05-11 at 16:50 -0700, Tom Cherry via Selinux wrote:
> This check is not specific to Android devices. If libselinux were
> used
> with Bionic on a normal Linux system this check would still be
> needed.
> 
> Signed-off-by: Tom Cherry <tomcherry@google.com>

Thanks, applied.  This was actually switched from ANDROID to _ANDROID__
 by nnk in 044f6ef104c8a9d8f42faa8756e71a0525198f5b.  We don't appear
to have any other uses of __ANDROID__, but we do have a number of uses
of ANDROID.  Offhand though these other uses of ANDROID don't appear to
be related to bionic but instead reflect differences in SELinux
userspace integration in Android vs GNU/Linux.  If however your
bionic/Linux system integrates SELinux support in an Android-like
manner (e.g. kernel policy file is /sepolicy, no /etc/selinux/config,
...), then you might need to generalize those as well.

> ---
>  libselinux/src/procattr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> index ebc0adec..48dd8aff 100644
> --- a/libselinux/src/procattr.c
> +++ b/libselinux/src/procattr.c
> @@ -22,8 +22,8 @@ static pthread_key_t destructor_key;
>  static int destructor_key_initialized = 0;
>  static __thread char destructor_initialized;
>  
> -#ifndef __ANDROID__
> -/* Android declares this in unistd.h and has a definition for it */
> +#ifndef __BIONIC__
> +/* Bionic declares this in unistd.h and has a definition for it */
>  static pid_t gettid(void)
>  {
>  	return syscall(__NR_gettid);
