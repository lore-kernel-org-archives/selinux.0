Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5470226057E
	for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 23:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599606; cv=none; b=nwscG9UAsC/ZadcgxfD8yY3EdFEZDY7yeBTHRK1+EOfOrdfAsEo7ehc3VXU7zDOJsqeBs+EsqZFpFs+xz4/0b8RmlYeeH0hZsZ+hv8oyYD7WDEBWq/NRqAGsEehVoR1cX0YF1+pN88FJ4ikER1doYzUHjVF927BBPj9TMxFeZW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599606; c=relaxed/simple;
	bh=sxWXA5uGPNOakSmmsXJxqvZ1AfSHsirhjr+o/Q6qAFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibyBNiaIGlvvJLVavth8os4LIbWpAMuUkvD/oyBKvG73sPnzLfJnmuT7/Fvt9Fg+7I1jID0UsAAhFcXh5M8vkmEk6dhbyqrlJJHLCd5KpcPt6bFD+C0NjDGB8geVCf2pRrVvDpZ+5zuf4ro18PE1FvU9Ar+Ffvto+QbRFxmtrDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HHAIRY21; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HHAIRY21"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e7b3410e122so5575715276.2
        for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 16:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749599604; x=1750204404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/v4Wb5GMuxS4FHeL1ScHmZve27WdU2EnRkCwUrcQK9o=;
        b=HHAIRY21riO/VoEzK/TgeeeNZN8vv47ZRSN58nKYos2sSMUKveQEiVKcworJx7cu1S
         wnGg3v/YgjVejUl5twUYb6IkMviOgZU2uUH6mnwhWcFqJNnDeJf+04LmAka7mQlzGwaz
         RPbaHZ0+Y+nRIC8dx2wH+3zDyddOqFI/7VtajMpkqnCcisDQ9AfUDiEFNY44ImYoPdie
         am3VQZ9GZyMoa4Vs2Yr0Waf/5da+QjlBlpe046NN/cjm11aUA1dWmsmzlapkk+5+HFKk
         5O7LlHbFBY4WZYUQUTR5OUH11wrfwHtl54bQ6s2DhwoiEs8Zm3lSnoIPaQ3OLqBGelui
         q89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749599604; x=1750204404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/v4Wb5GMuxS4FHeL1ScHmZve27WdU2EnRkCwUrcQK9o=;
        b=P4c5VWLj2+RV/VSLdtT7fLSiKS7DAN0sq/sFP9pAoguceYnC9M3TYFUgocI5eJxhe7
         fIN73N1uD0mItbP83YYuzUL3cuk8ERjRtSqp8qSNbl37tTkadoSAo9U/pHNCNShGnfzg
         b3dKZV8Oy4DZx4lNqTXXnaux6gsPI1gMvmoxY8yQEQdBGBYcV5sCsIv7cwIDX35ed/Gg
         UA9BHm1vGj/DSwDUVoRnYxmq6JaNtYSjlNdozRBLJjrqYae0tW1yhUGyP46j3zzI/Re2
         qzfAT9GxQm7UabVrjHWjRf/Ol0oq1haUHL0sJSqOwiXxV6f+bLvyMCEBy3CLr16WOyHn
         xNdQ==
X-Gm-Message-State: AOJu0YwseZH8p8pteWE4lv9alRZkI5xrmx1t/NFmPRMcNH/kjH1GMWkL
	mXyHvqCy2eQdOzUvlEiahdnMDpUgNqBNHCIZVFJ1wj1cfNYXS/FEUT3J17dr6FyGVbX3MjJOiRV
	CHmomVjSeL0AGbzhDtDSNEWuO/lvjM16FZnaPBeGh0vngsIKUKEI=
X-Gm-Gg: ASbGnctjEzlDg2WG/8AAWAfe8Nb6/DdnHEmyDDihDCnvK6CM/AnUaK7P80kKBezuHKf
	x5fwepoKv+TPRr5sQSzMV+c7MU72eaT3glh7nkcleBg3cxU6ocimanypfhtlyhYlo1pvYkSNGMv
	vk/U3cnUEBbhd3YrWZBq5aSE7uVRKbvdQt0j5dEukxT9o=
X-Google-Smtp-Source: AGHT+IEnq9+6Hn6NbplG0mbC+8eQQQBZJ3jkOCjiZI1YeONNSUb3Aq8vv1fbgmCwmE5pBBujlPIjNH8nCqfNpQAGPFM=
X-Received: by 2002:a05:6902:2682:b0:e81:891e:9628 with SMTP id
 3f1490d57ef6-e81fd9ae73bmr2280722276.10.1749599604230; Tue, 10 Jun 2025
 16:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610194826.80606-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250610194826.80606-2-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Jun 2025 19:53:13 -0400
X-Gm-Features: AX0GCFsdALQSNVyq8q0YMUf0o7F_VHKd6e3H0NKu_Gs81EjFSirK-KPTThgXulE
Message-ID: <CAHC9VhRcSO3sJrc8LVHNNsiEGhe0jhJMAfOVu=wP9MPrAPCx7g@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: change security_compute_sid to return the
 ssid or tsid on match
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com, 
	Guido Trentalancia <guido@trentalancia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 3:49=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> If the end result of a security_compute_sid() computation matches the
> ssid or tsid, return that SID rather than looking it up again. This
> avoids the problem of multiple initial SIDs that map to the same
> context.
>
> Reported-by: Guido Trentalancia <guido@trentalancia.com>
> Fixes: ae254858ce07 ("selinux: introduce an initial SID for early boot pr=
ocesses")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 fixes a compiler error.
>
>  security/selinux/ss/services.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Assuming we can get a tested-by from Guido, I believe I like this
approach the best.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 7becf3808818..d185754c2786 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1909,11 +1909,17 @@ static int security_compute_sid(u32 ssid,
>                         goto out_unlock;
>         }
>         /* Obtain the sid for the context. */
> -       rc =3D sidtab_context_to_sid(sidtab, &newcontext, out_sid);
> -       if (rc =3D=3D -ESTALE) {
> -               rcu_read_unlock();
> -               context_destroy(&newcontext);
> -               goto retry;
> +       if (context_equal(scontext, &newcontext))
> +               *out_sid =3D ssid;
> +       else if (context_equal(tcontext, &newcontext))
> +               *out_sid =3D tsid;
> +       else {
> +               rc =3D sidtab_context_to_sid(sidtab, &newcontext, out_sid=
);
> +               if (rc =3D=3D -ESTALE) {
> +                       rcu_read_unlock();
> +                       context_destroy(&newcontext);
> +                       goto retry;
> +               }
>         }
>  out_unlock:
>         rcu_read_unlock();
> --
> 2.49.0

--=20
paul-moore.com
