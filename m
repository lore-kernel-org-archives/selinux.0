Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449A1C2D0E4
	for <selinux@archiver.kernel.org>; Fri, 27 Nov 2020 14:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC2DE21D7A
	for <selinux@archiver.kernel.org>; Fri, 27 Nov 2020 14:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muYqqwzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbgK0OZR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Nov 2020 09:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730855AbgK0OZR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Nov 2020 09:25:17 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1172BC0613D1
        for <selinux@vger.kernel.org>; Fri, 27 Nov 2020 06:25:17 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id q1so4770620ilt.6
        for <selinux@vger.kernel.org>; Fri, 27 Nov 2020 06:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/DwxlMaqowAwlIrpsQegtq4OdaC6af6fKgBAjEQnRC4=;
        b=muYqqwzDo+SNK6TF0Erg+1AvgZN7GmsaTBQultsXsJHJjsep6JTwQqDmMyf1QGBevu
         xOZEqRyCmsvJyBR9zenIV7a9Cvx6B+xxlunBwxCjrGN4AU3AV/FEXPDY8r9KieJR8fZp
         HV7o9JuBjL/IBwNOeD28JhfDAy+0wBfydSQVTpjrH6+9+wdRupTYMK8nMfmlcffcxVEe
         E6xkzFwoWeaHlZUymwz8jz8dzdpIRe3n5ejsTnPRM4QYmma8goYEnPdtPQBSPnR8GN6r
         JumT1DaiPTZyEX9sAdK7lEQ3XDm7YqW47ey8rtdFY2b7B5byZ77p5SKPunp6ZPL/shw2
         nBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/DwxlMaqowAwlIrpsQegtq4OdaC6af6fKgBAjEQnRC4=;
        b=UtNELGINIVdoqZ5UV2RnPaXtbwIcGIyg2/xRKnnWCAF/V5Mmg7/2ZdfWxYvWLKh+Vm
         ZUUYy21enKK9qnkmvW9e/eN5oVjnrPzxSw0s7MeJLcGOBV+Ub/544Jm76tBLxpTRyGe4
         vbzy3et7CMoivRYctmJp+C8VQ5gffTBfHsUk0x/eMdqzPq9sAuU9gDLnNWwtzbgQJdg8
         ij6fQ8yqeJlxCwLWtFXtavSwF4SEHixOqj0JrlHF7caBWkYjZgjDEGJtvNy5YQM1vYku
         NXAtYg9os03tdYaoTeUFPY2bAe+2fJbJkgh1vOguI8P42Dh8Q0o/i7hphqkTzU3JcjR+
         nI2Q==
X-Gm-Message-State: AOAM531lYyCLHbjBWnVwK//Hxt0ELPLXSxNjCLNVjO5Je5ao6kEN4soP
        JIlELP8ER/xk5Ny83W+Ur7ZoJIKqEm87zi9B6Yo=
X-Google-Smtp-Source: ABdhPJzVlbf3g/M7FRHsCoEm6tca2iJcHaRK1HoK4D7Zs03c4tELJYHeQqQETwN00nJ6OQ5nRFJ6s8hIQUe567BGG1o=
X-Received: by 2002:a92:5e9a:: with SMTP id f26mr7211191ilg.129.1606487116386;
 Fri, 27 Nov 2020 06:25:16 -0800 (PST)
MIME-Version: 1.0
References: <20201127141745.1579498-1-omosnace@redhat.com> <CAFqZXNvK5SBo2dw6_OctuLJqcEv8=Ynd8BajOLCdgTa-PNO1xg@mail.gmail.com>
In-Reply-To: <CAFqZXNvK5SBo2dw6_OctuLJqcEv8=Ynd8BajOLCdgTa-PNO1xg@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 27 Nov 2020 08:25:04 -0600
Message-ID: <CAFftDdp7_dcebjje6+pX1RNQiaBRbgFZSfjxk55DD8-MXJ=MjQ@mail.gmail.com>
Subject: Re: [PATCH userspace] travis: run only selinux-testsuite
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 27, 2020 at 8:22 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, Nov 27, 2020 at 3:17 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > Now that the standard testing is run on GitHub Actions, we can remove it
> > from .travis.yml, leaving only the selinux-testsuite sanity check, which
> > can't be migrated. Hopefully this will save some precious minutesfrom
> > the limited "plan" Travis gave us...
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  .travis.yml                    | 161 +--------------------------------
> >  scripts/ci/travis-kvm-setup.sh |   1 +
> >  2 files changed, 2 insertions(+), 160 deletions(-)
>

Oh awesome you got them migrated. I am in the middle of this for my
other projects and was going to check
back on SE Linux, glad you took care of it.

> My intent is to apply this patch along with Nicholas's GH actions
> patch. In case some issues pop up with GH actions, we can simply
> revert it.
>
> Thoughts?

I'm going to assume actions are working, I didn't check that patch.
But it all LGTM.
Ack from me.

>
> --
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel
> Red Hat, Inc.
>
