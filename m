Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE54C1DA23
	for <selinux@vger.kernel.org>; Fri, 15 Nov 2024 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679154; cv=none; b=JOoC2IkQQ2kJH8oJg4AvgOnBgWfR7Kvd5Ut4obD2+S+1MRm6/eN69PJByM8slSE9xG7HndOpXGrSK9OMuvwff5gpH6xZknl+bfrI5cumgFCL7Utu+EMAYXS7Z0CUZSFu1A2HeWzJKC6sTGQxZmQzcmtoinILyrCR3D6k/38X57Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679154; c=relaxed/simple;
	bh=rjp+pLpPNVs4bO6Lny0RmDxI1f5AYTnrkpS85Ptu7Zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0j5cstxY8l7KygUOHXUmRQ/JL/UOh6Pah40yrhnT1LhOTgbZwypa0vuD2aLrxTfKLrKR4eOg+8nY9QOREQNfSUifOsX0cFs0LZ35YdGmkQ3QSPFTjos92besLzjKWZOZ3FD6agRfhFAmsDceFIZmkxexSrYBZL4LwtlU/8qmwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/w7Ny3b; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/w7Ny3b"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5142468fa79so353244e0c.3
        for <selinux@vger.kernel.org>; Fri, 15 Nov 2024 05:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731679151; x=1732283951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Srg/Opjh1hiZnOqe7UBIEKcdI47BTfgSsUXSPAMVY40=;
        b=M/w7Ny3bWVRWXjszIzwlfPyudRkuCSC1+7Z0DljvJNZrUHFwGL0vh74ycMw2EmzO4m
         cp7zbxnswwjVZ8S5dAF3Ph7dpODCCiN7ArjD8ZBzgIcHtQR8BQVb0IxRiaMH/4d3fbJe
         +ckC/Nmm39hpQWaFcM2iN6mCf8LSLzik/GX6w55vwb6hJIjwmSLWi/8s1zYD9pZwK2Np
         iNVHjJHMaofxgGX7QiUqF8OP/i20kk/R+QPeQjWGFnPL65PnpLODdpDBE9JwPIg4Cv6Y
         wIU1sBY6g+vCMkpmWrVyUjoi9oKok0EPPXiHHLDdGPtLNU5lgL7Ms6kzeXpddzDddaF7
         WZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731679151; x=1732283951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Srg/Opjh1hiZnOqe7UBIEKcdI47BTfgSsUXSPAMVY40=;
        b=BouPfo9pDWb7LRVdBYYZkfRtyTSKadmU5DMrfFf2bxxhZbD4+0Wf6TU1Kt6i2fPISd
         gwbp2JzbBDyAVdpXunYYXbXoiT/rRk7GRvNv1tlgaGdAw2lsa2DIPNf85gBax0ErFika
         o2iRI2cYKVIDFlqmiWOUapxPPE41Ym6h4VrbVwm1cUfI1sSrkFlOV4YCpGsAJP9H5nev
         YS6PzZMeGZ6RQzKlDBFuu46etA7emrrBmjWFiW+DAL0K6QpUwVjvS0upxdKsAZsrve32
         Nx2DTIwv8vnV90rgNEtZsG8xBlmiDtehQlZG/ki8fuczDuDko3DonD/Px/q95+bOBHFM
         Dvfw==
X-Gm-Message-State: AOJu0YxPx5vscse2B7eChJKLl/8o4hQ/zZ9QAhQUI23JAa9bk80gCRYb
	3rIiiNazXqr8zLaAzCypdQmWH1LJ6aC/VY41FjXQm7jQzaPCmSNs1obr5k9Wgf39OtPzJ3hBJmN
	4PVPYCW93GLilMAQ0Uw/MGs5F1rDufg==
X-Google-Smtp-Source: AGHT+IHyUEdOT6AunaCUfWDEpIgmCDvKuSSLDx85nK4ichFHPu+sXvHHLX7JN37AXnCLR0Rp3XnMaom0GwYzrllyOtc=
X-Received: by 2002:a05:6102:304a:b0:4a4:7928:637a with SMTP id
 ada2fe7eead31-4ad62b5a83dmr2850876137.3.1731679151244; Fri, 15 Nov 2024
 05:59:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104142500.20055-1-jwcart2@gmail.com>
In-Reply-To: <20241104142500.20055-1-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 15 Nov 2024 08:59:00 -0500
Message-ID: <CAP+JOzSPVouL=887pg+_+kQK5Fvxe0R28mgfGKvSz0_=nr2ymg@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol/cil: Optionally allow duplicate role declarations
To: selinux@vger.kernel.org
Cc: cgoettsche@seltendoof.de, pebenito@ieee.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 9:25=E2=80=AFAM James Carter <jwcart2@gmail.com> wro=
te:
>
> Allow duplicate role declarations (along with duplicate type and
> type attribute declarations and context rules) if the multiple_decls
> field in the CIL db has been set. This field can be set by a call to
> cil_set_multiple_decls().
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

I plan on merging these three patches soon.
Jim

> ---
>  libsepol/cil/src/cil_build_ast.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_buil=
d_ast.c
> index 19fbb04e..80e9c679 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -137,6 +137,7 @@ static int cil_allow_multiple_decls(struct cil_db *db=
, enum cil_flavor f_new, en
>         switch (f_new) {
>         case CIL_TYPE:
>         case CIL_TYPEATTRIBUTE:
> +       case CIL_ROLE:
>                 if (db->multiple_decls) {
>                         return CIL_TRUE;
>                 }
> @@ -1744,7 +1745,12 @@ int cil_gen_role(struct cil_db *db, struct cil_tre=
e_node *parse_current, struct
>
>         rc =3D cil_gen_node(db, ast_node, (struct cil_symtab_datum*)role,=
 (hashtab_key_t)key, CIL_SYM_ROLES, CIL_ROLE);
>         if (rc !=3D SEPOL_OK) {
> -               goto exit;
> +               if (rc =3D=3D SEPOL_EEXIST) {
> +                       cil_destroy_role(role);
> +                       role =3D NULL;
> +               } else {
> +                       goto exit;
> +               }
>         }
>
>         return SEPOL_OK;
> --
> 2.47.0
>
