Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ABB26136D
	for <selinux@vger.kernel.org>; Mon,  4 Aug 2025 12:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309909; cv=none; b=S7xhH0oG6VOr/Za7NqeehZWRiSRcRbqRBz2edV1O30kAY87m3exFSVnesTSr0gIYUEIDmvFWz/cnqPWBAlCs1CENZ16jBZ2uwnZf8jkvvUSShuMngAmkZSRVjPwNxOqrlNs4QWW+/sghMMqRq/Spd06fiEec5DMA8ReqDUf0owI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309909; c=relaxed/simple;
	bh=lqC6dC30Hr7pPhm6COOBXT5bBwJkOccUEJRzeLxF4G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cr8T80ESec/pNohKy0q+zpzrWIWHk5s5FD7BfrMQ0RVm9gvsMZFOsxGG0gDdv6Cz22fyqjASv5vJcseboKUURjtvA4UVhIsIAsM5I3Sq/SHSHHfdwA6yLDSMPeCgUfkrXEVb5Y3PgJ/njs2U7TAYxiFGMak8Xv/Iz181yVW1D2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIrV3Qha; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIrV3Qha"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31f53b3b284so5223419a91.1
        for <selinux@vger.kernel.org>; Mon, 04 Aug 2025 05:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754309907; x=1754914707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqC6dC30Hr7pPhm6COOBXT5bBwJkOccUEJRzeLxF4G8=;
        b=RIrV3QhaY6NQCh6xZfIYgBUeJqKQYSVWlgQaFX2/soTreAM6uz+KloRVIke0HeSOXT
         OlZ5wN+IDUGH1XDqU4C+yroj5tmlD1u3nNoaGzmy6xtQ1EZT3QiVDsayXK0HmvImVPhQ
         nXOIrQzNPa3aFsWqBmEVpPkRPbd27NiSRT7ObGTzHpMj4wTBidhxkHEObSBnMxFgc1BZ
         0GwiVFlaI0AXn79LbY9TmzJNhFRi5HENYSKT3FG/EBPKj1/xyctjSAQwmf72GV7DWfYl
         IZKPSqfquAl1z8zt/Em9uBLrMqIcwwrR7QVZOowUccKsrNy2MjANLMco823yBW1cTTce
         lTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754309907; x=1754914707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqC6dC30Hr7pPhm6COOBXT5bBwJkOccUEJRzeLxF4G8=;
        b=tMZk1TY2af4wVzaGHMv6o+dTj6HM/GEoH2aTyGmZ/+GIdkcs5Satsd+jOjoo7oyT5C
         if1Id64LNO5ls6visB2jYkZP91g2UqIeSaGFQTjFhevJkPmOZYVi4mfBVIerJGWRKKKw
         9EM9IhFYZLmfJHycIcG8jzC5w83SO/+ENXc0WKitMtzZGJDgrv3WRe/BZ8rgijYhJbJW
         msecax0ojetUy/yTm/tEAg4gtwXbOvJoEzmKeoI2FTTMYKaa/vbVKlxd4Eon4jks/eXz
         tZuESLwIujjwOIwdLKIpccHWW7A8n14x/sDq8iG3b+qKUFwICZThTQjm48MI6XWld0oJ
         0mdg==
X-Forwarded-Encrypted: i=1; AJvYcCVrvapo06L9yUdDimxDy6IXKG+xszoVfx5xGgc3FJKq3G9KyRTbtdOOuRq5HqXoIZ/Pv9TTbNFI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+AduNHt6gEs1j/VUsVaKbnY/MMaQD+spZo60Kzg7cowScTMcN
	VaBzpbw+4U/LDE0PSWWCQ+IJsDoIvLubZtFxlmy9mzoOJTRAnywuZfUD6s6FIzJS0k5HX8TOqjG
	EcRMFlwOYmR8eWco9KvO5sQWS+sCu/lD2beAU
