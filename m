Subject: Re: [PATCH 3/3] policycoreutils: Remove LDFLAGS from CFLAGS
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20160925121609.14516-1-nicolas.iooss@m4x.org>
 <20160925121609.14516-3-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ddf9396f-2b46-331a-738e-6e417d2f7122@tycho.nsa.gov>
Date: Mon, 26 Sep 2016 11:05:38 -0400
MIME-Version: 1.0
In-Reply-To: <20160925121609.14516-3-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/25/2016 08:16 AM, Nicolas Iooss wrote:
> Mixing LDFLAGS in CFLAGS can lead to compiler errors. For example in
> policycoreutils/sandbox:
> 
>     $ make CC=clang LDFLAGS='-Wl,-as-needed,-no-undefined'
>     clang -Wl,-as-needed,-no-undefined -I/usr/include
>     -DPACKAGE="\"policycoreutils\"" -Wall -Werror -Wextra -W   -c -o
>     seunshare.o seunshare.c
>     clang-3.8: error: -Wl,-as-needed,-no-undefined: 'linker' input
>     unused
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied all 3.

> ---
>  policycoreutils/newrole/Makefile | 2 +-
>  policycoreutils/sandbox/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/Makefile
> index 646cd4dd7214..8b41428cbbbc 100644
> --- a/policycoreutils/newrole/Makefile
> +++ b/policycoreutils/newrole/Makefile
> @@ -22,7 +22,7 @@ VERSION = $(shell cat ../VERSION)
>  
>  CFLAGS ?= -Werror -Wall -W
>  EXTRA_OBJS =
> -override CFLAGS += -DVERSION=\"$(VERSION)\" $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
> +override CFLAGS += -DVERSION=\"$(VERSION)\" -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
>  LDLIBS += -lselinux -L$(PREFIX)/lib
>  ifeq ($(PAMH), /usr/include/security/pam_appl.h)
>  	override CFLAGS += -DUSE_PAM
> diff --git a/policycoreutils/sandbox/Makefile b/policycoreutils/sandbox/Makefile
> index a4861eab52b6..2716d691d81b 100644
> --- a/policycoreutils/sandbox/Makefile
> +++ b/policycoreutils/sandbox/Makefile
> @@ -9,7 +9,7 @@ SBINDIR ?= $(PREFIX)/sbin
>  MANDIR ?= $(PREFIX)/share/man
>  LOCALEDIR ?= /usr/share/locale
>  SHAREDIR ?= $(PREFIX)/share/sandbox
> -override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DPACKAGE="\"policycoreutils\"" -Wall -Werror -Wextra -W
> +override CFLAGS += -I$(PREFIX)/include -DPACKAGE="\"policycoreutils\"" -Wall -Werror -Wextra -W
>  LDLIBS += -lselinux -lcap-ng -L$(LIBDIR)
>  SEUNSHARE_OBJS = seunshare.o
>  
> 
