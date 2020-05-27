Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2F6C433E2
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 19:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE402078C
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 19:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWTbkBD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgE0TTu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 15:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgE0TTt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 15:19:49 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87538C08C5C1
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 12:19:49 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id l6so22751414oic.9
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 12:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J25pB3FWaAkYnXfUqr50Mgwfc3r64FSbyq+qxuqgi6Q=;
        b=fWTbkBD0WDwc9FHBGeSaAEwglGjgSRZ88WvRxAIzR7K78/9PNJgGmrDf/r/sryGPcG
         vX8sjYRJR5gaahO1DKNCAquFxVLGtRBpibf2Jg7UyU4ZDEGJfkh258lnfhHeXqU/+5ss
         eyV/uSv58KDstDj0lZOokP4WCSOY1aEiSTOOmolsmokU51ZLfLs6NPlRTBD7eIqj6UQx
         F2lNE5iwwHTkWeOK+LKdKIW3Eezxl8hTRo8djz6TF/jcjRWJA134gNQzEOPNvuWiFcLo
         htfXtw0MMw0awxARd4uNUISExQRKuzmoo9fTakwdM2Ho3Ky6e6r30GxSzUlVO+LlC5ia
         3wCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J25pB3FWaAkYnXfUqr50Mgwfc3r64FSbyq+qxuqgi6Q=;
        b=HXglgYvuLZ231/v33TRNmDjerfxDStJdeIDSojz5THW6uGeJn3Hbjihpolbx4KiOpw
         Yye2kwQUbTNzpb95SueTA9sdQJp3XAMG4RS96nWND28CWJgzoTFLupTuLW7yjozImMNg
         dCyZVU559BEMeFAhSIhzBInvEE+NTqYyiDmiIUKrem9wmuKSaxrxE5riJmkDXjV+t1rz
         tDonXe+jR8xKRdRBeYaB7daDhDuhtpvGrFMUaDzhDy0fToUlX/Zkh7kNBFvQa6Dgz3/U
         yFJsIc5HuKtR3a0FG2hlYHo1DanN0yTlF6auxKLoMJ6CeD6t1ja+1Phjff4+4Pos3Oea
         omVg==
X-Gm-Message-State: AOAM533/QU1WEizIXqtjy4AI78RW4IDHUMELupoQGNISlGqh6aAN2L5r
        mQHM5PcWB0z5DlyHkY8Vz9UWtW9QCwXWhXFfcBQp0QRMGh0=
X-Google-Smtp-Source: ABdhPJyM2OdpBcY4ZGJ6EAlEK/32q3rpBhDJUoPYTWVm50paqRRnybvcaTHhVy9C9XzRUuymTslgKn/1xsNpmTNmICE=
X-Received: by 2002:aca:a948:: with SMTP id s69mr3859930oie.140.1590607188814;
 Wed, 27 May 2020 12:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200527155610.156633-1-jlebon@redhat.com>
In-Reply-To: <20200527155610.156633-1-jlebon@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 27 May 2020 15:19:38 -0400
Message-ID: <CAEjxPJ4wGxfjCVxFcLusgU0L_yaU7Yv=VEWc3MU1Jpw=hrBiwQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: allow reading labels before policy is loaded
To:     Jonathan Lebon <jlebon@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 27, 2020 at 3:04 PM Jonathan Lebon <jlebon@redhat.com> wrote:
>
> This patch does for `getxattr` what 3e3e24b4204 did for `setxattr`; it

Both above and down below you need to fix your commit reference to provide the
one-line summary ala commit 3e3e24b42043 ("selinux: allow labeling
before policy is loaded");
checkpatch.pl would have caught at least the 2nd instance for you.
Probably could change
the 2nd reference to avoid need to repeat it.

> allows querying the current SELinux label on disk before the policy is
> loaded.
>
> One of the motivations described in that commit message also drives this
> patch: for Fedora CoreOS (and eventually RHEL CoreOS), we want to be
> able to move the root filesystem for example, from xfs to ext4 on RAID,
> on first boot, at initrd time.[1]
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
>  security/selinux/hooks.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0b4e32161b7..67ee2cfc25b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3334,7 +3334,9 @@ static int selinux_inode_getsecurity(struct inode *inode, const char *name, void
>         char *context = NULL;
>         struct inode_security_struct *isec;
>
> -       if (strcmp(name, XATTR_SELINUX_SUFFIX))
> +       /* If we're not initialized yet, then we can't validate contexts,
> +        * so just let vfs_getxattr fall back to using the on-disk xattr. */
> +       if (strcmp(name, XATTR_SELINUX_SUFFIX) || !selinux_state.initialized)
>                 return -EOPNOTSUPP;
>
>         /*
> --
> 2.25.4
>
