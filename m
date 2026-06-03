Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F511EA7DB
	for <selinux@vger.kernel.org>; Wed,  3 Jun 2026 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445876; cv=pass; b=AAaZLB5sk74SrPnTmekwea+xW7C28kqsLp3S4921Z07i7ybtWSmyuoefZGDfG8tJMieX2TI+PMbjJFKF11zCVKbPBz/QwkBrYeMVKwsKlRjs+7FYXjnmbHkHJvuQCebYexltRnbpy6o8H+z/J9lfxg0bSoFqNUbjfRFhdiMpY78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445876; c=relaxed/simple;
	bh=2XVUNGJN763CRkkEw6FVufhqvUgoj5Q5trHv9qG4NWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euer0UY7b3Qwt9VlXz4Y0q3FHiX/DYEZTQNSqawu2Rc6htQyGrf+fUBsruBYmxVTqBryFH6NVm4oqvHa6d/xCi1g7VdaS61JHZEgj+BJQW0ntNsqPnafmCbNnN9AYROCNyJBwZPpdTNz/WzDy6I/p6dbgfRyODe6riu9zIbdQHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TUAsYQ5x; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TUAsYQ5x"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-133362c30cfso2694c88.0
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 17:17:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780445875; cv=none;
        d=google.com; s=arc-20240605;
        b=BpYS3SPa0yUiEwYUx3w0Mj9OPz8sxGaAdAKE0i2WvzmHSMNFkI28+w+cLgCueEac6u
         EhaadSiQ8fcaIDf2NBjIdICg5DOgqQCFI7jvYvMUrSagc6mHe1BC1mjmh3elF7QkRWlr
         qcVZui8N5sJ6vWFmzE4TgD4MUuFzs23yIcJcF/VLPJJjJfnMsNO1EP/bzDeS8MiSu2cM
         a0u+xmN0tq3QXpKUOtxWudJCf8HAY1GCyngq5L/7qUDzSbHC/23L83dGcus+37D/cS2V
         y8qFGKr4FKc9n27/dNxtJiqIqrLCa5yoSSRc0dXYyppeqjvJgAXNQ6Hv/I3o5TjtRrVd
         67vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2XVUNGJN763CRkkEw6FVufhqvUgoj5Q5trHv9qG4NWs=;
        fh=1bKZ5DG58S22qs+u3TwTvpdWVhmePepB2i/wh3MrD7w=;
        b=JbywrYaaL1ou9n1O6Xb/uH44uU/+Aw7MbJmNozSB3gwyQ3LPqDjMZeLe61podm31Ps
         DEorvtn7Lhv2fim0HIizmwSc0LLjWGaBFa2ezxUgedml9jskq1KfpfudHDk5mwbKUjp+
         8VJWTp1ztoTuAarmdAywpv6qslh7tL/BF3VmWTzimhbDYAw9ZwhGWzdithRoxmEx7cDg
         x6+d5cp80tvzsyWu9Vbq6Xy14V9MEHaAli8VcaEBc4rUFdMLmueGte1B0PJNbOyvA+JM
         Ezj0EzUWsaWauEXXv8ys5ucNLgl9cyDkHm2V2yhJHE8pibLz4TBDmxi+ab2HPS9yt14E
         I0KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780445875; x=1781050675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XVUNGJN763CRkkEw6FVufhqvUgoj5Q5trHv9qG4NWs=;
        b=TUAsYQ5xJ0MX8B1Z6gbHOdGmbVQ5W4ZNjszvq/2CTQqIWApTnpSMvuEhScLbB2lEPK
         7p0iPMllbQJYDSTDkTShZj+cXnIxBS5YM6+xa1PxHCWGxo6GnLfqvb+7tLrKxmxDOpRR
         7WTU4rNyiWhit3xuoMo6508qL67z+08uMJGlxpIXhVAGbAXl6JkLtcMatuqA+NQEdCF8
         J40ia9etzkCarKthBuC/f2j11NPbRIXvsLiRcIO3ia0Y+bNsVkJ9Dgoy3pAEdaHKC88h
         jE77e8eSSWZKnGps+zT92nu5dHu+XJdxJ3e5GbN0xUwfZHJL65npxd7aTWSPN5PVC7G1
         Wfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780445875; x=1781050675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2XVUNGJN763CRkkEw6FVufhqvUgoj5Q5trHv9qG4NWs=;
        b=d59iU1hKzsypV2Pf8oT6yfuxJNMvLIQvXB8yDy0j/teJzGUaM+OtnHNvh4RgwUZl61
         vceOIseEYf5WUT3vae5btLQrop7qM1wEl1DJc8K9S8TGAbs7dSN2/VCZisfUbakcPbcE
         kabuNaYPVQdgmkZkIpWtMKS3n+wL+26i+25lNTi/lah84BvJuDoHBuY9Cb8I68oi+3pv
         cO0Ouk6qEM1RuBy2S8avpXB/LRL2iUa4Eyqo+q0cmu9f39aBqU4EIWoaP9yK3eSIltxq
         +n6DOCapd31S/rEebtJ2/cAopd9FTpXr14rN1Sf3s0hZF9VJW9SvcUJ4U/4KabJ5fn1e
         hBOA==
