Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEF1219E8C
	for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757546199; cv=none; b=s4NwL3Qu0o1dQ7dsyQYYcHlzX3wU3xREsCviFBML9p1aWRyOgOhpM1aYhCaXZO/jyMuQ5F2JOdhjFyfwe8CpwFeVHjaL9ZmwWG9Dm9wbsIm+pPKx+US0lwmpkmd/pvWJlqNo9XGPwB7LNb1uaVlmUqW1SWOXUv2VBbmcZlanF6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757546199; c=relaxed/simple;
	bh=cWPvlWhIXgoNpWnLxgkaJh4kBsd5wsSFQeSPUDopFy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWoCFbwEuPHk804NTfidkmAkcS3M8MnxHclQxp/7KsSoywcgnHwBoJYVjb2v3RF+a+knj+/FuS6O8IRyBNFbunsXhtRdSP+5T5G2VLg5XgK9P+Q6UEwRc2mFYdxu86DkZ4l5NNihqzep0fVBJFHrSSx6T6uzuOc0SA1dR4PkE18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z9VAF8BJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z9VAF8BJ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7725147ec88so101092b3a.0
        for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 16:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757546197; x=1758150997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hN9WUSNKJBWPU5ohWUXV9W5ryUFORplwwLkrcLrHots=;
        b=Z9VAF8BJPG4T9BX/T7NbSJp1fBUZUIR2ZXvSZK3EsTOTkyL6eaf6+Vg0pcS+Wf6alF
         ZSvMWOelvuEwo9rJu8asdQLCD8AzKVWeqIhzZkqYPYM1RzJMpRUIpvCv6R0xuyl8FeKd
         6Yv5Uj42qpSyi/nkp0gte0k0K5hrRGYNoGYDNyqpDWVueA7fUwwdSTHGXaTqEWWCBSxP
         H9mmmUlmSPnCRmCf/ORx+mfCcHozzBAOmW+sKagd9H8jVYdG8O3XEYhgqCwn5aYvLcvm
         Lo8/XbWydezR3kC9FT19NQaKyGCuAowGPMB3sVLpa5FJVFs5c33/JbQwzQt0eho3Q86T
         /1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757546197; x=1758150997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hN9WUSNKJBWPU5ohWUXV9W5ryUFORplwwLkrcLrHots=;
        b=wc+h8edPlNqVT6KhLfYllJ/cXIaFgKwcQidQMgwFmkZnX4jf+e30M9FaUrTe33Ri65
         F8LPfkJNK8uGM/G0DhaKVfRabRFsb8SxpNOxZTCOcXt9DhSPJrZpthO2MG4az9EUmf31
         ZBri8BW6yFNRWpxaYHgaASBMxaF4wn2mJ6+3uNocN4CmWkDYbLBD2x8fVG3oT5avctc0
         6mOc6z9+PgjogB7LO8RabzN5LqaGsrQHI+UVcBNvTQ84vvxjdv6k6BKW2ADfnNrdCnxt
         fFgg5Yk2BzrhR3V7nxvRdzojcnSsJLfDqDY9xZ55AhyHCp7016ISFwhOsj/xBNBWAa0T
         ISRA==
X-Forwarded-Encrypted: i=1; AJvYcCVGtiUNorMsK1Y94ZqdTz6k33kethVQFdsFgOg4L5D4xIlnP+spMPQ9tDxGt1N+sKuDO2A3IaIQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb31q7e4mdnudLo9aS4Qn+iu+QLZEH7TCEga+cM8RmjwU4U1Zk
	XIzobeHzy8sekVZP0dEcCwNJBOg4Q4nITqj5xEjJaeNkpRmPofQZJhUcCDoCJVqyxZMddJ4OZIF
	YeituI17ETgJCLORwbRqUdsV+cNV4G5/J+Kdh+cIH
X-Gm-Gg: ASbGnct36ORj7ecrUsPQk9E6y4sjN+aeeHyYRWs/jr+qp+VupnIqz2eoDfbdJyJGDDI
	l4EwtjTS0j0Lae7qhQuyqoksDO6t0625zRjb90S64YIHsfcnAkadBpl0j3fJw5SsvwIeJxJCMBt
	XJFK89FQRwM4rg8AomnZ9sjHsSAIBdN5wisG07tkR/sZqsp5+IqeARCfJewFXpRKZSEvnKrnRHs
	Savn8c=
X-Google-Smtp-Source: AGHT+IEBNzG6Q4Yed2fHJiqX5obydVsYxXZ+4hYf0B5H0fztEeNHo/VLIS99Vzrl0SDId302DTBKGQVwpTNRbJ65Zuc=
X-Received: by 2002:a05:6a20:7f90:b0:23d:45b2:8e3c with SMTP id
 adf61e73a8af0-25cf5f1d558mr1542162637.6.1757546196993; Wed, 10 Sep 2025
 16:16:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909213020.343501-2-paul@paul-moore.com> <CAEjxPJ73qtdeTcv40gdj2tPJOSRC0VzGqEmHCZv6CwNz4AZdTQ@mail.gmail.com>
 <CAHC9VhSg6jsO8kET1qMUNUkHuWJ9e8UJb=Q75VmCv0kEzwk0Fg@mail.gmail.com>
 <CAEjxPJ7-1MdtcXaeTwH7Z-uPV2Mt++5NTGRWx6u58xKieH-G4w@mail.gmail.com>
 <CAEjxPJ72F9PsdWo_XBL5XDABYwZFJh5-TSt1bp3toLwgoLchkQ@mail.gmail.com>
 <CAHC9VhTXR42Ogr-aS6OLHTZfW2vwBLtAcSqW7hJ4-0FMZfC2Kg@mail.gmail.com> <CAEjxPJ4387JPN+JOQ7g=Z6CCXYR-mk+6tr_VeyprxNJtCy1TWw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4387JPN+JOQ7g=Z6CCXYR-mk+6tr_VeyprxNJtCy1TWw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Sep 2025 19:16:25 -0400
