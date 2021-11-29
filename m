Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E696C433F5
	for <selinux@archiver.kernel.org>; Mon, 29 Nov 2021 22:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbhK2XBh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbhK2XAg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Nov 2021 18:00:36 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEE0C0C236D
        for <selinux@vger.kernel.org>; Mon, 29 Nov 2021 09:48:44 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso26574196otj.11
        for <selinux@vger.kernel.org>; Mon, 29 Nov 2021 09:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FObIIv9WAUnOktnk9am2VhN07ZZb0Ljbwn1/sIa9tPQ=;
        b=o7OKsEuDYMET3yiKm4Fe/g+1RSKUShDwKNwchS7bq/oRiC+AuA2z96p86CUZwmvSvS
         t2TXtzCKClM1ODSKMWsgxAqzuHiBrg4xwZbtjEqEcGoXDKfZ7wtGHxMgJzdTmSBbhRdH
         9gNSR+cHMfjA5fPkQofjdgUlm94jemb9nuwQx39PkI69NshnxW2sVQaLrIGw9YI2AupY
         AV1Q1K6N7wdcq3Mwo7DIMVRo/mB2pA648J2Jd3yG4E2kbSgXRkZ9fjbFY8XzmcAFbmm2
         o2l/C/ml8Ffijom8ENcCC7ddhFiKWA6u2heTGiP7kMLXWGwPkJ8p8UVveqpkHgsJ19WJ
         8VyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FObIIv9WAUnOktnk9am2VhN07ZZb0Ljbwn1/sIa9tPQ=;
        b=5UIgJpc2RpO1XKd7hnVJkAZyU2TnZVUwZqcJ2fkDsKPyO3Mn+hZZSbZwuvPdCGvWBu
         aTvHT0UWayxX+mUijL8XAseAUWVZO9Dvz/IOlN6UCKueZYOkE1fg9vEXhjFfTgPjHm0j
         FVF3xsgkF8fJbesKVG49sc1fLFMLp9JM7ZOKpz/MclhT60d9K7pWJduMHxTQE/hbDJu+
         qihKB+NRqWHMidzbC/GeAdhZAnOesGhNm0Vas4tesrzd1v/xxAZTcBEIbhki23iRoVMx
         tHqvlnJi+72ISKWRnLoiI2Yl0pTiUwZB2loX/dk7KtE/fbuXw6/lOo9odd6b68n2QY03
         VIiA==
X-Gm-Message-State: AOAM530XQp6uyuWsBqH/pKqo6P0kF6Oh0ZQL2mCtArre8PulZz26qidd
        fINNZ9+34I8P/D0GAn8InglsXen2FCETarZCs5WQ3GGz
X-Google-Smtp-Source: ABdhPJzdAz8kDyzQCGOgkQ5VChV5QXNa0Hvuc5ufKKbP8yD7yx2K3mipJwIX9pL2To0tk67Bcc9rvBRkujbZSwb3NWo=
X-Received: by 2002:a05:6830:1bfa:: with SMTP id k26mr46162840otb.139.1638208123814;
 Mon, 29 Nov 2021 09:48:43 -0800 (PST)
MIME-Version: 1.0
References: <20211123190704.14341-1-cgzones@googlemail.com> <20211124190815.12757-1-cgzones@googlemail.com>
In-Reply-To: <20211124190815.12757-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 29 Nov 2021 12:48:32 -0500
Message-ID: <CAP+JOzQipvtFYq-R=BvsXaoa_LyZtYTMoPEc0H_oAgqxq9Cqrg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] libsepol: introduce ebitmap_subtract()
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 25, 2021 at 3:03 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add a subtract method for ebitmaps.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2:
>    - add shortcut for empty ebitmaps
> ---
>  libsepol/include/sepol/policydb/ebitmap.h |  1 +
>  libsepol/src/ebitmap.c                    | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include=
/sepol/policydb/ebitmap.h
> index 81d0c7a6..daca67a2 100644
> --- a/libsepol/include/sepol/policydb/ebitmap.h
> +++ b/libsepol/include/sepol/policydb/ebitmap.h
> @@ -83,6 +83,7 @@ static inline int ebitmap_node_get_bit(const ebitmap_no=
de_t * n, unsigned int bi
>  extern int ebitmap_cmp(const ebitmap_t * e1, const ebitmap_t * e2);
>  extern int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebitm=
ap_t * e2);
>  extern int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1);
> +extern int ebitmap_subtract(ebitmap_t *dst, const ebitmap_t *e1);
>  extern int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitma=
p_t *e2);
>  extern int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *e1, const ebitma=
p_t *e2);
>  extern int ebitmap_not(ebitmap_t *dst, const ebitmap_t *e1, unsigned int=
 maxbit);
> diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> index 1de3816a..80f0e201 100644
> --- a/libsepol/src/ebitmap.c
> +++ b/libsepol/src/ebitmap.c
> @@ -72,6 +72,24 @@ int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e=
1)
>         return 0;
>  }
>
> +int ebitmap_subtract(ebitmap_t *dst, const ebitmap_t *e1)
> +{
> +       unsigned int i, length;
> +
> +       if (ebitmap_is_empty(dst) || ebitmap_is_empty(e1))
> +               return 0;
> +
> +       length =3D min(ebitmap_length(dst), ebitmap_length(e1));
> +       for (i=3D0; i < length; i++) {
> +               if (ebitmap_get_bit(e1, i)) {
> +                       int rc =3D ebitmap_set_bit(dst, i, 0);
> +                       if (rc < 0)
> +                               return rc;
> +               }
> +       }
> +       return 0;
> +}
> +
>  int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2=
)
>  {
>         unsigned int i, length =3D min(ebitmap_length(e1), ebitmap_length=
(e2));
> --
> 2.34.0
>

We already have ebitmap_andnot() which does the same thing (although
it does take three ebitmaps). Also, subtract is not a bit operation,
so it doesn't seem to fit.
Thanks,
Jim
