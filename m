Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6053A1494CC
	for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934328; cv=none; b=V/Z24EbFKU/f3Ck10xlkmJY6IcSlbfvmzIj/ECYyDMlH2X/yCz/CbkpkP/jDlqziSgfUMRBZMxk6AzbyQMbzqI0wfbU/YNRuKQgP58V7rNjekBp2sd3Sd08awx2RToBkx1tUIj9J+uoLc3yj+JbcXUMcyIqjA4qALmRVDW4ItNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934328; c=relaxed/simple;
	bh=+wYV5Xv0EAaZ7y9QLEZ2We+6/+m0khA/IJslB2yeC4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W85bQy4cUTEAvSB/pCEFiijE43UYNnOXo/MAtoxV4ddTRlfhxo+hK9ByZjKzmsxFp3jsI8JQngzul00Xqmu+kLtHfIrk746kVxTrBCRhF//F9RJz9UVQBVnlxygHxqSYeigLiqyhi+I6t5hhFW8rX/meBk3fQOrdlbihMujKjLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqAlyEwM; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqAlyEwM"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4afdd15db60so1418302137.1
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 08:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733934326; x=1734539126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyyLC6DaTLgTSbxIFcl9H/2X8G9DoJTMHqusw/vLL4w=;
        b=VqAlyEwMwyZk8FR52z3Wd0o89rttMzPgosRgblVWsozAAYzLzaWlP3P3yRjC5j6TGx
         563Rog7VVRD+MHOiR2WL3FroQN7fPGUJaepqC0lHD9DMqzVfu7hJ9O3YJyouMODgoicp
         3LNIArBBVvwyhFQYtKy8q3KS5286Lq1+ao6MApUtFphsK9pWVetJpzPT+2JWqBQ5nQ8x
         7c/QarQ2aFjLWODCTIcBwxCg2gqxyf61Aq1Pe/XBceybhD7Be/g7I7436/7fhpSwQpov
         /V3rcUmEHYPb86XaBfpPCu3i1SVfdX2Aopvvi+oxh+lVX/nTsl1FLZgrKY9FwaU0ZGo7
         DE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733934326; x=1734539126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyyLC6DaTLgTSbxIFcl9H/2X8G9DoJTMHqusw/vLL4w=;
        b=ggDk1cff5jF8DGXFeVqXTougm5AboISEm22U8g0oQo3yumTxNIU4yXytW7RotTlWfE
         TtjDWqnvpKLwDgmZw1z/Bg2sNa+xrUxlo9c57kbyVpNWJPtTZrQLSvlU/M/cRpLQwNqU
         Hlk9AP/SoESL7blVZIrv07WUyD2tJ1tLBXaZxFMbJRyUY6dw+DHO0MqmMxkG5gh8mfts
         e+xjfqPTTNvVwc5vSleL6TFL4MM/dDWXz+wr4tWQybN8/OdPjvDIF1lVStsWnRuQ1wnK
         F02guWrt+f/MZa2mqNJm7py+fUmMXgxMbPCfr5Oq7xuYM1u+LPtyUsVk/l68hIZrTGX2
         SCVg==
X-Gm-Message-State: AOJu0YzgWllb742CWTMiNKTLlVj0mdA1QYT9p4sAS8nYGiUlk0isna6h
	41EXf5A7Jl+8O1Emnc5MJHk5DYSf9EYjRIgEVyHDtg12jYH3syhfpMUME/H5vTV/SofPJJyDiWx
	a8VjuK5OoOW/nNFLUnZMtNGzBYEnwag==
X-Gm-Gg: ASbGnctU9u50v3MZ5PW/u4h20Nnn8VTDRVP/ZMrRfX14AgB6+biF+ibqUvEy1j7x2oo
	3f+x5as1Yj4pZKMXkgZJ0Za5dTY7tV3vyUz0=
X-Google-Smtp-Source: AGHT+IE95N0ApEWSw7HemZxqqIKsXcmO0RjULxWzrjAiWysaGCii9Soo7enninljxjqvtS9v3EFaK8ifW2nuwjABO6Y=
X-Received: by 2002:a05:6122:1348:b0:518:965c:34a with SMTP id
 71dfb90a1353d-518a3a1028fmr4043849e0c.2.1733934326091; Wed, 11 Dec 2024
 08:25:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211161417.126236-1-jwcart2@gmail.com>
In-Reply-To: <20241211161417.126236-1-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 11 Dec 2024 11:25:15 -0500
Message-ID: <CAP+JOzSM9CN_gV61FyeWdpw6ZB7EF+XhpVqr0Hp-+r-14JOE4Q@mail.gmail.com>
Subject: Re: [PATCH 1/9] Revert "libselinux/utils: drop reachable assert in sefcontext_compile"
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com, takayas@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It looks like Christian was able to fix the problem, so ignore these.
Jim

On Wed, Dec 11, 2024 at 11:14=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> This reverts commit f50abe2a3aad0716a0711cfcc07f934f4a9d2b02.
>
> Needed to revert commit 92306daf5219e73f6e8bc9fc7699399457999bcd
> "libselinux: rework selabel_file(5) database", which broke Android
> file_context matching.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libselinux/utils/sefcontext_compile.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sef=
context_compile.c
> index b4445a1f..5d7ab301 100644
> --- a/libselinux/utils/sefcontext_compile.c
> +++ b/libselinux/utils/sefcontext_compile.c
> @@ -188,9 +188,6 @@ static int write_sidtab(FILE *bin_file, const struct =
sidtab *stab)
>         if (len !=3D 1)
>                 return -1;
>
> -       if (stab->nel =3D=3D 0)
> -               return 0;
> -
>         /* sort entries by id */
>         sids =3D calloc(stab->nel, sizeof(*sids));
>         if (!sids)
> @@ -206,6 +203,8 @@ static int write_sidtab(FILE *bin_file, const struct =
sidtab *stab)
>         }
>         assert(index =3D=3D stab->nel);
>         qsort(sids, stab->nel, sizeof(struct security_id), security_id_co=
mpare);
> +       assert(sids[0].id =3D=3D 1);
> +       assert(sids[stab->nel - 1].id =3D=3D stab->nel);
>
>         /* write raw contexts sorted by id */
>         for (uint32_t i =3D 0; i < stab->nel; i++) {
> --
> 2.47.1
>
