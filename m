Return-Path: <SRS0=r9sn=B6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEF4C433E1
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 01:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3845207FB
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 01:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="dSvioh3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHTBUA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 21:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHTBT7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 21:19:59 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718C8C061757
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 18:19:59 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id ba10so356729edb.3
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 18:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2rblKqGLIYS1rl8WfFoferEZryqB7qMtUUeRp+RYmg=;
        b=dSvioh3RqzDIBRqRZFNe/UYucXq4SePQINPGCCMntDtRTavaudefdBQ5F80C7D1WrL
         xq+F47BsT4UWNhtEH9HaH7/gWmCcH/pD/X8yH85DP15CwRqG2Cz1V8KwCWq/7sMzf50K
         M7J2GDvxJqdri4z+mURrpdZWH8GQAVD7TajpLzgWQZWEb/7kHUapcS+a2P+7hpMM9hDq
         EhgxvgxKb7tGGMTn/TMhrv+nfibpunmYdH2TTOK9JPmBcVjYgE2d0d97phT1ZbPAngzk
         HxN0vyTJKN8VEbQlPHW1Qcb81YIiIF+zEPOwCywgiJcINQ6fku5i9311UXJRV2jMf8SM
         Dr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2rblKqGLIYS1rl8WfFoferEZryqB7qMtUUeRp+RYmg=;
        b=dQvSPBjDQwwipyzi2EhYD3luSoFU8oRE/LUHLcphmZCJWTCC8AwbgLpm1JiccBbT4y
         2eZsn6uGHQDH13pvjePYEo2Am+sC3xQYtDK4LhyAaaRnKdIXZrBnXVqlhaxq9FrLuxzH
         FUAZo6raXAqru7JsZ82GsRXjWrZqz0Wka0nN3s+dAiAXiq3pAd7xoPj6BBcwmh5UD+++
         ALUyCpIruQsDissvhXKPhxFS6A6GkPf/ys1Wrqi7uHol7k2HeeVUd+WzVm+CQnASX5N8
         4lzooMGEot903v9Lu+sxh1Vqx/dQYPFNxlZtr/Db5wdFDLHoarejszBLA6via8ybqHAf
         hwhw==
X-Gm-Message-State: AOAM5306H9pvt8bBuc3YmpbwqmnbVAviyOt67LBsjIXMPVXeCmByfXJz
        ffz9eYTetyG3V/8+RCa5s1BXd/ikXG5MBJglqhDS
X-Google-Smtp-Source: ABdhPJyzpNbbRCbAN/iUOp0F3dPZFoyAk7fMePNDbv6IpYPkCYkoI6MJH8+JP2n8+lLaYglCXzrpq+iRHI808YIVtkI=
X-Received: by 2002:aa7:c383:: with SMTP id k3mr703279edq.164.1597886397987;
 Wed, 19 Aug 2020 18:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200819134541.41136-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200819134541.41136-1-stephen.smalley.work@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 Aug 2020 21:19:46 -0400
Message-ID: <CAHC9VhQEF6EZGeQ9Dn_AQmZOkEBcWbp60oKG_hT4mHx5PWovOA@mail.gmail.com>
Subject: Re: [PATCH] selinux: avoid dereferencing the policy prior to initialization
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        naresh.kamboju@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 19, 2020 at 9:45 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Certain SELinux security server functions (e.g. security_port_sid,
> called during bind) were not explicitly testing to see if SELinux
> has been initialized (i.e. initial policy loaded) and handling
> the no-policy-loaded case.  In the past this happened to work
> because the policydb was statically allocated and could always
> be accessed, but with the recent encapsulation of policy state
> and conversion to dynamic allocation, we can no longer access
> the policy state prior to initialization.  Add a test of
> !selinux_initialized(state) to all of the exported functions that
> were missing them and handle appropriately.
>
> Fixes: 461698026ffa ("selinux: encapsulate policy state, refactor policy load")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/services.c | 60 ++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)

Merged into selinux/next, thanks Stephen.

-- 
paul moore
www.paul-moore.com
