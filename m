Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2312C04FDF
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 23:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjHIXHs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 19:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjHIXHr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 19:07:47 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D671E76
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 16:07:46 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-63f7c242030so1928456d6.3
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 16:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691622465; x=1692227265;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=li/9TOw1D/al0BgcWpvzxPhzRc7oZy+uOQFsKnuD0nc=;
        b=VsgR3qiNN+VuZuH58/kL0XOyT5r0+EUKZKvFDLAYBNNEL6QY5BLbea3/fsWoOrepON
         1J9WYmT/sxrpqc/g+FT8PiebEUrRrnHGrp5HBz/GKO87cFAQF+B02NHzQeWXFG9u37ic
         bygIceYeq8MxC5bqcJ3loTL94SEZUqMLVV+Y0ZrXh5J6sCKs1uQu+HjxBHPmWNXOStXj
         QQrMZAljeAubu5D4pxANJTbpKpFu/9UGCu0ImHNkd+mVXM0RJ2pukjD7lt/jfFElIyLb
         c+EcJTe3S10nGDaYLhbWEaNs/JCnsJU7OD67hscB8ClWezuccWHlmO72NMpgjL2SlCEN
         q4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691622465; x=1692227265;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=li/9TOw1D/al0BgcWpvzxPhzRc7oZy+uOQFsKnuD0nc=;
        b=AaBKNybP87hdbq5b3C4G/nVepXhVOyQE9PGLqXJ/GvtEJXr1FGsqe9i9Opka4tGqJg
         1jOs7j4yHhQx+rvhceAmNsIE/HnnrgPRO1QZ0wrGQsbdaE7NZ+P/DWajSOKjkLhYbqlL
         V53dTVCfiK6ynxZv1MNvNOWr+7MkEKpUh02a28OwIcRgPzYlvmh+dvr4smDJtgTVfbcX
         BxcZd8GEKgoF2Ahj9jKdl3TliJuMuaNxNOCguhDgo2skE05bnC1TwTfGjd6ozLjVwNqA
         YWw532cNVsAQzMbiWnD9atNHteJgGROSwP194nx1V+kTTUhECatIZ3ywkQe6ojed/9Lr
         skRQ==
X-Gm-Message-State: AOJu0Yyg/Y50kUc3Zu/N1znG8eOgMC5ZMOEHArettCu9CHfFuyk45uKr
        9RGWRVK5dtkadnb2EK/pEEUd
X-Google-Smtp-Source: AGHT+IHJIdx5ep6T3i7VbU2Ri4DPcNW01+EfvQ176cqLxGeLFkTzHtE8Qipt4tOk6Yj+5eS/iXXa6A==
X-Received: by 2002:a0c:f54d:0:b0:63c:d8b5:ee6d with SMTP id p13-20020a0cf54d000000b0063cd8b5ee6dmr582494qvm.33.1691622465178;
        Wed, 09 Aug 2023 16:07:45 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d14-20020a05620a166e00b0076c5ad6750fsm45819qko.102.2023.08.09.16.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 16:07:44 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:07:44 -0400
Message-ID: <651d3c359cdfd599482a94104c35ee05.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] selinux: avoid implicit conversions in selinuxfs  code
References: <20230807171143.208481-4-cgzones@googlemail.com>
In-Reply-To: <20230807171143.208481-4-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Aug  7, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use umode_t as parameter type for sel_make_inode(), which assigns the
> value to the member i_mode of struct inode.
> 
> Use identical and unsigned types for loop iterators.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v3:
>   - drop leftover declaration in init-clauses of for loops
>   - use unsigned int instead of u32 for loop iterator with loop bounds
>     known at compile time to be small (<100)
> v2: avoid declarations in init-clauses of for loops
> ---
>  security/selinux/selinuxfs.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
