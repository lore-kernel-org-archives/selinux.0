Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B0A2D1911;
	Wed, 10 Sep 2025 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513518; cv=none; b=WABNhgaUaiM/qKU8jJBXg/Xh9uio0XoMZScsYLjq9TkulWagG+f+ClYx/n6VW+iuOd9qXhFulGRXe2lUBNseI8kFl6Ddp5+bxW1ixtVKNd3JvaGfJ1Kczqh/T9yJ6EkCrXxZBKN9W+NfMXgEwKU56ntA4fUIsy09FQB0essqpzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513518; c=relaxed/simple;
	bh=Tjx19ie3EbA6JXX4PPjcm4OpioyY9LLMZLfe89/rjQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFovjTiLve8wd+NURr06vya2H+IDQtxN0KLY74PK5QlMIAYnkuVYqZglf5a/2JGJmyDtdoydxt5jEXC4bzLm8bQq/WRwMEfvlxOAycNAN0fCyCbdyBhCPGx3Kcz2AtrmSwJBZuqWMyrDebLQvt9etJxpwjkofOkKR4ECcurlreU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxFLj6Tv; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxFLj6Tv"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-329b760080fso6795963a91.1;
        Wed, 10 Sep 2025 07:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757513516; x=1758118316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlRKv4Ffw1WSJlEgW2U45BRnwP3DdRL++Z1Dtw1fySY=;
        b=VxFLj6TvWyvNyrjZiuaAWvaPRn4zKpcq/086Tv3Fyihupgy+ckpalFEzmZ8utIRRpH
         aZhywfYeess5ezkwDcf5HrtfWgsH/u+e1fVE82ZFLEy//N9iqzK4PhCrTH5nuRvlch5w
         pjblRICosmFhKbB2CmixJ4GpmShd09Lf2u2GSAlN3Rg0tf0O3BTqOsMK0sBJCF2H2Q5s
         ZllRAa20RHPPgL8dnobroRC2a/PvBIOaIwWktU/Iu4YwEh43ieXCyFwlAWq8ewVAhKxY
         csGYNRMQsiaetPVTVn8pRjVjBO04aWcuLeyLyw00nfSWwMuBn9dO5WygurCdxx1o0DGe
         kJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513516; x=1758118316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlRKv4Ffw1WSJlEgW2U45BRnwP3DdRL++Z1Dtw1fySY=;
        b=sjJN8dhvVRj+JVZx0Qhd+to0b0ZNDav2tRNX0ehYRE/y0JtOilYIM0pZ7zkb8caNT2
         xOB8aVU+rziWEuy5DsXCaacHVLU1PVlJ16HGxZ9vPc3ZWzzhLA2sUQwDQ0/mbL5h0cqR
         t+22EafN6uoXpU4PWhtlqIWSfJH3AwKJpQEul5xuW9G4sU1HvcQYw2anq8BnKK4gGpXN
         O/1DE/M8FOpblkcX3JenC4i+Tjbhhk/YYFRAWOARAJIPYFc80p5QzRRAvOmvDbIS4aju
         FYWB3iuqCIb+VaRXyFxi4puWoFLHq7ZYb0R65yq7yPWrFm48+OyjrhsKC1cjxTwhqbjS
         SR+g==
X-Forwarded-Encrypted: i=1; AJvYcCVh+5hnyn4b6r35uCkUVOg+4fFqaqe793vvZpTU8zB1+vQDryyXeBJinxsXLv8bDT7L6pDJxKkO1InSxnA=@vger.kernel.org, AJvYcCXlw6ahmhrfk6HtAosXOavX6nH6EkNFVR51B4Or6evLhz1huwims/aC4dnkuMRC06vlkVydjgtbqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnF8+BUlhmyLHAtolScnw6QgJ47og9D381/D0cD4eDUf7mejC3
	aJIO8de3KegJdi94IXQlB3w7E8e+SiW/PLijDVDN/QrZOZt43+JTIEFaXycvFjlfget4kih4OwX
	6fuZA0Hav01UgEp9cVreqG9E5EfQeI6c=
