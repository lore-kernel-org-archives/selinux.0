Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96417C433F5
	for <selinux@archiver.kernel.org>; Mon, 27 Sep 2021 09:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CEA560E8B
	for <selinux@archiver.kernel.org>; Mon, 27 Sep 2021 09:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhI0JWT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Sep 2021 05:22:19 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:43663 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhI0JWS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Sep 2021 05:22:18 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 992905612BC
        for <selinux@vger.kernel.org>; Mon, 27 Sep 2021 11:20:38 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so13017947pjb.5
        for <selinux@vger.kernel.org>; Mon, 27 Sep 2021 02:20:38 -0700 (PDT)
X-Gm-Message-State: AOAM531fLg4+CClXBLWIUt8i2IELMYFiC29EK6j2Mqi/flijaebbXql6
        Ub1XyHnckXgBATGXPoHlLs0oAEAgNfDimvkWJPQ=
X-Google-Smtp-Source: ABdhPJymjpqk3NqUo4lmeiJ+IbusEpmEA5dWxfwQoZHTikDIFE48SCm0n1vSLXQwAU/bAjXfE8g0xU7BQaHJ5OJHVdQ=
X-Received: by 2002:a17:902:c086:b0:13e:2b52:29e1 with SMTP id
 j6-20020a170902c08600b0013e2b5229e1mr4188444pld.8.1632734437365; Mon, 27 Sep
 2021 02:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210927080634.4668-1-nicolas.iooss@m4x.org> <CAFqZXNucwVdeRf5hsjGraMRL060ninZOp=QbKWS=vofSBzmQLg@mail.gmail.com>
In-Reply-To: <CAFqZXNucwVdeRf5hsjGraMRL060ninZOp=QbKWS=vofSBzmQLg@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 27 Sep 2021 11:20:26 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mDLP1HxXk=HsquzR0g2S7-0XMhXcd=EXcMOVgz+7fz5g@mail.gmail.com>
Message-ID: <CAJfZ7=mDLP1HxXk=HsquzR0g2S7-0XMhXcd=EXcMOVgz+7fz5g@mail.gmail.com>
Subject: Re: [PATCH userspace] GitHub Actions: do not use macOS latest runner
 for now
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Sep 27 11:20:39 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 27, 2021 at 11:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
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

In fact, I got hit by the migration in my clone of the project, which
I am using to test things: the job
https://github.com/fishilico/selinux/runs/3708721148?check_suite_focus=true
ran on macOS 11, and failed with:

    /Users/runner/work/_temp/b65b7c49-de57-4461-9491-3d074d375d2a.sh:
line 2: vagrant: command not found

So the migration is already being rolled out, as described in
https://github.com/actions/virtual-environments/issues/4060#issue-993165185
:

    This change will be rolled out over a period of several weeks
beginning on September, 15. We plan to complete the migration by
November, 3.

> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
>
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

