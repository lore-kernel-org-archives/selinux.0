Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD7834EF1C
	for <selinux@vger.kernel.org>; Thu, 14 May 2026 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778789730; cv=pass; b=jY56UK6mZgzmafQrFeXjBOAMe3voKML4ooM+Zk/bMFUjT119/6U7pYTisQkVfoxHzcCz3a1pOVoFZEpnvVJqSxMRQKKeDyJ+g87WhhK6QmGmjIwKWb5fS9AVcXiqsB5i5cWiWxGUgqCPbwZoLr3s1qmexR3YZmlsrmtnnCAyTgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778789730; c=relaxed/simple;
	bh=L23g/GV6s5dbwKzNwqZYuRfdnx5W42pO/aIZUxIvmnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvPEzUs6n8Z1sBrfyPwbKEyukZMw/v+nX/BTnqb+KWmUNFUm60u9PjOQzSjaThVzgtk0Zkot9lQy1ajR6JoiV3BU2B0E+e0791TCgYkMzUHtxdq1klEbE49IOxvbNwBWEdfNuRtm3rWKmhUcHRKwYSJ6mOB7tXx1yEUxFDTrfVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f1PuyjQw; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f1PuyjQw"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bcd3ac3307so29804145ad.0
        for <selinux@vger.kernel.org>; Thu, 14 May 2026 13:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778789728; cv=none;
        d=google.com; s=arc-20240605;
        b=k/+5ZB0HfmsJ0HRNVvP4kNzBR0Q+WsFo+soz19UFNO4KKe3tZfNIWGZWgGERm+HZdK
         FBwZkh3QHPg84qGYj2DCnaCIUFy+GQPcmwAd/SXQ9TTV6JAji1Vj12auaExau57V7wYC
         t8R6XZhiXZDRMPEF3Eue0Ha6d1bnHPC33mzswxJajd4fq7n12Pqazswpd3SDG5z9HtmN
         AUZsr2//yHAyj9TT/bXlMeAwLO/GLsk8hiYz6pwszaJJQaE4716ajrNnoR6+ZTaBlGAx
         RNC802mn1e91GEaWxZTls1ylsrXWdx/nfUF2WcODkfAZB3mLwcsAFS8qfpY6aXxzhZMv
         cWOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dSkJycESPksBK1TkswZjGhIZC6pa0KpxZLEtY/1MYi0=;
        fh=HwJ7l+8wUnvTAhbd/Xtg+lD0qIvObnF8xyIu9BmlCl0=;
        b=kxjv/X/XY6N8zCmaq7v2ecL5kfYzENc46Xpdmx9+m0quujmVGtAKNk/xjhD/YIxoDx
         jS8uoijY0CpikWyDbjYJv+HVC8+9jVT6CayzeKCVxdjHC/2pk6QN6YFTrVXEjFXnUL6F
         xCeeCF6GAlpHlCrbaIzAirEoIQ+OH+nIS5c74waC6xcR1WjvXfjIkz2iC4GJkdZ8V2KR
         0Mv4ALtAy6NTUyFsYGEGLloa+yVWxJKMAuCyXRU5gDMAKhzVQJZKt0UswnD1hfPt/Pwq
         dvcFB2ib6+5ponoKvbzKKzZCOwtuKYou3/jhCO1H4RmXQ/iOc4mBVZxjUyQgCHQw95WP
         4znA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778789728; x=1779394528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSkJycESPksBK1TkswZjGhIZC6pa0KpxZLEtY/1MYi0=;
        b=f1PuyjQwJ2UPuKHYXu4AJK5jjx5qZA4xMN8oFmbMM5S8Ac7A8EiC4bFv8+yK3zvR58
         RprWQ6iZssF/m9KgvXeFW+e/fzXz+kFwBq0KrD4Gi9RSNABJXL/KRxqv69FLRbbZfium
         OtPKil4Kj04QLGDjz1ygQEO3t899yWsx+Qrt0cueifTj5DPn7bxlo2pF0kxZg9lR4ls6
         6bCpNlNg9E6Re+ogkUPfb7zhGQWImdudVZqXjBIyWFlx7ecR8ijcCmF8CKrT11IYwuEl
         fi3RvMyvB5buo0+DFYZV+OWp3hDZRXe8/92UMlTyLvVYMn4mdWrmlukj15scfYShu40H
         4oVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778789728; x=1779394528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dSkJycESPksBK1TkswZjGhIZC6pa0KpxZLEtY/1MYi0=;
        b=MSLveYzT19BlmKQPgjEPYLjB3FDjkX39AyyBTclSn42xlVb2TZgBpZgvR7ykT1Slrf
         YUxwx1cY5ZFmYgdFtZCbkll4TODHLbMjwtEelj+8Sr1nbMb1SXpY9KBgI/pUaVTiiU5i
         Kwb1rOCnhtWsS2Jo6EiN/+0PqbGexEswVk37haGQOUTS5pYtxr5RtBBZt8cgDgfo49Y5
         VRgochL8bQwC38LELguDBK5cXSZPvOLF01dnz/SD+frrU5TcKJnNaRdmH4mq8TLcKtY+
         LiR1lgPgIfxkNisrmh5fYyfIu9+/5wp6sJfn+8Dw30tmgvdshyq+sCZV6+Ua6nTYYRM7
         rhvw==
