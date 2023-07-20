Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13533EB64DC
	for <selinux@archiver.kernel.org>; Thu, 20 Jul 2023 13:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjGTNzi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Jul 2023 09:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjGTNzf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Jul 2023 09:55:35 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF4C1FD7
        for <selinux@vger.kernel.org>; Thu, 20 Jul 2023 06:55:33 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fba86f069bso1240807e87.3
        for <selinux@vger.kernel.org>; Thu, 20 Jul 2023 06:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689861331; x=1690466131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++nGIszo9Q91V5kaOlbOkPFyEAMZHWXdasn6/qII0Ns=;
        b=G+lr5tTx0oNZSJn8yGe4CJzsXfB/lAZ3m7868d09gO/XcOvEt9jmrbhgiTIK4h/WNo
         WZ9jX6EJq5nZdnzaLDz2IC8DPqnb8+4YmkXlqnkcdSiD2McK4FvNkU5JMn06ynw4TJRO
         3moCmdluN9H0EDHhjIgNYcCLlSwfFg8YK86nVjcMHhC3fJqjr9MUKJo2MIwK7Cxj+h74
         u0vUEa/NNuFAPIa1oerY9o6S8keY2/U8/a1g9Gm82+0utpphSp1yh6FUK5TM+b6UWPGx
         tWW59bv8+s5t527jIZC5eJoQ4ou4a8R45yRmIjW9uL5sM6HkChm/+eFdZwjmOGNhrzz+
         rLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689861331; x=1690466131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++nGIszo9Q91V5kaOlbOkPFyEAMZHWXdasn6/qII0Ns=;
        b=MG+1Xw226ATS/Xh0nZAVmrx0sSqD67KNOh5MoWRBIwe9qM7+2W0Yauw6S8bqqRjaw3
         x/VV/Gme7vFbt3i8/koFNKUBtyM6/XKWmpJLK5Fz6ToXFWhL8s5iPU4Ke5eh2tdPR0BI
         SRw5LhvtvdY9WkFfPTJmzIMvv9y6oY2QX1+9Z1S36oKKg5QUtcl3n2MVKDXCaMqXGFk9
         6BWkZkuTSkiZ73JXKQw5iDUI0xitjWySqu1eWJ5LcfYIqH9gglGMAfeM9GaC52M9Y0Og
         5ipSicmlevPXx1lXwNwhLoaM67b7BgK9k+rNTjlFzS8aXL/U1w2RJEGAqjKRxfKDb/ur
         3x4g==
X-Gm-Message-State: ABy/qLZhrZoS9crV/Rs8OmDULwDi4/WE0bIOZ8EtpMGzViYgrbwCIBok
        +UE3yhyJKCoJHBDYbOVtB6cpQlZEH+UTxCf2Gh1F+M8THb0=
X-Google-Smtp-Source: APBJJlEHu4Pf1RmGTk8onc6QbsfOeFj6g2qDqWzDVDuYsRRX8ScPdmCL8ItAELZAai2jP/9UMT9JfSnzWV0KJnKjWSQ=
X-Received: by 2002:a2e:8005:0:b0:2b6:e6cc:9057 with SMTP id
 j5-20020a2e8005000000b002b6e6cc9057mr2257534ljg.51.1689861331153; Thu, 20 Jul
 2023 06:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230714184414.40724-1-cgzones@googlemail.com>
In-Reply-To: <20230714184414.40724-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 20 Jul 2023 09:55:19 -0400
Message-ID: <CAP+JOzQQAJ-sTKWuf-Tpw4_VOmBsw+HANLwzMZgMT297sAagrQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] libsepol: validate: use fixed sized integers
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 14, 2023 at 2:53=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Avoid issues on architectures where unsigned int and uint32_t are not of
> the same size.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For this series of four patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb_validate.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 08b4a477..7db4ad35 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -23,7 +23,7 @@ typedef struct map_arg {
>
>  static int create_gap_ebitmap(char **val_to_name, uint32_t nprim, ebitma=
p_t *gaps)
>  {
> -       unsigned int i;
> +       uint32_t i;
>
>         ebitmap_init(gaps);
>
> @@ -180,7 +180,7 @@ static int validate_scope(__attribute__ ((unused)) ha=
shtab_key_t k, hashtab_datu
>  {
>         const scope_datum_t *scope_datum =3D (scope_datum_t *)d;
>         const uint32_t *nprim =3D (uint32_t *)args;
> -       unsigned int i;
> +       uint32_t i;
>
>         switch (scope_datum->scope) {
>         case SCOPE_REQ:
> @@ -205,7 +205,7 @@ static int validate_scopes(sepol_handle_t *handle, co=
nst symtab_t scopes[], cons
>  {
>         const avrule_decl_t *decl;
>         unsigned int i;
> -       unsigned int num_decls =3D 0;
> +       uint32_t num_decls =3D 0;
>
>         for (; block !=3D NULL; block =3D block->next) {
>                 for (decl =3D block->branch_list; decl; decl =3D decl->ne=
xt) {
> @@ -685,7 +685,7 @@ static int validate_bool_datum_wrapper(__attribute__(=
(unused)) hashtab_key_t k,
>
>  static int validate_datum_array_gaps(sepol_handle_t *handle, const polic=
ydb_t *p, validate_t flavors[])
>  {
> -       unsigned int i;
> +       uint32_t i;
>
>         for (i =3D 0; i < p->p_classes.nprim; i++) {
>                 if (bool_xnor(p->class_val_to_struct[i], ebitmap_get_bit(=
&flavors[SYM_CLASSES].gaps, i)))
> @@ -1377,7 +1377,7 @@ bad:
>  static int validate_permissives(sepol_handle_t *handle, const policydb_t=
 *p, validate_t flavors[])
>  {
>         ebitmap_node_t *node;
> -       unsigned i;
> +       uint32_t i;
>
>         ebitmap_for_each_positive_bit(&p->permissive_map, node, i) {
>                 if (validate_simpletype(i, p, flavors))
> @@ -1429,7 +1429,7 @@ static int validate_range_transitions(sepol_handle_=
t *handle, const policydb_t *
>  static int validate_typeattr_map(sepol_handle_t *handle, const policydb_=
t *p, validate_t flavors[])
>  {
>         const ebitmap_t *maps =3D p->type_attr_map;
> -       unsigned int i;
> +       uint32_t i;
>
>         if (p->policy_type =3D=3D POLICY_KERN) {
>                 for (i =3D 0; i < p->p_types.nprim; i++) {
> --
> 2.40.1
>
