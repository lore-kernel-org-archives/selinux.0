Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2EF31F999
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638642; cv=pass; b=bq1LQztx+ZWEwZ7gh1FdwZiLBLOEkK1PdPtejvJXkbx5NT2bHMAVolQV5jFSWVeBmdmI4RATXJ8aKMh3ABI7kKx2WMcU3VXcfaM9jJKt0WjUDKrn6xb1I+vhv9dUKpkB6CKcjJBOAO6CIoqg7xy8mWF6SxaebEHqgNZYaUO4St0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638642; c=relaxed/simple;
	bh=CHd2agh0v8CPmqFlOVhOQQu7zDnTukbWTZSWAVyXvM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KkHDy7MljRPBczQ6ZPdWLA6xX4JuPtXPGmCSeoibeSdQTOfXgB429SrlFGf1IxS30o9HrVljP4HNWFe73QDLOscVEAQ80ag5ld+HOo7JMwnLY2gaQsTKgLNpBebOIoslM2gxx7L53WT0lTIM8hHpGfDRCbkHfCA80cYaZrn4X7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCs/mThK; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCs/mThK"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso2015382a91.1
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 05:57:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638640; cv=none;
        d=google.com; s=arc-20260327;
        b=SmDp8f5v3MEhnRjFLRXHD7dghpKEyUrXKfuGPafrzRil620fDw6MgFKB/znsv5u1mU
         Goxl7QwZnAaV0ukB0qGs5C4XKi1a0ORb9hzzzlHVoAGL8W1du5GJ1vP6kO+4d2ccBNUN
         e48WxE7QJ9x1kztc9BWXqmTPlHb66oCIrLJeSSKJyq18gApBLcyCJjFaAb+S6JDNg89M
         JCDH21we6V4aodP/gxqexc+q1JusNAsrf2SIEpdWz0Rlrj6JBRyuVXamFGYyVljyO4+f
         Q7g83VHRtzRhhlFDQCbQ8qqFAFrZrBdRXErEAv2BsplXejBmaTVIB/Ij+ngnc5CEnzqc
         TRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CHd2agh0v8CPmqFlOVhOQQu7zDnTukbWTZSWAVyXvM0=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=WV9fCSEmPJreuRhQbdfQBfziHjscRNk175oeIoRqUdIkJV4W85CX1Y2Fc6k631WCIA
         xRumDz3CvpVjKHk2u+AeD6SReEDy4cTY8iX4PqdZAnYhMc+ROzvfYX0YTUARkYC/e2gx
         MGaxWwJu3xeBuKiFQ6GJ64bRi4ehLEtboZkBBDmIiscu7wwjsUb5Bxwhorw/EEpnEUrg
         5vzr+3qcUn97rCM/TH3AJnZ3kw+inNsxEXtHdL2JV/lQxSNIuCCFDe1ZSDtuLZ6TLjBh
         osKKF/0k/r0erLvYlqzZ0DvUjElqsmkYLwsi0D6l1/OVcHX/9bUxVlE7kbCAkcq4ERSH
         jaKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638640; x=1785243440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CHd2agh0v8CPmqFlOVhOQQu7zDnTukbWTZSWAVyXvM0=;
        b=HCs/mThKqWYJtGViegP3sGkp+f4DOgADNuOnRlC5q9iWSVReltfu97JAn6Dh1+drgs
         7DX22Ecvr/++zCS1MrLR9Bc4LL4XTJ/hGfHcV8O3sdNrRKXxmXQLjZYAd1KgFBPuJCdp
         LEtis6Ys2D5GYicjDmQ7tgaWjFvlmQOQLU/6Vg8JXphzrJx68O6y5EpEST+svxpvUVaR
         DwCh0WrQo3Tvv0K81NPbllteXEhe8kDWcGSI0rG7WDMQkkCgg0K2IypZuqAQ9dZaC2Lk
         yoBZ/3ICDqIBXkoBq4POgyweAF0oKcmk9Lk/Cxm6wxJPk9/xsvm4TXer04jYbNh5UkgE
         mBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638640; x=1785243440;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CHd2agh0v8CPmqFlOVhOQQu7zDnTukbWTZSWAVyXvM0=;
        b=otW6NZa21m46smaOgSPgz3w2TdlGUK0djEyRK2ANd9Yq2Kg0x04q4LUEz6xjM3SdX5
         fZgEMCbnjNZ71O8JJzqTmG9tAQhYNMtbIohvLVgaAsy2goPtCZtQxGs3sj84U6rFJjfm
         rWzkKAmddtKel70xmkXmYhJoYd4gnWqcBmiFx8+oBIgCwV168m/mxJzACIz103X6B0X2
         /SGQF/1Xuq91QJC35h2ZAm2ruf/aQ8KNqD94HVT0OdmUEtqTkQZlN5YsMeZ7P5NuqgUM
         9BsFPWPlXYheMHEmELwFtABi4KbF6aaqqFMLuCEw/gIN7HvHwXsNpuTVferY0GjhQ0XQ
         9cGw==
