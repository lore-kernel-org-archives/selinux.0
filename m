Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F65FC433F5
	for <selinux@archiver.kernel.org>; Tue, 25 Jan 2022 21:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiAYVR7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Jan 2022 16:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiAYVRt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Jan 2022 16:17:49 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5758C06173B
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 13:17:41 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 10-20020a9d030a000000b0059f164f4a86so10231988otv.13
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 13:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g6C8cNiocgyfpsssh2YdAqVKpMDh5IIrOzA6dOKoAos=;
        b=RyxndopaZ7MNhDJE4dqMCjk/VPIZ3OS4FHHmNcVoLqnNF+974VDYsevl/3Jp53b2VR
         88Iyq6uuyrnFqnJSgqm14ovai6qGI4VaIKGnM6rEvNDJ4nDR8tvq+hSahIr4b7+nDnbM
         vfzhPjyy9oQK8KK2Sbj8Ae3fThEIycHpJtTtD9Ul4XEAWCKIghwEXjEKud1wIrb21Bo5
         p14GFPUtvrmn7FzLjwFWyIIwwgJQJCZnf8kBAxzjbjJZSf1jTflmI0Zg9fTlEMe+X57V
         aCxgtGR4KJ861FWb3w6Qk2PmitWAzwFEVRdeUmfFSsu47YsZGjfRa5TKbmBscUMNjswP
         m5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g6C8cNiocgyfpsssh2YdAqVKpMDh5IIrOzA6dOKoAos=;
        b=pF+xOJA9GJ3cJHpOP6ziVMJAU5aFxDT0iQZH5JGTszKOQHBC+WvMAotHnpSARBS6Lc
         AG0vCl6fGXuDcIhs8go7BT7/oC7EVs+hu7lpwQyDg/r0V5um4VTAjigKfE6jWW9kA1Qt
         YQLluYuahRLE8pXdahJk9PeKwcvQ7gEZcPViV9IMBLxBhWgTSXO9x2jXQDE5onGoNDOg
         YDRpUzO/NkVbrQVUVosvDU+poitsyusno3ve8pyOcACytgCZnoLFrWmcBGBwigJNykF1
         1XQBohuSzordB7YVjJoTQoMyY2NcIT51/vG7rNw2QXp3meqvOfQoqaf/Ha9Lrxm8TPlm
         Bh7A==
X-Gm-Message-State: AOAM533e07YoN0japsHckmO4odSpjCKxFdrjDb7q92PxGvG0KfueiI1B
        viuJiOmuSCad7zZzV58lGHhpt86MjSxAl3XbR8SCa91Za8s=
X-Google-Smtp-Source: ABdhPJxb3OH33uVHwOtKXfDB8vdJh9r3yF5xSzCAqN7bAcKFUONGm3vVKEaaQrKvA4BsUoYGa3C7W18YOeP7EvZ7GiE=
X-Received: by 2002:a05:6830:794:: with SMTP id w20mr5788392ots.53.1643145461075;
 Tue, 25 Jan 2022 13:17:41 -0800 (PST)
