Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFBF848E
	for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720633699; cv=none; b=rJ3dBiNb9TZFZPLyLK+7xMcMJ9NzR10TE3DRq40SJ9w0tzZpkVkcSGO5kF7EE8WuIFclGL+lKAxOqJv4VdV0GRGQppTUbTAS0Nh4DXUobOKIpm3e7vOqOMJPACX/ZTEMylqJg9zEj+B8bLxCtqMjxz8icugxeO8k5WhRsJ1/Uts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720633699; c=relaxed/simple;
	bh=FUlPPz3uZfjH6WI5a2gPI+SiY7y7BqxirjJxe7umn7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l75KOfD8SeEHK7BgqXahRx38SBzZDxddtiW9tNzw9Z5QxVnphox09jddcs2H3SEGeifWIaXI+5D4/NmxALPPTM/j9TNIFnq2xXxtvPV2tbkyJMPwx6ZBLd0S0EvF2vFUAVyvhlEuk18yKZlJC8ygcPrLlocbG5L6TZCa+tKw2RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OQA0J01W; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OQA0J01W"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-650cef35de3so126657b3.1
        for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 10:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720633697; x=1721238497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gf29W4pL6r4Ar1NWig+G1vXbiZRND3iKsdxbXClbSTI=;
        b=OQA0J01WaJSs3idUwERCn+vj/iQ8ArT65BPhqfOAuG5EGbL2Ve1Nrt0M+42fzCNNT3
         aCQvCcYTyJ06fuJ4Nbv6fJ0/8fVE/jyaUEZSUhrC4kHaPjjmwjhFkFq5ApTDURdIoRN9
         nia9ppuEWMOyCXCZVLvQ7gARC5IxE7rRgDoVaUNgTl/f/2geGVArS1kLidDaZEFG/JTY
         BxEvxEcehcOVbmK/3xD5qPlNNDq/wQRy2uVt9z2ztRumYDyjxknGBmrD+m7KLmIuo+kQ
         jzdbG392CaFwFTi4emMJ5VGRciY5ZNoefk1ynw01X5DqG3zDSeX16Co1UFf/r6YJct4S
         DUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720633697; x=1721238497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gf29W4pL6r4Ar1NWig+G1vXbiZRND3iKsdxbXClbSTI=;
        b=wbwKVmHp3waQOXJed2ASGIPbsdApqZHu6olNpKVtNlvMu+dwuxne8ifNXwYOe9jOGr
         ucNTe5Y4+OeRycpcOL8mTu9cLXv+zn8Ef3eDVn+AH/NqsQg0zIo64tqbwWmrp7xUOsLE
         Zc33MX9I75I13CpSAKuGAMliZ9ac9d62SDLOn2bx+OLeermk5MuI3tzqkNIUJ+soqpxW
         23YRd7E2ym0gRb3rogPZtMi0NsBYmbewr+V8PQ+eahzU5nF5ilYla3NCNP9mnljJB/ni
         m0esQ7bDYeFhbiIk0l29BjNDCA7KiCTC9z4tbA2q6jNrlS+Rsw0n5hDKz1Y3zc7/NCDE
         /jYg==
X-Forwarded-Encrypted: i=1; AJvYcCUvZo2mhkAQ4uluB7vpH5s2bXg/O4UgDlGGUDguOfIQJ0ELSnH1Tr0KYPJyNaZdXckAUfck6uNRSLvS3pjA9wS30E0L9xoWnQ==
X-Gm-Message-State: AOJu0YyXXA9ZtiwxZjVobI4AtUwENGMI+90Un/6BDWL1nb2h7siRBXw6
	U4WboYknttamd3SStK9hSc1Lnicp2gc0YltRmUnQZ3GtYLginXxAC6pAOsQCSINtbLaO8v6SI65
	rkLhDJxOuKHwjJ8FAuN2e5cZCmMDUobfwMf8x
X-Google-Smtp-Source: AGHT+IHTKWboArCBLCtn1rj420vpTjh/kyJWUjZzRX6sCLpuPLH23OsgK9G2ASSfXGWE+m8HJ9Lz5sz3oGzx8Sj5L3Y=
X-Received: by 2002:a05:690c:648a:b0:64b:14bf:2fcf with SMTP id
 00721157ae682-658ee79084fmr81928177b3.8.1720633697159; Wed, 10 Jul 2024
 10:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710024029.669314-2-paul@paul-moore.com> <20240710.peiDu2aiD1su@digikod.net>
 <CAHC9VhTxz6eFFUBZYJ3kgneRqKMSqaW63cXuQvVs_tt88GU_OA@mail.gmail.com> <cda2665d-34c3-4276-afc6-e79e553b7664@schaufler-ca.com>
In-Reply-To: <cda2665d-34c3-4276-afc6-e79e553b7664@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Jul 2024 13:48:06 -0400
Message-ID: <CAHC9VhQAiCORNL=rYfpvoqBY7AUKZ1c0hkVqKgvDxuEnmRMHZA@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 12:41=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 7/10/2024 9:20 AM, Paul Moore wrote:

...

> > However, I have always thought we should add some better
> > structure/typing to these opaque LSM blobs both to get away from the
> > raw pointer math and add a marginal layer of safety.  I've envisioned
> > doing something like this:
> >
> >   struct lsm_blob_inode {
> >     struct selinux_blob_inode selinux;
> >     struct smack_blob_inode smack;
> >     struct aa_blob_inode apparmor;
> >     ...
> >     struct rcu_head rcu;
> >   }
>
> I have considered doing this as part of the stacking effort for quite
> some time. I've already done it for the lsmblob structure that will repla=
ce
> most uses of the u32 secid in the LSM APIs. I am concerned that there wou=
ld
> be considerable gnashing of teeth over the potential increase in the blob
> sizes for kernels compiled with LSMs that aren't active.

Yes, that's a fair point and something that needs to be considered.

> I have been frantically
> avoiding anything that might slow the stacking effort further. If this wo=
uld
> help moving this along I'll include it in v40.

No, don't worry about this as part of improving the multi-LSM support,
this is something that can be done independently, if at all.

--=20
paul-moore.com
