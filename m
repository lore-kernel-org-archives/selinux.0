Subject: Re: [PATCH] secilc: correct include path of cil.h for Android
To: Bowgo Tsai <bowgotsai@google.com>, selinux@tycho.nsa.gov
References: <1475205475-146225-1-git-send-email-bowgotsai@google.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a1e08ae1-4322-1039-d4c0-688305ea9f98@tycho.nsa.gov>
Date: Fri, 30 Sep 2016 08:35:38 -0400
MIME-Version: 1.0
In-Reply-To: <1475205475-146225-1-git-send-email-bowgotsai@google.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/29/2016 11:17 PM, Bowgo Tsai wrote:
> From: bowgotsai <bowgotsai@google.com>
> 
> The original CL in AOSP tree:
>   https://android-review.googlesource.com/#/c/274894
> 
> BUG=31366888

Thanks, applied both patches.

> ---
>  secilc/secilc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/secilc/secilc.c b/secilc/secilc.c
> index e98abe2..dad1e90 100644
> --- a/secilc/secilc.c
> +++ b/secilc/secilc.c
> @@ -35,7 +35,7 @@
>  #include <sys/stat.h>
>  
>  #ifdef ANDROID
> -#include <sepol/cil.h>
> +#include <cil/cil.h>
>  #else
>  #include <sepol/cil/cil.h>
>  #endif
> 
