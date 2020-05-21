Return-Path: <SRS0=ZZHY=7D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FCBC433DF
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 12:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F57D2072C
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 12:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hL/kE0b3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgEUMwQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 May 2020 08:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729328AbgEUMwQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 May 2020 08:52:16 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD339C061A0E
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 05:52:15 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w4so6130115oia.1
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 05:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Ro1AGqR9oxZzXvkQ1JCoghAbEmQbNgX+otAmcw8rJ8=;
        b=hL/kE0b3dDqr7gt1Z+JhwbNw1yvrjVKY0khDNfuUq7O4YsY6BL4Lazlr/lHisf1TaA
         /ouMbGE0uEC4QUzrDDktZZNj3lfIjEzEAqQF6HY46geMrtYvOONTFoWSyvgMOZnXdOQB
         xdUuxDXIb+WvScDVUDzbJFEFVQM5CkmJazB5XIXip2DNmw95UTMd7OZ1PcSDOhbBwTH3
         fKvDgrJpc7cVFc6doaHfhhjc0D6VXJUVbqdnAD61NT//Ddl3c3bUHvX1U6h0G2uu6nLE
         oajouNuGPE3Gf8UmQg92KtDr1OIUOyI3YCUlxOsLjAS/LUdr4zHkvkm4geKPmkT6JwlP
         tziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Ro1AGqR9oxZzXvkQ1JCoghAbEmQbNgX+otAmcw8rJ8=;
        b=LKH9jb4gbrSPecKH6+99EOFLeMgIddB7JblQ11/X1U7ZvAdAT4FXkGgvPuNz2oXRZ4
         dQfaLUdDy2W2RmB2lsYnhMe/V7kEgTmWCbE1tcWghg5O875S5kr+cUNn1mTxI2t8o7N8
         Z5zN7Dd+vny/oYCQzHDyZcOqMfJJe7+CD4UshyfbLl5reC5eC1mQuUUpnBa9mStg9TQt
         r0oH3txD/muM7ltxp1DpngE7OADDW0xUykRAr45jlyJajcsJJfD/AyilIJ+kyqw5cCSr
         9SCpTUmDyC5UJcaEqd89PXdXlGn25gsvt/uuCd7xXq1WXY267RGF8XISppQerZgLmC8t
         6ESg==
X-Gm-Message-State: AOAM532KlWXw6tzYUtRuupaDIUJ+7B0emZ2xcWLNIUc4Ro5Tr/NIf7+4
        s5MilcAv05p70C7eFiAGXS4ncLJ91QbMET0D3OvBy034
X-Google-Smtp-Source: ABdhPJy+QKaAyYUUBy2H3SlPi3yT34snHvqnYOwTEtqWTdwrKmswvWJmW0Ypdowq5/4MpJHQENShU88RLdPtaxRwrtQ=
X-Received: by 2002:aca:5e0b:: with SMTP id s11mr6169137oib.160.1590065535111;
 Thu, 21 May 2020 05:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTNZ=gcw5w3FFEs9KiuSrUBhbYLVc=sZq0N4ZEGCem1Zg@mail.gmail.com>
 <20200520163421.27965-1-william.c.roberts@intel.com> <20200520163421.27965-2-william.c.roberts@intel.com>
 <CAFqZXNsV8fUeA-tT4kMtmaNaDK6_LkqvftY-SF7+RUrSBkWUvA@mail.gmail.com>
In-Reply-To: <CAFqZXNsV8fUeA-tT4kMtmaNaDK6_LkqvftY-SF7+RUrSBkWUvA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 21 May 2020 08:52:04 -0400
Message-ID: <CAEjxPJ7HwA_5E6vCrtRfKK=Lpppp-WEbBa_5cVJvzH7fLSGD_A@mail.gmail.com>
Subject: Re: [PATCH v2] ci: run SELinux kernel test suite
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 21, 2020 at 4:51 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Wed, May 20, 2020 at 6:34 PM <bill.c.roberts@gmail.com> wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > The current Travis CI runs the userspace tooling and libraries against
> > policy files, but cannot test against an SELinux enabled kernel. Thus,
> > some tests are not being done in the CI. Travis, unfortunately only
> > provides Ubuntu images, so in order to run against a modern distro with
> > SELinux in enforcing mode, we need to launch a KVM with something like
> > Fedora.
> >
> > This patch enables this support by launching a Fedora32 Cloud Image with
> > the SELinux userspace library passed on from the Travis clone, it then
> > builds and replaces the current SELinux bits on the Fedora32 image and
> > runs the SELinux testsuite.
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
>
> From the text above I infer that this patch is intended against the
> userspace repo, right?
>
> If so, I don't quite see the usefulness of running the
> selinux-testsuite on every userspace change... It is mainly intended
> for testing the kernel and only a small part of its running time is
> spent on running (i.e. testing in a sense) the SELinux userspace
> programs. Not to mention that in your patch it runs with the userspace
> shipped in Fedora and not the version from the given commit...

Last I looked, his script builds and installs the userspace code on
top of the Fedora libraries and programs (make LIBDIR=... install...)
and then runs the testsuite.  That was my suggestion.  While it is the
kernel testsuite, it exercises a lot of SELinux userspace
functionality that isn't tested by the userspace tests.

>
> However, it could be very useful if this was added to the testsuite's
> CI instead so that it can verify that the testsuite patches don't
> break something. But note that you'd need to modify the script a bit
> to copy over the testsuite snapshot being tested to the VM and run
> that, instead of the current master.
>
> Anyway, thank you for working on this! I never realized that it could
> be so easy to run a Fedora VM from Travis. If I find some time maybe I
> can find some more ways to use this... For example we could run the
> Fedora/RHEL SELinux userspace tests from [1] after installing (not yet
> sure how) the userspace built from the currently tested userspace repo
> commit.
>
> [1] https://src.fedoraproject.org/tests/selinux/tree/master
