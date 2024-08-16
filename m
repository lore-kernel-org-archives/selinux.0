Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2779454BD4;
	Fri, 16 Aug 2024 11:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723808546; cv=none; b=VgzGHi1f0IfkOD0+LP+L6jM4O9XkPF/jhMFGKdEmH+TgqLI6qInA1xUMiJEQoOp3wzgYSzxqj09qUdsykttfelbIHG0OndupGxWNFLwalvHozEmQA38mAsoV1XM+CYGV+iv048knSZJ7mdRdGaRqE6B/P0FbsIWNiyVOyBi6+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723808546; c=relaxed/simple;
	bh=R5m16nHspY2kYdjIaZKQJOIacmRd19OsVc/ZCoBzdas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KW6OMI2RnYfCNPhR9ZvdfcE0SB4QFh6OYSM72THt/LSaScK5eoxifvjKkzaAZzvzlOWhoCS9gnNNOtuR8Vws5znqjNQoPubfy965n0HpyZ9MlfULp12u7/gp0VjjMko+6ZWbK1AWnOyvoZV2sgv2wdN04+yx1hwbzlHhN2vc2bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWjewBCK; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWjewBCK"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d3d662631aso968476a91.1;
        Fri, 16 Aug 2024 04:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723808543; x=1724413343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2CZtIBfpwDNTPf085eu3aklo+ZfCPYH0wHQWrvNbKU=;
        b=iWjewBCKRWd4FZHfytcSYAYgIbJ0OPlzL1y9sB8yY+B0+mjlqpXKKvWbohvlBL++Wu
         pVrBRU62yRCYHjNP4HKSOf8fclfyPKUOD1eXldFMXkNekNi62495qf+pmakrd/wZxYwl
         gJ8CYdxbcW6vpo6OTBRWRKoHN09m0bdiyCc4OVd6EpxKTZK4zhXANjvocrs5A5U8+NOE
         btKW/+2ouV5hGq/HdEU91ULRLKaV4PM62t8oXjQfQ+qY9cvnJPDlcH2yZ4mSYB692aLU
         bIq5vfd2bdgxIJvV6ytb66RLpWorgz6/FGP+m4DOIvfL0Ggj3o72CW1Lw3dOpbV6qpUq
         9A3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723808543; x=1724413343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2CZtIBfpwDNTPf085eu3aklo+ZfCPYH0wHQWrvNbKU=;
        b=Bi+GgyTW5F5D0rgcxy/BawPiu9lJsIx+t46qXBs+JP2LFtRfV059bYBPVCPZ7UBOAj
         jidv9lK4S0Ryu/iIFXueRszvHOFS9TjmBCleHN0T4mYCG2MIn3IW7Mtol5Ierzh83x58
         XZY4ReHyv5wKL2Zm3xTpJ3qZxMNqWuRgtMgRUO+/WD9qKIKw+e5fg08XwGn/zh8ZlWIo
         8sgRfopXCXeUNL2TgYRO2UtKjXxP7jJ542Dv4jnNLvTH8ZCKimWBkK7jskti4W2DEY8+
         92t8qyEFmDhA5zKYNBJD4+QtPAiTwUj30TzWq63dbD4oR/jOxVL9nITrBmW95d2QcEIf
         7RCw==
X-Forwarded-Encrypted: i=1; AJvYcCWXrg7vc7K/xSyB6jU80OHTpXmIfySQ9s755aIUm6hALJ7s8ea+8zmRUXA7l1KAo4ym2pxcXYaxmX9z9X0l1S1/IefSj80EWdq9t4r8jAwXFq+zRQ3pofQiHvinvMpqtYDETNBdow==
X-Gm-Message-State: AOJu0YzSSEhzhimIJHTZtIszOOr+Fsu3pEVCHX8lNaYYQ8ZepqKyHdJm
	etuJRsPCe+ewVd+79pj+BTX7gbI0PU3BrtIuk0/6KIJGIndzxjRc12LbQYz8lImOijB+c3nfx60
	pAuEC5FNdKYHMrMXKSwMQgy8MlJryKw==
X-Google-Smtp-Source: AGHT+IFSNqOOgg5nevET7SkCBY0Qcz90IpxVy8EXoAcAYMRxUVLuHlbFJaLF6YFOBBHV1ZT2Pjz5OAUrYfAvoARo/3w=
X-Received: by 2002:a17:90a:cb8a:b0:2d3:d7be:f740 with SMTP id
 98e67ed59e1d1-2d3e0968036mr3003806a91.39.1723808543087; Fri, 16 Aug 2024
 04:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhSrPS27KSG1_On8_WqUfR7tokbrmVwfW3+L_-XJiA=WZw@mail.gmail.com>
 <20240816035751.62058-1-aha310510@gmail.com> <CAEjxPJ6gznARkD_jTZUhXJmQ5zvdrwxJOiSC0YQoZekNe76Nug@mail.gmail.com>
In-Reply-To: <CAEjxPJ6gznARkD_jTZUhXJmQ5zvdrwxJOiSC0YQoZekNe76Nug@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 16 Aug 2024 07:42:11 -0400
Message-ID: <CAEjxPJ6nZY-RV2V0b5mqnUA4fKa09RhKp2SX7io9oO6XhZsacA@mail.gmail.com>
Subject: Re: selinux: support IPPROTO_SMC in socket_type_to_security_class()
To: Jeongjun Park <aha310510@gmail.com>
Cc: paul@paul-moore.com, linux-kernel@vger.kernel.org, omosnace@redhat.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 7:21=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 15, 2024 at 11:57=E2=80=AFPM Jeongjun Park <aha310510@gmail.c=
om> wrote:
> >
> > Paul Moore wrote:
> > >
> > > On Thu, Aug 15, 2024 at 4:32=E2=80=AFAM Jeongjun Park <aha310510@gmai=
l.com> wrote:
> > > >
> > > > IPPROTO_SMC feature has been added to net/smc. It is now possible t=
o
> > > > create smc sockets in the following way:
> > > >
> > > >   /* create v4 smc sock */
> > > >   v4 =3D socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
> > > >
> > > >   /* create v6 smc sock */
> > > >   v6 =3D socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
> > > >
> > > > Therefore, we need to add code to support IPPROTO_SMC in
> > > > socket_type_to_security_class().
> > > >
> > > > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > > > ---
> > > >  security/selinux/hooks.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > >
> > > I'm a little concerned that the small patch below might not be all
> > > that is needed to properly support SMC in SELinux.  Can you explain
> > > what testing you've done with SMC on a SELinux system?
> >
> > I don't have much knowledge about smc, so I can't tested everything, bu=
t
> > I created a socket, performed setsockopt, and tested two sockets
> > communicating with each other. When I tested it, performing smc-related
> > functions worked well without any major problems.
> >
> > And after analyzing it myself, I didn't see any additional patches need=
ed
> > to support IPPROTO_SMC in selinux other than this patch. So you don't
> > have to worry.
>
> Note that Jeongjun is not introducing SELinux support for SMC sockets
> for the first time here; he is just updating the already existing
> support to correctly map the new IPPROTO_SMC to the already existing
> SECCLASS_SMC_SOCKET. We were already handling such sockets created via
> socket(AF_SMC, ...); what changed was that they added support for
> creating them via socket(AF_INET, SOCK_STREAM, IPPROTO_SMC) too.

Also, the extent of the support is limited to just the socket layer
checks, but this is not a change and is no different than many of the
other AF_* families besides the small number that have been more
specifically instrumented for SELinux.
