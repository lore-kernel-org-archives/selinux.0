Return-Path: <SRS0=Kg/k=ED=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D4CC55179
	for <selinux@archiver.kernel.org>; Wed, 28 Oct 2020 22:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3414206F4
	for <selinux@archiver.kernel.org>; Wed, 28 Oct 2020 22:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="xQCZpC4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbgJ1WYK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732814AbgJ1WYI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Oct 2020 18:24:08 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B44C0613CF
        for <selinux@vger.kernel.org>; Wed, 28 Oct 2020 15:24:08 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id x6so968070ljd.3
        for <selinux@vger.kernel.org>; Wed, 28 Oct 2020 15:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xUr4wmN6YAMFAMs/alPzV/eL7lAzWJPO5NuYVAJTKO4=;
        b=xQCZpC4hRFEmqqxCphEGAP0t+o7k5wUhIMUuwQgTDLBhczhzZdT0QBIuN0v47vciCF
         8p2qx1L3xSX7K56ODcRtSWU3YUJ6Sw8dOLZvdOb2t4Xv0mnacFs3qvE10s8y8IdSarh4
         iuLrxr/BtsN96me4AYK0Qf1D1zCoYOm4bSN0IAdn5VV9rKGVVkU8sBF619ze2RyW0Uiv
         PcxzqJ/RZItOs5kvD7rd9ubNdh+UjlNbF+o6Xi7b1t+K4zy+NmOnDgrwjPqWF0t58SbW
         PhVQzJ9vpWreV03VZ6Q9un9OswHFRjZHk37mUf01jucV//pGCWAgxbDliB1oD6DZ1YZu
         k6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xUr4wmN6YAMFAMs/alPzV/eL7lAzWJPO5NuYVAJTKO4=;
        b=a/aoNk+mo6sFW7Kx8DVEPK7WsTMma1q3Q4I/qpYP4QcrEo/EyYlRhqcNm7/7vyuxEv
         0+M3GkLs6bttU8Qmz90nJx2KDQI/s4KUtnohMniONDEAGA5w4ANzFCjk8/3ZBDIG+Ybc
         85MXNzyD/cSZxmzUD3tCoGVPA2OzgFX6c7rvu2HwKUv5eS33vzdGHMb73LOVK6duQAMK
         NsZKdthnOTMsYXV6JSKJqP2Ul+3PCH3gsI18T39tIJtTvMTn8893k4LLnui0X8GUNhsq
         lijzUoxxsJ4kPdSTI8HW5Y0ixVgc4kzvZ5qtog/DMk+3NTKMwraukYrPU4jQC4pfqbAO
         10wQ==
X-Gm-Message-State: AOAM530uG37gcSQyW1MmCXTShnEbb85Sxozu80jZjaF0Z2slBwapVgRM
        GV1BIFQO+npoUgPszk6kaGyob40YNVPYW2LAf2by5/C1MSZG
X-Google-Smtp-Source: ABdhPJx1NDnItXvlxdM56DxxzHXiRgQw6VZGiNIq7A4b0a/ONZ+2etNuWJ9EhVeimpLJ7jhqAvWjkQ01kjm77qwDSr0=
X-Received: by 2002:a17:906:ce5a:: with SMTP id se26mr5248320ejb.106.1603851879816;
 Tue, 27 Oct 2020 19:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQ9h4rQK8W03jCmtqgr81jRueh_jzd8XjAkjzcCvGmCmw@mail.gmail.com>
 <a30c2b0c-d403-f296-5f15-aa7ec3a99db4@gmail.com>
In-Reply-To: <a30c2b0c-d403-f296-5f15-aa7ec3a99db4@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Oct 2020 22:24:28 -0400
Message-ID: <CAHC9VhRWtZ3CojV=M5z+qQeF+SFFB=-R7-wCAsA826Jia69sXg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: allow dontauditx and auditallowx rules to
 take effect without allowx
To:     bauen1 <j2468h@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        Nick Kralevich <nnk@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 9, 2020 at 8:47 AM bauen1 <j2468h@googlemail.com> wrote:
>
> This allows for dontauditing very specific ioctls e.g. TCGETS without
> dontauditing every ioctl or granting additional permissions.
>
> Now either an allowx, dontauditx or auditallowx rules enables checking
> for extended permissions.
>
> Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>
> ---
>
> v2: dropped the precedence change, I will make my case for that seperately.
>
>  security/selinux/ss/services.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

I feel that the Android folks have had plenty of time to comment on
this, and they haven't, so I'm going to go ahead and merge this since
it seems to make sense.  Thanks for your patience Jonathan.

I think The SELinux Notebook probably needs an update with respect to
this patch, mentioning that in Linux v5.10 the xperms auditing
behavior changed.  Can you submit a patch for that as well?

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 9704c8a32303..597b79703584 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -596,9 +596,7 @@ void services_compute_xperms_drivers(
>                                         node->datum.u.xperms->driver);
>         }
>
> -       /* If no ioctl commands are allowed, ignore auditallow and auditdeny */
> -       if (node->key.specified & AVTAB_XPERMS_ALLOWED)
> -               xperms->len = 1;
> +       xperms->len = 1;
>  }
>
>  /*
> --
> 2.28.0

-- 
paul moore
www.paul-moore.com
