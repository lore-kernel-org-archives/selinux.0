Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8B41917FB
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579339; cv=pass; b=KFH3tLN2z2k6VTWetIt8JO2tk0xgagPcmmCIjROniAQ0TlqsvLR5tOFd8lib/YMGPXwfzArVhSvfggE7efza7DdgoPECnDlRXxrfvJYCohvkXqmquJl/s9BYfKvnIRmKL+gUxNvI9k1tdXf52PQK9C9Bvvf6wF8igY5sO3xQwZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579339; c=relaxed/simple;
	bh=rqcmEx8Gw7L8JWQjbELrq2H1NjkQx+zcjWejPshg6Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGGAM5DCoei2Y6EtI8zdh6b+FMDkkABWyPyVDuZdIBmXfpsgvPKGlNJsVTMg3SLR7ZTRYL5RX5vKYq+Y651jtI9QMdVGdG6lMhrtVvUIYLRHG32MVmRrCI4yRymL892tSdp6HVIRB3HQqqEC3ZHJXqrkSkPobCbhcyGWCG9bSbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ls49UUqn; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls49UUqn"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so438543a91.3
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 06:22:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780579338; cv=none;
        d=google.com; s=arc-20240605;
        b=P5t/Wva8enpBeLKwmj4CT9H3E0yisM4c8LZu88Qjuh5vfj79C60zXbNrtoCZdop2vU
         uhWSOgAda446OgxgLMq83eoHjj/WOIQuvasrJvWtJPvGseU/HXLlwGDHefWcXpgoPgCK
         kC08OK+o6567h1ZtmkkJSWptG0ScTnBLfKW/WTMZXm2k9ZwUqULuONKD1HCsD9GYZvAO
         9X0+U4Q0U2SAZD28aRvDnE2Z7ZWnAihDww8FSokwzB/91ceTC7i4mzJTljL3hAhr8Xd/
         rLVIhVAKUmoapAHsOGi9RRc8QM4Fx81YT4OlvKV3l7oAdV2BbgUv/WR9gpd4aZ02joPF
         jNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y/iMjxoKvvGQgbtjQmLz5TIoHiNSZcfozYFSLQoiBWI=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=BOoFP8Ldm2zSYPefmJ/jOvLSw3axZRXKLfqnE13n3TPpM6M4nQBBsb1kwMQQCYEx/u
         hlzsHbKJmD5olppx2VMD3NuQbC1ETOougSIPj3kDmazeEWQAEYZjVXM1kOCDYWTtWuRb
         D8G91uzG9f5v5uuW7y7e0EKa/nnke0ooNrkfLFPATL1LjHXUxTVfmg75laH2atRoHovJ
         mE4Eg8r+Jgb8mGeyo6CzYCtOAVvUibR2PPd5sb1xMMcVAvxQ6FZNsnI0/AFlBO/jeC2T
         /m9qGCeIARE05obzyB4sBatamPYkR4MYoQg/UnzLCZUkuhJyZwSaGj36pf+uxTU4eKmi
         lUPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780579338; x=1781184138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/iMjxoKvvGQgbtjQmLz5TIoHiNSZcfozYFSLQoiBWI=;
        b=ls49UUqnkfAWQysCRqCHSEIZdAOKMSAFpeIO+84ICPEpK4c2alMyM2mUq12RUV+eV+
         CQ0nGZEz4X6UtLvT0fes8WJjCRmZDseVMFaEeAJKWmmvLoeG0gSs8ZIwq1+gkwpDmXWO
         q93iwVD+DZEL+c9qQH823Qtwdx05JT0xBSG0QoAoBovIN21WLWrzc1Z6mll1Xwqtwjcm
         2UVprdh+i0pOEECrIPf/VoJsgNk2T6G/DNtd/VK8I+RzH1lh1FFlHK+HbBPVw9NUmoNZ
         ULGl8vc7kwl91/QWCqfT3HmDclzIHSvfkw7TU+uF3PB8u1TUi+yv01REfdpYGv1tArpb
         g12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579338; x=1781184138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y/iMjxoKvvGQgbtjQmLz5TIoHiNSZcfozYFSLQoiBWI=;
        b=SA55gjQjwbjqf0vvpJec9NV0928Eo+9LkT7cq3A2G8uXKIeOoMr09TZMc7aBtzNiQD
         MWDCiBHF0ugTPJNvDP1N8CdUW2puxxdbEcpZqS+uS/3c+h/P6IoSwibyQDGacayXlIxK
         2pC2nwnSyXxwjGZ5upSdu99FP4MHWXMfc76DcOK7gpy6Yfnh650a3AfrznziDcgA+ZJX
         44rl1ZagNClw+fOuggH6URsZxGGlF4r8xOAsUlxIJ9iG5JdqYUQD/plFhEivMekfJOoO
         1s9PcKtcfMKw0pOyFynuWLScsXdL4XcF1uWbr5i1U8tVVU+OdAnvNbm0uMpJPmfemdLO
         Eucg==
