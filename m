Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD07B4C10D2
	for <selinux@vger.kernel.org>; Thu,  8 Oct 2026 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791472284; cv=pass; b=md0qSbeXRjj+HwLbH/lWhAuRX4frtc8qTfdnW9SPsNBaeFld/p1UA8Qme5iSt1JM3xNwgBx+c1AZepp98geTyA1AM9sA9IXH+xUus1NvnxiNF1MQCZ6o6G6ID7cTuFO+R6gCyCZs7QCc3rtsShxE3x8xstPPKfwpNwY3M/7nyAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791472284; c=relaxed/simple;
	bh=sfvLoHe1mNTXhHqCGeHU5XjNxMdKisAFdhJpIoXVAoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQkZi9pJUpWJyn4T1qv+StfOtoKSEu2QJY4nZX0LPgkgDE5vShTgcVVSTFmvnHa6iLcSYDGcy68o7O8xSGrCaJ3RKL/MDz4psbxa++ku5sWfeS8O79rKruR7N6APIi/JeMxAX5JLg557uX1zjVbZgZltdVH0eMSu/7ZyH/2T90M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wzm/y4Wr; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wzm/y4Wr"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6768a9fc0e8so5239334d50.2
        for <selinux@vger.kernel.org>; Thu, 08 Oct 2026 08:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791472273; cv=none;
        d=google.com; s=arc-20260327;
        b=snVvuvgfXKVFNGmLG3JvzDi1xfXlpLeSNa5+odZZaUkWcY6hvvtrBxAmSWyNYZ+WzL
         p0YveHRhCf21pQ1rkIZW8k793Fd91viN6tCMQALsIxFZMwRBUhVoeyW70TQyFXgVy2+m
         0bQU+R1irywq1k7Rxo2pTGZ+KSlFFsQwkI4CBVa8dBZqgVHxBGrBGX5G9bnBGzZDtJVE
         Ppvp6S9Cs2e0IEkWtZw7PwPuqPxepqhkPRrubI2oaX2DR/X5NREaVUFfhB92VTZvmEIl
         6fYxVsjkqCArHsvQN3E47PVtOsdiHrDCFjwKjvq5oxKtKdWf1HTFuGikDVS1j29limCx
         qSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sfvLoHe1mNTXhHqCGeHU5XjNxMdKisAFdhJpIoXVAoA=;
        fh=E95boLTiTkq8XsjKw8GK1wyz25DmW0RgNCvDUxEAbME=;
        b=mXGB02eRj/1v6HBzzweipYTtZwRTTQWwGOWjomkCy6O9Q+QI1FzUqDc/7a4EO2pRqN
         yFQYnqKakmZxlJpRbrvXxDLPFp61TktQQM/0S2UrKeLvqRRvvxlwafe4n2cP+iuS6b/2
         oKhhSF0eTPeIThhdjdraV7JUKyJCZnlW1rcGRA05b/U6pnb2EKb4SCOHsIN5fNHJsKJW
         q5Ki2cqYbEpKjbeePB9+OpcGJTxN3jG5/n/cTlG7jadtMrckxxCNg03Lwnv30T9s8ShL
         AbYQWuNVHzfLbF9P2iQI1mTCFXlC5jFHKybjUIz3jg4LGYSsottDansTIT+dJv5VTRub
         /b3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791472273; x=1792077073; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sfvLoHe1mNTXhHqCGeHU5XjNxMdKisAFdhJpIoXVAoA=;
        b=Wzm/y4WrOh91I1vVV93o6d+viZ04rvPVsF3fLfpD3sdgL8e+22mex0l1O+XgCocYo+
         mWQz1xGxMxHToT30MbzgxGeN8UX6RDo8a2n61yKmTXkzliPPRaktOAEgBSi+ZXbW+YIV
         i7UXdpKOJeNNoysTlivtyNx9Z3rTaaki1EvSn1F6EMhT/zZqluZketTOQGu3+LaTa+sc
         hgMKAVEx3sAsbra8JXFYHPlD97fFSrXcG3gxrcGCpDHQZz27Y61+2i4E+azZoqcyQPY4
         TvMlJCG1hLoAoneCV5htNJlQaLDMXbzVfkj/AEEfmkpHQ5W3t5gpxHsTs2VSPyF0rw4U
         VJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791472273; x=1792077073;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sfvLoHe1mNTXhHqCGeHU5XjNxMdKisAFdhJpIoXVAoA=;
        b=D13bTuuCf6h2bSDZvelwj1Pz/Xc5obOehPXCuWduRzttt/KzE277gWSHfuyrUfqfsg
         1fLKsSVHsMwtGe7BIbKLn2m1czojRom/BusIEwzbu3mImn1EkFn5mOnAh/Abl2VMW3SX
         76KW4yo50nq1mWmuGyLupeeiJf/pTESDSCe1x3eSY8QQoV+Zw3GO98oiB7AZK8XMJ3jE
         4bBgRUBltDVAbJFwnQ0RBCfsNLuIbdlYgE+tEzPa1rXuZxqkbcJc8wx8ngKbOSnbdKjv
         aeqHPSNIPaRG9hpo5yANwGBZkDztgB+oXBroxTrbikZ8Hp00dZMMHN59TWtBWRbm01g8
         q4Og==
