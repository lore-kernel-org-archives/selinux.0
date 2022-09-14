Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7668BECAAD8
	for <selinux@archiver.kernel.org>; Wed, 14 Sep 2022 11:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiINLwk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Sep 2022 07:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiINLwj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Sep 2022 07:52:39 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1C077EA4
        for <selinux@vger.kernel.org>; Wed, 14 Sep 2022 04:52:37 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-12b542cb1d3so30459280fac.13
        for <selinux@vger.kernel.org>; Wed, 14 Sep 2022 04:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ndUOLxOaGlFRGIa+IUCqchYoYX0ob/eqM4B2Su7aOP0=;
        b=EYX698uwfmKMSXh/ILCEGi20kLHVC2QuF0Wcs243ekp242ONMvwY1QBX2Wui6PGcDI
         CStw08eCxFr2759UFNnBa8qHHa4Win2S11Vurdt3ZiGKFm99xL6z796AH36DFexOXHDP
         zceFKtA8ZYKgFgi2lYpPZ4YFgTfHW75lvh0G4BuwOq1lyzddQzX9zqz0gVeu016zV1zD
         p7pXrSD4aLmWaQ02ILxqsWj/iVqXRyGwtUm79+trpdTViGk3qIKqq7Db2TJdO+s7ryjY
         6ehpS2yC1VWqMsZ7CzGOU4R+6lla4NmIAE5RKYGCXbWJFKfbJy5VfKDaamgKn3aZsgRm
         A9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ndUOLxOaGlFRGIa+IUCqchYoYX0ob/eqM4B2Su7aOP0=;
        b=T3Y0G1AtYer3EEmgKyY4ro3j7BZEyBrD8orfhNCyIOUpWB88IhcOB0A3OPlc24MqGW
         WhWzRPkieOY3aLXawGr/rTKjB9Ha3S1YCfwPiLDu84cDVzbLA+U+78CJchY+gvuKEK4Q
         poOceAandkwMWJA6mAOEOMud2dVaB6V5/Fog36gkY9RDMozFD6VIm0SlPrl3r4fLW2UO
         IwXOBTRyAIu165gMDercepg1lsR9jZJnGWC67HDIabC4pZFALW55yeVCBX5mL0St8hVj
         XiBWEx/2SS7fIRxOslBhiAgfQzHVQNU65olD3/2qzJ6khl3XsOhbLRU8gi/pPISTLzEn
         CFTw==
X-Gm-Message-State: ACgBeo0RHwQ7kQ15KzJAqt67vj7eDpPlN8vWrrK6hrZDeGvUzftJCa3g
        3mbwQH8W9iaWRQig3VbqURcxLxBbam9hEPngxH2z
X-Google-Smtp-Source: AA6agR6NuCDcdGmTw2CRi4kDEce0q6x+ZkxaJ0aByIguJ13AxbD6awMbL0ptxfjdNAPNp3SxBD/Oa58zKL17FN8ONQ4=
X-Received: by 2002:a05:6808:1a18:b0:34f:ff74:8303 with SMTP id
 bk24-20020a0568081a1800b0034fff748303mr1737508oib.41.1663156357118; Wed, 14
 Sep 2022 04:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220912091718.18053-1-xu.panda@zte.com.cn>
In-Reply-To: <20220912091718.18053-1-xu.panda@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 14 Sep 2022 07:52:26 -0400
Message-ID: <CAHC9VhSnzZ-75EVyOx6SO1_61y7HT-oGHisCwNSeM+VpjzhaDQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] selinux/hooks: remove the unneeded result variable
To:     cgel.zte@gmail.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Xu Panda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 12, 2022 at 5:24 AM <cgel.zte@gmail.com> wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
>
> Return the value avc_has_perm() directly instead of storing it in
> another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> ---
>  security/selinux/hooks.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)

Merged into selinux/next, thanks.

-- 
paul-moore.com
