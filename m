Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A74246772
	for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749579418; cv=none; b=RJ5Y2uU4k34TOmnqvZAa8agVVJ/Jwi31AEurCKIzxfGeizWhwUOXyeieReOV14/fXgPyTbPdjImlRgCx/hVrcMs/wuXH2TrlR3RFJcrKyFYw/V2Xr6Z4MGGBwVaSnjLJl06Pcsbr+eobXnigzbWVqHvZpv/mbGDuq8ER/OaZVG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749579418; c=relaxed/simple;
	bh=H6BomDrUV0OG+VQOnsj3NanlIiwa+2meGZUbmyXsack=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFOo+C3bn4kja7snWrTedgy42G2TQGtYIgHrWyr0beuHCdEDH0b0Eb7x/MRUW5lWT9w9kNM82bWVNup4nk6+fJCmPHjpq8sCehFLDSKE3N7fqTDsAVnG0fBvbdfas/r0jt87w6uqvWXJKOREFaR+T7ZOtIrRZX152HCbAlEs/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKkS4WgS; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKkS4WgS"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso4228248a91.2
        for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749579416; x=1750184216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2Gp1tfyzEifqZORK3kACHgP3/vet2aIIDFIxo1IcR0=;
        b=UKkS4WgSV4IfkTEqqz513kixzdsNE44Uunyf2TAmBnRPzNzeWWDOndt2BGHhTU2mLA
         vDzSyGMke8+o/QXhOpSk0K94Dm6imVLrM46CnnVKM70nulwwDDdyjHv1FaAMKs4bOp4c
         2BCnZ5tYXuAp6iX+tESPIy6sXR2B67RHqHFb8NWuNh6MULrLSQSUwoDfCpa8i7LofsR4
         YT9Q9JWzkwNTZxUlZl9bFIFdrUeTmPOnz7trSzcjaUzwsB8RgBb61rM8lzi6evyRdckF
         +mt5eGuHL9pAlDNs+ygmU6r0XIZ1wcSBVeMpxudiJZEM6yts1ePL6mxCWUprtuU1giHO
         qCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749579416; x=1750184216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2Gp1tfyzEifqZORK3kACHgP3/vet2aIIDFIxo1IcR0=;
        b=cqPcy4aGj5bYRs/i6NXGx9r4x6ibGdTtkAgBnLpnDgdJo4SxpiW93V+XD4uQOLaM7C
         09+UaZrYw9vDMXPLLPX9xcC9oLohg/YRKjFwW7o8CnK9FDDx9tZUU/MusRGj/+w5cXf7
         tvymxQW90bWTqlrFUKKk5qMfKeZtZVMwcs95cAT7LOQ2kWIXJTkZywQzzBH5/sqf4zy/
         ld00jwCZdeqZRwsTZpsKyA5FKtd/LWK2WHVTA4BxZ3gyeFn/5ctOm4C/wHPHoMO99ixx
         EPQgYatHevhbnZtrrSiTUtfw/ebU6E37uJ1PvJHqNiBVNuZ6XEx42U7r5Fn2WVY4xrB9
         C+/g==
X-Gm-Message-State: AOJu0Yz+xWL9xc63u30VngF9oXGl8u2a/i8dHAylji3GzcxaTcx0Rs3M
	mceXomvtZ3DRbQ0n5ASO8kR8gXcRlW3WSvd/A8GuatiBzwccpR7aBWIzQyUhBS8Et8lcVlkFDS0
	fGUoGnBUPtcsD+9vX7v9LfYasT35rJ4564A==
X-Gm-Gg: ASbGncsqiuKXHt91vNTmaiK33VKIqHni/YHDT3FhkFUnzJRbs+3run69WNvZU36V26g
	2s1GFnnMKO+MeUHpaqchRjD0+D7lOGN14UCisgSROdHc1pQC8V6+Tv495F+YaV33vppr8z8od61
	GsdjOQ1yVPhoWUzzX54g0Iaf/wUB7RhGon6GCAhqZ9pZyOFmlV+eqX4A==
X-Google-Smtp-Source: AGHT+IGxuEoT8nLSy+YErkZXDZjDL/7uSbZfW9FmhBBYxbtCABEAXQUcSMj+Eik3sGNw4NhvAd6yTgT30M1pkCtV2Yc=
X-Received: by 2002:a17:90b:5289:b0:312:1508:fb4d with SMTP id
 98e67ed59e1d1-313af225653mr861145a91.33.1749579416249; Tue, 10 Jun 2025
 11:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610181413.30851-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20250610181413.30851-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 10 Jun 2025 14:16:44 -0400
X-Gm-Features: AX0GCFu8BIELRHvDlsZ9c9wzd5Z4ajA-B5LLry8cSsyDKWS_-QD75W0zxO8pdmA
Message-ID: <CAEjxPJ5S5QmJV+NW89hqEdOykQoLwm40qPpeYE3HwngWA-+bdw@mail.gmail.com>
Subject: Re: [PATCH] selinux: change security_compute_sid to return the ssid
 or tsid on match
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com, 
	Guido Trentalancia <guido@trentalancia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 2:14=E2=80=AFPM Stephen Smalley
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

NB I didn't test this yet, so wait at least until Guido confirms that
it fixes the problem.
This seems simpler and better to me than the other proposed patches,
but others may differ.

> ---
>  security/selinux/ss/services.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 7becf3808818..8a8a3fe9a33c 100644
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
> +       if (context_equal(scontext, newcontext))
> +               *out_sid =3D ssid;
> +       else if (context_equal(tcontext, newcontext))
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
>
