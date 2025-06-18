Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3182ED844
	for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258248; cv=none; b=BWrLtoEVF8cMMq0xUk8GRXPWI09TYz35APqwAf9RAm5yO6ycNfTNdIbrTPP7bg+PO+zYsEqm3MXtp5c8ld/wvC8+t1lXSQZNyJRDtxihMp38thSX87XANrV5aeVXosjrrHGlDEBuu76HI8RS54bpKG0xvmTNJw7NqWBdZYNM9tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258248; c=relaxed/simple;
	bh=tcTafZ3pqbFQwHEMwHmIlzRj6Rk2Evf2Co3CGbo1eGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bp8HR+hoL+z0vBIZMb/KCHwaspu4shRaomNIOMtwVnElD9aElJpdSeBwm34f23P3YtHj+c1uSPGIvWnAVD/ODqTttUsXpVTNmAW2Kor3SEW370VSXp3fUsncgLl1IAkOL4z2aXmlPouuNRjjZheHHjyKVeDgPi3H1jlRy0PhL7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RzIClQZN; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RzIClQZN"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-70f94fe1e40so10006987b3.1
        for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 07:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750258245; x=1750863045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcTafZ3pqbFQwHEMwHmIlzRj6Rk2Evf2Co3CGbo1eGQ=;
        b=RzIClQZNdBiiPgLajkLwcm85+LOWXVmomAVcpZJfl0PvWaR40wOx7ZtGe81shKzYq6
         HcNE4hs5jxbE8jPjgTmjrMrdIuaf0Ptzfu5+g+CERRPJyMkwzTokbqL2YZhkE8xpO9j/
         VcPVdS2sQcGTeHZcGOF8rM5ujWD9lcGvBQ00UNFMAImycVBYfL8Lx7Jw6EpAUyJdxaPU
         3auSElGwff1sjkZd+Vp1KSL3ZP3/gEsYdZhEf+jD6oCpK+YRmhVzLPvH5JfKgxnpMo9e
         j3zrQ7waNMdQXu0pgZbJXNfae9yD1t+SKd0Bi+v04sntsSuitQpAlfCn+LHH9fH7zS7E
         t+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750258245; x=1750863045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcTafZ3pqbFQwHEMwHmIlzRj6Rk2Evf2Co3CGbo1eGQ=;
        b=b0dq8lQZAUGc0mAV3RvgcEqVp4D1VLKeba3N0/r9u4k6H+/neQq8tAu86u5kfLhv0m
         3EZLvvSkZvW0gkQMlhSV2qqmHwHZqzs75mMPhRsAs6+3O9K7YAy43jEESErJNVY7b0C3
         inOgaAdM0YDIcBQpa5cukQ9RduwmLyv7C+u52CQXLl4xyRqpFBb5ZZ0V2441QgVNVQgp
         5I1j0crzU4wAqnRyI34x2DDvB+casrfZiinMBhs/c5N/JHC/MUsBauDMBe2FNU3vDnnz
         QMl5RZhu0ENDwCKjYuZtK8jDZSW63moB12mKohQIo719fopWs6WnyXcwP8GYk0CNUURR
         cSjg==
X-Forwarded-Encrypted: i=1; AJvYcCUrjwkiAnj/p/oM0NI+D09sQWTWl/TqZoSmfPkON9pY0XMC7hBasLkACwW8OaKDCev0JaeodD1q@vger.kernel.org
X-Gm-Message-State: AOJu0YxBH30onCuv2AHucWgtho6WSZ5i/EnNBSQ149xmB0hrSWptWL07
	6WLB1jD/WTqlkEEj+zADHQqw7TaQZra/lGEqFkA59leR2Z+fxKbym8197rkal47S8F+8ONztCFQ
	px7+A3V/E1w9LdKtvwgEE2NYani0+oGdegnCd6TFwhXZXW0Q24AM=
X-Gm-Gg: ASbGncvSV1k9n+n/q9hYepFroetROpXjD0uDhVl2GGyScuwlXJmOnlfkr2K1jufAwoM
	S8daFyR8BBNnc65oAPQYteugH1A+bn1z0CWx64e41C7MDKzf0+8eCaa9PlKxdSWmp8MdSR7sYo0
	CbP0CCDhTHDuzkQgo5noC1wYneiN798MmMmBr9g/037PA=
X-Google-Smtp-Source: AGHT+IFxMMslCgutKgMMRr/XtvErMuhkeY2Dtk/a5qksBpvugGo9mDhEDAZWKxo29PokHwMFIDlgfKWSlx/u0dTouNg=
X-Received: by 2002:a05:690c:61c9:b0:710:e81e:1364 with SMTP id
 00721157ae682-712a6c2a5d7mr38544947b3.6.1750258245679; Wed, 18 Jun 2025
 07:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612081208.1721183-1-omosnace@redhat.com> <CAEjxPJ43XpL49FZmb6Ds7CD71mZffNMKSiOfpesh2Lgw1eah4Q@mail.gmail.com>
 <CAEjxPJ6+xbt9oKTJbGdJJ_seB=ZFRzeT2KHoEHM9ay1FY4_9Qg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6+xbt9oKTJbGdJJ_seB=ZFRzeT2KHoEHM9ay1FY4_9Qg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Jun 2025 10:50:34 -0400
X-Gm-Features: Ac12FXxhgtfssdFK2Z87faSxiI7je2iBryftddAgSB9qKUeiPO27NB4F9DIsdss
Message-ID: <CAHC9VhQpg82NGaQ0Y=2RoYvGmZVDPFYBOSyZf2YphV3-4bGDZw@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: properly detect IPSEC support
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 10:03=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Jun 12, 2025 at 12:18=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Jun 12, 2025 at 4:12=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > >
> > > Check if XFRM itself is supported by the kernel when deciding whether=
 to
> > > run the IPSEC tests, so that the testsuite can be run on kernels with
> > > CONFIG_XFRM_USER unset, too.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Feel free to merge it yourself. BTW would appreciate your input on the
> > patch/discussion for inet_socket iptables-legacy vs nft issue.
>
> I went ahead and merged your patch since it has been a few days.
> Also, if there are no objections, I plan to merge my recent
> selinux-testsuite patches for the README.md iptables-nft change and
> the nfs undefined label change soon.

No objections from me, thanks Stephen.

--=20
paul-moore.com
