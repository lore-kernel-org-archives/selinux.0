Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64537185949
	for <selinux@vger.kernel.org>; Fri, 13 Dec 2024 22:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128300; cv=none; b=VGDB173JZwU9lfUKoDZ6qeDjC3FkAubtEwZsq9+h+BPiv25RkCqLGuP1J5mF+nyfL+qg9nW0p7HdMIrzYDiWsyGYsytOp5XxRODDAufyVcnCmWpmwXh3cftdCBc6W3UjcJk3nO5G48XDS9wZng6fbzWjr4OiQTNZ2XBoNhgLzeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128300; c=relaxed/simple;
	bh=xtqRxBTJHmJaUXy5R/4swYGNg6ruYMLcY1OffP6TbxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D34FBVG9u10FUOeLhGGIoe4OctQwRSiRVajxU4QoOlIpF0XnVycuANDyfhb9fH+OihzD3DpZBikiA1ceF73n87HQzslS9hyxac4MPqISuqq+fMoh8AVeNmYPqfqlGvkG/2Txq0Ip0pe1eCDaZSBXb/3N5BAJkqQhn6hrZ2Wu77s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LiP0KqM5; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LiP0KqM5"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e39fb8548e2so1569282276.3
        for <selinux@vger.kernel.org>; Fri, 13 Dec 2024 14:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734128296; x=1734733096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bv/b25gVOUG5Oyb6GNJio9Wgg0bVBvq3pEzsy35+P5M=;
        b=LiP0KqM5H/apFcl1PQ3ie+fIMSLwo2ippC6dRjNA+ExVG2pxOUcPI8XO0QVjFfTd4Y
         g7QB+Sz0mFYunAJK7HbvCe4iItiTXvwJo7whTeg6scpbLRyqmWr/sRkSZMUxAP0wnoFq
         niUjhKff73pWgRt/eYr+0TXON4UZSWOCofx1D4WJiHo64cXyuOEuaQJwnEP2I4iduA2F
         n+wgV9Yq5FzAzZEODw5wfkP8ihwtbAMEC74gFbuRZlwLhkq8KlNd5004Nj/Icq/4tZaa
         2bw45XaWFZtNbhpkutF0HZwKBVuyXf240S2E7x8rcr1DWAdNC+kzQPPKhCFOa/sAN/5j
         /5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128296; x=1734733096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bv/b25gVOUG5Oyb6GNJio9Wgg0bVBvq3pEzsy35+P5M=;
        b=BD7/n37Fw4avyed1BlckO4sprJaf4Vm6oQ6oXdA5RXGkhZj5vaL118eiWHwHnwBQHD
         IjYh31SwlT9EvHI8Yt6gGr4L6CLP2bQQW6rGN9wHOt6Qb/L6W2+Gr0f/wHe2LGbx2dIu
         Axhy9qbxLRksISg8OhlwyLLo56kpjrNm4WOPGNamq/Sq5Jw6kPM3ncS7VwToQy3FlOWo
         8wu+1zljDI+UP5agHAIgxN5aBCY92ysaGXuoZpHwmj8kGWq2OykbkECc1iUzDW5Oa3cN
         oPjHNvfxjyPMsG9DPzaM38HJlCBFYJgEKsPM1MCCi/N+eDLeazKDcWAJNJ15xPZvaQcw
         KTcw==
X-Forwarded-Encrypted: i=1; AJvYcCVpp+R/I4MBPMgbavCQmO9izV3vnocRiABUMteGnLODuW6rie2b6SGBiXwayCl77wjgVKF1tlTO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1X/VuaznQnGMwgh9ji2XRvWsU3XkeMNHZLlxQlo9HTkKDTs36
	ALFHtRKVPqTU+mm9FfZXDGMkJZgytiTKEOXkuhABU7lTRXhs8dIINgdB1lZ0TQ9FCf02j8meran
	bFOS+eV7bSqxMJTkhQLkG8o6oFO/ueE60uQ+A
X-Gm-Gg: ASbGnctbbsz13spWt9QgkI/jvQHJBLoc0wPBwqby96xxKbItNg4URNx8w/sQiQ/2gGD
	IS0XmE4cg8krzYRqAtbEXr3pIoUFL90mrAFTM
