Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592E02D7814
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638200; cv=pass; b=phQFtU9J94ujFV1UMmuJFrRVFVACpT37q4d2VwUqCR5kjGbT0tALPa1qR9ZGK2krhU3h25fmgZLHlutuDXM2efm8VLm98ny/ZtBI+mpnczx5JYYYR5ZTmRPqjb1895NMPMiJFVCWsRKq9K6oKmtvjKdB9TBIoeiZV3BKHPcDmIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638200; c=relaxed/simple;
	bh=DQAgYfn60KbqrMJ6iPsp8KYsP2EodC/60ZTN4YTIapw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBoGJHVv0hSGmG9mPY6gLGtRv04UZRQn/jviuDP+PceoPc9ywZNFyAhJSfYW0VnN6+2rCMW7PfJnsdPux3CE7dcumaMHT7EFkWnzSs+UbJQljSHi7FVcpEar8hOv5GxJdaB/IXS35sVkR8QflPq2ahZQ6cxaEHICM1GdhWwKfqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pj5faJpu; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj5faJpu"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ceaf8a1265so111513265ad.2
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 05:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638199; cv=none;
        d=google.com; s=arc-20260327;
        b=eRqHlQdN/CvBqevqiTDOCkhNwBE9yVbC4r0TQbv2kSNr4L/mzX00Gux19cgumbhHLB
         nevJszByp8Ma7PceKnyOzJlldZWnC91jfit6mvgptLDgbJbgmvBkbuMcxDEzIP0k1g5U
         pLKQiGheiw1a15nJbb9XLlr1yFjllyXLh2aSscE9kJvP/bom36HJu/gmjyUT6zdwt8Wv
         UQSKNNAjlRh5rbc9ZsxXf7Sbypo/WhaYjHYLhndxwac2uz7vImiMTFa5Wx2wEVWEQL3h
         z6bnLUYO7KB4B4wyfXjdHk8KJvQQ/x+JcZW5i/pAU8zbTGMlK6ytK2CCpWm4IaK/6Ph/
         u68g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vmtw3qDwHLw9nLxaCmoXKlHzaCVwQYfHXn2RLy2kmLQ=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=bwMKhUZWhal+YjHgQIJ387Lj8eeceA5XTlTWjg+6itxgOyt9v7SlcuHKANBbyXgM/z
         pRrRbB11y1nDBdDIeBoT514B0dJ7OQIngdUrjCtf5TDwEys14xE0xaIUd1x4FtauuslX
         TSSIT1O6Kb7TAzDVKm1XKxFvERsFvKRg6uEYwQvNESaHyg37DBRTpjewLe3uIOu7JTTb
         tF2O6PGrPx6x3Zuv5hYd4OyuNyZryDJhrWXOee8zFmyKG1uGFvmlbI1pMEAFsT2TF37m
         xuPjAktJhJH7WRhMK2S8Pmaus0Iioz21+1g5yDmdfDOP38Y7OBiLlmnCqjosWY9QdKfA
         YUAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638199; x=1785242999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vmtw3qDwHLw9nLxaCmoXKlHzaCVwQYfHXn2RLy2kmLQ=;
        b=Pj5faJpuKervK6EhlMHz/tJfpDxmwPddb0BoLZd6QRkJZAZ75VwBMzhQXVoda2flCn
         D0rjJMuQUCo77KkE/yXiO3WjJjY40u+zaqvIjYzplCsRRcjWpMDdd27jswbe26wB83cJ
         3NMt5vc4CYJxt0t8BdxxhwL0o+QMh4cn6nzwcd+Wu6/wRXQU/ESW59ZNrtPrfbWKkorE
         bH/6ASpbAMqY7db6qLLqUPnH7m/E++D1lhuIQXmpdMba1exrluqjkSM7caerIvjRxSYw
         ZzVerzxbXmqjW7FEQbD9RHHllD5SsOXf8Meaa1qMriyknBe5ZQi2o6YogZ8RzaM3f2oJ
         SwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638199; x=1785242999;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vmtw3qDwHLw9nLxaCmoXKlHzaCVwQYfHXn2RLy2kmLQ=;
        b=rJhuq/Wdat3vLqQixqGLaR7Hr0PXaxBEcgwmxw4LOogcqmm+ptxOgt4Jp9j0C7M7xD
         21DRb+xZ8JttBR3Kc53hw2agfA/3Y55vDvuNUdKFxhKXN0/OzMnWP7RMGXoaX7umhCI+
         fdsT8nkAF1ZmTZtWb0/4pFfPiA+5eNr1FxC1HX86o6sfoKNhUQzLLJfxCc+sarkG3i7W
         hTgcTn3Do5Vbs9iR0AqValI5+cpCWZNdN1FW0uILjd/KM5793SCHq5oTPtXTKTHr1nrM
         M7URgSCDJT3AopME50KdAyAkUEl9TWVTqjnQcdld3j3BO7MJk2D5SnWzKuTGwh40VzzL
         impg==
