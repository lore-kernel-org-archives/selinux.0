Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7748FC4332F
	for <selinux@archiver.kernel.org>; Mon, 14 Nov 2022 17:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237613AbiKNRqH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Nov 2022 12:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237600AbiKNRqG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Nov 2022 12:46:06 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34571209BD
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 09:46:01 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so14527528pji.1
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 09:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GQVTl44oIH8oiV5K+Sv7U8T5hFlw2/VkCt8UIAvJo8k=;
        b=V1n/QmQ3AuN9+EmhyutLATvVqBnCmhroS/UAPXghdJmV0HU19jBjKXe8xXfkDii3uh
         NbqQrvC/rIPyGUCNyfGy1CLDRxYC6OHpDDCIHCoreQBo6O43xJmvGtuz6/9H7Vi9jUqD
         XauwRtxnkP/SX8dYOyE67HzHi8XH7ivB0fiyHazCPB1o5D8BR+/IEvz71nNZ73FZygr9
         Ixm16SE66NbwJ8g5krU2+4ZOzLZJ0u2CK9HUpXZQ9F4r4zDVHshhQ/fKQ0+/uNJkjoJY
         l3SUcHNoLOYCYhyvJUlY09N3xdjfCcdJAmAk5LAs9znBiX0C4BZTg0Stl3/l4cZ2B2We
         +gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQVTl44oIH8oiV5K+Sv7U8T5hFlw2/VkCt8UIAvJo8k=;
        b=DI9w5OoVrSx58cjM1OadsONdUo4VhvFF+sLFaFXLCWP8kETWYrrNINGN8X2Dv6yYmw
         SHcc1WTKxOCqVsCjDJ9cGBFyPbp70cI9iHGIhHT/P8iCz8ThUv3U5EM7KLpL92p2uLck
         EO2dzOAZ/ghE9eYfeUWeUbo6HFjxcY8Sfv8FUM2tgJ3TLtPygPrU5BZYb+wMUiLE6XbI
         oOpw3ikuOn4eaIofGoR/hszLYWt9G7XEuinH0E6S787d5BqNFRDdkTL5S+/6U4RA0GZS
         HlnR5RiNcXxp0mSB8KAoZOnYyRuGiIksl+Kw3GYgCT9j5xp8ljVsaJGyP6YYjLf2718L
         TQmg==
X-Gm-Message-State: ANoB5pnkazkVIJ0VhTZbJwen6Jo3S13Ud7vTyXaalc1Or9YAkmkywpqJ
        7S2w/ipLmuWjX+qUyQcE5enJEPQmCTVjj4B6Dyup
X-Google-Smtp-Source: AA0mqf4ETxqkXKYu+RpDh1ikHko1QWsZc6mC5UAwT9xXuQfI1egKxQiAZWWgvKVnWMoGCW1s91/EqBlGHFO3dDz7mK8=
X-Received: by 2002:a17:90b:3682:b0:1fd:5b5d:f09d with SMTP id
 mj2-20020a17090b368200b001fd5b5df09dmr14979218pjb.69.1668447960577; Mon, 14
 Nov 2022 09:46:00 -0800 (PST)
MIME-Version: 1.0
References: <20221114111844.3461403-1-konstantin.meskhidze@huawei.com>
In-Reply-To: <20221114111844.3461403-1-konstantin.meskhidze@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 14 Nov 2022 12:45:49 -0500
Message-ID: <CAHC9VhQZ0i1GF2a9P9v05awKCb_j2X0Tv_xVfhQm4NnMJFs5Lw@mail.gmail.com>
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

On Mon, Nov 14, 2022 at 6:19 AM Konstantin Meskhidze
<konstantin.meskhidze@huawei.com> wrote:
> From: Alexander Kozhevnikov <alexander.kozhevnikov@huawei-partners.com>
>
> This patch is a proposed code optimization for SELinux:
>
> 1) Each inode has SELinux security structure attached
>    to it, this one need to be initialized at some point.
> 2) This initialization is done by the function
>    inode_doinit_with_dentry ( ).
> 3) In the kernel releases started from some point in the past
>    this function (2) is always called normally from function
>    __inode_security_revalidate ( ).
> 4) Which in turn is always called  from inode_security ( ), which
>    is a base point for any selinux calls and always called on
>    any access to any inode except a few special cases when
>    _inode_security_novalidate ( ) is used.
> 5) Inode security structure initialization can be done only after
>    SELinux is fully initialized and policy is loaded.
> 6) So, for this purpose there was a special defeferred inode security
>    initialization list protected by a spinlock implemented, which was
>    populated instead of isec initialization in function
>    inode_doinit_with_dentry ( ), if it was called before SELinux full
>    initialization, and processed at the time when SELinux policy load
>    occurred by calling again inode_doinit_with_dentry ( ) on each inode
>    in this list.
> 7) This list was a part of a default initialization logic before (3) was
>    implemented, but now, taking into account new mechanism implemented
>    with current approach of inode security revalidation on each access
>    (4)-(3)-(2), it looks obsolete and not needed anymore.
> 8) So deferred initialization, this list and code associated with it can
>    be safely removed now, as anyway, if inode isec was not initialized
>    before it will be processed on any next inode access.
> 9) There are two possible positive consequences from this removal:
>      a. More clean and simple code, less memory consumption;
>      b. This deferred initialization in some cases (for example SELinux
>         was switched on manually after system was up quite a long time)
>         could take some significant time to process, i.e. system looks
>         hung for some notable time. And now this is avoided.
>
> Signed-off-by: Alexander Kozhevnikov <alexander.kozhevnikov@huawei-partners.com>
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> ---
>  security/selinux/hooks.c          | 70 ++++---------------------------
>  security/selinux/include/objsec.h |  3 --
>  2 files changed, 7 insertions(+), 66 deletions(-)

