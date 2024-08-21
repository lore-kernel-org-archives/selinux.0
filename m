Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656AF1D12F4
	for <selinux@vger.kernel.org>; Wed, 21 Aug 2024 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724270531; cv=none; b=Ocmwam9pwIM+4Yfhok87506SZNmeFt4DiuJfp8nwxCq+XNLHAhl38AalMxEyFXf3DYpT9ehW9DuCdtjMt6mHIBGu0VDn0dQ3t/IlDE3RrCbexZHzcYSxBEDxTypMRs4SH42anUu1u3hByVOovDdS3y8SxbxGNFfAp3O0SudO21M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724270531; c=relaxed/simple;
	bh=OnXcytC53/4o5Pt1aPpx2AkSZNydd/aCmCVXtxs6jEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azR8eVUtoklzdtQpbNz4m/JSyelEOBHMeXiaXLWLnZGT78ecHVcmkd2PEC0/dfeH/c61v2RY3OYrxr9ydrM1gm+H8Sl4nCzNdaKroDjLHzdksY1t3dRGovSqRs/Nu35MPuygEj65o49SrUWahykQcm4CdqWbDuKmpIx81VvzqUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ussy6yFY; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ussy6yFY"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6b8f13f28fbso1080307b3.1
        for <selinux@vger.kernel.org>; Wed, 21 Aug 2024 13:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724270528; x=1724875328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sd4fCf38q7zmEAJ7MeRruj4icO1IpN4DXf4IAgnQqlM=;
        b=Ussy6yFYAgh23Zp3b7QJ6nyXt0mFkIsLOVV7i48OuJ8Vm/T6Wy/tu8i3OKEvZyeyNP
         ggHrcnkdZuUr0ZmrQ31L4YoYw6YvKS0J7QvfxYjqWEHSIaED45jDOx0LebxHab+B/EXY
         tA4Icy3S6f9sORNOxLSnOHBrcMRj0CFOOHo+A4HgXS40kXqFKT2hjT8wFPHib4dg4ik8
         3OzOx0ytsZcE24FM+n9OaU9LhuQbkwhrh8IEz3y+yOEF5dD7mijXbzn0wp8ptAdIjtWU
         JwKYhRBvHRPAo4bqt7/sM9LvZSo74abJSwjqYVm8hU2H3n4MoCKHBz0FvF2byA1e94Kg
         VD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724270528; x=1724875328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sd4fCf38q7zmEAJ7MeRruj4icO1IpN4DXf4IAgnQqlM=;
        b=tM5/LRV8CUaXd0tbShpp5L90FSqp6TYah9Va0sxrTk6gs+E3ZjsvvG6A3RRv/8H08O
         k9I37cJuJRD985BkIO5vEjdu8621/0otAu5mNaUgJL3GmZYzP/rhqrjhojUnb14W5pnQ
         81qlfOt1g/bvd6eSqHoGoZSrJ+3P6OretPwRSORV6JH/eIb7VFOwGsJsLnpn/I1LmalE
         D/eROoTl/pPMbqOWBlkr32jooJXTlOYjBt/xVJqLCBl/ZduygjfGQiY3hfFLjcdnKRSW
         qSgPYDAgolDN7TS7Gb2zKXjoPnBkgSb1CTGdofo5y3UmPzZFV3zQTzmptVwKCW9+laBB
         L/Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVxLm6Pup0AWZQfIeAmN0VDGHU8k0IdBRd32QLbozHLJZyt+lB9oOntphSSY8oQVfKqWLUUIaq3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8XGAUuEko8MltuGQLEmJx4hT6z9vrbRtypSYyLqesHDwSZpIn
	iQBZlfJEadm/QfuJB9fuZlM+ToDpG8qrcQapyJC1NJTC+wMMosfOu8XdtKb9aY7A2GbdjTkg6HI
	is64lqU0gs0n0Wn1puDUYRzRb+D3WuzpmYc2Q
