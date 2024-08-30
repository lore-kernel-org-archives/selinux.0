Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395461BF325
	for <selinux@vger.kernel.org>; Fri, 30 Aug 2024 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725048306; cv=none; b=Hg4jOEQW1EKFS414qbG3OHIMSxJGS13jvL/ZVW1Sws89FTZx8wOddlSOAl0cMSLF/suNG8NBRUpZJtSxkqGplNpVGcLSBI2VVAhchDIJA96o3b+lmErYkbxHos7EL/imOTTTdMCJJNCA4fUFqduXq/Qdx4+ncl1cqhvMuS5jRAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725048306; c=relaxed/simple;
	bh=QWCTT5wCAH3kwRjPHh8bM3pbPPRt9Lm/Y/5a1bTXMBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ly5xrwxd1FgxfcYWEQygSVV2hylbmtUwVn7YrTKwOQ6v5f3E7nwQd1BPO601uNK2qEQbe7eB9DDP45KKNb2JkzkcEFICmtmt3LnZpctzWiyOnI1jGDCC8cJpBVOWihYMqZ8hTvjnweoCoUZkNu66BiMOVkOD8i/Xy/oEN29rhPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Jmp4yEkF; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Jmp4yEkF"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e116a5c3922so2201131276.1
        for <selinux@vger.kernel.org>; Fri, 30 Aug 2024 13:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725048304; x=1725653104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=va8DMzZzwo2vc63FlxGokLNqwDKTUn/bIWuJtwnfM/0=;
        b=Jmp4yEkFpLcL+dJZkP/I0/nVV5QCV3g5nxrfvsrDijn3ERi9QVp87dVyI7cLKNCk8H
         173Rb6mHeJDBtetTSx/rXaqdqGp6aF/mkbaXD8uGqmMmt2AckKfXb8zHNUehEc3kcte9
         1dZ6Ih61yE8u1b/TEGoNzlm4aS32WhuPeC+dDkriWlzEXze0vxruBeGBhpkVlfEIFc04
         10gkEYwJryFpmW8XUKPaJfbQ0ayGaOVPNsDp0+ODE7RYxQD47F96RWp4CuuMq5twy/+K
         CqegDnrsItQIpB+k9vCbM/ytNekehxlD5gQRotjsVqxfl4ITglVMauLjWIw02t0yv1Vn
         9F7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725048304; x=1725653104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=va8DMzZzwo2vc63FlxGokLNqwDKTUn/bIWuJtwnfM/0=;
        b=L8Vdgm4zZjRUabOQ6pbmQyVCMjsTYmipA7EX4pl8LvA1uS1ihT7CcsNOAdVfUFfgND
         m8jm8Or4eJ5qlQnLCpADilBLW1/dLYDhBfL1cN5vOYDijW5I+PCyFvXDU/nRpUdUVz8q
         PSfzpt/gRgoad8nfSA6NR62GE9gIpv84tZM+5dYkL3u/e4CM4L8CN3jKAa5wxbF2QMss
         EpIZFgHaskLipkeBxxV/LC4W58bVQzdJIG1N4PrYjOneFWJpbI9+WjCuF8XIq6zkFuPc
         tQwWqR1k/l1tc4EeErH5okfumxJvsWhTO/DQ9UuR9/1ZLKdCe1WbxxXwhEQEh8Ykfaoj
         0MRw==
X-Forwarded-Encrypted: i=1; AJvYcCUyu6cV4iFMYqJONAsp28MeaiFFh6oMy3P93DogSVGbdFMfYUUCMEWjjYfRbEayLyz+Ao6xkm/8@vger.kernel.org
X-Gm-Message-State: AOJu0YxB3IbgoBkkWNX0W8HI0wumDQSzErxjnE3SrdepAachYDjZnLHT
	EY1EJRMjTtKlCVSLmL2+pa1oCbPklXIChPXAcF2naRPYbYzFIcz/aYGbKKb+amjgKjgCc5xQ9Pc
	4rJC3w+DmRWLafDNKNspMHyA4eSTrBBaNsjS8
X-Google-Smtp-Source: AGHT+IG/2u3Vt8cgGE1evYB6Q9q7tenaZ9SSK+DO0M2hVfDT/ltupurYSkwcJmGgXlWkrogHlxVoxs5N/nILa6/SF+8=
X-Received: by 2002:a05:690c:39a:b0:6c7:a120:e0ec with SMTP id
 00721157ae682-6d40e688e3cmr43131277b3.22.1725048304191; Fri, 30 Aug 2024
 13:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815083229.42778-1-aha310510@gmail.com> <CAFqZXNvXJY4Bh5k6DZ3yoLFuHo2bQRk3Q5Lv25ms6oOGyN5ZAA@mail.gmail.com>
 <CAEjxPJ4TMk3AoAd++nHQUyTHd_7vbOHC1Veq1ZSSyjH3v0kJ7A@mail.gmail.com>
 <CAHC9VhRV4j9i7YuKFJkNe9RYnKvCMLHHOi0LrRvwaFWbGJTbHA@mail.gmail.com>
 <CAEjxPJ4ObSaEG98jHhDtOssD1mF1fEAioJODa4bHKhZO=7KDGw@mail.gmail.com>
 <CAHC9VhSkQtDQktM_RRUgusq6dvCKCOPcCwUytFPL+z=grYR3FA@mail.gmail.com> <CAEjxPJ4WkYo+6xbvrbz2XwmTYQeFEoYnWAjVtExnWvGiKZyvMQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4WkYo+6xbvrbz2XwmTYQeFEoYnWAjVtExnWvGiKZyvMQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 30 Aug 2024 16:04:53 -0400
