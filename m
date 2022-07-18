Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53923C433EF
	for <selinux@archiver.kernel.org>; Mon, 18 Jul 2022 20:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiGRUo4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Jul 2022 16:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbiGRUoy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Jul 2022 16:44:54 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54D42ED6E
        for <selinux@vger.kernel.org>; Mon, 18 Jul 2022 13:44:52 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso4095168otb.6
        for <selinux@vger.kernel.org>; Mon, 18 Jul 2022 13:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xWT+asmd+fz75oebuQUe3j8sXtV7j6xNUOAIs2Itx4E=;
        b=UxxOb9e8F/saO2qGKIi9iv8+MVX+yCg42PBvYu5ghh4doW0rP9u0gNzErl04lr98W1
         2oi+BKfghER/7Cg5O1gOYjsZjpCW7STHBveJtfg1rFqFA4tMu5HZIvOMFbN5IXOUPA5t
         KReqAL/rOSzerdUI94K29pYjr3dXjO8QBqf5e9wooNHTvZsLXDyNtkqz0aNaNhhpiYIB
         WAXSHvbytCBkKQlH6rdzFLpOLqZuUEQsz9G3zdnSds0UZ08xMIbXc4SC2yTCNRXorMaU
         GRG4mmWTSQ69QMxAoiS5u1bVDMlQNVkmEDDpyUuFOHojK43gz2L7FcuZ4Cu27bKgVrGa
         saSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xWT+asmd+fz75oebuQUe3j8sXtV7j6xNUOAIs2Itx4E=;
        b=AUmVISJthUK6YzdiJngLH10jbR7Xrt0y+KfZQkpj9/h9kW3s5hSG0GdcnN0co++HNk
         4Ez10cTaTQt8daqBxIUJssKgx74c6a/9Psl5dvSNjxulnSywZO0aL8kgK1Qa85VOTcWY
         Y/38W+/xVfDkxbVzJtl6Bw53lo2Q0xda9C6uc/0KZK3uQEiL15oPEynPqP3buaO3TpyF
         u1W5jK57G7q8cPzReOwLmL6U2WMmzBxvgdqZeboH3c2gbvBkKqG49QHNP6zqQFIE9FBc
         eksWax4X07+ggvSResnsGIgVqRsAJhGLsYLVUmrNI6qX4rFqE1VKl/iaTc9PwJ06MsAN
         Ekew==
X-Gm-Message-State: AJIora9hvYDiARQJqQw3NsRN330g0PtqZuLyq8wN50gbPkBJKabll7m4
        cOYEgNg56AeSk7tc5zN6loiJpsJPuqreMFRDQzgcriL8Zdw=
X-Google-Smtp-Source: AGRyM1vc23bWB+gCfADkOhQBBCQfcAW47rDclu80uSq681njvD+gOZoOh87SVYs5yBriW+g3xH35wvFdDFKZZ9hs1QQ=
X-Received: by 2002:a05:6830:91d:b0:616:e98c:2581 with SMTP id
 v29-20020a056830091d00b00616e98c2581mr11731024ott.53.1658177092176; Mon, 18
 Jul 2022 13:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220712160858.22677-1-cgzones@googlemail.com> <20220712160858.22677-3-cgzones@googlemail.com>
