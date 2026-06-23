Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19D723D2B1
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227478; cv=pass; b=odZ+hrF3AlRe1iZcBDPDWbW4Qhd4E+G2qFd8lUy3gJio7gJFG9x7T7jYdWJ2Zj9V/0495K5bkS4ng3Q+hTFQo64hkSzoKkOwRAMgHZlO/leYb0bOF4Nfa2U/FPddcGQg7UhU05ZWGvDDHTLWceUjKrmTktbjDMFX+TOpf0TX25A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227478; c=relaxed/simple;
	bh=nA4NrPNsUIuxUOsj6lTVnGRVn1fKF/rLT6J7864ct2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEGpCMWYB22HoGMp2kLT9995K0gExb+URuvdeRVnJJNFFP1AolUpGdj18kZfyJVgRNXbgE5Kdmb4UorssICjOzOq5paJd5UVzuO09gO3OnHiM2CvaeIwnRc9vuA6tlH9Gt/rjTJoZMM6f4ELlq6jueUt/ZySNBeOGC3dyiW7Lk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOm6jQkP; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOm6jQkP"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8422a92b6d6so658798b3a.1
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:11:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782227476; cv=none;
        d=google.com; s=arc-20260327;
        b=kFeRbxFyGYZmFAmKQEAEqzSu2T0GzfAZl9orwiZ/LyG1BMr0k0nbBxF4yGihwz/1cm
         +0nr7SmsRQl2TU9gu4OsTLI6F5tO4xv6h6gSRAhTU+S9xjuJsQ7u8W/T0wSymaRkc1Kp
         Cn7UjEoOzL3lwdmywvV0a6C3wgnE2wghMMWctjXYmKjrRgbvpkmMKaxT5kUw+8NCkl8k
         cNhCUjQbR3eHUKpHtqQWwJvBPQl+LSIvppXzCtRviOGQyYonxdEQTZLFBvHc2ytFKzNb
         Za9Fet2gSNLgu2uWTFPoWjzQK2xaQ9nQUT9RJWwiKlBQ7AQFrFg5bW3+M99SOXqNEzPB
         Qmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FaBxtNfb8MaoFnYG8O51uwSM5TYTNi2sqFM0FPZzTkk=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=DC/MPxsYCuWfbVr4n64OPHDODs9dmroS7Rv1IIoSftAzQoEQidsTbm/Jhar11AcQlB
         6x+vvZ0cpcbRd4sPA9Ji/fOOilRJHb8QOgBFvSCs2ozs9YhPqmuG/IT8CwgU5c6b5UDi
         0bNy5bS8s/iJlYOrblGT5F0YNZHHk35mL4zGdPnl/ztM7tBDa4ruAbuRKvHvbLIMjoNY
         Ordp+691ZiBK+1uVWOji5QaA4BU6ihcmgmLplo+JaJny3JoSJLxdBqf3IBFMLCCidep7
         N6GCNw9xj0KrkXKktGw76VlJsgIXoGwICsVmK8SQjCzO+BBPffwyezWKcAs3uZhQUxlN
         qeMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782227476; x=1782832276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaBxtNfb8MaoFnYG8O51uwSM5TYTNi2sqFM0FPZzTkk=;
        b=iOm6jQkPApM1uigVUAHlkp2Drb7hYQvq+4KoA9P0xpeYpNuATvKUj221DWtKC9YD5g
         0QTLrg6oOCXa5fNlykGo0aGycZ5yu5jov++XPu1g86j41LXpeBfLC+xGQ7roi2fZrHSH
         0AVlCzPbnV1ZhkNzoqLrdPgKxRnO/DkX93AZ95lZiu37ExIF05A/KyGXE8yubgVNM0Rn
         lKY1gDx+LXzskyrnbi23wkLsrvEku9o4hk0pKS/QLWRvEtGfqyLRgAfCltrZNykoaIvn
         3lpgMNW8sA9U34oA1dBEmYJt/sfX8OjBFiJaTh+XmjqbHqlgg/VDX0P2cvg7ORpPzoOO
         Eu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782227476; x=1782832276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FaBxtNfb8MaoFnYG8O51uwSM5TYTNi2sqFM0FPZzTkk=;
        b=KBjsvJT713Ja6+zsx/FloEghCcqoAnivcM/HUykqFQVzVUtqk0YPKs0MQGsu/5d7oS
         4rXMu+Sbd3hcKTnfATDrWowKNTR7VSCGtS8PZYNH4qbxyEQbwd4h+7Zd1oAcZTK4gHG+
         HLaYOFimJxM/00DtR+FYUKezYaIjqR0CesiZTHP1USrmCEFjPOOdAE10TN3EUXFXJLVn
         WYDusR1c5Rxg0ot/OutsS6AhDYbJQgqTZaxcAdABuKxDwMFjOOMMtKpyVl2A0xr9Bcwq
         cWuzA9NLK+oQDGCNg7HQJXB4OsP8ASwfG3mr8+jTWAPJEOm7s54yVi9VdRQSg5++LMIq
         seGg==
