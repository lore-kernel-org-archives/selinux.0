Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F72CF510
	for <selinux@vger.kernel.org>; Mon, 27 Jan 2025 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990046; cv=none; b=b8ijmMWEHs4hIF/IclD5/b4spEU676r3CVFSLZ21Fm5pW39JiBEOC2SFSeYpdp9C9laP+fSivOrRu7VbkAq00iatwEHz9RocCNuIYWfjoegtxnztMwLd66vTniHnvyHF1Lnyhb+7a1y/hf00tN3pFKPtM7Lfkwgs/Y3BUWq5BjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990046; c=relaxed/simple;
	bh=cUZsgFABjuuJ0JkTiLHU0q4TuE312CeT032ucCjFrRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekNgyPYbfGPinUGYZgnt2Oa8J0elF5f8dqE79WGU33fPnVIkDgso0/hxe/SOrfuha012Af2mJQqhyhAnpsjzaY1l/HZ91UhycdSzv+oSk/ClHBzbl+01MBWa/KeYIrQuQL9qYRd1mAHzFNZWDQFAo7CLkHhk+hd+/YNySUDa3Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyTiiDVg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyTiiDVg"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21bc1512a63so87887765ad.1
        for <selinux@vger.kernel.org>; Mon, 27 Jan 2025 07:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737990044; x=1738594844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/y5ui3U96hxQPLTOq5B3Eh3u82qp8u9V/kZ2vyW/LI=;
        b=CyTiiDVgD2Q6puNJDGuqMIzU8erGJCd+RAIy/4bOjv9YVGW6Gr39fgBZwabUtb5hsE
         ogfU7YWIZBM6Nto6gyVPbqzj9B5WJvqH3Mh8vyWw1rKyhOOswqpqt87UPbkTRCWUZuZt
         /+KXLSY3PIROtHBAfsPrZEKSNcWYmKhNseD8lUwAALjNcxr44ws7GDouPvO8RDTc5vb6
         AXUUmUHq9zRnGrRCv4LJSnKTYtv2nbFaz6Z+eFINE8ftmhx9azNgmDZGUYdUk2web+BL
         Uh0ml+z8ZUvE7KHDmRTVptHO/WHSqA6jcEx6qaGC069vQQBlQdJQdr2CLN1Vg8uB7QFc
         Wylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737990044; x=1738594844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/y5ui3U96hxQPLTOq5B3Eh3u82qp8u9V/kZ2vyW/LI=;
        b=jTvY3wY444hGMMDkSnzVJveW0GqhXr4gyrK/AUoOx5LJ9xpDT9gDUQeePFRiv3weBg
         /xBVoLn2ZBsuWuYqS9xP5TDw+p8SOukpcTfJQAIJaDJMhfN+sUKjNyOWZDIvy1YT/Vzn
         m07E2SyjmwhzyfYMG8DHymFO9tDuG7J9wGw4TbIfikgZREEruPPY8Fv3NXJu0a96U6DP
         us0+ExrrA7bpvfJZaJUEwfhKfIY2rIcJwTEbym5G8ki5OZ0mvvsaDTelGWWzv/9p0DGd
         BtGSf8fuY71zHgM9CiNeB6+ERmHu8nCn4wLlDaziEDU9wlrEyLgnlyZmvKL/fSmuHNeJ
         8ajw==
X-Gm-Message-State: AOJu0YzhgzenEDht/mmyLe9DThR6MPF7vvrgyDb5rIzSfxTJYqmO9kVP
	guL2cY1wR3FNlIHauHIEHY3WDd0WQS1EJd5j4h0AFJXuoqSD14O6ziDsTIsf+pjAkp7erlT9SZn
	Ro/UNwrpA0JxZ4Au3MlU2GHmn2wo=
X-Gm-Gg: ASbGncuOjJqzIYwwxD4pzCxWN7nqXqrSFohcZiYrTRniKdTEPn+c6zXZnRnw1OgGGqU
	YYkADcC31ZR+gLhpp4F4NrG1T9i9FFCEq/D2d47hzraTOs948UPRlS7S+C8u75g==
X-Google-Smtp-Source: AGHT+IGJ4XqfcznHSLGuhROnAy/J97gnUEWbNKWHC7PFPjj6NYRikg8t8AQ9qFGSQyZP/cXVILI3i45JDN/DL8HtumA=
X-Received: by 2002:a05:6a20:7490:b0:1db:dfc0:d342 with SMTP id
 adf61e73a8af0-1eb21461417mr70950705637.7.1737990044339; Mon, 27 Jan 2025
 07:00:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
 <20250102164509.25606-6-stephen.smalley.work@gmail.com> <Z5b92VmV-tEM-MU-@lei>
In-Reply-To: <Z5b92VmV-tEM-MU-@lei>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Jan 2025 10:00:32 -0500
X-Gm-Features: AWEUYZkSVrNQaLWAJKzePrfOzxhhY-RrUJlM3v4auf7nUlCRKOzKTgQ5M16FZmc
Message-ID: <CAEjxPJ4kmttoP7=GvdX5f=oSCYBiB6MxHTKW9v=0v+Bq1EcvNg@mail.gmail.com>
Subject: Re: [RFC PATCH 05/44] netstate,selinux: create the selinux netlink
 socket per network namespace
To: sergeh@kernel.org
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 10:30=E2=80=AFPM <sergeh@kernel.org> wrote:
>
> On Thu, Jan 02, 2025 at 11:44:30AM -0500, Stephen Smalley wrote:
> > The selinux netlink socket is used to notify userspace of changes to
> > the enforcing mode and policy reloads.  At present, these notifications
> > are always sent to the initial network namespace.  In order to support
> > multiple selinux namespaces, each with its own enforcing mode and
> > policy, we need to create and use a separate selinux netlink socket
> > for each network namespace.
> >
> > Without this change, a policy reload in a child selinux namespace
> > causes a notification to be sent to processes in the init namespace
> > with a sequence number that may be higher than the policy sequence
> > number for that namespace.  As a result, userspace AVC instances in
> > the init namespace will then end up rejecting any further access
> > vector results from its own security server instance due to the
> > policy sequence number appearing to regress, which in turn causes
> > all subsequent uncached access checks to fail.  Similarly,
> > without this change, changing enforcing mode in the child selinux
> > namespace triggers a notification to all userspace AVC instances
> > in the init namespace that will switch their enforcing modes.
> >
> > This change does alter SELinux behavior, since previously reloading
> > policy or changing enforcing mode in a non-init network namespace would
> > trigger a notification to processes in the init network namespace.
> > However, this behavior is not being relied upon by existing userspace
> > AFAICT and is arguably wrong regardless.
> >
> > This change presumes that one will always unshare the network namespace
> > when unsharing a new selinux namespace (the reverse is not required).
> > Otherwise, the same inconsistencies could arise between the notificatio=
ns
> > and the relevant policy.  At present, nothing enforces this guarantee
> > at the kernel level; it is left up to userspace (e.g. container runtime=
s).
> > It is an open question as to whether this is a good idea or whether
> > unsharing of the selinux namespace should automatically unshare the net=
work
>
> Is there any advantage to not enforcing that?  Something useful it might
> facilitate?

I'm not aware of any other namespace that triggers automatic unsharing
of a different namespace when it is unshared. Patch 32/44 ("selinux:
limit selinux netlink notifications to init namespace") also makes it
unnecessary to unshare the network namespace if you have no other
reason for doing so.
