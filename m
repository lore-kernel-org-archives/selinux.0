Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FD93F485A
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671638; cv=pass; b=nLWAKVcZkliIyVLZw1oy14YpV4mri5VhhzqoVQflK9XQNRQLGgBLm0W46cdODP1nhkQzvPinRaWwSwrjFdSKDNpUcb21GgaQw/GJlfpoqIwNXK9vgPlU2ehFQ/DbJqL/lASTCfz3T3IL0/Z/jsV3L+aaQzkFXPRW/MhQA23/IDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671638; c=relaxed/simple;
	bh=AIQ4orr/U9MZmQ6Lf142tryT0ODvlUktE0uubRU/QJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npQP2fQD1Kj1NwBSQy9goyJho9lOh7YTfQRJDEIHdKCFi/PS+2ukInX5c7x48WRDZNOHrnYt8A4c4F++ooTy1XhFscgBSJ97Zkc0yBoGQVuNz5IwQf/ihtLQ0rnPOzPCoa27CEKMh6en+ovoD+aWDPcr4qN4V7G0DjY0C//eJpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObHjW61P; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObHjW61P"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-396775c2720so19097911fa.2
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 08:00:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780671635; cv=none;
        d=google.com; s=arc-20240605;
        b=dPxygPAOFnOtCtTg02qL8xZWxP+w6qvBVjcS3YnjdCyhR7cZSZMqpLy0lAC6bFqjC3
         f3oH0sACUwN7C673uRYgwV6GdTlj7YEza0NCYkxIfoxLLmY1+tQB/lTMiiUxDb379pWX
         FjffME7EnD4DAyfoIOCWv3rskznzat8+w/K485Eicu31I9wdg4q7XFlbKOZ3wuzxsq4k
         ofDVqXvxm0IT1hOO72azr3ipsX6RgULk0NcqJtwZzFq2pFXhG8I3g5z689Bzli7S/btF
         /Vc5E+/l7i4MHpwEXrLeSZPewDsAJcz1O3mRY+CKikZH6huSr4AW4FuHSZUP7e6k5TUx
         Eo+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+aSYY3Qm1L7gcg3MOBMa1mxMl7Abo3+Fhd13WvOvBtc=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=aoZw4b8iqGFOgZorb/sY8gNJdcsLpfUXrmhc+WKaYxcnjgUyMlEPyikj1994DZ5JLO
         lVl4NwJXpFaJc7J0G3Y1i2xdKT2iW3sPJYqCRPA0z8mJ9iA9ollI2KSCCZeGj7cQaM/8
         6qzXsM3/cWq97v7o+aiU5YAVFNAVjOiB5hKam0ZvO3VO2I7MO6/c7akjLi/6ou64Ia8D
         SsiNBgB5TcXytEjjZGzPg9kY/sUG1+kdsIyeDLd/iZKMaFhFMlY6ryhHhD6PhGGVY6NR
         qcq/9qOWa5qmGp93wwNier8IhPXScYBLXPS4y2XhvW8VEo9eAwgiZcos6M2eZYkhihV9
         8+2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780671635; x=1781276435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aSYY3Qm1L7gcg3MOBMa1mxMl7Abo3+Fhd13WvOvBtc=;
        b=ObHjW61PqoN24V6A3owfGwG0X4W9RYm6DCb8lgDSrv5WGPKoQWq1mLSaIrRAytmkva
         438HHkaxklXNoDH/ycEqseB7571Sp0ulZ5AQu/2mGTsn9VSZvi9wNCuSJItJC9YpGn2+
         twUV2YdR7F+cgWujxATJjjLYIAp72Q8sDVFk8FCdmt1gGxOXXrUDn7dkC5f7LJotPB71
         rFOZALc67SsKUb2hEsf8dd4FmjRmabKkBinjCZ0Sd3lBWHRJzwm9JLgQ6uoyPOrsf8gV
         QVxsiX8g61UH0/6PjcexZjdqB4seT72Oa74LMQ/d1HP/1VyWbK0ZezqP0iUksirhueKE
         41dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780671635; x=1781276435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+aSYY3Qm1L7gcg3MOBMa1mxMl7Abo3+Fhd13WvOvBtc=;
        b=YE0KvhPIjoHZI/fm9o+rLSHs4U4mLZ86yTHvNAablouoKvMJ2jxuNt+dl2bVXdpfNM
         io1hi994kJI26+a1en5qZKD6qHuN2aDd/QI9JugYFmsNj9HAAM02Qyva+RKVu6ng8SXU
         PV0Y44rQJpvgFYS/oyvJA7RamLotabce5bo2FjE19wIirFyTrFYMAfAbNWJGDoRx8sPo
         GaViXkHhPKF+8/jjpfW2hcknL768DfQA1COoxo55O6/SfhhP5FejAL7DUMOrK9SPVDeu
         yfqq6M1WtYVns8AqXDNwzoQygWvOJdfBuVAbXHAXobaQ1gChSOLxek38KRKD/I3FUXvN
         MfiA==
