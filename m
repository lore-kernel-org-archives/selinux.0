Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F1A395AD3
	for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251491; cv=pass; b=l7i3IG6uWrZO1IloqMA+ZRhY15w4WgNwpbaTn0aBatQ4Q49SYt7OZ4CkzI/Ms+fQW/zzm7wEfN4ol3cfxDmE1GvGleq4RaSGzqmyHl93hNmzP0B5bftnxulcXQDuxoa9P3o0dlBxgH4fv2Ep8T5lQfGDueNfdmLx6TnYXt+cLcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251491; c=relaxed/simple;
	bh=1BUl/L18VjoyHto2cVeOh6hrwiaVF2vC8ns+kaLeyMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+pmOm11bEfioDG19a2fWJo2ZzUyG7JRoHk1oDViq3Ry5q/m2RXKjowCMTpwuaab1Ymmf91V+2KdkYuQEPFehZ0Tr77m6yRcX09TBoBH85WirFGsGSt7gufglZrNcX4bgwP/nM5FdnF9RmANWMem6OV2laXZw4EhDOZkSXFFGKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcEQf1Jf; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcEQf1Jf"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d3b440b97aso13375ad.1
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 11:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787251489; cv=none;
        d=google.com; s=arc-20260327;
        b=BUt/DaGiSz04aLs7L7yJZjJwp+Gw578q+BoTtoOnKhAgfTCIsnsJHxBPc/oWEyks7N
         QRt2E74UG9+VuPmSC7AdECr7ftLAE5L1OX8nrG95X9gPUKgXOGDz8Op7qbfeiPhtncrj
         2vdCr/VB6wLfjaiF/NazQ4TaUOscuvyb1EFEv5gmMxDH1/7nbV/v93BL+gLtxyGxs41V
         Nle6rDpnxFzkx9BX6nKRHcuWG22XOT2uzrqIC55lSp2av2dT9aEur7gkIbv6P2iSSQxg
         L7M8dR6OJcqIZ+pJWIqMHYL6TXPHXP+kaHTzdoaDRvUvgahML/6/WLo0ElhBvZtH5s1U
         QmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ra+u2k+WGBbYHMuPstN144hB8VFxEn7aIl8UwdTV5yc=;
        fh=oyeplR8n2+lXKIwHq3PQvwyze8ueIULio10DlOQljsQ=;
        b=FXG2iXxmoMC9r6AzzEGahaDsc9Rd9Gls+ZLoyBcQs6qWFOvcwufI6X9fBB7bjQxNzu
         5bM1K8gNpzzOPL7jRNdaHMucGrmG4E8yCFw3t3tcMlBDd4FGwibUEER3022QAR5Q6tMT
         4nWJrKVzFxZdxVcsc91cDhKfvC50BOIenVXHDHfoo+ud4dWGyKGec7ayBoEiPkqCf1oU
         HC4bdB8Va2yOWBHkrWy5B0ppQnQ8nFKv6YE+K8ccv/TbbuFy+44ewx/O35/4yWaGP/HL
         7MK4mkSuBkbrftXT8g8mJFsl7tOmLbur3gmdYKab0cvu+RpXaHiv/Z6F5fTYjPL1oj9I
         ayfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787251489; x=1787856289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ra+u2k+WGBbYHMuPstN144hB8VFxEn7aIl8UwdTV5yc=;
        b=dcEQf1JfkWtQKZBW2y7hJGbPS0z3rtQhMHHnMumkdEDuG5xKqTTfSFlfpDKJWAvsNo
         GeGUDOCIcKgYORGaZxwEVxUFxnQbEOo1Uk3H3R/2SecKGnktgMIFpXipPoWfiaMOTsZZ
         JOxtqIbtd+PulOvFb+6S13QPQXLZ3miLwBf62Hy6yV5Z/PC9n3C42kdhMrGEZvgLzkxn
         dqi15ns7h9w6ogFAyccb4BSKtizbWBFxP8GbkT7GgFEVFg+CgVSi9rVX8B1PfSmaK71S
         YBeAKX8dHnbmZAC5yO6RjDUH2pXT1eUwiNdkYV3XscblaanNUG2SQp6+uZOV6cgiOEtP
         /E1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787251489; x=1787856289;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ra+u2k+WGBbYHMuPstN144hB8VFxEn7aIl8UwdTV5yc=;
        b=Fcs8+aF00kE7fLW7/v15NK1++EbOpYp/o/V/j8m08F9L/ERy4W+gYL+V4ihhLZ9dZj
         8reiAka2dTIWqumGe/Sp0zjUIrx550EAGHGw1oYVVirQQBl1aUHdrL7jj8X51HpkRS9V
         PG5MR5bWiplZPNvg0v5/SgbnAqj/5gYxE6NSSvStEeiD7UnRIr165xh38366oX37kbeM
         Uj68CNSmBtUxRhiFvEwPXLE9TTLZUkyXsf9Ih+Coid6VQ7x05Q4ihBZx7iUCvfTc34kP
         7A6v4sbFj/KK2VquwRa/v9Ra+37Qq1KZRqP/EmyPtxPSGE7zBlg0wnLZm5BbvimXF/Fz
         R67w==
