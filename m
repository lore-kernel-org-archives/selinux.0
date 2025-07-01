Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE518140E34
	for <selinux@vger.kernel.org>; Tue,  1 Jul 2025 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382892; cv=none; b=cS1jeBCxTjv3ZxpZXSngTp4WWFR2bLGToutuuSru931bkOZ20JfPfEoeNgX9feAl37fp/6YdHdh9snLhmiK97FKNGGeIhOd20L48uXUmslgkidUIFkqLACo7zVls8VPyFfpoPm85Cr8yZnwwY0WvZBPqpr45Zij9qtr0K90EvmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382892; c=relaxed/simple;
	bh=n4xyzxw0Dkk2y9lsVjTBWrzFs2Kd7g3mK2VZFZ+ABlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=cp2syDWktQGxSalt2CsVuFAJ1+CzymBIsFK5f8LkcFolksccWn0EtS73DpadgLSA427/9/9Kt6Lwv+dMrtiqek2ToICrHLUndnY72rj8Aj/O0bDFdPCvvp1SJhDiNya0cS0DX2evlF94GawhBIH0MZqJwF5/0lS655MW8xQR+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9/SQLny; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9/SQLny"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d098f7bd77so644129485a.0
        for <selinux@vger.kernel.org>; Tue, 01 Jul 2025 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751382889; x=1751987689; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSQQVx358+EDqjktIllZSUJoDSScZIINVuBUqFqQJsY=;
        b=P9/SQLny6Pd84PoRqaR6XkI1rvLHUtGasV97vBvjasWHhuTJPG2pkeycE6ZbN1V092
         34gzrQ2ZBmEXjGCVWbvEYwQLZxnc/sP8sFoMi5CT7xGNCiI5InOQY9z3yWKN3ravkIke
         qdF0QzIlWCakm/CWuBbgy4OFsIWi/RSAA+zKRqug76pYRroknA5KPZrH4tXfl0LDuMQW
         nDde/N85Ps2TTJvDW/j4RH+WaYc9EDl0ovM7f6FiSsMlvsPvL5XA8LlhAooZzz0EzvTx
         4rQNQli7H6OjZH6Oy8P5AehDFImYhYqyx51BFzsZtmocI3nCPEWsw2IAOGJzlPOFqp+Y
         fGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751382889; x=1751987689;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSQQVx358+EDqjktIllZSUJoDSScZIINVuBUqFqQJsY=;
        b=nQeyXb16aVZpZgTuQ8Dva0cKZn4VU12eBaGYV+hUW5P24o6DeddCioaNUS9F9IGluX
         O0zNMoll7/VsEU6+UJ9mbjkDvfLC6ZUOYJM2V2Ay9Lb9eRaRCqLWhGQhx1qNawIXS+LI
         sZuQU/agEu80gOJ9z1yXR9cYomUNAnXPF+q6it+RTr6n/KbgbKF+36723vanjoOFTXVS
         V4A6gstxls/7QeKRqHfuniNBPACrXGZcCOyUfPgfFVKSJg4fKevh/QqTl0IxCzUUiaYA
         KYZdm5tSNWxBFh1w1tdI0OwPtZZQxsuF+bYjxfygZ0WwzGgjxyC1ARlshvCbLxNoLxXI
         9GYg==
X-Gm-Message-State: AOJu0YxXEufDqHcr4by+wWAJVv6XIopZloQ8HDfIh4l/d8lQncSHbFuk
	Pp/yACKWPb+7Jk21BB4xD9tJQ1bxhRtP8QJed0FK/AEmznUQLScXnNZnlAntIBHtOhXI1W1wZ85
	2cexqT4W+4CJnJxrJEpVZiM/ZD3SPqXdEeg==
X-Gm-Gg: ASbGnct3Xx8DesiH/vmlbIxhOh1aPZHliWDx6+bNZ0p1g5WxfdPvJQWCRy6QiXsxxQW
	AXb4BEOFFh5ko5MUsEAf/0X2TtYUT5xLhuZ9Pw7AlmstE5+cH4J3mGrXMu7DDi8tf1lD83W/Hp7
	VZCbeV0RS80TiHIVUQQVP2/3POHSQuySVC5d8k9tML
X-Google-Smtp-Source: AGHT+IHH8NKvvr+QPVwGl16TXANNgBfgqBL663l77qB0CrCS22+g3CUbdXaNKk1ZZG4klZGOetIVd2DGhPG3hc9xvgI=
X-Received: by 2002:a05:620a:179f:b0:7d3:acfa:de46 with SMTP id
 af79cd13be357-7d466e317demr528256385a.21.1751382889425; Tue, 01 Jul 2025
 08:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701130309.260015-1-jwcart2@gmail.com>
In-Reply-To: <20250701130309.260015-1-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 1 Jul 2025 11:14:38 -0400
X-Gm-Features: Ac12FXzarRT3oQDhcPC9OQ-aWA6DONADxRoNqP3fG0nOxc0MG-wC7Wk7vOTKRBk
Message-ID: <CAP+JOzTdnLj3ZnCg1-wD7SdO8oXKsxndJ8BBDpYE9CHNBXY3Dg@mail.gmail.com>
Subject: Re: [PATCH] Policycoreutils: Make pkg-config work for more types of builds
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 11:10=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> To support static builds, pkg-config is used to add the libraries
> needed for libselinux and libsemanage during the build. Unforunately,
> pkg-config will always use the installed pc files for libselinux and
> libsemanage.
>
> Instead set PKG_CONFIG_PATH when invoking pkg-config so that
> it searches in order:
> 1) The directory specified by PKG_CONFIG_PATH, if already set.
> 2) The local src directories of libselinux and libsemaange.
> 3) The default directories specified by the system.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

BTW, this applies on top of Alyssa's two patches.
Jim

> ---
>  policycoreutils/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
> index 0f3d62f2..7c9706e3 100644
> --- a/policycoreutils/Makefile
> +++ b/policycoreutils/Makefile
> @@ -2,8 +2,8 @@ SUBDIRS =3D setfiles load_policy newrole run_init secon s=
estatus semodule setseboo
>
>  PKG_CONFIG ?=3D pkg-config
>
> -LIBSELINUX_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs libselinux)
> -LIBSEMANAGE_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs libsemanage)
> +LIBSELINUX_LDLIBS :=3D $(shell PKG_CONFIG_PATH=3D"$(PKG_CONFIG_PATH):../=
libselinux/src" $(PKG_CONFIG) --libs libselinux)
> +LIBSEMANAGE_LDLIBS :=3D $(shell PKG_CONFIG_PATH=3D"$(PKG_CONFIG_PATH):..=
/libsemanage/src" $(PKG_CONFIG) --libs libsemanage)
>  export LIBSELINUX_LDLIBS LIBSEMANAGE_LDLIBS
>
>  all install relabel clean indent:
> --
> 2.50.0
>
