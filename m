Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD0DC54EBD
	for <selinux@archiver.kernel.org>; Fri,  6 Jan 2023 22:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjAFWdU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Jan 2023 17:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjAFWdT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Jan 2023 17:33:19 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C09F85CBC
        for <selinux@vger.kernel.org>; Fri,  6 Jan 2023 14:33:17 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id jl4so3178657plb.8
        for <selinux@vger.kernel.org>; Fri, 06 Jan 2023 14:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RD6ZDoUM0I8vJAaSTRhVYR9EsavHz+CRbGdgjyWSZ0s=;
        b=ecqXT4fVUQPppYh+nOFOJQuOhbP5ZWXP36MzDt+QbBjTxdlC9EY48EPcr4auVEacLA
         CtOvbBF86sbDxOorauKX3Z4TpbYPV+ZmY9di3o1bMbU5GbPT9iSGlDl4TVvCxBK6lz4k
         7YuKhUP5Fq9LkSZY5asRbFyB2LPxv2tH/vcafmRhIa2KGndwGFjqMsQpX2Y0mq84RpfW
         z1Cp6eF9xWunRbukEPppBk1i21zejOC3Zr1IMo1wei5HgLXlkdsYS9k5hgHvrMW4l4eK
         2viyPcet80xamjCB1f1+84vnQnpNbBhzvaFlT8V1g04CmEq9bAo1uOIMQD6YH1/V3jg1
         Q/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RD6ZDoUM0I8vJAaSTRhVYR9EsavHz+CRbGdgjyWSZ0s=;
        b=C8RtyVkWTZ2Fg3VEN4ydCd57mRMJq9MmzBLtpaAj2P0KBZgRcMO0oNIvsW/PnLRrtI
         glZvoiTc0lLiNtU9/ZGPjs9b2SgZOOfhaYbGTgeCULWIX1q8AHNqa3Hq+8YZujCz9Li9
         BXvqHagRyFdg57PH2p3qG6YjQqF2THbnhT2IPGq1yRRMHEM4fWo4dfRBicvlELVXl4Ca
         spA7EbUZkFWvBrfXvpE1f22LitITWWV9K6/P4QpXoMO17nF6zOjcP7mvUYmSzPKFzxlx
         7DcaaY051+6Yjkoa6BcaWVbc/QJCgkZ3B8dUzbqE7vw9z/iWMDS5EuJQZowOOTHH3bvS
         AMjQ==
X-Gm-Message-State: AFqh2kq3m5QH7qq2ZCKpLeJ1kcNY7QR708V68uBoYtX1RRR6c6OgJamu
        MWylqnq9rjoILLQYp1M+XGBg+BmIGRckukA4agav
X-Google-Smtp-Source: AMrXdXu4Xi5uqudWmYRvgmf5UcuvRHwD1XbPIyssTf++MrkiVh6KgdHqvgjiCH1bKr1bHoq7nL7pT4FKrbqLDhTCO08=
X-Received: by 2002:a17:902:cec8:b0:192:6675:8636 with SMTP id
 d8-20020a170902cec800b0019266758636mr2921296plg.15.1673044396858; Fri, 06 Jan
 2023 14:33:16 -0800 (PST)
MIME-Version: 1.0
References: <20221213033948.73512-1-alexander.kozhevnikov@huawei-partners.com>
 <20221213033948.73512-2-alexander.kozhevnikov@huawei-partners.com> <CAHC9VhRHK19tn4wepQsSk2sJKqeoO3Wv7niMePjzk0BFkpra=A@mail.gmail.com>
In-Reply-To: <CAHC9VhRHK19tn4wepQsSk2sJKqeoO3Wv7niMePjzk0BFkpra=A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 6 Jan 2023 17:33:05 -0500
Message-ID: <CAHC9VhRTdkqv2CGbUX0BM4A3Mxda7i2tSVfPBMq=JKxmz79ohg@mail.gmail.com>
Subject: Re: [PATCH 1/1] [RFC] SELINUX: Remove obsolete deferred inode
 security init list.
To:     Alexander Kozhevnikov <alexander.kozhevnikov@huawei-partners.com>
Cc:     linux-security-module@vger.kernel.org,
        jamorris@linux.microsoft.com, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com, artem.kuzin@huawei.com,
        hw.likun@huawei.com, xiujianfeng@huawei.com, yusongping@huawei.com,
        hukeping@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 6, 2023 at 3:30 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Dec 12, 2022 at 10:40 PM Alexander Kozhevnikov
> <alexander.kozhevnikov@huawei-partners.com> wrote:
> >
> > This patch is a proposed code optimization for SELinux:
> >
> > 1) Each inode has SELinux security structure attached
> >    to it, this one need to be initialized at some point.
> > 2) This initialization is done by the function
> >    inode_doinit_with_dentry ( ).
> > 3) In the kernel releases started from some point in the past
> >    this function (2) is always called normally from function
> >    __inode_security_revalidate ( ).
> > 4) Which in turn is always called  from inode_security ( ), which
> >    is a base point for any selinux calls and always called on
> >    any access to any inode except a few special cases when
> >    _inode_security_novalidate ( ) is used.
> > 5) Inode security structure initialization can be done only after
> >    SELinux is fully initialized and policy is loaded.
> > 6) So, for this purpose there was a special defeferred inode security
> >    initialization list protected by a spinlock implemented, which was
> >    populated instead of isec initialization in function
> >    inode_doinit_with_dentry ( ), if it was called before SELinux full
> >    initialization, and processed at the time when SELinux policy load
> >    occurred by calling again inode_doinit_with_dentry ( ) on each inode
> >    in this list.
> > 7) This list was a part of a default initialization logic before (3) was
> >    implemented, but now, taking into account new mechanism implemented
> >    with current approach of inode security revalidation on each access
> >    (4)-(3)-(2), it looks obsolete and not needed anymore.
> > 8) So deferred initialization, this list and code associated with it can
> >    be safely removed now, as anyway, if inode isec was not initialized
> >    before it will be processed on any next inode access.
> > 9) Another case for calling inode_doinit_with_dentry( ) is when a new
> >    dentry is created. This is done by call from d_instantiate( ). When
> >    the deferred initialization list is removed it would be useful to
> >    also check for SELinux initialization status here before calling
> >    inode_doinit_with_dentry( ) like it is done in
> >    __inode_security_revalidate( ).
> > 10) There are two possible positive consequences from this removal:
> >      a. More clean and simple code, less memory consumption;
> >      b. This deferred initialization in some cases (for example SELinux
> >         was switched on manually after system was up quite a long time)
> >         could take some significant time to process, i.e. system looks
> >         hung for some notable time. And now this is avoided.
> >
> > Signed-off-by: Alexander Kozhevnikov <alexander.kozhevnikov@huawei-partners.com>
> > ---
> >  security/selinux/hooks.c          | 91 ++++---------------------------
> >  security/selinux/include/objsec.h |  3 -
> >  2 files changed, 11 insertions(+), 83 deletions(-)
>
> Merged into selinux/next with some minor style and grammar fixes,
> thanks Alexander!

Unfortunately I just had to back this commit out of selinux/next as
the automated testing using the selinux-testsuite failed on my Fedora
Rawhide test system failed.

Please verify that this patch passes the selinux-testsuite on a modern
Fedora Rawhide install using Linux v6.2-rc2 as a base.

-- 
paul-moore.com
