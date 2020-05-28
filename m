Return-Path: <SRS0=TvmB=7K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EC1C433DF
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 13:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B93207D3
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 13:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEoDgT3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390430AbgE1Nmh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 May 2020 09:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390335AbgE1Nmg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 May 2020 09:42:36 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A364C05BD1E
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 06:42:36 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id d191so3399oib.12
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 06:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WkpBnDPW3fkDcUej8yhTQuIG/AzTnnrqyFgO+mW92xg=;
        b=UEoDgT3aKfc9ng6V8OHkQj8HhCjdb9o2joyiR4CfEw8/0x5psHhqzb6aqjEDVf0utf
         ZbqYdd9NBwOCC5nzEjLr/ir59mNHyVCwunAa0Wv3pvFvTFdGqvQYcJCmur3dtdE1y9rc
         KZpjL5Oxx/X2RXgeeX8ijWFMGOMK1SmXtlnqCUXM1ciONO6kkDAMbv/DUNY8nuUuHH6P
         4A3eEW1XOO4daRw3bDhpidHzIqfepH1uy0YIp6ULdZ2Hx56wW8bMogcRsurSpoQWiiuy
         Bx5hvs0JCBTayI9jo6YugZVsfGlBwyaS/urR+a/ZHheiMIKDIg3KK7QAG9hdwIRTwaco
         2PXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WkpBnDPW3fkDcUej8yhTQuIG/AzTnnrqyFgO+mW92xg=;
        b=TJYXLqKKNkVFhy2OLFaXTP+ItXFS2SrsihTNz3M3zzbVOMauIiIzX2KZK57CQb+1X/
         U2bKP52GbK81BK0ZOVJY7pdKRXPr+zgjaioLQUReqV2ZSXPe2asNtnVCCDohAvXJ6p8c
         zM1zAzVLC2edg7yaq4NrZav6mfV1608ROeiUmM7jmKOjqr1c9MERMLH8PAsRyW62+ptE
         5kKu35OMdQlsaFqntK4eBiQdCm5DmJHR0BLbb+aMBRVkwzoUd2vBifPhEAeHYdqYo1dM
         xJw5Cs5sLvIzfYcFuHl51FmMbgGGL7PGU8Uu21rfDF94Ibpf5TEqxtjO1hQBINM4uM7k
         MFxg==
X-Gm-Message-State: AOAM53154xSPqYMIqyxVqcz0FDnOxYXEIuBm/zr4QaIDiUpukl+nW8Nz
        Kc8j1IWe5O/8ltrHeIfxdaArP+1kmtgIe4TBuWaIaaKE
X-Google-Smtp-Source: ABdhPJzme2ktooYTF6gla7tWUSBN8UrRZv/nR72T+qTDW5cIluYWnwVSkfqIBWa+sQewSpe4HtW+49rBzGsRUOlHKp0=
X-Received: by 2002:aca:c704:: with SMTP id x4mr2108282oif.92.1590673355746;
 Thu, 28 May 2020 06:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200527220653.188794-1-jlebon@redhat.com>
In-Reply-To: <20200527220653.188794-1-jlebon@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 28 May 2020 09:42:24 -0400
Message-ID: <CAEjxPJ50MaQby45iKpxbJXVhKG=mcpRg9t0CjCxfQtNgQyr+Sw@mail.gmail.com>
Subject: Re: [PATCH] selinux: allow reading labels before policy is loaded
To:     Jonathan Lebon <jlebon@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 27, 2020 at 6:10 PM Jonathan Lebon <jlebon@redhat.com> wrote:
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
> Signed-off-by: Jonathan Lebon <jlebon@redhat.com>

You might want to fix the comment style below, but otherwise,

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/hooks.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0b4e32161b7..a2caf6e2313 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3334,7 +3334,11 @@ static int selinux_inode_getsecurity(struct inode *inode, const char *name, void
>         char *context = NULL;
>         struct inode_security_struct *isec;
>
> -       if (strcmp(name, XATTR_SELINUX_SUFFIX))
> +       /* If we're not initialized yet, then we can't validate contexts, so
> +        * just let vfs_getxattr fall back to using the on-disk xattr.
> +        */

coding-style says that multi-line comment style is to use a separate
line for the opening /* unless in net/


> +       if (!selinux_initialized(&selinux_state) ||
> +           strcmp(name, XATTR_SELINUX_SUFFIX))
>                 return -EOPNOTSUPP;
>
>         /*
> --
> 2.25.4
>
