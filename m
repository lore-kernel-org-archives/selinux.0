Message-ID: <1498841831.16913.15.camel@tycho.nsa.gov>
Subject: Re: [PATCH] Fix consistency of PYTHONLIBDIR variable across modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
Date: Fri, 30 Jun 2017 12:57:11 -0400
In-Reply-To: <20170630160916.14755-1-bigon@debian.org>
References: <20170630160916.14755-1-bigon@debian.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-06-30 at 18:09 +0200, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>
> 
> PYTHONLIBDIR is currently also used in sepolgen but has a different
> behaviour regarding DESTDIR. Let's try to make this consistant.
> 
> Signed-off-by: Laurent Bigonville <bigon@bigon.be>

Thanks, applied

> ---
>  python/semanage/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/python/semanage/Makefile b/python/semanage/Makefile
> index 60c36a3a..132162bc 100644
> --- a/python/semanage/Makefile
> +++ b/python/semanage/Makefile
> @@ -5,8 +5,8 @@ PREFIX ?= $(DESTDIR)/usr
>  LIBDIR ?= $(PREFIX)/lib
>  SBINDIR ?= $(PREFIX)/sbin
>  MANDIR = $(PREFIX)/share/man
> -PYLIBVER ?= $(shell $(PYTHON) -c 'import sys;print("python%d.%d" %
> sys.version_info[0:2])')
> -PYTHONLIBDIR ?= $(LIBDIR)/$(PYLIBVER)
> +PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig
> import *; print(get_python_lib(1))")
> +PACKAGEDIR ?= $(DESTDIR)/$(PYTHONLIBDIR)
>  BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-
> completion/completions
>  
>  TARGETS=semanage
> @@ -20,8 +20,8 @@ install: all
>  	-mkdir -p $(SBINDIR)
>  	install -m 755 semanage $(SBINDIR)
>  	install -m 644 *.8 $(MANDIR)/man8
> -	test -d $(PYTHONLIBDIR)/site-packages || install -m 755 -d
> $(PYTHONLIBDIR)/site-packages
> -	install -m 755 seobject.py $(PYTHONLIBDIR)/site-packages
> +	test -d $(PACKAGEDIR) || install -m 755 -d $(PACKAGEDIR)
> +	install -m 755 seobject.py $(PACKAGEDIR)
>  	-mkdir -p $(BASHCOMPLETIONDIR)
>  	install -m 644 $(BASHCOMPLETIONS)
> $(BASHCOMPLETIONDIR)/semanage
>  
