Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3299A2C0274
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680763; cv=pass; b=Bsyfc3aIKtOt/Gy/RumxCqYfijflLk2vV12Wtx70uT94YLs5TDLk9dRnKaoaqIG/ZxiU0bbvg2tMjVVTy9rhnaXb4jzdSWpRNrxW420jigzJcJOZYENpsALyAx19u/yaX02ubIMSf6lsqiXzMm72GCmf94SeART2JVkWrAE+VI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680763; c=relaxed/simple;
	bh=6PceRrEPFg/qD0DXpG9enigbLHBucdgOIpRdmVNOnv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHfwNYbnh6XbLqyf/rBQNufKHhGooG0zI8pN1xU1yKe9+hgK4b2C9jg2yhTbtyfLU34CEi4dG8PkPyA4E+114qx2lbiPvpE6DEVPngf+EGCmCmlFbpeyBFpFUaXWthpMqJT+orhndZ06/vEVv5NVPYtVCy0Up5tMcyDQ1xgTqsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVT8VBKr; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVT8VBKr"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-393c40246afso71487451fa.1
        for <selinux@vger.kernel.org>; Wed, 13 May 2026 06:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778680760; cv=none;
        d=google.com; s=arc-20240605;
        b=XUINdMJ+XI+2JdM/8t1/BSTe7mSsvy3ydwuXpHh8+k2bk1GpzkuiTc+o/oYweFTWmJ
         ldzFvsMwUGG71MiXJfSrM6b+sDMc1iYUUal59Ld0/Zd8vAe26fZjirOXTycqRnSECsl5
         W0SAWVn0uK7hajY+16Nj+sF2A2gbeADNMhuYM6v/0bM36TziFDBICprqh2TPyzPwgPbt
         a9wt7V3dz9lG3Dz19iVSUfT/MyJBQOm6KJaWIyVd0T0H0DWOKdgINWFE4R/Gb/xm2xdr
         +6FejwSUbEJ1ajn1jUAOGpvrmHzEgFltdLiGdTZADfreMl/YCbeflscl/3xNu+LVqSgx
         NBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XTHtKT3QHEYHHv8SAqoEE/17fn8FZzdrwhoJJNPzA5Y=;
        fh=YQ1o6PVsoJt/wh0IsDWS2kB5sOYTVg/L2UOtsoMAk3E=;
        b=aVuIkcS2/UUVDCuZG5cPBgb2BYujfV4epzORbmpFTcnR2fxjnLKX7IQylrfXCJFo4q
         NZ4jMuh8B4QY+Ydv7ja+M99zGhZ1Jyxd7PLkr8IfKqf84tW3gfeWbLwzoCj68FoPHgKn
         GJ51Ung2aqwAoiCLGN2aLcB0qtTWK/PIonPyFUSREZbuzE+sxuY/Ruaa8wxKVWmCs12W
         fESYtuEsqsgc9ygxcSLfRub1Wln/MZdDq6S1IB0GM0tzK/O09t4qbTlPRbOL8+ofNF78
         VLABo6GFPq/5MjTUhsSwkaQaO4Ger4CaNZ1d9RE/Pi8KA+dgbg88MuL/Gv5MLY24xPwN
         QoEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778680760; x=1779285560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTHtKT3QHEYHHv8SAqoEE/17fn8FZzdrwhoJJNPzA5Y=;
        b=CVT8VBKriJxJI+DH4cLZPiQbZ0qiVO/NYJdWtUU3bOaaS4nv8XllhmnA2qgvefSQBX
         X63ThDF7rki6FNJDOpPLooulZzV64VV+Du0EMjr5Y4AecnxdhoJ5F8/wK8668YvrwJmU
         i/i7KhxYgs38otG3Sc6BNy+NtHJpDLQoQ1ntuF196xoQ0U6UdWfOtm43rILnnvg1++sG
         OnkC6wpYEuPprMZ1Bh6HkkyOqBuzyBVcPCjqby+xT69huoxtN3buaaHYZbJ9ScLOT3rO
         +oDQrCqQI69RyCLe+UD/v5sXJ2Vb604QoJZMmW5Ho1sR8yaAKCnR79lj7j3iLHuf2rZq
         wKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680760; x=1779285560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XTHtKT3QHEYHHv8SAqoEE/17fn8FZzdrwhoJJNPzA5Y=;
        b=dzq786nCRZOlKFtoPRVFcnIaamA8Z/hPm6Gc2/9IoykcxG6hqAohFm10XdkxVI6239
         3XoXitgUA0pMFo/udkG6QINW+28SKuiZrWdqU1U96vi6mtGP/yp7WZY6cdyAMQWkppPz
         89sZIhSkeRTwifURkS5OUszzOfI/fwETH7/K/P/9e4/OzPl8yMKuARioAtiO4n1iS1mZ
         sSQMiynyKVlunyxhkSZYsLJkI10AwF8nOqJ28Yh/ik1wyLkgemRe5885saEiFo70+uwj
         4RKVcjo8xFT9ljkURjIO7FCh5kjpZp29X6GbFeplCt7Nr23DiIvAhwbU/An1LNQj6ZnN
         aVxg==
