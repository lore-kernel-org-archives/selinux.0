Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FC420ADD8
	for <selinux@vger.kernel.org>; Fri,  4 Apr 2025 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743783854; cv=none; b=cGPqdVFCoL+LfnRYWLSKy02L+pkZ8ybUBuC7rV6ZPCpMiE4BNHnZc592zwuXTr2pbS7VdCEUlZUaujIqiztoJng6FvnHZ9O895UaaRVgCjb+oP5vwv0Dlskmwu63Dss4UIBDE3CNlam1bCdjQ+V1tASR8NgGvlgwxSbesPlrAKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743783854; c=relaxed/simple;
	bh=um5P710ZAAnyS6tdD8bQNSy6UYBGoVcwz39q8BphDo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihVD1r2OKfowRco+/Annxzp3bkuEBajWam/hpQAl88WtY63rt3vKuzA9gkpUEmOiKTWqsc1Zpy0SrnQt3zKqg8TsbtApMfVXEmZIaDkXfGacoVvYauhj9CvFC0RAQw6lDzJmekzV93Vrpf4yV2/jNiM24SQi8CFQhYaSIhzKqqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MWSxxkBi; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MWSxxkBi"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e6dee579f38so2017308276.0
        for <selinux@vger.kernel.org>; Fri, 04 Apr 2025 09:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1743783851; x=1744388651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TofXaZuuC5maN+ISUqOxmJvqOmaxaR5w4I+IVIGf2kw=;
        b=MWSxxkBiZ4nc+if0a62h+Wv4jWA61EtiRiPcrkMkzkGIygdaE1kcJjs09/zosxEOy4
         dy+op9wVgSRbKGEbyI3F7Ihl0YYE+52NkqjXhyAszKHbEr15aAkmPes8Le/VrLhqRLwu
         dfPKWNmO4pQ53XlhFmRKD8PaV+bt4TqVHfpszlJPpXbR+AFEPLEMWwLJzwlrpEblZGxD
         Xx/m+oW+WRBwQh+m02pFWsgq7e0avCcV1AchIiNRqBMqnMOqQa0R8SiMOsLN3BQ8ChxO
         /08Rr87qVkiFd+CNMS3PeUYQFw174rNPfcDCTZoLftT+34GaZAM9x/a//m9dlOAv5Cus
         CIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743783851; x=1744388651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TofXaZuuC5maN+ISUqOxmJvqOmaxaR5w4I+IVIGf2kw=;
        b=InfLgwd5FC9kkDToexsUHmEU3mw9QYwKuRdR9AYcXS2SzpMff5X9rxXdBlMNsX0wRe
         SzeSS+FxWPZ0NLdeFnVmCdE1f12NgmZjrroYKxNZZ3TD4NOnd3Itxs9qkLi5uLoYNra7
         W+gJ7JboewkWmghvaio1kY/1yL8yao1bw0BKo3siDQDe48D6fJtlSlbYvcl+518ZzqRG
         nr4+3bRsLyUn2iGuxfgHf+qS+NaT8tcnjP/5z9OELjYPsbMU2xYCsHWt86mbKsJEhki+
         46V8Ec9yakQ+0dQFY8fhfCNAHcPvu1H6wK2TvQvkL2bkTAtv+5b807n6703ELt8HQ7Kz
         a6ow==
X-Gm-Message-State: AOJu0YwILjIxipZUMbRT9hNsz6B51f3MeyGAIqrRImWNZPZgelTyzdju
	ipQvSnYSHSlClU4mCYmwjjrTQpoT6zuppvjrQRD77t4G6lysiYRbL8kD1vvrEV0Ue7SRZBa9w0R
	HhiTU15yvg8jVuigvkOseZAOUZpDYabz/gSo0uySkFj0763E=
X-Gm-Gg: ASbGncvUNj9TsVYz7f8AaaVPRgw2fTnyTiY1VWWp2gdBJhPspxBHCfHVWDUYEzci/dZ
	NMEnFlLV9jbVjnrkIIkEqGi4A7GGivx4kU/mETWNDyC0EEvq9Mw9F4mTYZWmCmWyzzpMFovgH2y
	0tZTfcVbhiCIUU+fntuaUkRP1CYQ==
