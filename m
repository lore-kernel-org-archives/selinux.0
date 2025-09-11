Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78B12D24AC
	for <selinux@vger.kernel.org>; Thu, 11 Sep 2025 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577509; cv=none; b=PFhh35NUNcofR3kl0bI1wMuIbBa/tjCDCVZOAvFiO/hL9Div949cbDR0ng4+RyOwZnWIlaLlBaXraGs6qZfBBxBwboRnFrlGcEHJXdJ2K3Qd5gAJr0ekcZUlzU4hWkI9GVAzDbw0rHX2GdalmpwfF7KusTfGllTGlKHPqAKNe4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577509; c=relaxed/simple;
	bh=UeIXqlludSYMEwWhoNjpjaOSRmq3//gOoqNcDfiBsVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYtdw2dcfgUmwW0RJFsd3Byu5LNBbX4JLSM260dxlCSrtX/wS8ViE2VWy7EP9Hp79iufocmB15T0hD4Mxs/2agho9Jul5trT1wWiZ9k2RW4bXDtdkJkNJ+tU0bICTuVVA+92MtuEIDfUdfJULKVUfTQZ6xVswxstpg4biCAQzcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1x8oNrLr; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1x8oNrLr"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-560885b40e2so5565e87.0
        for <selinux@vger.kernel.org>; Thu, 11 Sep 2025 00:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757577506; x=1758182306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JF5NG+YttDSLEKUv5KIrP5G4Ql+hHf+w0iLwyRoya24=;
        b=1x8oNrLr5qSpBaBZ+re4D0EP43FGXMYmXWetYLoZWeBlWzdXIX3ju6FsitpeWT7+3K
         5nprAd2KZgxhDm7JNA4aV/CUl5LUS1hvYqr6pqDjRVTyO7IDYURpRPWvKjO9LpSPIPli
         BcAnRBl5I88rI4YxdJuD4S2X6HmaMAhMdPmh+03/bWyCjPNQK4EMWFOuzgn6Z/EB2UVF
         dtT1MDd3OoSyRQw4h+BXIPd7mobfaZyAcz40oVRdVuJLwNYWFHXMoYmK4a2hXSB3Y5/s
         cS+btXUezXUCm3aN33WVxO+p6pmU0zekCx+adOSktS+dI4m7IDoLSUVgSTpDdUznDPGM
         bUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757577506; x=1758182306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JF5NG+YttDSLEKUv5KIrP5G4Ql+hHf+w0iLwyRoya24=;
        b=IZO7NDljo6e+Nd+yzhBrnepmN1QTjAaWK/YivGnv47lfjUY+OX4u5qGUhd+ZGj1XHq
         PL9jymGz0wDl/zT92Q37vyAmHkPVfV+05VOq3K6b89nnnUhuBmvSKAcxRpM3hqDaM0Nf
         /lrJ0feppsqSk8FpZkupoBP4J50boU32uIEgtObimls6wC10BW4yDptafKTay+0KL8ig
         vEH/io9nniHuqGa/9rIOc6Ns2t/e3h9fHrctN910qd7/wjKkz60+neMO/wj+QrplaLek
         I4EBEwRaiCqQPyqPyT7CvbUapahEvNZ7IAd5xWo4hswQskmeCRUeaqdVN/lZTKKnuAAk
         ZISw==
X-Forwarded-Encrypted: i=1; AJvYcCXyJcj5VswkTJO+620zcSyKu9l3TFOGUqG+RX8ne9eM+rMfuIXNiJJGRa8F/RcVmS2EMaJl8QMj@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtwnf2b2R58H+eXILtI6cFThkIijI7cPIXENdDNUluNd8uopDj
	0pmh4SWOVn2ZJ/9tkGf5UqibpOkm26HsQ/uDwk988z5O463PnKUhymRTgblVctIEz2nOme5l22i
	TC6dOge7o1rlA+LZ+iQ1iP2Bqs917DxpnG2dPpwGBcqydUQPKGZVhXSAA
X-Gm-Gg: ASbGncufQp2be0fkzyEs979aiAepgEdZqUpqbBzOvM50+39XojqqastEnnuH7+HV+6o
	N+zYndszur8YoZgmXyFlN5Ig4k7tPF/ngikfE86kdw5+bN5InIjWllR+uzFb8Ca/jGGVjj6Yo2Z
	JgegtMR27H1SwjdwRSQSOemRkRDGpzUH9UStRvY/Iztc2Yfv2yjjXc6DOgLR7DimPqf3Z+e1136
	BOltZqyBcSu+g+OZbrms24vyLsh3cxPd9uH2WvC3Aoo9/C5fnYF
X-Google-Smtp-Source: AGHT+IGZh8nrJ/VcqiHW85KBtZVe+1xrdXuowwvldOu8OpDXFCYx6b8XkfVOwjMykdYTX4hXgCL0NMVCYSM3rZ4wsRo=
X-Received: by 2002:a05:6512:239b:b0:56c:8abf:2f84 with SMTP id
 2adb3069b0e04-56c8abf32b4mr509937e87.6.1757577505221; Thu, 11 Sep 2025
 00:58:25 -0700 (PDT)
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
 <CAHC9VhTXR42Ogr-aS6OLHTZfW2vwBLtAcSqW7hJ4-0FMZfC2Kg@mail.gmail.com>
 <CAEjxPJ4387JPN+JOQ7g=Z6CCXYR-mk+6tr_VeyprxNJtCy1TWw@mail.gmail.com> <CAHC9VhSdKTUvY3Tg+dVCWHLfwULV-Vgzr-d942eh_yHa16HyjA@mail.gmail.com>
