Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BD938B122
	for <selinux@vger.kernel.org>; Fri, 22 May 2026 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779454901; cv=pass; b=m+uMCIu3+sr+qJWG5tI7ONQzznV16OxdgCN5NgDfxAhoK0ph17MWm7RTPYECiX6P2LZfN6sKFUf8L0IVYl+glkGiqaUenrQX28GAtWlF2nvipW7mnSZNcOxs9HSz6TElxxWaZYN84uWOlBmAssulVJrNULcvuHvGoUWQvGLqfwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779454901; c=relaxed/simple;
	bh=JygF2unY56dFciZQm6rY4wqF4K6gLinoNeX8JY3h1Ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=fkRFdnfO7aMkoqkOjZN9A3FQnl88KhX3snOtfpJhzX8FC5fSmQ4ZBtefqgpxkFQSSakDUf0gA3ZECtZvwYEjboCKMmAckbz7I37TaxyC5sSAKZY20bBO1FYyesLNKIVNkRBsBHMD9bkbQIGYPsYQqG2ARSnp+aHBe2k/t0PksSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoClccVM; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoClccVM"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38be5e86918so89110901fa.3
        for <selinux@vger.kernel.org>; Fri, 22 May 2026 06:01:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779454898; cv=none;
        d=google.com; s=arc-20240605;
        b=ijIiYywE8BA6dpt2iWhkGJU9eerHv75EDY4cIYuZKXHuLhYwakyOgSmxO/w7HYxt5/
         kTONWsR+2gY8/tHtIY0mfP5H0Lky1Ulf9SsuVDnOT0B+HN7/mQ8xtfAH346qQMJeEWWq
         Q2AbeM3V1NvJdZKxsCuFqcmEJt8IjbMEsGEVKtZOOHz7jWnQ5IsnyNtjRdTscb3dz5ce
         2GzJr3/9NBJfO5peVHUxke8P223KpIxPb3RFLCsNgdngnsO6Iorulf5fJ6bSez3yx00S
         oLbrACY5HQj1bmoCMClmGOXNVegNcc9r6gbF03PRyr9fjInxTTQ3NoC5NF6V8vo//3Xd
         ZW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eEreIywThDmdB1ASeziXDjw5KPGvsS/6sUO0EO3pHxU=;
        fh=l2l+BKIhep14i9a5yxIzwDvgNRHYkyJlbYDDp8LiW6o=;
        b=T9lemaWCk/vK6/dEopkK6cWW8uznb83c2UFO8q+10pPVStoEKH+PZqVgcnKJpri3vs
         nvpp3SfEeP5lgm1ya69xsJXwxxecL7IzpHY7KbAnBfD7lKLzNOgkCxsnpVrGrcPI3azA
         mcUe9+ymWiTwLv6g/sJ5upxCDMTKOb7z5Wyru7XbTP/ytaiOqaMNrw15/vlXlVh2xxKI
         dg9IPVGmnaPFoR9snWvJB61s1ustraHNMRQETU0pesKZBluG+LQtoWkiP2/eSDMGoY+4
         t9EnTXnWuYXhZjSl9mbUZ5xLLTcPCzZ4Y4oIqe+sNcqw2UNlK3eC+ye09R8RUQ0yIRJK
         xVlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779454898; x=1780059698; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEreIywThDmdB1ASeziXDjw5KPGvsS/6sUO0EO3pHxU=;
        b=LoClccVMmj33A495ljmkPNbHosz0FoD0fFovpwPTFFG4wuObiL5eS0qIhQgm2CXCvI
         88AdzNwpWIf1BORHIuatWSTQ0CasghIhx5Br6+OWa9fpuv6dCMus5538giMjRvE5picF
         /q3Ds0BnKZfu6hnrkhilaQ6W9FOElAfGNXk/K8LCd5Lq3LZScYvlgX1MJhEy7r7SArAy
         yPVNOqd23QtNO1jy84StjYibFlG4fcBhZvBrW9EnOoplDRz4ZLW0aQhiFPM1q+TYuCKq
         l3frZcJ6rwr7mq8AzM4tIrLxkGImdjVRluX/qWa2Ja4jLfakrksPiWhFyLujySnpd93I
         NoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779454898; x=1780059698;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eEreIywThDmdB1ASeziXDjw5KPGvsS/6sUO0EO3pHxU=;
        b=H7DkKuevrqE2K7aFh2GzT3RufZyUZHZd38Uip1OsL5Gbx590Y4z5TlK5sXfyVmY1do
         9L4Jf3hR61JB9bgiGqbgxt7IQ3lLLeLPbbhtL3hGLb0tU3Sk9sPALJro5Km126k40/F7
         Mi40KnDLpTyuDiPz1n1HefsZ9hdj4jN1DfRtbwPwA+bKgazkIcXNaX7psQQlzTu3NMfP
         QkeO39mkis8mjbO6WqKT5Vgsrr5V76PlhNkaZ8eJzpY2oSvsDWa0c1CkSkAaNMUCc/5f
         b+sC1gipeu10ZCugnpeHYvtiDLJNriTAKeVKMGry3US6rE7fmCIDmBEVSjY2xzs/xhKs
         M7zA==
