Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D330E822
	for <selinux@vger.kernel.org>; Tue, 18 Nov 2025 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473479; cv=none; b=CswwwhSwkDyl9eO7RdfDiWRYzXnoFWOe5922Wd5KI96O6iqoE+SDmIUsrqBp4i32uqpRawCJCi3pGdwsQvII8xffZvxSN5WC5+thwAejg4SwDlku1ZdoYHd4g+pfKDGJ9rAFTi+ZQ+UbmWFio4Zv3fDqbUS2gqsK61/IQ/9vEpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473479; c=relaxed/simple;
	bh=BckwF6VQd6Vy45EPbHS4ajDXzu+7wnsM56+I70u0cb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzV4o5UH9u7LHZfvCovSsEgIYN25I91fLkgXqs3fxana6NJd2h9tLdeGyHaPOf4l5JolsbpLhkHj8occNtpoRuXx8H/PeycGuVtTwRBxJ3djxefXHjhtEY4FrhICtgYeLZHWlfgBVhrnOim2/Ta4V5GjjD3B3IuSyixvhSrjFrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cARYm4//; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cARYm4//"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29853ec5b8cso63810255ad.3
        for <selinux@vger.kernel.org>; Tue, 18 Nov 2025 05:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763473478; x=1764078278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi6VvX4X7Vr6Hlmbl1NKbweVfWQrbcu+BUn9sW/W0bY=;
        b=cARYm4//1Vy6VrbiXmVXP8HE5oqGNHrQB4fMOgkpcS81VuvvrIr9AzJG3HihL1bNNi
         Qv1Y3BVc2PfFU0rsVaQfL2aa+M/BvRBWWWQnMB/uVpsVfKtHrqPoQOXziDq6H5tBuUB6
         5p/QKiFHNZLETe8OHB6Lo+Q3DecAKjSK210eGiQvrcyukvXeXLLns8bts1Byw1YyFOsJ
         KWKXEFr2gtzsqGH6GRm49F5q9rAyGJzDhRrCee/3lWfaLHR54z/O6LZ8IOGj2pGuMMBa
         mJ45LJEaRdnuWSgH+tlGqSGKS20SNQ8ahiXKAX4U/kzLBBlS9d3+1hdrogA91zuXC/xA
         5OcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763473478; x=1764078278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fi6VvX4X7Vr6Hlmbl1NKbweVfWQrbcu+BUn9sW/W0bY=;
        b=v/ZpwAEEV9Cv9m4NX0piqdbvZIOy8AXyvwpqtHtz5vCMsjzzVXpFN/gAR4XqRLm+ST
         Yrp+y073afQJmlfmuI+E9vRUlHsFfRCifx9GbofxX1Lpbtoe3u53MGbcFdyQMkOlBdT0
         8G0lD/SObZeRWHmjhkR+kzTZacDqT49/8zU3xXjTkwypFMqsjRXUvARBFVI0tUeWA0pt
         NRgm7VmCIeVnpLYJSW3W1vNXTQ4VkD0xnMpjisE2YzrazrAZJmfsPGNZVGdIAfZL6YrP
         047TfJePDsSX5720TjQhduYrCKoDtCB2hTirXavNuqs6pIO4FGM1PcS8ADVa8iVgwPWV
         IUAg==
X-Gm-Message-State: AOJu0YxV6Cll52iBL/mHZm46dxUVzj190HWtBmVRg3OYBMnYytTGqcjA
	eSdBiv/RDCtk8lzSj7nYgFJpwUaTBSzWTYLsp+tUIYSSr7mCyPoOSfKWKdIsyhvSnZ7g8itDm9o
	AUY8G44Jgv9GlQ9YkhB/81GfkKofZlySUHg==
X-Gm-Gg: ASbGnctrz7blvRgkSsDZIAbXtUCQOYrOqqw/Dnc/87kxJO7mrv7BOEasZif7stCwtx1
	hPiSNeSQvUFz1rwBavR9MdEO8cDa9HUaHiB4DX9U+2mo8UKAZFcmMdt95vqE9PXZbDoriPqjmSx
	VaJnLl1R0/uyGXojvTNj6bRLHTs6D7cxlYeLbAPIOJOMhyZcGbXDxlgPC8LFzdqJzSd5mdppgiF
	k9C1w5BabRc9t8Kvl+cS4yXPAnessBuwew9GSHNHvnkNGhFAn+amS2TyHnp7U+ovCSdboE=
