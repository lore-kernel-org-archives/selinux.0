Return-Path: <SRS0=hg1M=T6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6466EC28CC3
	for <selinux@archiver.kernel.org>; Thu, 30 May 2019 11:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D11B21E6D
	for <selinux@archiver.kernel.org>; Thu, 30 May 2019 11:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfE3LwX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 May 2019 07:52:23 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37578 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfE3LwX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 May 2019 07:52:23 -0400
Received: by mail-ot1-f66.google.com with SMTP id r10so5317075otd.4
        for <selinux@vger.kernel.org>; Thu, 30 May 2019 04:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vAN+W8HMPR+e2EfUykPuPve3XAe6lmTzwXCfaLwdSz8=;
        b=ahsQqrL5XjdAD8s0E4pnmrB5bkbPxXb4XXnAGySOaERkURW4BRKGD3tiORY9K3Iwp/
         hnphtOvCDacJbJF2P4yQCMdIslELduvdEOQxm53VuWgu32zFsqPTwGLjeMpf63MdtUia
         VqvZcF8tsdov8Zvj3Zt9pcxUi89gAQHOaQZlEGtvyAEBW3G55Lrb3MHW4xfA/6B3LZtS
         kMWRFYlWS+Ch1cYbExBuBjUm3Q2YSkEkTfRzZqfix+j8ZSVFkwSYyhD/pyFfRAvQowSA
         LrjBbl/JynXxO1QPVxWLZgmlbC96HWvQB79l60O0nsj4Ih0vsvUwhYONXrF142+RwfBW
         TRVg==
X-Gm-Message-State: APjAAAWfI/R+ejl2nUVH+KJGB787JgCXSxLvB3XPJKW/e8tE4N2YZnQC
        1FvhX8pvCNMD4g5hmVx4ooe6lU16dA+GGw5cMyLGyw==
X-Google-Smtp-Source: APXvYqxKpCp2brBM13KsmN/4s51AkFDodgy602B18KVX9OGtDboNvG1r1eWhhRO2gFVi4V5WEVlWY0LUDFO4YhGMEBE=
X-Received: by 2002:a05:6830:154c:: with SMTP id l12mr2235146otp.66.1559217143019;
 Thu, 30 May 2019 04:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190530035310.GA9127@zhanggen-UX430UQ> <CAFqZXNv-54DJhd8gyUhwDo6RvmjFGSHo=+s-BVsL87S+u0cQxQ@mail.gmail.com>
 <20190530085106.GA2711@zhanggen-UX430UQ>
In-Reply-To: <20190530085106.GA2711@zhanggen-UX430UQ>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 30 May 2019 13:52:12 +0200
Message-ID: <CAFqZXNuVVTL4FmBRvsZri+tvv4T4U47tMLjTZvSr7Cro=hR5Dg@mail.gmail.com>
Subject: Re: [PATCH v2] hooks: fix a missing-check bug in selinux_sb_eat_lsm_opts()
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, tony.luck@intel.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 30, 2019 at 10:51 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
> returns NULL when fails. So 'arg' should be checked.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> Fixes: 99dbbb593fe6 ("selinux: rewrite selinux_sb_eat_lsm_opts()")
> ---
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3ec702c..5a9e959 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2635,6 +2635,8 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>                                                 *q++ = c;
>                                 }
>                                 arg = kmemdup_nul(arg, q - arg, GFP_KERNEL);
> +                               if (!arg)
> +                                       return -ENOMEM;
>                         }
>                         rc = selinux_add_opt(token, arg, mnt_opts);
>                         if (unlikely(rc)) {

Looking at the callers of security_sb_eat_lsm_opts() (which is the
function that eventually calls the selinux_sb_eat_lsm_opts() hook),
-ENOMEM should be appropriate here.

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
