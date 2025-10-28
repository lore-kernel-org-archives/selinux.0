Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCB416DC28
	for <selinux@vger.kernel.org>; Tue, 28 Oct 2025 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654172; cv=none; b=EbbTAmBtVEbMldFSppyosW5q8+v8WUPuEPLv6XGzwOwCF6fk5evXXv7JcAA9DS0BQtBDnB0ni7JMXR1ieKnBVTqFsPwruOZKpQy6YwOuv0TWeUtoQbYXSmKjFUHZjRm+w02NmgfGj61Aer8/LUr+ToMXalR3BG4mQ8ScNLM7K8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654172; c=relaxed/simple;
	bh=05DkbFkuh3dDmyFSSYioStK5ZKNjkIy1q7/oGVaWecA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrhBjUO+lyks/B96msFHXUQNyYXFEd9INrggpaRvXBFmsLvhU/w9kdfjIcnBgTy6KVpMtmQzklvpiD3r/LxGIPa5WEzG9mNvgJcWD9hRDfmGRlVOP9pjOImD5UQC8iAQOfaum8wbzSU9x6Kzl5uuyutGqcZDvJhh27OdaBFqvl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndH04Gve; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndH04Gve"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-290b48e09a7so71257635ad.0
        for <selinux@vger.kernel.org>; Tue, 28 Oct 2025 05:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761654170; x=1762258970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XjTX+dGXZ2wPXeKwWm6c1iDEnsReOlhYN7XgQfAsdI=;
        b=ndH04GveRshZyabztVvzTTuHKgb2Mmpy6IF+MlM8mbmRdiljm3s9aBcUSNw8pDJ9aZ
         JN5nzSF2OS4RvAvb26n+0j9aXrwXDoiAxy5hdsXNRFqTQ+h5dU+P3KhQ+bqt4ttfQzcF
         WzOlyBjiddhhRggnXZhRa6o+JrFWMDAA2foGBaUf+iq11rTIMCPlvQBIFTRJBn94o4Kw
         KG2Ii5bCpQmAneLJqg/NlT2m6/8CY18jpuYUFPgqBceAAQ6j4kFSDSVTefopUTDQMmtn
         DY3wQBa/38+DHwytFwQeNHjquCKLkLOR5lIe6UUTeh7LeFv8EM4unMcK2Zx9iQrXnUoW
         qkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761654170; x=1762258970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XjTX+dGXZ2wPXeKwWm6c1iDEnsReOlhYN7XgQfAsdI=;
        b=bWB5nAi5X4w2oNNlIxRjDJxLrBRfFLYS3SDJZZ99yh4zwUK9jjT+EJ9Bh/h4nLW7vz
         JhMbU3pTBiuJKYjfDR+e8iX/UvwRdTDoYJ+SH5NxqLOVnGMvIwgnIBUJwb0G669VOo3c
         DXcTi2M5rattcl1WjcKuHdusKdkX/4C5Nytjb3Npru2DAu+gNdJMYN8gw1uI0o14zdwq
         6k467Opz0v69ctXPkEgU3kBUeIU0Nw1+MwkYR7wDKSUCuBEyURxOP4mQSUfv1jKB1UiC
         RXK1DfibUFNhbGt5APyHdoAZYwO3iihUPXNl29ZXj+LCc/l4fdl1wUemvVN5P0UvStZ/
         ckFw==
X-Forwarded-Encrypted: i=1; AJvYcCW7u/yASwvIsRPLQbkXbbf4NYdeMWRClO0UggLQZLTEnvwikocwv1guKm2xKBPEk1arydhkAf9K@vger.kernel.org
X-Gm-Message-State: AOJu0Yz30r4OFBbRjKYqrpfYqR+/PeACFngr+1HkE27jrf4E4IeKlWfR
	6U9wtvsRGGLC/F/Ez96GhxIfuq4znHzN6m4l1tfCMUl4NMXT85qrVOhBqacZwymD66mliHfvU66
	+Hr7UnGhyaCHut/O8b+C8wMR7vIT+7f83BA==
X-Gm-Gg: ASbGncuGvRctcSvYMW35coF1wvIRp+roOh1u8rb7avIqevWbuQSFwQr1Vcr/8ApRGVf
	4Xh+xvkEcKjcILlOo7ylbU/HjiL1RWec2qUzRohiUzrapLZ8rXyr56e5hUe+vqwsBDaV3+bYXn0
	wzDa9YRItuTU85CTGnyqVQDWUOAr79ecr/2Gguv4C1bXYOmypMLE1PkoS1o76N9AQhRMPftquz4
	+Y2ckvi5ZzMgB7qrKuO2F/hYh8SPzlLarVjdXxxSbUcAa5+T7FPWz7oJgiK
X-Google-Smtp-Source: AGHT+IHjusAPOcdXYJQI4jko8s7LspMzJTfa9WQVs8+jmVwqj+HqU/VMjWApUVbXuPuMwPYVP4sbolMmjELxAAybqz8=
X-Received: by 2002:a17:902:a615:b0:252:5220:46b4 with SMTP id
 d9443c01a7336-294cb503e0bmr26885835ad.37.1761654169953; Tue, 28 Oct 2025
 05:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2b6896af-0fa9-4498-b33d-aa6729d320eb@googlemail.com> <20251027133009.27951-1-nvraxn@gmail.com>
In-Reply-To: <20251027133009.27951-1-nvraxn@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 28 Oct 2025 08:22:38 -0400
X-Gm-Features: AWmQ_bkxMzg9LQrl3TdqN21eO10erV_BP81BuX1hfnK36PhwyTziomakkofdq1E
Message-ID: <CAEjxPJ4jsZ_bWrLF=1si18f09p2Q_TEPWf1rd_a9=_kCb6iTEw@mail.gmail.com>
Subject: Re: [PATCH v2] clang-format: add check-format workflow, update CONTRIBUTING.md
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: cgzones@googlemail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 9:34=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Will defer merging until after make format is applied.


> ---
>  .github/workflows/check-format.yml | 13 +++++++++++++
>  CONTRIBUTING.md                    |  5 +++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
>  create mode 100644 .github/workflows/check-format.yml
>
> v2: bump actions/checkout to v5
>
> diff --git a/.github/workflows/check-format.yml b/.github/workflows/check=
-format.yml
> new file mode 100644
> index 00000000..9be8b629
> --- /dev/null
> +++ b/.github/workflows/check-format.yml
> @@ -0,0 +1,13 @@
> +name: Check format
> +
> +on: [push, pull_request]
> +
> +jobs:
> +  clang-format:
> +    runs-on: ubuntu-latest
> +
> +    steps:
> +      - uses: actions/checkout@v5
> +
> +      - name: check
> +        run: make check-format
> diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
> index 7ec8cb0f..98467d5c 100644
> --- a/CONTRIBUTING.md
> +++ b/CONTRIBUTING.md
> @@ -53,8 +53,9 @@ When preparing patches, please follow these guidelines:
>  -   Separate large patches into logical patches
>  -   Patch descriptions must end with your "Signed-off-by" line. This mea=
ns your
>      code meets the Developer's certificate of origin, see below.
> --   C code should be formatted using clang-format, using the .clang-form=
at
> -    configuration file at the root of this repository.
> +-   C code should be formatted with clang-format, using the .clang-forma=
t
> +    configuration file at the root of this repository. The targets `form=
at` and
> +    `check-format` are provided by the top-level Makefile for convenienc=
e.
>
>  When adding new, large features or tools it is best to discuss the
>  design on the mailing list prior to submitting the patch.
> --
> 2.51.0
>
>
