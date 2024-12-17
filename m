Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9469D1F7570
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467170; cv=none; b=qs9trPK2gYIoekVJIWnUHxifM0i/4+1ydgWHym7/HGEP5rbUOxoIQzhGNQEV6+V7ccPc93vD0myU5b0cTgeF4cNRxTi+8L3roesc+ugvcqqXaxO4fXROEHyorNFEq/rEOPHBsWVghZrMF6T4ymcd8NHhqovb7rZf6W6Ve0qL6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467170; c=relaxed/simple;
	bh=VTA8lTIUwlh7wNo7+BrzAcnu9A37Ftst9/huyi/+zl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9OK4+ss/dS8JFakYF6AqDLxYqeNj+EYyve4yjk9Z9NQLmzXQYv7SO8uW3j2VeiU4EBYz/7Vq+MAB/SXWp4oq5wG8Ie3EcW5nvrsk711fbJ1HWfB86HzKkMcpX1OUyWf/r5vHrWTeGXJJgmCLewgpy5dswkbLQSZgozaJ/sa2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laZgBdYK; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laZgBdYK"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-85bb13573fbso1548657241.1
        for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 12:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734467167; x=1735071967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkANpBqhO7p+zyPuvY0CPGZazjKILXmbj9THwVIT1Rg=;
        b=laZgBdYKntWZMsDpBo8KnCI3lg21mfW36yqNIvWwwE0UpUX+cYVMX3wI9RVHunGpEr
         V+uksO1pidlv/30zEvXclFJXqhZ5mvKJnOsqfJsWlDpe9onwaEv3JSlEDG3+POHzUHZz
         fmNio0UJcIaNieozsUDYXVYFZnLbq6ird6O0qwDsvvT8skTY/FE40EALcYLqlMqe40gI
         0VQsOTxpwF2Ap7lLvls22o8x+EGTX8Rjuez2B7I2Lvt9C9VQP7oJZCFuox/0nDANXpsm
         tSTtNb8WiKdBtN7EJwTYmErGATjiNb+FXQPT3ymbNwFHOujF4yODLJkEJTbKCdtzDbQo
         ygUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734467167; x=1735071967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkANpBqhO7p+zyPuvY0CPGZazjKILXmbj9THwVIT1Rg=;
        b=NPZn5slXMmZlv7iZeUzZXUspd7XmYI8dNvsMA3CqSqioukV1j4JYajf+T2MI9tebrf
         GDVoLXC8758/H0Bkv0JSW2QH914AKf+GN3r0Uj4q96cJQFV5EUf97cPVl5sfrTaz/R6I
         XS4ryGx285vyIQFEicLsGbFcyegBoyM/YoKjOCOVpQIkbUqCxwxuaLuTa9x3HCudoTLn
         pnrb7qg4RHuzMa8JqXNU0COlk7La1vx7BlrT2q+7A6py6Z82zl56ju1wRTdTCed1ZOuz
         KyjlEjrecr8MMB2NTxK0eVWCcLNNwnyLTrAHlQkTFyu1O2szvEWMInGwCHyowd+u5CgD
         iypQ==
X-Gm-Message-State: AOJu0YxMHzYYJGKOe5AdFkHBsxxkHEhqoeF/h9WN0R2Mq6ZqWzZ/Ejq4
	GY3guPeDCV3XdfejeTSq7fXaqT/YIiLfvPzJT4/QH/cSszOT6PBzcuwsuC4BkweK83GO6aMD9+t
	zrxBb72rOD9yA91nddp3UdEc38R2wOhV9
X-Gm-Gg: ASbGncu4kBZIiKO274TMcFEvmpp5VyslCIy/Q8L/BlXmcKwlVV/euZxOaTwEN+mE17p
	NAW4fNqfVR3EFTvipk2fNBwQLelDRE5l0obTktQ==
X-Google-Smtp-Source: AGHT+IHxwYruOmq7bWdHAkGIcKZ86irqFvYBnvw42RdCy2oYuHVfgN4dT4EcjyQsbXT31LaCZUJ6TZhLN2hcXvSKNhE=
X-Received: by 2002:a05:6102:32ca:b0:4b2:48cc:5c5a with SMTP id
 ada2fe7eead31-4b2ae7774demr289712137.15.1734467167460; Tue, 17 Dec 2024
 12:26:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204140614.25879-1-cgoettsche@seltendoof.de> <CAP+JOzRL6S4fP-9u-CJ-O1n0+XQZKeZNqUTz+uGimzw=y5wuHg@mail.gmail.com>
In-Reply-To: <CAP+JOzRL6S4fP-9u-CJ-O1n0+XQZKeZNqUTz+uGimzw=y5wuHg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 17 Dec 2024 15:25:56 -0500
Message-ID: <CAP+JOzR4Gwvj4yZRMtGwnWzt7+n0Opy265HGk4Bo_f0jB3mZ2Q@mail.gmail.com>
Subject: Re: [PATCH] libsepol: add missing word separators in error message
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 3:05=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Wed, Dec 4, 2024 at 9:06=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > The concatenation of the multi line error messages misses a separating
> > space between the boundary words.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/write.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> > index 4ef98449..89c80e7e 100644
> > --- a/libsepol/src/write.c
> > +++ b/libsepol/src/write.c
> > @@ -231,13 +231,13 @@ static int avtab_write_item(policydb_t * p,
> >                 return POLICYDB_ERROR;
> >         if ((p->policyvers < POLICYDB_VERSION_XPERMS_IOCTL) &&
> >                         (cur->key.specified & AVTAB_XPERMS)) {
> > -               ERR(fp->handle, "policy version %u does not support ext=
ended"
> > +               ERR(fp->handle, "policy version %u does not support ext=
ended "
> >                                 "permissions rules and one was specifie=
d", p->policyvers);
> >                 return POLICYDB_ERROR;
> >         }
> >
> >         if (!policydb_has_cond_xperms_feature(p) && (cur->key.specified=
 & AVTAB_XPERMS) && conditional) {
> > -               ERR(fp->handle, "policy version %u does not support ext=
ended"
> > +               ERR(fp->handle, "policy version %u does not support ext=
ended "
> >                                 "permissions rules in conditional polic=
ies and one was specified", p->policyvers);
> >                 return POLICYDB_ERROR;
> >         }
> > --
> > 2.45.2
> >
> >
