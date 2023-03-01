Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7A5C64ED6
	for <selinux@archiver.kernel.org>; Wed,  1 Mar 2023 14:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCAOa6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Mar 2023 09:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCAOaz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Mar 2023 09:30:55 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119343BD88
        for <selinux@vger.kernel.org>; Wed,  1 Mar 2023 06:30:54 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u9so5071510edd.2
        for <selinux@vger.kernel.org>; Wed, 01 Mar 2023 06:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677681052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMDQXAx6QNgexRR+4hYrNueQJK9bkbYwb1Y3tsvLCWM=;
        b=a/+o4zGX2z7Ec+/HFMJBgUOeIFflEEDAsYcRZ0Y9SQ+81cTo0Xbr4t8JlZmCJgO1gA
         cnAKsGuFy9SjrrSEuN+ncfemN41kcLjfrFre+eu04nriThlfGlC4BVCWmVqZPUZH3pFM
         laXiktbB7+qoU58dK1jaLfGNKBvtdGBnRAAYYpccELw4603teWq8UVoGZzLoCoHBjrqr
         d9+yfdRhtYV6mD7SCjCks2JNJNILpx+8BK84pGvZsBCn8v7v84ehZzwG98n4dWmA/pvf
         Tvyl8Kn15Ri1DR6n5WUHicXqpsAwFsqks67i2I2rifS1T6hwJ3ToyL6nscQ1fsTXb8FX
         XgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677681052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMDQXAx6QNgexRR+4hYrNueQJK9bkbYwb1Y3tsvLCWM=;
        b=u2utOvrFpSnLWvG7Yp7wqtWkRLIDfElUHpApgX+WXjMIuOjHJYNP5xF8rLr/2j8978
         5DzQKlmPczG/sGP4owwCQXY4iS9N0qXjlMl7XSk0l9OlyHvoJ6+9/JMgeBw1DXZABMB5
         VOz6czXXTrWchQwHwatCS4D3ssfj5iUHBcj4jzFOrcG2drVW5NRRY6eBgdk7OIpNf7mC
         Ga3Id9D2iWEV6tWxssIdVO6E8ly6F6XW9Z7np/u1d1T+rFQpo2hFD1RbjLi5R57N7XQS
         Rtx7yKvYitOUbXvo6Q6UfTFhU7aGtCFsfkvIXiyTVV0pHDrUz8J+xbJTUbeh9tBwieJW
         4iYg==
X-Gm-Message-State: AO0yUKU7/C/+A1KTiN/W9JOxCU5+YkkxyXdijwaFtjHLlcVjzq1FHHmC
        gk/dybbpEvhk2IvnIChSGKtYD4t2HV3jpUuNBg1WwWZXZsc=
X-Google-Smtp-Source: AK7set9AFa7T+Sv2YpDRlnMzmuRHKKZ/V17o6x27YHegZD46Hs3tXzIRyerN3/gcD9PYPH15uhF0GO7LiTUHdtiS6k8=
X-Received: by 2002:a17:906:d7a6:b0:87b:dce7:c245 with SMTP id
 pk6-20020a170906d7a600b0087bdce7c245mr3123844ejb.3.1677681052365; Wed, 01 Mar
 2023 06:30:52 -0800 (PST)
