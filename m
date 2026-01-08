Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FB71D47B4
	for <selinux@vger.kernel.org>; Thu,  8 Jan 2026 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891890; cv=none; b=NmW+VfGHc7HtqZZbwm2iKoXLd07uIt4OXCbUgvWgBdPBQ+Mi289HfXSnJWOPhdvraM0cWODtibVnk/ZXrtqPGwdixun+9sxGR7YOgAHEOJohWqJGKKWovWZTawuAwz04OAW695UeLxGtTKodWrdw6lfUEZQ3bZT+tRF+LZMyBsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891890; c=relaxed/simple;
	bh=zZ9h23p9st+L+9SEzayznKhazOtpUz3mg9Qi2Z7P840=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=AycPjVMvaY5i7LC1bPJG/cBFql9BuD21p64CyTNFDcH2pMQlE1ySZkTcSydX2A8xyTCUTmcWhScHWYrrvQGmcMbHk/miG+rGwANw+nyJw2tfs3cOxGcxCwg3GqgwZIsAc0gykkDvlC8uFQ3l+Wt3voP7tR3E4rJNZCmFYbSvJCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lg/Pq9k8; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lg/Pq9k8"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-382fd6cbae1so17637611fa.3
        for <selinux@vger.kernel.org>; Thu, 08 Jan 2026 09:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767891886; x=1768496686; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyaoBwzABLlFbKBPmvKsQuMRs2vc+cz6zJl7ORo+GEE=;
        b=Lg/Pq9k8pOAX9lmVTTsw7AVYbc5PlSyLOvgEA7wYBYXxIUdVAgCGkILOvt1gikuXF0
         3U0xTNYb1XpKrpnNLne5n+dXIhjKRi+uaKjDR+it5aJOimct83hHAnmy+8V5nWxiinAs
         MYmnJRrTTyenj7EKLSCr4dz/oHI1gMo7jMgfzNzRdUOy32t+lXT7Xgsi1w2gmKF+9TM9
         urNQ+VNy/SlxUqL5LBqW9zgwly+fwWDVMIm3NfwVPiR949JOPQnjjYRMqiho6KE/3DMF
         cCWGwLwYX+aclsf74AZZyyxtX2BYUEi9J3EjoZx9E3Sq9O0cSqBIUz+HTbDAAaRCbZo9
         Fu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767891886; x=1768496686;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wyaoBwzABLlFbKBPmvKsQuMRs2vc+cz6zJl7ORo+GEE=;
        b=V96ybOoKOwmkSkr3UjGjP/c5eRERh1uEQh8NNGnL6srdm6BW5s32h45v+BlnEwXIo4
         MbwGtm1JpElUb0npCLCEPj+N8wLhgllgtJtgI5QygaZuYm5XqV+7EMQyDRtgEQqyAeQY
         Oa5Yk9Nz5W1/6FwKVctLLhg6Iko1CXlml05ISE0KFEzB4kYFANkOO/x7bo4V5rnNQ2nI
         XcfQiJgrMWzzIewlP2csYdT09MWAJVCNMtnjYj1GaUpK9Bk9zciqZ3uE/3uBd9nAe55L
         4Jub8y6Zx9CZOq4caTk3sQEmxswGmb3glglmTsxHx651TSqjFSZ5cdahbfBemHxYvqkA
         fwGQ==
X-Gm-Message-State: AOJu0YxIkkbpLPOmNGjnjYwBP5mmfNrHYYpjBy/G81SFfGxZiLsinoEs
	Vpf/t9Lqg/JpTeNDwNLFb4n+XG+XgHMuPNCxtlWpLsNm6ms8QnkrkRhpjd4ncw+FCuDsD3rOcPi
	m5x3oTOTzEmFqBIMfzjpcXhAFLAQ5qlRuHw==
