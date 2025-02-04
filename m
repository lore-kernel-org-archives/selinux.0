Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F3A3D984
	for <selinux@vger.kernel.org>; Tue,  4 Feb 2025 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738629007; cv=none; b=JFv/nuuMnElU4NURxiVbBK6HoIIBYChejVXOtmKhcxuL8yu4f4aiYPIxJMWSrBrW9JgGabp3glzS07xzPcdwJjW+frBRHkz24IjZkWPw4+mRC8GhgLpnVDKRQz8SyjSZbRkYp2GmPsqrPLwgcByZsMeJmYRO2TjUPKGnsVb8BUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738629007; c=relaxed/simple;
	bh=NrOjKgLQr3QfAne2gG2ROs8/SBnGodNEd1uyXzcB0Qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VURPhKEa+WMjltfkT7TR8dXmtskcuVub9BOC3w0Q2wGz4/bWAmqlVigT9roxAKBi5G0k/XOiQ//J/2MdQNbr+IBONtffNsCeVCwQGBYJbqm8MxoES41QswoNzh8lHdfnyqJ2yBnCu5nrEwHXzbdRAidr7ztFvRZqXoN6PAu3Exw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AcOX3u0C; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AcOX3u0C"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ef9b8b4f13so30340537b3.2
        for <selinux@vger.kernel.org>; Mon, 03 Feb 2025 16:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738629005; x=1739233805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrOjKgLQr3QfAne2gG2ROs8/SBnGodNEd1uyXzcB0Qo=;
        b=AcOX3u0CE8uA7DeD5MPddVECOozCU1QSyO17jqn5/GUixgkVaAXBQUiMNVzVCxMS9x
         4mDjmn9tqsPMasGp/j+f2kZrGNas8X+mWTdhU2+rx2ZRDMtFb+QARHLxCwxV9uRn4POi
         Lw5H6FM34Jq/+xWV7ZHCCti4vdThpZU4SxTY0CmPg81GKwEV78QcCtGVfkYzO6O5O1az
         L5Xkx7Kn8bZ6WLR54p/1heCupZRtxj0RTSIqdUFKjtaFSGRb3b3ygaeHZmRaRY5lvW4r
         iL180QOPEhI1oyoVHJkz0txXrAFp+nX8dw+mYQBL7cQ9faAGrW/Xy7wq7eJvJHyEZVGc
         iOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738629005; x=1739233805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrOjKgLQr3QfAne2gG2ROs8/SBnGodNEd1uyXzcB0Qo=;
        b=MfTLUlMXBLc8uqL0k0nd/+lO0c01y2JljHwL2CcG5boVFfF3dxppuIbRe/Qs7vnyXf
         ZuzhTeLJLN0SeKc9TGO7VqWDarC6NlVhUV/pR23KBc7mMn2nVIdhx2CBgO8PlVErw57O
         ij2ki0jzvmgq9Y26KKnGsBNAh9gYxi89bmm0odAworSAhpYuRRt/74Jxrh7aTkUUWTCz
         otWQ7Mr8ubyb1WBv1aX2NXk9kZDyI2yXMr7MRprZYz98+xH4NeV8Z8vaaHKG2dDJI4Tn
         zxM0pvglsAJ4lud3jxt3q9Uo4kZmlMQhb9ii1ke3YmY1lLUL93ChG7/rFdq+lUIm3qTC
         IXtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhoM7j4aGRz9lqvruLUBioLCj0L+OMshqQXvttO3PzqiY0vxnD8ciV1LN+Lra8v23e1twM4PfU@vger.kernel.org
X-Gm-Message-State: AOJu0YzCaswQz8iO/xKYnUDdlZwEXGhCS9lc7L2zIQny4Ju3nDPVOw1c
	FbUJVVI8788VMIWY5s8tX2X/xa+8ZcZ2qVe2oatUVnEvQzyFDIkW50apjgi3ODVNla8T4EauhKg
	hjgTcf4yJCUtIRbSS389pXqDEvNADNdyAu3zk
X-Gm-Gg: ASbGncuzF/5EV1ABXYvvbt7GQycH7vbN7Nt9S20iX218Fb8AsjC+/ThUoDgE9S9iuJJ
	OwXN2i2gAGOTgbYLkSKpGkgMVC+BXN8sQk5SkWrUhuA93EI5lJJ6s7kmlv0jhtA3kPW1Lh1U=
