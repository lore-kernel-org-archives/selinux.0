Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E4FC433FE
	for <selinux@archiver.kernel.org>; Thu, 10 Dec 2020 09:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F139323DE3
	for <selinux@archiver.kernel.org>; Thu, 10 Dec 2020 09:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgLJJas (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Dec 2020 04:30:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29726 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732626AbgLJJaq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Dec 2020 04:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607592559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l4vrhzWNoJHmLpVaGHaEoezK1uszyDfN0ghXoshqirg=;
        b=SxwrusYdZA7bK26ztmgTwp3DKuoVanoJSs2A9vk2RxrGhQU4VijcIQeWm9wD/fuoGHpxA1
        ZfVcaHwIfTfuNbR61vgNbNYUfRXvYOf7UyGdbT/YJfnWvDAu4e75ggDvG1coeqpLRvALbO
        kR1fezutB9eNvRvQVgJxdh1v3tWZQ7U=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-KqiDgwREN92NSZNxhhWJXQ-1; Thu, 10 Dec 2020 04:29:15 -0500
X-MC-Unique: KqiDgwREN92NSZNxhhWJXQ-1
Received: by mail-lf1-f71.google.com with SMTP id v26so274823lfi.9
        for <selinux@vger.kernel.org>; Thu, 10 Dec 2020 01:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l4vrhzWNoJHmLpVaGHaEoezK1uszyDfN0ghXoshqirg=;
        b=WfVDHmZEj+OXMGBu198ClM9SKuJFVbeJae/oGs506spWK/32QUqrwdFYWtX/1/3Pgh
         U+FbYXuGa4aQgLYoHteEgLSBWEJGtlfOH2xtTqDDlynAkhyYOmQe+f5jFyOHesjCH2qc
         xt8jKlT0JVgahJA+vmCMKLHDcvbPhUk51OkoM160yOKzzLfxcI4DjG9g+22ecTI3k/6/
         4yl5ZTFCpPvy5NA9tQRAi2nQ201sHL1H0qarhfpZArvOIRIvoEIlEg8YEDFPKyufBAwI
         h26aSFzjsdfhvhpvPXW4sog3QKeZMztyrA8jIDH43EJ/kIvAUuU97DY02K0NaCONT1bP
         KavQ==
X-Gm-Message-State: AOAM533yIsZYhxkrm5pFbSwDNd06VLOU0lAGrEncS04QBMXd3p6ZCzI4
        g5VM3tvpeqIYXYiC2Rwr2f4OsOGB7RYcK9TIwQcwm9gGx7iywaXHKdsCWT8NuqaP81+UHZbazAF
        XjAvjt4RcTwLK1dVm2qJ7ElPkju61JmJEuQ==
X-Received: by 2002:a19:be0d:: with SMTP id o13mr2261197lff.517.1607592554160;
        Thu, 10 Dec 2020 01:29:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsMTw2C+24umKkyoyyP3FrkU6h3nIwuxz7VFQfeCgqBOHbdSO8cf9Sq3BfpJIXIQ/r2KrS1tvvXQF2/gy9Cvw=
X-Received: by 2002:a19:be0d:: with SMTP id o13mr2261192lff.517.1607592553939;
 Thu, 10 Dec 2020 01:29:13 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNsGabHBfV36nNAVLJgEzjkBev-O3YZ1vnmXyVoaDdjiHQ@mail.gmail.com>
 <CAP+JOzSWW6HFtN1VSyvKacKeZdtRkBo7TWR7JS4a0ewiopuKww@mail.gmail.com>
 <CAHC9VhSYt86rQJGg9JFD1ubL4N3PNmLg02sACOvRNHr94=41dg@mail.gmail.com>
 <CAP+JOzQ-s9ASgqFt7HVyY1R7JKQ85Ee-=iou0C5xRRvaSZo52Q@mail.gmail.com> <CAHC9VhQkSA5VteHfu8TyBp7wqDspoLCOP+sB7vaV4XCQ8vwBeA@mail.gmail.com>
In-Reply-To: <CAHC9VhQkSA5VteHfu8TyBp7wqDspoLCOP+sB7vaV4XCQ8vwBeA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 10 Dec 2020 10:29:02 +0100
Message-ID: <CAFqZXNsfomoMTr+uhisdsj75c7ZdXmGCiDZBsDwtLUpkwEA76w@mail.gmail.com>
Subject: Re: virtiofs and its optional xattr support vs. fs_use_xattr
To:     Paul Moore <paul@paul-moore.com>
Cc:     James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Zdenek Pytela <zpytela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 10, 2020 at 3:40 AM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Dec 9, 2020 at 10:37 AM James Carter <jwcart2@gmail.com> wrote:
> > On Tue, Dec 8, 2020 at 6:45 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Mon, Dec 7, 2020 at 12:17 PM James Carter <jwcart2@gmail.com> wrote:
> > > > On Mon, Dec 7, 2020 at 9:45 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > >
> > > > > Hi everyone,
> > > > >
> > > > > In [1] we ran into a problem with the current handling of filesystem
> > > > > labeling rules. Basically, it is only possible to specify either
> > > > > genfscon or fs_use_xattr for a given filesystem, but in the case of
> > > > > virtiofs, certain mounts may support security xattrs, while other ones
> > > > > may not.
> > > > >
> > > > > So we can't use the xattr support by adding fs_use_xattr virtiofs
> > > > > (...); to the policy, because then a non-xattr mount will fail
> > > > > (SELinux does a mount-time check on the root inode to make sure that
> > > > > the xattr handler works), but we also don't want to stay on genfscon,
> > > > > because then we can't relabel files.
> > > > >
> > > > > So my question is how to best address this? One option is to use a
> > > > > similar "hack" as for cgroupfs; i.e. do a kind of mixed genfs-xattr
> > > > > labeling, but that's ugly and requires hard-coding another FS name in
> > > > > the selinux code. The only other alternative I could come up with is
> > > > > to add a new FS labeling statement that would specify some kind of
> > > > > mixed genfscon / fs_use_xattr behavior. That would be a better
> > > > > long-term solution, but leads to more questions on how such statement
> > > > > should actually work... Should it work the cgroupfs way, giving a
> > > > > default label to everything and allowing to set/change labels via
> > > > > xattrs? Or should it rather just detect xattrs support and switch
> > > > > between SECURITY_FS_USE_XATTR and SECURITY_FS_USE_GENFS behavior based
> > > > > on that? In the latter case, should the statement specify two contexts
> > > > > (one for fs_use_xattr and another one for genfscon) or just one for
> > > > > both behaviors?
> > > >
> > > > I don't think adding a new statement is necessary. It seems like
> > > > allowing both fs_use_xattr and genfscon rules for the filesystem in
> > > > policy and then using the fs_use_xattr rule if xattrs are supported
> > > > while falling back to the genfscon rule if they are not would do what
> > > > you need.
> > >
> > > That seems reasonable to me so long as this ambiguity is okay with the
> > > folks who do policy analysis.  Thinking quickly I'm not sure why it
> > > would be a problem, but the thought did occur while I was typing up
> > > this reply ...
> >
> > I don't think that it would cause a problem with policy analysis. I
> > think that you would just assume the genfscon rule is being used,
> > since it is less fine-grained. It wouldn't be much different from how
> > booleans are handled.
>
> Makes sense to me.  Thanks Jim.

Okay, so I'll look into switching between use_xattr and use_genfs
based on the availability of xattr support and the presence of
corresponding rules in the policy. Thanks everyone for the fruitful
discussion!

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

