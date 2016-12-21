Message-ID: <1482355333.16789.14.camel@tycho.nsa.gov>
Subject: Re: [PATCH 1/1] libselinux/utils: do not create an empty /sbin
 directory
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Wed, 21 Dec 2016 16:22:13 -0500
In-Reply-To: <20161221210951.14337-1-nicolas.iooss@m4x.org>
References: <20161221210951.14337-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2016-12-21 at 22:09 +0100, Nicolas Iooss wrote:
> When building libselinux package, "make install" creates /sbin
> directory
> without putting anything in it. Remove this from the Makefile.
> 
> While at it, rename USRBINDIR variable USRSBINDIR (with an S) as it
> refers to /usr/sbin.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied.

> ---
>  libselinux/utils/Makefile | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index 774418495dbe..954da450c4d3 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -1,8 +1,7 @@
>  # Installation directories.
>  PREFIX ?= $(DESTDIR)/usr
>  LIBDIR ?= $(PREFIX)/lib
> -USRBINDIR ?= $(PREFIX)/sbin
> -SBINDIR ?= $(DESTDIR)/sbin
> +USRSBINDIR ?= $(PREFIX)/sbin
>  INCLUDEDIR ?= $(PREFIX)/include
>  
>  OS ?= $(shell uname)
> @@ -64,9 +63,9 @@ selinux_restorecon: LDLIBS += -lsepol
>  all: $(TARGETS)
>  
>  install: all
> -	-mkdir -p $(USRBINDIR)
> -	install -m 755 $(TARGETS) $(USRBINDIR)
> -	-mkdir -p $(SBINDIR)
> +	-mkdir -p $(USRSBINDIR)
> +	install -m 755 $(TARGETS) $(USRSBINDIR)
> +
>  clean:
>  	rm -f $(TARGETS) *.o *~
>  
