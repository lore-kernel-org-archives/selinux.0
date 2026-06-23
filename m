Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC023CDBD6
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228433; cv=pass; b=F+Iu/8cYx7BRxVJwmiAYVdroXDaeVHYa+T1kBf45YaQLSgwy5PvUl1J+VVyYJb5GNU5g+Fd10aIbnhOtag/XtOpqNunPRbJvsCvfPcQE58KtRTKnweAA84ngIUvUJfH2MkCqbEGhtc0WPaPnxZz7pQKU1AebF8E97YcLF93PAP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228433; c=relaxed/simple;
	bh=4PhCvuTG9plOF5M/VHPA6aAx/a82CyAG90GujRGELWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUaJC6F+/cANymwP6Q12OUfJaIULX768kysXDc/lmVn9i8QaCS++Nrc/3CeAojh+FArk9gXEmzcDR11EP9sOMeRsk2cboBUxjL86ZWYflI/2T9vWL2ejeIE/M7SWeJite/ohbrk4eh8X2KQl1nU4knPJqravCWDRBIhNsGbkrtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=El7cITWM; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El7cITWM"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-842358aaf36so36238b3a.2
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:27:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782228431; cv=none;
        d=google.com; s=arc-20240605;
        b=VGAZ67hJfvGtEJiXWJWjsh3O9WzBTXQmbSb9YCYadvuvXHB9+9ocvDEHG8Odo3ietn
         /Qz7UZtmRFc2pw6PlJ64TW2meH/+t8Ox9dcw7usoq4IASWuqzm8FbQkwL8MNgSvKdSvc
         W3GhposSNb8l5Flij3afuUYHyB/o4cHaTbrH4DA/U7IAkMGBnZxRjqzBmsnrEclkzJKq
         KcP4tzpSHQ3i/MpRjGG0JBtE6lFzLBrBHOYcmSHUHp2NJACFQjpVs+opb7ZVDE9wzHsj
         A8Iu4eh+z1/QnJrCf8nHIO5UppwB8T5rFOKyqGoS8wlusQvqE2kd2peNWTYSd/gqPVNU
         GKeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6qqz7VOm2+npE54UunjIyrBPPcjrx41pVoz2s+MeBKU=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=P+MEpcaBoJhDe6EvQgjK4BhMO9cfCfDDrJLwFXhsJEhSXWpMzfiPjxfIZCyCrYsgpY
         fNhzjmN7kaWRVfiU3ejMJlXtLPwewOw9J55DWIal6tjkD/YBio+w+Dk2HGx0eWgOPokO
         +Mah1MswgzheoI2HkDx5wrO34avDPJNxIyDmM60Gg5bnSDPA4KB6t9EJFwyxLG/Yo0Pf
         LU74wYzlidQBh8GipystWwl8tugnulbNL+59YhIkE2nFSP7qrEkEY8F/CWEiVGHmao91
         FBt9y12fm22bcSOKAWcrtStCY66kQwhjuPIeQasqtqeQa+wm6XUaq5GNknTeeTODCJ4h
         0bTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782228431; x=1782833231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qqz7VOm2+npE54UunjIyrBPPcjrx41pVoz2s+MeBKU=;
        b=El7cITWMovgGISIWGxM9Y7UFPdVopXMn+JFPwznJcBf324HG06ffS8c/hi7b5ytQ1Q
         9BtK8OZV1ZIhH7CwfDn31UVcKEGelFUOA+jJ6baBUjinbRo0V1ZmZmr+RnT7BbYurnqV
         GpKOLWCAWHmC33455x2hmT9owrTKlnzIFbG4U4eaqcq/2aH4sVPGbctMfYQItsIcvw2C
         mqRd5cfFdU4e/Bm1ncXLPIMqvpRwjk9f8MvqPa7Fk6Y9gS8YVEdbr8Ka9Dq9dqv50iRr
         pIefOQBgOYRi4r3HD6SSL7DpdtUhgrlZPLEJk9wOv481M/FEJppHskTlGkyWfan6WgQ4
         0pHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782228431; x=1782833231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6qqz7VOm2+npE54UunjIyrBPPcjrx41pVoz2s+MeBKU=;
        b=BKWDLXBGOdQiTOrtxcVhnHbcbaMEku/EjYFFLuHxpTnqrdbfcRATCA3vzPfhxaWZXZ
         Zs/V4vd0YiyaUw1OOxcFw8LnTQzgrQdJ9BllZYc9VfYRlL3fvcEmgFWWVZS5x7a2mHRZ
         vayysSEc4Fmdx22Q8sGDc2/wiehtJOBp0Fey/d7IR02ryksc8Tp8eU/EF2Vzzk4X8Umw
         +WTnvZbfAK5+Jnzt4jx4pkoxReZADiDkrKyjJucEggqWdEKq/x6YRpf2jFIO08xL6rqD
         /txVT/NoCQgQsvLC+Wy58Np3BhOObwTaSnKDhKbNa1c6kA4oBHYINxY/SK8iKZ0PZB/M
         kSVA==
