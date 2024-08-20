Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A171547D1
	for <selinux@vger.kernel.org>; Tue, 20 Aug 2024 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724183481; cv=none; b=qZg3fPzZuJanEUE8mqSaqH1DRUDdT08hXzXL/UkJfZMgcNEHByuZzrhtxyY/FfPiyXlFPaLEijFowRNfRM/9XmHrXURT+ZMcVclzKQP+kAJ/yRM3T7O3YhODUvySoqpIZzAbTVbH0zUFD01DBAiQBOcb98uEisp+NrczsojUNUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724183481; c=relaxed/simple;
	bh=NwD8zMXrqxMyC3u1LQ4ICjT19PTW1mxy/5ZPqQQIanU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lz62S6xrBP+cUolQpj2RlxO0zSIz53TcgxY2G1GwzLiO+bwuwv46wOUNVZPawIbz2+vciUuNBhERTSnKp99nR00McAHsDUXV+Tu1IgXdsJQswmK+SHY8Wfxb68Mg9Wn8zrswOnK3zSWqPZWOmxfpkPwBChFE5DQhbgfqi/DxmOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ExZJCPax; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ExZJCPax"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e0b7efa1c1bso6121645276.3
        for <selinux@vger.kernel.org>; Tue, 20 Aug 2024 12:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724183479; x=1724788279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HY8JWRO1iNfwMHzxpz8V7gHbqwhiAwxtKGMMcVo5XE=;
        b=ExZJCPaxPLT/Y03teKRi2FUHk91lRfpxGwR0arkoak83g2Qtn/JblPTFjoAAT5xujB
         pzVWZ9FAocOT4bndTKTGeM0NaNDexB34+JpI/BV72z7der6+uziZqhiCR4WnaPl7FZvj
         ATcdHuxbgt9eUDp3177GFGYFSF14EHsObNdN5DPwA5wQ2ZO4QHRZYNFtPjUSJ/izdLta
         lt8M4GcWnZm9983cCKwD1jHbhuokNcyDT+rv+PaqB4k+xM8/1+trFgfWDMTHmT0GJyrs
         RUB8h425G7U1NGI+j7QjxCnsTblL0T4GjSMyraMph/YhGPoHgi/m6eHc2IGoZwrIaFnz
         jcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724183479; x=1724788279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HY8JWRO1iNfwMHzxpz8V7gHbqwhiAwxtKGMMcVo5XE=;
        b=WLuixhnJERUkgGgFNvjnaL6pmXtsyPGzjbt4Y+o0876nXLFFnpULC2uqVSqL2VHip2
         rQpsWY6XS/56EOpO88UMkmvv66oVSvmaGjKleUGC0plxKzLRh47JWiRTvGSYX2s3EbAS
         8Ift3I2yc8zdqOX4xcq1GZF4riT5fIXTHdRHD0jdzi+buQXbrULse+RgA9Cu6XYbUN/n
         u3t1JWnfl3IYGJuyc2VuaZ7yiBX1xjtYeBuDkJurLUrS9qgYUkhrD9BcUccyn3EivYY1
         0o+NA/KA3GJpk46FQUn/mBDC7jdOlGAzKehlGYAvhZXWQOlmrZdf3wtYGJkkYsjMF3V/
         mRKw==
X-Forwarded-Encrypted: i=1; AJvYcCVGoXNqdCh7RIvXEbdLqy/AJBAJCFmS8Uu0n/JOtJy5ZwBU+tEAAjHOA46G1vYNIoRbCbSUrsQa@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5RheYWb257HoljifRjvY/2N6g/et8MpOaq7XFrSiMtWzNaAa
	lBhNS5w2I1sxn4KCCCENbg4CLLqRP6VoA4/Mp3Lbg2T6CfPe76Zmbn7l7HjL29pYTAT/31hrkTQ
	iP5lSLo25gNnINeoXmohAPXjmnS+UUvRpZhGD
X-Google-Smtp-Source: AGHT+IGKdykl+uj/SFsceNtjz8/psF36nvVXhz3ixkdL5oKCjpZbfeISAjdZnx73BCFFoEiw8mUJSYh2dgSSfjfN2GY=
X-Received: by 2002:a05:6902:11c8:b0:e11:6a21:2270 with SMTP id
 3f1490d57ef6-e166540f906mr545445276.6.1724183478751; Tue, 20 Aug 2024
 12:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815083229.42778-1-aha310510@gmail.com> <CAFqZXNvXJY4Bh5k6DZ3yoLFuHo2bQRk3Q5Lv25ms6oOGyN5ZAA@mail.gmail.com>
 <CAEjxPJ4TMk3AoAd++nHQUyTHd_7vbOHC1Veq1ZSSyjH3v0kJ7A@mail.gmail.com>
