Return-Path: <SRS0=fPvm=D2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B89AC433DF
	for <selinux@archiver.kernel.org>; Mon, 19 Oct 2020 21:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 365AE2231B
	for <selinux@archiver.kernel.org>; Mon, 19 Oct 2020 21:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbgJSVft (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Oct 2020 17:35:49 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:48466 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgJSVft (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Oct 2020 17:35:49 -0400
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Oct 2020 17:35:49 EDT
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 8042A564EE5
        for <selinux@vger.kernel.org>; Mon, 19 Oct 2020 23:35:47 +0200 (CEST)
Received: by mail-oo1-f46.google.com with SMTP id f26so311631oou.11
        for <selinux@vger.kernel.org>; Mon, 19 Oct 2020 14:35:47 -0700 (PDT)
X-Gm-Message-State: AOAM531Dc8+aPa15vuk7I+WXw9iPwa1urJcetrcTKUXxhlIbk+NiktB2
        FO7xeJk/r51FNcJ2R61F3dolEK3kYqTXmNORF/g=
X-Google-Smtp-Source: ABdhPJyTsPNvVFUNRKwNpapdM+TiA3CKRmLEaNVumQ5l4Zzlmb08dwZXA8k33FKvV1J7CdvVsz+9re9pO1Obz4rFPzg=
X-Received: by 2002:a4a:e643:: with SMTP id q3mr1423875oot.22.1603143346480;
 Mon, 19 Oct 2020 14:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201009130052.52409-1-plautrba@redhat.com> <CAP+JOzTSbTZnDEeAkAvUOMAwOdDgc3J52JauH=yfxshbBpDLbQ@mail.gmail.com>
In-Reply-To: <CAP+JOzTSbTZnDEeAkAvUOMAwOdDgc3J52JauH=yfxshbBpDLbQ@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 19 Oct 2020 23:35:35 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nBvxkg9cq98JCHYWvJePO+=DrYao3XhU8MP912QzUHJQ@mail.gmail.com>
Message-ID: <CAJfZ7=nBvxkg9cq98JCHYWvJePO+=DrYao3XhU8MP912QzUHJQ@mail.gmail.com>
Subject: Re: libsepol, libsemanage: drop duplicate and deprecated symbols
To:     James Carter <jwcart2@gmail.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Oct 19 23:35:48 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 15, 2020 at 7:59 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Oct 9, 2020 at 9:49 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> >
> > This is followup of
> > https://lore.kernel.org/selinux/20200930145031.910190-1-plautrba@redhat.com/T/#t
> >
> > Change against 1 version:
> >
> > - improved commit messages with references to Debian and Fedora guidelines
> > - drop deprecated functions from libsepol/src/deprecated_functions.c and
> > - semanage_module_enable/semanage_module_disable from libsemanage
> >
>
> I am not an expert in library versioning and such, but everything
> looks ok to me.
> Jim

Same: not an expert, but the patches look good (and Travis-CI does not
report any issue). Thanks for adding references to the guidelines! For
this series:

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

I will be busy tomorrow but will merge this on Wednesday if you do not
merge it before (and if nobody sends comments requiring changes).
Nicolas

