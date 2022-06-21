Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8F7C43334
	for <selinux@archiver.kernel.org>; Tue, 21 Jun 2022 15:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351921AbiFUPbN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jun 2022 11:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351717AbiFUPbL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jun 2022 11:31:11 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C2A2AE35
        for <selinux@vger.kernel.org>; Tue, 21 Jun 2022 08:31:09 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so9519050wms.5
        for <selinux@vger.kernel.org>; Tue, 21 Jun 2022 08:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YT/g1l+EhzOy6M+nS+bPwU5QfP9vQQuvmLes4FWs9nA=;
        b=zm+1B948VVBoC9zdmS3mRHOhlTzOOstEX1Msg5XVi49sfVCOnSIpk8b2dkPB7fCY+b
         Goajm2o/+0sxjayYUUrpCaauVigP981n/ef88s3lg6Uqd5IfgNwqM53vWLn6uYW44CJO
         lkW+eFe9poXybTn/y6UBnLxcT0pP53FHB87n0FydsMHrArcwuEOqj0Ylj1LCz2b+ZhfP
         Kx7dzCo3ZOFJQwnU+k51JdhWtP75KrzU6M7WiyIbwxRqRT05baeCa9ONMuUMG7eAPqW4
         f8ljW+lxxbIxsxEiA4J/qXviadQuo9KvaXEr4SF9Om93jcCcnr4DsHENocUxEsi/XAcw
         VsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YT/g1l+EhzOy6M+nS+bPwU5QfP9vQQuvmLes4FWs9nA=;
        b=t0yFpmAKVxC5XriAnA/6st+g6lk7QVlG7oOP/5/b5pLke4MdkEkYT/9DKHuUPPWlNs
         9VrAqvAoBfp9bGS4dNfr4fjrNwFBD5WaUqQeu+Mig1gAXkHCztuF1LpMbACSgW8WUDtY
         vJAQotmJvflPPdDnoCFDrsWuideOyqwEz+GNVIWjpUp+1ox1HWx47p8axadWK+x7eORt
         thONgr4ns2nhjG+7JlWmyoVOFuTTF0pz+NMBKo4+sY33RY14p9b+yGC3oV3Tgc4+BARz
         LOA8lJKhu8Sj9INvxLUnJvdZqr0XsaYJ/WPz7Iz12u4WiQPgsJ2KXJDGE3AxqgNsRiSp
         5ujg==
X-Gm-Message-State: AJIora/QZlqaXcSe+LhMqWimRH8ZrRJ4ydTbuUtzwoqNuwULbCPQV63e
        wbx+vmEsou1GpFoBBR2o8mnF8Ls4oL+HED84sIcJ
X-Google-Smtp-Source: AGRyM1tFlJzbaN0YRLI5nskwlap9strrp/mdu6n5GbB1zR8mMrlXwMjuJjoJ9Y5PdA6fFEJb3dRbMrNRS3BfacwgBKA=
X-Received: by 2002:a05:600c:2215:b0:39c:55a0:9531 with SMTP id
 z21-20020a05600c221500b0039c55a09531mr30734498wml.29.1655825467479; Tue, 21
 Jun 2022 08:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220621063824.241527-1-xiujianfeng@huawei.com>
In-Reply-To: <20220621063824.241527-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 21 Jun 2022 11:30:56 -0400
Message-ID: <CAHC9VhTXf=L97d9zuMOXr0JOm-vVgifJx7cSOJT+wLZZ7uA=gg@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Cleanup the enum SEL_COMPAT_NET
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 21, 2022 at 2:40 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> The "compat_net" compatibility code has been removed since commit
> 58bfbb51ff2b ("selinux: Remove the "compat_net" compatibility code"),
> so SEL_COMPAT_NET need to be removed as well.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/selinuxfs.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 8fcdd494af27..7115ca91ec05 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -58,7 +58,6 @@ enum sel_inos {
>         SEL_DISABLE,    /* disable SELinux until next reboot */
>         SEL_MEMBER,     /* compute polyinstantiation membership decision */
>         SEL_CHECKREQPROT, /* check requested protection, not kernel-applied one */
> -       SEL_COMPAT_NET, /* whether to use old compat network packet controls */
>         SEL_REJECT_UNKNOWN, /* export unknown reject handling to userspace */
>         SEL_DENY_UNKNOWN, /* export unknown deny handling to userspace */
>         SEL_STATUS,     /* export current status using mmap() */

Thanks for the patch, but keeping the old enum value is harmless
considering the size of sel_inos and I would rather see it preserved
just on the odd chance that some userspace tool is relying on specific
inode values.

-- 
paul-moore.com