X-Google-Smtp-Source: AGHT+IED54saghXjFaHPfkZ+AfKv8W+6Dv1fkQHQE7mnx/HzKYo5kzJzQFSgqllx+fELWl8kDTcCtAugOLwQV9Pc2GU=
X-Received: by 2002:a17:902:ce05:b0:295:7b8c:6611 with SMTP id
 d9443c01a7336-2986a6d2755mr193183645ad.15.1763473477670; Tue, 18 Nov 2025
 05:44:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114174514.14695-1-stephen.smalley.work@gmail.com>
 <CAHC9VhTponNBYJ=YEE447XKSLrHc8kKwVBxMuiQPNrzjKZ=GXA@mail.gmail.com>
 <CAEjxPJ5=GJ5aTxk2xTAiLCiJc41RMo2Wtfp4VJ1XBAdzzEGW6Q@mail.gmail.com> <CAHC9VhRtgQkvpY=Sa+4VNtg6PRnVVEBNLk+Q3FoWoSApqWjHYg@mail.gmail.com>
In-Reply-To: <CAHC9VhRtgQkvpY=Sa+4VNtg6PRnVVEBNLk+Q3FoWoSApqWjHYg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 18 Nov 2025 08:44:26 -0500
X-Gm-Features: AWmQ_bkUkiE1hLJd5h3JvV34plddsuOdTTwbVXwoD98aNfzSieuzqKPphOaD5Is
Message-ID: <CAEjxPJ6hFwZBW=WBUmubhSzjyna7XAQUdTvMCnPDaZ0a2HyN7w@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: move avdcache to per-task security blob
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 4:43=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Nov 17, 2025 at 4:26=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Mon, Nov 17, 2025 at 2:55=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > On Fri, Nov 14, 2025 at 12:45=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > The SELinux task_security_struct was originally per-task but later
> > > > migrated to per-cred when creds were first introduced to Linux. The
> > > > avdcache was meant to be per-task rather than per-cred; move it to =
a
> > > > new task_selinux_struct that is allocated per-task.
> > > >
> > > > Fixes: 5d7ddc59b3d89b724a5aa8f30d0db94ff8d2d93f ("selinux: reduce p=
ath walk overhead")
> > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > ---
> > > >  security/selinux/hooks.c          | 35 +++++++++++++++++++--------=
----
> > > >  security/selinux/include/objsec.h | 13 ++++++++++--
> > > >  2 files changed, 33 insertions(+), 15 deletions(-)
> > >
> > > Apologies for the delay, I was away the past few days.
> > >
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index a22b1920242f..0eea43e4a90c 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -212,11 +212,15 @@ static int selinux_lsm_notifier_avc_callback(=
u32 event)
> > > >  static void cred_init_security(void)
> > > >  {
> > > >         struct task_security_struct *tsec;
> > > > +       struct task_selinux_struct *tsel;
> > >
> > > I know we had a brief discussion about this off-list before you poste=
d
> > > the patchset and I asked you to move the task/cred renaming patch
> > > after this one, but looking at the results in cred_init_security() I'=
m
> > > regretting that comment; the naming is just too ugly otherwise.
> >
> > I'm not 100% sure that setting avdcache.sid in cred_init_security() is
> > even necessary since it should be set whenever the avdcache is first
> > populated and there is nothing else being initialized in the avdcache.
> > So if that's the only ugly part we could just drop it. I only included
> > it since it was being done previously. It wasn't in my original
> > patches.
> >
> > > As this patch shuffling is my fault, I'll go ahead and re-arrange the=
m
> > > and follow up with a reply when they are in the stable-6.18 tree so
> > > you can verify everything is still okay with you.
> >
> > In that case I'd be inclined to revert to the original patches since
> > they are already ordered correctly and they don't introduce the extra
> > task_selinux_struct name since it isn't needed.
>
> I'd want to go back and look at those patches again, but I don't
> recall anything jumping out at me during the quick review.  I did just
> check and they do have your sign-off, do you have a problem if I merge
> those (adding the fixes tag, etc.)?  I'll resend them to the list
> simply so we have a record of that beyond just the git repo.  Or did
> you want to change anything in there first?

That's fine with me.