X-Google-Smtp-Source: AGHT+IEd3/pdmWyVExiKVRSac9OGa/UPiq4R8HjURoH0kRIdggdOEdAZ73v29cQPJRynvgFM1jviwZVTkSN8ZlPhSTk=
X-Received: by 2002:a05:6902:1b04:b0:e63:6b6e:8d93 with SMTP id
 3f1490d57ef6-e6e1c2f705bmr6919858276.20.1743783851229; Fri, 04 Apr 2025
 09:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402203052.237444-2-paul@paul-moore.com> <CAEjxPJ7zEv5zt5i-fhrnytQKuu4YUEZSXUNjvZcOsbh6ETs99Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ7zEv5zt5i-fhrnytQKuu4YUEZSXUNjvZcOsbh6ETs99Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 4 Apr 2025 12:24:00 -0400
X-Gm-Features: ATxdqUHd_TIoNAsmHKeiwa06opZ5T-fbZMg6fknmaHiz34wDImAAZBDlrLqG9_Q
Message-ID: <CAHC9VhRG0nVUtpcmTUvuJaznhT+noVwtJWGgJ+0ZfOZj=uBoCQ@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: reduce path walk overhead
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 10:00=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Apr 2, 2025 at 4:31=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > Reduce the SELinux performance overhead during path walks through the
> > use of a per-task directory access cache and some minor code
> > optimizations ...

...

> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 7b867dfec88b..df2bc01175b4 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -278,27 +280,20 @@ static int __inode_security_revalidate(struct ino=
de *inode,
> >                                        struct dentry *dentry,
> >                                        bool may_sleep)
> >  {
> > -       struct inode_security_struct *isec =3D selinux_inode(inode);
> > +       if (!selinux_initialized())
> > +               return 0;
>
> Any particular reason you didn't lift this test up to the callers as
> with the isec->initialized test? Or alternatively, leave these tests
> in this function and just inline it?

I'm working under the assumption that if the user has enabled SELinux
the common case is to have a SELinux policy loaded.  Outside of some
automated testing bots, we haven't really seen a lot of reports from
people running with SELinux enabled but no policy loaded ... after
all, what would be the point of that configuration?

Anyway, leaving the selinux_initialized() check in
__inode_security_revalidate(), as opposed to the callers, means we
don't hit that check in the common case where the inode's SELinux
state is still valid/initialized.  If the inode's state is set to
LABEL_INITIALIZED we know that we have a policy loaded and
selinux_initialized() is going to be true.

> >         might_sleep_if(may_sleep);
> > +       if (!may_sleep)
> > +               return -ECHILD;
> >
> >         /*
> > -        * The check of isec->initialized below is racy but
> > -        * inode_doinit_with_dentry() will recheck with
> > -        * isec->lock held.
> > +        * Check to ensure that an inode's SELinux state is invalid and=
 try
>
> is valid

Fixed, thanks.

> > +        * reloading the inode security label if necessary.  This will =
fail if
> > +        * @dentry is NULL and no dentry for this inode can be found; i=
n that
> > +        * case, continue using the old label.
> >          */
> > -       if (selinux_initialized() &&
> > -           data_race(isec->initialized !=3D LABEL_INITIALIZED)) {
>
> Don't appear to have lifted the isec->initialized check up into
> dentry_has_perm() and path_has_perm()? A possible reason to keep the
> checks in this function and just inline them.

Thanks, also fixed.  At one point in my private working branch I had a
patch that incorporated the cache into the code paths that end up in
inode_has_perm() and I suspect that in the process of cutting that out
I mixed it up with the revalidate changes.  It's also very possible I
just missed it :)

Related to my comments above, doing a single isec->initialized check
should be quicker as we avoid the selinux_initialized() and
might_sleep_if() checks.  Yes, both *should* be fairly minor, but
things add up fairly quickly in the allmodconfig test.

> > @@ -2313,6 +2320,9 @@ static int selinux_bprm_creds_for_exec(struct lin=
ux_binprm *bprm)
> >         new_tsec->keycreate_sid =3D 0;
> >         new_tsec->sockcreate_sid =3D 0;
> >
> > +       /* Reset AVD cache, transfer the old_tsec cache later if possib=
le. */
> > +       new_tsec->avdcache.sid =3D 0;
> > +
>
> Since we'll know whether or not we need to do this before the end of
> this function, could just wait?

I thought about that, but was worried about that being a source of a
potential future bug if someone introduced code that returned early in
a success case (the uninitialized case likely doesn't count).  I'm
also not overly worried about this from a performance perspective, in
the worst case where we are transferring the cache we do one
additional u32 assignment during exec; that doesn't seem too terrible
to me.

> >         /*
> >          * Before policy is loaded, label any task outside kernel space
> >          * as SECINITSID_INIT, so that any userspace tasks surviving fr=
om
> > @@ -2406,6 +2416,11 @@ static int selinux_bprm_creds_for_exec(struct li=
nux_binprm *bprm)
> >                 bprm->secureexec |=3D !!rc;
> >         }
> >
> > +       /* Transfer the AVD cache if the SIDs match. */
> > +       if (new_tsec->sid =3D=3D old_tsec->sid)
> > +               memcpy(&new_tsec->avdcache, &old_tsec->avdcache,
> > +                      sizeof(old_tsec->avdcache));
> > +
>
> Shouldn't be needed, right, since selinux_cred_transfer() will have
> already copied everything over from the old_tsec?

Unless I'm mistaken, the
security_transfer_creds()/selinux_cred_transfer() hook only gets
called in a bizarre key API (which needs work, but that's a very
different discussion) and not part of a normal exec.

> Should also reset the cache from selinux_lsm_setattr() with attr =3D=3D
> LSM_ATTR_CURRENT.

Not necessary, task_avdcache_search() checks to ensure that the task's
current SID matches the SID used when populating the cache, if there
is a mismatch the cache is reset.  Given how rare this case should be
in practice, and the fact that we would want a check in
task_avdcache_search() anyway, I'd just assume let the search routine
catch the change and handle it.

> > @@ -3088,44 +3103,147 @@ static noinline int audit_inode_permission(str=
uct inode *inode,
> >                             audited, denied, result, &ad);
> >  }
> >
> > -static int selinux_inode_permission(struct inode *inode, int mask)
> > +/**
> > + * task_avdcache_reset - Reset the task's AVD cache
> > + * @tsec: the task's security state
> > + *
> > + * Clear the task's AVD cache in @tsec and reset it to the current pol=
icy's
> > + * and task's info.
> > + */
> > +static inline void task_avdcache_reset(struct task_security_struct *ts=
ec)
> >  {
> > +       memset(&tsec->avdcache.dir, 0, sizeof(tsec->avdcache.dir));
> > +       tsec->avdcache.sid =3D tsec->sid;
>
> Since we mediate any task SID changes, we can invalidate the cache
> upon them immediately and then shouldn't need to actually store the
> task SID in the cache or check it each time during lookup.

I know I argued against adding some simple checks earlier in this
email, but considering the impact of returning "bad" data from the
cache, I'd feel a whole lot better checking the SIDs before searching
through the cache.

Yes, we want to improve performance, but I don't want to do it at the
cost of making the code more fragile.  Maybe we can revisit the idea
of removing the SID from the cache at a later date, but right now I'd
feel a lot more comfortable leaving it as-is; this patch already
provides a nice drop in SELinux cost, let's be happy with that for
now.

(Somewhat related to the incremental change above, I suspect we'll get
a bigger bump by working to make avc_policy_seqno() faster through
inlining.  At the very least, we're always going to need to check the
AVC regardless of the SID check.  I spent a few minutes looking at it,
but decided the patch was already creeping well beyond just
selinux_inode_permission() improvements so I left it alone.  That's
worth another look later.)

--=20
paul-moore.com