In-Reply-To: <CAEjxPJ4TMk3AoAd++nHQUyTHd_7vbOHC1Veq1ZSSyjH3v0kJ7A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Aug 2024 15:51:07 -0400
Message-ID: <CAHC9VhRV4j9i7YuKFJkNe9RYnKvCMLHHOi0LrRvwaFWbGJTbHA@mail.gmail.com>
Subject: Re: selinux: support IPPROTO_SMC in socket_type_to_security_class()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Jeongjun Park <aha310510@gmail.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 2:24=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Aug 19, 2024 at 5:46=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> > On Thu, Aug 15, 2024 at 10:32=E2=80=AFAM Jeongjun Park <aha310510@gmail=
.com> wrote:
> > >
> > > IPPROTO_SMC feature has been added to net/smc. It is now possible to
> > > create smc sockets in the following way:
> > >
> > >   /* create v4 smc sock */
> > >   v4 =3D socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
> > >
> > >   /* create v6 smc sock */
> > >   v6 =3D socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
> > >
> > > Therefore, we need to add code to support IPPROTO_SMC in
> > > socket_type_to_security_class().
> > >
> > > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > > ---
> > >  security/selinux/hooks.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index bfa61e005aac..36f951f0c574 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -1176,6 +1176,8 @@ static inline u16 socket_type_to_security_class=
(int family, int type, int protoc
> > >                                 return SECCLASS_TCP_SOCKET;
> > >                         else if (extsockclass && protocol =3D=3D IPPR=
OTO_SCTP)
> > >                                 return SECCLASS_SCTP_SOCKET;
> > > +                       else if (extsockclass && protocol =3D=3D IPPR=
OTO_SMC)
> > > +                               return SECCLASS_SMC_SOCKET;
> > >                         else
> > >                                 return SECCLASS_RAWIP_SOCKET;
> > >                 case SOCK_DGRAM:
> > > --
> > >
> >
> > I'm not sure if this is the solution we want to go with... Consider
> > the following from af_smc(7):
> >
> > >   Usage modes
> > >      Two usage modes are possible:
> > >
> > >      AF_SMC native usage
> > >             uses the socket domain AF_SMC instead of AF_INET and AF_I=
NET6.  Specify SMCPROTO_SMC for AF_INET compatible socket semantics, and SM=
C_PROTO_SMC6 for AF_INET6 respectively.
> > >
> > >      Usage of AF_INET socket applications with SMC preload library
> > >             converts AF_INET and AF_INET6 sockets to AF_SMC sockets. =
 The SMC preload library is part of the SMC tools package.
> > >
> > >      SMC socket capabilities are negotiated at connection setup. If o=
ne peer is not SMC capable, further socket processing falls back to TCP usa=
ge automatically.
> >
> > This means that the SMC sockets are intended to be used (also) as a
> > drop-in compatible replacement for normal TCP sockets in applications
> > and they even fall back to TCP when the endpoints fail to negotiate
> > communication via SMC. That's a situation similar to MPTCP, where we
> > just mapped MPTCP sockets to the tcp_socket SELinux class, so that
> > MPTCP can be swapped in place of TCP transparently without having to
> > do extensive policy changes. We may want to consider the same/similar
> > approach here.
> >
> > I briefly played with this idea a couple of months ago, when I was
> > asked by someone at Red Hat about SMC sockets and their integration
> > with SELinux. IIRC, when I tried to implement the MPTCP approach and
> > adjusted the selinux-testsuite to test SMC similarly as TCP and MPTCP,
> > I saw that the netlabel-related tests (may have been more, I don't
> > remember) weren't passing out of the box like with MPTCP. However, the
> > person then didn't follow up on my questions, so I didn't look into it
> > further...
> >
> > I'm attaching the WIP patches I worked with, in case someone would
> > like to continue the experiments.
>
> I am not in favor of your approach, for the following reasons:
> 1. It would be backward-incompatible with any current code using
> AF_SMC (although this could be addressed by making it conditional on a
> new policy capability, so this is not too difficult to overcome),
> 2. It would not allow any distinction to ever be made in policy
> between SMC sockets and TCP sockets, so we could never allow one
> without the other.
>
> Hence, I am still in favor of Jeongjun's patch to consistently treat
> AF_SMC and (AF_INET, SOCK_STREAM, IPPROTO_SMC) sockets, and then if
> someone wants to extend that support to also provide more complete
> access controls and/or networking labeling, defer that to a future
> patch.

Without passing any judgement on the patches Ondrej submitted (I tend
to ignore patches as attachments for various reasons), I do share
Ondrej's concerns that this may not be as simple as suggested in the
original patch in this thread.  I saw the same thing as Ondrej
regarding the TCP fallback and that immediately raised a number of
questions that I don't believe have been properly addressed yet.

Someone needs to dig into how the standard SMC protocol works first to
ensure we have the necessary access controls for the current code; my
guess is that we are probably okay since the socket-level controls are
fairly generic, but I'm not sure we've actually seen proper
confirmation that everything is good from a conceptual standpoint.
Once that is done, we need to examine how the TCP fallback works,
specifically how are connections managed and are the existing TCP
hooks sufficient for SMC (the early connection state stuff can be
tricky) and how to distinguish between normal-TCP and SMC-TCP.

Basically I'm looking for some basic design concepts and not simply a
passing test without any understanding of why/how it passed.

--=20
paul-moore.com
