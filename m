Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76D0C43217
	for <selinux@archiver.kernel.org>; Wed, 12 Jan 2022 15:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354850AbiALPzo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jan 2022 10:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354857AbiALPzn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Jan 2022 10:55:43 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A58EC061748
        for <selinux@vger.kernel.org>; Wed, 12 Jan 2022 07:55:43 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id w19-20020a056830061300b0058f1dd48932so2971271oti.11
        for <selinux@vger.kernel.org>; Wed, 12 Jan 2022 07:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I9p1No6JLDMP5H67Z6G0JaJ7SRlnTDgriW7DiHmaL3k=;
        b=jQmLwfWt+cnjSngmHSk/BSWVomq881iAGN4DJ/zCBk4HaBqGmjbTskyOjkrEjiCCEN
         Scq1yrmrjS0sG6Ta4wyo9nJk+q8JslTsvYv7tmzSJu+7Lseq07XDJe4VhBM/Pf8blbUi
         fmLcZbqlNmnIuX3knehftuBrVxiSIxCl5pNqShIi9xr2KD3qARyeMfPMaSOWcGdPCYc2
         8xJIeMmTYXM44/qpvCsyQL9oPsQNsLlBpcb8rQo5qdOsW2NmGrvn/eGhuaRYH8C7Yq34
         YaEDvKGHgSBerf2M7N1IwDQmDzuVRtWbkTVnfEre4rSk/nEE/FbQ0v/Iw4pAV8CiFwwq
         9IRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I9p1No6JLDMP5H67Z6G0JaJ7SRlnTDgriW7DiHmaL3k=;
        b=k2EiTLMtXmbiZFb+wgOvjmMjRWRR8TraJMsNHU45odbJdB1WSvdx+PEL3aIXxa3Co+
         TQ0gjTtUIn3br1ZNJCNVI6la3oanjxaKklmHlx8iKB6zdZYTNdSaBXZtl5dz+8FRgcQ5
         c0Eu48TbMWEH/2Twf9/7l5MJP1SIelbjgvc98IAQLh6H3iEUOo1HEsuKIlAm7O+XLeDa
         WjDYG0UI77VxhsuyimfMp9qyLcHre5s6sLwy+xoAnWWo9u4l1meIWh8ZFJ6catIEb7hM
         6/1pDWfGPw2+FyGkgVL/Szy0vlfTxgfIzWrI7evZ0NisQF/Yx4Q8w69cVz54GVRPg6xS
         jdww==
X-Gm-Message-State: AOAM533KH4xaVgOOZ1DIduJzZfMgZin+r2SDWAGu4Vvozp7U+MDIhoNh
        Z20TxNf0NG8yghx3ogHjdLsp8lL/XqRx8T1pOxGmnRtMPS0=
X-Google-Smtp-Source: ABdhPJxb8O16/Uid00g68824DSgULLMkxxDIdIgxOYnY9yi+/AC2G4iGMYK0pPPTWHXoGmelzGRbc9u8a+chFCF7qHQ=
X-Received: by 2002:a05:6830:1384:: with SMTP id d4mr274415otq.139.1642002942454;
 Wed, 12 Jan 2022 07:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20211223185004.77862-1-cgzones@googlemail.com> <20220106204226.146879-1-cgzones@googlemail.com>
