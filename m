Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83013D88F7
	for <selinux@vger.kernel.org>; Wed,  3 Jun 2026 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502898; cv=pass; b=ggx3qTQfDKtA8vR9qp1WUC7dAqtVTcQcAjHS8G6GTQOW3PB0hR1w1s/freuuitV+Yl4FSpNVDClFDBcdXZExEzlT8+RqYxORmmZYpiDzQkKuOgr89k2lRmLh4c1C7qDlq3BWTSadVoTNhfjPji0ACTdXM2DWRWQ8b6MhObk3kNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502898; c=relaxed/simple;
	bh=Yll7NracjDnD3qZ5bpsXwD4DWWPd+0HKvhOaQK593vE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBzAjHNWH3t0TaQ/vrIZrX/hTJbhvpHGkwge8Wj6ItgXsHADRqoWkMI3okUitDMH7va9FYTzsx/H4iFdLuCUoGXKcPyn5TvzHBQggYEaeMpaSFtegnz40vY2yvLGbP3AUUerh6L6UkHqoWJ8bM53y/FV86VYU0BcJRBPh/8hk9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NVJ56p5g; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NVJ56p5g"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36bd175fdbaso3371037a91.0
        for <selinux@vger.kernel.org>; Wed, 03 Jun 2026 09:08:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780502897; cv=none;
        d=google.com; s=arc-20240605;
        b=YiC8BUzDsKo6COyn8txBwZZektqBuD08qzTBXUz2WzyyO9M/rmYz6W+YMWddfvlOW4
         wwaRlXSDAPupROdXbcuVB+ak9knqrHrsknwAtY9CvXPubfda/tOCNKNS+SFWLFD+p8wb
         9S72gduaGzr0pAr1iPQwinunBSSLNUmKbxajnxAkDlXJAAXMp44NqrMU3hA49ijf912Y
         tmaili8DeVknUNWpuJ35LsdhrPsk8KPvGIc3AodkJH60hbgr6o6Hw0p1jRL27eGbbQNT
         Fbl74F7JaXSNtW57HKBiVfdlk1aMqVJ6zy1khCBkYXo1ldfKK8M7kwRhX6goxZqdogOc
         dKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZUiGqlRnZNqGq4+yE88NmBZS3rhSRu/Pwt3j6qQYl/c=;
        fh=fJW02IZeP8dGTV07y5P0TdeWNpF42jiE3Rw6cN/aQ9A=;
        b=ZCDTPc//23ovcwoVvu5Gb5DYfEqMRAwVR7ZAyQRnc7BeS307F3smOQL1907vWfwKhR
         9KXdFuyGj+QC5iNa9de9Yhz6aGkg1NYBhjGfF965dzqjjkOiOe6aLg4bj95i27mpz1Wr
         Yb4B+2i9ihtXZkuIKJ8ULb3SYnjE6Dnm82C86cu9VmabSrfNXIw/SQRubtQNxJRu9slX
         kJmcCXJU0VvH7otUJN/U0HIy3jgqIJSejuUUJ6aH+g56QDi+iLyNKyexjQqhA/NLfB/I
         x9Hi5EjY0UVZVV97ZLxSyxAYnnSbL3YpcZBU01vMqma5CXglnQxOkReMTm9lhahrzEsB
         rBsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780502897; x=1781107697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUiGqlRnZNqGq4+yE88NmBZS3rhSRu/Pwt3j6qQYl/c=;
        b=NVJ56p5gQoFDZSLJsqpnsYKCR/Ja8mpcFSlqdEN/YvxyVHNZzG/g4ZokIjsOON/WNw
         mEAk1qaiZFJywa/3RJ1LAQk0RtafT3mHgqVKu8La+Swn1Sa1pjuaT5zVLKws3v8FP4Fx
         kAVIB4ESY7d6tb4VRjiFWlFAWLCVGP3NceEk7HjMnYRsQK7rAXQickWnSvNtnsDElyXK
         FDOC7YJ5usprHP52e2Lv6IpjKNP0RdrSANU4jR5zpqlk/tjHquxsmF2NBZYAEW5TBLBG
         Dpj1bo7tvgqlGMwVawZW26DNfnBIG1jMc8m4h9BDOeYLRUAph/lMGKwYV6+COn3eb4H7
         1xuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780502897; x=1781107697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZUiGqlRnZNqGq4+yE88NmBZS3rhSRu/Pwt3j6qQYl/c=;
        b=dJLrl5Vae7AGiL1IAsDN++XkvhQt17aO17albN4C4jRWu2kQ+DCXP979obkCfcepZC
         FQbxMNYcjqLnVWdMv36XOCNe+kyut30lig29nQJ9/pyPd0KEUV4Hitbm2j6/SCn6PfFY
         SChoorsthSFh1gZmkmfmeHwZUiMx142dWOcATNRAqBA/Ca7us2VXrmmi5V22iJ6ErJH9
         lZJP6CD4kI8s33jIJL5uOpSOZ3KH4KFb/cRAD3fHNkc9DdqL0tM1EJxAmn6yhnraKJ3E
         P5EaGunuwi8XJPfsMg1zdfB4K/98N93+DLDde0+E+JZqUhNXd0p0vy9JcRkCR8UnV/UX
         ioxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+3RHU2Sc1TBspL7Pb3IQ01MrTm8bgPVpDTXVKMg6kVnqXiPunF4zgXndp9U6HVUo2sEwrWvENR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1/A/ClqLoapXRzR18RsH+Ex1afyUcXw8G8EqrbPRr8ZzYsTSx
	Q01EnMcdckROSt82fYQDAJX2or6kdyUytq1u/DoQSoN0xsay7fRXBpkg2B0CyD+AaTYnp+NcDfD
	hwCpemfXZJDGBxdQ8iQzk6GKFER7W2mQAQ2ZsszbV
