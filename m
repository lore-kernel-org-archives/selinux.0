Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC48C001E0
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 23:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjHIXHs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 19:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjHIXHp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 19:07:45 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27045E75
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 16:07:45 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-63cf96c37beso1703166d6.0
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 16:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691622464; x=1692227264;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y2G1FEoODyuW8LZInJy/D8VWDoauS6KvhR2/aXXIASQ=;
        b=KRPD+tFlvIJIh/SfRJKPke3EkchYdx+kQLzWrBM9QT66JJaT98ADso2nUAtEt5l66S
         0PNcIMOhG+IgIuwi3bfr8OhPs3EAsox0ta5oBVOcFilb3ixjhgOF2OmgNDCzarRtnLQ+
         uro+J9gSpZpPrIWH2WdQKtoROsrHlH1t4yoPO3GfmgULgIkxYrnp/BatI61z6+dUPXAq
         R0kSNer1X52WabWq11ban6NnDgW+rXhCR0UkbjSejNBAtXR9JaKYhFlbWN/ylBdOpM0+
         IuU0UGnv6VGJVvOujPK/3Dcphk4lFKyUsOoVG/bIURMrZtHLJM4b75RCbnEQXgtohf4n
         Lp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691622464; x=1692227264;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2G1FEoODyuW8LZInJy/D8VWDoauS6KvhR2/aXXIASQ=;
        b=jn2hlPH7iHOTO+r9VzHJW21vhQ56kIX2qhLFhko1U8Wzr576Bf2Gwwvf/xCReLYUsx
         PS3NuHDB6f7IfBRs3r/f9UDaWl9QaA3C/oZvgc83vkNTbjx02cc71LTdMNLGxs2cyulT
         V1Yz8TdscjWCtR2XGDNEqWF+cRrJ5Lys6L9LFG/AsMYr3cG2Y9z3l1ITuzUF+ygz2hpD
         q0okSq8v87r8Bqo4qpiJgczIfr2z5/BR2MQfSUykg5zLYzV4DeJWk4UB3EkxMNIdh4KJ
         sOMjprZVB96KTcY9bNB8PkK3NaL+Tp+yWZcIDZ8L8I1iLSC6sCNawK2dHkYSgxDd2zFs
         cAug==
X-Gm-Message-State: AOJu0Yxp9kpr2S45RdYhprMDnQwsBACJfHnUC21bQdcvNZS9IipkZsJi
        YBbgg7UUBTqLOxCqnDZ8Wx10
X-Google-Smtp-Source: AGHT+IFSpMTflGFdiT1OvIdpQy/aE8TDHCxXjYsislp4DlCUAwm6eQUiY+WC8I+4nMwtsnGw/cIXLg==
X-Received: by 2002:a05:6214:1304:b0:63d:580:9c68 with SMTP id pn4-20020a056214130400b0063d05809c68mr414507qvb.32.1691622464288;
        Wed, 09 Aug 2023 16:07:44 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id g17-20020a0caad1000000b006166d870243sm26517qvb.43.2023.08.09.16.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 16:07:43 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:07:43 -0400
Message-ID: <3531a5295c973c359344ee36c2daaad7.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] selinux: make left shifts well defined
References: <20230807171143.208481-3-cgzones@googlemail.com>
In-Reply-To: <20230807171143.208481-3-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Aug  7, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> The loops upper bound represent the number of permissions used (for the
> current class or in general).  The limit for this is 32, thus we might
> left shift of one less, 31.  Shifting a base of 1 results in undefined
> behavior; use (u32)1 as base.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v3: split from parent commit and apply cast to correct shift operand
> ---
>  security/selinux/ss/services.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
