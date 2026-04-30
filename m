Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC6347DD4F
	for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576226; cv=pass; b=Ls6tXOzUFdrX++KO7N7+BxpSWkdgOzfc/upNPMUFP7Ce8JWP/3Pj7MDqKTXP+11MmVJHO8JEdoRyySOzPzYFTD+fuj44c+xc4A4uX1olljf8H4Ofy4TLDvulEzandwHrzUvnoacwk5dJQ2nshDc/gVPHFnlaUM7P4r/n0gN8BoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576226; c=relaxed/simple;
	bh=5ZLsC6am+km3e9KwxJbwccIegRCsR96E/kBXnaehfRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsKuBsCHfnNM0zBTP+suMUr412Rhy/iwCkpwWg8W6h4+g5u9wvQi3Wxror1/Yd2sT4BtyvP0gy6CTMcY5qWDQI62+u1gc9u/wjpTTwMNyCdN+QE/+4Oi9yRwzWJu+BeNdLovHaoDzibuimvE/b763a22OwOu1+HZ5zte5cbVUvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GB9M807K; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB9M807K"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38dfb789d7fso12039761fa.2
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 12:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777576222; cv=none;
        d=google.com; s=arc-20240605;
        b=RkVd/bowgfAu/3AUvlpL0gV/L0+oRROmrEMrQG9uDFkA9ZeuG5x27cD5YdIHYv/8Ac
         S0nW2uQt/EnU08mMRdJkoStQuskEk2gTb0R2cwvaztibhWiD21NJdAPTB848U2ggJwt7
         wxbeNPF+XmjgaE2F729viYYSeT6pKzM54UCnl/sz7BpDxvAs+M5fjUpog9tuIx2PVrkD
         MIslzdGFM5k/In2M7W0U0kjCcoW7LHbOVfvnvQndUxmc9AYsS4zucsZ9MigEkJMpquEf
         GgI3GD+vwq2uS5xmCSib7EjzM98RusTgrsCyuLQR0xcHDhnIm7nk1lKfRXcxsMlFDaKi
         Kvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sy7VEcqKe3FdFkHbHlLA/RWUr721I3cClaFNv9/k/pM=;
        fh=ZNZELwumJQzyBj6xGReJmxggiBuuIaCagxwYYjTHZAE=;
        b=J2FffVfFKy1YuMITabXue3Bwv4gvk39erqAkynBFVEoq9dfxn6ubP8PgoSV1Ib7FqE
         x6phPft8Qp+MQotT3mAPA9A5jh+JpPJj+rxqXBFkggKf/VXspPDk2NvqVdxEwolp9ju8
         em+vcsOCsAlGPVq584YQ7HflKlJduw8V0r0pWTj13WEJYoNSnG8A31m9i/Cl+ZY3LKsP
         ypUvEsPiuSrovSlmUR2ZJe+wruNOgVpvAwRjONba0VIZb+jZAxhHqTQgEm/DwUH2CsSu
         KesN0fjZK+XkTJM5m18oFqyVAdyFVbfBbU8d4+BVyhL5M721g+YecUzRZlA8j5aWe+wG
         qsWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777576222; x=1778181022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sy7VEcqKe3FdFkHbHlLA/RWUr721I3cClaFNv9/k/pM=;
        b=GB9M807KBCoOGi2PXW0RTiHzg7UiOxvlCFr8TqStd/KuP866KsaJ57sjapGb+jBYVF
         cdy6tQBGMfYLhSidHQfH5Jj6um3XFgRQ56ChTUIuUrGqrGpQY//p/HzJXndDU3wQ2WtK
         4Nwz+MotqcD/+CBYuo5oCKnuEq75ZdC2SUAXHdRBVkWDrHSjslizHKmVXnnQ9zaEXydh
         i9sK++UvZFAt1QUrM7dyE6/kBMS/QhNzJnImykm8wtOc1A06QwXdSvEMBx3N5mboxz1C
         ApJZfRvL52Ara38p1us764RzD4R//p4wG0zLQWEZ3Zzf2iCWwbDXFF+xY+lMnDXX3iP4
         C5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777576222; x=1778181022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sy7VEcqKe3FdFkHbHlLA/RWUr721I3cClaFNv9/k/pM=;
        b=Ir0T6OVUJUged9+IRg27C4J8aKn0/LfrJH80kJRLLcdjZgV/GAnPhoJSzyeuFVhyAz
         iiFzvSJ1w/bTsONM8IEGO/uOpRFO8o2jxm+Xomi/nQarhSzZ1EbbEDbGP5H4FmR+AYAE
         JTwtakZEuI+u3ahmC3meEbNQCceRItFYf4Ep8sxud97htUiw4GpiCfQIjGTvzlHayXP8
         P8nzij/IicHNWiXr6+ZUyTDOlDQSSk8wWLlr3OFsRs35mVhGIYyMOdwzJ0m7oo10aUIz
         s/qK6qTe+vWGBCofBvo2Q01Or4fxDGtMRp/mySmhJiJWG88Vndfb5h4gtIOUEd8lgMkV
         QoAw==