X-Gm-Message-State: AOJu0Yz2FGeDY3PVCtFpb+1vvv7aPn/sOlG1UoS0VEEluNSdr5s6SZpv
	6+74w9fuP5E/C2suZ4zEx1x+mMJftbRjlMM+koPbBU+jqy6Gan+rucevwxeFrzNtlGe8EKoTusK
	codZ42L1sxArlJYXKUeNyc58OsqcbFB0fDA==
X-Gm-Gg: Acq92OH6dKut9yDQp7zmB1lGZJHRuM7iG/vs5ufTB3QxQylvGPH0x+1qKCOvwOJM19g
	A1Na+mtrX1tYiSSINPjTJvKX4cEnVhMoM6UVxUy7oqpo/UTFxWoa1sHBUaVBchJUgEDBL6tBgOv
	JFHwxcDS8N/a+uXFC3JagwwoBozANY2ZVwLDDPR3pZ0jY8+MzgY3/qGGvHA/RtMtGa6tP6gkxMS
	UUAIsing/9uKVQ7PnZMC0YjrKLkwBlSrzSbIJHOPKlWP6pDuNwxuudLoDu8N4n90oqMP26YSgiU
	POPo
X-Received: by 2002:a2e:bea0:0:b0:393:4e44:63ba with SMTP id
 38308e7fff4ca-395d8e13013mr12331411fa.29.1779454897467; Fri, 22 May 2026
 06:01:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521183432.22333-1-jwcart2@gmail.com>
In-Reply-To: <20260521183432.22333-1-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 22 May 2026 09:01:25 -0400
X-Gm-Features: AVHnY4K2ZANxWyYmyUFUcQJiV0-KsnqP2VI2qxNnOYQdboEungcaQYwavVLTFyk
Message-ID: <CAP+JOzQzG2aqR=ZUeLj3wQUYXgYvPZtK6TB4GSDS8dUzzd4LjA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Fix index off-by-one errors for categories
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 2:34=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The category bitmap for a MLS level or range start at 0 as does the
> p_cat_val_to_name array, so just the bit position should be used
> without subtracting one from it.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Ignore this patch. I was confused. This code is collapsing category
sets and actually wants to refer to the previous category, so it is
correct.

Jim

> ---
>  libsepol/src/mls.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c
> index a37405d1..7f53c61a 100644
> --- a/libsepol/src/mls.c
> +++ b/libsepol/src/mls.c
> @@ -138,14 +138,14 @@ int mls_compute_context_len(const policydb_t * poli=
cydb,
>                                 if (range > 1)
>                                         len +=3D
>                                             strlen(policydb->
> -                                                  p_cat_val_to_name[i - =
1]) +
> +                                                  p_cat_val_to_name[i]) =
+
>                                             1;
>                                 range =3D 0;
>                         }
>                 }
>                 /* Handle case where last category is the end of range */
>                 if (range > 1)
> -                       len +=3D strlen(policydb->p_cat_val_to_name[i - 1=
]) + 1;
> +                       len +=3D strlen(policydb->p_cat_val_to_name[i]) +=
 1;
>
>                 if (l =3D=3D 0) {
>                         if (mls_level_eq(&context->range.level[0],
> @@ -216,11 +216,9 @@ void mls_sid_to_context(const policydb_t * policydb,
>                                                 *scontextp++ =3D ',';
>
>                                         strcpy(scontextp,
> -                                              policydb->p_cat_val_to_nam=
e[i -
> -                                                                        =
  1]);
> +                                              policydb->p_cat_val_to_nam=
e[i]);
>                                         scontextp +=3D
> -                                           strlen(policydb->
> -                                                  p_cat_val_to_name[i - =
1]);
> +                                           strlen(policydb->p_cat_val_to=
_name[i]);
>                                 }
>                                 range =3D 0;
>                         }
> @@ -232,8 +230,8 @@ void mls_sid_to_context(const policydb_t * policydb,
>                         else
>                                 *scontextp++ =3D ',';
>
> -                       strcpy(scontextp, policydb->p_cat_val_to_name[i -=
 1]);
> -                       scontextp +=3D strlen(policydb->p_cat_val_to_name=
[i - 1]);
> +                       strcpy(scontextp, policydb->p_cat_val_to_name[i])=
;
> +                       scontextp +=3D strlen(policydb->p_cat_val_to_name=
[i]);
>                 }
>
>                 if (l =3D=3D 0) {
> --
> 2.54.0
>