X-Google-Smtp-Source: AGHT+IEVbwtz+5w3Q/0H35+gEOBvf9lHbFARWTV19VmX2LqAuhVy8RS03DnQT9OFtbiSGhWCOlD2FbmJsxoDJGFVn2U=
X-Received: by 2002:a05:690c:7445:b0:6f8:cedc:570d with SMTP id
 00721157ae682-6f8cedc5710mr129600047b3.6.1738629004567; Mon, 03 Feb 2025
 16:30:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
 <e8b6c6f9-9647-4ab6-8bbb-ccc94b04ade4@yandex.ru> <67979d24d21bc_3f1a29434@willemb.c.googlers.com.notmuch>
 <CAFqZXNscJnX2VF-TyZaEC5nBtUUXdWPM2ejXTWBL8=5UyakssA@mail.gmail.com>
 <6798f1fb5e1ba_987d9294dc@willemb.c.googlers.com.notmuch> <c4413e16-d04f-4370-8edc-e4db21cc25f6@yandex.ru>
 <67996154e30ce_d9324294c4@willemb.c.googlers.com.notmuch> <8b81a534-9c30-4123-bd7d-bf3a9d89dfcb@yandex.ru>
 <679a376739b99_132e08294f3@willemb.c.googlers.com.notmuch>
 <04879909-72e5-4ab6-8c28-5d3cb551feb5@yandex.ru> <679bace3a753f_1d35f32942d@willemb.c.googlers.com.notmuch>
In-Reply-To: <679bace3a753f_1d35f32942d@willemb.c.googlers.com.notmuch>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 3 Feb 2025 19:29:53 -0500
X-Gm-Features: AWEUYZmUsmD5zCo4hDfd3nWC-dGlKyR6ryMJMAzMHvcapPBgUl5n85uHWuFs7UY
Message-ID: <CAHC9VhS-uSaVmy65oA8p6tCzMZxMsuzdmxO-vf7L0p44ZKO=_A@mail.gmail.com>
Subject: Re: Possible mistake in commit 3ca459eaba1b ("tun: fix group
 permission check")
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: stsp <stsp2@yandex.ru>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jason Wang <jasowang@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, network dev <netdev@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 11:48=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> stsp wrote:
> > 29.01.2025 17:12, Willem de Bruijn =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > stsp wrote:
> > >> 29.01.2025 01:59, Willem de Bruijn =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > >>> stsp wrote:
> > >>>> By doing that you indeed avoid
> > >>>> the problem of "completely
> > >>>> inaccessible tap". However, that
> > >>>> breaks my setup, as I really
> > >>>> intended to provide tap to the
> > >>>> owner and the unrelated group.
> > >>>> This is because, eg when setting
> > >>>> a CI job, you can add the needed
> > >>>> user to the needed group, but
> > >>>> you also need to re-login, which
> > >>>> is not always possible. :(
> > >>> Could you leave tun->owner unset?
> > >> That's exactly the problem: when
> > >> the user is not in the needed group,
> > >> then you need to unset _both_.
> > >> Unsetting only owner is not enough.
> > >> Adding the user to the group is not
> > >> enough because then you need to
> > >> re-login (bad for CI jobs).
> > > At some point we can question whether the issue is with the setup,
> > > rather than the kernel mechanism.
> > >
> > > Why does your setup have an initial user that lacks the group
> > > permissions of the later processes, and a tun instance that has both
> > > owner and group constraints set?
> > >
> > > Can this be fixed in userspace, rather than allow this odd case in th=
e
> > > kernel. Is it baked deeply into common containerization tools, say?
> >
> > No-no, its not a real or unfixible
> > problem. At the end, I can just
> > drop both group and user ownership
> > of the TAP, and simply not to care.
>
> In that case the safest course of action is to revert the patch.
>
> It relaxes some access control restrictions that other users may have
> come to depend on.
>
> Say, someone expects that no process can use the device until it
> adds the user to one of the groups.
>
> It's farfetched, but in cases of access control, err on the side of
> caution. Especially retroactively.

If a revert is the best path forward for v6.14, do you think it would
be possible to get this fixed this week, or do you expect it to take
longer?

--
paul-moore.com