X-Gm-Message-State: AOJu0Yyxge8QYPvXv8ER1IgyjMhu5Dmoxyyupr0QrXwrxh0cvcVORGw9
	CKFq5tYOIO8UCdJGGLHS9HFvDDEKIsx0iquZJCKgqt8yBDB4w4RIC71NFy9IRicmxLI9m+CfdFe
	RHQnIg+6sIIltfhyqkqJk4YVVvw8V3i4fr/7J
X-Gm-Gg: AeBDieuwhlvVwHxRWykoy6MS9RYbypG5UfcuPdF0QUbi/Z70cbfv1mydukZ6njJRtwr
	2GDoQBWkeWpKcpuD0UDaKEgsBW7+kJrAbvLqTBO0vo/4TlFJ03B1kIXe6jJMfAmx1HjSWQ2j4De
	AvoyM1E6McwhALfqwmGDQHNWm6EIh8ImLQ0yDBkLVCUIPj7/Y5jR8GHWJY8dB2B6KeTpTQtNdT8
	dI/kW8PFXJlLPoHLNNCycIf3g22AqYEmPtbqyqxB8jROkhCxODJDbUPd96xWs3YNvQ6U1FmyOTi
	bsqCRbjRU5NSfYI=
X-Received: by 2002:a05:651c:41d7:b0:38c:6a46:b98d with SMTP id
 38308e7fff4ca-3934deb8d39mr14976591fa.1.1777576221786; Thu, 30 Apr 2026
 12:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330015148.1482594-1-tweek@google.com>
In-Reply-To: <20260330015148.1482594-1-tweek@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 30 Apr 2026 15:10:10 -0400
X-Gm-Features: AVHnY4LFUhwlAjA_lSSqGT9yp80noCYUTNlEzCYPp84Rq4FFRQT4-m_pztxyryI
Message-ID: <CAP+JOzS0p2d=43EiumHpe9ESQTjaYuk4tAhyD8Er44p7HUAjgg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Fix off-by-one error in cats_ebitmap_len
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2026 at 9:51=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
>
> In cats_ebitmap_len(), i-1 was incorrectly used instead of i for looking =
up
> category names at the end of a range. This resulted in an under-allocatio=
n
> of the buffer for the CIL representation of category ranges, which causes
> cats_ebitmap_to_str() to fail its safety check and return (null).
>
> This fix correctly uses i (the current bit index) to look up the name for
> the category at the end of the range.
>
> Proof of Concept (PoC) Policy:
>   class p sid kernel class p { f }
>   sensitivity s0; dominance { s0 }
>   category c0; category c1_very_long_category_name;
>   level s0:c0.c1_very_long_category_name;
>   mlsconstrain p { f } l1 =3D=3D l2;
>   type t; allow t self:p { f };
>   role r; role r types { t };
>   user u roles r level s0 range s0 - s0:c0.c1_very_long_category_name;
>   sid kernel u:r:t:s0 - s0:c0.c1_very_long_category_name
>
> Reproduction steps:
>   1. checkpolicy -M -o poc.bin poc.conf
>   2. checkpolicy -M -b -C -o poc.cil poc.bin
>   3. cat poc.cil | grep userrange
>      Before: (userrange u ((s0) (s0 (null))))
>      After: (userrange u ((s0) (s0 (c0 c1_very_long_category_name))))
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Signed-off-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/kernel_to_cil.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 06cf4498..49040ae4 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -1018,9 +1018,9 @@ static size_t cats_ebitmap_len(struct ebitmap *cats=
, char **val_to_name)
>
>                 len +=3D strlen(val_to_name[start]);
>                 if (range > 2) {
> -                       len +=3D strlen(val_to_name[i-1]) + strlen("(rang=
e  ) ");
> +                       len +=3D strlen(val_to_name[i]) + strlen("(range =
 ) ");
>                 } else if (range =3D=3D 2) {
> -                       len +=3D strlen(val_to_name[i-1]) + 2;
> +                       len +=3D strlen(val_to_name[i]) + 2;
>                 } else if (range =3D=3D 1) {
>                         len +=3D 1;
>                 }
> --
> 2.53.0.1018.g2bb0e51243-goog
>
