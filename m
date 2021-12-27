Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65E9C433F5
	for <selinux@archiver.kernel.org>; Mon, 27 Dec 2021 15:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbhL0P4R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Dec 2021 10:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241675AbhL0PzK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Dec 2021 10:55:10 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE626C08EA74
        for <selinux@vger.kernel.org>; Mon, 27 Dec 2021 07:48:42 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id bm14so63172190edb.5
        for <selinux@vger.kernel.org>; Mon, 27 Dec 2021 07:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ruYVqDjSzvKE9ESDPOstmLOwEK7+kWJthKgCsoXnHVY=;
        b=gncD0yuRaX+MOn2Kq0j/LeVUg8abEo1ACRTxQ6aLtpDnN9/a2GUIwaLmSNy7xfXDmH
         +5ecYsxj+WJ49A1B1MAWUBY667WuJ/xk18ROqTqZcFB/xiSeYrZybosg5tTWvSWnePOF
         /MaNtMrJ/QFkLpQLSOB57zKZYNQZtRs1pQAM25x1sPo/ZXzF9/Xr575HQO8zUpKBPzXc
         Pim6X6E8EiYFsdO+XelUg0gDZHgxUbq9waD8Ep37ER/fVO3qbepfA3LDtBU231R0PJNa
         4Ib7NkZ6AejM255yP3a17tRZgAtUx1gB/6OAxqZ6pyAszJclgSw356QQMsQ8Z4ZTH4oN
         W/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ruYVqDjSzvKE9ESDPOstmLOwEK7+kWJthKgCsoXnHVY=;
        b=5llrMixS2TCdI1QRRSk2+07ypsfuyUWL6LdfEkCn4+aTBUteh3jL05LSB79r4Ibmkz
         HlMT5RezGDp2AtU8BViErY94vqgWQWcqc+S2efp7K5px5KoWx++OJgCCNtdnnSzzxn9m
         HrRA/NrQYKx8PiS4bhUbfdlurLPQXAPdxUPcaOdZXV/xY3G1ZNCv92RHnwj4iYYHrjl0
         kuLfOB3OvrbkJQNc0UWtPRlhy1KQg22v1Y37ttO6J/KmFjvYs1V2SaPSf8kZ/0jhrWDE
         FfiK2e9lEdE/7/uA1PcjjU9aDNJdElYeDJA0RxwuooQbwpZwYimnAYpofV6I2wXkMphX
         aqNA==
X-Gm-Message-State: AOAM533YRW3gPBt4qKJFIoyOoy8pAIXXYoYTmVrkQf4IHhUpqy3xAqDE
        9iDPn18e1z0Bs3M0glgTBgS2EqV+5K8dWoMCPjGQW40Igw==
X-Google-Smtp-Source: ABdhPJykLSQBHob3XG4bD0UAP8+YA6SVKSYWEEW+4XpOd3xphqx/nenjfXqcIvc7dsZdFgHEfd0gNvauJ5cgfEAh/qE=
X-Received: by 2002:a17:906:7304:: with SMTP id di4mr14134518ejc.327.1640620121150;
 Mon, 27 Dec 2021 07:48:41 -0800 (PST)
MIME-Version: 1.0
References: <20211224150739.3278019-1-trix@redhat.com>
In-Reply-To: <20211224150739.3278019-1-trix@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Dec 2021 10:48:30 -0500
Message-ID: <CAHC9VhR+ou3fx_b0dKgu12L6janT8_7DEHQ54QY-QYsZcUDEag@mail.gmail.com>
Subject: Re: [PATCH] selinux: initialize proto variable in selinux_ip_postroute_compat()
To:     trix@redhat.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        nathan@kernel.org, ndesaulniers@google.com,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 24, 2021 at 10:07 AM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Clang static analysis reports this warning
>
> hooks.c:5765:6: warning: 4th function call argument is an uninitialized value
>         if (selinux_xfrm_postroute_last(sksec->sid, skb, &ad, proto))
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> selinux_parse_skb() can return ok without setting proto.  The later call
> to selinux_xfrm_postroute_last() does an early check of proto and can
> return ok is the garbage proto value matches.  So initialize proto.
>
> Fixes: eef9b41622f2 ("selinux: cleanup selinux_xfrm_sock_rcv_skb() and selinux_xfrm_postroute_last()")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks Tom.  I don't think this is something that could be easily
triggered on a normal system, even if the compatibility mode was
enabled, but this is something that we should fix regardless.  I've
merged this into selinux/stable-5.16 and will send this up to Linus as
soon as it clears the normal automated testing.

-- 
paul moore
www.paul-moore.com
