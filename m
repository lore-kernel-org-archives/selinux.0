From: "Roberts, William C" <william.c.roberts@intel.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: RE: [PATCH] libselinux: fix subdir build and usage of cmdline CFLAGS
Date: Mon, 14 Nov 2016 18:31:09 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC561CD24A31@ORSMSX103.amr.corp.intel.com>
References: <1479147126-11727-1-git-send-email-sds@tycho.nsa.gov>
In-Reply-To: <1479147126-11727-1-git-send-email-sds@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Monday, November 14, 2016 10:12 AM
> To: selinux@tycho.nsa.gov
> Cc: Roberts, William C <william.c.roberts@intel.com>; Stephen Smalley
> <sds@tycho.nsa.gov>
> Subject: [PATCH] libselinux: fix subdir build and usage of cmdline CFLAGS
> 
> commit 16c123f4b1f3c8d20b3f597df161d7e635620923 ("libselinux:
> support ANDROID_HOST=1 on Mac") broke the ability to run make in the src
> subdirectory of libselinux (because OS and COMPILER were not defined) and also
> caused some warning flags that could be overridden via command-line CFLAGS to
> be mandatory.  Fix it.

Ack.

It would be nice if we could avoid the duplication running repent throughout these make files,
maybe include a file that has the definitions/callable functions for all of this stuff?

> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  libselinux/src/Makefile   | 12 ++++++++++--
>  libselinux/utils/Makefile | 10 +++++++++-
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile index
> 24946ce..76efe49 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -23,6 +23,14 @@ LIBSEPOLA ?= $(LIBDIR)/libsepol.a  VERSION = $(shell cat
> ../VERSION)  LIBVERSION = 1
> 
> +OS ?= $(shell uname)
> +
> +ifeq ($(shell $(CC) -v 2>&1 | grep "clang"),) COMPILER ?= gcc else
> +COMPILER ?= clang endif
> +
>  LIBA=libselinux.a
>  TARGET=libselinux.so
>  LIBPC=libselinux.pc
> @@ -67,12 +75,12 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-
> security -Winit-self -Wmissi  LD_SONAME_FLAGS=-soname,$(LIBSO),-z,defs,-
> z,relro
> 
>  ifeq ($(COMPILER), gcc)
> -override CFLAGS += -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -
> Wsync-nand \
> +CFLAGS += -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat
> +-Wsync-nand \
>  	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -
> Wsuggest-attribute=const \
>  	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines
> -Wjump-misses-init \
>  	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -Wp,-
> D_FORTIFY_SOURCE=2  else -override CFLAGS += -Wunused-command-line-
> argument
> +CFLAGS += -Wunused-command-line-argument
>  endif
> 
>  ifeq ($(OS), Darwin)
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile index
> a4f9903..7744184 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -5,6 +5,14 @@ USRBINDIR ?= $(PREFIX)/sbin  SBINDIR ?= $(DESTDIR)/sbin
> INCLUDEDIR ?= $(PREFIX)/include
> 
> +OS ?= $(shell uname)
> +
> +ifeq ($(shell $(CC) -v 2>&1 | grep "clang"),) COMPILER ?= gcc else
> +COMPILER ?= clang endif
> +
>  MAX_STACK_SIZE=8192
>  CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -
> Wmissing-include-dirs \
>            -Wunused -Wunknown-pragmas -Wstrict-aliasing -Wshadow -Wpointer-
> arith \ @@ -26,7 +34,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -
> Wformat-security -Winit-self -Wmissi  LD_SONAME_FLAGS=-soname,$(LIBSO),-
> z,defs,-z,relro
> 
>  ifeq ($(COMPILER), gcc)
> -override CFLAGS += -fipa-pure-const -Wpacked-bitfield-compat -Wsync-nand -
> Wcoverage-mismatch \
> +CFLAGS += -fipa-pure-const -Wpacked-bitfield-compat -Wsync-nand
> +-Wcoverage-mismatch \
>  	-Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-
> attribute=const \
>  	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines
> -Wjump-misses-init \
>  	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const
> --
> 2.7.4
