Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168D9C433DF
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 13:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E69E4206FA
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 13:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Ev6IiYZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgHSNXT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgHSNSl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 09:18:41 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74127C06134B
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 06:17:26 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id kq25so26243268ejb.3
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 06:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dateHzfZw4hPd5wFKbYuTwuR2vJkBtjz6R2J9fChvLQ=;
        b=Ev6IiYZ+OlH/SLqTtba7hvYAp8ZrC6H01bllc6jG+Y5MVimN3xs0fUUEGorLZEJEaz
         L/iZOR1mKogDqsk4V33A9qSfOwIJxoKeiczOZ/g+OnoZnxAZUzdIhc9SToh7CDd5y2YA
         PVDNLrUeMi3cVmklmjDL8B+j7houk5N26aHhoAY5peALSzS2nuPCzFIqXiGKUn1oR0/y
         B5a8qqpwlC7yewZnECWudOrH6bWg5/+OzxGieVIjdtxHq17DWEd/LoZuLyhFi1riXG7I
         055uWs7qw9OPmv1Ybi84aIl0KiAMHZimEKX6cq+FhlYtGf0A/o/r5obMctbu5wOBJTJf
         3Crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dateHzfZw4hPd5wFKbYuTwuR2vJkBtjz6R2J9fChvLQ=;
        b=TCd2Ars5/V/t9zIn5pMNlunAJxwrVsU/+zM3c5JOzQ1VmwEagnqDMUj46MmdRQGkzC
         j1YoaQbc8gbgsX72/mdSGOsq7InZncH6o035R99hjoU1+OxOWYnAEf31wM7EDTBIdhiP
         6FAa0qxjZwh7UzWLWrXA0j6NfJr6m7fe8EiPFIKjeh/Rz642XtToQOs8zfX4xkj6AVil
         6detrWo7OXLPu4sUNd/uTwATJr5IFDF3W/cBcTyQ2W1ykeVE02l9QzknhnEx8aHT04hz
         w+JGacxqZ5uiByy71+hgCNWRbmrsDPjldhUW+ViqIUyqWbIwqf9ToKtAX7yQ13v61Ssn
         xgXw==
X-Gm-Message-State: AOAM531BkqtSRyL0/tFT5X2pgR/eAZoxC0BAe/hOmHreBYMwn5IKCbQU
        igyNSNsIm2ZvTOTLseVL45KMg56JfSg+4lWDqEOO
X-Google-Smtp-Source: ABdhPJw7o0oSLKVTy4vNrzJxrl5baivYKPqVk7Brenppe5r+YscBH7pUQ9pcxpXLBtWTQrqYlPLDgY4/FfPIriQqf1s=
X-Received: by 2002:a17:906:1911:: with SMTP id a17mr23590862eje.431.1597843043948;
 Wed, 19 Aug 2020 06:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200819104256.51499-1-colin.king@canonical.com>
In-Reply-To: <20200819104256.51499-1-colin.king@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 Aug 2020 09:17:13 -0400
Message-ID: <CAHC9VhS3wvL43t+J=nhXiMj+1L+Ayso7+mO0z0KEM5uSfyM0mQ@mail.gmail.com>
Subject: Re: [PATCH][next] selinux: fix allocation failure check on newpolicy->sidtab
To:     Colin King <colin.king@canonical.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 19, 2020 at 6:42 AM Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The allocation check of newpolicy->sidtab is null checking if
> newpolicy is null and not newpolicy->sidtab. Fix this.
>
> Addresses-Coverity: ("Logically dead code")
> Fixes: c7c556f1e81b ("selinux: refactor changing booleans")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  security/selinux/ss/services.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks Colin, merged into selinux/next.

-- 
paul moore
www.paul-moore.com
