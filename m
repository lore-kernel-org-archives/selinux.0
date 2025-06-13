Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36F418A6DF
	for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749828263; cv=none; b=bOCULaT/M9fGWWumfbHZdZYd90g9/jNtvtoSch0/2mrpJIKpitqEVyhXAWWslWS6He4EuXR/d4DAfE1K3pL2GaY68Gh1+vxDcifeYCVQZ1s25t6Fih5011/Hw3Mlf1zAjXBI+CoTMpHulT0Mvo3cQes6dGOzEWKw1/LxVuyB7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749828263; c=relaxed/simple;
	bh=Fd4GQPsCd/UJEAFPjRW3/d3/dbrLCklY3CeEfYlTqrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RE3a4DPxMGYMV2ecy71ZK1mHtpwycH1Og3FLzkN4j606Sb/190U2OXUp1y6Y0BfxDOpW8A7VMw+KrZox6umXrXFZh4LMNMkfi0dGMtpFXoyn1AxFPhHBFLfh0sAI6ol5v9V7DXbMQL6yOixEsdJykTWiYY1Mc0PrUYWi98FN1N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FkafQ+hE; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FkafQ+hE"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70e6bddc30aso19965687b3.0
        for <selinux@vger.kernel.org>; Fri, 13 Jun 2025 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749828260; x=1750433060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fd4GQPsCd/UJEAFPjRW3/d3/dbrLCklY3CeEfYlTqrY=;
        b=FkafQ+hENy9nF+qHPJwXBY+NkRwkg8N5sXs3qDv5+6Mz1pblBKt5Spul5WStCBT4VD
         +Yq9lBGKgW5WOCSLSN+Q7wxzWzy8+eANMou5uvY3MaMT9Sp7onD9UjrENQ1bZnoUBrId
         8q5vH84VYoltmnZLH3nXMWvJF7Nk74xkWBqfF5r1IOQXbCnTb7hO5pXfWkDlY749Gtjn
         PUQk6Dkrksjq/wEeO9IKfBC+8tPaxDA48smX1dmYL2yDZruwJQpsIW1hlWmHlRe1P10Q
         U8BHkFcY5HgylqM4CDDJvHMQ9zsL6gF/I8hcOfFlivV6/yUTrONVGFM0br4DFKW3wLgO
         cLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749828260; x=1750433060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fd4GQPsCd/UJEAFPjRW3/d3/dbrLCklY3CeEfYlTqrY=;
        b=Fn1nDxGCxe8WMqfS8kGq70lsEcaAzf6QcMRndDlQJjgtMmzmrRyPZGvPFd7j/Yu50o
         v0wrSZg5z8qMVwgaGU9h2N56IOz4pcPfIixIy/hZBA5BjBoGh8ae4uYBFt9zD1WKWfTl
         sKdhGO6XA1sHgeokQiVhgV90YVoZnyMNdMDam8AZntZR4QDoQNEV/tnQPG8/huoE/Bmi
         nnmhHbljk9VcaB0N38N4TcswtaHUJS2ruWVzVTdOLq2L6w8bV9xWTjhMetGWJiNPn0ub
         5O8HCXel0rUD03WaHA9tjSYIWm2VgUcfBNJeJ3GnPgFrcMfEpbG5FEsj2RPNBq7NI6Ye
         Q9/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVG/pMdIWEaQKP2MZF5lOfb7VAT2tMHzTGzCTIDfS22ClmcN0fI2dSNA0I81CLFD2eDfTDlnJPs@vger.kernel.org
X-Gm-Message-State: AOJu0YykJHZOjQ6P0rjYCEhYaijZg9UxtFxR9tVMnbafjriWUQTGuGc9
	9hGpT0AEnMzw7X97PEpu3U5HerH+4rdQjm8FajINDK7OuCCWtLSB7XqQtk/dSvCb1FU7D4nxxsz
	B4+nrcwWL4PzQEHDuftmflmpNIt1fnByUAhFt158J
