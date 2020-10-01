Return-Path: <SRS0=ZFtm=DI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4FCC4727E
	for <selinux@archiver.kernel.org>; Thu,  1 Oct 2020 21:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 055C520796
	for <selinux@archiver.kernel.org>; Thu,  1 Oct 2020 21:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="O347ZKKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgJAVpu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Oct 2020 17:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgJAVpu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Oct 2020 17:45:50 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53E2C0613E2
        for <selinux@vger.kernel.org>; Thu,  1 Oct 2020 14:45:48 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l24so7203670edj.8
        for <selinux@vger.kernel.org>; Thu, 01 Oct 2020 14:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V6MiXR2nE035pNSzCfJD+UEEujvF2fdNAl5yQoWlRNQ=;
        b=O347ZKKQyHrayj4d1oCq85R9kE76wru9OFuQPJIqFwDlySU8C2u0OMdl18PbjD+BxR
         ozvTtl7lUAOvSMPnkNBHGmJSHsa1qhDtfcfsAQX6XKtcsP4O9g3ZU3AtI84Hw+P3tshc
         RNndXBR5CGJoIw/Dc/jJiMrssNI3JewgbJQo9/kPRM0yWVUOGozvAwRCKhlibWaR80Bc
         zA2HAKIEB2tAqfpuTmYzQ4coPts1NzAZq9Poji+vubgfWgqKQlsBPO7UAGgcX/DnQuEF
         JO8I/WRHUtbAxvtYtHrPmE//65HkMEpYW8k8tQLzz8q56U0NNxc4Xf6k7VdIy/XqcVof
         QROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V6MiXR2nE035pNSzCfJD+UEEujvF2fdNAl5yQoWlRNQ=;
        b=Japtu0sDEp1iZKCvtGgmX6UCWgrdEkYtLcI0LWXI8JDx2fEXowp8T0XL80j0S1fAzb
         7que81L81KL9N9rv+S0ZnkHJ5RLYAgH6brsdq62+vSfi/KkvVmaMRiaAS7FlTgka33ml
         +cvN6l1ASjvrNWBMp0JujNQWsupFrVV1s1L7eJQYVswCEc7QlPGqI86ww78X+99+rw5P
         RW8IXjFKsbdqcxf7f8CHeJ6QVb0Ps+6UzBiWDQLiJxxVKg0qq7LtTPZsLqrg67h/zDj8
         i22YWkeW1EAZ7IBVxa0aJLgadPZl0cD0hvWIr3pTVwJIUaUf7utg5gs8j7JKAwjnpdgR
         7EDQ==
X-Gm-Message-State: AOAM530zK5y3Ycrcrlnt3hbM0YA+iPBekquZNoRx/RC3xQYlyAR49C14
        vwCUJJVdGxVUiuzkpY9y2uyydUODLZXMeb4Uj2NX
X-Google-Smtp-Source: ABdhPJziZ3MnZ9kgj7RRwe6DbY4kqR3eKEF32H8bH9EBTrsMdD/CztTlHA+dd5aO+lhFOm9MqmKvYxW9VRxfFP4ZaZE=
X-Received: by 2002:a50:8e17:: with SMTP id 23mr10357187edw.31.1601588747243;
 Thu, 01 Oct 2020 14:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ7==mkXDKuDw2YueRP+ymoQjPDdCS8Wk7GJfth+CpLqkg@mail.gmail.com>
 <20200930013653.48787-1-rentianyue@tj.kylinos.cn> <20200930013653.48787-2-rentianyue@tj.kylinos.cn>
In-Reply-To: <20200930013653.48787-2-rentianyue@tj.kylinos.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Oct 2020 17:45:36 -0400
Message-ID: <CAHC9VhQTp3Rc_7zM661Rzur0XSuWRWKJJg=CwLPAQo5ABRpS-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selinux: fix error initialization in inode_doinit_with_dentry()
To:     rentianyue@tj.kylinos.cn
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andreas Gruenbacher <agruenba@redhat.com>, yangzhao@kylinos.cn,
        selinux@vger.kernel.org, Tianyue Ren <rentianyue@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 29, 2020 at 9:38 PM <rentianyue@tj.kylinos.cn> wrote:
> From: Tianyue Ren <rentianyue@kylinos.cn>
>
> Mark the inode security label as invalid if we cannot find
> a dentry so that we will retry later rather than marking it
> initialized with the unlabeled SID.
>
> Fixes: 9287aed2ad1f ("selinux: Convert isec->lock into a spinlock")
> Signed-off-by: Tianyue Ren <rentianyue@kylinos.cn>
> ---
>  security/selinux/hooks.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index bf8328adad8f..da7295a546e0 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1499,6 +1499,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>                          * inode_doinit with a dentry, before these inodes could
>                          * be used again by userspace.
>                          */
> +                       isec->initialized = LABEL_INVALID;
>                         goto out;
>                 }
>
> @@ -1553,8 +1554,10 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>                          * inode_doinit() with a dentry, before these inodes
>                          * could be used again by userspace.
>                          */
> -                       if (!dentry)
> +                       if (!dentry) {
> +                               isec->initialized = LABEL_INVALID;
>                                 goto out;
> +                       }
>                         rc = selinux_genfs_get_sid(dentry, sclass,
>                                                    sbsec->flags, &sid);
>                         if (rc) {

Looking at this some more, in both cases where we mark the isec as
"LABEL_INVALID" we can probably just do a "return 0;" instead of
jumping to "out" as there is nothing useful there except a needless
spin lock/unlock cycle.  I would suggest adding a short explanation to
the comment above each line explaining why this is okay.

-- 
paul moore
www.paul-moore.com
