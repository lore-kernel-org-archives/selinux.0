Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7718C433E0
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 15:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D78D20776
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 15:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWqcSH+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgE2PeH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 11:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2PeG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 11:34:06 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E41C03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 08:34:06 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p5so1777146ile.6
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 08:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2piG4a0zF0OPpCNb3xoei2Eyh+TNaVAoHX1B1v3+D3o=;
        b=TWqcSH+Z8BvMGnmCZ5lOhE2MhuqDNYR7U6tSmxysBcEZOC8o5R1P3MPX/yXm+cn0OC
         7hYZo1KoBPrt7Ed59lJnwg15uPt1IERMRL4nRnU12GaBkqIuWHWIUembuYf7EDO09vqc
         4VaYIrV9ICtdLkghm3RXdD3TqMxB4H6MC0dw96V2c1vCMH/EH9QrsVIUlu/0rr/9R4AJ
         D8Wd3FQUxZqohqLikldisiniVRpeBkOmvXdjhjUX3k3sw6+A3FD5vh4tjXnMb6nsPViT
         uyY9U5bMzkJFrJOjLkylxwEg7zLEHD3/o+gYSlX9CLh8GTyDNfq32QZZDEQBazOPLzqc
         FpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2piG4a0zF0OPpCNb3xoei2Eyh+TNaVAoHX1B1v3+D3o=;
        b=NgwAMaB+L3Dt5fpcl7xJ9Dv1Y4YWQ5xNlC/GZ/0R4WBmH8yREvuH19lOWmbTEiBwQP
         U72DmUndl6BnVXY60rQSBlWML4WfUPFVGmHeGN8zxq//4Cw6TOu8IMEiVkMumBMiUi5J
         X0rTpGcSLWaPnOTlgU5o2qliQn6Sz6EnKf5HqSNnYyHO7hsuZFUlzbtzh1tqutNlLBFx
         WfBsjJxRqxnOTdWfgm5Jug4OHwomTZeNM5FWqNwjxhiZkYhkep4vcN+Wc09X0dDqNOfu
         v8Mj4gTeTooozJoLesNsHXrIugF6kwI3+TADH0ktujxl0vllioZQ+n5MLsAPkyAu8GyW
         TyYw==
X-Gm-Message-State: AOAM532q3QNRc77mwYO4tCCH9Kvp0cnbS2abGXlful3GbsQp2Z5doKEn
        WO8TUyp6/PXQg/pUaeC1ZUtBzIJKoo2akjr8GJD7dVjt
X-Google-Smtp-Source: ABdhPJzZRp5pc8QZWt+uj7gvA34gSxWpITTJEjWOG1t7orW0aqK2oKR5RWQSWXDxERB/J6IpGpp6dUTi3ps3yn0FEco=
X-Received: by 2002:a92:c704:: with SMTP id a4mr7940365ilp.163.1590766445546;
 Fri, 29 May 2020 08:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTNZ=gcw5w3FFEs9KiuSrUBhbYLVc=sZq0N4ZEGCem1Zg@mail.gmail.com>
 <20200520163421.27965-1-william.c.roberts@intel.com> <20200520163421.27965-2-william.c.roberts@intel.com>
 <CAFqZXNsV8fUeA-tT4kMtmaNaDK6_LkqvftY-SF7+RUrSBkWUvA@mail.gmail.com>
 <CAEjxPJ7HwA_5E6vCrtRfKK=Lpppp-WEbBa_5cVJvzH7fLSGD_A@mail.gmail.com>
 <CAFqZXNuOTsPrE-0D7OD7jZ4ETWgwW4HCVywnooJs4Q4Qk3d5EQ@mail.gmail.com>
 <CAFftDdqnrPr32GW71aRgXu8akvMAu3FG5L7B2fp4GzBs0=_Z9g@mail.gmail.com>
 <CAFqZXNvc-J0=wpFnNzCxiq80e-hY=5Tubu84-KkPm5nAfgaYRQ@mail.gmail.com>
 <CAFftDdqqvDPGBHdVXWU5G+LuFMVHciRJpgnRRnDdSzpWQo7wog@mail.gmail.com> <CAEjxPJ7nX5uB=aaVsRzJkN2bWArS721SQ8=Ma=VjnRkvZzpCtA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7nX5uB=aaVsRzJkN2bWArS721SQ8=Ma=VjnRkvZzpCtA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 29 May 2020 10:33:54 -0500
