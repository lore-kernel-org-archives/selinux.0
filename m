Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A14C364940
	for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248655; cv=pass; b=NAaEzDUOrLNBrPdfXy6lGnSn98hifbEVoLFqU+traXa+FMpuVkZ0dEKr6orTJlJdXg6pLbDXuG491dKL1jkDQPGmKxLO1h2ITyvCvXGxYM4KEwqcw4i7e5HC/HQgCqgMwJ+zOWvruNqB/gUThd1+VTgiyg7Ia/NzYUdzQ5oFddc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248655; c=relaxed/simple;
	bh=iC1e0mbaJifPmCbBJf/VjTw290bibhF8MwosDGlJfEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mhc57+qEsFLFffN1ULsxUh5g+ZARs8QCvS9UMaMXACh146E71X4a8DOdDjJ5G78Gj7wO3lB8o9E2s6uNEzcZFTHHTaR3mY76uAHpy9dPqyKD8xyWHnr7o3bmDqShbgT1R2s5CckHk44WEEsXPurJpT2jr1CzhQncBAffODGqVjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Ub2ihFP5; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ub2ihFP5"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab19127so2260420d50.1
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 04:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790248653; cv=none;
        d=google.com; s=arc-20260327;
        b=KZTLi6ONcR1Q6O5AJBwe9BbrM+d/uUvmeqwLEw1JedhAMToR+W/k5UmkZqXAbBDmIO
         /RK8xrXNtPU6cOAA5FUx//8+4NXDJ5eJB+LU7c4b2IAPrHS/Xdcj6SBq3O2Yv6ByD539
         c8+hhSaU9mlASGdzjxlYOeESevPnltxw4Hn1X7Ypm9q2D4RohYsINmFikXo/biDC+m3o
         vJGt0hq7YC6Wp+2M/vodz233u5WAe5gpD2NmtkQxyLMfYVVeNlqYzzvbU+za2hnSMbkf
         Scz4xzEEYJY7gsXCarPaBVInPFPDQnUkLoa/favEtohB55WBJe6YxQGrmAyj5VBmP00p
         w2Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iC1e0mbaJifPmCbBJf/VjTw290bibhF8MwosDGlJfEY=;
        fh=DMHm+XdAmbCOr4HC02+7+6ToBTjP1Qp6AkA5cYLDx+Y=;
        b=RsvjbVSgWqrLl/r73M92ZP0ND/lHabBWh1xGc/001ULbPtdWPHK3UrwgfC+rT5Ih41
         71aaaTgW4YVFyLbi8LosplxK4Zfp78B298EEYDDlnEiev3TaMEnv1RYhhftsilgHE0YV
         PT+fthznvayGj4EdWM8u+9FEDPAbIPBj8hW8oFY0yWE8nmI7wiTy6xK4T24sTzxhg22v
         ND3tPYxKgxBxaMDEVKZm6SGp9SZsSsvuOl18GS7To4HkblZy/1F9hRnzARthGSGq2O5o
         TN4rH3bgj3yM4gXAmDgf+s2mf7PIrNsQy8N4w947pGrjB7BN0IFZRmNHD4bQSdyzzI9K
         ylLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1790248653; x=1790853453; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iC1e0mbaJifPmCbBJf/VjTw290bibhF8MwosDGlJfEY=;
        b=Ub2ihFP5nlguwKNPEoos+eO6yGeu2nSgdGTN9IMmsNQryS4b5FHLArT4+U2JQuvDlY
         tT2yRQrmkgmYSo2F5VTDmbvfYnQ3Jb1KUoSHqtMEFAUjQ6RYejczmDUyLRW/9C8ZrGul
         LcRV1AifH21FrWtWRB0wxGD3COj/vPDRyaXLsfpbtihgkqj+d9a8Tff9H6eIWC+fQ6Lg
         WrJmBxcIcFPExt+s4MppjS4D1nAYPUN6cFZIzVkaESOzNHGuBhHKhfWbYWiJwYLacsD0
         04fSeuCEW/sbxMkcrh5FVF6X+vMDFtrDpnPz5MpaE2hUDVboG+eNxhRd7GczB+dwa5fR
         WyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790248653; x=1790853453;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iC1e0mbaJifPmCbBJf/VjTw290bibhF8MwosDGlJfEY=;
        b=Gsq3KbzcCvBkvCbb+ikCObombnpzi82NM5gZWxNkq1HoNrEXnL4SqfEUy/c8Jc5csy
         3JnBwjbsDO8ad+dPJOYMOGCb+UbH4D2bDWvNJdVkYklvR5Add4HsRMIDCBojh/3mKgZC
         vicBSVM0mAvr9/GnPzYL3AQU3b3q/8LwD+flX+tsUJtonBk6N4Yzd6SIjoANZgY4YuUG
         wc1MUy2Qq/gLkXArTtLQ1MkHCWprrfCZNsOa/lPrEaxogUC4LVceI4mvQRX/eAWU6kPr
         cV9qj3MfQ4T5GcibQYVmz1soZQsZjTi2GFwPRDxbvC5fxZh/7C4GPz31WZ3weU7iDuSe
         qOIw==
