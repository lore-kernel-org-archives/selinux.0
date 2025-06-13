Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46191BEF8C;
	Fri, 13 Jun 2025 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749838655; cv=none; b=LaSHvJjOx0fJ92lBtZttE37G0zkSZ7Fq+blpaAkJ4fA2Gw0eMU+NczFKy03STKHyeJHLeVm3NNzjc/JbQRcagJi7RSaIrJ8uqYYz722D6vy/Qkcf3TGuUaSwpyWK75t6P6kGhEJmcEXFjXY19QceKDpjx5PF8d+5Q0ZaXgswph8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749838655; c=relaxed/simple;
	bh=0KNFfV7fownHanKtx8R1SlNU8ay1zo8lxKLpV/jp8m8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5Uf54yUFnFyZ2ZivBYCyyDCe4P/TjCJ1bhtdz2xGlAWqDA2B6pfQdEfmPX1yvHMZTNYHbovcW5nX6YOvItvtg3oZ5pEkXe2x1v4Ai6eJ8FB8pddatpYHawlXAoTaIBZ34Sbi6aaf0wQtn/A213Z8kq4uh1A6akqgKucbPoPyAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UP4xH+Y1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UP4xH+Y1"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-311a6236effso2160119a91.2;
        Fri, 13 Jun 2025 11:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749838653; x=1750443453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lj2XCdyseFAs5Xtxg2sKE50AyX6wcQu4qy75UBvv3Iw=;
        b=UP4xH+Y187Thk7ah9avSmIHT0ZHlnOOmWG7aypCeBItjKzrM306KmmEcErAsMgTapN
         T4q4R7e93EMeHNKfxGf8UCPnZdaKFTWd0qDY7dFfHXZNuX/I+sBlf9xQvOTkjDVENVl7
         0RnJY4XlGT8ElKlF3JrsqJ5UefosSs5I2led7daw4SEbDjGeAfYJTW0oTWk+gYUylso7
         GsU5+EUtFtvQVbu2dspuJqOmOxy7zul3yitkupzmgzJAygiDvuhH7kI2feR47MaQr0jx
         maNN9Y3Emi1Bk5HjnwZHl4XnB8GpbCNylwhWcb6ooikq5rt/7zcBJxk0XKQd7DBIwg+/
         SLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749838653; x=1750443453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lj2XCdyseFAs5Xtxg2sKE50AyX6wcQu4qy75UBvv3Iw=;
        b=X3KIF2D0MgKQFnTS0am5xmUbAM9VAj6ZDQ5p5Fonay328J3ZwibdwcZ+uEsm15be4r
         lidGLucCVTkge74yLS24fpOvV7kptPH4HIm7YPoDjm/esX/UzLQzi3XP1LXRiHobpXWJ
         dJcbDfI9xpYPc2/oPLFCQ1bIWSnjsTVjqB+bxc6BIY7rcG+xuwfDXt3rAKHhwT1u2aKI
         NEQof4dwJYumv+vTR9WyBzyr+VLK5msQ0r95pLomB1ZEVwI1yUMeA3OfVT13RCjM1SIH
         rW7nHu2ClN1QLUU7HoOqDG3LbKM8gY81A1ZKq3knq/ppnrSGOWqQZHW1ExX8LjDH1F7Z
         CCsA==
X-Forwarded-Encrypted: i=1; AJvYcCXEZx5YVRESNdTGfqrsZdxCshohBqsaVeJUl/h0mS+mXBWMHVBssI9EeJ7t/fm1edausBmtAkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1BD7WvZvQ2y654fcSkhkTzyfRBz7mhvfB7OFh6iihQWVRYbyy
	wML4e4rQ+ePz4f9BQOs5OJ2dBM14OhG2glbHIEfwXORfVFKOA5RZnS7nYBU93HA641I+HJqAX8L
	GCw4jruMyUN568BuCJf4XG6sPeL9EyqISmOVs
