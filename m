Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639E5C4743C
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41AE36108E
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFUU6Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFUU6Z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 16:58:25 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6FBC061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:56:09 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id f3-20020a0568301c23b029044ce5da4794so12517835ote.11
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TrZTfmoFPlpB/8g/mtu3rz4ibYUTCVQG5S/zygTca8w=;
        b=Kr/BC9O+z4NSIw5cav578xl3HsPTlMXp9QybAWlco9HEsdIn/atnjZ6qeb5l832f6X
         ANujD730qzK/Tr7cO8P6nS6moej+a0Np9niPFr+0sQmtHZtuOM0TJaearJYeOdAMIFjr
         nxk1FF5oxSwFPJQ2Nb2LV9Rvtv1VxEcxF0oeZJetdm2CaIT2LVFrXp65+ykQWsTUvAjL
         /OzVjFbL1l4krCbateTtMLcnwo+qMp0RtddPYC7cUWLR3F7XH0GnI37CeWFEc1n1Gw2y
         BWwmdRWVybOFB1BRoANk2HHzNxpZd1oziXY7k5KbYIltcpoJcKfWlUGS9pptqqwSQDJb
         qNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TrZTfmoFPlpB/8g/mtu3rz4ibYUTCVQG5S/zygTca8w=;
        b=KQ71vrevCfUdaun9CIMwQSpSl0iRddcVyCD8lcB/+PhExm8zDXAVHk/5x00Jyzv11K
         WMjoNCwEdyKcmuN3XBcUE300fgms8vhPGD/oMe3b0qkboB+d88Q9uimBerA7HY4ldsfZ
         ESLmoKgEphn5wwB3QwV41/124/5kiphci5pn/Qgb9Lk3+FXr6neFUf5fP2/sNi37OH9E
         rWflzgzAzZVNDDZh843iAySMPeBVJ6xO0Y4HnhS4mT+bA4LTNs9Bq/tyAfugE2j/ZaGy
         ZzJU5LEWw1BkT8sRh1hfbfqSoFU461f1zyzW0QNPrATHVyKTRxNkPpIaPSMto/2IvkZN
         R6FQ==
X-Gm-Message-State: AOAM532ScDWO55FMTAqVtQE+vB+d1wLISvlOZ6aXvEx/RHS7AdeEw8d0
        B5S7UPosx3SWErbBqJwvLc25iLi661sliqVLin4=
X-Google-Smtp-Source: ABdhPJwNfP6Z0JjNTqcir9PgiGLXWdOMJRRq5eOolTiUxtiGMnY24RXhZk4x395JLo1sbFlEh4elIS3jjPMUtutlqDU=
X-Received: by 2002:a05:6830:411e:: with SMTP id w30mr319242ott.293.1624308968895;
 Mon, 21 Jun 2021 13:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-11-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-11-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Jun 2021 16:55:57 -0400
Message-ID: <CAP+JOzT0f+M2KS2Qnm0ZJ_LA9A35fx8HP=eCMF_FgVZiRBuHTA@mail.gmail.com>
Subject: Re: [PATCH 10/23] libsepol: mark read-only parameters of ebitmap
 interfaces const
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 12:01 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Make it more obvious which parameters are read-only and not being
> modified and allow callers to pass const pointers.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/include/sepol/policydb/ebitmap.h | 16 ++++++++--------
>  libsepol/src/ebitmap.c                    | 18 +++++++++---------
>  2 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/libsepol/include/sepol/policydb/ebitmap.h b/libsepol/include=
/sepol/policydb/ebitmap.h
> index 634436f6..81d0c7a6 100644
> --- a/libsepol/include/sepol/policydb/ebitmap.h
> +++ b/libsepol/include/sepol/policydb/ebitmap.h
> @@ -67,7 +67,7 @@ static inline unsigned int ebitmap_next(ebitmap_node_t =
** n, unsigned int bit)
>         return (bit + 1);
>  }
>
> -static inline int ebitmap_node_get_bit(ebitmap_node_t * n, unsigned int =
bit)
> +static inline int ebitmap_node_get_bit(const ebitmap_node_t * n, unsigne=
d int bit)
>  {
>         if (n->map & (MAPBIT << (bit - n->startbit)))
>                 return 1;
> @@ -83,18 +83,18 @@ static inline int ebitmap_node_get_bit(ebitmap_node_t=
 * n, unsigned int bit)
>  extern int ebitmap_cmp(const ebitmap_t * e1, const ebitmap_t * e2);
>  extern int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebitm=
ap_t * e2);
>  extern int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1);
> -extern int ebitmap_and(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2);
> -extern int ebitmap_xor(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2);
> -extern int ebitmap_not(ebitmap_t *dst, ebitmap_t *e1, unsigned int maxbi=
t);
> -extern int ebitmap_andnot(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2, =
unsigned int maxbit);
> -extern unsigned int ebitmap_cardinality(ebitmap_t *e1);
> -extern int ebitmap_hamming_distance(ebitmap_t * e1, ebitmap_t * e2);
> +extern int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitma=
p_t *e2);
> +extern int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *e1, const ebitma=
p_t *e2);
> +extern int ebitmap_not(ebitmap_t *dst, const ebitmap_t *e1, unsigned int=
 maxbit);
