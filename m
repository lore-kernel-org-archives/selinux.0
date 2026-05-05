Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D460288C0E
	for <selinux@vger.kernel.org>; Tue,  5 May 2026 02:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777946719; cv=pass; b=ltIcQJdksJaKZ6zb4U6dHlp3v1t9DX2UaaIHRWNwvcHwOXmK+g8tV6vLKkAKCgvBd3MFJQp7JMTqwY7+Pn3KKQGNWikMQv5li9RwtcIPR53VBWGpSM2C2ea3sFcE4fb7QXRZ8zNq9M7tfoZ3K5eUmTyUZa0Fd5c7W8rGztoUFHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777946719; c=relaxed/simple;
	bh=gvTcP/QSZduWlO+YM2pkz7nb/ZWzyRFB9ciWkWgUHB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJn7nYZrYJcNmyBq+BCdtkrvPvZ6+biRTg/xDOUIdqUUP825HNGz5DB0K6xLRB/r7Ch866xjDiYmwojIXhzLaUNrpcmDV641Ng4TWxQoLsMQbGZtnzmpC8gqFGFm/fhCHx88oYxODcllapqlRw7fM3SiH0ZPUB9Dplye41PyD90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Iu4pHGTE; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Iu4pHGTE"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35fbca04006so2399833a91.1
        for <selinux@vger.kernel.org>; Mon, 04 May 2026 19:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777946717; cv=none;
        d=google.com; s=arc-20240605;
        b=a0ZeL5lHoHjyhiwngd+N+nhh/8PFmAibJiXvp5A2nomb7EQsuk5YYvDgedZi8Wi/Ho
         7ixoaOhf+b49k8fnXJF01Bjyjpg5hN2bS4ItxkW6aHghm8kAl/g/xnHkgwb2k5Ko2nKn
         InOhggzdjR6ugbu806zONdeJfu6yS/pfQ5V8itO6itTuv/pXdTGL5fwPrJ+NJApin4oI
         v8x1NGhc5OELG+mNGyESLAUCn7YLC/D6aXayboFepuV3buhXN0hD9XUX/c5qtxogIEQJ
         AkFe/Ot2J1bvcBsgQsRlMka+VBI5ZnSwm2qLoZNcrUej9aHASsg+TYWPBB7adViPV9jX
         VPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ds8VPZ8XGFRCMSYoTIFK4J9AmphYV1vVpSWFXmoaOPI=;
        fh=GqJV6TSIBYZez5YFHh5uVzim9Jc6pWSBVHy2Ie9PouM=;
        b=HjZ1ZV/lpveEXN2Dt0DvSxVM3xeRg353EA9DnYX+9Mrp0kq8uDXpWBcfp4iSalwapR
         5rAAfBMI2vgsRHS2yhK0F0/xgMZfr/1CbRvIK8f+w6zO5HpSgSJUT0nkmlSQcSf1IItX
         Jx1o6ysXbtlJvUMvTo9ryO6tibhqo32LMeEFp8R+5/mDg2W4hCi/zJEcUeQ21mwUKVhH
         UuTgjcYZT9d76Ok9F4tDTYoSA50fEvpm3um6WdgAoFA6ijoHYA5eiglBIpzvJxwuV0g3
         aPJrgAP7t0qupgs2uWbnZXYKNY/v5C8KblWL58Vqisl1HQn6w6O9QIBD9EEHTbDccIwX
         nXGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777946717; x=1778551517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds8VPZ8XGFRCMSYoTIFK4J9AmphYV1vVpSWFXmoaOPI=;
        b=Iu4pHGTEUaOLJwNoK6YkG3q0ITunicSOQ9GLJSqAZshyOtEqzWrx20esi7hYXfWjLS
         Ku7ucBmg80OyUDoA4XpZjPwA2+U33YY71h0OKr1hkn0n0eWGJWPw7vRTo9pNEkeUUy32
         W87BEB2psIcxaVJNpzgC+PUsNMKSKZ56NTumpArcoKSPLlj5tzHG6FrLVoyHjP6Qzfim
         8e6LE7bCXySDpMs23fKlu6L3bUasxX0AhJCPo1b6EAyXhne/WRGl0RwqTGRm9wycbohN
         53MU5QDes5YHyYQSiwfbTdSd4gG0kf/iFWA8IWJXM1lrA4sUmSmmK5DDJHCi/4jXt/ya
         50Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777946717; x=1778551517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ds8VPZ8XGFRCMSYoTIFK4J9AmphYV1vVpSWFXmoaOPI=;
        b=YJwPDTiwqBsuk9MoCKRCgaiEY2sXBez4HOXcY/Fizs4LKJJ/A4vwJGr3+4BbgAlCw9
         J2q1a0keZCBpbrSHkcsXSdVM/UxVxXCuc4wn43TuggDU05ztbc1SME27sNF3wbcSufBG
         gYa6+5KsS0uvQLgwpa+Vkmwx7Y+m6xFIJC2vxmOLe9oRAg0Oc1rUk4kuKXH1C2iHsdEx
         yzNiimSnQrL/5j3cR/HDkFjulYMk4QvwDInacdokN57t6KJsy26Tx4a6fgoN1oeSqCJy
         mbjMnAnYPKseOAiKNZXgNDow4XqAbXkni9RBkwIXfYVT5bY8B9eq/+l09JtyZFcjhvsK
         iGMg==