X-Gm-Message-State: AOJu0YzWyNgEvdtHndU/da5nPecrUEZGtZo9lD3tmEQV6yihsbFrp2iY
	dDEiBVWoFgz+nLXu0s6V+ONoV9qh/CETV7SjQOBCinHTAf1aDlBu6iCrU0YZCDeBi5mmkGQxWXg
	STG/pKKv3e4SszdZlkV1mnSR+Gz6n/34=
X-Gm-Gg: AfdE7ckfSqGhwKXkFH36I/vVuGuVHRHHyFVPIwD0kVPonbNC99QOYyFSNvEfi4dw8no
	5s7oQqv9KE15/YzzUoTB8mUfET3lX6f1W/i/B06iaWTgsxjfiTNqP7OJSHBWukZpG9hNsIwUL3K
	QV+c/hvBqAC6Unym4xLxvP5QJDGlUtuWUvcCR0mUZFI3rGZJH833nBsM3cvT7UyPUGSVl7mtAWF
	0KjvtIm1Xjf8LtYmf9NTQqOt4m7Q+7NZJPC3b8Ez4QWlyLGRNF7DLI/Dzf8ENkK/4PoYB8q
X-Received: by 2002:a05:6a00:889:b0:842:5e68:a56b with SMTP id
 d2e1a72fcca58-845970ed5d5mr3498533b3a.26.1782228431455; Tue, 23 Jun 2026
 08:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-16-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-16-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 11:27:00 -0400
X-Gm-Features: AVVi8CdRKRx4PWMhS4CC9bgBWJr3io7ULoCwWKCjs4W6M_fzdUrwm4W1s9HzHSU
Message-ID: <CAEjxPJ4_TSOb7T9umxM6nAY_gMCrwzzwa3sQAvPixLOwhc4N1w@mail.gmail.com>
Subject: Re: [PATCH 17/24] libselinux/audit2why: check allocations in
 audit2why load_booleans()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:43=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The callback dereferenced malloc()'s result without a NULL check and
> ignored strdup() failure. Bail out with -1 (which stops the iteration)
> so boolcnt only counts fully populated entries.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/audit2why.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> index 2275ffbd..268e9097 100644
> --- a/libselinux/src/audit2why.c
> +++ b/libselinux/src/audit2why.c
> @@ -49,10 +49,17 @@ static sidtab_t sidtab;
>  static int load_booleans(const sepol_bool_t *boolean,
>                          void *arg __attribute__((__unused__)))
>  {
> -       boollist[boolcnt] =3D malloc(sizeof(struct boolean_t));
> -       boollist[boolcnt]->name =3D strdup(sepol_bool_get_name(boolean));
> -       boollist[boolcnt]->active =3D sepol_bool_get_value(boolean);
> -       boolcnt++;
> +       struct boolean_t *b =3D malloc(sizeof(struct boolean_t));
> +
> +       if (!b)
> +               return -1;
> +       b->name =3D strdup(sepol_bool_get_name(boolean));
> +       if (!b->name) {
> +               free(b);
> +               return -1;
> +       }
> +       b->active =3D sepol_bool_get_value(boolean);
> +       boollist[boolcnt++] =3D b;
>         return 0;
>  }
>
> --
> 2.53.0
>
>
