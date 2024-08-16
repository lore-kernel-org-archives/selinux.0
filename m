Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366FB13C9A7;
	Fri, 16 Aug 2024 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723807315; cv=none; b=N/BfDz9mDci3MCg/+APf0Lh6PyVVCsiBS5xWUhvzY+y1AHo0JpLAVIzA61H648uKIl+Ly6JPoQ42b/qPgJBBZ2SuMa5o/d8fKNwnXH58oIvXElm6DQK6wA2YyYUFXdwtgHXk++RG5+BM4ODwqDoAz5i0KqtF2hKP/dsi9x+11UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723807315; c=relaxed/simple;
	bh=R+Q/8x20X/nTyD+7YQblrqtXOMfPL8BRA30eakhx8MM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjG/psNinimkHfwJ8H4RZolNcPaEaOWwphmatKZBWMavms4M4rm4cQQmCMgfqu3rbTlPw+few2q/cDFu7rLxJq+OovbPWWAkZALprxmYUwwD6xl7dzKT5qAA83PDZyIdV44kf5PfU84PIfQXeZnnJ06Y6XBjxT3beGz3eHU4GGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmXncSKm; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmXncSKm"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6e7b121be30so1469167a12.1;
        Fri, 16 Aug 2024 04:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723807313; x=1724412113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16cQp4jBhIOjJqZLUeHIPz2kWW5Nn4hw6rOt2LtcdoM=;
        b=WmXncSKm7k3PhGrcr6C6pidXi32e71S7+GRbuQkYgWEw8N2503JVaZeBUuvQ4mZF0l
         6nfcO1klXtjF58EJE8dgoQ0qKnzKo9qsrFOa02k7drZBxtkC8stBGwxtaWBWY2a98ets
         EtS4TtJvDBGCHDY81gvK2nD5T1Ben2hXTo3fbZqyEElf46vtybKEHY2xzopR0NILyoFi
         i2Cz2IMqIjYwx7qt9srozeeHJw7G4c3Bhj1vb4HN9flnLJNF1lsk4KMh2+10yNadBGJ9
         E9dX77hHhcPZyONugekCxbAzDNvKey09vRxXYXPP/e9WzhsP73wLL735ryZfJ6j9+o3E
         ExTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723807313; x=1724412113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16cQp4jBhIOjJqZLUeHIPz2kWW5Nn4hw6rOt2LtcdoM=;
        b=xKEhg5lSUrvEE1HDGiUmbwk2KnOeuwLalcDUi2FPPwCCxwVQMczVqdDxESA7hQ/32G
         WbNVTWv9DT3KfDVT4bNxED8efTb08GJyEZgAzLrL1wbGK0edteOSmAUmc403pERwlZOR
         cpEaQfKtvfUG1/XO6iwof2nmlkuM2t0bAYe2hbHMAt0Wu7YG+STjZcHuVeZ0suwKRrV9
         ce9bwySDzI5CCY+u6D9qk8tTXYgAMCqPQRi3MAzNf/QbLX5lTS2YkqiKvrxfdUhwHbkx
         GRTc2QaMwaooJOT7VOuuVjbUoyoKw8lnfjqousaLmatYMWus9jlJCpFROKZUKcMbnpp3
         BCPA==
X-Forwarded-Encrypted: i=1; AJvYcCW4tBHqOK5C0aWTtkqDIDsRTQLfC88SmGoLS0ZxGq2A0tNITJwf65ERVzKYhGuaGs3jdAyKTh86DeiE1RBx45gd0ztoPnF4sR/C628p9vXwFg840fmr17R6Dg26IT5u5zhHRAV0/w==
X-Gm-Message-State: AOJu0YxmcbarXy+OWOujM1dwL1IkLWxOvXnNOjL0LqWtob6qOtxiIrKR
	srx20mO1OJLtIVBOYlO4lS5e9EZyeVfSMt7OToaA3JZcnKg4oEjJEwWMfC40mKWQvj8hGt0FPYs
	wBC+CSvdR3vUwAY7A1Q+L/azw6WTJHQ==
X-Google-Smtp-Source: AGHT+IFxZCqQ4z81Lrsq2F4ufL/3FdZkEQfI/qgELsMISl0JCjgVx3GI7O1W68t5l7YvPkzi3lDytULPSrVCXZTBOqI=
X-Received: by 2002:a17:90b:a41:b0:2d3:c675:41e7 with SMTP id
 98e67ed59e1d1-2d3dfc3a9acmr2730998a91.7.1723807313230; Fri, 16 Aug 2024
 04:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhSrPS27KSG1_On8_WqUfR7tokbrmVwfW3+L_-XJiA=WZw@mail.gmail.com>
 <20240816035751.62058-1-aha310510@gmail.com>
In-Reply-To: <20240816035751.62058-1-aha310510@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 16 Aug 2024 07:21:42 -0400
Message-ID: <CAEjxPJ6gznARkD_jTZUhXJmQ5zvdrwxJOiSC0YQoZekNe76Nug@mail.gmail.com>
Subject: Re: selinux: support IPPROTO_SMC in socket_type_to_security_class()
To: Jeongjun Park <aha310510@gmail.com>
Cc: paul@paul-moore.com, linux-kernel@vger.kernel.org, omosnace@redhat.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 11:57=E2=80=AFPM Jeongjun Park <aha310510@gmail.com=
> wrote:
>
> Paul Moore wrote:
> >
> > On Thu, Aug 15, 2024 at 4:32=E2=80=AFAM Jeongjun Park <aha310510@gmail.=
com> wrote:
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
> >
> > I'm a little concerned that the small patch below might not be all
> > that is needed to properly support SMC in SELinux.  Can you explain
> > what testing you've done with SMC on a SELinux system?
>
> I don't have much knowledge about smc, so I can't tested everything, but
> I created a socket, performed setsockopt, and tested two sockets
> communicating with each other. When I tested it, performing smc-related
> functions worked well without any major problems.
>
> And after analyzing it myself, I didn't see any additional patches needed
> to support IPPROTO_SMC in selinux other than this patch. So you don't
> have to worry.

Note that Jeongjun is not introducing SELinux support for SMC sockets
for the first time here; he is just updating the already existing
support to correctly map the new IPPROTO_SMC to the already existing
SECCLASS_SMC_SOCKET. We were already handling such sockets created via
socket(AF_SMC, ...); what changed was that they added support for
creating them via socket(AF_INET, SOCK_STREAM, IPPROTO_SMC) too.
