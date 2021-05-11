Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82F5C43461
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 01:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B38D76162C
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 01:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhEKBlb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 May 2021 21:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhEKBla (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 May 2021 21:41:30 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEF4C06175F
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 18:40:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id j26so17255263edf.9
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 18:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UewUIUnZEU+WLxgt73DD3mXzDpZZk6Udya01I4ZEHrw=;
        b=kswNC8BfZzTXjrd6CNTModmWLgnAvrz8jFPHApeblmQg6rKJTfpByfO00OR0Pz90U7
         j1h5wLO98+mXFSkHIGaBBPFlGFIlVgszWA4z5S//jxNs7j6V5k7SvxLs2BACJNEA6cY6
         DdJk9F38VUmJZBUbe9y0G/3gP+BARMhWvICBTY4L0I+bRubNxCVz0PQMxcRQKAw3iRiO
         9MY1YMyzrEx57GDbBf8hCIEs3/VeMBEt//BpG/7jKlbyR/3VUWpUVsq//ToDHX33Pe2D
         UrYTX7tsSokm+E8dtjV5qW0tm9osyXnMLHx2HdZLyQm8oWzBGAc9Z9pL9D7wg9NU6CQ0
         vTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UewUIUnZEU+WLxgt73DD3mXzDpZZk6Udya01I4ZEHrw=;
        b=EC+IyJ6KY/SBY6ZSK9uIFCuikFxlXt8L0mqxZ56l1hxeuiIn82fWZq5sv6wGpmxlmg
         MDEaZcZ321tOCf5IyxEP0BSTe/5EoaUQig9fYx9PM0yL7erafblqWoe9j3Fl6ctJlgEr
         LAlBJEeRqAHwcjcPw0fZqvx5IGgiltt1btleqm2iHldOSCsCE8QGw/vzoZ6zDBcS2/YD
         yPAfBvYZK6UhkTN8d2RJu4yrqe67rB8brAAFx64i+eTbGBK2ehLAoJdTJJk4VwCB2jT+
         mLOQ1Q1NgqvaoohYY+JCgwwm/+pxsxavsYim8vU2MrCGOahvylt3FsROSRJCrrVfsjg4
         0vNA==
X-Gm-Message-State: AOAM531m/j0Y1q9FrkWDslkiMotaoMkg2uX5DPWnGQ1HKPeqaemynkKr
        /2OceO3zUG+UZ75NPZmsycaA4DoWDSVs/VJu4E+7
X-Google-Smtp-Source: ABdhPJyiTl7fBwjdXCS+1nwJylc1lzHYHwN8ZdaJRSyBufr+LfV/BQ7QX/iNclrk81EQS7LWDc/1AEQHqAIC14Mt+cY=
X-Received: by 2002:a05:6402:177c:: with SMTP id da28mr32267501edb.135.1620697221981;
 Mon, 10 May 2021 18:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210409054841.320-1-hbut_tan@163.com>
In-Reply-To: <20210409054841.320-1-hbut_tan@163.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 May 2021 21:40:11 -0400
Message-ID: <CAHC9VhT8+DR0jvY8SO=HArhjcTfxsZxaoqy-1ufcOQEcD6qOXQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux:Delete selinux_xfrm_policy_lookup() useless argument
To:     Zhongjun Tan <hbut_tan@163.com>
Cc:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, kuba@kernel.org,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, keescook@chromium.org,
        gregkh@linuxfoundation.org, ebiederm@xmission.com,
        kpsingh@google.com, dhowells@redhat.com,
        christian.brauner@ubuntu.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Zhongjun Tan <tanzhongjun@yulong.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 9, 2021 at 1:52 AM Zhongjun Tan <hbut_tan@163.com> wrote:
>
> From: Zhongjun Tan <tanzhongjun@yulong.com>
>
> seliunx_xfrm_policy_lookup() is hooks of security_xfrm_policy_lookup().
> The dir argument is uselss in security_xfrm_policy_lookup(). So
> remove the dir argument from selinux_xfrm_policy_lookup() and
> security_xfrm_policy_lookup().
>
> Signed-off-by: Zhongjun Tan <tanzhongjun@yulong.com>
> ---
>  include/linux/lsm_hook_defs.h   | 3 +--
>  include/linux/security.h        | 4 ++--
>  net/xfrm/xfrm_policy.c          | 6 ++----
>  security/security.c             | 4 ++--
>  security/selinux/include/xfrm.h | 2 +-
>  security/selinux/xfrm.c         | 2 +-
>  6 files changed, 9 insertions(+), 12 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
