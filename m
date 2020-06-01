Return-Path: <SRS0=O06S=7O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED50C433E0
	for <selinux@archiver.kernel.org>; Mon,  1 Jun 2020 18:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D337206A4
	for <selinux@archiver.kernel.org>; Mon,  1 Jun 2020 18:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="z7x3CT8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgFASnJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731474AbgFASmn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Jun 2020 14:42:43 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753E4C08C5CA
        for <selinux@vger.kernel.org>; Mon,  1 Jun 2020 11:24:33 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n24so10151378ejd.0
        for <selinux@vger.kernel.org>; Mon, 01 Jun 2020 11:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vKAll0/j6gh/8ckszoK4jLij5LBgLfIQzD3R0TgSVbo=;
        b=z7x3CT8RClJbN6XeoBirPeOy8uC2J271UkxaoA6sRNFIzS/8ntmKV87R+bJteNsS+m
         fGS7yP7Dfm56G3/VEihGoS9CzZNwsvpB393/BRoB3Xb7B9ewCoLtgFSnYxJKsqNQz/FD
         ImQ0/SlqPopqALEhmFhvFCjUeBc58yaJTvRpB7wGE0zKvbQeFHbdN1/ei+LpK4mAxB5r
         oe9Vz5JUpzzRlTaBeY+F841jZ3Zd44QbGHpR46jvm9EtXEnQyT6f++jXyHSiwQ13KHVY
         j6v3lFNvHQzmabEwCgZvtDxfQjWptFzSEHWP/G9CelVmcxKfnJKSybl2UD208lGa4T3d
         bGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vKAll0/j6gh/8ckszoK4jLij5LBgLfIQzD3R0TgSVbo=;
        b=cs2G1R/PfA0I28II+hM2t0VOx13mdyD75gQS641vnLaAJQ+iA+pjZ5pKyhQYvhd7fj
         Fq2PJVFtG2KUN84t58621Qys2deNfpn+DJAiiueBl+6Fiz+GofrRhKVhF73DdAbOvKje
         ViptWkt31LAQPk2EkPl2Y3SOnFGuAZA7n72AwxtzCDBf1JS5RtP0PiMwnnMAmzwhoc6L
         AsclMYs+LXx9j9AI+HsDVvlBC8IqfMcx5hT3Kn1gvKlogl4+Gud/09IPJg0gf5E15ZF4
         uiJX1zJ4PY8+I/cmMbroVZpbYzT+Gp6LcgvUgUaJjZbBMFj8Z4Y8lf48Wc4Ke2qVZ46p
         3IIw==
X-Gm-Message-State: AOAM530sk4XP4TzoCI5sQcdNETvmqpDhFmmILDPlqzaNmk139FZSR0Tw
        3mKGg1uKSyy/64jH1S2FV08MHmLsKUGAzqwXJIBP
X-Google-Smtp-Source: ABdhPJwiH9kMCg2gEoy8xmizUJrdm//o1/n1uucs9Wmi+6rcwTduD1Y/WSt/cxaDY7tSWsM150zwDihHPGk/78JO6zA=
X-Received: by 2002:a17:906:7395:: with SMTP id f21mr9624739ejl.178.1591035872013;
 Mon, 01 Jun 2020 11:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200528143938.209364-1-jlebon@redhat.com>
In-Reply-To: <20200528143938.209364-1-jlebon@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 1 Jun 2020 14:24:20 -0400
Message-ID: <CAHC9VhRy6hYVYTgxDxek+2Xv6tDbJy4GOGC3h2m5-VYDLG2iSA@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: allow reading labels before policy is loaded
To:     Jonathan Lebon <jlebon@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 28, 2020 at 10:49 AM Jonathan Lebon <jlebon@redhat.com> wrote:
>
> This patch does for `getxattr` what commit 3e3e24b42043 ("selinux: allow
> labeling before policy is loaded") did for `setxattr`; it allows
> querying the current SELinux label on disk before the policy is loaded.
>
> One of the motivations described in that commit message also drives this
> patch: for Fedora CoreOS (and eventually RHEL CoreOS), we want to be
> able to move the root filesystem for example, from xfs to ext4 on RAID,
> on first boot, at initrd time.[1]
>
> Because such an operation works at the filesystem level, we need to be
> able to read the SELinux labels first from the original root, and apply
> them to the files of the new root. The previous commit enabled the
> second part of this process; this commit enables the first part.
>
> [1] https://github.com/coreos/fedora-coreos-tracker/issues/94
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Jonathan Lebon <jlebon@redhat.com>
> ---
>  security/selinux/hooks.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Thanks.  This looks reasonable to me, but since it was posted only a
few days before the merge window was opened it needs to wait until
after the merge window closes.  I'll merge it into selinux/next then.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0b4e32161b7..25b3403711d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3334,7 +3334,12 @@ static int selinux_inode_getsecurity(struct inode *inode, const char *name, void
>         char *context = NULL;
>         struct inode_security_struct *isec;
>
> -       if (strcmp(name, XATTR_SELINUX_SUFFIX))
> +       /*
> +        * If we're not initialized yet, then we can't validate contexts, so
> +        * just let vfs_getxattr fall back to using the on-disk xattr.
> +        */
> +       if (!selinux_initialized(&selinux_state) ||
> +           strcmp(name, XATTR_SELINUX_SUFFIX))
>                 return -EOPNOTSUPP;
>
>         /*
> --
> 2.25.4

-- 
paul moore
www.paul-moore.com
