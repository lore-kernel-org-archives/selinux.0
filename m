Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A26483817
	for <selinux@vger.kernel.org>; Fri,  4 Sep 2026 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524346; cv=pass; b=VADN02zQUeEiHNqogAdj1IkBFa3xYvTXNoc6aYPHj2FPbghyVedAxKQnDkViCOisHVv1WfYoC9d5GondmmmKA5FDVHRonuuZC1YxSLJLsIZMQhX00/ZFPBbxTK8W+HdfbV73BN5jIa6pEAHLw285Z/Xpo1f5FmCvMFpx/Vjkgj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524346; c=relaxed/simple;
	bh=7LbgACDxeFJ/M5cPxpywIHPGI6e67r8GKakI6hNOd2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lw9KrelR5UJ4FVelC97M880giRoz8fUoRyHzF2HCPo8P5ztmGDg6j6boDgdwaEvzmE76tnQVQHURhDaJsDhFNObnz3UmkGWXI8SFyuYC8GUTj2CFHYy9bP5lTuYt39r91Nt8kcVWhOy8eYGjergcC3Z6eCG0ESHDBcr6fILq1ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivC8juc8; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivC8juc8"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-46ac24346b1so521305fac.2
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2026 05:19:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788524344; cv=none;
        d=google.com; s=arc-20260327;
        b=kZ4tWDtsbw3WDhHpwrhbT9MNMEjkp/exA6dAw83wseqmLLUkE4G8fwAJMwg+wTHxpL
         eNbUZx8K/4QZtnWvLEoPKHNhPvxNZskhcvMkRgEcGqrLwnNsrQfQrPHQGR3+wqN1Bb9/
         6Dgc1vxhU+7lTLVllIuk9mWk979RkTCJKZrL0+sO6HpTbR+COaHB+exExXgE6DjdpRPL
         /s5fRI+eza3EJ6GmaRhhNpIEG3cmY+HibjCFzKpJRNoVA/fXli8HLL+3UE8CcSWBCXqV
         BD2hLN5jfj1yO4qnwnJlW4ceZyyKMhsPD8v74+86cwQuDC3uBZqj37iFAdK3I9eaSh8s
         5lEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7LbgACDxeFJ/M5cPxpywIHPGI6e67r8GKakI6hNOd2g=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=U1wA3LIH6FPKwc9VeGyPW4ygFIb/P8NKI2+k3EK+YF1BCHdGJuplZvlcqM0VL/CuSe
         f62QPG81gouA8oQf8pCHnBmI6yavVcx/8i5DMawcvwQt+yrM76f5kmCImo3HAoeAo/Y4
         WOIXY1kj/8KzH7LCi7fBxPZqEu7tARu5uN+sx6+liF+8bByUCy7qu4cj+/9A5ygM0IiV
         5SRVlUMzkX8KojjG15t7G9wOFxy/JdfgSGosUU0z6YYbNrESHPSogPJVydJdpWrcywhE
         ZzpqtNI+IleADyVKz2OpJApOecK5dEdKy87JpvEKylNFzOClB4xqDQWUNvgfRbZPBXus
         7qkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788524344; x=1789129144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7LbgACDxeFJ/M5cPxpywIHPGI6e67r8GKakI6hNOd2g=;
        b=ivC8juc8FzO/0L6WntT4mSA6ogcLww9FK6yqJRyziOxw972GPD8SYgBalTzvq4k1nG
         3pIcSvBNIXomIYkkGczc4OkRTW79MIAzTSxy1lt3qR5VG18angNYdUZHrk2bua4QagAq
         Ga42K4dejZ/jdCWJU3hG5vvW+CS0ODa1X0mCGek3xkhl3u8wF3gtKY3GD8BEnu9ONyUz
         jr5UC49dZY+Arh1KNal/1rAp7V3GseBaM2v37wHm37YKBXMGwWPMaphO37yqrzqpcRb2
         HIXfpGGdSsGdueYoMaFgty3ZZ7upMqYlJb1mGt9p9zIOahcXzoSLT/DDa+8K8DlWugmZ
         4hOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788524344; x=1789129144;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7LbgACDxeFJ/M5cPxpywIHPGI6e67r8GKakI6hNOd2g=;
        b=gEexlp3gCwuh+C2770Xy7zWh1BJxqFGGjtxGY9tFDN1vWBOHZ2mNi9SsSIQlC3hYnQ
         Fiist5eUsLeuI8FL9h7hhn+i80jFO5qoEwQNcLlINIupYEcXRwjoPthnaBNL8+uc9n6l
         ayT0V4rY/qZtdsfgxsOKYsQB5/JFQqczppjmovtjTZlSuEyP9xNYzqKslPjv7Zl7Xj9L
         HVeAruV5qt0/e1RLlVALLy0iykEZlktCtwJ19LCbJH2fcQHEry1UBmoQDJfANY0/I5X4
         vJwEhCa94slojaO2asJzhgjSEkV7Ar+pAM6ekPVqpHpYourf71MjRDFNIWa+Ko7ggtW5
         KPSg==
X-Gm-Message-State: AFuF++nEV/L7vw/HWe/a+saUveE8Umenaq+MUsn4UhRBPBCy/+fQQV8s
	NuYwFWXPYtTsf3ajYEuigjD2XXg6h7RzSAWKBDyItY+Mn+efS7ef8tHELrgbgfoTxz4sY8pwEjK
	ZfMUcrUUVvgRrKOZ0vekDaTtPQNeSwwuDPw==
X-Gm-Gg: AYBFou2Ldo/f3X0f186VsgzeEAv6BcCuSskVrwWSibc/4qD4St9H0Zm3UhvxCMgZFl6
	FlrTEosWuMlxHvuHJdGvG02HUjIWqvNbZ3Wl3jNrKWY6y42+m92L+FRLADge4YKS+BAAmJfVd1z
	Gz3cbGnKCRiRc1T6MGO9L5u9wkCoqhjUxSqngYhjsxN12CmzOFdsJU6fgtxFeWatKiBGnMoXFc1
	OtWsLlSHhIu5crgC+qfsxR5Hp1+maG0KIJyoFw+S+A7/uwtCp4mhLSZ8ykvjoW/Um5fPA9DizOO
	h5Frf/WEZzCoIct7vLVn6Oec+MN8mEDlWCUtQY1irZJN
X-Received: by 2002:a05:6870:870d:b0:475:a153:2dc8 with SMTP id
 586e51a60fabf-475a1537cfdmr2350509fac.30.1788524343545; Fri, 04 Sep 2026
 05:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903201323.138212-1-jwcart2@gmail.com>
In-Reply-To: <20260903201323.138212-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 4 Sep 2026 08:18:52 -0400
X-Gm-Features: AcwNN1VhkBqfM9DnWCanMlILf6xVfFvCeeXX91sl-FcRQWX9rMPtaUDvsUIzyvY
Message-ID: <CAEjxPJ59X1fEk=0bgRQvXbUg4=i65-ZbpXMczQwUuGAiqf0SGA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Improve validation of scopes
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 4:13=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> The validation of scopes can be improved in several ways.
>
> For non-kernel policies and excluding the commons scope table, every
> key found in a symbol table should also be in the correspondeing
> scope table and vice versa. To validate this, verify that symbol and
> scope tables with the same flavor have the same number of elements
> and then check that each key found in a scope table can also be found
> in the matching symbol table. The function scope_read() in policydb.c
> also checks that scope keys can be found in the symbol tables, so
> remove that check to consolidate validation.
>
> The commons scope table is always be empty for all policies, so fail
> validation if it is not.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
