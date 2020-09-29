Return-Path: <SRS0=dH2y=DG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FA1C4727C
	for <selinux@archiver.kernel.org>; Tue, 29 Sep 2020 14:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66B52065C
	for <selinux@archiver.kernel.org>; Tue, 29 Sep 2020 14:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMHULWMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgI2OSo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Sep 2020 10:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbgI2OSo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Sep 2020 10:18:44 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499B4C061755
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2020 07:18:44 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 95so4536450ota.13
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2020 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+UVKC/poEJnzesIwE/JKVbUov5upwOn1Zx4tDVo03Y=;
        b=WMHULWMQlJXRu/rtlN8k7jvPqAuoJGqrODnvzKspCDRUSjez/VEM52yMeeoeYfyUWa
         s1vuTRDZpkPQnd8/c1LFAD/egXWMy83clI1ws8S3XABRyYfxcG+3K1sZ37rlwREXDKPv
         /l8mqXHWn9t7rklwSsqaW5CX50D7UX2eNK/EbPi/gY+4/3xiA1Uw9QJD4/R7OaWErKba
         YQXhJDcbhhRDjlH15nhcJvYCTIYmT2VRWD9wg150H2yPHvuptz2O9KddPmonlGbDni8Y
         AbRe0QwNXYwhPviyD0Iux3LX3CA56zVRthCmf9ebQKyOJ8t3+u9y16QC9xuvFJXhakyf
         mbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+UVKC/poEJnzesIwE/JKVbUov5upwOn1Zx4tDVo03Y=;
        b=fl+3VGW2geR8wegI0075Gs+KZbcqFL6mrb+mr4vAB4HI427kCfNDoIYnqs2G7AMZ9R
         ISbwyhA6fegmn3KuRxyC0TqBmkxpcCUQEgw/0N2dKcZUx2DV5DAYW1lK4zhfe6Gr8k+C
         TKHFUbw6DY1yEAxyzdaywYbrrhN6KAfG+DX1ng1K1DGJlmTel0e5DZNW1zooJ9bH7z0c
         Giq0QS5zhSLjytkhvzLt/jFlOGCy9PLO2NpG8VnDfKwHNspiLcTQQuVbKmC1mbD+wd4M
         +XsXY902pUQ81x1XNdr+Q88R/Bp/VSBug6NUkJWe0hwTbxYjeq1kc/5g+oEZXrx6j+UJ
         s0OA==
X-Gm-Message-State: AOAM532dSfeGQR/KP2PpfxyJHA6LUzOJaC0IseT8xf7e6aWB2aC53mQp
        rkqsW2OZCoz8+jdfzYQitDd0iQPvWGQpBmGXuITbXiqt
X-Google-Smtp-Source: ABdhPJxh30HqNpleC73p+rclSIoBFBivmFRSlA0O3ow+lQO6SBlpHG8pzSahm4ai9aXLFT3FluyiO1zNOgxxV3zonHA=
X-Received: by 2002:a05:6830:1be7:: with SMTP id k7mr2960086otb.162.1601389123583;
 Tue, 29 Sep 2020 07:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200927094243.43673-1-rentianyue@tj.kylinos.cn>
 <20200927094243.43673-2-rentianyue@tj.kylinos.cn> <de004adf-fde6-11f1-fab1-11289788d4ec@gmail.com>
 <CAEjxPJ6z-ZsbsbdpDtOWxJ3_rJPjREKhNXkBn5bV_pYzW7AYnQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6z-ZsbsbdpDtOWxJ3_rJPjREKhNXkBn5bV_pYzW7AYnQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 29 Sep 2020 10:18:32 -0400
Message-ID: <CAEjxPJ7==mkXDKuDw2YueRP+ymoQjPDdCS8Wk7GJfth+CpLqkg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] selinux: fix error initialization in inode_doinit_with_dentry()
To:     =?UTF-8?B?5Lu75aSp5oKm?= <rentianyue@tj.kylinos.cn>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>
Cc:     yangzhao <yangzhao@kylinos.cn>,
        SElinux list <selinux@vger.kernel.org>,
        Tianyue Ren <rentianyue@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 29, 2020 at 9:31 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Sep 29, 2020 at 8:54 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On 9/27/20 5:42 AM, rentianyue@tj.kylinos.cn wrote:
> >
> > > From: Tianyue Ren <rentianyue@kylinos.cn>
> > >
> > > Fix to initialize isec->class with SECINITSID_UNLABELED other
> > > than the from the xattr label when then dentry is NULL when
> > > the filesystem is remounted before the policy loading.
> >
> > Looks like this was broken by commit
> > 9287aed2ad1ff1bde5eb190bcd6dccd5f1cf47d3 ("selinux: Convert isec->lock
> > into a spinlock").
>
> It appears that the broken commit assumed (wrongly) that isec->sid is
> 0 initially, sets sid = isec->sid, and then in the out: path, if (!sid
> || rc) it sets isec->initialized to LABEL_INVALID.  In fact, isec->sid
> is SECINITSID_UNLABELED initially upon selinux_inode_alloc_security(),
> so that !sid test never evaluates to true.  And changing it to compare
> with SECINITSID_UNLABELED wouldn't be safe either since it is possible
> to end up with SECINITSID_UNLABELED without it being invalid.  I think
> your fix resolves the issue with ensuring that we retry upon
> subsequent attempts to access the inode but we should likely fix up
> this code.
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Please fix the patch description (e.g. "Mark the inode security label
as invalid if we cannot find a dentry so that we will retry later
rather than marking it initialized with the unlabeled SID"), add a
Fixes: line with the commit I cited, and re-post correctly with git
send-email so that it reaches the list.
