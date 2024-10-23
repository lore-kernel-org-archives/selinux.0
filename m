Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4D814658F
	for <selinux@vger.kernel.org>; Wed, 23 Oct 2024 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729710654; cv=none; b=UTxJUoL7LiwOaVuTSsHm96IcCZn0lanqLGlr5LHuWyfP6/llCAMM65FB/aEhyGguQ5T3hI0gFNTpATh30S7L+jF0ZdlDpQmD9cEEUpYo66wWVEMt5K+ZA8tbTJynZ94MZ12xzq8OaGhLSKnfx8ZhAWd+UqDXM3agKdU1qc+hgP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729710654; c=relaxed/simple;
	bh=xPA0ho92wOGpEN4q9o73alCxa3eTcsr8DgPS4BF9tmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMwfnseIOV7ECdaEFRvc+nV/Z4+Y3NSdknAmUh3zfOLGN9JvV4vlOObsd7w63PA65NPlprO5TjQtWdi/3QCmF+WiD/Nr2VCRM1rtGJ7IofmaVUrXHZmkdoQ1ovpf4ePyxAgBMADAUAJn11kDFh7egSnysXWLJvByySup8ti7W6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvzW8ybO; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvzW8ybO"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7180dc76075so87622a34.3
        for <selinux@vger.kernel.org>; Wed, 23 Oct 2024 12:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729710652; x=1730315452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSnQummQnZigmXwd3OxYNp3RNjDpPhzMIWsbFu31cuI=;
        b=XvzW8ybO+bOUnYDnSKlUJ0byYMLR8LU/bRfLyYAwakXiA9bYMARglIf9jUjEgOJ4QA
         682ZJs2/JmcfzRufACYiWPJwadOIX8696MVGRZCDtk6blWoJ11bH67sd90lfRDo2w6By
         XC/aWn4UPXx77K2bNHj2Pm7IhB1e4qg1b9QlgPC584WPqQTpFnAHzTxItCMHvDdMwDa9
         F2fVf7i+fR43Ms4Hw8eg5H9XDzXgOVt7Jyd7HXVQpMEC0zToUZVi8yiTweYpCuRfC9na
         qTF9z+vVfi4aaFii3VDlxtQJB5YRkagwOc39nIl1KBcMl7PDynlcrhbSnFpX+1pHjwnk
         Ca0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729710652; x=1730315452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSnQummQnZigmXwd3OxYNp3RNjDpPhzMIWsbFu31cuI=;
        b=dLMJm/nsRjHbEFyw9+m5pHz/sMk0Y/Whdfc7xQXjZRjh2fV/u1OcoT9eLrX4dmwIN7
         eHwW0Aay/QsgDwSYkH+k02pJNCH9zJh8ryUEuG9ixgQw4nc+9wQKP80pfVXlyzsAvtD6
         ylh246sl0I/G/L3JQsuLogQSTUOW4Yhaq+km39TZcL27cQFyhfsmt+MAtXwbcUztLWiP
         x7N1IHA1d9NYuuIMCrnzffQtXDbtqM7EnanJKL8JVjqSx1kYkkm4S3+SSN4eDzSMxh8C
         XKMYXGehuUNVrJE5T/RNraBfnHpijfZFvAexBv/B0h9YtuE/JBiczqeSkmprcmm4vSau
         5hKw==
X-Gm-Message-State: AOJu0YzqStEawUekNhSy9H+TX3bpq5Wsm+ARz7NTm+T6Z/uGRsusI7YN
	sRKWvM6xTLAPNpwrxg7ou6tAq7SpwU2L9PNs6UYtaT1fQ6EI7dKCWQiS5uzZjhli6S6kvYu2Pep
	6rld0wi2wcUj4W4pQyIc3M5oCOCs=
X-Google-Smtp-Source: AGHT+IHV3WoiFNz7cW/rhbPEi2jTqKj7WiDZSb4MHcy/3G3J4xp8sfxQGmhkAUUPwQ/4DK1rZXdEsNMMnkrWKjlkyiM=
X-Received: by 2002:a05:6808:3084:b0:3e6:140:c15b with SMTP id
 5614622812f47-3e6244fea5bmr3976737b6e.12.1729710651990; Wed, 23 Oct 2024
 12:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP+JOzRURZwsyvGzs3U7M7mw4NWD3Brh-K4wnztCS81MLYRHYg@mail.gmail.com>
 <20241023134318.733305-1-vmojzis@redhat.com>
In-Reply-To: <20241023134318.733305-1-vmojzis@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 23 Oct 2024 15:10:40 -0400
Message-ID: <CAP+JOzS2tm_7pXW46rWsOaMG1Nv=kKqFBQYsDbLfhFr4=F9QXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] libsepol/cil: Initialize avtab_datum on declaration
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 9:46=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wro=
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

For these four patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_binary.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index 3dec1883..3d920182 100644
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
>         avtab_ptr_t existing;
>
>         avtab_key.source_type =3D src;
> @@ -997,8 +997,6 @@ static int __cil_insert_type_rule(policydb_t *pdb, ui=
nt32_t kind, uint32_t src,
>                 goto exit;
>         }
>
> -       avtab_datum.data =3D res;
> -
>         existing =3D avtab_search_node(&pdb->te_avtab, &avtab_key);
>         if (existing) {
>                 /* Don't add duplicate type rule and warn if they conflic=
t.
> @@ -1346,7 +1344,7 @@ static int __cil_insert_avrule(policydb_t *pdb, uin=
t32_t kind, uint32_t src, uin
>  {
>         int rc =3D SEPOL_OK;
>         avtab_key_t avtab_key;
> -       avtab_datum_t avtab_datum;
> +       avtab_datum_t avtab_datum =3D { .data =3D data, .xperms =3D NULL =
};
>         avtab_datum_t *avtab_dup =3D NULL;
>
>         avtab_key.source_type =3D src;
> @@ -1372,7 +1370,6 @@ static int __cil_insert_avrule(policydb_t *pdb, uin=
t32_t kind, uint32_t src, uin
>         if (!cond_node) {
>                 avtab_dup =3D avtab_search(&pdb->te_avtab, &avtab_key);
>                 if (!avtab_dup) {
> -                       avtab_datum.data =3D data;
>                         rc =3D avtab_insert(&pdb->te_avtab, &avtab_key, &=
avtab_datum);
>                 } else {
>                         if (kind =3D=3D CIL_AVRULE_DONTAUDIT)
> @@ -1381,7 +1378,6 @@ static int __cil_insert_avrule(policydb_t *pdb, uin=
t32_t kind, uint32_t src, uin
>                                 avtab_dup->data |=3D data;
>                 }
>         } else {
> -               avtab_datum.data =3D data;
>                 rc =3D __cil_cond_insert_rule(&pdb->te_cond_avtab, &avtab=
_key, &avtab_datum, cond_node, cond_flavor);
>         }
>
> --
> 2.47.0
>
>