X-Forwarded-Encrypted: i=1; AFNElJ/x6mU5e7PuIE66xu0jYkluaY4kscOodyyeMMFZxXt5RM/W9EKxpLUqpboPlNKUR9xMOeNvBrTx@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbzdgh5KcA0ZKi+wgy3Bij+jbRMFfybpbsKqiX803qAOt7UnhW
	92hGahCuiiT5fzsiIm46hOjYsX95Q4RBu5/RqXOkGMANrNOfLveWo/kKyM29nJ6iUAOF2QH3PFo
	HEncplZHiF3+88ZeMaTYxFv2rCx/74ate415rmz+y
X-Gm-Gg: Acq92OE4Nyt/qo7IunALUIWjMlBi8VcroZ3Wb1riZk9A79XK4fWh6gvXUXz7v2ae3+/
	AytQJUSDm+zLRd3n1ANs12K46wgBxsUH7gGvCCYHiVyXMPPbeZZ/I8fQ4bHzuPLUsC2rZ+rsOq+
	mtt5/+0pziRMkajTvfx6lgW03FlAqF5JjPuzk/fX8k8lFQV/GuvtklGF2F1bLDEd894uF8AHePZ
	cM+LvozOM42V63iAkAam60Io491JYS/JG5WMSTpXd8Q6hpLHDRtlVJeojTHy/h+Jl79KidzL32r
	sakp+N4=
X-Received: by 2002:a17:903:94e:b0:2b9:f59e:aca5 with SMTP id
 d9443c01a7336-2bd7e9e7777mr8938935ad.39.1778789727707; Thu, 14 May 2026
 13:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509213803.968464-1-atomlin@atomlin.com> <20260509213803.968464-4-atomlin@atomlin.com>
 <CAHC9VhQthq7y2akbQSdJwBEex1MQYWG49wcJK3b8gSQuQ_d1cQ@mail.gmail.com> <bscbywzzx4nmxzbuw2bkzltb7rrmgmzy5u4gqy5pfpmafcnlto@eznniiguusqb>
In-Reply-To: <bscbywzzx4nmxzbuw2bkzltb7rrmgmzy5u4gqy5pfpmafcnlto@eznniiguusqb>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 May 2026 16:15:15 -0400
X-Gm-Features: AVHnY4J6HtYDS9Lrpjl43i8SgHkaXzBYbs_PTjoO3Mw_C9TveMyo-g1mcK1Gb3Q
Message-ID: <CAHC9VhSWrJc=aE1Sg4xfv1ZMmh=JqZFLWGeG2SnzOFqXxcUbtQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] security: Expand task_setscheduler LSM hook to
 include CPU affinity mask
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: tsbogend@alpha.franken.de, jmorris@namei.org, serge@hallyn.com, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, stephen.smalley.work@gmail.com, 
	casey@schaufler-ca.com, longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, chenridong@huaweicloud.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, omosnace@redhat.com, kees@kernel.org, neelx@suse.com, 
	sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, 
	nick.lange@gmail.com, cgroups@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 3:49=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
> On Mon, May 11, 2026 at 04:28:09PM -0400, Paul Moore wrote:
> [ ... ]
> > > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> > > ---
> > >  arch/mips/kernel/mips-mt-fpaff.c | 30 +++++++++++++++++-------------
> > >  fs/proc/base.c                   |  2 +-
> > >  include/linux/lsm_hook_defs.h    |  3 ++-
> > >  include/linux/security.h         | 11 +++++++----
> > >  kernel/cgroup/cpuset.c           |  4 ++--
> > >  kernel/sched/syscalls.c          |  4 ++--
> > >  security/commoncap.c             |  7 +++++--
> > >  security/security.c              | 11 ++++++-----
> > >  security/selinux/hooks.c         |  3 ++-
> > >  security/smack/smack_lsm.c       | 11 +++++++++--
> > >  10 files changed, 53 insertions(+), 33 deletions(-)
> >
> > I haven't looked too closely at this patch yet, but based on a quick
> > glance, can you help me understand why it is included with the other
> > two patches in one patchset?  The other two patches look like stable
> > level kernel bug fixes, while this patch introduces functionality to
> > an existing LSM hook; one of these is not like the others :)
> >
> > Unless there is something critical that I'm missing here, I would
> > suggest splitting this patch out from the other two bugfixes for
> > separate handling.  If there is a patch dependency issue you can
> > always mention that in the cover letter.
>
> Hi Paul,
>
> Thank you for taking the time to have a look.
>
> You raise a perfectly valid point.
>
> Please note, the cgroup-related BUG fix will be dropped from the next
> iteration of this series. As per Waiman Long (on Cc), a solution for the
> BUG was already proposed here [1].

That's good news.  I saw some discussion on that but didn't follow it
very closely.

> However, I suspect the MIPS-related patch will need to remain coupled wit=
h
> this feature patch. Because the first patch fundamentally alters the
> signature of the security_task_setscheduler() hook, the MIPS FPU affinity
> code must be updated concurrently to accommodate the new parameter.

I generally dislike when bug fixes depend on new functionality; it's
backwards in my opinion.  I would much rather see the MIPS bug fix
patch submitted as a standalone patch and then have the LSM hook
modification patch come separately, perhaps with a note that it
depends on the bug fix patch.

--=20
paul-moore.com