X-Gm-Gg: AY/fxX7kTLoB2g4xfVVV7kB5nWVjEnvTArjmPphruOjR0giKXbvEsC+H8xolktz3/84
	N4pHaHGaQ2zNUBFBMEO382ABSj6UCQecpVBDq0J7nSm9LbNB1G2j52BQJw8dcUrKbh6ebgkzCg8
	atWBEMJ+LLfakWyXlAyiYVt2FikCfa8H3AZFp5wr9I1BEk5hH8UtmqZBFT6foVVr45pN/7JZVqc
	hinJ7nkvNLGp0JpwXgiQ19VN5V6FDDIRozLk5BYWEOtucJZDr1LEgOaqaACbwoRYvAstqtvm+yt
	kEs=
X-Google-Smtp-Source: AGHT+IF8G1vXDNfjzDZbQ/HBQfVF6vL08VwUbL67YBu2l5SkGtTk5FanWEPZw7BRn/fC1pkIjXjKx2MuJs5EIqMirKs=
X-Received: by 2002:a05:651c:509:b0:37f:cac3:c27f with SMTP id
 38308e7fff4ca-382ff82b883mr23712761fa.33.1767891885724; Thu, 08 Jan 2026
 09:04:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217175938.193948-1-jwcart2@gmail.com>
In-Reply-To: <20251217175938.193948-1-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 8 Jan 2026 12:04:34 -0500
X-Gm-Features: AQt7F2rkygk33q-W4wTX0aM7O08eWjsJS4Z8GocMONX9RCHx0FbCDAVsF3nN91E
Message-ID: <CAP+JOzRVPmP=zBb-cGg5GvA11org=AMr8R-aym=pZoUr5M-eHA@mail.gmail.com>
Subject: Re: [PATCH V3] Allow type attributes to be associated with other type attributes
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 12:59=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
>
> Allow the following:
> attribute at1;
> attribute at2;
> typeattribute at2 at1;
>
> This associates the attribute at2 with the attribute at1. Any types
> associated with at2 will be associated with at1 as well when the
> policy is expanded. A loop in the associations between attributes
> will produce an error.
>
> The kernel binary policy is not effected by this change because all
> attribute associations are expanded when the policy is expanded.
> The modular policy is effected because compiled modules and the
> linked modular policy can now have type attributes associated with
> other type attributes, so a new module version is needed to prevent
> an older policy toolchain from creating a kernel binary policy that
> has type attributes associated with other attributes.
>
> Also validate that the types field of a type datum for an attribute
> is empty for kernel policies and does not contain an attribute for
> modular policies before this new version.
>
> This was suggested by Vit Mojzis <vmojzis@redhat.com> who also
> provided an initial patch for checkpolicy.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

This patch has been merged.
Jim

> ---
> V3: Fix potential NULL dereference in expand_attributes_in_attributes() a=
nd
>     change the language of the error message.
> V2: relocated call of expand_attributes_in_attributes() because of recent=
 commits
