Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F01439934A
	for <selinux@vger.kernel.org>; Mon,  6 Jul 2026 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352390; cv=pass; b=LYrhUbCM7pb9kaKq908+qaUJgN0/AzIwUoOv9zv5aLE0dTUTDIAUtG2L1O/p/YSbgzBgnJYFRaxksjFiiutVcD0790FvLmMoCqkNMKJs7FZqRDJ6yR9S6tx6gFS2ucAiTgBWOUgeE6Wcm2MxxRE7ElqKQpHz4WLwYYLeWZjc0zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352390; c=relaxed/simple;
	bh=TTQn2JaxKw1+8zSoeXQ5Hj+CD3X/pxLMwSlPGUWxhUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3BSBV64N/m/UFfHJgOPpk90IixgFInYp0UsJBD0R2b+R1Yp/SLgMuvzK9nqHYzkJk4KBNxYonzhbcSb9MGALpTiR5jOG+QYArNeoWnS/lldQqcgsRm6M5zsmzLpajk5VDOioleHENC0c/L4bHVx7H9nupnlxQ5qWjmZ31JcnsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOGdwfXb; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOGdwfXb"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39b26e2ad5eso26688451fa.0
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2026 08:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352387; cv=none;
        d=google.com; s=arc-20260327;
        b=ipiDzLflxEir0w9qciBGYJtNJEWVX147HWQ5EhByBYQBvaWR1H2HO5Aeg/Jdlj4IIg
         LilJC2Ca1EfCeOmwvoslJH/D1ahxhfd9aW3IQ+GN4SCYztaele3u/V6YfsNp5qb9h+af
         lZEh87wDNaFbgc1bt6531a39t/jL923eeO1bqSvpWjUyATTuQHHEmW6ugKm59J927wQj
         ARcczS/9geBdw8aRZrN4TPVKd4BRHToDkiKGPuez3QSCqF+31aC4gjFDl55ojtEXXSkD
         EkWmcUTV6ZLnPAIkOhiBS5/O5TIjM8VyTSdfFzLSVkLiSRe8cmRh2hhTlXL4PH5p9Ojl
         A9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=amKLtGsjWHsWKPDHyw6gfAR3sCItTn953TDrlGdaXrU=;
        fh=iWU6EMthgWNLSYoyCnZUFfTmFYJzGz6VSgGmuJwkex4=;
        b=mKRU8ms8H6r40zC+1lAUM41rK2lBlvRUpY8724n4mOR0NDX1tluSS0bVVBBksrvNn4
         v5LuaboAfcCLffp1yfBIN28kWCNU2yTSAdYsYJEJtPWoLmZdXHTz7Xx8ZdcWCp4qXl0L
         xVqw3JTzg6c5HKivzGS+MmOxiUJzKjR93qjsRsheoaaoERTTv6hf9J5feDwu0fDi4Yf2
         qwccenXHUCm2bvZv75lfInofyhLXDhxNMX78vZAt1J1TVxo99CYM1xIsLDFwz1ySkezJ
         KP04Dmgzu6m0VfENGqtF7RpPcIIh1fBqYD4Db1xiXsoO7XIwV+AYlGD9ryHnXv7EF+kE
         6FMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783352387; x=1783957187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=amKLtGsjWHsWKPDHyw6gfAR3sCItTn953TDrlGdaXrU=;
        b=aOGdwfXbvRxXiugByl0toZK6ZuHPBGJvD4mz+3NrkumvToi1lHcHvO8zzM3peYKS4h
         oRqG1W+nmUZGGLeZ6cA6GMjEeoip2vbfnzYc3xxZ0ndNLGz/mgOdx6MDGVpnZSiyNlLV
         wJCMuGSN3t/0sHu/sJ9hRz11iNxE89smrXULEz8cmULA7330RpfybyblOaHkJXGxK41T
         j7VsACIgnL5WUaOim9JxyQg5W97g4WjidxzYv72ZpA7jmF4lOuOsAin9NLlU06jFNO8S
         /JBKiwsi3l5Z6sq1e+4/ott9UTUHfIu/G1gcpKKWceSuspSa4+OHFxfdOE2DvT2zF7fb
         cH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352387; x=1783957187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=amKLtGsjWHsWKPDHyw6gfAR3sCItTn953TDrlGdaXrU=;
        b=bb1mpPHAZW3+KMg1OqOHcjCbfdb2GSwBukjrxkSqmBGLD0+cjy61ofUv8YbNTHK0tG
         IkqDcn3goHdp+OPRJ+F228F6s4yWK14EmVFfFXz5EtjO+z0EAY6LLFA+bTXyB4LYBiWb
         FBZQyUgR7v1nDF1AMkMjMi7e3rIK8O03LSZ884o1k52jMyQBj20xATENVZ7JzT9wSb5R
         tB2tyiwLgLugmmvL8URjiTdBO3PFaMSE9N+C6mBYvnZOaMUfPa3JYJi7fwBliXTvJ9qO
         +Y2l175fk6OR0I+SXjXQlD41ByBF4s/XsO4u3Ux1JmNZiLgINI1IKO4PdxaI7nW0ACky
         BFUQ==
