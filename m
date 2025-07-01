Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2AC274FFC
	for <selinux@vger.kernel.org>; Tue,  1 Jul 2025 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382786; cv=none; b=e8GYikZLLQ7yL8kw5lEozJpIeunq78rnR7NIjjXjPVlW32ZGvFRvZ6wfdHuskUxWoh+va7Yd/c2BeyOTVXnkea3CRBLGcLMBswhHWPda+rbBvqIFFKV0C1EGqJRHZS9N3APpny/mxUB8ydF2nISjhxXMFz4xwSnE5tOUcJFaw3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382786; c=relaxed/simple;
	bh=AOLz7i8r/MBOMRuYQo8nayjWXCw4WQglPR/vxzZCcZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8y0gy7W/rM8Pfs4mbBwm7W9uS1H5G6/aeKsBYNMC+w/MN0Xu0aqxCQmh3vDY25HYNBF7Bp/Qz4G21xd6PxJ9ptYenNfQGKyKvIxTm4y3EJbJQmLNd89csXj56/pMkNuuWnTjc+2AXEN13VaOinO+lwF8laLwoMSuPS/RJ7Cb18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgZxymU5; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgZxymU5"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d467a1d9e4so86888585a.0
        for <selinux@vger.kernel.org>; Tue, 01 Jul 2025 08:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751382783; x=1751987583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhVoRxrLNVkkg1y3PKwwZXpcVNnESLkajZDAGkSq38g=;
        b=UgZxymU5U3I2L1vdLhWvsxNRZ3mz9IiiXgxr57uj7fOIqi2zVdGDxkYCgu67nhnrdd
         KnrN+6jtcJxgqfWkAJDWaObSv7hElcNt1Kx7tQ04RffjvacxYM+JmpyGyzWG9V+Lghfn
         dvIZMkb4N3adKMd/KxOphnwBby5AJVdYztVUUND3qLM/TU45Yl4WrCYWxK58MuDVDI1G
         M3vQjbneDL4GpkjqZzJCRUb7PYCqnrRCCwItowMHZlwXMs0ZVif/IQtcFgobyT7pLNAW
         Jny4isZ/MlfMtlagrkaZQVDOt0R1dnAghiMfWyXg+G6DpIB6PR44XkUeB9rAVfsEZ4HN
         8iqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751382783; x=1751987583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhVoRxrLNVkkg1y3PKwwZXpcVNnESLkajZDAGkSq38g=;
        b=LE/28lIOzbnZsLy+iJdXboKDGx+xhBsu63pPzFQ1TpPaql+IMJrS4870Am0WLfWgfo
         Zgqb5E91NnZeKlBsoG7QLhsGIkfx8NJlV7gC/pRxOOVsWgF+AQ5iQsLbHK5/+Wx1NR02
         /EB2T7UxT+V2Xw8+LUovkLKDjmvIyiVcQBhqjP5GFpCNARJF1wzU1gmOvW5r3tEwuMK1
         bqeh9g2Ck3FFSXANgz6in1gqZ6j+dyhaUddMKXK44Ndvs8uzA6XpHESNFQfLdnTXrXrJ
         CGJGgoMlBGwrOp4TzRWhzcr/As5y+OiDuxuCipKCyMFud4Sz9qzuFko3M7paKlfBTLqC
         rNuw==
X-Gm-Message-State: AOJu0YzvB09mUft7BtBcXQL7l1MCGNF62+G0ZXU0Wf+3BiTDh4qQXVzx
	JYHg++l5+pNonM84wBni5TL8kA0r2eAxk2uw6HI4POgjxl0ksileYfWBnSZ44YWa0hUfryPlCKq
	fEnZ8uUW4Z8ubqyKmBpWgLjFXXH1mVIw=
X-Gm-Gg: ASbGncsSjzIJgPRjWOx3vBUKSTfpDaW3vo9cS7CUbno89kKEq5m0wJ3zPaaSKFS1jLQ
	qZw5vnL3Y31lISKBgwETzwFrW8RRNlCMnuiGY5beKtJXKdbe9nPailSpUYw8kn/j3Qh4AYlPFg/
	t8RsfvC40heOSpBo4CTpjfJ1IpPmydJNLuVbSTgKV1
X-Google-Smtp-Source: AGHT+IFQVQtkZdvJjocghbCKRdC5Q1Jx7g7thOn3ryI9aXvfupvs+KlcsJr6Lq0qLK9BjFEbkLfvDidf5E8i7oh6WUc=
X-Received: by 2002:a05:620a:424e:b0:7d4:4b12:a39c with SMTP id
 af79cd13be357-7d466de2a72mr537594685a.16.1751382782970; Tue, 01 Jul 2025
 08:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87bjqebpre.fsf@redhat.com> <20250625104103.140498-1-hi@alyssa.is> <20250625104103.140498-2-hi@alyssa.is>
In-Reply-To: <20250625104103.140498-2-hi@alyssa.is>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 1 Jul 2025 11:12:51 -0400
X-Gm-Features: Ac12FXyMm9qRnj8YNaU9DqXEWcOEAf5B9zYfTvXoeq_powafpnB7UrvZ4vJ8m5c
Message-ID: <CAP+JOzRcrLjK_pVWPGRVicPk4_QhwW_fo0pVfpdHuJi1WNm29g@mail.gmail.com>
Subject: Re: [PATCH 2/2] policycoreutils: use pkg-config for libsemanage
To: Alyssa Ross <hi@alyssa.is>
Cc: selinux@vger.kernel.org, Petr Lautrbach <lautrbach@redhat.com>, 
	Nicolas Iooss <nicolas.iooss@m4x.org>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Dan Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>, eparis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 6:41=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>
> libaudit and libbz2 are only required to be in the linker path for
> static builds.  For dynamic builds, they'll be discovered through ELF
> metadata.  pkg-config knows how to do the right thing in both cases,
> so just use it rather than listing libsemanage's dependencies
> manually.
>
> Fixes: da6cd3d8 ("Support static-only builds")
> Closes: https://lore.kernel.org/r/87bjqebpre.fsf@redhat.com
> Signed-off-by: Alyssa Ross <hi@alyssa.is>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  policycoreutils/Makefile           | 3 ++-
>  policycoreutils/semodule/Makefile  | 3 +--
>  policycoreutils/setsebool/Makefile | 3 +--
>  3 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
> index 7acd51dd..0f3d62f2 100644
> --- a/policycoreutils/Makefile
> +++ b/policycoreutils/Makefile
> @@ -3,7 +3,8 @@ SUBDIRS =3D setfiles load_policy newrole run_init secon s=
estatus semodule setseboo
>  PKG_CONFIG ?=3D pkg-config
>
>  LIBSELINUX_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs libselinux)
> -export LIBSELINUX_LDLIBS
> +LIBSEMANAGE_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs libsemanage)
> +export LIBSELINUX_LDLIBS LIBSEMANAGE_LDLIBS
>
>  all install relabel clean indent:
>         @for subdir in $(SUBDIRS); do \
> diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule=
/Makefile
> index 7c45831f..018ee2ca 100644
> --- a/policycoreutils/semodule/Makefile
> +++ b/policycoreutils/semodule/Makefile
> @@ -7,12 +7,11 @@ MANDIR =3D $(PREFIX)/share/man
>  CFLAGS ?=3D -Werror -Wall -W
>  override CFLAGS +=3D -I../../libselinux/include -I../../libsemanage/incl=
ude
>  override LDFLAGS+=3D -L../../libselinux/src     -L../../libsemanage/src
> -override LDLIBS +=3D -lsemanage -lsepol $(LIBSELINUX_LDLIBS)
> +override LDLIBS +=3D $(LIBSEMANAGE_LDLIBS) -lsepol $(LIBSELINUX_LDLIBS)
>  SEMODULE_OBJS =3D semodule.o
>
>  all: semodule genhomedircon
>
> -semodule: LDLIBS +=3D -laudit -lbz2
>  semodule: $(SEMODULE_OBJS)
>
>  genhomedircon:
> diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebo=
ol/Makefile
> index 1d514846..87494c55 100644
> --- a/policycoreutils/setsebool/Makefile
> +++ b/policycoreutils/setsebool/Makefile
> @@ -8,14 +8,13 @@ BASHCOMPLETIONDIR ?=3D $(PREFIX)/share/bash-completion/=
completions
>  CFLAGS ?=3D -Werror -Wall -W
>  override CFLAGS +=3D -I../../libselinux/include -I../../libsemanage/incl=
ude
>  override LDFLAGS+=3D -L../../libselinux/src     -L../../libsemanage/src
> -override LDLIBS +=3D -lsemanage $(LIBSELINUX_LDLIBS)
> +override LDLIBS +=3D $(LIBSEMANAGE_LDLIBS) $(LIBSELINUX_LDLIBS)
>  SETSEBOOL_OBJS =3D setsebool.o
>
>  BASHCOMPLETIONS=3Dsetsebool-bash-completion.sh
>
>  all: setsebool
>
> -setsebool: LDLIBS +=3D -laudit -lbz2
>  setsebool: $(SETSEBOOL_OBJS)
>
>  install: all
> --
> 2.49.0
>
