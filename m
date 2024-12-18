Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74D514BF92
	for <selinux@vger.kernel.org>; Wed, 18 Dec 2024 04:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734496868; cv=none; b=KFg6QlZGMCmC02yOOXp5sPtDTqixcxVXsgOaZrI46ds0QMfSiHFw3nYr2sDQNF5owSfCZWRnjyXWhkhTiSb2bCpzr0CQWsR5DlA10qAl1T306dWepx4SZenaa9awKbFqoqsVRfX0qVKgBnDP0l6QCaxbCsJJjEdCIqEFEpzz1po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734496868; c=relaxed/simple;
	bh=FWQIiurlCx5VsRzxliq+pAHPEaRk1dgAb3M4cUw7dTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJpbm5xKy4PyqCfLn+FcRoDWwWXRzr+dWkV2SZWNc0SGJPO1XveWHFBSZXlLOyC0SzHnBvmYiHAI7WizMRsSPf77alpv49UoSY4kXY3QP+NXESHDuX0gYmU0mbXPs49OJnq/oxAcmMFpTg1U6undCKZb+meL7H6CJCIpUoXLLPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dWGi0q54; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dWGi0q54"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so2652276276.3
        for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 20:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734496861; x=1735101661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxLE4Oq6ASt7HvdZppJk+gA4lbQEeJ8s0rpUR73lisk=;
        b=dWGi0q54ED0UjiA/6OQ8zaDuXLc0PDDKPlNznQ9v1OBuAB3xhjdpO9/51ctZ9XhwOL
         jH3zrM5pFSayQqmVk2IKoSmdVa7IzEXCo6AfHuY+GiisErm5H+zO+soNUnmtQFBBa/VD
         yuxgsCIdfYNwbEzMRWqja+bt077ikPtJW4OhMoHGB1caQSVO59of2EcGGDBO4xkKytVR
         lcObOofeSiGLVdPATt3hfgjxnIJsp9Ij1cdGLBGqLhXQjwd9CW27AsK+Fn6IDsVZqtYo
         axsZJf3RO55BoADng/PvBAKzsE278YJuRRjZFNKPcRp0Ogk6SRARE7T5WcAQAABinIwp
         grBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734496861; x=1735101661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxLE4Oq6ASt7HvdZppJk+gA4lbQEeJ8s0rpUR73lisk=;
        b=oCoG/YF42/u/r+0Tx9Z/QQoTL6UZEEDB5Ed1ZkD8WQuVFliZqVag+xAP4thm4p4G6k
         PlBsgLSbA3uoYVtsjnZlz8spPP6T76L8JVsl24QwTxZtqEclZNQ6t5Fp2ZcVheXM3O50
         l5QXcT6FKRHWJ7dWski3CHgbHm21gyf7ZL+lRPwVuJIXOK3aQp9W+WwvoyC40XPOllMn
         3gefSNNm4PPFMJ0GmvHylZB71kqvz3qHww6Mpu74n7FKLAS151dju/cLxIY8HGY6ScXu
         f5SkOMmwCcxqYKnOWqmQFeEiAhWGgiMVaaQK38FlSD1M3FOoBGOhDUGvk27g3MAPaWLR
         zUqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ/JZoIxfq3xbgZDPWOzqD1f+gHNAuI5c/Ja5oJmrR0IOombbk9VhOmrHzh8aJ+UtYAy2e8Qi3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7XQbU7PJu3VG/Scm4CN+zFso1hzP6GwWt0iSqNvwLHUm4pxjF
	v/RP/FFRSakz+j2H5s2J/TYrB+IiAHOGR3NgCOyG9Dg01H5WLcg3rBB1Zw2aSzJlZ+rR/gVmVQS
	JVoA8uWTrWHd+CFiaaTNnx+4Nj6kzYJwjapTo
X-Gm-Gg: ASbGnct2FwDcZzTQLDSXIDaULFvoFb01wLf4bJSU4aDz5TtGwChcBblkKVMnrezG39N
	3tB4a0tQJt96oFfkGBSW9jBi5UtlkwjjYz2EW
