Return-Path: <SRS0=so3z=V3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URI_HEX autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA10C433FF
	for <selinux@archiver.kernel.org>; Tue, 30 Jul 2019 22:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CA8206A2
	for <selinux@archiver.kernel.org>; Tue, 30 Jul 2019 22:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbfG3WFU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:05:20 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:59860 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfG3WFU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Jul 2019 18:05:20 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 7447D5646B7
        for <selinux@vger.kernel.org>; Wed, 31 Jul 2019 00:05:16 +0200 (CEST)
Received: by mail-oi1-f175.google.com with SMTP id a127so49049867oii.2
        for <selinux@vger.kernel.org>; Tue, 30 Jul 2019 15:05:16 -0700 (PDT)
X-Gm-Message-State: APjAAAXTdP/UfAyYn5Q1uJ0VFKrc/p/bytfjMThbdSOHgyxvoAuHrWyi
        gdrLB5JorvuJ7pOcgCqTo7eZ2VMXrrQG/hrZfQo=
X-Google-Smtp-Source: APXvYqzYwAe0Luupr7nkIkL+Fsy8U4QF0DfKfiODBsC6RpET1QHetOrnCe1XfAkpZnDCXbeTIbQ0qYbCwXkwGJoJyqo=
X-Received: by 2002:aca:6104:: with SMTP id v4mr60099924oib.172.1564524315432;
 Tue, 30 Jul 2019 15:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190728183749.30044-1-nicolas.iooss@m4x.org> <CAFqZXNsbL8tQ+XEHuo7huBs7_3utzKWbG5DYb+jXPo9hmWHEWA@mail.gmail.com>
In-Reply-To: <CAFqZXNsbL8tQ+XEHuo7huBs7_3utzKWbG5DYb+jXPo9hmWHEWA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 31 Jul 2019 00:05:04 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==m3g0ZcOGUZAtosR+_haaLdJ-Cu6SxW7YF7K5+3fGZGA@mail.gmail.com>
Message-ID: <CAJfZ7==m3g0ZcOGUZAtosR+_haaLdJ-Cu6SxW7YF7K5+3fGZGA@mail.gmail.com>
Subject: Re: [PATCH 1/1] libsepol: initialize a local variable once
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jul 31 00:05:17 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jul 28, 2019 at 10:29 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Sun, Jul 28, 2019 at 8:38 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > Function optimize_cond_av_list() initializes its local variable pcov_cur
> > twice. Remove the first initialization.
> >
> > This issue has been found using clang's static analyzer:
> > https://282-118970575-gh.circle-artifacts.com/0/output-scan-build/2019-06-24-210510-6101-1/report-c64da3.html#EndPath
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

Thanks, merged.

Nicolas

> > ---
> >  libsepol/src/optimize.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
> > index 3780b68b24fe..10399a43e1cf 100644
> > --- a/libsepol/src/optimize.c
> > +++ b/libsepol/src/optimize.c
> > @@ -247,7 +247,7 @@ static void optimize_cond_av_list(cond_av_list_t **cond, cond_av_list_t **del,
> >  {
> >         cond_av_list_t **listp = cond;
> >         cond_av_list_t *pcov = NULL;
> > -       cond_av_list_t **pcov_cur = &pcov;
> > +       cond_av_list_t **pcov_cur;
> >
> >         /*
> >          * Separate out all "potentially covering" rules (src or tgt is an attr)
> > --
> > 2.22.0
> >
>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Software Engineer, Security Technologies
> Red Hat, Inc.

