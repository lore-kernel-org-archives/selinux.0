Return-Path: <SRS0=qOYA=EG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E03C388F7
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 11:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601FB20739
	for <selinux@archiver.kernel.org>; Sat, 31 Oct 2020 11:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxnT5hET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgJaL2I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 31 Oct 2020 07:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20151 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726798AbgJaL2H (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 31 Oct 2020 07:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604143674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QqMovL/jU7xh97RKUijUEsQbEijk7nIKs8jbq/vjYK4=;
        b=AxnT5hETY0mpnVCW7qtp84X598/dYLSE4ckXTjuNkngKq5ylCzC81xt3BvTiX5czr/cykz
        +HbC9ONqaCMkQ/eh3H3EsIaH5fCYFa2Q41dc7MpeyV0KotMOSenoEjLNJDO83rP3DQyjee
        OlFR7WF1CKkBGM/VuG+sCWXxPxF85uI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-osFCKqPHO02dUV9vJIUwXA-1; Sat, 31 Oct 2020 07:27:51 -0400
X-MC-Unique: osFCKqPHO02dUV9vJIUwXA-1
Received: by mail-lj1-f199.google.com with SMTP id h22so123432ljh.23
        for <selinux@vger.kernel.org>; Sat, 31 Oct 2020 04:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QqMovL/jU7xh97RKUijUEsQbEijk7nIKs8jbq/vjYK4=;
        b=gLG5GtIYaUduM3C4EHrJmdk7xGMc6AFHIS3P54o88RRXzzN/JcROKeBbgvgZ3Nlk4b
         1c7Ej7p41g5qRvl25SclgS0yX6OTd8QRRfU0BqiOFSTOeh4zr3W8H36pM6voz9Tf81/o
         rbPR3vJGh+0x6L5TmpIWoAsi3qeH/ksmlDqPXIVgJkJeW9qJeosZemFCJR5hgxIgM5RQ
         eYb0wpr+j1B1rJBRnqckoZ9HVyhSAg88Z27rEqcNBC1EmbEGGWHHnjUQ972JdYWmO9+g
         v0/K04XYj3ku6zG/j82ORhm9QJX1m5u+tI//pLk2DhTsQLF+Ll6TFeXjNLCgSkvCgsib
         17Gw==
X-Gm-Message-State: AOAM532f8yBBwrmFagvGae4ppwgOQVWYKOLZ721RAuai2zGiEvuPyU9j
        79iE9RM1Yjmy6Rh7r5PplscoONQKmESOg4O1ph3xp8CtvfMyEibc0yMclu14QQqnFgT7L3f3ixB
        znWlJb+6MD9erfiYfYT4hosbugszwIUkBZA==
X-Received: by 2002:a05:651c:124f:: with SMTP id h15mr2858595ljh.123.1604143670043;
        Sat, 31 Oct 2020 04:27:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnCvgX69zTxlJkuxDeZYsMgklI1WXKtULe5v/nsVP0JTte/Mnx2iQq7ezwqvUVY2UAK9Q5R1h5GzHyzu8K+/8=
X-Received: by 2002:a05:651c:124f:: with SMTP id h15mr2858589ljh.123.1604143669841;
 Sat, 31 Oct 2020 04:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201013145456.77253-1-richard_c_haines@btinternet.com>
 <CAFqZXNu1o3rTRcrNBRwESt+txA+chc3PcdFjrZFiP50koceyAQ@mail.gmail.com>
 <CAFqZXNtubRw-pqEiuxwzp=6n53Gnso3oOoExbhc+OhWcQ5ESAA@mail.gmail.com>
 <CAFqZXNvUiezPUTYgV+vWiS2LO5Nt0_Sb-p8GeELhLjVcPVTmRg@mail.gmail.com> <e895f6ebe00f6fd8ca451521a2326d0717d75760.camel@btinternet.com>
In-Reply-To: <e895f6ebe00f6fd8ca451521a2326d0717d75760.camel@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 31 Oct 2020 12:27:38 +0100
Message-ID: <CAFqZXNshi4F4uEO+x9PJ4-MAoXLQgG2w8qw__EPbWWV5eWqb1A@mail.gmail.com>
Subject: Re: [PATCH 0/1] selinux-testsuite: Add btrfs support for filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Oct 31, 2020 at 11:58 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Sat, 2020-10-31 at 01:04 +0100, Ondrej Mosnacek wrote:
> > On Sat, Oct 31, 2020 at 12:44 AM Ondrej Mosnacek <omosnace@redhat.com
> > > wrote:
> > > On Fri, Oct 30, 2020 at 10:55 PM Ondrej Mosnacek <
> > > omosnace@redhat.com> wrote:
> > > > And on related note, the existing vfat tests are also failing:
> > > > Test Summary Report
> > > > -------------------
> > > > filesystem/vfat/test      (Wstat: 7936 Tests: 43 Failed: 31)
> > > >   Failed tests:  3-4, 6-7, 10-12, 14-19, 21-22, 24-36, 38-40
> > > >   Non-zero exit status: 31
> > > > fs_filesystem/vfat/test   (Wstat: 8192 Tests: 42 Failed: 32)
> > > >   Failed tests:  3, 5-7, 10-20, 22-35, 37-39
> > > >   Non-zero exit status: 32
> > >
> > > And this might be the same problem, but with dosfstools... I'll
> > > need to check.
> >
> > Yeah, that was it. With dosfstools installed the tests pass.
> >
> > There are some fsetfilecon(3) errors visible in the test output,
> > though:
> > https://travis-ci.com/github/WOnder93/selinux-testsuite/jobs/422914927#L2697
> >
>
> These tests pass as for vfat Operation not supported is correct. The
> tests just need " 2>&1" added to stop output. I'll submit a patch, also
> to add dosfstools (also to travis run-testsuite.sh).

You can skip the dosfstools, I have a patch ready for that (it will
also add e2fsprogs and jfsutils, which are also missing). You might
also want to delay respinning the btrfs patch for after my "multi-fs
filesystem test" patches (it will need small tweaks to align with
that). Stay tuned, I should have the patches ready by today :)

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

