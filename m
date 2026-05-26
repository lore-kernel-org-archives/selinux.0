Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B36260580
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801896; cv=pass; b=W3rjibw3fLVkHm4MJrRVNEdbWyLi4uQpxDbjAUThHY3onrlRNMvn1BH/wkbQOdbMP4B9BDPxg5FEbKPLZQcXVdAV6MnC/EeS8Pyoh2L3qx1EqqodOFNNIWrr5LzGBIESqc4uFr7oQgMIJ9auiaLMWqqUOChHz4eQpsHARqu06L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801896; c=relaxed/simple;
	bh=y8DLdQYRnbFM6w92HhDwc3q8IK7n9SUkH66dgx2T0Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Etv49rvNlS495YOR4LWYplm8jwn8cY51CadhEUq5Ke/8sEl+2sGyyr3AHm3uW83lxcvrwVjiOTZTVSoSAM92ojOLzqm5kG9gDjMdRY2btlDwNRMvEUb6JeKVbFFUnLjkgLk/+Ql5xmDPKnFuOkPCoYK9SRx3pW1CjrDeqtnso/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRPkVJWX; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRPkVJWX"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-367d88b9940so7057120a91.1
        for <selinux@vger.kernel.org>; Tue, 26 May 2026 06:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779801895; cv=none;
        d=google.com; s=arc-20240605;
        b=DWrktjG/lfsjJ4AF6sE//rHhn8A5T2lfdpsIhWsvkMCDJ8l5LIi4SwhPy1fU/lQFSO
         u+dWTU44DDKpjXpMh6Uz5j26AwEgYet7Wp2F6fW+yyc1QaWpsLocrigV+NK4LPzvfmLZ
         /lE4uBxSS8tAWcRcmeKxkA1pCfG3pi+Q2A7cIPJGGj012D795fhDgY36Kjo/t+uuSfb3
         SJti3OIjHCm9jD7otqv1yNw2tgcLCC6dT3aGzm0g+uoFZLvpqToKSfE61iqL0W04i95Q
         SqaSRxbyGQQ/c5SzCIqg/b9fS/uELKV9vKVDzIgc/hq8aYYaJGwqaD2L7EGmR2iAcsgZ
         2nRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tRkXGb8xU8Hs8w9WowxWkxJ2tfxDFQ5SDvO+t3rEHk0=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=lfaRh4FihFn22db+cD4Hvtg/2JMFjXkjG2aYavFcVRV2D6iFztGAkgUOtyKHRBx69t
         s2ijGm5UVtWTkxzaLH5N7pqrtwXzEHzwJj2fczI+y4ajEael0S2SzsMjZcjjedDg3b7O
         rdn9t36oLtoNJNRai01lIQgKbIY9WYEHZy9QocgMt9uvGOYEiWfMQAxyGIyYFlWYwZw7
         /SUD+8WitslF5zNzyCtaGdfrjCsR8hAeVGzTdV5xGf7gcgzQnQgemKSxoNUp56mx73RG
         E2DNDV3FWn1kleHH/RESgaaYle+dWCMm6cZAhvhtDXTSz+AgoYd0SrrlYfETpTYAHZ8B
         JGIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779801895; x=1780406695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRkXGb8xU8Hs8w9WowxWkxJ2tfxDFQ5SDvO+t3rEHk0=;
        b=nRPkVJWXaEQkc8vejFRn04omnrKSzZiLG1vvc3he0ErH8r4/vSufmS80GojksB8sr5
         9wBQIusF67mRsx/UC/as2Ecp0fCF6xIa4UNnh1SiSDfuciRG8oH6+zTD4gGMBTVvN1Q7
         mKvMBc+vVfDf3kqfiAKzlIWoFUYksmSb2QkvORHVN93Ux/e3zrKtRd7lpg+nobds3d2t
         Mv5VxY47pqnWhA4zLuI5kPWHSuzaUbDhpMtxnQEpaq4/uQ+cu0kcGxJjpkTfYYakRVi6
         fbytNwZpCdflCxVXqNVrt7HrUHyAlrmwYhVoUf4PStM/wdhbVJ+CUnjhobh8HFSladl4
         3Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779801895; x=1780406695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tRkXGb8xU8Hs8w9WowxWkxJ2tfxDFQ5SDvO+t3rEHk0=;
        b=B9mo/w2unfHemw6jpdqX+sscwSAgwHLk61PC3BiWkisS/2Iv85U4yQ41+5lahxCtv6
         5raJNQ/etskRbG4vaM/2o+7ooahK3g+IcfNoMHYKrXBvTc+9199F59ijBmoHp7D+3nOK
         txJV7K7fDQmlekxJGrSvgJciDeivpFRyVY2ZuNaTn6ibGXJnRwB/rcxddM5o3mkAO38Y
         RPuGK7QPME3FolydHCFmQMQQBFYDFY8DUf6JPWa+B1kiW7aC7IalxMbtz08/tohUmXuL
         MAdS5vsZpo8sZP3Td5hX75zM6PrzgD0pxuP+uQ0Bpr3q0+dp4fWZzPt15N86ssPRt0PX
         SpFg==
