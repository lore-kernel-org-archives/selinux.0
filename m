Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9FF2F50B2
	for <selinux@vger.kernel.org>; Wed,  2 Jul 2025 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477745; cv=none; b=tbIe/Pv37rJ3W5xIslvJ/Xy3RS+nvuiQjQXa7GTBimnzZ4Im4LVqHV3UuYt2FmLvBAyH2/omMfbCeLvC5YdaL9eYJNbB3T/hsNtH5P1mELiaMZSz8zAByjHHdY34oqU7h4Ugl0Zno/x9eMcCuVGwCXtXFH3EiCdF/2fU4oW+EL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477745; c=relaxed/simple;
	bh=fRK0STm8/zlk8griGpsCzrQ/LVF6AprlyMaH1rL33io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=WovyPpv3WHb+FF9G9yDsnk6nMm1tnUrF9un3bhSKwOUxSHhOqQ9JHtLXWEpmBcy63I+aJgL6DgSrmQ1in5ChQRlVd01drEvTR1tpom/VZv49MAdFry1Fe4eWOyfee0hGlvfi9jMGvBZIdOo/6ug+jJzk4etM4nr2thj6+ynaukM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k88dxJ7d; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k88dxJ7d"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-88131f0badcso2781585241.2
        for <selinux@vger.kernel.org>; Wed, 02 Jul 2025 10:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751477743; x=1752082543; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8S+LR5T2KLNH6Czxo+xClYrQ5D+VnactA+yqe7PgJZI=;
        b=k88dxJ7dlHKV5hVqJB50TtTW8nXELW89BYLNzeyO5+EC7sd7KyQ4EtbaX2YCrJwzNj
         0P6D4UbDzdnRQ7nruBh0kDw0eM/s9OK9DcEYc89tKqgjJoFayGoGusBlkcQxzk3A3Q9D
         U8zj9qN+L9qYiXkj54srvlo5rUlZtwI2M+aEm9Ly9bZkTnsi+3tNTTwpk/4leW9whDAp
         798vaqY7N+eoB7mSaqTgkWpDEcC01vBGB97uKeGkNHa4VwGyGk8f3t32kAViFH8N/eUN
         qa7yB6FYNsQfBfQ1Bmo2NvE3+2NtOs7wHINxSXKl/od+CP6Tgb6PuWIQCr8958SbT6px
         pJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751477743; x=1752082543;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8S+LR5T2KLNH6Czxo+xClYrQ5D+VnactA+yqe7PgJZI=;
        b=LZ7P6D8dQnNhQ8G+C+OMTr3RMPXfs/n8zPgpCfPBVnhq20qZld4P9smnWvHAbrxeVk
         gC1w4OEE8d6othYgxKCD0Tq8h8EDhxUoU0uSbTNyJYPigfRfv3rjBwHZwQiVzPpXQUK2
         0IN+FJOI3pBbtSdR53FTJtv/aBAwPsNj+fPtJFA5n2hOBvJzOb0ijviR2u3HpcOhnjaH
         F/MXKsIdCaaASd0VH6ZHyFnNgpGgnv6wh/DdbQJb0H/8DrsJoh8zTkJamwNvBDB1fPu0
         JM0j7QDSuqoWIi6RJ6wZmvjP1JpSTDQQhK/Pyb5XgGP2Suqk+P7IlJsUBJ/QJqB/0o9+
         JahQ==
X-Gm-Message-State: AOJu0YyIh1fu5cnijvWsAl/L3XPUTTXledT5yv2s8W8rog/79rDJuH/H
	OANCuY7RSyF7qff+XhwUOxGttpMecnPORzFN+0hvHmklJhd54xTz7qONWVtGWB+ujeEOvtPShzF
	lMNKYkohlR9gd7VwBMUKNfyWUvB1zgStrvQ==
X-Gm-Gg: ASbGncshqyv+dj+7lNoLxhS28N4vGnnrLMtanYENuvsbSjNUpkjASDMNqzEvUe0KqlW
	kWJ980Hu3umJkHqfxAaOG1EFKP3mCr0NEdvrByLQ+wSjvBZ4piDcrn4jonf1pqrldnZuv78WLhd
	ODr/SmekITa+Aa+4vNHyUfchM0SPIBfGipI+ngZXL+vmijis6Mq+w=
X-Google-Smtp-Source: AGHT+IHGbAiXSokMRnDBQh/fC4tQt5tC4Xhd7hN74nI3GeOzrutN1Cg9Jl1j0buUYCpVY3gxFtCzOJMoFQ+KKZ2Quqo=
X-Received: by 2002:a05:6122:6169:b0:531:2906:752e with SMTP id
 71dfb90a1353d-53458103c69mr3298031e0c.5.1751477743111; Wed, 02 Jul 2025
 10:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701130309.260015-1-jwcart2@gmail.com>
In-Reply-To: <20250701130309.260015-1-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 2 Jul 2025 13:35:32 -0400
X-Gm-Features: Ac12FXxCUsMZHa01tlkfsWUWyZB3iwUnUN2W-V0EwXcNvS5D80LVsB3OyEm0YIk
Message-ID: <CAP+JOzT-CyXg8Bf4OTiY3G9xpOUNYr7U5AztJ59h8Z3MmX0cMg@mail.gmail.com>
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

It seems like there are no objections, so I have merged this.
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
