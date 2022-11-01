Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374BBC433FE
	for <selinux@archiver.kernel.org>; Tue,  1 Nov 2022 12:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiKAMIl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Nov 2022 08:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiKAMIh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Nov 2022 08:08:37 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1E46311
        for <selinux@vger.kernel.org>; Tue,  1 Nov 2022 05:08:35 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id s9so7663782ilu.1
        for <selinux@vger.kernel.org>; Tue, 01 Nov 2022 05:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AF8nKIXl8zd9hfxLbHpHtiMK8og6zkZi/1pGrwACnFM=;
        b=qXfdOypHxRKTrdQ243OS5i7K5VQaN+6VWej9VqFOqOkCWf55ztWIPWmrFn3eBC3tsJ
         La5NaqVZO3M+gQxmVBoiIPU42VCD9or2QshPtB0Sv2diKUDa4Pn3kz3yhtCnx2hOwdz3
         U4ypzMP7I30P4GFJTJZThYZRAdNvbjSaGhsGC2NuuXn6yxfrYPAjdulKy8zzcgqPHAc4
         JtlFusOkG7FKVr06SyY2DSVVDLTpaIZ6nncFW0qfuofzzgVbYBLCIntyIKS8TR2yZYzs
         MerDGYY0raQWEsQjg0Tq01qhnL0WhMVnuny8FGFUp8E+Ua0nTzkGiJ0oHhgb65gUpk9L
         8pZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AF8nKIXl8zd9hfxLbHpHtiMK8og6zkZi/1pGrwACnFM=;
        b=8Lp2jQVaDmECuMpjVticEfNwpP3nHQQTaGW3DYusxU/959ptkIykR7cLbwU9jd8g+7
         BH9lMavJTH+azZC0vKeBa3ZKc9O+KnpWdnNjZAjNIHlr9D+WBhsBfB6VvjisC9g95Ca+
         zB/eZRVW7/TPDw9kpib/8FMAvm7qTjNLCyCHibtO50g4eVyIPjMpOysWIryx+Wiaw/5R
         bn8Xdvn50kQbIlKpqgeBmTwKZPd2n8DFVCbFcnq/I/jrGdMzPKjuzReXTD/JiET/xoDP
         RcEvz5qCkfNMX7LZC6AufTor+lvtftBPu5kPTYaGvjaxab8zI5yjf8b3Idr8p3hRwEVx
         IiUw==
X-Gm-Message-State: ACrzQf2ptO8g4YpRDiaByyGECva7ogPyvhoYH6Z+gvWwu2x4cZ+30uy8
        I9ZsCP565XZlXOZLHAYQKdWdJVvrRfaYQbk/0IKL2qYs
X-Google-Smtp-Source: AMsMyM4DBJYYrmD52fy2HV6ikuS+SDAT69VsVe5VExTxNlgkxPEFm8tg2Uvl1y2mmkG7PsGfyP54BWEwG/hpWktwwjY=
X-Received: by 2002:a92:ce0e:0:b0:300:9dad:3104 with SMTP id
 b14-20020a92ce0e000000b003009dad3104mr9263763ilo.174.1667304515268; Tue, 01
 Nov 2022 05:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221028203852.526472-1-jwcart2@gmail.com> <20221028203852.526472-4-jwcart2@gmail.com>
 <87v8nzrqwp.fsf@redhat.com>
