Return-Path: <SRS0=z4nS=6V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B28C38A2A
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 15:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A6720643
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 15:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3HHRXtb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgEGPWY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 May 2020 11:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725914AbgEGPWX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 May 2020 11:22:23 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B5CC05BD43
        for <selinux@vger.kernel.org>; Thu,  7 May 2020 08:22:22 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id w4so1578308ioc.6
        for <selinux@vger.kernel.org>; Thu, 07 May 2020 08:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WsObPp7fBOgk1/qWiOgnFEHipBROhtsRuo3FJbADJCY=;
        b=F3HHRXtbYWoydna5WUGBuSafZy+XCs5jBR99rCz8vsn+rt1VjjlRYf9bzgpfK+gVdw
         9eBzra5y724doBnZiSqXBUwCcfIgtkKCxCd1YnVSHsDrLC2e58C5m3iHKZ9tyufIKlRN
         Pt3IBWiFMBGefCvuYhXOsafIRpghP0JAI06BGFddJlLJ6BP3xRCdHmYnKgo+7zCg9Eav
         k6SM/TklAGBg7Te3wx/glGJlB0BIVFcgQiH3sUSUlwu3zm+wG7tKtDFK7FfYA1oPHovC
         YOkQf0FIBcZ5J/BV/1TIGTBZFAHJSi/rla2UOPXM0dU19RL4Fruq5nPA3YZcm9Y8SqKD
         6i/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WsObPp7fBOgk1/qWiOgnFEHipBROhtsRuo3FJbADJCY=;
        b=YdkV7mxmfuS+8BhLDKZQsYKfVqmSvXT2ukeN3eGEYLN+AR05x4JqJfOPF7yA0hhfk1
         MXo2D2k7okNoeuO9BM5oXvYBB3ZyJE377N8aAYr3knuNcwOFN/upabPzBvHtKK2JwjAr
         Zrr2+WndTAfklqvCq5yHVanRNes5U/hnsquzLEs/t1xANoN1VmiMCXKcF9LF1DmgThwg
         BSTiHdWP+hEOIOlrR7yFBXZEYhILHofyUk6eUPkq4FJ8o6LRdbRc4hvwKMwDN/WJMA2C
         VerrQhWoF/854drk0ipnzMrYstSk4eZg8xBEpz9MiFJniUTAS9JWbuWzOjeUcni1Eg52
         zg1A==
X-Gm-Message-State: AGi0PubAh9je22MyLd96GKslzzYR5NgM2GDMrB9DsJtQIdUzNBa5qj9G
        wngfECp3F0PLEQKdt0NLoK5pGV3LvvL3grWaK7w=
X-Google-Smtp-Source: APiQypIlTP5ahwlZCvfcOwbu4AGytWbbcgaFN3XoQ8OqyWcs2R0PpbcHzm/o98Yyu4e886iG5JV6HglaBT7hJKRgRys=
X-Received: by 2002:a5e:d506:: with SMTP id e6mr14720036iom.184.1588864940841;
 Thu, 07 May 2020 08:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
 <3838641.zh4Wi6GlAV@liv> <cf747e50-ca5b-429f-1af2-afaa16ee29be@debian.org>
 <1916523.qzzCliNl98@liv> <CAEjxPJ7oXd5EM_hB1tdRKZKLKZoeOh_w8UYevivMC5d1D2G1+w@mail.gmail.com>
 <CAFftDdpygOSWOGNQnbGzGOcKrtsd+3hHsfPY9chM5L90CZGHwg@mail.gmail.com> <CAEjxPJ44XXQibMfT00xU0F2ySTR_1+QjPNU35R6zLqgyakQAQA@mail.gmail.com>
In-Reply-To: <CAEjxPJ44XXQibMfT00xU0F2ySTR_1+QjPNU35R6zLqgyakQAQA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 7 May 2020 10:22:09 -0500
Message-ID: <CAFftDdp61vBDDwwsrDv2c1COc6TR4yD1JoPp9DwzQgqu2-CKqw@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Russell Coker <russell@coker.com.au>,
        Laurent Bigonville <bigon@debian.org>,
        SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

>
> On Thu, May 7, 2020 at 11:02 AM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > >
> > > On Thu, May 7, 2020 at 10:49 AM Russell Coker <russell@coker.com.au> wrote:
> > > >
> > > > On Thursday, 7 May 2020 6:35:11 PM AEST Laurent Bigonville wrote:
> > > > > If people are using preseed installations (kickstart equivalent), I
> > > > > think that enabling SELinux in the installer shouldn't be too difficult
> > > > > (installing the needed packages, modifying the files and relabeling with
> > > > > fixfiles). It's obviously not user friendly, but the question is what's
> > > > > the target here.
> > > >
> > > > If we want to do that properly then I guess we want SE Linux enabled in the
> > > > kernel that the installer uses and then have the policy installed early in the
> > > > installation so the files can have the correct labels from the start instead of
> > > > having a relabel process afterwards.
> > >
> > > That would be good but might be overreach for Debian since SELinux is
> > > not the default there.  It isn't strictly necessary; ever since we
> > > went to using extended attributes for file labels, you can set them on
> > > a non-SELinux-enabled kernel, so the installer can always set them
> > > even if its kernel doesn't enable SELinux.  Optimally they would be
> > > set by the package manager based on file_contexts; that is what rpm
> > > does in Fedora/RHEL.  Or you can always run setfiles after package
> > > installation but before rebooting into the SELinux-enabled kernel.
> > > You don't need to defer labeling until you have SELinux enabled.
> >
> > On Thu, May 7, 2020 at 9:54 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >
> > I found this:
> >   - https://man.sr.ht/builds.sr.ht/compatibility.md
> >
> > It seems to have Fedora-30,31 and rawhide.
> > It seems to be free as well (for now)
> > I would be a little leary using it, seems new, its only in alpha,
> > and looks like it could disappear at any moment.
> >
> > The travis ubuntu to fedora VM might be heavy, but it would at least provide
> > us with something stable... for awhile or we look at getting some
> > better infrastructure support for running a CI job on.
>
> Fedora's own CI infrastructure seems like a better bet for the near
> term wrt testing on Fedora; Petr appears to be already exploring using
> it.

I though the Fedora CI was limiting the amount of testing and
triggering tests, no?
Or is that why he is exploring it to see if we can get around them?

> My goal here though is to improve the level of support outside of
> just Fedora and its derivatives.

Definitely a plus.
