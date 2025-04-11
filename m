Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1CB26FD8A
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 01:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744334519; cv=none; b=MMDgj5tNjAlc7edeR+wLfgcvcejYZuouaJ6BR2YkCBFyVJXGa7NK9x65+9P8J3cpGNBA7dY2Ce+px3cRf35ui96wDkfrUY3nIgPHUAMioOIi49olY8kACkN5uQoUOVRdRMNQhtxywJyvTVhU0M3NfuYcqaUJbK2z+qSAVllzNBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744334519; c=relaxed/simple;
	bh=0W34x8Ck2m4q/Qa+lzOYSRJAJBcw975BtQwXfNHZXj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9Cx8NAjmBayXaBKZTBwfUuJC49a3DKVIVqqMvJgPGwMx2bvLcdCEE+tjSS+7I9iGxqvMCqOVfGSFCzBxwz27NvWNa/yfUI+TF69D6+TsU5T/VVeYRqkwmJrrWTsnAcOW0XxllMseuRUtjs06WOkdHgNa8fkx/Z+MsJL1NzfpO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ShCFN5lc; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ShCFN5lc"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e637edaa652so1128270276.1
        for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 18:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744334517; x=1744939317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDZj3yQ14A5xcIpe7c0DSs5qSG0Hnq5KDdt6cHHAOgY=;
        b=ShCFN5lcBIMD2qx87n80CsrOt1TElZUZ/3xNWFNSnMM5cqtnoJe077KRiCZb52IrlK
         zJi9mQToaJa6+MV1qUj9XtDfrv2wYtKWjgj3DPUmOalhR6t+On0UG9dL+rKLx5unhpLI
         6HPvtfdmARbLxfdux3fGN50TB2+w1T8TvggoVzcadtAkk1UvpqMQkKTeiHsW/vrbu9Pi
         IyKM165CYs2uku3Arc9FJSNJqLVeSHOPra+JgSmziW6UG7M2ZpgfIv37Pcgf04uMVbb0
         9qxHDz0/jaoZqz1fbxNH8TKC88iZwyBYCr4X8/q8uDmEZQm/HsnQXACGVIU+NOm3mG6d
         zufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744334517; x=1744939317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDZj3yQ14A5xcIpe7c0DSs5qSG0Hnq5KDdt6cHHAOgY=;
        b=ABDEiLofc153i4h2BFkblMyb1hdQZwJChLgXiTpgAql88980/TZpdlNKKnQ0xlAoFR
         dUEroxbXqnsN7+n/o7kV73earhdjvBTKPZleCzKiL8wIYwoyJBhJ6Q0U5MxVpXTFee3t
         TKLR9MN5k6Ffqfkxu8MHAV1n5JY1Pq2EwLrsa8/Q2GPnMdKQHG5SpzfWqgWahymz/FTo
         2qUioWjLyZ3P90pbBppkIVc6K+hF0maKrNYFMOanKUp2d3kqv5kyCAYHCzY8atnkzuQi
         YyflzWM9Wj6i6bpNMc7sLNeibDvIuIs6ewYB7/j5s5V/6nh5iRcHGJ0qZ4MxkLJk346u
         0qUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAmoQnv7g1j41T0HRkems8I8P3OMV9kZyyw3XABJo0lxxbPgU5dIcpmaNUvyqbPQng/lVm5LrV@vger.kernel.org
X-Gm-Message-State: AOJu0YwdLbe7GJltoNLmH9g3g0qJ2mNW7WvIfOWa2qRbR+AvBrZCRNHK
	4W19A5XQID6kSzI6pGju1iv1tcZnZBK3NIE2m7MUn6zv5LTdRHSkttI5ubauJ+5DXQBcLAIF9qG
	RWjDN7qHZLeH/aZOCO+8D8l3cW2OssukGV2ct
X-Gm-Gg: ASbGncvtSU+d6XuPD24hPp1aMWXyWhBDAmRKhboDNA9lVp3NkZI05b/7svLKi5Hr/UT
	MbXiODlqxjfJmjYnR1H99LJfBiKOxLy1m8CYtEhELAo415Uoc9D7UQik9iC21yHngIbP85YXAZz
	wuccoKoGzqQ4Ze3+Wcb+2hJg==
X-Google-Smtp-Source: AGHT+IG7WXGp7fnjjFYKUmfliUjJExX03/TYU/y9D8duxhk/OQGZU8sKLSMddfn2XvWf/re46nHpnP9HIJ7dpJxGopo=
X-Received: by 2002:a05:6902:91a:b0:e5a:b05e:4da8 with SMTP id
 3f1490d57ef6-e704e025162mr1839801276.42.1744334517198; Thu, 10 Apr 2025
 18:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-58-paul@paul-moore.com>
 <202504091649.E30A1670@keescook>
In-Reply-To: <202504091649.E30A1670@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Apr 2025 21:21:46 -0400
X-Gm-Features: ATxdqUFV6nml9Pgs1tXUY-RKXULr_XkSZF2rF4yd2I4HaYI1g1tN1bIqwvmlvGI
Message-ID: <CAHC9VhSFGfEJ1-f48hdBMgrXwCMcqxi22ze5WZz1N_yPuFdriQ@mail.gmail.com>
Subject: Re: [RFC PATCH 27/29] lsm: consolidate all of the LSM framework initcalls
To: Kees Cook <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Micah Morton <mortonm@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 7:52=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Wed, Apr 09, 2025 at 02:50:12PM -0400, Paul Moore wrote:
> > The LSM framework itself registers a small number of initcalls, this
> > patch converts these initcalls into the new initcall mechanism.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/inode.c    |  3 +--
> >  security/lsm.h      |  4 ++++
> >  security/lsm_init.c | 14 ++++++++++++--
> >  security/min_addr.c |  5 +++--
> >  4 files changed, 20 insertions(+), 6 deletions(-)

...

> > @@ -503,7 +508,12 @@ early_initcall(security_initcall_early);
> >   */
> >  static int __init security_initcall_core(void)
> >  {
> > -     return lsm_initcall(core);
> > +     int rc_sfs, rc_lsm;
> > +
> > +     rc_sfs =3D securityfs_init();
> > +     rc_lsm =3D lsm_initcall(core);
> > +
> > +     return (rc_sfs ? rc_sfs : rc_lsm);
> >  }
> >  core_initcall(security_initcall_core);
>
> Hrm. Given these aren't really _lsm_ hooks, maybe just leave this out. I
> worry about confusing the lsm inits with the lsm subsystem's core inits.

I'm not too concerned about that, and I do prefer it this way.

> Or we need a new stacking type for "required"? But that seems ... heavy.

So I understand the motivation behind that, but that's a big hard "no"
from me at this point in time ;)

--=20
paul-moore.com
