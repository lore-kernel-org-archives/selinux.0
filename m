Message-ID: <1483995866.20858.100.camel@tycho.nsa.gov>
Subject: Re: [PATCH 2/3] checkpolicy: always include ctypes.h
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Mon, 09 Jan 2017 16:04:26 -0500
In-Reply-To: <20170108184553.31842-2-nicolas.iooss@m4x.org>
References: <20170108184553.31842-1-nicolas.iooss@m4x.org>
 <20170108184553.31842-2-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, 2017-01-08 at 19:45 +0100, Nicolas Iooss wrote:
> The prototype of isdigit() is provided by ctypes.h header. Without
> including this file, gcc fails to build checkpolicy using musl libc:
> 
>     checkpolicy.c: In function ‘main’:
>     checkpolicy.c:705:8: error: implicit declaration of function
>     ‘isdigit’ [-Werror=implicit-function-declaration]
>         if (isdigit(ans[0])) {
>             ^~~~~~~
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied all three.

> ---
>  checkpolicy/checkpolicy.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> index 2d68316dc07b..c82f6f409271 100644
> --- a/checkpolicy/checkpolicy.c
> +++ b/checkpolicy/checkpolicy.c
> @@ -57,6 +57,7 @@
>   * booleans or conditional rules are thrown away a warning is
> printed.
>   */
>  
> +#include <ctype.h>
>  #include <getopt.h>
>  #include <unistd.h>
>  #include <stdlib.h>
> @@ -73,10 +74,6 @@
>  #include <errno.h>
>  #include <sys/mman.h>
>  
> -#ifdef __APPLE__
> -#include <ctype.h>
> -#endif
> -
>  #include <sepol/module_to_cil.h>
>  #include <sepol/policydb/policydb.h>
>  #include <sepol/policydb/services.h>
