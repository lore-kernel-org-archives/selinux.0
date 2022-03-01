Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08196C433F5
	for <selinux@archiver.kernel.org>; Tue,  1 Mar 2022 22:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiCAW6p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Mar 2022 17:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiCAW6o (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Mar 2022 17:58:44 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93F6643D
        for <selinux@vger.kernel.org>; Tue,  1 Mar 2022 14:58:02 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bg10so13937ejb.4
        for <selinux@vger.kernel.org>; Tue, 01 Mar 2022 14:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=gL/XkgGAO7mxj8M+HTBuorXxGlo2Z8KQlEZkjfciOng=;
        b=5ZVBhsoStNYc4ErNouxgkKdxgrU+7JljYO8f+Cw7r6s2pxmTLxKvZfrcYy32xIntV/
         e2wSOAlcuNAtw+MCrbcIPdRioZP+Z0n5RxgbjOiKcTKJlQO88553YzGVZ7kEC+t7/6HY
         FiBYaqdDiEOKsgV7xtzWNIeiExu1rDrSFx6uojeGKxTXp2FD/a29MPCuwet/l3IXDzrG
         0u2PHfRq4+kSEKNEI8tGW7HHIurqL/QBPoSwLEA54yoZArEtPObxBZRczs9YmkoQqyou
         gq9yKKXO/6MJEBDbucvA6o208sPeJLVvuq79UAf4t8L0vgb4okB1L3BTaiWyeA/AxEZR
         kE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=gL/XkgGAO7mxj8M+HTBuorXxGlo2Z8KQlEZkjfciOng=;
        b=rZY0snsAEVJjqJM5PFjdQjmSq64WUpy/Bjg1yhia5Ozb5njXsfokb2pFMmamPGx1Nx
         JKPuMch8hNVst1l5/Z3Kov9psTBjkcMP9XsicuC933OIci7gU/MhLYbLJWE72XJMwmxb
         flIs/lG+y9KoJ4nux0qPmrslM+2gD43Xu4snuvVHzS6ZdIyfYH5v4EW3SlNtmTKT9wwH
         EORgMZLduhyy5is/42CZSBwmRmaRfagTlfqbgPIZPYVPSSFMawtjUq1QzaXcKbUgLzVk
         j0bK4dZP+gDlmFjakKPVRt6thn0Ixm0CfTYSlv5kElAjbLj68FcT4BvQzx8u1VxsvBp1
         Cedg==
X-Gm-Message-State: AOAM530p77NZKx9LljYipuSzkFOqjWENGOsfWaBVpjXvdcNWhdwTyM01
        rnxmr18Fz3wz/dHPdbnOTrKfGwLlTRyUuvC1GRsYikDAJQ==
X-Google-Smtp-Source: ABdhPJxLhleoXDU8XDsQ+VhNre1nwVJIzDvSS5OMJt3F+VeiT+ZFl2HbGpyGK3Vp032HBtAmqpuMlK5VpcbckKS+BuQ=
X-Received: by 2002:a17:907:216f:b0:6ce:d85f:35cf with SMTP id
 rl15-20020a170907216f00b006ced85f35cfmr20881017ejb.517.1646175481097; Tue, 01
 Mar 2022 14:58:01 -0800 (PST)
MIME-Version: 1.0
References: <164617518151.117500.8843073220563946007.stgit@olly>
In-Reply-To: <164617518151.117500.8843073220563946007.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Mar 2022 17:57:50 -0500
Message-ID: <CAHC9VhS=tPgNy75ou7MSBuTKe7tc4soJBKdUewmyK1U6TueT=A@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 1, 2022 at 5:53 PM Paul Moore <paul@paul-moore.com> wrote:
>
> We deprecated the SELinux runtime disable functionality in Linux
> v5.6, and it is time to get a bit more serious about removing it.
> Add a five second sleep to anyone using it to help draw their
> attention to the deprecation and provide a URL which helps explain
> things in more detail, including how to add kernel command line
> parameters to some of the more popular Linux distributions.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/selinuxfs.c |    2 ++
>  1 file changed, 2 insertions(+)

Comments are also welcome on the text in the URL shown as part of the
error message below.

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index f2f6203e0fff..3739155ee0db 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -293,6 +293,8 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
>          *       kernel releases until eventually it is removed
>          */
>         pr_err("SELinux:  Runtime disable is deprecated, use selinux=0 on the kernel cmdline.\n");
> +       pr_err("SELinux:  https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-runtime-disable\n");
> +       ssleep(5);
>
>         if (count >= PAGE_SIZE)
>                 return -ENOMEM;
>

-- 
paul-moore.com
