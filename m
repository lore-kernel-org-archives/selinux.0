Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6D6370AD6
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535558; cv=pass; b=JJ1g2o7DP4OE0b308uKC6whsUIFpib/WGOgA7Q1TXWX0SGTWwkI8Y906xOZDEQ03v9eAiTYJesN9GUI2qDVofSmPe7Y7r6tiMZPf1kKpe6hc2sZtlNXtfOIvOUshPEDbCbhR7l+FEi+ZKjZD0vfHMYSX9Pj4ZRmzjhfv42Ua0Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535558; c=relaxed/simple;
	bh=8uAPW4Y4tgPtlrtMQ9XmOxyEAeCeZ56ZPj7LynX+3lI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3gSR8NqH9fXXw/fq7VBBL568hPvJqpVQscSNmF8LjPBGMVwhRTwiFOinwr7U4uWGugg01qfrElRwrQfXkAT0GJEJGoIvs/Qo6kHxTsS7prUhoYiVBo0nZ1U614btzjentKZlvsEu2RwNSKywvoehBlCFxMhzu5divmzQM2eLkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lio6Nld6; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lio6Nld6"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36b903567fdso3985050a91.1
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 07:59:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781535557; cv=none;
        d=google.com; s=arc-20240605;
        b=YjpMZotRrBxuZrnNkaBXG59oHeM19MMsuLbCoeyMHcU8qhkTTtgupssCmy1zJPnru2
         DJvAcMPt1pSnin0F2uDll1jn8m7S1DCM/fAE1+kb3oq4LjI7aO3u+AKp3S7VG+10b+xN
         WLyRsVi5UhOi3pS0Hrxq2jBSt5SiqGASjEC2ZQ1P3p3hEMDFKfhjTuJJ95C0Yyw41F1T
         MPSojgB2OPN/cOdbI4zpbypr39zE64tX2row0Wu+RNPy7JZ7UoohXrRsTFKeTLMFRIlB
         j92Y48GzjYa+knU+XQ0jj1Wp4HxYsv1hsjg9eiwSAl7/B/R1Dp6PItAOGTzsTJi2wIxz
         LLEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yjR3Ti2w94/WMNyInnMFPBO7fXir9F6ApvYs7/lu9fE=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=fm4GHynjbzA8bspJsEBAnAoKHvDfsMefTL+WAGU5KB1/0gI10zWN4CysC5/x1LqnUh
         dysHQLRE7jr6OC9DXbmHNIT5au1jSckh2UYCdAI2zdK8vKRsdeIUVNpeiScACLcSjuZm
         5ZE6omEOihhuVQkFvXpwUdzJMQMPyuGrEgEDLZ+mGciMAdNvu5JeuO/CpTwFbOtx1q54
         u+6DmU4FFnuMana9Lqvfi+kpgZdd/bqbNYCCPRHwwq3YFzny3n1snAqv7CxpIRULLDqL
         VmzQY/bqxpxdYVWKYh0pWVbUIcqsmQp75M79FuBuaymCpRdmWhTqt+fPDR/EydCm177M
         ttQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781535557; x=1782140357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjR3Ti2w94/WMNyInnMFPBO7fXir9F6ApvYs7/lu9fE=;
        b=lio6Nld6VUQsaLSbcyPNnH14xuqb3aXYEFa52elcDY9M3Pm/5jHpmcQyuBJUEsO2Ao
         P0GUI3KVgLj8qbyiJWqidslgvFVVBKmxg63frJlYg73EgO/cEQ2b5KRHVQeAWhMaLzAr
         lP+VXGn+Oc+jpgSHo6W5v9PXn6dGP8S662XPab6rtwYpbHsbA9SwhHsmh1S1bUtla1Y4
         ey0hjXvAIddfq1aDMlfIxwCYeh/SJeFfDS2I4BGIAh6kqcT97AsLgDCIrAcC4ivjyI+P
         t5Pj/gdg4p+Dk9BCmmC2RQumY9XFV+wMdqZ6EEfpPUoOhHPV6CVfR+2mgXx0UHQuoFQ7
         Cydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781535557; x=1782140357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yjR3Ti2w94/WMNyInnMFPBO7fXir9F6ApvYs7/lu9fE=;
        b=RlSKCaN2C+JTwl43OGyD97rVZUGFtIOtBOSlpLcyg5s+rxPlRnItvbkcrxhPzwwlRr
         vAStIxlJaTJNWxftpxQmFdrzfm5BQyFCxvEK0oi0rGKm/dYku6jXUn4TzSeGFlceBUJa
         caPIKmYCw2uZ49b+F/Gxg/CtIAWda24/HL63m5fACNsI6zmEOfjaYOi81+E0mIF+V/xv
         Hs8B2WnhgNi8oTlcF72W3FZAzGZ2tUb9cgLcxYZWgKKjvGPj564+yS3a/g79tl4pUlyP
         frygQiz21ki3Xalp575z8mVCVx7EMDtklKrUO9luAazg+XzAUWmZR8gqGtQts1/GbcmO
         zi3A==
