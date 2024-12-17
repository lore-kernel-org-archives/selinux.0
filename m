Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD84C14A609
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734453511; cv=none; b=rU0SXFEK+rUGVIu1Nq5+RYfv77sk4ty+9UhnQW7lcav/nCXZUR8byWAsUoZDq61rLHQflGZJsz+xEyJg7Xv9hp25ApwDjQAIzKH0rkVevtB97+zyny2XY+pMaIitXG02De7bpFnL0aR4qlaPU/ckRI3gzq2Q93447gWNfr6+KWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734453511; c=relaxed/simple;
	bh=7UyGz1erhVZpOEqfsBJnZOcXXNMwgFpgeCF+MsaS3xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBvvWXd6Lh/5mSxhufUujh40QWITADg1wKHvB2uFKf3Qk0HugSQPFdaCHpcKCihyxy7uHqBL1OvRfsHWK1vndD7dh6eO9gWSM+OXUGGA5en08pXyqW2YkI/hxuPElaK5/tHxncrUtIWT5MDal49FSoXMeEfZL2A2MKj0TrcTmOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BcjDvkAH; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BcjDvkAH"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e460717039fso2889731276.0
        for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 08:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734453508; x=1735058308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUoFXC0WD62FKsW34KEYJk6Kwp1XREjqmde+wBGePNo=;
        b=BcjDvkAH9Q80mOD12phiLcyM01ALpQwKWzj3MxMrrjVKA3NFQx6dKYYSaNtmBdXl4V
         FP3JT/N9C0sy8DXBDINAzRiN7FIRgxErNQqkxlZSk7qozRfUba9SBXgI5IeXbly9oG26
         dp4CR/lvy0UhRbJrzP4Ruib1h/EJfI7UndL4SeG142bKu9bYPmcua1oKPOZiWcM0Mv/p
         7IW6AvparIZaT8lXnuGVnhyANiqJ8pZv1MumBBuMqexHjMxJyUv++yL1kcUz9zW/oksG
         +8zw/AXBuPYNlEN5rhpJfjZHqvcQLVH+oPevSZmqGYbDwu6M4R6Lxi79yP8xNNih4yJw
         yjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734453508; x=1735058308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUoFXC0WD62FKsW34KEYJk6Kwp1XREjqmde+wBGePNo=;
        b=XLUZ0e+DK5sVLR2XiSfeY1vOwfKDwGWevvgfleazciyHWpyhmAKhGdGud/ked7Yb4n
         /IIUTbLtvEBUkJtS2tx95iV6/lM4ziYeGADVTl6/CR7nA3c2p7JMd07NbRg4KbcnIazf
         i9uTr7hPoCOFzMej7+QWOLOG67BurDHqaVLlD49Jt6SfLs9BADJzilNGHrJ7p/iyBx+8
         lgrJdDSDeExZ/ZV1ukaR+f1LhNDGeG9rYqNRS79hzmhToRjS0i9J+L0sqiP4Glne2oAa
         7nMOTox9suLsYvc0NoN31VyqEq7EUC9qcnG3YBZeQzkUchh8FJYztpYWrLG5gZsgm2Yf
         yEwg==
X-Forwarded-Encrypted: i=1; AJvYcCX7IogZ+Z5AfSHVoQA/ob8kQOXJx1gfWtNRal+lafLCAUwU0kJhe7jpaB4XI+8jH/WbcB+y2HUt@vger.kernel.org
X-Gm-Message-State: AOJu0YzGBoszAkKu/EZHyJF25xiQXzNsOwMUNlmMKWIQ8RJBqB0PjX9D
	AiUXj23oRZg3h3XSyhkOA/YJgkXPATqQ7L6739YByovCNqHr7AbRWNGwA+NNNaTYXABvCg2be9s
	VJoF4hRiQjhohWYWT9vPCMfd8czMkX+B2d26N
X-Gm-Gg: ASbGncuvoKdgeFBaSsxun4m3vZWZhmFdzqfIMW7jdukBPafy6S6CTNS5ja/OPOc9NeY
	hYuzvLhPs6SsHXMVxZciB3PLphwQZRXth+zxx
X-Google-Smtp-Source: AGHT+IEcNxCwdgmvgf0BHBPQlrk0dgTaTpUCYaENY8IAQsc6yTTYhXac0JjTeIAaLeD76MS7pGoFiBf0BpVZ2n6bvxw=
X-Received: by 2002:a25:11c8:0:b0:e44:82ef:3987 with SMTP id
 3f1490d57ef6-e4482ef41eemr9524836276.34.1734453507834; Tue, 17 Dec 2024
 08:38:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210115551.1225204-1-takayas@chromium.org>
 <8d8da243506dd9291fa5f02adc7f6142@paul-moore.com> <CAH9xa6ccd51V9fswkRX+xGfXHQog-wJQzB1LvK0pLT3CLYkfsw@mail.gmail.com>
 <CAHC9VhQrSGitY_TUAHbds-A8uQmn2TveTUrK-Jcd6quuMPHh1g@mail.gmail.com>
 <CAH9xa6ecz_P+GwLQ_73_M==WF8cZt3bzD9NJz84U9B4mRdTOrA@mail.gmail.com>
 <CAHC9VhTta96fojwPuf_JRTws92=BLqRPRcDc2sBTddH-50HxoQ@mail.gmail.com> <CAH9xa6d+zJRoZMO+ip_DR88vhxBf6PoneQBkrGuR7F6PqD1r-g@mail.gmail.com>
In-Reply-To: <CAH9xa6d+zJRoZMO+ip_DR88vhxBf6PoneQBkrGuR7F6PqD1r-g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Dec 2024 11:38:17 -0500
Message-ID: <CAHC9VhSVpDDGW7rKVCYiOtgq71yfXRWDWegyEx3Zp-BoS9dj5A@mail.gmail.com>
Subject: Re: [PATCH] selinux: support wildcard match in genfscon
To: Takaya Saeki <takayas@chromium.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Junichi <uekawa@chromium.org>, 
	selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 2:13=E2=80=AFAM Takaya Saeki <takayas@chromium.org>=
 wrote:
>
> > We really shouldn't have compatibility hacks when enabling policy
> > capabilities, policy capabilities *are* the compatibility hack by
> > allowing systems to continue to operate in the legacy mode until such
> > time as the policy has been converted.
>
> While this makes sense, as Stephen pointed out, neither Fedora nor Androi=
d will
> be able to quickly enable this capability in reality.

The speed at which a new nice-to-have feature can be adopted is
generally not something I worry about, it's a new *feature*, not a bug
fix so if it takes some time to be fully adopted that is okay.  What I
do concern myself about is the quality and long term maintainability
of the kernel code, especially when user visible changes are
concerned.  Adding kernel complexity for changes like this, especially
when they can be handled in userspace is almost always going to be a
no-go as far as I'm concerned.

> What do you think about
> two alternative ideas for right things; just start to interpret wildcards
> without introducing a new capability ...

No.

> or introducing a new syntax that does
> wildcard full match such as `genfsconwildcard`?

That seems pretty awful to me too.

If you can't be bothered to actually update the policy as you should
be doing when enabling a new policy capability, add the same hack you
were proposing for the kernel to the compiler/linker toolchain and
just start adding the '*' wildcard at the end of the paths.

--=20
paul-moore.com
