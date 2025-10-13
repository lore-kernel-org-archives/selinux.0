Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19E927979A
	for <selinux@vger.kernel.org>; Mon, 13 Oct 2025 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371901; cv=none; b=ClBnNuRG/Im5C85cVD9pVSc//wVz1GyaO1QJfhpTZrc5rQS5vRHmpcxYHkA2MT33eePUsnqW76mz3oxjVuehn7liCFJexwRAQc4ennMTMQpeovtuJU/IGPJWXrahq+M0G2qgMOwyDq+VHHQgZvIiUpRie6LNf9/v9OlK1kjAbwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371901; c=relaxed/simple;
	bh=kg/O8YEE7mR+ya0+LRSE57GVTGuGrt0BUIQcKJIGT5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yu9LPPqHF9VYUYPrWQNH+o4uIMrmdZe2a2IAVRMw5VMu4B3lr9/AGhKhtISaKI39b9lJESbULrpXEJTPxYLaX3Ru3gWdmM+6P3CDPKKttCgk68LoBdiX8EnI8OUcUXga9CZWZhcVPrhlPr77/DMHN74C/TmwNWH/lGJhJHDXXB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BAafWk04; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BAafWk04"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3352018e051so5125416a91.0
        for <selinux@vger.kernel.org>; Mon, 13 Oct 2025 09:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760371899; x=1760976699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqOTihtF3LWBkyrOGHrf9dtz4pV67L7r6ac9tYX6C1E=;
        b=BAafWk04W2IbJqD903TwCKpzbScLcVU1DKRkLGTFdkHM1jBvA3zQR9GbyFNH8of9oF
         hwsmFajD2xsR0xDY9YRutepiKkY4bbQKElitqEKuRwwL2mDvhsN/CtCGOC3xe0188Qhq
         LigN5AGNIzz0C4FR4VO0ylgKaMMxboX1i2qSCAFwvkvUcRpAXac/uVrDQnIektIi6zq7
         2uNzT8uUFDkS4MwP/H4SfleVSXY3Bn+jcB2ta3lMuMxFFc3KMyQ4CcKm8RtXBhj+IROF
         438Ah7Z9VdA5IMeWIFwxRff350vLN1dFuwoTVgsq42uxqLcVVgyFQyF0glugqziB0CUM
         7V9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760371899; x=1760976699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqOTihtF3LWBkyrOGHrf9dtz4pV67L7r6ac9tYX6C1E=;
        b=aC8FRkHlLaOReGiqQzOufDDIZUZZ3dVtgqPw4uHl797YBLGn5U20bMaW1in3UsqB2d
         dWzR7B40vJ2Pr//DpaXInZwqXqYWuKAvTs9lyrzZNGg2KeVO+rzvoF/19No6RfnIlp0D
         YxM7X71y40uJRPc0SQxvsKiU1JOttdA9fZpvP6pvrXeCz1Lddi9GI3YYiJ/D3AVDjOwf
         DGkVuMMPu3h9Uy7QqsPiql3EynE8O/u29wvqnhkp2abzZsfHsHo6lGztvR6DTKjkA8c4
         GBtggt/eYiXM75l9oMXch89PuH5wCLUvl9zvm6tT987zArVVdD1tYq7V1Q+4OoaGJdGU
         +Emg==
X-Forwarded-Encrypted: i=1; AJvYcCUsiPEooU69ZxZn+zUYF4jfLDNIMuxcRoK0X8jHjVSt0GwpVFfkGA+fHwwqcsjdeN6hsEIZwGkk@vger.kernel.org
X-Gm-Message-State: AOJu0YydJO39xfqIwR+KpR4A/cpYVEbtQP4R2B22gG1cNo3hzYA5Ke5Z
	0kxX8EZa27u0jnVDzRX7TZBHO0h3YIYHIICDLgsyOY9APqrnWUbwBgRKnkqlalcdTa23TwP0zkb
	jk+he/r/WexrvseZ9346wjZR4cr/UtHJAhPSGMVdG
X-Gm-Gg: ASbGncuZ9dSfES5QLQHGtmPBPSteJ/GL67NDxRT2d0AAIkkfYMWIRt+BlLDcF9uvUwv
	Ce2bERAUSlX1h5ne4nVMriIGZCjpQMUh3beuoB3o/NPUdwg9ojNWkPz2SHethKp8/I7qo7cVxbD
	YErW+XZGwqL9hpUupxEpvr7sj/kFu7f/gCQFE/SBr+qfhwKP+gnSnMloX+aJDLIlNMEWXHclfKv
	nP+SoaVMg5Wfl4hXvcnAwl1yQ==
X-Google-Smtp-Source: AGHT+IHRsuUk9qzBCL3fBbXKncdyg4e+WegpXlz1W9aKK5q8PTZ1CSe8HMgR8w4ThEmt0m0Vt2wsoc3RPFAThEuvYAo=
X-Received: by 2002:a17:90b:1e0c:b0:32e:749d:fcb6 with SMTP id
 98e67ed59e1d1-33b51118ef7mr32930909a91.12.1760371898906; Mon, 13 Oct 2025
 09:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918020434.1612137-1-tweek@google.com> <CAHC9VhSbWJ-8tj5BxSTxznGO8zraKRSE31a+tqdfMHB53ef-MQ@mail.gmail.com>
 <CAEjxPJ5GidA9oT_fbKRe_nH1J3mER0ggM-dBW=Nuo765JDuQKg@mail.gmail.com> <CAHC9VhS2TU2GWgfUOHerbfjyxb5QZMSMqLdQirjSdkUohR7opg@mail.gmail.com>
In-Reply-To: <CAHC9VhS2TU2GWgfUOHerbfjyxb5QZMSMqLdQirjSdkUohR7opg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Oct 2025 12:11:26 -0400
X-Gm-Features: AS18NWDWa7MaOMrTZEmj_OT-vE-kCVjZdzIYuzWQVFZrpDBS2O2ZFbNWHUYu4oU
Message-ID: <CAHC9VhTSRkP=jNw8bLRx5em6MnX9HTywBqXGsJCBPQ9MKJym=g@mail.gmail.com>
Subject: Re: [PATCH v3] memfd,selinux: call security_inode_init_security_anon
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Hugh Dickins <hughd@google.com>, James Morris <jmorris@namei.org>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Isaac Manjarres <isaacmanjarres@google.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 3:30=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Mon, Sep 22, 2025 at 9:12=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > When would you recommend that I re-apply the corresponding userspace
> > patch to reserve this policy capability number for memfd_class?
> > After it is moved to selinux/dev? Understand that it isn't truly
> > reserved until it lands in a kernel.org kernel but would prefer to
> > reapply it sooner than that since there may be other policy capability
> > requests queueing up (e.g. bpf token) that should be done relative to
> > it. Can always revert it again if necessary, at least until another
> > userspace release is made (not sure on timeline for that).
>
> When it comes to API issues like this, my standard answer is "tagged
> release from Linus" as it is the safest option, but you know that
> already.
>
> The fuzzier answer is that unless something crazy happens, I'm likely
> going to move the patches, in order, from selinux/dev-staging into
> selinux/dev when the merge window closes.  This means that any
> policycap API additions for the next cycle are going to start with the
> memfd_class policycap, so it *should* be fairly safe to merge the
> userspace bits now, I just wouldn't do a userspace release with that
> API change until we see a tagged release from Linus.

... and the patch is now in selinux/dev, thanks everyone!

--=20
paul-moore.com
