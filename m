Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB62C4332F
	for <selinux@archiver.kernel.org>; Mon, 13 Nov 2023 16:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjKMQHl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Nov 2023 11:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjKMQHl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Nov 2023 11:07:41 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705BC10F4
        for <selinux@vger.kernel.org>; Mon, 13 Nov 2023 08:07:36 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-509c61e0cf4so5226369e87.2
        for <selinux@vger.kernel.org>; Mon, 13 Nov 2023 08:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699891654; x=1700496454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcsJoKvm3cxfOpethkGZJgN4fy0BDMZ4Q0N1+iXKSec=;
        b=O96azlG2o8xOD3IleDYA9GlZBOXENCtYsvrTZ0HVijVboBr/jogvx10771rBJf2fnP
         PD9gpRWPTGLadzP2fj7WNt55qm8O7rMhJA/8i7x7gcGfP1CDz+xyoO2HZuE2o1upx38h
         taKPHBUXPHNK1rB6wtu8S9xkr3CGd6IYLPnsbFkWr1LtJpjGP/Vp0rBK+UTo17jWX9zz
         P6UWfMtMMlLkaqO+P2MyBHXS4LLw7hiipr1d2uxrXVqOERqxo4Coyey2cxVPO/OTgyVO
         2FDVerSHb483UK3x78XWQsq1epKoOiN5FNzdU5/+6WvEH/c1K9VvR0Us9VTpXhOFJDzb
         sQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699891654; x=1700496454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcsJoKvm3cxfOpethkGZJgN4fy0BDMZ4Q0N1+iXKSec=;
        b=IndBxf7LICQlpufuIPZxL9dl3PnEB7z7DogyQ5maPyrR1elapPH8SvGtR+O4BOSpGz
         x04zHnBM6AW/biqkEZUiuOEzrbS4M4WolRE++iYwBkLVOD07or6r/9+oD2xBvPX07lBH
         YXMWhh7ZxrHPNNntQ+MhxtDOUtKEI3tY2eY0tB6ahlgBba7l4DpJ7+aDRsJdwqw9fSkN
         IfhKfjXsFGwIPuiF7PQlmQ+9856RFSEGVtZ90NDZUQXOUpaCklMcJ2yr/KSKsPvJhG7V
         4k9AGR8c99N/oTZJClR97eJvlKjll8SNitagivwH/geGMV6sTbW2IGXDFs73DLGpVNyb
         1qCQ==
X-Gm-Message-State: AOJu0YwwCgOLjca4kyuN0wCwcAVxvkVt41go+zbUnSxMX3p1Iz+0y6uu
        4DVV6ns+K5O09DIfhNuJIUUmTigcX0nsDq2BifU=
X-Google-Smtp-Source: AGHT+IGO+3m1NBUtKXK+OxhJtPqmNXzS+WKXGpSbLjrjh94Spo6yFinRTjIU3vsEnGV/Afkp8Uglu4wUGE0HC+r30Ok=
X-Received: by 2002:ac2:424f:0:b0:509:494d:c3d5 with SMTP id
 m15-20020ac2424f000000b00509494dc3d5mr4015114lfl.26.1699891654164; Mon, 13
 Nov 2023 08:07:34 -0800 (PST)
MIME-Version: 1.0
References: <20231109135121.42380-1-cgzones@googlemail.com>
In-Reply-To: <20231109135121.42380-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 13 Nov 2023 11:07:22 -0500
Message-ID: <CAP+JOzRKRuzT209q8gN+bPa6U_KFEwLWVEuw6HK8SnP_CQz_0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] libsepol: use str_read() where appropriate
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 9, 2023 at 8:51=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Use the internal helper str_read() in more places while reading strings
> from a binary policy.  This improves readability and helps adjusting
> future sanity checks on inputs in fewer places.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these four patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb.c | 199 +++++++++-------------------------------
>  1 file changed, 41 insertions(+), 158 deletions(-)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index f9537caa..f608aba4 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -2108,7 +2108,8 @@ static int common_read(policydb_t * p, hashtab_t h,=
 struct policy_file *fp)
