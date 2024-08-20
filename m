Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E844194149;
	Tue, 20 Aug 2024 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724178282; cv=none; b=UQP1Z+j6CeLk4ZOqk6mL2GVz3Z/cYSL/ycoK8bBHpki4u/XIkquF/IIWJplPXjVhi5912gsSb1CaGJUwDNxhpPvIz6dUvyGfQ08eBhVS1nsLmu6r4amdv3xk7AGLKbTosX+SmE5pucb6gYv+Ey5jXjhmKzl3ijq0EMo8yVurdnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724178282; c=relaxed/simple;
	bh=kuV/PhhqVkgVmCsLz5MC/5pdYhpliVeomTil3Z6ltu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZd7MCiMiLt/o+xl3F1PmcwpDRft+/qqu6IyRLDwdVLLGbiUBDq8f3UyyKyTK3dr0jVdWyUeWsrF6ll+6+Q04skzaVjilNq1cGYqgHVOzuJ2xO9QFgp2o7PauR6QhXqNJ5j+LvvWWjXHt744pkOrIlrfZpmZnOzUf7BqHT0Ifqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekmlQodU; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekmlQodU"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d3dc25b1b5so3464300a91.2;
        Tue, 20 Aug 2024 11:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724178281; x=1724783081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+i6sJ42DtiCpxwsR6+GPd0920c+6jUd1LQPHgVW96w=;
        b=ekmlQodU57HcTlFrprj+wjgQqyS5aOzsqHCXfxtjW8L8gs75NQZLOjATkU7YhAYRmB
         Axl9VzNxSmecLIVnfND+SOpvUy71L5Xa3RWtF2F1AwHMUom6M4JIOEFSesRuirYiyn1Z
         5orL/lD34WCh3zwJAsM0mw2U0sjr4K8X984AwryVivY7tbcr5ujE1bKIux6+koPvytTx
         YD0gDty28WAreLseiw1fNv3DfrHxiz1tjiB8Vn33QYzBvLg9ngKytcNUCudam7W1pG95
         LqH+xzAM/lXtzMUcOGw8HFrEQLuSqD/FBMXimXfhiZMidbbA9VGAVamwu9fqqCJlo/uX
         h0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724178281; x=1724783081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+i6sJ42DtiCpxwsR6+GPd0920c+6jUd1LQPHgVW96w=;
        b=t2HnpOvtiy39YJOvJOCayPgpR577FJJyo/wdeLj3lmc+A10hlSflu0Wd+707lLyWHr
         C0h8afTsM651MJhTa0IySRCPrzFxlEVsuWagLMJvaazZhCcvhaaVnb02lGbzgXUpqL3g
         jVfFasUYdApAzMrlyscBd4xtCBKZI1bqhtbv17LyavdMsTwqOHFaYfxgq5l6rVBulRF8
         qDlZ1pT6uhRo1GcBA2weSM27C7bn8D9pcSGYHEIZTYl7nvUaL+84qm3ge6c0bP7+JUcP
         V5qdRUYfznlFwpFszoJlWzqZADYzwSt99Yed55aDxCISSBLjlSt7afu4jmJaxhCqT7yF
         +urQ==
X-Forwarded-Encrypted: i=1; AJvYcCUchLtt/4ayDQsSifkbUFVaN18q16I4wGOZuIxTh8Wv1yudFy81n5bIMpmJP9oM4Aq3aU5z3SQMNrs/w5o=@vger.kernel.org, AJvYcCV3t1VtG8hCiyRZgPTrBJVlwvj6ov+ekmdDIo1oBd67gKqkkND8cJ6lMsmki+R4FV6GVcHcjWTq5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPtFVnxc0eSS9ts0lOWBxhfU8Dr36Q6F6sJzEWylT9JmQfo3qQ
	ixIxSAXVMV+mUOyO2ApUr4dvKLOxWRITWGH76THyCTed+iHY1qpXU1KowPKiwyC2Ze9pg7cq+j4
	ilnZZ1+EWhwFAKSLQcOirQlGf+qt7Mw==
X-Google-Smtp-Source: AGHT+IHFhkAzGsuYJ77lXUTjIcm6T0Re7rUfafDIoobQNcv9++idQxCvfecblA3n09EI9Shu4DlUaEu53eWspTq41/A=
X-Received: by 2002:a17:90b:374a:b0:2d3:d7b9:2c7e with SMTP id
 98e67ed59e1d1-2d3dfd9074bmr15061863a91.24.1724178280389; Tue, 20 Aug 2024
 11:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815083229.42778-1-aha310510@gmail.com> <CAFqZXNvXJY4Bh5k6DZ3yoLFuHo2bQRk3Q5Lv25ms6oOGyN5ZAA@mail.gmail.com>
