Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12B01804F
	for <selinux@vger.kernel.org>; Mon, 15 Jul 2024 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721078614; cv=none; b=ON5nFjzxKWn28acwcaiZy9WH7gZWEEZVocndcMtMBKoqoizO6JHgdAR2GxIjKPF3q08BRZ5x1vTC7LblbcrhxjMwj/efD2GfvaU58RqTEbtHDx3Ems0uTD4VGwCBwb89TBgtR5A+XOGoAk0jiULGk1YAUYW6QWW539k3hGeqNDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721078614; c=relaxed/simple;
	bh=MZ3iBxt+5dqDGRLllZnI1LCFqMjWc4P+6DjlVLb7tec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mfo9V23cpghI9iV0P1SAMhI/GZuAFkH/5m7eYdB+66205RblvtkgK8oA3yTyY46KPLceehBYnSH2FBeQBne0ZH08PxM0Xuwer2UA2pB1swUvYMIxI4iruYeWXiwMLnZ0kQk51PmEDHZjNzVAghV3GbAKCXSKqzYe1ifCa5LwYPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NXX2KmNJ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NXX2KmNJ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-659f781270dso45193657b3.1
        for <selinux@vger.kernel.org>; Mon, 15 Jul 2024 14:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721078611; x=1721683411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEnN5uN5cY/n5JR2WvewER9KhzgBlk/5MGdM2c3D0Yc=;
        b=NXX2KmNJ7XU27sXhjJ8PJIsoTnyK3wa5INopVtIOP0mYPdCFJNFHpaVo+9DFlPi32d
         oXhtBjRw2T8cbzOY6m/jzxLIC3RLGogKIJya0ioPV0o6zWBrZPqpJMRaC01DvwYHAFPr
         r3PUj6NypGQ7NcGsN6A8c64SqEq4TeCPkFNsXXtZ6gruPb/71jY1Ky9KgrnDWqx/3cY4
         0VHWtezWuhm5ewCgmKpCmD4d2AVQ0F1VcMolMYZMlRwYrlU1VRe9tJk6xgJpcGjJaqrw
         1VjiKMD89kcDlKw6tLuxgKjaoHGmF3wMIwteSQ6rJEJNiutW9z1GQgQl6+eVnU9H3TIH
         Q5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721078611; x=1721683411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEnN5uN5cY/n5JR2WvewER9KhzgBlk/5MGdM2c3D0Yc=;
        b=bTTsJ+ZogTN7LPtdcvAGPwdEz5vw2BPqBSdsn+zL2m6o/PGNp1JgcY2hy3c5jgRFKk
         ronYOVOJjnAn4ARNTrTsz2BHiJqJxxJkfVzjlL9FOCObykOH2MEEGxHTBqh+yRoc7vw4
         ydmDk0wX85L2QzXAhKvdaYUMLRvYh95XoGhjLFP6sVOMnCfWPq6liC9q1utrd4ZcZm+k
         dHZMr7eSqrPtL2gMztjMh5ELw+nDzNcDifJlbfPGrYtIDQXM0+AxjtRGhs1dIwFRxzjI
         XpA5HkN7TQtXCzr4yuypvbA2h6IAeGgXX3ILBtcsDIIFUDRW+zg5Ogs4LyUWjYls/3Au
         l1bg==
X-Forwarded-Encrypted: i=1; AJvYcCVlsUxBf6D2o/qoQ+uBFEDv2JrDmZQdGVktXjWqX/IAY3UillRi0LBeJMgxkfjLWzFfFjizj8SykM0SiS9zLU1lk7gPWTWKoA==
X-Gm-Message-State: AOJu0YzBV78mc1kNjMEcCWyBqny5uFmQf7J+u0VHYolbxZRf/9szLI06
	jjH6KGTECPU3/sVjEvKbRJ3eDK0YlP3qBBfkJK1zTDUPlMO9c+UeV1RivG5dknOxeS7ewpEgziJ
	AMbI7fQFqLF0LdSoFEj0Kee6L6PYSdmiu8Q6B
X-Google-Smtp-Source: AGHT+IH+Qq7dAFzyGYGImGr7Ipjqqk01sz7FXkA4fwUSm/bl+/PzFE0JSsAaoOe8H4FstSfodQ/izKPDYhsurwMH0q8=
X-Received: by 2002:a81:9e50:0:b0:65f:96e9:42f4 with SMTP id
 00721157ae682-663890c272cmr1039547b3.15.1721078611496; Mon, 15 Jul 2024
 14:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710024029.669314-2-paul@paul-moore.com> <20240710.peiDu2aiD1su@digikod.net>
 <CAHC9VhTxz6eFFUBZYJ3kgneRqKMSqaW63cXuQvVs_tt88GU_OA@mail.gmail.com> <20240715.uax4chahCohw@digikod.net>
In-Reply-To: <20240715.uax4chahCohw@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 15 Jul 2024 17:23:20 -0400
Message-ID: <CAHC9VhQtENHOpx+CpeFT6jySqvK-Hc40iFkc0H4RMTwf_g58Vg@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 9:35=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Wed, Jul 10, 2024 at 12:20:18PM -0400, Paul Moore wrote:
> > On Wed, Jul 10, 2024 at 6:40=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Tue, Jul 09, 2024 at 10:40:30PM -0400, Paul Moore wrote:

...

> > > However, I'm wondering if we could backport this patch down to v5.15 =
.
> > > I guess not, so I'll need to remove this hook implementation for
> > > Landlock, backport it to v5.15, and then you'll need to re-add this
> > > check with this patch.  At least it has been useful to spot this inod=
e
> > > issue, but it could still be useful to spot potential memory leaks wi=
th
> > > a negligible performance impact.
> >
> > Yes, it's a bit complicated with the IMA/EVM promotion happening
> > fairly recently.  I'm marking the patch with a stable tag, but
> > considering we're at -rc7 and this needs at least one more respin,
> > testing, ACKs, etc. it might not land in Linus' tree until sometime
> > post v6.11-rc1.  Considering that, I might suggest dropping the
> > Landlock hook in -stable and re-adding it to Linus' tree once this fix
> > lands, but that decision is up to you.
>
> I would prefer to backport the new hook.  I can help with that.  In
> fact, I tried to backport the removal of the hook for Landlock, and it
> requires the same amount of work, so it would be better to work
> together.  That should also ease future backports impacting the same
> part of the code.

Okay, let's get the initial v6.11 LSM PR merged (I just sent it to
Linus) and then I'll post the updated patchset and a proper patch for
review.

> BTW, while trying to backport that to linux-5.15.y I noticed that a fix
> is missing in this branch: the default return value for the
> inode_init_security hook, see commit 6bcdfd2cac55 ("security: Allow all
> LSMs to provide xattrs for inode_init_security hook").

Likely a casualty of a merge conflict; I haven't noticed the stable
kernel folks doing any manual merging of LSM patches that fail an
automated merge.  You can always do the merge and send it to them.

--=20
paul-moore.com
