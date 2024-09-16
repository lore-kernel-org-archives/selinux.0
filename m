Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07847165EE2
	for <selinux@vger.kernel.org>; Mon, 16 Sep 2024 21:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726521314; cv=none; b=rKi92xbuoJAQZF6c578ovLGVd99bmEu8TcGIY8IuktA8z3cfy0sPh2FGFw4jVIuSm2DLWQmHrBlI1Y1sDoD2Q8Qdc+0SQzx3PLcX20iSowM8ogpFlclI8kff79i/yudL9Ob0Yuro+2EVt1lXon2XNJf9OVGDCxF3CeEbkyzbWds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726521314; c=relaxed/simple;
	bh=jsP4BpefWGxRC1SsETIlVv45lPzMhi8m9W79ZBrx1F0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J21vjfT/E8xTbQ5qr9Oy9/9GRvQoZdmQKEUp0YWw4PjGC/L5jhXhXpXAaSUGrRTRKQ2EvMpW6fhACGs5AFgFk46VQsHZspUYSBuiC+Qg4e2b0cypWA4M65olqCOpnspNJg7lK2/fkKJbJMlZnivVXh5PD2uRcM+X6vSrwJrvQh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jlu1YcLz; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jlu1YcLz"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c2460e885dso8366a12.0
        for <selinux@vger.kernel.org>; Mon, 16 Sep 2024 14:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726521310; x=1727126110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9leef1lP79QdzQSlMu20RvsBQRhUgfHGz+v151OddCM=;
        b=Jlu1YcLzmx45LjdHR6gqD+YPMYTOLGbeoySXwl34ODW2tfzjiu8+RvB2MjdYZW6n6K
         3azYz/kdJ7LSWtAkef00K+c8ZL08/NAMcLxJxP4hM6/u8DIfuj0mu8tqmf9xDP+AKM3f
         v4fzrCwFx9nPzTO40ljd1W9ypQjXn44T6yZtZlfiMnEV1tu01TAi2Os3Jd1HonqBG/65
         ovlKRS6OUNBD/YFKa4og7UYYBrvwOSbE/7g1iFHiruKC5AN2NVNNryKuUGuv5Mz0o+Q+
         dYX4GMaHBw/728lNDkVesyvH9G9NqWG2L7EiNJl4VDgsQF50yD/m1pFMNaxhSsCo8aqy
         3J2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726521310; x=1727126110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9leef1lP79QdzQSlMu20RvsBQRhUgfHGz+v151OddCM=;
        b=eJwZF/PzaCV0IxJNYkFTniZHWlhHCvkvYFS3Ss7JtT4U6jRaVhfvhhG9yF8Pmfw6/n
         U7ATiPSNmplxB7SGiY1uh1XCrYTFScJZAdTQob1aX8eOoq1CBEcj0yXpv328ctTLi/BV
         ma9r78jX1dUb+lcFFYOFnl5FqOXcYk1nKvUeGAQOiURNLmoz/hjfyPFEKkVZ005fREnO
         DNLOO6QFg2/cdUDTeZp2/z2gabXm/lh1h1fEAzs3XQWGNuj7ln1ghiYtR1cWtwKP3HrY
         CxMdXCfZIBozqcchM6+0lVOl7ED8ms7eD/30h8eoWyC/BN5cXZuB6q0VExycj9N87GQi
         DBtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCemtqcDGKSntKNUuFjy3/cZOLVxo8SnCObli+E9B1YGW+ZlOR5CdrCUp3hcLGpQU0+0a4mVK2@vger.kernel.org
X-Gm-Message-State: AOJu0YxLUQbccGHwHhIkynu9eQwvZ6+/aNxE1UlQAJ3VJyVlZFpt9GYB
	N5UYuXhjUm7WOoWw5fCGjDrbxR5jqJzLLXXWjLZnSVRBG2iKDjn1kQq0/gvN3XZeFdE2kKwE5vz
	hkC6JpazVq1dWwFQmkE6AfA+fTHtD37xdcyvv
