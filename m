Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248463EDE42
	for <selinux@vger.kernel.org>; Wed,  5 Aug 2026 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946788; cv=pass; b=oyyQchngb+3wPoA4j5bSRJBNk/s1gCDEinNsA6tPtH/tESaUs3Bl3fTTdFdnEtMdl+NFeytqYTWxtUIB43rQs5a8CYKXrW08EODXkj4fd9/+xKS/GcCmiMt3jxVNtbMh5rBnn7EDjWM3osnuzCvlH1S3LZKdpXMhaaGg68HyeCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946788; c=relaxed/simple;
	bh=NnLmQFysjT7fdEutzgJTYA/TXzco2hbkjkBE8lVRpiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dViha9kK5RxIwWQKnuEylHf63SdLV9GxK72zpiYC+0fVNYjp79Ebn1whfoig8Y0m6kWN5+bkFxVXIE2MvmTzktF/mfEXtNJk9KvDZkzrN2GCEnvzsHXYRdnGKFHLlz79tVz6h6ZDerHr9PYICySux1CiDjTWm9H2X+GwBLEPyNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ao84frdw; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ao84frdw"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-44caeb973b3so817797fac.1
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2026 09:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785946786; cv=none;
        d=google.com; s=arc-20260327;
        b=d/yYx327xn3WS3mHb6kOsvxpAwMbHR5aVSu4ra8QSGbcVPsZ5wvqZUxaK+UM6IAg3z
         yjG+k4pjdJug/37zghCmR+kKlz2gqj6uLrPtx6dQEjdaLljjPj/AyeNekvgnafK9nEnT
         xaSceeWbRGT9fx8goWrHhvrwhNarnGRpgY8V6sOOONs9kZevjdGE21Illhe2xukKDhxk
         hVSzlC+MS3vCoK+Mc8eH6qZMMojy53AKnJCOW/1445oyMIJMdkKrQxC5epKAZSfArZ9p
         uO5Ny56R23pqpkPsTmHR3lp1AG+pqPzkJ9Y7opn4ZWD1YlTAPEERUN28qjNUZ1eViKU+
         EpXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NnLmQFysjT7fdEutzgJTYA/TXzco2hbkjkBE8lVRpiA=;
        fh=hHxFmmuaOLzT2FSSyyQP8hIOa5fDwpRUH/2LlLaXh+E=;
        b=lBcf0XcOlcebTpG2wRf7BBG6qCb9UEeoEOnjMhiY9CRoZCCGM/tWeJzGctVqJKEdOh
         thJiEO59VQgXqFTAHiT4gb9LS8a8li/43yb4GgY5oKdrmqtKDaHWWXuiN6cpLy+0Jps9
         xD4XblZaySg/s3osiGrTZqr+uDPmhffhK6gZSeia7WujmbmORpIpRIiAqKDEIO4mdOT3
         5tyKj+48QKy+mue4Ro4lWEnwPMpyJREO+OCs/HIg6dLg8prd1hYeDbImhKMNQQWYDS2V
         k4DCwgchqUnyJ5OfGghI+hV46b6iwd0+SfjH2uMT7OIetwFHfXkbvH0Aks/z6Eavb/zi
         f/6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785946786; x=1786551586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NnLmQFysjT7fdEutzgJTYA/TXzco2hbkjkBE8lVRpiA=;
        b=ao84frdwwDuntHCDJDITvoar8yvNSjOmHX/kEBcxChC2/HvL3/DXzK29ZHMyV9/XX8
         46o1+o9ukyN4tUhoOhYofOaOZ1kSKVFrbtywo16DC3qp2aSf7yWV2Ry7zPwc57lRVvju
         2NUupB71IZwPTfudUwf6BGZK8Wb1tGij8d6M+knYIfJl5+xFTevQTTM0KF3CNRKyIMjC
         QqgzIe/FKfxOjjdBRQOL3HkP21cTnTWe9QzhZ+EzLhF7q871866J0JqRfuKygZoKbuv4
         4Bn+FMkeokchSpXi3brlJDLraPp7Oacf7EDiFZiY2VSZf5XpHchW+sn4dOSpsu6mgSwa
         xF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946786; x=1786551586;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NnLmQFysjT7fdEutzgJTYA/TXzco2hbkjkBE8lVRpiA=;
        b=fR+/kFUsHNELFnKxQwrmtUt557bGNEQF9NHxJ91CL3fey5fUHyAJFZ0j7g/9GXtRLO
         ZzgjJG7sXzpghaJkvNVDsT5R5+uCpDt8B/DPg7cR3gZeOXCZL8nOGpIHYoiiQkNVzRad
         +o1+uDHpT9rG2ut8f4VtjNp7LuIbXtF17F0kmbe9cenYuD6Le9/5oCAEggEOpVdqqvzW
         CaEH5dTC3+ktWCM5qtAlv3r37aLqd7NIRjalps3ft2VVCBBQl6B46sU0T2giBiwZ4lRt
         Fc7uLMC3ZbL660PglMtGXF7MzM0uYpNl64zvWFf9CLriJs9hrAjmWZGablBm+WSZSTQY
         VREg==
X-Gm-Message-State: AOJu0YxBtLZncx9lPjKm+k0LF4eXhTB9LYRCjDkGJqA7U0n1Q+uOLdq7
	OoZzcHDTCU97r4UHY9e4Pp+cPIH5OVykz1So/DqvD2vHRfLR24vEr3iSZeJBL/O602eB/X+rQif
	iIF0ml1yvPkjYPd5LcdRVFTfhRIs3DrA=
X-Gm-Gg: AR+sD12QR+FGgq+ABn8wf8GMatl42YC9uL/knr6egHg75IVfeyFQWV3cSmcNSRfvqqW
	YgeOoOQmlDH+04EVUZPwrfWerLgpB6mvq2CgEx2F0zkIsxdrE9BQxz8VOvNUF/EYgc2/M/lg/HL
	BRQ+1SICD48xR1G73ejcAMaQT0RDsVtCi9qscyFtDAYhf6j0YhsXf0c0egxvBz5EIeU8CzG93dC
	5BDsm5eH5LvdnHu1A1tK8fhtEleHw+FuItdArEnGifsUDpgntYG0P1+yGmUyYU6A0hGoGFHrHAv
	xJTWqt7irEawYxzXGVt36D5AW9gFPQMkj1p15HD5TH4/xl/JUtYNA0k=
X-Received: by 2002:a05:6870:e136:b0:451:ffac:5643 with SMTP id
 586e51a60fabf-4599eda4d93mr4127332fac.10.1785946786003; Wed, 05 Aug 2026
 09:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805144401.55963-1-stephen.smalley.work@gmail.com> <CAP+JOzRYEf777ohK1Fk7=zuMO3ti8BhncMxEpzduYorhQ1qmZA@mail.gmail.com>
In-Reply-To: <CAP+JOzRYEf777ohK1Fk7=zuMO3ti8BhncMxEpzduYorhQ1qmZA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 5 Aug 2026 12:19:35 -0400
X-Gm-Features: AUfX_mwq-NnbVtU0nTrIeUGWAAQr46zws3HXKqE5y6SbTasyyWT4-yI2GKQBFls
Message-ID: <CAEjxPJ61+MRPRbjVM=ub=v-4n=sxot9WX_F=-2YyGj+F7gmsvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: validate type datum value even for aliases
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com, Chen Gong <reister@ruc.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 11:16=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Aug 5, 2026 at 10:44=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Validate type datum values even for aliases. The corresponding change
> > was already made in the kernel's type_index() function.
> >
> > Reported-by: Chen Gong <reister@ruc.edu.cn>
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.
