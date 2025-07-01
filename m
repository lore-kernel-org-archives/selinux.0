Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C52D276045
	for <selinux@vger.kernel.org>; Tue,  1 Jul 2025 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382751; cv=none; b=hQ70r5N3Hv64Qu6iuubmjFHR+SD61F0ODYsb/dA3p09nkRkHlyr22fqf0MEWcC577CoIBHfXwoZumbt+/ozHBAAGWhzzDGRMTPQc+lNB8O3kZgeAuodavgjSLjSELoZfZVGpIxn5Y4b9GzuVsEhJYkK+O3n3LGZwEWHkHYwx1TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382751; c=relaxed/simple;
	bh=lvfuBVjtnhVO8tACxqHu6gBp+RQ/VAAFoNH/wTAFwuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YR1cRJPdx44jHjOFDTwt8ZY+NnOcVadTYMMRvRFAssTXtNW8cU0t5QkJ3ePi1p1wecYDMv1L+bzqMGOTH/elH19B48m7Yau7ildm9nQ95EionoVkxu6SvCYnewi4ovL96pRnIerMIf+63CnEYRqkkQiSFsk1bZ0wPST02siBR4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/onMe38; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/onMe38"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d09f11657cso530480485a.0
        for <selinux@vger.kernel.org>; Tue, 01 Jul 2025 08:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751382748; x=1751987548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEAX+6f2KQ7pyu3iggNM1T6Rk3Fv8AAqfbTCI21H+t0=;
        b=P/onMe38CzUuHX4W0EcaTywIwLcvmd5xZ7hruhB9Xe0GXVcI6e8CYLUAo2ob286obl
         F+LGWJOLuyzsuuL9a5Ezw6UiAQGjiHARiCu+s3QCWc0XXrKa8hkIRYUZnFsOy36TTqoJ
         keJHnbMZ3vjr3U+PcY7u43KHghE5ExiTNO09wsKGCldNCUjiJUQSexp2OFQkAn1H32S/
         +x+6QVjCvfLd1rY0uFh2o5RTKpQ2O3M+VgiSOUJLm8ctm97AigJBkyBRmYUmH8MBkbxI
         zql0/8Jm+HdHg1VCzrvCzXbDqyrhpQmDCfXkGhyAZkzoQLTr0KOfxPMi2z5j1pP5vD0o
         BAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751382748; x=1751987548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEAX+6f2KQ7pyu3iggNM1T6Rk3Fv8AAqfbTCI21H+t0=;
        b=lXQTpZCuQRbE8e24mHAIrgR7k2pVrf3h5PwnxO0mydP0nvlA6B94NC7StxsHHS6mhK
         BM44i0VkIJF5qn/AwoCxHe6VJIkh7aKkrb5phlLjQ9JfcHvc9yjqxgYcoJmef4b3dQfc
         JQ4If2YJ7rZTE7fA8QGrSi0N0KTkwzC4UbU81kqd9hKdqLc69p94S1v2Xts1f4VFzkDM
         Rod+UrB3ercuTTlOYy2Tpb3PS48xBxbyb90NdJUI19Au8THjisFSH5H1R9GqKW3qoZoB
         scBKYw316dMnaTxdHQim8/hUcC/5zLyRtc7GaqwvYggzs1VemjAPME4KPZIMR6UIuW8h
         c7tw==
X-Gm-Message-State: AOJu0YxzKMdN4leMM8jR7f50mGhNmrxeC6Xd+4yax3SaV/xZtOetDR2K
	+McBohMJ0w6r5dfyu5r0JtCx/SYXepNmD/0fXAcac2prR1cm9+RzDVQBHuS4W3Z3ezh0mZBnVLs
	IE1/lPS7cMg1mVsOr32SG7PCPS4xppqDzohmM
X-Gm-Gg: ASbGncuAP+A5ftzmq6XXyWFyI8DSEDpkTCRDva+TNuhraZZXAcpS+/SiXrNmynBtp2r
	RCP7xzrInuKBdBFOIgWQsUQPGb8cxR7qRzn7BI+mXZ36f3MlN4DhrUzhBTuTipJ6QDt2u1CMieZ
	TwZ0TlaXjdejWkaKIbjIon0bWVxC69gq1PRvApR+eB
X-Google-Smtp-Source: AGHT+IFicahCBPKXtiitt629bWJ8RRwmi1F8pdKcFQ4RirvBcgkD14vD77GYVLmQxOYxwExLTcEtb9HxaXR+5pFm10U=
X-Received: by 2002:a05:620a:3945:b0:7d3:e88d:a1d4 with SMTP id
 af79cd13be357-7d4439791camr2280579785a.33.1751382748117; Tue, 01 Jul 2025
 08:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87bjqebpre.fsf@redhat.com> <20250625104103.140498-1-hi@alyssa.is>
In-Reply-To: <20250625104103.140498-1-hi@alyssa.is>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 1 Jul 2025 11:12:17 -0400
X-Gm-Features: Ac12FXzCM9bxgwYyYxew1EP6C2OCwwv66OsKo_rmJZ3O2xKXUm45C2y5prcs1oY
Message-ID: <CAP+JOzSRTvywkO4jXHy6U1xhSC6wtbXSZWqWQoB379vKA4M79g@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsemanage: add missing libaudit private library
To: Alyssa Ross <hi@alyssa.is>
Cc: selinux@vger.kernel.org, Petr Lautrbach <lautrbach@redhat.com>, 
	Nicolas Iooss <nicolas.iooss@m4x.org>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Dan Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>, eparis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 6:41=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>
> libsemanage always uses libaudit functions, so we need to make sure
> that consumers of libsemanage.a know to link against libaudit too.
>
> Fixes: 56d9d20a ("Pull auditing into libsemanage.")
> Signed-off-by: Alyssa Ross <hi@alyssa.is>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/libsemanage.pc.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/libsemanage.pc.in b/libsemanage/src/libseman=
age.pc.in
> index 303f8069..8b7c55a9 100644
> --- a/libsemanage/src/libsemanage.pc.in
> +++ b/libsemanage/src/libsemanage.pc.in
> @@ -9,5 +9,5 @@ Version: @VERSION@
>  URL: https://github.com/selinuxproject/selinux/wiki/Releases
>  Requires.private: libselinux libsepol
>  Libs: -L${libdir} -lsemanage
> -Libs.private: -lbz2
> +Libs.private: -laudit -lbz2
>  Cflags: -I${includedir}
>
> base-commit: 2304becd8154eeab084a7ef31b29048c0a780e84
> --
> 2.49.0
>
