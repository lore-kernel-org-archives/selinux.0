Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CF81CFBC
	for <selinux@vger.kernel.org>; Tue,  1 Jul 2025 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382971; cv=none; b=OBrMNltj1oeksel+FTIhlZdq9vbc1D0p+cq76bqX09nUEPKDqZrRBClyCm5O45qvF4loxzU/Og6xw7azomNGk7+d6RNGP1D8irbIT/vmfGWAnXLA/4JlqdgKgiGzHNg4t89Yqk5i2PV7SjIQnTOjs+Vw54B/VCMOmzCA8fKpqfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382971; c=relaxed/simple;
	bh=I1h3JnHmOEXwM92kDbvgE0yhNqOxB/I1WN47BPY3abY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGs14J6t+vGb7PA2BkpdQo+gug8xVRkDFo8YK7QY90DMOfWJQW/aRKM6+ZClEOZXoIRm3b2ulIb9z/QYP5osSdY5NA1y9FHQo9bv+dtqhFnii0lyWZvrrMu1bRVoJsUZbWCcfgkILLXRabUWlXDFo5ct6fEYKgFxUXuhlM34DGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J95ngTmc; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J95ngTmc"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-40b859461easo136125b6e.1
        for <selinux@vger.kernel.org>; Tue, 01 Jul 2025 08:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751382968; x=1751987768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EG5Re7YJgPWSTkjRd6En4ZOa1RhV8QH3i74P7T4+Wq8=;
        b=J95ngTmcMbkkCuCX5uC8GLMAMH33hYdr/VSuXvyaT+DF57dp/5ViR+e4ANruv4yGm2
         KaZEPKlwUf7wOmNh2Ef2VwMyzfA2zuU8+NccX51tBCvhh+auNOqFFWhZfPNhAbkxykzk
         G9gK5HFLyLC2n4Lp9CtCnDxabwywqhDaru6y9szRGsTerFUk7TqT53242ItO+mnr7rdT
         ptyZXEV9TifZ3Y8Ib6lxDuP/DAhl6gabfEqpVPlVz7z6ovgGFdpFHVOMMt2FPeI65g05
         u3xZdOHabUwFJBBJYqQC4YX/qqpEDyAVtky7coFrDolrmbO/3O6hevLzerrAhbEzMosN
         cKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751382968; x=1751987768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EG5Re7YJgPWSTkjRd6En4ZOa1RhV8QH3i74P7T4+Wq8=;
        b=QWyS5OZlmRunq6KxleMROpZjxfi7LDJ88wJkbKoSimF2ODfCiYMpEQyYAn38eFoFIV
         ZGYvR6A7AEFIfZAapmrncXmAWp3uHGPfhFlSiE7SkZD+acqMPsC91++VLX8pPmLoXUfF
         pxTvgnSen07C6cgaWne+PwdtSBELPrUFyfc13Ck8gwov/6A/OE/qZ3G8f0XrFrmFJl0Z
         zAqGDxQWgQZ7UGoqHRsgeq+NJ2dLmNTt+l5HKbzL6W8f+13PxHLbVzOYGACjPQW3Ug3m
         sX4I9DqfHJsilVEanLd5wj3bDQf0E5Bm5J7a3fhDoFmalU4PFqmWVqBT74vy1FbuAa3Q
         diNQ==
X-Gm-Message-State: AOJu0YwyyUhAaNo1NB2T1V1vAyAI53FNpJVoH8+/WNStQr7YsXqczlJ6
	0Q3LKihcXTVjqbGgBtR7DLvd3IblkxEmfSmuAFar1q9g6GhvnW7F0AXwQ0gCXuS6SqCsaBG47DC
	SpF7QMS92OFR6sOUf1aUNBkXNVftaQ5M=
X-Gm-Gg: ASbGncviMHzTdpH3KhIlCvZ8MBBymTEXVjsE0vb8UA/Hdkj7BmF4q9pv4xV1S0b7Uzm
	kFiea4TTh/MkhuqpZFb7jIMHis01NABp1RYrI+JEgym4Wa4N6ETA0temfxfv3iTMKZRgugAmonq
	BgRClx6GB55VxQLuoeK1rJFBhfVRTtC1rAwDdZb9dK
X-Google-Smtp-Source: AGHT+IFEksKCSVfT3VNNoWls9a4uGZxalk4yLSxijknqcQaDRF/DtLitkwzyagCSYz6BbLZ05ZjMxCRbl7t2sCdbxWM=
X-Received: by 2002:a05:6808:23d2:b0:401:e6f0:a8d4 with SMTP id
 5614622812f47-40b33c60e48mr11810998b6e.5.1751382968460; Tue, 01 Jul 2025
 08:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623180645.232680-1-lautrbach@redhat.com> <CAP+JOzRhp_bZXDZLnbS3DbYeJYpq0dsVzfchZQ8rCjDkGy-HGQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRhp_bZXDZLnbS3DbYeJYpq0dsVzfchZQ8rCjDkGy-HGQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 1 Jul 2025 11:15:56 -0400
X-Gm-Features: Ac12FXyUnA0VwQwPw6oQbYejX6TwvVQdAaBX9P4S3IxZHik-jDQu0aU8N02-xS0
Message-ID: <CAP+JOzSoaJP7Dqt7G9bKKW9U_4Z-qQkyg3nZNfRtwpzSm_RGBQ@mail.gmail.com>
Subject: Re: [PATCH v2] policycoreutils: make `-laudit -lbz2` conditional
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 2:08=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jun 23, 2025 at 2:07=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
> >
> > Commit da6cd3d8d7600 ("Support static-only builds") introduced possibil=
ity
> > to build static-only toolchain. For static builds of `semodule` and
> > `setsebool` seems to be necessary to use `-laudit -lbz2`. As an side
> > effect, when policycoreutils is built without other components, the
> > buildroot requires libaudit.so and libbz2.so to be available. For share=
d
> > builds this is not necessary and had not been required before.
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

I think this has been superseded by Alyssa's and my patches.
Correct?
Jim

> > ---
> >
> > v2: fixed indentation, I was inspired by the wrong file :/
> >
> >  policycoreutils/semodule/Makefile  | 2 ++
> >  policycoreutils/setsebool/Makefile | 2 ++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodu=
le/Makefile
> > index 7c45831fcd4e..52a68dfcac10 100644
> > --- a/policycoreutils/semodule/Makefile
> > +++ b/policycoreutils/semodule/Makefile
> > @@ -12,7 +12,9 @@ SEMODULE_OBJS =3D semodule.o
> >
> >  all: semodule genhomedircon
> >
> > +ifeq ($(DISABLE_SHARED),y)
> >  semodule: LDLIBS +=3D -laudit -lbz2
> > +endif
> >  semodule: $(SEMODULE_OBJS)
> >
> >  genhomedircon:
> > diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setse=
bool/Makefile
> > index 1d5148469f01..f68440f90df7 100644
> > --- a/policycoreutils/setsebool/Makefile
> > +++ b/policycoreutils/setsebool/Makefile
> > @@ -15,7 +15,9 @@ BASHCOMPLETIONS=3Dsetsebool-bash-completion.sh
> >
> >  all: setsebool
> >
> > +ifeq ($(DISABLE_SHARED),y)
> >  setsebool: LDLIBS +=3D -laudit -lbz2
> > +endif
> >  setsebool: $(SETSEBOOL_OBJS)
> >
> >  install: all
> > --
> > 2.49.0
> >
> >
