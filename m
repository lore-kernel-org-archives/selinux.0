Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0143E2BFC91;
	Tue, 13 May 2025 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165245; cv=none; b=Jub5G8sTc1FF3wlzTqaouKeND04r0MYLMaG5lwzX7q20sUHFBJVXLTkBM1xAuHY+sYBTG0FmJ2G6A+/TWKA7D7ofi5RvQRvwOubU6brVGevFcxzSuEn/qmiQnERr/P2CeQ8wrplsmbvFbcwo1H8RQA2/1KpfDImix6ZOdnrGq4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165245; c=relaxed/simple;
	bh=55S9qf5AUSRTJmR0vy4mwBh3qP5m/nSl27LYZMKt5WY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfJhj0l0uysQzde4F3THXo9zD8I+TNfqy/0YL0tIrwYUpm00tewfiALErc24jgo0glk3g/cw0PBWjcVBQuCv8hiDvx5d9/i5KgXVT5ymdOCJJX/+HEQENKF8gurVgWU0H8sNqS5Y4fco3Jac0U0Ex9Wh0+vB529rA4RjMv8Sl8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1jDfy4z; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1jDfy4z"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7426c44e014so2734997b3a.3;
        Tue, 13 May 2025 12:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747165243; x=1747770043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gj1glHl/D2ZV3bZq3WkUKPH94DAWXYMq8MtTtJ8xwoo=;
        b=e1jDfy4zV+smFoF+hZgXZbuO7FDCeYtocstKaXMALJzkBS1t1A7qx+aKXforsPSZrD
         r6MHi6pLu0g//C/35THHPuCXAu0C2b+lLq0u0IHNJWhcYNH1JQ+s7qllmMlBfmxgJ75x
         5VhzlfM1UhUxBozNlNohqt42jITd4JteZG7QhMeZM/Trh4AUVMBgoMK9Rpga6e0iFddE
         hK6VFjwJUn82CHXJwaU+Kykd1OCukU9X2ghNdiE9t4A1EyoSPDppfW7yj59vv5uF5Zos
         H+4zEX74pSPI1zK1cIGVBZiRC9I0rodaRmltTE2wwCZaDOF7X5NuqCtjdnJAzOn6IsDT
         iO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747165243; x=1747770043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gj1glHl/D2ZV3bZq3WkUKPH94DAWXYMq8MtTtJ8xwoo=;
        b=CET4gSRU3zs5HxArHAPlmRWmTqf3y9qRSOLPc8t+kJb5EgTxBGLMZBuxqmr/gTRfvX
         aGEMyMuEkG2ISz/kYdUS55WamNlC4JW75+pSbAryM7mNbXjZtpeGQB6gvUTjIJdRnM6h
         3Jcm/wPYzmZLSXyICVyyeLUuPoGQk+G7kKsrGsrR4NI/IvTXpx3peg4JOTEc6ELupssE
         kwMyrb/CR6LFQMghmk9jMyfv5tYVPPYhmVClQwp52UYJczZN23qFt+5WdEJhxi2k0MvV
         ORIwDcH7ODb/ash3MSaee0enKAnlAeDwQohaPzxtnVOmMXBFuDkXsuQJUbe31frmhiDD
         jzsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCqaTn6a3vFpGIlYQRmmtvfN4MS8/D3Rxk9udyeCYmBU3FW4CkZqrP593zPkN/JgfTol7X6mVTOZ7ZsAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQ8nlyDz4WyOqTxFApaHRsS5vfYvl/7CTjzrs2W4dAgxNFi5y
	NI0Ha7sf0x1LCTSPWCJpwHQ6r9UmyhzlQ0i/0vN6tXrF9piZBH1EpUN5QoKsTRZAHjOHMRZE8BJ
	InIpUIzO8YoHz5hUv7yW93EosbGU=
