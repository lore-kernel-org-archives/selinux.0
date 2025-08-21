Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4147E25392D
	for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 02:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755743756; cv=none; b=NPUMmYfXP52UntezPMTJVj0naey9VCrSDwW/CoR4DMTEt0deW0WVhwcvuYG6hBa3Hc+skp7vlIOMXaHKOo1AA2w/Q9p7EQFC+VJlaS3nr7aR28q1wZ/2xmrKnVMyWfzk3bZTMNuBUfu5RrIqbvyXlqacvHp4L/ESOEvOU3bi1KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755743756; c=relaxed/simple;
	bh=UMOe/4Z4kVuf/7QpZR3sg7y8Stw+4YrPdcDaFHTRHjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDcmKh49P1XRX/DB0+9bSpMFJTtlz9xoqGCizB/MIYZMzkG/g7cj5u8g65yEEYvMxYbjoldE6/jT0VamvSd7bm0iwKpFvwiPd/B0D32yg47NvHASranP2ieg+rd+VbtS56tKev1exYJ2cxA4hKjcWZid9PE2OkI+rmrovCP36wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CdilRHQU; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CdilRHQU"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32326e06496so559698a91.2
        for <selinux@vger.kernel.org>; Wed, 20 Aug 2025 19:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755743754; x=1756348554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POzxLiaahI/jDhOTSERUZBDU94mQ+lLR+a/gmK+XrKI=;
        b=CdilRHQUnaCCMfQueLF7h81iX84zNNVoAchqmp1Bf0fB+byDYXCKdySimK10j14tCS
         GYOvyS6GoiWepYOWKuNwQ87F212KAJuFTRaLJxuXAUHvlTjKQ0GUdFoTjiEKP1d7YNe9
         3esq8g/9uazsvPnB5YUpx7AhZOD1w4YBzcIs60jdaS+hu7no+3grqcGc/lKskQBg6cuS
         PJcsCETL0FDISuJSobfmoWTvfai46e48AcRsLQKBES4pRbHe7sp77hPbmcSMRd2pCZ6N
         Nyt2FKLN298qrWtq0ONGZ8/xCaiSeyW0oNsR5N4hldx9rALnEhSnSBlg33UJCvwGzLMk
         PKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755743754; x=1756348554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POzxLiaahI/jDhOTSERUZBDU94mQ+lLR+a/gmK+XrKI=;
        b=iGut4JbmMN14YYZXiQ4MBtn5sVIKDZmZsX5FBJXkPC8PYtAE2+tV1eqVE1D/aEcS9Z
         SjPevrmc7AXwWk96+33zdEsmirSqhu1VKysUDjU5cyO/T0z1aVfwczBKD5vQ5L787VBF
         9QhKiNE0RnIDlb8T6TKKkFoSlFIs4A/xWHKAEviI78hxshQdOM8GT8Y/3QDjSEd3B5m0
         I5CcKxVauyLbDMS3f3y5oBOnMImluzZmoLYHBbNTKwEfkH7zxtm2MT/qe5dfjCn4PCC3
         hMX+lfLFQoCgcYPV2EwL9xOQO5gLadQIi6SxLevsltIj2asgUl+fOb5gp3KFfo6iceb4
         NeWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq0oaSuwNslv/b5zAxTPfRYvJxInahvm7vek5gz5mEg84s/SnvYvSWQJ586fE7EmITjA30aZeq@vger.kernel.org
X-Gm-Message-State: AOJu0YwSJm474bNRNWgJjHKQI5RTM4TlQZacvKxYOPwOgWFOXUF9RZ11
	ruj4T1ny4JE6005MmVNfhqe7ZAK8KkEs2w2ZEI1pqgIIDSnISFC90FygYA+OFy6ccQE3HUwVi0h
	d+sEEV/lZ2PeB8YVEQw3acFh+KWl4k8+A6kk908p9
