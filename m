Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2229928DB63;
	Wed, 14 May 2025 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747250579; cv=none; b=r8BllNAdvtT+LeZmdR7Dt81MiXzKdImStQbGQvpsv8/CgAnqNvEHVCBg4VIOIrbjTdcwjUOIfhIhnZ1tZCWlMjSVmS2G/JgtpUoygFw70Q8Sv7TL/eS8byExH6/xxfpPNArwYqJ4sxZA2r5Da+sFWw4slPIeDIdwgJPcK3K74MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747250579; c=relaxed/simple;
	bh=PcmeF9xu+bWkoskr64C6qtZXQFuEoIowdE7JlvXFr9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNoxBCrXsfUMMp5oDEenfSW03NM0LWf4VetUmBXp8VrolEbrQMInYVdozA5waotG6LcypyuKvPJvbZ9LKR84oWWCT0+674NF2wLVlhv0Mw0jVDRJmCCK7QAMPoCWocdGB6rLehZHOdtHNSd1Iooi06gwtQLkoTyoHPaVtP4Op88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijTnYAZg; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijTnYAZg"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-30c54b40112so176319a91.2;
        Wed, 14 May 2025 12:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747250577; x=1747855377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYiDoFOtETXEnA0bo6eKLCt3zN+Tbs/yfpv1kVl0R4I=;
        b=ijTnYAZg14VuN5tEhRNhPe6CoUIPfdEJ5qPCncpYWfPwuA5cGpRDdSyyafV7ixO1r8
         4kNy2xQDxoklzSxdCK7NQ8SgWLyXFy24F2y5Qox2BbWYVaN1GwfvIC5mU6JRNcU9hEGW
         Uv+My21HA2B72GEb6Ui8bOz5RPkaaGAnupBajhPAoqVU/c+ipBugnttEay/QQC0XbaRv
         yTZeHxZUZzFAgoeAOkXasDQrlZ8/ull/V7X4Q0d5RocRNhhVIxwMKnBWVXY2wk4wW+ls
         v0w6KTzkbcmbJtH0bkoB8hxM7VaHuMjGvs7CHJlvOtM/iLoERotlHz25w9F5sCNceZDQ
         M7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747250577; x=1747855377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYiDoFOtETXEnA0bo6eKLCt3zN+Tbs/yfpv1kVl0R4I=;
        b=rhBTIMco81F/Wpab5mK8VX1nsb39DDY+diu13uQShYllSZO7q3YSe6MZHoHifaQIB+
         hVOR9m+FWWzXOsiXio0LeG+V7KfHGBbUqyFnVCeY+gMEAbfE9NUylbN4cRLi0nxAv6r4
         HpMCkKzOJJAYdluZihQZ1KDJu6y84HY4MeHT+0i7ZAFtnw7GooM8tfJhIDHZGB9bWVip
         9yUs5TFLguMikowK5UZgv8Tl2HqaAnAFfyp0B5GWycOwPiG9TaKp9iwtubqckYNWRiTF
         Q0svWEUYQWP501hfwcEfEb4c+3lcHJAh4dlsrXgC8YxjZfywbE0N7rPcNivK2sN/iZ5f
         /FVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR0hbiaXj1J+THdI0auT0QHWUCNzzEXyUrRk9j3upNr3ylbmUWoLtwZb8gNbVWcmBlvYCgixhgTCw3vBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi3LQDawSfeLMeGK/3WS70muGQaEgpg2P528M5eWC7ptvR8Jsn
	zIcGwG/a2hVXFi/jLYRZ7ls9wYz26mgWBvJsvayjmNpD3kP0IgIOIWIZ50onXbGaYYYnjeM2916
	EmeVYCa9hV2R4bn2muxGMrCFZh7I=
X-Gm-Gg: ASbGnctNUk1U/ew8qvNqJvarycuvuHpYdrpVapf8omMYQVyPUDSjmE7y+FLI1dZSZf3
	oCXIcpm3s/MCF/P9fSAKcSbICk+tin1oHvgDuFLq4CF1OO1Eh2fbaywstnAv6rgicy2T/tbW6w3
	OaspxCM/8EhTAhUva8YsEx+o9v3eEmotaB
X-Google-Smtp-Source: AGHT+IGLWhk44wAjXOoydmV/UuHMn61ujHBBk82uZcRvOz+emzBf4J1v63Mrj/7s9V508U8Lmm7t+QSVTqb29PdkW3A=
X-Received: by 2002:a17:90b:4acb:b0:2ee:b4bf:2d06 with SMTP id
 98e67ed59e1d1-30e2e6133d8mr6497146a91.19.1747250577298; Wed, 14 May 2025
 12:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511173055.406906-1-cgoettsche@seltendoof.de> <20250511173055.406906-12-cgoettsche@seltendoof.de>
