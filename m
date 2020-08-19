Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F31C433E1
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 12:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CCC32075E
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 12:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2jV8B13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgHSMV6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgHSMV4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 08:21:56 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1B2C061757;
        Wed, 19 Aug 2020 05:21:56 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s16so17544472qtn.7;
        Wed, 19 Aug 2020 05:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8ilKX+a70jTPPEN//PJ60e7XsFBDrxK1bHnpEzpl1JY=;
        b=Z2jV8B13DC70Ru2gQFkwcdUpG/4jYcVF3Zt8PiAh/6QCrw3nWLp1arQPSh64AagVww
         gHMQZ3AUCIJ1Aj/J/XiGEpL956v6X8KJtx3cb2Zf1Q0oS69hv2Usld1HHt+zFk4sqvLo
         YAuKRaSFvi4plK9CQ1ULQbVhELyotnZ0x8E3+w4Q3ad6A4jx9erikr1O5ZNjsRU5dUsp
         UUft0A7LtcoX70srXjhjAmgYYXUXBzuA/04OGokFWoBqFZZ4ZVUV0LlPV5f8wmKpioWi
         U7z9oixRIYE7EKW/cG/QqYcgd990b+Kkhw28R5G+sh10ZjxxlFMbdPljT35aKUKQhjbl
         9/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8ilKX+a70jTPPEN//PJ60e7XsFBDrxK1bHnpEzpl1JY=;
        b=oRpManZuxzTm7F9xN4tRYTSqpoV/A5OcYPuLhcYWTa52HxypBnkEkpd5ZUTVB90+ZV
         WW7lLPKRfmenLdhUeAAVYxg5yPK0YR+ddkkMcjns7zYYBOwmNm55lWTI/nARBxH3M2hG
         d7Vkt1+VcDTb4p19oXK07/b54yHtQRHAM8yO/2BidHWSgMd3bnMCHKoTp4U/4rwDuOlV
         p8Bqht0iqXtDOC/fcKhBsVXpmW+h040y3dWHjbWSH6LyhaYd7i0kxzqG/S2L5AHkfvAD
         nqG9emD/rG7YCyvLbe3Sibf9L6tDCQxZ0cpQQDMzFEfroosoY8cPVR8m+aC4SzuOUrsv
         C01A==
X-Gm-Message-State: AOAM5319kodOqkM0mJLQtj+XVqBfAVVSIjuAnznUUwSBpaAmAEpkgCzg
        ExDZvGhfAC6iNMa2Mj3ZWC/yxB9b1NI=
X-Google-Smtp-Source: ABdhPJzH7q8L+vI8V5vUJfXQoHxH9fOu3E+Z6yC2h55W8qD2RKcMIrp3AR6qs55Re4KR0YJkAVFMIg==
X-Received: by 2002:aed:38e6:: with SMTP id k93mr21036770qte.90.1597839715641;
        Wed, 19 Aug 2020 05:21:55 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id v28sm29331368qtk.28.2020.08.19.05.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 05:21:55 -0700 (PDT)
Subject: Re: [PATCH][next] selinux: fix allocation failure check on
 newpolicy->sidtab
To:     Colin King <colin.king@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200819104256.51499-1-colin.king@canonical.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <20dcb065-7f19-423a-81c2-cb9524a730de@gmail.com>
Date:   Wed, 19 Aug 2020 08:21:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819104256.51499-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/19/20 6:42 AM, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> The allocation check of newpolicy->sidtab is null checking if
> newpolicy is null and not newpolicy->sidtab. Fix this.
>
> Addresses-Coverity: ("Logically dead code")
> Fixes: c7c556f1e81b ("selinux: refactor changing booleans")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>   security/selinux/ss/services.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index f6f78c65f53f..d310910fb639 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2224,7 +2224,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
>   		return -ENOMEM;
>   
>   	newpolicy->sidtab = kzalloc(sizeof(*newpolicy->sidtab), GFP_KERNEL);
> -	if (!newpolicy)
> +	if (!newpolicy->sidtab)
>   		goto err;
>   
>   	rc = policydb_read(&newpolicy->policydb, fp);
