Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C281EB64DC
	for <selinux@archiver.kernel.org>; Mon, 17 Jul 2023 20:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjGQUq1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jul 2023 16:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjGQUqX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jul 2023 16:46:23 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC9810C4
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 13:46:22 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5774098f16eso52777477b3.0
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 13:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689626781; x=1692218781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEdcEcIb3INTfFcQiUk0YSKaQiTgc3Kskp0pp8FOXTk=;
        b=JWD3XIdVT+GpokCpDezMxA5qSflvlS2Tl/XIK/P3zokCNIE8IsLwFXHZODC/dXPPkA
         639sg3K1ISUjHT1umjBfRimeLMgfeLGDmIdmQ1TCENOQ/H0Mb2AvZRn5rGDObI6lNoV1
         Wz86nTYUxWQRKblpl0osV3xUgq+l3PuwIHHSS+tvy6CMB0udcdnk36NTKPklgdo0fbDd
         inX3vV0SQemh+3ZcVSdO/DhFXYkbnFNsl2YRtpif5vedqQs0a+Z8/5ce8ryKg6+KYlcQ
         Rq1ZsAChTPCgyeovI4V6+w3HAJN+MCFY/jQU1uaEzEH2noIK6CBkV/jo8n0qRHn4GfXE
         Q45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689626781; x=1692218781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEdcEcIb3INTfFcQiUk0YSKaQiTgc3Kskp0pp8FOXTk=;
        b=KbBib1ICU1M5Js9hkAp1Kq/Rrzgvm6S7m0Jc2g3Gmt0P8CIrsOsMKEpY5Tnie2HtLc
         RBXFoB0iaq6wiGPfhB0eNJgcIepXXpqguS2gC57O1okBqkg8OIH843+gVULKNF+auoOJ
         Vk+jmQe3fpJW1i27l0pdVIGTIWanyONYW2axSOVVP+PCMDUli3ylYXBFq5cou0Sd77pr
         kxzE6MxDrUMnv9gRCwsS+2/mtMzGRkcvohUEyYAv+ll/1tLA9FvC94jy9kCnkHv00Qcs
         ddo20MqMHuoHVFzeIMEZ4j4o/YJgvUO5e8O7R1P4Vr3weLYP3zHITM0hQzML3CKXp3qh
         Df/g==
X-Gm-Message-State: ABy/qLZ9nxDDRaAN7a/ufcPZmDtKEzTqyTpCJoOj20VQwVpf5YohepEb
        8NAzFlj8tWT6bjRchSJRMAKBW7ViP4u4vD3vofam
X-Google-Smtp-Source: APBJJlFXvlWe55QM5YJhg5GUjTrvMhqBVX+o3OiftGPE9hM+2FUj2AVtjmH00pTMqyPP3xaY8BVDYaML4FGEVXSm81Q=
X-Received: by 2002:a81:6c55:0:b0:57a:8ecb:11ad with SMTP id
 h82-20020a816c55000000b0057a8ecb11admr14789633ywc.43.1689626781235; Mon, 17
 Jul 2023 13:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230706133004.19064-1-cgzones@googlemail.com>
In-Reply-To: <20230706133004.19064-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Jul 2023 16:46:10 -0400
Message-ID: <CAHC9VhS=DzORJHPH+ObJJ8HpsnBqcDw0_PzzP1=TNL9gvaPgsg@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: implement avtab_search() via avtab_search_node()
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 6, 2023 at 9:30=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Deduplicate avtab_search() by using the identical implementation from
> avtab_search_node().
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/avtab.c | 32 --------------------------------
>  security/selinux/ss/avtab.h | 11 ++++++++++-
>  2 files changed, 10 insertions(+), 33 deletions(-)

I only see three avtab_search() callers, and only one that actually
cares about a return value other than NULL/non-NULL.  With that in
mind, how about we remove avtab_search() entirely and update
security_compute_sid() to use avtab_search_node()?  After all, it
already uses it for the conditional rules lookup ... not sure why it
doesn't use it everywhere?

> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index 6766edc0fe68..33a54fbd989b 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -180,38 +180,6 @@ struct avtab_node *avtab_insert_nonunique(struct avt=
ab *h,
>         return avtab_insert_node(h, hvalue, prev, key, datum);
>  }
>
> -struct avtab_datum *avtab_search(struct avtab *h, const struct avtab_key=
 *key)
> -{
> -       int hvalue;
> -       struct avtab_node *cur;
> -       u16 specified =3D key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_=
OLD);
> -
> -       if (!h || !h->nslot)
> -               return NULL;
> -
> -       hvalue =3D avtab_hash(key, h->mask);
> -       for (cur =3D h->htable[hvalue]; cur;
> -            cur =3D cur->next) {
> -               if (key->source_type =3D=3D cur->key.source_type &&
> -                   key->target_type =3D=3D cur->key.target_type &&
> -                   key->target_class =3D=3D cur->key.target_class &&
> -                   (specified & cur->key.specified))
> -                       return &cur->datum;
> -
> -               if (key->source_type < cur->key.source_type)
> -                       break;
> -               if (key->source_type =3D=3D cur->key.source_type &&
> -                   key->target_type < cur->key.target_type)
> -                       break;
> -               if (key->source_type =3D=3D cur->key.source_type &&
> -                   key->target_type =3D=3D cur->key.target_type &&
> -                   key->target_class < cur->key.target_class)
> -                       break;
> -       }
> -
> -       return NULL;
> -}
> -
>  /* This search function returns a node pointer, and can be used in
>   * conjunction with avtab_search_next_node()
>   */
> diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
> index d6742fd9c560..16238c7bcbba 100644
> --- a/security/selinux/ss/avtab.h
> +++ b/security/selinux/ss/avtab.h
> @@ -90,7 +90,6 @@ struct avtab {
>  void avtab_init(struct avtab *h);
>  int avtab_alloc(struct avtab *, u32);
>  int avtab_alloc_dup(struct avtab *new, const struct avtab *orig);
> -struct avtab_datum *avtab_search(struct avtab *h, const struct avtab_key=
 *k);
>  void avtab_destroy(struct avtab *h);
>  void avtab_hash_eval(struct avtab *h, const char *tag);
>
> @@ -110,6 +109,16 @@ struct avtab_node *avtab_insert_nonunique(struct avt=
ab *h,
>
>  struct avtab_node *avtab_search_node(struct avtab *h,
>                                      const struct avtab_key *key);
> +static inline struct avtab_datum *avtab_search(struct avtab *h,
> +                                              const struct avtab_key *ke=
y)
> +{
> +       struct avtab_node *cur =3D avtab_search_node(h, key);
> +
> +       if (cur)
> +               return &cur->datum;
> +
> +       return NULL;
> +}
>
>  struct avtab_node *avtab_search_node_next(struct avtab_node *node, int s=
pecified);
>
> --
> 2.40.1

--=20
paul-moore.com
