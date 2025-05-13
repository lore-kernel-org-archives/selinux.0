Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142D21F8676
	for <selinux@vger.kernel.org>; Tue, 13 May 2025 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747170628; cv=none; b=SRmTX3I0Tnmtk6c6ngXrexAn1EnV/FFTWCkQmF9eUdIsJxClOzx140GgctZ8ABc7tq8dFLpGKwJehIm3Tcy005LMVcrk2UyGLlwoKqXk0c7h8Fk1+6oGoDbT2N0m/nKvQHBVWGifteSOuwaoZrCp/P7EJ1VS67pR47MiY6xjzpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747170628; c=relaxed/simple;
	bh=82zEtRLhUQDpsLvYBWZVZquqMGMoaEvNl8BtBzmS4FE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvgEjP1LHGRS2Q2eZRdn2pnb53EfK30L8VCBNvRUzzS0kwy2cZ6tSDB6Nm5/ran6hb+X5OzLE0jUMzXKer2DG+0l79qZG4/EjD+SBnJwTRVmzVdgRetw8DWCkdegrVEgXqnsnzxa8a8sAb9XMyHkQI1MonquPfxF2v9q8Bae/ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EFnQoGNA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFnQoGNA"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5fce6c7598bso3393a12.0
        for <selinux@vger.kernel.org>; Tue, 13 May 2025 14:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747170625; x=1747775425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82zEtRLhUQDpsLvYBWZVZquqMGMoaEvNl8BtBzmS4FE=;
        b=EFnQoGNAHT+HNm/BO6dpQc/hpbe4FHRkl/KBSUQ0dbVLmNf1M/tZoYwwQLKlJ1jvBc
         BAoKLv1G+V1ho4CrIRd74+jJrMhoaNo51UePMRuOJTirDrVCFR1P5CshEmy+NKwJtqx0
         np920pie86rdJPgxpk6p4tZbuA9U9Hk3HT+PUbdMrmbMo61cws7Lkgy0E6uwbxxceQ0j
         2GV8Bm42zgqd3kfTHRyahEojzz7pDLYOXzerYt1Byk37giujpPVNTtziS50YV34crund
         VDcILoEmCzogT4/PvpCEabuBfr/OZ12ib9FqUHMCQUC8LxnPUgrr6KSUUxIeVk26SyCp
         YHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747170625; x=1747775425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82zEtRLhUQDpsLvYBWZVZquqMGMoaEvNl8BtBzmS4FE=;
        b=mdXzyBiaTvMnrl8MjVWQAoeKeus+z16k9bl9/m07jRqdjDNJXwZZf+t2ycYDGV6IF5
         8/MUa9Zntq4wuhbQclajEqC8UbNY5ag/m/SduS2r2aZkGoAFibIIQb03nV5XOIBv4TYG
         FO5Y0dMrugDwgHnZ192aS48pJTCM0G44cXHwgzrraMvFpzFOX/VS5hdmqvwDgMv4ydb9
         ilNZd9/cWCfBjMxXK5LRgd6Lea1IrhgfMHMg7G3+6dIa6IzWbJYAoykTEDpBBYo2V+Sa
         evZgvlrHo3AsKlR9DntkGM1d0LHr9zNXmaspKun87Skw+CDigSYrf957IoIW/gDhdis/
         8xZA==
X-Forwarded-Encrypted: i=1; AJvYcCWj0hJn3CwV6RIULlQ0pEaE0t7+KIhP6k0EVTpRMWTlIdU3XHDsH0VNeBAShPVC+q8Hd7qiLVCv@vger.kernel.org
X-Gm-Message-State: AOJu0YwvfeOM7oHwEb0eKAxNjI+Xej8NkiaGtyvlyZ7FeJWhBS+0Dwsa
	WbtCgr3KMOwf3Yxj0SCzofromSeGDgBmslHPZOzAzUEspguCkKeErgqvwYHqOWWTDBIpMxZvjp9
	nIrqIWIvFcvPBy+pQYKwcgYw840jNeJlJvnvTCjAl
X-Gm-Gg: ASbGncuNqzctgxBjbYd6RPkG7cz1uS/zRByfs8tsZVyONurqH1rLZ5nVPUwVnC85N2O
	uM/osi3RDTLh2EXhR9rEm+mNDpKdttfh8cMyY2zvjt72B8J0i4R7+UjFIanyg6fU0Ym4ou6aael
	QyoIvRaEkP/5e5LhBGFoWwZNHXGfEIPcHrmTTj0osUdygDISaxC73Ljaj62AdC
X-Google-Smtp-Source: AGHT+IFFvoW0vaiQwXwOuLU8KHoNjqrz7yUskjzEQxJboJ77uRfEnj6qF+F1/xO6hcdFFQqM32ILfLKZ8071TJJxbuw=
X-Received: by 2002:a50:ed16:0:b0:5fd:6065:7bbc with SMTP id
 4fb4d7f45d1cf-5ff97e27b24mr28177a12.0.1747170624943; Tue, 13 May 2025
 14:10:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221006082735.1321612-1-keescook@chromium.org>
 <20221006082735.1321612-2-keescook@chromium.org> <20221006090506.paqjf537cox7lqrq@wittgenstein>
 <CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com>
 <86CE201B-5632-4BB7-BCF6-7CB2C2895409@chromium.org> <h65sagivix3zbrppthcobnysgnlrnql5shiu65xyg7ust6mc54@cliutza66zve>
 <D03AE210-6874-43B6-B917-80CD259AE2AC@kernel.org>
In-Reply-To: <D03AE210-6874-43B6-B917-80CD259AE2AC@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 13 May 2025 23:09:48 +0200
X-Gm-Features: AX0GCFvSGCrl8jRaWXokLgXy6n507r0H59ZuhYg2-C-s2mYQog1RTVhArK8PEPE
Message-ID: <CAG48ez0aP8LaGppy6Yon7xcFbQa1=CM-HXSZChvXYV2VJZ8y7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
To: Kees Cook <kees@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Kees Cook <keescook@chromium.org>, 
	Christian Brauner <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Jorge Merlino <jorge.merlino@canonical.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Eric Paris <eparis@parisplace.org>, Richard Haines <richard_c_haines@btinternet.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Todd Kjos <tkjos@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Prashanth Prahlad <pprahlad@redhat.com>, 
	Micah Morton <mortonm@chromium.org>, Fenghua Yu <fenghua.yu@intel.com>, 
	Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-hardening@vger.kernel.org, oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 10:57=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On May 13, 2025 6:05:45 AM PDT, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >Here is my proposal: *deny* exec of suid/sgid binaries if fs_struct is
> >shared. This will have to be checked for after the execing proc becomes
> >single-threaded ofc.
>
> Unfortunately the above Chrome helper is setuid and uses CLONE_FS.

Chrome first launches a setuid helper, and then the setuid helper does
CLONE_FS. Mateusz's proposal would not impact this usecase.

Mateusz is proposing to block the case where a process first does
CLONE_FS, and *then* one of the processes sharing the fs_struct does a
setuid execve(). Linux already downgrades such an execve() to be
non-setuid, which probably means anyone trying to do this will get
hard-to-understand problems. Mateusz' proposal would just turn this
hard-to-debug edgecase, which already doesn't really work, into a
clean error; I think that is a nice improvement even just from the
UAPI standpoint.

If this change makes it possible to clean up the kernel code a bit, even be=
tter.
