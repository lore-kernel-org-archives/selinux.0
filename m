Subject: Re: [PATCH] enabled.c: Remove stdio_ext.h header
To: Nick Kralevich <nnk@google.com>, selinux@tycho.nsa.gov
References: <1479940678-8681-1-git-send-email-nnk@google.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <11e43599-f68c-f2cf-3e59-5a2b877187ef@tycho.nsa.gov>
Date: Mon, 28 Nov 2016 09:34:05 -0500
MIME-Version: 1.0
In-Reply-To: <1479940678-8681-1-git-send-email-nnk@google.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/23/2016 05:37 PM, Nick Kralevich wrote:
> This appears to be unused.

Yes, legacy of older code.  Thanks, applied.

> 
> Signed-off-by: Nick Kralevich <nnk@google.com>
> ---
>  libselinux/src/enabled.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/libselinux/src/enabled.c b/libselinux/src/enabled.c
> index bb659a9..2ec6797 100644
> --- a/libselinux/src/enabled.c
> +++ b/libselinux/src/enabled.c
> @@ -6,7 +6,6 @@
>  #include <errno.h>
>  #include <limits.h>
>  #include <stdio.h>
> -#include <stdio_ext.h>
>  #include "policy.h"
>  
>  int is_selinux_enabled(void)
> 
