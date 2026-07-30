Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7545242A14D
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414339; cv=pass; b=VmHGYXT29LtB17q8lVbENs1+EsDIe6HHXfhm5UqLwGZtxZGjv6jfucNsStsHH+Fuf2dzQuhqUzwtCli52ARdBavxixnmyZVfnZSK3gU2jj2WlM9/wRlSZu9qLY+EAxDi+0j1HofRwyWNSGhjdgdWOIUNckKqbYNSCT6r9LcgAwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414339; c=relaxed/simple;
	bh=+u4PSXWnQMBc6V1mLArUtNrtp9pcRIebquopTbBtvt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aiAoootk69nUsgqgu4e6PfBQedk8Y0y06eAq0Lx8lIqhhFJFS86BOFgfOVxK58kXFs53UhTojQXeG9TZEWcjQ9ncY8KZSPCj4q+9MdNolVMv9W801wTuiRTq09/pCEX7DZKPwZEeQTNAbYOAjOp9WpFyaKPHYmnNAgQHuG9r328=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGqwHmvZ; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGqwHmvZ"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b015b2d792so2079398e87.3
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 05:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785414335; cv=none;
        d=google.com; s=arc-20260327;
        b=atlICxGoe9FIMtgIbA2fN69famiHvD+CjgyNonWUDqQOxWYAl3VxTs6J2JNJn8mu0Y
         owQqa2Z2/StKCRCUaB+dW0ng/VtMIaje1mtMs97Uyz1uHGcrNYPs4hW0ui9m9TxnFPXY
         j7NE+U2KrnmqsSTFiN7SjnCcN0oZa76u8kcEChPUmLckWirA2z4+moZyWOMozmEEsKLm
         9tOcfa1MGZTUiZlJM+tJQa86MUcUDGMjBzGP+r2i2GcZSgj2BnS71jM0uYkTHEzNkLkg
         p7uNCLqz5qZ86H7sVEVVp4n8eJydr56eP35yhm5h+6YACdHqDCij4YJti0oWM8Gdk1Ws
         oeZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+iG5mkPVpw70TtFs9lDAi95WI0NF2OO96DIxssEyE1g=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=mkRCvEzmr+vNTAR6sMct6lM87FGRSunAVQcnoIHsnbXcp/G1RoeLEmDFMlCHQdOQyC
         Zs3yRbJ4mWoar+zQbisTEwpZHC0hb1pp8/4MLiVVgfrKB38BXskwTNe+KTsZUm+YAUoa
         osbBk74cgotuQ71cyUujgU+ehCyTfWYhHnop4Mm2ucMRz1Zl1mMYSsZ1hHDNtvJ1B4hu
         qwz9jV2lgGcHowzKXjnXbYZQq4CwI2VMiPIKeJpmnVcRrF6q2P3t6uCOHnW48NCJuZRp
         fLoQsHXxX1DDz0Ek72rPOJ7fPTHCvMRIwLxSU26iHWKvFWCZKdU6axO2OtpeIQG+iwMX
         pR7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785414335; x=1786019135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+iG5mkPVpw70TtFs9lDAi95WI0NF2OO96DIxssEyE1g=;
        b=FGqwHmvZH1LkyXLQanSJmz1cc5w2ULfB0ktAbRArD0WfE645w2BEDhdp3/v2miSehF
         ZEOFOvqqp5cbCG5iLNYzrw8HPIpqO5AblOwiiE754wxkWSdEG0UtlNXu0y84u/KTAbfi
         pyoEB2UGV7iL5ZZmNRy3RZM9IyhzaSwHk/inmOuoILNEiRT0orNM3OkFMlnUROjSasjg
         G88keUKBlc8d9CRrwuMCWS9UIdyoMSR2Q7engVvLlkXJVA4NA7D+oYEWMyHbFv4hXv1e
         JKWXXEt44dTCWDGlUITQ33h/NdWpXbpDkbnW2C9U3MKvCi0+uq96BR0Q2g5TaMmYQ2GX
         /Cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785414335; x=1786019135;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+iG5mkPVpw70TtFs9lDAi95WI0NF2OO96DIxssEyE1g=;
        b=qo7xT5M7PLXw6bUL0dBY5G6ut6bKq8A7lFGBMIVxr1nMdBeWn3wZf2oeSpUPDywinR
         L3ZIEZxyMDER6tgNV4kBTQi2xBJ7uFKKUE67E7hU1gF8La5T9ZnmIA6aDMkvEwky7cFj
         GBg/eMvqa8ZPOQd6Uc+R6h4OTJ3F+ok2KdpWARMy+J8it5Kymzaiffn2bksyV3qDHwdM
         2vjnPHI/jbY4QhAwx96bnDt79LKUa8MrFM3myFWF/ESKGurT/Q1dst1sPhAeK8HlMOCX
         uTGq4k6bEiXcMGX4CyVnX4FPCwO14cxZL6YyM9pIT1uLaqFUUGjDvFTizpG7c1UXlGAs
         VN8Q==