In-Reply-To: <20250511173055.406906-12-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 14 May 2025 15:22:45 -0400
X-Gm-Features: AX0GCFvtInJTuwDuGvrkRniWrryViIS0baYZz7wNmqOCKdW0RMJsypRpRNRxTHY
Message-ID: <CAEjxPJ6xPrGMcA4HOR6S0Mz61XB0HoV0BuJznJpuUrRKNuTTnQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] selinux: check for simple types
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org, 
	Eric Suen <ericsu@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 1:31=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Validate that the target of AVTAB_TYPE rules and file transitions are
> simple types and not attributes.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/ss/avtab.c    |  9 ++++++++-
>  security/selinux/ss/policydb.c | 23 +++++++++++++++++++++--
>  security/selinux/ss/policydb.h |  1 +
>  3 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index 50df8b69de2b..5b45f37fdcbb 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -426,6 +426,13 @@ int avtab_read_item(struct avtab *a, struct policy_f=
ile *fp, struct policydb *po
>                                 }
>                                 key.specified =3D spec_order[i] | enabled=
;
>                                 datum.u.data =3D le32_to_cpu(buf32[items+=
+]);
> +
> +                               if ((key.specified & AVTAB_TYPE) &&
> +                                   !policydb_simpletype_isvalid(pol, dat=
um.u.data)) {
> +                                       pr_err("SELinux: avtab: invalid t=
ype\n");
> +                                       return -EINVAL;
> +                               }
> +
>                                 rc =3D insertf(a, &key, &datum, p);
>                                 if (rc)
>                                         return rc;
> @@ -517,7 +524,7 @@ int avtab_read_item(struct avtab *a, struct policy_fi=
le *fp, struct policydb *po
>                 datum.u.data =3D le32_to_cpu(*buf32);
>         }
>         if ((key.specified & AVTAB_TYPE) &&
> -           !policydb_type_isvalid(pol, datum.u.data)) {
> +           !policydb_simpletype_isvalid(pol, datum.u.data)) {
>                 pr_err("SELinux: avtab: invalid type\n");
>                 return -EINVAL;
>         }
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index 7774f6da2ebe..2b098d9abf17 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -686,7 +686,7 @@ static int role_validate(void *key, void *datum, void=
 *datap)
>         }
>
>         ebitmap_for_each_positive_bit(&role->types, node, i) {
> -               if (!policydb_type_isvalid(p, i + 1))
> +               if (!policydb_simpletype_isvalid(p, i + 1))
>                         goto bad;
>         }
>
> @@ -1047,6 +1047,23 @@ bool policydb_type_isvalid(const struct policydb *=
p, u32 type)
>         return true;
>  }
>
> +bool policydb_simpletype_isvalid(const struct policydb *p, u32 type)
> +{
> +       const struct type_datum *datum;
> +
> +       if (!type || type > p->p_types.nprim)
> +               return false;
> +
> +       datum =3D p->type_val_to_struct[type - 1];
> +       if (!datum)
> +               return false;
> +
> +       if (datum->attribute)
> +               return false;
> +
> +       return true;
> +}
> +
>  bool policydb_boolean_isvalid(const struct policydb *p, u32 boolean)
>  {
>         if (!boolean || boolean > p->p_bools.nprim)
> @@ -2235,6 +2252,8 @@ static int filename_trans_read_helper_compat(struct=
 policydb *p, struct policy_f
>         key.name =3D name;
>
>         otype =3D le32_to_cpu(buf[3]);
> +       if (!policydb_simpletype_isvalid(p, otype))
> +               goto out;
>
>         last =3D NULL;
>         datum =3D policydb_filenametr_search(p, &key);
> @@ -2357,7 +2376,7 @@ static int filename_trans_read_helper(struct policy=
db *p, struct policy_file *fp
>                 datum->otype =3D le32_to_cpu(buf[0]);
>
>                 rc =3D -EINVAL;
> -               if (!policydb_type_isvalid(p, datum->otype))
> +               if (!policydb_simpletype_isvalid(p, datum->otype))
>                         goto out;
>
>                 dst =3D &datum->next;
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policyd=
b.h
> index 04acf414fffa..b4f0c1a754cf 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -323,6 +323,7 @@ extern int policydb_load_isids(struct policydb *p, st=
ruct sidtab *s);
>  extern bool policydb_context_isvalid(const struct policydb *p, const str=
uct context *c);
>  extern bool policydb_class_isvalid(const struct policydb *p, u16 class);
>  extern bool policydb_type_isvalid(const struct policydb *p, u32 type);
> +extern bool policydb_simpletype_isvalid(const struct policydb *p, u32 ty=
pe);
>  extern bool policydb_role_isvalid(const struct policydb *p, u32 role);
>  extern bool policydb_user_isvalid(const struct policydb *p, u32 user);
>  extern bool policydb_boolean_isvalid(const struct policydb *p, u32 boole=
an);
> --
> 2.49.0
>
