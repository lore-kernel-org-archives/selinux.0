Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02ADC04A6A
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 23:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjHIXHq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 19:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjHIXHo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 19:07:44 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546E6E7F
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 16:07:44 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76ad8892d49so23885085a.1
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 16:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691622463; x=1692227263;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sHK61T6EgbxK/w/h+u2OTZ46eXlV1WaAOWJmOQveL60=;
        b=gkjR2QtHz2DQFihjTgiuc1uY2qjpu9zys8jz6KgXSN7FqLZyqquHE0eJh4SGK6i83D
         rD218t5MopuA/4TP7POzZPoRawzonPU1L90DzSeIBG73sjbKALkHZN1sJShUCWOUHksz
         NEPcjLefA71RDAw7VBoHj75GENR3Ev2yYKKcvNItFB8cE0RRiQWuEOZjQngcw6XxSmHq
         qhhyGKX5pnigORXmHjSUErufD8ppeqnv9P8cNPRJAquWvWIAhrlFf7eDeAuxWMKAlEmF
         79UKT0OSXc/hdvMy4EAvC4iawkeUKRuMH7C7ZgQgYwPi8GiVJNlg3HOWcAS7OT9IXccZ
         mjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691622463; x=1692227263;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHK61T6EgbxK/w/h+u2OTZ46eXlV1WaAOWJmOQveL60=;
        b=YBc4qLZjUaX5J2zWBrx5eITqS4j56JOA63uUHnXWArHl/X87z7P9AjNiVpmvvpcUEN
         a4rr/klUF4J/W55D1XelJrAaaOOIBSowqSanlvgBdpVsTesiSauQV6ChBze1LsAm5B5Y
         w7QqCcEQl0VJZWbissmLZCdkYnYR0+Z3y3PMRJh+xSFxidGAyevJxTeKfd175sOCAepK
         QOxQvJ/e4jEsmTiH6WIZ3KQ/RUSSr17TrdIzTfM4lFThLFIzirOQfzFwNncvynccXQ9w
         gaAIc2tMsmroLNufTQYW1DUGszHkGDjlF8W7ubuVeFzpCAxt3RHu7jY69Po+Qr2730kr
         /lYg==
X-Gm-Message-State: AOJu0YxnVa68tKoA0KleeRGG/l06zBaavmkNHcxUZDAx0neA9UeeT+Qy
        xm6NoH4CxmVjQ0oDi22AB89y
X-Google-Smtp-Source: AGHT+IG4zDPfU/zDa5sG1B+ZHVEFI1O2Ivcjs1oMRzZkRBurX+fNIrzdu5EPrQpKRZq0kCYmj1ohXw==
X-Received: by 2002:a05:620a:90a:b0:768:13b6:e9e7 with SMTP id v10-20020a05620a090a00b0076813b6e9e7mr427080qkv.63.1691622463415;
        Wed, 09 Aug 2023 16:07:43 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id s29-20020a05620a031d00b00767e62bcf0csm49515qkm.65.2023.08.09.16.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 16:07:43 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:07:42 -0400
Message-ID: <bc30edc4e609babadee9acb39c8bff4e.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] selinux: update type for number of class  permissions in services code
References: <20230807171143.208481-2-cgzones@googlemail.com>
In-Reply-To: <20230807171143.208481-2-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Aug  7, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Security classes have only up to 32 permissions, hence using an u16 is
> sufficient (while improving padding in struct selinux_mapping).
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v3:
>   - drop type change of arithmetic variable; it might effect performance
>     as suggested by David.
>   - split bogus and corrected cast into separate patch
> v2:
>    update commit description:
>      - mention struct selinux_mapping  in the padding argument
>        (currently between the first and second member there are 2 bytes
>         padding)
>      - mention overflow in the cast argument and the result of setting
>        no bits due to it
> ---
>  security/selinux/ss/services.c | 2 +-
>  security/selinux/ss/services.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
