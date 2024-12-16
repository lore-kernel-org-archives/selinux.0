Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3B6F9DA;
	Mon, 16 Dec 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358011; cv=none; b=F5q5picc42avOxg1l2XN/44gzmhVbAWPGOdy1t1rGzh88nc7TNM10rj0qkG4Cl6v3VwMjsBE75Vmsblg61CCXVl6DARc9eomafZnnGhbMMUkQeg4M1VFKBpAVdjUGHe5UqLpOhssq33E2SIWy3PEu96C05aAcN5HNbEG3jBznk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358011; c=relaxed/simple;
	bh=za955f5yytbP6XETn6xT5Fn97sIWB1ARQsMsbId7G1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAjxlp4UiXf5p7dixdkdkMvSxxDfLkG2TcTcH4+1osxsM45dqhT+FwJcF6KKzPWefOQ4cg1pM+/a6e21eLBHdJgkVyQU3Zg2XPh5GJsbZMsBm2INJuqWUuSbdEdIKrWXmzceaGRTkpd4VhVnrdH2kslX1yV9AAV5ZMiC8e3bGDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAEkYxgA; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAEkYxgA"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee76929a98so3002351a91.1;
        Mon, 16 Dec 2024 06:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734358009; x=1734962809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DR+GKpOhUkgjRJRCGj+6G2Ttdso5dJH3Im5WlzUjyiQ=;
        b=IAEkYxgAKJkyenuJrwWqbNWTDtW5xYJxIC6tG40Y1bNkhcigO9RDjGgbEw8brXKxcq
         4A7MW+s0Muc7lqo2oaC6/yjykR/iOkUcnEtRDDEZaKdOaOT0ST+0Y7dRqVsk3d/zhHoS
         ZAh2MopxZ/rt0BGEyaOK0PpJ81nr1KGKN6ZL4tYTO+triLleUKY7lfgej4GA3QzvDgjK
         VA5+lPcavdQQ+ACGoUgPC3Yoqvs9tdD64cO4jFeavSJY7fkxe6mUqGh6WHKUP38IJPbD
         pc0odcRddeHj2s7HR8DLyz6GRfuxSaxjmvteSnHo9vZUm3quHuRIsPvLRAPWmJPTlsfK
         578Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734358009; x=1734962809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DR+GKpOhUkgjRJRCGj+6G2Ttdso5dJH3Im5WlzUjyiQ=;
        b=T1AZ8fZdQwAeBTgWYasUloGcUfLbaV1OOZ0S2bxzRscIPHC6G8wgDUxMhnZD2DsUpo
         +qV7HAR10h+vNxRFnn/LYUL/085ofUCCzihPp7vMg4+9IXBWuGAersboFlqTa/wScIpY
         jf5h+QERudtTKudecXHZYSFKlFx/RIEZv2nL07j5C5cd9QaQFmVt7fxJdxmhPeTVJmgf
         3bQsPVEgfzwCEYS9HPQZgnAJIGBAng65xiVefHrMrTBEZzyFOZZMBTfoh30jNufBSO61
         yxvIwHgRdl+vhbGf0mrVThGpBJNZS5tjijneaVDOe+Oxu18ffFIDDh+JrM9y7IUy2Q0c
         7RFA==
X-Forwarded-Encrypted: i=1; AJvYcCWMCieqzrZe0RTHiko3W5cBUgaAIdqqBofU5InfaiBCYK1HEuXs45ZfEJLKpFmvWfiHv05n13Outw==@vger.kernel.org, AJvYcCWRdyvi7WBnmXvlcJN4RdpprrF2LLSFgKiBIP9KV5ubYDuwo5dL227zHDBwCY+3Q6HFO5KEkRo8kAyEvFZTmkGQ+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd3qUBwWkT24eTUXZrfAz046wVwmDaJYFQ1JJ1GlpY4pSm31LH
	eIPwscGWeHGgGy81zjU8G0ieTGaIFw392fh7pm9iwLUUP2EdBD7Fcer/d+yjWGLgsKClzLcrn32
	XTqwaeG1/hNLwYXafuWdPPSVcPGZabg==
X-Gm-Gg: ASbGncvO5qhQdViAyUeT0l82oH7RMlg6hAyINgZeEC6k9V3aLGFmaiC8wZpF2OQGgMH
	AWzMP5hkfHdZDPX+GR8zSFV1cRhvryl+kEzAkXg==
