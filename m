Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C495DC001B0
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 23:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjHIXHo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 19:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjHIXHn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 19:07:43 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DF4E75
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 16:07:42 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40fd6da0325so1564471cf.3
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 16:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691622461; x=1692227261;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ftckZL31GeKECcX0U6jMawLvlmm2ONkMUEDYz+ycfxA=;
        b=Cwnb7SxfXEHNI8OHrEMZHuifuhEFHRSr+NFN9uS6HJda3ZvcH6QSP4Ri3ytH91wych
         X0sU/uVjx46iWmdlqX9zOkrLQc02UpLw15UZdKMnMq06V/ASDu8eFCoYLe8dndKHsLWm
         AnxI6svOOnfeDaK3fCYjFygbBf+caGhTzepbg905VPZJuBYLb/MCbaHOfbgIOd8QJK7p
         qsqPYHNnwYMM67gOYxg+Vp6uCP00BqSdnEnRhURJv45n0/qHHZ/oadzcko4nlT0AErZ8
         eUzwsfyWxOk2eQ+Ipyvm+A7WNBwhuWt7aiWvW4Ze6InoG7GKXKdiHql74mtH96fdQn+R
         4rLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691622461; x=1692227261;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftckZL31GeKECcX0U6jMawLvlmm2ONkMUEDYz+ycfxA=;
        b=UIRIUExGPfr77DWGzX3yaaZySxQVN3Hv+fpKkKR133VKU/roSR/+cor1e9IxYamkBS
         c3zaCe0N990147VD+S3Bv+JFzXNlqtoV6kwKmMr4UCqLJj8D3M4GqlB9zC2cNaFcUWT8
         1olcMIhwp7O7lMqx5wVndoW5xavzM9XD9cf1frsjTmiifM2Ka52Ky0VQq7YBFBUg09bs
         4V1B3J0azw1KrVp5uiLmlBhDAl5dAMVRO+W7IJzEnumcB2clXdkDrhCGTR8MptyPYw7i
         6qjPqm8Prh3LxB97SOWTVvZ/JhsHq4UzH1R8m8tAh/dSEZ1E9LRs95wH7zo6U8SWj6A+
         fH6A==
X-Gm-Message-State: AOJu0Yz34SubKY/PuRsvjXtFwxAb82ZwfKO2sN2mS7HAd7MNlbCcpPmT
        Nxq45uEBpQ4DNDMLc4fPlRHJ
X-Google-Smtp-Source: AGHT+IFQGQI0zvmK54Wk9FNpHspX8SYcUm9mLvtc9S9BqAL0j2OhVljJ1pF0HGZckJweLqa9r5d4Fw==
X-Received: by 2002:ac8:5b0d:0:b0:3f9:a6ad:e734 with SMTP id m13-20020ac85b0d000000b003f9a6ade734mr1127980qtw.3.1691622461689;
        Wed, 09 Aug 2023 16:07:41 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id jj6-20020a05622a740600b0040c72cae9f9sm64964qtb.93.2023.08.09.16.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 16:07:41 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:07:40 -0400
Message-ID: <685c8157bd45fa7dbdadd8583d882489.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] selinux: avoid implicit conversions in avtab code
References: <20230807171143.208481-7-cgzones@googlemail.com>
In-Reply-To: <20230807171143.208481-7-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Aug  7, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Return u32 from avtab_hash() instead of int, since the hashing is done
> on u32 and the result is used as an index on the hash array.
> 
> Use the type of the limit in for loops.
> 
> Avoid signed to unsigned conversion of multiplication result in
> avtab_hash_eval() and perform multiplication in destination type.
> 
> Use unsigned loop iterator for index operations, to avoid sign
> extension.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v3:
>   - use fixed sized counters in avtab_hash_eval()
>   - perform multiplication in avtab_hash_eval() in destination type
> v2: avoid declarations in init-clauses of for loops
> ---
>  security/selinux/ss/avtab.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