X-Gm-Message-State: AOJu0YxirYbJAQhr0EuMj8kVTjS2n3ZYMBdocwCZ4q5f5QZp9qmI4o3v
	um2KPpOR6LPz6bruvtVtQn27s0Ah9FHHiHCbrVqYS1iQg04SFXFI0G+re16+vhDUjwd+q3Y9PNz
	npifVrbWP/dtpVpgKhiL9AWlrX3ortBH9gFyD
X-Gm-Gg: AfdE7cljsyQFCLeR/o6zWFH8qNEkK3HnLj25at7A6HE3mi91wVtEwowqt3ZQwKgyPfq
	/8gw6hbdd9iggtaChmLWcdGgrD5g78NW2rWGJVAjcrBqlRBfWaOOOlB77uk6vqYG7jL6erNk5IS
	ZXY01+3l5tORjyunwhlqFeRYHo/Ha/HF+nyjwtwzu58neDsCHBDKe4HRqLsygnqB7CaXWlalxSl
	1RTbMJl+DDrrFdmUhGFDN9cXXWkFB0Bw53cdJuxLCSjlnrvan/otsb3a9d9X6XiHMYdlQ4UVBtp
	DS/rVjc=
X-Received: by 2002:a05:6a00:2c95:b0:842:5ea5:5fe0 with SMTP id
 d2e1a72fcca58-84591b260d6mr3862565b3a.6.1782227475980; Tue, 23 Jun 2026
 08:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-10-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-10-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 11:11:02 -0400
X-Gm-Features: AVVi8CdK3y43q2drAvbZ5kdVNQkIFosRn9N_avI3vllUKDwqW4Glc1vDcB40yms
Message-ID: <CAEjxPJ4xSg5FxztP_O9GxCj4ud4i-UjR-wkfBio38E2BZrTV9w@mail.gmail.com>
Subject: Re: [PATCH 11/24] libselinux: bound permission loop in selinux_set_mapping()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The per-class loop indexed both the caller-supplied p_in->perms[] and the
> fixed-size p_out->perms[] (sizeof(access_vector_t) * 8 entries) with the =
same
> k, stopping only at the caller's NULL terminator.  A mapping table with m=
ore
> permissions than the output array holds would write out of bounds.  Cap k=
 at
> the output array size.
>
> Also drop a double space in the log message; the neighbouring "SELinux:"
> diagnostics use a single space.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Should we return an error if the input exceeds the expected size?
Regardless,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/mapping.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/libselinux/src/mapping.c b/libselinux/src/mapping.c
> index 6b9071ba..ddc11dae 100644
> --- a/libselinux/src/mapping.c
> +++ b/libselinux/src/mapping.c
> @@ -13,6 +13,8 @@
>  #include "mapping.h"
>  #include "selinux_internal.h"
>
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +
>  /*
>   * Class and permission mappings
>   */
> @@ -79,25 +81,22 @@ int selinux_set_mapping(const struct security_class_m=
apping *map)
>                         continue;
>                 }
>
> -               k =3D 0;
> -               while (p_in->perms[k]) {
> +               for (k =3D 0; k < ARRAY_SIZE(p_out->perms) && p_in->perms=
[k];
> +                    k++) {
>                         /* An empty permission string skips ahead */
> -                       if (!*p_in->perms[k]) {
> -                               k++;
> +                       if (!*p_in->perms[k])
>                                 continue;
> -                       }
>                         p_out->perms[k] =3D
>                                 string_to_av_perm(p_out->value, p_in->per=
ms[k]);
>                         if (!p_out->perms[k]) {
>                                 selinux_log(
>                                         SELINUX_INFO,
> -                                       "SELinux:  Permission %s in class=
 %s not defined in policy.\n",
> +                                       "SELinux: Permission %s in class =
%s not defined in policy.\n",
>                                         p_in->perms[k], p_in->name);
>                                 if (reject)
>                                         goto err2;
>                                 print_unknown_handle =3D true;
>                         }
> -                       k++;
>                 }
>                 p_out->num_perms =3D k;
>         }
> --
> 2.53.0
>
>