X-Forwarded-Encrypted: i=1; AHgh+RpyV7NZ3wYb7DP0B8m5nQ/B0/fjB5wLRO+pNXNXmsoj9uM79HsnbK4A8cIzH6M/pJpkB9kqBZek@vger.kernel.org
X-Gm-Message-State: AFuF++lc1yGlcJ9cjRsi7ff5zs96pzfv7hF3D2tRFYr+9U87tyfQkq/T
	vn8ZACsliTJYp1AzQlvfN6Ylfy7VWIIPVgooOhnLBHgLNCqZ4LFSZcHWsrS820uifx4Zlu2Iuui
	PgV5BBq5h/Vuf8/4MK9hBtqmr51l3Y9Pf06epXQpi
X-Gm-Gg: AR+sD11wTYsZYI+K6HpIfaoh62HdPuJ7ak2fUL8hB0x/uOq1dxtarPHTzvjmXpNy8Nq
	0CXmbaU45NtJ5Wx+Aya9uIQt2ATgNpWsyGfUyfbI4PqJCl18clshfD/CcqnJ2zlGDKf0WlmXeV7
	PRaJyZ7tNsr9FJWrOtGS/5EpM6dBmhA6cENIaRNSolwjLOV3R2JYOxqoy9K/145Vo4mwMGhQWNk
	gvYun9gRxc+dkwt+EQETsBzHvUVL4wJkJQBhy/d5C7SU5fL0pKAgbhoUoMdbEWtzMnRkAkdcCUV
	RekDEmlUfuKyRj2O9GCi4RKtizBlMPq7M5bMetmc8ULRdFAd45n1P7J2jcMCeqSSveBZILrwCWH
	xSDJ2vc7zKW7sPJAleeK/KL07NayVJw==
X-Received: by 2002:a17:903:22c7:b0:2ca:cbe5:c3af with SMTP id
 d9443c01a7336-2d64b50af9cmr824745ad.7.1787251488719; Thu, 20 Aug 2026
 11:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
In-Reply-To: <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 20 Aug 2026 20:44:12 +0200
X-Gm-Features: AcwNN1WPc46lB25I9dlQYQePR9UcO75mKPz3cBjmzriG3esMrA3mvmTFFADdtWE
Message-ID: <CAG48ez2Ngo3=VtyykXY6ynVzGwA8px-p4zV3V6U=YfgV-Hy4BA@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 7:22=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
> On 8/18/26 21:51, Jann Horn wrote:
> > If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently hav=
e no
> > good opportunity to block a process from overwriting read-only code in =
its
> > own address space through FOLL_FORCE writes via /proc/self/mem.
> > The security_ptrace_access_check() LSM hook is bypassed when a process
> > opens /proc/self/mem because this is considered "introspection".
> >
> > This causes a hole in SELinux EXECMEM enforcement, which tries to ensur=
e
> > that a process cannot create executable anonymous pages.
> >
> > PROC_MEM_FORCE_PTRACE prevents that and ensures that such FOLL_FORCE
> > accesses are only possible when the LSM allows ptrace() attachment; but=
 it
> > is unclear how quickly PROC_MEM_FORCE_PTRACE can be deployed in
> > environments running lots of third-party code, such as Android.
> >
> > So, introduce a new LSM hook that can forbid FOLL_FORCE specifically fo=
r
> > such "introspective" accesses.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  fs/proc/base.c                |  6 ++++++
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  6 ++++++
> >  security/security.c           | 15 +++++++++++++++
> >  4 files changed, 28 insertions(+)
> >
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index bec6197329dc..3dfaef49bb70 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -851,6 +851,8 @@ static int __mem_open(struct inode *inode, struct f=
ile *file, unsigned int mode)
> >  /* private_data for proc_mem_operations */
> >  struct mem_private {
> >       struct mm_struct *mm;
> > +     /* Was the ptrace access check bypassed due to introspection? */
> > +     bool introspection;
> >  };
> >
> >  static int mem_open(struct inode *inode, struct file *file)
> > @@ -864,12 +866,14 @@ static int mem_open(struct inode *inode, struct f=
ile *file)
> >       priv->mm =3D proc_mem_open(inode, PTRACE_MODE_ATTACH);
> >       if (IS_ERR_OR_NULL(priv->mm))
> >               return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> > +     priv->introspection =3D priv->mm =3D=3D current->mm;
>
> Is the feat that the fd could be passed to someone else that would then n=
ot be
> detected as introspection?

Yes, exactly, that's the primary reason why I did it this way.