X-Gm-Message-State: AOJu0YxsF/AYSZaOaEAtasweNJIJRcdh39xjFkc9872znI1kwczfKagq
	LL+4vZ4ioysYwG2+nmM3joDi9c/mtkrMPyIhfxtETFHLrN0GXecMGDvv4aZMzK/G4db1qcY1GM+
	q0UkZmPCkHtxeTFmdtWjeiuLRhVGKVSE=
X-Gm-Gg: AR+sD12+xoAh6FiTLLvkwBydOrXgtH0awoAOwwpcbJa9sIMGI4y7qR4VqNEsKe8NzYS
	YapvBwCnrZJdxDa04yIfR2En0gR6G9kTsPa1gjgp7+z0Kqunsp8Va6QISFvRlCLBOZLsKMYJrmi
	kpZ5/jGVfGEN+d/AHYf5zBkWsnu8yzjXBnGDrHMdR0k6QPA/tpgp0VrQeb0Pje3vuBwoiNqxDwU
	IKnQrXRwvrqF8jsQyqruxEnBusnuC6foxKHnn6CYwUYzmORDQ0el8nL++pAdlfGcM5rBVNIdtqn
	yolHSVbwIDoMLBm45ecXyjChGT1QzQnBCUZWKjIj3Q==
X-Received: by 2002:a05:6512:669a:10b0:5b1:568d:971 with SMTP id
 2adb3069b0e04-5b2db37f0a3mr292396e87.49.1785414334882; Thu, 30 Jul 2026
 05:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729193713.23187-1-jwcart2@gmail.com> <CAEjxPJ6J=ArpCwLAaCed7Gn2K4nDJODLcSwZ5orJT7zw4HyiQg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6J=ArpCwLAaCed7Gn2K4nDJODLcSwZ5orJT7zw4HyiQg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 30 Jul 2026 08:25:22 -0400
X-Gm-Features: AUfX_mx3KIbsCUWoVLuQsub-tSJ12RhUsykwqrhfzkG8G_UMGMxZtGhXLMswCP0
Message-ID: <CAP+JOzSQibGghmGu8bDdxXiGO5zR9DXW2nLZNwUc594tCvVD0A@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Turn assert into error in type_set_expand()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 4:00=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jul 29, 2026 at 3:37=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > The assertion in function type_set_expand() can only be violated by
> > a malformed policy. Since it is called before the policy has been
> > validated just return an error.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/src/expand.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > index 8d7fe519..19b5fdcc 100644
> > --- a/libsepol/src/expand.c
> > +++ b/libsepol/src/expand.c
> > @@ -2827,8 +2827,8 @@ int type_set_expand(type_set_t *set, ebitmap_t *t=
, policydb_t *p,
> >                 for (i =3D 0; i < p->p_types.nprim; i++) {
> >                         if (p->type_val_to_struct[i] &&
> >                             p->type_val_to_struct[i]->flavor =3D=3D TYP=
E_ATTRIB) {
> > -                               assert(!ebitmap_get_bit(t, i));
> > -                               continue;
> > +                               if (ebitmap_get_bit(t, i))
> > +                                       goto err_neg;
>
> Why did you drop the continue; in the non-error path?

That was a mistake. I'll send out a correction.
Jim

>
> >                         }
> >                         if (ebitmap_get_bit(t, i)) {
> >                                 if (ebitmap_set_bit(t, i, 0))
> > --
> > 2.55.0
> >
