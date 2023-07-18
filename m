Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283BFEB64DD
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 22:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjGRWBT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjGRWBQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 18:01:16 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF98A19B2
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:13 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-766fd5f9536so421787985a.3
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717673; x=1692309673;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z0/uf5AvHD3Ad9NS83FZnzRuH3oiKZoLYaLQ80T3/84=;
        b=Be6zVOCErHmcczCO6fqOr11lh9Xyzw7rJ7oPkz/UXLYHG4MTP+IhvLNL26Q0V4eMH6
         OLG2EBrwnWD5iYXvs0uuxaUJFT3E1Fc3O78lusGJF2KBKgaYeeSkKDyzmCrAfyiJGP0S
         dv76BfQ2bFT+DjoV1+4LJL9WFyolS4/2Pxz9NC4RHsLIWCb7dl9on8XIYOF6yS4IVF+9
         BKeokHt3R78is4+UjwIerhOpSQKhlLO7cOhwmWHD8ijMP+GuDCr+uFdw14BAYnHbHPDi
         /oLO1EfP6nHwbX3dfFWcAHCsXO2XTQGkg5zWgXCZLAOqURbBPJWFe861glRe1Xp1/GIB
         TpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717673; x=1692309673;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0/uf5AvHD3Ad9NS83FZnzRuH3oiKZoLYaLQ80T3/84=;
        b=dvzTDFprPnDfVaFEVtq5YO5HwJs62myrDK86yjebc6Z3jy9z1ARTi97faZHajTBYIq
         c2BiOsrJjrCagUMYFDcxFbCKBE3RjF5Kym0rcrcLigB1jP57GYtjp4qV8A0aDAi/TQOc
         9wniLXlQpmpb2v9qh8IimdjELZ/zZXdaKdZEcA6mcipM9e6i8902XS9kuyh+0HMp3J/R
         dWY6y9CKVbd7pK0TAIYipaTuQ6CNhe4aKH0NgKR5VjcIBRF/nyBexoI8+BxNmRwX33yC
         KNNY+xFPNjxPCv7wFN3cgadoxMvdH1ES75EQpmzAXbARiiH3gIG2FpLZDxcFyE2X63mJ
         Fnbw==
X-Gm-Message-State: ABy/qLYQ1ONk2Ud5TCmXOoDXB11wl3i3Mc5gbm84v5lM559SxoTKqMmp
        Qm8Yq2ym/uXbBW4Y2AADCJ60
X-Google-Smtp-Source: APBJJlHFnLy5PH2r2LCdf+C6Xe1C4n2YBqesF57TOIq56DDmQRQbh04seW3hlYl3u+MrP4i9FEQdeQ==
X-Received: by 2002:a05:620a:1a84:b0:767:e57f:6fe with SMTP id bl4-20020a05620a1a8400b00767e57f06femr1115499qkb.61.1689717673041;
        Tue, 18 Jul 2023 15:01:13 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id i2-20020a05620a074200b00767fbfea21dsm877906qki.69.2023.07.18.15.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:12 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:12 -0400
Message-ID: <6fcffe16a17c4e1b28daa23f3c6ca49f.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Gong Ruiqi <gongruiqi1@huawei.com>,
        =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>
Subject: Re: [PATCH RFC 1/20] selinux: check for multiplication overflow in  put_entry()
References: <20230706132337.15924-1-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-1-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul  6, 2023 Gong Ruiqi <gongruiqi1@huawei.com> wrote:
> 
> The function is always inlined and most of the time both relevant
> arguments are compile time constants, allowing compilers to elide the
> check.  Also the function is part of outputting the policy, which is not
> performance critical.
> 
> Also convert the type of the third parameter into a size_t, since it
> should always be a non-negative number of elements.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/policydb.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