X-Google-Smtp-Source: AGHT+IE2QO57xS8SgeCLUqJT3hCavShJNH5jHqpIvVtKtPyOZLLtL5WZ7rGTH2dX5GBAahZ77OWb2kXbFsOhpzxCaQQ=
X-Received: by 2002:a05:690c:6c07:b0:61b:342e:91ae with SMTP id
 00721157ae682-6c0a0141ae8mr44149257b3.36.1724270528366; Wed, 21 Aug 2024
 13:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815083229.42778-1-aha310510@gmail.com> <CAFqZXNvXJY4Bh5k6DZ3yoLFuHo2bQRk3Q5Lv25ms6oOGyN5ZAA@mail.gmail.com>
 <CAEjxPJ4TMk3AoAd++nHQUyTHd_7vbOHC1Veq1ZSSyjH3v0kJ7A@mail.gmail.com>
 <CAHC9VhRV4j9i7YuKFJkNe9RYnKvCMLHHOi0LrRvwaFWbGJTbHA@mail.gmail.com> <CAEjxPJ4ObSaEG98jHhDtOssD1mF1fEAioJODa4bHKhZO=7KDGw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4ObSaEG98jHhDtOssD1mF1fEAioJODa4bHKhZO=7KDGw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Aug 2024 16:01:57 -0400
Message-ID: <CAHC9VhSkQtDQktM_RRUgusq6dvCKCOPcCwUytFPL+z=grYR3FA@mail.gmail.com>
Subject: Re: selinux: support IPPROTO_SMC in socket_type_to_security_class()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Jeongjun Park <aha310510@gmail.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 9:38=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Aug 20, 2024 at 3:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:

...

> > Without passing any judgement on the patches Ondrej submitted (I tend
> > to ignore patches as attachments for various reasons), I do share
> > Ondrej's concerns that this may not be as simple as suggested in the
> > original patch in this thread.  I saw the same thing as Ondrej
> > regarding the TCP fallback and that immediately raised a number of
> > questions that I don't believe have been properly addressed yet.
> >
> > Someone needs to dig into how the standard SMC protocol works first to
> > ensure we have the necessary access controls for the current code; my
> > guess is that we are probably okay since the socket-level controls are
> > fairly generic, but I'm not sure we've actually seen proper
> > confirmation that everything is good from a conceptual standpoint.
> > Once that is done, we need to examine how the TCP fallback works,
> > specifically how are connections managed and are the existing TCP
> > hooks sufficient for SMC (the early connection state stuff can be
> > tricky) and how to distinguish between normal-TCP and SMC-TCP.
> >
> > Basically I'm looking for some basic design concepts and not simply a
> > passing test without any understanding of why/how it passed.
>
> At present, we are already applying the general socket layer access
> controls to AF_SMC sockets; hence, existing policies can prevent or
> allow use of AF_SMC sockets through that mechanism. This is useful for
> reducing kernel attack surface, e.g. prevent all use of AF_SMC by
> untrusted code, or to limit use of AF_SMC to specific
> processes/programs.

That's true.  I'm not suggesting we revert what we currently have, I'm
only expressing some caution about moving forward with
AF_INET/IPPROTO_SMC without a better understanding.  Ideally we would
have done so before adding AF_SMC support, but we didn't, or at least
I don't recall much discussion at the time.

> Since kernel commit d25a92ccae6bed02327b63d138e12e7806830f78
> ("net/smc: Introduce IPPROTO_SMC"), there is a way to bypass such
> controls by creating such sockets via (AF_INET, SOCK_STREAM,
> IPPROTO_SMC) instead of AF_SMC. In that situation, any process that is
> allowed the socket layer permissions to the generic socket class would
> be allowed to create/use SMC sockets.
>
> Jeongjun's patch closes this bypass and ensures consistent application
> of the general socket layer access controls for SMC sockets. Given
> that, I don't see why we would defer merging it until someone figures
> out a more complete solution for SMC sockets. It's more of a bug fix
> than an enhancement.

SCTP, that's why.  Granted, SCTP is likely a far more complicated
protocol than SMC, but the TCP fallback raises all sorts of complexity
red flags in my mind.  Before we go further with SMC I want to see
some evidence that someone has looked through the SMC protocol and can
write a few coherent paragraphs about how the SELinux access controls
for the SMC protocol should work.

... and yes, labeled SCTP is still broken.  Perhaps someday soon I'll
have the time to finish the patchset to fix it.

--=20
paul-moore.com
