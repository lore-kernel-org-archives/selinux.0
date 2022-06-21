Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A514BC433EF
	for <selinux@archiver.kernel.org>; Tue, 21 Jun 2022 01:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbiFUBWR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Jun 2022 21:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbiFUBWP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Jun 2022 21:22:15 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A2D6395
        for <selinux@vger.kernel.org>; Mon, 20 Jun 2022 18:22:14 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o8so16810010wro.3
        for <selinux@vger.kernel.org>; Mon, 20 Jun 2022 18:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iGjjY3HwOIbttDwUviSsDQPsfAs3UUDt07n3f4W7ebQ=;
        b=hnD5iao8QXyX4Am/IkpwLe36L0lhcFXUS9xABII7VIuDsCodgNb9mLuww/8hvhAQ+U
         dURvI7VLHfSpnufrdyDrHeMM5PYellEIW7LsmQ+COuxxgo+evSCiCFouKZJfw6l4uL11
         ASLeErBCwWndAVyF2EuOX+uK632Op8J3u8vq6ZhedSixDg8Tw2pq48sL0imLE9RFfM0Z
         sbro9vvE7qH6o5Bl5+8zcxPeDCqpNklnbANFwGnOXgN9jghips19+aIUwdslj8p6MVGj
         Xj329321iOTelgM4m7YEeEuhvqG+j+0XGOP/95Pd3HSuPMgnVLJ1HP3QomhQefqB7hdV
         WOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iGjjY3HwOIbttDwUviSsDQPsfAs3UUDt07n3f4W7ebQ=;
        b=LDQqd9s67No+b43TFUXk+886IPza6lHhC8+gmlLdlCWa+wx4oIZ7luCu8qWTspuvjs
         2k5v/8KQQfMdkEbsmUrQb/Nov2FCOUykGmmKeTi1cb4Eu+x1J6O6Kr5nkU19JCyR/nvu
         QbNThiurvP0HnimR/VqZyNBysBE9MU+QaYM8JEOmBgHATXlkq5UTGWjCOurkukXzNHnS
         /hlEKUeZbH8x4gxPWXrmZ9BxfLehOERtRq1LmSgRH0qA56e9BpfnNdRWa4HijBs9EKcA
         T+3i3oYWG+FimT/W/va/NOWzJTOiX2Z0aI1sMMlOM5TRWFZRzbcMrEWuHrzKgpl3jVrH
         lmMw==
X-Gm-Message-State: AJIora83+NJUKu0nJTLHCh6yKBl5Qu7OGNuHqgOzhZ4/GvCxvvZ+7Vw4
        UsNvyLasqvB+hRrTJMDTRwXbUoi6DN0n2gtMDcLc/ARmjw==
X-Google-Smtp-Source: AGRyM1srvmz0sxYpUL+j7hh3Nxp9SHP3Rpo4co7pFbz2Zx5Ri5/ae/iUzcou5p1/HoxjxoYMy50uLEJPD/myCX07iXE=
X-Received: by 2002:a5d:4848:0:b0:21b:8cda:5747 with SMTP id
 n8-20020a5d4848000000b0021b8cda5747mr9405276wrs.483.1655774532923; Mon, 20
 Jun 2022 18:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220617094412.197479-1-xiujianfeng@huawei.com>
In-Reply-To: <20220617094412.197479-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Jun 2022 21:22:02 -0400
Message-ID: <CAHC9VhTD0Z=9M_7TRBoOUDgNigLyYCW2SgNAtaZdPj8nJNCV2Q@mail.gmail.com>
Subject: Re: [PATCH RESEND -next] selinux: Let the caller free the momory in
 *mnt_opts on error
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 17, 2022 at 5:46 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> It may allocate memory for @mnt_opts if NULL in selinux_add_opt(), and
> now some error paths goto @err label to free memory while others don't,
> as suggested by Paul, don't free memory in case of error and let the
> caller to cleanup on error.
>
> And also this patch changes the @s NULL check to return -EINVAL instead.
>
> Link: https://lore.kernel.org/lkml/20220611090550.135674-1-xiujianfeng@huawei.com/T/
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/hooks.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Thanks, merged into selinux/next with some rewording of the subject
line and commit description.

-- 
paul-moore.com
