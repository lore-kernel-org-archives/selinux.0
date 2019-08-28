Return-Path: <SRS0=2AUq=WY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8730EC3A5A3
	for <selinux@archiver.kernel.org>; Wed, 28 Aug 2019 00:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545DD2173E
	for <selinux@archiver.kernel.org>; Wed, 28 Aug 2019 00:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="MtTAAoMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfH1A4M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Aug 2019 20:56:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41856 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfH1A4L (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Aug 2019 20:56:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id j4so565211lfh.8
        for <selinux@vger.kernel.org>; Tue, 27 Aug 2019 17:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b1V/Uk1SkUf+5MOu9CDLPVtTyRpxj6Yja1v+q4vfCq8=;
        b=MtTAAoMSYW1weYnGCfArw1CeHlCuMbcuCJ0L6A4YYRegenfVRUcPpRM17LsVjlKjBg
         LRzWSa5/IvKzrQtjOg6Ob/jF5PRAxp7GpD/1FINzLaEZ5ryLN3Nn4Tz7dP6MbT/U4DZP
         FTiCIuR0y2G3KMpW00DGRpg0IKKKI2Vs2xZz8f0LjNKnBb8vHtqf8wruENoGN6Bi/7jF
         eblZe7dEl5wmdj7ssM6+F1wbq7em5pHnsSeA4BUqUniUcexCj1z2FhDpr+Kr0KZm/CR1
         M5996xaNFCYSEI6hmYAS/E/e68J3WQcJc1UYIjZWYePMRlx1DJDMk6o29+0BIfu8pEpf
         4I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1V/Uk1SkUf+5MOu9CDLPVtTyRpxj6Yja1v+q4vfCq8=;
        b=qeQbRmDMhM8r2MOK2g9Ra2rvOSSKtiLgAGs93h9b73F8oJm2udfSUjPISpSxAwlqMF
         8Pb18XeJjIhSnqA2VyCsTW/la9EOPu5XRpgmJ2Xp5eQEA2Z8M9urZtwggTvLaHdJJqoc
         QplRrT+dAGk4XLFAx7eY/iqOX94WoATx2kCuL8TNqTmmNbFPPcFt+fjpw5RI9dYsb4aj
         K5UJKRZWjmgCxo8URvD52Dm7LPhDlkbymqCvSPTvgguXQvPgSa7EKNarbDxDa7xw7MfQ
         eysUyDslmqhRwdBd5JPCuKazUfJdYxWwfRrv+cGfG4t9KyRiACMyQdIni2peWsQQRDtH
         UiNw==
X-Gm-Message-State: APjAAAWkr3JCUvdqyFODxqSCUGv+epcJLLYeycDicrESDTqQb0SXmwxi
        7EazaISjtAkn8uXa5V42dx/fD4pw56QcokXYPYu5F8IDWg==
X-Google-Smtp-Source: APXvYqx9Z0P2LmLQMw8gDR3oUtOH4QHPfz2TxBPidal9kyMJTmSeSpEH4L5TGrB6JXft31U2SkruhNC2PU3+8lyW9e4=
X-Received: by 2002:ac2:5225:: with SMTP id i5mr750923lfl.13.1566953769384;
 Tue, 27 Aug 2019 17:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190819193032.848-1-jlebon@redhat.com>
In-Reply-To: <20190819193032.848-1-jlebon@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Aug 2019 20:55:58 -0400
Message-ID: <CAHC9VhSLc=ORU2CkJSHiCmzTENEjk5Sy-dK2Op1btWgr17DZfg@mail.gmail.com>
Subject: Re: [PATCH] selinux: allow labeling before policy is loaded
To:     Jonathan Lebon <jlebon@redhat.com>
Cc:     selinux@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 19, 2019 at 3:31 PM Jonathan Lebon <jlebon@redhat.com> wrote:
>
> Currently, the SELinux LSM prevents one from setting the
> `security.selinux` xattr on an inode without a policy first being
> loaded. However, this restriction is problematic: it makes it impossible
> to have newly created files with the correct label before actually
> loading the policy.
>
> This is relevant in distributions like Fedora, where the policy is
> loaded by systemd shortly after pivoting out of the initrd. In such
> instances, all files created prior to pivoting will be unlabeled. One
> then has to relabel them after pivoting, an operation which inherently
> races with other processes trying to access those same files.
>
> Going further, there are use cases for creating the entire root
> filesystem on first boot from the initrd (e.g. Container Linux supports
> this today[1], and we'd like to support it in Fedora CoreOS as well[2]).
> One can imagine doing this in two ways: at the block device level (e.g.
> laying down a disk image), or at the filesystem level. In the former,
> labeling can simply be part of the image. But even in the latter
> scenario, one still really wants to be able to set the right labels when
> populating the new filesystem.
>
> This patch enables this by changing behaviour in the following two ways:
> 1. allow `setxattr` on mounts without `SBLABEL_MNT` (which is all of
>    them if no policy is loaded yet)
> 2. don't try to set the in-core inode SID if we're not initialized;
>    instead leave it as `LABEL_INVALID` so that revalidation may be
>    attempted at a later time
>
> Note the first hunk of this patch is functionally the same as a
> previously discussed one[3], though it was part of a larger series which
> wasn't accepted.
>
> Co-developed-by: Victor Kamensky <kamensky@cisco.com>
> Signed-off-by: Victor Kamensky <kamensky@cisco.com>
> Signed-off-by: Jonathan Lebon <jlebon@redhat.com>
>
> [1] https://coreos.com/os/docs/latest/root-filesystem-placement.html
> [2] https://github.com/coreos/fedora-coreos-tracker/issues/94
> [3] https://www.spinics.net/lists/linux-initramfs/msg04593.html
> ---
>  security/selinux/hooks.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 94de51628..faf93e9f8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3143,7 +3143,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
>         }
>
>         sbsec = inode->i_sb->s_security;
> -       if (!(sbsec->flags & SBLABEL_MNT))
> +       if (!(sbsec->flags & SBLABEL_MNT) && selinux_state.initialized)
>                 return -EOPNOTSUPP;

As I'm looking at this, I'm wondering why we don't just bail out early
if the policy isn't loaded?  The context lookup and permission checks
later in the function are pretty much useless if the policy hasn't
been loaded (they are just going to return defaults/allow), I think
the only thing we would need to check would be
inode_owner_or_capable().

  int selinux_inode_setxattr(...)
  {

    if (strcmp(name, XATTR_NAME_SELINUX)) {
      ...
    }

    if (!selinux_state.initialized)
      return (inode_owner_or_capable(inode) ? 0 : -EPERM);

    if (sbsec & SBLABEL_MNT)
      ...

    if (!inode_owner_or_capable(inode)
      ...

    ...
  }

-- 
paul moore
www.paul-moore.com
