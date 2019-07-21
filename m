Return-Path: <SRS0=0060=VS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EF7C76191
	for <selinux@archiver.kernel.org>; Sun, 21 Jul 2019 22:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DB92083B
	for <selinux@archiver.kernel.org>; Sun, 21 Jul 2019 22:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfGUWxp convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Sun, 21 Jul 2019 18:53:45 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:52826 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfGUWxp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 21 Jul 2019 18:53:45 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 5917F561259
        for <selinux@vger.kernel.org>; Mon, 22 Jul 2019 00:53:41 +0200 (CEST)
Received: by mail-ot1-f46.google.com with SMTP id x21so38231685otq.12
        for <selinux@vger.kernel.org>; Sun, 21 Jul 2019 15:53:41 -0700 (PDT)
X-Gm-Message-State: APjAAAWhENZgN+MejWitMm7tB5NEvr5txTy/g8PGIRWkFv4HYXujb4TC
        gd/QCfahyJn1tmsKLgDFSke9HJh6HImXE4xOjB0=
X-Google-Smtp-Source: APXvYqzfVf+XEaHr9sOGjznugu+Q96Pv421CuoqLVXfNYIXWsP43TE+Y4VvTIlfc6RPdlniKQhNeSZSwDJ1e+mS57y4=
X-Received: by 2002:a9d:744a:: with SMTP id p10mr43734732otk.321.1563749620439;
 Sun, 21 Jul 2019 15:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <pjd4l3mezyk.fsf@redhat.com> <20190717111014.25650-1-plautrba@redhat.com>
