Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49494369D55
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759577; cv=pass; b=NR4gn22An525Uc+weZAxSx/X1rRbfSfR6hkY1jDDab+8m0b+W/82LQJeZLtPankgPDZP3w/6pkMxcRocsuLZgyu/Tw04t2HjGPaGKPv3bia+RUKrAdZjMBZDZh5AXzlolg80YviemWE0x3PdMIzCyxGdZv35g3k7RKJakPP5BHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759577; c=relaxed/simple;
	bh=2FVnObuP0aXrppl1weQZQJ8yN6k/iC50IPfu8q6MsnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDIflwcyGc6l6ad4XsM+xB/b2KB1jKQbNm30IPWNUqpfjsg3Ad7zcFEq+0pBhwfvKVyiRK5NWbgm5KLz4g53KyYyerOwQ72Wy/vA3MY0LQNmKzyVli2ofW+xxT6gwEPepEuruol1OWz4U163JgXsuktavBaKoq9gmvn6SmK1Ws8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/PXI/Me; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/PXI/Me"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-45837e52d8aso1167786fac.0
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 05:19:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785759574; cv=none;
        d=google.com; s=arc-20260327;
        b=hyleMsKkvQCAR+kLKUhzNBNTKNIa4LbhHtVkPPEgdLpM0yeTsBVXhbWrYKSErc5v72
         k5rzQFGj4QJJvqy8FlQ/smBsmYVDH8VGZntyXaOyw6dD+IZfTp8e1AVzUsom3uiNbFCT
         vg0NlwFwSo7hiduVFXaqkx5waoq43Et2OPyCtQ7yD/O6pVodJUNwLEPiM+JQXYORt39A
         gESrUKtg8Z1UttY6JPoUQbZhKyPkoIvguFLlV/D2Mcmb+jQWOonNAyJYrIy2SKiJR2EL
         /VJ3jyIXL9DtQ1xQkWhsowAReocchqvGPyN6QWxzdRzxmAZyHfjjnzbtH1w2JnItPEMY
         fbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YQXm0UY+nRhuAFe3Fy18h0FGFXXj5HAunMsBXKjpuoM=;
        fh=ctNnd7rEgrNGVRcNYAD2iHPqnd+GFVudQHEzcgGqyZE=;
        b=F/9wA9My/06cvRu0wMXWULYLkbDTD4teAXga6mPNyww3Z5pR8exBCGdfTOpipbWIXz
         22E7e3S8B/NlxTPqqUQo9/2zBPv21PQ+X+eRPG09AOEuC8jQK/EWqT1P5fu/ZXK2MgQS
         vjc7rMS6SUrSColQY4x8huOKPutKdWYsxaNCAMIVs9fTjKaZXKNlkVmH1hnZd3tXRZeX
         7JRCf7jGhBbwq+aa3YcOdtPk3i78BSkWXDNLOmvQ5cTCBPl6c/zL/qFG2+d3YnSzVFvp
         dzAslIkBNB5q8VJuedKMisAgvLPR0O/2XVMccUEq55btVq3Dew2D/Ep12CK1BY2wGzms
         b+OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785759574; x=1786364374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YQXm0UY+nRhuAFe3Fy18h0FGFXXj5HAunMsBXKjpuoM=;
        b=Y/PXI/Me+S37xyxcbcznFqjc/3opNS/+iBWYqPZ5fpaQkuN+e2ziRO5WaytxXIAXW7
         o/grgosvf9XvrEr/i9TDe4cpg4lCfk3ZyaOd9FdqvkCTscuIFafjChfb8AMr2YolfUV/
         tKIy7ziW4VRhiBR2vLLhuP1avO736y0hcil++ZO0yk+ckJVWyvRdUIF9n3hsKv1V4I2O
         wTKbKCBbmoGyssRAFeeLnbM5hOPgptsFHYk4dc5m+isC90w10G9Bu8KfzyL99KBfE0V8
         35QNdXadR/tTz1DS74vGkk5Pzxbhd38A3Na+IRnjzwyZyNoSyA65U//a3kElPLOkkCS3
         kdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785759574; x=1786364374;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YQXm0UY+nRhuAFe3Fy18h0FGFXXj5HAunMsBXKjpuoM=;
        b=edlr7SjPeJrGmly20rg0eQfUSIn+rx8todG1M+UY3eyE/kPNEia3/YZYTTGgWAyZcL
         MndQNPTWfkLAbUncESUFI8p6OmS20nVr0SvhuM4/fcOyV+XpWRDGvM2FwUdq2PzOdwSD
         BZv4O9Vzk69SLSXKTsWBIqv8g7VwZ45ibKF0bEyS/vApV/bzZ6IcFWYhN772fNyDk5xa
         bgWlwQBmmva52UXXwxEVxx9K1L93vIj1Jr/8qhiY8CKkPKo2p/Vab4yUV0C1jzE4tgkY
         lVuzS4IxERZrR8ufxPLQX+mIyXTu/Tl/Zc5+0mtWZrd1pYg5FioHQGnW+/uOjTnHec4h
         so/g==
