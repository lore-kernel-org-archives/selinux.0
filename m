Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D9818CC1A;
	Thu, 29 Aug 2024 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939473; cv=none; b=NK6L8b6QpnX0mXOhPDmP3sR16SWJK+YMgx12+SAgKqPxHPigUDfNEBwqAy2JrO8LhlEZKLwn4XUARr8gk467RNS00jIAoKJoRPUJJSu5/4hSax0vMewkrX67sXUlkR0v1zMlOzBwuDh6eLRjbZJEh7UKUEKoD7Ja1/IewUhUcvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939473; c=relaxed/simple;
	bh=iQk+U/ouB1EHucfIxkcJ1KxazrO9N8PEsVQ++mmkQF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBjFKJy23dV7txZDpm4OSHCcwOp77dS3VOXQ10DEl2DJLxFt4A3cuI2TYGjkZoM+agY1sSeLjxEOc/i9f/bFLLaLNoKHKN28lUf48Nw6ZOGzPcoSFcexFGPa5CdnScfGMt7b0HFztFRUA+k95MLQ5YkUQJ8fwR09LAiRGlKl8u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEFPLI0z; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEFPLI0z"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7163489149eso388925a12.1;
        Thu, 29 Aug 2024 06:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724939472; x=1725544272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0FmDY8FkIbcjP++GfJg9NkFqS1dN0SQJ4Ht4KAa4fI=;
        b=bEFPLI0z5h7oS2THnmi9fBT/jFk2dwjwuJ5ZqalCKL2abG2T4yhHVoCYDYyWxH3gBD
         YdD9R6tt3Atimft7j5NYb1NoRRKF9GgKbWv1uQtBkgqkjOJ0HmN0se4ejK7o8IyBUvss
         C9uLlfpXDD+0RNebaJ/HWtn9i3+Ree4JL5pFm0xVa+imEcebixuE4Tw+pMlBl6TObKBP
         Et38Tcu76N0FfIfOuqxcolqnJ5T2VmDa6ANNWB3H/XgTmF51tUGLfge6tk6wiQ6Mxm2k
         AklyqZi8jiEf3BhouXUazq4LgFWlnWy4Q0cf2YU6RyuTFPZbIHPURzCh7tkmPGyqeFuv
         fBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724939472; x=1725544272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0FmDY8FkIbcjP++GfJg9NkFqS1dN0SQJ4Ht4KAa4fI=;
        b=c0rRtHRTdvN37qnrxPnVmWL/wQ4L7KxiHwfap5MSIIa/NIwEdFlawQQn+ZH+woAJaJ
         sQuOcu218iEESZZHEV2XteT9CcBNcZy0NDa9TrkWT5x4lvGJW/tY9yupkvxNKXTlUHZr
         61YyDpczEMoSRjPI179xzQmUfMPAjS74lPYEgWIZoE4JgW1iyb4ddSk3WZxPexUfS7V0
         4xrloTEPJ7ux/VoIi/HhIciV3h7ITCWUz7SGRJBI90kZe8RK7vhJmhRvpTsVbVVfn68Z
         FwqVQnmlJqm6KWeqo/9vtWe4QORlR9WmeUfCy6zJLjzJhH4/+q24TzzkVIosztbu9n0z
         VVXA==
X-Forwarded-Encrypted: i=1; AJvYcCVoxkzdSW1Qem2RGb5yHgYEc+gvD56NBmqd9jUx06yc5hZiwm7AYr4B2WYf8RJ9/p373ViYhtJ5+w==@vger.kernel.org, AJvYcCXmHfKBrD21yQ1UUGhT9ZAISn5LBFFMEKxPXp6SdKgnVhjBBqJjZZZq3/oiHEuzdRxjcI1lh425NM5VbSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqPbktMxqSDLX2ynIsGWuW5wjBnaYNYC3EywVagFG/Umy+a5ln
	DXtB9qBBYvBFVj8pfmApeogGftQ+eALZpf67f84HaRc1pQHLFitcDjJRi7EV9qzlh8ECFtbrj+m
	uU9KeOam4Fv/pPuBA6lzVRHJ8Pi0=
X-Google-Smtp-Source: AGHT+IGvL/bZZzWkh0k1v3mQEGyka01YV5j7T9gs357eM0N6gctoKHE3XGtos2CUWg0UDXruuUJnGn65PFxyg98qc7E=
X-Received: by 2002:a05:6a00:228c:b0:714:3a7e:31e0 with SMTP id
 d2e1a72fcca58-715dfc9005amr3328533b3a.29.1724939471442; Thu, 29 Aug 2024
 06:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815083229.42778-1-aha310510@gmail.com> <CAFqZXNvXJY4Bh5k6DZ3yoLFuHo2bQRk3Q5Lv25ms6oOGyN5ZAA@mail.gmail.com>
 <CAEjxPJ4TMk3AoAd++nHQUyTHd_7vbOHC1Veq1ZSSyjH3v0kJ7A@mail.gmail.com>
 <CAHC9VhRV4j9i7YuKFJkNe9RYnKvCMLHHOi0LrRvwaFWbGJTbHA@mail.gmail.com>
 <CAEjxPJ4ObSaEG98jHhDtOssD1mF1fEAioJODa4bHKhZO=7KDGw@mail.gmail.com> <CAHC9VhSkQtDQktM_RRUgusq6dvCKCOPcCwUytFPL+z=grYR3FA@mail.gmail.com>