X-Gm-Message-State: AOJu0YwHddqGXiLKTulD2SNWxl2gcLIPPe02H1gy7/ShU9B4JN6eaNTE
	IBUZE7soBwf9dtOUmhXa+gqPk4e1iQHkWu46Sx9dCX7W62QBQKPudaS6m2szOvmxPzvXXuA/hax
	krcCNAT3NjX84Oee7zV1WHi6mcQ5QlJtEnQ==
X-Gm-Gg: Acq92OHyAydMc8I4GVRIKSaED/aA92Zj6oU0VfFQVbGpAkkxahxk0j5BaLuyleVU8So
	oyu7sqQZyY3xM/JvKlasMMP+s/ODy2A4vaJwJKDSUMa9ZqjGO7Wyj+FpfMTvLd5bIk5dlI6OD5O
	epvzbltrREiRoIkgzsyNJMs+H0BWBOaJClk/snWH5hM/jn5S8m0NOeRFSKo5tYzicaBF03PFF8x
	n+oCJqzk0UQuARx9lMb8hUTQWdCvVY3UHirJnaNqHXKlA/CQSnSdknlQGzfHFS7kwRig7XmtocX
	iz29UyE=
X-Received: by 2002:a17:90b:2e86:b0:369:e217:d110 with SMTP id
 98e67ed59e1d1-36a678b86a9mr17541288a91.27.1779801894806; Tue, 26 May 2026
 06:24:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521190627.34885-1-jwcart2@gmail.com> <20260521190627.34885-2-jwcart2@gmail.com>
In-Reply-To: <20260521190627.34885-2-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 26 May 2026 09:24:43 -0400
X-Gm-Features: AVHnY4LXys5jNY_SFKIldBIQuamkFoEBFZpNBYluveGAWf7002Gbj0Bu7gjVY94
Message-ID: <CAEjxPJ7=8LfDLGkeX_ZbfqKejFn53mZs0tp4tGbuCc5L0dxE+A@mail.gmail.com>
Subject: Re: [PATCH 2/3] libsepol: In module_to_cil correctly choose tunableif
 or booleanif
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 3:06=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The flag COND_NODE_FLAGS_TUNABLE in struct cond_node is calculated
> and used only during module expansion, so it should not be used
> to determine if a conditional block is a tunableif or a booleanif
> when converting a module to CIL.
>
> Instead, set a flag when a tunable is found in a conditional
> expression so the conditional block can be marked later as a
> tunableif.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Would be good to add a test for this if we don't already have one.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsepol/src/module_to_cil.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 5f1e4dbf..f736288c 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -1280,10 +1280,12 @@ exit:
>         return rc;
>  }
>
> -static int cond_expr_to_cil(int indent, struct policydb *pdb, struct con=
d_expr *cond_expr, uint32_t flags)
> +static int cond_expr_to_cil(int indent, struct policydb *pdb, struct con=
d_expr *cond_expr)
>  {
>         int rc =3D 0;
>         struct cond_expr *curr;
> +       struct cond_bool_datum *dat1;
> +       uint32_t is_tunable =3D 0;
>         struct stack *stack =3D NULL;
>         int len =3D 0;
>         int rlen;
> @@ -1303,6 +1305,8 @@ static int cond_expr_to_cil(int indent, struct poli=
cydb *pdb, struct cond_expr *
>
>         for (curr =3D cond_expr; curr !=3D NULL; curr =3D curr->next) {
>                 if (curr->expr_type =3D=3D COND_BOOL) {
> +                       dat1 =3D pdb->bool_val_to_struct[curr->boolean - =
1];
> +                       is_tunable |=3D dat1->flags;
>                         val1 =3D pdb->p_bool_val_to_name[curr->boolean - =
1];
>                         // length of boolean + 2 parens + null terminator
>                         len =3D strlen(val1) + 2 + 1;
> @@ -1388,7 +1392,7 @@ static int cond_expr_to_cil(int indent, struct poli=
cydb *pdb, struct cond_expr *
>                 new_val =3D NULL;
>         }
>
> -       if (flags & COND_NODE_FLAGS_TUNABLE) {
> +       if (is_tunable) {
>                 type =3D "tunableif";
>         } else {
>                 type =3D "booleanif";
> @@ -1429,7 +1433,7 @@ static int cond_list_to_cil(int indent, struct poli=
cydb *pdb, struct cond_node *
>                 if (!cond->avtrue_list && !cond->avfalse_list)
>                         continue;
>
> -               rc =3D cond_expr_to_cil(indent, pdb, cond->expr, cond->fl=
ags);
> +               rc =3D cond_expr_to_cil(indent, pdb, cond->expr);
>                 if (rc !=3D 0) {
>                         goto exit;
>                 }
> --
> 2.54.0
>
>
