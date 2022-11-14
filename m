Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BAFC4332F
	for <selinux@archiver.kernel.org>; Mon, 14 Nov 2022 18:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbiKNSK1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Nov 2022 13:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238163AbiKNSKE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Nov 2022 13:10:04 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D332B61A
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 10:10:00 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso14566499pjg.5
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 10:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8+yZhAhr7NAUT9GmiB1IKSJ9jNEMF8zBynfUT8bHs+o=;
        b=6+sjHhvznvTcyKSrY+5KA+08PFuG7RhKbw1tbRBc0icUFEejCsXOXqq6qMTXoD8eP5
         MiMTjs7k2oUhdFOOTZHpG/VqELPNts7hbAIuY7CdHwkEsiGnghy0wAXgq8w9P1drNxV7
         +dLxA7hTHUqpKTnhvEWX+tGzszFIihwC9nJhpOmSNjEgRqclH0fFHyt898Y/Ky/n9d06
         fpcFvHB6ciAAciYQlECvKrKr/7t15yyFwBKgy/9kFoMqtuxNgTdN7izpeyKfMFDn2spi
         81uLJNSer3vDtEMJmkItc29iTA9DiqkVVDMBnCcEh+dPg85FxFXiNJiRW6K63UGJeAZh
         WKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+yZhAhr7NAUT9GmiB1IKSJ9jNEMF8zBynfUT8bHs+o=;
        b=iWKzQZtS7y7aWlIR57hUvTBRHnMR6+AeqrR5ze4lxRJTFw2ZvX+Y/7PwJWxMqtkJE+
         Ao8Vu07YwKNg8pT/VJfqSWjNHOlGDSo6XoMNbwxARGKDr8erJT3BcymLgB+mydUn9dtN
         02PfcUF0OEM+EG+QX3wG+fHlyTXLbrYbr/DnZ9EckgbiV6oNLFyq5LqaqVwp6h0Uj5dm
         COL/Zd9NWfLTxCcOQ7pdT62jPlhBApKOotLSSBwjbzRUGqz5YmG3744I5dHVd9nkNl5C
         IRxUVeQyb8SVSKXohef2QE8P0CDoj4IbXSFFcttvaloqQj07+eM83y6esE7hHSIAuMS6
         BexQ==
X-Gm-Message-State: ANoB5pna3FLV/JlqlY+TWrgI/sxSBU8Ed2amdvKBmt9g/ZDkCLhkUEj8
        X12diIMRXezynbdVtvJBTxY4Dm4d9foXQq/IGITR
X-Google-Smtp-Source: AA0mqf7NbJaOooC6NtTT1GTTCEn+rquNSNpp1Tz9skdx9H8RN2w18W3PdKfzzaDh4o9CiRYOG//yNB9WUnxdOx1/2Pc=
X-Received: by 2002:a17:90a:6a85:b0:20d:4173:faf9 with SMTP id
 u5-20020a17090a6a8500b0020d4173faf9mr14670365pjj.147.1668449400273; Mon, 14
 Nov 2022 10:10:00 -0800 (PST)
MIME-Version: 1.0
References: <20221114111844.3461403-1-konstantin.meskhidze@huawei.com> <CAHC9VhQZ0i1GF2a9P9v05awKCb_j2X0Tv_xVfhQm4NnMJFs5Lw@mail.gmail.com>
In-Reply-To: <CAHC9VhQZ0i1GF2a9P9v05awKCb_j2X0Tv_xVfhQm4NnMJFs5Lw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 14 Nov 2022 13:09:49 -0500
Message-ID: <CAHC9VhSrbZeP2Lmd-dVXyUqM2=b7z-HMWh1ZPQ30eWchwrQJvA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] SELINUX: Remove obsolete deferred inode security
 init list.
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     linux-security-module@vger.kernel.org,
        jamorris@linux.microsoft.com, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com, artem.kuzin@huawei.com,
        hw.likun@huawei.com, alexander.kozhevnikov@huawei-partners.com,
        xiujianfeng@huawei.com, yusongping@huawei.com, hukeping@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 14, 2022 at 12:45 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Nov 14, 2022 at 6:19 AM Konstantin Meskhidze
> <konstantin.meskhidze@huawei.com> wrote:
> > From: Alexander Kozhevnikov <alexander.kozhevnikov@huawei-partners.com>
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
> > 9) There are two possible positive consequences from this removal:
> >      a. More clean and simple code, less memory consumption;
> >      b. This deferred initialization in some cases (for example SELinux
> >         was switched on manually after system was up quite a long time)
> >         could take some significant time to process, i.e. system looks
> >         hung for some notable time. And now this is avoided.
> >
> > Signed-off-by: Alexander Kozhevnikov <alexander.kozhevnikov@huawei-partners.com>
> > Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> > ---
> >  security/selinux/hooks.c          | 70 ++++---------------------------
> >  security/selinux/include/objsec.h |  3 --
> >  2 files changed, 7 insertions(+), 66 deletions(-)
>
> Hi Konstantin, Alexander,
>
> A few comments below, but can you share what testing you've done with
> this?  Specifically what you've done to ensure that inodes allocated
> before the policy is loaded are properly initialized/validated after
> the policy is loaded?

To be more specific, I'm curious about the cases where
__inode_security_revalidate() is called without the ability to sleep;
in those cases it is not possible to call inode_doinit_with_dentry()
to revalidate the inode's label.  With the current solution that is
not so much of an issue as sb_finish_set_opts() can block, but in your
proposed solution I worry this may be an issue.

--
paul-moore.com