X-Gm-Message-State: AOJu0YzTyylZiRO2W4akrDc9iwYglRTRfO3O4HFZ5iQb/MbUhWr74Rbg
	0NSCD98HnCQ+jxdwKAJRKmSGWCrUcM24zwFh3gccg2iVvO7TNiT+g4ni0BBVfJw2ASx5Rh0JF02
	1OnO239aFDHKyb4K4ahM6UbK7jx7RANk=
X-Gm-Gg: Acq92OH8E6sIbppR5BCOpc4hEpr85quQtnO/2m81i8qAhjKu26Fx25Dhvz0yDbBQSkh
	Up9kYBj6OhgSZmi8xntMW7sTj6OPoQlvN/1FajYFWErXPmIrMzS+HtUS0ReAS9Gn1BbP+NkyPsp
	0lP9G1AEgoxVTr+G5zfbLU+b/WGsYkxvErOghjh4HRjdQ5EFtVZ5Pa+u7Rzaa9Ibhf4z8m/z6il
	SOkC4L8cojeZfvKNJiH+wpjKOScw9RmDTo4D/PwYNifggI0oXb73ou99C2R7yXRQQtDCnDpUNmm
	aqmCDyybLkd+Eqo0bg==
X-Received: by 2002:a17:90b:2d8d:b0:368:ac5f:d31b with SMTP id
 98e67ed59e1d1-36e32d287d4mr8055811a91.24.1780579338059; Thu, 04 Jun 2026
 06:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603093801.1070705-1-lautrbach@redhat.com> <20260603093801.1070705-2-lautrbach@redhat.com>
In-Reply-To: <20260603093801.1070705-2-lautrbach@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 4 Jun 2026 09:22:06 -0400
X-Gm-Features: AVHnY4KHLzVOqEzXCAkUmGNJGrJjfSF9Ds3yTyJcuhQMa4q7y0jRtwyZl_FojrM
Message-ID: <CAEjxPJ6GC5ugbBuegYpKTQXt-Hq0vrZ9DvyoRE3gOU=j96j1vg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add check_format Github CI job
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 5:45=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> Run `make check-format` on PRs and pushes
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>
> There's a test run available at https://github.com/SELinuxProject/selinux=
/pull/520
>
> https://github.com/SELinuxProject/selinux/actions/runs/26875462663/job/79=
261408494?pr=3D520
>
>  .github/workflows/check_format.yml | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 .github/workflows/check_format.yml
>
> diff --git a/.github/workflows/check_format.yml b/.github/workflows/check=
_format.yml
> new file mode 100644
> index 000000000000..bb44e60a5507
> --- /dev/null
> +++ b/.github/workflows/check_format.yml
> @@ -0,0 +1,21 @@
> +name: Check format
> +
> +on:
> +  push:
> +    branches:
> +      - main
> +  pull_request:
> +    branches:
> +      - main
> +
> +jobs:
> +  check-format:
> +    runs-on: ubuntu-latest
> +    container:
> +      image: fedora:latest
> +    steps:
> +      - uses: actions/checkout@v4
> +      - name: Install tools
> +        run: dnf install -y make clang-tools-extra
> +      - name: Check format
> +        run: make check-format
> --
> 2.54.0
>
>
