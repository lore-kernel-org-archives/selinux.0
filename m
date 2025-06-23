Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAEF1B4242
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750701521; cv=none; b=GVoBp9praF11MfJItGXLUvgA45/F4idYfvnvCxG3N4hGq881b1+6xfkEZpT31ZPhfZD6fPmw3IXWlSZb7K3HcktkKi/QSpJyOh0WspKLWjmfXdFADE1TQCnYm2B//RYE2IxYMMsx0uub+iM2lAmXfpyMBh5EWvpYz6TaX9OQk04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750701521; c=relaxed/simple;
	bh=Rq1b3mXOXB/34Y9nslPb9rUTHkXr5Q51uEPafXu9PJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGXPop1pb3eyy0OJU4Kt9iFBZAKld35cOIRKQSPtdR8XC9BnPotlSfvgmdKGqGIr6zgOC3QIJEYy6rqKR7AQhLVdTV+XGI+FV9nvsREsxn929rsm1JiT2BTPMrB2s4K+nDTUCdTItBmGX8gKfFeBRHHAXGHgK2ja+nDYvUAY+PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjDnFKGj; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjDnFKGj"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-87ecac3e17cso1025121241.3
        for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 10:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750701518; x=1751306318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdwgweGQikHxxl3ibpgQiwoWo56feChmEn2GGIUIHgQ=;
        b=CjDnFKGjURU3//xgfFd8II3DbPGtYemLvTgv7vT1esgxoa52hbgXBUjEEkr0LLW3dj
         oa6fK6F9X/RS79iBHWOH30lNm96zhgWEDT+j7CcT35J/5eAS6bFg0SA1Ct7Og6hz1jKr
         ELJmAv1SouEXKM+MAKQDwcS2ycjRDqnoduqOOZjtio2FQmNBerj3zkipJEVpyuMVEbEk
         GQnhT/QalZwv3kUTSWqwXwxZjRbBoenYWQHOlEz0Dp9AOdP8IdLnvu9S6d8Pu8qc6W6+
         anqNROW74Zy+yttTpL47fAfwsUkNCrpHv1UNiJ3U5EPiIgtRoLmyXknEpwK39YEXPr+/
         0TZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750701518; x=1751306318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdwgweGQikHxxl3ibpgQiwoWo56feChmEn2GGIUIHgQ=;
        b=SJkJT45JsATNGt8qgTFhpynQTOs2pTwmgM0pw9CtM1jr2OXGu7yLBhZGOmJMeeDRjU
         gltKzI81yX8xiimu/GAp7dxHo3spSkIPWLiOGkWKsQxIEeVWK3rN+zE0eexdrr+zimI3
         YmRiggGAVU3PeDe4pPrhQ/WHEq+2VirWjiTdPu1TCzApBpP/fhGw2oKflB94HHxY9Aer
         TPsNJcqAmRLSG1rnr6L5dA8ChRqJryVOcq4LxJhNQLz0TFYuRifb0Np+c9wWBoszs0Bi
         X/Fv7alglmNb2oDp4OKNrm5ngs9sG21FeKT5dclrEKzqiOKD1lgFtrqPv5SvGGPc0L/1
         7Vwg==
X-Gm-Message-State: AOJu0YzB/eRgU8P5IobGhktLjbyw9Cf1wKbFPUx+8PLqCM04G76cPnfi
	QY4tAfN8rnA4pqkvoIfA+HJsZpsAmhL6B27ycvYEsODvQOoRXhXgLBB1txCWkIPl0f7wvfwBb+o
	ZVmydLyV8OCcbkTwi7gutNHdXDTIUX8I=
X-Gm-Gg: ASbGncu5D/9JRNlNOq6LZDjiJ4FFQHra/9hpemJxNqsBfzVHMo3C6YZPSdttR3tWUdP
	UgUw5gkKV9y4FMOhQ3/Cf5SMZDJSXYehrixe4CrIut/Dj7FIox6Iax4NmC3UFreVD4cogh/COSu
	+nS1IoxdU1VhxsiY4VfA9yxq/jfy3m8SH4tkuA8Xtu
X-Google-Smtp-Source: AGHT+IFiH9RObRf5wefEANaZSYevkJ4aehKe84CC9NkQHm3yEfzQSQ2OC+0Zn9VujXv4pXHdxI9cUoLxkMVtNxg+5y0=
X-Received: by 2002:a05:6102:510e:b0:4e1:48ee:6f36 with SMTP id
 ada2fe7eead31-4e9c2d3e74dmr8086222137.19.1750701518252; Mon, 23 Jun 2025
 10:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623135133.217270-1-lautrbach@redhat.com>
In-Reply-To: <20250623135133.217270-1-lautrbach@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 23 Jun 2025 13:58:27 -0400
X-Gm-Features: Ac12FXys0EgvpjbxMcKbJub-_dI7J2lZs9E3nefv96WJqSqCra17_gKcU5KBFsI
Message-ID: <CAP+JOzSMT1jbNpw9z4pb-pVh8ZjboQkeKr9qZEkQz3GZRDyBPw@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: make `-laudit -lbz2` conditional
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 9:55=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
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
> ---
>  policycoreutils/semodule/Makefile  | 4 +++-
>  policycoreutils/setsebool/Makefile | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule=
/Makefile
> index 7c45831fcd4e..e5e5a3086224 100644
> --- a/policycoreutils/semodule/Makefile
> +++ b/policycoreutils/semodule/Makefile
> @@ -12,7 +12,9 @@ SEMODULE_OBJS =3D semodule.o
>
>  all: semodule genhomedircon
>
> -semodule: LDLIBS +=3D -laudit -lbz2
> +ifeq ($(DISABLE_SHARED),y)
> +       semodule: LDLIBS +=3D -laudit -lbz2

make does not like the tab here (or the one below either).
Thanks,
Jim

> +endif
>  semodule: $(SEMODULE_OBJS)
>
>  genhomedircon:
> diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebo=
ol/Makefile
> index 1d5148469f01..03b8b67a5cb3 100644
> --- a/policycoreutils/setsebool/Makefile
> +++ b/policycoreutils/setsebool/Makefile
> @@ -15,7 +15,9 @@ BASHCOMPLETIONS=3Dsetsebool-bash-completion.sh
>
>  all: setsebool
>
> -setsebool: LDLIBS +=3D -laudit -lbz2
> +ifeq ($(DISABLE_SHARED),y)
> +       setsebool: LDLIBS +=3D -laudit -lbz2
> +endif
>  setsebool: $(SETSEBOOL_OBJS)
>
>  install: all
> --
> 2.49.0
>
>
