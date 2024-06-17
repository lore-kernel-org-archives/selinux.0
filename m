Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF3C194C6B
	for <selinux@vger.kernel.org>; Mon, 17 Jun 2024 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718625420; cv=none; b=AA76QLY50cV/yPbEY8hPW+Gq8ekJzxCyoS75a8JrbHo71oSuVFAPz+/VYRR9MdQBAS7GKr13nf9UTUKzj2juXDxYmlUbn7Rsruy4xGiyB3TyX/VvBDQHgMBZVQ0ku6P62IUWzEyBwC2cUaq7b7xXkI//+ep5RnWe8VXovIvlLck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718625420; c=relaxed/simple;
	bh=WGjQnzZGGtHPtfLsAVl9XxFpwTc0TLDfHeGIVkgex+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oz8BZI2mMsxa8231STXWigzJ7LDMPl9E6rrbI+cRO3wlda6FaDEAraHsox/ytrCMo+l4wfO/v4mjv7o4X5hkYDjKf23qYtSbmRzz9cL7ChtkiuZJ+Tru+lajJQO+sGeQzI5Glb9FvUzh7OFBZso7eVux0+LPH+JZV5OpL2ECk6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiG1cNMA; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiG1cNMA"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-48c4268adfeso1444310137.1
        for <selinux@vger.kernel.org>; Mon, 17 Jun 2024 04:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718625417; x=1719230217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1EP8vf8OfQwFxreUDLDVHYqMkvqABC9QlsBtlgS0Co=;
        b=BiG1cNMAr8EHVw50XBsnVeqUJzlPl+zWn3wzYofIK++xuF6K5V0bNxgebcq/ZcCr/t
         Sm31pFFXZNKqN8nVQvRVb+vfUtugxRiIoBBota2PcqcqKRVIbZX/0EeOXiqbNc0WufFk
         PQtKZgO82+KazrjACghmLmzbU1F15VxzwXplmKYCI57/lIvAMv4BPVWn0nFMHncO805E
         gOa0Z4dAjoR8jEuTSEzGOYdwPcwukKEvNN93ujZQvfBZtF6hZ/OGQWHSm5OaM5Jsn+3c
         7yWViRWozrp0SfZrRmZdUWz6XcK9kriOGk0b2cPfh2H4HP56vkxAD9bYTpxbQcwHjTBC
         kXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718625417; x=1719230217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1EP8vf8OfQwFxreUDLDVHYqMkvqABC9QlsBtlgS0Co=;
        b=UVevzb9IkLgjLoCZKgCMoA5e/c0PVit54S7bWaS34NK5MThgK/Lh4TBmUAIlS12yeB
         gJqUxYRPdVJLPNuiUCM33ll1+3iMZgRvGfzQWIjgK428vqeMUyPKXAZQz6sSXZGUmx5Z
         JmduCoJrvs/HfdtirjNH8JdQ9sf0/212vRfVBYgydUkPheqHEk7xN3AJ2n0wyAjTxkte
         UT8wj3wts66OmrAXn/yCag9S8h7Zht+MjKyizv7YBTdQFUZjJY5tePVsP0lSVmBsjRX3
         5UQfh7eELOsBxSwyE0X4vSOVa/xxRkKXfM7E+qi19PcDxVKF0kTY/aA03aGziGTyvqj0
         s/eQ==
X-Gm-Message-State: AOJu0YxIym4Ermgb5kRHQ4Dz+vf1sPGizXxhIiRtIgILzs6P3UnsQc1c
	BI16r+Xn1HLV2aKWnvwuIFRYKh67MeNpOza1r2X32WsQ8ZX3a2pab99DlZCtMNls4I6wMkdrjAZ
	4hD8GplYAIO/H/dTNxsddzZIUfOU=
