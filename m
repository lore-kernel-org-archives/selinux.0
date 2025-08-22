Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042361A316C
	for <selinux@vger.kernel.org>; Fri, 22 Aug 2025 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827438; cv=none; b=VqOXoudW9p0NXH5Z167BCJvhf0pL53o7Xv2C6OIGUjTYzP+aNmyDj6TXKQnlXQV3H6RhoGtTJO6x4ia3+weq4mBUVKM4H2BzndtIAKKRnHSxUk6r/govTUe5Sr6YK0uvj5h6AQqH581yuyw0wLlmunqkgGWQtTlRCMIIWtscAQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827438; c=relaxed/simple;
	bh=8WGUDYIWCI0XUA/Aq3asozKWW6rnukYIVdUVVHfJsDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzB/gVb7Gyy2MB5YNSWox4C2pMu+g3TwS2Dmzo33l++7qL5e1lNARCcKPFKuu56X0Q5UWbo9bE/DN0ykG7VYUYuvmW+H3uwUcIvU4kS5dSl5BZSZsllMOOyQuPHtUQL92sfPtrKpDsQc1Saj7lX5I2egs+vGpl2IZLbFVrfkqBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Fgvhj+i3; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Fgvhj+i3"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so1594265b3a.0
        for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 18:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755827435; x=1756432235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fM1VQGGbaao3xVBrGpCMs2zca6FvFyseJxxIoayxqao=;
        b=Fgvhj+i319qQ7s9Qa2Cv9kyAZvcZ/dDwbBGUFnCIKOqoHsv5YV+/ujm7vIlxTXudKo
         hMOoszReEdN88C5POl3qgWFKKaAB01G5/d53lkzXmsNPyJ7i7VJsynWd30MLSPDO3TnZ
         JVY9SBzG81MI2Ct29ZUiQEcyUsumdd5qhpI5MSJ3tU49O+pypGgYSygq1R/XTyc1g0pr
         oCw6TL+bczBDxQ87Q+PBcETbZAXaoLiJbaqpYRHOVUL1dmmsYUgOhGvowDhU86bk+8BZ
         IRu9j5H6SsiutnV5MfJk9t4p6geHjLZUX6y/GS45CkFE2rvzW5AcAkwnEi8bqZFMwTVp
         yGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755827435; x=1756432235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fM1VQGGbaao3xVBrGpCMs2zca6FvFyseJxxIoayxqao=;
        b=Hmi+mT9shZ+plDwC0EWWsD39OdIGrggZDpPFNjrHxVtyt/wFJdqWOc/fZoWQLZOd17
         JxthtR98+Q3w/9HYsjl0lLxs5/q/12bVs2UdqPaIHRIVbp2+ZzFLE99hjRwV/1cKLWeb
         eDT8Zj6SKkTQkPyOFrQ1GgJjXj/7BUmPotYGzJqj4wxICRuaUz1TcDasiTxWXQjMVqPY
         AwjWJSXAb+QGEf7NlKba/xAxauEh5QEJTNp408ivagheHtmbfPxBKFiuO7AM7lfVQItc
         5NLfqyIOsOA4MP/DX6UCwEUdoDleiOsOoA7MEVluQGyypH+FyDhMLkvP5TaUrpD3lUaT
         PV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWN8QzhacyZi4sdiTwuMx34d0mOXKQVYwqlTVGR3KvxyWw1iC5Fx1RqKlwVRqGbdL38A7GulG4@vger.kernel.org
X-Gm-Message-State: AOJu0YxXaSj8p/BW8hlPTmu5rbqxRf7+ttKuUWAIp796NIT+9Vk9HlYT
	l8DfCk8X3BBWnpVfiKJRZTP3+vXKnUCDPN7BNafbEodNc93riXQ2UjuCrhe3wd2SuKD3Yhll8om
	4bTMYaQnGPiCmGr2MkE8B67/sSJ2/wnHGxpAeevRw
X-Gm-Gg: ASbGncsm/c6O8nxa3CRTmIS9pkikXD3B6PSTQ5deIVekonWGQequStbWfUg8UY96hmg
	Xpkc9PWUPlsDEBAGYp8ERQZ88r1dPnVF4t0zMLybGBZHDeaecEX19RvQa9F5XDq8vKIxpF66s0B
	sx9wzmeH8MfaG4mFSQpxWgsIorDBIyMhaOW30IylFjQyFl5F6nUYYBrmTq3BwIS6rk292vljmqL
	ExQEEM=
X-Google-Smtp-Source: AGHT+IHBuBobs/vblH7LUy/G0OP8be24STA5cAdkqfHVbd0CPoNQhONGc13E2tH6gwe5Et27wxt9pQ0//6oluc0v/Xo=
X-Received: by 2002:a05:6a20:2448:b0:243:78a:829a with SMTP id
 adf61e73a8af0-24340e06a0cmr1657690637.51.1755827434990; Thu, 21 Aug 2025
 18:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
 <CAHC9VhSubXA4tAUoz7T==UvfrM_DXS6nF5s0tJZ1HrrVizMgZA@mail.gmail.com>
 <aKZ+2NMx+ZQhpySY@mail.hallyn.com> <CAHC9VhR-5Rwg132UsLdpJgM0c51HYBrBDivBinw3YcYqe0QTKA@mail.gmail.com>
 <aKaMVPbPrgUc7mtv@mail.hallyn.com>
