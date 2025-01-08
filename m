Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3559B15853B
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360697; cv=none; b=rjyvZDSDByho8NTfcK7ADIi07h9f9nJZN7rmx4+y9j+G33FCOKtmqs0AKFgTqgs/rNXZWWlHmvpFkvEIlvr+Q/+hUKeWDYR0MP+1RVu/c8ohG8epyqMklr7FVHDqsCzm0TepG9RHKqTB+vY2IB4MRWkWE+p9sOISRhzSBZ5YqSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360697; c=relaxed/simple;
	bh=chi76t8grp4PecR0nTJ4skZT3OIVmtW68KCLiepcezQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRvIKzCg6vBnHisU0JHZgVAYLEU8Uyaw0YL7ARuQ3aG1vU8MSbcSLGoWBRiESL6wZpqtiDWz/159NmUgewLXiNIHglLieGAnbUDOv/f0DRuL7iksahdoxTHoWfBXOMVqOH2J3ifRtbzP80ZqqpMsLYFumiMuftHxOttGy1e8Ww8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGsLs8Rc; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGsLs8Rc"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-85bad7be09dso62112241.0
        for <selinux@vger.kernel.org>; Wed, 08 Jan 2025 10:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736360695; x=1736965495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTvtLD6GwLFZEYTxqOVoXlDGl/2dZfqGGszqb8k4oaw=;
        b=gGsLs8RcgxCobz+0X9b6XaO2BxD+0S2tIvj6Eh94Ogu7/IqWFOeLSrSWbvi+w2Zvuf
         Zb67s4JVtNQG75HcAIINw7DvN+EGRY5QTEADZtthxqGCVRWSzp/3L5M7QmZqlcdLDEVX
         2qlsTkEzKxHvfDtqJJIGdKHOaLVxvsz5nlk3akWffvpZ0ct796nL30QWMwUyopWd5Vki
         L3p5I865ym1+eohX1vO/w/IJOmuNt4UR2WBDrE2YsAfrq8fdWe0GiTuYNe/0Rw5yiIB9
         zsxiY1xR4Nj2KZz1HTfaRJkO+ssPKCwnUrQYJf2eB0H1Y/b7+TkKH8ivO7diNDqwKRhr
         8Kug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736360695; x=1736965495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTvtLD6GwLFZEYTxqOVoXlDGl/2dZfqGGszqb8k4oaw=;
        b=bBBYu0E59X6X0yYj9d5r4EoAUiAchtMy1W8TMq2PYrtfHQDjwdwR1B29QN8qZY1zla
         8fRN8TtkVanYjtDBn0+B2AX7FlpQIj2v2mYQbnTNMPgzcv/6TI3p+mo3TdP6TD6VQnRV
         SDLIyHZNpnusIgenJ1LR5AcduHtSlc9smW85y53tZHSBIRNrHkwbwQGrbkGz1asRSad1
         G8sMm1DQNUKKfvbrckuuR9SGp2t5Es9U9DRGXvlosZxdqkJ04KrBY04/A5MHG3EPmBFS
         dFpUd9Hve2HemcHkGGp+kjGIEMzwIuBxFslx0rT1Md4DHBa1SUepgqZkSLNianekB6GL
         TsEw==
X-Gm-Message-State: AOJu0Yx52++HOIkoXkRVEp6hwqmrWr7o20py71WrY6qFWJ2bPGMTxhXj
	nlFgSBMhCemkAI2tvUqvzHd9ec/VDZqhM2p/FRW58GmKYG7g+hzlusvg/AbWlGbZkz70mzuxz47
	2lgqwOSQPq6KDGxJeiVWgGJtTDK8=
X-Gm-Gg: ASbGncv1ZCJ04nNLzT6JEFCWPnP3YFGTpcy0uR1RLqqOIhh5KOg5lx6ikvpGojZiNNW
	JFnAVojNULuUg6tZAY2AeGdiwpi7qynuWhsTheg==
X-Google-Smtp-Source: AGHT+IEvRXiOb8ku/sB/5PW7yQmbe/E+cf2M/6kZQ/FOZ0jypaoMPqWzXep0V103AUHQR33URtBojoSQTG6mObbYbAM=
X-Received: by 2002:a05:6102:3c8e:b0:4af:e61d:e22f with SMTP id
 ada2fe7eead31-4b3d0eee48fmr4001162137.24.1736360694964; Wed, 08 Jan 2025
 10:24:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230140523.60053-1-cgoettsche@seltendoof.de> <20241230140523.60053-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241230140523.60053-2-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 8 Jan 2025 13:24:44 -0500
X-Gm-Features: AbW1kvbQVPJHgJHukQKsEq6fdH3gJsXvKkCQfxe5kTe5CClFyhvr00F8cQl9fkY
Message-ID: <CAP+JOzQkEU_TGtL4cYzZAL0tUARjyL1y1jn1MXs6WdOYRwARpw@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: fix typos
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 9:05=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Found by codespell(1) and typos[1].
>
> [1]: https://github.com/crate-ci/typos
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/kernel_to_cil.c | 2 +-
>  libsepol/src/module_to_cil.c | 2 +-
>  libsepol/src/policydb.c      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 2d563e7d..ddca2b62 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -1802,7 +1802,7 @@ static char *avtab_node_to_str(struct policydb *pdb=
, avtab_key_t *key, avtab_dat
>                 } else if (datum->xperms->specified =3D=3D AVTAB_XPERMS_N=
LMSG) {
>                         xperm =3D (char *) "nlmsg";
>                 } else {
> -                       ERR(NULL, "Unknown extended permssion");
> +                       ERR(NULL, "Unknown extended permission");
>                         goto exit;
>                 }
>                 rule =3D create_str("(%s %s %s (%s %s (%s)))",
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 0ede0c9b..ae9a2b5d 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -709,7 +709,7 @@ static int avrulex_to_cil(int indent, struct policydb=
 *pdb, uint32_t type, const
>         } else if (xperms->specified =3D=3D AVTAB_XPERMS_NLMSG) {
>                 xperm =3D "nlmsg";
>         } else {
> -               ERR(NULL, "Unkown avrule xperms->specified: %i", xperms->=
specified);
> +               ERR(NULL, "Unknown avrule xperms->specified: %i", xperms-=
>specified);
>                 rc =3D -1;
>                 goto exit;
>         }
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 0747e789..8443380b 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1662,7 +1662,7 @@ int policydb_load_isids(policydb_t * p, sidtab_t * =
s)
>   *
>   * arguments:
>   *   policydb_t *pol       module policy to modify
> - *   uint32_t sym          the symbole table for insertion (SYM_*)
> + *   uint32_t sym          the symbol table for insertion (SYM_*)
>   *   hashtab_key_t key     the key for the symbol - not cloned
>   *   hashtab_datum_t data  the data for the symbol - not cloned
>   *   scope                 scope of this symbol, either SCOPE_REQ or SCO=
PE_DECL
> --
> 2.45.2
>
>