X-Google-Smtp-Source: AGHT+IEKPEmYcGMA/EGjz7b71/HrNZxtrXPAIZrbZq+lRvJh2uII/9GhCrqhuXUTylZZ1NtFJCMoHKJTnPkG1EBTihw=
X-Received: by 2002:a05:6902:250c:b0:e4b:f516:38ba with SMTP id
 3f1490d57ef6-e53621b5d06mr1373917276.17.1734496861569; Tue, 17 Dec 2024
 20:41:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNuVK=Pt6Vx8xiUF7WFhCD3VrqjW=dvox4wHWZfHBCEDTQ@mail.gmail.com>
 <CAHC9VhTqe9roT1dySDXDMQzbOSZyA0f34H0a1xinDSLd-TyQTw@mail.gmail.com> <CAHC9VhTTGA5LADsn4OxJAUkd4V0auS4LrPQs87JqmRVV4nraxg@mail.gmail.com>
In-Reply-To: <CAHC9VhTTGA5LADsn4OxJAUkd4V0auS4LrPQs87JqmRVV4nraxg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Dec 2024 23:40:50 -0500
Message-ID: <CAHC9VhTSeC3NAbAA192ZHQsRZe2aYELHM9inYOPRsR31wSyh2Q@mail.gmail.com>
Subject: Re: kernel-secnext aarch64 builds missing?
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: kernel-secnext@googlegroups.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 12:29=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> On Tue, Dec 17, 2024 at 11:28=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Tue, Dec 17, 2024 at 4:17=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > > Hi Paul,
> > >
> > > It seems that aarch64 builds of the secnext kernel stopped appearing
> > > in [1] some time ago (and kernel-secnext testing results for aarch64
> > > stopped appearing as well). Were they intentionally stopped or is
> > > there a problem that prevents them from being produced?
> > >
> > > The new Testing-Farm-based selinux-testsuite CI matrix includes
> > > aarch64 + secnext kernel, so it is somewhat affected (until [2] it ha=
s
> > > been quietly installing rawhide kernels instead and passing; now it
> > > will fail when no secnext kernel is available). Any chance the aarch6=
4
> > > builds could be reinstated?
> >
> > [NOTE: adding the selinux list since it is somewhat related]
> >
> > Hi Ondrej,
> >
> > Yes, sadly for some reason Fedora Rawhide, which I use to build the
> > kernel-secnext kernels, started panicking my aarch64 system *hard*
> > after an update some time ago and I was forced to disable the
> > kernel-secnext builds.  Unfortunately the issue appeared to be due to
> > some userspace, or compiler change, that affected the entire system
> > and once my build chroot was updated using dnf the entire chroot was
> > bricked.  I saw similar problems on my aarch64 dev/test VMs.  I dug
> > around on the RH bugzilla and didn't see any reports, nor anything
> > obvious via google searches.  I was hoping to go back and try to debug
> > and/or restore the chroot and VM but I haven't had the time.
> >
> > As a reference point, Fedora 41, Alama v9.5, and Ubuntu 24.04 are all
> > working fine on my aarch64 system so I doubt there is some hardware
> > issue.
> >
> > Are you aware of any nasty aarch64 problems in Rawhide, either now or
> > starting back in October?
>
> I'm still interested in hearing if anyone has any info on a
> aarch64/Rawhide breakage in October as it may help me recover my VMs,
> but I just now tried creating a minimal aarch64/Rawhide chroot (only
> installed bash) and it seems to be working now (!).  I'm going to try
> to rebuild a new Rawhide chroot that can build kernels and see how it
> goes ... more info later.

I was able to rebuild the Rawhide chroot and recover the Rawhide VMs
and it looks like everything is back and working again.  It will
likely take several days to catch-up with the src rpm backlog, but you
should see secnext kernels starting to appear in the repo in the next
few hours.

--=20
paul-moore.com
