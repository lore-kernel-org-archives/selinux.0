Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670D2C4646B
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 07:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466EB2086D
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 07:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbfFZHAM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:00:12 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:47457 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfFZHAM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 03:00:12 -0400
X-Greylist: delayed 337 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jun 2019 03:00:11 EDT
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9A6F056128D
        for <selinux@vger.kernel.org>; Wed, 26 Jun 2019 08:54:31 +0200 (CEST)
Received: by mail-oi1-f180.google.com with SMTP id g7so1096566oia.8
        for <selinux@vger.kernel.org>; Tue, 25 Jun 2019 23:54:31 -0700 (PDT)
X-Gm-Message-State: APjAAAVwSD3ZpCa1BbsmhoVfS18Qd1WSMRNKFNkS7Qur/9q4nFZ8O2fD
        Bbltpdi00Se4UNejWUDXvhBd6ZgX85iKPml16mk=
X-Google-Smtp-Source: APXvYqwrTt2cE7fh24yjrVQ2a5HX8lK6A6oJVX0JDu0WXP8ifXeIqanfLIy153AHtXFJ7zuOCWVRduEilu7poyBqR6A=
X-Received: by 2002:aca:4306:: with SMTP id q6mr817625oia.39.1561532070643;
 Tue, 25 Jun 2019 23:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190624193154.8453-1-nicolas.iooss@m4x.org> <CAFftDdrgMfG_xvozsKAwQGPZ6pPnVGMx4jefdnSVWbEaBA+=KQ@mail.gmail.com>
In-Reply-To: <CAFftDdrgMfG_xvozsKAwQGPZ6pPnVGMx4jefdnSVWbEaBA+=KQ@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 26 Jun 2019 08:54:19 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=m2GX0vpoOzocsN7pLk5-HeF8RGjLoQK4Kiq5HeT-P7Ew@mail.gmail.com>
Message-ID: <CAJfZ7=m2GX0vpoOzocsN7pLk5-HeF8RGjLoQK4Kiq5HeT-P7Ew@mail.gmail.com>
Subject: Re: [PATCH 1/1] libsepol: include module.c internal header in module_to_cil.c
To:     William Roberts <bill.c.roberts@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jun 26 08:54:32 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 25, 2019 at 6:01 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> ack, you going to to merge this?

Yes, I merged it.

Thanks,
Nicolas

> On Mon, Jun 24, 2019 at 2:58 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > In module_to_cil.c, sepol_ppfile_to_module_package() calls functions
> > from module.c without including the internal header. This makes building
> > libsepol with "gcc -flto -fuse-ld=gold" fails when linking libsepol.so:
> >
> >     /tmp/ccHYAKVZ.ltrans21.ltrans.o:<artificial>:function
> >     sepol_ppfile_to_module_package: error: undefined reference to
> >     'sepol_module_package_free'
> >     /tmp/ccHYAKVZ.ltrans21.ltrans.o:<artificial>:function
> >     sepol_ppfile_to_module_package: error: undefined reference to
> >     'sepol_module_package_create'
> >     /tmp/ccHYAKVZ.ltrans21.ltrans.o:<artificial>:function
> >     sepol_ppfile_to_module_package: error: undefined reference to
> >     'sepol_module_package_create'
> >     collect2: error: ld returned 1 exit status
> >
> > Fixes: https://github.com/SELinuxProject/selinux/issues/165
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > ---
> >  libsepol/src/module_to_cil.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> > index da62c8aaf0ef..1af166c9abd0 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -54,6 +54,7 @@
> >
> >  #include "kernel_to_common.h"
> >  #include "private.h"
> > +#include "module_internal.h"
> >
> >  #ifdef __GNUC__
> >  #  define UNUSED(x) UNUSED_ ## x __attribute__((__unused__))
> > --
> > 2.22.0
> >