In-Reply-To: <20220106204226.146879-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 12 Jan 2022 10:55:31 -0500
Message-ID: <CAP+JOzR1KidV3suFZA6VVhZKd1K_E0kDUazSMqRrBj3+dPGR+Q@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: handle type gaps
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 7, 2022 at 1:57 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> For policy versions between 20 and 23 the type_val_to_struct array might
> contain gaps. Skip those gaps to avoid NULL pointer dereferences:
>
>     =3D=3D1250=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x00=
0000000008 (pc 0x00000058560b bp 0x7ffdca60c110 sp 0x7ffdca60bfc0 T0)
>     =3D=3D1250=3D=3DThe signal is caused by a READ memory access.
>     =3D=3D1250=3D=3DHint: address points to the zero page.
>         #0 0x58560b in build_type_map selinux/libsepol/src/optimize.c:107=
:33
>         #1 0x58560b in policydb_optimize selinux/libsepol/src/optimize.c:=
441:13
>         #2 0x55e63e in LLVMFuzzerTestOneInput selinux/libsepol/fuzz/binpo=
licy-fuzzer.c:42:10
>         #3 0x455283 in fuzzer::Fuzzer::ExecuteCallback(unsigned char cons=
t*, unsigned long) cxa_noexception.cpp:0
>         #4 0x440ec2 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, u=
nsigned long) /src/llvm-project/compiler-rt/lib/fuzzer/FuzzerDriver.cpp:324=
:6
>         #5 0x44671c in fuzzer::FuzzerDriver(int*, char***, int (*)(unsign=
ed char const*, unsigned long)) cxa_noexception.cpp:0
>         #6 0x46f522 in main /src/llvm-project/compiler-rt/lib/fuzzer/Fuzz=
erMain.cpp:20:10
>         #7 0x7f9c160d00b2 in __libc_start_main /build/glibc-eX1tMB/glibc-=
2.31/csu/libc-start.c:308:16
>         #8 0x41f67d in _start
>
> Found by oss-fuzz (#42697)
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> @Jim:
>     I hope I have interpreted and implemented your feedback correctly, bu=
t I
>     am not sure I have seen through the whole gaps logic yet.
> ---
>  libsepol/src/kernel_to_cil.c  | 40 +++++++++++++++++++++++++++++++++++
>  libsepol/src/kernel_to_conf.c | 32 ++++++++++++++++++++++++++++
>  libsepol/src/optimize.c       | 18 +++++++++++++++-
>  3 files changed, 89 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 18294a9a..1353e77f 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -1227,6 +1227,14 @@ static int write_type_attributes_to_cil(FILE *out,=
 struct policydb *pdb)
>
>         for (i=3D0; i < pdb->p_types.nprim; i++) {
>                 type =3D pdb->type_val_to_struct[i];
> +               /* Gap in types for policy versions between 20 and 23 */
> +               if (!type) {
> +                       if (pdb->policyvers <=3D POLICYDB_VERSION_PERMISS=
IVE) {
> +                               rc =3D -1;
> +                               goto exit;
> +                       }
> +                       continue;
> +               }

There is already a check in sepol_kernel_policydb_to_cil() and an
error is returned if the policy version is between 20 and 23.
While no policy that is written by libsepol will have gaps in this
array, the validate_policydb() only checks that gaps are not referred
to by any rules, so there does need to be a check for a NULL here.

I would make the line below to be "if (type && type->flavor ..."

>                 if (type->flavor =3D=3D TYPE_ATTRIB) {
>                         rc =3D strs_add(strs, pdb->p_type_val_to_name[i])=
;
>                         if (rc !=3D 0) {
> @@ -1357,6 +1365,14 @@ static int write_type_decl_rules_to_cil(FILE *out,=
 struct policydb *pdb)
>
>         for (i=3D0; i < pdb->p_types.nprim; i++) {
>                 type =3D pdb->type_val_to_struct[i];
> +               /* Gap in types for policy versions between 20 and 23 */
> +               if (!type) {
> +                       if (pdb->policyvers <=3D POLICYDB_VERSION_PERMISS=
IVE) {
> +                               rc =3D -1;
> +                               goto exit;
> +                       }
> +                       continue;
> +               }

Same here.

>                 if (type->flavor =3D=3D TYPE_TYPE && type->primary) {
>                         rc =3D strs_add(strs, pdb->p_type_val_to_name[i])=
;
>                         if (rc !=3D 0) {
> @@ -1486,6 +1502,14 @@ static int write_type_bounds_rules_to_cil(FILE *ou=
t, struct policydb *pdb)
>
>         for (i=3D0; i < pdb->p_types.nprim; i++) {
>                 type =3D pdb->type_val_to_struct[i];
> +               /* Gap in types for policy versions between 20 and 23 */
> +               if (!type) {
> +                       if (pdb->policyvers <=3D POLICYDB_VERSION_PERMISS=
IVE) {
> +                               rc =3D -1;
> +                               goto exit;
> +                       }
> +                       continue;
> +               }

And here.

>                 if (type->flavor =3D=3D TYPE_TYPE) {
>                         if (type->bounds > 0) {
>                                 rc =3D strs_add(strs, pdb->p_type_val_to_=
name[i]);
> @@ -1540,6 +1564,14 @@ static int write_type_attribute_sets_to_cil(FILE *=
out, struct policydb *pdb)
>
>         for (i=3D0; i < pdb->p_types.nprim; i++) {
>                 attr =3D pdb->type_val_to_struct[i];
> +               /* Gap in types for policy versions between 20 and 23 */
> +               if (!attr) {
> +                       if (pdb->policyvers <=3D POLICYDB_VERSION_PERMISS=
IVE) {
> +                               rc =3D -1;
> +                               goto exit;
> +                       }
> +                       continue;
> +               }

And here.

>                 if (attr->flavor !=3D TYPE_ATTRIB) continue;
>                 name =3D pdb->p_type_val_to_name[i];
>                 typemap =3D &pdb->attr_type_map[i];
> @@ -2273,6 +2305,14 @@ static int write_role_decl_rules_to_cil(FILE *out,=
 struct policydb *pdb)
>
>         for (i=3D0; i < pdb->p_types.nprim; i++) {
>                 type_datum =3D pdb->type_val_to_struct[i];
> +               /* Gap in types for policy versions between 20 and 23 */
> +               if (!type_datum) {
> +                       if (pdb->policyvers <=3D POLICYDB_VERSION_PERMISS=
IVE) {
> +                               rc =3D -1;
> +                               goto exit;
> +                       }
> +                       continue;
> +               }

And here.

>                 if (type_datum->flavor =3D=3D TYPE_TYPE && type_datum->pr=
imary) {
>                         rc =3D strs_add(strs, pdb->p_type_val_to_name[i])=
;
>                         if (rc !=3D 0) {
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index a92ba9fd..235b4556 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -1210,6 +1210,14 @@ static int write_type_attributes_to_conf(FILE *out=
, struct policydb *pdb)
>
>         for (i=3D0; i < pdb->p_types.nprim; i++) {
>                 type =3D pdb->type_val_to_struct[i];
> +               /* Gap in types for policy versions between 20 and 23 */
> +               if (!type) {
> +                       if (pdb->policyvers <=3D POLICYDB_VERSION_PERMISS=
IVE) {
> +                               rc =3D -1;
> +                               goto exit;
> +                       }
> +                       continue;
> +               }

Same thing here. sepol_kernel_policydb_to_conf() already does a check
and returns an error if the policy version is between 20 and 23. All
the same comments above apply here.

>                 if (type->flavor =3D=3D TYPE_ATTRIB) {
>                         rc =3D strs_add(strs, pdb->p_type_val_to_name[i])=
;
>                         if (rc !=3D 0) {
> @@ -1340,6 +1348,14 @@ static int write_type_decl_rules_to_conf(FILE *out=
, struct policydb *pdb)
>
>         for (i=3D0; i < pdb->p_types.nprim; i++) {
>                 type =3D pdb->type_val_to_struct[i];
> +               /* Gap in types for policy versions between 20 and 23 */
> +               if (!type) {
> +                       if (pdb->policyvers <=3D POLICYDB_VERSION_PERMISS=
IVE) {
> +                               rc =3D -1;
> +                               goto exit;
> +                       }
> +                       continue;
> +               }
>                 if (type->flavor =3D=3D TYPE_TYPE && type->primary) {
>                         rc =3D strs_add(strs, pdb->p_type_val_to_name[i])=
;
>                         if (rc !=3D 0) {
> @@ -1460,6 +1476,14 @@ static int write_type_bounds_rules_to_conf(FILE *o=
ut, struct policydb *pdb)
>
>         for (i=3D0; i < pdb->p_types.nprim; i++) {
>                 type =3D pdb->type_val_to_struct[i];
> +               /* Gap in types for policy versions between 20 and 23 */
> +               if (!type) {
> +                       if (pdb->policyvers <=3D POLICYDB_VERSION_PERMISS=
IVE) {
> +                               rc =3D -1;
> +                               goto exit;
> +                       }
> +                       continue;
> +               }
>                 if (type->flavor =3D=3D TYPE_TYPE) {
>                         if (type->bounds > 0) {
>                                 rc =3D strs_add(strs, pdb->p_type_val_to_=
name[i]);
> @@ -1583,6 +1607,14 @@ static int write_type_attribute_sets_to_conf(FILE =
*out, struct policydb *pdb)
>
>         for (i=3D0; i < pdb->p_types.nprim; i++) {
>                 type =3D pdb->type_val_to_struct[i];
> +               /* Gap in types for policy versions between 20 and 23 */
> +               if (!type) {
> +                       if (pdb->policyvers <=3D POLICYDB_VERSION_PERMISS=
IVE) {
> +                               rc =3D -1;
> +                               goto exit;
> +                       }
> +                       continue;
> +               }
>                 if (type->flavor !=3D TYPE_TYPE || !type->primary) contin=
ue;
>                 if (ebitmap_cardinality(&pdb->type_attr_map[i]) =3D=3D 1)=
 continue;
>
> diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
> index 8a048702..f8c28313 100644
> --- a/libsepol/src/optimize.c
> +++ b/libsepol/src/optimize.c
> @@ -104,6 +104,13 @@ static struct type_vec *build_type_map(const policyd=
b_t *p)
>                 if (type_vec_init(&map[i]))
>                         goto err;
>
> +               /* Gap in types for policy versions between 20 and 23 */
> +               if (!p->type_val_to_struct[i]) {
> +                       if (p->policyvers <=3D POLICYDB_VERSION_PERMISSIV=
E)
> +                               goto err;
> +                       continue;
> +               }
> +

I want the same sort of check for the policy version done in
policydb_optimize(), not throughout the code.
Can still check for NULL.

>                 if (p->type_val_to_struct[i]->flavor !=3D TYPE_ATTRIB) {
>                         ebitmap_for_each_positive_bit(&p->type_attr_map[i=
],
>                                                       n, k) {
> @@ -114,11 +121,20 @@ static struct type_vec *build_type_map(const policy=
db_t *p)
>                         ebitmap_t *types_i =3D &p->attr_type_map[i];
>
>                         for (k =3D 0; k < p->p_types.nprim; k++) {
> -                               ebitmap_t *types_k =3D &p->attr_type_map[=
k];
> +                               ebitmap_t *types_k;
> +
> +                               /* Gap in types for policy versions betwe=
en 20 and 23 */
> +                               if (!p->type_val_to_struct[k]) {
> +                                       if (p->policyvers <=3D POLICYDB_V=
ERSION_PERMISSIVE)
> +                                               goto err;
> +                                       continue;
> +                               }

Same here.

Thanks,
Jim

>
>                                 if (p->type_val_to_struct[k]->flavor !=3D=
 TYPE_ATTRIB)
>                                         continue;
>
> +                               types_k =3D &p->attr_type_map[k];
> +
>                                 if (ebitmap_contains(types_k, types_i)) {
>                                         if (type_vec_append(&map[i], k))
>                                                 goto err;
> --
> 2.34.1
>
