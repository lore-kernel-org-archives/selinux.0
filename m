Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672824A3E
	for <selinux@vger.kernel.org>; Sat,  4 Jan 2025 04:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735963719; cv=none; b=kZdDkJjKxKlVBmsQDrzBzIqeqOVY1AQ5d1EPzvsDkHrn5X/UhQ7k+zaOc3r6lOfNGvQwlyporToMx8XHh9jq7xfgcilW77FyYKztWckf593LkUsR78Lv7e5u4Q/2nMwBZXNpuPUD6Tfl3mvoSnnuXZ57020MNMID3dHIFaJ+Sa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735963719; c=relaxed/simple;
	bh=3UpnDtOJzKgx+LoOOuQo61yhJmr6TLg4sOc+YWpOYTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFravHtA2xnciwfTQBXAWo94mMBZ+i85ksiBnaYT54k1I4gbNefWD4ss2Z/LdpFkti8k/N4l7BS+BtQfkLEIi/MToWOm5Cn6kK3DE4MY6rONFfCPEMmcea7bWee72cqQs8957rHJ0gWX7EyYeCvMYFNrcGmFtLph3jnNt4LAFms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Gu3VljgO; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Gu3VljgO"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e53537d8feeso16270017276.0
        for <selinux@vger.kernel.org>; Fri, 03 Jan 2025 20:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1735963716; x=1736568516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJoUp6aQEd6YuI0OPpTYOOIFE/o7Rkiy+MOpCGB4Z/4=;
        b=Gu3VljgOWbUCcAj6IGvGcz5asn3qUTi53Kwr77y14JiIamw+9bmQHur9R/3WJeptvE
         yu0udFWzXnAWbQrZ6NS74VUXBQxbkiOc4FeZf0OPCoZJrYYAtc0dEG6pCsg8gTcChGQY
         Tg1gxpnfsDVEhcnQN7tFYj4Q7vamA/ZCjoD/TYy3nw5txAykaOGAVTvIax9/cb5E0DmC
         al4y4r26NwcYf6TLLn9Q3Y8QKX4njZMY+CbQWxKo1SvmiErFRqCdYsqYvBWOVSEN8wXq
         ZF71msebNdyE5wgvzN2bAezXnghrvJ8q/i81mz6/GinC1Nh4o4N16gg7rgdV4nm6ELJc
         D+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735963716; x=1736568516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJoUp6aQEd6YuI0OPpTYOOIFE/o7Rkiy+MOpCGB4Z/4=;
        b=SDfIwMvuFeV9cVGJ7aw4hRV7sAG2j1r81M2ItaI/7ygUHU1WhCE8i9s8bLpO7zOtXI
         R8HMo9U3IKQKPN1vKD2V6RqVDV8Muq7jaNFw8JLZU/arI83n+27+u8WIJkJI402KwMrm
         //V17sI0ltQmO8u0UdXeucFwOinXBduVeUUIOrpMFyxgxst8e4iaR3GNBrzND840MKC7
         53BqOUIRbTZdAYrYRMQxRbNYzwLMaRAJO3UBOBqXesl44YZoVhsVTWe3YSoJJp96XzBg
         +3n5OPFKblamWVBRL5eIoPYWzpxbKCotexyCs+T8UlOO2326QSEiua9HtiG7qRBk11cP
         VwCA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ0mAfGEj9nOq1GBXKxGos8Z2nhTN0wGTlBvJsKWTocvU2FLpI+nMw/a+/AznQtiNAwEq+Wui8@vger.kernel.org
X-Gm-Message-State: AOJu0YyElatT7H6VkqTbri3VyrPdDUM8yw19eoSwWNfVOCpVlto0/N4G
	f9V/A5NfNNDjkpXeVMEB3STu5W7oH45DPTuGjhxkv/gZWAbbyJ1CysGv01UvQhTdyMoGlz+KYna
	izwex1Ipw0ieMugCSG52xpkmmEbPZX4ToJ1UL
