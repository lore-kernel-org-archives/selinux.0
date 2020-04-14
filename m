Return-Path: <SRS0=NJTS=56=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36530C2BA19
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 10:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD69206D5
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 10:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYBWOpKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438688AbgDNKyu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:54:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45585 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438454AbgDNKyp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Apr 2020 06:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586861682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MW+aNfzs3D4COi2BSgfuslmfAT8XS6hyrvfVSZnnAKU=;
        b=BYBWOpKPdITbPMfnzsf+bBDTbd88BMXAK7wE/N02hsOs4ZSxrF5Iz1ZgmkF3BMQHezr/Bg
        mhtug6o4kP/R+5nr0N3yuUzMp4nFA/+rDBZJLCPP8iFIS4+6Z+1RKaCdgdEftcxPHtbXGc
        KolHSPSx6vAu0RyvpOg8dH4GST0XOLM=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351--0T7NBsqM8KtZ_KbW4yIbg-1; Tue, 14 Apr 2020 06:54:38 -0400
X-MC-Unique: -0T7NBsqM8KtZ_KbW4yIbg-1
Received: by mail-oi1-f197.google.com with SMTP id w7so4445762oic.12
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2020 03:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MW+aNfzs3D4COi2BSgfuslmfAT8XS6hyrvfVSZnnAKU=;
        b=EUfnVw+DclJ8jDm2psCvUl8RKb7Kdmg5mgg6sfLPm3LPSfCEjduBXGPGLGOGtPqPg7
         ZaYNMTp4sy3HU98VWz31/GjaBNic9ay688NJtnq0MjaLzDwLs+0ChtoWsmjQIL8HaR9E
         gj2NF/fr5EYlwlQ+QBjYHrNL9elQ0t5xZsOH+f2eGmmXjvGQXgkzAxtia/FiML6T9M49
         vKMSAqLwdJZl3yMMuQ9sgbdtHLB5WvZ7YMIH99x4z+PCcMFwX9DD7HnmM5FWuN/NhhYg
         EijgE/pB7Ad/dMtHL5W8Z5Pf0+fAI0NcJEqQbTgFG1AGbCKPwOWOnE+9BYFMawbGVZJU
         qJrQ==
X-Gm-Message-State: AGi0PuZ+ePvMsa/+wfR2gbGVhXDjZXeceynJyHzsa7O3tSI2Y1raf11P
        tzNUwdpY1CPen9dlwvwl6gMuJSCfUS3eebLLk9Tkj1ohMizabLJUrWe1tZ/YUp318cZ2EkBFOl1
        wJAnCcCAm/JfoZ51FiRXOXlXclei415+11g==
X-Received: by 2002:aca:488a:: with SMTP id v132mr15245195oia.166.1586861677600;
        Tue, 14 Apr 2020 03:54:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypJQtLzxmslPUDMYm+GHnxtAihy/44rv/YRNCyn9y3J3K4zxjxbpDTd6epJ8ZlNv9ZRaibbOTctd8vYwv7ivMbw=
X-Received: by 2002:aca:488a:: with SMTP id v132mr15245178oia.166.1586861677332;
 Tue, 14 Apr 2020 03:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com> <20200408182416.30995-8-siarhei.liakh@concurrent-rt.com>
In-Reply-To: <20200408182416.30995-8-siarhei.liakh@concurrent-rt.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 14 Apr 2020 12:54:26 +0200
Message-ID: <CAFqZXNt4+O6Ys-5Xb8mrXyvSsVt6NanuHxkq0oN7BPok-ecvOQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] SELinux: Expose filename_tr hash table sizing via Kconfig
To:     siarhei.liakh@concurrent-rt.com
Cc:     SElinux list <selinux@vger.kernel.org>, colin.king@canonical.com,
        Eric Paris <eparis@parisplace.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Siarhei,

On Wed, Apr 8, 2020 at 8:24 PM <siarhei.liakh@concurrent-rt.com> wrote:
>
> From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
>
> This change exposes previously hardcoded filename_tr sizing via Kconfig,
> which provides a more convenient tuning mechanism for downstream distributions.
> Default sizing is not affected.
>
> Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
> ---
> Please CC me directly in all replies.
>
>  security/selinux/Kconfig       | 10 ++++++++++
>  security/selinux/ss/policydb.c |  3 ++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> index b7ced53ffd76..23ec741b1ce6 100644
> --- a/security/selinux/Kconfig
> +++ b/security/selinux/Kconfig
> @@ -123,6 +123,16 @@ config SECURITY_SELINUX_AVTAB_HASH_BITS
>           footprint at price of hash table lookup efficiency. One bucket
>           per 10 to 100 rules is reasonable.
>
> +config SECURITY_SELINUX_PDB_FILE_TR_HASH_BITS
> +       int "Number of slots (buckets) for File Transitions hash table, expressed as number of bits (i.e. 2^n)"
> +       depends on SECURITY_SELINUX
> +       range 1 32
> +       default "11"
> +       help
> +         This is a power of 2 representing the number of slots (buckets)
> +         used for File Transitions hash table. Smaller value reduces memory
> +         footprint at price of hash table lookup efficiency.
> +
>  config SECURITY_SELINUX_CHECKREQPROT_VALUE
>         int "NSA SELinux checkreqprot default value"
>         depends on SECURITY_SELINUX
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 0d03036ca20d..f2d809dffb25 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -496,7 +496,8 @@ static int policydb_init(struct policydb *p)
>         cond_policydb_init(p);
>
>         p->filename_trans = hashtab_create(filenametr_hash, filenametr_cmp,
> -                                          (1 << 11));
> +                          (1 << CONFIG_SECURITY_SELINUX_PDB_FILE_TR_HASH_BITS));
> +
>         if (!p->filename_trans)
>                 return -ENOMEM;
>
> --
> 2.17.1

Note that this patch in particular won't be needed after (if) [1] gets
merged. Then for all policies built by new userspace the number of
elements will be known before the hashtab creation and it will be
passed to hashtab_create() directly (as is already done for the other
hashtabs). The hard-coded size will only be used in the
backwards-compat code path (when a policy built by an older userspace
is loaded) and thus won't be worth tuning any more.

[1] https://patchwork.kernel.org/patch/11462503/

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

