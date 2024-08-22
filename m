Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8117C7C9
	for <selinux@vger.kernel.org>; Thu, 22 Aug 2024 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341485; cv=none; b=Hh77ig6nuMnDT029x5mtO4wLjq8vcvs0TWHPbxsX5vN6SAqPvvMC9OUp1XWCCtxG5gpC/nbuDz8DzRR4xsPwEXk9KDpwjph/BSRQ0JWnsoSVIAx+TUmYFfKwL2m4Hrq3OHhjIAvcKm7Y+PJCvwxxNDvB/dSvm73sooFlNQSG1FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341485; c=relaxed/simple;
	bh=HrxJ6TsJoOTnd88vPgp66skdeDpKpE2SKfE3GWqgh7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSbrC1xmY8drazwLl9Hf7hkJL3YphRN/uxfOx/V3h/CYOj57lsenGBJLzWAFbwOqXEnXMKcG8J9Eu9KRMKMxjQNFrcCA+/t5U3bExcXzAcD6IeKxsH0zbur4hH6zMaF723bJOz2MPDbMbNO6T+YvK5pyGSwMwAgGO35sd8Kbz4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXhNWuyH; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXhNWuyH"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d60f48a2ccso775060a91.3
        for <selinux@vger.kernel.org>; Thu, 22 Aug 2024 08:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724341483; x=1724946283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrxJ6TsJoOTnd88vPgp66skdeDpKpE2SKfE3GWqgh7s=;
        b=VXhNWuyHhwC29qoazD7wk1f6la7shdtKddzqfjTv+ifJaiU8O2Ja3dI578/06ystpn
         K7MJp3EmFnyuhRdrTHviJA3xNviY8XJgwNMTMMtVdSWm95YBDTZYniiztaoBLehJOw9t
         JobDMFFjzDGipRf+cXITTV6F2+F5tBxQn3JdDE7y542oEpWa8GCn5rvrkSS3ZneDw3oA
         ejEqyGFVT90uCW2Wyt2csPF5rHUOEcJ7VKFQxGMsVlb+9gHexj4QyxpO/F1U8nfn9cdg
         gkMWsJQZK6E9Kav//vzfM7wshKgHJUeYn9C0Y6A2qGxnZKevLww87yT6bzZWSnUBob0r
         Y8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724341483; x=1724946283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrxJ6TsJoOTnd88vPgp66skdeDpKpE2SKfE3GWqgh7s=;
        b=we4qkP36eAuYXjRuOrKKUd5w198Css87CBY5pSJaSNJdkAecPcPfW2PDzNp3ZN8aJQ
         Yqs9vYNbIdF5xJGwRHY6POBMOIzAT543L1w0S9epiyMXenKtrW1d8+MB+z/mBZCU0pLs
         lx74/qh2eW8FG2CF22N1n2x/pFxwwscfQQ3jwSvDsvu8l18BMNNPGDRzTHtmhYhBv0PY
         WULYBJc7UvjmhPamULEnghXirEENMimUs5vca9plAyBPaQVBIlFDxLSlJq6tFyBWncbf
         myUA3vmPK2K6FWFq9FwGOp/Wv5yXsRavcX1nRdhed3NXaZOuivvVzLrLSz/9XLWiFf0g
         7gkg==
X-Forwarded-Encrypted: i=1; AJvYcCXTjqSezQNd1AJ/OGFsV5KyFs4PnIvo+Cxy8h6XwSZjhDetddqfkKARHbBxi7PGOIrPANqTOJRc@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2M1svrgv14/MjxlAXXhVxdjfhBhaAUKqzGKjK50JUq629gqk7
	z6YdcbTDET45ex8yWqNhKKfeYv9m+eQquV1mKRelqjYmR2Ak1Kz40bOYnNEzZ2rwRC7ZMP2Ir/i
	3TVrQ/XN1WOMFHNcqD/tiPL0Wvns=
X-Google-Smtp-Source: AGHT+IGxZj+/aDvH/E4H6eawNuUWtxx3oZbE8ZLNhiwjTcmE0mXaVU3cYpELeU7eu5lxpgU5ubrxCWgpBt/dpnria6k=
X-Received: by 2002:a17:90b:1881:b0:2c7:700e:e2b7 with SMTP id
 98e67ed59e1d1-2d617290591mr2635625a91.39.1724341482656; Thu, 22 Aug 2024
 08:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820002723.1345639-1-tweek@google.com> <CAEjxPJ7Jg6vYOQXVr_tT9F4SZcDHN==7LfORxxOACqtn_SRKTw@mail.gmail.com>
 <CAHC9VhQU1oEaS=bB-Kc6Bfukb_MMFv+CrhpJ4F7L=tK8j_c8Ug@mail.gmail.com>
 <CA+zpnLeoz3yuVd5EUtct-CDi2zT9u7Y61edB3s4HbiEfxLOZNQ@mail.gmail.com>
 <CAEjxPJ5g_9CDRi8zm_=0tPyQf4D8Tpo0q3ai13_txNW1_Wd6kw@mail.gmail.com> <CAEjxPJ6rCPwwJoVWHXvC8qK2vLfc2wON4ik4Wugys=uC=WypqQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6rCPwwJoVWHXvC8qK2vLfc2wON4ik4Wugys=uC=WypqQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 22 Aug 2024 11:44:30 -0400
Message-ID: <CAEjxPJ77N8OLNiOcwZLcdJDy9AYzxo+17s1nYPRX5VBo71nQ0A@mail.gmail.com>
Subject: Re: [PATCH] selinux: Add netlink xperm support
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, brambonne@google.com, jeffv@google.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 11:37=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 22, 2024 at 10:37=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Aug 21, 2024 at 8:56=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@g=
oogle.com> wrote:
> > >
> > > On Wed, Aug 21, 2024 at 5:54=E2=80=AFAM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > >
> > > > On Tue, Aug 20, 2024 at 2:02=E2=80=AFPM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > Thank you for reviving this patch.
> > > > Do you have a corresponding userspace patch? And for extra credit, =
a
> > > > selinux-testsuite patch?
> > > >
> > >
> > > Thank you for the quick response and initial feedback. I've just sent
> > > the libsepol patches for userland on this mailing list.
> > > For selinux-testsuite, an issue I came across while testing is that
> > > the policy capabilities cannot be updated (that is, only the
> > > capabilities from the original host policy are active). I am not sure
> > > if I got that right or if there is any obvious solution (except
> > > toggling on the new capability in Fedora).
> > > I'm still hoping to get the extra credits by: updating the selinux
> > > notebook documentation as well as updating setools (for sesearch
> > > support). :) I will send pull requests if these patches get accepted.
> >
> > With your userspace patches, can't you just do this:
> > $ cat netlink_xperm.cil
> > (policycap netlink_xperm)
> > $ sudo semodule -i netlink_xperm.cil
> >
> > If so, then you can add that along with corresponding allowxperm rules
> > to the test policy to exercise this.
>
> NB you may need to also allow { domain -testsuite_domain } the new
> nlmsg permission for all the netlink socket classes to avoid breaking
> the other processes running on the test system.

Sorry, never mind - you would still need to define the nlmsg
permission for each of the netlink socket classes and that doesn't
appear to be something one can do in anything other than the original
definition in the base module.
Oh well.
