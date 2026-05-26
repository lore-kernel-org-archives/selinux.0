Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60B5194AE6
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 23:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779838289; cv=pass; b=YdzN/6HRwaCW3sQoT2ZW+z8ZRsrGROZykxsfETjvTMIZK8HIVwx3oQrTO6JKfIkHtvm/TBojWIzASjLWQmM3lUaIhBmd5MO5DAF4SjN43XQSG+tTmmGATGh7EFhvzHUrLkQk4lt40D094DOuYtFUUdyhlS0ulVLa30G8fK1+dDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779838289; c=relaxed/simple;
	bh=9hXxCrG+BuHuuQvRn3gOZu+OTVhhkov9QQNosIuvI+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Og1lya/9R5WNUOXy48xl88CLO6TWEpACbNmr/jIbwL+5QEv8HENcB6JFfWZd/lBRSxPutlu+GPZmVu9Hk/wJ0DzaISjZT/sZLjdY/ExSj1NHhZ7KYnG7XaUK13mgXojxgQ4IlPF8IDaF96Y4EFG8F6hW60urC3tYzloC2ouuFqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=utZJ6o60; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="utZJ6o60"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50e61648f10so3721cf.1
        for <selinux@vger.kernel.org>; Tue, 26 May 2026 16:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779838287; cv=none;
        d=google.com; s=arc-20240605;
        b=gBMbCP3tVyOErt/C2QpxQ/9qU7QPTNhGIbl2Nv9wzX9FKfnMdrz/o1RX7kS3vdaqId
         5sAIJim5a5GpV78ny4q8iMCLu8TasHnQ/nouI8nJFBJ6hmjVTVMnCbpyDBlBWnadwwsJ
         wkJLqCRDEUOPg2jRfLbq4IUnYhgUKEYmTZVfz1Kgs8H0l2leMvxVUwI+9bfRWYEkLbFG
         gu2kGzR9EwPlu14WcXJ6avVuzqbUqrt1uLkzAGw3EQLTi5gOAt723kJfIqcDImXOpVyh
         nEH1rhUvkHgZRBBp5z7r+EzfXWegwn87LHVNQEFqAlfiTfJ71MLLPxWtapmK+Th2MFB5
         gNtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9hXxCrG+BuHuuQvRn3gOZu+OTVhhkov9QQNosIuvI+A=;
        fh=OYclwgFTdTe6GWNWBL6uWqCqh0op9Ic3EWgtdSR9I+A=;
        b=cZPsOnhmM5+6hJI7bq76HJby/vznZP7jxhMywnQcoDAIc8hBHqhCIPIfncgKRp5tuk
         g1X4mpg1KT3NRnH4CLJkB3xVhDT6kTZY3vUvOfyVnsUennh5Hq+/Qa3ew/XWNZ2kckbs
         ndmdt9F1eahNSK4l5lqWaZQlOVj3kfNGFdz8Ij9Qfvak8vnboSiNsQFyUU7NnTHxM3ne
         xcNRrXgViywAZtrOKHgLkLytzKgt81cMGAwvZuFqheI9YWl0zD9Z4FT/LxEvMnC5IJsP
         iMZ8BPbdo67SYdsXh7j3gEGjNVilYWCP/0Q1NgbwDHth5/+aIdh+NgIjNn2vXnfhc4k7
         Ah+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779838287; x=1780443087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hXxCrG+BuHuuQvRn3gOZu+OTVhhkov9QQNosIuvI+A=;
        b=utZJ6o60SKxklO7DspvT9IXGJETw3rQxvb3CSUOEF+keE9+ZskkGtzjllyAa7G3HNt
         2xPHTXjZIqyM9kNBaM4Iu8DGpj4nYxyhuits96rk1z97LngLVUXaDiPeVlZhdUCTkdgh
         HtjgbkGQ1ojl7GW2iVeDM8TER+wSDjgAJzJsC1AmDCUeTXFpbj2JLMI/lSHL50cuMb0y
         xKzDXm+XsIaVlT4F2BU9ADiW+AGL5HryBa4ccOly8NdBj5dDj3DjK3u9W01NdwDI/5VU
         g8ENlqcWmiz7pYMUNuIuZl6qk9tE8EWHRFgIf1E0RUwieEq6A01sLj29oULEZlgx850X
         13xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779838287; x=1780443087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9hXxCrG+BuHuuQvRn3gOZu+OTVhhkov9QQNosIuvI+A=;
        b=pAehHVCt6OGayXr+n/qa7RxZA2TH67sKFcSCJKR93gr42db1RHHx3aYHO83/TPfGUV
         kGcJmptwu1Zwqm9re8YMBu5xr4MG2t8ynxvKf5eem8megZ+4rd0OqOpJRPSnOLjlEwhf
         vxqFELTKcOD9E8zc7cVGRV0IEs0BYsojpN5vhd3CJpqI3Th9iKyLJhpJS+nUsNHh0QZk
         +mJv9sQfO70OoEhKCqoRVzP64gq6cj4jHojmnTi4LCnPTru2z5VKrIra9VodvUjVR43D
         7TKsedMKPAUArH1qP6V9FNuZzOhGcTmpws0t7lLbSHy61XHLTMmxCL7opvi4uFqneC7A
         XOVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+yCIBO9JDYoEF64F6ofAbcl6ei8jRp6JjkwcfI7T7hCVxp+ZQ/r4El4xXrPAj99PRquSdWrVb2@vger.kernel.org
