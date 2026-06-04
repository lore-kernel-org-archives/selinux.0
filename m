Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1D918CC13
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 18:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596390; cv=pass; b=iVUdTvOE0ZKsQ2sQN/YIhdJck6mbKjuirsESK87fpWXZoiHvVXej6r/zKxOFoCuC7hi2/on8BO8VFnb6U7fg5sG21Btt2IXJ7WYzDRCtLw1IwGLZLTsBSAhOADoKG7xdotcwmWL5yF+xL6UFy1KRq/byHq8/hLnH3/UPaS8rkHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596390; c=relaxed/simple;
	bh=OUsjWviXtbmVAcijwFFoyPnOBFuP+X9O1Ch+EOERUjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6U+paT+qxp0o0BiaIDd/y3FXul/o1zOhUaOTiKoHjZ591x4KQLMXkEKJWBVEO5Lxjd8opmE+BB3gMla1rHN8J5VC7Jz4G5rJ4cPg6NdIQUf83dym1O1HKzyB70oYpqQ/o40TYTCi50QlgC+5gtjL8NsVUk5yvcVVwYrzxI7VCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TK+KbbDb; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK+KbbDb"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8422f395a4aso683920b3a.0
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 11:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780596388; cv=none;
        d=google.com; s=arc-20240605;
        b=KeSJvq720kUU0/oPMRRH3NtWUavN9NXT1eFgbs9/dREFHHT3PF5TehVlMClzViP49y
         NY3wS/fdpsqzU8Kyp/KDGOajk/ylMsVnFHaeut9owTNlaSLr11lo4aozDXAk2I1y9+sa
         I0o/XCI053Pts6Z+JVA4enMfFdEmormUmfKBUWuLzyq8idm7eviv5KrK43f/S6FAirdD
         +js4pFkq087NmhiPfZ60fnfkDUYVcC0EgJ9sO7BEMnsUfzXxI9KPWOffo8pF0xjSwVYp
         OssXFM59y2ZfDhPHlwRuPwFp9F6+UKIa1x9N3IUF9lrySF65o0MFqkE1iYA/9nVY+GiF
         R8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l3Bga+DnK7P0BDJStp4r1Js3eBXaTpu9ognzOWIA150=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=RwQZPI6/fMlnRaWzI4S2nVTZEWJM5HEhBCXzjGoMTCg/yArr66oDS7ymCEiIqFAKJO
         EKgNLH+3dwJsyNkHkeCWcRhr0u+lghbaq+1lH/JQ8rHH5tag42aTml78ZiVqZAh0avSU
         s/eItDJUCPA6vyk8uXk2WmnQ2u47FNzDAdG+inZDcFsBc8poI4YsSOwkwUUuqwwNGDkS
         uxW6O/ZCN74sUz+2WaiqUVdUpSFVsu8FdmsvuIbQemVUGf1u8EuGydnpBe8jWttfdlkm
         wmuSKGzJCqCf6kff9/v3YtAitx/w5UpqqAgKDc7L76OGc+Us7AbNWRLyZXi9hZsyCt6p
         nWsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780596388; x=1781201188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3Bga+DnK7P0BDJStp4r1Js3eBXaTpu9ognzOWIA150=;
        b=TK+KbbDbzpiO4lv0pzALWrPXL7chajbdGeM1OJsvQKDJlral9J/OI7ZN3ZOXmH/01B
         DUKiblB8BXCe5Io7OQTaMsb4aqhaZnrUL5ypeyAXDB89oBqOJJOvLSI67/FRgr4+JwRh
         3YKHMAq5jneepX2CRL3JMa06gwKeYel5ph8JgWF4jGnmAT0qHICQlDE8Z8oEZ5uzXO3i
         LFGrW58vqOEI5rV4cj0NaO3AIJfaf4kH2eKr0zV66aIzN3WpflNBRvzXSLJn92hP+qqg
         upSf0QT7Tvntg9ZO6BbI1IVRvhz9Tl08Xt3NgdDXcTkTFDkg3hgtdLPnBZH3NzAKiCus
         Wvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780596388; x=1781201188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l3Bga+DnK7P0BDJStp4r1Js3eBXaTpu9ognzOWIA150=;
        b=MRHqI+pkcPUbV652qiFMIdKTLhmSZMOejbU+R0bZf5nad66Fy1/Las20Ii+UqnyNeO
         jVsEmOilG78NgM40yrssjrkiV1DclhD2XwBoJ2gOd04YUK5ocCb5H5SJq7GyeWDCt64f
         dSJ6UB1iY4wCmFoN0pcMYl8IV+feq0dS20RaEpko4PZu++gOMcnBAYk6LMZy6Q7SoZoq
         RMRauHs779nVpwt09O4GrcxtONzvi0ffYNu3/LwO7ziVmS0qeKzOh+HpASqCJ2YZlgh0
         3U7oOAsysqMxrYVjNkzEmftTPP4CCHVoBH7HyFR9t52hT0M504RO90UMv8ln7dQ6yc05
         pngg==
X-Gm-Message-State: AOJu0YyBEfzE74teYGafZmMr2Zl5vlJuz+GbH9jmwX4QkjEZj4i22l48
	GFvU+YJu5hWexICByAVGZxUU4IRAUABvF7O17Ma10Yzt/EW0nsW1vy0vtAsQkeId6GMWH2PUc4R
	WAoy0Ln6QnTyITyJFLy2nR63P6mh2JGCdRIF/
X-Gm-Gg: Acq92OGvQYclMDtctePnfaZGlAi/FTIbXeBk4aDhixVc3umySTfKxPmki3Uszfm8a+1
	0zmdtszpqogaBZ+T+rSRz5POyP7cyZDWQXkEdgoeVMsAqVAkUeiyaYcecTf8jYnsVn+2Vz9pwd1
	uFJY5HxtJLH4gEZKRfQbaNm9fEB0XTYsFVF9qvXAeAboIIt/3l2nKb2MAJ9P21pK1/UT06IdzzH
	C1ZbzbiAXe1s1W2RDXGK1MogzElAXXgkmUwlLIpnXEoset9R+RKhSUShWhFNtFPr9sLLZocRYdF
	R0CVD+QlPJozuk8kLQ==
X-Received: by 2002:a05:6a00:450c:b0:842:4f2d:c4e6 with SMTP id
 d2e1a72fcca58-8429b63aa8dmr3940473b3a.9.1780596388347; Thu, 04 Jun 2026
 11:06:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604175529.42776-1-jwcart2@gmail.com>
In-Reply-To: <20260604175529.42776-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 4 Jun 2026 14:06:14 -0400
X-Gm-Features: AVHnY4LWXIwYoBXvFtiJmHwqlDqy3Wslm_P9PJ-qf6yUAG7eJnPPJIUdgPrfOnQ
Message-ID: <CAEjxPJ4rbmoPSbD5GcOPnA044xQ28uqacKrxPoUphZG6pV=2Dw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Add check for too large of file size
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 1:58=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> In cil_add_file() add a check for a file size that is too large.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index 83377821..64d02466 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -549,6 +549,11 @@ int cil_add_file(cil_db_t *db, const char *name, con=
st char *data, size_t size)
>
>         cil_log(CIL_INFO, "Parsing %s\n", name);
>
> +       if (size > SIZE_MAX - 2) {
> +               cil_log(CIL_ERR, "File size is too large");

Missing newline but otherwise
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> +               return SEPOL_ERR;
> +       }
> +
>         buffer =3D cil_malloc(size + 2);
>         memcpy(buffer, data, size);
>         memset(buffer + size, 0, 2);
> --
> 2.54.0
>
>
