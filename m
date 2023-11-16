Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D077BC54FB9
	for <selinux@archiver.kernel.org>; Thu, 16 Nov 2023 14:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343893AbjKPOzm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Nov 2023 09:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKPOzl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Nov 2023 09:55:41 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC9BB5
        for <selinux@vger.kernel.org>; Thu, 16 Nov 2023 06:55:36 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507975d34e8so1263458e87.1
        for <selinux@vger.kernel.org>; Thu, 16 Nov 2023 06:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700146534; x=1700751334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5RSr8RsHdbQ9SQ8Gvz/iRft62yMRCsq3iHOroXGpHU=;
        b=Ja9GiOM1dX2iuFgFmPQmAc3WgWBuw0CRyU3QMPcW3zdlp0NBRqbE9oemiGkPpF7pN5
         Zb6YzkXuv17KOWFc12reENWEoCPjJtRDSZpX/m5m1CLlycIHzZUcaHcnlUTLbOylFQG5
         +2CrtxVDyVBeUKrIQMaRP7ANKQ+v1aLFkdfyvye16GyZWhINVt9PzLbPAvDsCm+4uvyV
         Vp/jiDNAKFMGux164OCGVpoRFUoMJNZVjNlfiFBHJNa4dMR2KwA2BoH8CHpkBUVP3XGI
         kynTB0CYhNaHpCpCjAsv6PzPQDqet0C4PtNltGGRscLIEDnXH1/gk9MWgyvqp8rwgF+S
         +2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146534; x=1700751334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5RSr8RsHdbQ9SQ8Gvz/iRft62yMRCsq3iHOroXGpHU=;
        b=bRb7E6czinVe7asSzXltb4B2fQ+pGhOyAaIIGX8rQS7zLMyCZSNcQKQOMpfUnE56Jk
         ROQWXIH/nTils6iOih+hmqPB33jeoRSJn3VkYmwD4SqdTmPcm1YHlj1TlDQBGrXkz88G
         xsvxVqJ+fyOd5/q33ZoFLkeqpgYMyCFRHe3spcViLulb24pd9RtCM2afyWiPtWYD5sDS
         NULMYrf2jpHCOxVOIrWBVDh8CRTxlfVJIIYWLpUNX9clR04MxFX8dHobi96anZopQmml
         hPWrCiVLX5NdSdFJHFCQ0I5XZNmhXVauy24qo/y2rfPty/KAi5ewJuI6FFG42DQuG/Bs
         F7Pg==
X-Gm-Message-State: AOJu0YwT7VdCTRFH7oSG7Li3fUuzpCoJOv7u4e7EkL5/H9GFiZRykNDk
        IhsZLURf61TGBRTy84z0MdvzyBHY26R1XQa6waLr0kTr
X-Google-Smtp-Source: AGHT+IFFBZbn+nByq3s/JXIfVeNL2rsUyKGQvRtP8knLAhEjfNM7qOLTUGIrlJIm+hx7dlPkwFtrK0msM9tFoqPICuc=
X-Received: by 2002:a05:6512:3441:b0:507:99fe:28f3 with SMTP id
 j1-20020a056512344100b0050799fe28f3mr10143424lfr.34.1700146533860; Thu, 16
 Nov 2023 06:55:33 -0800 (PST)
MIME-Version: 1.0
References: <20231109135121.42380-1-cgzones@googlemail.com> <CAP+JOzRKRuzT209q8gN+bPa6U_KFEwLWVEuw6HK8SnP_CQz_0A@mail.gmail.com>
In-Reply-To: <CAP+JOzRKRuzT209q8gN+bPa6U_KFEwLWVEuw6HK8SnP_CQz_0A@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 16 Nov 2023 09:55:22 -0500
Message-ID: <CAP+JOzRbOd3Vr2B6R1BsZKj6ecTc08xa2kB8ksMqxgPQ0n-iAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] libsepol: use str_read() where appropriate
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 13, 2023 at 11:07=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Thu, Nov 9, 2023 at 8:51=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Use the internal helper str_read() in more places while reading strings
> > from a binary policy.  This improves readability and helps adjusting
> > future sanity checks on inputs in fewer places.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these four patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These four patches have been merged.
Thanks,
Jim

