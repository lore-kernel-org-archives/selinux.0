Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o74IWPJ5021426
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2010 14:32:25 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o74IWKwB022998
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2010 18:32:20 GMT
Date: Wed, 04 Aug 2010 14:32:23 -0400
Subject: Re: Patch for python3 for libselinux
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Message-ID: <C87F2A77.BA088%csellers@tresys.com>
In-Reply-To: <4C4F2EFB.9080102@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 7/27/10 3:09 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Resending patch I sent a month ago.  Can we get this upstream?
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.14 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
> 
> iEYEARECAAYFAkxPLvoACgkQrlYvE4MpobNUxACgkr0+50GNbDPFmzWQp/vEgchY
> Hd0AoOU1rrSg2uH/yBRUF+ujoIJOVq2+
> =Dopt
> -----END PGP SIGNATURE-----
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index bf665ab..8aeb7a1 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -1,9 +1,10 @@
>  # Installation directories.
> +PYTHON ?= python
>  PREFIX ?= $(DESTDIR)/usr
>  LIBDIR ?= $(PREFIX)/lib
>  SHLIBDIR ?= $(DESTDIR)/lib
>  INCLUDEDIR ?= $(PREFIX)/include
> -PYLIBVER ?= $(shell python -c 'import sys;print "python%d.%d" %
> sys.version_info[0:2]')
> +PYLIBVER ?= $(shell $(PYTHON) -c 'import sys;print("python%d.%d" %
> sys.version_info[0:2])')
>  PYINC ?= /usr/include/$(PYLIBVER)
>  PYLIB ?= /usr/lib/$(PYLIBVER)
>  PYTHONLIBDIR ?= $(LIBDIR)/$(PYLIBVER)
> @@ -23,13 +24,13 @@ SWIGIF= selinuxswig_python.i
> selinuxswig_python_exception.i
>  SWIGRUBYIF= selinuxswig_ruby.i
>  SWIGCOUT= selinuxswig_wrap.c
>  SWIGRUBYCOUT= selinuxswig_ruby_wrap.c
> -SWIGLOBJ:= $(patsubst %.c,%.lo,$(SWIGCOUT))
> +SWIGLOBJ:= $(patsubst %.c,$(PYPREFIX)%.lo,$(SWIGCOUT))

I don't see PYPREFIX defined anywhere. Is this something that you're
defining in the spec file?

>  SWIGRUBYLOBJ:= $(patsubst %.c,%.lo,$(SWIGRUBYCOUT))
> -SWIGSO=_selinux.so
> +SWIGSO=$(PYPREFIX)_selinux.so
>  SWIGFILES=$(SWIGSO) selinux.py selinuxswig_python_exception.i
>  SWIGRUBYSO=_rubyselinux.so
>  LIBSO=$(TARGET).$(LIBVERSION)
> -AUDIT2WHYSO=audit2why.so
> +AUDIT2WHYSO=$(PYPREFIX)audit2why.so
>  
>  ifeq ($(DISABLE_AVC),y)
>      UNUSED_SRCS+=avc.c avc_internal.c avc_sidtab.c mapping.c stringrep.c
> checkAccess.c
> @@ -91,10 +92,10 @@ $(LIBPC): $(LIBPC).in
>  selinuxswig_python_exception.i: ../include/selinux/selinux.h
>      bash exception.sh > $@
>  
> -audit2why.lo: audit2why.c
> +$(PYPREFIX)audit2why.lo: audit2why.c
>      $(CC) $(CFLAGS) -I$(PYINC) -fPIC -DSHARED -c -o $@ $<
>  
> -$(AUDIT2WHYSO): audit2why.lo
> +$(AUDIT2WHYSO): $(PYPREFIX)audit2why.lo
>      $(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L. -lselinux
> ${LIBDIR}/libsepol.a -L$(LIBDIR) -Wl,-soname,$@
>  
>  %.o:  %.c policy.h
> @@ -123,8 +124,8 @@ install: all
>  
>  install-pywrap: pywrap
>      test -d $(PYTHONLIBDIR)/site-packages/selinux || install -m 755 -d
> $(PYTHONLIBDIR)/site-packages/selinux
> -    install -m 755 $(SWIGSO) $(PYTHONLIBDIR)/site-packages/selinux
> -    install -m 755 $(AUDIT2WHYSO) $(PYTHONLIBDIR)/site-packages/selinux
> +    install -m 755 $(SWIGSO)
> $(PYTHONLIBDIR)/site-packages/selinux/_selinux.so

I'm still not sure why PYPREFIX has been added, but assuming it should be
shouldn't this be /$(PYPREFIX)_selinux.so, or better yet /$(SWIGSO)

> +    install -m 755 $(AUDIT2WHYSO)
> $(PYTHONLIBDIR)/site-packages/selinux/audit2why.so

and this should be $(AUDIT2WHYSO) instead of audit2why.so.


The bigger problem is that it doesn't seem to build for me. Applying the
patch (and fixing the Makefile with the below patch, as it doesn't look like
it will currently build the python wrapper), I get this:

make PYTHON=python3 pywrap
...
cc -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn
-Wmissing-format-attribute -I../include -I/usr/include -D_GNU_SOURCE
-D_FILE_OFFSET_BITS=64  -I/usr/include/python3.1 -fPIC -DSHARED -c -o
audit2why.lo audit2why.c
cc1: warnings being treated as errors
audit2why.c:439: error: missing initializer
audit2why.c:439: error: (near initialization for Œmoduledef.m_base.m_init¹)
make: *** [audit2why.lo] Error 1


Thanks,
Chad

Makefile patch to make pywrap build:

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index bf665ab..baf4a6c 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -104,7 +104,7 @@ $(AUDIT2WHYSO): audit2why.lo
        $(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
 
 $(SWIGCOUT): $(SWIGIF)
-       $(SWIG) $^
+       $(SWIG) $<
 
 $(SWIGRUBYCOUT): $(SWIGRUBYIF)
        $(SWIGRUBY) $^



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