X-Gm-Gg: ASbGncv2aKowx9gizJWbhQ69jomkGdYflLptXqUqgWg5mzu90X54T2j+Omr0/A4jVCI
	IngB6Xn2Te9pTokJ3590PhS+tPvbEFyoo3IY6
X-Google-Smtp-Source: AGHT+IEuIlqWd8UHJJnk56wp+lw9KyANkQXRyn+Qg+hxn1KsmMY0Y9PJeT7p6cgjBCFok4HYT8jnpS6uSGl29C2cbuE=
X-Received: by 2002:a05:690c:62c6:b0:6ef:5fee:1cbe with SMTP id
 00721157ae682-6f3f826b29emr396260577b3.40.1735963716377; Fri, 03 Jan 2025
 20:08:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNuVK=Pt6Vx8xiUF7WFhCD3VrqjW=dvox4wHWZfHBCEDTQ@mail.gmail.com>
 <CAHC9VhTqe9roT1dySDXDMQzbOSZyA0f34H0a1xinDSLd-TyQTw@mail.gmail.com>
 <CAHC9VhTTGA5LADsn4OxJAUkd4V0auS4LrPQs87JqmRVV4nraxg@mail.gmail.com>
 <CAHC9VhTSeC3NAbAA192ZHQsRZe2aYELHM9inYOPRsR31wSyh2Q@mail.gmail.com>
 <CAFqZXNvJAQNLWZ795cj64FVG5zVzYtiTTuFzxOS5AwcfD7kV-w@mail.gmail.com>
 <CAHC9VhRFOm9DBXMF2SbwBxZqtPrr5ghbDRqcwjX6TP_79xDT_g@mail.gmail.com> <CAFqZXNt0KozfAybTnoL39DtOx+kx4QLgGVrA7z4c0aOqj4v2BQ@mail.gmail.com>
In-Reply-To: <CAFqZXNt0KozfAybTnoL39DtOx+kx4QLgGVrA7z4c0aOqj4v2BQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 3 Jan 2025 23:08:25 -0500
Message-ID: <CAHC9VhQwfWz9HPyeJOCVvn3Pb3mG6pR_pUiWHzyRNcj1v8o6BQ@mail.gmail.com>
Subject: Re: kernel-secnext aarch64 builds missing?
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: kernel-secnext@googlegroups.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 8:48=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> There seems to be another issue with the aarch64 builds now: the
> latest -rc3 RPMs are not present in the repo, even though they are
> referenced in the repo metadata ...

Please let me know if you see this happen again, but I think this was
just an usual combination of things coming together, including some
rather spectacular timing to catch the repo at just the right point in
time to see this.  I'll explain a bit more below if you're curious,
but everything appears to be working correctly with the 6.13-rc5
builds, at least on my test systems:

* https://groups.google.com/g/kernel-secnext/c/i4UAqrY5E8o

As far as to why this happened with the -rc3 build, let me first
provide some background:

- In an effort to limit the amount of disk space needed for
repo.paul-moore.com I only keep the last 14 days of builds on that
system.

- The job which uploads the builds to repo.paul-moore.com first
removes all packages built more than 14 days ago, then uploads the new
builds, and finally regenerates the repo metadata using createrepo.
While there is a window where the packages have been removed and the
metadata has not yet been updated, this generally isn't a problem
because 1) the time window is relatively short and 2) there generally
isn't much interest in "old" secnext kernel builds (it is somewhat
counter to the whole bleeding edge testing idea).

- When there is a significant backlog of packages to build, as was the
case when I restored the aarch64 builder, the package build job starts
with the newest src.rpm first and works backwards, because once again,
people generally only care about the most recent secnext builds so
this approach gets that build out quicker.  In this particular case
that was likely 6.13-rc3.

So, despite 6.13-rc3 being the "latest" kernel build in terms of
version, it was one of the older packages in terms of build date and
thus when the repo.paul-moore.com was updated with fresh builds, the
"old" 6.13-rc3 packages were removed.  If the testing farm tests
happened to start during that window where the packages had been
removed, but the metadata not yet updated, I suspect you would have
run into the problem you describe.

--=20
paul-moore.com