X-Gm-Message-State: AOJu0YwDDOrAdHwZGzAFOqA92pw3Ew73KVHlCAeBElmCtMq3jf5QI9/W
	0wfvzGisez9o8Pdjaqb+gmnnSPby62eWeJgrg9uLwH3odXAXwRLooWogkcJU9c3gs0iVy2FhMgi
	SiMRApPJvRvn1y8tbIBQ5Bj59rEy1oByjQg==
X-Gm-Gg: AR+sD114LZ84D3AuRHLBUfSW5DPkwUlBs3Grbo4WpuE3wT2C9QCcDQpsmi6VrHIb1H1
	Wi76z4+K0UZXZoMf0CMT3ZnfoEBHQk802BKG+Liq2hlocruf+YR8apINATcDahwUPqes8mPLX6O
	klazI9Xw5C5gYfTEW713jOxzA1vEYObpB+UsnaJJsA9YCCX95+YxhTdkEVd8UKOD5rfVl42IlRc
	oPMsvrDfCPnD4EIx0bOFjjQA6yhMigPzeGF+Y7Fv31CBdzlLnLuqcScmPwozqzo6qoEJii+k3dk
	aVjM3eKBhV+F3X6bvuZevIlN2UQcwG/usKqwD7u+JoP/
X-Received: by 2002:a05:6870:20c:b0:43d:2e43:9e4e with SMTP id
 586e51a60fabf-45905a6dd6fmr13812998fac.17.1785759573837; Mon, 03 Aug 2026
 05:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803090152.1456176-1-omosnace@redhat.com>
In-Reply-To: <20260803090152.1456176-1-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 3 Aug 2026 08:19:22 -0400
X-Gm-Features: AUfX_mzzlWJUCoBXSJbaL2ifapfdocIs71cBdIfa36FEn4tTTN0q8SEgEhOMFsg
Message-ID: <CAEjxPJ4ny0BcpcYT03xwy6JKdj3sd1y8GgBa9-Fbur1jD3BJ_A@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket/connect.c: add missing
 include for bool
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 5:11=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> The below commit added a usage of the bool type to
> tests/inet_socket/connect.c, but didn't add the corresponding stdlib
> include (<stdbool.h>). This problem seems to be masked on Fedora (likely
> some other header file includes <stdbool.h> internally), but for example
> on CentOS 10 or 9 the compilation fails because of it.
>
> Fix it by adding the missing include.
>
> Fixes: 433c597a6a9a ("tests/inet_socket: add tests for TCP Fast Open")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  tests/inet_socket/connect.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/inet_socket/connect.c b/tests/inet_socket/connect.c
> index 067d196..89e85ef 100644
> --- a/tests/inet_socket/connect.c
> +++ b/tests/inet_socket/connect.c
> @@ -3,6 +3,7 @@
>  #include <netinet/in.h>
>  #include <arpa/inet.h>
>  #include <stdlib.h>
> +#include <stdbool.h>
>  #include <stdio.h>
>  #include <stddef.h>
>  #include <string.h>
> --
> 2.55.0
>
>
