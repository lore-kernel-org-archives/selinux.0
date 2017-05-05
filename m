Message-ID: <1494013984.5745.21.camel@tycho.nsa.gov>
Subject: Re: [PATCH] libsepol/utils: Fix build without system sepol.h
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Date: Fri, 05 May 2017 15:53:04 -0400
In-Reply-To: <20170505101233.13767-2-plautrba@redhat.com>
References: <6e6bc5c8-2a86-2189-8e1c-dc512de699e2@redhat.com>
 <20170505101233.13767-1-plautrba@redhat.com>
 <20170505101233.13767-2-plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-05-05 at 12:12 +0200, Petr Lautrbach wrote:
> fcb5d5c removed ../include from CFLAGS from libsepol/utils/Makefile
> so
> that a build tool can't find sepol/sepol.h when only libsepol is
> built
> and a system is without sepol.h in standard paths. It should use its
> own
> sepol.h file during build. `oveeride` needs to be used in order not
> to
> be overridden by values provided on a command line. Same problem
> applies
> to LDFLAGS.
> 
> Fixes:
> $ make CFLAGS="" LDFLAGS=""
> make[1]: Entering directory '/root/selinux/libsepol/utils'
> cc     chkcon.c  -lsepol -o chkcon
> chkcon.c:1:25: fatal error: sepol/sepol.h: No such file or directory
>  #include <sepol/sepol.h>
> 
> $ make CFLAGS="" LDFLAGS=""
> ...
> make -C utils
> make[1]: Entering directory '/root/selinux/libsepol/utils'
> cc  -I../include    chkcon.c  -lsepol -o chkcon
> /usr/bin/ld: cannot find -lsepol
> collect2: error: ld returned 1 exit status

Thanks, applied

> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  libsepol/utils/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/libsepol/utils/Makefile b/libsepol/utils/Makefile
> index a13164e1..3b2fb771 100644
> --- a/libsepol/utils/Makefile
> +++ b/libsepol/utils/Makefile
> @@ -3,7 +3,8 @@ PREFIX ?= $(DESTDIR)/usr
>  BINDIR ?= $(PREFIX)/bin
>  
>  CFLAGS ?= -Wall -Werror
> -LDFLAGS += -L../src
> +override CFLAGS += -I../include
> +override LDFLAGS += -L../src
>  LDLIBS += -lsepol
>  
>  TARGETS=$(patsubst %.c,%,$(wildcard *.c))
