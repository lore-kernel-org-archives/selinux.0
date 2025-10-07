Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55F16E863
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759866480; cv=none; b=brQwbOjEZVxPdR96O3nf3Ln4ffitbxCbcAnteC3ZqOKMv5j5NAfXaDpOx570ZxqMQruGZ5X+0DPfo/4iHTfqVunSNCw/SeZQbmvjAgPMZmDe0Iki22/J14B3jyqaN94tjDpcOv+xb3tv12DtWBzpCU+LQNGIB4vA2BpZVufSlqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759866480; c=relaxed/simple;
	bh=JDAyKAAsMzITNo4XBmum5qUhBzE7WFJJxduk69F5uFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRdqYkiGjdbKQYw5/OmTw0NPkVBjh6QvWUdeDO93pImIvwPqB54USjLwdl8mpj+XaLdBA4T4oy0qTUulVlRFAB0xD0QEqtIXjXgSSjHpR6nCKrVCDXy7+rA0uEh0dpXA/OmOwjxCXS6hZzbtf4PxWwxbwMq/hNuLJhpPHLUxUjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVculdkE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVculdkE"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso7689700a91.0
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 12:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759866478; x=1760471278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nY5XvFxOCgWaiSLia25Uc78n6LZsns/kt8U3OtEf0Eg=;
        b=bVculdkEEeINIbJL/JZ9DhI6tTKXbDkn937KDwDGy3mWHIxapO5q6ayc5UaB7Q0Ggu
         6ni8N78GIqBVlgDdgVQvzI8NHXwdSQeoApClEAIEbFqAW3XiC+PAmRhm6KZiDt8jKAOV
         oQB7TCQw/mY+gp/0pSS6PQyLbipPJR2KfL+qzQcaWqtkML+Cf1ymrDAsdne+BGsmhz9t
         a9+Jifg1iuERYW69isn9C9+h1FL/4p3Lh/wsAdOd3fWFnUkSVLX6YgQufTEwk0UHhX0c
         0B/I3m0Fa5RP0o0cH+/wgnPtM/e/Oov9L4/29v/nrH4IhbP3hUre0Whu0pdOwZaeVODd
         i2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759866478; x=1760471278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nY5XvFxOCgWaiSLia25Uc78n6LZsns/kt8U3OtEf0Eg=;
        b=JmFv+gMlaaq+pcQhXIC6p2GnVxC07JV0/+psPJsqLH1b6289nZKyukDeuyGwJJ5X2F
         agjtNo4IY1v9dQjn9fAZLrqSxhoewXqYtTHxBe9tE5pmas+XGUtWjuOpMvlQRzjHfxRC
         N/LFMZuZrgqYPslFOzgPp4Ci2Rm4Sm74WLgIQ24el9kOY/rGp28rC9ULNmHzsa2HfMPw
         jZXZGnm93CRNFYnoiizdGOAoQa0oC1bRy+ts7DqJvZSlbJmTv+5xOncsAr/JfpjHQi1e
         94VH49kLMPAJGqWxAcFjYHIp7AM9U/4IiUVZH36ApPf0Nch97Dgb+hBVbmqYjO0w0vAp
         KH6w==
X-Gm-Message-State: AOJu0Yy6acYgsq1N68Kdrvycjq3cDL3nN/P19r1X/oECzAsn4ZxXfgQs
	EKZrGeumZIha4vRbZ33jrTLmYDsnecZFtQ+KmCNkuVVl+XwUa1gj93iJHDypSKZnp9IVxUI80yw
	O5ju216G3sLAwl0EsnjwQsxu8p7tkt6E=
X-Gm-Gg: ASbGncurNe0OWr1yT0ZL9gJkn7XFBTCxYd+epziwefPkrqpe3dBswEoJCzhRbYwDSeL
	ot2fDonDkuv1vUoQEilkjpIi7b65cll5ewatmnwTC6ne/HMVhnDIYm/KmKJJXYKHkrEEYxSIv4t
	4Des9fnn1wzbKXfnFjEONPkCYryQ80ZcKpqXd9Rk6NgTUme6r9DVwBqn2pv20mRonPsVLYjPdmc
	Kc95rbu6MunHjifyEXGgLhtwaCOJWg=
X-Google-Smtp-Source: AGHT+IGlngMU0rI5tgR6au2ZwtlksqWHIEMy6L1QzGuoPI2Ha9I7kz2O32TR/VEMS2xFCex0JzwXLyDl9WnVmApy0x0=
X-Received: by 2002:a17:90b:1b4c:b0:327:9e88:7714 with SMTP id
 98e67ed59e1d1-33b513ebf89mr825588a91.37.1759866477971; Tue, 07 Oct 2025
 12:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007183552.74330-2-stephen.smalley.work@gmail.com> <CAHC9VhS8e_WBQZu76LUqy0ydqChwxzZZVZviz_UG-GDiOfwEyQ@mail.gmail.com>
In-Reply-To: <CAHC9VhS8e_WBQZu76LUqy0ydqChwxzZZVZviz_UG-GDiOfwEyQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Oct 2025 15:47:46 -0400
X-Gm-Features: AS18NWAjlIV14-gKsf_J0s6EzYRnl4MiccE8FcWdhrKnC55BWI3_t9-dG60_lh4
Message-ID: <CAEjxPJ7GjRQtBq-CcCOj8UnMZDh5Tp-RRkHRckWoDJpJcdPxAA@mail.gmail.com>
Subject: Re: [PATCH v3] selinux-testsuite: Add btrfs support for filesystem tests
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com, 
	Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 3:29=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Tue, Oct 7, 2025 at 2:37=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > From: Richard Haines <richard_c_haines@btinternet.com>
> >
> > This allows btrfs filesystems to be created to support the
> > filesystem mount(2) type calls and the fs_filesystem fsmount(2)
> > type calls.
> >
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  README.md                      | 2 ++
> >  defconfig                      | 5 +++++
> >  tests/Makefile                 | 2 +-
> >  tests/filesystem/Filesystem.pm | 3 +++
> >  tests/filesystem/btrfs         | 1 +
> >  tests/filesystem/test          | 6 ++++++
> >  tests/fs_filesystem/btrfs      | 1 +
> >  tests/fs_filesystem/test       | 6 ++++++
> >  8 files changed, 25 insertions(+), 1 deletion(-)
> >  create mode 120000 tests/filesystem/btrfs
> >  create mode 120000 tests/fs_filesystem/btrfs
>
> ...
>
> > diff --git a/tests/filesystem/btrfs b/tests/filesystem/btrfs
> > new file mode 120000
> > index 0000000..945c9b4
> > --- /dev/null
> > +++ b/tests/filesystem/btrfs
> > @@ -0,0 +1 @@
> > +.
> > \ No newline at end of file
>
> This, and the similar file below, look odd to me.  I only looked very
> quickly, but I don't see any references to these files in the rest of
> this patchset, is their inclusion in this patch a mistake, or am I
> missing something?

These are symlinks - they just look strange in a patch file.
Each tested filesystem type has a corresponding symlink in the
directory that refers to the current directory and gets used to invoke
the test script with a path that indicates the filesystem type. It's
been like that for the other filesystem types for a long time.

>
> > diff --git a/tests/fs_filesystem/btrfs b/tests/fs_filesystem/btrfs
> > new file mode 120000
> > index 0000000..945c9b4
> > --- /dev/null
> > +++ b/tests/fs_filesystem/btrfs
> > @@ -0,0 +1 @@
> > +.
> > \ No newline at end of file
>
> --
> paul-moore.com
