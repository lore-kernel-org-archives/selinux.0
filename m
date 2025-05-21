Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B3190696
	for <selinux@vger.kernel.org>; Wed, 21 May 2025 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747844640; cv=none; b=uuly3dkNGT9tmLPrIjFD3qTOMXU6aXp50tYUq89qPEjVizgq2wYGfIzZcUzfcKLArsGpsS9/q+fPreTh5N80U5CKMr1Vq83TpL2vFpsY8fo5+t/JhQkFsY0J2ndpRQ6tMmZSSWX46WNoEjQ7byuUrI5JnpAppO1nKfA7FyD9hzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747844640; c=relaxed/simple;
	bh=kZryWAumlQV83Is46EP9iXM2sfmkeUuBF31EkcvXQiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txodaQdzuXu8Lt1W5j8YRCrw7DDF9ppUqOvWnZRP9PfUnsV9swCbsMBT0gYbRQe9vq8119xtMHTBycHts/sOzDEdvJpte/U3HluUiIsOVODsUvFNDt68MxesviP6rqmLsbqnO+ux6paGCKtWg4N6BRzrPnRUJNfHRDWMd6/elSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=U8I8hi7O; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="U8I8hi7O"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70c7b8794faso70797827b3.1
        for <selinux@vger.kernel.org>; Wed, 21 May 2025 09:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747844637; x=1748449437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8HGIkyD+25rtozx80O1WWPPKfD1jKvESyLw4tJ4yXo=;
        b=U8I8hi7OhAvlF7ud1c8jtt13Egxr9JIop51WTQuwEdFq1Bn7QKP88y/MK0GrAP2cXO
         F0VbvFemBlbAIEv40y0OhtuQT9WEVpzFmXvMX+/NXl5iFvnCMIZku5PeBUgyx/vTwHAh
         O5oqLCbOwJem+CVMhf6WYMhv0CqvCtaYKhTIV3llkRn5IvEgxrk0BTYAbW8tar2OUnX5
         S2njD0NB5XKi9TybD78ffeOaInSvdc9H/aGsvzqpsP+f/gnTP1LjGOx9zlyO44Tq0/Ax
         4bue86oob//jQ3L4kj4RoD/cdwWAt75MQzzy6fSTcG3frpkPSz45RyGt7kNxHlkHXSqs
         nIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747844637; x=1748449437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8HGIkyD+25rtozx80O1WWPPKfD1jKvESyLw4tJ4yXo=;
        b=w1FfymQDWERqsR0My3NA1I7pSvWwquEFBHEqKGBz/X5Wa5uY2Evb9H9qLVGpNWNwDn
         IeHooBgkJv+IZ3lZXa9pkoe4EFrwznrscZIomZ7KHK8cuv5nalVR6sNrpD8DrZKbBOPB
         ujmBFB9oNPsMeNaOhye1iyooOxDcZaeTnXfGf5U28opGmgoZQx8O7SowidqdpHG3JTL+
         smOBziv+r8raWIb372fhEnGES+Zpo4klUwpT9Zv0kmDCn5SAx2BI+PC4rgEZesMlx74I
         BFHBFCglKWMrnf0xiw6Ci3ck88i+83NLOizuoKEpyKUPvX4y9bnJ0GaOOp0oTFODu6iN
         rrLQ==
X-Gm-Message-State: AOJu0YzlfrjTExCq1Va8muxD4snzrewYexbJPo0B+krxw+B8vOGdxFED
	Q1onTuZfKe8Fg+PbtYyTKd09kTyAp2wOi/Gw7bVeyTT0D3oFjO/P38xfrryrcNjTNib2nYDFEoP
	ThKUR/iT2gU0kRRBdB5ZMvAQHBFb6Evckguqn5n9k
X-Gm-Gg: ASbGncsWeyQWA6L8tJ7XkbcFhsNT+twwUvG9HsTPlq3j4BNxsfnzl4gCmxhPB03KT7r
	cwwRpIipSLRI7RVXujPd64FHkI3AKSvsrFKNP8wIHFgZ1UUX8ve131j4TMFKOrLqv4UgjqzcxdC
	59P6qAIc/7kPgsxZrLwIOCeXnmAJE8553Y
X-Google-Smtp-Source: AGHT+IGBiLaRRF5o05OSNxyAm5cawKnHK5KbtxeG8SQQCU7kmdC6M8HxLhfizhSoS0YRKv47d97NL7C9uCOv+DHtEdw=
X-Received: by 2002:a05:690c:d1f:b0:70c:c8fb:33d5 with SMTP id
 00721157ae682-70cc8fb3731mr206392567b3.14.1747844636871; Wed, 21 May 2025
 09:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502170450.27160-3-stephen.smalley.work@gmail.com>
 <a0842c097e2b73c93954e2a414b3fad2@paul-moore.com> <CAEjxPJ6jp1Y9uSB2fg6ODufuzvwu-Z3VFz-ER+xMh6escKAyHQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6jp1Y9uSB2fg6ODufuzvwu-Z3VFz-ER+xMh6escKAyHQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 May 2025 12:23:45 -0400
X-Gm-Features: AX0GCFtWc8xTrjo4VCN9c8ov_NwCIraRY-Rkx6uHfocPaHOVkixSAE9IsQhZ_tc
Message-ID: <CAHC9VhRtAFSsDihebcdt0tot-aE_wBhNYZiScPq4vcYCQesYJQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux: optimize selinux_inode_getattr/permission()
 based on neveraudit|permissive
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 7:52=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, May 20, 2025 at 7:38=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On May  2, 2025 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> > >
> > > Extend the task avdcache to also cache whether the task SID is both
> > > permissive and neveraudit, and return immediately if so in both
> > > selinux_inode_getattr() and selinux_inode_permission().

...

> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index b8115df536ab..1a3806fdf3d6 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -3184,6 +3184,8 @@ static inline void task_avdcache_update(struct =
task_security_struct *tsec,
> > >       tsec->avdcache.dir[spot].audited =3D audited;
> > >       tsec->avdcache.dir[spot].allowed =3D avd->allowed;
> > >       tsec->avdcache.dir[spot].permissive =3D avd->flags & AVD_FLAGS_=
PERMISSIVE;
> >
> > This obviously has nothing to do with your patch, but looking at this
> > code has me wondering what my thinking was putting the permissive field
> > in the avdc_entry struct instead of task_security_struct::avdcache.  We
> > should probably move that ...
>
> Well, it does exist as a per-avd flag so it was consistent with that.
> Certainly willing to coalesce.

That's probably it.  Don't worry about the permissive flag, I can hack
together a quick patch for that.  That change really should be
distinct from these changes.

--=20
paul-moore.com
