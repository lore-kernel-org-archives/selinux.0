Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8B0BE4A
	for <selinux@vger.kernel.org>; Fri,  4 Apr 2025 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743792072; cv=none; b=KWNvQLA0Wpn9jyr93Ku6g4NRb6M0gAsO8NT+M0hYLUpytWl3LVxQoAU1iDNHiAzztpUztszzarbuqYrcOXBNY8/+VL2vblGgZiS7Fb1tRwOhCB7xKw9OV6uDn/UBy+eC9m8IHbF9ibILaESwGdu+Hz6hKBvMY5deF+Wa7Nq9PTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743792072; c=relaxed/simple;
	bh=0oqFoPM4tI50xPxIPBjwYnZbl2xjhkS6xbYo/sshvj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpAaGnJU4gc87YvakfQfbCA7N+ukEavmUH6RHNLG+ehIKD2H201dA/NmGBZw3jHeduatsAi28UccR48u+/ezX/kflcgzg7JriqgfevBA1agrNnFO3wawiR0BNE4I1KHZrCBuBqYjzW2cVsFNjbZwEOxt7uoRYvW8XHOos9/MTKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VkemXveg; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VkemXveg"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e53a91756e5so2212911276.1
        for <selinux@vger.kernel.org>; Fri, 04 Apr 2025 11:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1743792070; x=1744396870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZakTc8cJtAcBd2JF/UBpsscdqN8Q5jjWHFAjDluHwlw=;
        b=VkemXvegGZ/eSIPGD075vfJ+Y7A2yfRTEHei1OnnNal2CqDupIHO/vdCI85Jm1sK7n
         XmJy5LprJ6+fwOq4lywSV1wK6yS0ISXevlF4arRRxCCCTc2tDUfzulMisF9kZurLohHz
         uxOhsUNO4wB93YdjWVbfKyYjOe5h5CcYqQZwPVjU9oI0X8keydY45JfmBE4TUKG2/FLF
         1qxQdVVAvbytQzTuJ09KQ3gWVjsiv/5c6VQC29uvRN7qDICOCisHpNBddNx8gN1kIFGq
         BWd8wwngmX/2rY8epzGpGgzN91zHVhTLYTLpW7ZE6m1kgEPUGv4l17qhR8o6I/JLBUMH
         7oTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743792070; x=1744396870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZakTc8cJtAcBd2JF/UBpsscdqN8Q5jjWHFAjDluHwlw=;
        b=SHShs7E1yKFqHUsHwBeCubbhOwtui9bV6BlNDyAxf9b8IDkOOcKJ3DnjgryYUCSplS
         VgY384HHwQwk0JU2WWHw45Thqiq/EUau3O2+XhjVRvyrMKqAWVGY6xIxE4c9E6KjCF8V
         Xi0keTbUtWlSiM0w9z5/Rp4GEQwYQwQfu72JgeeWeo2Js6V6vepzfUoh82btPF7YNcHi
         Csv8n0dGQksqxuWHu9ADxSwwcxx0yJpA9VWoBlyYJ9KhVekdNvCVGQ7hCiVVDg0TaoaO
         FgcR8wir9BBgbzSg6NBkrDWRnTnljRDI4wcM2Ofz1jCl68ssc66FZDLDMp6O9R+09r1s
         PKtg==
X-Gm-Message-State: AOJu0YwRCu5RupXR35ZfaOjnbh5BKDWuJTFlsyk/U8pdB1dUwpwGrB+a
	X9qvYYghtKbzaxqzxLBrj8XooE4wskojxOuYHwWgNVN/BOojH68SQ5vUZdHMym5vA7xrXZxExFy
	u1nDrrWw3wEDlmrD2/b/dF8hybN1FsEJsGUew2+lMmFS2breBCw==
X-Gm-Gg: ASbGncuXmF7l+txTFqdOzr1bR/DXDZE1MFcNz2Vi8Y28rjMMXCPxf8pLVVT0p6rLUuu
	UbQBKUTglxNpeoTjXAewhxiaFAjrZQPq59ZJGu9pJArI0D0kOuVVx7Dh4fNbKeGbuja8D8MxtBV
	GXXvwXeJmDAowS6oz9xnJ7xBuvSw==
