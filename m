Return-Path: <SRS0=4SPy=7P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA7DC433DF
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 12:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47775206A2
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 12:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="htiBsV8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgFBMuE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBMuE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Jun 2020 08:50:04 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51840C061A0E
        for <selinux@vger.kernel.org>; Tue,  2 Jun 2020 05:50:04 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a2so12578816ejb.10
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2020 05:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=q7Jfd9vsR+kPtmC+L4L0b1kPMnnQYZrdmmXkWf13cbc=;
        b=htiBsV8FFcZXb4cYgnzPftZEOcJgsZUHkZzJQyYD0+HqmSIAWDwagZgOIcdCkjvKU4
         6JjwwTDvL3qtpV6B07U2/WGC60aJ2yAWpwJEYH2DKfeKCPg7we+y6UxDf0sa4z1Q8MLh
         Rh9YyFuI5uiDwOQQ52aDZuLiQDii3vnuJdW5vVz5N8f7PCzA05Xdajbmc622dnYKH0HY
         /QaN5uFiYBKodH0jszQthwEMuJ4Y1gJ/JruDuDU7cXOhsXwYaYynaiEDda2SfMGJBCm8
         Bgba7DqjLEsJUJstcKbCvGJKWi4CTDms19GwuQv1dFRENc4KPpL5N14ha3QqEemtSD45
         IzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=q7Jfd9vsR+kPtmC+L4L0b1kPMnnQYZrdmmXkWf13cbc=;
        b=CwVNwOdtALO+h9Z2VK2tOdCWG8Ta6tUXwzTGaClxmwJyY2kHOWiRUuKWd/RiL3eRrH
         gMCK9AtmE9X7Chsqq7cEo+L/U1NVHZXOCI1Ns4AmYVk425W+ae7FqQWyQo4iE8fztA/u
         9QJmFvqhPio4tBk17kCMhFOaeRskQyxtc9jz3ZMkDF5iuqNKbfMNM//94zInozh5k3aY
         snLX03AnDF+2mphy1E+K7wrnowwYMhljn5T2+OTWWGLlahUT9vuDwrgYEPNVvWcuDLXr
         2pypaOdwo8UMP1BpC2CVOdUbqPauOZGCq4cD9DwsfK+oocI/Rmq18XQ+bGXJ1KRO2OpF
         +xdg==
X-Gm-Message-State: AOAM5313LyaNwL1VTg+QJp1X8IVh2+GR85G2OkP2xA16kqfv5wEA4UnU
        4KrlSPiY9i+gOyv4h6Jaqb6f9Mo3aGoyNIOyzMt23Mc=
X-Google-Smtp-Source: ABdhPJyoSg9SKwIPbJBPPqb+qNsntt21m/CRc6gjTL7E/OaxNw+FJkn2jUZ2kj5wTY7VkS8ddLyEXfKpas+dxhc/XVc=
X-Received: by 2002:a17:906:2b81:: with SMTP id m1mr2352890ejg.488.1591102202637;
 Tue, 02 Jun 2020 05:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <159110207843.57260.5661475689740939480.stgit@chester>
In-Reply-To: <159110207843.57260.5661475689740939480.stgit@chester>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Jun 2020 08:49:51 -0400
Message-ID: <CAHC9VhQacYKE4sJRbqmpudXfMyzCT8VM0SFUCi=o-MNsn4c_MA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 2, 2020 at 8:47 AM Paul Moore <paul@paul-moore.com> wrote:
>
> We deprecated the SELinux runtime disable functionality in Linux
> v5.6, add a five second sleep to anyone using it to help draw their
> attention to the deprecation.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/selinuxfs.c |    2 ++
>  1 file changed, 2 insertions(+)

Warning: while trivial, I've done no testing beyond a quick compile
yet.  I'm posting this now to see what everyone thinks about starting
to make it a bit more painful to use the runtime disable
functionality.

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 4781314c2510..07af1334d9c9 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -30,6 +30,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/kobject.h>
>  #include <linux/ctype.h>
> +#include <linux/delay.h>
>
>  /* selinuxfs pseudo filesystem for exporting the security policy API.
>     Based on the proc code and the fs/nfsd/nfsctl.c code. */
> @@ -287,6 +288,7 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
>          *       kernel releases until eventually it is removed
>          */
>         pr_err("SELinux:  Runtime disable is deprecated, use selinux=0 on the kernel cmdline.\n");
> +       ssleep(5);
>
>         if (count >= PAGE_SIZE)
>                 return -ENOMEM;
>

-- 
paul moore
www.paul-moore.com
