Return-Path: <SRS0=Xk8N=7G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F088AC433DF
	for <selinux@archiver.kernel.org>; Sun, 24 May 2020 16:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7557207CB
	for <selinux@archiver.kernel.org>; Sun, 24 May 2020 16:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z65Js3YP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgEXQSh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 24 May 2020 12:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgEXQSh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 24 May 2020 12:18:37 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BA4C061A0E
        for <selinux@vger.kernel.org>; Sun, 24 May 2020 09:18:36 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d5so7011055ios.9
        for <selinux@vger.kernel.org>; Sun, 24 May 2020 09:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Az4sa01dNLgyhEDuf4EWyTZQ4581J+VE3OOmfEt+l0=;
        b=Z65Js3YPCRvDzAL9HjlUuk3fsCeVCjNRBvsGOh70aEnZs2iRedbUSbb017qsh86Nwa
         e6TEgqxkb/t68MmKFIBQb7goqnll+3paa5H/EiiIaoB6QaOl/8bGtov+r76T3icXaK0z
         Xb/QlrQnDm9D1DYE7DTkRW+oDPFWawOpInyiqjSkEDERM8sZFfSJceqx32rXNCnfkWo7
         REmmk6KmDNbnxLxWVIgqLoFEDUsAOV7bL9GS2lpKtlCdS31ViouEpHLMzaojrdZmbm4F
         OL2Q93eelKHppCH0bXr8yBCOApfn5CWjZXFodMWoWmXhajHYdcYe3WNQC1SpUWEms95y
         SjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Az4sa01dNLgyhEDuf4EWyTZQ4581J+VE3OOmfEt+l0=;
        b=KGy+nm3m+152ipAutfXBNDddZ03MqUZRVrsC/sG1YbZ8IjjZGjHsuCgRgA+xnKOI5+
         9D0axkLlMMy8Dtv82C1q3gPb3R7kCs8OtZuvaQA7A/GhJup90VNKg43tZmdCITS83foF
         lM5IvzKnW8wXBA0NlltkR1PtsHS23frp7SMcNCvLR95LD8JTPFua0ZZtFsEN6p/0+Xw1
         +45im1e0ExQvX6MeUHaCodAcFUn5Pgy631QP/LhQ8FnF9R7iISgBQnSDvlv6xHc/6ahc
         oesQiBcrc9Z+QqJkg00iX+FdBh/zlUbHuHAeqK4PxiKnj4aH6NAGcvCRJRiCGBuekJpg
         uClg==
X-Gm-Message-State: AOAM5336hYf4FOnTy0CUR/Lw77w75uxzhr7wna9pbPaIeGShpLYF23/h
        ptSq5yrGTl8+B9DLusuUOYwJb0iGFtx2zTJIhVz+eMFi
X-Google-Smtp-Source: ABdhPJxbrd69aqWw5AT7MgCfsuLy9rNBXtqj+kb5e39iW4VHa+O3OrFB7fbqeAPGrowWkTACRxSX6xby/wjS5eTYNvA=
X-Received: by 2002:a02:94e6:: with SMTP id x93mr491678jah.116.1590337115924;
 Sun, 24 May 2020 09:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTNZ=gcw5w3FFEs9KiuSrUBhbYLVc=sZq0N4ZEGCem1Zg@mail.gmail.com>
 <20200520163421.27965-1-william.c.roberts@intel.com> <20200520163421.27965-2-william.c.roberts@intel.com>
 <CAFqZXNsV8fUeA-tT4kMtmaNaDK6_LkqvftY-SF7+RUrSBkWUvA@mail.gmail.com>
 <CAEjxPJ7HwA_5E6vCrtRfKK=Lpppp-WEbBa_5cVJvzH7fLSGD_A@mail.gmail.com>
 <CAFqZXNuOTsPrE-0D7OD7jZ4ETWgwW4HCVywnooJs4Q4Qk3d5EQ@mail.gmail.com>
 <CAFftDdqnrPr32GW71aRgXu8akvMAu3FG5L7B2fp4GzBs0=_Z9g@mail.gmail.com> <CAFqZXNvc-J0=wpFnNzCxiq80e-hY=5Tubu84-KkPm5nAfgaYRQ@mail.gmail.com>
In-Reply-To: <CAFqZXNvc-J0=wpFnNzCxiq80e-hY=5Tubu84-KkPm5nAfgaYRQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Sun, 24 May 2020 11:18:24 -0500
Message-ID: <CAFftDdqqvDPGBHdVXWU5G+LuFMVHciRJpgnRRnDdSzpWQo7wog@mail.gmail.com>
Subject: Re: [PATCH v2] ci: run SELinux kernel test suite
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 22, 2020 at 2:40 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, May 21, 2020 at 4:12 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> > On Thu, May 21, 2020 at 7:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > On Thu, May 21, 2020 at 2:52 PM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> [...]
> > > > Last I looked, his script builds and installs the userspace code on
> > > > top of the Fedora libraries and programs (make LIBDIR=... install...)
> > > > and then runs the testsuite.  That was my suggestion.
> > >
> > > Ah, yes, I can see that line now. Sorry, somehow I missed it before.
> > >
> > > > While it is the
> > > > kernel testsuite, it exercises a lot of SELinux userspace
> > > > functionality that isn't tested by the userspace tests.
> > >
> > > OK, I suppose it's better than nothing...
> > >
> >
> > Stephen pointed out the additional ways userspace gets tested, and
> > perhaps my title and description
> > of the patch could be better. But the main point is to increase the
> > test coverage
> > and perform the testing steps we expect are done before a release in
> > the CI. We should have
> > the testing coverage and the confidence to release userspace from master at any
> > point. We also have forward facing proof that tests are being executed
> > and we can make sure
> > nothing regresses.
> >
> > My ultimate goal here, is to help make sure that if Petr gets hit by a
> > bus, releases will
> > move forward without worry and without any change in quality among the various
> > maintainers.
> >
> > Additionally, we pick up some cross project testing and can find other
> > surprises.
>
> Ah, so you want to move an integration test, which we would normally
> run only before release, down to per-commit testing, which is fine
> because it is quite fast... OK, it started to make sense to me now :)

Exactly, plus we pick up a little more test coverage on the userspace bits
by swapping out what's installed in the VM with the current build and running
the tests. The speed is less important, it's just fast enough where our CI isn't
going to take years to complete. CI doesn't need to be super snappy per se,
but it also cannot take a fortnight.

>
> If I find time I'll have a closer look at the scripts. I already see
> some tiny possible improvements... I have Nicolas's last comments
addressed and staged, so ill wait a few days and see what you come
back with and re-send a V3.
