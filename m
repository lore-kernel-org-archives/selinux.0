Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4C93A961E
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697897; cv=pass; b=A9nyUmVwWvtQ/sXhwd6ZfLTbD26D07bOyUPztJ0ht7NWXWR3tbvbFIMW/BUs+qnTDnUvHCpX5+RpaZUo6WGDm8qeKRjYmHCWpd3ViNuvt11/KsN5OORQ8Cjb3g+bbeNnuEzjRgIa+I2m8EDezvc1/B8V5fHB1AfuJaNi1/jl+HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697897; c=relaxed/simple;
	bh=WZ2q4ClchM/chAF1MzRvgDL4Uxc99tBZ8pMY2j9hBKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfH9grKf7CP37s/5cmNBylnq7eSMUeo4DpD2FFXzArUYoL6pMcTFZlZB8xoEV72Xp+7UcU67kqf+DOcvG/R316FuVfdGH73EJN/Cbu4c4UtSWKUqAPsoqV/fdFb/3Fw3yT6bE+I9JQqRXGDQCjAlP6ZKd+Q0hxqiCsfZnp0Xvog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGTS2uVo; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGTS2uVo"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38e84ed22bdso67541201fa.2
        for <selinux@vger.kernel.org>; Wed, 13 May 2026 11:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778697894; cv=none;
        d=google.com; s=arc-20240605;
        b=C9+loXEn0ocV7leu6O6iZthVvWJFgGqh15qqta5PUxk3c0r9eidUF+lBcXM2I4bMrO
         FlJISG2UlVffVmRpS8er910PTaic8mG4FewC51WmnYXTun58hKmjyDxD7EfRWMTlmVGe
         exP0qArzsf6uFvB3uVkTnmKGXVhlaVxKqp+DQd5ff/kkDM1XAa4J0zHHuahPjW9+69l9
         REkcye57g2pgbhBHycMDl/K6+0DEFuxZMZXE6Y0IFA0L8ws1SmuIACTs+Qc25AEjSeEb
         mXoEvTPHKGq5epuVFkNxuCvxMgcjTphbMCwLNibtBLq3bKlXGFARXOUjjjsOSA3vL92s
         TR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/i54lnvpnhUm3i3215LvZuiXkEnHBQS7c34L5e+vh7w=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=IvuNAEwQagU6UNOEIPapLFjUMIP0LomYMLb3LEEXWCuucQNryyHLyx9CeGU9eeBBg5
         jx5mI9qNYB4VMlT8h0oRHT/qENK4AaUDN9K7gIlnJqFpMOijAcYC0PQmRfmzp8Vee3jy
         iwwi7K9ZfFmDJQbxFbnmufU4wAjlVbj4HsXJ7eLeEYedTecVb3rq+/EpBebOFk/sEWfJ
         9glwPOkvOCIHbrRhw01EldcGjH2nHNa9uoP34GzYJbzCRFXQBiTApVwsrmShmoRVtcvT
         GteXqbk1v35cGvTmPb31VHp1bZF/oNOJgQ698zNI5dLLje3DBuIoiV29PTrmIroD29EK
         milw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778697894; x=1779302694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/i54lnvpnhUm3i3215LvZuiXkEnHBQS7c34L5e+vh7w=;
        b=FGTS2uVoWKhjWy9NoQZl/vDCEUNEtGCzIMFlqR0WsXDOYfqxi1gM194mFxHW4M/WAb
         MqOSoUEBTCQTaBy8Kd8kzPQnadykSEDyJorjD5krlD64CIvTa05arMDP9YvBmLY0rijx
         ZXK0fCyZNVxNXfU0InkX92Kc7MHt39fHO6YKZcPZbnQkUHotu+12z7+BdBTRdQ82n5uV
         uMuzST80msGcQhW+05cd4R7ARwIUmWVxOV66Sr+Psj0n/ZcdUVP4F36WDXb1nbHRsuA1
         +LKV+dWqjCc1vepvAWUAbAXGuqF+xJxh80v0u2882m4gta5ybdJotdJIiSXyVsjE4tUI
         RL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697894; x=1779302694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/i54lnvpnhUm3i3215LvZuiXkEnHBQS7c34L5e+vh7w=;
        b=T1v6GmLtyChOO78rleKZV819zAYS4rcrTgxaI95MYI7QEJEwkx6v9j5orfQNj3x8S5
         t5StjRdvVntno5DC1rch0TEYcCFt9sftrf36Uc6ANAyywvO0a2tpv6cVJv5ijOD2GEMK
         PTubuPhxG6dm1zn1GoyHiVBPbcDEGKEbprLRx6Agq2tMaRwNO9bnz6o4DkIz/zrhrutf
         Vwa/2vVws2TCGFCwJxyq+UG1AXcNAR2otrJPDm/+Y/zwz9NLdq1yOFqSpf9heLIMGd7B
         ZazzweKnfuImuPs+j+tkSv3svTJqQc2Z1iERjxygpARF21FF9baCgvtKV3VlpK2pUdFW
         9IMw==
