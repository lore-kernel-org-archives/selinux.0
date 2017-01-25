Message-ID: <1485354168.15074.30.camel@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux/src/regex.c: support old compilers for the
 endian check
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 selinux@tycho.nsa.gov
Date: Wed, 25 Jan 2017 09:22:48 -0500
In-Reply-To: <1485337456-16195-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1485337456-16195-1-git-send-email-thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-01-25 at 22:44 +1300, Thomas Petazzoni wrote:
> libselinux 2.6 has added some code in regex.c that uses
> __BYTE_ORDER__
> to determine the system endianness. Unfortunately, this definition
> provided directly by the compiler doesn't exist in older gcc versions
> such as gcc 4.4.
> 
> In order to address this, this commit extends the logic to use
> <endian.h> definitions if __BYTE_ORDER__ is not provided by the
> compiler. This allows libselinux to build properly with gcc 4.4.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks, applied

> ---
>  libselinux/src/regex.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index a3b427b..0c5ad27 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -13,7 +13,18 @@
>  #endif
>  
>  #ifndef __BYTE_ORDER__
> -#error __BYTE_ORDER__ not defined. Unable to determine endianness.
> +
> +/* If the compiler doesn't define __BYTE_ORDER__, try to use the C
> + * library <endian.h> header definitions. */
> +#include <endian.h>
> +#ifndef __BYTE_ORDER
> +#error Neither __BYTE_ORDER__ nor __BYTE_ORDER defined. Unable to
> determine endianness.
> +#endif
> +
> +#define __ORDER_LITTLE_ENDIAN __LITTLE_ENDIAN
> +#define __ORDER_BIG_ENDIAN __BIG_ENDIAN
> +#define __BYTE_ORDER__ __BYTE_ORDER
> +
>  #endif
>  
>  #ifdef USE_PCRE2
