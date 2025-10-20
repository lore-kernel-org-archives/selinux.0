Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1301A9FAB
	for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968905; cv=none; b=eqRigTMwiIEI/ZQb09p5DHwK+DGnkWgYUzgHQSRKyItw7sjhmZer6+FQzSLbMiMCIUZmqCQYdqOLtFjQgh7kjByiZD7StRJhIoUOZHZMnHUXQjbXK7662sucj8JH9PRYniIrvf7oUZ6F6AYkOTd23Z1IVTQOBkgLN4IXeMkOfCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968905; c=relaxed/simple;
	bh=Qkmp+irLEunpP95M2/ujT6Ugu5cYyg9bT6Z74zLWdk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlniAAUZ1Qct/hPRKS68mivDkkB3UhdJ5mApYiwZU9vaIg6oIPq4tjEHXMCkpzH0MzALBsOfbsdbtvkatrLDaOqs0lUvoSrnlEf6S0eg34uY1XjQj1ZNNTO3MwZ5YjLoAPSagWHQnf6+o0dNcHgAXXRqkztvrMMyRvdIp1S2gRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7u4pllD; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7u4pllD"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so4019057a91.2
        for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 07:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760968899; x=1761573699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emsp3LiGBLFCaKTFBEiGCT6LR0WsygLbaSc0B3LV5AE=;
        b=K7u4pllDPh/w1u7gTIZaZobykAA7VVLXNWNmCTyU0mAF83KPjhw8ClOv/Jsr3cMjui
         IWdmTg09wY04zGpHU8zdicHuNOryI8821XZIxqa3MWi5RFDjpVa5Tf5zbOewFzWKLjDz
         wPOMf86pn/HS4iWV9Fji67vPwbmZDrH0PLLzOnoMp6VDlUYAdf6kNKHzpwPWEvnV3zlT
         SQGIxB2RthH2wXa+eESBxaHsIBeOUruJMoiIbpS+ZUz1Cjm0ETmTfJCyJ4muZESXt1yk
         Fy9M2teBEVaPqzJaQKN76Mt4uXqHT81vxzsbf4BydZnv6oc/yp4E6mA25bjQHH3v8kjz
         DtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760968899; x=1761573699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emsp3LiGBLFCaKTFBEiGCT6LR0WsygLbaSc0B3LV5AE=;
        b=ZjoB2yb6D8vM24soW581M7ody7ot9gU91Oepg9ZkivTQFKMEwJUhDVwBZ6z5P4EAxq
         uel+ul8G7yD2JWzQD6wq6TU1cNvNCowkhzTqkoSMLCHda3WS7mWuR8rZXShNLO0PiqoU
         M7TW9VlEUmnSOdAsGHwJlhwqFlKi9umYJxthnpcrTLGbrKqPzoRnjUZwXacmxSoTJ1sL
         J41PyOV/gU2a5ElepSJsRF1glQ1gKLCnAtEYCe5z05WAa2RlkvFPFOrzdAcdb6sfHW8B
         uQDx5Ld4ODlOENE65QPx01yKqJ9413lM4JbNC0vXWI8qNGRowk70I3/V+WagQw/RgH51
         nbzg==
X-Gm-Message-State: AOJu0Yx864J5XTJBQytRAJzpUt/m2UsdyloYHMUKTdJdhBCm0AINLZsy
	66JgTYY/lsb82P8PtP0vLUdYeuSXYDPWBulYnekpflNxLdCCLhJFa/4ZYzcTRv20wt9rmfIXYTP
	ilreCkYP4mAOrNv4Xn/slDuuvUz5NPkk=
X-Gm-Gg: ASbGncuWQlAg3Fw37t4OBtGGkudBAOFIQNtSIUkSbaskWMat0pWCTtjobiUifVVNgYw
	DQvhA84xV9dgB0RiYHJNm97F/84fAq/+kg6vRAUhXIuTi23JHr/oNSOJpDIvE2FyWsEQt0Mo648
	wdlWGzlNV6mEpC12lte780YzXxwEcTVD2URx5t5dJCrh6UTaIJzemDTO4jmCnNfJfQY4nPueiSX
	ZsO4pgS4y4DeY+HON9SjKreIvmnB7BAJRRp2BN/wwSCcSSbQMOSal47zgqC
X-Google-Smtp-Source: AGHT+IGJDqtNlL6c1vAEy7pUynTu6SXGbK4NbzxjeXU2fu0aypON0LhGk5pxAZGqHChpHpN/53w4AfDVJfEkRaAphxY=
X-Received: by 2002:a17:90b:3ec6:b0:339:ef05:3575 with SMTP id
 98e67ed59e1d1-33bcf8f94c3mr20644397a91.26.1760968899306; Mon, 20 Oct 2025
 07:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018062741.57106-1-nvraxn@gmail.com>
In-Reply-To: <20251018062741.57106-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 20 Oct 2025 10:01:28 -0400
X-Gm-Features: AS18NWCNyGih9KuWwKgRx4QdzFj6RiiQghvWSGo0kTwS5QN1Hz0vPqPt6bJTcDk
Message-ID: <CAEjxPJ7AgnNUL4gZ2=tOM60nXsZAgWAo3Yhu=34xvLX1DWt8EA@mail.gmail.com>
Subject: Re: [PATCH] add an editorconfig file
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 2:29=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> editorconfig is a standardised way to configure editors for a project.
> Based off the Linux kernel .editorconfig file.
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  .editorconfig | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 .editorconfig
>
> diff --git a/.editorconfig b/.editorconfig
> new file mode 100644
> index 00000000..2a2282df
> --- /dev/null
> +++ b/.editorconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +root =3D true
> +
> +[{*.{c,h,mk},Makefile,Makefile.*}]
> +charset =3D utf-8
> +end_of_line =3D lf
> +insert_final_newline =3D true
> +indent_style =3D tab
> +indent_size =3D 8
> +
> +[*.py]
> +charset =3D utf-8
> +end_of_line =3D lf
> +insert_final_newline =3D true
> +indent_style =3D space
> +indent_size =3D 4
> --
> 2.51.0
>
>
