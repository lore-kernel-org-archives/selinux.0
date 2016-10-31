Subject: Re: [PATCH 1/1] policycoreutils: restorecond: use pkg-config to find
 dbus-glib-1 files
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161030191508.9155-1-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b697b19a-f172-f465-4ccc-2d3290dc768f@tycho.nsa.gov>
Date: Mon, 31 Oct 2016 12:52:12 -0400
MIME-Version: 1.0
In-Reply-To: <20161030191508.9155-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/30/2016 03:15 PM, Nicolas Iooss wrote:
> On Ubuntu some header files are located in /usr/lib/x86_64-linux-gnu/,
> not /usr/lib64/:
> 
>     $ pkg-config --cflags dbus-glib-1
>     -I/usr/include/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include
>     -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
> 
> Use pkg-config instead of hard-coded paths to find glib and dbus-glib
> headers and libraries.
> 
> This is needed in order to use environments provided for example by
> https://travis-ci.org/.

Thanks, applied.

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  policycoreutils/restorecond/Makefile | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/policycoreutils/restorecond/Makefile b/policycoreutils/restorecond/Makefile
> index 253246d7b5ea..93050f00d230 100644
> --- a/policycoreutils/restorecond/Makefile
> +++ b/policycoreutils/restorecond/Makefile
> @@ -1,3 +1,5 @@
> +PKG_CONFIG ?= pkg-config
> +
>  # Installation directories.
>  PREFIX ?= $(DESTDIR)/usr
>  SBINDIR ?= $(PREFIX)/sbin
> @@ -11,11 +13,11 @@ autostart_DATA = sealertauto.desktop
>  INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
>  SELINUXDIR = $(DESTDIR)/etc/selinux
>  
> -DBUSFLAGS = -DHAVE_DBUS -I/usr/include/dbus-1.0 -I/usr/lib64/dbus-1.0/include -I/usr/lib/dbus-1.0/include
> -DBUSLIB = -ldbus-glib-1 -ldbus-1
> +DBUSFLAGS = -DHAVE_DBUS $(shell $(PKG_CONFIG) --cflags dbus-glib-1)
> +DBUSLIB = $(shell $(PKG_CONFIG) --libs dbus-glib-1)
>  
>  CFLAGS ?= -g -Werror -Wall -W
> -override CFLAGS += -I$(PREFIX)/include $(DBUSFLAGS) -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/lib/glib-2.0/include
> +override CFLAGS += -I$(PREFIX)/include $(DBUSFLAGS)
>  
>  USE_PCRE2 ?= n
>  ifeq ($(USE_PCRE2),y)
> @@ -24,7 +26,7 @@ else
>  	PCRE_LDFLAGS := -lpcre
>  endif
>  
> -LDLIBS += -lselinux $(PCRE_LDFLAGS) $(DBUSLIB) -lglib-2.0 -L$(LIBDIR)
> +LDLIBS += -lselinux $(PCRE_LDFLAGS) $(DBUSLIB) -L$(LIBDIR)
>  
>  all: restorecond
>  
> 
