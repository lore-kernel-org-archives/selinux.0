Message-ID: <54B3FDE5.8000802@tycho.nsa.gov>
Date: Mon, 12 Jan 2015 12:01:25 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: John Brooks <john.brooks@jolla.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/3] Build libsepol with -O2
References: <1420668221-52637-1-git-send-email-john.brooks@jolla.com>
 <1420668221-52637-2-git-send-email-john.brooks@jolla.com>
In-Reply-To: <1420668221-52637-2-git-send-email-john.brooks@jolla.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/07/2015 05:03 PM, John Brooks wrote:
> libsepol contains performance sensitive code; in particular, compiler
> optimizations save a few minutes off of the optimized policydb hash
> tables.
> ---
>  libsepol/src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> index 6450d67..059f198 100644
> --- a/libsepol/src/Makefile
> +++ b/libsepol/src/Makefile
> @@ -22,7 +22,7 @@ OBJS= $(patsubst %.c,%.o,$(wildcard *.c))
>  LOBJS= $(patsubst %.c,%.lo,$(wildcard *.c))
>  CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-format-attribute
>  
> -override CFLAGS += -I. -I../include -D_GNU_SOURCE
> +override CFLAGS += -I. -I../include -D_GNU_SOURCE -O2
>  
>  ifneq ($(DISABLE_CIL),y)
>  OBJS += $(sort $(patsubst %.c,%.o,$(wildcard $(CILDIR)/src/*.c) $(CIL_GENERATED)))
> 

Not sure we want this to always be set even if the caller specified
their own set of CFLAGS on the make command-line.
