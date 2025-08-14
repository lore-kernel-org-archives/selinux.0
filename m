Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5E2321446
	for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190099; cv=none; b=q3gTUOsOV/adwP/Uawi07H+pC8x974lZvWGxSXmWn+2wZ/mtSGvzJQ3A3/uo+5cu2x7YnxfUWW8jx4t1+tsVacnjSo5+1Etvy0U9L1g3B8Z/PKgpP3OGQ9HbZHG7rM0dFcefwD1Miims5yE0PfDMblvAhe9fK3/rswMBymHYVDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190099; c=relaxed/simple;
	bh=rsSQ1tqV4BbsqTyWzkkWL3ca4cun9OD9vZEW/6ns5jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7ymvDzmoIciwXaZJJFI2THbnks0IvFudm+jPdAYvPHFEd/jvdRc0yV/4nA8Iu8cWEjZuRjPPfGvUutkQeGagQ2iP+PkPuqdvBNS6qxoFwt75F2fTqTnw9LkJKc0tn29gj867ML7l/F544jhUgfZc/L06Bjhxt652MugfxY/Y7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esLbBSp1; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esLbBSp1"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-89018fa6f6dso326055241.1
        for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 09:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755190096; x=1755794896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLDrrpafB1dc7zKQbNRbgWKK7dMiwCoZciqkMWYR9Ro=;
        b=esLbBSp19ggbnpDnAvH1PYoE2NL8lLbKbhPmGMKxiMAZ1iyM+WotfRcwY/EBjN6yvp
         bY2ym5lVZH2VrWXu8GQ/1jeAO7VxLAp0TixPlKR/bRlCQVbgJBCn4ECmlBOPyqqlF5oB
         bMb2QN08kd5mVQxpK/f0ouZRYDvoxYvDFAT0/K7cJlI4gAwaV9oXq74myPhOUPbpySah
         xf6fDQLOEy+iMmWw3ZaqB8mNZ0kDh49eAW19K3fXt+hyYMOJpCr9cxQt1rFKOd0DCVc6
         u3h7rI1s7j7wzDMVxKumavqBY5pOOyWtYl9rElpbuWPzjKbSxZ2rP7lIBOshIZAuBbIg
         w+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755190096; x=1755794896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLDrrpafB1dc7zKQbNRbgWKK7dMiwCoZciqkMWYR9Ro=;
        b=gjSXBZER5BOdLZrROEOjarzMI2tGDDLAAt2rIr68GCWLFN9dOOElPKierl2E50rrcq
         +hdlodubuUp+nTw97QPPM8LuE2u3xdyFXTLourcqkyrRMRXxVWsTzAy2P5dgwAGT19wh
         Z8FeCAmcXvLRDtxIgzzrZowFBonW8njwdCJa+lH+Fbvq3ZUWxbHqaJ6+bJN8LF1LXrCN
         BGihnLRckbmdk5/oGF9rhNAOx6oTfJblC33GYGLmmfHyFxBrm07kv6UGrviZIHlKZshq
         rC2kfwINMQ8tJtlmF/gJZ0/kabSdh9f5ybLplsIu7fJEmHn520zTWDO9Nyg4edjGmDce
         RU/A==
X-Gm-Message-State: AOJu0YyLY5PYHHEXWltuIw525jzYHjvEeYKYTqgvoeXtfih1aEO0arAj
	D2Y/jZcaEJUtzoo40xUIqPAOjisu/eYXdrtMyxKh16DG+g7p8JDS5mZKZR0hwaDHJz32NpK1nRm
	DIQYUfB07e+RY3kBZsgbvHTkNBeuOvR0Q1SII
