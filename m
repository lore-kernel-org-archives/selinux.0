Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3352C158A
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 13:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159239; cv=pass; b=ZRk10xF/2BrNgTsOawTR2Vlm8b9dSO3nCvmGsL++8rryyOTrfpnf/xepaDWKzr+c9A1mHVd9isvmNQ0gDqcDA7ja2GVY/QYTZjLAbjFncyiL5DsdZp+EBXSLp+6MExZkF/VGNyD8cyb6uz3SHkz+suXnTCqdfLcwBt1Jko9S3ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159239; c=relaxed/simple;
	bh=ORbtDUzsf8EXtRMQPDR53Pd0aTV2OJBHdOKE9zn3aH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8/PbQLtMDcE2i2vMZC7LPbeE4sGKGl4AvwaYLS/7e/d3RJbAYvHBF1COICbVOYs2uzpXRH0mq5E8gAbi78ie/um4BiiLIOTJhRkH7YR4cunG32eoDGHzILVovu2OpaFAQCAokiiG7zsMZfJiGagWP10xrHPP+f1BwXMwqc+kAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJpodScA; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJpodScA"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6aaf3f54dbeso1429558eaf.2
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 06:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785159237; cv=none;
        d=google.com; s=arc-20260327;
        b=I9GgwfwxuWNvGxq4a7zE4v3MuOEGcVdZfsq0EV6iUb9hkXHRNJqkzordsrcBvHcE1N
         riDJmI2/bgp+8NPsjUvsDBX/b4+Vsdp9aLCR3xk8sYd02soygeFJa94XZlP9EqKpagDU
         ZkGJfUt3T9t/K1d+QjTIk+6+WufAMX2wsUguA74zb5x23Gnx8m1PbUdGsx93vsCjTmOc
         YFiwqMvUUPu73Kmck9RcK8+Aq1BqGO9SwZlI1z58+ZG9aRdnXyTHEqg4XN9j36glWOBs
         DEsqGZ4upbdovAcCivirqXfgCDmOg3PkvV7yqdrYTI/TafroiB+2co85MpMrtYszDeE3
         IQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ix0OLcBKaqNms1MfHIg4+rpT9yZn6akTejcO82c2S6M=;
        fh=ctNnd7rEgrNGVRcNYAD2iHPqnd+GFVudQHEzcgGqyZE=;
        b=GObAszC4mIoMcOQTZLGk7rMPy+ziaaAkHxr0+oLaz2OtDoWMmGAiLjUJAHr0dlah5B
         bdkBw3mcS8i2GG2zUuGKmEmES41kU4IevCtodldguQ8OgQ5rb5bDtxccignm4ebv7YWK
         DOTnOMT5/LLVcmh+tIkZpAwkx6rlwckwP+QFr9cIsZoc4XEQp+IwSI8BPM20H59oOSFe
         1rELOiuIdbYAh/zq9JefjB4/uJBKwbYaEdMFfCvQ6cggpooGRr0SxD5ZAAL/xF7nsBth
         uHaDn+PYIY/DuRSm/S8xdB9ARDBJ5k08EUtyt2lirxI3an0M1AMKKvPW0RSnHrwiB7Oa
         qnkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785159237; x=1785764037; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ix0OLcBKaqNms1MfHIg4+rpT9yZn6akTejcO82c2S6M=;
        b=KJpodScAaCkUjZH/RmpPle6dO032tdAwEH0Wkuhnzh1YscL9awKRofxoJ704MJf1+q
         Nf7+Zi3vS585Mo54jI47U+Dnf3HTC4UEh7miTjRDw2mshHDzNHowdyeaOHPGE1jrF3uW
         kivwq4ercTidsHO8YPsq7G6W+2Uyspt+xNU1xn/zUmIZOFP5DhM7r7aE0n+gEj859BN9
         kdVUM9xivqG1iC0oLhefCla4Vt5K6Sp1nnRacXMveLHjvvBBWKHOQUMaaDhX0x94zx9D
         AzcyuxyFtDFrn6289A3x9tVYMVaOkjfUZL3nlR18UToB1tdkKjsI2INI+0L6tC+KBRgp
         UlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785159237; x=1785764037;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ix0OLcBKaqNms1MfHIg4+rpT9yZn6akTejcO82c2S6M=;
        b=PGqls4raF7+HEcqHVRGZu+i5wEwuzL1XboPiblXnmhJ++1q45tZgL1ytAKd08b1V8R
         oVvwV7XYKfjmLKtzczdPjSd3tRlndsQXMmBhqfEHy91/X6eXr4iiaZppc/EgvUQD+E0l
         YwAsR03AQldq6zzw65wCLDNoVPOYIkt/2M5ndI3K5SuwjyZvhRPI3yYdmSoWPyIwWE1X
         xO+XGGjPqwzk6dEH06ZgCDG+B1cuiobyeUOOH2cR5zmyj2Qn0teUTn5CRIeP6gQT6fBr
         Ee4hqGOQcpz7T1qahm+kxT4y7DM+UyVjxTob5D4mhuAXQ/uMzv9uqKuxK3/9vUAGQ7WB
         GrKQ==