X-Forwarded-Encrypted: i=1; AFNElJ//7dRoxcoXkyA+snGvByq9bMrdj7w2YxeJeR9CvHWgmZG2xJI5FkVgXBWgCaQunXmPS5EpLOd3@vger.kernel.org
X-Gm-Message-State: AOJu0YzF73hhk7l2CWIR7Fz2JGKTP6nzXKissM/6chYH6dee8dFCyVdS
	XZfKshVzWPOBQX+PjMXtwpZ4ZgNTQG+8H3F58HcDxbQoxj4BsorO35Q2V3C4w/cPgJOTcRNmyJb
	5Of1hxgWGiFHLmoVTNfTIEcFZoXZL4Os=
X-Gm-Gg: Acq92OFcA+UBwfJFVv08tJCrv0x+SVBqecVqmP6SdluPZJbV9N+Bw9Q255hqWwkP/tA
	yNIBdUfNcwymnEVOi9PIod/kFT1vFpOJ+bDtgnKqK4vTC5Z6DHrxVk7O2MPw1WwtKN4R28mPH05
	w6yR8A4qoK9LmIH80VfC4sRp9kLhOx/sGowFJmReEo60bMvar3YKzMB4/Z0EMZ+Z1Um7fTOoutK
	RkeUvUUe+e7uGaxK56Wp3dFeNN4QydqRboy2Xs/zMVQW4h7YOJd902Qi4keweXRIivIMXh3vev3
	VAcgMmVSRlJJPoM=
X-Received: by 2002:a05:651c:198e:b0:393:c6b5:9930 with SMTP id
 38308e7fff4ca-3944b71a25fmr12189121fa.27.1778680760148; Wed, 13 May 2026
 06:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427162452.132118-1-lautrbach@redhat.com> <CAEjxPJ426jE5yu5A9rLWZmpOawChP_uTk5XTCMzNJkE91D6ONg@mail.gmail.com>
In-Reply-To: <CAEjxPJ426jE5yu5A9rLWZmpOawChP_uTk5XTCMzNJkE91D6ONg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 13 May 2026 09:59:08 -0400
X-Gm-Features: AVHnY4Lr3CGnGj0ivl3aI5R2H3De0A3fZh9wwEhNLc3zLm_4m7HFjJumYyBKAz4
Message-ID: <CAP+JOzQ39YFgJVrR55uMz2TwMdRKENqkGAcZkO1x7DzWfZ-6vw@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: do not discard const qualifier
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 11:39=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Apr 27, 2026 at 12:29=E2=80=AFPM Petr Lautrbach <lautrbach@redhat=
.com> wrote:
> >
> > Fixes:
> >     selinux_config.c: In function =E2=80=98selinux_set_policy_root=E2=
=80=99:
> >     selinux_config.c:284:29: error: initialization discards =E2=80=98co=
nst=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualif=
iers]
> >       284 |         char *policy_type =3D strrchr(path, '/');
> >           |                             ^~~~~~~
> >     cc1: all warnings being treated as errors
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>

These three patches have been merged.
Thanks,
Jim

> > ---
> >  libselinux/src/selinux_config.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_c=
onfig.c
> > index e1bc1b79fb10..1e6da288aaeb 100644
> > --- a/libselinux/src/selinux_config.c
> > +++ b/libselinux/src/selinux_config.c
> > @@ -281,7 +281,7 @@ const char *selinux_policy_root(void)
> >  int selinux_set_policy_root(const char *path)
> >  {
> >         int i;
> > -       char *policy_type =3D strrchr(path, '/');
> > +       const char *policy_type =3D strrchr(path, '/');
> >         if (!policy_type) {
> >                 errno =3D EINVAL;
> >                 return -1;
> > --
> > 2.54.0
> >
> >
>