Hi Konstantin, Alexander,

A few comments below, but can you share what testing you've done with
this?  Specifically what you've done to ensure that inodes allocated
before the policy is loaded are properly initialized/validated after
the policy is loaded?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f553c370397e..c93b5621d735 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -316,27 +316,7 @@ static struct inode_security_struct *backing_inode_security(struct dentry *dentr
>
>  static void inode_free_security(struct inode *inode)
>  {
> -       struct inode_security_struct *isec = selinux_inode(inode);
> -       struct superblock_security_struct *sbsec;
> -
> -       if (!isec)
> -               return;
> -       sbsec = selinux_superblock(inode->i_sb);
> -       /*
> -        * As not all inode security structures are in a list, we check for
> -        * empty list outside of the lock to make sure that we won't waste
> -        * time taking a lock doing nothing.
> -        *
> -        * The list_del_init() function can be safely called more than once.
> -        * It should not be possible for this function to be called with
> -        * concurrent list_add(), but for better safety against future changes
> -        * in the code, we use list_empty_careful() here.
> -        */
> -       if (!list_empty_careful(&isec->list)) {
> -               spin_lock(&sbsec->isec_lock);
> -               list_del_init(&isec->list);
> -               spin_unlock(&sbsec->isec_lock);
> -       }
> +/* NOTHING TO DO AFTER DEFERRED LIST REMOVAL */
>  }

We should just remove inode_free_security(), as well as
selinux_inode_free_security(), there is no reason to leave them as
empty functions and/or hooks.

> @@ -551,27 +531,6 @@ static int sb_finish_set_opts(struct super_block *sb)
>         /* Initialize the root inode. */
>         rc = inode_doinit_with_dentry(root_inode, root);
>
> -       /* Initialize any other inodes associated with the superblock, e.g.
> -          inodes created prior to initial policy load or inodes created
> -          during get_sb by a pseudo filesystem that directly
> -          populates itself. */
> -       spin_lock(&sbsec->isec_lock);
> -       while (!list_empty(&sbsec->isec_head)) {
> -               struct inode_security_struct *isec =
> -                               list_first_entry(&sbsec->isec_head,
> -                                          struct inode_security_struct, list);
> -               struct inode *inode = isec->inode;
> -               list_del_init(&isec->list);
> -               spin_unlock(&sbsec->isec_lock);
> -               inode = igrab(inode);
> -               if (inode) {
> -                       if (!IS_PRIVATE(inode))
> -                               inode_doinit_with_dentry(inode, NULL);
> -                       iput(inode);
> -               }
> -               spin_lock(&sbsec->isec_lock);
> -       }
> -       spin_unlock(&sbsec->isec_lock);
>         return rc;
>  }

I would suggest ending sb_finish_set_opts() by returning from the
inode_doinit_with_dentry() call, e.g.:

    /* ... */
    return inode_doinit_with_dentry(root_inode, root);
  }

> @@ -1430,9 +1381,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>                 if (!dentry) {
>                         /*
>                          * this is can be hit on boot when a file is accessed
> -                        * before the policy is loaded.  When we load policy we
> -                        * may find inodes that have no dentry on the
> -                        * sbsec->isec_head list.  No reason to complain as these
> +                        * before the policy is loaded. No reason to complain as these
>                          * will get fixed up the next time we go through
>                          * inode_doinit with a dentry, before these inodes could
>                          * be used again by userspace.

There are some typos at the start of this comment that are worth
fixing here since you are updating the comment block, e.g.:

  /*
   * This can be hit on boot when a file is accessed
   * before the policy is loaded ...

-- 
paul-moore.com
