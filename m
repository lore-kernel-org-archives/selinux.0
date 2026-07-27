Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34B13F65EA
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785175010; cv=pass; b=Sn0Y5WlDOXatP0q75oLY4pilnb6PwJtAuWPBQb/ItZZ5zqObV7BVPQem0Ioe7fyf+EFukq2LB1bvM2sdtWM90VuckoOYIPq8wFa/VmvXja0By3ZqTyhT4fDMFBRfSMDxlf06RXZkNK1pPrDhE6gk7dQNFnpYVqmsm3ohEv2g0qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785175010; c=relaxed/simple;
	bh=rvTWmnj/6HaC2Vud3lJnjeoLLb+8WkB91zKicJ0EzgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKJGDg9meFZ47yEFtThPTIPBsm5H8JyYgQL+3gb6V75qbxz2YkbkGM6ANjweX1fGjb4ct70duTjNwdfYa8YfQaVz4PeINUHH0an3hXm7bQrqq2kcDfr81WIiVptDgPc053ys2tjsQJ+f2Nr/NbwI09Z8eF8QkHbXLmrzsPjGw34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+7og7k6; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+7og7k6"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-497d6c2d000so1711809b6e.0
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 10:56:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785174997; cv=none;
        d=google.com; s=arc-20260327;
        b=VaJ0jdudPFPynCyHsLlrmw5nulo3ELUsOnjMZY7BP3iO4Na9Ga90OBwZDvswNxEHWM
         fsIuGKJPsIFb7qDTGOQ4WyauTpqbCuRR2lPyxh2EhY2hzOWNYqa4SzniW8Ruty9rsxzZ
         OyhS90QT0LHphGg5Oe70IWDYEMv0W/hrFh+v+xH6NYqeZY7Kgm8CSJ6NGrH2VffN/Eeq
         0tGzkr7GHpQD5CwVYHJnZHuPN0/GPNKjPwcSavTYWnAQCJ5rkbdMMVlDBRYn/JxtCk2m
         JPA7tohtkbR8MUs3PgCj/l0ysM4n44z6Cdz5BvIwNmeowxjGn1SuOn5JgM/vM4sD0ERh
         llAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a3s4ZR/U3o1ycWpkBxBOesXjYTbwVM79mr0w5wEQMX4=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=mvUtiZX1kNukrcyjRjHP0iIT7Yavg67KEWr2zWJZn/FxLvzlF3axtngkGGOVyz8o33
         iA/40qlut0Fa2IwL6CCR6eNgYb1aw08LJXZxXf7WUtnAFjRPABBlNLdqlo0uWjEEzYKf
         vxhyMDmjD2xkf11QP9EAdHg2jA4TsuDMpavOsE5284QnTNOT+arFqyk++QXJZDrMjxZs
         c6esVD1cG4lSDKgFMZygGjzPNHgYf75pKYR4NSuMG5b6zDgsN1jm3l/mC3C5SVBpab4i
         qLDVlP9UGdpzsv4IoIgY+Lm6NjYZOnsnTIr5Y2IhXWXLXgztdAFrLBr8so+dUdOzkn4c
         PmaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785174997; x=1785779797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a3s4ZR/U3o1ycWpkBxBOesXjYTbwVM79mr0w5wEQMX4=;
        b=V+7og7k684xgQfQRg6jDuw5MMNwbhMrBsmZHQoEmloW7I8u87MrrpE0HRcZ8WTzk+i
         98B7n46fI3HY6jJwRu/9eUPXM9qXE4yjBfo6BfOsgo/IWy1Ch4LQzCHKQkmxTmwRjqWH
         XjcNH4VeDurdur2pnXv0phYbkqC1CT8axtADATdyuSGZ8dPJqi9eyHc3lCgy6JQ8fHRx
         E5rKAeTBptaTzHFMD9Eo6D3oGJqPqo031GrSREsBu/XHVV6rdb4NvPNmRXE9pZF2K/C8
         7CVTShaZsFBfE0S3Od5yCszURa0I1sgGXaf51NFy47ptmXxHxFH0vPjUGCSBEcUciYnH
         VXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785174997; x=1785779797;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a3s4ZR/U3o1ycWpkBxBOesXjYTbwVM79mr0w5wEQMX4=;
        b=rcfB+6xzPNu2EZPKCc5tFmbK6Sh1zbQx/6Sp0gH0CaIRXerfzws2iBWkfRrKl+56Cu
         diCevxh8ZcP76Id1XeHjOSKYKzWDMFm5/HCzQ9XDIQelJDBaOGMIzdaCRkHzn6hXpauC
         YPzmhn1IYLbJ/GdYcmontP9OCjRctdo6RIDqDpVRGdcuKA0S0utU4QIl7N3vr68ZUmrr
         TH08d5mr/MHhjuxb8OTyJnDuSwKXCTc2ghj41VYC7jPUbDt34C3PUhVSTBvm28mG2m5H
         oQMhBxxm8RpPTN4VEjDeAUBzsWUadXijri2SyvIADMMMNgr6HkKeAQRoCGJnTi/3q1Sp
         DCwA==
