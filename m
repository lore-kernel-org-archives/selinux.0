Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF9113E41A
	for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 20:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729628566; cv=none; b=mU+fxDYh5Y0Coal+i64yyLNApu2VZ/94ypwaoXAjkyiUMDjXBYm4bOWs7B5SQS4R5c16PkZvlftLvb2F76yZIUeNWseWby9so0vsv2MRnbPiRIkOkyJGRTD6pO81itR4W0/klkat1mqfMgloXVAvW4HkWxqBV11Z4rExSln5Vco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729628566; c=relaxed/simple;
	bh=dzZudAPzKoRrs1QoxqEZST6W7tyU57yfHjtr6OgehiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASsjW7fXLrKUnpCWaU7FULpZZaSTqyGWNeFlOv/XAbCz2gyYBBt20MuUSMBRQlV3kARX14FneZE+Thzy3iRc5CGf4rS00lvn9LMhHf1ChZPXsJF1PXbsHuIiJ8GM4wnFZWltESefPnlmbXTY6OaE32rQNOdBveZceRsrgi+UPuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=el5q6oe6; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el5q6oe6"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4a492f73befso1723810137.2
        for <selinux@vger.kernel.org>; Tue, 22 Oct 2024 13:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729628564; x=1730233364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4p3rpeQl7tIVXyBJ0RqgVNY1sTRyW3ucImEIGtDEU0=;
        b=el5q6oe6A3vJDFnUfYkRk4YxciH4li4rawTcaOcYWE+JqizUUYxt9uzcBaZBRVODiy
         QpJLSesK0fQCG0OLl/1rQET1ovmiOrc68rEFMmJ8VAUVDtMFg+wCELhj/k3MbGxi+bIF
         LgxzyXNBjXRNhYJLqDu185hh+joHTYjvSpkMFQc+qqqfPJjJs9tJiiFRo3VlDRCz6J1G
         JodmdLxOrGdgCLAEYqktVBq/dJgp8AZYxxxinTDKH0Db4CibEMjcYtrF+Jhgn6DL8WSd
         HIRqlJlhUy1uHGqVf/ofnVgKhviytD9WD2Eu8md1hFD7uu1euMjyJT8cpfVrfOij6mJ5
         BJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729628564; x=1730233364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4p3rpeQl7tIVXyBJ0RqgVNY1sTRyW3ucImEIGtDEU0=;
        b=mLxkmfZXPVE+KzwBdxQScegEiaZ9PTaF7wxEi9XcsDMNe3BQcHr/eCl/aA9RECskPR
         zLIht7cS0S8derbsuR5EFHr/mghdhAKDXXHJ4NLK8cyEtaXXCPKXe+fSGVIGLDS/9vYJ
         TcoSRhhVNg+paQ66xYGWH1XgbsGDEKNJrH38Nm+PH5eqebegCV/zi3bCANLjq8Vs6zdr
         W7Y3jAinemxgkv0oew3vV+Y+EQtxGSv4/EfXipO/w/eelJ45+vOMAHwM7FB5XfU+t281
         uS0dR7x9E4jrUCfLi5eNESrG7rlU5l4OFI5+NIa+gdvlno5mN4x82tmlKNwcqleMn2b2
         QAfw==
X-Gm-Message-State: AOJu0YxAV5amF+znEfCxsghEphor0XOqgoYeBKdC+niAPt1cXpj83bgU
	ZmHCk8oy1+JI3EDrKUirI59Nzrz4fzcmf4b3xiUlT0JqtT7MCCKmWYlEEPMFQLAj3/KVN0bmuJo
	XUf+2Q8yak16YpZxWEV1K64XBQ8k=
X-Google-Smtp-Source: AGHT+IFGlkE1mOValKj3pHe9+Z45G+z+Jt4Hj6/lEltcB/KEMYz1eQB427IE3zQP5YCFdQBKeskp4l9acbcw/3t3aKU=
X-Received: by 2002:a05:6102:dce:b0:4a7:49ca:4ba4 with SMTP id
 ada2fe7eead31-4a751cbebc7mr322114137.27.1729628563948; Tue, 22 Oct 2024
 13:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022090314.173002-1-vmojzis@redhat.com>
In-Reply-To: <20241022090314.173002-1-vmojzis@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 22 Oct 2024 16:22:32 -0400
Message-ID: <CAP+JOzRURZwsyvGzs3U7M7mw4NWD3Brh-K4wnztCS81MLYRHYg@mail.gmail.com>
Subject: Re: [PATCH 1/4] libsepol/cil: Initialize avtab_datum on declaration
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 5:09=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
> avtab_datum.xperms was not always initialized before being used.
>
> Fixes:
> Error: UNINIT (CWE-457):
> libsepol-3.7/cil/src/cil_binary.c:977:2: var_decl: Declaring variable "av=
tab_datum" without initializer.
> libsepol-3.7/cil/src/cil_binary.c:1059:3: uninit_use_in_call: Using unini=
tialized value "avtab_datum". Field "avtab_datum.xperms" is uninitialized w=
hen calling "__cil_cond_insert_rule".
>  \# 1057|                       }
>  \# 1058|               }
>  \# 1059|->             rc =3D __cil_cond_insert_rule(&pdb->te_cond_avtab=
, &avtab_key, &avtab_datum, cond_node, cond_flavor);
>  \# 1060|       }
>
> Error: UNINIT (CWE-457):
> libsepol-3.7/cil/src/cil_binary.c:1348:2: var_decl: Declaring variable "a=
vtab_datum" without initializer.
> libsepol-3.7/cil/src/cil_binary.c:1384:3: uninit_use_in_call: Using unini=
tialized value "avtab_datum". Field "avtab_datum.xperms" is uninitialized w=
hen calling "__cil_cond_insert_rule".
>  \# 1382|       } else {
>  \# 1383|               avtab_datum.data =3D data;
>  \# 1384|->             rc =3D __cil_cond_insert_rule(&pdb->te_cond_avtab=
, &avtab_key, &avtab_datum, cond_node, cond_flavor);
>  \# 1385|       }
>  \# 1386|
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  libsepol/cil/src/cil_binary.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index 3dec1883..eb6120d9 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -975,7 +975,7 @@ static int __cil_insert_type_rule(policydb_t *pdb, ui=
nt32_t kind, uint32_t src,
>  {
>         int rc =3D SEPOL_OK;
>         avtab_key_t avtab_key;
> -       avtab_datum_t avtab_datum;
> +       avtab_datum_t avtab_datum =3D { .data =3D res, .xperms =3D NULL }=
;

Since we are initializing it here, there is no need for the assignment
on line 1000.

>         avtab_ptr_t existing;
>
>         avtab_key.source_type =3D src;
> @@ -1346,7 +1346,7 @@ static int __cil_insert_avrule(policydb_t *pdb, uin=
t32_t kind, uint32_t src, uin
>  {
>         int rc =3D SEPOL_OK;
>         avtab_key_t avtab_key;
> -       avtab_datum_t avtab_datum;
> +       avtab_datum_t avtab_datum =3D { .xperms =3D NULL };
>         avtab_datum_t *avtab_dup =3D NULL;
>

I think it would be clearer to just do " =3D { .data =3D data, .xperms =3D
NULL };" and eliminate the assignments on lines 1375 and 1384.

Thanks,
Jim


>         avtab_key.source_type =3D src;
> --
> 2.47.0
>
>
