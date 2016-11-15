Subject: Re: [PATCH 4/4] libselinux,libsemanage: link Python wrapper with
 Python
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161114212817.15781-1-nicolas.iooss@m4x.org>
 <20161114212817.15781-4-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ab182335-7f81-6a35-7881-76eb67a442dc@tycho.nsa.gov>
Date: Tue, 15 Nov 2016 11:08:07 -0500
MIME-Version: 1.0
In-Reply-To: <20161114212817.15781-4-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/14/2016 04:28 PM, Nicolas Iooss wrote:
> When linking with -Wl,-no-undefined in LDFLAGS (in order to find
> possible link-time errors), the Python wrapper module needs to be
> linked with the right libpython.so. This library is found using
> pkg-config in a new PYLIBS variable.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied all four.

> ---
>  libselinux/src/Makefile  | 5 +++--
>  libsemanage/src/Makefile | 3 ++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 82a1010af2d8..928cc049cedb 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -13,6 +13,7 @@ LIBDIR ?= $(PREFIX)/lib
>  SHLIBDIR ?= $(DESTDIR)/lib
>  INCLUDEDIR ?= $(PREFIX)/include
>  PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
> +PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
>  PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
>  RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
>  RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -lruby"')
> @@ -131,7 +132,7 @@ $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
>  	$(CC) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
>  
>  $(SWIGSO): $(SWIGLOBJ)
> -	$(CC) $(CFLAGS) -shared -o $@ $< -L. -lselinux $(LDFLAGS) -L$(LIBDIR)
> +	$(CC) $(CFLAGS) -shared -o $@ $< -L. -lselinux $(LDFLAGS) $(PYLIBS) -L$(LIBDIR)
>  
>  $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
>  	$(CC) $(CFLAGS) -shared -o $@ $^ -L. -lselinux $(LDFLAGS) $(RUBYLIBS) -L$(LIBDIR)
> @@ -154,7 +155,7 @@ $(AUDIT2WHYLOBJ): audit2why.c
>  	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
>  
>  $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
> -	$(CC) $(CFLAGS) -shared -o $@ $^ -L. $(LDFLAGS) -lselinux $(LIBSEPOLA) -L$(LIBDIR)
> +	$(CC) $(CFLAGS) -shared -o $@ $^ -L. $(LDFLAGS) -lselinux $(LIBSEPOLA) $(PYLIBS) -L$(LIBDIR)
>  
>  %.o:  %.c policy.h
>  	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index 5c7bc6c6ea65..5176582f654d 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -13,6 +13,7 @@ LIBDIR ?= $(PREFIX)/lib
>  SHLIBDIR ?= $(DESTDIR)/lib
>  INCLUDEDIR ?= $(PREFIX)/include
>  PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
> +PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
>  PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
>  RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
>  RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -lruby"')
> @@ -79,7 +80,7 @@ $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
>  	$(CC) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
>  
>  $(SWIGSO): $(SWIGLOBJ)
> -	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $< -L. -lsemanage -L$(LIBDIR)
> +	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $< -L. -lsemanage $(PYLIBS) -L$(LIBDIR)
>  
>  $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
>  	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lsemanage $(RUBYLIBS) -L$(LIBDIR)
> 