X-Google-Smtp-Source: AGHT+IFdbcHbVPkdPYImeVz016De8H0T3X4g5Lg85rV3R69MOf4zweRovpoGCgGAXBBhW8mAqHUPQQRcUWmQEq5gRBM=
X-Received: by 2002:a17:90b:54cf:b0:2ee:8cbb:de28 with SMTP id
 98e67ed59e1d1-2f29164efbbmr17690706a91.8.1734358009189; Mon, 16 Dec 2024
 06:06:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210115551.1225204-1-takayas@chromium.org>
 <8d8da243506dd9291fa5f02adc7f6142@paul-moore.com> <CAH9xa6ccd51V9fswkRX+xGfXHQog-wJQzB1LvK0pLT3CLYkfsw@mail.gmail.com>
 <CAHC9VhQrSGitY_TUAHbds-A8uQmn2TveTUrK-Jcd6quuMPHh1g@mail.gmail.com>
In-Reply-To: <CAHC9VhQrSGitY_TUAHbds-A8uQmn2TveTUrK-Jcd6quuMPHh1g@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 16 Dec 2024 09:06:38 -0500
Message-ID: <CAEjxPJ44mJ0sUSSp9h0Q+H_=AVRBa7i_P5g0kMjB6VS1AtZ=Jg@mail.gmail.com>
Subject: Re: [PATCH] selinux: support wildcard match in genfscon
To: Paul Moore <paul@paul-moore.com>
Cc: Takaya Saeki <takayas@chromium.org>, Ondrej Mosnacek <omosnace@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Junichi <uekawa@chromium.org>, 
	selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 5:18=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Dec 12, 2024 at 12:26=E2=80=AFAM Takaya Saeki <takayas@chromium.o=
rg> wrote:
> >
> > > I would like to hear from the policy and toolchain folks on this idea=
 before
> > > we go too much further with this, but I did take a quick look at the =
patch
> > > and left my comments below.
> >
> > Thank you for reviewing this patch. Could you let me know the relevant =
folks
> > who could provide feedback from the policy and toolchain perspective?
>
> The toolchain people are already on this email as they belong to the
> normal selinux@vger mailing list.  From a practical perspective I
> believe the policy people are on this mailing list as well, but I just
> CC'd the Reference Policy mailing too just in case.
>
> > > > @@ -2193,7 +2223,17 @@ static int genfs_read(struct policydb *p, vo=
id *fp)
> > > >                       if (!newc)
> > > >                               goto out;
> > > >
> > > > -                     rc =3D str_read(&newc->u.name, GFP_KERNEL, fp=
, len);
> > > > +                     if (ebitmap_get_bit(
> > > > +                                 &p->policycaps,
> > > > +                                 POLICYDB_CAP_GENFS_SECLABEL_WILDC=
ARD))
> > > > +                             /* Append a wildcard '*' to make it a=
 wildcard pattern */
> > > > +                             rc =3D str_read_with_padding(&newc->u=
.name,
> > > > +                                                        GFP_KERNEL=
, fp, len,
> > > > +                                                        '*');
> > > > +                     else
> > > > +                             /* Prefix pattern */
> > > > +                             rc =3D str_read(&newc->u.name, GFP_KE=
RNEL, fp,
> > > > +                                           len);
> > >
> > > More on this below, but it isn't immediately clear to me why we need =
to
> > > have the special handling above, can you help me understand why these
> > > changes are necessary?
> >
> > Sure. Thank you very much for the comments.
> >
> > > I understand you are "marking" the wildcard entries with a trailing '=
*', but
> > > since we are calling match_wildcard() in __security_genfs_sid(), why =
not
> > > fully embrace the match_wildcard() capabilities...
> >
> > Currently, genfscon rules perform prefix matching (e.g., `/sys/dev` mat=
ches
> > `/sys/devices`). Directly using `match_wildcard()` would not preserve t=
his
> > behavior, as it does full match. To maintain compatibility with this ex=
isting
> > prefix-matching behavior, the trailing '*' is added.
>
> Yes, the existing genfscon handling does prefix matching, likely as an
> easy workaround for the lack of wildcard matching, so if we move to
> properly supporting wildcard matching, and the policy explicitly opts
> into using this new capability, I'd rather just see the policy do the
> right thing with wildcards.  It might mean more work to convert the
> policy, but this should be easier to understand and more consistent
> than silently adding a '*' wildcard at the end of every path when the
> path matching supports explicit wildcards anywhere in the path.

I think the problem with that approach is that it assumes that the
entire policy can be updated at one time.
If as is the case in Fedora you have independent policy modules
shipped in individual packages, or as in the case of Android you have
multiple distinct policy module providers (platform vs vendor vs odm
vs product ... - seemingly they add another new one every release or
so), if/when the base policy enables the new policy capability, there
may still be policy modules present using the old genfscon rules.
And since the kernel has no concept of policy modules, enabling the
capability is necessarily global in its effect.
