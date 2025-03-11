Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96376088F
	for <selinux@vger.kernel.org>; Tue, 11 Mar 2025 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713285; cv=none; b=BjffYML+bYVo1A4Wl2eGUxLFZLVO2p+X4JlTu0byi9eqKgERlYAs05DXCjLCrJTzghzsyt7m0xYDdcOA3ygT/TPyPo1foBX2GngKxKuKZ/nqEBqbo2+K5zqno+EKXTi+Evj1hLmNYlPa8QSYLMW99STQFg0IYXOL7MBxhEd/Glc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713285; c=relaxed/simple;
	bh=l5YZ8a/8EJZbiw/7w/i3eB7PvIOZtmMVZ+Vo6I9qkxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgZf6M8vKhqXDwqImTWrdZGm3gAmLCFOkyBKon3eCIBYpZiDHvTVtbGXHjrjG+Lu8gYfdyDtB4cLY3Rwu/6svU3lj1bAx7lVEdjB22nu5d+DrHbhBV1gvCfaDCEbmVr4cg0vkgCxaKrIm3oZo8nShJIq+9Og8BYg86xbyxIbi8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgoYu1Q8; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgoYu1Q8"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff4a4f901fso8662451a91.2
        for <selinux@vger.kernel.org>; Tue, 11 Mar 2025 10:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741713283; x=1742318083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JIyLqs4ErQg6GuZaZND4XFzQiKVD16wTZNoMfHF3Eg=;
        b=NgoYu1Q8bPNgZZtfI7Xvi1/PGwEViDZnam/jXYd382JQFOpVFCcYkVQ7ftvCnbtUKJ
         a2hPPWorZuh8bgWCh6W9dK8aY9at490BwcMHvDeQuuj234hx5KMOzGG73AqOaLB9OA6q
         zm+W+/dWB7RDKkn0rZIadT0PMAzTrFBoDxj2a14mrVaZ+osvMXMJdywlbtV/Ndsc0TmH
         tr/meo9OVHSTJM15IUN3oD0BsSfpHCZA2rirE0Iox1PIo1sN7XV5aCgOtOHFO3GEz5XU
         bTPxTd87zAVy0WBHUrW7nbNm1dEL5gaDWyhA8kRXCdYLmQtBA9jzxO9w16FFyuzz+gQN
         aqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741713283; x=1742318083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JIyLqs4ErQg6GuZaZND4XFzQiKVD16wTZNoMfHF3Eg=;
        b=lyNBtwKf10i8mflQ8I3owdd0CEQMZ8Opoub/GA9263NLmPEYTrN9JwwfM+UqcfwS3o
         2vVr4W2THcMFsq77pTbIXmHw9hvNkNhIho80OUTNcqOlzYaaInmCowkS79pP6Oi56j0d
         X00SDtqfK9WG69caRTjl+DWFZZFAIQgwlu1zt8OxrX8bqQaeg9+I8axPky+bdduw+wO2
         J0Vni7nYDV0ZFE8saErPfmi7+E9aWeHhChyuS7qBVesx+m93R45ppcVQnezV+Df3f0w3
         +U05+NYeNlPan5xk4+TvM0vef3x1rF2c/6Nv2TIvytDsQtJ+KFKJC4uKoPkpu7C+Lqr+
         xYKg==
X-Gm-Message-State: AOJu0YzNYALT0fNpvLMXv6w8jGfvPWoijOD4P8lmc+FHITpRjcIREaHb
	7XVL9U56pbrvaQFJZyACZR6IwXdRh3R5flK6gtilc11TBSVLfWXuY595W58kL5M8rfQUUbUuBY1
	0MCJ5bkMxca0cBcU3OlTqILOdUEo=
X-Gm-Gg: ASbGnctrmAT0HbJ4DXQTF17sudZvGiDR9s5JI1chBOUj/9aRBpI0VJs0FK0P77j6nfV
	qGPUI0+H55fhGyQqbgiqhZ3nBuruEeRsz6OVR81GpBJ5VpZ46oJ3hHGx/sKx4O8kcqqaYFG/pk5
	JiZIoaYcIG1tzZeLJiqnmJ4o6AWw==
X-Google-Smtp-Source: AGHT+IHNibnQ0QrxdUNsdS2FNLgT4mZ8I9MwX99pHW0Ief1wh19miAn4Ub5YQFetYavC+cMAmt3NQbBe0ShJ5Z+3PCc=
X-Received: by 2002:a17:90b:3906:b0:2ee:c6c8:d89f with SMTP id
 98e67ed59e1d1-300ff0d6160mr6186034a91.14.1741713282906; Tue, 11 Mar 2025
 10:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHT0Tqz+vNUAb4DTnon-w9_uN8yBBbqjnfu2vXsJAuczontmYA@mail.gmail.com>
In-Reply-To: <CAHT0Tqz+vNUAb4DTnon-w9_uN8yBBbqjnfu2vXsJAuczontmYA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 11 Mar 2025 13:14:31 -0400
X-Gm-Features: AQ5f1JoEDbCvldhchhxAQb2ZYO53AEb9bVwvexnUmfBF1fkSDLDGbWpB9AyP1Es
Message-ID: <CAEjxPJ6dWiiGGDbYd6aqbZZv=x5aUxTdxMjd+oxeibQ1YyPfHQ@mail.gmail.com>
Subject: Re: SeLinux, Heal thyself.
To: Darvond <xanthinzarda@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 4:52=E2=80=AFPM Darvond <xanthinzarda@gmail.com> wro=
te:
>
> time->Sat Mar  8 16:43:30 2025
> type=3DAVC msg=3Daudit(1741470210.428:2587): avc:  denied  { dac_override
> } for  pid=3D248048 comm=3D"touch" capability=3D1
> scontext=3Dsystem_u:system_r:setroubleshoot_fixit_t:s0
> tcontext=3Dsystem_u:system_r:setroubleshoot_fixit_t:s0 tclass=3Dcapabilit=
y
> permissive=3D0
>
> Context: SeTroubleshoot says possible fault in system labeling. Offers
> a button to fix, Authenticate for fix, errors out with blank error and
> trigger audit/alert.
>
> Will manually invoke fixfiles and see what happens.

The denial indicates that setroubleshoot is trying to write to a
directory/file to which it lacks DAC permissions.
You could workaround it via a local policy module via audit2allow but
it would be better to have it write to a directory/file it owns or fix
the DAC permissions of the directory/file in question.
These kinds of errors should really go to the Fedora selinux list
and/or bugzilla rather than to this list, which is for upstream
selinux development.
