Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF8CC433DF
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 20:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 553D4205CB
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 20:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9NSyfbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgEOUva (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 16:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgEOUv3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 16:51:29 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A56C061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 13:51:29 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e8so3915078ilm.7
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 13:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nn4eV8EHys7MortS9G7LljRGY0FALC+3vU3a78PKDJI=;
        b=r9NSyfbFN0Pcso7MKARLUpPsNR5rZkgHTXjinoTA2HSrgBE5gySeVIQZCfCsMX0UXN
         26MoJ7/j8JvXmJ19HY+6s+gL9qJIrG86lAao3BpatDi2ire780/o9ZkzePJDcqCq1dDF
         DImtSJOgfAZpmNgGTMvrpHmw/2QrnsDgbX0uxfLim6bpUdAFWyHPItJPMpulntoOWlPo
         MpRd2ZHSzK8oZGJpHXLL1206Cx7+m4scmVreVoATEzdrsX7/C6dT5UTHBG6lA+fT/wV7
         ds/VfPei9aKXgCD7T1e2yb/D46C1iYsfPNiHBXGEwwW7VyvOKI/X+NR6kKbBnXni31u7
         iEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nn4eV8EHys7MortS9G7LljRGY0FALC+3vU3a78PKDJI=;
        b=O1/c+8WxE/YziQUbHgjqx+3w9bNV63n5HkXfq6IuQiOsuTRGNOFQeZ/jLhp4PTakpS
         MPjByhBznFAa10gm/6eF5ngRA84LD4VbwLJ6J4bx7g7MYucv6YW9fWF7YXZ2SWwGbMQ6
         xUJrv6SPkcKqIyA4mRTPQb2g9cup2Y4oS0KCzOz/yc7znoxECFA6S7kyGCfpUA1VTS7D
         r7Gev5pvADx4Nxv3BBJlm9r53jmngvVodsGobW9vTMk1ZTgPjLPyXjEVRv0CTvKBTdE3
         zUNoKgznKXVDfCROSP4JusSwVrfI9Q+512qSK6SlteZsuKcreiKKFxDk4E+EBLWmCrBo
         8COw==
X-Gm-Message-State: AOAM533AcCGf1kLsriy0NQTWh4T/+MPmPZP7b8SgAh39oQr9DB24m9RC
        rcxK2JUyxKWojkcFn4YhnxCOXZWMFzQlyRyGDQE=
X-Google-Smtp-Source: ABdhPJwlVmTvmi5gW7eW5AZibPa751iQ8XRN0MTCsBJfkrHJS4s5kN+Ht/bfenlXHJfpNYeaTbRg4Tb1XUVzkkdfYO8=
X-Received: by 2002:a92:d744:: with SMTP id e4mr5201210ilq.174.1589575888654;
 Fri, 15 May 2020 13:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <3581425.j52oWYpJar@liv> <20200407085922.GA438349@workstation>
 <20200422065053.GA167999@workstation> <CAHC9VhQUmY=ue3zWdTnE1Ehi90Lj3077sLbu+jyaWoAVKuKyeQ@mail.gmail.com>
 <CAFftDdo1hqbacU2TD6zQp_t_KJq-KS5pWBMr89c4HA3=aUdUbQ@mail.gmail.com>
 <20200423150039.GC204116@workstation> <CAFftDdq_g_rUy=KFh_gOEXoVxkCgz9qWzR17d4Mt1qVChoVLjg@mail.gmail.com>
 <CAEjxPJ5qm8P0jmRvQNavDsrWCDDf7yCeRQ1orp_S63u-2EfBoA@mail.gmail.com> <CAFftDdopFfNynCNTnzo34XNVc=t49=82NOQP8OFq+fXLC9Ghtw@mail.gmail.com>
In-Reply-To: <CAFftDdopFfNynCNTnzo34XNVc=t49=82NOQP8OFq+fXLC9Ghtw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 15 May 2020 15:51:17 -0500
Message-ID: <CAFftDdqAZE-DW1uMbQcx3v0xrqR_qUaO70mida=7STQPTEYPCg@mail.gmail.com>
Subject: Re: Fedora VM On Travis for Testing
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        Jason Zaman <jason@perfinion.com>,
        Steve Lawrence <slawrence@tresys.com>,
        Chris PeBenito <pebenito@ieee.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        James Carter <jwcart2@tycho.nsa.gov>,
        Joshua Brindle <brindle@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 14, 2020 at 5:31 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Thu, May 14, 2020 at 5:21 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, May 14, 2020 at 5:03 PM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > >
> > > I just wanted to lay out a demo of a Fedora 32 cloud VM image booting
> > > on Travis with execution happening in the Fedora VM.
> > > The Fedora VM contains the selinux source code for that particular
> > > travis build, so it has the PR patches, etc.
> > > The VM has networking.
> > >
> > > The build logs for the Travis run are here:
> > >   - https://travis-ci.org/github/williamcroberts/selinux/builds/687185489
> > >
> > > Which comes from my git tree here:
> > >   - https://github.com/williamcroberts/selinux/tree/kvm-fedora-testing
> > >
> > > Note that it's super messy, I need to go through and cleanup both the
> > > patch and the git
> > > history. I also should verify the downloaded image is signed for the VM.
> > > Also note that I may rebase/squash my git branch at any time.
> > >
> > > Petr started a release document here:
> > >   - https://github.com/bachradsusi/SELinuxProject-selinux/blob/RELEASE/RELEASE_PROCESS.md
> > >
> > > I'd like to gather feedback, and perhaps more comments on:
> > > 1. Is this CI approach worth continuing?
> > > 2. Comments on the CI scripts (I have no idea what I am doing, common issue)
> > > 3. Comments, patches, suggestions on what tests to run in this CI environment.
> > > 4. More information in in the RELEASE_PROCESS.md file. I made some
> > > comments there
> > >     as well on ideas.
> > >
> > > My goal here is that a release can occur if CI is passing without
> > > worry, and that
> > > we automate manual steps as much as possible. This way, if we get hit by a bus
> > > releases can occur without much effort.
> >
> > I'm amazed travis-ci supports all of that (especially for free).
> > Hopefully you aren't violating their terms of use.
>
> Not that I am aware of and I read their terms of use.
> https://docs.travis-ci.com/legal/terms-of-service/
>
> They don't seem to limit what you can do, it seems to be centered
> around availability, liability and support.
>
> I stumbled into other projects on github that were running virsh commands
>
> > The biggest thing I'd add is to build and install the selinux
> > userspace in place of the stock Fedora versions (sudo make
> > LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap relabel) and
> > then build and run the selinux-testsuite to exercise the SELinux
> > userspace and kernel runtime functionality.  Other things to possibly
>
> Perfect, that's the info I was looking for.
>
> > add would be rebuilding upstream refpolicy (similar to its
> > .travis.yml) with the latest userspace, rebuilding and running setools
> > (but until we decouple it from libsepol internals this will
> > periodically break).
>
> If it breaks, it breaks, just means we need to merge something or actually
> fix it properly IIUC.

So I just wanted to share, that the test suite is running with a PASS on
a travis CI instance with a nested KVM of Fedora32.

https://travis-ci.org/github/williamcroberts/selinux/builds/687592735

Next week I'll clean this up and make sure that its working consistently.
I've had 2 hangs when building the libselinux src, not sure why..
I don't want a CI check that'd flaky, so I want to do some more testing.

An example is on this build:
https://travis-ci.org/github/williamcroberts/selinux/builds/687496735

I'm gonna assume I need to allocate more memory and im gonna bump
the vcpu count as well to match the host. As Travis gives us two cores.

Bill
