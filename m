Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221FE1AD5C5;
	Wed, 21 Aug 2024 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247481; cv=none; b=BV9mb1EUWI31IRT/ShMEsSfWOonvBHak93feU+A5GbRHFI0Nak6L3cPacy55k2GMlAqkjDB0qcMScPPg471Y24Fic7nALXGV15FJHmnLCkqBPLQ1tWcFUrGoZxf6r5Db5jKSkdvLhHR+S2eSYSzn+XZfvsh7j+vewYI/PJDTARU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247481; c=relaxed/simple;
	bh=A5QbkoOwlSYI3M3Xde9fHEwHLHky4MZ1H6h1uSCdf+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQm+3ngKebPH4D6ebVXTlEtMzlTS89uW5en2J7htmlli5HoYyCeKkAeZ+Qbx0EyEn7qcirjFKSgkjTgve3kxFFjO8uph8tm9BpPRl4zv0avNmbbf/dkUJlWEess+gugck2xnGKtMImBKbD2xFHdAiTynxyYoFbJvhcO2USMGXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McBu0BRv; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McBu0BRv"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7cb3db0932cso3105672a12.1;
        Wed, 21 Aug 2024 06:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724247479; x=1724852279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOtzgRB9yrFrJMnqCSca7u16T835Q1JRuh51Yi9FmO0=;
        b=McBu0BRvMp5yh4aSH7mLbmYfwU5M/ceDlYFOcMDV22P8EPaQ1m8Tmq481G5E7/3Yug
         ysSonF/Zgaf+xxID82OJJj0Uk3JjEx+D9rGe+PAIDenxkda4zJ7RoH47UwR72XB0Wdz3
         wimDqP5OkGiBr6JZkZ48vUQzxDGDfXBLJpo7C+bcDMqbLucVyV/+7rbQd95dXJZFJqLA
         wuulucbK2wFNcJB6NspNomIOk9dZxVen+nWwDDgKUVkUN/LQVTmQxkiTSvJeNQwGhuAb
         GaLTHT+MkHL7Tm0DWEtz6i1KXrCL5g0clWs2TZyG2tPIDNDivtKch83rA5Kx0QCpA8sj
         B+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724247479; x=1724852279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOtzgRB9yrFrJMnqCSca7u16T835Q1JRuh51Yi9FmO0=;
        b=D33icokp8+YCOxdk4ggqIPhjShnLwroI66E7W5XsuO0cdsWYNFUCceWxVp3Q9N5DJr
         kVtSo8MJz5FPGDsOuFK2mfq5ABU3tpesQfAtzA4s+kVrC4Kk9r9lopge9aJaYAqmr9qT
         NMtKQyqjey/p6ZRACbQhsUyo72UoXo9FpLMR0Tn8pl5Pv8bf+K1mVgV6EZl7oPF0POR3
         PETujHIAGb7umMDSNQegUcz/nVK+UhViri7NxlC8nzzknaoCGa0YsbdP92jOMdusVgHj
         5NkMeHe8gn4j5OFsPVMA/GQeR06F6hT7PqE0sZJuznXxTWIq2ciL84MONSgsRx3T+gWU
         n2LA==
X-Forwarded-Encrypted: i=1; AJvYcCU7mYVsQUUskyFx0dVL5EBQgOmjv8Yhv3g1odnDVl8QaWdA3EAju4c8c/WkdkafNJEJmLes7KD/Cx8LgKA=@vger.kernel.org, AJvYcCWAqLcZn9Kcl5daUnzPMbBmTikUtFFqnDTvBsxkhR3tCl4jp+To19s7sST5Fm8i5vUu6XvT4aYS/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYIBEDHNFz1T3OWX07JCrx238WUq+yoNwvUsLWggZYlNtncpUb
	+UpYWGNO5Ax7MLXDbal5W8zLggZrevtmYibKnManlGFtwn1MVUUmqBfe6IhV9D0RYIVctN17EEK
	8vVpjcP0E4gP7mZiVV0LGDn7QgaD9gGJs
X-Google-Smtp-Source: AGHT+IFHWpO7TaNhM0sQnbPZQWO63t8FCYLwVvfCZ3E38rCrTUEoAhATUJyRslp9ciKv8jN9sH46BQ1s0fmRr3mITdg=
X-Received: by 2002:a17:90b:3e84:b0:2d3:cb16:c8e with SMTP id
 98e67ed59e1d1-2d5eacbc625mr2075091a91.43.1724247479135; Wed, 21 Aug 2024
 06:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815083229.42778-1-aha310510@gmail.com> <CAFqZXNvXJY4Bh5k6DZ3yoLFuHo2bQRk3Q5Lv25ms6oOGyN5ZAA@mail.gmail.com>
 <CAEjxPJ4TMk3AoAd++nHQUyTHd_7vbOHC1Veq1ZSSyjH3v0kJ7A@mail.gmail.com> <CAHC9VhRV4j9i7YuKFJkNe9RYnKvCMLHHOi0LrRvwaFWbGJTbHA@mail.gmail.com>
