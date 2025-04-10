Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F396620C48F
	for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 22:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744322692; cv=none; b=pBq9VJIHvkXZfGh57zqKNonkeLP3L6X2vaPeh6snklILzc9SaW2rwUoELt6oxuGmvl960gGSJ34g0ea/RvJSlRsmGBk7+seLKYWUe1gKoTKP2OIJxSzMolsxI4UwRqLJKBaoOyrOCsX0LZm1yiaIUi0eefSIe68VgbJ28KPEtcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744322692; c=relaxed/simple;
	bh=lR4MKuu340RWszf0Guxd0jymAu7e7DxV0vQyiIB8too=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QagfKUp+NBUm0XzhIVKkU2WtpZdvUp9IuqcFYRG4E06XSVvMostF8LYYygOeawjLcBQ7aWGpLhwggSreuK3+qQma8LGHcU2ttDEREFJqsZl9up/7gs/kUfVfvgmPxyDK/ZPyfMPRkKupVeRWSyTOc6iYh2iFFeGnB05TAvxF6oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OD9Qo8sv; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OD9Qo8sv"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ef60e500d7so12431087b3.0
        for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 15:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744322690; x=1744927490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThJA9RCffpGJB52cdB/k9+6Gib3Kw1fb/e4rgWap2ag=;
        b=OD9Qo8svGjjZW4e2ydgv1rnw6ylHh/bhgyXDadI+SwJjgZtglkhNHuq/HSIS2BppBE
         6pxSS56HMESgghA24v0Aw7OF+F8QWq/sa6x9GR5jtQqjFkGiYhERZf/MaVvMsK0psux6
         +p1Oh7rxCpwHSJdGh3/1QZ6/nPKDy4IOwVw+aJWm2iTdN39W0vh7Rh65YJp0R1qCHO2M
         72QPXd/LItl3gcPY8d3gBznLCW15Q45hxsNE2rpMe68K4gJz+q2bq2v/MZIGlk/dYHFi
         z+NdjnuXs/VtXzomjtOjYFx+R/KfBWpyX1GQczOZXgV2t6KSiLYTBtceNoQW0VXhz+67
         p/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744322690; x=1744927490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThJA9RCffpGJB52cdB/k9+6Gib3Kw1fb/e4rgWap2ag=;
        b=rPFH4JMT4zFbTaPH7LXOK+8xh4MWQnlkms4BkV4PvZjOUP4ENJ8fV4TZQP4agW9I1d
         37AY2mTkbHsQ01UnkugTLQm3t5iRUmXXc6etRRnqp8jjnJBneL2A5YZFN6tomenBYtm3
         OrLnAPZsnae1tfo0fKts65rluj/Nkv5kgbuUdfQEapfWolifSzulpjDSFVkLgTRmm7rI
         oS4AJRR4daTbZOFNcGqq0IFFZW11fLLXfBFuvPcQonF33s1Y3+Hf95GVjhOOE+qk2r8S
         tCR2dPmYSGGXNdfNEdhinNmqfj4VwcihRLJyFhsDzh7d2IpnROmomqjh46+i/T9lAddV
         WI2A==
X-Forwarded-Encrypted: i=1; AJvYcCUDcY+zVZ7SyfllD4boVTK9qXwnoc2GYVwnjYNFJ0a8IW4Zwtb8tQ/VNRM8mRt6176we7Wd51mS@vger.kernel.org
X-Gm-Message-State: AOJu0Yyon799d+E/UQuFAruhe+DIpOw/ZyV1A5sgEOWgRFPpUWyfOaJe
	j14mtszmW4yfx0LpWm7zDpB0s1hxg4yLeSkw83+sZKYBp2HJBIQ+9Qj5dwHT+KVICtMshmkg8Rw
	zyDJZCx6NPskn0a7ENwqnbvGWRDUiooSJZ2i9
X-Gm-Gg: ASbGncvZlClGVRFC9VgCyozSiq9LaaXd7qjBQBUVHV2Icx5CBOaCbQUyCZ14wxJLqJX
	RO2DYHXEL1kMNuowLIXElsKgWBxE45KKuuuXw2OikVy9wy6J8R7skHw1F6UCm0+wRSr1iF/ohOp
	3Jsy8mV5dM4nd/W9skg5c88A==
X-Google-Smtp-Source: AGHT+IGu9blHBtA3CEBz2LkZkg/e7jSU3qWOp94YzjozDX5VWYKwsBrkCM0y59Kq8Fo/PoEfVbgmMOpFZRD+yGBpMsQ=
X-Received: by 2002:a05:6902:1b02:b0:e61:1c56:d65e with SMTP id
 3f1490d57ef6-e704df3ae64mr1115328276.39.1744322689832; Thu, 10 Apr 2025
 15:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-38-paul@paul-moore.com>
 <202504091603.107B41F4@keescook>
In-Reply-To: <202504091603.107B41F4@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 18:04:38 -0400
X-Gm-Features: ATxdqUHFxuT5USi8IiIkSasG6nEMfemcLUEOIyHb3nrfcVUUbanf7KB9GsqSVvI
Message-ID: <CAHC9VhT+yr=Pf=sSpFAO7RbAGejRgQhKPDLppCeOmydfhds5qQ@mail.gmail.com>
Subject: Re: [RFC PATCH 07/29] lsm: rework lsm_active_cnt and lsm_idlist[]
To: Kees Cook <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Micah Morton <mortonm@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 7:06=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Wed, Apr 09, 2025 at 02:49:52PM -0400, Paul Moore wrote:

...

> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index edf2f4140eaa..981ddb20f48e 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -22,8 +22,8 @@ static __initdata const char *lsm_order_cmdline;
> >  static __initdata const char *lsm_order_legacy;
> >
> >  /* Ordered list of LSMs to initialize. */
> > -static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
> >  static __initdata struct lsm_info *lsm_exclusive;
> > +static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
>
> I don't care either way, but why re-order these? Just local reverse
> xmas-tree?

Sure?

Honestly can't say for certain, at this point in the development
process I had somewhat resigned myself to having a mess of a patchset
so I figured this was an opportunity to make it look "nice" (er?) in
my mind, and I suppose at that point that looked better to me ... ?

--=20
paul-moore.com
