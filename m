Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C41622E3E9
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906966; cv=pass; b=UKkQUqwRnD8IRk7bS73/GZnqu4b1dDD4eDUEDBDGuCcq9QnU5hKrTB2cYrO02+mXtPy82hulY/QsVeSAGYW3JyYPjo/8Qs/xBo/kg2LOFSDzl/31sTVBMEHcj2xo/9kZAY7b4Sv7S3WU5OwovdRb9yvy73B4GKDfaXYkboFhX+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906966; c=relaxed/simple;
	bh=KcubabikT31XxV653m45sCoGMr/eNhuLLpXSykA+uGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1kkeQgiZCeCnK+fRXC6fpqMB+xB/tM4RO9drCi3IfDdsxUUrVwIlWxj4TnAj9E+szmCxio3fEhbtF8lC7iahij+ookuIWopWA3oQq43FQ5T3IuuQo2kW+Ir4VvwwPm0wtJ2K/M9wHuHDlJH+LeBD0L52T54bg2Ms48z+r6E8UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAxjB1tn; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAxjB1tn"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4560d6f82edso263702fac.3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 08:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784906963; cv=none;
        d=google.com; s=arc-20260327;
        b=sNR3l25zn9ubUJhpNlMxBCcdHonmfSMBErr6JACz/hMzOgrlL3lUoDwszsy9HXuRbW
         7NQeM0IqIyylF2xj27mWhjkxd6bufNBMApVeZ7bA/TIa7cSwGg+BbBgem06owii3NQ/3
         P/SwoznUyoXGxYVsomiBj8++MKMcqpTnNmP/vqrnvQbNazbzmVOXbR17ObnQnnZSqd8y
         TYkNNgZoPHLHavDyqZg+qpQZlOkGG+248bZZY4TgDLwlYw2v1tBcoW9tw7/9hM0GJ9EU
         /jqK3urdjrVaawJozA3qnHmE6F9BWelFFxDiO6jMFciGahZEj50MChSEmYIqpgz0nboj
         Q32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KcubabikT31XxV653m45sCoGMr/eNhuLLpXSykA+uGE=;
        fh=GzyI2ONSPIE5feUa0UlNy0S1TSYRl/j0IMaVpx3MUs8=;
        b=iKKonHYTQ5/szkWQzMyw54dQkKLytmLNVjySN9mYcslXIKqifypYKV+RoBXamqPG5U
         VRgUdFzOaXnm2HOdsXnZxWHxLRSEoN23IBIjvL40xjd71fTo26ZWyPSy0AzGhqz5uyKv
         L98BRfQUApmyCjsuW9V/XkMQ7yNxTZrGi1g679mOz1Q6OZqwNVOnG6ywTi4O9TbqXxy5
         qG+kfBJeJqpxN9JrfMfMTQ0FOUNmBenjBpws2PXac63c0cIWux51tQ8QZRAuL3opnthU
         EGTX8NNEWbn+5k8E2aNbcK6lB7JjP2RB93gdIjeY0ebmvWYA8hlIw7aCSBRJlsb7S9OV
         gdMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784906963; x=1785511763; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KcubabikT31XxV653m45sCoGMr/eNhuLLpXSykA+uGE=;
        b=bAxjB1tnwEvP0PhiCUM4tjv27lBPajhz5NaHFBLYDnfdhHjkLFhS1OaOkWd5SUXe5k
         PBfQtSdos6832HsLfp3Wbzmk9n/LbLV6s0BDv6vYKNuVYXloTQ5/SVaPrNtRym2GAxuW
         diwGM2Ek1RcJkwIuJc7wRqJaPLcep0y4o4QxTTifpeSQi+z3cJOAkzKDuGgj7paM0/Rs
         nh2ZhZK6MJc6sdCQXAMN5Zv+YHA7vJBgaVNUNInxCKKhjv4tfdIlQjAKKLMhaQVcDqyv
         GM2xvLveSSClu8rKQimnVgbSAJCLBEdgHNwaiWnCo4CLo+9G8A5sNtNc9kz/wyZfotgb
         XoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784906963; x=1785511763;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KcubabikT31XxV653m45sCoGMr/eNhuLLpXSykA+uGE=;
        b=WUIDkywN31tLGwwMhtaNn2qLL6sl3f2cmAdI+5X7t9VyUdCtQX7kqgcSu4qe31n9Yt
         L6iyo82+qObTFJHd4E/dP/nltrKayU7m6wV41aV1AUmCQoFO7468I1FT3RRHQmI3Rsw5
         SujMz84GePq06KzewKJHne43s/j29OPFNxXAyo4BAgnri+NYABbl93qTsNVlFZS7bi4z
         pKpWoPpvKP5ArzlCbsFyHZ/++Gfua4UmmsL1mNBbFMFqY/bpKoA8DGWVzPClkGJQfVHE
         Pq8Au6hZfv6tbaOaY7g0a9DITnRmq4sJs1CgN6d5Ld4DOa5AsPoqgJk48J/RHn15pUnW
         ETYA==
