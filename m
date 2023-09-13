Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A24EE0202
	for <selinux@archiver.kernel.org>; Wed, 13 Sep 2023 17:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjIMRrE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Sep 2023 13:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjIMRrC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Sep 2023 13:47:02 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1CA1BE6
        for <selinux@vger.kernel.org>; Wed, 13 Sep 2023 10:46:57 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-649a653479bso670886d6.0
        for <selinux@vger.kernel.org>; Wed, 13 Sep 2023 10:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694627216; x=1695232016; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2tqqqVOlWsAHGl0XMhMJeMmA0HXl2zbF86DXDUgMIEo=;
        b=NTS8YyUvqiyV1d26WeYz5jHsTzTeKYTJbSMBwQ9kRx1omp0ETV/7Dwl13YozUeg9D0
         X7i8cn/p7X2zNpcAdBMZ5gmt2fd/JYYozSpR3PGzzOJgz6ktn8LupMciYNiFuTIZNTIL
         Fpx6UXSDpZXJXF9xkmF59mEnHETU/axUtcaV6upIyK706/TpFjWAARF8QCNVltvuRkX/
         ZIB8kB+OeEGP3kRGN6ZpPbhdQ2myXniIITDCpSatpO5d27UNaVcJ0VaFYiqb/C1A+/7G
         3VM5m056PEtr+UKtHl7VfgYqkNLhO8OwzRN6gMI9GBfl1PZ0QBE+tLh7F6yXx4FeRRz0
         zdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694627216; x=1695232016;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2tqqqVOlWsAHGl0XMhMJeMmA0HXl2zbF86DXDUgMIEo=;
        b=mJhJphNXCm+M4vGJABnhb315xxTp3t9i5hEBK6HVELfgKZu20sE1zzCeuwtHK9eYzf
         +cbejDB6XIFf68zisZNjrhjm26/NngBt7FluTFoClhTMR43J0nGcsihF3Lw2sTsNjBea
         RUd3qNZw0h0Ns8b0RLUL3xUmHZNFY9hy1JkoaVAEKH+ZDTISK+G6c/PHkEa8iPerwIAU
         8m5nNVSW0n4vymwkJ773S8FFY3W7YnMZWTp9dibWv2GKXkJfSRsGWSdf7rU7M4USpSDF
         IXWzLl3ZVJtzwTYrtutdsa1VKGX1ePGDtAsOMdScEJwSAd1M9dGcOhihijbJCd86hjhQ
         ddWQ==
X-Gm-Message-State: AOJu0YyYmfiOKtIj1gvieX3lSmK7rF/L1k9IRfkHjBM0y1DVnBguuFwS
        TBiL3/2N75kOcgM+chT0kexj
X-Google-Smtp-Source: AGHT+IE0DsEQp+TXnF2CWTn+mIC1q/n12B+VHNeNyu9gfiCePPQrEy/Mf0aHtfNfJlnr7TJ8rVsWBQ==
X-Received: by 2002:a0c:ebc2:0:b0:651:6edd:c6c7 with SMTP id k2-20020a0cebc2000000b006516eddc6c7mr3001249qvq.31.1694627216572;
        Wed, 13 Sep 2023 10:46:56 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id e6-20020ad44186000000b00647386a3234sm3618854qvp.85.2023.09.13.10.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 10:46:56 -0700 (PDT)
Date:   Wed, 13 Sep 2023 13:46:55 -0400
Message-ID: <48756a04aea9d076c3a35ff4c9257dce.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] selinux: improve role transition hashing
References: <20230818151220.166215-4-cgzones@googlemail.com>
In-Reply-To: <20230818151220.166215-4-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Aug 18, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> The number of buckets is calculated by performing a binary AND against
> the mask of the hash table, which is one less than its size (which is a
> power of two).  This leads to all top bits being discarded, e.g. with
> the Reference Policy on Debian there exists 376 entries, leading to a
> size of 512, discarding the top 23 bits.
> 
> Use jhash to improve the hash table utilization:
> 
>     # current
>     roletr:  376 entries and 124/512 buckets used, longest chain length 8, sum of chain length^2 1496
> 
>     # patch
>     roletr:  376 entries and 266/512 buckets used, longest chain length 4, sum of chain length^2 646
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/policydb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/next, thanks.

--
paul-moore.com
