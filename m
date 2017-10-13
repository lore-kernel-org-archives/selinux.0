Message-ID: <1507923099.15007.12.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Date: Fri, 13 Oct 2017 15:31:39 -0400
In-Reply-To: <20171011085345.31496-1-plautrba@redhat.com>
References: <20171011085345.31496-1-plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] libselinux: Add support for pcre2 to pkgconfig definition
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-10-11 at 10:53 +0200, Petr Lautrbach wrote:
> When libselinux is built using USE_PCRE2 libselinux.pc needs to
> require
> libpcre2-8 instead of libpcre.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1487521
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, applied.

We still need to revisit the value proposition of file_contexts.bin
after the move to pcre2, given the large increase in file size and the
runtime overhead.  We can add -r to the sefcontext_compile args via
semanage.conf, but then I'm wondering whether it is worth having
file_contexts.bin at all.

> ---
>  libselinux/Makefile             | 11 ++++++-----
>  libselinux/src/Makefile         |  2 +-
>  libselinux/src/libselinux.pc.in |  2 +-
>  3 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/libselinux/Makefile b/libselinux/Makefile
> index 1ecab178..16531fe9 100644
> --- a/libselinux/Makefile
> +++ b/libselinux/Makefile
> @@ -21,13 +21,14 @@ export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS
> ANDROID_HOST
>  
>  USE_PCRE2 ?= n
>  ifeq ($(USE_PCRE2),y)
> -	PCRE_CFLAGS := -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8 $(shell
> $(PKG_CONFIG) --cflags libpcre2-8)
> -	PCRE_LDLIBS := $(shell $(PKG_CONFIG) --libs libpcre2-8)
> +	PCRE_MODULE := libpcre2-8
> +	PCRE_CFLAGS := -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8
>  else
> -	PCRE_CFLAGS := $(shell $(PKG_CONFIG) --cflags libpcre)
> -	PCRE_LDLIBS := $(shell $(PKG_CONFIG) --libs libpcre)
> +	PCRE_MODULE := libpcre
>  endif
> -export PCRE_CFLAGS PCRE_LDLIBS
> +PCRE_CFLAGS += $(shell $(PKG_CONFIG) --cflags $(PCRE_MODULE))
> +PCRE_LDLIBS := $(shell $(PKG_CONFIG) --libs $(PCRE_MODULE))
> +export PCRE_MODULE PCRE_CFLAGS PCRE_LDLIBS
>  
>  OS := $(shell uname)
>  export OS
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 2408faea..18df75c8 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -148,7 +148,7 @@ $(LIBSO): $(LOBJS)
>  	ln -sf $@ $(TARGET)
>  
>  $(LIBPC): $(LIBPC).in ../VERSION
> -	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):;
> s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
> +	sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):;
> s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):;
> s:@PCRE_MODULE@:$(PCRE_MODULE):' < $< > $@
>  
>  selinuxswig_python_exception.i: ../include/selinux/selinux.h
>  	bash -e exception.sh > $@ || (rm -f $@ ; false)
> diff --git a/libselinux/src/libselinux.pc.in
> b/libselinux/src/libselinux.pc.in
> index 2cd04d38..2e90a844 100644
> --- a/libselinux/src/libselinux.pc.in
> +++ b/libselinux/src/libselinux.pc.in
> @@ -7,6 +7,6 @@ Name: libselinux
>  Description: SELinux utility library
>  Version: @VERSION@
>  URL: http://userspace.selinuxproject.org/
> -Requires.private: libsepol libpcre
> +Requires.private: libsepol @PCRE_MODULE@
>  Libs: -L${libdir} -lselinux
>  Cflags: -I${includedir}