>                 goto bad;
>
>         len =3D le32_to_cpu(buf[0]);
> -       if (zero_or_saturated(len))
> +       rc =3D str_read(&key, fp, len);
> +       if (rc < 0)
>                 goto bad;
>
>         comdatum->s.value =3D le32_to_cpu(buf[1]);
> @@ -2120,14 +2121,6 @@ static int common_read(policydb_t * p, hashtab_t h=
, struct policy_file *fp)
>                 goto bad;
>         nel =3D le32_to_cpu(buf[3]);
>
> -       key =3D malloc(len + 1);
> -       if (!key)
> -               goto bad;
> -       rc =3D next_entry(key, fp, len);
> -       if (rc < 0)
> -               goto bad;
> -       key[len] =3D 0;
> -
>         for (i =3D 0; i < nel; i++) {
>                 if (perm_read(p, comdatum->permissions.table, fp, comdatu=
m->permissions.nprim))
>                         goto bad;
> @@ -2256,11 +2249,11 @@ static int class_read(policydb_t * p, hashtab_t h=
, struct policy_file *fp)
>                 goto bad;
>
>         len =3D le32_to_cpu(buf[0]);
> -       if (zero_or_saturated(len))
> +       rc =3D str_read(&key, fp, len);
> +       if (rc < 0)
>                 goto bad;
> +
>         len2 =3D le32_to_cpu(buf[1]);
> -       if (is_saturated(len2))
> -               goto bad;
>         cladatum->s.value =3D le32_to_cpu(buf[2]);
>
>         if (symtab_init(&cladatum->permissions, PERM_SYMTAB_SIZE))
> @@ -2272,22 +2265,10 @@ static int class_read(policydb_t * p, hashtab_t h=
, struct policy_file *fp)
>
>         ncons =3D le32_to_cpu(buf[5]);
>
> -       key =3D malloc(len + 1);
> -       if (!key)
> -               goto bad;
> -       rc =3D next_entry(key, fp, len);
> -       if (rc < 0)
> -               goto bad;
> -       key[len] =3D 0;
> -
>         if (len2) {
> -               cladatum->comkey =3D malloc(len2 + 1);
> -               if (!cladatum->comkey)
> -                       goto bad;
> -               rc =3D next_entry(cladatum->comkey, fp, len2);
> +               rc =3D str_read(&cladatum->comkey, fp, len2);
>                 if (rc < 0)
>                         goto bad;
> -               cladatum->comkey[len2] =3D 0;
>
>                 cladatum->comdatum =3D hashtab_search(p->p_commons.table,
>                                                     cladatum->comkey);
> @@ -2369,21 +2350,14 @@ static int role_read(policydb_t * p, hashtab_t h,=
 struct policy_file *fp)
>                 goto bad;
>
>         len =3D le32_to_cpu(buf[0]);
> -       if (zero_or_saturated(len))
> +       rc =3D str_read(&key, fp, len);
> +       if (rc < 0)
>                 goto bad;
>
>         role->s.value =3D le32_to_cpu(buf[1]);
>         if (policydb_has_boundary_feature(p))
>                 role->bounds =3D le32_to_cpu(buf[2]);
>
> -       key =3D malloc(len + 1);
> -       if (!key)
> -               goto bad;
> -       rc =3D next_entry(key, fp, len);
> -       if (rc < 0)
> -               goto bad;
> -       key[len] =3D 0;
> -
>         if (ebitmap_read(&role->dominates, fp))
>                 goto bad;
>
> @@ -2460,9 +2434,6 @@ static int type_read(policydb_t * p, hashtab_t h, s=
truct policy_file *fp)
>                 goto bad;
>
>         len =3D le32_to_cpu(buf[pos]);
> -       if (zero_or_saturated(len))
> -               goto bad;
> -
>         typdatum->s.value =3D le32_to_cpu(buf[++pos]);
>         if (policydb_has_boundary_feature(p)) {
>                 uint32_t properties;
> @@ -2503,13 +2474,9 @@ static int type_read(policydb_t * p, hashtab_t h, =
struct policy_file *fp)
>                         goto bad;
>         }
>
> -       key =3D malloc(len + 1);
> -       if (!key)
> -               goto bad;
> -       rc =3D next_entry(key, fp, len);
> +       rc =3D str_read(&key, fp, len);
>         if (rc < 0)
>                 goto bad;
> -       key[len] =3D 0;
>
>         if (hashtab_insert(h, key, typdatum))
>                 goto bad;
> @@ -2681,14 +2648,8 @@ static int filename_trans_read_one_compat(policydb=
_t *p, struct policy_file *fp)
>         if (rc < 0)
>                 return -1;
>         len =3D le32_to_cpu(buf[0]);
> -       if (zero_or_saturated(len))
> -               return -1;
> -
> -       name =3D calloc(len + 1, sizeof(*name));
> -       if (!name)
> -               return -1;
>
> -       rc =3D next_entry(name, fp, len);
> +       rc =3D str_read(&name, fp, len);
>         if (rc < 0)
>                 goto err;
>
> @@ -2766,14 +2727,8 @@ static int filename_trans_read_one(policydb_t *p, =
struct policy_file *fp)
>         if (rc < 0)
>                 return -1;
>         len =3D le32_to_cpu(buf[0]);
> -       if (zero_or_saturated(len))
> -               return -1;
> -
> -       name =3D calloc(len + 1, sizeof(*name));
> -       if (!name)
> -               return -1;
>
> -       rc =3D next_entry(name, fp, len);
> +       rc =3D str_read(&name, fp, len);
>         if (rc < 0)
>                 goto err;
>
> @@ -2957,16 +2912,9 @@ static int ocontext_read_xen(const struct policydb=
_compat_info *info,
>                                 if (rc < 0)
>                                         return -1;
>                                 len =3D le32_to_cpu(buf[0]);
> -                               if (zero_or_saturated(len))
> -                                       return -1;
> -
> -                               c->u.name =3D malloc(len + 1);
> -                               if (!c->u.name)
> -                                       return -1;
> -                               rc =3D next_entry(c->u.name, fp, len);
> +                               rc =3D str_read(&c->u.name, fp, len);
>                                 if (rc < 0)
>                                         return -1;
> -                               c->u.name[len] =3D 0;
>                                 if (context_read_and_validate
>                                     (&c->context[0], p, fp))
>                                         return -1;
> @@ -3024,15 +2972,13 @@ static int ocontext_read_selinux(const struct pol=
icydb_compat_info *info,
>                                 if (rc < 0)
>                                         return -1;
>                                 len =3D le32_to_cpu(buf[0]);
> -                               if (zero_or_saturated(len) || len > 63)
> +                               if (len > 63)
>                                         return -1;
> -                               c->u.name =3D malloc(len + 1);
> -                               if (!c->u.name)
> -                                       return -1;
> -                               rc =3D next_entry(c->u.name, fp, len);
> +
> +                               rc =3D str_read(&c->u.name, fp, len);
>                                 if (rc < 0)
>                                         return -1;
> -                               c->u.name[len] =3D 0;
> +
>                                 if (context_read_and_validate
>                                     (&c->context[0], p, fp))
>                                         return -1;
> @@ -3080,13 +3026,10 @@ static int ocontext_read_selinux(const struct pol=
icydb_compat_info *info,
>                                 if (port > UINT8_MAX || port =3D=3D 0)
>                                         return -1;
>
> -                               c->u.ibendport.dev_name =3D malloc(len + =
1);
> -                               if (!c->u.ibendport.dev_name)
> -                                       return -1;
> -                               rc =3D next_entry(c->u.ibendport.dev_name=
, fp, len);
> +                               rc =3D str_read(&c->u.ibendport.dev_name,=
 fp, len);
>                                 if (rc < 0)
>                                         return -1;
> -                               c->u.ibendport.dev_name[len] =3D 0;
> +
>                                 c->u.ibendport.port =3D port;
>                                 if (context_read_and_validate
>                                     (&c->context[0], p, fp))
> @@ -3120,15 +3063,11 @@ static int ocontext_read_selinux(const struct pol=
icydb_compat_info *info,
>                                         return -1;
>                                 c->v.behavior =3D le32_to_cpu(buf[0]);
>                                 len =3D le32_to_cpu(buf[1]);
> -                               if (zero_or_saturated(len))
> -                                       return -1;
> -                               c->u.name =3D malloc(len + 1);
> -                               if (!c->u.name)
> -                                       return -1;
> -                               rc =3D next_entry(c->u.name, fp, len);
> +
> +                               rc =3D str_read(&c->u.name, fp, len);
>                                 if (rc < 0)
>                                         return -1;
> -                               c->u.name[len] =3D 0;
> +
>                                 if (context_read_and_validate
>                                     (&c->context[0], p, fp))
>                                         return -1;
> @@ -3196,23 +3135,17 @@ static int genfs_read(policydb_t * p, struct poli=
cy_file *fp)
>                 if (rc < 0)
>                         goto bad;
>                 len =3D le32_to_cpu(buf[0]);
> -               if (zero_or_saturated(len))
> -                       goto bad;
>                 newgenfs =3D calloc(1, sizeof(genfs_t));
>                 if (!newgenfs)
>                         goto bad;
> -               newgenfs->fstype =3D malloc(len + 1);
> -               if (!newgenfs->fstype) {
> -                       free(newgenfs);
> -                       goto bad;
> -               }
> -               rc =3D next_entry(newgenfs->fstype, fp, len);
> +
> +               rc =3D str_read(&newgenfs->fstype, fp, len);
>                 if (rc < 0) {
>                         free(newgenfs->fstype);
>                         free(newgenfs);
>                         goto bad;
>                 }
> -               newgenfs->fstype[len] =3D 0;
> +
>                 for (genfs_p =3D NULL, genfs =3D p->genfs; genfs;
>                      genfs_p =3D genfs, genfs =3D genfs->next) {
>                         if (strcmp(newgenfs->fstype, genfs->fstype) =3D=
=3D 0) {
> @@ -3243,16 +3176,10 @@ static int genfs_read(policydb_t * p, struct poli=
cy_file *fp)
>                         if (rc < 0)
>                                 goto bad;
>                         len =3D le32_to_cpu(buf[0]);
> -                       if (zero_or_saturated(len))
> -                               goto bad;
> -                       newc->u.name =3D malloc(len + 1);
> -                       if (!newc->u.name) {
> -                               goto bad;
> -                       }
> -                       rc =3D next_entry(newc->u.name, fp, len);
> +                       rc =3D str_read(&newc->u.name, fp, len);
>                         if (rc < 0)
>                                 goto bad;
> -                       newc->u.name[len] =3D 0;
> +
>                         rc =3D next_entry(buf, fp, sizeof(uint32_t));
>                         if (rc < 0)
>                                 goto bad;
> @@ -3344,21 +3271,14 @@ static int user_read(policydb_t * p, hashtab_t h,=
 struct policy_file *fp)
>                 goto bad;
>
>         len =3D le32_to_cpu(buf[0]);
> -       if (zero_or_saturated(len))
> +       rc =3D str_read(&key, fp, len);
> +       if (rc < 0)
>                 goto bad;
>
>         usrdatum->s.value =3D le32_to_cpu(buf[1]);
>         if (policydb_has_boundary_feature(p))
>                 usrdatum->bounds =3D le32_to_cpu(buf[2]);
>
> -       key =3D malloc(len + 1);
> -       if (!key)
> -               goto bad;
> -       rc =3D next_entry(key, fp, len);
> -       if (rc < 0)
> -               goto bad;
> -       key[len] =3D 0;
> -
>         if (p->policy_type =3D=3D POLICY_KERN) {
>                 if (ebitmap_read(&usrdatum->roles.roles, fp))
>                         goto bad;
> @@ -3430,19 +3350,12 @@ static int sens_read(policydb_t * p
>                 goto bad;
>
>         len =3D le32_to_cpu(buf[0]);
> -       if (zero_or_saturated(len))
> +       rc =3D str_read(&key, fp, len);
> +       if (rc < 0)
>                 goto bad;
>
>         levdatum->isalias =3D le32_to_cpu(buf[1]);
>
> -       key =3D malloc(len + 1);
> -       if (!key)
> -               goto bad;
> -       rc =3D next_entry(key, fp, len);
> -       if (rc < 0)
> -               goto bad;
> -       key[len] =3D 0;
> -
>         levdatum->level =3D malloc(sizeof(mls_level_t));
>         if (!levdatum->level || mls_read_level(levdatum->level, fp))
>                 goto bad;
> @@ -3476,20 +3389,13 @@ static int cat_read(policydb_t * p
>                 goto bad;
>
>         len =3D le32_to_cpu(buf[0]);
> -       if(zero_or_saturated(len))
> +       rc =3D str_read(&key, fp, len);
> +       if (rc < 0)
>                 goto bad;
>
>         catdatum->s.value =3D le32_to_cpu(buf[1]);
>         catdatum->isalias =3D le32_to_cpu(buf[2]);
>
> -       key =3D malloc(len + 1);
> -       if (!key)
> -               goto bad;
> -       rc =3D next_entry(key, fp, len);
> -       if (rc < 0)
> -               goto bad;
> -       key[len] =3D 0;
> -
>         if (hashtab_insert(h, key, catdatum))
>                 goto bad;
>
> @@ -3865,17 +3771,10 @@ static int filename_trans_rule_read(policydb_t *p=
, filename_trans_rule_t **r,
>                         return -1;
>
>                 len =3D le32_to_cpu(buf[0]);
> -               if (zero_or_saturated(len))
> -                       return -1;
>
> -               ftr->name =3D malloc(len + 1);
> -               if (!ftr->name)
> -                       return -1;
> -
> -               rc =3D next_entry(ftr->name, fp, len);
> -               if (rc)
> +               rc =3D str_read(&ftr->name, fp, len);
> +               if (rc < 0)
>                         return -1;
> -               ftr->name[len] =3D 0;
>
>                 if (type_set_read(&ftr->stypes, fp))
>                         return -1;
> @@ -4119,15 +4018,10 @@ static int scope_read(policydb_t * p, int symnum,=
 struct policy_file *fp)
>         if (rc < 0)
>                 goto cleanup;
>         key_len =3D le32_to_cpu(buf[0]);
> -       if (zero_or_saturated(key_len))
> -               goto cleanup;
> -       key =3D malloc(key_len + 1);
> -       if (!key)
> -               goto cleanup;
> -       rc =3D next_entry(key, fp, key_len);
> +
> +       rc =3D str_read(&key, fp, key_len);
>         if (rc < 0)
>                 goto cleanup;
> -       key[key_len] =3D '\0';
>
>         /* ensure that there already exists a symbol with this key */
>         if (hashtab_search(p->symtab[symnum].table, key) =3D=3D NULL) {
> @@ -4387,28 +4281,17 @@ int policydb_read(policydb_t * p, struct policy_f=
ile *fp, unsigned verbose)
>                         goto bad;
>                 }
>                 len =3D le32_to_cpu(buf[0]);
> -               if (zero_or_saturated(len))
> -                       goto bad;
> -               if ((p->name =3D malloc(len + 1)) =3D=3D NULL) {
> -                       goto bad;
> -               }
> -               if ((rc =3D next_entry(p->name, fp, len)) < 0) {
> +               rc =3D str_read(&p->name, fp, len);
> +               if (rc < 0)
>                         goto bad;
> -               }
> -               p->name[len] =3D '\0';
> +
>                 if ((rc =3D next_entry(buf, fp, sizeof(uint32_t))) < 0) {
>                         goto bad;
>                 }
>                 len =3D le32_to_cpu(buf[0]);
> -               if (zero_or_saturated(len))
> -                       goto bad;
> -               if ((p->version =3D malloc(len + 1)) =3D=3D NULL) {
> -                       goto bad;
> -               }
> -               if ((rc =3D next_entry(p->version, fp, len)) < 0) {
> +               rc =3D str_read(&p->version, fp, len);
> +               if (rc < 0)
>                         goto bad;
> -               }
> -               p->version[len] =3D '\0';
>         }
>
>         if ((p->policyvers >=3D POLICYDB_VERSION_POLCAP &&
> --
> 2.42.0
>
