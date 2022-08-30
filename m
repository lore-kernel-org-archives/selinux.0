Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD00ECAAD5
	for <selinux@archiver.kernel.org>; Tue, 30 Aug 2022 20:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiH3U21 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Aug 2022 16:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiH3U20 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Aug 2022 16:28:26 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7C227CC6
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 13:28:25 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-11f34610d4aso8751021fac.9
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 13:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pkoq/o9P8wU4zBUF6l/1Q8f9r4lCtzL1bt9bVqYTgbg=;
        b=vQ5OEjPyI48ASRgu7ssOii2xYWJ4xnPBiTNLBGGE608Z7A05x4M4cgABuJO0i9jN2c
         QATOeDvd8dss1mFC90RZMGre1/oN7HHYgFE95dL3a0OHfZ/Ihc//ZZYIFsxJQMK6pugb
         B+7pKt6yNeV1mFBvUg65k5/+nNf8pKWYIza0LDe2VoMgle5vh7b4MA+AjiD1+VcMJMHE
         su18WVASI8CWQEP7UMc830pIxfnlPHStDyF6kT9vyNw8ZfoyjFBZRR/OfYEtVMQAg91T
         tL8bJ2pLDUr5TE1aSyfy9x9QVZvCSXbduMX79y3Ql8kIDwreogHJIBaue2odW4VAIdRm
         u3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pkoq/o9P8wU4zBUF6l/1Q8f9r4lCtzL1bt9bVqYTgbg=;
        b=Tj+Aiucf9x4nQAnq0HhEWsumoR+4jQ2FBjZHBMgXNOkAQFW6a09siFimSnH4tmT5XE
         5vaRch/iUBOVTl/FCi81HtP3aC1Zlcaahe2GAFAPu1CgNTXTG4flbUd5kcTwJrb+q1N7
         L+nxidG18BPbxssvOnJku5Vp+4OGWvrTqzDoQe1sUdz+heQ/2llyaqhFd8QRI6tyaw58
         78QOTaPSM/eOFNmL7OiPhXBNaMMQRpiLl3knI/AgOLqMh49+/t20nehMNyaWYbtc7O2o
         EhL0s6wL+F7V3YaK/OOVBGZN1lUr4N6Qf3KDD3yCOKyPgdvnyMvFitaWVl4Gu8oYuaQ3
         OPTw==
X-Gm-Message-State: ACgBeo3i4WBXYKL3a03FxezD22KS9VmIP/tJcGQ24oBM6AQuaTpyewlk
        30UIoL6AQER1KC3CQtJVUNl/Rum7FZy0tq0pXtsB
X-Google-Smtp-Source: AA6agR6o/lP5VVKIId0/k9uoG0ZQyJf1wTjojPiCx7MFLhqOZh+C+0wZydEzou1Rty6gZpdKl+qDXkaPZla6f5n/pMc=
X-Received: by 2002:a05:6870:a78d:b0:11c:437b:ec70 with SMTP id
 x13-20020a056870a78d00b0011c437bec70mr11345537oao.136.1661891304676; Tue, 30
 Aug 2022 13:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220830150058.300327-1-cui.jinpeng2@zte.com.cn>
In-Reply-To: <20220830150058.300327-1-cui.jinpeng2@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 30 Aug 2022 16:28:14 -0400
Message-ID: <CAHC9VhT79eWvT4Nyd7BPZcfQPwQcWH+T4NaW7ARqA3BNHUOx2A@mail.gmail.com>
Subject: Re: [PATCH linux-next] selinux: remove redundant variables rc
To:     cgel.zte@gmail.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 30, 2022 at 11:01 AM <cgel.zte@gmail.com> wrote:
>
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
>
> Rturn value directly from sel_make_perm_files() instead of
> getting value from redundant variable rc.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> ---
>  security/selinux/selinuxfs.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Please don't send multiple patches to fix the exact same issue.

-- 
paul-moore.com
