Subject: Re: [PATCH] Sort object files for deterministic linking order
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
References: <1464850158-16461-1-git-send-email-bigon@debian.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <0eb952c6-cac0-7c7b-4e09-424645732fc7@tycho.nsa.gov>
Date: Mon, 6 Jun 2016 13:12:57 -0400
MIME-Version: 1.0
In-Reply-To: <1464850158-16461-1-git-send-email-bigon@debian.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/02/2016 02:49 AM, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>
>
> This patch is part of the Debian effort to make the build reproducible
>
> Thank to Reiner Herrmann <reiner@reiner-h.de> for the patches
>
> Signed-off-by: Laurent Bigonville <bigon@bigon.be>

Applied.

Thanks,

> ---
>  libselinux/src/Makefile  | 2 +-
>  libsemanage/src/Makefile | 2 +-
>  libsepol/src/Makefile    | 8 ++++----
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index ac9a5d6..d94163e 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -49,7 +49,7 @@ ifeq ($(DISABLE_BOOL),y)
>  endif
>
>  GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) selinuxswig_python_exception.i
> -SRCS= $(filter-out $(UNUSED_SRCS) $(GENERATED) audit2why.c, $(wildcard *.c))
> +SRCS= $(filter-out $(UNUSED_SRCS) $(GENERATED) audit2why.c, $(sort $(wildcard *.c)))
>
>  MAX_STACK_SIZE=32768
>
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index d6c3f0f..96ee652 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -52,7 +52,7 @@ SWIGRUBYSO=$(RUBYPREFIX)_semanage.so
>  LIBSO=$(TARGET).$(LIBVERSION)
>
>  GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) semanageswig_python_exception.i
> -SRCS= $(filter-out $(GENERATED),$(wildcard *.c))
> +SRCS= $(filter-out $(GENERATED),$(sort $(wildcard *.c)))
>
>  OBJS= $(patsubst %.c,%.o,$(SRCS)) conf-scan.o conf-parse.o
>  LOBJS= $(patsubst %.c,%.lo,$(SRCS)) conf-scan.lo conf-parse.lo
> diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> index c0c3274..b0c901f 100644
> --- a/libsepol/src/Makefile
> +++ b/libsepol/src/Makefile
> @@ -18,15 +18,15 @@ TARGET=libsepol.so
>  LIBPC=libsepol.pc
>  LIBMAP=libsepol.map
>  LIBSO=$(TARGET).$(LIBVERSION)
> -OBJS= $(patsubst %.c,%.o,$(wildcard *.c))
> -LOBJS= $(patsubst %.c,%.lo,$(wildcard *.c))
> +OBJS= $(patsubst %.c,%.o,$(sort $(wildcard *.c)))
> +LOBJS= $(patsubst %.c,%.lo,$(sort $(wildcard *.c)))
>  CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-format-attribute -O2
>
>  override CFLAGS += -I. -I../include -D_GNU_SOURCE
>
>  ifneq ($(DISABLE_CIL),y)
> -OBJS += $(sort $(patsubst %.c,%.o,$(wildcard $(CILDIR)/src/*.c) $(CIL_GENERATED)))
> -LOBJS += $(sort $(patsubst %.c,%.lo,$(wildcard $(CILDIR)/src/*.c) $(CIL_GENERATED)))
> +OBJS += $(sort $(patsubst %.c,%.o,$(sort $(wildcard $(CILDIR)/src/*.c)) $(CIL_GENERATED)))
> +LOBJS += $(sort $(patsubst %.c,%.lo,$(sort $(wildcard $(CILDIR)/src/*.c)) $(CIL_GENERATED)))
>  override CFLAGS += -I$(CILDIR)/include
>  endif
>
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
