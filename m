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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3ECC4743C
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6842261245
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhFUU4f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhFUU4e (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 16:56:34 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34577C061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:54:19 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id s17so12585506oij.11
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fjjeW3aTWPYmi/i+THOlNiAmB8lrkrTtg/MfRW1ACxo=;
        b=Zu9w6kVQwSbWOwojHvQy41hUxF5msu513NOkwImtOSL6Jafh4WCCdcfWqrAkqYf31f
         BiomTJ8S0J52xoJJKEJDND5bayHzVAQqZz0bKCsWC+FCX6gnnVxTGc40aKOfP9Z4LYEf
         kwjyb4hhYuoPKuIi/B5uW5RsQK2YEhIl9L8cFIVykToDbuFHcH2pVb8pA0+WGYrPh1Sr
         /+7azh/G3w8WEkPOSZwiyu4IQm8w2n6ZAYoFq4MdWuqzAVq353XM5d+Mh+zrNQHVYXjd
         hOoQ6OqggIkGt81qvmzs8r4Ya9nTotevKYyzHGb2v0EoH9/mqgDHcrmJKZOkc6GiIkiP
         RH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fjjeW3aTWPYmi/i+THOlNiAmB8lrkrTtg/MfRW1ACxo=;
        b=DgF4/INqwBRjB2+T+h/sf0sODU1LixvpAVDiWfexYB76bFtCA8dr1bZ8PQjYP4CSue
         qyZqDwpZEEWg7G0FTx95FQwyrJq90kZs32cj7HRDPMO5ybf+bPb2jjv3WB8y+Bis4BDM
         y5V7m+SaSfwzMQwaTNkS+/xXzqezudoR9jYsSq24XJNKaQfMzFIxgpRGqLbRuEfEe3G1
         fY48K7wNzkSHoTbeh3T4St64Tc5A3AKWDf3dDD65Lncx4JhK8fC0wgHtc+moJmFPh8Wm
         QmKOaUvz5oUUYO3pMADijCZpcyULcskC1ymm+ocyNPdwiG81iOYJyy6SeslWwplYkiiG
         nk2A==
X-Gm-Message-State: AOAM531mrPgInTWZOZEX9OiqaEHYW7cT/zzeC07rszQvUGkwMaownlwd
        4EfhQr1cyRXdRd5niR281nqubGWUg7Z359l2eSw=
X-Google-Smtp-Source: ABdhPJzJElL3rOQ3Khq7fTvZeK1eSpja02hYcG2in/4eCtsv4qk9tO17aY/5aDLipvmC7HMQaee3BIkAnRz5hXvJ86M=
X-Received: by 2002:aca:1c0d:: with SMTP id c13mr280291oic.128.1624308858645;
 Mon, 21 Jun 2021 13:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-4-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-4-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Jun 2021 16:54:07 -0400
Message-ID: <CAP+JOzSG0FaTwHS9m2dbr=8gd2BTXR4N1+ZOcrVaGYJJWOJyWA@mail.gmail.com>
Subject: Re: [PATCH 03/23] libsepol: remove unused functions
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 12:00 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The functions `role_set_get_role`, `sepol_validate_transition` and
> `sepol_sidtab_remove` seem to be unused since the initial import.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb.c | 18 ----------------
>  libsepol/src/services.c | 47 -----------------------------------------
>  libsepol/src/sidtab.c   | 31 ---------------------------
>  3 files changed, 96 deletions(-)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 3f7ddb11..fc1d0711 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1791,24 +1791,6 @@ int type_set_or_eq(type_set_t * dst, type_set_t * =
other)
>         return ret;
>  }
>
> -int role_set_get_role(role_set_t * x, uint32_t role)
> -{
> -       if (x->flags & ROLE_STAR)
> -               return 1;
> -
> -       if (ebitmap_get_bit(&x->roles, role - 1)) {
> -               if (x->flags & ROLE_COMP)
> -                       return 0;
> -               else
> -                       return 1;
> -       } else {
> -               if (x->flags & ROLE_COMP)
> -                       return 1;
> -               else
> -                       return 0;
> -       }
> -}
> -
>  /***********************************************************************=
/
>  /* everything below is for policy reads */
>
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index 39fbd979..ff91f7d2 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -1024,53 +1024,6 @@ static int context_struct_compute_av(context_struc=
t_t * scontext,
>         return 0;
>  }
>
> -static int sepol_validate_transition(sepol_security_id_t oldsid,
> -                                    sepol_security_id_t newsid,
> -                                    sepol_security_id_t tasksid,
> -                                    sepol_security_class_t tclass)
> -{
> -       context_struct_t *ocontext;
> -       context_struct_t *ncontext;
> -       context_struct_t *tcontext;
> -       class_datum_t *tclass_datum;
> -       constraint_node_t *constraint;
> -
> -       if (!tclass || tclass > policydb->p_classes.nprim) {
> -               ERR(NULL, "unrecognized class %d", tclass);
> -               return -EINVAL;
> -       }
> -       tclass_datum =3D policydb->class_val_to_struct[tclass - 1];
> -
> -       ocontext =3D sepol_sidtab_search(sidtab, oldsid);
> -       if (!ocontext) {
> -               ERR(NULL, "unrecognized SID %d", oldsid);
> -               return -EINVAL;
> -       }
> -
> -       ncontext =3D sepol_sidtab_search(sidtab, newsid);
> -       if (!ncontext) {
> -               ERR(NULL, "unrecognized SID %d", newsid);
> -               return -EINVAL;
> -       }
> -
> -       tcontext =3D sepol_sidtab_search(sidtab, tasksid);
> -       if (!tcontext) {
> -               ERR(NULL, "unrecognized SID %d", tasksid);
> -               return -EINVAL;
> -       }
> -
> -       constraint =3D tclass_datum->validatetrans;
> -       while (constraint) {
> -               if (!constraint_expr_eval_reason(ocontext, ncontext, tcon=
text,
> -                                         0, constraint, NULL, 0)) {
> -                       return -EPERM;
> -               }
> -               constraint =3D constraint->next;
> -       }
> -
> -       return 0;
> -}
> -
>  /*
>   * sepol_validate_transition_reason_buffer - the reason buffer is reallo=
c'd
>   * in the constraint_expr_eval_reason() function.
> diff --git a/libsepol/src/sidtab.c b/libsepol/src/sidtab.c
> index e6bf5716..255e0725 100644
> --- a/libsepol/src/sidtab.c
> +++ b/libsepol/src/sidtab.c
> @@ -84,37 +84,6 @@ int sepol_sidtab_insert(sidtab_t * s, sepol_security_i=
d_t sid,
>         return 0;
>  }
>
> -int sepol_sidtab_remove(sidtab_t * s, sepol_security_id_t sid)
> -{
> -       int hvalue;
> -       sidtab_node_t *cur, *last;
> -
> -       if (!s || !s->htable)
> -               return -ENOENT;
> -
> -       hvalue =3D SIDTAB_HASH(sid);
> -       last =3D NULL;
> -       cur =3D s->htable[hvalue];
> -       while (cur !=3D NULL && sid > cur->sid) {
> -               last =3D cur;
> -               cur =3D cur->next;
> -       }
> -
> -       if (cur =3D=3D NULL || sid !=3D cur->sid)
> -               return -ENOENT;
> -
> -       if (last =3D=3D NULL)
> -               s->htable[hvalue] =3D cur->next;
> -       else
> -               last->next =3D cur->next;
> -
> -       context_destroy(&cur->context);
> -
> -       free(cur);
> -       s->nel--;
> -       return 0;
> -}
> -
>  context_struct_t *sepol_sidtab_search(sidtab_t * s, sepol_security_id_t =
sid)
>  {
>         int hvalue;
> --
> 2.32.0
>