Message-ID: <CAHC9VhS3y4OCsMLMC9cALMAN1oz2VbTDJW67j1hzP7pjx4qv+w@mail.gmail.com>
Subject: Re: selinux: support IPPROTO_SMC in socket_type_to_security_class()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Jeongjun Park <aha310510@gmail.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 9:51=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 21, 2024 at 4:02=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Wed, Aug 21, 2024 at 9:38=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Tue, Aug 20, 2024 at 3:51=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> >
> > ...
> >
> > > > Without passing any judgement on the patches Ondrej submitted (I te=
nd
> > > > to ignore patches as attachments for various reasons), I do share
> > > > Ondrej's concerns that this may not be as simple as suggested in th=
e
> > > > original patch in this thread.  I saw the same thing as Ondrej
> > > > regarding the TCP fallback and that immediately raised a number of
> > > > questions that I don't believe have been properly addressed yet.
> > > >
> > > > Someone needs to dig into how the standard SMC protocol works first=
 to
> > > > ensure we have the necessary access controls for the current code; =
my
> > > > guess is that we are probably okay since the socket-level controls =
are
> > > > fairly generic, but I'm not sure we've actually seen proper
> > > > confirmation that everything is good from a conceptual standpoint.
> > > > Once that is done, we need to examine how the TCP fallback works,
> > > > specifically how are connections managed and are the existing TCP
> > > > hooks sufficient for SMC (the early connection state stuff can be
> > > > tricky) and how to distinguish between normal-TCP and SMC-TCP.
> > > >
> > > > Basically I'm looking for some basic design concepts and not simply=
 a
> > > > passing test without any understanding of why/how it passed.
> > >
> > > At present, we are already applying the general socket layer access
> > > controls to AF_SMC sockets; hence, existing policies can prevent or
> > > allow use of AF_SMC sockets through that mechanism. This is useful fo=
r
> > > reducing kernel attack surface, e.g. prevent all use of AF_SMC by
> > > untrusted code, or to limit use of AF_SMC to specific
> > > processes/programs.
> >
> > That's true.  I'm not suggesting we revert what we currently have, I'm
> > only expressing some caution about moving forward with
> > AF_INET/IPPROTO_SMC without a better understanding.  Ideally we would
> > have done so before adding AF_SMC support, but we didn't, or at least
> > I don't recall much discussion at the time.
> >
> > > Since kernel commit d25a92ccae6bed02327b63d138e12e7806830f78
> > > ("net/smc: Introduce IPPROTO_SMC"), there is a way to bypass such
> > > controls by creating such sockets via (AF_INET, SOCK_STREAM,
> > > IPPROTO_SMC) instead of AF_SMC. In that situation, any process that i=
s
> > > allowed the socket layer permissions to the generic socket class woul=
d
> > > be allowed to create/use SMC sockets.
> > >
> > > Jeongjun's patch closes this bypass and ensures consistent applicatio=
n
> > > of the general socket layer access controls for SMC sockets. Given
> > > that, I don't see why we would defer merging it until someone figures
> > > out a more complete solution for SMC sockets. It's more of a bug fix
> > > than an enhancement.
> >
> > SCTP, that's why.  Granted, SCTP is likely a far more complicated
> > protocol than SMC, but the TCP fallback raises all sorts of complexity
> > red flags in my mind.  Before we go further with SMC I want to see
> > some evidence that someone has looked through the SMC protocol and can
> > write a few coherent paragraphs about how the SELinux access controls
> > for the SMC protocol should work.
> >
> > ... and yes, labeled SCTP is still broken.  Perhaps someday soon I'll
> > have the time to finish the patchset to fix it.
>
> I see this as being different than SCTP. The AF_SMC support was
> introduced with the extended_socket_class support which merely
> introduced distinct socket security classes for each address family so
> that SELinux can distinguish each address family in policy. Previously
> a number of the socket address families were defaulting to the generic
> socket security class and could not be distinguished in policy. The
> only change was introducing a distinct security class specifically for
> SMC sockets, not introducing any family/protocol-specific logic. Only
> the socket layer access controls were being applied (both before and
> after the introduction of the SMC socket class, just changing which
> class was being used). Fixing the kernel to also map IPPROTO_SMC to
> the SMC socket class likewise just ensure consistent application of
> the socket layer access controls on SMC sockets regardless of how they
> are created and doesn't introduce any SMC-specific logic.

Possibly.  However, I don't feel like it is a very big ask to have
someone spend some time to provide a basic summary of the SMC protocol
and what might be needed from a SELinux perspective; that would help
increase my confidence in our SMC support significantly and perhaps
then I would feel comfortable with the simple mapping originally
proposed here.

--=20
paul-moore.com