X-Gm-Message-State: AFuF++mlVGHYrtgcLD7zO85O9akxC2+0PrIJsgRXFuJMO1jZJeq0rMTV
	rn2uJr2IPGAqv1q2RHK+rYgW/QYOCmYMJGOGpRoxUNYClCuiRof2ouSxy/TEPyc9U+zVFG4L5gj
	x5rYOm57U0/oOM2Cw6E4so1FggOKMylM=
X-Gm-Gg: AYBFou3FNyTDslvDEd81jlL4cBGvd0bVwr6CVX2B7y9/WnJ54Jz9S8tY63kiJ6bqSm2
	78paw0JWv/AM9inyRc507jrlFlnsOejfNtivulj2Qcu+dhhV0zYUawd2UZKFN8fx4JW0OcstCJh
	NLNFtK8JCS0bYmAQKYeDEN2dAYx3coHeybP4+T30xAbgnMgK+VZyjsfKDhFxH7eapaCuek+/bEM
	mbgMBO2/P1mdwI/i2ZNVDrYhLxXfmf3uGUlH52/0gVrHjxb97wNakMJ3oarvmySvUibbygRmXxG
	0GHEOWcB0pUw1yjXF0pf1F8h9FR/WIYwZ86xw56crmOi7/x7ewTccGmOnJ06vEVl/SjGsQ==
X-Received: by 2002:a05:690e:14cf:b0:66d:1131:b81d with SMTP id
 956f58d0204a3-672ed1deeaamr1199652d50.29.1790248653290; Thu, 24 Sep 2026
 04:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923101323.2996793-1-cgoettsche@seltendoof.de> <CAEjxPJ6DQ+W6OvRhO50D3G4oq_VoMoZ=-tK8FAHe-6tJwCJ4qA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6DQ+W6OvRhO50D3G4oq_VoMoZ=-tK8FAHe-6tJwCJ4qA@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Thu, 24 Sep 2026 13:17:22 +0200
X-Gm-Features: AclHuK8sCMO6qWd67k7fX8GOE1_oiAlhJrwQb_BhkTxDs8MlQZCIlqnZRVb7JZ0
Message-ID: <CAJ2a_DfaWSJU_faubjtY7v84E7PJyYNDE8maCXhuAexR6n06oA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: fix data race on AVC latest_notif
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>, syzbot+a7f7cb0737bd91aa698c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Sept 2026 at 15:21, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Sep 23, 2026 at 6:13=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > avc_policy_seqno() reads latest_notif without holding notif_lock, while
> > avc_latest_notif_update() can update it under that lock. KCSAN reports
> > these concurrent accesses during policy boolean updates and permission
> > checks.
> >
> > Use READ_ONCE() for the lockless read and WRITE_ONCE() for the update.
> > The spinlock continues to serialize the comparison and update against
> > other writers. Reads made while holding notif_lock cannot race with a
> > writer and can remain plain accesses.
> >
> > This marks both sides of the intentional concurrent access and constrai=
ns
> > compiler transformations, without suppressing checking with data_race()=
.
> >
> > Fixes: 788e7dd4c22e ("SELinux: Improve read/write performance")
> > Reported-by: syzbot+a7f7cb0737bd91aa698c@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Da7f7cb0737bd91aa698c
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

With this fixed, there is one syzbot report left:
https://syzkaller.appspot.com/bug?extid=3D9b95da55ba5146a60734
For me this seems not at all SELinux related, maybe Paul can correct
the tagged subsystem.
