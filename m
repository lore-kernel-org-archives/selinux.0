Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF4BC433EF
	for <selinux@archiver.kernel.org>; Mon, 18 Jul 2022 20:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiGRUsu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Jul 2022 16:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiGRUst (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Jul 2022 16:48:49 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8166BFF
        for <selinux@vger.kernel.org>; Mon, 18 Jul 2022 13:48:47 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id c203-20020a4a4fd4000000b0043566a4e265so2528319oob.2
        for <selinux@vger.kernel.org>; Mon, 18 Jul 2022 13:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eW4BUMl3rB6ORHSQ8ZHFQ96GFEASBQFwOaSOetLhbCY=;
        b=gSgwRuaaszCVjjr99MiEHA0eDNgnMocIJUMfj9lqnYvoLQXFN5VcG9m0/rn1BmD8+P
         MbXfJJdE5hCkPjI+5rap+14vVUZH+XeGAwLXnEZsWem5kqG32v/xkeSHooogqFv/l16x
         O1lnKZfZ6JaeAmow+jVshqJdgFPwHQoKgJ0KZRaUNAoCvH3VT73raNNCZcKMKQPilkp+
         Hc41xMO5iGwAidg9wuL4P8gmECxY8wkhgvRDcA/RUZfSycLaLYOkTlrNkng2wFUNM0S1
         5ZGNl0W6/qLvX48D3ofXiZWBIUrAdyXiW0XcalsHrR8ZFFsKabyJbj38IfulnWO9GcWI
         4IPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eW4BUMl3rB6ORHSQ8ZHFQ96GFEASBQFwOaSOetLhbCY=;
        b=BoDriPKhRMaYrAoWtZZ8po7VVg2BIyj9OSJ0DImFATw7cUUphVULq81p9CahgdWbPz
         aAPvbWpTHw3TN9lHI9tHdlNDbTP4unTDxzATcUffrzCaO8PLX/PdY8ScVT7uHzHn8m+q
         UrOrvjVdkVLq7/CRn01FrIVkL4Wncsz9jakOAcknQzrJAYpwPODRIfQHJDhx7OYL6efz
         lyiVz5Nw46DmQ1o6UOZM20h9R765Et+a3FpSbSi2FdQPKGogCUBmGW4KajR1+lM8E/wC
         N0Gjb9iryi+JgTDfBe5MkkJT3+DFZwYsVTWJ6Buw9vu3pxW1exNh6u/y/cc1js76oMjL
         txfA==
X-Gm-Message-State: AJIora/rE/udA8EV/Zr5MB5UqgEUeNeZSIs9x0JXor0QC+Tl0O6matXP
        1Y7x6tdbIKJgyz+RQ3WNsyef5Cq7SH3L3dUZHH8=
X-Google-Smtp-Source: AGRyM1t1589Hpob+QKKRRv7brhMlNJvjhv5zAI3FpMRWZmQqTm7WXtzSML9kBnOHMgeXABddzxb0vFzFI5kcdbk9gkk=
X-Received: by 2002:a4a:9731:0:b0:35e:fd1a:d452 with SMTP id
 u46-20020a4a9731000000b0035efd1ad452mr10186212ooi.8.1658177327228; Mon, 18
 Jul 2022 13:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220712160858.22677-1-cgzones@googlemail.com> <20220712160858.22677-7-cgzones@googlemail.com>
In-Reply-To: <20220712160858.22677-7-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 18 Jul 2022 16:48:36 -0400
Message-ID: <CAP+JOzRUwmXB0dmcPsHZC3mD0qcS5P2=OkfErhUyXpnoceTvwA@mail.gmail.com>
Subject: Re: [PATCH 7/7] libsepol: skip superfluous memset calls in ebitmap operations
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 12, 2022 at 12:09 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The three members of struct ebitmap_node are all unconditionally
> initialized.  Hinder compilers to optimize malloc() and memset() into
> calloc(), which might be slightly slower.  Especially affects
> ebitmap_or().
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/ebitmap.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> index e0541abb..d0f7daba 100644
> --- a/libsepol/src/ebitmap.c
> +++ b/libsepol/src/ebitmap.c
> @@ -31,7 +31,6 @@ int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, c=
onst ebitmap_t * e2)
>                         ebitmap_destroy(dst);
>                         return -ENOMEM;
>                 }
> -               memset(new, 0, sizeof(ebitmap_node_t));
>                 if (n1 && n2 && n1->startbit =3D=3D n2->startbit) {
>                         new->startbit =3D n1->startbit;
>                         new->map =3D n1->map | n2->map;
> @@ -289,7 +288,6 @@ int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * sr=
c)
>                         ebitmap_destroy(dst);
>                         return -ENOMEM;
>                 }
> -               memset(new, 0, sizeof(ebitmap_node_t));
>                 new->startbit =3D n->startbit;
>                 new->map =3D n->map;
>                 new->next =3D 0;
> @@ -429,7 +427,6 @@ int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, =
int value)
>         new =3D (ebitmap_node_t *) malloc(sizeof(ebitmap_node_t));
>         if (!new)
>                 return -ENOMEM;
> -       memset(new, 0, sizeof(ebitmap_node_t));
>
>         new->startbit =3D startbit;
>         new->map =3D (MAPBIT << (bit - new->startbit));
> --
> 2.36.1
>
