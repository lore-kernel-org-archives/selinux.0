Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE61C433F5
	for <selinux@archiver.kernel.org>; Thu, 27 Jan 2022 19:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245167AbiA0TDI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jan 2022 14:03:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235324AbiA0TDH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jan 2022 14:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643310187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cO2S4FwGpNtTOGbqGG2CtHNzDPXrIzabQCn3neLBo0k=;
        b=Pk0+YP1PQyAevsfqPdwA401TYZUMzPVeladGInvkStLBi32BhCeOCgnzL39d5jHjhWx6RJ
        JlwEnUv27Mx08xPFLmpxVZu42bByD7xdMK8pTTcL/Xp6MaKyhxtA7gRkFHRefDpSAsa3x9
        TvHQoKbJm2Dc5M+d+CSW5MTr3u2GhM8=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-tNGcBaWeOUW5naXEVfnRpQ-1; Thu, 27 Jan 2022 14:03:05 -0500
X-MC-Unique: tNGcBaWeOUW5naXEVfnRpQ-1
Received: by mail-yb1-f199.google.com with SMTP id 4-20020a250304000000b006137f4a9920so7605320ybd.6
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 11:03:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cO2S4FwGpNtTOGbqGG2CtHNzDPXrIzabQCn3neLBo0k=;
        b=lxGXBpCbSwdBVHxUtOos+RcmN2ffMFl5lvl5ee1P5IEgeycgTH2YlDyBZhjGC+RLE6
         OwzpWCPBfn+u6sYa++P2A8LMY6J8C+VNVCrpzLREAsVX2fOmyhbTEXNwFGZmmAqdB4gV
         U983UqNjF1rv8Tjfq+udMcC4iIJd0RWFC6tHgtYSfZ1oZqRv0LkVu7W9q3OxS+NaTEh5
         IJ9l14g0/M6hEYNnb7ksb30HZ7iX87onJcSl7NKmMyH6O2gSKAD2C3XoY8doz05hJZAk
         Dbvro79+W5f9Gml2nfpA1ePb8rzN9eKFUp39g07n5XJO0QEAaZC/lOq9fBUKLX3DjLDO
         YT7Q==
X-Gm-Message-State: AOAM5335I2AdPoD5NNEq1zZE3za3zehFoSDSjsgMClCq6f4DGGWyqV+p
        z2lxxxJu00ku8TBoREHNV2k6Am8oFp1q+0dXXDNsv8wWKaNPxl93y0JtTIGdPAaZpP5+fHFmBZD
        iLd9K0AsD9PPQL9fSdFay8BLMDIrcguJuCA==
X-Received: by 2002:a25:b003:: with SMTP id q3mr6811860ybf.767.1643310185387;
        Thu, 27 Jan 2022 11:03:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcr923Xuze3J4ia2C8Ni7xaR5RF08cSp2mP6QKjKVrQGrYMxQU6Ymn6Q0eq/ZeiMfWbWvH1wGYjIofuUFUi1w=
X-Received: by 2002:a25:b003:: with SMTP id q3mr6811841ybf.767.1643310185153;
 Thu, 27 Jan 2022 11:03:05 -0800 (PST)
MIME-Version: 1.0
References: <164330771809.139041.6643670399086580972.stgit@olly>
In-Reply-To: <164330771809.139041.6643670399086580972.stgit@olly>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 27 Jan 2022 20:02:49 +0100
Message-ID: <CAFqZXNv9LhVWD_cK+TbgnPSRnVSndecqJOh2vwqTVkxOQdu0zw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: various sparse fixes
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 27, 2022 at 7:22 PM Paul Moore <paul@paul-moore.com> wrote:
> When running the SELinux code through sparse, there are a handful of
> warnings.  This patch resolves some of these warnings caused by
> "__rcu" mismatches.
>
>  % make W=1 C=1 security/selinux/
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c   |    6 +++---
>  security/selinux/ibpkey.c  |    2 +-
>  security/selinux/netnode.c |    5 +++--
>  security/selinux/netport.c |    2 +-
>  4 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 221e642025f5..0e857f86f5a7 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2534,7 +2534,7 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
>         if (rc) {
>                 clear_itimer();
>
> -               spin_lock_irq(&current->sighand->siglock);
> +               spin_lock_irq(unrcu_pointer(&current->sighand->siglock));
>                 if (!fatal_signal_pending(current)) {
>                         flush_sigqueue(&current->pending);
>                         flush_sigqueue(&current->signal->shared_pending);
> @@ -2542,13 +2542,13 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
>                         sigemptyset(&current->blocked);
>                         recalc_sigpending();
>                 }
> -               spin_unlock_irq(&current->sighand->siglock);
> +               spin_unlock_irq(unrcu_pointer(&current->sighand->siglock));

Shouldn't this be:

spin_[un]lock_irq(&unrcu_pointer(current->sighand)->siglock);

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

