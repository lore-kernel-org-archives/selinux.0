Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00568C433F5
	for <selinux@archiver.kernel.org>; Thu, 11 Nov 2021 22:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2F861106
	for <selinux@archiver.kernel.org>; Thu, 11 Nov 2021 22:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhKKWkY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Nov 2021 17:40:24 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:47006 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhKKWkY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Nov 2021 17:40:24 -0500
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 8F396564A39
        for <selinux@vger.kernel.org>; Thu, 11 Nov 2021 23:37:32 +0100 (CET)
Received: by mail-pj1-f50.google.com with SMTP id x7so5129335pjn.0
        for <selinux@vger.kernel.org>; Thu, 11 Nov 2021 14:37:32 -0800 (PST)
X-Gm-Message-State: AOAM530Jqh53QPfTSSbhcRa/lvKHJXZJnhJY3+hLOLZH32iB1bL5ckFs
        fNC7cYXAc3fUKWDWM8tELcwp1jCDSLM0Z8/E0Sk=
X-Google-Smtp-Source: ABdhPJwM/xSgfpQW7jC49y3ruY9Kx0FsWH1tQZzNx+/r1VBCiV7ydPVJnIJKnalHK9GWwj7CBUXO/jUolsNS56AE9uc=
X-Received: by 2002:a17:90b:e83:: with SMTP id fv3mr12318490pjb.115.1636670251191;
 Thu, 11 Nov 2021 14:37:31 -0800 (PST)
MIME-Version: 1.0
References: <20211111164229.9711-1-hi@alyssa.is>
In-Reply-To: <20211111164229.9711-1-hi@alyssa.is>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 11 Nov 2021 23:37:20 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mmv1FxAP0FY=mDZvUDhQx3f4zzB0OHP-M-P1OWx_ZJjg@mail.gmail.com>
Message-ID: <CAJfZ7=mmv1FxAP0FY=mDZvUDhQx3f4zzB0OHP-M-P1OWx_ZJjg@mail.gmail.com>
Subject: Re: [PATCH] Support static-only builds
To:     Alyssa Ross <hi@alyssa.is>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Nov 11 23:37:33 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 11, 2021 at 5:42 PM Alyssa Ross <hi@alyssa.is> wrote:
>
> Sometimes it's useful to have a static-only toolchain.  This can be
> due to targetting some weird embedded platform, or it can be because
> it ensures that no dynamic libraries are sneaking into a system that's
> supposed to be 100% static due to non-cooperative build systems.  Most
> build systems support static-only builds, e.g. autoconf provides a
> --disable-shared configure option.
>
> libselinux's custom make-based build system did not support such an
> option, so here I've added one.  Apart from the obvious changes, I had
> to make the utilities that use libpcre link against it manually,
> because that can't be inferred from the static libselinux.  For
> downstream users of libselinux using pkg-config, this shouldn't be a
> problem, because libselinux.pc already includes the Requires.private
> line that specifies libpcre should be linked against as well.
>
> Signed-off-by: Alyssa Ross <hi@alyssa.is>

Hello,

Thanks for your patch. It is interesting (as a maintainer) to see that
some SELinux users are still interested in having the static
libraries, as in the past there were messages about users who only
wanted the .so on their systems, if I remember correctly.

Your patch looks right, except for one detail (which I put inline).
Nevertheless I am wondering about how future changes will not break
your use-case and I am thinking of adding a "DISABLE_SHARED=y"
configuration to our Continuous Integration system. More precisely it
would be nice to have something similar to what is currently done to
test various build configurations in
https://github.com/SELinuxProject/selinux/blob/3.3/.github/workflows/run_tests.yml#L84-L94
. Currently when I try to test it, it fails when linking
libsemanage.so:

/usr/bin/ld: /destdir/usr/lib/libselinux.a(seusers.o): warning:
relocation against `stderr@@GLIBC_2.2.5' in read-only section `.text'
/usr/bin/ld: /destdir/usr/lib/libselinux.a(seusers.o): relocation
R_X86_64_PC32 against symbol `stderr@@GLIBC_2.2.5' can not be used
when making a shared object; recompile with -fPIC
/usr/bin/ld: final link failed: bad value

This build failure is normal, as the files in libselinux.a are not
compiled with -fPIC and cannot be integrated in libsemanage.so. Did
you also modify libsemanage (and other tools) to also use the static
libraries?

This failure also happens when linking the Python bindings (with "make
install-pywrap"). Are you using bindings to Python or Ruby in your
project?

> ---
>  libselinux/src/Makefile   | 11 ++++++++---
>  libselinux/utils/Makefile |  6 +++++-
>  libsepol/src/Makefile     | 11 ++++++++---
>  3 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 52c40f01..814012e1 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -136,7 +136,10 @@ endif
>
>  SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(DISABLE_FLAGS)
>
> -all: $(LIBA) $(LIBSO) $(LIBPC)
> +all: $(LIBA) $(LIBPC)
> +ifneq ($(DISABLE_SHARED),y)
> +all: $(LIBSO)
> +endif
>
>  pywrap: all selinuxswig_python_exception.i
>         CFLAGS="$(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup.py build_ext
> @@ -175,11 +178,13 @@ $(SWIGRUBYCOUT): $(SWIGRUBYIF)
>  install: all
>         test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBDIR)
>         install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
> -       test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SHLIBDIR)
> -       install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
>         test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d $(DESTDIR)$(LIBDIR)/pkgconfig
>         install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
> +ifneq ($(DISABLE_SHARED),y)
> +       test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SHLIBDIR)
> +       install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
>         ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
> +endif
>
>  install-pywrap: pywrap
>         $(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS)
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index 36816155..12d028df 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -52,7 +52,11 @@ else
>  TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
>  endif
>
> -sefcontext_compile: LDLIBS += ../src/libselinux.a $(PCRE_LDLIBS) -lsepol
> +PCRE_USERS = matchpathcon sefcontext_compile selabel_digest \
> +       selabel_get_digests_all_partial_matches selabel_lookup \
> +       selabel_lookup_best_match selabel_partial_match
> +$(PCRE_USERS): LDLIBS += $(PCRE_LDLIBS)
> +sefcontext_compile: LDLIBS += ../src/libselinux.a -lsepol

This makes our CI complain because -lpcre needs to be put after
libselinux.a when linking sefcontext_compile. Here the linker
complains with these messages
(https://github.com/fishilico/selinux/runs/4183433352?check_suite_focus=true#step:9:401):

/usr/bin/ld: /tmp/destdir/usr/lib/libselinux.so: undefined reference
to symbol 'pcre_fullinfo'
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/9/../../../x86_64-linux-gnu/libpcre.so:
error adding symbols: DSO missing from command line
collect2: error: ld returned 1 exit status
make[2]: *** [<builtin>: sefcontext_compile] Error 1

When I put the "sefcontext_compile:..." before the new
"$(PCRE_USERS):..." line, this issue is fixed. Could you send a new
version with this change?

Thanks,
Nicolas

>  all: $(TARGETS)
>
> diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> index dc8b1773..a3623635 100644
> --- a/libsepol/src/Makefile
> +++ b/libsepol/src/Makefile
> @@ -39,7 +39,10 @@ LDFLAGS += -undefined dynamic_lookup
>  LN=gln
>  endif
>
> -all: $(LIBA) $(LIBSO) $(LIBPC)
> +all: $(LIBA) $(LIBPC)
> +ifneq ($(DISABLE_SHARED),y)
> +all: $(LIBSO)
> +endif
>
>
>  $(LIBA):  $(OBJS)
> @@ -81,11 +84,13 @@ endif
>  install: all
>         test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBDIR)
>         install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
> -       test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SHLIBDIR)
> -       install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
>         test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d $(DESTDIR)$(LIBDIR)/pkgconfig
>         install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
> +ifneq ($(DISABLE_SHARED),y)
> +       test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SHLIBDIR)
> +       install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
>         $(LN) -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
> +endif
>
>  relabel:
>         /sbin/restorecon $(DESTDIR)$(SHLIBDIR)/$(LIBSO)
> --
> 2.33.0
>