X-Forwarded-Encrypted: i=1; AFNElJ8xNaJSaOgfJEa+dpKiae2VaIHwIdWpZK/3Gx7T01HBGyGAMT9G2xierET+F6Ap/ymgIO4ZPnPC@vger.kernel.org
X-Gm-Message-State: AOJu0YyWJD3/X7UqBT5ogNfMf8a/3F9FZ++B/r9Co/E+agfaBrdAsdcW
	apcvbA0+c1wCT2IP9uEBdkZ99DHK6MJpxR2Mb7ZGwouQ34B6AOTfE06p593+vdQh36AY5T9uhtX
	JZMfdfeRBV8m3GWpCWNOOeq1GpkCkplHQqN8IUNVmZ/h7LR0iH1N8dGqOtUc=
X-Gm-Gg: Acq92OEDDUHiLF7Lt1auGqSsKgthvZm4zgEiXiDlADG4rFHdbws6Rz0gYIhpbVaqoHG
	gAtSxBHgnEey770ua6brYFo/M5hCDqRTtwVSCw+d1IA6ABgsPp4D3dXurXEZmZcec0uzsiA7l0X
	+ZdmGMzda6hiH3W5Lm6x+CM0YnsH4GcNUE+/diLGrSKDWRP+gWxnqIIcIgIH5owkD1khaZC+Y7T
	OPn/vbAISNYlTJLy7S3jFd6s9KnhAgxqQaiir/lYneBuoK6yX9kwqc5K7oAcKWsnEttJeEcJDvH
	FpDmwcfB888g4tBEwZ5ZCHXMI1lfm4wi/vbF+VmQ4BMoqZdGTY/5dhY5UbvtSr5xtozHpNJXbTp
	XsFcka8rW
X-Received: by 2002:a05:7022:ebcb:b0:12c:be9:7ce with SMTP id
 a92af1059eb24-137f7a79431mr13128c88.2.1780445874031; Tue, 02 Jun 2026
 17:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602153309.157348-1-jwcart2@gmail.com> <20260602153309.157348-3-jwcart2@gmail.com>
 <CAEjxPJ7NyYz8fXbiEGdhBMPcckRTk6OuzS+fsPNO_W=SuZCYWg@mail.gmail.com> <CAEjxPJ68-SUdABNeRsX1GZXv_scQFSGJWY2YZDU5bTa4B-ZCXA@mail.gmail.com>
In-Reply-To: <CAEjxPJ68-SUdABNeRsX1GZXv_scQFSGJWY2YZDU5bTa4B-ZCXA@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Wed, 3 Jun 2026 10:17:35 +1000
X-Gm-Features: AVHnY4Kdu2b6lBNBrDFC60cg4cowWrHn2S7oMst1UW0lP8fAizk3AnZlR286Wd0
Message-ID: <CA+zpnLdS7VaVk-3Kwoj6X7BBbW1rxHLt=6bA7xBEBA6EoZyP3A@mail.gmail.com>
Subject: Re: [PATCH 3/3 v4] secilc: Add program that checks CIL neverallows
 against a binary policy
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 4:22=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jun 2, 2026 at 2:10=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Jun 2, 2026 at 11:33=E2=80=AFAM James Carter <jwcart2@gmail.com=
> wrote:
> > >
> > > Add the program secilcheck that takes a binary policy and one or
> > > more CIL files and checks for violations in the binary policy using
> > > the neverallow and neverallowx rules from the CIL policy.
> > >
> > > ex/
> > > secilcheck policy.bin neverallows.cil
> > >
> > > The CIL neverallow and neverallowx rules must only use types, classes=
,
> > > and permissions that are declared in the binary policy.
> > >
> > > This is planned on being used in Android to validate policies from
> > > partners against the standard AOSP assertions as part of the
> > > Compatibility Test Suite.
> > >
> > > Suggested-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > > Signed-off-by: James Carter <jwcart2@gmail.com>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> All three merged.

Thanks again James.

I know they have been merged already, but for the whole set:

Tested-by: Thi=C3=A9baud Weksteen <tweek@google.com>