X-Gm-Message-State: AOJu0Yy32lTF9EqkDIIdAvTqd1G7Hm+uIBwq1jflwGmM4eoWOu5fhBj9
	jxpPVmXxYDnDBX9QTnD8k17fG7LoNx1fUvZlNAvpVqhkPOnfrx+DP/zxDJa9MylJbMlQDTuOKhU
	mY3uZu1GPvggmr4MN9f3hb/swEjLuojg=
X-Gm-Gg: AfdE7cnsj2D3k/Qz5hVRhVwRfvwBysEifhBcZbDUq7quNinqvqU4qVR3sYbS9qjo1i2
	9IYqTGxXBMbQdSEmG3Y6lrCcwOZt1TEfSpm5A4GNbxgAE287pJ0GNPI7+kTrTlzTQdZbn4kW4G+
	Yj6BVK4kDLsEZ4tXePyWberpQrFZ5HswYde+qgBLVjNm4n6TtRp4cQ3lOjsyh0X94sHl4USC+CH
	KxaWrvJN6lBJJlVX6borvDDDgUMG/LB5rB9j8Kc3dtsgkwkGCzYuWBUrJnIWsD2oXbrIg==
X-Received: by 2002:a2e:90d8:0:b0:39a:f0b5:7656 with SMTP id
 38308e7fff4ca-39c5fd1bf2fmr1943191fa.4.1783352387212; Mon, 06 Jul 2026
 08:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706143726.47421-1-stephen.smalley.work@gmail.com> <20260706143726.47421-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260706143726.47421-2-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 6 Jul 2026 11:39:34 -0400
X-Gm-Features: AVVi8CdN-3FxbFHqAZtrdV3mY_ZZz7hgnuXLnIRojfM0VQs5Uo77Fe3FHx0jhHE
Message-ID: <CAP+JOzRYWVLBCHZT37ESKKvaMxgPhXj79AMizWebQ6jq4UDGUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] libselinux: selinux_restorecon: use openat2 if defined
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 10:37=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Update selinux_restorecon()'s safe_open() helper to use openat2()
> if defined to optimize the lookup of the initial pathname. Fall
> back to the existing per-component lookup on ENOSYS/EINVAL so
> that pre-5.6 and seccomp-filtered environments are unaffected.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

For these three patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/selinux_restorecon.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index b34d8e60..30f1b836 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -25,7 +25,11 @@
>  #include <sys/vfs.h>
>  #include <sys/statvfs.h>
>  #include <sys/utsname.h>
> +#include <sys/syscall.h>
>  #include <linux/magic.h>
> +#ifdef __NR_openat2
> +#include <linux/openat2.h>
> +#endif
>  #include <libgen.h>
>  #include <syslog.h>
>  #include <assert.h>
> @@ -1114,6 +1118,25 @@ static int safe_open(const char *path, struct stat=
 *sb)
>                 return -1;
>         }
>
> +#ifdef __NR_openat2
> +       struct open_how how =3D {
> +               .flags =3D O_PATH | O_NOFOLLOW | O_CLOEXEC,
> +               .resolve =3D RESOLVE_NO_SYMLINKS | RESOLVE_NO_MAGICLINKS,
> +       };
> +
> +       nfd =3D syscall(__NR_openat2, AT_FDCWD, path, &how, sizeof(how));
> +       if (nfd >=3D 0) {
> +               if (fstat(nfd, sb) < 0) {
> +                       close(nfd);
> +                       return -1;
> +               }
> +               return nfd;
> +       }
> +
> +       if (errno !=3D ENOSYS && errno !=3D EINVAL)
> +               return -1;
> +#endif
> +
>         copy =3D strdup(path);
>         if (!copy)
>                 return -1;
> --
> 2.54.0
>