X-Gm-Gg: ASbGncsKoIWCiKs39cqzUj6JXfgEbFITHokZ+BtXtu5ZdVvawjC/1ZLcQ4f3wRdNfwG
	M1IOv8f4XIByfF2r7zHTHDe+uZOLnGGXA95lok1XIO2HkxL++0qk2pP/gaciyUdMHRvcVkUYUAs
	kFRHtXWV1RBERCPWrryWBV7tShHDl1QXxYNy2yM1Q1WEg5y0TdFUczjylntuF3eC/mWgTWs3m0G
	0x89SzogU+hI5Wl0Q==
X-Google-Smtp-Source: AGHT+IHr3ufdkLP58eojNDk71ENCQSGX78v8/v1O3w06BE4KGtrzjSiK02IAwnxG6XMYkG603b7v+dDCvt5fLh3Lzi4=
X-Received: by 2002:a17:90b:4e83:b0:32b:b514:3912 with SMTP id
 98e67ed59e1d1-32d43ee5afamr20100886a91.2.1757513516641; Wed, 10 Sep 2025
 07:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828170503.2323187-1-nkapron@google.com>
In-Reply-To: <20250828170503.2323187-1-nkapron@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 10 Sep 2025 10:11:45 -0400
X-Gm-Features: Ac12FXyiDeyreEY4DrnfvbM_XMuE5GsA0S-i3oG_AeN9fiYaT3v8SZlvHCmmQ8g
Message-ID: <CAEjxPJ7e6GVBzi2O7xv_A0+iJTWePRmMeN+jH0Z2Wo5qh6Om2w@mail.gmail.com>
Subject: Re: [PATCH v3] libsepol: Support functionfs_seclabel policycap
To: Neill Kapron <nkapron@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 1:05=E2=80=AFPM Neill Kapron <nkapron@google.com> w=
rote:
>
> This adds the necessary userspace pieces to support the
> functionfs_seclabel policycap which enables per-file labels in
> functionfs and the ability for userspace to apply the labels.
>
> With the policycap disabled, legacy behaviors are maintained and
> per-file labeling is disallowed.
>
> Signed-off-by: Neill Kapron <nkapron@google.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

>
> Changes since v2:
> - Sending as separate patches
> ---
>  libsepol/include/sepol/policydb/polcaps.h | 1 +
>  libsepol/src/polcaps.c                    | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include=
/sepol/policydb/polcaps.h
> index 0835ea21..bbaebf1a 100644
> --- a/libsepol/include/sepol/policydb/polcaps.h
> +++ b/libsepol/include/sepol/policydb/polcaps.h
> @@ -19,6 +19,7 @@ enum {
>         POLICYDB_CAP_NETLINK_XPERM,
>         POLICYDB_CAP_NETIF_WILDCARD,
>         POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
> +       POLICYDB_CAP_FUNCTIONFS_SECLABEL,
>         __POLICYDB_CAP_MAX
>  };
>  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> index 7ac0ae7c..83eb6143 100644
> --- a/libsepol/src/polcaps.c
> +++ b/libsepol/src/polcaps.c
> @@ -18,6 +18,7 @@ static const char * const polcap_names[POLICYDB_CAP_MAX=
 + 1] =3D {
>         [POLICYDB_CAP_NETLINK_XPERM]                    =3D "netlink_xper=
m",
>         [POLICYDB_CAP_NETIF_WILDCARD]                   =3D "netif_wildca=
rd",
>         [POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]          =3D "genfs_seclab=
el_wildcard",
> +       [POLICYDB_CAP_FUNCTIONFS_SECLABEL]              =3D "functionfs_s=
eclabel",
>  };
>
>  int sepol_polcap_getnum(const char *name)
> --
> 2.51.0.318.gd7df087d1a-goog
>
