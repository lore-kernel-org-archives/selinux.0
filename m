Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555DAC4332F
	for <selinux@archiver.kernel.org>; Wed,  9 Nov 2022 17:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiKIRQY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Nov 2022 12:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiKIRQW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Nov 2022 12:16:22 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15271D678
        for <selinux@vger.kernel.org>; Wed,  9 Nov 2022 09:16:21 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b3so26759467lfv.2
        for <selinux@vger.kernel.org>; Wed, 09 Nov 2022 09:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GENfn6zXgOzdkYAvC13fOBpuMVCsNyUj5wFKBHC8rHo=;
        b=Mn9i0tIRV+BOP8LzYAMTZZD20R2qVzbRKtj3ACF38MAT+t84U0QO2pGN3TB/79ZTv7
         vj7EQTNnZJaOIOIaugy8rulMsddgQoaTaCdWoo9LOFHeOWA006zChY7YhX8vvoHv7eUk
         FDmayh40P3KFEZ0jsNrZ9UP1avo5lyqgO8yJ6v1KL2C7Fab8ea+YQm0TR2SgeOppIxpC
         CPUaRsklHz5TT0MOTBJJDkpUiQpqK6Af4Rqp4XaUlhfey4D4GthD91cuk+6ph4AOl3zt
         GetgQiUY3dE72tp6h8CDWnkJFRfq9mC8/qRF+ZkhPzu357xEQtS1D2Q9qgO5GlZhru2k
         5FLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GENfn6zXgOzdkYAvC13fOBpuMVCsNyUj5wFKBHC8rHo=;
        b=dW+2qj/IA1iNBQ7/+At8zM4876kqnJHnCFP833w+58xXw2gtrzX3sJnfu/kDZ6IOhg
         LM/GQUHsy5DdPeRdfCzHJMJsjV6pqsX1ZIHGhR2GYEArDmHTJ4SWhIbQeoAWhpbQz7zf
         xtNyCJ9IlqAomRPLbs2QHMC48BTF2qYa6kFhrp9J1JczZKB9+zK2ocRPGB50BSoDFzdP
         7N+0zDHE+lRfChAGaBJwoR5kD1sBh/fEChFtmTdU47Oa2S2NZnJJF8CNL8y4IeUXlT3d
         PqQdJ9OS4jj49YpW/ayUINFMMdOPS+oKffZ1GZWgvtYSb5WPxrAZHNJiioYCoP9c0Soa
         IPzA==
X-Gm-Message-State: ACrzQf354RVNkvuhCNSMmb5DfWI1gDPnBHZkBQsqZDhzn5Yb2jZpaBrP
        obxIEx7BndFGpE+BRxjHtManh0+l8mK3VU8WoYE=
X-Google-Smtp-Source: AMsMyM5nUssdRvrnP6x14u3mIdywjP1nYiRRn/K93KUNU6y5WO6YadnpPWTpnHgIbWz4jI+PI3jz5c7cm+xmdAat58w=
X-Received: by 2002:a19:791b:0:b0:4b0:ab95:f07 with SMTP id
 u27-20020a19791b000000b004b0ab950f07mr19409728lfc.30.1668014180245; Wed, 09
 Nov 2022 09:16:20 -0800 (PST)
MIME-Version: 1.0
References: <20221109105327.1181753-1-plautrba@redhat.com>
In-Reply-To: <20221109105327.1181753-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 9 Nov 2022 12:16:08 -0500
Message-ID: <CAP+JOzRCKet4qcg9SN2cuDKDDXAT9AdPEacJ4uFOWKQo2pX5UQ@mail.gmail.com>
Subject: Re: [PATCH v2] python: Fix typo in audit2allow.1 example
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 9, 2022 at 5:59 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  python/audit2allow/audit2allow.1 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/audit2allow/audit2allow.1 b/python/audit2allow/audit2allow.1
> index c61067b33688..04ec32398011 100644
> --- a/python/audit2allow/audit2allow.1
> +++ b/python/audit2allow/audit2allow.1
> @@ -151,7 +151,7 @@ policy_module(local, 1.0)
>  gen_require(`
>          type myapp_t;
>          type etc_t;
> - };
> +\[aq])
>
>  files_read_etc_files(myapp_t)
>  <review local.te and customize as desired>
> --
> 2.37.3
>
