Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9569BC07E97
	for <selinux@archiver.kernel.org>; Sat,  3 Jul 2021 14:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 668E761445
	for <selinux@archiver.kernel.org>; Sat,  3 Jul 2021 14:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhGCOWA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 3 Jul 2021 10:22:00 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:37219 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhGCOWA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 3 Jul 2021 10:22:00 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 6FCBE56498C
        for <selinux@vger.kernel.org>; Sat,  3 Jul 2021 16:19:17 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id v13so7394392ple.9
        for <selinux@vger.kernel.org>; Sat, 03 Jul 2021 07:19:17 -0700 (PDT)
X-Gm-Message-State: AOAM533Taeg2NSjXQjpg+ojc75hQYUOO9uNwSn8GpZ4ObatJeoY86XAe
        6lxEEPVWGz2Xcd+/imP0+h65zi/tVc7Cpk8t3RA=
X-Google-Smtp-Source: ABdhPJyW0kwsfuh9cMqth71knev3HDo88P9GWSFRHUGTQmZ6KfDD67ptV5ywelFRJvTnxZr+xo2QxUttVa1dKDHv0yI=
X-Received: by 2002:a17:90a:588b:: with SMTP id j11mr4863459pji.114.1625321956050;
 Sat, 03 Jul 2021 07:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210701170619.96954-1-fontaine.fabrice@gmail.com> <CAJfZ7==8hu4oBQmBf++TG4dVRTeqU0nFOKf11K-59Dyd3cPnBA@mail.gmail.com>
In-Reply-To: <CAJfZ7==8hu4oBQmBf++TG4dVRTeqU0nFOKf11K-59Dyd3cPnBA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 3 Jul 2021 16:19:04 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==gdF_SFrYwxWrROWpeGn-AL5nxcDzYVBSKgUHnGMU=RA@mail.gmail.com>
Message-ID: <CAJfZ7==gdF_SFrYwxWrROWpeGn-AL5nxcDzYVBSKgUHnGMU=RA@mail.gmail.com>
Subject: Re: [PATCH] libselinux/utils/getseuser.c: fix build with gcc 4.8
To:     Fabrice Fontaine <fontaine.fabrice@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jul  3 16:19:17 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 2, 2021 at 10:18 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Jul 1, 2021 at 7:06 PM Fabrice Fontaine
> <fontaine.fabrice@gmail.com> wrote:
> >
> > Fix the following build failure with gcc 4.8 which is raised since
> > version 3.2 and
> > https://github.com/SELinuxProject/selinux/commit/156dd0de5cad31e7d437c64e11a8aef027f0a691
> >
> > getseuser.c:53:2: error: 'for' loop initial declarations are only allowed in C99 mode
> >   for (int i = 0; i < n; i++)
> >   ^
> >
> > Fixes:
> >  - http://autobuild.buildroot.org/results/37eb0952a763256fbf6ef3c668f6c95fbdf2dd35
> >
> > Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> If nobody else has comments, I will apply this patch tomorrow.
> Thanks!
> Nicolas

Applied.
Thanks,
Nicolas

> > ---
> >  libselinux/utils/getseuser.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/utils/getseuser.c b/libselinux/utils/getseuser.c
> > index ce1b7b27..34f2e887 100644
> > --- a/libselinux/utils/getseuser.c
> > +++ b/libselinux/utils/getseuser.c
> > @@ -9,7 +9,7 @@ int main(int argc, char **argv)
> >  {
> >         char *seuser = NULL, *level = NULL;
> >         char **contextlist;
> > -       int rc, n;
> > +       int rc, n, i;
> >
> >         if (argc != 3) {
> >                 fprintf(stderr, "usage:  %s linuxuser fromcon\n", argv[0]);
> > @@ -50,7 +50,7 @@ int main(int argc, char **argv)
> >         if (n == 0)
> >                 printf("no valid context found\n");
> >
> > -       for (int i = 0; i < n; i++)
> > +       for (i = 0; i < n; i++)
> >                 printf("Context %d\t%s\n", i, contextlist[i]);
> >
> >         freeconary(contextlist);
> > --
> > 2.30.2
> >

