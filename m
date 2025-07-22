Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC661DE4DB
	for <selinux@vger.kernel.org>; Tue, 22 Jul 2025 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189568; cv=none; b=uHKqIqIPPdpmhjfRSAlIgm9/qcvOEXkD+ktNZf4UN08tCFStgvh7/x6iqB+Wkq/jq+UTUBB6xOcW8BIR1cUI5nLtRWWM3Y+iMZSCicv/HLIK171ULfLnazKfBrUD7nlCeG9iqXCBKOEGOXCab5PyOa3EtMy6GE3sli80IsjogDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189568; c=relaxed/simple;
	bh=iVnmglkuzUyyqLsYL+Eh2W6aHEVCyf5qb2tESUBOr+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8aMh14MOeM8s2y03F86MnPlBVwfQnEwhNPXPhTBzkAND7Ti2pu8rEUA62sjX1h8aDcA7eTfI91M9lpia7Mz7WOXCKL+Df90RQBwguhqKUXvVF7DpA4JY2r/di5eiWFYv/Qz8mnmv5CI1OmKjUmfEnS4GhyGA8ScheeFo+YJE/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMBIsrCH; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMBIsrCH"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-315f6b20cf9so5721011a91.2
        for <selinux@vger.kernel.org>; Tue, 22 Jul 2025 06:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753189565; x=1753794365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAaRB39mUicWg+5cGIMZnLtgD6ora0mCHE4TtXlryro=;
        b=EMBIsrCHbX7wTYm62hcnTjZSCWTWefOv9tcoYS533DCSl+nAPvmQh0RdmfiTiXNJvB
         pNJKXz0WQ4tvweNoLPdDs/au/yD/TOp1sWKrx6zi3dDUU1Lp+3wR357Ib65071Yhml39
         YJp1bJHeFwZyB4C97sfneYf+qYmDqUKAI2gFJj8EIvgsqYLppz4njDRTHyEmgEw5f3wQ
         I59Aza5o2vNetmqe3/cisFM1j06Qjx3XUWWEGilzklxPLEnjiOZOnkAcJc+tjHkLpevH
         i48Crdni+HG2+JozUSrlK2Yow1HzMEbUrR4A5C7mkcFBR+yF9U26ZLxyoRtB1M+/Bu/h
         TXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753189565; x=1753794365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAaRB39mUicWg+5cGIMZnLtgD6ora0mCHE4TtXlryro=;
        b=P3EoaOwsGfh5Lw/WN5l6L9zCFiXh0eSwLK1iViQ+2KJPqwD6sOIZXABuUD4w/PPZNq
         /3HFo1ZcCncEPLU0UxVfU0KAXKiuO+h0/6K++IeSIACvIVIjSZRGH5w7hAFBOKZlbJQu
         19sk/Ekv4X3Y6Xmz8Y5XCzYZd4WivDveGqlLjbcURyHo3o6blic/sm+MSa9G4X198sm6
         LEkI5zh7saj/3Oiqkcg9U0buAeNYJLBBRq4KfzGaiqcG7NQaKTXbKQXtIyPkMIeTugEN
         OfJw9PKNQQSjeZMJtPJAZSH9WQp65bCnQ8A/c3k2Im4Ydu5VsMqXKNIT76ffERENE4cK
         Svvw==
X-Forwarded-Encrypted: i=1; AJvYcCWrEyZBOLTNoWcIF+VaFjewcObZo0A4maVvz34D04KYmxinYuQk1j5O0L7FXJy0orxvj2Eibja+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+neklOjr4vVWXxOCzbXdFaW1radjDacN5FbBokxDz5DYadVzf
	yheY4gOmf3PQH0EHmZrZWIFYenXoDtlubIIV9VbibGyv1JCecbY8Y4bUzWw6FrZRELNmG1ZtSO1
	UpBFssrFO3j0+uvsRP3oUdy0Gf74FSHk=