In-Reply-To: <CAFqZXNvXJY4Bh5k6DZ3yoLFuHo2bQRk3Q5Lv25ms6oOGyN5ZAA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 20 Aug 2024 14:24:29 -0400
Message-ID: <CAEjxPJ4TMk3AoAd++nHQUyTHd_7vbOHC1Veq1ZSSyjH3v0kJ7A@mail.gmail.com>
Subject: Re: selinux: support IPPROTO_SMC in socket_type_to_security_class()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Jeongjun Park <aha310510@gmail.com>, paul@paul-moore.com, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 5:46=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> On Thu, Aug 15, 2024 at 10:32=E2=80=AFAM Jeongjun Park <aha310510@gmail.c=
om> wrote:
> >
> > IPPROTO_SMC feature has been added to net/smc. It is now possible to
> > create smc sockets in the following way:
> >
> >   /* create v4 smc sock */
> >   v4 =3D socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
> >
> >   /* create v6 smc sock */
> >   v6 =3D socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
> >
> > Therefore, we need to add code to support IPPROTO_SMC in
> > socket_type_to_security_class().
> >
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >  security/selinux/hooks.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index bfa61e005aac..36f951f0c574 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -1176,6 +1176,8 @@ static inline u16 socket_type_to_security_class(i=
nt family, int type, int protoc
> >                                 return SECCLASS_TCP_SOCKET;
> >                         else if (extsockclass && protocol =3D=3D IPPROT=
O_SCTP)
> >                                 return SECCLASS_SCTP_SOCKET;
> > +                       else if (extsockclass && protocol =3D=3D IPPROT=
O_SMC)
> > +                               return SECCLASS_SMC_SOCKET;
> >                         else
> >                                 return SECCLASS_RAWIP_SOCKET;
> >                 case SOCK_DGRAM:
> > --
> >
>
> I'm not sure if this is the solution we want to go with... Consider
> the following from af_smc(7):
>
> >   Usage modes
> >      Two usage modes are possible:
> >
> >      AF_SMC native usage
> >             uses the socket domain AF_SMC instead of AF_INET and AF_INE=
T6.  Specify SMCPROTO_SMC for AF_INET compatible socket semantics, and SMC_=
PROTO_SMC6 for AF_INET6 respectively.
> >
> >      Usage of AF_INET socket applications with SMC preload library
> >             converts AF_INET and AF_INET6 sockets to AF_SMC sockets.  T=
he SMC preload library is part of the SMC tools package.
> >
> >      SMC socket capabilities are negotiated at connection setup. If one=
 peer is not SMC capable, further socket processing falls back to TCP usage=
 automatically.
>
> This means that the SMC sockets are intended to be used (also) as a
> drop-in compatible replacement for normal TCP sockets in applications
> and they even fall back to TCP when the endpoints fail to negotiate
> communication via SMC. That's a situation similar to MPTCP, where we
> just mapped MPTCP sockets to the tcp_socket SELinux class, so that
> MPTCP can be swapped in place of TCP transparently without having to
> do extensive policy changes. We may want to consider the same/similar
> approach here.
>
> I briefly played with this idea a couple of months ago, when I was
> asked by someone at Red Hat about SMC sockets and their integration
> with SELinux. IIRC, when I tried to implement the MPTCP approach and
> adjusted the selinux-testsuite to test SMC similarly as TCP and MPTCP,
> I saw that the netlabel-related tests (may have been more, I don't
> remember) weren't passing out of the box like with MPTCP. However, the
> person then didn't follow up on my questions, so I didn't look into it
> further...
>
> I'm attaching the WIP patches I worked with, in case someone would
> like to continue the experiments.

I am not in favor of your approach, for the following reasons:
1. It would be backward-incompatible with any current code using
AF_SMC (although this could be addressed by making it conditional on a
new policy capability, so this is not too difficult to overcome),
2. It would not allow any distinction to ever be made in policy
between SMC sockets and TCP sockets, so we could never allow one
without the other.

Hence, I am still in favor of Jeongjun's patch to consistently treat
AF_SMC and (AF_INET, SOCK_STREAM, IPPROTO_SMC) sockets, and then if
someone wants to extend that support to also provide more complete
access controls and/or networking labeling, defer that to a future
patch.
