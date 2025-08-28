Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ADC3128B8;
	Thu, 28 Aug 2025 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386826; cv=none; b=d2NSbCZ6y6KBCkrvfgqee1mtHdmHozA05mSXijO3bvFwbrNnsYt4WXb+IOCdJX9ddVA4WPdnqZ133t2IQ9QkfT7mCCpsxYlYspDIj1SDqWOOW7hwJzdTUfg+xh6sulFtw+H76QWwEpZ6PB8zlP58ocUkvoyCXHww9grb+/3UnTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386826; c=relaxed/simple;
	bh=8FiCQow+KtDuwdoxKCgUJG6rVThMBW0mKUAMBFuQtpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWz8uHnPK7TN/Ppey/mBCfattrt3EhVGkdH2TQXrGgiprdukPx3Opj196ptPWT9LcI4z8O6CekZ5u1tf2mjRxYvtE7AV+jPtajT05ZlYUV36moNcwGWy6+7jRCQkyy4CzS3XJFjwsT0tTRejVD97/7eSTEIvy5+Kyp1+JpTEXak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7i59jBI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7i59jBI"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2465cb0e81bso7181485ad.1;
        Thu, 28 Aug 2025 06:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756386824; x=1756991624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzhVITsiXVsOs4t23mWMg13L0epRzZnvV3ujad4r+EQ=;
        b=H7i59jBIezy0cgFabtG0rUDsOsXSxFyh5L/e6riDJKOimFu0rA18a4ADm0SXDDf6qq
         SsW1nShVM1nZsbi/OeuMlcDNTgPXCM1bMCZxCl0Wnivzn+ie6Dns7fD837wfoYUqghX4
         fRePRXp12S6vZY3BA2lXtDEU5jOQkrcfjr9QRPKGU5Rm01c1/SZOBmg0cLMaFtdYKHRz
         T9TpcfwaEMLeMAW9LHIfyzY3mJrsdTxWb8sRLtmI3JsW+cRjV9ufn6Wvx7gAew/dfzm4
         KWxdDONCKa0edixyBg+vwpTyKbCuNu4XyMbn5j8D+ZYOVXEv591I8RegEBk4zNvHBxgW
         9RKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386824; x=1756991624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzhVITsiXVsOs4t23mWMg13L0epRzZnvV3ujad4r+EQ=;
        b=jojeLKlW387hkeWP/yi8yvwkYSVAV9kxU8GOnWfzdUlBRckl5WB0tFNYYn4J5vTuyP
         OdmIzxsVUdRE1dxvm3s030KJDLBejKl9Xuzt95ARE0s1KkQsFplHAdJJtqlosHfsJrGE
         uKLdLpTGaYm3n0tYHPIIh7wZLzhHeXrk27T+cxwhnLPj9I2TAwSJSayVYxjE+bB/yHTA
         ZvH5Y8Wmj3GACqz5vVvc0/NFc0XK9NpdUoTxJna6qY8qQMIACIul4K0adIPcbmms6Hmf
         fqFQyddNAGcOyYHahioIYP82jH3xxGiJLRWAmQTLAk5m5J7GmSwiSlXTVjm1EAHTh1+0
         dktw==
X-Forwarded-Encrypted: i=1; AJvYcCUfJZ31g9KFOktW+1dp37AN4DLrcCeLUJ04O9ffGSO/uD3Zvb9oYVpVWEy3Q39n2dX9lNtRntxVag==@vger.kernel.org, AJvYcCVX3KwwWUL7RWsR01yywTyWoOHqYYaVORC3czSgRr+4J1g+Gaa2FjqYgDO2ORn0qntchyDezYK+gDwpF8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNhCoXzzYOW+ioN00p34xE8tgIiKetOPwQ7cFkVcWIkTOu2fv3
	gm7Cx1StCdiLQgngN/9t/PWc1s2Ib4+kpc893fitmzgSmJgZw+IB6w9Ebph8jni+WTs3SIaQuMY
	qBKOaYAl9m7Au3damGcZLtmCrvgHuD5xzrA==
X-Gm-Gg: ASbGncuUxgrxeBtcKes32Jt27QiUMNTswGG4ylMwQtj84NbgscDWSfOLy/4UfLzIgd1
	Xl55j/YTZuHcuyLfO0N8mWHKH/77CFdVwnO0Fu6mRU9tkmcwwxSE4iOGE0t0Cver01W0khHY2Hu
	Q6oGEs+gDDmLpW+5PeO1sIrN7U0xZpZsd8Q1WT4sLBejleHvpEU+Nk7XyBOjnSPuw7yZOS5z8HI
	XETjqM=
X-Google-Smtp-Source: AGHT+IHyr2yObCnQfuikSYqPviaCUWwXbuVbLXww794O1BfEQXymXKpveynz0mu5GM5DERf9TyYtRq6CbVxQESre+f4=
X-Received: by 2002:a17:903:2288:b0:248:9b4f:f688 with SMTP id
 d9443c01a7336-2489b4ff92emr86377485ad.4.1756386823616; Thu, 28 Aug 2025
 06:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827222224.1648500-1-nkapron@google.com> <20250827222224.1648500-2-nkapron@google.com>
In-Reply-To: <20250827222224.1648500-2-nkapron@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 28 Aug 2025 09:13:32 -0400
X-Gm-Features: Ac12FXzlbI48IKukt1S-bw7-vgy2CippIMR8uz3VV9jAvK8UfyXWmZSkC9GZuUE
Message-ID: <CAEjxPJ7Uy5szo0SJ94vjrtY9bQau8JvouLuP0x6rPogNQbTGPg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libsepol: Support functionfs_seclabel policycap
To: Neill Kapron <nkapron@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 6:22=E2=80=AFPM Neill Kapron <nkapron@google.com> w=
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

Just a note for other SELinux userspace maintainers: we need to
de-conflict the currently pending 3 kernel patches each trying to
claim the next available policy capability bit so don't merge any of
the libsepol patches until that gets resolved please.


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