In-Reply-To: <aKaMVPbPrgUc7mtv@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 21 Aug 2025 21:50:23 -0400
X-Gm-Features: Ac12FXyBORUydle3k00Nh9qGFkyX6vaTXFoYaF3wxZe0af5zpDG_LnSTMOjePyM
Message-ID: <CAHC9VhQRbva1QHgORhXpw5ubqgoTo3X=+NTmZM+514v2qK4Cgw@mail.gmail.com>
Subject: Re: LSM namespacing API
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 11:02=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
> On Wed, Aug 20, 2025 at 10:35:42PM -0400, Paul Moore wrote:
> > On Wed, Aug 20, 2025 at 10:05=E2=80=AFPM Serge E. Hallyn <serge@hallyn.=
com> wrote:
> > > On Tue, Aug 19, 2025 at 02:51:00PM -0400, Paul Moore wrote:
> > > > On Tue, Aug 19, 2025 at 1:47=E2=80=AFPM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> >
> > ...
> >
> > > > > Serge pointed out that we also will need an API to attach to an
> > > > > existing SELinux namespace, which I captured here:
> > > > > https://github.com/stephensmalley/selinuxns/issues/19
> > > > > This is handled for other Linux namespaces by opening a pseudo fi=
le
> > > > > under /proc/pid/ns and invoking setns(2), so not sure how we want=
 to
> > > > > do it.
> > > >
> > > > One option would be to have a the LSM framework return a LSM namesp=
ace
> > > > "handle" for a given LSM using lsm_get_self_attr(2) and then do a
> > > > setns(2)-esque operation using lsm_set_self_attr(2) with that
> > > > "handle".  We would need to figure out what would constitute a
> > > > "handle" but let's just mark that as TBD for now with this approach=
 (I
> > > > think better options are available).
> > >
> > > The use case which would be complicated (not blocked) by this, is
> > >
> > > * a runtime creates a process p1
> > >   * p1 unshares its lsm namespace
> > > * runtime forks a debug/admin process p2
> > >   * p2 wants to enter p1's namespace
> > >
> > > Of course the runtime could work around it by, before relinquishing
> > > control of p1 to a new executable, returning the lsm_get_self_attr()
> > > data to over a pipe.
> > >
> > > Note I don't think we should support setting another task's namespace=
,
> > > only getting its namespace ID.
> > >
> > > > Since we have an existing LSM namespace combination, with processes
> > > > running inside of it, it might be sufficient to simply support movi=
ng
> > > > into an existing LSM namespace set with setns(2) using only a pidfd
> > > > and a new CLONE_LSMNS flag (or similar, upstream might want this as
> > > > CLONE_NEWLSM).  This would simply set the LSM namespace set for the
> > > > setns(2) caller to match that of the target pidfd.  We still wouldn=
't
> > > > want to support CLONE_LSMNS/CLONE_NEWLSM for clone*().
> > >
> > > A part of me is telling (another part of) me that being able to setns
> > > to a subset of the lsms could lead to privilege escapes through
> > > weird policy configurations for the various LSMs.  In which case,
> > > an all-or-nothing LSM setns might actually be preferable.
> >
> > Sorry I probably wasn't as clear as I should have been, but my idea
> > with using the existing procfs/setns(2) approach with a single
> > CLONE_NEWLSM (name pending sufficient bikeshedding) was that the
> > process being setns()'d would simply end up in the exact copy of the
> > target process' LSM namespace configuration, it shouldn't be a new
>
> Oh, I think I was being unclear - I thought the first option, using
> lsm_set_self_attr(), would allow choosing a subset of LSMs to setns to.
> In contrast, the pure setns with a single flag is less flexible, but
> possibly safer.  So I typed there the result of my train of thought,
> which is that your second suggestion is probably preferable.

I think we've probably both been a bit off :)  Let me try again ...

I'm proposing the lsm_set_self_attr(2) approach as a way for a process
to setup an arbitrary set of LSM namespaces to take effect on an
upcoming clone() or exec() (we can discuss that detail).  I didn't
originally envision this as a way to potentially join existing LSM
namespaces, but rather a way to create new LSM namespaces when a new
process is created/exec'd.

The procfs/setns(2) approach would be in addition to the
lsm_set_self_attr(2) mechanism, and would allow a process to enter a
previously configured LSM namespace set when a CLONE_LSMNS (or
similar) flag was passed to setns(2).

Both mechanisms are very much up for debate in my mind, and doing
either or both, is possible as far as I'm concerned.

--=20
paul-moore.com
