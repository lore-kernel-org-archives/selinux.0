Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C39B25E800
	for <selinux@vger.kernel.org>; Wed, 26 Mar 2025 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743022094; cv=none; b=n14Fx66aylC2ELZ19y+Wz6ehzKDs5M16I08Moa07+4i026sVvhNE1sAdbWjih0u73MipEVLLHD7VXR9OmeSqpoUHCO2kdLMlel2ezyj7GqnuiJkf5oboibsVm+lSiOcCN8qFvdgX6rFtjgJFsKC0XhPxOecmffHC6WwYPlrmgwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743022094; c=relaxed/simple;
	bh=lkwNgZSqUlm9DJirk/oVV9tPmlsUXC77j/zjRQBf3B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3YU7jCgRTw4vvU6DzZYNcl+mLjuHXUkq+whyVAMd2CPingaCbTAa6HlhknjfWnH+bZQWzMlXl6Hn5EdrseuNetBSyujlWxpvm4IDLjC79ZeaDoNSwkgNYj88jUyNX2Q9i1/qmUZxf5aDaDHUz0lWEy+DtCVYfhwGF7qCcd0GW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F6X62d2+; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F6X62d2+"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e643f0933afso1205282276.1
        for <selinux@vger.kernel.org>; Wed, 26 Mar 2025 13:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1743022091; x=1743626891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KugdLRUS2IB/bWcBImczTBUF8xvxY/0i4eovnJ/pJc=;
        b=F6X62d2+OJfKCwhsA6Vh+qLbkDeDYnzecTxBZ15ubeyfAk61vWwZ84hUXEwJ7g2BYW
         oEM8vlHrNHVSukS3R+XmA9xwuEelzlnX/Vv/l36Z1qZp1i4O+S7SYuIaQ0qMbjVTxQRY
         9VUAfCQFo2HslAoLchRsXyWDpKfzSLpOYPyFiHKdFEj11TZF9GXxwAiszDzgqhhHkM8K
         pq+S4P2Csytc9k1Sw9nrc2g39a/1uaUl2LhAICIHHMb+xua1adF41MvYD2vPn2GYZVj0
         IVpVAwg//tQ+u268GeHltkrFYbQpmmlfg8Xk90bsrpmEX3rWqar989mwT3nMQK4jWLN0
         F92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743022091; x=1743626891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KugdLRUS2IB/bWcBImczTBUF8xvxY/0i4eovnJ/pJc=;
        b=hHhBqyU4JtB8JpeldR4AjRI5xSFmoj9qdZCNJfDr3HiW5ZkepT7qzOBOru4kGMuxpa
         xy58ctC6jazeSgns0V1R6z9th7B+N878JTVC36JwMzj4W1n2WH7jKH2TLZzNZiAF9MCR
         S/j658JtNhZT1dWuO6/dCddATtQ6wYh8lhmrqxPaHwbjrqw6BOn/jbHNTMyXOXvcA6u3
         mp5M2yOcVOzIy7ztu8FU/7hWXO45CjBbTNi4upp4lXe0nAlUy+4zJhtv7170vEzk/sf8
         7wqxYnR93l2hy12Qu2Yp/0BoGaZ6RVI8aDM/p7PFOvKSwJfM6vA2J5Urv6xfK9AqaPxx
         hMww==
X-Forwarded-Encrypted: i=1; AJvYcCUXGmRlyXUez4IW6nDWeMWwRXXwAaGBH8n95L8a7E/eiDK7OnmLIWq+/eNAxWZxEkoZ2dHQXwAX@vger.kernel.org
X-Gm-Message-State: AOJu0YzrXEmea9jhioBg+NtmK38hFVlbULHGw7H+0uKkK+vga4k2tvvS
	z5ZOmS53KlWQPaUvUx0UkUeEuLwi8lPIgbMvEcbG2bE0ZdL9VpL04RJsqvh0MZIcSb5gdSkn4nD
	NEbYG1pcaXuCpriTMeqRZVNpV7c7Ms3ZPQoXi
X-Gm-Gg: ASbGncvFvJoryyRQNTMIMBgAJfBp2r8HBbOSASfwlxEvAaap1ZjGgmuQfESQV+qTsUE
	ow8PY+6duTnxH+kZ7OiQ7pL2ys1xAaMf4AyLIcZTdTtH1waWPPylMOfJ6udnLe1hFeZ5dOMdH1D
	PfhANVKk3SbBvhg1qSoFw58T1hTA==
X-Google-Smtp-Source: AGHT+IH2jQrsJDcBGNU0CPjcKd4UHxAwQucgB3nqCzI3sVup8fdoHxy8f+YJtEB/KLQhTPeRracAiI//nfAKZ0B6MVY=
X-Received: by 2002:a05:6902:2808:b0:e5b:32f5:e38c with SMTP id
 3f1490d57ef6-e692ecfbe45mr7747622276.8.1743022090883; Wed, 26 Mar 2025
 13:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
 <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
 <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com> <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
In-Reply-To: <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Mar 2025 16:48:00 -0400
X-Gm-Features: AQ5f1JqLL8hQNV93T465HG7TmuUvsJm2aGb-Tsdg4Dg6IQiLpz7nTzcvVAy5xw4
Message-ID: <CAHC9VhT3D7X=4SpO5xbYm=JUwJqTa7tn=J6QMDBV96c7VBUw4g@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Cameron K. Williams" <ckwilliams.work@gmail.com>, "Kipp N. Davis" <kippndavis.work@gmx.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 3:40=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, 26 Mar 2025 at 11:36, Paul Moore <paul@paul-moore.com> wrote:
> >
> > From my perspective this is largely a continuation of our discussion
> > last April, and considering that you ignored my response then, I'm not
> > sure typing out a meaningful reply here is a good use of my time.
>
> What you are saying is that I have complained about added overhead
> before, and you aren't even willing to explain why new code was added?

My comment is simply that you have a habit of disrespecting the work
done in the security/ space (e.g. "security theater"), and despite
explaining how that behavior is detrimental you seemingly choose to
ignore these concerns and repeat the same tired language.

If you want to have a discussion about something substantive, I would
suggest refraining from insulting those you want to engage.

> In other words: why were new policy entries added? The commit message
> and the list explains what the commit *does*, but doesn't explain
> *why* it does it.

Looking at the pre-patched code one can see that SELinux only enforced
access controls on kernel module loading; other operations such as
kexec images, firmware, policy, etc. were not originally included.  As
this happened back in the v4.x time frame I would have to go dig
through the archives to provide a fully accurate reasoning as to why
SELinux only concerned itself with kernel module loading at that point
in time.  However, speaking solely from memory, I believe that the
initial focus was limited to modules simply because that was the area
of largest concern at the time, and many of the other file types were
not yet gated by the LSM hooks.  Moving forward to the recent pull
request, the LSM hooks do have the ability to gate these additional
file types, and for a LSM such as SELinux that aims to provide
comprehensive access controls, adding support for enforcing controls
on these additional file types is a logical thing to do and consistent
with our other work.  The fact that these changes didn't happen at the
same time as the enabling support for the other file types is likely
due to an ongoing challenge we face where we sometimes fail to keep
current with all facets of kernel development.

--=20
paul-moore.com