X-Gm-Gg: ASbGncsyaOdqFfGbz+y2jVY04ZRvYw1mt4kTcljPZ5oRWjxm04gLlP/FRzCJ6is92Bo
	kDXqGbEH6kALiQLIPoOQkdP14vejDH8yR+sYutzU0xbQKwsHtJhJHk59eycQIUDbEUkQWuuSZ/l
	ayc+VY+oBCKPDQMWQ67My5LmUfX8vMNq0En/6v0VpbN/g=
X-Google-Smtp-Source: AGHT+IGJdlProWwJLnEBtaN88nEOVeFAIbu9b07U+OTg3ZGmbz5sClL9jcB0J4MyuTo0cY21DWZkSm4ervUuXXMnOeo=
X-Received: by 2002:a17:90b:3dd0:b0:311:ff02:3fcb with SMTP id
 98e67ed59e1d1-313f1dee9c6mr919334a91.28.1749838652912; Fri, 13 Jun 2025
 11:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
 <20250610172226.1470741-5-stephen.smalley.work@gmail.com> <20250613141447.GF414686@horms.kernel.org>
In-Reply-To: <20250613141447.GF414686@horms.kernel.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 13 Jun 2025 14:17:21 -0400
X-Gm-Features: AX0GCFu1s6IIViKOqH_mdcKU485uUsEO_UsJ8ZCY7oT9tFC3tGq0RhVEzYQd0bo
Message-ID: <CAEjxPJ5vWnRCMd85F2ycKNrkyJUPoumkugEJo1sq7rRuMKw2SQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/42] selinux: dynamically allocate selinux namespace
To: Simon Horman <horms@kernel.org>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 10:14=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Tue, Jun 10, 2025 at 01:21:35PM -0400, Stephen Smalley wrote:
> > Move from static allocation of a single selinux namespace to
> > dynamic allocation.  Include necessary support for lifecycle management
> > of the selinux namespace, modeled after the user namespace support.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> ...
>
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/servi=
ces.c
> > index 112edf9b2106..c67965cbfcba 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -2202,7 +2202,7 @@ static void security_load_policycaps(struct selin=
ux_state *state,
> >  static int security_preserve_bools(struct selinux_policy *oldpolicy,
> >                               struct selinux_policy *newpolicy);
> >
> > -static void selinux_policy_free(struct selinux_policy *policy)
> > +void selinux_policy_free(struct selinux_policy __rcu *policy)
>
> Hi Stephen,
>
> It looks like this __rcu annotation is insufficient, and further updates
> are needed. I didn't look further, but Sparse says:
>
>   .../services.c:2212:27: warning: incorrect type in argument 1 (differen=
t address spaces)
>   .../services.c:2212:27:    expected struct policydb *p
>   .../services.c:2212:27:    got struct policydb [noderef] __rcu *
>   .../services.c:2214:15: warning: incorrect type in argument 1 (differen=
t address spaces)
>   .../services.c:2214:15:    expected void const *objp
>   .../services.c:2214:15:    got struct selinux_policy [noderef] __rcu *p=
olicy
>   .../services.c:2232:39: warning: incorrect type in argument 1 (differen=
t address spaces)
>   .../services.c:2232:39:    expected struct selinux_policy [noderef] __r=
cu *policy
>   .../services.c:2232:39:    got struct selinux_policy *policy
>   .../services.c:2297:29: warning: incorrect type in argument 1 (differen=
t address spaces)
>   .../services.c:2297:29:    expected struct selinux_policy [noderef] __r=
cu *policy
>   .../services.c:2297:29:    got struct selinux_policy *[assigned] oldpol=
icy
>   .../services.c:2210:24: warning: dereference of noderef expression
>   .../services.c:2211:15: warning: dereference of noderef expression
>   .../services.c:2213:15: warning: dereference of noderef expression

Thank you, fixed via
https://github.com/stephensmalley/selinux-kernel/commit/66c448df995fb8d6c5c=
9a4875efc0ab56a5dd21d
and will likely squash into this patch for next submission.

>
>
>
> >  {
> >       if (!policy)
> >               return;
>
> ...
