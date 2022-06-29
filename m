Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1460C43334
	for <selinux@archiver.kernel.org>; Wed, 29 Jun 2022 17:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiF2R7g (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jun 2022 13:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiF2R7g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jun 2022 13:59:36 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAD8E9
        for <selinux@vger.kernel.org>; Wed, 29 Jun 2022 10:59:35 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id be10so22673008oib.7
        for <selinux@vger.kernel.org>; Wed, 29 Jun 2022 10:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nVV/qUp4Me14YG9vpS6wOtW0gqHRoldyqO7K4md5U5Y=;
        b=Rgh15pllovqqLr7mx4ESEWLjcNBTBTgNJ7nxcTx+vOBvywee/8XxntNFyyvBA8fWYx
         EeIPq9Plqsu3gRUx63VamyjKaK/Y0Ft55ixA9DfU2uAdg7QoUd+hMFZLh4LmGFBNvFL+
         mJy3PyibycEd89wD8qQfsU7m+juCegcUoP8NA7u9bXGDHkK4OvvBm1tPsdC9lv47n94o
         IJjInO2RjdO5rE7jCtf9EWKZKR0RT/1+qvkMwHtPSJur92VqaP1VeGh68vSyWs3YCJHa
         YR0UbuWbuHT5YB6wLOpow70Hsxtwi1IR7d/LMMgkCv8Iw2Qs8m8WFLIrZouazeRZHw2h
         Qg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nVV/qUp4Me14YG9vpS6wOtW0gqHRoldyqO7K4md5U5Y=;
        b=235/DZG5vSXzYTMrLXhVLzS5FypzOj7Yw3qKQmCfpF8BEGf5O5zsRYb+tR9nVcaYYA
         xHApX7GnW8Si+uJEDBu/+ba2CxqMEifLNR48WZhlai+b74IzK9Ur1Sce/EuBsYN9MMZ1
         E11g15RIoGu6Hbyn2CCbbF0Qas2RP1eL1JUaqwP7JhttqwIM/dYwkdrMB7Y2/4ZgW4Li
         Ez57cWVrjz8ISTJyf3fTylI1EKtFVH21NB/vT9/7QH96fCOy9QyoLjNQd01NLIMnDsnu
         veub4Pk9kWSYqhohrSpTVF8w0A/m9QfV4yOBDxTgGuw0/YKPzbJt6vWfkTe1WkTIHXhn
         FMIg==
X-Gm-Message-State: AJIora82hU1qRQJxBlUJBpx+vKLDVduTUoUg7smE7ZWocgOtruJd9cvc
        ZhCM+uG9X5O1xfKKfWP86KQt+Eq3Nc8nQIcyG08=
X-Google-Smtp-Source: AGRyM1s51P8eSkrJs4fSm/lXdvUit5NN+iYp3BZTz+z3Vjs9Ceon/Dy1iQA/tTZuQ7I+D66sbN5pyQKVAP1jKMSWBgs=
X-Received: by 2002:a05:6808:198c:b0:335:9b27:95b with SMTP id
 bj12-20020a056808198c00b003359b27095bmr2725766oib.182.1656525575197; Wed, 29
 Jun 2022 10:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220610150623.21082-1-cgzones@googlemail.com>
In-Reply-To: <20220610150623.21082-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 29 Jun 2022 13:59:24 -0400
Message-ID: <CAP+JOzTgmEChGDe-7j8rrh1PNJQBY9AOJx4gkTdtxM_FxNauaw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: avoid potential NULL dereference on optional parameter
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 10, 2022 at 11:12 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The parameter `reason` of `context_struct_compute_av()` is optional and
> can be passed in as NULL, like from `type_attribute_bounds_av()`.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/services.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index d7510e9d..24412d83 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -894,7 +894,8 @@ static void type_attribute_bounds_av(context_struct_t=
 *scontext,
>         /* mask violated permissions */
>         avd->allowed &=3D ~masked;
>
> -       *reason |=3D SEPOL_COMPUTEAV_BOUNDS;
> +       if (reason)
> +               *reason |=3D SEPOL_COMPUTEAV_BOUNDS;
>  }
>
>  /*
> --
> 2.36.1
>
