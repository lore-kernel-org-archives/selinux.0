Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF2337E300
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920818; cv=pass; b=rLwc4QbaNFlRXfJT/bS6yU2ttJZ54dnrgMGqutWxehtJ+XqmRwghJdALby4qvFyyJCPsGk3SA5yyXNQP8oGwuD137AwFTPm06tGgVEjb7h2xcZMpCC6Hh5+lVezLMycsY9RCml7CQpoacwOQfMGqtMY57RYxO6SEApmHVvW1dsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920818; c=relaxed/simple;
	bh=w5aSGS8SCA9k4m1LSJpg58f3BCVV+GJPm7H4x88Yu7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSAD+Zan/PmAtADgqTchTdpBCEO5YAGBkKjOUs+8V+zX97kXPj/QUS8HhFo1vgddcQtl1Rt74nDbkHokmPxCWR7locpnGtlK7Tv3ZrHv+Kbct/jYvORN1IO1pL4RbfAWem4n4hx1WEcxm6fYaUuSrGFAZuLKXS+2mpzriCgBnbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cdu4p5Rc; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cdu4p5Rc"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4518ad44e83so457215fac.0
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 12:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784920815; cv=none;
        d=google.com; s=arc-20260327;
        b=gNylhh+onoL/Yj7Qt4GtZACU9F60Vd18zFaebGqb0VnTLSOa7593Jqp1UxtPo521vE
         3LGh6H5PIi85pbaZoyximCoO8UpaJOZp6rCd+uBf/2qEaD29zOtSzdgu4lK6lwU5gJj8
         bkH5ijSnCFCe98nThkmCDY7YDGjT3FnO7efZGTs7EX31Qzp+ZkExIOOkgFn4g4VJmVEH
         x47j1HQEpsPAqjLCLhTUEP4P6flVo/KtFmSNe+H1bCcF3eANXleuNpeZoPZVMSh0k9cb
         lT5/MS+p0Lzm2+qGT0lu720GbbfI93ln0dEwazuzTWbHpAHQEKpQvW7UqszJKUENiwuA
         4a7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=svH91FKUkX4zHg+ojPLIYQMuH4W4uFqneu4sBVxKnmQ=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=c76/icxWIi6QN8yIMrDRQVeqhgpItL4WrTvfh7aucKK59ti9S6h1rVrHS04C+s2b6F
         6ZMSYfCcki7VqcdxPeaO69rrpVv9ZHQ2hrxzpwd/b9ymhAC93UL+ZwmQ4Sr2E1zUO7Nt
         ZyWPWT6w3eqXBjASaOVnA1nyj9phCsSFKtYHyW3kHwlHQqxvHRISrjf3yqIWT+fbNa7C
         /vqxdYdQBtw7cWoQmGHvDunqm6bCp4kasvw/xop/HhIjWSWznwGcwOmpEBefH/1qg3hx
         bQNEkROwEuTcU4iaX7erv9lYQgsVlUhBxpLWwpnp4JX6xq8m9E0MHQ0HRciPs3sf4Sxk
         A2rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920815; x=1785525615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=svH91FKUkX4zHg+ojPLIYQMuH4W4uFqneu4sBVxKnmQ=;
        b=Cdu4p5RcuJHMPCCvk3D41ZPY/1DFlzw5B/TLd25zFgb7sA6v/YLmUj/GWnFX9F61Xb
         EtfBJ180+iidtK1ojhiFdHFw76L0X1UX7YoIj7NU8oJXPiq4NhAIkQH5TcRELJsgtbd9
         wKX2au6loJKsGs5O8R+DU05xz8c1YzK5uFbI8M1j//zOhMucncO7uKMPdbAenO/l6NVC
         NRDwtaJxUcSD48933xO5VPoxrPg29DntDrqNiFCp9bI3lUgs8xgmlpJECIpo0+tyRW/E
         A4owjIrEdTsj1T1YJzISePDFs9BLWVKS6RnKXp6B6VyphpVlKXFFbTVZxv9u7P4gSJIc
         6jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920815; x=1785525615;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=svH91FKUkX4zHg+ojPLIYQMuH4W4uFqneu4sBVxKnmQ=;
        b=ZbSShLdOoKlHzeHnz9oo82zaLAGQFyS8VgcFACHdRAW3yOkPSXYj5/QA2IuAOvcRBi
         +Yac6icnxSnkJR0+01WOK/NGFzzHoK9AdVUB6WgEB6Juj2NpTKT7qfsVf7UP32YLz0eT
         kNMGlq/zV8EpMzHncNBkCkqoIGM8OANaHf5sKCY4Y7cktlV5mQMBeQ3HawOjyfzkCBNo
         A1k/FezVMcVC6eSuo2Pb4wt9v5tC0Z+gMDhBv4J4QzXn4a6C5p7jlAYnTIy5xn1LTQ3F
         fo/Aehau3yaN40V++R8SLolBvgAt/vNlsUFZ/iu8DFquqyDqRAYVHC+Ab1q3ho41c2s9
         vXhA==
X-Gm-Message-State: AOJu0YzmgcPAUky7Lw+QOs95L7cNsN0sBzh9/uBvVngRmucvFX8rEfnP
	cG7uydmV3jYzfaAJnpaIwMTc5dZRE+EuY4QOJkNAzZD3gir45NRxB9jn9lbTozRT9RFOifbhGHh
	0o243gwXNUeRNbf11bP5umegpon+AwN4=
