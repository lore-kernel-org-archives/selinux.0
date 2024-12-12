Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ED0223E94
	for <selinux@vger.kernel.org>; Thu, 12 Dec 2024 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025724; cv=none; b=Iyt+1cWfAmSoVK0DN+mTHLi3p2mSTEJk3mD5KMZVY2QD/UrVfa2TTCUlzX/5WNZLJKOa/pHCfvoycp7eOvx4uhao+NbIFNj73rmomHBlaUBxWdBqqjKCkcWkSbV+rybxflv2DnRoYNKohB5RMNNfWZ8EkA6ZCsANdduA2zIrMDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025724; c=relaxed/simple;
	bh=IUuwXjviMV4DptEThLasqrbJT8iwWjqICyqQfK4vRO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wgb5yu9pUsOCCcO40XIMlAXmnLXz33z8iM8IZ9jBDrzbIQ/QgVIvty8t3ps2L45VESkNWNPmZIGHSqf5HtJUoRvVcRoAxnZI/iVEdKr+OKm6xUZ3KEk6jHt3+uHC11On+FIrXdREt41/ScS8t0eIn8L8MZPlkKTMAoHCWpIOrSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I+UyY9mX; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I+UyY9mX"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6eff5ad69a1so7808647b3.3
        for <selinux@vger.kernel.org>; Thu, 12 Dec 2024 09:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734025720; x=1734630520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl0QbOxOvK91dgAlMiEChBBLQvVR+A2N8YgsC/w3BS0=;
        b=I+UyY9mXDL7ucUpzXRfxZ6YJGq3dxH69Was8xP/bC+rvVRepVBozZ8XHAw03poQd/t
         pm9W6ork1vr/V5EohvQ5RP7+HurCE9wcMXSfk/dcZiAxagB66wZIpNccwjGHGtycjYau
         tkDAGRtDlqakPIGK0X3J8ogP+ml8v8boat8Hkb4fIkqiJnDR/pSXpaTgV9QMLRYoWSxQ
         kCQXnyvJHBXnZvSCJuDt0rTV9PLkSnS4urUWNOcQI4kDtmvnx0mVtvJ9AmFl+yDdcU6x
         /SwnHHR4BiPa5mFWPM4/9nmDyg3W4KmbirfpVJ7ZdlAoMYLyq9R9k81Fb9qJkPyv+bTa
         BRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734025720; x=1734630520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rl0QbOxOvK91dgAlMiEChBBLQvVR+A2N8YgsC/w3BS0=;
        b=uRw8thnVhQAAL45Yb7MV0ffnmwK5vFCILudQsJu3c362sft/Ar+3L/Zx4qCpparcvV
         PxsKWbvuYLoso8dIwSsJpzQF545PdALcGQYsCue9BdggeWlAMuOR4091dmDVM4EWWsuk
         8VQIMaJ1KU+6PS1rs9gNTSd7+11hO6/6LQXJYcLnEyJtgYi1p3K2xE032LuWdVqu+EWm
         iJbma8N7CBtzC5NccC6n7GjbaqLVg2fDpKNVIPZ8pYzLVyK3r5s5GjBuMBeFlsEeFKSL
         gycTjK5EO/rvb8r0cq3w5RTgW7XUXMTuDm1/o4W9zeV6nbegyGWZBetL/M2fb3rRCnCu
         s0MA==
X-Gm-Message-State: AOJu0YyujKaWiHOqkjER/xB1143a97pYYFUZ3VTzbKsXuVDKrbxy3ZRv
	TrWMyFOP2S7Bk7xs+XwurrwH1cRUES5ie5v/Kwy7bMEps6LZa9NpjeXPTxGWzOYYZi6FN2ljkqb
	XO4Hn2cSpyjySW9n0oZIF0RfyguXs6+67QTcrwsvG1fYH9aE=
X-Gm-Gg: ASbGncsxcBWSf29zPxqdnCW1JSmMbkMvv/6dYjfdfaqh/+FZsVV7YUPo/xAecyqbDTo
	oPJamSiirpAUUeWQvQdPD4aqVXR1x4yzjCnHR
X-Google-Smtp-Source: AGHT+IGyWUUaSr4BulBQh30C4H2Z5xDl6KrIgYo7SY4+FIjDebDi9TvbMs2Za600m1SedNKVtQGkUCUBtplqpXwPYtw=
X-Received: by 2002:a05:690c:30a:b0:6ef:7370:96ee with SMTP id
 00721157ae682-6f27529a087mr13283147b3.12.1734025720304; Thu, 12 Dec 2024
 09:48:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhTUX1L=WDtVaEMWDgCreyphrOLDtjL4Fg3gvQk8ihs0Dg@mail.gmail.com>
 <CAEjxPJ5DXJRRYB+RHfeWm7TYKF=LJKFNFq5X6S8H6JrQwhf4iw@mail.gmail.com> <CAEjxPJ57bUx05FYh6Eu-06CEV2-zfWLbo_yz3j-HDDZK0JLnCw@mail.gmail.com>
In-Reply-To: <CAEjxPJ57bUx05FYh6Eu-06CEV2-zfWLbo_yz3j-HDDZK0JLnCw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 12 Dec 2024 12:48:29 -0500
Message-ID: <CAHC9VhRaeQC1amoQSJSNUz1F4FYfJmj5YuwnkJUU_r4ft81Rwg@mail.gmail.com>
Subject: Re: The curious case of pidfs and pidfds
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 12:10=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Dec 12, 2024 at 11:19=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Dec 11, 2024 at 10:49=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > >
> > > Late last year Chris sent an email[0] about the increasing use of
> > > pidfds on modern systems and the difficulty in distinguishing between
> > > pidfds and other file descriptors when passing or inheriting fds
> > > across a process boundary.  A few months later there was a similar an=
d
> > > very brief discussion on a related GitHub PR[1] to add some basic
> > > enablement in refpol.  Unfortunately both discussions faded without
> > > much in the way of resolution and I'm concerned that we don't have a
> > > (good) plan for handling pidfds.
> > >
> > > As we are starting to see pidfds become more common (which I view as
> > > an overall positive), the lack of a good way to handle pidfds is
> > > becoming more of an issue.  Having just started to look at some of th=
e
> > > kernel code a couple of hours ago (see fs/pidfs.c) I'm worried that
> > > many of the access controls we have for /proc/PID may be missing or
> > > bypassed with pidfds and their associated inodes.  I haven't spent a
> > > lot of time on this just yet, and with the upcoming holidays it isn't
> > > clear how far I'll get before the end of the year, but I wanted to
> > > send out another email on this topic to see if anyone else has spent
> > > any time looking at pidfds and pidfs.
> > >
> > > Anyone?
> > >
> > > [0] https://lore.kernel.org/selinux/da1d9efd-fdc1-4651-8a7a-30ae4a399=
926@linux.microsoft.com
> > > [1] https://github.com/SELinuxProject/refpolicy/pull/762
> >
> > I could be wrong, but I think pidfds are controlled via ptrace hooks
> > and those check the task label rather than whatever random inode is in
> > the pidfd.
>
> Apparently I'm wrong. If you take the sample program shown under
> EXAMPLES in the pidfd_open man page, you can seemingly run it on any
> PID in your PID namespace, irrespective of whether you are related to
> said process, have a different UID, a different context, etc. What am
> I missing?

I haven't had the time yet to really dig into everything, but one of
the things that I noticed very quickly is that the inodes are marked
as S_PRIVATE which avoids a lot of the inode level access controls.  I
believe there are other concerns beyond that, but that is likely the
biggest.

--=20
paul-moore.com
