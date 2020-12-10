Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EC5C4361B
	for <selinux@archiver.kernel.org>; Thu, 10 Dec 2020 02:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615B423CD4
	for <selinux@archiver.kernel.org>; Thu, 10 Dec 2020 02:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgLJCku (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Dec 2020 21:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbgLJCku (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Dec 2020 21:40:50 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6D3C0613CF
        for <selinux@vger.kernel.org>; Wed,  9 Dec 2020 18:40:10 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id f23so5193954ejk.2
        for <selinux@vger.kernel.org>; Wed, 09 Dec 2020 18:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XunQ2XM8DV9/+jhrwYW3nI7RCKvCoq6ggkX2GiMUXYk=;
        b=vRM0hGIz9KD/DhCwxtyIWjbc9lbnRdtYyzC9pbMSRbf+PYVUFu2ZRF3XpHR1vWDnbm
         LvwuBics8YP4bE4tsC3vO0T5IG5FoU9rr2DhamRSv29GtJJq1ueay3jxVcACv2CtN8bd
         zHjt2uBGszFFQKHlutb6y+AONI4P6wVUZfUAzJ4eDkw3wKKqmN5aZPYKwVLWtDTYxjxB
         1EZ3vB9U3QMeK22XJf6X+M5lTx929AkZwdxFfU509n+tQUdEX+mAxXd9bFd6bLZ/GYfV
         1xVKOHcqNGHxjiA1XNydDbFmzRVKDI5E67rGOgM2t/RIVyOyCA7kRrb0xHfitRAaoHUH
         Q2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XunQ2XM8DV9/+jhrwYW3nI7RCKvCoq6ggkX2GiMUXYk=;
        b=GhxxyUXHivi/lAF8pkIPYrJFC1HiZJDeqJTCv0/aPVrWmCFskSTm+BROnfuc+hwJcJ
         oWZURgMtMRXyg4X1KINgODUx91oy3BMhio4w5mHl32dRM07FEbvLGWW7Dhmsn1grWShO
         Pk0WgRTlrZeAHhHLMmIMtR2i/EUsV1vatmdXACPqHt0OruUHeAH9fBCgX/ehV96EaMRC
         nEX5bNCk1dgpoECigmpS5pgQmOCxjQM55AzBYZFOwhRsWjCAuKQX5GWZynd/BCU1lYA9
         +hemqAT1sIBEyP9++ycMEnvI2h7Yp5Mhi4dA1rxwIG2k2Jv3Ak8/hlb/ytcGLOr7lL7i
         PFNA==
X-Gm-Message-State: AOAM530gCcFVwcaGQsTO/Sy4KYfyOjQ5W+6l3RDKaTEtIcEM1p8skmrl
        Y2ZJHLjBkIRn0VIAyxfMHnkZauQdcUlptsuTVS3U
X-Google-Smtp-Source: ABdhPJyfWQlv/winyY/Kbe619FqMaWVf7T91OvrstmgRH67Xu7D8rEQzGiiytNs2O42b4pJo+4X+KN42+9zZoOY+J84=
X-Received: by 2002:a17:906:1393:: with SMTP id f19mr4496424ejc.431.1607568008987;
 Wed, 09 Dec 2020 18:40:08 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNsGabHBfV36nNAVLJgEzjkBev-O3YZ1vnmXyVoaDdjiHQ@mail.gmail.com>
 <CAP+JOzSWW6HFtN1VSyvKacKeZdtRkBo7TWR7JS4a0ewiopuKww@mail.gmail.com>
 <CAHC9VhSYt86rQJGg9JFD1ubL4N3PNmLg02sACOvRNHr94=41dg@mail.gmail.com> <CAP+JOzQ-s9ASgqFt7HVyY1R7JKQ85Ee-=iou0C5xRRvaSZo52Q@mail.gmail.com>
In-Reply-To: <CAP+JOzQ-s9ASgqFt7HVyY1R7JKQ85Ee-=iou0C5xRRvaSZo52Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Dec 2020 21:39:57 -0500
Message-ID: <CAHC9VhQkSA5VteHfu8TyBp7wqDspoLCOP+sB7vaV4XCQ8vwBeA@mail.gmail.com>
Subject: Re: virtiofs and its optional xattr support vs. fs_use_xattr
To:     James Carter <jwcart2@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Zdenek Pytela <zpytela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 9, 2020 at 10:37 AM James Carter <jwcart2@gmail.com> wrote:
> On Tue, Dec 8, 2020 at 6:45 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Dec 7, 2020 at 12:17 PM James Carter <jwcart2@gmail.com> wrote:
> > > On Mon, Dec 7, 2020 at 9:45 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > Hi everyone,
> > > >
> > > > In [1] we ran into a problem with the current handling of filesystem
> > > > labeling rules. Basically, it is only possible to specify either
> > > > genfscon or fs_use_xattr for a given filesystem, but in the case of
> > > > virtiofs, certain mounts may support security xattrs, while other ones
> > > > may not.
> > > >
> > > > So we can't use the xattr support by adding fs_use_xattr virtiofs
> > > > (...); to the policy, because then a non-xattr mount will fail
> > > > (SELinux does a mount-time check on the root inode to make sure that
> > > > the xattr handler works), but we also don't want to stay on genfscon,
> > > > because then we can't relabel files.
> > > >
> > > > So my question is how to best address this? One option is to use a
> > > > similar "hack" as for cgroupfs; i.e. do a kind of mixed genfs-xattr
> > > > labeling, but that's ugly and requires hard-coding another FS name in
> > > > the selinux code. The only other alternative I could come up with is
> > > > to add a new FS labeling statement that would specify some kind of
> > > > mixed genfscon / fs_use_xattr behavior. That would be a better
> > > > long-term solution, but leads to more questions on how such statement
> > > > should actually work... Should it work the cgroupfs way, giving a
> > > > default label to everything and allowing to set/change labels via
> > > > xattrs? Or should it rather just detect xattrs support and switch
> > > > between SECURITY_FS_USE_XATTR and SECURITY_FS_USE_GENFS behavior based
> > > > on that? In the latter case, should the statement specify two contexts
> > > > (one for fs_use_xattr and another one for genfscon) or just one for
> > > > both behaviors?
> > >
> > > I don't think adding a new statement is necessary. It seems like
> > > allowing both fs_use_xattr and genfscon rules for the filesystem in
> > > policy and then using the fs_use_xattr rule if xattrs are supported
> > > while falling back to the genfscon rule if they are not would do what
> > > you need.
> >
> > That seems reasonable to me so long as this ambiguity is okay with the
> > folks who do policy analysis.  Thinking quickly I'm not sure why it
> > would be a problem, but the thought did occur while I was typing up
> > this reply ...
>
> I don't think that it would cause a problem with policy analysis. I
> think that you would just assume the genfscon rule is being used,
> since it is less fine-grained. It wouldn't be much different from how
> booleans are handled.

Makes sense to me.  Thanks Jim.

-- 
paul moore
www.paul-moore.com
