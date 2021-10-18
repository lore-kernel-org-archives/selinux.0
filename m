Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ECBC433EF
	for <selinux@archiver.kernel.org>; Mon, 18 Oct 2021 19:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 159F461038
	for <selinux@archiver.kernel.org>; Mon, 18 Oct 2021 19:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhJRUAi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Oct 2021 16:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhJRUAi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Oct 2021 16:00:38 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1679AC06161C
        for <selinux@vger.kernel.org>; Mon, 18 Oct 2021 12:58:27 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so1231610ote.8
        for <selinux@vger.kernel.org>; Mon, 18 Oct 2021 12:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9IIYG5FWGEJpZ+7Bwy8IPFlRaJEPPJuXVPkjXqC4atw=;
        b=NDYd/2JqatCHOE7CudI5KHnoZIk8D+0/9HyO7YrR4v7+aD7CTDMvdvERbEvGEIBJXb
         c38m6V21z2pXYGKtooz7iYKFXuci7hOFYGQRWIvf20uNGMyYapxpkRSWdfvCI7xU4Yb0
         ukCox5v06D3zCtTIUYXNZH45JUbMx1/iH3GHTz3Uv9Ir+Ybjn6O1EwQKJv5VWGNTUNDW
         +ElssjQ7hs12bM7B7Y5mcwtWfzRNq59mEFT8wPhmiN2vh9zYZJ9dvhdNIpvxv1V8cHyJ
         9FJ0NUu+65Ot5supKE0khfMUv1WE/bykFQFmuXpei8cXM4fFvKT1DMhrOHkX6LKvlzAw
         89OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9IIYG5FWGEJpZ+7Bwy8IPFlRaJEPPJuXVPkjXqC4atw=;
        b=Ky5p+kiSpFOfUSqpj8jeDrhJgHg4Zdb+WoAbVSpfvKmVnQP6k3c3Ag1swceo7WDGCZ
         fH/U2UhoktqIFXbmmp5ZjQvECyJflNpr2+qcuiogQZrBbiD4R8neBjj76PkWiykHLLbB
         UhzoIY19GcwVsSn0yR2X+bq/3Z59hvViWaAHBHZ60PtZLubMj2yjRNIPfyoGHR3DUN4p
         P+IwldXINSY/dcdQahiNo2SE6yPZcvtIE0FTVX3SjEb9D7GcsbdatXjUVG8y0meAMI2I
         LTaeHlNrfk6sw4Q6FDKMm0REgtwXy/aRw/+EQXIiWkZkh1DM6NOyIwR+qZRA2QNLcApi
         U8Fg==
X-Gm-Message-State: AOAM530hToZvtbRfHZjASCbPMLCmwrnAa6yYPFnkg62iAiHA31v67HUK
        6pZfhPA0Lp0H3OWVJqB8HI27lhHLkSwI3Td652M=
X-Google-Smtp-Source: ABdhPJxAdEJQDUa/UxyB910rfGqPOG6U+u3rlwdF/S+k/z2abbeWfuSKjSGgB22HNoO+E0ys+Hb46UjNVJEeXUxTIK0=
X-Received: by 2002:a9d:7182:: with SMTP id o2mr1612737otj.53.1634587106434;
 Mon, 18 Oct 2021 12:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211011162533.53404-1-cgzones@googlemail.com> <20211011162533.53404-16-cgzones@googlemail.com>
In-Reply-To: <20211011162533.53404-16-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 18 Oct 2021 15:58:15 -0400
Message-ID: <CAP+JOzTVuL77xhEnn2nwBL-1cpZUOPkEnGAzXh3uGBTasyLixA@mail.gmail.com>
Subject: Re: [RFC PATCH 15/35] libsepol: reject invalid default targets
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 11, 2021 at 12:41 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Reject loading a policy with invalid default targets so that all
> following code, e.g. the different output modes, do not need to handle
> unsupported ones.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/policydb.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 980af059..5e8b4a3f 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -2313,8 +2313,37 @@ static int class_read(policydb_t * p, hashtab_t h,=
 struct policy_file *fp)
>                 if (rc < 0)
>                         goto bad;
>                 cladatum->default_user =3D le32_to_cpu(buf[0]);
> +               switch (cladatum->default_user) {
> +               case 0:
> +               case DEFAULT_SOURCE:
> +               case DEFAULT_TARGET:
> +                       break;
> +               default:
> +                       goto bad;
> +               }
>                 cladatum->default_role =3D le32_to_cpu(buf[1]);
> +               switch (cladatum->default_role) {
> +               case 0:
> +               case DEFAULT_SOURCE:
> +               case DEFAULT_TARGET:
> +                       break;
> +               default:
> +                       goto bad;
> +               }
>                 cladatum->default_range =3D le32_to_cpu(buf[2]);
> +               switch (cladatum->default_range) {
> +               case 0:
> +               case DEFAULT_SOURCE_LOW:
> +               case DEFAULT_SOURCE_HIGH:
> +               case DEFAULT_SOURCE_LOW_HIGH:
> +               case DEFAULT_TARGET_LOW:
> +               case DEFAULT_TARGET_HIGH:
> +               case DEFAULT_TARGET_LOW_HIGH:
> +               case DEFAULT_GLBLUB:
> +                       break;
> +               default:
> +                       goto bad;
> +               }
>         }
>
>         if ((p->policy_type =3D=3D POLICY_KERN &&
> @@ -2325,6 +2354,14 @@ static int class_read(policydb_t * p, hashtab_t h,=
 struct policy_file *fp)
>                 if (rc < 0)
>                         goto bad;
>                 cladatum->default_type =3D le32_to_cpu(buf[0]);
> +               switch (cladatum->default_type) {
> +               case 0:
> +               case DEFAULT_SOURCE:
> +               case DEFAULT_TARGET:
> +                       break;
> +               default:
> +                       goto bad;
> +               }
>         }
>
>         if (hashtab_insert(h, key, cladatum))
> --
> 2.33.0
>

Same comment as for patch 14, I would like to see this in
policydb_validate.c and checked when validating the policydb.

Thanks,
Jim