X-Gm-Gg: ASbGncsweAQyuWkJZ5DpdaNBX9eGKB/mUiamlYHm9xWr8+BaqAGPES2/2fhMzOKs+Ia
	nFdl0IgriE/j3KZ+7BMUke2JdffOiEGtQnuy/rxLw+D6otD7oU0CS9LtU+rAcOHpGKHVqE6B6Ao
	r7DRt87Vrx/k1rMd2EG69SGec2pHhX6QHbF+UkUHkoVDQ=
X-Google-Smtp-Source: AGHT+IHfnek+OYLPMr02U9aUh9LETTc5LfJKEK1FR9UgTnTqLiFh2eGERdl20kslUSU02uXwnTAPnA4GCEAD45/jp38=
X-Received: by 2002:a05:690c:250a:b0:70e:53:6741 with SMTP id
 00721157ae682-711637557b0mr49724967b3.28.1749828260669; Fri, 13 Jun 2025
 08:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611183234.10255-2-stephen.smalley.work@gmail.com>
 <CAHC9VhR5CZSHKo41C4PdXbeJ3OuZUQ3ue1cbk9kjkHA6thjH6A@mail.gmail.com>
 <CAEjxPJ7JAJ2aypxVyjw4KKAvGBvUVK6eCzbXF3Wd8huTSPiSFw@mail.gmail.com>
 <CAEjxPJ7YixhZOmHVq92EBVoXO5ZO9__YXhhyD7iAWMkQNV-xsA@mail.gmail.com>
 <CAHC9VhTunOdxp2v=27sAxTjQc558nwnQCT=86WR5TNP3ihSdfQ@mail.gmail.com>
 <CAEjxPJ4MS4S+O3vj+mMuKkCVx53hnt91=2ZNPiP4eY9fKDyO8Q@mail.gmail.com>
 <CAFqZXNtrNCHcybw4mEJZ6AZHGzTjtrf4LnBM6wZNVdpjqec-pw@mail.gmail.com>
 <CAEjxPJ4ErTOs5wRPA455cUAha22pCpvAD8joS5fZTtYaGitDZA@mail.gmail.com> <CAEjxPJ5O9diTHkewEJeB_9mA6TskGU9BSRyhbMA0YEUyq_8zMg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5O9diTHkewEJeB_9mA6TskGU9BSRyhbMA0YEUyq_8zMg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 13 Jun 2025 11:24:09 -0400
X-Gm-Features: AX0GCFueH8zLBLFlpPU1yWsgpa5TPzFb7xW2RQOcSnZH_8_BIXNhrU9jZE_yTbs
Message-ID: <CAHC9VhR8hLW0NE17cYoOXuZy1ODqd5xyxZD_OHVJxDZ5VoaoGQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: invoke ip{6}tables-legacy
 when appropriate
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 11:22=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Jun 13, 2025 at 9:03=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Jun 13, 2025 at 7:29=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > > On my end, the testsuite passes with both iptables-legacy and
> > > iptables-nft on Rawhide (with stock Fedora kernel). Also the
> > > alternatives symlinks are created automatically on package
> > > installation. It looks like you had some weird issue with the symlink=
s
> > > and perhaps some missing config options in the kernel.
> >
> > Ok, so I was able to pass the tests after uninstalling iptables-legacy
> > (reverting alternatives to iptables-nft) and using the provided kernel
> > config. Will need to see if I can figure out what if any relevant
> > differences there are in the config since I was using the testsuite
> > defconfig, which is intended to enable all _required_ options for the
> > tests.
>
> I am seemingly unable to reproduce the problem now that I only have
> iptables-nft installed, so I guess it is fine now that my symlink
> issues are sorted (possibly a problem due to upgrading from F41->F42).
> Should we update the README.md to stipulate iptables-nft instead of
> just iptables?

Seems reasonable to me.

--=20
paul-moore.com