X-Gm-Gg: ASbGncuP7gltwrW1yMdnp6FMHK+pkW+LCe8Rn4unaFYJooLv/jLZKFCc86ydvEPDqmv
	E5S5bSYpGzglLeo4fWvvMeo2nM57QB6WbkSHcHXXb8kXIn7/GvvIsz+jvwzSk02qOEJ4+amPlt9
	54fxI5mOxgOkWhmMbtDEq0EKluYR6CltrHMimIsFuGsdyms7S5HtF/guxoGjihtA/VhJpoxnse1
	ZKE2WU=
X-Google-Smtp-Source: AGHT+IHZWyVzY/UjsBpvZTte6OxIdjh2zc/c0qTR4//IKIQvlO2fWpMcIjsD8BgdPJVG/P+E26865bz9jdnRUnE20ro=
X-Received: by 2002:a17:90b:4ac6:b0:31f:20a:b549 with SMTP id
 98e67ed59e1d1-324ed069184mr1241774a91.7.1755743754243; Wed, 20 Aug 2025
 19:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
 <CAHC9VhSubXA4tAUoz7T==UvfrM_DXS6nF5s0tJZ1HrrVizMgZA@mail.gmail.com> <aKZ+2NMx+ZQhpySY@mail.hallyn.com>
In-Reply-To: <aKZ+2NMx+ZQhpySY@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 20 Aug 2025 22:35:42 -0400
X-Gm-Features: Ac12FXy-Gm-jBci81Eg4G3npbBJYpla6vOiWCIIr-aWGTY0zNy59UZ5_APaALqE
Message-ID: <CAHC9VhR-5Rwg132UsLdpJgM0c51HYBrBDivBinw3YcYqe0QTKA@mail.gmail.com>
Subject: Re: LSM namespacing API
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 10:05=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
> On Tue, Aug 19, 2025 at 02:51:00PM -0400, Paul Moore wrote:
> > On Tue, Aug 19, 2025 at 1:47=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:

...

> > > Serge pointed out that we also will need an API to attach to an
> > > existing SELinux namespace, which I captured here:
> > > https://github.com/stephensmalley/selinuxns/issues/19
> > > This is handled for other Linux namespaces by opening a pseudo file
> > > under /proc/pid/ns and invoking setns(2), so not sure how we want to
> > > do it.
> >
> > One option would be to have a the LSM framework return a LSM namespace
> > "handle" for a given LSM using lsm_get_self_attr(2) and then do a
> > setns(2)-esque operation using lsm_set_self_attr(2) with that
> > "handle".  We would need to figure out what would constitute a
> > "handle" but let's just mark that as TBD for now with this approach (I
> > think better options are available).
>
> The use case which would be complicated (not blocked) by this, is
>
> * a runtime creates a process p1
>   * p1 unshares its lsm namespace
> * runtime forks a debug/admin process p2
>   * p2 wants to enter p1's namespace
>
> Of course the runtime could work around it by, before relinquishing
> control of p1 to a new executable, returning the lsm_get_self_attr()
> data to over a pipe.
>
> Note I don't think we should support setting another task's namespace,
> only getting its namespace ID.
>
> > Since we have an existing LSM namespace combination, with processes
> > running inside of it, it might be sufficient to simply support moving
> > into an existing LSM namespace set with setns(2) using only a pidfd
> > and a new CLONE_LSMNS flag (or similar, upstream might want this as
> > CLONE_NEWLSM).  This would simply set the LSM namespace set for the
> > setns(2) caller to match that of the target pidfd.  We still wouldn't
> > want to support CLONE_LSMNS/CLONE_NEWLSM for clone*().
>
> A part of me is telling (another part of) me that being able to setns
> to a subset of the lsms could lead to privilege escapes through
> weird policy configurations for the various LSMs.  In which case,
> an all-or-nothing LSM setns might actually be preferable.

Sorry I probably wasn't as clear as I should have been, but my idea
with using the existing procfs/setns(2) approach with a single
CLONE_NEWLSM (name pending sufficient bikeshedding) was that the
process being setns()'d would simply end up in the exact copy of the
target process' LSM namespace configuration, it shouldn't be a new
set/subset/configuration ... and I would expect us to have controls
around that such that LSMs could enforce policy on a setns(2)
operation that involved their LSM.

--=20
paul-moore.com