Message-ID: <CAFftDdo0aU5NTMhkhSXCQnKAGWgaQCghHOsg4MtVjwzZWdz2+w@mail.gmail.com>
Subject: Re: [PATCH v2] ci: run SELinux kernel test suite
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 29, 2020 at 8:24 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sun, May 24, 2020 at 12:18 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > On Fri, May 22, 2020 at 2:40 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > On Thu, May 21, 2020 at 4:12 PM William Roberts
> > > <bill.c.roberts@gmail.com> wrote:
> > > > On Thu, May 21, 2020 at 7:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > >
> > > > > On Thu, May 21, 2020 at 2:52 PM Stephen Smalley
> > > > > <stephen.smalley.work@gmail.com> wrote:
> > > [...]
> > > > > > Last I looked, his script builds and installs the userspace code on
> > > > > > top of the Fedora libraries and programs (make LIBDIR=... install...)
> > > > > > and then runs the testsuite.  That was my suggestion.
> > > > >
> > > > > Ah, yes, I can see that line now. Sorry, somehow I missed it before.
> > > > >
> > > > > > While it is the
> > > > > > kernel testsuite, it exercises a lot of SELinux userspace
> > > > > > functionality that isn't tested by the userspace tests.
> > > > >
> > > > > OK, I suppose it's better than nothing...
> > > > >
> > > >
> > > > Stephen pointed out the additional ways userspace gets tested, and
> > > > perhaps my title and description
> > > > of the patch could be better. But the main point is to increase the
> > > > test coverage
> > > > and perform the testing steps we expect are done before a release in
> > > > the CI. We should have
> > > > the testing coverage and the confidence to release userspace from master at any
> > > > point. We also have forward facing proof that tests are being executed
> > > > and we can make sure
> > > > nothing regresses.
> > > >
> > > > My ultimate goal here, is to help make sure that if Petr gets hit by a
> > > > bus, releases will
> > > > move forward without worry and without any change in quality among the various
> > > > maintainers.
> > > >
> > > > Additionally, we pick up some cross project testing and can find other
> > > > surprises.
> > >
> > > Ah, so you want to move an integration test, which we would normally
> > > run only before release, down to per-commit testing, which is fine
> > > because it is quite fast... OK, it started to make sense to me now :)
> >
> > Exactly, plus we pick up a little more test coverage on the userspace bits
> > by swapping out what's installed in the VM with the current build and running
> > the tests. The speed is less important, it's just fast enough where our CI isn't
> > going to take years to complete. CI doesn't need to be super snappy per se,
> > but it also cannot take a fortnight.
> >
> > >
> > > If I find time I'll have a closer look at the scripts. I already see
> > > some tiny possible improvements... I have Nicolas's last comments
> > addressed and staged, so ill wait a few days and see what you come
> > back with and re-send a V3.
>
> This is looking good to me.  Only questions I have are:
> 1) Have you confirmed that a testsuite failure within the VM gets
> correctly propagated up and treated as a failure by travis-ci itself?

Yes, when I was testing and didn't have SCTP support, the test suite
would fail and propagate back.

> 2) Have you seen any problems with instability in running of the tests
> due to the additional complexity and time?  I've certainly already
> seen instances where travis-ci of selinux or selinux-testsuite fails
> randomly due to timeouts or something when downloading external
> components.

No, and I did a bunch of additional runs, like 10-12 and never saw additional
failures. I see some of those intermittent travis CI failures with all
my projects
on Travis, but I don't see this as adding any more issues. Timeouts are caused
by nothing sent to stdout for 10 mins (IIRC), so we should be good there.

Im just waiting on Ondrej, he said he had some feedback and I was gonna send
round 3. If I don't here anything back on Monday ill send round 3.
