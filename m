Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4218C433E9
	for <selinux@archiver.kernel.org>; Thu, 11 Feb 2021 21:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9DFD64DE3
	for <selinux@archiver.kernel.org>; Thu, 11 Feb 2021 21:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhBKVZJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Feb 2021 16:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhBKVZJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Feb 2021 16:25:09 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A38C061574
        for <selinux@vger.kernel.org>; Thu, 11 Feb 2021 13:24:28 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id sa23so12311266ejb.0
        for <selinux@vger.kernel.org>; Thu, 11 Feb 2021 13:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TNQWFiyPdo3ojYabHzl68ZCQOfKSj9UblM8Ayd7V6k8=;
        b=0UTYGiD+q8sRdd4e9z+0UDeoWRhcEMd6O3vLz6j6fcXyEceSwiC1v+wuvcM9YYHryq
         kCtgM15eZ/olcm628YFo3W70n2Yd+D4AWaZv7/p0hFJ/QTBNKbS/f8UkjMM4+n3q2RsC
         Ile04VI8ev0qFWbpKyGQ8Yf60aAId0Tbtmjm8ZnnSlUuFPdQwmbxTBfqwj0Hsw/pPyVl
         LrkvuvjCoBDFwBxLLaxWKTn6uC3Ho4LvE76WnQ3X/u3DugeJYFJk/dXgNZ9s2JqFiQrq
         osBN79Qhp+voo132GxBqLj8RAJKV9MS+62ALd1xZLxA/awnNZYa/ZQGUqs36skEcgKzO
         Z7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TNQWFiyPdo3ojYabHzl68ZCQOfKSj9UblM8Ayd7V6k8=;
        b=rGvcZYjJY5F7sLuQZjvJ2ktAzwZKjUYDas32C/Qx9oac6Q3eaZS8TbzR6M4OpgUzqF
         xkSgtcGyRa+nFfohPi//Jk74qJDdSLWiyr+xTLoqqO7KA2BYsgU2OxWYkz9AeBTknaBW
         oZ5YWmcT2yieIoij5dj6yiq8c68ZFguDa5C7uYS6gkmoKazyxlzVkGJr2ilDNtJo2MOQ
         W0az/xLLDFpTrKVtv9BMtHRXLNkcJ/w4eKWmKmikYDem9b0v0jdySXa4oAeJl07Cm0Pq
         LL978UsN5HX3x8JXsFwd9UnoDmxaigkNn3yJg7O/qp4/Q7AH6ggM5MXftOsEwF7PDsQR
         1OxQ==
X-Gm-Message-State: AOAM530uydw+vf2WJ0eOsTgaJ7PmhJ8lC/NV49UZ3NYsjmBiLl8vynIF
        BJ19dY9ybzvtUijU6t/yhfVRx7HDej980INDDi4B
X-Google-Smtp-Source: ABdhPJzg+xsqK6Q0BsRYV8h1s0SJFG6SaF05PNIQrOtXeBKCsbEGJOUCqJslJ1jhv+m2CVmqraNE739MufK3mqAzEjk=
X-Received: by 2002:a17:906:c010:: with SMTP id e16mr10170417ejz.91.1613078667508;
 Thu, 11 Feb 2021 13:24:27 -0800 (PST)
MIME-Version: 1.0
References: <20210211180303.GE5014@redhat.com>
In-Reply-To: <20210211180303.GE5014@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 11 Feb 2021 16:24:16 -0500
Message-ID: <CAHC9VhRM6MiF1m2aFpLJKb3CFWXcXEX_SY=EnkLaq7U_X2UTZw@mail.gmail.com>
Subject: Re: [PATCH][v2] selinux: Allow context mounts for unpriviliged overlayfs
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     selinux@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 11, 2021 at 1:03 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Now overlayfs allow unpriviliged mounts. That is root inside a non-init
> user namespace can mount overlayfs. This is being added in 5.11 kernel.
>
> Giuseppe tried to mount overlayfs with option "context" and it failed
> with error -EACCESS.
>
> $ su test
> $ unshare -rm
> $ mkdir -p lower upper work merged
> $ mount -t overlay -o lowerdir=lower,workdir=work,upperdir=upper,userxattr,context='system_u:object_r:container_file_t:s0' none merged
>
> This fails with -EACCESS. It works if option "-o context" is not specified.
>
> Little debugging showed that selinux_set_mnt_opts() returns -EACCESS.
>
> So this patch adds "overlay" to the list, where it is fine to specific
> context from non init_user_ns.
>
> v2: Fixed commit message to reflect that unpriveleged overlayfs mount is
>     being added in 5.11 and not in 5.10 kernel.
>
> Reported-by: Giuseppe Scrivano <gscrivan@redhat.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  security/selinux/hooks.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks Vivek, once the merge window closes I'll merge this into
selinux/next and send a note to this thread.

-- 
paul moore
www.paul-moore.com