In-Reply-To: <20190717111014.25650-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 22 Jul 2019 00:53:29 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=njQ0KbUofrjyC7GLf4kCbg804UFyU=mgPQxQMZumsa1Q@mail.gmail.com>
Message-ID: <CAJfZ7=njQ0KbUofrjyC7GLf4kCbg804UFyU=mgPQxQMZumsa1Q@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Use Python distutils to install SELinux
 python bindings
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Jul 22 00:53:41 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 17, 2019 at 1:10 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Follow officially documented way how to build C extension modules using
> distutils - https://docs.python.org/3.8/extending/building.html#building
>
> Fixes:
>
> - selinux python module fails to load when it's built using SWIG-4.0:
>
> >>> import selinux
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
>   File "/usr/lib64/python3.7/site-packages/selinux/__init__.py", line 13, in <module>
>     from . import _selinux
> ImportError: cannot import name '_selinux' from 'selinux' (/usr/lib64/python3.7/site-packages/selinux/__init__.py)
>
> SWIG-4.0 changed (again?) its behavior so that it uses: from . import _selinux
> which looks for _selinux module in the same directory as where __init__.py is -
> $(PYLIBDIR)/site-packages/selinux. But _selinux module is installed into
> $(PYLIBDIR)/site-packages/ since a9604c30a5e2f ("libselinux: Change the location
> of _selinux.so").
>
> - audit2why python module fails to build with Python 3.8
>
> cc -O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -DOVERRIDE_GETTID=0 -I../include -D_GNU_SOURCE -DDISABLE_RPM -DNO_ANDROID_BACKEND -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8  -Wl,-z,relro -Wl,--as-needed  -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -L. -shared -o python-3.8audit2why.so python-3.8audit2why.lo -lselinux -l:libsepol.a  -Wl,-soname,audit2why.so,--version-script=audit2why.map,-z,defs
> /usr/bin/ld: python-3.8audit2why.lo: in function `finish':
> /builddir/build/BUILD/libselinux-2.9/src/audit2why.c:166: undefined reference to `PyArg_ParseTuple'
> /usr/bin/ld: python-3.8audit2why.lo: in function `_Py_INCREF':
> /usr/include/python3.8/object.h:449: undefined reference to `_Py_NoneStruct'
> /usr/bin/ld: /usr/include/python3.8/object.h:449: undefined reference to `_Py_NoneStruct'
> /usr/bin/ld: python-3.8audit2why.lo: in function `check_booleans':
> /builddir/build/BUILD/libselinux-2.9/src/audit2why.c:84: undefined reference to `PyExc_RuntimeError'
> ...
>
> It's related to the following Python change
> https://docs.python.org/dev/whatsnew/3.8.html#debug-build-uses-the-same-abi-as-release-build
>
> Python distutils adds correct link options automatically.
>
> - selinux python module doesn't provide any Python metadata
>
> When selinux python module was built manually, it didn't provide any metadata.
> distutils takes care about that so that selinux Python module is visible for
> pip:
>
> $ pip3 list | grep selinux
> selinux              2.9
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  libselinux/src/.gitignore |  2 +-
>  libselinux/src/Makefile   | 36 ++++++++----------------------------
>  libselinux/src/setup.py   | 24 ++++++++++++++++++++++++
>  3 files changed, 33 insertions(+), 29 deletions(-)
>  create mode 100644 libselinux/src/setup.py
>
> diff --git a/libselinux/src/.gitignore b/libselinux/src/.gitignore
> index 4dcc3b3b..428afe5a 100644
> --- a/libselinux/src/.gitignore
> +++ b/libselinux/src/.gitignore
> @@ -1,4 +1,4 @@
>  selinux.py
> -selinuxswig_wrap.c
> +selinuxswig_python_wrap.c
>  selinuxswig_python_exception.i
>  selinuxswig_ruby_wrap.c
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index e9ed0383..d074548b 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -36,7 +36,7 @@ TARGET=libselinux.so
>  LIBPC=libselinux.pc
>  SWIGIF= selinuxswig_python.i selinuxswig_python_exception.i
>  SWIGRUBYIF= selinuxswig_ruby.i
> -SWIGCOUT= selinuxswig_wrap.c
> +SWIGCOUT= selinuxswig_python_wrap.c
>  SWIGPYOUT= selinux.py
>  SWIGRUBYCOUT= selinuxswig_ruby_wrap.c
>  SWIGLOBJ:= $(patsubst %.c,$(PYPREFIX)%.lo,$(SWIGCOUT))
> @@ -55,7 +55,7 @@ ifeq ($(LIBSEPOLA),)
>          LDLIBS_LIBSEPOLA := -l:libsepol.a
>  endif
>
> -GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) selinuxswig_python_exception.i
> +GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) $(SWIGCOUT) selinuxswig_python_exception.i
>  SRCS= $(filter-out $(GENERATED) audit2why.c, $(sort $(wildcard *.c)))
>
>  MAX_STACK_SIZE=32768
> @@ -125,25 +125,18 @@ DISABLE_FLAGS+= -DNO_ANDROID_BACKEND
>  SRCS:= $(filter-out label_backends_android.c, $(SRCS))
>  endif
>
> -SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./ $(DISABLE_FLAGS)
> -
>  SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(DISABLE_FLAGS)
>
>  all: $(LIBA) $(LIBSO) $(LIBPC)
>
> -pywrap: all $(SWIGFILES) $(AUDIT2WHYSO)
> +pywrap: all selinuxswig_python_exception.i
> +       CFLAGS="$(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup.py build_ext -I $(DESTDIR)$(INCLUDEDIR) -L $(DESTDIR)$(LIBDIR)
>
>  rubywrap: all $(SWIGRUBYSO)
>
> -$(SWIGLOBJ): $(SWIGCOUT)
> -       $(CC) $(CFLAGS) $(SWIG_CFLAGS) $(PYINC) -fPIC -DSHARED -c -o $@ $<
> -
>  $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
>         $(CC) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
>
> -$(SWIGSO): $(SWIGLOBJ)
> -       $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $< -lselinux $(PYLIBS)
> -
>  $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
>         $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(RUBYLIBS)
>
> @@ -161,29 +154,15 @@ $(LIBPC): $(LIBPC).in ../VERSION
>  selinuxswig_python_exception.i: ../include/selinux/selinux.h
>         bash -e exception.sh > $@ || (rm -f $@ ; false)
>
> -$(AUDIT2WHYLOBJ): audit2why.c
> -       $(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
> -
> -$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
> -       $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(LDLIBS_LIBSEPOLA) $(PYLIBS) -Wl,-soname,audit2why.so,--version-script=audit2why.map,-z,defs
> -
>  %.o:  %.c policy.h
>         $(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
>
>  %.lo:  %.c policy.h
>         $(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
>
> -$(SWIGCOUT): $(SWIGIF)
> -       $(SWIG) $<
> -
> -$(SWIGPYOUT): $(SWIGCOUT)
> -
>  $(SWIGRUBYCOUT): $(SWIGRUBYIF)
>         $(SWIGRUBY) $<
>
> -swigify: $(SWIGIF)
> -       $(SWIG) $<
> -
>  install: all
>         test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBDIR)
>         install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
> @@ -194,10 +173,9 @@ install: all
>         ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
>
>  install-pywrap: pywrap
> -       test -d $(DESTDIR)$(PYTHONLIBDIR)/selinux || install -m 755 -d $(DESTDIR)$(PYTHONLIBDIR)/selinux
> -       install -m 755 $(SWIGSO) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
> -       install -m 755 $(AUDIT2WHYSO) $(DESTDIR)$(PYTHONLIBDIR)/selinux/audit2why$(PYCEXT)
> +       $(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)`
>         install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
> +       ln -sf $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)

Hello,
Using $(DESTDIR) in a symlink target does not work when building
packages. For example if I build a package with
"BUILDDIR=/tmp/builddir" and
"PYTHONLIBDIR=/usr/lib/python3.7/site-packages", and then install the
package on a system,
/usr/lib/python3.7/site-packages/_selinux.cpython-37m-x86_64-linux-gnu.so
will be a symlink to /tmp/builddir/usr/python3.7/...
This can be prevented by either using "ln -sf --relative" (like other
places in the Makefile) or by using a relative target directly, such
as:

    ln -sf selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)

Otherwise, your patch looks good to me. If you want to directly merge
the patch once the issue is fixed: Acked-by: Nicolas Iooss
<nicolas.iooss@m4x.org>

Thanks,
Nicolas