X-Gm-Features: Ac12FXwgCJFlmwiuIqWYy5qBYzjn9R_IkfjiWUKd4AU1OK_Kcr3PCTyQ-rD6nbE
Message-ID: <CAHC9VhSdKTUvY3Tg+dVCWHLfwULV-Vgzr-d942eh_yHa16HyjA@mail.gmail.com>
Subject: Re: [PATCH] selinux: adjust the !file/memfd_file error handling on execute
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 12:29=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Sep 10, 2025 at 12:07=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Wed, Sep 10, 2025 at 12:06=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Wed, Sep 10, 2025 at 12:03=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Wed, Sep 10, 2025 at 11:57=E2=80=AFAM Paul Moore <paul@paul-moor=
e.com> wrote:
> > > > >
> > > > > On Wed, Sep 10, 2025 at 10:05=E2=80=AFAM Stephen Smalley
> > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > > On Tue, Sep 9, 2025 at 5:30=E2=80=AFPM Paul Moore <paul@paul-mo=
ore.com> wrote:
> > > > > > >
> > > > > > > A prior commit, see the 'Fixes:' tag below, added support for=
 a new
> > > > > > > object class, memfd_file.  As part of that change, support fo=
r the
> > > > > > > new object class was added to selinux_bprm_creds_for_exec() t=
o
> > > > > > > facilitate execution of memfd_file objects using fexecvc(2), =
or
> > > > > > > similar.  This patch adjusts some of the sanity checking adde=
d in that
> > > > > > > commit to avoid a "silent denial" in the case of a kernel bug=
 as well
> > > > > > > as return -EACCES instead of -EPERM so that we can more easil=
y
> > > > > > > distinguish between a permission denial and a fault in the co=
de.
> > > > > >
> > > > > > Technically, this doesn't make it easier to distinguish because=
 we
> > > > > > usually return -EACCES from avc_has_perm() and friends, but ret=
urn
> > > > > > -EPERM for capability denials and in certain other cases (not a=
lways
> > > > > > clear why, arguably a bug unless we were just replicating the e=
rror
> > > > > > number for some existing check that also returned -EPERM).
> > > > >
> > > > > It's awfully fuzzy from my perspective.
> > > > >
> > > > > > My
> > > > > > suggestion to use -EACCES was because that is more consistent w=
ith how
> > > > > > we report denials outside of capability checks.
> > > > > > To actually test this, would need an updated libsepol patch tha=
t deals
> > > > > > with the fact that the policy capability number changed on merg=
e, or
> > > > > > re-basing the original patch on top. Otherwise,
> > > > > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > >
> > > > > To be honest, this isn't the sort of discussion I like to see for
> > > > > patches that are merged in the -rc5 time frame, if we're merging =
stuff
> > > > > at this point in the dev cycle we should be past uncertainty like
> > > > > this.  I'm obviously not going to merge this patch and I'm going =
to
> > > > > drop Thi=C3=A9baud's patch from selinux/dev too so we can sort th=
is out.
> > > >
> > > > Not sure it warrants reverting Thiebaud's patch. I was fine ack'ing
> > > > that as is. I just thought we might want to follow up with somethin=
g
> > > > to improve the error handling here, which can be done anytime IMHO.
> > >
> > > And if we revert his kernel patch, I'll have to likewise revert the
> > > libsepol patch, and the policy capability number might change yet
> > > again before it lands.
> >
> > Yep.
>
> Bummer. Me and my big mouth. Apologies to all.

I really don't want the take away from this to be that speaking up
about potential issues is a bad thing.  It's far better to address
issues, even if they ultimately turn out to be nothing, *before* they
go up to Linus' tree rather than afterwards.  If folks start holding
back their comments for fear of a patch being held for revision,
rejected, dropped, or reverted, then we potentially set ourselves up
for failure in the future with ourselves, our users, and the kernel
development community as a whole; all of those possibilities are far
worse than what we are dealing with now.

If anything, the fault in this particular case was mine for not
reviewing the patch as thoroughly as I should have done; I was trying
to make sure we got things merged before the end of -rc5 and in my
haste I rushed through the review.  My apologies on that, I was
impatient and it caused confusion and extra work for everyone.

> Revert coming up...

This is something that might be worth a more general discussion among
the userspace folks, but moving forward it might be good policy to not
merge userspace changes that rely on kernel API magic numbers until
the associated kernel patch ends up in a tagged release from Linus.
Of course one could always merge the patches into a "dev", "staging",
or topic branch for ease of testing and later merge it into the
default branch.  Just a thought.

> On a different note, taking a quick look at POSIX.1 definitions of
> EPERM and EACCES makes me think we got it all wrong originally and
> should have been returning EPERM most places (except for file access
> checks, maybe). But changing the existing ones now could create havoc
> for userspace.

Yes, what we have in the kernel now is what we need to stick with
moving forward.  While consistency with POSIX is a nice goal,
consistency with the existing kernel code is the most important thing.

--=20
paul-moore.com
