Subject: Re: [PATCH] procattr.c: Use __ANDROID__ instead of ANDROID
To: Nick Kralevich <nnk@google.com>, selinux@tycho.nsa.gov,
 William Roberts <bill.c.roberts@gmail.com>
References: <1479955630-85378-1-git-send-email-nnk@google.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f83e9379-df94-e23b-2093-69934faab8ad@tycho.nsa.gov>
Date: Mon, 28 Nov 2016 09:38:56 -0500
MIME-Version: 1.0
In-Reply-To: <1479955630-85378-1-git-send-email-nnk@google.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/23/2016 09:47 PM, Nick Kralevich wrote:
> When code is compiled within the Android tree, the resulting binaries
> are intended to run either on the "host" (the machine doing the
> building) or the "target" (the machine running the Android operating
> system).
> 
> "ANDROID" is defined if the code is being compiled for the host or the
> target, whereas "__ANDROID__" is only defined for code being compiled for
> the target. (yes, I agree, this is not obvious).
> 
> gettid() is only declared in the target environment, not the host
> environment, so adjust the #ifdef to properly emit the gettid()
> definition for binaries targeting the host.

Thanks, applied.

> 
> Signed-off-by: Nick Kralevich <nnk@google.com>
> ---
>  libselinux/src/procattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> index 7efcd7e..8cd59af 100644
> --- a/libselinux/src/procattr.c
> +++ b/libselinux/src/procattr.c
> @@ -22,7 +22,7 @@ static pthread_key_t destructor_key;
>  static int destructor_key_initialized = 0;
>  static __thread char destructor_initialized;
>  
> -#ifndef ANDROID
> +#ifndef __ANDROID__
>  /* Android declares this in unistd.h and has a definition for it */
>  static pid_t gettid(void)
>  {
> 