X-Forwarded-Encrypted: i=1; AFNElJ/RdYDJoWgC6hbenKX1161EKdYkw+LSD1JWPp2IktAf1ewZYPVjXQnEhnqlwrYmXpZvcWczOEdX@vger.kernel.org
X-Gm-Message-State: AOJu0YyG558TxcivPwkZ7jRHULmEundNKDlRFSMOpduMdUDnpfYmSYU+
	O/7uRse99kzYJmcE2fTE6d5IPrmr/fpTAwNw39PtTC7jGPFGeaD7ccENxNL7tfclVtQNKL2Z2f0
	7+OJ4HryxJf5j1PxEVDaGEMSXXTSJb4rUyjG4SdGt
X-Gm-Gg: AeBDies0rSEOLb+7mz8c2bQTyfbr0xkTR9zyuPoSNmZaKy/gHsFNitPiBBAzBRIM00O
	heFSfd0m5xm2mk/b8Ao6m/egFJvR7PCxQav3+24TkejR1mEJo9Z/W9osvTlxIiTZiAvKoGJeErD
	k0R4z74khr+B/46rMZjPxVBbXe9IhBWqjZ3ABHVG0UJsEF5Dtqfk/ErctFWmY2udHxXYUMOAhjT
	chIS+lo0WoPmAAwkkH3lmzGr7/YYyolHfugEX2C1vnJhTYUx384V97RDqb4a+2UAZJtst2VZPR9
	U8p2NKO3CnyDhsHHjCFM2z8hgdmT
X-Received: by 2002:a17:90b:578b:b0:35b:e51a:ec77 with SMTP id
 98e67ed59e1d1-3657747c6b0mr1240269a91.16.1777946717425; Mon, 04 May 2026
 19:05:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503211835.16103-1-dwindsor@gmail.com> <20260503211835.16103-2-dwindsor@gmail.com>
 <CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com>
 <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
 <CAHC9VhQLN5NA_ZMMNyUdMCZVdwC3VM4PUnzka8xDK5rpR2a3sw@mail.gmail.com>
 <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com> <CAHC9VhRx7L1WXYgQvWmGN0a7ssSaDKx4JPhup2E3W161sdp74A@mail.gmail.com>
In-Reply-To: <CAHC9VhRx7L1WXYgQvWmGN0a7ssSaDKx4JPhup2E3W161sdp74A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 May 2026 22:05:04 -0400
X-Gm-Features: AVHnY4IXddbw6Xna7rtOXW0Z3iNQtqb02aaSWmZldIVvVUPK0DOCzTg7J5JMJqs
Message-ID: <CAHC9VhSkBsUDKoQArjyPLTgSfc4GVinphyJmNv=-UwnQp97qCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Song Liu <song@kernel.org>
Cc: David Windsor <dwindsor@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 10:02=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Mon, May 4, 2026 at 7:09=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> > On Tue, May 5, 2026 at 12:42=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > [...]
> > > > > Perhaps I'm simply not seeing it, but is there a check to ensure =
that
> > > > > there is only one BPF LSM calling into security_inode_init_securi=
ty()
> > > > > at any given time?  With the BPF LSM only reserving a single xatt=
r
> > > > > slot, multiple loaded BPF LSM programs providing
> > > > > security_inode_init_security() callbacks will be a problem.
> > > >
> > > > I don't think there is such a check. Also, a single BPF LSM functio=
n
> > > > may call the kfunc multiple times, which is also problematic.
> > > >
> > > > I think we will need to make the default bigger, and also introduce
> > > > some realloc mechanism for the worst case scenario. This should
> > > > work, but the code might be a bit messy.
> > >
> > > Thanks for the clarification, that is what I was afraid of when
> > > looking at the code, but I was hoping I was just missing it.
> > >
> > > Increasing the default is an option, but I don't think we want to
> > > support a dynamic reallocation scheme for the xattr slots, that will
> > > likely get extremely messy with synchronization between the LSM
> > > framework and BPF LSM hook registrations as well as special code to
> > > handle inodes with lifetimes that are disjoint from the BPF LSM
> > > programs ... I suppose there may be a way to do it, but it will surel=
y
> > > be ugly and come at a cost.
> >
> > BPF trampoline already handles all the synchronizations, such as
> > add hook, remove hook, etc. properly. So this is not that hard.
>
> How do you plan to handle the issue of disjoint lifetimes?
>
> > All we really need is to allocate a new array, copy pointers, and free
> > the old array. And we only really need this in the worst case
> > scenarios.
>
> Oh, is that all? :D
>
> Keep in mind that the code must also handle arbitrary ordering of
> LSMs; in other words, you must handle a BPF LSM that isn't at the end
> of the LSM order.  While a BPF LSM at the end of the LSM list is the
> most common, and recommended ordering for the vast majority of users,
> we've been working to make the ordering as generalized as possible.

I just realized I probably wasn't as clear as I should have been ... I
really don't like telling people not to go experiment with things and
play with the code as that feels wrong for many reasons, but I do want
to warn you that if the code to handle this ends up looking like I
think it will, I'm not going to want to support it in the LSM
framework.

--=20
paul-moore.com