X-Gm-Message-State: AOJu0YyoiUSriqjzfPts7u8A6YEO5Q/IYv+kc6AtFHNkiGCsn3iQQkWR
	kw/clVC8weT3wKUqFvZ8TeiM9UyKSkoDB8j1NGEW3i0jt6m1ygInRfZ2wiwmH1eZjw4noKPS2r8
	SSRDAdkc8fGFdDnpq2xQkYnhUlwSwxoHHAAWB
X-Gm-Gg: Acq92OHaGNfhBQkN/NEjUvL2AFLsIJjU48Hpt2ciEqDe4q2Ein4y37TyPzOgBnQqjT3
	rFMvGNZOgMh/YbNbqp88hnl6fmQqVwjWhyPP0JCsOZW6B23ai2n7PGaE6tnSpL4nFX9wo9rd/4P
	9KfY3ckj5vO4dHDhj8Mkpi6CuYfmW5MPYfF0nCZdyVo4YkoodWJrTbdOAp0Stjvp9WqW/qVvO4i
	GejXY3t7jCSQ+R1Gv1/JH0XbSEM/Qg/0aXIp/7++0SAwmc/MY1FxK5l2P2+to0rVlSDAQJsNoUf
	f8iYabDp3tQyZ74=
X-Received: by 2002:a2e:a5cb:0:b0:396:7d75:447b with SMTP id
 38308e7fff4ca-396d0993bbdmr11893751fa.24.1780671634588; Fri, 05 Jun 2026
 08:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604184219.265741-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260604184219.265741-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 11:00:23 -0400
X-Gm-Features: AVVi8CeUoj6SWOUixvsurfISZpA4ZabSt3R2Xub74WX-GkIJuZrF_KDur1qMk-E
Message-ID: <CAP+JOzSNORjYhvto0_OiomqL4c2mMDWc6-m8q+wTMN-yeUK8ng@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix REQUIRESEUSERS true/false handling
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 2:42=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The man page only describes setting it to 0 or 1, but the code
> allows for false and true as well, but reverses the sense of the
> comparison. Fix it.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

"make check-format" complains, but that can be handled when you merge.

Acked-by: James Carter <jwcart2@gmail.com>


> ---
>  libselinux/src/selinux_config.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_con=
fig.c
> index 364e7dc8..1d3a441f 100644
> --- a/libselinux/src/selinux_config.c
> +++ b/libselinux/src/selinux_config.c
> @@ -210,9 +210,9 @@ static void init_selinux_config(void)
>
>                         if (isdigit((unsigned char)*value))
>                                 *intptr =3D atoi(value);
> -                       else if (strncasecmp(value, "true", sizeof("true"=
) - 1))
> +                       else if (!strncasecmp(value, "true", sizeof("true=
") - 1))
>                                 *intptr =3D 1;
> -                       else if (strncasecmp(value, "false",
> +                       else if (!strncasecmp(value, "false",
>                                              sizeof("false") - 1))
>                                 *intptr =3D 0;
>                 }
> --
> 2.54.0
>
