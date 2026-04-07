Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B2835EDBD
	for <selinux@vger.kernel.org>; Tue,  7 Apr 2026 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775593314; cv=pass; b=qmYy43eJk8DzRL+CI409Ihb7nIl4IYv7RYSVvYlcS0ehSfLefesjQjf7mDJ9V/cc5HlO9flLOgKJopGaF4jvuM52GLKsN3mYfJwbwMeiJZ6LvEPiTgSoR0haMm0lyp4PEWkNdXaB+79wdUuk8Y15X46EPeoYcrmeAyraNq5dsmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775593314; c=relaxed/simple;
	bh=s8r+Vr1ig1OhurHXWjJkYiIRQ8nvrWmPw/5iPQbFVX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovH01Wc+xE51dbD0Bi2TbE2M2tAN13Mg0iD1q/UOHmUD/GRliEmqve7zZhNgpEjwW6n5OP0Z9nVduKw2ccC6O0Pz1j+yLvmCwXTzgpeO9iCGd+QaQtgsMBbvldAjfgTWbPQ+OJ/fyLLYOhzo1DjJodFw5Q2DV/WEEjXJU4ND93c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IC2Mf/76; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IC2Mf/76"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82d0b68837aso2315827b3a.2
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2026 13:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775593312; cv=none;
        d=google.com; s=arc-20240605;
        b=i5jPQqIf2CiBgfrBszc3f+0ai0WzV0eid5tZchpI1MF46OlQgTUoBFBws+IEh/HNrm
         b9pZtUIVtESM2vIa+RWA2sbBGJZdk8nNNNHYig7tCL96sj/yHmCdZxecoSmN8dYxVLxe
         ZzsdUsS7UvHfoZVbDqjFaqxaWUueYGQBhAV6XzaS+JaOaSdVFfvIPVD56rRYuxDjYeOQ
         6D+27ejqnayUnfhEBINq2Of4dvwH5rPlgEwrIvVbzPyRfu21lcnZfXfEbdRvn4ONIQ9+
         6h2WgJanVZKitf0qJGdpW73HxW3nux6/PtoJwHQjzCRiXOdn19MhevUutNvrjAqLBwCE
         VuEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/8nRFvW3dvzP0f1HI4A52To34cw9HB6EK5c+K6burZQ=;
        fh=7T/Kz9KD8RCHByrKxptK3cqsLvVI4FRNv+MXiflWHyg=;
        b=Q4Vk5lb5/h2lxCND8mv1NKcz5aR+liA3ulw8TzETHptNHMHQCyMpCLHKX/nRx/E9m7
         HfEmCDznlxxLUh8hcBG9AB/PJZmr9Vi5QkawYwA3pgBHsrxYlYMjgYKX4ACA0vBmKy7W
         iPBhhBwORpIuBOPfkXfi18fqmpfrDTRUd4N+25bBtpMsx7hcHI7+rDGQbY4BKWF+VbPv
         QPJrqYwxyszokZ5BovG6K6FYwsZ6gOy8NwLePs0RfiERPK0omdKgMWO5iahGW/VGFK58
         6MUCW0k5voQAqoZKsRcj+HOL3u94y1EVgLFyWlVMASypeaibKWz01ZhMxB0tIZ47YRvx
         3msg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775593312; x=1776198112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8nRFvW3dvzP0f1HI4A52To34cw9HB6EK5c+K6burZQ=;
        b=IC2Mf/76v9d/4+Vh6KzdO1wOwI2ty3/6KLd9aw31Jtecua/uQWbW5+nbP4siULJXMu
         6WeZ1BfHZ68bJ22X9VtLypqRXjl5TwOS05KNkt2SbxiZchp30K2/GorVjvcNyKmbIPU9
         nnnIuWJeqVhuZJmechP9u8OQX238BxxuBGR8k+bJosBBkwvg1eOOAIWdz02ujgKD2EnO
         QXSsuX0SyQ2T+plZugFMZaXTvgf8v3+ULApDpbgmCr/IcrTr3eslMgmePJRq0n+iZO0c
         pqfSpiQEmQlmb0/EhCC8SEAUleZLDhRSmcB0Exsg60oNRTQyjVLuIEgm4TsxM8845Nuf
         ccvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775593312; x=1776198112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/8nRFvW3dvzP0f1HI4A52To34cw9HB6EK5c+K6burZQ=;
        b=n91fRhKf0ybI2grIVqivhv+hjkVgV5co5kbRzCuXfwUfJRJKKqv1Caoe58/EWUrN/4
         2V8/clKlpkgPFm6++beSLIzxKyerBeQlhw/kBte7QKbPOLo+JItXPjvG33Ruds2qz8VD
         BFhVejFmezxdoH96uS5hFJ0MDbo4PJpqfMPpPEWAQxS8XPqB78spdCCc4WwIR9u8ttHy
         f4KYUme6uJDWouN+TP9p+2CLjkWMHb/1Pmfbt77sS8aAMndN9W41AScdu3L70czn3Ntc
         KOb6K+Y0ktRz5GCErnQknQZjId86Ry18Nhk3Y1jTefC6A5yeY6OAdqpf7o/dpS1t7gX4
         FT0A==