X-Gm-Gg: Acq92OFfcBavCyCTOLGLS572zvTmIgJZGDtByOpTnHEgEISnqg1HLUSdopLrcF9AwiB
	JAOe1/QWXOScA8gSJ25oQA+E0wanCWeAazxlhVfcZZf+SMjl7M4ZCGa8H2VaPt7Xa3PNavXvjBo
	8jdot2/ROtGW4CVDmKl9FgW8hBh2uby3MEkIKCSsvWXYDyLcbyE8OF4QPhSYgDVTK4DdehVSXIi
	9lhN+G0+wG6abTBl0l2Esl/eOxri3sgfaUAG0CH0c2MakABaMHJhFtFtQZe6sgQ1pK7423wgN1S
	YeII3JbEBtFvk2Ef8Q==
X-Received: by 2002:a17:90a:d406:b0:36d:bc0d:f789 with SMTP id
 98e67ed59e1d1-36e33105147mr4066598a91.22.1780502897047; Wed, 03 Jun 2026
 09:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531165852.1478916-1-rppt@kernel.org> <CAHC9VhQ9mMhswzmy3745HbXbe_xm0aeJOmTG1PiDHtv1=zTG6A@mail.gmail.com>
 <ah6uXccHdngEUKr8@kernel.org>
In-Reply-To: <ah6uXccHdngEUKr8@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Jun 2026 12:08:04 -0400
X-Gm-Features: AVHnY4LuaYNdNWYLl9EEEaSid6CfsReMM08jS3s_ajY7j8EUVy3NpBhg7BLhw7o
Message-ID: <CAHC9VhSFRyFZSxu0jeA_Wv9bU3MgmEWpQMnzP5Q=vRBXe-m++g@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: hooks: use kmalloc() to allocate path buffer
To: Mike Rapoport <rppt@kernel.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	David Laight <david.laight.linux@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 6:20=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wrot=
e:
> On Mon, Jun 01, 2026 at 02:11:11PM -0400, Paul Moore wrote:
> > On Sun, May 31, 2026 at 12:58=E2=80=AFPM Mike Rapoport <rppt@kernel.org=
> wrote:
> > >
> > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > >
> > > selinux_genfs_get_sid() allocates memory for a path with __get_free_p=
age().
> > >
> > > Such usage does not require a "page" and the size of the buffer shoul=
d
> > > actually be PATH_MAX which may be less than PAGE_SIZE on some
> > > architectures.
> > >
> > > Replace __get_free_page() for allocation of a path buffer with kmallo=
c()
> > > and make it explicit that the buffer size is PATH_MAX.
> > >
> > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > ---
> > > v3:
> > > get the args in the right order
> > >
> > > v2:
> > > * explicitly use kmalloc() with PATH_MAX
> > >
> > >  security/selinux/hooks.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > Considering the problems with the first two versions of this patch I
> > have to ask what sort of testing you've done on this?  I know it's a
> > trivial patch, but we're on v3 ...
>
> Boot of fedora on an arm64 VM with 64K page size kernel.

Given the minimal testing, the problems with the previous versions,
and the fact that we are at -rc6, I'm going to hold this for the next
dev cycle.

--=20
paul-moore.com