> > ---
> >  libsepol/src/policydb.c | 199 +++++++++-------------------------------
> >  1 file changed, 41 insertions(+), 158 deletions(-)
> >
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > index f9537caa..f608aba4 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > @@ -2108,7 +2108,8 @@ static int common_read(policydb_t * p, hashtab_t =
h, struct policy_file *fp)
> >                 goto bad;
> >
> >         len =3D le32_to_cpu(buf[0]);
> > -       if (zero_or_saturated(len))
> > +       rc =3D str_read(&key, fp, len);
> > +       if (rc < 0)
> >                 goto bad;
> >
> >         comdatum->s.value =3D le32_to_cpu(buf[1]);
> > @@ -2120,14 +2121,6 @@ static int common_read(policydb_t * p, hashtab_t=
 h, struct policy_file *fp)
> >                 goto bad;
> >         nel =3D le32_to_cpu(buf[3]);
> >
> > -       key =3D malloc(len + 1);
> > -       if (!key)
> > -               goto bad;
> > -       rc =3D next_entry(key, fp, len);
> > -       if (rc < 0)
> > -               goto bad;
> > -       key[len] =3D 0;
> > -
> >         for (i =3D 0; i < nel; i++) {
> >                 if (perm_read(p, comdatum->permissions.table, fp, comda=
tum->permissions.nprim))
> >                         goto bad;
> > @@ -2256,11 +2249,11 @@ static int class_read(policydb_t * p, hashtab_t=
 h, struct policy_file *fp)
> >                 goto bad;
> >
> >         len =3D le32_to_cpu(buf[0]);
> > -       if (zero_or_saturated(len))
> > +       rc =3D str_read(&key, fp, len);
> > +       if (rc < 0)
> >                 goto bad;
> > +
> >         len2 =3D le32_to_cpu(buf[1]);
> > -       if (is_saturated(len2))
> > -               goto bad;
> >         cladatum->s.value =3D le32_to_cpu(buf[2]);
> >
> >         if (symtab_init(&cladatum->permissions, PERM_SYMTAB_SIZE))
> > @@ -2272,22 +2265,10 @@ static int class_read(policydb_t * p, hashtab_t=
 h, struct policy_file *fp)
> >
> >         ncons =3D le32_to_cpu(buf[5]);
> >
> > -       key =3D malloc(len + 1);
> > -       if (!key)
> > -               goto bad;
> > -       rc =3D next_entry(key, fp, len);
> > -       if (rc < 0)
> > -               goto bad;
> > -       key[len] =3D 0;
> > -
> >         if (len2) {
> > -               cladatum->comkey =3D malloc(len2 + 1);
> > -               if (!cladatum->comkey)
> > -                       goto bad;
> > -               rc =3D next_entry(cladatum->comkey, fp, len2);
> > +               rc =3D str_read(&cladatum->comkey, fp, len2);
> >                 if (rc < 0)
> >                         goto bad;
> > -               cladatum->comkey[len2] =3D 0;
> >
> >                 cladatum->comdatum =3D hashtab_search(p->p_commons.tabl=
e,
> >                                                     cladatum->comkey);
> > @@ -2369,21 +2350,14 @@ static int role_read(policydb_t * p, hashtab_t =
h, struct policy_file *fp)
> >                 goto bad;
> >
> >         len =3D le32_to_cpu(buf[0]);
> > -       if (zero_or_saturated(len))
> > +       rc =3D str_read(&key, fp, len);
> > +       if (rc < 0)
> >                 goto bad;
> >
> >         role->s.value =3D le32_to_cpu(buf[1]);
> >         if (policydb_has_boundary_feature(p))
> >                 role->bounds =3D le32_to_cpu(buf[2]);
> >
> > -       key =3D malloc(len + 1);
> > -       if (!key)
> > -               goto bad;
> > -       rc =3D next_entry(key, fp, len);
> > -       if (rc < 0)
> > -               goto bad;
> > -       key[len] =3D 0;
> > -
> >         if (ebitmap_read(&role->dominates, fp))
> >                 goto bad;
> >
> > @@ -2460,9 +2434,6 @@ static int type_read(policydb_t * p, hashtab_t h,=
 struct policy_file *fp)
> >                 goto bad;
> >
> >         len =3D le32_to_cpu(buf[pos]);
> > -       if (zero_or_saturated(len))
> > -               goto bad;
> > -
> >         typdatum->s.value =3D le32_to_cpu(buf[++pos]);
> >         if (policydb_has_boundary_feature(p)) {
> >                 uint32_t properties;
> > @@ -2503,13 +2474,9 @@ static int type_read(policydb_t * p, hashtab_t h=
, struct policy_file *fp)
> >                         goto bad;
> >         }
> >
> > -       key =3D malloc(len + 1);
> > -       if (!key)
> > -               goto bad;
> > -       rc =3D next_entry(key, fp, len);
> > +       rc =3D str_read(&key, fp, len);
> >         if (rc < 0)
> >                 goto bad;
> > -       key[len] =3D 0;
> >
> >         if (hashtab_insert(h, key, typdatum))
> >                 goto bad;
> > @@ -2681,14 +2648,8 @@ static int filename_trans_read_one_compat(policy=
db_t *p, struct policy_file *fp)
> >         if (rc < 0)
> >                 return -1;
> >         len =3D le32_to_cpu(buf[0]);
> > -       if (zero_or_saturated(len))
> > -               return -1;
> > -
> > -       name =3D calloc(len + 1, sizeof(*name));
> > -       if (!name)
> > -               return -1;
> >
> > -       rc =3D next_entry(name, fp, len);
> > +       rc =3D str_read(&name, fp, len);
> >         if (rc < 0)
> >                 goto err;
> >
> > @@ -2766,14 +2727,8 @@ static int filename_trans_read_one(policydb_t *p=
, struct policy_file *fp)
> >         if (rc < 0)
> >                 return -1;
> >         len =3D le32_to_cpu(buf[0]);
> > -       if (zero_or_saturated(len))
> > -               return -1;
> > -
> > -       name =3D calloc(len + 1, sizeof(*name));
> > -       if (!name)
> > -               return -1;
> >
> > -       rc =3D next_entry(name, fp, len);
> > +       rc =3D str_read(&name, fp, len);
> >         if (rc < 0)
> >                 goto err;
> >
> > @@ -2957,16 +2912,9 @@ static int ocontext_read_xen(const struct policy=
db_compat_info *info,
> >                                 if (rc < 0)
> >                                         return -1;
> >                                 len =3D le32_to_cpu(buf[0]);
> > -                               if (zero_or_saturated(len))
> > -                                       return -1;
> > -
> > -                               c->u.name =3D malloc(len + 1);
> > -                               if (!c->u.name)
> > -                                       return -1;
> > -                               rc =3D next_entry(c->u.name, fp, len);
> > +                               rc =3D str_read(&c->u.name, fp, len);
> >                                 if (rc < 0)
> >                                         return -1;
> > -                               c->u.name[len] =3D 0;
> >                                 if (context_read_and_validate
> >                                     (&c->context[0], p, fp))
> >                                         return -1;
> > @@ -3024,15 +2972,13 @@ static int ocontext_read_selinux(const struct p=
olicydb_compat_info *info,
> >                                 if (rc < 0)
> >                                         return -1;
> >                                 len =3D le32_to_cpu(buf[0]);
> > -                               if (zero_or_saturated(len) || len > 63)
> > +                               if (len > 63)
> >                                         return -1;
> > -                               c->u.name =3D malloc(len + 1);
> > -                               if (!c->u.name)
> > -                                       return -1;
> > -                               rc =3D next_entry(c->u.name, fp, len);
> > +
> > +                               rc =3D str_read(&c->u.name, fp, len);
> >                                 if (rc < 0)
> >                                         return -1;
> > -                               c->u.name[len] =3D 0;
> > +
> >                                 if (context_read_and_validate
> >                                     (&c->context[0], p, fp))
> >                                         return -1;
> > @@ -3080,13 +3026,10 @@ static int ocontext_read_selinux(const struct p=
olicydb_compat_info *info,
> >                                 if (port > UINT8_MAX || port =3D=3D 0)
> >                                         return -1;
> >
> > -                               c->u.ibendport.dev_name =3D malloc(len =
+ 1);
> > -                               if (!c->u.ibendport.dev_name)
> > -                                       return -1;
> > -                               rc =3D next_entry(c->u.ibendport.dev_na=
me, fp, len);
> > +                               rc =3D str_read(&c->u.ibendport.dev_nam=
e, fp, len);
> >                                 if (rc < 0)
> >                                         return -1;
> > -                               c->u.ibendport.dev_name[len] =3D 0;
> > +
> >                                 c->u.ibendport.port =3D port;
> >                                 if (context_read_and_validate
> >                                     (&c->context[0], p, fp))
> > @@ -3120,15 +3063,11 @@ static int ocontext_read_selinux(const struct p=
olicydb_compat_info *info,
> >                                         return -1;
> >                                 c->v.behavior =3D le32_to_cpu(buf[0]);
> >                                 len =3D le32_to_cpu(buf[1]);
> > -                               if (zero_or_saturated(len))
> > -                                       return -1;
> > -                               c->u.name =3D malloc(len + 1);
> > -                               if (!c->u.name)
> > -                                       return -1;
> > -                               rc =3D next_entry(c->u.name, fp, len);
> > +
> > +                               rc =3D str_read(&c->u.name, fp, len);
> >                                 if (rc < 0)
> >                                         return -1;
> > -                               c->u.name[len] =3D 0;
> > +
> >                                 if (context_read_and_validate
> >                                     (&c->context[0], p, fp))
> >                                         return -1;
> > @@ -3196,23 +3135,17 @@ static int genfs_read(policydb_t * p, struct po=
licy_file *fp)
> >                 if (rc < 0)
> >                         goto bad;
> >                 len =3D le32_to_cpu(buf[0]);
> > -               if (zero_or_saturated(len))
> > -                       goto bad;
> >                 newgenfs =3D calloc(1, sizeof(genfs_t));
> >                 if (!newgenfs)
> >                         goto bad;
> > -               newgenfs->fstype =3D malloc(len + 1);
> > -               if (!newgenfs->fstype) {
> > -                       free(newgenfs);
> > -                       goto bad;
> > -               }
> > -               rc =3D next_entry(newgenfs->fstype, fp, len);
> > +
> > +               rc =3D str_read(&newgenfs->fstype, fp, len);
> >                 if (rc < 0) {
> >                         free(newgenfs->fstype);
> >                         free(newgenfs);
> >                         goto bad;
> >                 }
> > -               newgenfs->fstype[len] =3D 0;
> > +
> >                 for (genfs_p =3D NULL, genfs =3D p->genfs; genfs;
> >                      genfs_p =3D genfs, genfs =3D genfs->next) {
> >                         if (strcmp(newgenfs->fstype, genfs->fstype) =3D=
=3D 0) {
> > @@ -3243,16 +3176,10 @@ static int genfs_read(policydb_t * p, struct po=
licy_file *fp)
> >                         if (rc < 0)
> >                                 goto bad;
> >                         len =3D le32_to_cpu(buf[0]);
> > -                       if (zero_or_saturated(len))
> > -                               goto bad;
> > -                       newc->u.name =3D malloc(len + 1);
> > -                       if (!newc->u.name) {
> > -                               goto bad;
> > -                       }
> > -                       rc =3D next_entry(newc->u.name, fp, len);
> > +                       rc =3D str_read(&newc->u.name, fp, len);
> >                         if (rc < 0)
> >                                 goto bad;
> > -                       newc->u.name[len] =3D 0;
> > +
> >                         rc =3D next_entry(buf, fp, sizeof(uint32_t));
> >                         if (rc < 0)
> >                                 goto bad;
> > @@ -3344,21 +3271,14 @@ static int user_read(policydb_t * p, hashtab_t =
h, struct policy_file *fp)
> >                 goto bad;
> >
> >         len =3D le32_to_cpu(buf[0]);
> > -       if (zero_or_saturated(len))
> > +       rc =3D str_read(&key, fp, len);
> > +       if (rc < 0)
> >                 goto bad;
> >
> >         usrdatum->s.value =3D le32_to_cpu(buf[1]);
> >         if (policydb_has_boundary_feature(p))
> >                 usrdatum->bounds =3D le32_to_cpu(buf[2]);
> >
> > -       key =3D malloc(len + 1);
> > -       if (!key)
> > -               goto bad;
> > -       rc =3D next_entry(key, fp, len);
> > -       if (rc < 0)
> > -               goto bad;
> > -       key[len] =3D 0;
> > -
> >         if (p->policy_type =3D=3D POLICY_KERN) {
> >                 if (ebitmap_read(&usrdatum->roles.roles, fp))
> >                         goto bad;
> > @@ -3430,19 +3350,12 @@ static int sens_read(policydb_t * p
> >                 goto bad;
> >
> >         len =3D le32_to_cpu(buf[0]);
> > -       if (zero_or_saturated(len))
> > +       rc =3D str_read(&key, fp, len);
> > +       if (rc < 0)
> >                 goto bad;
> >
> >         levdatum->isalias =3D le32_to_cpu(buf[1]);
> >
> > -       key =3D malloc(len + 1);
> > -       if (!key)
> > -               goto bad;
> > -       rc =3D next_entry(key, fp, len);
> > -       if (rc < 0)
> > -               goto bad;
> > -       key[len] =3D 0;
> > -
> >         levdatum->level =3D malloc(sizeof(mls_level_t));
> >         if (!levdatum->level || mls_read_level(levdatum->level, fp))
> >                 goto bad;
> > @@ -3476,20 +3389,13 @@ static int cat_read(policydb_t * p
> >                 goto bad;
> >
> >         len =3D le32_to_cpu(buf[0]);
> > -       if(zero_or_saturated(len))
> > +       rc =3D str_read(&key, fp, len);
> > +       if (rc < 0)
> >                 goto bad;
> >
> >         catdatum->s.value =3D le32_to_cpu(buf[1]);
> >         catdatum->isalias =3D le32_to_cpu(buf[2]);
> >
> > -       key =3D malloc(len + 1);
> > -       if (!key)
> > -               goto bad;
> > -       rc =3D next_entry(key, fp, len);
> > -       if (rc < 0)
> > -               goto bad;
> > -       key[len] =3D 0;
> > -
> >         if (hashtab_insert(h, key, catdatum))
> >                 goto bad;
> >
> > @@ -3865,17 +3771,10 @@ static int filename_trans_rule_read(policydb_t =
*p, filename_trans_rule_t **r,
> >                         return -1;
> >
> >                 len =3D le32_to_cpu(buf[0]);
> > -               if (zero_or_saturated(len))
> > -                       return -1;
> >
> > -               ftr->name =3D malloc(len + 1);
> > -               if (!ftr->name)
> > -                       return -1;
> > -
> > -               rc =3D next_entry(ftr->name, fp, len);
> > -               if (rc)
> > +               rc =3D str_read(&ftr->name, fp, len);
> > +               if (rc < 0)
> >                         return -1;
> > -               ftr->name[len] =3D 0;
> >
> >                 if (type_set_read(&ftr->stypes, fp))
> >                         return -1;
> > @@ -4119,15 +4018,10 @@ static int scope_read(policydb_t * p, int symnu=
m, struct policy_file *fp)
> >         if (rc < 0)
> >                 goto cleanup;
> >         key_len =3D le32_to_cpu(buf[0]);
> > -       if (zero_or_saturated(key_len))
> > -               goto cleanup;
> > -       key =3D malloc(key_len + 1);
> > -       if (!key)
> > -               goto cleanup;
> > -       rc =3D next_entry(key, fp, key_len);
> > +
> > +       rc =3D str_read(&key, fp, key_len);
> >         if (rc < 0)
> >                 goto cleanup;
> > -       key[key_len] =3D '\0';
> >
> >         /* ensure that there already exists a symbol with this key */
> >         if (hashtab_search(p->symtab[symnum].table, key) =3D=3D NULL) {
> > @@ -4387,28 +4281,17 @@ int policydb_read(policydb_t * p, struct policy=
_file *fp, unsigned verbose)
> >                         goto bad;
> >                 }
> >                 len =3D le32_to_cpu(buf[0]);
> > -               if (zero_or_saturated(len))
> > -                       goto bad;
> > -               if ((p->name =3D malloc(len + 1)) =3D=3D NULL) {
> > -                       goto bad;
> > -               }
> > -               if ((rc =3D next_entry(p->name, fp, len)) < 0) {
> > +               rc =3D str_read(&p->name, fp, len);
> > +               if (rc < 0)
> >                         goto bad;
> > -               }
> > -               p->name[len] =3D '\0';
> > +
> >                 if ((rc =3D next_entry(buf, fp, sizeof(uint32_t))) < 0)=
 {
> >                         goto bad;
> >                 }
> >                 len =3D le32_to_cpu(buf[0]);
> > -               if (zero_or_saturated(len))
> > -                       goto bad;
> > -               if ((p->version =3D malloc(len + 1)) =3D=3D NULL) {
> > -                       goto bad;
> > -               }
> > -               if ((rc =3D next_entry(p->version, fp, len)) < 0) {
> > +               rc =3D str_read(&p->version, fp, len);
> > +               if (rc < 0)
> >                         goto bad;
> > -               }
> > -               p->version[len] =3D '\0';
> >         }
> >
> >         if ((p->policyvers >=3D POLICYDB_VERSION_POLCAP &&
> > --
> > 2.42.0
> >
