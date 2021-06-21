Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AF4C4743C
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 21:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C2FB61245
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 21:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhFUVCl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhFUVCk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 17:02:40 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C101C061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 14:00:25 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u11so21370509oiv.1
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 14:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2wMWwc5JY8sbX2BbX0t/BYsseNKykyld49l8+wyb1Fg=;
        b=YYun/Iya+LxPYNPcT5gEpVusNlmFDpg2sjHo+H3YX0asWXv/I1diEYfctNoGowNs04
         Gfitq6hV1WuFrCMwurvcXkiU4YRIpOgKNqNFPXWZ46A0/Pw5ESy7sMnNchR+TTZxVgtZ
         7NbuOhnRXhvQGjMGlG4jX7avWRTc6QOoCV2u1j1vkRaqyzIfFoklqgiUTkdkqWyPK4px
         jAxCzqMjM/7gKnT9gLeqGu3XRX4RdipNv8AUndjYNT5HOTGKj6Sl0IOHvrkmub08ctD5
         LAcERVYBmBmhDqBbQa4AWf/fE+tVjRwzKfT6w01fg/ryptPTZ0Z7g0Kp92IZwWK7mGYM
         sfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2wMWwc5JY8sbX2BbX0t/BYsseNKykyld49l8+wyb1Fg=;
        b=EBkqQ0PKPPiW8qNGPlyFNAQdsPzyXne/V4B7q+qYXtt4T4BvwzzFxB6kHCfZ02Ff6R
         k+LHZOYYK3nfeqFkzC3qhHOCV4CId6v/sxloVT+jhCJL7vkXLAScYUo5A1v8zM0ObYqH
         oygvqUVX+QKPCa/KSids6xrxAn8NHFuZixHfmlOraFpDUETiJBncf0jjtWoFwByG/eTP
         HNV2CS7OxoGlgLg5/km6rkPEIih8BEraHcbSuGpUQJQUP/m3limcqbTdfs6qBc2ZBW0C
         IoAx0js5E/1FO5Rf08oq6q0H603d35QgLBMw67gWwhT9Xhwiv8F5u9ffa5q6xyHOwl19
         PoEw==
X-Gm-Message-State: AOAM532e1E5KvwIorgHTQQx8GUKQeYqn1YOrmuMwk+siRPaZLEKIhJnu
        L0UBCVdfapNzAR+Y1qcOLmtVclBxG259AUBGydI=
X-Google-Smtp-Source: ABdhPJzBQJ5T4KglR0PHWdAQfqW46avI9EP/QaJaaKvqcVg7FGTvar9uVDTDQizG+TMOQbQaH2vSyEVW9B66eyHUz68=
X-Received: by 2002:aca:d5cd:: with SMTP id m196mr296074oig.138.1624309224821;
 Mon, 21 Jun 2021 14:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-20-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-20-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Jun 2021 17:00:14 -0400
Message-ID: <CAP+JOzS4kznzpVC3rBuzi=A0ZGsY4gFAhZOKc+oJ9Fwp9hLkjw@mail.gmail.com>
Subject: Re: [PATCH 19/23] libsepol/cil: avoid using maybe uninitialized variables
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 12:02 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Initialize variables, as they are set after goto statements, which jump
> to cleanup code using them.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_binary.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index 601fe8d1..54d13f2f 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -1073,7 +1073,7 @@ int __cil_type_rule_to_avtab(policydb_t *pdb, const=
 struct cil_db *db, struct ci
>         type_datum_t *sepol_src =3D NULL;
>         type_datum_t *sepol_tgt =3D NULL;
>         class_datum_t *sepol_obj =3D NULL;
> -       struct cil_list *class_list;
> +       struct cil_list *class_list =3D NULL;
>         type_datum_t *sepol_result =3D NULL;
>         ebitmap_t src_bitmap, tgt_bitmap;
>         ebitmap_node_t *node1, *node2;
> @@ -1129,7 +1129,7 @@ int __cil_typetransition_to_avtab(policydb_t *pdb, =
const struct cil_db *db, stru
>         type_datum_t *sepol_src =3D NULL;
>         type_datum_t *sepol_tgt =3D NULL;
>         class_datum_t *sepol_obj =3D NULL;
> -       struct cil_list *class_list;
> +       struct cil_list *class_list =3D NULL;
>         type_datum_t *sepol_result =3D NULL;
>         ebitmap_t src_bitmap, tgt_bitmap;
>         ebitmap_node_t *node1, *node2;
> @@ -2338,7 +2338,7 @@ int cil_roletrans_to_policydb(policydb_t *pdb, cons=
t struct cil_db *db, struct c
>         role_datum_t *sepol_src =3D NULL;
>         type_datum_t *sepol_tgt =3D NULL;
>         class_datum_t *sepol_obj =3D NULL;
> -       struct cil_list *class_list;
> +       struct cil_list *class_list =3D NULL;
>         role_datum_t *sepol_result =3D NULL;
>         role_trans_t *new =3D NULL;
>         uint32_t *new_role =3D NULL;
> @@ -3166,7 +3166,7 @@ int cil_rangetransition_to_policydb(policydb_t *pdb=
, const struct cil_db *db, st
>         type_datum_t *sepol_src =3D NULL;
>         type_datum_t *sepol_tgt =3D NULL;
>         class_datum_t *sepol_class =3D NULL;
> -       struct cil_list *class_list;
> +       struct cil_list *class_list =3D NULL;
>         range_trans_t *newkey =3D NULL;
>         struct mls_range *newdatum =3D NULL;
>         ebitmap_t src_bitmap, tgt_bitmap;
> @@ -3603,7 +3603,7 @@ int cil_default_to_policydb(policydb_t *pdb, struct=
 cil_default *def)
>  {
>         struct cil_list_item *curr;
>         class_datum_t *sepol_class;
> -       struct cil_list *class_list;
> +       struct cil_list *class_list =3D NULL;
>
>         cil_list_for_each(curr, def->class_datums) {
>                 struct cil_list_item *c;
> @@ -3658,7 +3658,7 @@ int cil_defaultrange_to_policydb(policydb_t *pdb, s=
truct cil_defaultrange *def)
>  {
>         struct cil_list_item *curr;
>         class_datum_t *sepol_class;
> -       struct cil_list *class_list;
> +       struct cil_list *class_list =3D NULL;
>
>         cil_list_for_each(curr, def->class_datums) {
>                 struct cil_list_item *c;
> --
> 2.32.0
>
