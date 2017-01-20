Message-ID: <1484936862.1689.6.camel@tycho.nsa.gov>
Subject: Re: [PATCH] libsepol compilation fixes for macOS.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <karlwmacmillan@gmail.com>, selinux@tycho.nsa.gov
Date: Fri, 20 Jan 2017 13:27:42 -0500
In-Reply-To: <1484932559-10730-1-git-send-email-karlwmacmillan@gmail.com>
References: <1484932559-10730-1-git-send-email-karlwmacmillan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-01-20 at 12:15 -0500, Karl MacMillan wrote:
> ln on macOS doesn't support --relative, so use the gnu version by
> default.
> 
> Also document how to build on macOS.

Thanks, applied.

> 
> Signed-off-by: Karl MacMillan <karlwmacmillan@gmail.com>
> ---
>  README                | 5 +++++
>  libsepol/src/Makefile | 4 +++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/README b/README
> index e6f7276..7fc7b17 100644
> --- a/README
> +++ b/README
> @@ -17,3 +17,8 @@ make install install-pywrap relabel
>  This may render your system unusable if the upstream SELinux
> userspace
>  lacks library functions or other dependencies relied upon by your
>  distribution.  If it breaks, you get to keep both pieces.
> +
> +To install libsepol on macOS (mainly for policy analysis):
> +cd libsepol; make DESTDIR=/usr/local PREFIX=/usr/local install
> +
> +This requires GNU coreutils (brew install coreutils).
> diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> index 497cd56..819d261 100644
> --- a/libsepol/src/Makefile
> +++ b/libsepol/src/Makefile
> @@ -32,10 +32,12 @@ endif
>  
>  LD_SONAME_FLAGS=-soname,$(LIBSO),--version-script=$(LIBMAP),-z,defs
>  
> +LN=ln
>  OS := $(shell uname)
>  ifeq ($(OS), Darwin)
>  LD_SONAME_FLAGS=-install_name,$(LIBSO)
>  LDFLAGS += -undefined dynamic_lookup
> +LN=gln
>  endif
>  
>  all: $(LIBA) $(LIBSO) $(LIBPC)
> @@ -84,7 +86,7 @@ install: all
>  	install -m 755 $(LIBSO) $(SHLIBDIR)
>  	test -d $(LIBDIR)/pkgconfig || install -m 755 -d
> $(LIBDIR)/pkgconfig
>  	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
> -	ln -sf --relative $(SHLIBDIR)/$(LIBSO) $(LIBDIR)/$(TARGET)
> +	$(LN) -sf --relative $(SHLIBDIR)/$(LIBSO)
> $(LIBDIR)/$(TARGET)
>  
>  relabel:
>  	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