X-Gm-Message-State: AOJu0YzGXqzVCoxOZjlzmQrLcVmjtpZA2dPWSXqya47NKkj/R5ujar2B
	hdwwsbPzw3IsuC/jQRYfxUwmUurNRssKGXdSiZoKZpMKpUlY7AHIUykwvZLY4c7kVRCNQLE5YbJ
	3cLARnkpGoFbPSbx4nXNHjDrMTBwRDe1leQ==
X-Gm-Gg: AR+sD10txm/RU0eMVMssG8qGEVcqk/IstXysSqiltWz8XeTES3yNF9UVWvG1mpFfoYM
	Jm9Ol03Zkx423LwdMDdWi23DUTE8G3NiVV7BK4HbwJqUS63G0b7RJviGVNVq4Ddkno7BPjSbf5z
	BIMGE90MdbBereuAcyOoyeUMasU+BIw4Q4qBMeDZsen4T1W9yvnirBwINwceiYeA04GdH5AKWTc
	zgxd0zuKY3YusRmmDdgD8oDbzwMJvFswyrT+gDkqy1KDhlCAe9Rb0IO+SarsQ==
X-Received: by 2002:a17:902:e88c:b0:2cc:aa38:4df3 with SMTP id
 d9443c01a7336-2cf348c2e97mr195070125ad.13.1784638198505; Tue, 21 Jul 2026
 05:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716143515.8392-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260716143515.8392-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 08:49:47 -0400
X-Gm-Features: AUfX_myzHHs-Li0R_Di9YAJXh5M7Tlyki5cS5JVt9JI8uJlG8A-EYXAxqOq_Xuo
Message-ID: <CAEjxPJ4KPaOsjJHqiSevmSAUojxmPdA3wS84f6b_VOB26bZZ9w@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils/run_init: fix EINTR/EAGAIN checking in open_init_pty
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 10:35=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> open_init_pty was incorrectly checking the number of bytes
> read/written against EINTR/EAGAIN. Check errno instead, and only check
> it if the return value is less than 0 since otherwise errno could have
> been set by an earlier operation.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  policycoreutils/run_init/open_init_pty.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/policycoreutils/run_init/open_init_pty.c b/policycoreutils/r=
un_init/open_init_pty.c
> index a51320a5..bd65c991 100644
> --- a/policycoreutils/run_init/open_init_pty.c
> +++ b/policycoreutils/run_init/open_init_pty.c
> @@ -371,7 +371,8 @@ int main(int argc, char *argv[])
>                         fprintf(stderr, "stdout can be written\n");
>  #endif
>                         ssize_t n =3D rb_write(&outbuf, STDOUT_FILENO);
> -                       if (n <=3D 0 && n !=3D EINTR && n !=3D EAGAIN)
> +                       if (n =3D=3D 0 ||
> +                           (n < 0 && errno !=3D EINTR && errno !=3D EAGA=
IN))
>                                 err_n_stdout++;
>  #ifdef DEBUG
>                         if (n >=3D 0)
> @@ -387,7 +388,8 @@ int main(int argc, char *argv[])
>                         fprintf(stderr, "pty_master can be written\n");
>  #endif
>                         ssize_t n =3D rb_write(&inbuf, pty_master);
> -                       if (n <=3D 0 && n !=3D EINTR && n !=3D EAGAIN)
> +                       if (n =3D=3D 0 ||
> +                           (n < 0 && errno !=3D EINTR && errno !=3D EAGA=
IN))
>                                 err_n_wpty++;
>  #ifdef DEBUG
>                         if (n >=3D 0)
> @@ -404,7 +406,8 @@ int main(int argc, char *argv[])
>                         fprintf(stderr, "stdin can be read\n");
>  #endif
>                         ssize_t n =3D rb_read(&inbuf, STDIN_FILENO);
> -                       if (n <=3D 0 && n !=3D EINTR && n !=3D EAGAIN)
> +                       if (n =3D=3D 0 ||
> +                           (n < 0 && errno !=3D EINTR && errno !=3D EAGA=
IN))
>                                 err_n_stdin++;
>  #ifdef DEBUG
>                         if (n >=3D 0)
> @@ -420,7 +423,8 @@ int main(int argc, char *argv[])
>                         fprintf(stderr, "pty_master can be read\n");
>  #endif
>                         ssize_t n =3D rb_read(&outbuf, pty_master);
> -                       if (n <=3D 0 && n !=3D EINTR && n !=3D EAGAIN)
> +                       if (n =3D=3D 0 ||
> +                           (n < 0 && errno !=3D EINTR && errno !=3D EAGA=
IN))
>                                 err_n_rpty++;
>  #ifdef DEBUG
>                         if (n >=3D 0)
> --
> 2.55.0
>