X-Gm-Message-State: AOJu0Yw7S3YdoFk0eaDwKwgw8/PPWRv7tBp8CVk/AN4o3CsbbrXyzRVx
	Btj9lw9/jBleEoUHJWFtMtKe/1cZWKuAVzZ/kQJeY5sTqFQjbhR85/JE/KTebPxeQlDvDq0qiMS
	jbGgVDgeEvFix+eX42Ty0FPdpiiQUQg8=
X-Gm-Gg: AR+sD11SeMal1+umZyd0JjOYYYcPU+NAHAW60rSb5Qvf5i44RM5TleE2p2SjKkRL6Ps
	7xC6m/fVwf+yArLJg0rOJl7ypfYBHlUkTFxjYnOAWKcPvhrRbGgnNYIWx8AFL2+O+15YjI4FE8N
	bepbsEJYyCmvuXH8aAjg/AVlKBmBi5HoB0Z3BihceoX01+gXRNx6NM30QO04G1mFI52rrxSrD86
	44sl19jAXusdDN+kUkD2BuSVpea3S6K8BzqLxKnnkBGz0tcl4wDv+WMyLrHWA==
X-Received: by 2002:a05:6820:2016:b0:6ab:480:7172 with SMTP id
 006d021491bc7-6ab048087ffmr5695883eaf.4.1785159236691; Mon, 27 Jul 2026
 06:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727115247.365341-1-omosnace@redhat.com>
In-Reply-To: <20260727115247.365341-1-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Jul 2026 09:33:45 -0400
X-Gm-Features: AUfX_mxoI2fgUDSFH9Kmwd6o5cFHoDwZv27k7lPusifGfmznbSvXPtMrXd6j8fY
Message-ID: <CAEjxPJ7WpL2N7ZJ=jkNFNKpvFtWga+Ub8ufFwaPFZWzMQ=LqYg@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/file_contexts: avoid using a C99-style
 for loop
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 7:54=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> The for loop in assertContextsMatch() seems to be the only code that
> makes use of C99 features, which means that it fails to build with older
> compilers, such as GCC on RHEL-7. Avoid this by moving the declaration
> out of the for loop.
>
> An alternative would be to instead add -std=3Dc99 to CFLAGS, but it seems
> simpler to just revert to the C90 status quo ante.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

It makes me sad that there are still people using RHEL-7 but:
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>
> If someone strongly prefers the -std=3Dc99 solution, feel free to submit
> an alternative patch. I don't have a strong preference here.
>
>  tests/file_contexts/internal.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tests/file_contexts/internal.c b/tests/file_contexts/interna=
l.c
> index 22b5790..20ab428 100644
> --- a/tests/file_contexts/internal.c
> +++ b/tests/file_contexts/internal.c
> @@ -13,7 +13,9 @@
>  void assertContextsMatch(struct selabel_handle *hnd, struct test_t *test=
s,
>                          size_t n)
>  {
> -       for (int i =3D 0; i < n; i++) {
> +       int i;
> +
> +       for (i =3D 0; i < n; i++) {
>                 char *context =3D NULL;
>                 struct test_t test =3D tests[i];
>
> --
> 2.55.0
>
>
