Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB1418E25
	for <selinux@vger.kernel.org>; Fri, 12 Sep 2025 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702104; cv=none; b=eJougb1Ar7o0mVNJvJ4yWYFcdVdOoMdAdOCUg97VLvdY0GvBqJ7kQr4IwWSz54kNialf0SQeml1pQ8a5vIpzwa1IT9ECUDZ8HVzBLMt+JwMl1Hdoq/2DSnR7Rr0wYTUuHhH1tCeDRfFrvkCD3aU9lzYVHtrq6jbVqrwfAvTJ1R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702104; c=relaxed/simple;
	bh=pV2R19qaV2jysxPXVrBQ9GBfZqWmAWst19wBedy0Mrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbZJWhdG80tUvSZ+DCv+553t2PDaonNqwC4Janb51fVP0dyDzIPqFKmw/09Lp3U9gH4Uqe8Ceux2q9HB1YU/0pgOlQyBfQGVRyf59nLuaNv3k7PsCZUDyBtyKtsPB98EqrrL2G3vf7Ua5hSrRjOyjiWdBcUG+Yfjd0Ioud7JJkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aI6HZMlY; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aI6HZMlY"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4cb3367d87so1469457a12.3
        for <selinux@vger.kernel.org>; Fri, 12 Sep 2025 11:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757702102; x=1758306902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmHZtd6KQp7WuseCCLd3Qa9lFH+jQSQPT8tPfioKehE=;
        b=aI6HZMlYfr04LZNcbAdeTkM7lJ86RrZ3kwRXrMFxxhw9fJYkWp2gMc7Dx490f9H/hH
         RxHX42Cj4WyI2eNmSrdzGMkJjJHruou0eAhSx6qMRE3zHaWIc1t41v7Gee2Yzk6hEIc/
         e7dAbxiKL7TgcAk0AcV54qAI/9J03Cm1Tdv3g7jrafAxu1wZqV48HQQQs5r+ufOeNxT2
         xBLu7Q/sKbuvbId+HMxXzwYSlMSp5SWysp/vvWgoSsvfIYmBAxuEfVgJaMtGTqCkQ36u
         uSYikq7UmJY0NYSCkRRaYrRsJLaJVfFbb55c6PN/m1DNpPLZ3HIUTI+Z1abay+b0OPzq
         BKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757702102; x=1758306902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmHZtd6KQp7WuseCCLd3Qa9lFH+jQSQPT8tPfioKehE=;
        b=a32ksF3B+nEaXQNGXGbhyaBdemwdEMIf36fSA21vNE42C6XHgATcDgVTWnZqqu7bMy
         2ju13hiNRVhwfih2soUXQEmSQBkzL/3104j47KEQf4hkJVGU8FxKQPR+9rzm+qql6asZ
         Q7aXjhSR3ml1criQ7QHro0IVwmxW3HvALUaJHACQ6AnxNO9e9bPfrDI+dzjMoSzTCJow
         7RcLVjPHw2GdneWyWj2vpu6ZuCeQXmzsHyExBw/1C2tlTbvHLEIQm6HfT0cqvdRVSjWw
         7DVhmKfus21tJj9v0dnf077ZfGUdK6wJVrfI5PePfGFaouRNcYYeDDPuC3ac9m8x9ueq
         dxHA==
X-Forwarded-Encrypted: i=1; AJvYcCWWrikIm4w6Z4+u1T8aeWGn4WIL1gWHnuLKEtroQl69ycmN3sh0YGmNzXTVTPcIX4wWBdZeptZr@vger.kernel.org
X-Gm-Message-State: AOJu0YxWkzKeyy7pnmo3M4VeGeZkPFFSjiyRFmhup34MLc2zFgcaIs3D
	iRtipusnfbIYuOJR15hpWkNqsXfz4FKERb3749dKjghqzgAvlLRBv/anGPxKxQEPba7eIh6MtHG
	uiWCNe8VOUU9oh8T/wfCOHZLtw3WdyzdukGtrtpAe
X-Gm-Gg: ASbGnctzwVTdiDiVB9pMjoZ5Df4VXYHfQyXQj+EFRVL8jcUMuem89Zffo5ib1FA1Ng6
	FnQp5DWMnt2htkJ15B4Q6L/phifOxdsM1qHWOlpkT6o9SBkX42T6pi2z+8/yavMGCa4RxZehoGg
	ThGIgm8mpJaxGK+gww6w5ypZKuf38lwmLnSuSfValY2jyvkTmZFXmq6Gl19bPWDuwriZelDn7Kq
	7E/c1hnsgp77XXnTA==
