Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE14013A26D
	for <selinux@vger.kernel.org>; Mon, 27 Jan 2025 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990480; cv=none; b=uipl722mfLLpH2BjjbT6jtQLxCbQrHT55nXi6LSUfYXhxHKn1AXLujiVDKqY5txyptcraSJoHkW4/9KlsqSgizleEjnWNyeH9WhcYtA4cwRpAZeknMYM69nrF8ybwkpb8mPV1j4R3UZa8B8VEPwJWOiOLzYXf4NnWN2fESbKcx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990480; c=relaxed/simple;
	bh=uYwTKGvTY0JcA+XVzF8TV51qJZcAMUs9wdhgZQOzTVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcjpSgkuFiQcrFME7ErJKmdGh4ENWawGTLoVa/yZVAwrnwvBX55P0X5aVoIP2VfI7b0InRvUPuAytEsyPUo61WMgPXvpN4pYxaCE18AUShJwqJzWTgcXVMEWFiDm5qQJV34pSIXK+8xdBq4E9wlWQacIYD8jqDHBBwoTS6JIs7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3aAc0UT; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3aAc0UT"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef760a1001so7796840a91.0
        for <selinux@vger.kernel.org>; Mon, 27 Jan 2025 07:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737990478; x=1738595278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YhOqSdo2gf0MipwgE3H9AwaU5B8TxLT9IOWckDLGRw=;
        b=C3aAc0UTHwW3zfWahyf+nRUMm7+P0UAwQGmx/+ppFJ2yD/DHRDgSeHiM/XagXEbHSJ
         LCgnn84EZCf9TemzJ5+P7IawDpUVGiBY6MO34w1dqafZOISCYgp93C2pvLKhksg454b1
         1uUFz8L9KdSZzWF1dFSV24fcv8iOs0YBZH9i/aYCl6MpYzLCUHdGXjZBQ13SIqaDthKS
         KmE09bUn2AnZstSV7tqpD6d8TVzxL7ZYV3cJEdrvTwkwOZpwitUcq9lmF+X2kaoxKGPT
         aA8netdHBjkYDH8W77MYFwx5e2QTvB/6rW0vixr1zFNTAwH+yhJ3yEcZuY1WknfsWVia
         gllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737990478; x=1738595278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YhOqSdo2gf0MipwgE3H9AwaU5B8TxLT9IOWckDLGRw=;
        b=Nwl0FwNhOrqc8wL5vxRHUf6B3VJyQo2zKHMWRW3ByKmnoD6u9TcLR6vWANXX3UvqB2
         lDgLnYnZdLWCeRY21gUN4LB4ZDB+IbJGd3WIqtS0/PpZvBcG6C3NOTqZmmr5BUDWhlQT
         nCm1HyN9VzZsULlNNO3K33aJ5L6I2cxesLSDc8ZQP5fH60xxbagWAuXN2I8a6y+k6g2k
         QFBCk0J6ufLyC2o/Fmjo3WEcrk2nqjxQL/GdJfdanLbTytV3SnYNQLYS5Jz3kQoQDp3W
         z5rf40nMnmruqT7AFTkcZ5lOeVTiWquJZFgmkN3uKQsglGRSDshWSWoKI4QJrBLs/wX6
         9X8g==
X-Gm-Message-State: AOJu0YwK1LPIWiWwf3pTNxlDrjtwlfTVd0UHWNBa//3xSu0oCuByam8Y
	j1ASnH3WD3pBpAiooBwZMqGoKJKe+bIpWUKFw2hYwlYf/q4AuEStGKQ3jSr5ehCfjG/4xj6EoBA
	YSHZ18WKLWg6pM3w7F3gGQZ6Tw3Y=
X-Gm-Gg: ASbGncvkkERnnZsEfvmgitXWf8xyJv/32z2OFX3aEYZiiPp7L3U3mQDIo085qzxqBQx
	/148D3t/eA6yFlmT89RwiTfBkfFb1Uh0M+sCNJGNu2anviCpsO/WmFqzjUUHRIg==
X-Google-Smtp-Source: AGHT+IFMew62LJg57MfJYaLMr4trSucSNvMAg1ay55DCQgmPQPgbVgJQ6q/kz16YkcXnwjsVTSX2SYHPfVHV8aqZlRE=
X-Received: by 2002:a17:90b:2750:b0:2ee:aef4:2c5d with SMTP id
 98e67ed59e1d1-2f782d32bdcmr53443391a91.26.1737990477705; Mon, 27 Jan 2025
 07:07:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
 <20250102164509.25606-7-stephen.smalley.work@gmail.com> <Z5cAT7xpQJFOrjGf@lei>