X-Gm-Message-State: AOJu0YwOnwo4psVw26AlO2BAiVPPui6mHe/66/js/f9Wl16PYHea1F8j
	p9KsvXdei8hljd2oslEW/60AeIHKv8mGZM9HDabEBOzgq0WElOVWc4boma+0R7nP23J5SacH4pG
	9VbMDK31m1Cfd6afyfWZiYrskwWWVFeU=
X-Gm-Gg: Acq92OE/fP3/84uQChYF6sHkP+lRi1wJZCA3YMMHZyT/MOmdyXbxtnJDK7ihAl2i9l0
	0aVHhOBuGCaeCmXs8SLw6WOYmUJV5yJCtf08PQDR50CF63mOHdPKBSaGZrwrqwod2CQR/ljJ5LU
	WMs6ZG0UKSeVmA9iKdvMmfcdpWm1jQPZ/nc4Ue7QhzupR3qoZdBJewS3xtFH7tCEaRz8wYc83Xu
	RsjeT8BNvcIxe337PhSN+kFvags5u0K8jYz9BzgbWZrpIgEXcufsHqSnhEvn6vDmsnWUyrYUovz
	hLDE
X-Received: by 2002:a2e:be83:0:b0:390:ff98:ec2e with SMTP id
 38308e7fff4ca-3944b783beemr17323101fa.20.1778697893645; Wed, 13 May 2026
 11:44:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501230959.65581-1-kalevi@kolttonen.fi>
In-Reply-To: <20260501230959.65581-1-kalevi@kolttonen.fi>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 13 May 2026 14:44:42 -0400
X-Gm-Features: AVHnY4ITpxS-3a3vUVx9zW_D9833h93kRthzop2HhvHc4mfYl9iTBqO209Q3j6M
Message-ID: <CAP+JOzTZHui1Ce-r34YOrjbDOABL=h4YMOrzJUqWxaEnmE3eYg@mail.gmail.com>
Subject: Re: [PATCH v2] checkpolicy: use calloc() so no need to do memset()
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 7:10=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.f=
i> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
> ---
>  checkpolicy/checkpolicy.c     | 4 +---
>  checkpolicy/module_compiler.c | 3 +--
>  2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> index b808e4d0..34c21199 100644
> --- a/checkpolicy/checkpolicy.c
> +++ b/checkpolicy/checkpolicy.c
> @@ -235,13 +235,11 @@ static int identify_equiv_types(void)
>          * Create a list of access vector rules for each type
>          * from the access vector table.
>          */
> -       type_rules =3D malloc(sizeof(struct avtab_node) * policydb.p_type=
s.nprim);
> +       type_rules =3D calloc(1, sizeof(struct avtab_node) * policydb.p_t=
ypes.nprim);

p_types.nprim is the number of types, so that is the value that should
be used as the number of elements rather than 1.
Thanks,
Jim

>         if (!type_rules) {
>                 fprintf(stderr, "out of memory\n");
>                 exit(1);
>         }
> -       memset(type_rules, 0,
> -              sizeof(struct avtab_node) * policydb.p_types.nprim);
>         if (avtab_map(&policydb.te_avtab, create_type_rules, type_rules))
>                 exit(1);
>
> diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.=
c
> index 4b2f98d8..a6ecc939 100644
> --- a/checkpolicy/module_compiler.c
> +++ b/checkpolicy/module_compiler.c
> @@ -842,12 +842,11 @@ int require_class(int pass)
>                                 return -1;
>                         }
>                         allocated =3D 1;
> -                       if ((perm =3D malloc(sizeof(*perm))) =3D=3D NULL)=
 {
> +                       if ((perm =3D calloc(1, sizeof(*perm))) =3D=3D NU=
LL) {
>                                 yyerror("Out of memory!");
>                                 free(perm_id);
>                                 return -1;
>                         }
> -                       memset(perm, 0, sizeof(*perm));
>                         ret =3D
>                             hashtab_insert(datum->permissions.table, perm=
_id,
>                                            perm);
> --
> 2.54.0
>
>
