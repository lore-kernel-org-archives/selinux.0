Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB5314B7B;
	Fri, 29 Aug 2025 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470368; cv=none; b=KthGWdqj5+kp1+Aoo8VmWldxhzopW9r52gghcL2P/DvOUBJREwqrJ4cHPLHO3ZDakW2CFO7afRKVOCme3XFT5fC2gGKTuUXqWbQDo5K4vmQhx3TbvNSKvbWlI4yXzzGn3R+umLDBPYOT4471dUtHH+4G33cnUyOjiXGtQSDH/tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470368; c=relaxed/simple;
	bh=iFI0/yI+74yAbMsl6eOM0bAZHRVDdpiKUdiXmY6Wy+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgs+0GWjZviIKAfwFDuYWyB7V33Zmzt4oOrRXb+Xae7pgXHCvFDlqL3cJGeU2urtlBdXvfD9fEQ/m/OZNuNFazGRQ+hK24KbujUnXcPQWEDEJZgFU3YgPdSTFpNr2b+7uHMHGteQIC68qlpZJER9CtSqg6d8uR2zSmr4U61aNCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAVOW1sB; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAVOW1sB"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-328015abe0bso173142a91.0;
        Fri, 29 Aug 2025 05:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756470366; x=1757075166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lH1VzVsUexxcYyR6V/xEZQCfjvjSZYifMhkfJzyrGGM=;
        b=FAVOW1sBWxH1aB7OHpj8H9cM2Ui4CzSV4uhR8LnDIByBkeopeT79pPHuwwUIEqPzGg
         akObfCdMvcp68n+P8fTGCuPW3XL88j/C6D7l/4sX/2/Ccdwbw5h1LZ0UQKCOhoSVvgIa
         HvTcNcyXoCHqy2UaER5ppXp1e/w/O8CROiPNSNoU0OizY/9PMZmWLz6JsZ7Z946zOTAr
         YAo5cPUyrjTkMlU2fxMf0FtxO8v/chl2DbpBqd1J8goyDk/0eq/rIVAP/xDHffXXTssa
         2aWnCgsuVdfyRPtSe8S+pLY5/cXV7RMj9jmrsG0T+TxFu4fzd22Q4x0tCcf/WrFDkMT9
         QB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756470366; x=1757075166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lH1VzVsUexxcYyR6V/xEZQCfjvjSZYifMhkfJzyrGGM=;
        b=fXvtOpd9aRz+7oI1+BG/+HZeyk/R+dHl/bj2V0yBL4geaP/E1Hn+D8XSQcKpbU6hMk
         1M0siXkO36HrsMv6Qu07PolOJFCqYnykpC3afQyDBDApRe3TIq6IOce/IQa2dQrihrVR
         Hc1bbOThKW/HbEiSYQAjGSjDa+vhtyhPJtqnYW0QKHPxrw+bxU1Ylvyi/qF8NB58oO2f
         SOcVq5mlv1RGpZT1U+PI7w8ubc+V6kpy0b3tflhIYPpCF3CePYGGPZiHAqFlqNo9gJhr
         7HJ8vR44VYLZpshgtjuA/u0GuQ6OBVDmaDr3PjBoTXdFiT1giLmv9hTCugXkd/fJwJYX
         OioA==
X-Forwarded-Encrypted: i=1; AJvYcCVdJQFBIiwduyjxC77CSpEelmqwiVi3jOkbEAkBRVY8x9/MO9IMYMJf5QfNvY+Weq/oIVm2cEPmkg==@vger.kernel.org, AJvYcCXeci6fBZ68ywRDiQ+m3oW2SSHr6kOpArktmkyrvpWWkt4FCQqET1WbpQVvfu0OBhAJVkhKaA1WFCqVdqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu+4u9pcaMzIzsQLfryk/WxegQ+t+kNa2IP4QC1xIgp2TFAlGe
	JB4td9/iM29YyNtcMd+nLWtgMa+/iI21O5FMLdfvgZofiLJvUva8R58zC/zfg2kSBoTkNJZUhur
	8HCO1q0w93pqYVT7HlhzvvKte0fLUjXo=
X-Gm-Gg: ASbGnctaRbDeUNR9GjR0o065YUVRYbG4wKfY+gdqhOdTcqmRJkuY1J94iKCBQ3j6mvy
	Jm0wSecKI5yZlTO7MmGdzV6eyDVgxBTPC1lwIneQHkx+ACyrQe25zZKw3LZ6sqQpSIjiR3WP34d
	jrZvubo9mH4gQr8JGhUrUFZ/SPFym+pQpR/BE9hJ1QxiGZQx2ZqayZPQrsILnwdGobvkdKWTFTm
	Osqlol78oreJFyTQg==
X-Google-Smtp-Source: AGHT+IEgHTaTHOh+lA6JUZHbnapTEWK9wRoncZ2E1VWm92awnld772e7CvAH/uBvGsK4QIuBWefrUpAvTJufdHehSXo=
X-Received: by 2002:a17:90b:1f8a:b0:327:53f0:6368 with SMTP id
 98e67ed59e1d1-32753f06524mr15768520a91.2.1756470366534; Fri, 29 Aug 2025
 05:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828170503.2323187-1-nkapron@google.com>
In-Reply-To: <20250828170503.2323187-1-nkapron@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 29 Aug 2025 08:25:55 -0400
X-Gm-Features: Ac12FXx1oSX4EXBH9uiLUrEqV8tzBGv8orc8GPDBy3QXtzhALhvI1DVsZ8SdY9o
Message-ID: <CAEjxPJ6C4zALr7UDh2Psgt2KqPhhGuMW_aWZuko9+RqtNtb15A@mail.gmail.com>
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

Same caveat here - don't rely on this policy capability bit remaining
stable until the kernel patch is merged and de-conflicted with the
other recent patches introducing policy capabilities.
And likewise, again doesn't require re-spinning IMHO but the changelog
below should go after the "---" so it doesn't get included in the
commit message since it becomes irrelevant once the patch is merged.
Will wait to Ack this one until the kernel patch is merged.

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