X-Gm-Message-State: AOJu0YzVyRp0lbBid3R8XfezPs5Y7jA/1Epoa9OMTXKthAoqoillqnKY
	V4W1ZJjRJwDmURWOqsix6ULD1man+upC9tOj1dKM8eJvZANZDt5T3zbcs/7BXcfD1nw7cjIs7ob
	/+ifixqAUXytrPW847Gxvt8mfwVEL5yg=
X-Gm-Gg: AR+sD11XkG8AMfpz5heYvipslHPd03P5jlpV6wFfq/9rJTevKZFHMqsOhUig1qoDd8s
	jqsbsfg9SYkkC2mW3IOR2R7qCmKHaVwdlnk0bkjotAYjUoy2l805H+a8lqbw48Tj41sx5r38PUz
	KEG2fhpCOjaikSlvWwUcPRDuhpm4g2sTP8nz9e/cAKc7qJT3himC4card7FGiU9hkC/iCTVbkpM
	witTRrIRrbkZ+CGPg/Ae4hkeQeKecOcrF1ACUHQkGIzvnCTtdHtc7A0ymR2NQ==
X-Received: by 2002:a05:6808:198d:b0:4a3:cf5a:d18c with SMTP id
 5614622812f47-4ad55c2242bmr330909b6e.33.1785174997481; Mon, 27 Jul 2026
 10:56:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727173854.10810-1-jwcart2@gmail.com>
In-Reply-To: <20260727173854.10810-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Jul 2026 13:56:26 -0400
X-Gm-Features: AUfX_mwdEet0BnAS7W0CMV5DyC4TUj6mkdXZioAHbd7sb_LoYoGbDwRU-Ray2TA
Message-ID: <CAEjxPJ4AxjisR+VCNhS7mLCFmBOZhiWV4opHTtVmu1OD0ZLYug@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Return SEPOL_ERR on failure to set bit
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 1:39=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The functions cil_typepermissive_to_policydb() and
> cil_typeneveraudit_to_policydb() return rc when ebitmap_set_bit()
> fails, but the rc value at the point is SEPOL_OK.
>
> Return SEPOL_ERR instead of rc when ebitmap_set_bit() fails.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsepol/cil/src/cil_binary.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index caf2d987..7ec3e781 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -614,7 +614,7 @@ int cil_typepermissive_to_policydb(policydb_t *pdb,
>                 return rc;
>
>         if (ebitmap_set_bit(&pdb->permissive_map, sepol_type->s.value, 1)=
) {
> -               return rc;
> +               return SEPOL_ERR;
>         }
>
>         return SEPOL_OK;
> @@ -632,7 +632,7 @@ int cil_typeneveraudit_to_policydb(policydb_t *pdb,
>                 return rc;
>
>         if (ebitmap_set_bit(&pdb->neveraudit_map, sepol_type->s.value, 1)=
) {
> -               return rc;
> +               return SEPOL_ERR;
>         }
>
>         return SEPOL_OK;
> --
> 2.55.0
>
