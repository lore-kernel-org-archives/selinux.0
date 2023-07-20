Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25E9EB64DA
	for <selinux@archiver.kernel.org>; Thu, 20 Jul 2023 20:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjGTUV6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjGTUV5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Jul 2023 16:21:57 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029E4271D
        for <selinux@vger.kernel.org>; Thu, 20 Jul 2023 13:21:51 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-440db8e60c8so559086137.0
        for <selinux@vger.kernel.org>; Thu, 20 Jul 2023 13:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689884510; x=1690489310;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lGkEH3HBHDf1WQxqf9n4HZbKM1bp9cKX4/NDY3EFZU=;
        b=AVO0Rwhq4vywmRPOA2P56d/QT7pC1THiHLLK8WF4HOSiSbtrzV5JVQErT1FFYO9lZz
         5XHCX621ZVaUa4bzxed4NGHVGstLcuVH78KBd/X7TVYws2y0oUZ8q+gLMcCm304nscer
         aBzoj0PuQ8KCHHSOpPC22doal5w+NJy8N132rnRCLQEF2Z94UU0koWpX4+je4NQ5FF9q
         dpDzFmZ8MPcHac3CXvwo9Ps58UC7wveiNqf1rq2tZJCu6S94uGnBolw2lHqsNBD5j67D
         AVaKh76uP+k0hpXjGJisQ/FelOblnxYR3qZbRRuK7W3su5I/wZNWS7nyXHQLyWFHWwOb
         YxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689884510; x=1690489310;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3lGkEH3HBHDf1WQxqf9n4HZbKM1bp9cKX4/NDY3EFZU=;
        b=T4cZUVW5+CyJu9YMRQhSPryhYX/XblKtZpc7w+rWoqHUQv1oj4BkGrX68oVfZ54tQo
         Bjnsmj4FUnUnoJ96pcuM1BKtfRiQAYFoy499328qLNrWUPKT4RKuiyuIQiznEs179hHS
         bu3NcO3aOTVopnf7SQ5jsUfFYoZmM6EWsH4OT635XINlrqukN2RilOCvdbV+mK/M3t62
         rRmeVNHEoIOe17ozDqki9puESLZD9upCPeXhcZ3ElGHY45jU6oRQsceFxCe1enkwdK1Y
         KvscwS8JcDw6FbwegP2Pc+y+v21qG2q4GyjB97x8iZyADXCwR4riLC44wf73sCqIWJQH
         iTAA==
X-Gm-Message-State: ABy/qLZD26Mi8Zk/t5+tWYao5FEsd0ooEs6gH905Ox3PN214Xo5QHHuV
        DDJajR+sG888AJ5K2MK7MsA/qmPMePcOI/87+w==
X-Google-Smtp-Source: APBJJlFhgL9o+xTxaoLZjjQsLM946P/2hjyDhLLBj48FqsuTLYq4hSxGSL+7LfIa9hvIHuR/slmgcA==
X-Received: by 2002:a67:ec17:0:b0:443:6457:101 with SMTP id d23-20020a67ec17000000b0044364570101mr2667617vso.7.1689884510077;
        Thu, 20 Jul 2023 13:21:50 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id w9-20020a0cdf89000000b0063c60533c7fsm693600qvl.133.2023.07.20.13.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 13:21:49 -0700 (PDT)
Date:   Thu, 20 Jul 2023 16:21:49 -0400
Message-ID: <e87f9f809a06fc42da147225a87065af.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH 1/3] selinux: introduce SECURITY_SELINUX_DEBUG  configuration
References: <20230718184921.112786-1-cgzones@googlemail.com>
In-Reply-To: <20230718184921.112786-1-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul 18, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> The policy database code contains several debug output statements
> related to hashtable utilization.  Those are guarded by the macro
> DEBUG_HASHES, which is neither documented nor set anywhere.
> 
> Introduce a new Kconfig configuration guarding this and potential
> other future debugging related code.  Disable the setting by default.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> This already uses the de-branded naming scheme, as proposed by
> Stephen.
> ---
>  security/selinux/Kconfig       | 9 +++++++++
>  security/selinux/ss/policydb.c | 8 ++++----
>  2 files changed, 13 insertions(+), 4 deletions(-)

Merged into selinux/next with some minor adjustments to the help text
line lengths, thanks for doing this Christian.

--
paul-moore.com
