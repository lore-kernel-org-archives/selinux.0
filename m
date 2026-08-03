Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F74D344DB0
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785788354; cv=pass; b=K70KjDT9hrEnIcBe4MEJ3EBff3J0ncT8tBZ/IuYCxd25ySWJkBKoD/fKlz1p57l+wUkEOSEAgIGUAfH17U9fwGPQneBXCNAStsgKITbe67LItMGVEUXEIX0CgjOwt6Z8kv/Zs/qdwuSWNA7ISBuFdjzMgC1+z9d0OdIrqJKbHKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785788354; c=relaxed/simple;
	bh=jZsUmY3vscGN34FXwkScU4OTaFHgdJyGXTWgpbzktMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3Y9WA9SAts0AhxdG02vqvmx0pJwd/zxNk8mrhMNYYJbV3VStbHWlUQVUjm96PNsbUabYmSenpB3WePBS/3f8X6WuN+DE73Y/SG07PLRftTefZp+n5Hp/14NXGC+IwbCDGc2fhc/oGVuVSIejjufGL5HM9j3Is+WuhId2hOB2j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDCrUkNi; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDCrUkNi"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-451fd21113cso224079fac.1
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 13:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785788350; cv=none;
        d=google.com; s=arc-20260327;
        b=D4/uY9bE7AwIypIQfCBMT0DRqzjMRwRfnxupGJeIxm88bpSp4ty9+MJXFojFl1/LOF
         zVyeF0bcwFrnADr6s0Wd975+FoxSv4G043YJp+3jWrDrE1ZB4vWzV0FK1jfs2luhbhSi
         OJf7c2g2vySzvBe9NmLgRBWibP9GZinsBjm75jjs5F0EiOHYe1A2FNavP5kRYgMGhaFz
         +EMFS37mKDGTJ0avl47qAjnAc8+FyaoSA9IyDIoAkz9HweiGVc39sgW3P98VtQZZWrao
         E/05sR780CnEDn/1mJW0l5ZgRV97yHGDMOndyN3hBylbSOrBRzniMzzqpitPXqGmMNAE
         TsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jZsUmY3vscGN34FXwkScU4OTaFHgdJyGXTWgpbzktMA=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=Q35InHBanl3l1cC42rT/KzqSzCuBTQCmaKH9VpQTLr9J+eyYtTeG4/K2mkpKSBywuk
         mI0MKtBhgO+bh16jzix6uGaZ3ODUhaw+MaGoBXGu1DB4HpmpfG4RI37mj8aQjFe1jWZX
         O+lzDKbMrtcJ5HaUjriYeezVIYi37J70nu6Udnxuu880smsfYVZdzWAMfv5rM2eqDSXP
         yVjmSqkjv3E2jRTnxEJ7ax305egdMznt2iG60gttQgEPYCZ3o+3x9aHTpS75P8a/2alK
         02MOeY2rr75RUBtRxalp3fEtRZeG82MB6Qlua2iYfuQQ91Y1vmnF+5WtBLeJXi3q+VSx
         pVaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785788350; x=1786393150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jZsUmY3vscGN34FXwkScU4OTaFHgdJyGXTWgpbzktMA=;
        b=UDCrUkNiR5VdeXCT0HcqwQpzS/tutzPJ5U2m6XDF+mFsrWZ7r29p+3zjSKuS2hilvC
         FDOrQGbQvSaHCdfa7FBYYVKoUqd4HBGOJRXHAZ/OVZZi1v82kpY8KYauTmLnwJmDMeeB
         pElh4UipBNvM92xNGW/3g7rdTd+q9aJ7Cse7im/SBhmBLKP093OY/8s4w5OGlnamPZak
         st0gdJ1FKhMIV5dHYApkctNkiJ6OfmIO5HxnIp8pOT/xddLqxMiMXVa0mCNEigE82oDy
         6wU39I7x43oBFmC+p74U3bsX0QvilCgnzRIIjhhsJ2lJX/b4c6Ls9mXKGqwVNTknh4FP
         YHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785788350; x=1786393150;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jZsUmY3vscGN34FXwkScU4OTaFHgdJyGXTWgpbzktMA=;
        b=LqYAf6SCiL6s1kaOfJKyL/DY1erzMKH+ERtsjS8xEy9XtKzuRLZ3q4Xsr8l0f6fNtQ
         enuHz4pLzuOo2YrWnf3XPI+fjtoDN9msYbfpF6Akzr8wWJ2CCIoUAetisKn2IH4WGfaa
         zQ1plWdK3F22sO01E8dFUZV4kfBjsHJ8BtNko5ByKuaZ2GuWYmeZXtbU8tN92YLZtLLg
         PSB33sQRTFFurtG6Ysuk602VUUmAdI3xplauvUH9V2//7nz7GXZRcrTDbPbuCRvwAZP0
         uicQK8f2e/ks/ROgrm+BvT2rb+YpwnY8Nx/i9CudnrGPB38Gn/IZTNmhBzjEKCJtQkeN
         YCvw==
X-Gm-Message-State: AOJu0Yzinu2qWjCUNj6l3YrDOMFrbKbBivU76ImjnyNXPWouuzGqKfrz
	wqtPUQKrXn2ZVe5mmsY71Kk4pDt49W/I1UQvrRw2CFmZYxbD/qbPsa5QwxSkmJU2aomuJPq2Pxo
	C6TYDavUenv84bn1Xr+K0opkj7b4OFUk=
X-Gm-Gg: AR+sD10t8aJ70Ai+xQ4O3wpvpyOByY0rMH189GADvxaiv/+NY8RqdnKuflOujPwKmyP
	mqEL+FncRnIUnaV2kC3JQgEMTyDkg6b87jA33SVCI8CLE45Km4G+iOQeg+TsrxX5CX1Idrhw0UU
	NRn+wY//DbR46VdZUxxVIIIG85ECVWJBkj+c+N+1F3AET41Lze5KC8J5A5nrnuxnUR1CSj+qBo5
	1OQ1ymsekF7KSrsYDqRK7C1NlnsRScfb0H5qIXputGae4fCuS7ENWUGPg+2gdJYpdDDDAu6/Fc7
	AxIV8sOmWqMzIDFCtLamjnrz1VGLTdngn9bgdBJRM4uG
X-Received: by 2002:a05:6871:453:b0:44d:2da0:fa1f with SMTP id
 586e51a60fabf-45978bc87camr697897fac.10.1785788345694; Mon, 03 Aug 2026
 13:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803172420.23048-1-jwcart2@gmail.com> <CAEjxPJ7h=AqMPVP21rp=bv6ymZRmXfgKvAPRqD0x-=SDCTGckQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7h=AqMPVP21rp=bv6ymZRmXfgKvAPRqD0x-=SDCTGckQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 3 Aug 2026 16:18:54 -0400
X-Gm-Features: AUfX_mw09ovpTVKAAq-IP0EqIf-oZMLFRloQS9YHpFLWlzH3hQGGecDADblMohI
Message-ID: <CAEjxPJ4xvoY_FfNz+j7v9MiCM3kLnGwAT2MoX0y65iA=UoCAzw@mail.gmail.com>
Subject: Re: [PATCH] secilc: Use size_t for file sizes
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 1:45=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 3, 2026 at 1:24=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
> >
> > The programs secil2conf, secilc2tree, and secilc use uint32_t for
> > the value of the size of the input files being read. This could
> > lead to a file larger than 4 GiB being truncated, so use size_t
> > instead.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
