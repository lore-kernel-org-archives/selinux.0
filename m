Subject: Re: [PATCH] libselinux: Allow overriding libsepol.a location during
 build
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
References: <20161026220430.2403-1-bigon@debian.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f267a904-1c19-1935-1b34-02960cc3fbfd@tycho.nsa.gov>
Date: Thu, 27 Oct 2016 10:45:34 -0400
MIME-Version: 1.0
In-Reply-To: <20161026220430.2403-1-bigon@debian.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/26/2016 06:04 PM, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>
> 
> Signed-off-by: Laurent Bigonville <bigon@bigon.be>

Thanks, applied.

> ---
>  libselinux/src/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index c9f35b1..ae40f80 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -18,6 +18,7 @@ RUBYLIBVER ?= $(shell $(RUBY) -e 'print RUBY_VERSION.split(".")[0..1].join(".")'
>  RUBYINC ?= $(shell $(PKG_CONFIG) --exists ruby-$(RUBYLIBVER) && $(PKG_CONFIG) --cflags ruby-$(RUBYLIBVER) || $(PKG_CONFIG) --cflags ruby)
>  RUBYINSTALL ?= $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
>  LIBBASE ?= $(shell basename $(LIBDIR))
> +LIBSEPOLA ?= $(LIBDIR)/libsepol.a
>  
>  VERSION = $(shell cat ../VERSION)
>  LIBVERSION = 1
> @@ -146,7 +147,7 @@ $(AUDIT2WHYLOBJ): audit2why.c
>  	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
>  
>  $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
> -	$(CC) $(CFLAGS) -shared -o $@ $^ -L. $(LDFLAGS) -lselinux $(LIBDIR)/libsepol.a -L$(LIBDIR)
> +	$(CC) $(CFLAGS) -shared -o $@ $^ -L. $(LDFLAGS) -lselinux $(LIBSEPOLA) -L$(LIBDIR)
>  
>  %.o:  %.c policy.h
>  	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
> 