X-Gm-Gg: ASbGncuCD/NykJHz1WBkvdOlnVtjxGo2biMqAQvSjsiMVGQ4iEqM6VSpRJlmDlSYT4W
	go3yswE6K0BOiBjoSeDr5wHXW+t9A6VKcPK5v0NUy5VBSWTaSWtVMUtddS4KAGV6x34l9zDTrp3
	2lUpZqSokpvi0wDs6E9MuG0ux83VfLSIrWE77R0AFVwso1HEpn6l9T3VOA4CxMLd0uooNgQ60VP
	JOyLixk7X6nFAQ=
X-Google-Smtp-Source: AGHT+IHI3DPgX2OxCTF4clTCNl2WrljKPiPssEu8NAaJ0prei7h2WzOkEMHwkRGt0Svjj0c7KbPEVpg2ID8LVLfgSGE=
X-Received: by 2002:a05:6102:dc6:b0:4f9:6a91:cc95 with SMTP id
 ada2fe7eead31-50feaab4646mr1568963137.27.1755190096469; Thu, 14 Aug 2025
 09:48:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813052552.3636318-1-inseob@google.com>
In-Reply-To: <20250813052552.3636318-1-inseob@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 14 Aug 2025 12:48:05 -0400
X-Gm-Features: Ac12FXyvN-JhU0640rDyoHP6lkXx1_1HG4OsHdRVKEhHaD1gDov1UI98vLwrSno
Message-ID: <CAP+JOzQu-KPLP9QSeseLj+VB10j-PYO1se8T+zKY4-kP=zQoiA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Fix erroneous genfscon asterisks
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, takayas@google.com, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:26=E2=80=AFAM Inseob Kim <inseob@google.com> wrot=
e:
>
> When genfs_seclabel_wildcard is on, extra asterisks are added to keep
> semantics of genfscon entries. That needs to be removed when converting
> the policy to CIL or conf, but genfscon_to_cil is missing it.
>
> Signed-off-by: Inseob Kim <inseob@google.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/module_to_cil.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index b4439b27..8647d928 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -2987,10 +2987,22 @@ static int genfscon_to_cil(struct policydb *pdb)
>         struct genfs *genfs;
>         struct ocontext *ocon;
>         uint32_t sclass;
> +       char *name;
> +       int wildcard =3D ebitmap_get_bit(&pdb->policycaps, POLICYDB_CAP_G=
ENFS_SECLABEL_WILDCARD);
> +       size_t name_len;
>
>         for (genfs =3D pdb->genfs; genfs !=3D NULL; genfs =3D genfs->next=
) {
>                 for (ocon =3D genfs->head; ocon !=3D NULL; ocon =3D ocon-=
>next) {
>                         sclass =3D ocon->v.sclass;
> +                       name =3D ocon->u.name;
> +                       name_len =3D strlen(name);
> +                       if (wildcard) {
> +                               if (name_len =3D=3D 0 || name[name_len - =
1] !=3D '*') {
> +                                       ERR(NULL, "genfscon path must end=
 with '*' when genfs_seclabel_wildcard");
> +                                       return -1;
> +                               }
> +                               --name_len;
> +                       }
>                         if (sclass) {
>                                 const char *file_type;
>                                 const char *class_name =3D pdb->p_class_v=
al_to_name[sclass-1];
> @@ -3011,9 +3023,10 @@ static int genfscon_to_cil(struct policydb *pdb)
>                                 } else {
>                                         return -1;
>                                 }
> -                               cil_printf("(genfscon %s \"%s\" %s ", gen=
fs->fstype, ocon->u.name, file_type);
> +                               cil_printf("(genfscon %s \"%.*s\" %s ", g=
enfs->fstype, (int)name_len, name,
> +                                          file_type);
>                         } else {
> -                               cil_printf("(genfscon %s \"%s\" ", genfs-=
>fstype, ocon->u.name);
> +                               cil_printf("(genfscon %s \"%.*s\" ", genf=
s->fstype, (int)name_len, name);
>                         }
>                         context_to_cil(pdb, &ocon->context[0]);
>                         cil_printf(")\n");
> --
> 2.51.0.rc0.205.g4a044479a3-goog
>
>
