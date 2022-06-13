Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA6CCCA47D
	for <selinux@archiver.kernel.org>; Mon, 13 Jun 2022 20:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350928AbiFMUym (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Jun 2022 16:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352295AbiFMUyW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Jun 2022 16:54:22 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678A62AE1F
        for <selinux@vger.kernel.org>; Mon, 13 Jun 2022 13:22:58 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h19so5267828wrc.12
        for <selinux@vger.kernel.org>; Mon, 13 Jun 2022 13:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XNSQOYdF4aUChA2evFn2lCgcdKNRBXwLiO2UBbZQeSk=;
        b=azkHDkclWS6CSHjmTjRpoEBREa2BAJJcqk8J3vYFeMO3o/Cik4sXq6jqK5Vvr77saw
         l8b/AxE+syxDBIKtk0RTME80ml2RdygAUYKT/ZAeATvHnjjRn7T0H4P/6yaPqobKPQ5E
         CRgXXd9xZrV2/NCT4Kj6TifnRxO7+wXkSbhtZQj7ch9RtICkVEYiX5ehiF0WOthOcl7e
         YUkQHXRCQ2SJHKmi3hlMW/T+abNsnY0jt0dGySXf/KlSqVV74nCytJAHuY2MJ7GLlCUn
         RcaoiXbWMWRq/a/ea8asagGzWZDe708N8Tjp4vL7fR1AhFKqTv0dkM0L5QJ10B3WOOy/
         rq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XNSQOYdF4aUChA2evFn2lCgcdKNRBXwLiO2UBbZQeSk=;
        b=DqLHJ1BKosdreBOnr8gVVA12PuCcvpm3IQiDQT55XZMHQV/CG99fFpH/a2aLsbjrAb
         wvykkm4fm9lm7Pw+oj5NtmsiDA6rVBLAipFy34S/21MyVoNyK9NFShLC3vHfkbVoV8cV
         Zyg6EVWBaD8saEUTWm5My14YVNVKJU2rxTmWoB3OFxFggeZ0dTcuBspkDFJxJieS0f7z
         dAJFnY0lGzcgHQvPjvqtIjytA5lPRRjs9u+ZXiqi7ui8pIc3/vmXodJ5DQA4souT1m53
         wB2RFXbqRytOktU+iQaGjH4xFZptEGCldNYVlKOfHnVYuZ41/cSPr4dq2BXT6KHkF2yk
         ELeA==
X-Gm-Message-State: AJIora/5TuYRCB44hwakUq665+0MwumKp43AEsmGG+H38N1+/Cp4zXig
        RR71/Rt2AM5f6de84EevD76Kf5nXNPyULZVBy7+9
X-Google-Smtp-Source: AGRyM1vicqR0MGly968BIwuj3k9Dkrrdns5uJdk9zY4Ip3egIEtSLmZV9bqPpVp7rF2jk1ikFhmbRnX+5kS5IsTME74=
X-Received: by 2002:a5d:64e7:0:b0:218:5626:7e7f with SMTP id
 g7-20020a5d64e7000000b0021856267e7fmr1404151wri.245.1655151776983; Mon, 13
 Jun 2022 13:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220611090550.135674-1-xiujianfeng@huawei.com>
In-Reply-To: <20220611090550.135674-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Jun 2022 16:22:46 -0400
Message-ID: <CAHC9VhSwYdrHw8jNYxWApPYMjnmX-ZDN1=CzmRBeS1HoL-KOOA@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Fix potential memory leak in selinux_add_opt
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        omosnace@redhat.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jun 11, 2022 at 5:07 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> In the entry of selinux_add_opt, *mnt_opts may be assigned to new
> allocated memory, and also may be freed and reset at the end of the
> function. however, if security_context_str_to_sid failed, it returns
> directly and skips the procedure for free and reset, even if it may be
> handled at the caller of this function, It is better to handle it
> inside.
>
> Fixes: 70f4169ab421 ("selinux: parse contexts for mount options early")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/hooks.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Have you actually observed a memory leak from the selinux_mnt_opts
allocation in selinux_add_opt()?

The selinux_add_opt() function has two callers:
selinux_sb_eat_lsm_opts() and selinux_fs_context_parse_param().  The
former cleans up the selinux_mnt_opts allocation it its error handler
while the latter will end up calling
security_free_mnt_opts()/selinux_free_mnt_opts() to free the
fs_context:security when the fs_context is destroyed.

This patch shouldn't be necessary.

-- 
paul-moore.com
