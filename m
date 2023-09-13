Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87723EE01FD
	for <selinux@archiver.kernel.org>; Wed, 13 Sep 2023 17:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjIMRzD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Sep 2023 13:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjIMRzD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Sep 2023 13:55:03 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487F219AE
        for <selinux@vger.kernel.org>; Wed, 13 Sep 2023 10:54:59 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77058512c18so7522285a.1
        for <selinux@vger.kernel.org>; Wed, 13 Sep 2023 10:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694627698; x=1695232498; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uQCc9pEr6M+GkVAEf9UVkQlISGfnRam2R0wl9SFmxPA=;
        b=RC7SpFOmzDAPqKOXHvwHMJajQdhBMV1PKsrXH/2W+dCE3y8Mk63cRvKm23+Rgij0Nk
         f4EwWfqcJ4Hy25TVzC7AZSG+Lg6X432y8fSrf2pCq4FXNRPLZHjTa1CsLhWValZatqA6
         A1HQVtRJmijJ5l7n8G9f0tJc2MfPaXWXSGdW23g267cJKfJ+1hfnwUnY3Tl818EIyhKK
         qw/WCPHAyzhCu9/4bCmuiggp6f4ANsDzWj+aZ7sn13syxyu4EJGjPFOMlrvWBjDPhC8C
         Exx4oW0BNOIB3ZdhR/HTB8W1xbar6c4ltmm8reB6rFhe/5x9eNAqtvNQI+6aJp7G6zgi
         u/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694627698; x=1695232498;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQCc9pEr6M+GkVAEf9UVkQlISGfnRam2R0wl9SFmxPA=;
        b=N/3XyNFxaA4IurNZzvi29dplMZNzApxzjZO142vQxTywpOLpWmILvXVtZBaRs+jlR6
         5v0Yecd4bq5U4XHIMEOMDUY9qLQQRLcVhDp8kRSG7ZEIBYkZ+UcXqnYYfe1uwcE0vioz
         w1nYbJ7UTkJeJdpiTDjZAfErmnzRa7b9JM0Dv3eoRV8fuva5HBgISx/HFvcZZeBAzzCu
         F/bCoYwq3HNEdE/ECr+s4AJvvcZN8YY0MjJ4LVHdPZBbUi/GwmPdrDB8XsL866XBtOI7
         plxTYGkZ0dvRrkj9QfvMdKF6sHe3R1ZVpfv9J4rnsjmaABABFXavNI69TOPGWzNuTGs8
         9TMA==
X-Gm-Message-State: AOJu0Yw2+IO6duzsXJWI5S94IodB+NdX6lteKmgnL+Xyng5iAfSH/e1R
        m/15zcMwwBW398btqxp/ygQwRmdhcCHu9RbZzg==
X-Google-Smtp-Source: AGHT+IGQRdCIKlvypI9bbHDY717bBRVD9GP0c5DSMc7KEZzqoilhDv8zed74+DnNmZkl6SWSvnc5Zg==
X-Received: by 2002:a0c:cc8d:0:b0:636:afa1:345d with SMTP id f13-20020a0ccc8d000000b00636afa1345dmr3381323qvl.17.1694627698414;
        Wed, 13 Sep 2023 10:54:58 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id s28-20020a05621412dc00b00655eb94348bsm2609841qvv.79.2023.09.13.10.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 10:54:57 -0700 (PDT)
Date:   Wed, 13 Sep 2023 13:54:57 -0400
Message-ID: <989919a2f147a7d98adbdda00fb58b52.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, omosnace@redhat.com
Subject: Re: [PATCH 3/3] selinux: hweight optimization in avtab_read_item
References: <20230906154611.31762-4-jsatterfield.linux@gmail.com>
In-Reply-To: <20230906154611.31762-4-jsatterfield.linux@gmail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sep  6, 2023 Jacob Satterfield <jsatterfield.linux@gmail.com> wrote:
> 
> avtab_read_item() is a hot function called when reading each rule in a
> binary policydb. With the current Fedora policy and refpolicy, this
> function is called nearly 100,000 times per policy load.
> 
> A single avtab node is only permitted to have a single specifier to
> describe the data it holds. As such, a check is performed to make sure
> only one specifier is set. Previously this was done via a for-loop.
> However, there is already an optimal function for finding the number of
> bits set (hamming weight) and on some architectures, dedicated
> instructions (popcount) which can be executed much more efficiently.
> 
> Even when using -mcpu=generic on a x86-64 Fedora 38 VM, this commit
> results in a modest 2-4% speedup for policy loading due to a substantial
> reduction in the number of instructions executed.
> 
> Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/avtab.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
