Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3929BC433EF
	for <selinux@archiver.kernel.org>; Tue, 25 Jan 2022 14:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580577AbiAYOvD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Jan 2022 09:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1580067AbiAYOob (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Jan 2022 09:44:31 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44447C061751
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 06:44:26 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id e81so31389252oia.6
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 06:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kLwiSmb7xZBY4oOewvV48jG7tqgj2oXlh4KuElycNf4=;
        b=Q1aNo8Uxv3znrIEUuXot8ZLWYiVTdHET6PyYMtTlaoFzfdIzsA0TCKAGADCq3wkz6f
         0YAD+yI/8qg3Elydr4kQms//a8EBybFr0maMHgP8yoV26gyon+VU/iGJ08ZEKIPB6D0v
         yUDF3vxtr+D8wcxeOA7Jdd+gqiGKQDWGS14XjroWHcbZpiKVEfadlaNe7YT9sHoQoUZG
         vaZVY7ybDdJjFd4mbvIS/Pvm8p2bKiCUg4Cxa2AnudoKqROm6UZkchdQ2/1CsqRvqN1p
         oYIGSSU2IGdla2PyUJb55O58eSpSXxb5vPX+ryfSrnKLSwQQTXm6NvBkPdRs0Fu3UROt
         kRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kLwiSmb7xZBY4oOewvV48jG7tqgj2oXlh4KuElycNf4=;
        b=lRZ7AjTvdxE/O4eBCU07YW+2A4eKDyL6w1uPb8vnf8n51fkF7GrhmdnjBaIBCTtdv8
         4M9Lp3HFahq9PSShCJSYUxw2V5hcednTf/gJPhslEyvTE2GJtu0UfFn4JiuV8JjSvIHr
         sjKq/8UsGRO++vMlxUKEQIGJTNaY+8/+XLhkySxaI0rwl+NBb7osYAedzJHdulzDBM9I
         z6tEXLt1F9VagWaOXCKV0kHo7BNPdyPhDTwD4TibZQXu8fZwRCeH86OIsSUIUNWo2GJt
         ewISfYU7+pKbzY+7ZnNQ3r2MlCBee3tokq7KLmhsTzXKdQj1ZcVqbo0P1uMKKv9nfkaP
         CAuw==
X-Gm-Message-State: AOAM533ulCQnCvNfILCkZhdyfFG+/tf6PsTO3Z5JzlApnJucSJeaYx9f
        Yzi99QqMMFR6Z/qlhvdDkJF6ghFBKZtpWvBCHOY=
X-Google-Smtp-Source: ABdhPJy/OQ2vW+zTp8qN+BgYl4KG4xlKLcHIl6yAQAJ/LWrO2Y9fMiq35dhM9lNgbN/yWgE9dvwjtP9nt6j6wlZcSXY=
X-Received: by 2002:a05:6808:2124:: with SMTP id r36mr842960oiw.200.1643121865636;
 Tue, 25 Jan 2022 06:44:25 -0800 (PST)
MIME-Version: 1.0
References: <20220119143926.5464-1-cgzones@googlemail.com>
In-Reply-To: <20220119143926.5464-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 25 Jan 2022 09:44:14 -0500
Message-ID: <CAP+JOzRbmA=3kfHpCn-JwuuDKrBz5_Hpendk3JDFv-Y=RrBBbA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: return failure on saturated class name length
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 21, 2022 at 2:18 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Do not return success if the class name length is saturated (or too big
> in the fuzzer build).
>
> Fixes: c3d52a6a ("libsepol: check for saturated class name length")
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 562e044e..fc71463e 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -3937,7 +3937,9 @@ static int scope_index_read(scope_index_t * scope_i=
ndex,
>         if (rc < 0)
>                 return -1;
>         scope_index->class_perms_len =3D le32_to_cpu(buf[0]);
> -       if (zero_or_saturated(scope_index->class_perms_len)) {
> +       if (is_saturated(scope_index->class_perms_len))
> +               return -1;
> +       if (scope_index->class_perms_len =3D=3D 0) {
>                 scope_index->class_perms_map =3D NULL;
>                 return 0;
>         }
> --
> 2.34.1
>
