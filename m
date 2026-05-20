Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE0129D291
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291155; cv=pass; b=p/d+OIN4Mz99mBLPdWVxHIA9TJUl95zuZY0lqsCH2ILGIejT3X/m5wH2ovJRhpnubttjIcECwVvFWNmZl8kBZLBCS+NGSuK2O5ZMoIzNzLLQajdmcXDv+fWL8n6We9FJevQaUQXcX1bgggJNfE+vXoGOTtfQrxy805eI5hrDAD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291155; c=relaxed/simple;
	bh=Hw07Gi0etP9R2vJuPfNHWHL2t+UCu1liFRqqcHVg01s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRBKMfS6f8E86i9uSkmgmd6gvkk2bFzj7M+ujDYMma+lXci6S2jW2qrU8NYIfynwHq+frmZxVAq2QkmPbYXaBAC4Oe22+O0VMTS3mGH5FJSe//QaIxIY2S7XTSq5Ijm4AkoK6nyBZfwt/PCV1H8e2VONy1MhsDdAT6iYKKHeeKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVPrMTGU; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVPrMTGU"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39556b00a85so43538851fa.0
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 08:32:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779291152; cv=none;
        d=google.com; s=arc-20240605;
        b=Aa3GsVxoXtYvJhrJpuNmGuxBB2OzEkoD8nJ/4hbgIZytzLLyF1b/PcZ9i7DDbCiuGV
         WoEX8Afg1Kkc1spGoOQbAKpaHbpYKwY27Ki30wJKR1lk1O0uZ/jPovb/xIjmeexVqIWp
         wD2lrWpqVT0TthF8CvzK3kC+rTtjUprnuI9vA45hz7xqREImraDkGvX77xUkmgBh98ie
         EngWmzFWWSJjLjoPxyCjtSqP4EDkEePDZGg3dNQumQt1YEPYPCg6d3pfV/N/qLxUhPLx
         D+JHGjJ8/kKBBOOneoA40tl8ce/O7+Ff4ZLtnnyLEBVJRgrF3GjTzMog71P26Owa/760
         gHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EbgXxnFJqRCX7ewcqP7wML2kLWPK857N7wyQmY+RpHA=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=YiFqNXzMr9LMfro8ktzErm3UHnUSj77uAy5FV3w91CcTA2hvhw+PilR5d0zmM7yVnz
         7J5iD8e3I7PtlBLNqQQB3YayioE00+9wkO7UUHUuViRw2yzQhVJ949qtBqrpptmJFLuA
         meDPVvsh64hPRvTiQ8eKtQ1179dzMmjAG3VH478lbCuA9yms0aKyTMizOUoviIVdQ2zZ
         vJitEdoRvsI1UCNVfaD6M9piHU6nfVJcSubUrEshGkaoYcMbMkUvwR50S5TYfDkXDjLv
         7rvX7uYVfwmpqIZU7Nq4p13FIxN0OohmhFnEP3Z6i8GZgNrkbfIhtJk8jlx9L6h+GJ2z
         mS4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779291152; x=1779895952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbgXxnFJqRCX7ewcqP7wML2kLWPK857N7wyQmY+RpHA=;
        b=CVPrMTGUvY4eO1zEuQAoFR1AiwPF1asbI1Khhu58CrxjgXxNMvIcczgRWBx/2AflkV
         gkLSnKD/zExExLzEv067pi0AH08ke2v6M+i2QYLpI76PFK5vk1dhLvv2kUGIeaDQRHnk
         UdZau4ZO3HdVXsXvVuAEh9h3a078kCMwQZ2gngH4Q1sV6+Knz6HvSYfkEpJTyOAhwxkf
         ZdPGEk8qA2d4ddFkv5WCsrXif+2zftDxudoXsHR7om9AUOccA0SArzfH1uL9OVcQ3nMi
         MzPYoB6egqCWaY7mohsv6dvCfV778h/t/IhklD2+qtFdctU+mTF/qGu4Q69MiNNgG6Xa
         XMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779291152; x=1779895952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EbgXxnFJqRCX7ewcqP7wML2kLWPK857N7wyQmY+RpHA=;
        b=OgTT3HXtWDw6t73Bxpn7cRcBa+On/lOCbiq9DUbdY1pNh9AFT2C+3A3O0M2WYDpClB
         5nhnJHJq/hirT8cZ3B/i+JdS+1EY0yBP0JkDF6EdjYCQKBml8zZZbEnjH4mpw0M5JQbz
         BrThVvqzAwwjyHRMv0MwMNhm32u280rewolaJH31pXO+inUtRMINMvbVAwUlcCcp+v05
         7ia0iaW3ZBb1ca/Acd1Z9k21wNKyzc5dxkiXqthm4V/K8b+dTEWKM6FmIKlJWZ5qNE6u
         dmnel60sool011n23rCGRozBNkucLjUmzRPRCrcc96P7fzN7hV1v7hz5D79XBquS8+mt
         T7zw==