MIME-Version: 1.0
References: <20211223185004.77862-1-cgzones@googlemail.com> <20220125133009.21405-1-cgzones@googlemail.com>
In-Reply-To: <20220125133009.21405-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 25 Jan 2022 16:17:30 -0500
Message-ID: <CAP+JOzStdDcHmU3EmvPtvqaRw+hCk4LV0noovUsbC8de+QjVHQ@mail.gmail.com>
Subject: Re: [PATCH v3] libsepol: handle type gaps
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 25, 2022 at 2:43 PM Christian G=C3=B6ttsche
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
>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v3:
>    - drop extra error blocks in kernel_to_(cil|conf).c in favor of a
>      simple non-NULL check, as writing policies between version 20 and
>      23 is not supported and previously checked
>    - refuse to optimize policies between version 20 and 23 altogether
>      and simplify NULL checks
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/kernel_to_cil.c  | 10 +++++-----
>  libsepol/src/kernel_to_conf.c |  8 ++++----
>  libsepol/src/optimize.c       | 21 +++++++++++++++++++--
>  3 files changed, 28 insertions(+), 11 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 18294a9a..693206d2 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -1227,7 +1227,7 @@ static int write_type_attributes_to_cil(FILE *out, =
struct policydb *pdb)
>
>         for (i=3D0; i < pdb->p_types.nprim; i++) {
>                 type =3D pdb->type_val_to_struct[i];
> -               if (type->flavor =3D=3D TYPE_ATTRIB) {
> +               if (type && type->flavor =3D=3D TYPE_ATTRIB) {
>                         rc =3D strs_add(strs, pdb->p_type_val_to_name[i])=
;
>                         if (rc !=3D 0) {
>                                 goto exit;
> @@ -1357,7 +1357,7 @@ static int write_type_decl_rules_to_cil(FILE *out, =
struct policydb *pdb)
>
>         for (i=3D0; i < pdb->p_types.nprim; i++) {
>                 type =3D pdb->type_val_to_struct[i];
> -               if (type->flavor =3D=3D TYPE_TYPE && type->primary) {
> +               if (type && type->flavor =3D=3D TYPE_TYPE && type->primar=
y) {
>                         rc =3D strs_add(strs, pdb->p_type_val_to_name[i])=
;
>                         if (rc !=3D 0) {
>                                 goto exit;
> @@ -1486,7 +1486,7 @@ static int write_type_bounds_rules_to_cil(FILE *out=
, struct policydb *pdb)
>
>         for (i=3D0; i < pdb->p_types.nprim; i++) {
>                 type =3D pdb->type_val_to_struct[i];
> -               if (type->flavor =3D=3D TYPE_TYPE) {
> +               if (type && type->flavor =3D=3D TYPE_TYPE) {
>                         if (type->bounds > 0) {
>                                 rc =3D strs_add(strs, pdb->p_type_val_to_=
name[i]);
>                                 if (rc !=3D 0) {
> @@ -1540,7 +1540,7 @@ static int write_type_attribute_sets_to_cil(FILE *o=
ut, struct policydb *pdb)
>
>         for (i=3D0; i < pdb->p_types.nprim; i++) {
>                 attr =3D pdb->type_val_to_struct[i];
> -               if (attr->flavor !=3D TYPE_ATTRIB) continue;
> +               if (!attr || attr->flavor !=3D TYPE_ATTRIB) continue;
>                 name =3D pdb->p_type_val_to_name[i];
>                 typemap =3D &pdb->attr_type_map[i];
>                 if (ebitmap_is_empty(typemap)) continue;
> @@ -2273,7 +2273,7 @@ static int write_role_decl_rules_to_cil(FILE *out, =
struct policydb *pdb)
>
>         for (i=3D0; i < pdb->p_types.nprim; i++) {
>                 type_datum =3D pdb->type_val_to_struct[i];
> -               if (type_datum->flavor =3D=3D TYPE_TYPE && type_datum->pr=
imary) {
> +               if (type_datum && type_datum->flavor =3D=3D TYPE_TYPE && =
type_datum->primary) {
>                         rc =3D strs_add(strs, pdb->p_type_val_to_name[i])=
;
>                         if (rc !=3D 0) {
>                                 goto exit;
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index a92ba9fd..52b6c60f 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -1210,7 +1210,7 @@ static int write_type_attributes_to_conf(FILE *out,=
 struct policydb *pdb)
>
>         for (i=3D0; i < pdb->p_types.nprim; i++) {
>                 type =3D pdb->type_val_to_struct[i];
> -               if (type->flavor =3D=3D TYPE_ATTRIB) {
> +               if (type && type->flavor =3D=3D TYPE_ATTRIB) {
>                         rc =3D strs_add(strs, pdb->p_type_val_to_name[i])=
;
>                         if (rc !=3D 0) {
>                                 goto exit;
> @@ -1340,7 +1340,7 @@ static int write_type_decl_rules_to_conf(FILE *out,=
 struct policydb *pdb)
>
>         for (i=3D0; i < pdb->p_types.nprim; i++) {
>                 type =3D pdb->type_val_to_struct[i];
> -               if (type->flavor =3D=3D TYPE_TYPE && type->primary) {
> +               if (type && type->flavor =3D=3D TYPE_TYPE && type->primar=
y) {
>                         rc =3D strs_add(strs, pdb->p_type_val_to_name[i])=
;
>                         if (rc !=3D 0) {
>                                 goto exit;
> @@ -1460,7 +1460,7 @@ static int write_type_bounds_rules_to_conf(FILE *ou=
t, struct policydb *pdb)
>
>         for (i=3D0; i < pdb->p_types.nprim; i++) {
>                 type =3D pdb->type_val_to_struct[i];
> -               if (type->flavor =3D=3D TYPE_TYPE) {
> +               if (type && type->flavor =3D=3D TYPE_TYPE) {
>                         if (type->bounds > 0) {
>                                 rc =3D strs_add(strs, pdb->p_type_val_to_=
name[i]);
>                                 if (rc !=3D 0) {
> @@ -1583,7 +1583,7 @@ static int write_type_attribute_sets_to_conf(FILE *=
out, struct policydb *pdb)
>
>         for (i=3D0; i < pdb->p_types.nprim; i++) {
>                 type =3D pdb->type_val_to_struct[i];
> -               if (type->flavor !=3D TYPE_TYPE || !type->primary) contin=
ue;
> +               if (!type || type->flavor !=3D TYPE_TYPE || !type->primar=
y) continue;
>                 if (ebitmap_cardinality(&pdb->type_attr_map[i]) =3D=3D 1)=
 continue;
>
>                 rc =3D ebitmap_cpy(&attrmap, &pdb->type_attr_map[i]);
> diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
> index 8a048702..93ff2116 100644
> --- a/libsepol/src/optimize.c
> +++ b/libsepol/src/optimize.c
> @@ -31,6 +31,7 @@
>  #include <sepol/policydb/policydb.h>
>  #include <sepol/policydb/conditional.h>
>
> +#include "debug.h"
>  #include "private.h"
>
>  #define TYPE_VEC_INIT_SIZE 16
> @@ -104,6 +105,9 @@ static struct type_vec *build_type_map(const policydb=
_t *p)
>                 if (type_vec_init(&map[i]))
>                         goto err;
>
> +               if (!p->type_val_to_struct[i])
> +                       continue;
> +
>                 if (p->type_val_to_struct[i]->flavor !=3D TYPE_ATTRIB) {
>                         ebitmap_for_each_positive_bit(&p->type_attr_map[i=
],
>                                                       n, k) {
> @@ -114,11 +118,13 @@ static struct type_vec *build_type_map(const policy=
db_t *p)
>                         ebitmap_t *types_i =3D &p->attr_type_map[i];
>
>                         for (k =3D 0; k < p->p_types.nprim; k++) {
> -                               ebitmap_t *types_k =3D &p->attr_type_map[=
k];
> +                               const ebitmap_t *types_k;
>
> -                               if (p->type_val_to_struct[k]->flavor !=3D=
 TYPE_ATTRIB)
> +                               if (!p->type_val_to_struct[k] || p->type_=
val_to_struct[k]->flavor !=3D TYPE_ATTRIB)
>                                         continue;
>
> +                               types_k =3D &p->attr_type_map[k];
> +
>                                 if (ebitmap_contains(types_k, types_i)) {
>                                         if (type_vec_append(&map[i], k))
>                                                 goto err;
> @@ -438,6 +444,17 @@ int policydb_optimize(policydb_t *p)
>         if (p->policy_type !=3D POLICY_KERN)
>                 return -1;
>
> +       if (p->policyvers >=3D POLICYDB_VERSION_AVTAB && p->policyvers <=
=3D POLICYDB_VERSION_PERMISSIVE) {
> +               /*
> +                * For policy versions between 20 and 23, attributes exis=
t in the policy,
> +                * but only in the type_attr_map. This means that there a=
re gaps in both
> +                * the type_val_to_struct and p_type_val_to_name arrays a=
nd policy rules
> +                * can refer to those gaps.
> +                */
> +               ERR(NULL, "Optimizing policy versions between 20 and 23 i=
s not supported");
> +               return -1;
> +       }
> +
>         type_map =3D build_type_map(p);
>         if (!type_map)
>                 return -1;
> --
> 2.34.1
>
