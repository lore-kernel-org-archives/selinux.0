Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464C21537C6
	for <selinux@vger.kernel.org>; Wed, 21 May 2025 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747845358; cv=none; b=ERF1mO71+5qAgmEyiFBxsPYaYMZ66tdSLEsl4QuSons/FhUA8o5DWgxNFFwdvPvHxxCaI8SZhkKogE0cEVTYI0UQwIvFsICop39XdbVAReK+cQJoyGjZoshRz62ET4ev/S7UtdOcO9L+TyP58p7DJILnc3L5iv740aFsi8FVBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747845358; c=relaxed/simple;
	bh=l82wZeLJtEAspwyq4jGul3tuvPwbUybcM/GYc/fq7eQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAyPMCm0ruuyHHNKUkFItLbi5g+4syHyoMkrSzMC3nh0xHlxniAW/9uy+rhQCJl8ZqcQLtApcsZheWEdIFHf6EBJ6GBgHKg0uCHlDdMn5m/9SwAokDLV9vA0bHo9V89lSEev6WOC9+v0XmT/tU7XYY0GIZhJj1knyvwSgV5RizU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VRcEWeaZ; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VRcEWeaZ"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70ccf9a4ab3so38892227b3.1
        for <selinux@vger.kernel.org>; Wed, 21 May 2025 09:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747845355; x=1748450155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19m2TDn05i/4DbL0bI/dXh6jZp1nlxvo1x/A6PV7dyI=;
        b=VRcEWeaZfEmIjsOgRHHiqODBLiwkaydPmGMUZFHYtjek2hQp0NgBnf5D+HmmA0Oq7R
         F+5+89yvoCOu8+OdGtWEIDoBsEsx8Ul38FCSxE00lZi+VbrZHn1p5Il0mlwkR2L2AnRg
         esfiEeXU9d0P8yZx0RrCSY1tptmT8oX3te56gzmQTS/JG+4aUOhoAMCWZvfvN3jS9vt9
         Ws/TqzFm6NkVDL2amuhIChV2zdxPaEb9rBfEpcf5h96+pujCbhthO1RLfBDvsv15E82E
         wAdhWdCl64XLI7aKeNSOz/WvM4LLn3mCoYFd+Ydd6iILjw6jWWjRa+PhqN6gNjTEH3Fg
         7wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747845355; x=1748450155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19m2TDn05i/4DbL0bI/dXh6jZp1nlxvo1x/A6PV7dyI=;
        b=kAfUl72v3UObZAtf1jdKrnFHhICXXxTMhTvoyUtcufeU1aaWc9ogtpjH3vgke0a9Gp
         XRGnIuQFZ7Vkpf8au8dOnetxX2fEOTsksFXZPKFnxhmCNZwDxMGL02SZXuw+u0Ty0gdu
         i65MiwGgety+30Pf6y6T42ly18NaCJFr+St1EzKHgOHMbv8QjFQYOsaaGaGWJbya78YS
         Zz6+cvKQ5gKigT+yaurN0bqxl5zQhx66YZpxnBlBnJNtUbvtx8w2HXTvdqxwjdOfqXcw
         2fh5hpb4z9EmnQ1C5k4rbOO+mD+TTMDHH6dRJ79f9W6tUv1ArEzv28fQVeDCQfb8rJ7k
         XMqw==
X-Gm-Message-State: AOJu0YzUCWiTbMUUI8K0RqH6H8mxPf0e2dccFy/dcAlTXtoz00Qyc57g
	hX0vc+fp+BntY/0d1PU0ykcD4iGCoB5qP2xjWMV7cUtThPSbTXWnXDHH48+bMkOxlb/PehllXih
	MOsUu7+4By+gNs8JuJFuSF9mS5KgGUMgOvSUQCSWn
X-Gm-Gg: ASbGnctzo9d2db8LnjBAh+mvo8SYBao8t+6VApjrkAd1uNlNMXiSe/XeM7xiD0HIPBe
	A2v+G3BXEc++aMX4OpJceJYuuYTeEsT3JWvdXLuL/w7+aPnASZiW1xn6UytX2sZEjUwGUnNRh+s
	NJY/QpqOVXpGYYuXdnwKfdrWs/P1bQ3Hdh
X-Google-Smtp-Source: AGHT+IF3bWXbqSWj9f1Zp3Ehh0TOxqZyL/UpI8mvIIABOxJJhTbx3REEIZwaUujxi4v78UUW1S40U6xsdpR+/uWRGNw=
X-Received: by 2002:a05:690c:9c08:b0:70c:d322:8587 with SMTP id
 00721157ae682-70cd3228867mr188615407b3.6.1747845355117; Wed, 21 May 2025
 09:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502170450.27160-2-stephen.smalley.work@gmail.com>
 <8c2770270a9d4a217e22102ddf91327e@paul-moore.com> <CAEjxPJ4NQ-OoXXK0cn+jN50bzM01hBoXkSN2UX3HJv5cO0J3uQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4NQ-OoXXK0cn+jN50bzM01hBoXkSN2UX3HJv5cO0J3uQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 May 2025 12:35:44 -0400
X-Gm-Features: AX0GCFuPIinS5ElgPsOcq-9O4tcq2I8FYRw3Imskukc0XAwNbO_85mzvqW4CMTM
Message-ID: <CAHC9VhSwtif+ijxJDt0jpqyrvuD2Um9wy2vB6oBKzr5CkYF0xw@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: introduce neveraudit types
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 7:47=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, May 20, 2025 at 7:38=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On May  2, 2025 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> > >
> > > Introduce neveraudit types i.e. types that should never trigger
> > > audit messages. This allows the AVC to skip all audit-related
> > > processing for such types. Note that neveraudit differs from
> > > dontaudit not only wrt being applied for all checks with a given
> > > source type but also in that it disables all auditing, not just
> > > permission denials.
> > >
> > > When a type is both a permissive type and a neveraudit type,
> > > the security server can short-circuit the security_compute_av()
> > > logic, rendering the type equivalent to an unconfined type.
> >
> > I really don't want to see the word "unconfined" in this patchset.
> > Talking about optimizations that can be done when the permissive and
> > neveraudit flags are combined on a single type is a good thing to do
> > but I don't want people talking about how this is an unconfined type
> > because it is not, it simply mimics that behavior.
> >
> > You are welcome to criticize that stance, but understand I believe
> > this is an important distinction and it *is* a hill I'm willing to
> > die on.
>
> I am a believer in plain speech, and the reality is that this patch is
> introducing a first class unconfined construct to SELinux for the
> first time ...

No.  The combination of the permissive and neveraudit flags does not
make an "unconfined" domain, it marks the domain as one where we are
not enforcing access denials and we are not auditing those denials.
An unconfined domain, as defined by the common unconfined_t type, is a
domain with a set of explicit access permissions which let it perform
any operation on any type.  There are certain implementation details
that effectively allow a permissive|neveraudit domain to mimic the
same behavior of an unconfined domain, but the two are not the same.

> ... which is something AppArmor had from day one.

I'm not sure how that matters one bit to what we are discussing here.
SELinux is not AppArmor, just as the combination of the permissive and
neveraudit flags does not make an unconfined domain.

> That said,
> this is NOT a hill I am willing to die on, so I will change it as
> requested. If I understand correctly, it is merely the use of the word
> "unconfined" in the patch description and comments to which you
> object, nothing else.

It's more about this persistent mischaracterization of permissive|neveraudi=
t.

--=20
paul-moore.com
