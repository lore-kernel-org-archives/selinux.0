Subject: Re: [PATCH] Android.mk: Add -D_GNU_SOURCE to common_cflags
To: Nick Kralevich <nnk@google.com>, selinux@tycho.nsa.gov
References: <1459984522-76969-1-git-send-email-nnk@google.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <570BFF88.1050804@tycho.nsa.gov>
Date: Mon, 11 Apr 2016 15:48:24 -0400
MIME-Version: 1.0
In-Reply-To: <1459984522-76969-1-git-send-email-nnk@google.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/06/2016 07:15 PM, Nick Kralevich wrote:
> Other build scripts define -D_GNU_SOURCE. The Android build
> system should too.
> 
> Fixes the following warning:
> 
> external/selinux/libsepol/cil/src/cil_mem.c:109:7: warning: implicit
>   declaration of function 'vasprintf' is invalid in C99
>   [-Wimplicit-function-declaration]

Thanks, applied.

> ---
>  libsepol/Android.mk | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/libsepol/Android.mk b/libsepol/Android.mk
> index a43b343..5d2c96b 100644
> --- a/libsepol/Android.mk
> +++ b/libsepol/Android.mk
> @@ -64,6 +64,7 @@ cil_src_files := \
>  	cil/src/cil_verify.c
>  
>  common_cflags := \
> +	-D_GNU_SOURCE \
>  	-Wall -W -Wundef \
>  	-Wshadow -Wmissing-noreturn \
>  	-Wmissing-format-attribute
> 
