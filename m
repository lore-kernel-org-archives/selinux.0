Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4458984A27
	for <selinux@vger.kernel.org>; Wed,  4 Sep 2024 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478638; cv=none; b=T9P+Zi03yfC889jT0KOwJVQCRNVrYVI/3CW8wt3ZE3ROOjVqDc6VMxEb2thufGzM0SUVfIDXtCbDI4Vw6VYVVV1pStwNNY+rUGZ9kS7DDj01SpH6OfAs72V6YHVK2A+MgWkz/ld/qks50KW3mW3Hw8qc+sWO1ZyrydoA2GW4nHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478638; c=relaxed/simple;
	bh=fO3I2DYOkPnyck9ihvR26LkE9jU7two/b/+YwgF7uEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jVt6ID+KE/cnbduCDc27YW7T5lNF6Pr1TXx3FtZ7KmWwEfTm2N8iHkjj+Zkim+T9+TvH8q6mfrxNk0QMBteKgcn6HLn4Vn93qUE2lCFiRMYKJROQXiCvZ8tSxWVZVFIuX6+2asK+VZbVrFFrXsJny4RGkVFNhxYYEZp5qzWIoEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJh0isL2; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJh0isL2"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-498e40756baso2267397137.1
        for <selinux@vger.kernel.org>; Wed, 04 Sep 2024 12:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725478635; x=1726083435; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfcQhfI+jvfhsFbqZQMspT2HeadCFX22l0U12eLlHpI=;
        b=MJh0isL22/nnaKP/4gkyg9GWXC4Uo2rg2ARcWvWdM/wIy0tfd2U+xJLF7IKTPNABz+
         /n8NNH2iH/9sfkO7B5qRH8ZFoXabedTYFqQtKWhK5d5Rdydq/1WgMEH9zUJA6Y6TX+Ix
         HC1BTwTIt/o3IBAPa8uUj1c43RnKDksAeoTnKuynNUbhmnOkbqtUgsI2kcdU6Rq9B4Mm
         QAMuHxKx9+qTlgp13DSVQOhrt5U5Z5S1XjB32wVIeZb3DsV6QEWk7/ywtKFs4xZtNHWX
         QkB1hzCH2/hPfXpLmgmIlESmEQLyGO/KfTeIcjc2EAwGXx17L+BBJSxFAgBJ/agBerCF
         4sUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725478635; x=1726083435;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfcQhfI+jvfhsFbqZQMspT2HeadCFX22l0U12eLlHpI=;
        b=l57HVTnbtZD2l5UwUZVutRsqLYJhvrR2TAWkK1voaIJXbmRZDZ6hsheWTsAuevZOEh
         DmmSieJkAH+nvllJomhOj5zToPOXS7E2MBgLwf1sFLhkYkxzZDcqJr1K7n2AqVspcI2W
         OU7fNaNu8SzK5Gg8BVeByfD+tvxkooG4GDcl0Pzm3pPYuxKTsi6X/9C/IfpSooW9LOK5
         s1akkwThdTNlj8/Dn1iZfcvTofHjMS6P1e5JGmgbjfk6mJMggdjEuKJJ0Vla6CFDrKDl
         J2SIOdKIA7wDnf1ImKFbU8tNIfIgLY+wcqspkNKLujr9XxQDW8gR+75nB3quVdWOJwx4
         11Hg==
X-Gm-Message-State: AOJu0YwR5jfywDVmfG+7YznlDulAcqu7eTL6kQNBxs2o8Dj/p57zoFrh
	CgD5/+QX+MMgLzcISI1mTjHxNLdfE0mMjY6Y/7SOCQWhFirWc71Zup3C/TD/J/iN2JlhHg0CBfd
	FrXPgsVPERl9S8MWs7lAnMpbeTE7vew==
X-Google-Smtp-Source: AGHT+IHfN16BK5CAnz8Tb2ehwVqHw5cnq5FcdZnrmILvL+a/EzsyKHxy+wzevG06CSAxUip+cdyKcAju6FgZZUeXEKc=
X-Received: by 2002:a67:ef1a:0:b0:49b:c95a:5bb8 with SMTP id
 ada2fe7eead31-49bc95a6110mr1021691137.18.1725478634680; Wed, 04 Sep 2024
 12:37:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812165633.49121-1-jwcart2@gmail.com>
In-Reply-To: <20240812165633.49121-1-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 4 Sep 2024 15:37:03 -0400
Message-ID: <CAP+JOzQmwxD5oO9VESSAbwYFSofMd0HiOoUBdv+E1=Ks9Xi_aA@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Allow dotted names in aliasactual rules
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 12:56=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
>
> The function cil_gen_alias() is used to declare type, sensitivity,
> and category aliases and the function cil_gen_aliasactual() is used
> to assign an alias to the actual declared name.
>
> Commit e55621c03 ("libsepol/cil: Add notself and other support to CIL")
> added "notself" and "other" as reserved words. Previously, a check
> was made in cil_gen_aliasactual() to ensure that the "self" reserved
> word was not used. With the notself patch this function was upgraded
> to call cil_verify_name() to verify that the other reserved words
> were not used as well. This change prevents the use of dotted names
> to refer to alias or actual names that are declared in blocks.
>
> The check for a reserved word being used is not needed because that
> check will be done for both the alias and the actual name when they
> are declared.
>
> Remove the call to cil_verify_name() and allow dotted names in
> aliasactual rules.
>
> Reported-by: Dominick Grift <dominick.grift@defensec.nl>
> Signed-off-by: James Carter <jwcart2@gmail.com>

I plan on merging this soon.
Jim

> ---
>  libsepol/cil/src/cil_build_ast.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_buil=
d_ast.c
> index 56dac891..6884f12c 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -3174,16 +3174,6 @@ int cil_gen_aliasactual(struct cil_db *db, struct =
cil_tree_node *parse_current,
>                 goto exit;
>         }
>
> -       rc =3D cil_verify_name(db, parse_current->next->data, flavor);
> -       if (rc !=3D SEPOL_OK) {
> -               goto exit;
> -       }
> -
> -       rc =3D cil_verify_name(db, parse_current->next->next->data, flavo=
r);
> -       if (rc !=3D SEPOL_OK) {
> -               goto exit;
> -       }
> -
>         cil_aliasactual_init(&aliasactual);
>
>         aliasactual->alias_str =3D parse_current->next->data;
> --
> 2.46.0
>
