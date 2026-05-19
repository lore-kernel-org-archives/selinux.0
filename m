Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D9939FCB1
	for <selinux@vger.kernel.org>; Tue, 19 May 2026 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218768; cv=pass; b=GGs3Oju9Z1nvWvT2vneFUki8Jl7RpphGYdwaB7DuLHq80+bmcwVFtK/QDk/9c+IcJCOp63CwBBFCseMXvo4p7XxtU5QVVeqr4F93N5RIhdkttGOlF1Iej6cz0FlptmKMs9eSBZqj/0rw+bqzacRy0PxCb+7/8oZIwH/1JXBFPAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218768; c=relaxed/simple;
	bh=x3Ow0c2ub5GXsyCmDR3qsB9z+OIlU8Wtwpun28gZ/Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNlZBtOuKn2+GcD1REAkcjBuKzFbFO8BNjMULiVR4Yn/xC23nBrxuCkHNhRBw1gYASdpGiajm36oM5TjOg+UjXt4yS8lNEknJ5pSwbelSFolaNRipU7+L4FXQefM/ojuZTwBR4liKTKBsvt40X642374YXIhl7FL43eA5Y08Q6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nqyri64Y; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nqyri64Y"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-366139223e4so2150080a91.0
        for <selinux@vger.kernel.org>; Tue, 19 May 2026 12:26:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779218766; cv=none;
        d=google.com; s=arc-20240605;
        b=eUwhsZCk0LQVuFIwueIbFgggb9mu/LXy+ONpizJTbQ+GcZ9cmiSJX7bt4ccNr0Nt24
         U36UyTX3VEb0YMDsB9LrnU7HX4hOXeXB3yWrp5dj6AG6iLHNAIO58jcLOtnQUKPe8T/t
         U07g/8G7cOcV5lo1nJEgq8ZOalbzG0ig3Dwl6aoWmaAztghFljgJEnFIuX+IoqkcBM/y
         aSaIKoe1//rfqpa4s5kVfIxjhsECtJPuHFfJcBY8kRu8T/Ub9WS+5EcrlX48k3Ti8S3c
         pHFT5LPxpOgpVShEULiI1FdNW1We4vwRCC9OsnQNCCP20H1zH53n7sVEVDSeKZGq+aiP
         Y93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cXNBTHTTx31gI5162il1uRPmPMF/hPCudDyIGQqqSMI=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=gYRYdAyTOTY9pjDvr9WTCEiYzm92xZymKk6PnR+4bZRC31juU2NaQsGARmdvTUU3QR
         QVHdfXhNHfuqZZtFRCgftN40H2w3hepswqdqZ0A5al5gxpRXC1AZeZ0kRiW2+XCQwP/N
         XJHPCnib0MCzuBE6YHW/8ulZBC/FEKE2cbyU4FuCAuMOYMK1fN9jHt7kjAMX2xCPoN+o
         Q4v/Bn3TMf7OYKUKbCtbGbmkK+rPpzGMJYLLhqSD//efyxT8YlSOw68TbPncyaJrNFFv
         QwRHWUB1Fu975v05TmN3wDbCIEXqiPOUp/muSZVpp7HjciUS5Av8LGX81VMz0/OAMUd6
         PCvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779218766; x=1779823566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXNBTHTTx31gI5162il1uRPmPMF/hPCudDyIGQqqSMI=;
        b=Nqyri64Yor0hzMjfbnDF4XUmfCxJJ65TcNG/5E6ZKujatNC5AqFx6hqPN0HGy2f2VX
         SLfqyFdpUoSMju8OfAkPhMn7JaVRnx8jTy1mJ4PsKeC/J2q2cdp1kit3hylfjJUqRJk/
         s9MOPqqcrg8u2m2CievEH2Mbqy6jcCR7hjw0I/Q6YBFIK+pnZlkL8W54tmiObePVFyiz
         wvPbeE2hiAGg9i8u2DotWIdJnt5+r4q+aZWTSjlcGt/8GYZIciYV+6X0QmEz3wxsEQyw
         2SHfZLzSTqyQ0IRTA0b+hm0j7hmMS3W0wiRtW5oDsNBxqDwTECcF1DfR6zJGmRlQkmQS
         R4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779218766; x=1779823566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cXNBTHTTx31gI5162il1uRPmPMF/hPCudDyIGQqqSMI=;
        b=dABL24J4BV5TzxttdKGMH0GwLCxYr+gFXk81A+j/eLHr/MTLxNo70TB3aXdRm6lRhb
         LsHzw4DCpKFZOn9N6J8dIvC0shoaL58z5QcUk8ho1aqhHwXbTZy87qPhe4avLX2AUA8H
         hLBYS9HvNHa0OLJ4+HmsNUKHO7vOKWtbRYNegkXb4DaQdH+pOghW06sADAk9UbunabzP
         /r/WjgKxoIdoIHUJeyxb+yKkP27KSnIcAf/hESUtD3deaaERY/dnOW48cV2bDkDmUgxa
         w1/ILNcrRnFYSLkLu5GMqkWwUZxzEuMijNhJK14IdKAak0XCUpDHglpADlVjTILCbnQW
         wXRg==
X-Gm-Message-State: AOJu0Yw15VEFvouh/NIFtkSz4AqspZ3vmBzpB/xUG/58b11ulC7Zvk2r
	w2ustwWSzbIjoeX3njiceWrnkpqpRsVrMdo4ZTIBGfktYZU8sGGKg20NFjz4EetDxihHUWsP7m5
	JV9wEzS2dPhKkwzbdyaj9MhsklnXCwjvTUA==
X-Gm-Gg: Acq92OGOwvxC1oVAhUl1kZ0maJwAAVbvjUhC1dwOTkAZUr1o8Eccw8cZzjBzRvHm+Fb
	mXJbrq+NgZHeUNonuCixTUiR5tEyUV92OZNa/+5hVHhV2bdMBmisiR08xAvqSoIltcM7bL8euqL
	pZZxs/h73dLoxfnOhJG5ufFPzQh9JKt50+Ey2dgRy60k4uLQa6YffSqoLJnxzCcRX+Zmgyw+ugd
	sdqgEQmmz80TCBcy5q7VqppxFiG5l/9z+RI76v3NxF/thgDx2d/kg3KfbZju2DDLZnGZw9N2vww
	7Qlnv2ZNKxbfdu13Sw==
X-Received: by 2002:a17:90b:568d:b0:367:bf0c:54e9 with SMTP id
 98e67ed59e1d1-36951cbd45emr23926449a91.21.1779218766503; Tue, 19 May 2026
 12:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519163316.450138-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260519163316.450138-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 19 May 2026 15:25:52 -0400
X-Gm-Features: AVHnY4KcmuCM8pFpkhmYqAIu6zwwRDwj4ZNuru8GA2ACNJ3Rt8TShaNaQevbqMI
Message-ID: <CAEjxPJ63hP2Zt92F5F0z-WFi+7_G_T4_OwTR7R032yAKuwsJqQ@mail.gmail.com>
Subject: Re: [PATCH] gitignore: add entries for coverage related files extensions
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 12:49=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  .gitignore | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/.gitignore b/.gitignore
> index 6ff61265..64927124 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -19,6 +19,9 @@
>  *.rej
>  *.pyc
>  *.pyo
> +*.gcno
> +*.gcda
> +*.gcov
>  cscope.*
>  .#*
>  \#*
> --
> 2.53.0
>
>
