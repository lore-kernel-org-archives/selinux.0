Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE391946F
	for <selinux@vger.kernel.org>; Sat, 15 Jun 2024 13:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718458486; cv=none; b=Lszq+M5XWdBZGeGb8oSHunT9FmptJ9zgIaNo2ztcOcqorMx+Jz7nMfeXZLI8Nwdyah+1mQdQB/9BB1zyOWpjRwIVFOqOp93YjAWfxCYl4sIkKqroXvRx3XXcRhPi7I/S7vlbt8pigAQHE5iBnd/STm+uCU1WymZ5k9/aST+4t40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718458486; c=relaxed/simple;
	bh=FsM0KWFqBFJXnGtAgPk2n4nknCa7w5Nqt79QYx1m6dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpOSKrMu/BZ6hieOY0MNYIPB+tcEq0LxHEo6zlgs+/Bw63kaSVS11ludKuk1LPvn3J20SoUlrFeO05rFT/Jmfj7kTFJLpVHwFU96yaYnykSW5VzxVaP1k4H8MIQUQ1WGB6MG3qByHqzOJR9W806n0rKfTMbnnvVz9qlFKUpwmQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Jvowfr7y; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Jvowfr7y"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dff13c4cec0so2302839276.2
        for <selinux@vger.kernel.org>; Sat, 15 Jun 2024 06:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1718458483; x=1719063283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrXkFbPGt9QD5XodH2ygM3GjOtpJ01nz/Wrvf3p7D8M=;
        b=Jvowfr7yx3erxnIwal+/DZreXfu5jIcdGHS6kxYkxSesrGXko2tewHicXp+wyZyd90
         B/jMpJ0p7z9sO7nw+Ovn21opkO1cYwl4EspCGT9LKH+tSZEPbuUO4SIhJGmqTQTVTUYZ
         BFtO/5INnZlJK0pcaAB3psWuV14dCdiNavsTDdaL1afr2o17EuPl7gbTLoqbHLytbGll
         GdAeB3SNX0YGlHVwUyKCNvWWLf+EKM/zPpGtPl5e53RSAI0BRNKMC4hdWyzN8GKOCMsm
         VMdx7sOPBJPxdpAB3zOGOB20Qf2HVthwe3IgxABt1oFN4UmCazF3JoVqSiwlnGc+GIkA
         BQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718458483; x=1719063283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OrXkFbPGt9QD5XodH2ygM3GjOtpJ01nz/Wrvf3p7D8M=;
        b=QRtbz21Xyb7WtaiLb3kua5Oq8Dktlf1ZiCijuru+rqTk8v0/QLVlX9aCuOwcIFHrCi
         W2kKe8ox3cqIV/UWLMZ8NePKT8NBgVUXtNC/m6CB/fbkEy9b3fKXtQBTNHsxjbyGukrP
         M/zYF+Igm6tlj5BmwATM73Mr411ZSL4myDl/kQx+VSPhsol1uuiGRAJMRKGq3DR4NXif
         dEo9CLG7ffgHBK0TFk+FbuLaOTbhCyVI8HX4rJNzrg0AauUFf3IbIg789PMHEJCt0anK
         68l4UA+BUT8inDc1jMancNLphduj4Hkx2kvpt8pJ9JJ/x5QbHn5k2o0VftZiBbSvmHy2
         1MNw==
X-Gm-Message-State: AOJu0YxbhldSlUFexfYM7UD1zoPOfdXSLNK5zI5v7PF9vP/sygXNdKQM
	zeHRWV0N/qOE+OoD1t6H3F7HIJzFXu0z24e3kZpQLn56zYvcELavNqwZSqGCEHEahLiXPGSL5aB
	bjgtFV4262qS2TZLgtJSzdjfTYjM=
X-Google-Smtp-Source: AGHT+IG0+OXL/CuTKpR7VNXce8K9JSIQ8T7hoxzlmojFdGbeI4uidXxbbyWbb2+4znbvqdjkVQw9FDH6yTlBPdKamNw=
X-Received: by 2002:a25:aa70:0:b0:deb:cd02:3688 with SMTP id
 3f1490d57ef6-dff154a13d7mr4988139276.48.1718458483529; Sat, 15 Jun 2024
 06:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608172025.137795-1-cgoettsche@seltendoof.de> <CAP+JOzT35Q70n5zXycWt29VAnm_e4YvMcpscdfWwWYmW5Ur-mw@mail.gmail.com>
In-Reply-To: <CAP+JOzT35Q70n5zXycWt29VAnm_e4YvMcpscdfWwWYmW5Ur-mw@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Sat, 15 Jun 2024 15:34:32 +0200
Message-ID: <CAJ2a_Dd3RNNss36-1i76taciYr_+ssGQVqbFkaMG+gO7jdgpCA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: deprecate security_disable(3)
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Jun 2024 at 22:43, James Carter <jwcart2@gmail.com> wrote:
>
> On Sat, Jun 8, 2024 at 1:20=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > The runtime disable functionality has been removed in Linux 6.4.  Thus
> > security_disable(3) will no longer work on these kernels.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  libselinux/include/selinux/selinux.h   | 6 +++++-
> >  libselinux/man/man3/security_disable.3 | 3 ++-
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/=
selinux/selinux.h
> > index 61c1422b..1318a66a 100644
> > --- a/libselinux/include/selinux/selinux.h
> > +++ b/libselinux/include/selinux/selinux.h
> > @@ -367,7 +367,11 @@ extern int security_deny_unknown(void);
> >  /* Get the checkreqprot value */
> >  extern int security_get_checkreqprot(void);
> >
> > -/* Disable SELinux at runtime (must be done prior to initial policy lo=
ad). */
> > +/* Disable SELinux at runtime (must be done prior to initial policy lo=
ad).
> > +   Unsupported since Linux 6.4. */
> > +#ifdef __GNUC__
> > +__attribute__ ((deprecated))
> > +#endif
> >  extern int security_disable(void);
> >
>
> This causes the userspace build to fail.
>
> load_policy.c:329:17: error: =E2=80=98security_disable=E2=80=99 is deprec=
ated
> [-Werror=3Ddeprecated-declarations]
>   329 |                 rc =3D security_disable();
>       |                 ^~
> In file included from selinux_internal.h:4,
>                  from load_policy.c:13:
>
> Maybe we should just print a warning message for now until we can
> remove the internal usage.

Sorry for obviously not build-testing this.
Printing a warning might be redundant since the kernel already does so.
Besides adding the two notes (which I guess are o.k.?) we could either
not annotate security_disable(3) or explicitly ignore the warning in
load_policy.c (via a pragma).
Do you have a preference?

>
> Thanks,
> Jim
>
> >  /* Get the policy version number. */
> > diff --git a/libselinux/man/man3/security_disable.3 b/libselinux/man/ma=
n3/security_disable.3
> > index 072923ce..5ad8b778 100644
> > --- a/libselinux/man/man3/security_disable.3
> > +++ b/libselinux/man/man3/security_disable.3
> > @@ -14,7 +14,8 @@ disables the SELinux kernel code, unregisters selinux=
fs from
> >  and then unmounts
> >  .IR /sys/fs/selinux .
> >  .sp
> > -This function can only be called at runtime and prior to the initial p=
olicy
> > +This function is only supported on Linux 6.3 and earlier, and can only=
 be
> > +called at runtime and prior to the initial policy
> >  load. After the initial policy load, the SELinux kernel code cannot be=
 disabled,
> >  but only placed in "permissive" mode by using
> >  .BR security_setenforce(3).
> > --
> > 2.45.1
> >
> >
