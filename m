Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F74EC433EF
	for <selinux@archiver.kernel.org>; Wed, 19 Jan 2022 19:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiASTSG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jan 2022 14:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiASTSG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jan 2022 14:18:06 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339B3C061574
        for <selinux@vger.kernel.org>; Wed, 19 Jan 2022 11:18:06 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id s9so5710194oib.11
        for <selinux@vger.kernel.org>; Wed, 19 Jan 2022 11:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YiZMH9QlO/UVd8q8stKx9wAtVvl8TQngIQ3hjSzSuGo=;
        b=NQBC/AMHi8TCEngF1dbT0FNdKT32/QWBAeFmkY5APlzTtvFmKS/a7Z7/2qDzaY2K4j
         JYmnlTmFKpOOUqLhWzB2VIhXvwUhzQXi4adkfOAvRdpQ8+JHHash/vII8TlE2u4Vv0VO
         QoHASHqe74ksMlZS3hIBf+psZkK1z6Nhh5tW6HsCBN8z2932Yo+CJZrLm048RPsUfiih
         RsDSI7ZZ30fyznrXkUlMC73r8N9WPMxwdjoKIPTGDV3ab2IlMvPnKKYxL48IoNCic4WK
         RsDN5zS93dtKCSwK91uXO3MIcwK7wieClpsjRtuatEoBgKzF0Ae/Jaos26bnGCbX3snZ
         ycVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YiZMH9QlO/UVd8q8stKx9wAtVvl8TQngIQ3hjSzSuGo=;
        b=UX3i++ygFCfUg3WFux0K/6A6MNLZY6P9G0Dnx7xooxe8XD+JrdayzS/DbO88umKWEW
         csvwAb9RIKDXbHXgR/sycZqW5+uqBFRoWKzmimRzPsi8daXVVZEoS5+5R6iPF7KZzHj0
         so+xX1csyzH0OdO9riClmAooSqCxsFepOzBkDywRLiGexwNaJPJmW4nT2PhQfEw3beWc
         pBzD7F3cyR/rYw10VPlCbhYWZdGgTlbeFa1T5/g4LsnEq/7vmEiRAzzmXyl9pYbCCOyM
         nArGoNq/6KAfwM2w9Rh6Qx2yt/x8W+cwDsUlxZ4TU2E2dpNM495lapRkiMl1M6rjcJNi
         4wrg==
X-Gm-Message-State: AOAM5325szldflTXlUwwfavFiVFaeIxPcClh3+s1onL6z5VGx3QoOmTJ
        OfIH5s/rJB5pza9Lh30ac2mv60VGPUTq+j/YtC83KI3u
X-Google-Smtp-Source: ABdhPJyLN7jMxk1W/mBj2+NjQVyhkR9+lUXR4F8Sks1f6gl2z81zJnCjOarcY4zoeBh+EB1MfUAU4HK6wpr9wygnFz4=
X-Received: by 2002:a05:6808:290:: with SMTP id z16mr4503578oic.128.1642619885580;
 Wed, 19 Jan 2022 11:18:05 -0800 (PST)
MIME-Version: 1.0
References: <20220117150200.24953-1-cgzones@googlemail.com>
In-Reply-To: <20220117150200.24953-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 19 Jan 2022 14:17:54 -0500
Message-ID: <CAP+JOzRj5EY20ATmHhk2PsYOTabmBDRuxQKNYZtqgkU7ky-Ozg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: reject invalid roles before inverting
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 17, 2022 at 9:34 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Since the role datums have not been validated yet, they might be invalid
> and set to an enormous high value. Inverting such an ebitmap will take
> excessive amount of memory and time.
>
> Found by oss-fuzz (#43709)
> ---
>  libsepol/src/expand.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 898e6b87..3fc54af6 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -2481,6 +2481,10 @@ int role_set_expand(role_set_t * x, ebitmap_t * r,=
 policydb_t * out, policydb_t
>
>         /* if role is to be complimented, invert the entire bitmap here *=
/
>         if (x->flags & ROLE_COMP) {
> +               /* inverting an ebitmap with an invalid highbit will take=
 aeons */
> +               if (ebitmap_length(r) > p->p_roles.nprim)
> +                       return -1;
> +
>                 for (i =3D 0; i < ebitmap_length(r); i++) {
>                         if (ebitmap_get_bit(r, i)) {
>                                 if (ebitmap_set_bit(r, i, 0))
> --
> 2.34.1
>

One would think that ebitmap_length() would be the right function, but
actually it will return the highest position in the bitmap without
regard to whether it is set or not. Since the ebitmap has 64 bit
nodes, it will be a multiple of 64.

The function you want to use here is ebitmap_highest_set_bit().

Thanks,
Jim