MIME-Version: 1.0
References: <20221125154952.20910-1-cgzones@googlemail.com> <20221125154952.20910-2-cgzones@googlemail.com>
In-Reply-To: <20221125154952.20910-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 1 Mar 2023 09:30:41 -0500
Message-ID: <CAP+JOzSuwKTFXp9HGWYN_tcB+EbRbaSgY3JiNHjzuvoLDkA1Kg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/6] libsepol: Add not self support for neverallow rules
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 25, 2022 at 10:51=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add not self support for neverallow rules.
>
> Example 1
>   allow TYPE1 TYPE1 : CLASS1 PERM1; # Rule 1
>   allow TYPE1 TYPE2 : CLASS1 PERM1; # Rule 2
>   neverallow TYPE1 ~self : CLASS1 PERM1;
>
> Rule 1 is not a violation of the neverallow. Rule 2 is.
>
> Example 2
>   allow TYPE1 TYPE1 : CLASS2 PERM2; # Rule 1
>   allow TYPE1 TYPE2 : CLASS2 PERM2; # Rule 2
>   allow TYPE1 TYPE3 : CLASS2 PERM2; # Rule 3
>   neverallow ATTR1 { ATTR2 -self } : CLASS2 PERM2;
>
> Assuming TYPE1 has attribute ATTR1 and TYPE1 and TYPE2 have
> attribute ATTR2, then rule 1 and 3 are not violations of the
> neverallow while rule 2 is. Rule 3 is not a violation because
> TYPE3 does not have attribute ATTR2.
>
> Adopted improvements from James Carter <jwcart2@gmail.com>
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/include/sepol/policydb/policydb.h |   3 +-
>  libsepol/src/assertion.c                   | 144 +++++++++++++++++----
>  libsepol/src/policydb_validate.c           |   9 ++
>  3 files changed, 129 insertions(+), 27 deletions(-)
>
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
> index ef1a014a..b014b7a8 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -285,7 +285,8 @@ typedef struct avrule {
>  #define AVRULE_XPERMS  (AVRULE_XPERMS_ALLOWED | AVRULE_XPERMS_AUDITALLOW=
 | \
>                                 AVRULE_XPERMS_DONTAUDIT | AVRULE_XPERMS_N=
EVERALLOW)
>         uint32_t specified;
> -#define RULE_SELF 1
> +#define RULE_SELF       (1U << 0)
> +#define RULE_NOTSELF    (1U << 1)
>         uint32_t flags;
>         type_set_t stypes;
>         type_set_t ttypes;
> diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
> index 161874c3..11185253 100644
> --- a/libsepol/src/assertion.c
> +++ b/libsepol/src/assertion.c
> @@ -223,6 +223,7 @@ static int report_assertion_avtab_matches(avtab_key_t=
 *k, avtab_datum_t *d, void
>         ebitmap_node_t *snode, *tnode;
>         unsigned int i, j;
>         const int is_avrule_self =3D (avrule->flags & RULE_SELF) !=3D 0;
> +       const int is_avrule_notself =3D (avrule->flags & RULE_NOTSELF) !=
=3D 0;
>
>         if ((k->specified & AVTAB_ALLOWED) =3D=3D 0)
>                 return 0;
> @@ -242,19 +243,31 @@ static int report_assertion_avtab_matches(avtab_key=
_t *k, avtab_datum_t *d, void
>         if (ebitmap_is_empty(&src_matches))
>                 goto exit;
>
> -       rc =3D ebitmap_and(&tgt_matches, &avrule->ttypes.types, &p->attr_=
type_map[k->target_type -1]);
> -       if (rc < 0)
> -               goto oom;
> -
> -       if (is_avrule_self) {
> -               rc =3D ebitmap_and(&self_matches, &src_matches, &p->attr_=
type_map[k->target_type - 1]);
> +       if (is_avrule_notself) {
> +               if (ebitmap_is_empty(&avrule->ttypes.types)) {
> +                       /* avrule tgt is of the form ~self */
> +                       rc =3D ebitmap_cpy(&tgt_matches, &p->attr_type_ma=
p[k->target_type -1]);
> +               } else {
> +                       /* avrule tgt is of the form {ATTR -self} */
> +                       rc =3D ebitmap_and(&tgt_matches, &avrule->ttypes.=
types, &p->attr_type_map[k->target_type - 1]);
> +               }
> +               if (rc)
> +                       goto oom;
> +       } else {
> +               rc =3D ebitmap_and(&tgt_matches, &avrule->ttypes.types, &=
p->attr_type_map[k->target_type -1]);
>                 if (rc < 0)
>                         goto oom;
>
> -               if (!ebitmap_is_empty(&self_matches)) {
> -                       rc =3D ebitmap_union(&tgt_matches, &self_matches)=
;
> +               if (is_avrule_self) {
> +                       rc =3D ebitmap_and(&self_matches, &src_matches, &=
p->attr_type_map[k->target_type - 1]);
>                         if (rc < 0)
>                                 goto oom;
> +
> +                       if (!ebitmap_is_empty(&self_matches)) {
> +                               rc =3D ebitmap_union(&tgt_matches, &self_=
matches);
> +                               if (rc < 0)
> +                                       goto oom;
> +                       }
>                 }
>         }
>
> @@ -272,6 +285,8 @@ static int report_assertion_avtab_matches(avtab_key_t=
 *k, avtab_datum_t *d, void
>                         ebitmap_for_each_positive_bit(&tgt_matches, tnode=
, j) {
>                                 if (is_avrule_self && i !=3D j)
>                                         continue;
> +                               if (is_avrule_notself && i =3D=3D j)
> +                                       continue;
>                                 if (avrule->specified =3D=3D AVRULE_XPERM=
S_NEVERALLOW) {
>                                         a->errors +=3D report_assertion_e=
xtended_permissions(handle,p, avrule,
>                                                                          =
               i, j, cp, perms, k, avtab);
> @@ -383,6 +398,7 @@ static int check_assertion_extended_permissions(avrul=
e_t *avrule, avtab_t *avtab
>         unsigned int i, j;
>         ebitmap_node_t *snode, *tnode;
>         const int is_avrule_self =3D (avrule->flags & RULE_SELF) !=3D 0;
> +       const int is_avrule_notself =3D (avrule->flags & RULE_NOTSELF) !=
=3D 0;
>         int rc;
>
>         ebitmap_init(&src_matches);
> @@ -399,20 +415,31 @@ static int check_assertion_extended_permissions(avr=
ule_t *avrule, avtab_t *avtab
>                 goto exit;
>         }
>
> -       rc =3D ebitmap_and(&tgt_matches, &avrule->ttypes.types,
> -                        &p->attr_type_map[k->target_type -1]);
> -       if (rc < 0)
> -               goto oom;
> -
> -       if (is_avrule_self) {
> -               rc =3D ebitmap_and(&self_matches, &src_matches, &p->attr_=
type_map[k->target_type - 1]);
> +       if (is_avrule_notself) {
> +               if (ebitmap_is_empty(&avrule->ttypes.types)) {
> +                       /* avrule tgt is of the form ~self */
> +                       rc =3D ebitmap_cpy(&tgt_matches, &p->attr_type_ma=
p[k->target_type -1]);
> +               } else {
> +                       /* avrule tgt is of the form {ATTR -self} */
> +                       rc =3D ebitmap_and(&tgt_matches, &avrule->ttypes.=
types, &p->attr_type_map[k->target_type - 1]);
> +               }
> +               if (rc < 0)
> +                       goto oom;
> +       } else {
> +               rc =3D ebitmap_and(&tgt_matches, &avrule->ttypes.types, &=
p->attr_type_map[k->target_type -1]);
>                 if (rc < 0)
>                         goto oom;
>
> -               if (!ebitmap_is_empty(&self_matches)) {
> -                       rc =3D ebitmap_union(&tgt_matches, &self_matches)=
;
> +               if (is_avrule_self) {
> +                       rc =3D ebitmap_and(&self_matches, &src_matches, &=
p->attr_type_map[k->target_type - 1]);
>                         if (rc < 0)
>                                 goto oom;
> +
> +                       if (!ebitmap_is_empty(&self_matches)) {
> +                               rc =3D ebitmap_union(&tgt_matches, &self_=
matches);
> +                               if (rc < 0)
> +                                       goto oom;
> +                       }
>                 }
>         }
>
> @@ -425,6 +452,8 @@ static int check_assertion_extended_permissions(avrul=
e_t *avrule, avtab_t *avtab
>                 ebitmap_for_each_positive_bit(&tgt_matches, tnode, j) {
>                         if (is_avrule_self && i !=3D j)
>                                 continue;
> +                       if (is_avrule_notself && i =3D=3D j)
> +                               continue;
>                         if (check_assertion_extended_permissions_avtab(av=
rule, avtab, i, j, k, p)) {
>                                 rc =3D 1;
>                                 goto exit;
> @@ -442,6 +471,61 @@ exit:
>         return rc;
>  }
>
> +static int check_assertion_notself_match(avtab_key_t *k, avrule_t *avrul=
e, policydb_t *p)
> +{
> +       ebitmap_t src_matches, tgt_matches;
> +       unsigned int num_src_matches, num_tgt_matches;
> +       int rc;
> +
> +       ebitmap_init(&src_matches);
> +       ebitmap_init(&tgt_matches);
> +
> +       rc =3D ebitmap_and(&src_matches, &avrule->stypes.types, &p->attr_=
type_map[k->source_type - 1]);
> +       if (rc < 0)
> +               goto oom;
> +
> +       if (ebitmap_is_empty(&avrule->ttypes.types)) {
> +               /* avrule tgt is of the form ~self */
> +               rc =3D ebitmap_cpy(&tgt_matches, &p->attr_type_map[k->tar=
get_type - 1]);
> +       } else {
> +               /* avrule tgt is of the form {ATTR -self} */
> +               rc =3D ebitmap_and(&tgt_matches, &avrule->ttypes.types, &=
p->attr_type_map[k->target_type - 1]);
> +       }
> +       if (rc < 0)
> +               goto oom;
> +
> +       num_src_matches =3D ebitmap_cardinality(&src_matches);
> +       num_tgt_matches =3D ebitmap_cardinality(&tgt_matches);
> +       if (num_src_matches =3D=3D 0 || num_tgt_matches =3D=3D 0) {
> +               rc =3D 0;
> +               goto nomatch;
> +       }
> +       if (num_src_matches =3D=3D 1 && num_tgt_matches =3D=3D 1) {
> +               ebitmap_t matches;
> +               unsigned int num_matches;
> +               rc =3D ebitmap_and(&matches, &src_matches, &tgt_matches);
> +               if (rc < 0) {
> +                       ebitmap_destroy(&matches);
> +                       goto oom;
> +               }
> +               num_matches =3D ebitmap_cardinality(&matches);
> +               ebitmap_destroy(&matches);
> +               if (num_matches =3D=3D 1) {
> +                       /* The only non-match is of the form TYPE TYPE */
> +                       rc =3D 0;
> +                       goto nomatch;
> +               }
> +       }
> +
> +       rc =3D 1;
> +
> +oom:
> +nomatch:
> +       ebitmap_destroy(&src_matches);
> +       ebitmap_destroy(&tgt_matches);
> +       return rc;
> +}
> +
>  static int check_assertion_self_match(avtab_key_t *k, avrule_t *avrule, =
policydb_t *p)
>  {
>         ebitmap_t src_matches;
> @@ -485,16 +569,24 @@ static int check_assertion_avtab_match(avtab_key_t =
*k, avtab_datum_t *d, void *a
>         if (!ebitmap_match_any(&avrule->stypes.types, &p->attr_type_map[k=
->source_type - 1]))
>                 goto nomatch;
>
> -       /* neverallow may have tgts even if it uses SELF */
> -       if (!ebitmap_match_any(&avrule->ttypes.types, &p->attr_type_map[k=
->target_type -1])) {
> -               if (avrule->flags =3D=3D RULE_SELF) {
> -                       rc =3D check_assertion_self_match(k, avrule, p);
> -                       if (rc < 0)
> -                               goto oom;
> -                       if (rc =3D=3D 0)
> -                               goto nomatch;
> -               } else {
> +       if (avrule->flags & RULE_NOTSELF) {
> +               rc =3D check_assertion_notself_match(k, avrule, p);
> +               if (rc < 0)
> +                       goto oom;
> +               if (rc =3D=3D 0)
>                         goto nomatch;
> +       } else {
> +               /* neverallow may have tgts even if it uses SELF */
> +               if (!ebitmap_match_any(&avrule->ttypes.types, &p->attr_ty=
pe_map[k->target_type -1])) {
> +                       if (avrule->flags =3D=3D RULE_SELF) {
> +                               rc =3D check_assertion_self_match(k, avru=
le, p);
> +                               if (rc < 0)
> +                                       goto oom;
> +                               if (rc =3D=3D 0)
> +                                       goto nomatch;
> +                       } else {
> +                               goto nomatch;
> +                       }
>                 }
>         }
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 521ea4ff..3d51fb68 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -916,6 +916,15 @@ static int validate_avrules(sepol_handle_t *handle, =
const avrule_t *avrule, int
>                 case 0:
>                 case RULE_SELF:
>                         break;
> +               case RULE_NOTSELF:
> +                       switch(avrule->specified) {
> +                       case AVRULE_NEVERALLOW:
> +                       case AVRULE_XPERMS_NEVERALLOW:
> +                               break;
> +                       default:
> +                               goto bad;
> +                       }
> +                       break;
>                 default:
>                         goto bad;
>                 }
> --
> 2.38.1
>
