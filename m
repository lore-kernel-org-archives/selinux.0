Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916DE8F58
	for <selinux@vger.kernel.org>; Mon,  4 Aug 2025 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754319139; cv=none; b=WAlsCQx6S2lv3cAnQpbX2AKMQRWrCAbWnnT4fFI0t+8Fc29h1hN1Y7UJAiN7ud3IfE/XP3PPTUirnEgSnypYS7bivXQpYVnqKdNRWJG134te4M1Hyoc7uQG6x/IiqMZgCoY7sOr+ikIfSKshOnZ3rlwVX+tUW600ktuzZfRQ6/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754319139; c=relaxed/simple;
	bh=54eMTJDPCG5pT/DVfqU2p9AITjgBWZhHNlPkno33bNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsmaMZiWavwu3V3eFogS3IgG1+/zGeVVIJGP71ZGrhrf+zRBMxW2mFqP0nQM7E6ylxDVxAZFqxOT7VSTec/simkmBSsO7FYCF1ZNzCb2r5IgNcaIO7y/NeNWbauntaJc/R/zC08F324xedn0N0D2ee9xDxcPI0sSxiiAhHr8xn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UzHYX504; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UzHYX504"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3190fbe8536so2919274a91.3
        for <selinux@vger.kernel.org>; Mon, 04 Aug 2025 07:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754319135; x=1754923935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2XOyCZQ4BA+qFc9hYWA3x68LbHIUoRZhcHyoxazfKM=;
        b=UzHYX504GVrp3oXBv8yQwG8+RL/kgC7xp8AcQCWMySyPi2ObKrV6UZ6lGNMIl47vNe
         SEnSYJTglJWcJs01HAddLBSWggLz5jJY8PILPUZiDJTbifcUKbD7quatFhxQ8HcdmetF
         Dl1yM6rQYf87y2temfR06R7yTC3v64Ls/zaNs/RD6axuM71V41qJtN1kklqqb03l9RBi
         Sn42E9eNLpHfwONoW+ArWJd9yu4Vhw/W68KqDbpt9STqE9pgoAJwZ/SOTxEgufm0HJn4
         Fu6mFKUxNhDnDJ5W+Haa6XqJQtuR7lPx56IqjJ/umFHLRdN3KTQHNOMvr2+FN7eyr36E
         Hk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754319135; x=1754923935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2XOyCZQ4BA+qFc9hYWA3x68LbHIUoRZhcHyoxazfKM=;
        b=Iu0Xw6PsSBsLlU7LKfti0UVZMSF/fJAYEwodPRD7AiEophX7Y2sFmuH/H7DzcpM4YJ
         5S7i8TgcnhcVy9o2lNvtNJ20/3xXbftSRrOVonYLWOXyNnJ/ioGuSrzOWA0tjXxpeBn+
         3caHPGTiEEFm7Z10VTkO0zgjM1zdGm82PhRkt4dK9Vw0Ves+6N0JIiQW4uOttCX7P/ii
         PZCcl3e7zQUk6D610vGveRHa/rOvlQZRskWxWjtASZyNLcdUPTUk5MDaFJRP9XPpsJzy
         1rf4x8bqdWG+Avnzpm6CfmncuxRrkC3CL2tYtQ4WQxQ5TbLZYp+I5lKXTvLy3jbd6tFX
         RkqA==
X-Gm-Message-State: AOJu0Yzw9KMGarqzm4ONVP2fVrg/Ir28krcHMnlG7qMBUOwjtKgbPSuM
	8csPElkX4AfJg9w3G4obTNXkSRw5uJRKRCZ2DbnRiukN7iTxAWlo1IByyD/E1h93FNwIxrcgbh5
	fydmuyDiRR8MV5R1GfPxTE9+UVytQcZ2tefRf+MbFHHBsFSWsFF0=
X-Gm-Gg: ASbGncsp6BPK8Hs539ReHOW44o6cKBVUk1ggj0a6HXDRop1mfhvq7tte9Y6xq3C6TEU
	3C95ob8Dw13olRGBMfwSF24PdkByyDsZzO5ghAJ89qY6MceOxvi22oy/SvJ4DZ71qtQkWVvZK1B
	UeX1oiLwbYu9zaz3hLn7s2C5lNFE1Z/5uAcNJJONLKJdypqc4IdVdu0xAQgAzZA/yftWB+BGaQJ
	T3KKCc=
X-Google-Smtp-Source: AGHT+IEI/SgClQfYpb9QIFqX59rfZhX0MjtLy3n9Q1nHeBrK3TqvYCBgl0mKCgs3nCxk/wQJJxFZbEnHRb8aA7PGfrk=
X-Received: by 2002:a17:90b:3509:b0:321:2407:3ced with SMTP id
 98e67ed59e1d1-32124073dedmr8644070a91.28.1754319135413; Mon, 04 Aug 2025
 07:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723182550.1065144-2-stephen.smalley.work@gmail.com>
 <CAHC9VhSUbZrbV06hzzu5kNwrgojjYVYaUL_Yto+stWD1C=XZ5A@mail.gmail.com> <CAEjxPJ7SAJKdZDqdP4jj5i7wjNhJDjV0+8LyC3TQPVWNV4ZmQQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7SAJKdZDqdP4jj5i7wjNhJDjV0+8LyC3TQPVWNV4ZmQQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 Aug 2025 10:52:03 -0400
X-Gm-Features: Ac12FXyi9qd5uG1903pqrRDEquTFP7-sUYFtthiRM5Eq3FcGWMi6otfqzx-idtw
Message-ID: <CAHC9VhQ_ePH2ZmX9nNGs6BDHuwV8_efHC2xoCFfm0XdiGQc8CQ@mail.gmail.com>
Subject: Re: [PATCH userspace] SECURITY.md: add my email address and GPG key fingerprint
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 8:48=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Jul 23, 2025 at 10:14=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Wed, Jul 23, 2025 at 2:27=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > This key can be downloaded from https://github.com/stephensmalley.gpg
> > > or
> > > https://keyserver.ubuntu.com/pks/lookup?op=3Dget&search=3D0x578c42118=
32f0a7ea2c5a7c221a46e603f744ecf
> > >
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > >  SECURITY.md | 2 ++
> > >  1 file changed, 2 insertions(+)
> >
> > I have verified that the GPG key identified by the fingerprint in the
> > patch belongs to Stephen.
> >
> > Acked-by: Paul Moore <paul@paul-moore.com>
>
> Gentle nudge on this patch, since several others have verified and
> signed my key, and I have uploaded the updated signed key to the
> public key servers and to github.com/stephensmalley.gpg.

Considering the nature of this patch, and the fact that there are
others who can verify Stephen's GPG fingerprint, I think it would be a
very good thing if a few more people who can verify the fingerprint
can ACK this patch.

--=20
paul-moore.com
