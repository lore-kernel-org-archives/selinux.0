Subject: Re: [PATCH] checkpolicy: set flex as default lexer
To: Julien Pivotto <roidelapluie@inuits.eu>, selinux@tycho.nsa.gov
References: <1463435592-30980-1-git-send-email-roidelapluie@inuits.eu>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <cd153bb1-e778-c1dd-b9a0-cd104f1fadf0@tycho.nsa.gov>
Date: Thu, 19 May 2016 14:34:34 -0400
MIME-Version: 1.0
In-Reply-To: <1463435592-30980-1-git-send-email-roidelapluie@inuits.eu>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/16/2016 05:53 PM, Julien Pivotto wrote:
> This makes the checkpolicy Makefile consistent with the Makefile present
> in libsemanage and libsepol.

Thanks, applied.  Please add Signed-off-by lines in the future (git
commit -s option will do so automatically for you).

> ---
>  checkpolicy/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
> index e5fae3d..53a3074 100644
> --- a/checkpolicy/Makefile
> +++ b/checkpolicy/Makefile
> @@ -8,6 +8,7 @@ LIBDIR ?= $(PREFIX)/lib
>  INCLUDEDIR ?= $(PREFIX)/include
>  TARGETS = checkpolicy checkmodule
>  
> +LEX = flex
>  YACC = bison -y
>  
>  CFLAGS ?= -g -Wall -Werror -Wshadow -O2 -pipe -fno-strict-aliasing
> 