In-Reply-To: <87v8nzrqwp.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 1 Nov 2022 08:08:24 -0400
Message-ID: <CAP+JOzRWEMnqFSyEfqb76q9HysyURv8FCJv7wKd4u9WWBH7M-w@mail.gmail.com>
Subject: Re: [PATCH 3/5] python: Remove dependency on the Python module distutils
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 1, 2022 at 5:00 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > The distutils package is deprecated and scheduled to be removed in
> > Python 3.12. Use the setuptools and sysconfig modules instead.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  python/semanage/Makefile              | 2 +-
> >  python/sepolgen/src/sepolgen/Makefile | 2 +-
> >  python/sepolicy/sepolicy/gui.py       | 2 +-
> >  python/sepolicy/setup.py              | 2 +-
> >  4 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/python/semanage/Makefile b/python/semanage/Makefile
> > index 024e9640..b1f1bd3a 100644
> > --- a/python/semanage/Makefile
> > +++ b/python/semanage/Makefile
> > @@ -5,7 +5,7 @@ LINGUAS ?= ru
> >  PREFIX ?= /usr
> >  SBINDIR ?= $(PREFIX)/sbin
> >  MANDIR = $(PREFIX)/share/man
> > -PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(prefix='$(PREFIX)'))")
> > +PYTHONLIBDIR ?= $(shell $(PYTHON) -c "import sysconfig; print(sysconfig.get_path('platlib', vars={'platbase': '$(PREFIX)', 'base': '$(PREFIX)'}))")
>
> $ python3 -c "from distutils.sysconfig import *; print(get_python_lib(prefix='/usr'))"
> /usr/lib/python3.10/site-packages
>
> vs
>
> $ python3 -c "import sysconfig; print(sysconfig.get_path('platlib', vars={'platbase': '/usr', 'base': '/usr'}))"
> /usr/lib64/python3.10/site-packages
>
> Given that python/ is not platform specific this should use 'purelib' -
> https://docs.python.org/3/library/sysconfig.html#installation-paths
>
> $ python3 -c "import sysconfig; print(sysconfig.get_path('purelib', vars={'platbase': '/usr', 'base': '/usr'}))"
> /usr/lib/python3.10/site-packages
>
>

Thanks. That was one of the things I was not sure about. I will change that.
Jim

>
>
> >  PACKAGEDIR ?= $(PYTHONLIBDIR)
> >  BASHCOMPLETIONDIR ?= $(PREFIX)/share/bash-completion/completions
> >
> > diff --git a/python/sepolgen/src/sepolgen/Makefile b/python/sepolgen/src/sepolgen/Makefile
> > index cac8def7..9578af23 100644
> > --- a/python/sepolgen/src/sepolgen/Makefile
> > +++ b/python/sepolgen/src/sepolgen/Makefile
> > @@ -1,6 +1,6 @@
> >  PREFIX ?= /usr
> >  PYTHON ?= python3
> > -PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(prefix='$(PREFIX)'))")
> > +PYTHONLIBDIR ?= $(shell $(PYTHON) -c "import sysconfig; print(sysconfig.get_path('platlib', vars={'platbase': '$(PREFIX)', 'base': '$(PREFIX)'}))")
> >  PACKAGEDIR ?= /$(PYTHONLIBDIR)/sepolgen
> >
> >  all:
> > diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
> > index 5bdbfeba..63f2371f 100644
> > --- a/python/sepolicy/sepolicy/gui.py
> > +++ b/python/sepolicy/sepolicy/gui.py
> > @@ -77,7 +77,7 @@ def cmp(a, b):
> >          return 1
> >      return (a > b) - (a < b)
> >
> > -import distutils.sysconfig
> > +import sysconfig
> >  ADVANCED_LABEL = (_("Advanced >>"), _("Advanced <<"))
> >  ADVANCED_SEARCH_LABEL = (_("Advanced Search >>"), _("Advanced Search <<"))
> >  OUTBOUND_PAGE = 0
> > diff --git a/python/sepolicy/setup.py b/python/sepolicy/setup.py
> > index b0f9650d..c8220664 100644
> > --- a/python/sepolicy/setup.py
> > +++ b/python/sepolicy/setup.py
> > @@ -2,7 +2,7 @@
> >
> >  # Author: Thomas Liu <tliu@redhat.com>
> >  # Author: Dan Walsh <dwalsh@redhat.com>
> > -from distutils.core import setup
> > +from setuptools import setup
> >
> >  setup(
> >      name="sepolicy",
> > --
> > 2.37.3
>