X-Gm-Gg: ASbGncttWbzvVl0l2qO8WvdvEFHG2X8Mk6fbmVB8E898GslY8nD//QofPJWdt1GWW75
	TPjX7OkrIKhvWJxXNwT+VlSR/BvXTLgk/Qr/nLSSXQm4/WhomOMZJyrtE0gOpzG7QRPrn1uUVII
	nQ2v7kvq3/uSN7uP56mlsyugBKmYvtK3OetOHn+YD6bAPAw9GPAwILCt17i4noYPM6+3e1F2D/9
	6JPvco=
X-Google-Smtp-Source: AGHT+IHJkqfCbj2FvyLn6HvrdpoATeXz5srGR0isUnp+b4ihWMpRuZFGoG5f2jlQ6NL4yRTdrz7NgqBca6iRM6BHNaA=
X-Received: by 2002:a17:90b:134f:b0:312:639:a064 with SMTP id
 98e67ed59e1d1-31c9f43748bmr35576384a91.28.1753189564882; Tue, 22 Jul 2025
 06:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ5M76PFEMghyCWPsJW27rNA6A4yxhFydGoWWDW0Eybqfw@mail.gmail.com>
 <DBICEHLQ2KYS.2WJEMIZAPCJCG@gmail.com>
In-Reply-To: <DBICEHLQ2KYS.2WJEMIZAPCJCG@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 22 Jul 2025 09:05:52 -0400
X-Gm-Features: Ac12FXxdSA7XtLb3GU490Bz73vWQiwbuZ9EMQ9UKEx6b9Kvf2ZnxuXzx7z8GX1w
Message-ID: <CAEjxPJ4CqG0_ORke4nyDM8w8w3-vW8DEvkkSFhRhYL_13Rrpiw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix parsing of the enforcing kernel cmdline parameter
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: omosnace@redhat.com, paul@paul-moore.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 1:42=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> Hi Stephen,
>
> > We should make it match the kernel's logic for parsing and handling
> > enforcing=3D on the cmdline. For reference, the kernel does this:
> >
> > static int __init enforcing_setup(char *str)
> > {
> >        unsigned long enforcing;
> >        if (!kstrtoul(str, 0, &enforcing))
> >                selinux_enforcing_boot =3D enforcing ? 1 : 0;
> >        return 1;
> > }
> > __setup("enforcing=3D", enforcing_setup);
>
> Okay, seems reasonable, I'll send a v2 to follow that logic shortly.
>
> > And the kernel's parser ignores anything after a "--", passing
> > anything after that to the init process.
>
> Just to clarify, unless I'm missing anything I don't see any need for
> us to worry about that as:
>
> 1. Based on the logic above it would seem 'enforcing=3D' is recognised by
>    the kernel?
> 2. We're reading /proc/cmdline anyway, so I don't see a reason for that
>    to be a concern - we're going to see all arguments as far as I can
>    tell.

Yes, I believe you are correct.

> Although, I'm a bit confused about CONFIG_SECURITY_SELINUX_DEVELOP, how
> are we handling that in libselinux? I don't think that stops userspace
> from loading in permissive mode, and even with:
>
> #define selinux_enforcing_boot 1
>
> I don't see how that would stop libselinux from loading in permissive.

I'm not aware of any Linux or Android distribution that disables
CONFIG_SECURITY_SELINUX_DEVELOP itself, although Samsung disables
permissive mode another way. That said, I agree that libselinux should
handle it correctly. If I am reading it correctly, if one boots with
enforcing=3D0 on the kernel cmdline and
CONFIG_SECURITY_SELINUX_DEVELOP=3Dn, then selinux_init_load_policy()
will set *enforce to 0, get the current enforcing status from the
kernel via security_getenforce(), see that it differs from *enforce,
call security_setenforce(*enforce), which will fail, and then fall
through to loading the policy. So the system will come up enforcing
with a policy loaded, which is correct. The only seeming bug here is
that *enforce will be left as 0, which could confuse the caller, but
it appears to be only used to determine how to handle errors from the
policy load, so a failed policy load might not halt the system. So
that should be fixed too to set *enforce to the value returned by
security_getenforce() in that situation.


>
> Regards,
> Rahul