X-Google-Smtp-Source: AGHT+IHVvBIvv+adF652tSeSlhbLLZsCbE9ujlK47tNi04pmZ29VtdfvJKQA0YX18CqFTY8U+i+92IXwerec17Tb4I4=
X-Received: by 2002:a17:90b:1dd1:b0:329:d85b:d9ee with SMTP id
 98e67ed59e1d1-32de4f87a6emr4233742a91.23.1757702102616; Fri, 12 Sep 2025
 11:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-67-paul@paul-moore.com>
 <CAHC9VhS3KdVO9n-dgk1qFzTae0i+Oab8atMmt0CAsMEm1D4v5w@mail.gmail.com>
 <bd46c63ebb9eddfcdc8df92fe9f85473416ea8a0.camel@linux.ibm.com>
 <CAHC9VhTJnQ3EggEXwbW5D8xOnb+Z_02yz-Dgb7QiAoArhw1ETg@mail.gmail.com>
 <9f1dd6d30193c82ff36b5665eadc1aec73736017.camel@linux.ibm.com>
 <CAHC9VhQT8X8UDt2ZbKhA8bVcaNj06sVyTLG0+WyevrTVFpJwtA@mail.gmail.com> <f9aceb873648bcc8ba6c07b9b9bd269800f03c14.camel@linux.ibm.com>
In-Reply-To: <f9aceb873648bcc8ba6c07b9b9bd269800f03c14.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 12 Sep 2025 14:34:50 -0400
X-Gm-Features: Ac12FXzYDKy6W7IMrSqJvNKOxHIfXkJDGgBASrRc6LLkJS8LXlomahU9WYQUy8g
Message-ID: <CAHC9VhRAkH3GgZOfZU=fFvh71J1G_NNDKPfOOzS23y3GpRXdBA@mail.gmail.com>
Subject: Re: [PATCH v3 31/34] ima,evm: move initcalls to the LSM framework
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 12:38=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
> On Thu, 2025-09-11 at 15:30 -0400, Paul Moore wrote:
> > On Mon, Sep 8, 2025 at 6:34=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com>=
 wrote:
> > > On Sun, 2025-09-07 at 21:05 -0400, Paul Moore wrote:
> > > > > The "unrelated to IMA/EVM" wording misses the point.  An exceptio=
n was made to
> > > > > load the pre-boot keys onto the .platform keyring in order for IM=
A/EVM to verify
> > > > > the kexec kernel image appended signature.  This exception was su=
bsequently
> > > > > extended to verifying the pesigned kexec kernel image signature. =
 (Other
> > > > > subsystems are abusing the keys on the .platform keyring to verif=
y other
> > > > > signatures.)
> > > > >
> > > > > Instead of saying "unrelated to IMA/EVM", how about saying someth=
ing along the
> > > > > lines of "IMA has a dependency on the platform and machine keyrin=
gs, but this
> > > > > dependency isn't limited to IMA/EVM."
> > > > >
> > > > > Paul, this patch set doesn't apply to cleanly to Linus's tree.  W=
hat is the base
> > > > > commit?
> > > >
> > > > It would have been based on the lsm/dev branch since the LSM tree i=
s
> > > > the target, however, given the scope of the patchset and the fact t=
hat
> > > > it has been several weeks since it was originally posted, I wouldn'=
t
> > > > be surprised it if needs some fuzzing when applied on top of lsm/de=
v
> > > > too.
> > >
> > > Thanks, Paul.  I was able to apply the patches and run some regressio=
n tests.
> >
> > Mimi, I know you already tagged Roberto's patch with a 'Reviewed-by'
> > tag, but I wanted to follow up and see if you were comfortable
> > converting that into an ACK, or if you wanted more time to review
> > Roberto's patch?  No wrong answers, just trying to understand where
> > you are at with this patch.
>
> Please don't convert the Reviewed-by tag quite yet to an Ack.  I'd really=
 like
> to review the entire patch set and do some additional testing.

Yep, no problem, I was waiting on your reply to repost.  I have
limited network connectivity for the next several days, so depending
on how things go I may not be able to get a new revision until next
week sometime.

--=20
paul-moore.com
