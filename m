Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB95C2BB55
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 17:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82CC8207FC
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 17:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgDPRMS convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:12:18 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:57547 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgDPRMR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 13:12:17 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 5780956122E
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 19:12:14 +0200 (CEST)
Received: by mail-oi1-f174.google.com with SMTP id r66so3037132oie.5
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 10:12:14 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ6NSnorzMAig4VyI6pHY6rzIJx4ulQpwwWvxTLDI3OLbqOtG6s
        VObI55s7Hrvnm4EhNXwqQScS7Iuh/A9o9aKO5Bk=
X-Google-Smtp-Source: APiQypIxWjVIDZCK8opOoHW1IW6kF/ntUQCcUqH3C3XOhjkhpAjt3KSI6DnqbL7UgSdVwMsmokOC/NBmRbzc05DIV3Y=
X-Received: by 2002:aca:57d6:: with SMTP id l205mr3464662oib.20.1587057133275;
 Thu, 16 Apr 2020 10:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200407115849.41225-1-cgzones@googlemail.com>
 <20200414100606.14601-1-cgzones@googlemail.com> <CAJfZ7==zGCfimy_JZqNERoZATZvk5SxdcLbw3u6psta4F5q1BQ@mail.gmail.com>
In-Reply-To: <CAJfZ7==zGCfimy_JZqNERoZATZvk5SxdcLbw3u6psta4F5q1BQ@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 16 Apr 2020 19:12:01 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==6koBgJ0muvuP_RFPhs=vTPUVcCN+tp20Y8QfYv3U-MA@mail.gmail.com>
Message-ID: <CAJfZ7==6koBgJ0muvuP_RFPhs=vTPUVcCN+tp20Y8QfYv3U-MA@mail.gmail.com>
Subject: Re: [PATCH v2] tree-wide: use python module importlib instead of the
 deprecated imp
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Apr 16 19:12:14 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 14, 2020 at 10:43 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Tue, Apr 14, 2020 at 12:06 PM Christian Göttsche
> <cgzones@googlemail.com> wrote:
> >
> > Replace
> >
> > python3 -c 'import imp;print([s for s,m,t in imp.get_suffixes() if t == imp.C_EXTENSION][0])'
> > <string>:1: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
> > .cpython-38-x86_64-linux-gnu.so
> >
> > with
> >
> > python3 -c 'import importlib.machinery;print(importlib.machinery.EXTENSION_SUFFIXES[0])'
> > .cpython-38-x86_64-linux-gnu.so
> >
> > Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> > ---
> > v2: use 'import importlib.machinery;' for python 3.5 compatibility
> >     thanks to Nicolas Iooss
> >
> >  libselinux/src/Makefile  | 2 +-
> >  libsemanage/src/Makefile | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index 2d1c654e..9992221f 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -15,7 +15,7 @@ INCLUDEDIR ?= $(PREFIX)/include
> >  PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
> >  PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
> >  PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
> > -PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.get_suffixes() if t == imp.C_EXTENSION][0])')
> > +PYCEXT ?= $(shell $(PYTHON) -c 'import importlib.machinery;print(importlib.machinery.EXTENSION_SUFFIXES[0])')
> >  RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
> >  RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
> >  RUBYINSTALL ?= $(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
> > diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> > index 606ce1c6..a0eb3747 100644
> > --- a/libsemanage/src/Makefile
> > +++ b/libsemanage/src/Makefile
> > @@ -14,7 +14,7 @@ INCLUDEDIR ?= $(PREFIX)/include
> >  PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
> >  PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
> >  PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
> > -PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.get_suffixes() if t == imp.C_EXTENSION][0])')
> > +PYCEXT ?= $(shell $(PYTHON) -c 'import importlib.machinery;print(importlib.machinery.EXTENSION_SUFFIXES[0])')
> >  RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
> >  RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
> >  RUBYINSTALL ?= $(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
> > --
> > 2.26.0
> >
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> I will merge this tomorrow if nobody complains.

Merged.
Nicolas