X-Google-Smtp-Source: AGHT+IGpw0p6saXEbn4x17vJAIl5Xh9Gc5mR/A4uFx9W19prEwzowG1M/dyiP4GUoOsD3YQEpUUa9KfIpaxFA5u1npg=
X-Received: by 2002:a05:6902:2512:b0:e62:d12f:1526 with SMTP id
 3f1490d57ef6-e6e1c4e3365mr7217951276.48.1743792069789; Fri, 04 Apr 2025
 11:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402203052.237444-2-paul@paul-moore.com> <CAEjxPJ7zEv5zt5i-fhrnytQKuu4YUEZSXUNjvZcOsbh6ETs99Q@mail.gmail.com>
 <CAHC9VhRG0nVUtpcmTUvuJaznhT+noVwtJWGgJ+0ZfOZj=uBoCQ@mail.gmail.com> <CAEjxPJ5ht5pPAeMWq6fX3KQ7ESUZNmKqF8VdEGUWRyO_ykJCbQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5ht5pPAeMWq6fX3KQ7ESUZNmKqF8VdEGUWRyO_ykJCbQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 4 Apr 2025 14:40:59 -0400
X-Gm-Features: ATxdqUH_KYQHQrozIKKz0gOJqEyY9QE6zZHtgHinc7yg2urA1ykvtzG_g_yW9Uk
Message-ID: <CAHC9VhQpYAPz_sU5FH8PKKurd=9Vc8GoN5PJpm7VnRVqVCfNrQ@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: reduce path walk overhead
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 1:33=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Apr 4, 2025 at 12:24=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Fri, Apr 4, 2025 at 10:00=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Wed, Apr 2, 2025 at 4:31=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > >
> > > > Reduce the SELinux performance overhead during path walks through t=
he
> > > > use of a per-task directory access cache and some minor code
> > > > optimizations ...
> >
> > ...
> >
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index 7b867dfec88b..df2bc01175b4 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > >         /*
> > > >          * Before policy is loaded, label any task outside kernel s=
pace
> > > >          * as SECINITSID_INIT, so that any userspace tasks survivin=
g from
> > > > @@ -2406,6 +2416,11 @@ static int selinux_bprm_creds_for_exec(struc=
t linux_binprm *bprm)
> > > >                 bprm->secureexec |=3D !!rc;
> > > >         }
> > > >
> > > > +       /* Transfer the AVD cache if the SIDs match. */
> > > > +       if (new_tsec->sid =3D=3D old_tsec->sid)
> > > > +               memcpy(&new_tsec->avdcache, &old_tsec->avdcache,
> > > > +                      sizeof(old_tsec->avdcache));
> > > > +
> > >
> > > Shouldn't be needed, right, since selinux_cred_transfer() will have
> > > already copied everything over from the old_tsec?
> >
> > Unless I'm mistaken, the
> > security_transfer_creds()/selinux_cred_transfer() hook only gets
> > called in a bizarre key API (which needs work, but that's a very
> > different discussion) and not part of a normal exec.
>
> Sorry, I meant selinux_cred_prepare().

Okay, that makes more sense.  I couldn't figure out what you were
thinking about with the cred_transfer() hook.

> The point is that the new_tsec
> is initially a complete copy of the old_tsec so you don't need to
> repeat that copying for anything you aren't changing.

Fair point.  I'll just drop all of the changes in
selinux_bprm_creds_for_exec() and let the search code do the right
thing if/when it's called.

Unrelated, but I also made a change to __inode_security_revalidate()
to use might_sleep() instead of might_sleep_if(); we're already
checking if we are going to sleep, we don't need to duplicate the
check in the macro.

I'm holding off on a v2 post to see if there are any other comments,
but I'll plan to post an updated revision early next week.

> > > Should also reset the cache from selinux_lsm_setattr() with attr =3D=
=3D
> > > LSM_ATTR_CURRENT.
> >
> > Not necessary, task_avdcache_search() checks to ensure that the task's
> > current SID matches the SID used when populating the cache, if there
> > is a mismatch the cache is reset.  Given how rare this case should be
> > in practice, and the fact that we would want a check in
> > task_avdcache_search() anyway, I'd just assume let the search routine
> > catch the change and handle it.
>
> It's a tradeoff between paying a small cost at the time of writing to
> /proc/self/attr/current aka setcon(3), which is never
> performance-critical, versus comparing against the task SID on every
> lookup.
> Your call but if you clear the cache on a SID-changing exec and
> setprocattr, you don't need to do it on every cache search.

As mentioned previously, I'd much rather have one single u32 SID
comparison in each cache search than worry about missing an unrelated
code change that could result in a security regression.  It's a
tradeoff, but considering the gains already made in this patchset, I
think keeping that one scalar comparison is fair.

Also, like I said in my last reply, working on improving the AVC seqno
compare is likely to yield more of a benefit.

--=20
paul-moore.com
