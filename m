Return-Path: <SRS0=8S61=Y2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F64CA9EC7
	for <selinux@archiver.kernel.org>; Sat,  2 Nov 2019 17:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8704821897
	for <selinux@archiver.kernel.org>; Sat,  2 Nov 2019 17:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfKBRXa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 2 Nov 2019 13:23:30 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:57550 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfKBRXa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 2 Nov 2019 13:23:30 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3AC5E5646FE
        for <selinux@vger.kernel.org>; Sat,  2 Nov 2019 18:23:27 +0100 (CET)
Received: by mail-ot1-f54.google.com with SMTP id b16so11041877otk.9
        for <selinux@vger.kernel.org>; Sat, 02 Nov 2019 10:23:27 -0700 (PDT)
X-Gm-Message-State: APjAAAXskig8Plzx2b3EXul8HXVKHyPTZVp5nVqOp86G/l7/rCqc4aY5
        kBj4WVMnz/66T317JE9dRlMmForwHJz3h/r8R8E=
X-Google-Smtp-Source: APXvYqzQaSqZcFgREa5raCWVXU5z9dGGHWRFb9ChcmF+W+7LVzZd0Cls6dlFKP0pEBMD+WVQoQRVzJIUgYHHLEah0HU=
X-Received: by 2002:a05:6830:1587:: with SMTP id i7mr13545194otr.321.1572715406145;
 Sat, 02 Nov 2019 10:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191025134149.12518-1-thomas.petazzoni@bootlin.com> <CAJfZ7==Y0vw1nXR=qH-SETcwMyaF08L0ygputGFp1AAKV+opTw@mail.gmail.com>
In-Reply-To: <CAJfZ7==Y0vw1nXR=qH-SETcwMyaF08L0ygputGFp1AAKV+opTw@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 2 Nov 2019 18:23:15 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kQ42uknUJL3NX7LyLcpYSX-bR47ndE+puqpgtRKL1ggw@mail.gmail.com>
Message-ID: <CAJfZ7=kQ42uknUJL3NX7LyLcpYSX-bR47ndE+puqpgtRKL1ggw@mail.gmail.com>
Subject: Re: [PATCH libselinux] libselinux/src/Makefile: don't pass bogus -I
 and -L to python setup.py build_ext
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Nov  2 18:23:27 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 1, 2019 at 10:22 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Fri, Oct 25, 2019 at 3:42 PM Thomas Petazzoni
> <thomas.petazzoni@bootlin.com> wrote:
> >
> > Using $(DESTDIR) during the build does not follow the normal/standard
> > semantic of DESTDIR: it is normally only needed during the
> > installation. Therefore, a lot of build systems/environments don't
> > pass any DESTDIR at build time, which causes setup.py to be called
> > with -I /usr/include -L /usr/lib, which breaks cross-compilation.
> >
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>
> This patch looks good to me. It does not seem to break the build
> configurations that I am using and fixes a real issue. If nobody
> complains, I will merge it (without the 2 other patches) tomorrow.
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Thanks!

Applied.
Nicolas

> > ---
> >  libselinux/src/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index 2b1696a0..3b8bad81 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -130,7 +130,7 @@ SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(DISABLE_FLAGS)
> >  all: $(LIBA) $(LIBSO) $(LIBPC)
> >
> >  pywrap: all selinuxswig_python_exception.i
> > -       CFLAGS="$(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup.py build_ext -I $(DESTDIR)$(INCLUDEDIR) -L $(DESTDIR)$(LIBDIR)
> > +       CFLAGS="$(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup.py build_ext
> >
> >  rubywrap: all $(SWIGRUBYSO)
> >
> > --
> > 2.21.0
> >

