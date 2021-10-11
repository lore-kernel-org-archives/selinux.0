Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B90C433F5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 23:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECFF6604AC
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 23:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbhJKXPt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 19:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbhJKXPs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 19:15:48 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5CFC061570
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 16:13:47 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id p13so74274864edw.0
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 16:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VbHSYrxIuWvs0WJBrmp3gTDxQKx1zfn+nzTO7mNWaVk=;
        b=itYqBqk/BbhezM+FrU0bqtpt7TVkTsnOlEnVf7LPROk5Gs56SEczMpDVYj7Ew0owsg
         /2KUf5rE+tGmdcDTOxjVljFOhirLFgZuR92L90VfEf3FeZr4QtLdXPQa/+hMq8R8+Va3
         ulFBkwApEM6UCC0qR8Q8xlDLqFK3oJ8wfDBvP0zW0sgWjswZAWNT5M78UUcppLKrssLw
         Dh/6+v7ss2gL3V5p4cqWTlAqtHQZoRXESpeXTOIx5gadKqX6LbDMXpkJ2K1l1BOcipPl
         p/v4k8sizpiTM3g9AyYGqTeO48hSSFxqiJuF7Vd2kLEefnjvK8poz2ruCCL3o5cYOzoj
         GiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VbHSYrxIuWvs0WJBrmp3gTDxQKx1zfn+nzTO7mNWaVk=;
        b=EeMTtfy6xuVkbl/Vz0dRvl3TGho4bYuNZOUjOlY0lPNSTLkHCL7JgKWFXgScaBdyEY
         er2463l2LJoyx9r0pRwwPII8DozA/W9rtxrEEUmFTWKoTp9Gfbm6DDQ+pDblccQ4vUtY
         yJid0iuWIpwfGNOR7knWPOlYs3WrmicGrUMOERxCyROLwBmdyCx6CtryI3jfLrCOoItP
         VKl6I8wnA/p3HyCjQzay5DSAVW5DxU5uaSb8yccX4MRymT5bWtnS2ZhKsK23CJH00sjc
         Y0GZFtF11if5TkM+vpZOKwx81C4Vwm91SAYKDr4kzxkxK0INbt+K/cD5ZR/xRpfsr71i
         GL4A==
X-Gm-Message-State: AOAM531GR7zHpYLsYrAGsl9UiunBkrfELLk3GWs3bknrefp6Ui9Qd4bQ
        teE9onGogK0UDwqrT3t2o6YYc65UxlLYKy4IY3p5
X-Google-Smtp-Source: ABdhPJwhqjv2XrohTdGULsJcB8Ip/3qpy7Zyd6bqoAsdC1P3tLpO4/GcKMk+kfnC97uBV3UyTX4VndlbkrXIls21COw=
X-Received: by 2002:a05:6402:5114:: with SMTP id m20mr45667014edd.256.1633994025809;
 Mon, 11 Oct 2021 16:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211011190204.123934-1-dave@stgolabs.net>
In-Reply-To: <20211011190204.123934-1-dave@stgolabs.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 11 Oct 2021 19:13:34 -0400
Message-ID: <CAHC9VhQngdvJCDWtguSH8EXwYhgeQwG8Zbp5jA3bheNVCZaigA@mail.gmail.com>
Subject: Re: [PATCH] selinux: consilidate comments from inode_doinit_with_dentry
 wrt !dentry
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 11, 2021 at 3:02 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> Instead of having the same big comment twice for the same scenario,
> just have it in out_invalid.
>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  security/selinux/hooks.c | 30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)

Hi Davidlohr,

Thanks for the patch, but I think the comment is a bit more
discoverable/helpful when it is integrated into the main flow of the
code and not the error handling at the bottom.  However, if you wanted
to change the second instance to refer to the prior instance I think
that would be okay.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e7ebd45ca345..0e0013cc7ba8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1502,18 +1502,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>                         if (!dentry)
>                                 dentry = d_find_any_alias(inode);
>                 }
> -               if (!dentry) {
> -                       /*
> -                        * this is can be hit on boot when a file is accessed
> -                        * before the policy is loaded.  When we load policy we
> -                        * may find inodes that have no dentry on the
> -                        * sbsec->isec_head list.  No reason to complain as these
> -                        * will get fixed up the next time we go through
> -                        * inode_doinit with a dentry, before these inodes could
> -                        * be used again by userspace.
> -                        */
> +               if (!dentry)
>                         goto out_invalid;
> -               }
>
>                 rc = inode_doinit_use_xattr(inode, dentry, sbsec->def_sid,
>                                             &sid);
> @@ -1559,15 +1549,6 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>                                 if (!dentry)
>                                         dentry = d_find_any_alias(inode);
>                         }
> -                       /*
> -                        * This can be hit on boot when a file is accessed
> -                        * before the policy is loaded.  When we load policy we
> -                        * may find inodes that have no dentry on the
> -                        * sbsec->isec_head list.  No reason to complain as
> -                        * these will get fixed up the next time we go through
> -                        * inode_doinit() with a dentry, before these inodes
> -                        * could be used again by userspace.
> -                        */
>                         if (!dentry)
>                                 goto out_invalid;
>                         rc = selinux_genfs_get_sid(dentry, sclass,
> @@ -1607,6 +1588,15 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>         return rc;
>
>  out_invalid:
> +       /*
> +        * This is can be hit on boot when a file is accessed
> +        * before the policy is loaded.  When we load policy we
> +        * may find inodes that have no dentry on the
> +        * sbsec->isec_head list.  No reason to complain as these
> +        * will get fixed up the next time we go through
> +        * inode_doinit with a dentry, before these inodes could
> +        * be used again by userspace.
> +        */
>         spin_lock(&isec->lock);
>         if (isec->initialized == LABEL_PENDING) {
>                 isec->initialized = LABEL_INVALID;
> --
> 2.26.2

-- 
paul moore
www.paul-moore.com
