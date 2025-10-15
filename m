Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA187226863
	for <selinux@vger.kernel.org>; Wed, 15 Oct 2025 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760565240; cv=none; b=qX+6/+vDYx1epMUoTG9ybNHy+fZG0o4N/edCoCKO+JmQLfEdtN6myQhct9bEXTL9ML3wF5krJ+x7sIlF+z5ShygNlOIDvTlMq3M2BQGNtFcaaxNY5AqbCpGL3faNBrkNMIrSdf9JXG+Cbt3Khp2+xdXY4Htg76gACCU064S/Ttg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760565240; c=relaxed/simple;
	bh=UX56nlb0delqs1bXek21MMuJ1qboPWS0P5UAc13361c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0v4tl0yK1kt3qFweg60akBt3lAl2N4TfjguHnMKKUqlfcf8k+G3TBgKrIt3Zc2x7fbMSnZtEkfdJnXr9Mf78SvLPBJRv6ihIbl4yhLZzdzNCc6NW32mRkwuzIOP8d3qt6o1ZNtJcuWOTvPR/USgmPfh6cjYuYIW/Ci9tPwFg60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SQo9JHSp; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SQo9JHSp"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-339d53f4960so94530a91.3
        for <selinux@vger.kernel.org>; Wed, 15 Oct 2025 14:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760565238; x=1761170038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UX56nlb0delqs1bXek21MMuJ1qboPWS0P5UAc13361c=;
        b=SQo9JHSpSgwZAv7m8n5Aq2GlZ+hXE4K0/xANYX+/fUowpmKAV8Ssn/wC50xqmFOeMk
         ueYlPWs6TOXGZtqkjCP7xN4fwW347w/9XtAkom2x/YdD9dz8RWjmeREgy85rq5GPcMfi
         YmtDg6Lmy2h5HezAr4zWMP8wNt2zRsWAjA76DB/daf4ZZqQuhapbZUJys10cZ/2j+/vS
         4ZaJyoLhl2lPWFj6wwp4Vcr3MiTqmcEajLHlDd+ws2hJKFb5p7UjxtTXAOLVca9p3SIy
         TT8xKUkqPHRZ77vmyj6H0fB2M3HBfnbMKjUzKKQxtfJXJvE1ivKKyuoKPjmKOhpyN+9S
         oUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760565238; x=1761170038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UX56nlb0delqs1bXek21MMuJ1qboPWS0P5UAc13361c=;
        b=JB1CLmCmhyNjcwc6+DVDAAD8i8dG+HesT/W/m4cMqd41ddYZDgiw0+joYWENVir4ns
         J9zZq5nzHQTdO5W6kRVHf+rozMqdI2UDX3xy2mFjAp2CJ3Gerj2jXOlZxv4gkrLoD3KB
         OjyicW/ClXdK8HEwLY4MMaxJLrLwtoUD/0QPjxmxcZs2NMpE42X5Bt95Wb3I3DHA+k1q
         M38Wkkc1W593xTomab3QtTB2UvEbC88tI4gU/JPdmxUam5zOO0/Ae3uG4cxNuDz4Lzs5
         sTRaAAj8nYdH59/mbYqk9RSq/p6kULHAy43maIZOV+yQy24I4PVOwApH7H7iGJ56QOUs
         lPrg==
X-Gm-Message-State: AOJu0YyvCGbNTgNrqPgf94keopZf46ovm2E4ebkVB2yLztVInY7ard2V
	fnhQmLnEEwA+EW7pzWd5aHtaAayR59qvSorjaKR0aQfAWmn9EAKlYSzFWiJogfMfCUco9S/SVsd
	g8lPntzl9GHyDC0VAcEnBmEcGUT1sDMXUfg5vGuqP
X-Gm-Gg: ASbGncs9EM6ZNCdJKR1S/SSHnmuTvwu9eKrZMdpG2A5susMgbXbPjYIaTzhhXCgD9Km
	LB7A+lm8ZevKZ/Pwq1EiK+8kis3OQTo+gKkRNr7WzVBALU7WilaZXVucmeyJi78fSu4mLyPF8pj
	AFeTN5mewUVPStTQerV8yhJmig5Ys8aMS+jYZVJ++ww1pbwFUDYco6JATbtrc3coiicCAgMKYhP
	Fb2Baq/7nPQ5kkb9vJokjMw6Xo3g5zFCcYfnKo7W9Yk4z9a4dmSECUqY5pv
X-Google-Smtp-Source: AGHT+IHxagupuk19ft9p8E2+XslPn6hmuybfDCy6Uj8ancUU8kbdcOuntqeipkPzXOfH2woDn+GBckLsh6SJUZ1Vj3k=
X-Received: by 2002:a17:90b:4d10:b0:32e:ae12:9d32 with SMTP id
 98e67ed59e1d1-33b51169e5emr44328288a91.11.1760565238123; Wed, 15 Oct 2025
 14:53:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4CNH91Vh-5dF=43Xwg7WpSq8obKn+iAyg0HhqWqBzAUw@mail.gmail.com>
 <CAHC9VhQZ9wdb9Tr4V40kXu_40xF29+dizae2oysPL5LKnkfU0A@mail.gmail.com>
In-Reply-To: <CAHC9VhQZ9wdb9Tr4V40kXu_40xF29+dizae2oysPL5LKnkfU0A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 15 Oct 2025 17:53:46 -0400
X-Gm-Features: AS18NWCmxc6JHzI29b5pLN-O0zTX3HYC3D2eane-uUI7pdxv6cPSbrDQeCfn6IU
Message-ID: <CAHC9VhQwR8vu1ajp1NDir3KhWC=XW_TiqeNHKz2nHRWCHnADEw@mail.gmail.com>
Subject: Re: Fix for v6.18-rc1 udp test bug
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 5:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> ... I'll add this to the kernel-secnext builds now so anyone
> using those should benefit on the next version.

Kernel version 6.18.0-0.rc1.251015ge987e.18.2.secnext, or later,
should have this fix.

https://groups.google.com/g/kernel-secnext/c/6NKuDyD-DHY

--=20
paul-moore.com