X-Gm-Message-State: AFq9FYJEMthvTyn8b4lpBsvKCjDz/gtgltMg5CyMR5qwNZFSSBmOXi/e
	TQFO7EyKMzfiwlgRYADk/N8Ae2+Z/9XiN4BJK9RXQsGFTFC29KY57xjz/0RcszfdJPtq1PU4NOq
	hXN4FG1MtMYJpSl5sftAcJqmYewOU3C8e0sgr
X-Gm-Gg: AYBFou3RY7MuvhiVcHr7Jik8B84qEyau/Lfn3ZAUOxJkn04enATfmPPiJJUSc+atFaf
	TT4dtmosk3Qh+FHoOf9MQy1s4BgAA5jf8d23KPv/1/Tas7IwlkGakG5lo8NQyVw1iAzEiAQXRDk
	sBhQ2xaZfbvQD5ATrqncRxGf8uETKhBhu/0DkTePOS8dI0A72mFpreBOlYatCt3PDJcW8x+MtjO
	kirRCwQebH+ByNYPOLtFfwy6quc/29SAM0u2eypMhYryEIpRS02F+AzwYyXNWj8vKOGevuGO9ly
	XSS5+cYMEMZqnk90aIuqIS7WdSEfp6D9ksuJOa/NYIP5KpzcWlyzJjz8
X-Received: by 2002:a05:690e:43cd:b0:671:43b8:41bd with SMTP id
 956f58d0204a3-6790a446996mr1819400d50.41.1791472272694; Thu, 08 Oct 2026
 08:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005185343.2782019-1-bgrech@redhat.com> <CAEjxPJ5_ScD4Pxr0djXtow7S-mJaTDLydti1PA=XapOrqFOrxQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5_ScD4Pxr0djXtow7S-mJaTDLydti1PA=XapOrqFOrxQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 8 Oct 2026 11:11:01 -0400
X-Gm-Features: AclHuK8--K8kOsp-IJ2vy4KgRqYAbfUqZpCNkK71ZPqyYLKdHkBXYqXxCzjaBo0
Message-ID: <CAEjxPJ7TqZxVpTaYL8YbUGCcD9GjWrfJQrmnr5QSTASa62uRpw@mail.gmail.com>
Subject: Re: [PATCH] tests/io_uring: check io_uring_disabled before probing
To: Brian Grech <bgrech@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 8:54=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Oct 5, 2026 at 2:53=E2=80=AFPM Brian Grech <bgrech@redhat.com> wr=
ote:
> >
> > With kernel.io_uring_disabled =3D=3D 2, the unconfined probe also fails
> > (io_uring_setup() -> EPERM), so the probe's generic skip_all fires
> > before the sysctl-specific elsif is ever reached, giving a less
> > specific skip message than possible.
> >
> > Check the sysctl first so the more specific message is used when it
> > applies.
> >
> > Fixes: c3911c7 ("tests: skip io_uring when unsupported or disabled")
> > Signed-off-by: Brian Grech <bgrech@redhat.com>
>
> Nit: We conventionally use 12-char commit hashes like the Linux
> kernel, but I can fix that on merge.
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged
