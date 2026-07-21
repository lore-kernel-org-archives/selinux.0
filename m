Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DADB1C68F
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638046; cv=pass; b=YoDG0Tydnba/8VukxIkHV0e6AnpZ13PybUiqus2dla1sjSnxnTlL8WqA58aHcu2Ag56ScIrnBgdOMHekwJQCFhTrdGEa168NtO4HmS6jFFQmT0reLWrL4vYlcRtL+NDXIYWLs58r73qB/GAoYVMn2i5Rls8Tw9VsdWUY9nA6Cjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638046; c=relaxed/simple;
	bh=RWV+idHbaQjgW8BxsDplv/kCVylKFRrf/qktwQRNKa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFMt3LqkedG+E5mP55DI2h5s5C7TJgqOXfRcpbJDKH58Pw/cVVv9kHHBtPSHg2U7ESZBD5iL6A54/WX7ag/rPqoy5UHEwl5n/zISfieXjZh79lKGiERiHtpyELbAo67A5WzyWBArE2A/463tsm2haCPrBhrRB1DrCk3hMpJ56KM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECp2WB6g; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECp2WB6g"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc73e322dbso132306965ad.1
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 05:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638044; cv=none;
        d=google.com; s=arc-20260327;
        b=U8OOnHMeeDiYOVs2aVEYCFaVHyUkRyCrrMqEPZZgtmeWToBpr9LUmDkWvkTQg3tnRq
         ZLoZMVNf1Xt2bKmWXX439ohTT3mdnQsKpwj7vqhz7BlMWiaEscKIa1dtz9tX4lUoztMp
         G8KePaFAbIAzd1wzQeglw4dmk6muEddbI8x9Carmlwp9LHP5GeQW5MatMq+gDJGoTp2m
         AVAR+5tp1kCQCOv9pO/VKoFPb6FcITFZMrGkOVUl0D6RQfWQHPae4QRnio4680XfUQUf
         PAd0r6dH8Y7ViGeHDHiNUU0NV7e0Y95+V+CJsy9XN07DVVn4drO5f0C9WYedPcEQyb9U
         aggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c0MJrXphQVUi5bBoPu/G7hUoaAxIKDrSLOMEIw2aFfg=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=VKop46rCsb6QWba6Wft7jZ1QkH+mvJMm2v67fy4UDcw0WO0Yj4KpiZcINA7N3V/qK2
         xbOlJYgUM6pGOGTROjdCz3NjKhkOUfNbM1osj3eXSxc4gV5km2oefGblHkwFWYl+xKGx
         XaiAGRHroXoVNxFSrE1RFyK0xwtpA8Nlg8lE94cAK+kbXcxqJdmeJmGKp3I+IGNi8AEd
         LiglP2d1ZWhhJLuwO2uI+qam+bDs1U1n2H587IlFldDqPOBA03jcyskJAW7Bs5rZcdzF
         QEJ0JVUgeqT0lKKaUHUO3rEHOfRemZ78qVFr1soiLzSBjnmcWf5QzE5HdtwAHnkglnx3
         Xduw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638044; x=1785242844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c0MJrXphQVUi5bBoPu/G7hUoaAxIKDrSLOMEIw2aFfg=;
        b=ECp2WB6gbkvdQnHsUqitsQrvd1RafJYa3+wFhL44PSr9JSIQZb44AR/KFL0akdex1c
         EbaOsoWtNoHlKm2nXJoy0vjvRvCuMH30WrrVjpNV+/rNx8kSL3ZOuzK+byFNBVPkwCs0
         /9Buy0F5/Pt6D4M51jESEq2/Zd1zQ7ARPg+1YSrf7galPoK5CDn6UV0shaiWcN6zki2H
         GbvoZen/4lBGVEdh77eol137774xlWg0/Pv1v6yTh598A4wIjnXLOtR56vS5lyD71GOC
         1S5UWgMmN9PxKUiY7I8y5Z7YvDPS2Yp/MFhKvm6hU3SpBIIS60PWXTs0/Sukhgb4qrrD
         Guzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638044; x=1785242844;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c0MJrXphQVUi5bBoPu/G7hUoaAxIKDrSLOMEIw2aFfg=;
        b=SOLdRNhJxH0QA9b8YSjQBf+TNSFPpE/W/MiIG9cf/ZGrNNtemhrx3QleFoCRBBwD6k
         /PhZLq6zM6n4nWRVtP+9c+3NXs0/lZpFBE6NWzIlk448zt26OrJij04oy4GFV+wMxDL2
         7Bc2RxvaAzozSPEc1ndkyQ4Eeb79sfXNEn8PspHVGCatDi3PiJIddtf+DxLj3CnnwQhL
         WlkPOtOOmhkChkp5t9hJRUaLDzDDdGorsX/w7pdTa8x7sJYImMfrsalcyH2xW6bOQylH
         eVNOPqpbrnPSs2VusMbnRJADc90vfFNLzFyDylw4LvLixddF6drBg44EjDQOOwBo1c6r
         uRIw==