In-Reply-To: <20220712160858.22677-3-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 18 Jul 2022 16:44:41 -0400
Message-ID: <CAP+JOzT+PZ0-0rm+SMVrFV-+Ccza25U28VtQkLmHO1Sj8-b8QQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] libsepol/cil: use ebitmap_init_range
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
> Especially in the case of __cil_permissionx_expr_range_to_bitmap_helper()
> it substitutes hundreds of thousand of calls to ebitmap_set_bit() during
> semodule(8) on a policy widely using extended permissions.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_post.c | 30 +++++++++---------------------
>  1 file changed, 9 insertions(+), 21 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index 714ce227..6e95225f 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -1191,7 +1191,6 @@ static int __cil_cat_expr_range_to_bitmap_helper(st=
ruct cil_list_item *i1, struc
>         struct cil_tree_node *n2 =3D d2->nodes->head->data;
>         struct cil_cat *c1 =3D (struct cil_cat *)d1;
>         struct cil_cat *c2 =3D (struct cil_cat *)d2;
> -       int i;
>
>         if (n1->flavor =3D=3D CIL_CATSET || n2->flavor =3D=3D CIL_CATSET)=
 {
>                 cil_log(CIL_ERR, "Category sets cannont be used in a cate=
gory range\n");
> @@ -1213,12 +1212,10 @@ static int __cil_cat_expr_range_to_bitmap_helper(=
struct cil_list_item *i1, struc
>                 goto exit;
>         }
>
> -       for (i =3D c1->value; i <=3D c2->value; i++) {
> -               if (ebitmap_set_bit(bitmap, i, 1)) {
> -                       cil_log(CIL_ERR, "Failed to set cat bit\n");
> -                       ebitmap_destroy(bitmap);
> -                       goto exit;
> -               }
> +       if (ebitmap_init_range(bitmap, c1->value, c2->value)) {
> +               cil_log(CIL_ERR, "Failed to set cat bit\n");
> +               ebitmap_destroy(bitmap);
> +               goto exit;
>         }
>
>         return SEPOL_OK;
> @@ -1234,7 +1231,6 @@ static int __cil_permissionx_expr_range_to_bitmap_h=
elper(struct cil_list_item *i
>         char *p2 =3D i2->data;
>         uint16_t v1;
>         uint16_t v2;
> -       uint32_t i;
>
>         rc =3D __cil_permx_str_to_int(p1, &v1);
>         if (rc !=3D SEPOL_OK) {
> @@ -1246,12 +1242,10 @@ static int __cil_permissionx_expr_range_to_bitmap=
_helper(struct cil_list_item *i
>                 goto exit;
>         }
>
> -       for (i =3D v1; i <=3D v2; i++) {
> -               if (ebitmap_set_bit(bitmap, i, 1)) {
> -                       cil_log(CIL_ERR, "Failed to set permissionx bit\n=
");
> -                       ebitmap_destroy(bitmap);
> -                       goto exit;
> -               }
> +       if (ebitmap_init_range(bitmap, v1, v2)) {
> +               cil_log(CIL_ERR, "Failed to set permissionx bits\n");
> +               ebitmap_destroy(bitmap);
> +               goto exit;
>         }
>
>         return SEPOL_OK;
> @@ -1318,9 +1312,7 @@ static int __cil_expr_to_bitmap(struct cil_list *ex=
pr, ebitmap_t *out, int max,
>                 enum cil_flavor op =3D (enum cil_flavor)(uintptr_t)curr->=
data;
>
>                 if (op =3D=3D CIL_ALL) {
> -                       ebitmap_init(&b1); /* all zeros */
> -                       rc =3D ebitmap_not(&tmp, &b1, max);
> -                       ebitmap_destroy(&b1);
> +                       rc =3D ebitmap_init_range(&tmp, 0, max - 1);
>                         if (rc !=3D SEPOL_OK) {
>                                 cil_log(CIL_INFO, "Failed to expand 'all'=
 operator\n");
>                                 ebitmap_destroy(&tmp);
> @@ -1328,19 +1320,15 @@ static int __cil_expr_to_bitmap(struct cil_list *=
expr, ebitmap_t *out, int max,
>                         }
>                 } else if (op =3D=3D CIL_RANGE) {
>                         if (flavor =3D=3D CIL_CAT) {
> -                               ebitmap_init(&tmp);
>                                 rc =3D __cil_cat_expr_range_to_bitmap_hel=
per(curr->next, curr->next->next, &tmp);
>                                 if (rc !=3D SEPOL_OK) {
>                                         cil_log(CIL_INFO, "Failed to expa=
nd category range\n");
> -                                       ebitmap_destroy(&tmp);
>                                         goto exit;
>                                 }
>                         } else if (flavor =3D=3D CIL_PERMISSIONX) {
> -                               ebitmap_init(&tmp);
>                                 rc =3D __cil_permissionx_expr_range_to_bi=
tmap_helper(curr->next, curr->next->next, &tmp);
>                                 if (rc !=3D SEPOL_OK) {
>                                         cil_log(CIL_INFO, "Failed to expa=
nd category range\n");
> -                                       ebitmap_destroy(&tmp);
>                                         goto exit;
>                                 }
>                         } else {
> --
> 2.36.1
>
