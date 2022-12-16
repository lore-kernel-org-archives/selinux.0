Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B176BC3DA7B
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 16:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiLPQIl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 11:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiLPQII (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 11:08:08 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCA143861
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 08:07:24 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id t17so7297136eju.1
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 08:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XkOZtBf5ZB5/J4bVrettMnh5NROcUyWv9vxh4zak8hw=;
        b=ofLtkZl5ToEcyUwDFTrcR2PXawEb7hXLV9I44DoRptWZqzG/PLZNUJlaFkIwgY0C/2
         UI7T5m03S3q9Vhn4uifo+vj32wHY/Ap41PeQPadwmPfKs44He10ZLX38qg6gl9IkoHra
         USyPhh8T1SATwbkYe2Cm+GA7PBlGWEu/c/sZyo8rCfrXFcNBVK/T4pxUIGMC4HeosbSd
         lDFg4atMpx62ReLZr0arCJN3aowHpuZ1MPFvgKd2xvK6z3yc+iyLpWFMlJC0xRXcBkVb
         +V9tSQZM8tMdaiaDTeV4a1tV70+n4QSfuisAHDDRQVQCMV+OAmebjrwhXFhA4jYbZQbO
         H04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XkOZtBf5ZB5/J4bVrettMnh5NROcUyWv9vxh4zak8hw=;
        b=PJRB1C/cuKAGaTKRb5do/eaFgHGWd0jftOsmbEALPaU5OM4qwfu5gOktj4g5fra2UL
         N+Em+TFlE6CTVtWzZ9eWPjJvrahOCetNSsMFZegNGrCO5YtDXDyQu/Fd6GPNXpWGBpFe
         iA6kh3yjf6FtgosRQxw29/o956ge5OtdT/jAGcvA9C3I52wL0fmvyp9LX3ItrARaDO1e
         ShgSZtCPgAQ28+HcZOo9S+ERFN1MbdFN2cHl3pvgbrlAVVu+0Zyw6uEOynYFCWRxMDU9
         YoFl6i9LiACsktUnk1XZRqAifO51q1xGstMBWqHQcYJS5q2pKeXnSrD0XORbAQqcmZ2H
         q+AQ==
X-Gm-Message-State: ANoB5pk4lNk6BCgisQKSb1EI1ttgWtvTM8fHqT51pcE3uCT/CqQBB6Zg
        h4YX/3uURpYTix5s+sR00iIR52glqRugs1Nid3LilXl0yZI=
X-Google-Smtp-Source: AA0mqf4/GVNNe/oc2g8dKz5NI/itfqLvqwwboQJSQD4cB9jIHfu/O4s5kuapXbwHOBUfOfs02e6D+9ukYtkEotFhKgA=
X-Received: by 2002:a17:906:3a15:b0:7c1:b65:ad79 with SMTP id
 z21-20020a1709063a1500b007c10b65ad79mr10936856eje.402.1671206842714; Fri, 16
 Dec 2022 08:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20221205093644.703107-1-lujie54@huawei.com> <20221205093644.703107-3-lujie54@huawei.com>
In-Reply-To: <20221205093644.703107-3-lujie54@huawei.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 16 Dec 2022 11:07:11 -0500
Message-ID: <CAP+JOzSEFRrejgab331mG8dFgv2YwR=WYjC7Qv42XMkoOnDw9g@mail.gmail.com>
Subject: Re: [PATCH 3/3] policycoreutils: fix potential NULL reference in load_checks
To:     Jie Lu <lujie54@huawei.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 5, 2022 at 7:13 AM Jie Lu <lujie54@huawei.com> wrote:
>
> In load_checks(), add return check for malloc() to avoid NULL reference.
>
> Signed-off-by: Jie Lu <lujie54@huawei.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  policycoreutils/sestatus/sestatus.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
> index 7dcc9944..6c95828e 100644
> --- a/policycoreutils/sestatus/sestatus.c
> +++ b/policycoreutils/sestatus/sestatus.c
> @@ -140,6 +140,8 @@ static void load_checks(char *pc[], int *npc, char *fc[], int *nfc)
>                                         pc[*npc] =
>                                             (char *)malloc((buf_len) *
>                                                            sizeof(char));
> +                                       if (!pc[*npc])
> +                                               break;
>                                         memcpy(pc[*npc], bufp, buf_len);
>                                         (*npc)++;
>                                         bufp = NULL;
> @@ -150,6 +152,8 @@ static void load_checks(char *pc[], int *npc, char *fc[], int *nfc)
>                                         fc[*nfc] =
>                                             (char *)malloc((buf_len) *
>                                                            sizeof(char));
> +                                       if (!fc[*nfc])
> +                                               break;
>                                         memcpy(fc[*nfc], bufp, buf_len);
>                                         (*nfc)++;
>                                         bufp = NULL;
> --
> 2.27.0
>
