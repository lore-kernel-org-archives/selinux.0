Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30603C433F5
	for <selinux@archiver.kernel.org>; Fri,  1 Apr 2022 17:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348602AbiDAR31 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Apr 2022 13:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347621AbiDAR31 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Apr 2022 13:29:27 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BFD1DEC31
        for <selinux@vger.kernel.org>; Fri,  1 Apr 2022 10:27:37 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w127so3459085oig.10
        for <selinux@vger.kernel.org>; Fri, 01 Apr 2022 10:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RmwWiyi2vZCY1cZfWbuMgJFxrW8niaGj7elKtAGc8dk=;
        b=P6BitqbTJ8ElRASqyjMN9pPlaxzQB/jQEZ7+Mv5z+es3HZvWbLSj0eogElNkDkoYtD
         ICjbpqe4sSsyPAQ/em7l/vNly3iAKS9n+7g8MMu8gEhsPCsYvfE+tH5X3NmcsyfMG47Z
         M6hfSdIMsplxT9tVGJAMspVba314YgqA72yPASYaNL+XZX/DZGG3gG3fqqSTi7Majc7d
         opNZiBH/S+bI8VgSX9riztKFZ/PAxncazjkTI/2aF9DnqNLX0urxIhUGSh0f1WG4LX9U
         m/6BhpPrGvhooZAd9931XcVmOKTGvK1rkbo5Ejg/NzSVweIeJHJ7UBkvcJaGc5yHE4Eo
         rVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RmwWiyi2vZCY1cZfWbuMgJFxrW8niaGj7elKtAGc8dk=;
        b=qKjGAFFMBIoentqV8MamyWCkne33/pKkk+2FjbQ6+bllXpPox8fhkYNW+My/YG+Rqn
         f7Kf8Ed2NvPbLgZ+1cdtJkVHSXf3dmxeorDZu/5C6LQ1XlrCO3i5Z9Zq9Gtd2v5m3C8C
         YfGrLwx6m2CPnjoQ5biVUdjGZxcYTs20w+Izk4uTtPN2WAczCR+7h25YF97DKR4NI9Rm
         fLkClOK20tXC9+0W/KXBvccT/kTwbBSg7GiceTeDRh2AuVWqH1O1EKo97qtuZzL+KT/j
         5WB+HvkU/GNNJ/9fplgRbaVEcqhpebdxke5VI+ggFX5b19IQLF0zIPh9zUC4jCliyG4s
         HZuw==
X-Gm-Message-State: AOAM533VYvvSmY/gZIMulIYpm3v/0kminVft9MfxrC19CkLld5m3KX3x
        0gWxwwYdMaUV/al0qZ2h0BgpWV2z522tFg8UT5TDfGBIWto=
X-Google-Smtp-Source: ABdhPJxfDbc5kdawVwhpB2x8CeBBQirGupRiD88vZhLGLJpyRKsmcgMV4VtI/yput8mgpwLlqXMX5igpTw/hdmtuUM0=
X-Received: by 2002:a05:6808:ecb:b0:2f7:41cc:21b9 with SMTP id
 q11-20020a0568080ecb00b002f741cc21b9mr5169776oiv.156.1648834056654; Fri, 01
 Apr 2022 10:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220331144610.31056-1-cgzones@googlemail.com>
