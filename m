Subject: Re: [PATCH 2/2] libselinux: query for python site-packages dir
 directly
To: Jason Zaman <jason@perfinion.com>, selinux@tycho.nsa.gov
References: <1475381714-9906-1-git-send-email-jason@perfinion.com>
 <1475381714-9906-2-git-send-email-jason@perfinion.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fa22ce21-3ec2-485c-c0c0-499bff50792d@tycho.nsa.gov>
Date: Mon, 3 Oct 2016 09:35:31 -0400
MIME-Version: 1.0
In-Reply-To: <1475381714-9906-2-git-send-email-jason@perfinion.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/02/2016 12:15 AM, Jason Zaman wrote:
> instead of building the path manually which is more error prone

Thanks, applied both.  I guess the only question I have is whether a)
this same change ought to be applied to all other Makefiles (e.g.
libsemanage, policycoreutils), and b) could this break any existing
build recipes that relied on setting PYLIBDIR.  Doesn't appear that
Fedora spec files do so, but not sure about other distribution packages.

> 
> Signed-off-by: Jason Zaman <jason@perfinion.com>
> ---
>  libselinux/src/Makefile | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index f9e3de1..13501cd 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -12,9 +12,8 @@ PREFIX ?= $(DESTDIR)/usr
>  LIBDIR ?= $(PREFIX)/lib
>  SHLIBDIR ?= $(DESTDIR)/lib
>  INCLUDEDIR ?= $(PREFIX)/include
> -PYLIBVER ?= $(shell $(PYTHON) -c 'import sys;print("python%d.%d" % sys.version_info[0:2])')
>  PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
> -PYLIBDIR ?= $(LIBDIR)/$(PYLIBVER)
> +PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
>  RUBYLIBVER ?= $(shell $(RUBY) -e 'print RUBY_VERSION.split(".")[0..1].join(".")')
>  RUBYINC ?= $(shell $(PKG_CONFIG) --exists ruby-$(RUBYLIBVER) && $(PKG_CONFIG) --cflags ruby-$(RUBYLIBVER) || $(PKG_CONFIG) --cflags ruby)
>  RUBYINSTALL ?= $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
> @@ -160,10 +159,10 @@ install: all
>  	ln -sf --relative $(SHLIBDIR)/$(LIBSO) $(LIBDIR)/$(TARGET)
>  
>  install-pywrap: pywrap
> -	test -d $(PYLIBDIR)/site-packages/selinux || install -m 755 -d $(PYLIBDIR)/site-packages/selinux
> -	install -m 755 $(SWIGSO) $(PYLIBDIR)/site-packages/_selinux.so
> -	install -m 755 $(AUDIT2WHYSO) $(PYLIBDIR)/site-packages/selinux/audit2why.so
> -	install -m 644 $(SWIGPYOUT) $(PYLIBDIR)/site-packages/selinux/__init__.py
> +	test -d $(PYSITEDIR)/selinux || install -m 755 -d $(PYSITEDIR)/selinux
> +	install -m 755 $(SWIGSO) $(PYSITEDIR)/_selinux.so
> +	install -m 755 $(AUDIT2WHYSO) $(PYSITEDIR)/selinux/audit2why.so
> +	install -m 644 $(SWIGPYOUT) $(PYSITEDIR)/selinux/__init__.py
>  
>  install-rubywrap: rubywrap
>  	test -d $(RUBYINSTALL) || install -m 755 -d $(RUBYINSTALL) 
> 
