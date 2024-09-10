Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A031A4F3A
	for <selinux@vger.kernel.org>; Tue, 10 Sep 2024 23:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726009544; cv=none; b=iCFNnbjTG5+I+wCG/fSRVOEo3mu+TgwyK1VUysKKyDR7FWZdKKuHm0Rd1gm/TFjaYKPg9Uvu4RoY2qQvqrGd7jcsGWlT560BUpjPhAGcE1mOOFHJs2OLyxDMw3Oyqy0UcLtNlNZlzW1Ymr35KnBZ9sldCKDbPy+A8mpk130+eR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726009544; c=relaxed/simple;
	bh=xl9eYIT9ivuySXl2SQPVFb2BTIVvRUAmegAxUX7d4hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4fsxZl7VFY4EK/QA9Op2gNfaRbb8pY/+rDTtCeODoDpcJBEvmkb3+ylb25t+zZWGnrz8vm/E+GzlJR5+29uXWisRHeOQG6WCwY/COJncJTx759wjbxyKst2tMWzgmyNgkH5FTnTPC4plAQNr3WZE5nHayPlxhArCZ4d2zjH0Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IRGuoY6V; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IRGuoY6V"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c2460e885dso36776a12.0
        for <selinux@vger.kernel.org>; Tue, 10 Sep 2024 16:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726009541; x=1726614341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGDNjxA8a/+7X5OLMsKVJ1MSV2s9K8DgSyu27kL3bTc=;
        b=IRGuoY6VHOHQSfwAFWu7X66vhJhmetPFYWTVp3tNwxV3nq4Ktru1Hq4n14FVsPqVUC
         SM85jexXfUSDcskTLqmHwT5Cln0z1n8+8tbKROWQWOWHooxQZh5Sg3hsL/chESkUHuZ5
         nYmnK960p8LJvn79evwids0L/quplkRE+DaaQPk2ueysOQCxQ81SdD4kvMohBMK8o7sV
         OV0okc/ljxDYyi+NRbB8gZBuwqBTt8fJkWnJhnNYuZpC03W7EhFKZBWO3cd/gpGnWyJ1
         hXMxcCcjXhMOk/moJT0NLIMvOoEJ5Z9sVeVZVeatT8229N4w10n5H7VXNc9kSy2X9o47
         pt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726009541; x=1726614341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGDNjxA8a/+7X5OLMsKVJ1MSV2s9K8DgSyu27kL3bTc=;
        b=PMdI961ijvrsf4joLBDjBSdE7MSEMEQ2fzvFtKo9o8CGeS0mmzbQwSN65Fj3JqzMBr
         MO8oXRt/qQJnCtBgAIjpflrbwOKwnkN3+4/hS2V7QtvGl+rlq9l4VqbBfYqegArN/d7D
         otgd2bbwbEwhUJh8x9zk0AcG1QOobsBaoyiU1wD9ZZb8XBusqIXwd8g2LM61V8T9WxiT
         pagwHbOj1xFmR8TMf/PUx0+BH1X/pYe9wdvXThES1sQ6DtqA01+5Zk+HoOsSfZxiNmEU
         YUoA831PjVjFMPHPbTS5S2YBc9mR8DKRWP2ae6F78ZJWC+nwI5geKUBj7jRpOgYh2kuY
         P2WA==
X-Forwarded-Encrypted: i=1; AJvYcCW7b8RYp7qp4g2XgVmla2zEjUWSQShmfulJpIK+LCAXD/dXDI8EbK1js1nUZxsdI54tH5I5H3fk@vger.kernel.org
X-Gm-Message-State: AOJu0YxthnnlXuS2SbmmWhJ7rQASdjPsBA5HH3PF4ofakLZRDCvD1xLu
	CJmmWmK7NsjvbJEfmwjJ60zuUU/nwF4KMe5RYuCLUxEPz6ragI8G/turBG+QyWsBWLPywjWoIB5
	NPuww1/xlcecbK3FeM96G6pRDy02cvDP+o4Iu
X-Google-Smtp-Source: AGHT+IHi+pt6zImju/NyZ5JtEjJPlJdjWNiRZnmzpVbUhgzUBz1ExYC4BgzyceVyNtRPkeaqMAMV1q5yq7wvDn/CO+U=
X-Received: by 2002:a05:6402:278d:b0:58b:15e4:d786 with SMTP id
 4fb4d7f45d1cf-5c40dacefbamr74233a12.5.1726009540433; Tue, 10 Sep 2024
 16:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805-remove-cred-transfer-v2-1-a2aa1d45e6b8@google.com> <47697d5f8d557113244b7c044251fe09@paul-moore.com>
In-Reply-To: <47697d5f8d557113244b7c044251fe09@paul-moore.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 11 Sep 2024 01:05:04 +0200
Message-ID: <CAG48ez1GiPYROLukVwBQhDeFWzp8Xo9uUs-1B5X1YgqNw78dAA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] KEYS: use synchronous task work for changing
 parent credentials
To: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	John Johansen <john.johansen@canonical.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com, 
	keyrings@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 11:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> On Aug  5, 2024 Jann Horn <jannh@google.com> wrote:
> > -     cred->session_keyring =3D key_ref_to_ptr(keyring_r);
> > -     keyring_r =3D NULL;
> > -     init_task_work(newwork, key_change_session_keyring);
> > +     /* the parent mustn't be init and mustn't be a kernel thread */
> > +     if (is_global_init(parent) || (READ_ONCE(parent->flags) & PF_KTHR=
EAD) !=3D 0)
> > +             goto put_task;
>
> I think we need to explicitly set @ret if we are failing here, yes?

Ah, yes. Thanks.
