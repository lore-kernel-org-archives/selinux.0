Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF3016848F
	for <selinux@vger.kernel.org>; Tue, 30 Jul 2024 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722340733; cv=none; b=Q+zJIL9XmjSHWmegPtxg/bmJpIkMbbHS/jiW8cVgAcZGH0Gljn7ukHATwgmYGfLxe7025bK8BN9rPGsKlpJjhCH0NSUh648PpdBQfeKf5lwNns/DZTNQ+ANaTDdDMN+5jjqWKjknZqsmMuc8PjrCIUQTGDzzmd85FLXL42xnOZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722340733; c=relaxed/simple;
	bh=Ocd1MJRe+5pAuY9aHSN7l2x1DLaKeBBNAH3JwoAAOyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6ILJS0Qq7AxNFkEw6SzdYSm4ZGTkHolpUDX2SLYaDmv2lWDa7V1bdMj25zd+MfwPaRY9IsqSeO6qKmAvQBppvJUGfiVUdKhL0jETMGmGyhoCUK2AD4wU3pCtxsm86F89HMr7Ve4HwVGtUeCeoFGDOCqnEIPlcGctYcmq5nef+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJIS10JH; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJIS10JH"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7a10b293432so2624691a12.0
        for <selinux@vger.kernel.org>; Tue, 30 Jul 2024 04:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722340731; x=1722945531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qKDRdcv9dCLnMUFJ4XwHSuhthziwPbBC7l61q4oY8g=;
        b=aJIS10JHCNq0BYYs/+ub4XrcYPsSg5TVR7iXgRV+1R2IXk2VYVRljSwqAU3ZqHunow
         Z9Arvl2rLFrKkFO9fIx8cE/OWPbzwxsXQvgx5xCteRZDmHz3yphmo1Q9ygfiAWWAocmT
         NgCgeXKkInWAmjIbI2UvJhqtFRtDayq0IHEIMyU2abVmaj1NpR3jG03P85l38yvTiLBr
         5ON54uY9nCl/BfFN72L62GnkNcG+vIS3ssSmUXcYZj5BfRpBHkuZ/kmwGB3t5nMyRJIX
         Dzlah0cNAyUCLamZPU4TQgNWpSdZJPUq1LGLd50j/29TQChs6MBZuhQgQWkSMUIAGu55
         3FGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722340731; x=1722945531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qKDRdcv9dCLnMUFJ4XwHSuhthziwPbBC7l61q4oY8g=;
        b=jBieWJ1to/nN0wxubV0ZzRbRy0zDSOLVvWGbJgJUFBPFeYjieef9NH7bF/dYBOJDJB
         g9Z0u2wAp0DQmW2nzQILZw/to8V9rzBb36pglLX258aoKj/UT2U3svFtnawcs8+1lSF1
         a5RZ7UAkTgq+BrTNNwpfjH5wfhbLLUWVO6SsCfAJydQTv0A4QCYWQF/3iJsUVHR2kebT
         m0RM/dJOx7Y8JXsWJ+xVcKng6Nwm/oG3mokdVOG0b91LWaJX1nBaZfGl8KdP10i++oSI
         Qdf13lH7ONpgxW1JLNJ4cW0S8e2IOi/kiKacuqFBkf7BNe7EOyfT+tFQyBszk/5c50Gh
         NlcA==
X-Gm-Message-State: AOJu0YxlqZpNScaPPG/3Ux17X13ydSRDCaIpxEgJAxWtRxtCM5kus6MD
	mpt+etE9ad9prhPqvUejSYAawDyzHy94wvOi2fmbl06UZaoR01v0LszIi1FJbj13IpWUp3Pi1ui
	ZRh/zp3WPqzHPfz6VtkgDa6mefXE=
X-Google-Smtp-Source: AGHT+IHquBwqqTYPntm8DFJ9uKcA1HgAAPygOaH0wTLvj0MdU5NhDCH3Zc5RIIhiRXTDC/styDbJHOLn+Ver6M0SiNo=
X-Received: by 2002:a17:90b:4ac3:b0:2c4:ee14:94a2 with SMTP id
 98e67ed59e1d1-2cf7e6078d4mr8861004a91.27.1722340731505; Tue, 30 Jul 2024
 04:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701182732.85548-1-jwcart2@gmail.com> <CAJ2a_DevjOD55nbGxqjEPx+Z6q4bpXWZDVu15-4iAV0_mQgpzQ@mail.gmail.com>
In-Reply-To: <CAJ2a_DevjOD55nbGxqjEPx+Z6q4bpXWZDVu15-4iAV0_mQgpzQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 30 Jul 2024 07:58:39 -0400
Message-ID: <CAEjxPJ7HyFpPQapVcfkpKGgRa-ZbSzQjwuo76_3eoGarRyOqgw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Fix integer comparison issues when compiling
 for 32-bit
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 7, 2024 at 3:00=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Mon, 1 Jul 2024 at 20:27, James Carter <jwcart2@gmail.com> wrote:
> >
> > Trying to compile libselinux for 32-bit produces the following error:
> >
> > selinux_restorecon.c:1194:31: error: comparison of integer expressions =
of different signedness: =E2=80=98__fsword_t=E2=80=99 {aka =E2=80=98int=E2=
=80=99} and =E2=80=98unsigned int=E2=80=99 [-Werror=3Dsign-compare]
> >  1194 |         if (state.sfsb.f_type =3D=3D RAMFS_MAGIC || state.sfsb.=
f_type =3D=3D TMPFS_MAGIC ||
> >       |                               ^~
> >
> > Since RAMFS_MAGIC =3D 0x858458f6 =3D=3D 2240043254, which > 2^31, but <=
 2^32,
> > cast both as uint32_t for the comparison.
>
> LGTM.
> Reviewed-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Do you have a reproducer for this? Building with -m32 didn't seem to
trigger the error for me on 64-bit Fedora.
