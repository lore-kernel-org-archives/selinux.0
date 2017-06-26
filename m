Message-ID: <1498505865.13301.37.camel@tycho.nsa.gov>
Subject: Re: [PATCH] Fix consistency of PYTHONLIBDIR variable
From: Stephen Smalley <sds@tycho.nsa.gov>
To: bigon@debian.org, selinux@tycho.nsa.gov
Date: Mon, 26 Jun 2017 15:37:45 -0400
In-Reply-To: <20170626164651.20452-1-bigon@debian.org>
References: <20170626164651.20452-1-bigon@debian.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-06-26 at 18:46 +0200, bigon@debian.org wrote:
> From: Laurent Bigonville <bigon@bigon.be>
> 
> PYTHONLIBDIR is currently not consistant, at one place it's
> influanced
> by DESTDIR an at another one it's not.
> 
> Fix this and make it consistant

Seems like it is influenced by DESTDIR before and after this change
(before, PYTHONLIBDIR is defined relative to LIBDIR which is defined
relative to PREFIX which is define relative to DESTDIR).

If I do a make DESTDIR=/path/to/foo install before and after this
change (with an empty /path/to/foo before each run), the only
difference is that it moves from $(DESTDIR)/usr/lib/pythonM.N/site-
packages to $(DESTDIR)/usr/lib64/pythonM.N/site-packages.

This makes it consistent with sepolgen but inconsistent with sepolicy,
which is installed to usr/lib, not usr/lib64.

So, I'm unclear on whether this is an improvement.

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