X-Google-Smtp-Source: AGHT+IEIvZaN/yqHbz0I33TeeQrkqHFU7+1slWRampxrE1HaYXHUkKCaIBmDv/EK7yvSxErp0BEtNyu8dgc7EcmI/X8=
X-Received: by 2002:a05:6902:f88:b0:e38:8749:815e with SMTP id
 3f1490d57ef6-e434b698336mr3697466276.30.1734128296359; Fri, 13 Dec 2024
 14:18:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210115551.1225204-1-takayas@chromium.org>
 <8d8da243506dd9291fa5f02adc7f6142@paul-moore.com> <CAH9xa6ccd51V9fswkRX+xGfXHQog-wJQzB1LvK0pLT3CLYkfsw@mail.gmail.com>
In-Reply-To: <CAH9xa6ccd51V9fswkRX+xGfXHQog-wJQzB1LvK0pLT3CLYkfsw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 13 Dec 2024 17:18:05 -0500
Message-ID: <CAHC9VhQrSGitY_TUAHbds-A8uQmn2TveTUrK-Jcd6quuMPHh1g@mail.gmail.com>
Subject: Re: [PATCH] selinux: support wildcard match in genfscon
To: Takaya Saeki <takayas@chromium.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Junichi <uekawa@chromium.org>, 
	selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 12:26=E2=80=AFAM Takaya Saeki <takayas@chromium.org=
> wrote:
>
> > I would like to hear from the policy and toolchain folks on this idea b=
efore
> > we go too much further with this, but I did take a quick look at the pa=
tch
> > and left my comments below.
>
> Thank you for reviewing this patch. Could you let me know the relevant fo=
lks
> who could provide feedback from the policy and toolchain perspective?

The toolchain people are already on this email as they belong to the
normal selinux@vger mailing list.  From a practical perspective I
believe the policy people are on this mailing list as well, but I just
CC'd the Reference Policy mailing too just in case.

> > > @@ -2193,7 +2223,17 @@ static int genfs_read(struct policydb *p, void=
 *fp)
> > >                       if (!newc)
> > >                               goto out;
> > >
> > > -                     rc =3D str_read(&newc->u.name, GFP_KERNEL, fp, =
len);
> > > +                     if (ebitmap_get_bit(
> > > +                                 &p->policycaps,
> > > +                                 POLICYDB_CAP_GENFS_SECLABEL_WILDCAR=
D))
> > > +                             /* Append a wildcard '*' to make it a w=
ildcard pattern */
> > > +                             rc =3D str_read_with_padding(&newc->u.n=
ame,
> > > +                                                        GFP_KERNEL, =
fp, len,
> > > +                                                        '*');
> > > +                     else
> > > +                             /* Prefix pattern */
> > > +                             rc =3D str_read(&newc->u.name, GFP_KERN=
EL, fp,
> > > +                                           len);
> >
> > More on this below, but it isn't immediately clear to me why we need to
> > have the special handling above, can you help me understand why these
> > changes are necessary?
>
> Sure. Thank you very much for the comments.
>
> > I understand you are "marking" the wildcard entries with a trailing '*'=
, but
> > since we are calling match_wildcard() in __security_genfs_sid(), why no=
t
> > fully embrace the match_wildcard() capabilities...
>
> Currently, genfscon rules perform prefix matching (e.g., `/sys/dev` match=
es
> `/sys/devices`). Directly using `match_wildcard()` would not preserve thi=
s
> behavior, as it does full match. To maintain compatibility with this exis=
ting
> prefix-matching behavior, the trailing '*' is added.

Yes, the existing genfscon handling does prefix matching, likely as an
easy workaround for the lack of wildcard matching, so if we move to
properly supporting wildcard matching, and the policy explicitly opts
into using this new capability, I'd rather just see the policy do the
right thing with wildcards.  It might mean more work to convert the
policy, but this should be easier to understand and more consistent
than silently adding a '*' wildcard at the end of every path when the
path matching supports explicit wildcards anywhere in the path.

--=20
paul-moore.com