In-Reply-To: <CAHC9VhSkQtDQktM_RRUgusq6dvCKCOPcCwUytFPL+z=grYR3FA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 29 Aug 2024 09:50:59 -0400
Message-ID: <CAEjxPJ4WkYo+6xbvrbz2XwmTYQeFEoYnWAjVtExnWvGiKZyvMQ@mail.gmail.com>
Subject: Re: selinux: support IPPROTO_SMC in socket_type_to_security_class()
To: Paul Moore <paul@paul-moore.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Jeongjun Park <aha310510@gmail.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 4:02=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Aug 21, 2024 at 9:38=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Tue, Aug 20, 2024 at 3:51=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
>
> ...
>
> > > Without passing any judgement on the patches Ondrej submitted (I tend
> > > to ignore patches as attachments for various reasons), I do share
> > > Ondrej's concerns that this may not be as simple as suggested in the
> > > original patch in this thread.  I saw the same thing as Ondrej
> > > regarding the TCP fallback and that immediately raised a number of
> > > questions that I don't believe have been properly addressed yet.
> > >
> > > Someone needs to dig into how the standard SMC protocol works first t=
o
> > > ensure we have the necessary access controls for the current code; my
> > > guess is that we are probably okay since the socket-level controls ar=
e
> > > fairly generic, but I'm not sure we've actually seen proper
> > > confirmation that everything is good from a conceptual standpoint.
> > > Once that is done, we need to examine how the TCP fallback works,
> > > specifically how are connections managed and are the existing TCP
> > > hooks sufficient for SMC (the early connection state stuff can be
> > > tricky) and how to distinguish between normal-TCP and SMC-TCP.
> > >
> > > Basically I'm looking for some basic design concepts and not simply a
> > > passing test without any understanding of why/how it passed.
> >
> > At present, we are already applying the general socket layer access
> > controls to AF_SMC sockets; hence, existing policies can prevent or
> > allow use of AF_SMC sockets through that mechanism. This is useful for
> > reducing kernel attack surface, e.g. prevent all use of AF_SMC by
> > untrusted code, or to limit use of AF_SMC to specific
> > processes/programs.
>
> That's true.  I'm not suggesting we revert what we currently have, I'm
> only expressing some caution about moving forward with
> AF_INET/IPPROTO_SMC without a better understanding.  Ideally we would
> have done so before adding AF_SMC support, but we didn't, or at least
> I don't recall much discussion at the time.
>
> > Since kernel commit d25a92ccae6bed02327b63d138e12e7806830f78
> > ("net/smc: Introduce IPPROTO_SMC"), there is a way to bypass such
> > controls by creating such sockets via (AF_INET, SOCK_STREAM,
> > IPPROTO_SMC) instead of AF_SMC. In that situation, any process that is
> > allowed the socket layer permissions to the generic socket class would
> > be allowed to create/use SMC sockets.
> >
> > Jeongjun's patch closes this bypass and ensures consistent application
> > of the general socket layer access controls for SMC sockets. Given
> > that, I don't see why we would defer merging it until someone figures
> > out a more complete solution for SMC sockets. It's more of a bug fix
> > than an enhancement.
>
> SCTP, that's why.  Granted, SCTP is likely a far more complicated
> protocol than SMC, but the TCP fallback raises all sorts of complexity
> red flags in my mind.  Before we go further with SMC I want to see
> some evidence that someone has looked through the SMC protocol and can
> write a few coherent paragraphs about how the SELinux access controls
> for the SMC protocol should work.
>
> ... and yes, labeled SCTP is still broken.  Perhaps someday soon I'll
> have the time to finish the patchset to fix it.

I see this as being different than SCTP. The AF_SMC support was
introduced with the extended_socket_class support which merely
introduced distinct socket security classes for each address family so
that SELinux can distinguish each address family in policy. Previously
a number of the socket address families were defaulting to the generic
socket security class and could not be distinguished in policy. The
only change was introducing a distinct security class specifically for
SMC sockets, not introducing any family/protocol-specific logic. Only
the socket layer access controls were being applied (both before and
after the introduction of the SMC socket class, just changing which
class was being used). Fixing the kernel to also map IPPROTO_SMC to
the SMC socket class likewise just ensure consistent application of
the socket layer access controls on SMC sockets regardless of how they
are created and doesn't introduce any SMC-specific logic.