X-Gm-Gg: AR+sD12lZRTu0JB3D1FvGRkEMRHLB+B0k2h6i714rPoj3C3r/7hPuVW3TmlrnnV4AYR
	LeokC7tFaRlLeBzraPtWUlzpwmu8t5MBrcxNNExsUdKqvEwSVV7PIUKWhDo0QEoqUgDwgV/bvfQ
	mIOa/O8q5Ob+tMEC8emTxwywcIwX4ROYcsETuXVNbpR7v9B0Jn/0gTlp1JsX9RWgJbVXpUih3Ni
	g0XI8hdGOC5LCcH0we07hq9eZab/NqJqLYQT6+i1MOPGWMaZn+kizdUSIadhw==
X-Received: by 2002:a05:6870:e08e:b0:441:5c83:fbf0 with SMTP id
 586e51a60fabf-457a0faf6c2mr5952898fac.24.1784920815644; Fri, 24 Jul 2026
 12:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724182908.97023-1-jwcart2@gmail.com> <20260724182908.97023-2-jwcart2@gmail.com>
In-Reply-To: <20260724182908.97023-2-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 15:20:03 -0400
X-Gm-Features: AUfX_myTMe7jqYBJtwD5juN4L-XCNEwJBQB84FZ8atKXotpq57J9Zhc8BzLLlU4
Message-ID: <CAEjxPJ7_DfRsGBrVMOL_rqE8tRZ_EDXMzK=oRq3sujDNr-DcQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: Validate scope index class_perm_map array
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 2:29=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> In addtion to the array of ebitmaps that shows which declarations
> are in scope for a given block, the scope index also contains an
> array of ebitmaps, class_perms_map, that shows which permissions
> are in scope for each class and it contains the length of that
> array.
>
> If the class_perms_map is NULL, then verify that class_perms_len
> is 0. If the class_perms_map is not NULL, then verify that the
> class_perms_len is not 0 and that the array is long enough to
> contain all of the classes that are in scope for the block and
> that for each class in the array either the permission ebitmap
> is empty or it contains at least one valid permission. [Older
> compilers could set all the bits if "*" was used.]
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Was missing the v3 in the subject line but regardless:
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v3: - Stop differentiating between required and declared blocks and
>       instead differentiate between NULL and non-NULL class_perms_map
>     - Remove the added bool argument "required"
>
>  libsepol/src/policydb_validate.c | 45 +++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 7 deletions(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 1d8e0870..fc66a4c7 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -1713,10 +1713,8 @@ bad:
>
>  static int validate_scope_index(sepol_handle_t *handle,
>                                 const scope_index_t *scope_index,
> -                               validate_t flavors[])
> +                               const policydb_t *p, validate_t flavors[]=
)
>  {
> -       uint32_t i;
> -
>         if (!ebitmap_is_empty(&scope_index->scope[SYM_COMMONS]))
>                 goto bad;
>         if (validate_ebitmap(&scope_index->p_classes_scope,
> @@ -1735,9 +1733,42 @@ static int validate_scope_index(sepol_handle_t *ha=
ndle,
>         if (validate_ebitmap(&scope_index->p_cat_scope, &flavors[SYM_CATS=
]))
>                 goto bad;
>
> -       for (i =3D 0; i < scope_index->class_perms_len; i++)
> -               if (validate_value(i + 1, &flavors[SYM_CLASSES]))
> +       if (scope_index->class_perms_map !=3D NULL) {
> +               uint32_t i;
> +               if (scope_index->class_perms_len =3D=3D 0)
> +                       goto bad;
> +               if (ebitmap_highest_set_bit(&scope_index->p_classes_scope=
) >=3D
> +                   scope_index->class_perms_len)
>                         goto bad;
> +               for (i =3D 0; i < scope_index->class_perms_len; i++) {
> +                       const ebitmap_t *map;
> +                       class_datum_t *class;
> +                       ebitmap_node_t *node;
> +                       unsigned int bit =3D 0;
> +                       if (validate_value(i + 1, &flavors[SYM_CLASSES]))
> +                               goto bad;
> +                       map =3D &scope_index->class_perms_map[i];
> +                       class =3D p->class_val_to_struct[i];
> +                       /* Either there are no perms */
> +                       if (ebitmap_is_empty(map))
> +                               continue;
> +                       /* Or at least one valid perm */
> +                       ebitmap_for_each_positive_bit(map, node, bit) {
> +                               if (bit < class->permissions.nprim)
> +                                       break;
> +                       }
> +                       if (bit >=3D class->permissions.nprim)
> +                               goto bad;
> +               }
> +       } else {
> +               /* This is the normal branch for declared blocks.
> +                * Base module required blocks should never be in this br=
anch.
> +                * Module required blocks can be if neither its nor the m=
odule's
> +                * require block has a class in it.
> +                */
> +               if (scope_index->class_perms_len !=3D 0)
> +                       goto bad;
> +       }
>
>         return 0;
>
> @@ -1811,10 +1842,10 @@ static int validate_avrule_blocks(sepol_handle_t =
*handle,
>                         if (validate_range_trans_rules(
>                                     handle, decl->range_tr_rules, flavors=
))
>                                 goto bad;
> -                       if (validate_scope_index(handle, &decl->required,
> +                       if (validate_scope_index(handle, &decl->required,=
 p,
>                                                  flavors))
>                                 goto bad;
> -                       if (validate_scope_index(handle, &decl->declared,
> +                       if (validate_scope_index(handle, &decl->declared,=
 p,
>                                                  flavors))
>                                 goto bad;
>                         if (validate_filename_trans_rules(
> --
> 2.55.0
>