In-Reply-To: <Z5cAT7xpQJFOrjGf@lei>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Jan 2025 10:07:46 -0500
X-Gm-Features: AWEUYZkxxjev_1tcssRdgxqAQ84nY-ReiAhpc_-EdoksUQ_tTvyPIRQi-cGYCss
Message-ID: <CAEjxPJ6JPQhDTy-x-PpZT42rPH-VRP=vr+30e9CFQ-=y=DAqRQ@mail.gmail.com>
Subject: Re: [RFC PATCH 06/44] selinux: support per-task/cred selinux namespace
To: sergeh@kernel.org
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 10:41=E2=80=AFPM <sergeh@kernel.org> wrote:
>
> On Thu, Jan 02, 2025 at 11:44:31AM -0500, Stephen Smalley wrote:
> > Extend the task security structure to include a reference to
> > the associated selinux namespace, and to also contain a
> > pointer to the cred in the parent namespace.  The current selinux
> > namespace is changed to the per-task/cred selinux namespace
> > for the current task/cred.
> >
> > This change makes it possible to support per-cred selinux namespaces,
> > but does not yet introduce a mechanism for unsharing of the selinux
> > namespace.  Thus, by itself, this change does not alter the existing
> > situation with respect to all processes still using a single init
> > selinux namespace.
> >
> > An alternative would be to hang the selinux namespace off of the
> > user namespace, which itself is associated with the cred.  This
> > seems undesirable however since DAC and MAC are orthogonal, and
> > there appear to be real use cases where one will want to use selinux
> > namespaces without user namespaces and vice versa. However, one
> > advantage of hanging off the user namespace would be that it is already
> > associated with other namespaces, such as the network namespace, thus
> > potentially facilitating looking up the relevant selinux namespace from
> > the network input/forward hooks.  In most cases however, it appears tha=
t
> > we could instead copy a reference to the creating task selinux namespac=
e
> > to sock security structures and use that in those hooks.
> >
> > Introduce a task_security() helper to obtain the correct task/cred
> > security structure from the hooks, and update the hooks to use it.
> > This returns a pointer to the security structure for the task in
> > the same selinux namespace as the caller, or if there is none, a
> > fake security structure with the well-defined unlabeled SIDs.  This
> > ensures that we return a valid result that can be used for permission
> > checks and for returning contexts from e.g. reading /proc/pid/attr file=
s.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  security/selinux/hooks.c            | 50 +++++++++++++++++++++++++----
> >  security/selinux/include/objsec.h   | 23 -------------
> >  security/selinux/include/security.h | 32 +++++++++++++++++-
> >  3 files changed, 75 insertions(+), 30 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index ad8172ae7fda..ddaf1f527fe3 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -108,9 +108,6 @@
> >
> >  #define SELINUX_INODE_INIT_XATTRS 1
> >
> > -static struct selinux_state *init_selinux_state;
> > -struct selinux_state *current_selinux_state;
> > -
> >  /* SECMARK reference count */
> >  static atomic_t selinux_secmark_refcount =3D ATOMIC_INIT(0);
> >
> > @@ -207,6 +204,8 @@ static int selinux_lsm_notifier_avc_callback(u32 ev=
ent)
> >       return 0;
> >  }
> >
> > +static struct selinux_state *init_selinux_state;
> > +
> >  /*
> >   * initialise the security for the init task
> >   */
> > @@ -216,6 +215,7 @@ static void cred_init_security(void)
> >
> >       tsec =3D selinux_cred(unrcu_pointer(current->real_cred));
> >       tsec->osid =3D tsec->sid =3D SECINITSID_KERNEL;
> > +     tsec->state =3D get_selinux_state(init_selinux_state);
> >  }
> >
> >  /*
> > @@ -229,6 +229,24 @@ static inline u32 cred_sid(const struct cred *cred=
)
> >       return tsec->sid;
> >  }
> >
> > +static struct task_security_struct unlabeled_task_security =3D {
> > +     .osid =3D SECINITSID_UNLABELED,
> > +     .sid =3D SECINITSID_UNLABELED,
> > +};
> > +
>
> I don't know the selinux coding style, but I would think it worth
> mentioning that a caller of task_security() must hold rcu_read_lock.
> As callers you introduce here do.

Good point. I can add that in a future version.

>
> > +static const struct task_security_struct *task_security(
> > +     const struct task_struct *p)
> > +{
> > +     const struct task_security_struct *tsec;
> > +
> > +     tsec =3D selinux_cred(__task_cred(p));
> > +     while (tsec->state !=3D current_selinux_state && tsec->parent_cre=
d)
> > +             tsec =3D selinux_cred(tsec->parent_cred);
> > +     if (tsec->state !=3D current_selinux_state)
> > +             return &unlabeled_task_security;
> > +     return tsec;
> > +}
> > +
> >  static void __ad_net_init(struct common_audit_data *ad,
> >                         struct lsm_network_audit *net,
> >                         int ifindex, struct sock *sk, u16 family)