X-Gm-Message-State: AOJu0YyGy2vLrOw4/1wWsLBZF+/v0rJE4Eh6ZyhciP06oxqyM86ue/3Y
	2tRCCDBmWHYzfsTeMonabifN8k4pEU71m67tRr/tLNzf5XfODbtlPKj37DzwgLSuVylZKbsfH85
	IEnkH7dbQorLTZaVb5RHhlbRTHXghlLU=
X-Gm-Gg: Acq92OHJjY0msczqtTVS/3Nhfyy8/r9r6aXMkBQti1heZslz+m4cEsf1I89cLBQ9GEO
	RgdPdyv+lYcGcCNBZ2Wb24BJ51rQcj4ExOnDbbdCO2pKGPBNUosuiiNI4PM/q3nvpr4olSWyI+q
	Cbns9mRtFMWH8QbBNYQpv3EDYjR44Jt/OCBmdOyYkzgg5RWPM759VG04tqeEsgcxw+Czno5WjVM
	BR3b75ItjsTNmSYHs6ZSrI5hrYmLHLFcZ9q8QzgRzmGr0VtMKZJ4sWMg2OYJow7LonWeloXjy+w
	RvwWQMA=
X-Received: by 2002:a17:90b:1c91:b0:36b:9c4a:e05d with SMTP id
 98e67ed59e1d1-37a03cc776fmr16010003a91.17.1781535556644; Mon, 15 Jun 2026
 07:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614170203.69842-1-kalevi@kolttonen.fi>
In-Reply-To: <20260614170203.69842-1-kalevi@kolttonen.fi>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 10:59:04 -0400
X-Gm-Features: AVVi8Cd8mtIjEr6eekz-A7hR1U_EV0LA9GnQZkSCeWPOicHR-xtTTvLmD2lZ-E0
Message-ID: <CAEjxPJ5QD5-b9vK027zF6OnCO-20WVrSjAXRsfn9XADw-JExqQ@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: use bool instead of int
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 1:10=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policycoreutils/setsebool/setsebool.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/policycoreutils/setsebool/setsebool.c b/policycoreutils/sets=
ebool/setsebool.c
> index d85b2a33..3cf1f063 100644
> --- a/policycoreutils/setsebool/setsebool.c
> +++ b/policycoreutils/setsebool/setsebool.c
> @@ -1,4 +1,5 @@
>  #include <unistd.h>
> +#include <stdbool.h>
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <string.h>
> @@ -17,9 +18,9 @@
>  #include <semanage/boolean_record.h>
>  #include <errno.h>
>
> -static int permanent =3D 0;
> -static int no_reload =3D 0;
> -static int verbose =3D 0;
> +static bool permanent =3D false;
> +static bool no_reload =3D false;
> +static bool verbose =3D false;
>
>  int setbool(char **list, size_t start, size_t end);
>
> @@ -44,13 +45,13 @@ int main(int argc, char **argv)
>
>                 switch (clflag) {
>                 case 'P':
> -                       permanent =3D 1;
> +                       permanent =3D true;
>                         break;
>                 case 'N':
> -                       no_reload =3D 1;
> +                       no_reload =3D true;
>                         break;
>                 case 'V':
> -                       verbose =3D 1;
> +                       verbose =3D true;
>                         break;
>                 default:
>                         usage();
> --
> 2.54.0
>
>
