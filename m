Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E5BC433DB
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 00:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D086B65295
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 00:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCIArh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Mar 2021 19:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhCIAr0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Mar 2021 19:47:26 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4800EC06174A
        for <selinux@vger.kernel.org>; Mon,  8 Mar 2021 16:47:26 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id l12so17532524edt.3
        for <selinux@vger.kernel.org>; Mon, 08 Mar 2021 16:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lN3ZnzypLBcXQIQsrg5996DIvMhTqbj3VD67InnBKe0=;
        b=xuPq8c8isCABiU33a6OJHIh/aQgDgXAIV2d8Zwm6DqxH+rh7teoCLm+3FQewmQgeTh
         KDyeXc8x9GmgEQcgr+qBIAZV4Zzn+15RsGW0X80LiKugWjQOU30J7Z9C2xhqnTYKTu65
         zuCDWxLEAAvxXcm3nQjhED93rzSKkqJ0JLUwa6Ze7J0fuQp5wyWH/HT7jF3krWc2gRsn
         l1wQ0NLqYSiRWcsvB0qiTXYeQYEjiEKL6BadHQXyu5qE2bHZ61c1W5+Ec6GgQ5X1rpky
         tljgagGBw50TYxetH5LwDB6yANtRfDm0mTpOprfW/PrG0MxxBw46E1yaRWZE0WtEDSHG
         rC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lN3ZnzypLBcXQIQsrg5996DIvMhTqbj3VD67InnBKe0=;
        b=cXJIygjZRdih6NnExLVVLqCEeQrP2WDSJcha5sdYg+tgpsZohJm1rZi++jna3nPDO7
         clekPapJqOuwx3JyfZVdskKmEw/T7PwnTUpgDU82muKKkzfYd3nOfDkV+9XN7xOXsn1o
         U5lcyhS/3h14TadAQr70VEGwnWJGgXGAoQDJASSLXtmJLRj4fr7rs+OcuMPe1Fdjd6Xm
         Q78CsK8ZFTvteXSmxFyWvva/SbMZzx6fEhsw5gVYGJQMni7zE6yTu9rugfY7sjJx5zgd
         dlAwiQRlij+GiMd58P4mI9t5ro1FCBkUTLoD8JuoI+sQTEX+DIfbR4lViD2oYPlFiR9e
         VeXA==
X-Gm-Message-State: AOAM530rzU70RZPNsPHxAHLOwrc+xkdY1DOgYf6RykKAULBSVPiP+x/d
        3Z01gdktJvznDwWyIeQhGIIdYwsL5gI9Y5qpMwsB
X-Google-Smtp-Source: ABdhPJwGUHU9PrTxrGBtoYtSKMYAcXnBiw9XKjgugmd9yKbdvXHZLTtrBwQzl93xDROZ7Cv7xCTVwxk20cwg0r4af5s=
X-Received: by 2002:a05:6402:3c7:: with SMTP id t7mr1214463edw.196.1615250844975;
 Mon, 08 Mar 2021 16:47:24 -0800 (PST)
MIME-Version: 1.0
References: <20210308111939.261079-1-xiong.zhenwu@zte.com.cn>
In-Reply-To: <20210308111939.261079-1-xiong.zhenwu@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 Mar 2021 19:47:14 -0500
Message-ID: <CAHC9VhRObSaufq1kvvFqy_djSi15QbGOzQLNOE2=q3G9_hY7iw@mail.gmail.com>
Subject: Re: [PATCH] security/selinux/include/: fix misspellings using
 codespell tool
To:     menglong8.dong@gmail.com
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        nramas@linux.microsoft.com, tyhicks@linux.microsoft.com,
        xiong.zhenwu@zte.com.cn, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 8, 2021 at 6:19 AM <menglong8.dong@gmail.com> wrote:
>
> From: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
>
> A typo is f out by codespell tool in 422th line of security.h:
>
> $ codespell ./security/selinux/include/
> ./security.h:422: thie  ==> the, this
>
> Fix a typo found by codespell.
>
> Signed-off-by: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
> ---
>  security/selinux/include/security.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

-- 
paul moore
www.paul-moore.com