X-Gm-Gg: ASbGncsZ8DAAywBYEIqV+/2Piu99rnNF7W5RleoJlXUqstwkdGgvk2t9qzH4ZgvqBgy
	Plkeli0vX++FkvIK9AY0dh/BXeQoapvigXy49QagLrgODxFdfNjw4HrkQ+mhm4a3hRxCwBAFSP+
	fPkWwk8Oc/P7zuS5alPNfbY5GVoxVi7Ekz
X-Google-Smtp-Source: AGHT+IEj8jBuXyBds9EA5ovcuMOsLW/kS72KQXDSf9RMurN+ld/XOiDWqn23jkVA56+BG3+Pi9fuBQmduZE2+7ox8VI=
X-Received: by 2002:a05:6a21:6e93:b0:1f5:8678:1820 with SMTP id
 adf61e73a8af0-215ff0f9a08mr675249637.12.1747165242949; Tue, 13 May 2025
 12:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511173055.406906-1-cgoettsche@seltendoof.de>
In-Reply-To: <20250511173055.406906-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 13 May 2025 15:40:31 -0400
X-Gm-Features: AX0GCFt3I7CoDyQzvuCNWq8GVId-soBZ-na6LXBSrEfbskX9z1ckVKbb744wo2w
Message-ID: <CAEjxPJ7R-ZR6u6kn3ao_7AT6-QckUzoR+xiop0PumUu9p+xVJQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] selinux: avoid nontransitive comparison
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 1:31=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Avoid using nontransitive comparison to prevent unexpected sorting
> results due to (well-defined) overflows.
> See https://www.qualys.com/2024/01/30/qsort.txt for a related issue in
> glibc's qsort(3).
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

I don't especially care either way about this patch, but it seems harmless.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v3: rename macro to cmp_int()
> ---
>  security/selinux/ss/policydb.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index 9ea971943713..dc701a7f8652 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -37,6 +37,8 @@
>  #include "mls.h"
>  #include "services.h"
>
> +#define cmp_int(a, b) (((a) > (b)) - ((a) < (b)))
> +
>  #ifdef CONFIG_SECURITY_SELINUX_DEBUG
>  /* clang-format off */
>  static const char *const symtab_name[SYM_NUM] =3D {
> @@ -424,11 +426,11 @@ static int filenametr_cmp(const void *k1, const voi=
d *k2)
>         const struct filename_trans_key *ft2 =3D k2;
>         int v;
>
> -       v =3D ft1->ttype - ft2->ttype;
> +       v =3D cmp_int(ft1->ttype, ft2->ttype);
>         if (v)
>                 return v;
>
> -       v =3D ft1->tclass - ft2->tclass;
> +       v =3D cmp_int(ft1->tclass, ft2->tclass);
>         if (v)
>                 return v;
>
> @@ -459,15 +461,15 @@ static int rangetr_cmp(const void *k1, const void *=
k2)
>         const struct range_trans *key1 =3D k1, *key2 =3D k2;
>         int v;
>
> -       v =3D key1->source_type - key2->source_type;
> +       v =3D cmp_int(key1->source_type, key2->source_type);
>         if (v)
>                 return v;
>
> -       v =3D key1->target_type - key2->target_type;
> +       v =3D cmp_int(key1->target_type, key2->target_type);
>         if (v)
>                 return v;
>
> -       v =3D key1->target_class - key2->target_class;
> +       v =3D cmp_int(key1->target_class, key2->target_class);
>
>         return v;
>  }
> @@ -496,15 +498,15 @@ static int role_trans_cmp(const void *k1, const voi=
d *k2)
>         const struct role_trans_key *key1 =3D k1, *key2 =3D k2;
>         int v;
>
> -       v =3D key1->role - key2->role;
> +       v =3D cmp_int(key1->role, key2->role);
>         if (v)
>                 return v;
>
> -       v =3D key1->type - key2->type;
> +       v =3D cmp_int(key1->type, key2->type);
>         if (v)
>                 return v;
>
> -       return key1->tclass - key2->tclass;
> +       return cmp_int(key1->tclass, key2->tclass);
>  }
>
>  static const struct hashtab_key_params roletr_key_params =3D {
> --
> 2.49.0
>
