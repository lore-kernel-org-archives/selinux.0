Subject: Re: [PATCH] libselinux, libsemanage: respect CC and PKG_CONFIG
 environment variable
To: roidelapluie@inuits.eu, selinux@tycho.nsa.gov
References: <1462691382-10841-1-git-send-email-roidelapluie@inuits.eu>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <65b3a2ca-5cd3-79a6-56e4-a94923e1fc23@tycho.nsa.gov>
Date: Mon, 16 May 2016 16:46:10 -0400
MIME-Version: 1.0
In-Reply-To: <1462691382-10841-1-git-send-email-roidelapluie@inuits.eu>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/08/2016 03:09 AM, roidelapluie@inuits.eu wrote:
> From: Julien Pivotto <roidelapluie@inuits.eu>
> 
> Compilation tools respects certain environment variables, like CC.
> However, in libselinux and libsemanage, they are not respected
> everywhere. This command fixes respect for those variables, falling back
> to the previous hardcoded values if not specified.

Thanks, applied.

> ---
>  libselinux/src/Makefile      | 5 +++--
>  libselinux/src/exception.sh  | 2 +-
>  libsemanage/src/Makefile     | 5 +++--
>  libsemanage/src/exception.sh | 2 +-
>  4 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index d0021ae..ac9a5d6 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -5,6 +5,7 @@ PYTHON ?= python
>  PYPREFIX ?= $(notdir $(PYTHON))
>  RUBY ?= ruby
>  RUBYPREFIX ?= $(notdir $(RUBY))
> +PKG_CONFIG ?= pkg-config
>  
>  # Installation directories.
>  PREFIX ?= $(DESTDIR)/usr
> @@ -12,11 +13,11 @@ LIBDIR ?= $(PREFIX)/lib
>  SHLIBDIR ?= $(DESTDIR)/lib
>  INCLUDEDIR ?= $(PREFIX)/include
>  PYLIBVER ?= $(shell $(PYTHON) -c 'import sys;print("python%d.%d" % sys.version_info[0:2])')
> -PYINC ?= $(shell pkg-config --cflags $(PYPREFIX))
> +PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
>  PYLIBDIR ?= $(LIBDIR)/$(PYLIBVER)
>  RUBYLIBVER ?= $(shell $(RUBY) -e 'print RUBY_VERSION.split(".")[0..1].join(".")')
>  RUBYPLATFORM ?= $(shell $(RUBY) -e 'print RUBY_PLATFORM')
> -RUBYINC ?= $(shell pkg-config --cflags ruby)
> +RUBYINC ?= $(shell $(PKG_CONFIG) --cflags ruby)
>  RUBYINSTALL ?= $(LIBDIR)/ruby/site_ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
>  LIBBASE ?= $(shell basename $(LIBDIR))
>  
> diff --git a/libselinux/src/exception.sh b/libselinux/src/exception.sh
> index b7cff7e..a58bf3f 100755
> --- a/libselinux/src/exception.sh
> +++ b/libselinux/src/exception.sh
> @@ -15,6 +15,6 @@ echo "
>  ;;
>  esac
>  }
> -gcc -x c -c -I../include - -aux-info temp.aux < ../include/selinux/selinux.h
> +${CC:-gcc} -x c -c -I../include - -aux-info temp.aux < ../include/selinux/selinux.h
>  for i in `awk '/<stdin>.*extern int/ { print $6 }' temp.aux`; do except $i ; done 
>  rm -f -- temp.aux -.o
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index d1fcc0b..b0711a7 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -5,6 +5,7 @@ PYTHON ?= python
>  PYPREFIX ?= $(notdir $(PYTHON))
>  RUBY ?= ruby
>  RUBYPREFIX ?= $(notdir $(RUBY))
> +PKG_CONFIG ?= pkg-config
>  
>  # Installation directories.
>  PREFIX ?= $(DESTDIR)/usr
> @@ -12,11 +13,11 @@ LIBDIR ?= $(PREFIX)/lib
>  SHLIBDIR ?= $(DESTDIR)/lib
>  INCLUDEDIR ?= $(PREFIX)/include
>  PYLIBVER ?= $(shell $(PYTHON) -c 'import sys;print("python%d.%d" % sys.version_info[0:2])')
> -PYINC ?= $(shell pkg-config --cflags $(PYPREFIX))
> +PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
>  PYLIBDIR ?= $(LIBDIR)/$(PYLIBVER)
>  RUBYLIBVER ?= $(shell $(RUBY) -e 'print RUBY_VERSION.split(".")[0..1].join(".")')
>  RUBYPLATFORM ?= $(shell $(RUBY) -e 'print RUBY_PLATFORM')
> -RUBYINC ?= $(shell pkg-config --cflags ruby-$(RUBYLIBVER))
> +RUBYINC ?= $(shell $(PKG_CONFIG) --cflags ruby-$(RUBYLIBVER))
>  RUBYINSTALL ?= $(LIBDIR)/ruby/site_ruby/$(RUBYLIBVER)/$(RUBYPLATFORM)
>  
>  LIBBASE=$(shell basename $(LIBDIR))
> diff --git a/libsemanage/src/exception.sh b/libsemanage/src/exception.sh
> index 94619d2..d18959c 100644
> --- a/libsemanage/src/exception.sh
> +++ b/libsemanage/src/exception.sh
> @@ -9,6 +9,6 @@ echo "
>  }
>  "
>  }
> -gcc -x c -c -I../include - -aux-info temp.aux < ../include/semanage/semanage.h
> +${CC:-gcc} -x c -c -I../include - -aux-info temp.aux < ../include/semanage/semanage.h
>  for i in `awk '/extern int/ { print $6 }' temp.aux`; do except $i ; done
>  rm -f -- temp.aux -.o
> 
