Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A9AC433EF
	for <selinux@archiver.kernel.org>; Mon,  4 Oct 2021 13:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2BE860F6C
	for <selinux@archiver.kernel.org>; Mon,  4 Oct 2021 13:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbhJDN60 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbhJDN6K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Oct 2021 09:58:10 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BD0C061363
        for <selinux@vger.kernel.org>; Mon,  4 Oct 2021 06:52:58 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id c26-20020a056830349a00b0054d96d25c1eso21550817otu.9
        for <selinux@vger.kernel.org>; Mon, 04 Oct 2021 06:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3dSUp9r5XDGMqXPtIio+X0gdA8JX/ybxrc0IeZcY+8Y=;
        b=T3WcGaQ19rpH6N+76Gd3ECmvLLTEMOTqnLtja/AF9ekN4V09g+7ULroVS++h/LRILa
         95j8eupVzpwfsLoNE5Jj/o9uStgWuZov3MAfgOWDeGYrPQwYRCfqF3UZdoEiyUA49Toz
         NaDzq2LcmEaIG0rguO2aZ/H2YlK2XtCUQUxuHt6b1pBsUKsD11KpWqfWRFUhhssBHOdg
         c+7OUeUr554OBrxTFrbBcq1s3aY2w0lO4P+ifndto5DrWGlVu574HPV7+KybzdaOjE1P
         MsMmFHFMqVHZtgMHPvGAvWeK49J1yn8xjjeCqmmDTqBcRujLH/6kfbFVHStVZPQvWFOE
         rfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3dSUp9r5XDGMqXPtIio+X0gdA8JX/ybxrc0IeZcY+8Y=;
        b=wiblLXS45s9u84KBjXrgZD5qom/aLZuoiq5T+04oZlsCvZpEw5mcXr8EE+oPIawgR3
         Ltvum52tR4RHRvyJIz5VCqM2xB0cvODd+q631u2YBFYjQsT41sbS4MZ8G3rnqH8JodG4
         iphLCV0tq9XKbUD0GkimJSUXiyrU6qiGOTi8Vc4NS0xB4onARgmdhlxy4aUPlXx+jIMX
         kwI4xvkzQ4pVfi1R09IYNCFDk0WnK/78gTSrJlXayrr7qoTSwipOKKryHMEoM4I5uIuN
         vVFIHultKplOPhuSZeXASvRDeFkJzHB1jt9tMFPznZR907VzgXQyrtqzH/ukR6B772WT
         XUcw==
X-Gm-Message-State: AOAM531q04xx3tNNLCtStiEq8UzrbdeqIJtmHLw9vy4wJJNEi2daGJCM
        jlwoV7Mssf0xLAyU+vxI8ycUZwXUaF6v06TXhWU=
X-Google-Smtp-Source: ABdhPJxgT6FI4DqtECu0W/cdZGqTWINtUeWLyejSlkd7RbSQPB0VrSMJM1cFJXq0Zm+jnhYHazHkvP9Dy9Knk76pZdA=
X-Received: by 2002:a9d:5f85:: with SMTP id g5mr9532406oti.139.1633355577502;
 Mon, 04 Oct 2021 06:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210927080634.4668-1-nicolas.iooss@m4x.org> <CAFqZXNucwVdeRf5hsjGraMRL060ninZOp=QbKWS=vofSBzmQLg@mail.gmail.com>
In-Reply-To: <CAFqZXNucwVdeRf5hsjGraMRL060ninZOp=QbKWS=vofSBzmQLg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 4 Oct 2021 09:52:46 -0400
Message-ID: <CAP+JOzQjWBiFQk8Ajw=qQx01jUetabYM8PTMrVcDWK4rcuqb0g@mail.gmail.com>
Subject: Re: [PATCH userspace] GitHub Actions: do not use macOS latest runner
 for now
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 27, 2021 at 5:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Mon, Sep 27, 2021 at 10:06 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > GitHub is currently migrating its macos-latest runner to macOS 11:
> > https://github.com/actions/virtual-environments/issues/4060
> >
> > Unfortunately, installing VirtualBox and Vagrant on this new version of
> > macOS is not easy, and the current macos-11 runner does not support
> > running virtual machines using Vagrant. This issue is being fixed on
> > https://github.com/actions/virtual-environments/pull/4010 .
> >
> > Until this Pull Request is merged, use macos-10.15 runner instead of
> > macos-latest, to continue using Vagrant to run the SELinux testsuite in
> > a virtual machine.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> It seems to me there is a decent chance that the PR will be merged
> before the migration takes effect, but I guess it's better to be safe
> than sorry :)
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
>

This patch has been merged.
Thanks,
Jim

> > ---
> >
> > For information, I tested this patch on
> > https://github.com/fishilico/selinux/actions/runs/1273275936
> >
> >  .github/workflows/vm_testsuite.yml | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/.github/workflows/vm_testsuite.yml b/.github/workflows/vm_testsuite.yml
> > index af2fad1e73f5..601276ddcf50 100644
> > --- a/.github/workflows/vm_testsuite.yml
> > +++ b/.github/workflows/vm_testsuite.yml
> > @@ -6,7 +6,8 @@ jobs:
> >    vm_testsuite:
> >
> >      # Use VirtualBox+vagrant on macOS, as described in https://github.com/actions/virtual-environments/issues/433
> > -    runs-on: macos-latest
> > +    # Use an old version of macOS until https://github.com/actions/virtual-environments/pull/4010 is merged.
> > +    runs-on: macos-10.15
> >
> >      steps:
> >      - uses: actions/checkout@v2
> > --
> > 2.32.0
> >
>
>
> --
> Ondrej Mosnacek
> Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>