X-Gm-Gg: ASbGnctG02MaTUhcSfprzFq+ZZ4G05KF6BuTS9DXuHTvtPvB/hVQCqpv2LpXkucxv/M
	WHYjVB6hvr+E53mo/eH3xt8V+vUgdmcPmmKkvBAYc86hXL/dzpzuWijUIXPCSmmJGP1F+mSdkwV
	kxyVA6LG+IQkj89HRjeFHsT9PAYPjDvNXl8Pr+CNnDwjFwDOJgbftiGQZiDWwvMRgnc+ZJOGapI
	yFFHx8=
X-Google-Smtp-Source: AGHT+IENgG1CpgnX6bM4sx1PnhquhkvuMNAomRloMix28UpTVgIMGrSnOSL0BRhZdQl62rO4s4dh1U55mWXzajq3Dpg=
X-Received: by 2002:a17:90b:3e8e:b0:31f:14b:f397 with SMTP id
 98e67ed59e1d1-32116818bfdmr13846999a91.1.1754309906785; Mon, 04 Aug 2025
 05:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801154637.143931-1-danieldurning.work@gmail.com>
 <CAEjxPJ799AYzKGMJr5vmcP+b_ikPncy-vwaKZudRMRokwyuXMQ@mail.gmail.com>
 <CAEjxPJ7d=LJ=Rxyiy6TpjEETVhkAkKxJci0Hog1v+55V8jvpdw@mail.gmail.com> <1986fe81af8.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <1986fe81af8.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 4 Aug 2025 08:18:14 -0400
X-Gm-Features: Ac12FXy0ZLoewke1xlGj-yBpE0dAGfruW5TbeZt6xrMjD45sa521-_8-KDT1f34
Message-ID: <CAEjxPJ6wM2Jv6J7Vdmk8H4GYXGgoeQFqZfRK3EZkv=9MgOdAXQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: implement bpf_token_cmd and bpf_token_capable hooks
To: Paul Moore <paul@paul-moore.com>
Cc: danieldurning.work@gmail.com, ericsu@linux.microsoft.com, 
	selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 8:29=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On August 1, 2025 3:30:02 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Fri, Aug 1, 2025 at 2:38=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >>
> >> On Fri, Aug 1, 2025 at 11:49=E2=80=AFAM <danieldurning.work@gmail.com>=
 wrote:
> >>>
> >>> From: Daniel Durning <danieldurning.work@gmail.com>
> >>>
> >>> Implement bpf_token_cmd and bpf_token_capable hooks for SELinux.
> >>> For both hooks we check against the token SID, to support
> >>> delegation. We could add a further check based on process SID
> >>> when the token is first created.
> >>
> >> I agree with the approach - it is consistent with how tokens are used.
> >> I suppose we could perform a process-based check in
> >> selinux_bpf_token_create() if it was generic, or add one to each of
> >> these hooks if we want a different permission for different cmd or cap
> >> values.
> >
> > Ah, actually that doesn't look viable at least for the token capable
> > checks, since those look like they can occur from outside of process
> > context if I am reading the code correctly.
> >>>
>
> Eric Suen has also been working on a SELinux BPF token implementation too=
,
> and I believe he is planning to post it upstream for review soon.
>
> I do expect we'll need to have a discussion about the access controls,
> especially the labels involved, as BPF tokens are quite bit different fro=
m
> many of the other SELinux access controls.

Eric - note that Daniel also posted a patch for the selinux-testsuite
to exercise these hooks and checks based on the Linux kernel self-test
for bpf tokens, see
https://lore.kernel.org/selinux/CAEjxPJ7DBDnZEFvgpe58K4B+4kZdOqUGMHvGC2vKt-=
4Zget=3DHg@mail.gmail.com/T/#t

Paul - it would be good to avoid such duplication of effort in the
future, maybe we should be tracking such things in the GitHub project?

>
> --
> paul-moore.com
>
>
>
