Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29681D6195
	for <selinux@vger.kernel.org>; Mon, 11 Aug 2025 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950633; cv=none; b=axyr/9VTCKyfLivx3426DsqnwcKf1SPAr4rrGoVjzFVbVQAHubLZNP9031DZnMhB78tg4zUlUAfuBeSBhao+cHxHzWA0XlABRfJ0aUc7JK3s9yPE6DuP4/eZEHN0lx+MbG68yFdKnnZFlkebBhrza8e7gAbilcA0orX3eOWoWqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950633; c=relaxed/simple;
	bh=1t2gSAFuBD2pmTHsdNa89BroU/+iTca3RYH3ziKTQkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYkNu9nmI/yX361xC4F9KKJ/4mwji6Jq38bkUxx5ZC5GvrZg4h1HWbizW3REMxePHzR6bLpL1fLaumw30PDQLlYFohwX8WpepRzzZFkCOXyJ1s8ezyQ3i36c3A4F4QdKvRptisk3hnMfIgfjdL/AXj7P97lCQ25ax6bVBUztwFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eecyzQbl; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eecyzQbl"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-321a5d6d301so1264706a91.3
        for <selinux@vger.kernel.org>; Mon, 11 Aug 2025 15:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754950631; x=1755555431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sv7bfonbOtnyi9GXdkuQQycl89N9wubFNFBp3GJPPOY=;
        b=eecyzQblgywX3H6nDiILBZ/VmqpAqdSbeXlx9Y0X/xuh/jqZhGroWVRSdLPsBBYVfa
         L5hijNwFJrJ90qxRufJJ2uwAf0qzqW/B2Lgtqz0PUti7d3cqyFuiokfRzfTimvmQN4xt
         5e5RcBiCnuyao+YrA+it7h10N2XjMcg1JWtEai+kJix5mSB3XsfZs1/cw3VBZmtXJ/XW
         qKU0AwolcmMThpzU2ZkjoiY0YoXfIdxLNYvLUuZAOaov8Re6M5wCt8vwB4pvXVup8ggy
         6u0NqTGHiNPDIoTwTQNHGtz9Sn5dxvU18p/epeN0ZYuROcEjKRaLyy2q9b6OTsa6fS7Z
         Pw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950631; x=1755555431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sv7bfonbOtnyi9GXdkuQQycl89N9wubFNFBp3GJPPOY=;
        b=mJSgEi1IS/k8Ra8VxcNh6emLzGbYuSZmFx8K/LSw86FZfYbyXkvh++odApyDp7blc2
         2zwrsdAcNGPrFTeSLLoPw/wmQp+DPKgp30Ry9HL9mHBI3Sigq+VBX4liBOoYtsbUnBDG
         P6LA4ygaekeqkB12Hjmz4WIrp+PyVNY7k56ipIvHtG0a4jKAlkeqkZnyrAXbYA1V2ONQ
         n+I952diqj8HY5qWeGQ3f3RSGracwKsIJfPV44NO6P5ugCWRlEt5LfplO3FWthNDBfOd
         ysXdSFWp0oHQlOUkXDS1lqXzhOOuNkvNBAGA5+kog3uU6urmouVsDpEvOys85xCEZtUb
         Xnkw==
X-Forwarded-Encrypted: i=1; AJvYcCXhfH5u/GyBBVfV0+b6I9eHLGc7FILxGZ64+z7GXuCgFujGaXKYmMZCBOHByrWzDZd8XF3Sfsdp@vger.kernel.org
X-Gm-Message-State: AOJu0YyoddaZoa4D1LiuW2y18K7xVtKHx05zlxiZJaqrTvHQ8Z0x5ZWC
	5eTQpWrRQR/OC5Kfhx5tXQ67pPQ6CFPRKB/QzWEBvudQjh9wFBH5nEguV8uotppTy+fEbiefoA6
	lZQnwGw/qsygZ3eYYbIJK4gC9UWm6KYqe7+PRvMSB
