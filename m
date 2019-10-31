Return-Path: <SRS0=943q=YY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1394ACA9ECB
	for <selinux@archiver.kernel.org>; Thu, 31 Oct 2019 17:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D6D208C0
	for <selinux@archiver.kernel.org>; Thu, 31 Oct 2019 17:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfJaRki (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Oct 2019 13:40:38 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:43872 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfJaRkh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Oct 2019 13:40:37 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 4F2FD5606A9
        for <selinux@vger.kernel.org>; Thu, 31 Oct 2019 18:40:33 +0100 (CET)
Received: by mail-ot1-f42.google.com with SMTP id d8so6111105otc.7
        for <selinux@vger.kernel.org>; Thu, 31 Oct 2019 10:40:33 -0700 (PDT)
X-Gm-Message-State: APjAAAWrV65/EradTf0EULyv8wKbn1FTOnPTPO++ERvGIQa3qQH64PNi
        Jh1omeDyS9i8uSQtjmxaA79MuxuFP5D7jXSLa20=
X-Google-Smtp-Source: APXvYqzSTkJb05t+HazGCeamSO0jwsgm5L4RvcKW3e2H3RCiMqYt0Z0EQkh+dDE9acESHsp2TUaxFrqx86zpXBPPoMs=
X-Received: by 2002:a05:6830:1587:: with SMTP id i7mr5516135otr.321.1572543632267;
 Thu, 31 Oct 2019 10:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191025134304.12666-1-thomas.petazzoni@bootlin.com> <20191025134304.12666-2-thomas.petazzoni@bootlin.com>
In-Reply-To: <20191025134304.12666-2-thomas.petazzoni@bootlin.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 31 Oct 2019 18:40:21 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=koMBuaskafoDn2JR18a_FDLCZ3DGjKZZVRkwXRdDmyAg@mail.gmail.com>
Message-ID: <CAJfZ7=koMBuaskafoDn2JR18a_FDLCZ3DGjKZZVRkwXRdDmyAg@mail.gmail.com>
Subject: Re: [PATCH libselinux 2/2] libselinux/src/Makefile: do not use
 PYCEXT, and rely on the installed file name
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Oct 31 18:40:33 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 25, 2019 at 3:43 PM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:
>
> PYCEXT is computed by asking the Python intrepreter what is the
> file extension used for native Python modules.
>
> Unfortunately, when cross-compiling, the host Python doesn't give the
> proper result: it gives the result matching the build machine, and not
> the target machine. Due to this, the symlink has an incorrect name,
> and doesn't point to the .so file that was actually built/installed.
>
> To address this and keep things simple, this patch just changes the ln
> invocation to rely on the name of the _selinux*.so Python module that
> was installed.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Hi,
Thanks for your patch. At first, I did not like forcing the extension
to ".so", because other operating systems use different extensions,
but in fact this point is not really an issue because libselinux and
libsemanage are very specific to Linux (contrary to libsepol, that may
be compiled for MacOS for example in order to analyze a policy there).

Anyway, I do not like using a wildcard pattern in the Makefile to
match the produced file. I wanted to reproduce your issue by
cross-compiling the python extension with "make
CC=aarch64-linux-gnu-gcc DESTDIR=/tmp/selinux install-pywrap", but
this fails with the following messages:

creating build
creating build/temp.linux-x86_64-3.7
aarch64-linux-gnu-gcc -Wno-unused-result -Wsign-compare -DNDEBUG -g
-fwrapv -O3 -Wall -march=x86-64 -mtune=generic -O3 -pipe -fno-plt
-march=x86-64 -mtune=generic -O3 -pipe -fno-plt -march=x86-64
-mtune=generic -O3 -pipe -fno-plt -O2 -Werror -Wall -Wextra
-Wmissing-format-attribute -Wmissing-noreturn -Wpointer-arith -Wshadow
-Wstrict-prototypes -Wundef -Wunused -Wwrite-strings -Wformat=2
-Wno-padded -Wno-cast-align -Wno-cast-qual -Wno-conversion
-Wno-missing-prototypes -Wno-packed -Wno-switch-enum
-Wno-variadic-macros -Wno-vla -ftrapv -Wno-clobbered
-Wno-maybe-uninitialized -Wno-uninitialized -Wno-unused-result
-I/tmp/selinux/usr/include -I../include -D_GNU_SOURCE
-DNO_ANDROID_BACKEND -Wno-shadow -Wno-cast-function-type
-Wno-stringop-truncation -fPIC -I../include -I/tmp/selinux/usr/include
-I/usr/include/python3.7m -c selinuxswig_python_wrap.c -o
build/temp.linux-x86_64-3.7/selinuxswig_python_wrap.o
Assembler messages:
Error: unknown architecture `x86-64'

I am not used to cross-compile native Python extensions so I might
miss something obvious. What tools/configuration are you using in
order to make setup.py cross-compile correctly? It would be great if
the configuration you are using allows getting the produced file
extension. And this information would also help creating a
configuration for Travis-CI in order to check whether
cross-compilation works.

Thanks,
Nicolas

> ---
>  libselinux/src/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index dc675a49..3fc535d4 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -15,7 +15,6 @@ INCLUDEDIR ?= $(PREFIX)/include
>  PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
>  PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
>  PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
> -PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.get_suffixes() if t == imp.C_EXTENSION][0])')
>  RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
>  RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
>  RUBYINSTALL ?= $(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
> @@ -175,7 +174,7 @@ install: all
>  install-pywrap: pywrap
>         $(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)`
>         install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
> -       cd $(DESTDIR)$(PYTHONLIBDIR) && ln -sf selinux/_selinux$(PYCEXT) _selinux$(PYCEXT)
> +       cd $(DESTDIR)$(PYTHONLIBDIR) && ln -sf selinux/_selinux*.so .
>
>  install-rubywrap: rubywrap
>         test -d $(DESTDIR)$(RUBYINSTALL) || install -m 755 -d $(DESTDIR)$(RUBYINSTALL)
> --
> 2.21.0
>

