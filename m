Received: from mail-yx2-f31.google.com (mail-yx2-f31.google.com [74.125.224.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AFC53358B
	for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.159
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170720; cv=pass; b=XZmkOhiU0XT4zjusqCQjmJb604O6PHoxHPgtF5RO+0+67KPd2R/q/XursdP0sU18a9va0QZyGBxMBwFaHDpgMLBRuXvdwddIO/muDf5MAWr+d+9JgC5dV+FOTVtiNTPCbQCWWEIPgZAQiF2uwkNEff39m5nZUG1aivNfhx9Jg1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170720; c=relaxed/simple;
	bh=GnrP3GYKnAZvOYa/VZOv3xHdL1BrhKzA1AssQAKBOno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRhdIaihD69tduFPhbcKVzzjeOZLfZf7ku9NC5d2e+/Y0dzstwb4cnAGut6HpE+sKt5Le03s+D0+MFvn9i4CLmGrUYH9d45ZpVYPu0SMyj4FGSmsQjSNuh+cWW1iYp3VmmnK+5KQKy4778xr6NsUo8VNVaQYO7Lbk0DFlprX44o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sctMWTpu; arc=pass smtp.client-ip=74.125.224.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sctMWTpu"
Received: by mail-yx2-f31.google.com with SMTP id 00721157ae682-8659af7454eso14667057b3.1
        for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 06:38:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790170717; cv=none;
        d=google.com; s=arc-20260327;
        b=l4ADTG7KUHDq3UqhqWqQPstpaF9cW1ZJ+sbXrDhD5b2hX5EDOf7lE6P+yMTJLlBaPh
         5NwHdZksoRAPS2UuYw7jorvuQSfNb+QVkYZwQu+o35yK6+Wv+g5vQ8r1TwOLdHhMJ5co
         1tJVaBRycRkx1uer0wym6uSnSPhwO/2Icwj9FMS4VkQ4ySAhM9CH7jfstpcPtGiXBCHi
         vnpPpwjSUgklIOqK3dZKrZbJagLY/9JMU+L4i9+Rk1osp5P7ugwq42Irz4e1PSU8Gvgp
         ZBt0UnyJHpI57ez3LMHnXf+xrMagCvfKc0fT6wEuXoeiD9NF0qxYGi6AA5dvBj+DgwWd
         srNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lCGQX/ipzcOOeMxRbp6wRlqqaTDM53LN4+s6YuTWBxs=;
        fh=umc3Nr61JguynosSZv6Nt1t3DnezwCIDroWR11qQrsc=;
        b=BRH0LemhdoqfUz9U5zGuGuBuvkljL/EEnRlIUGJj6Zd6bpnZvbidUa42zoWCNa0bZN
         tEoPgNtoM950+ItdQ9sJLyBSx/XNi1UAUznF9IkofaKCi9tNIoI/sty9fIDYto+0xSxu
         WiKgvly+xZ2G4SD1IbsRsSrMvbeIVlR0ePAnIVlKnirRgckH9cBHoo7dayNw1GEBuvUv
         SuJcvf5R6ws9xLdn/SeYzteQySUF243qeRroCybN1ua3aKag6mP5dvoVKSs/pTmgFTf4
         3Lvlk2kfoqV52Ni69CBmhf5cBQgJzdbi3lTqlR3jhJ54Tbky4W3xEHt5Ml1/wVRmY+CY
         q9vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790170717; x=1790775517; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lCGQX/ipzcOOeMxRbp6wRlqqaTDM53LN4+s6YuTWBxs=;
        b=sctMWTpuMvOKIHQ35N4Uaxu8fw9PKZz7fs3W3KIXArPBzuZX/V+F/EaG+ezVz8dzoq
         Q5gEEZpvXSFNpnZ56KpU/gig4e87fhdAh78rhY36VCaVjJGPLxSk1HLytMApjRdRIVkt
         fJAfqUMHqnLcDh0Qeob8BLDhkxVAWHLUWCdAQadRVg/RHhrpZoqLRo+WCQI5P+EXLQbZ
         b3UeKBcC95409iS2sWhNaEun8vyNT++YwzA3VG4ygqHsxoY+xQ0ifSbZSN6wcfXYTnSc
         RM+x0acgEYSRTKc1So/be3Ds1WamGPt818x+a7BMfc9y9w7eSBWniMUCOcYDF3t0UcSH
         ctIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790170717; x=1790775517;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lCGQX/ipzcOOeMxRbp6wRlqqaTDM53LN4+s6YuTWBxs=;
        b=O1puZDpkLFufUzG7bX1BxT8K6I4vQwAkGNE90HBZCI6Uvv+JSTm0d9vV0qUNg8ePtA
         zauzlWoO9o2x3sxAUYQ52ZjeJGUEbngNiQQPJULj8vuUhb6pJ/P2/2eFzKvgpuEnq9vk
         s0v6wQskF95n5FVZKsjENyJzbBJ0YaYwJJiJ3AMD7UIEnZ+ormwHXJHwqYQu8ICgl3tD
         rNbZMSACgtyzcLqn5mdZG4bGFREhF81f6jLNWThdX4wQ/k8fUtVbaJcZwmz/gfWHc6ub
         5ty+wP+JN1LJq1W2tuOTqq8OzEM8CiIWp3sYjhPZzb6Xn6VG1GMO17/3vnZ/Xi3c9DAE
         RhaA==
X-Gm-Message-State: AFuF++mDGc9uWj8/WEm7KKtc0+enwBDei1E2mNtI7E1HrH2Shl+9nvrG
	gmo83sZc4D7kH9kP+WDe/rvpXoAkVC4LvkrGjkhZaTsC90gx1D9f2sTNTmztk3i6xalfVbcd354
	cM4gIIEAFAAnayRDDQyKcSR3kOdeNz2g=
X-Gm-Gg: AYBFou0buhYaWRlH40rMbti+NJ1O8wM1b06lDkHBFsQRgexrI+BMd+Nh+xdbP62k68l
	W3GZwR5EN43Wpee1mX0bD1MLrrIuErubKngHb6UP/vha7vmorFLszCng07PIeqfJMFS2q0awl5O
	Ry/ObKYmA4X8GUWFXstSHKEPVgrpnH5+nwhWbYIXZA+pYg6NvMF00Lf25P3oosVeVpfvRY9w6i4
	sVLU1uHqgDuRGtdICnXTlmXhPtw+rQT7mO1rktfw6XeiV0itCAJKHfx45O4YLVQBp9RRT4TS+UZ
	28i71tulPZg2M0EaC0X2paAppOlzjgDaxrj2BUF13tC4Ga5o7VxMe8c=
X-Received: by 2002:a05:690c:9985:b0:873:5c0f:295 with SMTP id
 00721157ae682-8a45c4620a2mr16644897b3.63.1790170716700; Wed, 23 Sep 2026
 06:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923055823.3567355-1-inseob@google.com>
In-Reply-To: <20260923055823.3567355-1-inseob@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 23 Sep 2026 09:38:24 -0400
X-Gm-Features: AcwNN1X12J2r3BB0QloSH3riVG9L8XTPZK0QTB8Ucu4CjCcSJZCboRWr6ufDQ_I
Message-ID: <CAEjxPJ4TGBbZZGOSPm14c0K+ZX-22ve9yK+zwDSH9aeu8sv6Mw@mail.gmail.com>
Subject: Re: [PATCH] libsepol,checkpolicy: add --multiple-decls option
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, tweek@google.com, nnk@google.com, 
	James Carter <jwcart2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 2:02=E2=80=AFAM Inseob Kim <inseob@google.com> wrot=
e:
>
> Add a -m/--multiple-decls option to checkpolicy, mirroring the option of
> the same name in secilc, which allows a type or an attribute to be
> declared more than once. The declarations are merged into a single
> symbol whose attribute set is the union of the attribute sets of the
> individual declarations. Without the option a repeated declaration
> remains an error.
>
> Policies assembled from several independently maintained sources may
> declare the same type in more than one of them. secilc merges such
> declarations when it links the resulting CIL files, but checkpolicy
> rejects them when the same sources are compiled in a single run.
>
> symtab_insert() already permits multiple declarations of roles and
> users, so only SYM_TYPES is added to that allowlist, behind a new
> policydb flag. Nothing else is needed: create_type() returns the
> existing datum when the symbol exists and define_type() sets one
> attribute bit per declaration against it. Using the same identifier for
> both a type and an attribute remains an error, as does a repeated
> declaration of any other kind of symbol.
>
> Signed-off-by: Inseob Kim <inseob@google.com>
> ---

> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 9716f5f..9e0eb72 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1456,8 +1456,11 @@ int symtab_insert(policydb_t *pol, uint32_t sym, h=
ashtab_key_t key,
>                         return rc;
>                 }
>         } else if (scope_datum->scope =3D=3D SCOPE_DECL && scope =3D=3D S=
COPE_DECL) {
> -               /* disallow multiple declarations for non-roles/users */
> -               if (sym !=3D SYM_ROLES && sym !=3D SYM_USERS) {
> +               /* disallow multiple declarations for non-roles/users, un=
less
> +                * the policy opted in to multiple declarations of types =
and
> +                * attributes */
> +               if (sym !=3D SYM_ROLES && sym !=3D SYM_USERS &&
> +                   !(sym =3D=3D SYM_TYPES && pol->multiple_decls)) {

sym =3D=3D SYM_TYPES can also be true for type aliases.
policy_define.c:add_aliases_to_type() case 1 was written for the
require->decl path
(turn a required stub into an alias). Under -m it is now reachable
from DECL/DECL and
does existing->flavor =3D TYPE_ALIAS; existing->primary =3D <T>;

    type TYPE2;
    allow TYPE2 self:CLASS1 PERM2;
    typealias TYPE1 alias TYPE2;

secilc -m rejects this via cil_allow_multiple_decls() f_new=3D=3Df_old
(CIL_TYPE !=3D CIL_TYPEALIAS
at cil_build_ast.c:151. Reverse order (alias then type X;) is a
harmless no-op; create_type() returns the alias datum with
flavor=3D=3DTYPE_TYPE(0)=3D=3Disattr(0), define_type() has nothing to set.

Suggested fix: mirror the SYM_ROLES flavor guard in symtab_insert() -
add_aliases_to_type()'s
incoming aliasdatum has s.value pre-set to the primary's value whereas
create_type()'s incoming
datum has s.value=3D=3D0 from type_datum_init() memset; reject
((type_datum_t*)datum)->s.value !=3D 0
at the DECL/DECL_SYM_TYPES branch.
Or refuse in add_aliases_to_type() case 1 when the existing datum's
scope was already DECL - but
symtab_insert() has already flipped/appended by then, so the former is clea=
ner.
