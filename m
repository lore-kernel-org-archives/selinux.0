Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6F1C00528
	for <selinux@archiver.kernel.org>; Mon,  7 Aug 2023 15:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjHGO77 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Aug 2023 10:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjHGO76 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Aug 2023 10:59:58 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E78510CB
        for <selinux@vger.kernel.org>; Mon,  7 Aug 2023 07:59:57 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so71000891fa.1
        for <selinux@vger.kernel.org>; Mon, 07 Aug 2023 07:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691420395; x=1692025195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GSeT9FeGHK4noNRb4vgqxaP8G6jAuF0jze/0sqcyGU=;
        b=UCnCzbu2KKg6XjOyAwoD7wASqDfn1RjfghTX2f+rG5uLDyLmpYk4ZD3oFUCibwTiSU
         J1i4V9ZUBJ/WDrAUhmXLImddvCPwpwuhmXJcJCd+p8HgJ9tkVAL8ra/bO44Zj91bUyYQ
         6qJxSRtKueo0iFfUXDQ9uK98eNYBK1k0C3S3d2BDrhIlMtlUa0WwZLrEN61TSB7PrkOa
         0XOiP3Tn+p+Xue7lPzccZz9AZpZdUrNIikdtLl4YSHMCmbmayNz/+gsaMSAfdapBECoR
         q6Oczk6yIvFTD6j9vdOmrGIV2ScKnjma2mx0dVIuXCj6fY7O+0aaRuK4umbP76BZtv0O
         rUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691420395; x=1692025195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GSeT9FeGHK4noNRb4vgqxaP8G6jAuF0jze/0sqcyGU=;
        b=L9OhpghlK5p9wzxVhwZslimFRpjX6rT32kNpxg9XAuAfeyv4j38Aj8Qt00P9c88unS
         BcB4qppJLam/heGCCeBT0baezEpf05MKv5aa0qZNSiDVKUOj4MkVMH/eELsStLBXbU/U
         2p16wGJNafUUU4rWDLYjKyEFxKUzE0gsT3o6Ej46KPyLwhWF1JTWWXEe11sXiqtVKjaG
         1lnqrSEVV5axxh6NKktFZAKCkqpunOk9+AVOVwfdr7izswnbYZRNvYU0tDUkrffIJi9+
         UHyrfA6yhXHQD38CP0NNGKP3NZk8L68MXQ3vtLpv4aEDmQIZ1mjcOHu/b+OexZ2U6/fB
         MzqQ==
X-Gm-Message-State: AOJu0Yz3vL4pYiFiyP2+CdQ46A7Vvpbcd2WSmJQfzw8Cq3DoYQMZBqof
        noWocreNloNEGMYEFQH4OrHzHRbGA0QekMoxEDDL3ZYC
X-Google-Smtp-Source: AGHT+IEuDmqzA6nXL6kGnBRfgctXqOw9ebA76s7c7LCP/HiQ/7ASJnrBWq264Nue4aVEBkCjzFCxRoX4V+WJmRFssAA=
X-Received: by 2002:a05:651c:454:b0:2b6:ffd1:165a with SMTP id
 g20-20020a05651c045400b002b6ffd1165amr6889724ljg.30.1691420395037; Mon, 07
 Aug 2023 07:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230714184414.40724-1-cgzones@googlemail.com> <CAP+JOzQQAJ-sTKWuf-Tpw4_VOmBsw+HANLwzMZgMT297sAagrQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQQAJ-sTKWuf-Tpw4_VOmBsw+HANLwzMZgMT297sAagrQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 7 Aug 2023 10:59:43 -0400
Message-ID: <CAP+JOzQeD9dvACzXP8YZAC=NPOuzisN8Y=X3RswDF8_9hYx8xA@mail.gmail.com>
Subject: Re: [PATCH 1/4] libsepol: validate: use fixed sized integers
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 20, 2023 at 9:55=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, Jul 14, 2023 at 2:53=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Avoid issues on architectures where unsigned int and uint32_t are not o=
f
> > the same size.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For this series of four patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

This series of four patches has been merged.
Thanks,
Jim

> > ---
> >  libsepol/src/policydb_validate.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_v=
alidate.c
> > index 08b4a477..7db4ad35 100644
> > --- a/libsepol/src/policydb_validate.c
> > +++ b/libsepol/src/policydb_validate.c
> > @@ -23,7 +23,7 @@ typedef struct map_arg {
> >
> >  static int create_gap_ebitmap(char **val_to_name, uint32_t nprim, ebit=
map_t *gaps)
> >  {
> > -       unsigned int i;
> > +       uint32_t i;
> >
> >         ebitmap_init(gaps);
> >
> > @@ -180,7 +180,7 @@ static int validate_scope(__attribute__ ((unused)) =
hashtab_key_t k, hashtab_datu
> >  {
> >         const scope_datum_t *scope_datum =3D (scope_datum_t *)d;
> >         const uint32_t *nprim =3D (uint32_t *)args;
> > -       unsigned int i;
> > +       uint32_t i;
> >
> >         switch (scope_datum->scope) {
> >         case SCOPE_REQ:
> > @@ -205,7 +205,7 @@ static int validate_scopes(sepol_handle_t *handle, =
const symtab_t scopes[], cons
> >  {
> >         const avrule_decl_t *decl;
> >         unsigned int i;
> > -       unsigned int num_decls =3D 0;
> > +       uint32_t num_decls =3D 0;
> >
> >         for (; block !=3D NULL; block =3D block->next) {
> >                 for (decl =3D block->branch_list; decl; decl =3D decl->=
next) {
> > @@ -685,7 +685,7 @@ static int validate_bool_datum_wrapper(__attribute_=
_((unused)) hashtab_key_t k,
> >
> >  static int validate_datum_array_gaps(sepol_handle_t *handle, const pol=
icydb_t *p, validate_t flavors[])
> >  {
> > -       unsigned int i;
> > +       uint32_t i;
> >
> >         for (i =3D 0; i < p->p_classes.nprim; i++) {
> >                 if (bool_xnor(p->class_val_to_struct[i], ebitmap_get_bi=
t(&flavors[SYM_CLASSES].gaps, i)))
> > @@ -1377,7 +1377,7 @@ bad:
> >  static int validate_permissives(sepol_handle_t *handle, const policydb=
_t *p, validate_t flavors[])
> >  {
> >         ebitmap_node_t *node;
> > -       unsigned i;
> > +       uint32_t i;
> >
> >         ebitmap_for_each_positive_bit(&p->permissive_map, node, i) {
> >                 if (validate_simpletype(i, p, flavors))
> > @@ -1429,7 +1429,7 @@ static int validate_range_transitions(sepol_handl=
e_t *handle, const policydb_t *
> >  static int validate_typeattr_map(sepol_handle_t *handle, const policyd=
b_t *p, validate_t flavors[])
> >  {
> >         const ebitmap_t *maps =3D p->type_attr_map;
> > -       unsigned int i;
> > +       uint32_t i;
> >
> >         if (p->policy_type =3D=3D POLICY_KERN) {
> >                 for (i =3D 0; i < p->p_types.nprim; i++) {
> > --
> > 2.40.1
> >