X-Gm-Gg: ASbGnctQBc8bL1/QEotBCjJwC0lTiv5SX9GsJ5EH9J2DjCbv3Dzl6U1R3Z9Gr8Q/eJn
	mz5Ak2sO1aqpz24f89zT4SAiZzTECiykMYEBGdwJMgZRMdUfOyv4zmkxmQ4+e9y0k1MtPLrPUfV
	GkbiaNBMVEbeZ+R1s7efSiBalddWuVmvRaCEOAxjqQm5vsAy2n9Sy0zNKX/ow/F0dIRqm2Z2gft
	wMiNMY=
X-Google-Smtp-Source: AGHT+IFwFEBMYcuh4oMcdsq/fHgVqQT9Tc8p5Bbo9xtS2j8tV/hcAwRwQa/i5ZfaQKMacfbgAwKozV5H4uA2yniz+B8=
X-Received: by 2002:a17:90b:3910:b0:321:2160:bf72 with SMTP id
 98e67ed59e1d1-321839d3f14mr20936515a91.7.1754950630749; Mon, 11 Aug 2025
 15:17:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722212139.1666060-1-bboscaccy@linux.microsoft.com>
 <8d6e0d9d4bb99481d01500a7211e5119@paul-moore.com> <87pld788yu.fsf@microsoft.com>
 <CAHC9VhTPrrgRh7v-H7qpizbxHNcW-V1qj-=24+Z8at2w4Co4uw@mail.gmail.com>
In-Reply-To: <CAHC9VhTPrrgRh7v-H7qpizbxHNcW-V1qj-=24+Z8at2w4Co4uw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 Aug 2025 18:16:58 -0400
X-Gm-Features: Ac12FXyuWYLohIYpJotYXh5r2pfwoxJNS_CY_qqw-DoJKGoTJNQfJaZ4ATHiamo
Message-ID: <CAHC9VhTWZ1McpFoqhsez+pm7LFSdsF77S6fx0iM9hVc3jOxS3Q@mail.gmail.com>
Subject: Re: [PATCH v2] lsm,selinux: Add LSM blob support for BPF objects
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 1:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Thu, Aug 7, 2025 at 11:09=E2=80=AFAM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
> > Paul Moore <paul@paul-moore.com> writes:
> >
> > > On Jul 22, 2025 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote=
:
> > >>
> > >> This patch introduces LSM blob support for BPF maps, programs, and
> > >> tokens to enable LSM stacking and multiplexing of LSM modules that
> > >> govern BPF objects. Additionally, the existing BPF hooks used by
> > >> SELinux have been updated to utilize the new blob infrastructure,
> > >> removing the assumption of exclusive ownership of the security
> > >> pointer.
> > >>
> > >> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> > >> ---
> > >> v2:
> > >> - Use lsm_blob_alloc
> > >> - Remove unneded null check
> > >> - ifdef guard bpf alloc helpers
> > >> ---
> > >>  include/linux/lsm_hooks.h         |  3 ++
> > >>  security/security.c               | 86 ++++++++++++++++++++++++++++=
+--
> > >>  security/selinux/hooks.c          | 56 ++++----------------
> > >>  security/selinux/include/objsec.h | 17 ++++++
> > >>  4 files changed, 113 insertions(+), 49 deletions(-)
> > >
> > > This looks good to me, one nit/question below ...
> > >
> > >> @@ -5684,7 +5731,16 @@ int security_bpf_prog(struct bpf_prog *prog)
> > >>  int security_bpf_map_create(struct bpf_map *map, union bpf_attr *at=
tr,
> > >>                          struct bpf_token *token, bool kernel)
> > >>  {
> > >> -    return call_int_hook(bpf_map_create, map, attr, token, kernel);
> > >> +    int rc =3D 0;
> > >
> > > I understand the motivation behind initializing @rc to zero, but to b=
e
> > > honest it is redundant and will surely result in a follow on patch fr=
om
> > > someone to remove the initialization.
> > >
> > > Do you have any objection to me removing the initialization during th=
e
> > > merge?  This would obviously apply to the other two as well.
> > >
> >
> > No objections on my end. Thanks.
>
> Okay, merged to lsm/dev-staging with plans to move it to lsm/dev once
> the merge window closes.

Now merged into lsm/dev, thanks!

--=20
paul-moore.com