X-Google-Smtp-Source: AGHT+IGTQNb8q1dUNh4XVRYPBoqATergmZcV5oY0dTsL2Zqz5/tFjRto3GgpRW31QCgaefCqk3iy+kdoPufZ8C6mEuQ=
X-Received: by 2002:a05:6102:86:b0:48d:afac:38a6 with SMTP id
 ada2fe7eead31-48dafac39admr8707446137.18.1718625417430; Mon, 17 Jun 2024
 04:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608172025.137795-1-cgoettsche@seltendoof.de>
 <CAP+JOzT35Q70n5zXycWt29VAnm_e4YvMcpscdfWwWYmW5Ur-mw@mail.gmail.com> <CAJ2a_Dd3RNNss36-1i76taciYr_+ssGQVqbFkaMG+gO7jdgpCA@mail.gmail.com>
In-Reply-To: <CAJ2a_Dd3RNNss36-1i76taciYr_+ssGQVqbFkaMG+gO7jdgpCA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 17 Jun 2024 07:56:44 -0400
Message-ID: <CAP+JOzR7yKZxy0mhqcRm_icT_G-_99pcdQ4TU5peg+V6g2HHGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: deprecate security_disable(3)
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 9:34=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Wed, 12 Jun 2024 at 22:43, James Carter <jwcart2@gmail.com> wrote:
> >
> > On Sat, Jun 8, 2024 at 1:20=E2=80=AFPM Christian G=C3=B6ttsche
> > <cgoettsche@seltendoof.de> wrote:
> > >
> > > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >
> > > The runtime disable functionality has been removed in Linux 6.4.  Thu=
s
> > > security_disable(3) will no longer work on these kernels.
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > >  libselinux/include/selinux/selinux.h   | 6 +++++-
> > >  libselinux/man/man3/security_disable.3 | 3 ++-
> > >  2 files changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/libselinux/include/selinux/selinux.h b/libselinux/includ=
e/selinux/selinux.h
> > > index 61c1422b..1318a66a 100644
> > > --- a/libselinux/include/selinux/selinux.h
> > > +++ b/libselinux/include/selinux/selinux.h
> > > @@ -367,7 +367,11 @@ extern int security_deny_unknown(void);
> > >  /* Get the checkreqprot value */
> > >  extern int security_get_checkreqprot(void);
> > >
> > > -/* Disable SELinux at runtime (must be done prior to initial policy =
load). */
> > > +/* Disable SELinux at runtime (must be done prior to initial policy =
load).
> > > +   Unsupported since Linux 6.4. */
> > > +#ifdef __GNUC__
> > > +__attribute__ ((deprecated))
> > > +#endif
> > >  extern int security_disable(void);
> > >
> >
> > This causes the userspace build to fail.
> >
> > load_policy.c:329:17: error: =E2=80=98security_disable=E2=80=99 is depr=
ecated
> > [-Werror=3Ddeprecated-declarations]
> >   329 |                 rc =3D security_disable();
> >       |                 ^~
> > In file included from selinux_internal.h:4,
> >                  from load_policy.c:13:
> >
> > Maybe we should just print a warning message for now until we can
> > remove the internal usage.
>
> Sorry for obviously not build-testing this.
> Printing a warning might be redundant since the kernel already does so.
> Besides adding the two notes (which I guess are o.k.?) we could either
> not annotate security_disable(3) or explicitly ignore the warning in
> load_policy.c (via a pragma).
> Do you have a preference?
>

Using the pragma to ignore the internal usage would be my preference.
Thanks,
Jim

> >
> > Thanks,
> > Jim
> >
> > >  /* Get the policy version number. */
> > > diff --git a/libselinux/man/man3/security_disable.3 b/libselinux/man/=
man3/security_disable.3
> > > index 072923ce..5ad8b778 100644
> > > --- a/libselinux/man/man3/security_disable.3
> > > +++ b/libselinux/man/man3/security_disable.3
> > > @@ -14,7 +14,8 @@ disables the SELinux kernel code, unregisters selin=
uxfs from
> > >  and then unmounts
> > >  .IR /sys/fs/selinux .
> > >  .sp
> > > -This function can only be called at runtime and prior to the initial=
 policy
> > > +This function is only supported on Linux 6.3 and earlier, and can on=
ly be
> > > +called at runtime and prior to the initial policy
> > >  load. After the initial policy load, the SELinux kernel code cannot =
be disabled,
> > >  but only placed in "permissive" mode by using
> > >  .BR security_setenforce(3).
> > > --
> > > 2.45.1
> > >
> > >
