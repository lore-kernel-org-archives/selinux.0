Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A316C28CC6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 15:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC1026B9E
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 15:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="RPZh76mo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfEaPzj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 11:55:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36139 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfEaPzg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 11:55:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id m22so9871620ljc.3
        for <selinux@vger.kernel.org>; Fri, 31 May 2019 08:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVcOaYatOpeo1CRV+hYtc16/sImBcgmxdJUqU74IXf0=;
        b=RPZh76moKr55vlOhT6KnMQNS2x36jsAOlxZc9yNKyxBw0/CnSaJqQXxPo8wQogqSrH
         xvmcd8R/2F0tPP/2ihZ1+29FSCm9nEmo6aw5HY8bzked4RIQPKJuQOkb+A/GhtgtIj5a
         aLWdXP2tDDewNDPoZfQNbPfPMJRAtol/Hsyp/gqT51L1Anjn5GoDMPRjuY6Sc09LcwlO
         n4vSZg3ld4ZHB+BWhlysxicuNc0AlznR6JfJ4CZMe6EOFOQnF/TJRQYeJKzSXA7tqj9a
         Jpm9h6pr7EN7xwZSsvAaiJ12eb5JuE2TSUY+75Sh0GRQZQCe1qpwgP9inI/9WD2YWaC2
         8PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVcOaYatOpeo1CRV+hYtc16/sImBcgmxdJUqU74IXf0=;
        b=BwIZxlT7L+eHnJD9fsRurpOL970Fxb2xhxu18MZNJpMm9RzZAccqPCRDcocPmr+xId
         9JcUb7z7zRNJv+WXXpWz0NNp39GdKn9qUsKo7eavoLpxAgSQbL9sD/m3lIiUuISaT9C5
         85yBziLPq433b+ud1WKcKy6/nnKNP62m/oHGbIIJevQuxH8ZFzoziXdc7dKpwtseA7OA
         1DZdkQxp+0EVhqDrap0jKBpIRyrsdEqeg5/Invs47fF4QdqLtvAu3x3moPiSKa0d0b00
         Gv/1FZwOhGbtZmVLlt5gSMRj+wIbDthEOIrRnrPKp3MXtKwfPYWGiGNRTBGM60CXYWdM
         Q2FA==
X-Gm-Message-State: APjAAAXlA3E1vadiISeBr4BF3hJ1PxyM6yZ6Rkp2+5UB09yCaR9UDr7J
        p4Cp4YYqz1i63pcjwBGOMFeQEHu13Ss8So2H9jfe
X-Google-Smtp-Source: APXvYqzr2MCUTgiueRQHjiAeFx7vxTXPmGHbdykoMlbeOPTpRuJBL1Ru1ZFTbbOjFttwWXo6DFPAaxt9JHVyrRBUZds=
X-Received: by 2002:a2e:9a97:: with SMTP id p23mr6347647lji.160.1559318134012;
 Fri, 31 May 2019 08:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190530080602.GA3600@zhanggen-UX430UQ> <CAFqZXNtX1R1VDFxm7Jco3BZ=pVnNiHU3-C=d8MhCVV1XSUQ8bw@mail.gmail.com>
 <20190530085438.GA2862@zhanggen-UX430UQ>
In-Reply-To: <20190530085438.GA2862@zhanggen-UX430UQ>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 31 May 2019 11:55:23 -0400
Message-ID: <CAHC9VhSwzD652qKUy7qrRJ=zy-NZtKRGc7H4NZurzUcK4OgFZA@mail.gmail.com>
Subject: Re: [PATCH v2] hooks: fix a missing-check bug in selinux_add_mnt_opt()
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, ccross@android.com,
        selinux@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 30, 2019 at 4:55 AM Gen Zhang <blackgod016574@gmail.com> wrote:
>
> In selinux_add_mnt_opt(), 'val' is allcoted by kmemdup_nul(). It returns
> NULL when fails. So 'val' should be checked.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> Fixes: 757cbe597fe8 ("LSM: new method: ->sb_add_mnt_opt()")

Previous comments regarding "selinux:" instead of "hooks:" apply here as well.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3ec702c..4797c63 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1052,8 +1052,11 @@ static int selinux_add_mnt_opt(const char *option, const char *val, int len,
>         if (token == Opt_error)
>                 return -EINVAL;
>
> -       if (token != Opt_seclabel)
> -               val = kmemdup_nul(val, len, GFP_KERNEL);
> +       if (token != Opt_seclabel) {
> +                       val = kmemdup_nul(val, len, GFP_KERNEL);
> +                       if (!val)
> +                               return -ENOMEM;

It looks like this code is only ever called by NFS, which will
eventually clean up mnt_opts via security_free_mnt_opts(), but since
the selinux_add_opt() error handler below cleans up mnt_opts it might
be safer to do the same here in case this function is called multiple
times to add multiple options.

> +       }
>         rc = selinux_add_opt(token, val, mnt_opts);
>         if (unlikely(rc)) {
>                 kfree(val);

-- 
paul moore
www.paul-moore.com