In-Reply-To: <CAHC9VhSdKTUvY3Tg+dVCWHLfwULV-Vgzr-d942eh_yHa16HyjA@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Thu, 11 Sep 2025 17:58:06 +1000
X-Gm-Features: Ac12FXx05dwP_DAm0R6WYFpNnS0KjWR3P2jXPXf504IwDkF4IwsXWQNMhNHYObw
Message-ID: <CA+zpnLca1_fRqcBq6AK0-hGbSb44R73xq2jw6qiYTv32GhKDfQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: adjust the !file/memfd_file error handling on execute
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 9:16=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Sep 10, 2025 at 12:29=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Sep 10, 2025 at 12:07=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > On Wed, Sep 10, 2025 at 12:06=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > On Wed, Sep 10, 2025 at 12:03=E2=80=AFPM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > On Wed, Sep 10, 2025 at 11:57=E2=80=AFAM Paul Moore <paul@paul-mo=
ore.com> wrote:
> > > > > >
> > > > > > On Wed, Sep 10, 2025 at 10:05=E2=80=AFAM Stephen Smalley
> > > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > > > On Tue, Sep 9, 2025 at 5:30=E2=80=AFPM Paul Moore <paul@paul-=
moore.com> wrote:
> > > > > > > >
> > > > > > > > A prior commit, see the 'Fixes:' tag below, added support f=
or a new
> > > > > > > > object class, memfd_file.  As part of that change, support =
for the
> > > > > > > > new object class was added to selinux_bprm_creds_for_exec()=
 to
> > > > > > > > facilitate execution of memfd_file objects using fexecvc(2)=
, or
> > > > > > > > similar.  This patch adjusts some of the sanity checking ad=
ded in that
> > > > > > > > commit to avoid a "silent denial" in the case of a kernel b=
ug as well
> > > > > > > > as return -EACCES instead of -EPERM so that we can more eas=
ily
> > > > > > > > distinguish between a permission denial and a fault in the =
code.
> > > > > > >
> > > > > > > Technically, this doesn't make it easier to distinguish becau=
se we
> > > > > > > usually return -EACCES from avc_has_perm() and friends, but r=
eturn
> > > > > > > -EPERM for capability denials and in certain other cases (not=
 always
> > > > > > > clear why, arguably a bug unless we were just replicating the=
 error
> > > > > > > number for some existing check that also returned -EPERM).
> > > > > >
> > > > > > It's awfully fuzzy from my perspective.

Stephen, from re-reading your messages, I am not sure which option you
prefer at this stage. Are you leaning back towards -EPERM?

An alternative here would be -EOPNOTSUPP, this would be more explicit
for userland on the root cause. There are similar usages in hooks.c
(see selinux_lsm_getattr for instance).

> > > > > >
> > > > > > > My
> > > > > > > suggestion to use -EACCES was because that is more consistent=
 with how
> > > > > > > we report denials outside of capability checks.
> > > > > > > To actually test this, would need an updated libsepol patch t=
hat deals
> > > > > > > with the fact that the policy capability number changed on me=
rge, or
> > > > > > > re-basing the original patch on top. Otherwise,
> > > > > > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > > >
> > > > > > To be honest, this isn't the sort of discussion I like to see f=
or
> > > > > > patches that are merged in the -rc5 time frame, if we're mergin=
g stuff
> > > > > > at this point in the dev cycle we should be past uncertainty li=
ke
> > > > > > this.  I'm obviously not going to merge this patch and I'm goin=
g to
> > > > > > drop Thi=C3=A9baud's patch from selinux/dev too so we can sort =
this out.
> > > > >
> > > > > Not sure it warrants reverting Thiebaud's patch. I was fine ack'i=
ng
> > > > > that as is. I just thought we might want to follow up with someth=
ing
> > > > > to improve the error handling here, which can be done anytime IMH=
O.
> > > >
> > > > And if we revert his kernel patch, I'll have to likewise revert the
> > > > libsepol patch, and the policy capability number might change yet
> > > > again before it lands.
> > >
> > > Yep.
> >
> > Bummer. Me and my big mouth. Apologies to all.
>
> I really don't want the take away from this to be that speaking up
> about potential issues is a bad thing.  It's far better to address
> issues, even if they ultimately turn out to be nothing, *before* they
> go up to Linus' tree rather than afterwards.  If folks start holding
> back their comments for fear of a patch being held for revision,
> rejected, dropped, or reverted, then we potentially set ourselves up
> for failure in the future with ourselves, our users, and the kernel
> development community as a whole; all of those possibilities are far
> worse than what we are dealing with now.
>
> If anything, the fault in this particular case was mine for not
> reviewing the patch as thoroughly as I should have done; I was trying
> to make sure we got things merged before the end of -rc5 and in my
> haste I rushed through the review.  My apologies on that, I was
> impatient and it caused confusion and extra work for everyone.
>

No worries at all.

> > Revert coming up...
>
> This is something that might be worth a more general discussion among
> the userspace folks, but moving forward it might be good policy to not
> merge userspace changes that rely on kernel API magic numbers until
> the associated kernel patch ends up in a tagged release from Linus.
> Of course one could always merge the patches into a "dev", "staging",
> or topic branch for ease of testing and later merge it into the
> default branch.  Just a thought.
>
> > On a different note, taking a quick look at POSIX.1 definitions of
> > EPERM and EACCES makes me think we got it all wrong originally and
> > should have been returning EPERM most places (except for file access
> > checks, maybe). But changing the existing ones now could create havoc
> > for userspace.
>
> Yes, what we have in the kernel now is what we need to stick with
> moving forward.  While consistency with POSIX is a nice goal,
> consistency with the existing kernel code is the most important thing.
>
> --
> paul-moore.com