X-Gm-Message-State: AOJu0YxLA1ikG/jUZZh5lFUg66Y8nxtj+ftLY5U2UzBes8rgRZZeSAI+
	1G30fjqjPY61ai1FP+HnxNW1wD/zyYk3c6qHCnj4FbZJZr2Jl5K+jw708WiCvbj3UTnSDNpXXMH
	xl48ip8EWLln56jvqgmvKkrkGhqXHGG4vDw==
X-Gm-Gg: AR+sD10+CXgByQtk8KOGMChLHaQ06ffihDurUmuC9GkhPLQicU4Pi0KuxOM/ALLKX2S
	vR/8qP2XNz0F/kZXYbjxyFTcjH2HIKU/Epm+LoAe0nFelw4THJfh+9MEo0IaK7k9yWe1HqnLa5i
	UAhuuJyubRuX0MCxjff46lONtZjsVDXrNtBkYrQoL6zAQ3oPCMBxjYv25D7cGy/gbz/5tmkiFs5
	ew8H5RNDm9/gAmgtLimrJiQvMKsu1UCI/eRQTb5D0BfN/9vyDknv/yjJm4aWQ==
X-Received: by 2002:a17:902:fd86:b0:2cf:32bc:971e with SMTP id
 d9443c01a7336-2cf349bb7b8mr186952215ad.29.1784638044227; Tue, 21 Jul 2026
 05:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715184914.45524-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260715184914.45524-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 08:47:13 -0400
X-Gm-Features: AUfX_mwk-8PVLc-nX9OaxA9OGDVEzxqhpzzbKANwmt-xaykSrVGreVVsUQS34tM
Message-ID: <CAEjxPJ5w2XUOkb7CNjuF2hnZXz_rYBsXtvQUt3Yhbjn0u=EePg@mail.gmail.com>
Subject: Re: [PATCH 1/5] libselinux: selinux_set_mapping(): reject class
 tables with too many classes
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 2:49=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Prevent integer overflow while counting the caller-supplied class
> table and return an error if the table has more classes than
> security_class_t permits.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged.

> ---
>  libselinux/src/mapping.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/mapping.c b/libselinux/src/mapping.c
> index ddc11dae..1fd1f04d 100644
> --- a/libselinux/src/mapping.c
> +++ b/libselinux/src/mapping.c
> @@ -3,6 +3,7 @@
>   */
>
>  #include <errno.h>
> +#include <limits.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <stdarg.h>
> @@ -35,8 +36,7 @@ static security_class_t current_mapping_size =3D 0;
>  int selinux_set_mapping(const struct security_class_mapping *map)
>  {
>         size_t size =3D sizeof(struct selinux_mapping);
> -       security_class_t i, j;
> -       unsigned k;
> +       unsigned int i, j, k;
>         bool print_unknown_handle =3D false;
>         bool reject =3D (security_reject_unknown() =3D=3D 1);
>         bool deny =3D (security_deny_unknown() =3D=3D 1);
> @@ -56,6 +56,10 @@ int selinux_set_mapping(const struct security_class_ma=
pping *map)
>         i =3D 0;
>         while (map[i].name)
>                 i++;
> +       if (i >=3D USHRT_MAX) {
> +               errno =3D EINVAL;
> +               goto err;
> +       }
>
>         /* Allocate space for the class records, plus one for class zero =
*/
>         current_mapping =3D (struct selinux_mapping *)calloc(++i, size);
> --
> 2.55.0
>