X-Gm-Message-State: AOJu0Yyi9diLQN2W0qZtsFtang8LFjOwf5iGN831tjtzc1dL1UgxxaYk
	NE14mMZp6DJxuDA+poUxjFjqG6ZzDzSgGZXbTzb5DCwx/S8CGpJUyBa7xZC2tZcMsZ+MVW19J/L
	OV+WdfwByWQlbKoQd/n2li+bwzcj8u7E=
X-Gm-Gg: AR+sD13KCjfYUfyfeL+uYSRSL4uwMH67oTu39mI+ORXBF5BC5Dsl3sAy2XXPVD8fBTI
	CHfXtbid99pYxR2CJ2RhVnUDIE1Um7+WARxFpYUwyipTKtALquCoNhWUI4z+CUN97VznSHOfXTM
	6OBn7We7TLEVMHMhS3lOLxSf1S232s4pxws/OZlhjqFNN0skGg0sz3KNssAIk1qr+yvhBNJ0z0J
	Nw0TLUawbti24a4+IbAMrRUzOvg+z2ArBglpuQExjvH8lvAHwo0jGpQkubaqtgG32iie6I4
X-Received: by 2002:a17:90b:3c09:b0:37c:607b:2cd9 with SMTP id
 98e67ed59e1d1-38e4b29a892mr18314909a91.0.1784638640360; Tue, 21 Jul 2026
 05:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717173544.15801-1-jwcart2@gmail.com> <CAEjxPJ5Mcz8ECLWS6mmjfbx+YsBF2tPNZVVyeGRjhQFMN-VN4w@mail.gmail.com>
In-Reply-To: <CAEjxPJ5Mcz8ECLWS6mmjfbx+YsBF2tPNZVVyeGRjhQFMN-VN4w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 08:57:07 -0400
X-Gm-Features: AUfX_mzNBaxoW4FDd-69Zb1LhKRVgld_917S0ApZMmzdJO_3Be_yR-m9t13UZPM
Message-ID: <CAEjxPJ6QJfuzDMvy7VJxKWj8mjd-0bnhPALX96DHXZfU+LBhcQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Prevent OOB access of array when copying scope information
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 8:20=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jul 17, 2026 at 1:35=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > The function copy_scope_index() in link.c copies information about
> > what declarations are in scope for the current block. This is tracked
> > in the "scope" field of the scope_index struct in an array of ebitmaps.
> > A second field called "class_perms_map" is used to track which
> > permissions are in scope for each class. The "class_perms_len" field is
> > the length of the permissions array. As the function is copying scoping
> > information from the module to the base policy, the index values are
> > translated as well. When the information for classes is translated and
> > copied the largest new index value for a class is determined. This valu=
e
> > is used to allocate the class_perms_map array. For each source class in
> > that array, the bits in the source ebitmap are translated and set in th=
e
> > destination bitmap.
> >
> > A maliciously crafted policy could set permissions in the module's
> > class_perms_map for a class that is not in scope. If that class has
> > a new index that is greater than the largest index of a valid class,
> > then there will be an OOB write when copying the class_perms_map.
> >
> > When copying the class_perms_map, check that the index is not going to
> > result in an OOB write when converting. In addition, if there were no
> > classes, then just set class_perms_map to NULL and return. Also, don't
> > bother trying to copy permissions if the ebitmap is empty. Finally,
> > just use array notation when copying the scope and class_perms_map
> > data since they are both arrays of ebitmaps.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
