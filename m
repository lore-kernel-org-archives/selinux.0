Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBC12D543A
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702152; cv=none; b=VohPVikUPKUSuVPe9D6A2GoN9QObqoy6pC0c2fZnbGdTSinMYs8DdWZNgU/Pqn/Fan3h62oo/WcgKz4na3YxTgrIreAchM+OQSBLsraNCyQquR6IAjnCiaO4jo9xBHF4XqaXMU1etKqTTCbuzxS9t5USwCzLNhwNJtacd5MZ8dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702152; c=relaxed/simple;
	bh=SscqmdzcNgq1lGVcxK63v6BKsMacR24ht5Vk4QOQG+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cu8BfOGZlUiNljJljrPsOjS9NgSbkpKatfkhvheC0OHU8ao7hn4ntXNgrWbE7M5P+Uxu1V0NdAbZ/v2om0ghk+mBU66HpqigE0fgWMG8BMHjhUoQv7oANXVzDPCAeQAOnfKlh/03zv+9f1RUPNCZPWpdojvnIsd7FDSohvuu3Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ncu9E/sU; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ncu9E/sU"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4e79dde8511so901777137.0
        for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 11:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750702148; x=1751306948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r62/mbUcmn3N7BSZQ6AerYdv8TBwZ5mDCx1vw3o/kKA=;
        b=Ncu9E/sUCTcd08lJRBjPS7EJvqQT6AG+RLnK5up9XJvWF9B4d9BHht6VddjkzZPuQm
         b+GV+jtbOWi04eFcHTvTaZFwfcGgZgiJJiqWPDWVotxVNiWmjUn0Kzu94T5dfbsNZbC5
         az72tEOLHPvEvhq45wTKwDSwmFl2FXKwQQI7fBaizNGSJXf3dpA0eC6pHL3SgD+es17J
         iyvTOGpoSlyqXf9pnJAUoa3cenyOIagTRwoJhv/tutswxHV/DqtNYTMbq8n/djvWnS3P
         RBAQEOUAppuNK64lj7+bm8X/dGTb5MAfXyVCxzloGgcj8sUrXEehTLxoW1Y++8YcIYqg
         tzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750702148; x=1751306948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r62/mbUcmn3N7BSZQ6AerYdv8TBwZ5mDCx1vw3o/kKA=;
        b=uNzL+ioir7oPk77BqW+cYImlDxSNXvpKUF+xzbAYSUJH7odFl3qwA4MPDmgZlQAdpR
         hnqj/QIfLruB9aq2uuu9tAyGT/op/ol5lOoAD44OimRUSxzyPoCMuov8LVTjPdgQLmhC
         gfxFhHyr6WvwXlnTG23IZ4VcqzEq3wJ2DXcRaHaE8B2yqVe15X2TVV9bjtq4sdGID3zx
         Ks+b7801twzH5dCj73daLGW8ov7Jbbh9Q98NTgrSjhwCn8hYTEWJ2Qa44Wn1Z+KTV74N
         5eL+2xRUeiOw+HkqPsBPovse4T+28q5Fw0Kw0H5Wwjf5U2T9Bh8F9NmzjL/NIqyeSQXJ
         KzFw==
X-Gm-Message-State: AOJu0YxmeEOO6vJ87SwYxqml0j8slE1147YHtulfvhKyEybcmBbcqvAu
	Luog7iLufzDP0hcU7ELyfBtziD5vMGhAhIPPjPt0GmxDwJuEdwW/PG/fsqpM7GO2t2wOe8cdpda
	PkMoCEUUiyw0qoVaT5d0RMJ/RGyVO2jJ7r8sH
X-Gm-Gg: ASbGncucHxGOQce4fJQuCOtQWhrebQqPOABsINBKztUCYvAzJ3AixXqO3FwVGBUMVBV
	xN8Z9ZDjSf5DluFodnVDJjnRXOCA/wda0D5KPtYcav5EFmMwVQFy3we3ro3/hbLReKaQVHupkNb
	qBebHYkRiBvzZy8W840ylPMFQWs/tYLeFrvfJcjN9G
X-Google-Smtp-Source: AGHT+IFy9uOOgPzBbVsHUK75iE+zQlAj4kSNVYVx5+Edn8Eb9bevHUVdaJsyk41AwUhSNFQWaaq2YVl2uuYWUkls25w=
X-Received: by 2002:a05:6102:504d:b0:4e9:b793:1977 with SMTP id
 ada2fe7eead31-4e9c28bc437mr7806330137.0.1750702148552; Mon, 23 Jun 2025
 11:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623180645.232680-1-lautrbach@redhat.com>
In-Reply-To: <20250623180645.232680-1-lautrbach@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 23 Jun 2025 14:08:57 -0400
X-Gm-Features: Ac12FXx8E46ex361dC8XoVvnoEPT3oSnrLA1vkC7CznD_4wMl16fElmjmGot6kQ
Message-ID: <CAP+JOzRhp_bZXDZLnbS3DbYeJYpq0dsVzfchZQ8rCjDkGy-HGQ@mail.gmail.com>
Subject: Re: [PATCH v2] policycoreutils: make `-laudit -lbz2` conditional
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 2:07=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Commit da6cd3d8d7600 ("Support static-only builds") introduced possibilit=
y
> to build static-only toolchain. For static builds of `semodule` and
> `setsebool` seems to be necessary to use `-laudit -lbz2`. As an side
> effect, when policycoreutils is built without other components, the
> buildroot requires libaudit.so and libbz2.so to be available. For shared
> builds this is not necessary and had not been required before.
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>
> v2: fixed indentation, I was inspired by the wrong file :/
>
>  policycoreutils/semodule/Makefile  | 2 ++
>  policycoreutils/setsebool/Makefile | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule=
/Makefile
> index 7c45831fcd4e..52a68dfcac10 100644
> --- a/policycoreutils/semodule/Makefile
> +++ b/policycoreutils/semodule/Makefile
> @@ -12,7 +12,9 @@ SEMODULE_OBJS =3D semodule.o
>
>  all: semodule genhomedircon
>
> +ifeq ($(DISABLE_SHARED),y)
>  semodule: LDLIBS +=3D -laudit -lbz2
> +endif
>  semodule: $(SEMODULE_OBJS)
>
>  genhomedircon:
> diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebo=
ol/Makefile
> index 1d5148469f01..f68440f90df7 100644
> --- a/policycoreutils/setsebool/Makefile
> +++ b/policycoreutils/setsebool/Makefile
> @@ -15,7 +15,9 @@ BASHCOMPLETIONS=3Dsetsebool-bash-completion.sh
>
>  all: setsebool
>
> +ifeq ($(DISABLE_SHARED),y)
>  setsebool: LDLIBS +=3D -laudit -lbz2
> +endif
>  setsebool: $(SETSEBOOL_OBJS)
>
>  install: all
> --
> 2.49.0
>
>