X-Gm-Message-State: AOJu0Yx8lYEx37TejMBI0QddhRvUxpooSmg3dv5RUmWnqBBp3bfdOrGQ
	v8orU8yDi3wHXgzaW5ZfrDeThpbMvqQ5JuqJjenGXT4IDDaiEfjF7jC8fpr8Kihys7sggiegidb
	iF3QdinESqww6doKP5dpuUduXlUeaq80TmQ==
X-Gm-Gg: Acq92OEfASEaEzlys9SjXvw9dzrg21B4/n+UlbMyzFRUSXZdTZyxX7cFvfx6AiS9nkG
	mzI+Eh6p9uYgOOMm0DpDnFIIWkKG+icBaycop8LdnNi9ZU0MAmKHkKM7W+W7hbctWTLbPIALBXg
	0/1SVej9UZAwDQtjlalHaSwmAOBeOPXsJ+0hYjCNEwbvIuPZgBvq6+otdz/6ZcIRWQU7sqNcT10
	Z3ikvYOix8PPpidUfVUNZB2jkugGCEWBr6MPiF3B4phtsW1ZUWWm9inoZj2cgDCQZIzjD/TdiDr
	XG/g
X-Received: by 2002:a05:651c:421c:b0:38a:27b1:4e60 with SMTP id
 38308e7fff4ca-39561f2862dmr60286401fa.27.1779291151949; Wed, 20 May 2026
 08:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508121327.91410-1-kalevi@kolttonen.fi> <20260508121327.91410-2-kalevi@kolttonen.fi>
In-Reply-To: <20260508121327.91410-2-kalevi@kolttonen.fi>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 20 May 2026 11:32:20 -0400
X-Gm-Features: AVHnY4LrPH3Ttl2v02KT1pbhz-TVkRzFxhkJWjxPN3wDhEqp8MO2Fe3S55NuF68
Message-ID: <CAP+JOzRCt4hxf6yE-0L4j5Fiz_0BP3R+MFCKDfZKdWy1mYA6zQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] checkpolicy: use strcasecmp() instead of two strcmp() calls
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 8:18=E2=80=AFAM Kalevi Kolttonen <kalevi@kolttonen.f=
i> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
> ---
>  checkpolicy/policy_define.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 02e2c077..d1511a1a 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -35,6 +35,7 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include <strings.h>
>  #include <sys/socket.h>
>  #include <netinet/in.h>
>  #ifndef IPPROTO_DCCP
> @@ -5201,13 +5202,13 @@ int define_port_context(unsigned int low, unsigne=
d int high)
>                 free(newc);
>                 return -1;
>         }
> -       if ((strcmp(id, "tcp") =3D=3D 0) || (strcmp(id, "TCP") =3D=3D 0))=
 {
> +       if (strcasecmp(id, "tcp") =3D=3D 0) {

We don't want to do it this way. We want either "tcp" or "TCP", not
"Tcp" or "tCp" or any of the other combinations. Either all caps or
all lower-case.

It is the same with the ones below as well.

Jim

>                 protocol =3D IPPROTO_TCP;
> -       } else if ((strcmp(id, "udp") =3D=3D 0) || (strcmp(id, "UDP") =3D=
=3D 0)) {
> +       } else if (strcasecmp(id, "udp") =3D=3D 0) {
>                 protocol =3D IPPROTO_UDP;
> -       } else if ((strcmp(id, "dccp") =3D=3D 0) || (strcmp(id, "DCCP") =
=3D=3D 0)) {
> +       } else if (strcasecmp(id, "dccp") =3D=3D 0) {
>                 protocol =3D IPPROTO_DCCP;
> -       } else if ((strcmp(id, "sctp") =3D=3D 0) || (strcmp(id, "SCTP") =
=3D=3D 0)) {
> +       } else if (strcasecmp(id, "sctp") =3D=3D 0) {
>                 protocol =3D IPPROTO_SCTP;
>         } else {
>                 yyerror2("unrecognized protocol %s", id);
> --
> 2.54.0
>
>
