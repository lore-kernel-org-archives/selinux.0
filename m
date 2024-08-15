Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ECB4F8A0
	for <selinux@vger.kernel.org>; Thu, 15 Aug 2024 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723752037; cv=none; b=JHC+iYhzZb46gk1FyD40HPaaradSV9ixNtIGOkPclKJk3Nw3kPV94oHSFy+2rqteWlXx6b4u/i3b4ySQ7gHjvTRoEeTUG2HxnBJsywqTtnAhT2yXDbzM7E6jKAv7YzvhJZIcdKz+MW0IiLT7x85tEjwcisBWpNdOdKQkVGGzCxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723752037; c=relaxed/simple;
	bh=xGYBVjCJruWxpObTcbXRaohepR1nP2OwaL5Zu9E+LTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvP26zGu5uKIrZJnRvv/y4J089YUe5hmhcpZ0tu+f3tEARAYfYyQ3LQzFzwITbOwoIzU3duvYe9bPKDnj+Se9YmGzJkMcraZF+5Z3BHCQhs9vztcCZwj7yWaafXjcRFEd9TwqfK/Qv2yiO5QbOROAzl4ddSaYXxr0cfX4AQIZz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XEoCxbyL; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XEoCxbyL"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bec7c5af2aso157a12.1
        for <selinux@vger.kernel.org>; Thu, 15 Aug 2024 13:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723752034; x=1724356834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3ArqisW88zeUJ5548euro8ampk/ZNm/xfRfsdbWrSo=;
        b=XEoCxbyLwL4HcM51EsZbF3tltEsLeG0fMLChLyci6j8xwhfdhsrk6PiWQztaCnghnC
         eaT2mcJ4GFV3M/3yL2RhFQQJf3dUVdRow4s3vrr2/+04q2tTYkdxTpp3dAklavj7Nqat
         qt3xj+w69yg9KR3KfFxFysAFY0NCnGqPh/+jZDSKE8vgmyM40WTWy39GMYmEuULcPvna
         aWkDjRKI0g9hrEGuYsZQoJniEdjA0Z1H51ZpwRfckEvQM/453k1oPkSM1Tb389rtf0BX
         OKs8QmWwYCgZDH20vSOLhDjMJhyNsMS6uelDMF9OtT2GHwOMx8BqyfLU4FfjClsjs7nI
         QfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723752034; x=1724356834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3ArqisW88zeUJ5548euro8ampk/ZNm/xfRfsdbWrSo=;
        b=tSaKG2NvIGAyvLVO2kCCS8/10RqtQ25lm+Z7NRTtvNIxRS44uT/XJOcoU7w7zGpP86
         YnfzO6Nrb668NXtFLoV54uHdpUSk4NGojTqp46GrTMD87JexqrxpFx97BQEehLs2zPQ/
         S4L5T1U26E65G7nc3ffzALcyYZGXq/t2pciMdZSh1JNTv8t9t3Hs/rzgAyX1iSfK/Fjz
         Y5QmyWQJZd7xFWLIPYv4pMCDlg9r7V7Yh82NXSypfgXiuRDAXZJv9uc5RIuuruaGU4Dm
         SGwBNcwDu3CFAKg7Q5SS7iKEIceZi7WG8aihTSbwWvczBHhm/ceFaGdsl180cftjc/B6
         jL3g==
X-Forwarded-Encrypted: i=1; AJvYcCVZSBczdBRSHDzvXlNPKVGcM1G4W1XihcvfXT6YBy7bliFlw4K0PJuGGox0BKPxXykkRbYBpCe6VeI+C4Rx/3KXmYMZ0174tw==
X-Gm-Message-State: AOJu0Yw5naySfKcshcHdtAYVyQWFlK3UqQ5BAq4JdXtYR36idgQ6zDTh
	aqdCp/8NOIYDlgIjYPvDXkan0sWxse/1lUGv8RBkfS0jiiJdJLrFPXH9tZnewcPf+cheJ6hqEgv
	q4JFDFyVPAHpyr6FBxxiR3bIVExs5TvTjlEzD
X-Google-Smtp-Source: AGHT+IFwS4EKwUlrFlYXcuSN5oh43sNNRYX1HBigJRCxXbMVgn7z8rfDqxIsTOr1QPI6vYSZFktXxOduALeTABTxFEw=
X-Received: by 2002:a05:6402:27ca:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-5becb50aa8cmr15762a12.4.1723752032713; Thu, 15 Aug 2024
 13:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805-remove-cred-transfer-v2-0-a2aa1d45e6b8@google.com>
 <20240805-remove-cred-transfer-v2-1-a2aa1d45e6b8@google.com> <2494949.1723751188@warthog.procyon.org.uk>
In-Reply-To: <2494949.1723751188@warthog.procyon.org.uk>
From: Jann Horn <jannh@google.com>
Date: Thu, 15 Aug 2024 21:59:54 +0200
Message-ID: <CAG48ez2LBmS91fQVLYRYEaBHssj22NyUjB0HVtkDHUXDvDZ6EA@mail.gmail.com>
Subject: Re: Can KEYCTL_SESSION_TO_PARENT be dropped entirely? -- was Re:
 [PATCH v2 1/2] KEYS: use synchronous task work for changing parent credentials
To: David Howells <dhowells@redhat.com>
Cc: Jeffrey Altman <jaltman@auristor.com>, openafs-devel@openafs.org, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, John Johansen <john.johansen@canonical.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	apparmor@lists.ubuntu.com, keyrings@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:46=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> Jann Horn <jannh@google.com> wrote:
>
> > Rewrite keyctl_session_to_parent() to run task work on the parent
> > synchronously, so that any errors that happen in the task work can be
> > plumbed back into the syscall return value in the child.
>
> The main thing I worry about is if there's a way to deadlock the child an=
d the
> parent against each other.  vfork() for example.

Yes - I think it would work fine for scenarios like using
KEYCTL_SESSION_TO_PARENT from a helper binary against the shell that
launched the helper (which I think is the intended usecase?), but
there could theoretically be constellations where it would cause an
(interruptible) hang if the parent is stuck in
uninterruptible/killable sleep.

I think vfork() is rather special in that it does a killable wait for
the child to exit or execute; and based on my understanding of the
intended usecase of KEYCTL_SESSION_TO_PARENT, I think normally
KEYCTL_SESSION_TO_PARENT would only be used by a child that has gone
through execve?


> > +     if (task_work_cancel(parent, &ctx.work)) {
> > +             /*
> > +              * We got interrupted and the task work was canceled befo=
re it
> > +              * could execute.
> > +              * Use -ERESTARTNOINTR instead of -ERESTARTSYS for
> > +              * compatibility - the manpage does not list -EINTR as a
> > +              * possible error for keyctl().
> > +              */
>
> I think returning EINTR is fine, provided that if we return EINTR, the ch=
ange
> didn't happen.  KEYCTL_SESSION_TO_PARENT is only used by the aklog, dlog =
and
> klog* OpenAFS programs AFAIK, and only if "-setpag" is set as a command l=
ine
> option.  It also won't be effective if you strace the program.

Ah, I didn't even know about those.

The users I knew of are the command-line tools "keyctl new_session"
and "e4crypt new_session" (see
https://codesearch.debian.net/search?q=3DKEYCTL_SESSION_TO_PARENT&literal=
=3D1,
which indexes code that's part of Debian).

> Maybe the AFS people can say whether it's even worth keeping the function=
ality
> rather than just dropping KEYCTL_SESSION_TO_PARENT?

I think this would break the tools "keyctl new_session" and "e4crypt
new_session" - though I don't know if anyone actually uses those
invocations.
