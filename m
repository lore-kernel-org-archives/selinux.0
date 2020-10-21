Return-Path: <SRS0=8FG4=D4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56FEC388F9
	for <selinux@archiver.kernel.org>; Wed, 21 Oct 2020 20:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FB62415A
	for <selinux@archiver.kernel.org>; Wed, 21 Oct 2020 20:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505412AbgJUUiM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Oct 2020 16:38:12 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:43337 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410598AbgJUUiK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Oct 2020 16:38:10 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2020 16:38:09 EDT
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 472955654B9
        for <selinux@vger.kernel.org>; Wed, 21 Oct 2020 22:32:35 +0200 (CEST)
Received: by mail-ot1-f45.google.com with SMTP id f10so3091215otb.6
        for <selinux@vger.kernel.org>; Wed, 21 Oct 2020 13:32:35 -0700 (PDT)
X-Gm-Message-State: AOAM53364eJqLKZFFu/kskO+E1yrSzsDDUNNxUriYLYHVbOLNOCmipqJ
        HNqKFK7H54JSAQTX6qLh0oyOcWHbMcG01ZXzWZk=
X-Google-Smtp-Source: ABdhPJzEl0ds0auIGXMejTA3WCAhEX9PU6gQq9StXghUmij0r3CSnMAf/7I7yZxUpQawWboNHHhPWJndks+G1n+OZ5I=
X-Received: by 2002:a9d:7019:: with SMTP id k25mr3617134otj.96.1603312354282;
 Wed, 21 Oct 2020 13:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201009130052.52409-1-plautrba@redhat.com> <CAP+JOzTSbTZnDEeAkAvUOMAwOdDgc3J52JauH=yfxshbBpDLbQ@mail.gmail.com>
 <CAJfZ7=nBvxkg9cq98JCHYWvJePO+=DrYao3XhU8MP912QzUHJQ@mail.gmail.com>
In-Reply-To: <CAJfZ7=nBvxkg9cq98JCHYWvJePO+=DrYao3XhU8MP912QzUHJQ@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 21 Oct 2020 22:32:23 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==4h8FCX=bBisLUjYq2ukFXFpyNH490U5ji26L0G+Z0HA@mail.gmail.com>
Message-ID: <CAJfZ7==4h8FCX=bBisLUjYq2ukFXFpyNH490U5ji26L0G+Z0HA@mail.gmail.com>
Subject: Re: libsepol, libsemanage: drop duplicate and deprecated symbols
To:     James Carter <jwcart2@gmail.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Oct 21 22:32:35 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 19, 2020 at 11:35 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Oct 15, 2020 at 7:59 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > On Fri, Oct 9, 2020 at 9:49 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> > >
> > >
> > > This is followup of
> > > https://lore.kernel.org/selinux/20200930145031.910190-1-plautrba@redhat.com/T/#t
> > >
> > > Change against 1 version:
> > >
> > > - improved commit messages with references to Debian and Fedora guidelines
> > > - drop deprecated functions from libsepol/src/deprecated_functions.c and
> > > - semanage_module_enable/semanage_module_disable from libsemanage
> > >
> >
> > I am not an expert in library versioning and such, but everything
> > looks ok to me.
> > Jim
>
> Same: not an expert, but the patches look good (and Travis-CI does not
> report any issue). Thanks for adding references to the guidelines! For
> this series:
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> I will be busy tomorrow but will merge this on Wednesday if you do not
> merge it before (and if nobody sends comments requiring changes).

Merged.

Thanks!
Nicolas