>
>  checkpolicy/policy_define.c                |  9 +++-
>  libsepol/include/sepol/policydb/policydb.h |  3 +-
>  libsepol/src/expand.c                      | 54 ++++++++++++++++++++++
>  libsepol/src/policydb.c                    | 25 ++++++++--
>  libsepol/src/policydb_validate.c           | 30 +++++++++++-
>  5 files changed, 113 insertions(+), 8 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 4c53e1e6..b73de45c 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -1440,11 +1440,18 @@ int define_typeattribute(void)
>                 return -1;
>         }
>         t =3D hashtab_search(policydbp->p_types.table, id);
> -       if (!t || t->flavor =3D=3D TYPE_ATTRIB) {
> +       if (!t) {
>                 yyerror2("unknown type %s", id);
>                 free(id);
>                 return -1;
> +       } else if (t->flavor =3D=3D TYPE_ATTRIB) {
> +               if (policydbp->policy_type !=3D POLICY_KERN && policydbp-=
>policyvers < MOD_POLICYDB_VERSION_TYPE_ATTR_ATTRS) {
> +                       yyerror2("Type attributes cannot be used in a typ=
eattribute definition in policy version %d", policydbp->policyvers);
> +                       free(id);
> +                       return -1;
> +               }
>         }
> +
>         free(id);
>
>         while ((id =3D queue_remove(id_queue))) {
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
> index 9875255c..4107b662 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -802,9 +802,10 @@ extern int policydb_set_target_platform(policydb_t *=
p, int platform);
>  #define MOD_POLICYDB_VERSION_SELF_TYPETRANS    21
>  #define MOD_POLICYDB_VERSION_COND_XPERMS       22
>  #define MOD_POLICYDB_VERSION_NEVERAUDIT                23
> +#define MOD_POLICYDB_VERSION_TYPE_ATTR_ATTRS 24
>
>  #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
> -#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_NEVERAUDIT
> +#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_TYPE_ATTR_ATTRS
>
>  #define POLICYDB_CONFIG_MLS    1
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 04b5e5e4..d8f56476 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -222,6 +222,56 @@ static int attr_convert_callback(hashtab_key_t key, =
hashtab_datum_t datum,
>         return 0;
>  }
>
> +static int expand_attributes_in_attributes(sepol_handle_t *handle, polic=
ydb_t *p)
> +{
> +       ebitmap_t attrs, types;
> +       ebitmap_node_t *ni, *nj;
> +       unsigned int i, j, reps =3D 0, done =3D 0;
> +       type_datum_t *td, *ad;
> +
> +       ebitmap_init(&attrs);
> +       for (i=3D0; i < p->p_types.nprim; i++) {
> +               td =3D p->type_val_to_struct[i];
> +               if (td && td->flavor =3D=3D TYPE_ATTRIB)
> +                       ebitmap_set_bit(&attrs, i, 1);
> +       }
> +
> +       while (!done && reps < p->p_types.nprim) {
> +               done =3D 1;
> +               reps++;
> +               ebitmap_for_each_positive_bit(&attrs, ni, i) {
> +                       td =3D p->type_val_to_struct[i];
> +                       if (ebitmap_match_any(&td->types, &attrs)) {
> +                               done =3D 0;
> +                               ebitmap_init(&types);
> +                               ebitmap_for_each_positive_bit(&td->types,=
 nj, j) {
> +                                       if (ebitmap_get_bit(&attrs, j)) {
> +                                               ad =3D p->type_val_to_str=
uct[j];
> +                                               ebitmap_union(&types, &ad=
->types);
> +                                               ebitmap_set_bit(&td->type=
s, j, 0);
> +                                       }
> +                               }
> +                               ebitmap_union(&td->types, &types);
> +                               ebitmap_destroy(&types);
> +                               if (ebitmap_get_bit(&td->types, i)) {
> +                                       ERR(handle, "Found loop in type a=
ttributes involving: %s", p->p_type_val_to_name[i]);
> +                                       ebitmap_destroy(&attrs);
> +                                       return -1;
> +                               }
> +                       }
> +               }
> +       }
> +
> +       ebitmap_destroy(&attrs);
> +
> +       if (!done) {
> +               ERR(handle, "Failed to expand attributes");
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
>  static int perm_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
>                               void *data)
>  {
> @@ -3161,6 +3211,10 @@ int expand_module(sepol_handle_t * handle,
>                 if (hashtab_map(decl->p_types.table, type_bounds_copy_cal=
lback, &state))
>                         goto cleanup;
>         }
> +       /* Expand any attributes in each attributes' types ebitmap */
> +       if (expand_attributes_in_attributes(state.handle, state.out)) {
> +               goto cleanup;
> +       }
>
>         /* copy commons */
>         if (hashtab_map
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 8a81687d..6aaa18f2 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -362,6 +362,13 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
>          .ocon_num =3D OCON_IBENDPORT + 1,
>          .target_platform =3D SEPOL_TARGET_SELINUX,
>         },
> +       {
> +        .type =3D POLICY_BASE,
> +        .version =3D MOD_POLICYDB_VERSION_TYPE_ATTR_ATTRS,
> +        .sym_num =3D SYM_NUM,
> +        .ocon_num =3D OCON_IBENDPORT + 1,
> +        .target_platform =3D SEPOL_TARGET_SELINUX,
> +       },
>         {
>          .type =3D POLICY_MOD,
>          .version =3D MOD_POLICYDB_VERSION_BASE,
> @@ -502,6 +509,13 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
>          .ocon_num =3D 0,
>          .target_platform =3D SEPOL_TARGET_SELINUX,
>         },
> +       {
> +        .type =3D POLICY_MOD,
> +        .version =3D MOD_POLICYDB_VERSION_TYPE_ATTR_ATTRS,
> +        .sym_num =3D SYM_NUM,
> +        .ocon_num =3D 0,
> +        .target_platform =3D SEPOL_TARGET_SELINUX,
> +       },
>  };
>
>  #if 0
> @@ -4492,16 +4506,19 @@ int policydb_read(policydb_t * p, struct policy_f=
ile *fp, unsigned verbose)
>                         if (r_policyvers >=3D POLICYDB_VERSION_AVTAB) {
>                                 if (ebitmap_read(&p->type_attr_map[i], fp=
))
>                                         goto bad;
> -                               ebitmap_for_each_positive_bit(&p->type_at=
tr_map[i],
> -                                                        tnode, j) {
> +                               ebitmap_for_each_positive_bit(&p->type_at=
tr_map[i], tnode, j) {
>                                         if (i =3D=3D j)
>                                                 continue;
>
>                                         if (j >=3D p->p_types.nprim)
>                                                 goto bad;
>
> -                                       if (ebitmap_set_bit
> -                                           (&p->attr_type_map[j], i, 1))
> +                                       if (p->type_val_to_struct[i]->fla=
vor =3D=3D TYPE_ATTRIB) {
> +                                               ERR(fp->handle, "Invalid =
to have type attributes associated with an attribute for a kernel policy");
> +                                               goto bad;
> +                                       }
> +
> +                                       if (ebitmap_set_bit(&p->attr_type=
_map[j], i, 1))
>                                                 goto bad;
>                                 }
>                         }
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index fb79c8d9..5afbfa49 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -566,6 +566,27 @@ bad:
>         return -1;
>  }
>
> +static int validate_types_in_attribute(const ebitmap_t *map, const polic=
ydb_t *p, const validate_t flavors[SYM_NUM])
> +{
> +       ebitmap_node_t *node;
> +       uint32_t i;
> +
> +       if (validate_ebitmap(map, &flavors[SYM_TYPES]))
> +               goto bad;
> +
> +       if (p->policy_type !=3D POLICY_KERN && p->policyvers < MOD_POLICY=
DB_VERSION_TYPE_ATTR_ATTRS) {
> +               ebitmap_for_each_positive_bit(map, node, i) {
> +                       if (validate_simpletype(i+1, p, flavors))
> +                               goto bad;
> +               }
> +       }
> +
> +       return 0;
> +
> +bad:
> +       return -1;
> +}
> +
>  static int validate_type_datum(sepol_handle_t *handle, const type_datum_=
t *type, const policydb_t *p, validate_t flavors[])
>  {
>         if (validate_value(type->s.value, &flavors[SYM_TYPES]))
> @@ -582,8 +603,13 @@ static int validate_type_datum(sepol_handle_t *handl=
e, const type_datum_t *type,
>                         goto bad;
>                 break;
>         case TYPE_ATTRIB:
> -               if (validate_ebitmap(&type->types, &flavors[SYM_TYPES]))
> -                       goto bad;
> +               if (p->policy_type =3D=3D POLICY_KERN) {
> +                       if (!ebitmap_is_empty(&type->types))
> +                               goto bad;
> +               } else {
> +                       if (validate_types_in_attribute(&type->types, p, =
flavors))
> +                               goto bad;
> +               }
>                 if (type->bounds)
>                         goto bad;
>                 break;
> --
> 2.50.0
>
