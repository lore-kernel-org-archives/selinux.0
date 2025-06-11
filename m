Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD4A2576
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 00:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749600047; cv=none; b=nNeszHekPkmfJ2fYnfZXaA+e77w+uO6SpcEg99mODrRgCMn0btW0EPM+vsWLLHy1BXN1RJp3NeFt13PP4uT2C44c8Re3MjsGRcQWLYpOsWOtdhLLEGnfmtHvQRHEZcXulJP2se2ZJDxPJK7nu5EYH1OaFUhveeQnwHK9rnIWeFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749600047; c=relaxed/simple;
	bh=6pliUWjNyTVV6apbGcNUgGCujGDQwVKN7InjdC0k1GM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bkXHwv/E1Ot+MOyFZyGBpw5eeEE2IC9ji6igXonXcBMHSJKDzWQ8OG8aqjf83/Bn5jji1La8xm4b0PId2bmwRuhlQc4MPal42f9Gbl1EJ/fS7leFB6lJhwnB/R9lasskUWRNk8kfywpmm0NBLRa2X5meoJhQriG7geqCn6y2bjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TeJEVOrr; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TeJEVOrr"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e81ec95d944so352156276.1
        for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 17:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749600043; x=1750204843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnfDXmORkn8VgWLIsiFV4Nh55Ki5yFsNDh+Q2DpXTt8=;
        b=TeJEVOrrrYx0W6qIvxuS46gZzngfWT8rmwvKZTqtoz4vyCVNnQF2zaoQQAkF6o+LVB
         GRH6BIHfSHZ9XPyKaVB7H+5XE9Kb+L5f53wHdSkAe3oFr5zzYcTJryeXf9vZk2jF1ygc
         wVfK2A6AOAZET47Tjexn/e1rANPEw0PeXNGt43awtFxKyAkIRLLZ+siqXlBsP7cQQOtq
         PD+OnoRY2TKLmv71THgSDj+IqdKPv3z60V0Xb5ky3dAYpguwqVnYOQwSNBsPw3NpAkF0
         YcWMn2DD7ysPwntgMA2ysYwuX1itAIC0FBbQbVj5mD/vifIBRJ6m1Lr5A0BHbE8F3/FA
         uSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749600043; x=1750204843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnfDXmORkn8VgWLIsiFV4Nh55Ki5yFsNDh+Q2DpXTt8=;
        b=LRZUt2rtex+CczYexzRbQoUcHgbIkvDT+BjNcqvwf9x/AT3HFUlT6FKLpGZOIhFQWh
         SYYnwX0L60f39nIFIEH8dmggcOEa0G10SFSRAziGp599ZyQ/QZrmXwTWJeAqJKibeSSy
         gRHUR1TMFpjuJ1mnz8ImvxEq345YoEMV8RlmoqS6EYKe8Km7/j8VFcBVyTSXjeEsD7zA
         coWF3bR7WeDX7+dv3bXYxoNhti3rceOoN3UFn9EVY+lE8GZ/pcMuVlMn+2cZ2j2xcV3L
         HUGtpYf26TRPC/NJGauKEAkhZwgSKJcL+AGQ8LAqBomeZzKeLPo+SMdr9Jg5aMqD9780
         IayA==
X-Gm-Message-State: AOJu0YwbZqwoCwmZRbBjJ/9JC3b08wq5ROAi6ZLqXjpAI/Gj39mjA9ha
	k6ZUhZTi1V24HJIYhyUHbtS0bRZoBJkBCZf2b4uVq2XxIB0Qtj992so/zdQ5BAiibZWusXZ92Tp
	4goDcFunHmZx8SGlqJEWvkLsR8251lOKLJ7in4lTcs0CquQ3SXlk=
X-Gm-Gg: ASbGncu/eFA1ukiXXACjenF5unVVKRg2k86bOZxK2kGmgdCvPW3OQYRWcgqw3cyjr58
	UL/0zPE014jmqRX0Fu+TWsFWrMKTiUnnHxXci5PpeClLZ72GM0J5wOhj5LXcott6MPGryhh0M11
	/CPxJnW4dx0kw+riP8dAAHfaDmHBQ19o8xsyQXNNm9XoU=
X-Google-Smtp-Source: AGHT+IGjT+7bzMeeWNn8I44G8BcAkhc3Rhr/xgqjaXK9FTbCySR+EKgIl/zRyO6NJ9iSz3tN3CljHTgtAFV9P5aRu10=
X-Received: by 2002:a05:6902:2313:b0:e81:eb1c:1a1e with SMTP id
 3f1490d57ef6-e81fe899e1emr2136064276.3.1749600042545; Tue, 10 Jun 2025
 17:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515092606.14760-1-kalevi@kolttonen.fi>
In-Reply-To: <20250515092606.14760-1-kalevi@kolttonen.fi>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Jun 2025 20:00:31 -0400
X-Gm-Features: AX0GCFvizDIR2SDlM2tP8jVThvdZ9UIv92reLeOD7DAqnWIMINZ-ZaJGHR8Np5c
Message-ID: <CAHC9VhSMfn=en3z5Ue17B3gmozXLcajgzsvyM82v9Ec8F8fC9Q@mail.gmail.com>
Subject: Re: [PATCH] A trivial simplification to shorten the code a bit
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 5:26=E2=80=AFAM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
> ---
>  security/selinux/hooks.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e7a7dcab81db..337951fb81e0 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6693,14 +6693,10 @@ static int selinux_secid_to_secctx(u32 secid, str=
uct lsm_context *cp)
>         if (cp) {
>                 cp->id =3D LSM_ID_SELINUX;
>                 ret =3D security_sid_to_context(secid, &cp->context, &cp-=
>len);
> -               if (ret < 0)
> -                       return ret;
> -               return cp->len;
> +               return (ret < 0) ? ret : cp->len;
>         }
>         ret =3D security_sid_to_context(secid, NULL, &seclen);
> -       if (ret < 0)
> -               return ret;
> -       return seclen;
> +       return (ret < 0) ? ret : seclen;
>  }

I'm not sure we gain much with this patch, other than some undesirable
code churn.

--=20
paul-moore.com
