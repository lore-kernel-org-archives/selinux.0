Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u74D0OQT005531
 for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2016 09:00:25 -0400
Subject: Re: [PATCH] libselinux/utils/Makefile: Fix in tree compilation
To: Laurent Bigonville <bigon@debian.org>, <selinux@tycho.nsa.gov>
References: <1470314646-29805-1-git-send-email-bigon@debian.org>
From: Steve Lawrence <slawrence@tresys.com>
Message-ID: <49c99a05-aba8-18ab-e9cb-df96b5aa2af7@tresys.com>
Date: Thu, 4 Aug 2016 09:00:10 -0400
MIME-Version: 1.0
In-Reply-To: <1470314646-29805-1-git-send-email-bigon@debian.org>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/04/2016 08:44 AM, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>
> 
> Some tools need the sepol/sepol.h header

Applied. Thanks!

- Steve

> ---
>  libselinux/utils/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index cf7af52..8497cb4 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -3,6 +3,7 @@ PREFIX ?= $(DESTDIR)/usr
>  LIBDIR ?= $(PREFIX)/lib
>  USRBINDIR ?= $(PREFIX)/sbin
>  SBINDIR ?= $(DESTDIR)/sbin
> +INCLUDEDIR ?= $(PREFIX)/include
>  
>  MAX_STACK_SIZE=8192
>  CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissing-include-dirs \
> @@ -23,7 +24,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
>            -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
>            -fipa-pure-const -Wno-suggest-attribute=pure -Wno-suggest-attribute=const \
>            -Werror -Wno-aggregate-return -Wno-redundant-decls
> -override CFLAGS += -I../include -D_GNU_SOURCE $(EMFLAGS)
> +override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE $(EMFLAGS)
>  LDLIBS += -L../src -lselinux -L$(LIBDIR)
>  
>  TARGETS=$(patsubst %.c,%,$(wildcard *.c))
> 
