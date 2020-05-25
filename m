Return-Path: <SRS0=axcH=7H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D45DC433DF
	for <selinux@archiver.kernel.org>; Mon, 25 May 2020 17:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21B820723
	for <selinux@archiver.kernel.org>; Mon, 25 May 2020 17:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDGVMevB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389266AbgEYROa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 May 2020 13:14:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37463 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388230AbgEYROa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 May 2020 13:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590426867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ms/n8dX/gX2C5kBRLtQwbQYlB7DwHeK3fEJRoFvgn0Q=;
        b=GDGVMevB0RzpQs9DOyolPXOrmWee68I7bPi4v1dyPSYY5lCh39RIudf12Mu4OKbzdoUFxN
        t/Jf1kiahhoKsv6Pj9mtP23gUh8sEfoWQZk+NDfv1o1ocmEMhRoOfJlZMloJCRf434UAmk
        CHlXuHHBigQqFv0xxVxdHBkQaAQEb54=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-ALHCZz79PzuVVE9TgTBU1A-1; Mon, 25 May 2020 13:14:22 -0400
X-MC-Unique: ALHCZz79PzuVVE9TgTBU1A-1
Received: by mail-oo1-f71.google.com with SMTP id p6so2138348ooa.3
        for <selinux@vger.kernel.org>; Mon, 25 May 2020 10:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ms/n8dX/gX2C5kBRLtQwbQYlB7DwHeK3fEJRoFvgn0Q=;
        b=tduqYpDOwvJPZ1N3aELT8Jj+xOQl/Zt2xHnJaHIZUeJwoEsZh9Q7xQK6KpSiI5WRzs
         x3VoOXslPBE8gP7lA++o28wHLzSRP6+hC3lFptmZHIAnDP2u209j6cGpsKw4icTRQ3Pp
         SpKa8ybO03IFb18PHuaGd5aZ4XivUVTeujJ9uTbhkJy0YhnulODM9QkCFrX3wEV0UIUa
         0THMERiUBYwI9FURy7YqnBVsZbyXSnn08hy04Oak/mAE2cf2n0Dzis+fKvO0vtPOKEqm
         /Igj1rmGq/uY9oIaoAvqsN1OZ4OQUWl07+A+iWadHU0F8+IxEmt0k0+nscRRSD7FuKHJ
         kxVA==
X-Gm-Message-State: AOAM5304wTzgTpQ4OVdnKV/m1M1WyPhRKv1Wv9QlD/pFrRFovP5IYLBH
        xilrLWzXHickGA5urJHHnYe6PMdEi/xAWChxdEgmzKBPZWW+rOdU8A4Tv9wxeUgdI81qneVD1pU
        +o9XP8ne94FfxSRpZjcG1xToWtwc/cuqxmg==
X-Received: by 2002:aca:230e:: with SMTP id e14mr10778748oie.127.1590426861984;
        Mon, 25 May 2020 10:14:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvqg1sunPcch9jovctypZc4hue2Nkk/UhtiEd/tvu1F98PK74OhLk4AnhZSYhgtFc3tl9iT8kRvzwAJ881ZDc=
X-Received: by 2002:aca:230e:: with SMTP id e14mr10778735oie.127.1590426861664;
 Mon, 25 May 2020 10:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200523195130.409607-1-jlebon@redhat.com>
In-Reply-To: <20200523195130.409607-1-jlebon@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 25 May 2020 19:14:10 +0200
Message-ID: <CAFqZXNsuJ7S9zFhHBJNJxUr4=_ZGmKdzTU29PrWRuziMfJJkGQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: allow reading labels before policy is loaded
To:     Jonathan Lebon <jlebon@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, May 23, 2020 at 9:56 PM Jonathan Lebon <jlebon@redhat.com> wrote:
> This patch does for `getxattr` what 3e3e24b4204 did for `setxattr`: it
> allows querying the current SELinux label on disk before the policy is
> loaded.
>
> One of the motivations described in that commit message also drives this
> patch: for Fedora CoreOS (and eventually RHEL CoreOS), we want to be
> able to move the root filesystem for example from xfs to ext4, on first
> boot, at initrd time.[1]
>
> Because such an operation works at the filesystem level, we need to be
> able to read the SELinux labels first from the original root, and apply
> them to the files of the new root. Commit 3e3e24b4204 enabled the second
> part of this process; this patch enables the first part.
>
> [1] https://github.com/coreos/fedora-coreos-tracker/issues/94
>
> Signed-off-by: Jonathan Lebon <jlebon@redhat.com>
> ---
>  security/selinux/hooks.c | 55 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 50 insertions(+), 5 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0b4e32161b7..3bbb9966697 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
<snip>
> @@ -3333,10 +3354,34 @@ static int selinux_inode_getsecurity(struct inode *inode, const char *name, void
>         int error;
>         char *context = NULL;
>         struct inode_security_struct *isec;
> +       struct superblock_security_struct *sbsec;
>
>         if (strcmp(name, XATTR_SELINUX_SUFFIX))
>                 return -EOPNOTSUPP;

I might be missing something, but couldn't you achieve the same by
simply adding something like this in here:

if (!selinux_initialized(&selinux_state))
        return -EOPNOTSUPP;

(Or by adding it to the condition above.)

Then you should hit this condition here and be all set:
https://elixir.bootlin.com/linux/v5.7-rc7/source/fs/xattr.c#L337

>
> +       isec = inode_security(inode);
> +       sbsec = inode->i_sb->s_security;
> +
> +       /* Just return the raw context if the policy isn't even loaded since we
> +        * have no way to validate it anyway. This is symmetrical with allowing
> +        * setxattr without a policy. */
> +       if (!selinux_state.initialized) {
> +               /* See similar code in inode_doinit_with_dentry; for xattrs,
> +                * some filesystems really want a connected inode. If we don't
> +                * find one, just let fallback in case it corresponds to one of
> +                * the default sids. */
> +               struct dentry *dentry = d_find_alias(inode);
> +               if (!dentry)
> +                       dentry = d_find_any_alias(inode);
> +
> +               if (dentry) {
> +                       error = get_inode_raw_xattr_context(inode, dentry,
> +                                                           &context, &size);
> +                       dput(dentry);
> +                       goto out;
> +               }
> +       }
> +
>         /*
>          * If the caller has CAP_MAC_ADMIN, then get the raw context
>          * value even if it is not defined by current policy; otherwise,
> @@ -3346,7 +3391,6 @@ static int selinux_inode_getsecurity(struct inode *inode, const char *name, void
>          * and lack of permission just means that we fall back to the
>          * in-core context value, not a denial.
>          */
> -       isec = inode_security(inode);
>         if (has_cap_mac_admin(false))
>                 error = security_sid_to_context_force(&selinux_state,
>                                                       isec->sid, &context,
> @@ -3354,6 +3398,7 @@ static int selinux_inode_getsecurity(struct inode *inode, const char *name, void
>         else
>                 error = security_sid_to_context(&selinux_state, isec->sid,
>                                                 &context, &size);
> +out:
>         if (error)
>                 return error;
>         error = size;
> --
> 2.25.4
>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel,
Red Hat, Inc.