In-Reply-To: <CAHC9VhRV4j9i7YuKFJkNe9RYnKvCMLHHOi0LrRvwaFWbGJTbHA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 21 Aug 2024 09:37:47 -0400
Message-ID: <CAEjxPJ4ObSaEG98jHhDtOssD1mF1fEAioJODa4bHKhZO=7KDGw@mail.gmail.com>
Subject: Re: selinux: support IPPROTO_SMC in socket_type_to_security_class()
To: Paul Moore <paul@paul-moore.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Jeongjun Park <aha310510@gmail.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Aug 20, 2024 at 2:24=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Mon, Aug 19, 2024 at 5:46=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > > I'm not sure if this is the solution we want to go with... Consider
> > > the following from af_smc(7):
> > >
> > > >   Usage modes
> > > >      Two usage modes are possible:
> > > >
> > > >      AF_SMC native usage
> > > >             uses the socket domain AF_SMC instead of AF_INET and AF=
_INET6.  Specify SMCPROTO_SMC for AF_INET compatible socket semantics, and =
SMC_PROTO_SMC6 for AF_INET6 respectively.
> > > >
> > > >      Usage of AF_INET socket applications with SMC preload library
> > > >             converts AF_INET and AF_INET6 sockets to AF_SMC sockets=
.  The SMC preload library is part of the SMC tools package.
> > > >
> > > >      SMC socket capabilities are negotiated at connection setup. If=
 one peer is not SMC capable, further socket processing falls back to TCP u=
sage automatically.
> > >
> > > This means that the SMC sockets are intended to be used (also) as a
> > > drop-in compatible replacement for normal TCP sockets in applications
> > > and they even fall back to TCP when the endpoints fail to negotiate
> > > communication via SMC. That's a situation similar to MPTCP, where we
> > > just mapped MPTCP sockets to the tcp_socket SELinux class, so that
> > > MPTCP can be swapped in place of TCP transparently without having to
> > > do extensive policy changes. We may want to consider the same/similar
> > > approach here.
> > >
> > > I briefly played with this idea a couple of months ago, when I was
> > > asked by someone at Red Hat about SMC sockets and their integration
> > > with SELinux. IIRC, when I tried to implement the MPTCP approach and
> > > adjusted the selinux-testsuite to test SMC similarly as TCP and MPTCP=
,
> > > I saw that the netlabel-related tests (may have been more, I don't
> > > remember) weren't passing out of the box like with MPTCP. However, th=
e
> > > person then didn't follow up on my questions, so I didn't look into i=
t
> > > further...
> > >
> > > I'm attaching the WIP patches I worked with, in case someone would
> > > like to continue the experiments.
> >
> > I am not in favor of your approach, for the following reasons:
> > 1. It would be backward-incompatible with any current code using
> > AF_SMC (although this could be addressed by making it conditional on a
> > new policy capability, so this is not too difficult to overcome),
> > 2. It would not allow any distinction to ever be made in policy
> > between SMC sockets and TCP sockets, so we could never allow one
> > without the other.
> >
> > Hence, I am still in favor of Jeongjun's patch to consistently treat
> > AF_SMC and (AF_INET, SOCK_STREAM, IPPROTO_SMC) sockets, and then if
> > someone wants to extend that support to also provide more complete
> > access controls and/or networking labeling, defer that to a future
> > patch.
>
> Without passing any judgement on the patches Ondrej submitted (I tend
> to ignore patches as attachments for various reasons), I do share
> Ondrej's concerns that this may not be as simple as suggested in the
> original patch in this thread.  I saw the same thing as Ondrej
> regarding the TCP fallback and that immediately raised a number of
> questions that I don't believe have been properly addressed yet.
>
> Someone needs to dig into how the standard SMC protocol works first to
> ensure we have the necessary access controls for the current code; my
> guess is that we are probably okay since the socket-level controls are
> fairly generic, but I'm not sure we've actually seen proper
> confirmation that everything is good from a conceptual standpoint.
> Once that is done, we need to examine how the TCP fallback works,
> specifically how are connections managed and are the existing TCP
> hooks sufficient for SMC (the early connection state stuff can be
> tricky) and how to distinguish between normal-TCP and SMC-TCP.
>
> Basically I'm looking for some basic design concepts and not simply a
> passing test without any understanding of why/how it passed.

At present, we are already applying the general socket layer access
controls to AF_SMC sockets; hence, existing policies can prevent or
allow use of AF_SMC sockets through that mechanism. This is useful for
reducing kernel attack surface, e.g. prevent all use of AF_SMC by
untrusted code, or to limit use of AF_SMC to specific
processes/programs.

Since kernel commit d25a92ccae6bed02327b63d138e12e7806830f78
("net/smc: Introduce IPPROTO_SMC"), there is a way to bypass such
controls by creating such sockets via (AF_INET, SOCK_STREAM,
IPPROTO_SMC) instead of AF_SMC. In that situation, any process that is
allowed the socket layer permissions to the generic socket class would
be allowed to create/use SMC sockets.

Jeongjun's patch closes this bypass and ensures consistent application
of the general socket layer access controls for SMC sockets. Given
that, I don't see why we would defer merging it until someone figures
out a more complete solution for SMC sockets. It's more of a bug fix
than an enhancement.
