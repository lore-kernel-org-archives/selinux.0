Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C671A9B4A
	for <selinux@vger.kernel.org>; Wed, 18 Dec 2024 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734559599; cv=none; b=qdQnpwDpoAAOJ9JAPleBlLGIbEqdw2o4dmO3UCfqKgHDkY5k4nWzpBIV5ALst9Jon7gHkOutB7+nYs+zN4YkSU+0Ngkv/QjnL9/DP2E7GsYiTY3y1Yf8z/vysijX7RftV8mZAB1TF0k0Ft6v2KFSCjyRSpIeQT76Y4vB/OrlxzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734559599; c=relaxed/simple;
	bh=oZW9AJBL3f7kmJhGJ6BrhLdcr2vV6xibbPFGD+YiQNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TX28b1GxjyYk5YUptB2ZvLboCujbkYap8soBv+M/fY/KxexpFN2sNI0lTw+AtvIF+wSxlBlTWHrfwMoKjanwDRMLQ171IMZu8wAjCB2WCcYt1GIYYfPO6z08D76q7poIjWPIOxrfMpzY2Zfy7r8ZVskazo47tUPJebrl03Jdh0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KuAWsrDw; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KuAWsrDw"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e38938a55e7so120837276.2
        for <selinux@vger.kernel.org>; Wed, 18 Dec 2024 14:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734559596; x=1735164396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6LxDb6RLUrycnRVy36lv8szD5N2HPIBgoI/MoCMO3I=;
        b=KuAWsrDwvaEEpK8Pud/Y77uRRWR+2K3Rfx0rx/tptSk/BdotfVDWY1/QrFGztEfj+p
         Vf0mVZ67ocDZ2CGcNgjRvtwLI/PR/0SzD5wdvhpANoFwxYfsJaPFpj/0V/IdOFl4+j6u
         Zd/q5UhbIPNHVsoIFWp/Xjiugl2hDummitYlS/tUmsD1Ajswmg2o/tZS0j5gfgvlGEn6
         GsfqEDr0XGK2eNELsYGBidrkjXw48QMJfoWpxQeqeoMBwDeYn+DPz6hxNOp3oY9R5FOJ
         Wglat0d7dGcuJFTmzE1aG43pQP3ouYY//rDfdtPj/XvrgqB6ywGI1iM97VN7125iD/2w
         e6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734559596; x=1735164396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6LxDb6RLUrycnRVy36lv8szD5N2HPIBgoI/MoCMO3I=;
        b=dyPi8wBQcUHAZa8AEVfrPHos8jfP2rEemWn7LToR9ooOTA5aUkgz4sKPPkoNGgSEoH
         nfXs1M3Is9Gmy2b6IPKNwWUkqd/s4QMmudOcQos6cWj9HjmVmpRiZHChogoW7XBN1MIj
         YnRS4azH3RYxQT5e7r3Ctf5eq9p/QRYVk1iTi/h2NnnqdxS3Cwyj7iGaGRY+EzKINqQm
         NCV0foz07H/vGqM9MoqZTALW1emI+s0UDxf03ky7IWlJQOPtNCxVOa0cAeSuCu+NBo+E
         qvSH5hhX081EjNim5hgct9IAwj+ZVdfncjD90iVAFHe6anZQuWl2d3jEzQvYBi8aDfAc
         vD6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSGEVLARgIhbuaCrQTgu+WDD8IS/aZbaGpp9stiZ9bl0Y9D90sCJggSsdVLywdrk5627ueTyz7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9gSKi/RkzZJSuibyLZKYMdGHvVoOBBsskQUdz4Nwpe6n/9Ps8
	suibUDzILdLouQrqdzxmwyVV2XnbyZ2ta8DJSsIQWiLaRZGjAHMxZF79l5mweCWnKLBxnXqWTyq
	itoPXa9+cV8LQ3qXKxsBEkWW4jX58uccVRmfo
X-Gm-Gg: ASbGncstdidaixL/F6FHTAt/QSK1jMJI26kscjZ5+HQZWkW3lsm9E4ElYp+qSYoRDtt
	BEJJelUQXlunrz9T0Pj9CnrTu49XQ6SypxtdR
X-Google-Smtp-Source: AGHT+IF2h8U1xOL2mYFV3umFgf74KNeoN5uWow8kooJKUwxSHsLIPIgzNhYZyKRtvpU2V5r+ltJoFN5nEAWBzeixBKU=
X-Received: by 2002:a05:6902:e01:b0:e4d:a924:41d7 with SMTP id
 3f1490d57ef6-e53621b705bmr4855704276.13.1734559596605; Wed, 18 Dec 2024
 14:06:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210115551.1225204-1-takayas@chromium.org>
 <8d8da243506dd9291fa5f02adc7f6142@paul-moore.com> <CAH9xa6ccd51V9fswkRX+xGfXHQog-wJQzB1LvK0pLT3CLYkfsw@mail.gmail.com>
 <CAHC9VhQrSGitY_TUAHbds-A8uQmn2TveTUrK-Jcd6quuMPHh1g@mail.gmail.com>
 <CAH9xa6ecz_P+GwLQ_73_M==WF8cZt3bzD9NJz84U9B4mRdTOrA@mail.gmail.com>
 <CAHC9VhTta96fojwPuf_JRTws92=BLqRPRcDc2sBTddH-50HxoQ@mail.gmail.com>
 <CAH9xa6d+zJRoZMO+ip_DR88vhxBf6PoneQBkrGuR7F6PqD1r-g@mail.gmail.com>
 <CAHC9VhSVpDDGW7rKVCYiOtgq71yfXRWDWegyEx3Zp-BoS9dj5A@mail.gmail.com> <CAH9xa6c7AAvMUE+DK2tDD65Nsg3S663iH2fZLeeNc+mSPjfT2g@mail.gmail.com>
In-Reply-To: <CAH9xa6c7AAvMUE+DK2tDD65Nsg3S663iH2fZLeeNc+mSPjfT2g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Dec 2024 17:06:25 -0500
Message-ID: <CAHC9VhSZpAXAX-oNk5rP13bNTBrxu=2DTCnVLNR2r-e2ePEccg@mail.gmail.com>
Subject: Re: [PATCH] selinux: support wildcard match in genfscon
To: Takaya Saeki <takayas@chromium.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Junichi <uekawa@chromium.org>, 
	selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 8:38=E2=80=AFPM Takaya Saeki <takayas@chromium.org>=
 wrote:
> >
> > The speed at which a new nice-to-have feature can be adopted is
> > generally not something I worry about, it's a new *feature*, not a bug
> > fix so if it takes some time to be fully adopted that is okay.  What I
> > do concern myself about is the quality and long term maintainability
> > of the kernel code, especially when user visible changes are
> > concerned.  Adding kernel complexity for changes like this, especially
> > when they can be handled in userspace is almost always going to be a
> > no-go as far as I'm concerned.
>
> The perspective of long term maintainability being more important is comp=
letely
> understandable. Also, your comments on the other alternatives are well-ta=
ken.
> Thank you very much for your input. Then, I will update my patch based on=
 the
> full match, also reflecting your review comments.
>
> In the meantime, I'd like to confirm one remaining option that we haven't=
 yet
> discussed, just to consider all possibilities. If the concern is primaril=
y
> about the implementation rather than the behavior itself, would it be fea=
sible
> to implement prefix matching using a dedicated helper function instead of=
 using
> a trailing wildcard character like '*'?"

While adding a helper function instead of a direct wildcard
concatenation would change the implementation slightly, the higher
level concerns around added complexity remain, and for that reason I
remain opposed to such an approach.

--=20
paul-moore.com