X-Forwarded-Encrypted: i=1; AJvYcCVVLdPbF1FmID7fPLvrKWlrKoGNLPmvTufvVVuTdikub187vll91aBxhj3horVpJLsQPmqjQKZL@vger.kernel.org
X-Gm-Message-State: AOJu0YyOPwqNJN4VnVSZECapC+ETBpgOcTNJ9hHXbXx2awfpQFlGXWHa
	hbdYqjfA/oVncDRuP8YAO+UdcAHtk0B5WL7lNBrrhWVf1BinviyQvpxn1qY06XobE8gGMgvBDxs
	9TcSfkIMz6yh7IWIQ1m/ZEKVnuTJ2AoCqFe4Kk/Gp
X-Gm-Gg: AeBDieuy9Q6DOLyy7wWaFs8Yc8eWfKuen3k+oZMXC7XgyAjhmdbQjizjppmr0WhaECa
	vY+pDDigaAHwRgeCNqSe7ay4Z0FGiGHazNDo3WrGvks89Yw2H+s4kJQBZxhP/GK+aWlgORxj965
	lTBMUpdlLjDvazMfFMZ9vl7xl74rq3tnzCK9EjS8+7E8Yz/LbHSKPm66PgYGkjsEbpVFltjgWiC
	J2ynESzBSF9g8cS86CiLMq7kNELNw9aJRsgObIPcryX7TQPi/34H0Rc9BjkYjj5JTb8+4Rpbemp
	SZXexPIv/VF0ahkLGQ==
X-Received: by 2002:a05:6a00:1a89:b0:81f:4a36:1c7c with SMTP id
 d2e1a72fcca58-82d0da74ce9mr18411507b3a.23.1775593312517; Tue, 07 Apr 2026
 13:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-8-paul@paul-moore.com>
 <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com>
 <CAHC9VhQnA38-9wDeVmOMxAFPHnd9y6x5LXtD3cSquGiL_MDDpA@mail.gmail.com> <CAEjxPJ62=0v9QYJ6s0DrwRp4WZna8f9wnuM_DUUNrcz2dd_kog@mail.gmail.com>
In-Reply-To: <CAEjxPJ62=0v9QYJ6s0DrwRp4WZna8f9wnuM_DUUNrcz2dd_kog@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 Apr 2026 16:21:40 -0400
X-Gm-Features: AQROBzC_mkg1V6Olu64dm2ucorBxgS86oz5XW-KOWVbdzobSFYHPihrj_73P3oU
Message-ID: <CAHC9VhQ5PH99EQBuYq4c7Jf82UXiDfC7qzM2kvnZuyH6yFPL_Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 3:20=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Apr 7, 2026 at 10:35=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Apr 7, 2026 at 8:14=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Thu, Apr 2, 2026 at 11:09=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > >
> > > > The existing SELinux security model for overlayfs is to allow acces=
s if
> > > > the current task is able to access the top level file (the "user" f=
ile)
> > > > and the mounter's credentials are sufficient to access the lower
> > > > level file (the "backing" file).  Unfortunately, the current code d=
oes
> > > > not properly enforce these access controls for both mmap() and mpro=
tect()
> > > > operations on overlayfs filesystems.
> > > >
> > > > This patch makes use of the newly created security_mmap_backing_fil=
e()
> > > > LSM hook to provide the missing backing file enforcement for mmap()
> > > > operations, and leverages the backing file API and new LSM blob to
> > > > provide the necessary information to properly enforce the mprotect(=
)
> > > > access controls.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > >
> > > Do you have tests for these changes showing the before and after (i.e=
.
> > > failing without your patches, passing with them)? I tried running an
> > > earlier set from Ondrej but they failed.
> >
> > A few months ago I sent you and Ondrej some feedback on those early
> > tests from Ondrej, but yes, I also had problems with Ondrej's tests.
> > I've been using a hacked up combination of the existing tests, some of
> > Ondrej's additions, and an additional debug/test patch to ensure the
> > labeling is correct.  It's far from ideal, but I didn't invest time in
> > test development as I assumed Ondrej would continue his efforts there
> > (unfortunately it doesn't appear that he has?), and I wanted to focus
> > on getting a solution as soon as possible for obvious reasons.
>
> Ok, I'm happy to look at even unpolished tests - just want something I
> can use to exercise the before and after states.

Hopefully Ondrej can provide an updated patch.

--=20
paul-moore.com
