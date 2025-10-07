Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF32B1CDFD5
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851576; cv=none; b=e3CagAmRObDk6c8kbsZs+4732uXVR3UeoBCNWW2LR7nEZm36hwlZjK3v4dZwbEtoRiGRNG2kp2xjvCZUSK0nzOzErtmUtgHml5f16m3EYTKRu07Gj+bzAiO9UdcN5sL2i4eQltBhxaDsUGHDS3IyrOMi0EeLwphkAbWzDrDWb3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851576; c=relaxed/simple;
	bh=SHFBZ97HtuQIaERwy9N9AbE5u0wsIlWVxa7KKxecmK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+N5WOSrekyNBM9Qtz+b7GPWJxJFl2hxCY4GxkyUciMxXXV8LnLDVly02DSC5d0ToubfVUqhTQ7f/qpt6VJyP+I0I7lUjQWrozhkJCYfSDQeF9IJUQ2ktRiTLwBdo/x+vgjyOaAkQSDqDuXp+osxp0Nw8nJLniTEjXv2A+0zs7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fetidw/T; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fetidw/T"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7811a5ec5b6so5505349b3a.1
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759851574; x=1760456374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHFBZ97HtuQIaERwy9N9AbE5u0wsIlWVxa7KKxecmK0=;
        b=Fetidw/TQ2wkR9R/St0V6zgYLDX4P+NeiNGeteYEhSqqvNwejnLcqjtLAgJEdkjGiQ
         owZVtgSmSxQ+uYoEPOisxRl2I1HjlMoN3rdxNjTf/hzNTn2bxtyNWJnIhHzD4ugHCw5P
         cIZPIP0eI7W2PWS5dHXsjgvoWynzWuc2o0IEpQrczUXBjJbPSA0F/SrZT/n9w1L1ErBP
         fxHHssVY+7lUz/ISu1Z3hJRYSsgxUdgfVeIaZCKDLs2skJDjXchT1aW22ShnLEjwo6fK
         X0OGFTCGcaeBEvDuFODE/CdVflJHrBDoYgebV4CYj/D6AAsG4iarJg8SS85sVVMfmWzm
         IGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759851574; x=1760456374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHFBZ97HtuQIaERwy9N9AbE5u0wsIlWVxa7KKxecmK0=;
        b=IGCGleoSm//46bQgbQrulMIfopSffSnqSGOYPzXHPrnCv7Q55h6grskg6BtWV8rwfv
         xhx4yRLUs/UhpA7q21reDj4tJH/k6TvKPNmqKR8BR+oq2jtT3RflVcl/TdJsBr+ik/2j
         dTsGirlZGwsfSqSr2hreDGnyFeH6jgRKHoQY7//9qWXalFxf0h1Xn+q0Hkj1lVMP7cn7
         ShpBsTk8l37gu3gcTzRjBr9jBHMPigLFU7BHdULLNMGTvIV/aZVwvd4BAgmEYMgkMRn+
         YolAWStpPL2wUF18UazdjeiAz0RUsFMVtSVNh8RPfFH6YTxyG2VluZwMoi7xiqk+mN7a
         XlGg==
X-Gm-Message-State: AOJu0YyZ4iWuSG27D/JX854s3nT8Z+Q4r7mvbeYA3HabkNe3hj7q+go6
	vRnIkmng3rZ7MmERRHJQ87xMFfDrLKkVfq51fo/G44PI/zeV/6H7cFM76F5vkoak3jae1y0TpDu
	AxXsJB5IxGnsQCKSs+jJ1FVeYAfm0NRP7Yw==
X-Gm-Gg: ASbGncukSRo9XUta5rJ4awNVg8X0n5Ku+0t40gxWuKGMb4UZ2eM5N8fhuw6cS3FP3+u
	J4+pyut8v4h7WW9g2iqObEOskyqnvBRBv/BfKUl38Xq1KN/E+AdiWs7f/rL3fT2/MSz39eK7Gua
	0uAU80jMbeGUJjpAUxvOFFtCfDVhk6AcuqvDB7MV8IuL0KcU5pkNOA9HzZRVXV1LxayaNCnby1G
	SgdCbAq0AEEHBvlIN/f6Yxuidr8eBo=
X-Google-Smtp-Source: AGHT+IHRs9zZoNqnGq6bidsRBwKAZhizH3EqFTjiqbG0ylANlLUzL9WjMSpuqAQJxjr1aLYLFV7v0UazI79zoJvqQ+8=
X-Received: by 2002:a17:903:38c7:b0:269:aba9:ffd7 with SMTP id
 d9443c01a7336-28ec9cafcc7mr50829365ad.25.1759851574099; Tue, 07 Oct 2025
 08:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912132911.63623-1-calebcenter@live.com> <CAEjxPJ7y-vhX-dVRr6CPw4D-2+FjM9mYj9_HwJrM0XtzckFG=Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ7y-vhX-dVRr6CPw4D-2+FjM9mYj9_HwJrM0XtzckFG=Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Oct 2025 11:39:22 -0400
X-Gm-Features: AS18NWBMVuPoHCS2-d9Aqz5Feh8L_4u5AiyYMyEsUVZbjB2LMP9gwjesCmt0OGY
Message-ID: <CAEjxPJ4UtoRn_QgHcpMaN7zEcP76eT8B8f9oUURr2JShA-wN+Q@mail.gmail.com>
Subject: Re: [PATCH] libsepol: fix TARGET and LIBSO on Darwin
To: Caleb Xu <calebcenter@live.com>
Cc: "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 11:48=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Sep 12, 2025 at 9:29=E2=80=AFAM Caleb Xu <calebcenter@live.com> w=
rote:
> >
> > On macOS (Darwin), shared libraries have the extension .dylib and the
> > soversion is between the basename and the extension, e.g. libfoo.1.2.3.=
dylib,
> > which differs from the usual libfoo.so.1.2.3 scheme in Linux.
> >
> > This change sets the TARGET and LIBSO variables appropriately in the Ma=
kefile
> > for libsepol when building on macOS.
> >
> > Signed-off-by: Caleb Xu <calebcenter@live.com>
>
> I am not a macOS user so I can't test this myself but it looks fine to me=
.
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