X-Google-Smtp-Source: AGHT+IF6dyyQJaSHZbZwngVDJVdsJApUMqXalKKi0actzWHOX8EqkqUTgpJ77CsgYsbI+x2vL0Ykn2Y5eGpt5/BHf5s=
X-Received: by 2002:a05:6402:348c:b0:5c4:2c6f:e265 with SMTP id
 4fb4d7f45d1cf-5c4478072b6mr15387a12.1.1726521309278; Mon, 16 Sep 2024
 14:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805-remove-cred-transfer-v2-0-a2aa1d45e6b8@google.com>
 <20240805-remove-cred-transfer-v2-1-a2aa1d45e6b8@google.com>
 <2494949.1723751188@warthog.procyon.org.uk> <CAG48ez2LBmS91fQVLYRYEaBHssj22NyUjB0HVtkDHUXDvDZ6EA@mail.gmail.com>
 <CAHC9VhSPcy-xZ=X_CF8PRsAFMSeP8-VppxKr3Sz3EqMWTEs-Cw@mail.gmail.com> <CAHC9VhS5ar0aU8Q6Ky133o=zYMHYRf=wxzTpxP+dtA=qunhcmw@mail.gmail.com>
In-Reply-To: <CAHC9VhS5ar0aU8Q6Ky133o=zYMHYRf=wxzTpxP+dtA=qunhcmw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 16 Sep 2024 23:14:30 +0200
Message-ID: <CAG48ez2hhu8AXgBR=ze9RRLDpB0V1rzUX2Xr2e45giV6ebTxMA@mail.gmail.com>
Subject: Re: Can KEYCTL_SESSION_TO_PARENT be dropped entirely? -- was Re:
 [PATCH v2 1/2] KEYS: use synchronous task work for changing parent credentials
To: Paul Moore <paul@paul-moore.com>
Cc: David Howells <dhowells@redhat.com>, Jeffrey Altman <jaltman@auristor.com>, openafs-devel@openafs.org, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	John Johansen <john.johansen@canonical.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	apparmor@lists.ubuntu.com, keyrings@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 12:46=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> On Tue, Sep 10, 2024 at 4:49=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, Aug 15, 2024 at 4:00=E2=80=AFPM Jann Horn <jannh@google.com> wr=
ote:
> > > On Thu, Aug 15, 2024 at 9:46=E2=80=AFPM David Howells <dhowells@redha=
t.com> wrote:
> > > > Jann Horn <jannh@google.com> wrote:
> > > >
> > > > > Rewrite keyctl_session_to_parent() to run task work on the parent
> > > > > synchronously, so that any errors that happen in the task work ca=
n be
> > > > > plumbed back into the syscall return value in the child.
> > > >
> > > > The main thing I worry about is if there's a way to deadlock the ch=
ild and the
> > > > parent against each other.  vfork() for example.
> > >
> > > Yes - I think it would work fine for scenarios like using
> > > KEYCTL_SESSION_TO_PARENT from a helper binary against the shell that
> > > launched the helper (which I think is the intended usecase?), but
> > > there could theoretically be constellations where it would cause an
> > > (interruptible) hang if the parent is stuck in
> > > uninterruptible/killable sleep.
> > >
> > > I think vfork() is rather special in that it does a killable wait for
> > > the child to exit or execute; and based on my understanding of the
> > > intended usecase of KEYCTL_SESSION_TO_PARENT, I think normally
> > > KEYCTL_SESSION_TO_PARENT would only be used by a child that has gone
> > > through execve?
> >
> > Where did we land on all of this?  Unless I missed a thread somewhere,
> > it looks like the discussion trailed off without any resolution on if
> > we are okay with a potentially (interruptible) deadlock?
>
> As a potential tweak to this, what if we gave up on the idea of
> returning the error code so we could avoid the signal deadlock issue?

I'm still not convinced that there is a real danger of deadlocking
here if the only way to deadlock involves the parent being in an
uninterruptible wait. There aren't many places in the kernel that
involve a parent uninterruptibly waiting for the child without locks
being involved, especially when the parent is a shell that spawns the
child with execve, as seems to be the intended use here.

I really dislike the idea of silently ignoring an error - I kinda feel
like if we give up on returning an error to the child that issued the
keyctl, the next-best option is to SIGKILL the parent, so that we can
say "hey, we technically ensured that all future syscalls in the
parent will use the new creds, because the parent will no longer do
_any_ syscalls".

> I suppose there could be an issue if the parent was
> expecting/depending on keyring change from the child, but honestly, if
> the parent is relying on the kernel keyring and spawning a child
> process without restring the KEYCTL_SESSION_TO_PARENT then the parent
> really should be doing some sanity checks on the keyring after the
> child returns anyway.



> I'm conflicted on the best way to solve this problem, but I think we
> need to fix this somehow as I believe the current behavior is broken
> ...