> +extern int ebitmap_andnot(ebitmap_t *dst, const ebitmap_t *e1, const ebi=
tmap_t *e2, unsigned int maxbit);
> +extern unsigned int ebitmap_cardinality(const ebitmap_t *e1);
> +extern int ebitmap_hamming_distance(const ebitmap_t * e1, const ebitmap_=
t * e2);
>  extern int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * src);
>  extern int ebitmap_contains(const ebitmap_t * e1, const ebitmap_t * e2);
>  extern int ebitmap_match_any(const ebitmap_t *e1, const ebitmap_t *e2);
>  extern int ebitmap_get_bit(const ebitmap_t * e, unsigned int bit);
>  extern int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value);
> -extern unsigned int ebitmap_highest_set_bit(ebitmap_t * e);
> +extern unsigned int ebitmap_highest_set_bit(const ebitmap_t * e);
>  extern void ebitmap_destroy(ebitmap_t * e);
>  extern int ebitmap_read(ebitmap_t * e, void *fp);
>
> diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> index 522e14a6..4e9acdf8 100644
> --- a/libsepol/src/ebitmap.c
> +++ b/libsepol/src/ebitmap.c
> @@ -71,7 +71,7 @@ int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1=
)
>         return 0;
>  }
>
> -int ebitmap_and(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2)
> +int ebitmap_and(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2=
)
>  {
>         unsigned int i, length =3D min(ebitmap_length(e1), ebitmap_length=
(e2));
>         ebitmap_init(dst);
> @@ -85,7 +85,7 @@ int ebitmap_and(ebitmap_t *dst, ebitmap_t *e1, ebitmap_=
t *e2)
>         return 0;
>  }
>
> -int ebitmap_xor(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2)
> +int ebitmap_xor(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t *e2=
)
>  {
>         unsigned int i, length =3D max(ebitmap_length(e1), ebitmap_length=
(e2));
>         ebitmap_init(dst);
> @@ -98,7 +98,7 @@ int ebitmap_xor(ebitmap_t *dst, ebitmap_t *e1, ebitmap_=
t *e2)
>         return 0;
>  }
>
> -int ebitmap_not(ebitmap_t *dst, ebitmap_t *e1, unsigned int maxbit)
> +int ebitmap_not(ebitmap_t *dst, const ebitmap_t *e1, unsigned int maxbit=
)
>  {
>         unsigned int i;
>         ebitmap_init(dst);
> @@ -111,7 +111,7 @@ int ebitmap_not(ebitmap_t *dst, ebitmap_t *e1, unsign=
ed int maxbit)
>         return 0;
>  }
>
> -int ebitmap_andnot(ebitmap_t *dst, ebitmap_t *e1, ebitmap_t *e2, unsigne=
d int maxbit)
> +int ebitmap_andnot(ebitmap_t *dst, const ebitmap_t *e1, const ebitmap_t =
*e2, unsigned int maxbit)
>  {
>         int rc;
>         ebitmap_t e3;
> @@ -126,10 +126,10 @@ int ebitmap_andnot(ebitmap_t *dst, ebitmap_t *e1, e=
bitmap_t *e2, unsigned int ma
>         return 0;
>  }
>
> -unsigned int ebitmap_cardinality(ebitmap_t *e1)
> +unsigned int ebitmap_cardinality(const ebitmap_t *e1)
>  {
>         unsigned int count =3D 0;
> -       ebitmap_node_t *n;
> +       const ebitmap_node_t *n;
>
>         for (n =3D e1->node; n; n =3D n->next) {
>                 count +=3D __builtin_popcountll(n->map);
> @@ -137,7 +137,7 @@ unsigned int ebitmap_cardinality(ebitmap_t *e1)
>         return count;
>  }
>
> -int ebitmap_hamming_distance(ebitmap_t * e1, ebitmap_t * e2)
> +int ebitmap_hamming_distance(const ebitmap_t * e1, const ebitmap_t * e2)
>  {
>         int rc;
>         ebitmap_t tmp;
> @@ -347,9 +347,9 @@ int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, =
int value)
>         return 0;
>  }
>
> -unsigned int ebitmap_highest_set_bit(ebitmap_t * e)
> +unsigned int ebitmap_highest_set_bit(const ebitmap_t * e)
>  {
> -       ebitmap_node_t *n;
> +       const ebitmap_node_t *n;
>         MAPTYPE map;
>         unsigned int pos =3D 0;
>
> --
> 2.32.0
>