X-Forwarded-Encrypted: i=1; AHgh+Rp2ItWWrH1wEQI2X8zEttxOV4SVlFKgfRw6vN8P8ynGYwFZOUrSf27pAsUBYMoXRrUjcMm+wu+3@vger.kernel.org
X-Gm-Message-State: AOJu0YzKHwNCZMnAT8SElFF6FwcsPLhLDZZjTUsYR55QHOeqXhrO76Pl
	TlZDMK0UaK5ghzzeTubToNku3MDr2EeQb/S6uemcSGeqcgsbOVcMydSGXh2y8xGcjYvE9Qa0SBn
	coB1FGEut+UPAYakosAkT5xiVhs9ijL8=
X-Gm-Gg: AR+sD12T1vdyBAJMc3Hj458D7NhaUWYF9YXYAIDDlNSZWQ4dXorZp3KxR/uGLj8yCEL
	66GboOr6VEZ8//tqQ3xrE4dnaxvfse8rR+fUvr1TvU/K8VnjIkp3AJktKx+K+MFjVaxxIYdQIQF
	UmSJmh9dRl51tgLreNyZUFcrr+I0RWwHVmrMU4/k4ezjG5uBKLe/j4qj2zevZIB5eEg5Qw+N0tE
	YOQnWYLM9EE6UHKPhT6I74fxp4rN0779fpRGR9zt7T4kJzP0U5bv85tvWQf7Q==
X-Received: by 2002:a05:6870:8648:b0:451:cadb:2a98 with SMTP id
 586e51a60fabf-457a0b3ec7bmr4646302fac.2.1784906963337; Fri, 24 Jul 2026
 08:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <amHW-fFHM3pw-g3y@suse.com> <CAEjxPJ5KfidbsqrUe07F8sdssdqEtEUsBUDgGqn4dm4RZUcyOw@mail.gmail.com>
 <amIxkNuNJcxhtkOR@suse.com> <CAEjxPJ6oS-W+5e6G-KqSr60CP+GTU3G_A6d0nLpFHQMPnqccGg@mail.gmail.com>
 <amI2denYr02e5TKA@suse.com>
In-Reply-To: <amI2denYr02e5TKA@suse.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 11:29:12 -0400
X-Gm-Features: AUfX_myOHknryVxlg3OVTBGdp9UvrOIesO0j5UIC62buTCSuUtrCufBZEqkxdtQ
Message-ID: <CAEjxPJ5VzDzK_JAPmHJZhYvQKAbKXDum6mOgvitc=H5XHSFH-w@mail.gmail.com>
Subject: Re: [PATCH] selinux_restorecon: Do not exit on directory cycles
To: Johannes Segitz <jsegitz@suse.de>
Cc: Petr Lautrbach <lautrbach@redhat.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Jason Zaman <jason@perfinion.com>, James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 11:42=E2=80=AFAM Johannes Segitz <jsegitz@suse.de> =
wrote:
>
> On Thu, Jul 23, 2026 at 11:38:24AM -0400, Stephen Smalley wrote:
> > On Thu, Jul 23, 2026 at 11:21=E2=80=AFAM Johannes Segitz <jsegitz@suse.=
de> wrote:
> > >
> > > On Thu, Jul 23, 2026 at 10:55:48AM -0400, Stephen Smalley wrote:
> > > > On Thu, Jul 23, 2026 at 4:56=E2=80=AFAM Johannes Segitz <jsegitz@su=
se.de> wrote:
> > > > >
> > > > > All other failures are handled gracefully. Directory cycles can e=
.g.
> > > > > happen on BTRFS filesystems with subvolumes. Skip them and contin=
ue
> > > > > instead of exiting
> > > >
> > > > This is a user-visible behavior change so we should note it; restor=
econ -R
> > > > on a tree with a bind mount of an ancestor will now complete with r=
c 0 and
> > > > only a WARNING rather than aborting with ELOOP.
> > >
> > > Okay, I can write something up. But in general you would be fine with=
 the
> > > behavior change?
> >
> > I am (although other maintainers are free to disagree).
>
> okay, I'll prepare an updated version with wording that addresses this an=
d
> ...
>
> > > > Missing Signed-off-by line and the patch still doesn't apply for me
> > > > (did you send it using git send-email and against current selinux/m=
ain?)
> > > > but also see comment below on the code.
> > >
> > > I start feel like an idiot. The first time I used this old repo with =
the
> > > wrong branch, but this time I made sure it applies, but didn't use
> > > git send-mail.
> > >
> > > I did
> > > # git format-patch -1 HEAD
> > > 0001-selinux_restorecon-Do-not-exit-on-directory-cycles.patch
> > >
> > > which for me then applies:
> > > # git checkout main
> > > Already on 'main'
> > > Your branch is up to date with 'origin/main'.
> > > # git rev-parse --short HEAD
> > > 84d424b8
> > > # git am 0001-selinux_restorecon-Do-not-exit-on-directory-cycles.patc=
h
> > > Applying: selinux_restorecon: Do not exit on directory cycles
> > >
> > > Maybe my manual inclusion in the mail breaks it? I attach it now to t=
he
> > > mail
> >
> > Yes, unfortunately mail clients are unforgiving of inline patches
> > these days so we recommend
> > using git send-email,
> > https://github.com/SELinuxProject/selinux/wiki/Contributing#contributin=
g-code
>
> ... will set this up. My mail setup is bit unusual, because of this I
> avoided it until now, but I agree that it makes reviewing easier

Also, if you could pass -v3 on your next iteration that would help b4
figure out which version is latest.
