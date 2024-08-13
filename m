Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BF31A08D1
	for <selinux@vger.kernel.org>; Tue, 13 Aug 2024 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723570148; cv=none; b=pp5LblNMhSZNgjm+AsxHH5Lcg6p6fOjGYk0sdkreXpK574QZPsH3aFHHLefoXbu7d7jPrZ6VFnwoXV56Qz34zUpS09RWpUx7bxCkT5JnAkFbNeXUmm23E1EQ6VVKGHX0INhVToZCCWqa0fUFxV9ZClcrgCvRnL9YLE2sUFSPcX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723570148; c=relaxed/simple;
	bh=4qDBqGN8jHA/im7p6AvTh39kLcza1PkI8CmK9dGzbcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sw4k8ICo2XqaSUWuRuHzbDDTRGljAsUGsBYvqcXRHHd8+SIIdBG/reMvUuM1HRXBszKKLef5cBqSeCAs5EhrOOom+svc4GoryxE1+viFNAN+x8zkFU82RLe9Y2jI4MvynO6BpsrC+AY9SCTl9ZNu8LW/ac0b4i6dgfo67lqinHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/ssRF+A; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/ssRF+A"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-81f91171316so45873241.0
        for <selinux@vger.kernel.org>; Tue, 13 Aug 2024 10:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723570146; x=1724174946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6oKMxcAL3e82thO5kOomw8I13iPgj4pE84cH0zvDbE=;
        b=D/ssRF+AsycQX+N7jeteQqolh36KBMsTPrmUBUXc0NVnbeVtTAz8ijOlTnbSOGM7Et
         8BpxCn2pN5JdAD+r5Ff6PxJDUk7nu1Y27AK6x4lMWaWmnC3U2F3Hxk90jwKITGwK9be7
         vlzc7ZKLicZ1vi0fsIo2n4FlM2CvL2gN+tGPg0XCpOaok6gNV7is6knjEDTNmfhbdNkV
         2IAS0WE0yh+Ton4sFWijtDO5S/hNuRrLTUqIjzwiFNstsTnqr1NZdWwLS98NHzAA68ED
         8drZ8m4AWcSOJwu4+vuBQ2et4XExZQcAc6nLUBlRiHpwnYxfYZN6JRHCMt0yPBImJ+NK
         LFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723570146; x=1724174946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6oKMxcAL3e82thO5kOomw8I13iPgj4pE84cH0zvDbE=;
        b=EAFd1IsSDvPFJzTt97yHF7HAj6VfDVRnG9RU5OUa92cK1oT/1pkPHbWKpAI0fBXZ5i
         0GidGzDAfYhaGEMN7MTFFx9mra8iwZ2h6sCTh/hMORBaF39F6PmNd0xPEBfiNOz+s6TX
         Kajfi6sjKwNHNuahMibLBqwwu41dtlDnlE6TyHCkScmGhxNxWebw4jjlSOn+gKK9KdSJ
         j49lS4R2qrlVojADE+YN/zcJN31aSnk9umHQ19HiIg1rporkmc+VnZjNHg/Ywd6GfbNp
         0eVrEf0qcemGwvFiJM1FDhSGNypQcEQXB0nw6r0W4xkgPGYd83BTRqppSVWSH+/egEOT
         iTJw==
X-Gm-Message-State: AOJu0Yx4xu+154eAVlQihdgzRY4ZGK+3LmFlnI/sjtdRJ7bJ8pTOmhfR
	le2MZ69rtMRT/eQaJ3ipdrnTuFhoVeUpL3xLtXlhuZn8GExkS/yDQ3Z9MeDfZU/ELuVPRuNZPHP
	I/MABscfbOfQO+rFXH8LHgBy6UFN8XVeG
X-Google-Smtp-Source: AGHT+IHVR+K06oeoz1dEwQhzvOXjm8Ebhw3Ec/Lgy0pBxp1fleXXg/f3nlQjCkC29LN5X8H0pbGYzpDOxrvc9x/BDHU=
X-Received: by 2002:a05:6102:32c6:b0:492:9e70:ef2b with SMTP id
 ada2fe7eead31-49746d0d86cmr2314556137.1.1723570146309; Tue, 13 Aug 2024
 10:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723144157.1242699-1-vmojzis@redhat.com>
In-Reply-To: <20240723144157.1242699-1-vmojzis@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 13 Aug 2024 13:32:05 -0400
Message-ID: <CAP+JOzRJ1iBY+hxO8oFGJU3umknqTO0jT5M0JrnhW4dcq+ABXg@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Check that sym_index is within bounds
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 10:42=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wr=
ote:
>
> Make sure sym_index is within the bounds of symtab array before using it
> to index the array.
>
> Fixes:
>   Error: OVERRUN (CWE-119):
>   libsepol-3.6/cil/src/cil_resolve_ast.c:3157: assignment: Assigning: "sy=
m_index" =3D "CIL_SYM_UNKNOWN".
>   libsepol-3.6/cil/src/cil_resolve_ast.c:3189: overrun-call: Overrunning =
callee's array of size 19 by passing argument "sym_index" (which evaluates =
to 20) in call to "cil_resolve_name".
>   \# 3187|                   switch (curr->flavor) {
>   \# 3188|                   case CIL_STRING:
>   \# 3189|->                         rc =3D cil_resolve_name(parent, curr=
->data, sym_index, db, &res_datum);
>   \# 3190|                           if (rc !=3D SEPOL_OK) {
>   \# 3191|                                   goto exit;
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_resolve_ast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_re=
solve_ast.c
> index 427a320c..da8863c4 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -4291,7 +4291,7 @@ int cil_resolve_name_keep_aliases(struct cil_tree_n=
ode *ast_node, char *name, en
>         int rc =3D SEPOL_ERR;
>         struct cil_tree_node *node =3D NULL;
>
> -       if (name =3D=3D NULL) {
> +       if (name =3D=3D NULL || sym_index >=3D CIL_SYM_NUM) {
>                 cil_log(CIL_ERR, "Invalid call to cil_resolve_name\n");
>                 goto exit;
>         }
> --
> 2.43.0
>
>
