Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD7BC433DF
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 13:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 163A720721
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 13:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZARq1tZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgE2NY1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 09:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgE2NY0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 09:24:26 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F2BC03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 06:24:26 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id b3so2482677oib.13
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 06:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ckFuwiluEsIPo77mB05k+lc9ijChD1LAduAH0b+Axo=;
        b=ZARq1tZYaNmaYOBgcnxcLJxhtpe1hKIZ+TgYWUmjjbiMDfcjjzJuaqlTKP59fSMiIg
         L+vuifLK7+cvNt5Q7GyJRJVMvVvoUmGLcAyXyOUFBeYbrXT+Mwi8geUmIaaKYoCAU2kB
         8RI67EFtFdi2Zjt9roVh82g4+aMmjCFdRjmhkcml4B226noyOJh3XnGaYheVZO58ABX4
         mRTsVGnVkalqtpSByMFUD0B4uiPB/XXyM1w0tAg0KIFZGby6lPZHBPfT2M4tIDBirdlt
         HxQlTgHOoOrtLSK2AJ10UCxAI9XTfeOeGm9rJ9xIDBab3tgeatYVMlD8uxM5SVNiKKny
         IzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ckFuwiluEsIPo77mB05k+lc9ijChD1LAduAH0b+Axo=;
        b=t9GwqWndXqfzM1zmeufhIOF/ft+nMeCDbBmxlyTYKRlHkJp9gYZnosI4igFm1PV4eI
         9zLMxJTE2GqtCQLuhiGDz/OuxU+abLe1FUcibPrFPr8s5Fn8xSZRQuhDVu24ghs1caZW
         yurESQraELcX7Wz3gMOa8JPRqqxHkxvTpLgPqDHQPI2g04baov3TIkpQNmAOxwBpqqLy
         /0dSCSZhQfbCPLe5CcuNSs1Y4IV1dMjclgq5cQr/A8D8WrcL4S4ifd1gsg4xpjs/TqLf
         EVKWbbW0ONvTam7+96wulUcmiSoJDA1XyAuJ2IkpFNNnJiYDW6PySqNyciXzsz0YxRVh
         7YWg==
X-Gm-Message-State: AOAM531lcgvel2KSW50O8MfBu8Qpfw9OmbH/kCh0hXfroVn5Vq++nDEn
        Xf9Ny4PZdESSw0uqx9HjBu49MPc+CqCcu8JQRt3wLe5n
X-Google-Smtp-Source: ABdhPJy7vm0Ubmp6VWKcKGWAAIwXA3bYYEb7lVMYJuvTwAAsk00Hpv6ZcZSv4Ex7l6cQTJnHQZe+c38Dxvuxtuzy+FU=
X-Received: by 2002:aca:c704:: with SMTP id x4mr5462882oif.92.1590758665797;
 Fri, 29 May 2020 06:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTNZ=gcw5w3FFEs9KiuSrUBhbYLVc=sZq0N4ZEGCem1Zg@mail.gmail.com>
 <20200520163421.27965-1-william.c.roberts@intel.com> <20200520163421.27965-2-william.c.roberts@intel.com>
 <CAFqZXNsV8fUeA-tT4kMtmaNaDK6_LkqvftY-SF7+RUrSBkWUvA@mail.gmail.com>
 <CAEjxPJ7HwA_5E6vCrtRfKK=Lpppp-WEbBa_5cVJvzH7fLSGD_A@mail.gmail.com>
 <CAFqZXNuOTsPrE-0D7OD7jZ4ETWgwW4HCVywnooJs4Q4Qk3d5EQ@mail.gmail.com>
 <CAFftDdqnrPr32GW71aRgXu8akvMAu3FG5L7B2fp4GzBs0=_Z9g@mail.gmail.com>
 <CAFqZXNvc-J0=wpFnNzCxiq80e-hY=5Tubu84-KkPm5nAfgaYRQ@mail.gmail.com> <CAFftDdqqvDPGBHdVXWU5G+LuFMVHciRJpgnRRnDdSzpWQo7wog@mail.gmail.com>
In-Reply-To: <CAFftDdqqvDPGBHdVXWU5G+LuFMVHciRJpgnRRnDdSzpWQo7wog@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 29 May 2020 09:24:14 -0400
Message-ID: <CAEjxPJ7nX5uB=aaVsRzJkN2bWArS721SQ8=Ma=VjnRkvZzpCtA@mail.gmail.com>
Subject: Re: [PATCH v2] ci: run SELinux kernel test suite
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, May 24, 2020 at 12:18 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Fri, May 22, 2020 at 2:40 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Thu, May 21, 2020 at 4:12 PM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > > On Thu, May 21, 2020 at 7:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > On Thu, May 21, 2020 at 2:52 PM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > [...]
> > > > > Last I looked, his script builds and installs the userspace code on
> > > > > top of the Fedora libraries and programs (make LIBDIR=... install...)
> > > > > and then runs the testsuite.  That was my suggestion.
> > > >
> > > > Ah, yes, I can see that line now. Sorry, somehow I missed it before.
> > > >
> > > > > While it is the
> > > > > kernel testsuite, it exercises a lot of SELinux userspace
> > > > > functionality that isn't tested by the userspace tests.
> > > >
> > > > OK, I suppose it's better than nothing...
> > > >
> > >
> > > Stephen pointed out the additional ways userspace gets tested, and
> > > perhaps my title and description
> > > of the patch could be better. But the main point is to increase the
> > > test coverage
> > > and perform the testing steps we expect are done before a release in
> > > the CI. We should have
> > > the testing coverage and the confidence to release userspace from master at any
> > > point. We also have forward facing proof that tests are being executed
> > > and we can make sure
> > > nothing regresses.
> > >
> > > My ultimate goal here, is to help make sure that if Petr gets hit by a
> > > bus, releases will
> > > move forward without worry and without any change in quality among the various
> > > maintainers.
> > >
> > > Additionally, we pick up some cross project testing and can find other
> > > surprises.
> >
> > Ah, so you want to move an integration test, which we would normally
> > run only before release, down to per-commit testing, which is fine
> > because it is quite fast... OK, it started to make sense to me now :)
>
> Exactly, plus we pick up a little more test coverage on the userspace bits
> by swapping out what's installed in the VM with the current build and running
> the tests. The speed is less important, it's just fast enough where our CI isn't
> going to take years to complete. CI doesn't need to be super snappy per se,
> but it also cannot take a fortnight.
>
> >
> > If I find time I'll have a closer look at the scripts. I already see
> > some tiny possible improvements... I have Nicolas's last comments
> addressed and staged, so ill wait a few days and see what you come
> back with and re-send a V3.

This is looking good to me.  Only questions I have are:
1) Have you confirmed that a testsuite failure within the VM gets
correctly propagated up and treated as a failure by travis-ci itself?
2) Have you seen any problems with instability in running of the tests
due to the additional complexity and time?  I've certainly already
seen instances where travis-ci of selinux or selinux-testsuite fails
randomly due to timeouts or something when downloading external
components.
