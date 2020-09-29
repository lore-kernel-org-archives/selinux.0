Return-Path: <SRS0=dH2y=DG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226AAC4727C
	for <selinux@archiver.kernel.org>; Tue, 29 Sep 2020 12:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A968D2145D
	for <selinux@archiver.kernel.org>; Tue, 29 Sep 2020 12:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXDPKHo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgI2MyE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Sep 2020 08:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgI2MyD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Sep 2020 08:54:03 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7490EC061755
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2020 05:54:03 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o21so3399538qtp.2
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2020 05:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iyPsFrCnW6Cs7mqZ7fE1OjoXLPmkdyJPblfUQFziKcY=;
        b=RXDPKHo1lYdchTy56AWS6aLwY6D4SEJnZucuHTaBs1s4F+z140fw14I/JsfxAEA6Ks
         7NcRb1Hc/7FrXZyKfJz2iQFIF2IqsFVHadnZ10mFrBN43GJ52jAvqa3cUM/zaKfA+j8O
         CEGblSeoQ52aMJCaao14snhTCGFnz9wwLxgZY6x2YUo5halxEfzye1UXHrmAc9kgs5zJ
         KgN+cPSCZh07YbiERUu9lvJi5GnOPiZLa/e31lTunQPt5xbsfz9l/LPOuso6wHyt2s6N
         3LWdnVfUZPEQORFGipklFyMOB1gDaPgJDzuh15HcN4tC0aghyvnXIw4iuRHHiwVgQeiq
         cn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iyPsFrCnW6Cs7mqZ7fE1OjoXLPmkdyJPblfUQFziKcY=;
        b=dgUhQ8hN4P5zhtd+2TikAShQXbPztjGtdzOFNKfg/2hpNxF2cV/9pP0oYxnl55JRNI
         WcHVlbwDtTt8kPYzZa1EnKnmgsmMUWrFLN6NUL5C7+rZzPkjRMddK4yAZIQ/FvvuNNuB
         N+kaMWv1iJcd9KLuh3P2BqloZ96WpmVKKyYOQDERGU14l965qc3o77Q7oKyGmZYOKif3
         hS6JdUweXxjOnLyJSp3TsuPKMITs60l60RWlT8wyLHUaG43ri8W4k3Tlw3Ik8kw/aptX
         k+QEjX1+qMdsetEL4Rk/DIkWkK0axWv4vi6wM/RooiZVzTULUWzvt7aSsyU8CQJh4H9O
         GjNg==
X-Gm-Message-State: AOAM530KHPkQYU/iCiEUpMMmj6fEz5VY/6gRymYoN7SKT9PYhRqiFZRf
        NIEpdyPFXo4sR23R04w/BufN9WTbNlA=
X-Google-Smtp-Source: ABdhPJyUb3nPC73vgC3umtXkf5zPVKX+oxf0lH+m7uYV6ulkh7Yd+u5sEz/pqGPEQf1/Ukt+wxYXPg==
X-Received: by 2002:aed:2d83:: with SMTP id i3mr3126575qtd.198.1601384042682;
        Tue, 29 Sep 2020 05:54:02 -0700 (PDT)
Received: from [192.168.1.190] (pool-96-234-167-227.bltmmd.fios.verizon.net. [96.234.167.227])
        by smtp.gmail.com with ESMTPSA id u46sm5430891qth.31.2020.09.29.05.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 05:54:02 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] selinux: fix error initialization in
 inode_doinit_with_dentry()
To:     rentianyue@tj.kylinos.cn, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>
Cc:     yangzhao@kylinos.cn, selinux@vger.kernel.org,
        Tianyue Ren <rentianyue@kylinos.cn>
References: <20200927094243.43673-1-rentianyue@tj.kylinos.cn>
 <20200927094243.43673-2-rentianyue@tj.kylinos.cn>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <de004adf-fde6-11f1-fab1-11289788d4ec@gmail.com>
Date:   Tue, 29 Sep 2020 08:54:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200927094243.43673-2-rentianyue@tj.kylinos.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/27/20 5:42 AM, rentianyue@tj.kylinos.cn wrote:

> From: Tianyue Ren <rentianyue@kylinos.cn>
>
> Fix to initialize isec->class with SECINITSID_UNLABELED other
> than the from the xattr label when then dentry is NULL when
> the filesystem is remounted before the policy loading.

Looks like this was broken by commit 
9287aed2ad1ff1bde5eb190bcd6dccd5f1cf47d3 ("selinux: Convert isec->lock 
into a spinlock").

>
> Signed-off-by: Tianyue Ren <rentianyue@kylinos.cn>
> ---
>   security/selinux/hooks.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index bf8328adad8f..da7295a546e0 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1499,6 +1499,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>   			 * inode_doinit with a dentry, before these inodes could
>   			 * be used again by userspace.
>   			 */
> +			isec->initialized = LABEL_INVALID;
>   			goto out;
>   		}
>   
> @@ -1553,8 +1554,10 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>   			 * inode_doinit() with a dentry, before these inodes
>   			 * could be used again by userspace.
>   			 */
> -			if (!dentry)
> +			if (!dentry) {
> +				isec->initialized = LABEL_INVALID;
>   				goto out;
> +			}
>   			rc = selinux_genfs_get_sid(dentry, sclass,
>   						   sbsec->flags, &sid);
>   			if (rc) {