In-Reply-To: <20220331144610.31056-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 1 Apr 2022 13:27:25 -0400
Message-ID: <CAP+JOzSVU+mGXv5Z36xTxy7U=FJbW2+oCC7S6cQzi9ssLo8LZg@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: mark immutable mls and context parameter const
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 1, 2022 at 9:49 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Make it more obvious which parameters are read-only and not being
> modified and allow callers to pass const pointers.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/include/sepol/policydb/context.h   | 14 +++++++-------
>  libsepol/include/sepol/policydb/mls_types.h | 12 ++++++------
>  libsepol/src/mls.c                          | 17 +++++++++--------
>  libsepol/src/mls.h                          |  4 ++--
>  4 files changed, 24 insertions(+), 23 deletions(-)
>
> diff --git a/libsepol/include/sepol/policydb/context.h b/libsepol/include=
/sepol/policydb/context.h
> index 37cdc591..025c894f 100644
> --- a/libsepol/include/sepol/policydb/context.h
> +++ b/libsepol/include/sepol/policydb/context.h
> @@ -43,7 +43,7 @@ static inline void mls_context_init(context_struct_t * =
c)
>  }
>
>  static inline int mls_context_cpy(context_struct_t * dst,
> -                                 context_struct_t * src)
> +                                 const context_struct_t * src)
>  {
>
>         if (mls_range_cpy(&dst->range, &src->range) < 0)
> @@ -55,7 +55,7 @@ static inline int mls_context_cpy(context_struct_t * ds=
t,
>  /*
>   * Sets both levels in the MLS range of 'dst' to the low level of 'src'.
>   */
> -static inline int mls_context_cpy_low(context_struct_t *dst, context_str=
uct_t *src)
> +static inline int mls_context_cpy_low(context_struct_t *dst, const conte=
xt_struct_t *src)
>  {
>         int rc;
>
> @@ -75,7 +75,7 @@ out:
>  /*
>   * Sets both levels in the MLS range of 'dst' to the high level of 'src'=
.
>   */
> -static inline int mls_context_cpy_high(context_struct_t *dst, context_st=
ruct_t *src)
> +static inline int mls_context_cpy_high(context_struct_t *dst, const cont=
ext_struct_t *src)
>  {
>         int rc;
>
> @@ -92,12 +92,12 @@ out:
>         return rc;
>  }
>
> -static inline int mls_context_glblub(context_struct_t *dst, context_stru=
ct_t *c1, context_struct_t *c2)
> +static inline int mls_context_glblub(context_struct_t *dst, const contex=
t_struct_t *c1, const context_struct_t *c2)
>  {
>         return mls_range_glblub(&dst->range, &c1->range, &c2->range);
>  }
>
> -static inline int mls_context_cmp(context_struct_t * c1, context_struct_=
t * c2)
> +static inline int mls_context_cmp(const context_struct_t * c1, const con=
text_struct_t * c2)
>  {
>         return (mls_level_eq(&c1->range.level[0], &c2->range.level[0]) &&
>                 mls_level_eq(&c1->range.level[1], &c2->range.level[1]));
> @@ -118,7 +118,7 @@ static inline void context_init(context_struct_t * c)
>         memset(c, 0, sizeof(*c));
>  }
>
> -static inline int context_cpy(context_struct_t * dst, context_struct_t *=
 src)
> +static inline int context_cpy(context_struct_t * dst, const context_stru=
ct_t * src)
>  {
>         dst->user =3D src->user;
>         dst->role =3D src->role;
> @@ -135,7 +135,7 @@ static inline void context_destroy(context_struct_t *=
 c)
>         mls_context_destroy(c);
>  }
>
> -static inline int context_cmp(context_struct_t * c1, context_struct_t * =
c2)
> +static inline int context_cmp(const context_struct_t * c1, const context=
_struct_t * c2)
>  {
>         return ((c1->user =3D=3D c2->user) &&
>                 (c1->role =3D=3D c2->role) &&
> diff --git a/libsepol/include/sepol/policydb/mls_types.h b/libsepol/inclu=
de/sepol/policydb/mls_types.h
> index 0ba6d9de..12990c69 100644
> --- a/libsepol/include/sepol/policydb/mls_types.h
> +++ b/libsepol/include/sepol/policydb/mls_types.h
> @@ -50,7 +50,7 @@ typedef struct mls_range {
>         mls_level_t level[2];   /* low =3D=3D level[0], high =3D=3D level=
[1] */
>  } mls_range_t;
>
> -static inline int mls_range_glblub(struct mls_range *dst, struct mls_ran=
ge *r1, struct mls_range *r2)
> +static inline int mls_range_glblub(struct mls_range *dst, const struct m=
ls_range *r1, const struct mls_range *r2)
>  {
>         if (r1->level[1].sens < r2->level[0].sens || r2->level[1].sens < =
r1->level[0].sens) {
>                 /* These ranges have no common sensitivities */
> @@ -74,7 +74,7 @@ static inline int mls_range_glblub(struct mls_range *ds=
t, struct mls_range *r1,
>  }
>
>
> -static inline int mls_level_cpy(struct mls_level *dst, struct mls_level =
*src)
> +static inline int mls_level_cpy(struct mls_level *dst, const struct mls_=
level *src)
>  {
>
>         dst->sens =3D src->sens;
> @@ -119,7 +119,7 @@ static inline int mls_level_dom(const struct mls_leve=
l *l1, const struct mls_lev
>  (mls_level_dom(&(r2).level[0], &(r1).level[0]) && \
>   mls_level_dom(&(r1).level[1], &(r2).level[1]))
>
> -static inline int mls_range_cpy(mls_range_t * dst, mls_range_t * src)
> +static inline int mls_range_cpy(mls_range_t * dst, const mls_range_t * s=
rc)
>  {
>
>         if (mls_level_cpy(&dst->level[0], &src->level[0]) < 0)
> @@ -149,7 +149,7 @@ static inline void mls_range_destroy(struct mls_range=
 *r)
>         mls_level_destroy(&r->level[1]);
>  }
>
> -static inline int mls_range_eq(struct mls_range *r1, struct mls_range *r=
2)
> +static inline int mls_range_eq(const struct mls_range *r1, const struct =
mls_range *r2)
>  {
>         return (mls_level_eq(&r1->level[0], &r2->level[0]) &&
>                 mls_level_eq(&r1->level[1], &r2->level[1]));
> @@ -174,10 +174,10 @@ extern void mls_semantic_cat_init(mls_semantic_cat_=
t *c);
>  extern void mls_semantic_cat_destroy(mls_semantic_cat_t *c);
>  extern void mls_semantic_level_init(mls_semantic_level_t *l);
>  extern void mls_semantic_level_destroy(mls_semantic_level_t *l);
> -extern int mls_semantic_level_cpy(mls_semantic_level_t *dst, mls_semanti=
c_level_t *src);
> +extern int mls_semantic_level_cpy(mls_semantic_level_t *dst, const mls_s=
emantic_level_t *src);
>  extern void mls_semantic_range_init(mls_semantic_range_t *r);
>  extern void mls_semantic_range_destroy(mls_semantic_range_t *r);
> -extern int mls_semantic_range_cpy(mls_semantic_range_t *dst, mls_semanti=
c_range_t *src);
> +extern int mls_semantic_range_cpy(mls_semantic_range_t *dst, const mls_s=
emantic_range_t *src);
>
>  #ifdef __cplusplus
>  }
> diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c
> index 366a1114..4ffe9814 100644
> --- a/libsepol/src/mls.c
> +++ b/libsepol/src/mls.c
> @@ -451,7 +451,7 @@ int mls_context_to_sid(const policydb_t * policydb,
>   * Copies the MLS range from `src' into `dst'.
>   */
>  static inline int mls_copy_context(context_struct_t * dst,
> -                                  context_struct_t * src)
> +                                  const context_struct_t * src)
>  {
>         int l, rc =3D 0;
>
> @@ -471,7 +471,7 @@ static inline int mls_copy_context(context_struct_t *=
 dst,
>   * Copies the effective MLS range from `src' into `dst'.
>   */
>  static inline int mls_scopy_context(context_struct_t * dst,
> -                                   context_struct_t * src)
> +                                   const context_struct_t * src)
>  {
>         int l, rc =3D 0;
>
> @@ -490,7 +490,7 @@ static inline int mls_scopy_context(context_struct_t =
* dst,
>  /*
>   * Copies the MLS range `range' into `context'.
>   */
> -static inline int mls_range_set(context_struct_t * context, mls_range_t =
* range)
> +static inline int mls_range_set(context_struct_t * context, const mls_ra=
nge_t * range)
>  {
>         int l, rc =3D 0;
>
> @@ -601,8 +601,8 @@ int mls_convert_context(policydb_t * oldp,
>  }
>
>  int mls_compute_sid(policydb_t * policydb,
> -                   context_struct_t * scontext,
> -                   context_struct_t * tcontext,
> +                   const context_struct_t * scontext,
> +                   const context_struct_t * tcontext,
>                     sepol_security_class_t tclass,
>                     uint32_t specified, context_struct_t * newcontext)
>  {
> @@ -755,9 +755,10 @@ void mls_semantic_level_destroy(mls_semantic_level_t=
 * l)
>  }
>
>  int mls_semantic_level_cpy(mls_semantic_level_t * dst,
> -                          mls_semantic_level_t * src)
> +                          const mls_semantic_level_t * src)
>  {
> -       mls_semantic_cat_t *cat, *newcat, *lnewcat =3D NULL;
> +       const mls_semantic_cat_t *cat;
> +       mls_semantic_cat_t *newcat, *lnewcat =3D NULL;
>
>         mls_semantic_level_init(dst);
>         dst->sens =3D src->sens;
> @@ -800,7 +801,7 @@ void mls_semantic_range_destroy(mls_semantic_range_t =
* r)
>  }
>
>  int mls_semantic_range_cpy(mls_semantic_range_t * dst,
> -                          mls_semantic_range_t * src)
> +                          const mls_semantic_range_t * src)
>  {
>         if (mls_semantic_level_cpy(&dst->level[0], &src->level[0]) < 0)
>                 return -1;
> diff --git a/libsepol/src/mls.h b/libsepol/src/mls.h
> index 5ca3cd51..eb4a1cb8 100644
> --- a/libsepol/src/mls.h
> +++ b/libsepol/src/mls.h
> @@ -56,8 +56,8 @@ extern int mls_convert_context(policydb_t * oldp,
>                                policydb_t * newp, context_struct_t * cont=
ext);
>
>  extern int mls_compute_sid(policydb_t * policydb,
> -                          context_struct_t * scontext,
> -                          context_struct_t * tcontext,
> +                          const context_struct_t * scontext,
> +                          const context_struct_t * tcontext,
>                            sepol_security_class_t tclass,
>                            uint32_t specified, context_struct_t * newcont=
ext);
>
> --
> 2.35.1
>