X-Gm-Message-State: AOJu0YyiFkurCzuodki5/Nu8hZxvRswddsss/KwvZ2MwHV8bWEqdsG8v
	GCGt6KYSgbdaTjL3RiJ3PHQ7z/BvgHp0o/lf7K0oDf1nwHbKaXjKAmDgACAB6Kp0sztpHbvSlPp
	3Dmc/EdmuIunrL/adXd+m2VhvZnY+q0odFKjxf/nv
X-Gm-Gg: Acq92OExsIxHWF0+QHfu2L0Ooi0dHybFPT5Jua0WIOSdRvAPQhK5vtKyCyBEOviMmmy
	ORK292gdBqzFRdYnDdOJXWX6qUtiwFq5NpB3V5jVrmT9B6Ad+mfqyQyfqEoGdtoTobr9zxdOnYK
	dfLxbAiSnXqPn6RrpPCd6HAd/DNZZnX91/uxadXrCxDOwfKQ6w+vyjBtCSvR14rEAhFzNR/xoeP
	k+zoiArLdf2oDVHAb/YBesLImmw7ufndgh/Y9n0UwOt3n0polDmf3bONO8bNDVS0xJ+Dvr+7plI
	6bIRmyFscgvqWxehA7+LCeOpjOqaMbAEvFWHneN5ty5tQNnJRA==
X-Received: by 2002:a05:622a:1c05:b0:516:5709:45e5 with SMTP id
 d75a77b69052e-516e0d92954mr38678891cf.14.1779838287105; Tue, 26 May 2026
 16:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4bb+sBUPPVYbwkay7w6k1NJx_6adiLVbHnYa5vjb5SUA@mail.gmail.com>
 <CAEjxPJ5OLy3NVut1PW_vAVwR+qUBTv+oq2Ngt3R_Rk=Hx2FgXw@mail.gmail.com> <87mrxmnrz5.fsf@redhat.com>
In-Reply-To: <87mrxmnrz5.fsf@redhat.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Wed, 27 May 2026 09:31:09 +1000
X-Gm-Features: AVHnY4JZcBsI2l-XHGakGylsH6C4Nv7xuLDCPJ6lYhUu8OZwJo_9DcdH68dZWtQ
Message-ID: <CA+zpnLeN=y2hV1MczSZSsPSk5X5D77+nt1uu-X8_PtV=-pj44A@mail.gmail.com>
Subject: Re: Minimum kernel version for SELinux userspace
To: Petr Lautrbach <plautrba@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, SElinux list <selinux@vger.kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	James Carter <jwcart2@gmail.com>, Jason Zaman <perfinion@gentoo.org>, 
	Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 1:00=E2=80=AFAM Petr Lautrbach <plautrba@redhat.com=
> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > On Thu, May 21, 2026 at 3:33=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >>
> >> There are newer kernel APIs we could leverage to further improve the
> >> SELinux userspace, but doing so would require setting a minimum kernel
> >> version for new SELinux userspace releases. Not sure we've done that
> >> previously.
> >>
> >> In particular, I'd like to be able to use some or all of the following=
:
> >> open_tree() + move_mount(): v5.2
> >> openat2(RESOLVE_*): v5.6
> >> mount_setattr(): v5.12
> >>
> >> The question is what if any of these can we assume to be the minimum
> >> kernel version going forward?
> >> - kernel.org LTS kernels span 5.10 through 6.18 currently.
> >> - Android common kernels track LTS kernels.
> >> - RHEL 9 kernel was 5.14-based.
> >> - Ubuntu 22.04 kernel was 5.15-based.
> >> - Debian 12 kernel was 6.1-based.
> >>
> >> I would guess we could set the minimum kernel version to v5.12 and use
> >> all of these interfaces, at least in code not used by Android.
> >> Thoughts?
> >
> > As further context, I'm only looking at open_tree(), move_mount(), and
> > mount_setattr() for sandbox/seunshare.c and at openat2(RESOLVE_*) for
> > sandbox/seunshare.c, restorecond/watch.c, and
> > libselinux/src/selinux_restorecon.c. None of these are used today by
> > Android AFAIK, although selinux_restorecon() was based on
> > selinux_android_restorecon() and might be re-unified with it some day.

Thanks for modernizing the codebase and sharing the plan Stephen. I
don't see any issue on the Android side.
