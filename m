Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BB4C07E9A
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 02:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF515610A7
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 02:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhGMCnB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jul 2021 22:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhGMCnB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jul 2021 22:43:01 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51749C0613DD
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 19:40:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t3so30946694edt.12
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 19:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6SKPfn6xRnP6RvM1343nJURmtoEoYmDq0f1l/33/h84=;
        b=x7RRPQyv9jG3OzPccMOSnW3VrdK3C+C7wh57/h4YZqZTFnUPLVZIkbejJqFM1bGJXD
         hevjB4DEy9ElJW2GegUT1Xz2iGCm80zDMxIHFu6XRcIUtWY+iXCOVvT0Riyb19LtNK/X
         RALuOfemsmqkkECHX8UFntgZwQiBNizAreHhCk+nxQ9KufS/UsFKP4VvmFp4KT9issBw
         d3HYbjdCRd67BmavBuE9GJTUdo8fV2oYiXZC7dHoKcGKuGW1xjO37V29xWHAPtcL2ejB
         2C2bzm6u2g5vlaz5YJv05KqWddMghzzTRd6D0hlHY3+5n9BgfSBLXDolpjLtUY0GcJNu
         torw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6SKPfn6xRnP6RvM1343nJURmtoEoYmDq0f1l/33/h84=;
        b=ieQite92H1HP9R2Uh+hCJsOqCCyXZoFGU6XintZJiccp4754L5hOgv6RNOqz3cpPgN
         Q7cRLqWJjrYVQRC7KZP3tpdWUixRnroCjN4pBK4IX3ttLAmCovaXHyiNgwPy57KhWTGm
         27ZW4Ff7R6+03b2Di+oC/tYlxUR0X4sUPF9Mxf6ztDsWiG8aqGUlHrgXng8juEMF1KYP
         dBndcO3/CFjwCS7NXDdf8Erb+5JOfsMG9CfITQ+S7O+QinSbSuOXU5OKRi4WsnY5WvKx
         xenCxcQCVU8PTBowke/k5YpWcdEXR+2Rco6rC9dJ9GJiNfmhizPtJCXufQJJIysJBr73
         wjZQ==
X-Gm-Message-State: AOAM531xDjFDUqR4NIbQyxai/SPABru1yq2biuIaRFJ4rmbrGu3taXAK
        shYY/dD1vMYpe3S8bQfSk22NduOFIwZiwfvE3w9m
X-Google-Smtp-Source: ABdhPJyZ/TPOOkCsJy185npELs8RkJjMh8prX3d/UtGFgQ0YS2+kXH0n7ovix3Q1wjS+ou3pLjc8wCtqxZLZR+mgDZA=
X-Received: by 2002:aa7:dd88:: with SMTP id g8mr2479547edv.196.1626144010862;
 Mon, 12 Jul 2021 19:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210705090922.3321178-1-roberto.sassu@huawei.com> <20210705090922.3321178-4-roberto.sassu@huawei.com>
In-Reply-To: <20210705090922.3321178-4-roberto.sassu@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Jul 2021 22:40:00 -0400
Message-ID: <CAHC9VhQAM+-TXOHLkcY2VGyJ3PNES0EaNr3PccHT=j3nGAvfPQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ima: Add digest and digest_len params to the
 functions to measure a buffer
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        prsriva02@gmail.com, tusharsu@linux.microsoft.com,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 5, 2021 at 5:09 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> This patch adds the 'digest' and 'digest_len' parameters to
> ima_measure_critical_data() and process_buffer_measurement(), so that
> callers can get the digest of the passed buffer.
>
> These functions calculate the digest even if there is no suitable rule in
> the IMA policy and, in this case, they simply return 1 before generating a
> new measurement entry.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/ima.h                          |  5 +--
>  security/integrity/ima/ima.h                 |  2 +-
>  security/integrity/ima/ima_appraise.c        |  2 +-
>  security/integrity/ima/ima_asymmetric_keys.c |  2 +-
>  security/integrity/ima/ima_init.c            |  3 +-
>  security/integrity/ima/ima_main.c            | 36 ++++++++++++++------
>  security/integrity/ima/ima_queue_keys.c      |  2 +-
>  security/selinux/ima.c                       |  6 ++--
>  8 files changed, 39 insertions(+), 19 deletions(-)

The SELinux changes are trivial and fall into that
cross-subsystem-ACK-not-really-necessary category, but why not :)

For the SELinux bits:
Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
