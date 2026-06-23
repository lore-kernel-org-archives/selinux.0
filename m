Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2E5311968
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235281; cv=pass; b=gVwmBOWAKSGnZayXG8UOWZDNMjP3gKHtUyH1cHCTWL2NTRJY8I3zpQyyBEuPoPVt7vjtM2BTfTJNFq/j79IApKKHOig1SDatLIx95Kd8KcAGamMP9vxCRQf/M/0VGAWDHRzaO9K4XT5DHk62Qu4cAz09uBaVV7pyP0E2dXB/Jyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235281; c=relaxed/simple;
	bh=GI989BJELXfCxGoSdN+kLg4af72CEyBAtOd+8aWv34Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDUgk9UTsyCXzsVpoGrAGRHTrD8LFS2GOkurhQ0mLkGFVQ/jOjr5QURnQsTntemUNx9UxT+aS0ID7GuGIuGU6qtuSK3dYx5pCh3gsg+P0ynOL99+jTgGd6LlQeeK+k4P2/UXMVXg7Rh1AET13UuG8FpkMhmZSnywDT9ac1mDxZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lo04749x; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo04749x"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so156787a91.1
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 10:21:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782235279; cv=none;
        d=google.com; s=arc-20240605;
        b=E57air61orwPKUlWJRF3D2hsgUSxx9S7d9uVEyT4TlMYzdWz4/o/IX+tdlcRCOrljY
         O/5c/JEBzrrpyxG+Wtn/4hxGL6I1L50i2VS37Vg2kTqa6TyzBpI+Px+gQAUTB7JqZPjD
         yhvM6rKb59dEn5S8V/EZlDManigCtxmYaPAPi6oNVYzYsOjcRPCrqyl6j9F0brpc2+Lc
         L2HEnsrhP430oMCjeritLPtYYE4ZTkjXBn7uFex6sLaVwfWQfMAVrPDRvunCaOyiGkk4
         SHaonEW/67cAa4n0ecsqfefz6htrNCJ2jrmx/jrTZT0fxUbkBIBmxrBsZfpI2fOoPpCO
         G9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yiZZZEYoX1+y1AHNsY6nAa3144k0LSfXqlBOqJaqMG0=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=L7pWf1osjJOuzpcdLVrzPcCHlJ612SvSYP/MmHU6gC06V7CkDwR5v3Iy/qq0syc5z3
         /FTuCVep7KU0FRoDBD/wo67n/DK9FdpyCLmGlsNfNBS+Ejg3sl2vV6Kh5uYaYm5Bc9LJ
         5jEZYuHOi2bZFwrFz39fwfIeu0br4fDRy2Z8pgiGJp4BndN2xmE3mmGTOJPpJJKzwpwc
         MKOD1WRNaYTCeWiH5pvHaXQGv59REcpfOMlXjPtrpGH+OQ6fFYJdB+nWw4CrgDBTts36
         hdn5fTbRW4bJ+DeK4kBQmx9O2fhoB4HBvtsEavYb5Nk3vzC7zZub9O3ZDyj9IKHeV/4d
         ZN/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782235279; x=1782840079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiZZZEYoX1+y1AHNsY6nAa3144k0LSfXqlBOqJaqMG0=;
        b=Lo04749xDh8/06jfaQ8oa9TIJ6j8G2f7CuWR6Ps30EQjHv1u3UNMYxSLAvz+wOpyt5
         Fd1DbYPtgIfab/rb7KnyV65bFj0ZyTvgVLAbONeo8g+12LOd/t/vPld2QI6ITwaJr+6t
         WLsTV3GYoO13MKYsfH6UPv3k1QfASIBX0Pm4WnVERpj93eAHxhMx/w35Is9OvbIwh07i
         AtjbjzKRsPWPbredZWey9TzACL66+rfXUhWUIqPgLGG5u5nsHKWC00ZfqXDrjfepg7cf
         QC7Q+r9Dq7YKLXRmcFIUTQKC//z7yzcyb/beIWKDGWIvzC3sJ5QM55KvHQUgCukenLVq
         CnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235279; x=1782840079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yiZZZEYoX1+y1AHNsY6nAa3144k0LSfXqlBOqJaqMG0=;
        b=HIcxoVWrfJDVHmJ4XKyukIicLl82U4+yvgr2q2ukbFg4FTvID+KT44ROsbmmZ79IZF
         7niNVx8K66J+b7GxakPEwMHWszglVeWuESasajo1MbaYxvVe9lop+1rfa09bDCC7ojXX
         hMkzift3FPE/gg8FIW0jNzcdV6MJQUvh1zKvux/cyQbt+Kjtftr1maSksjkuzc7xXfg3
         86X2+iVDpOYg/VSEV+6d6NTJ00jhxiz7QfgMnqy8jlReQa+5W4KJV2svIYeU2CcZ3pbq
         xMIu2ARU+O7EO1Lvwq+VWrReWCakTEUu2ZX0yaJOFXwKSS+69vHwER8mEsJJEMIBmNme
         4iZA==
X-Gm-Message-State: AOJu0Yy/bgvWKZtYaWh930CNZTSNFsHL2AR4DwwzbKQJlgz/MyFCP9FL
	xCymkkVDdW6ZkKrwORI8l0aYmeUsbmQ18GvT+X1G45+MzMGD+qb9cQHKcfPqS8kGB1cv7iKtwNd
	O5ED7ibE1QoI5lYVvxzYm9V7Q4fywbok=
X-Gm-Gg: AfdE7cn1xb/aJLxg30rlUq92zYYp+xGCDi/VfWes7loBA/lsSnxCZGRIN5sTYsBeL7U
	NoZR25LDs0b/pbnreKm6CUMo9dKkUV7DszS+5PskUgj44fdNgDkHVD8lvfAx+HZKbZy90alzw99
	BIgYFiH3C+FeV8eWGJdWQDy3+N1FtWpU3dUBZ8oLMwWfEa3Mr70mj1/EtALczImpjqnLcCZBVV7
	iZSa9RCX7+2c1wJ9xsdjvb9MzHy13tI6EZxhjMNAv2N3gpo1n/Gk1FMO+N8FAGyoqs1vg2B
X-Received: by 2002:a17:903:3d10:b0:2c0:a360:45da with SMTP id
 d9443c01a7336-2c742b5d928mr174162305ad.32.1782235279370; Tue, 23 Jun 2026
 10:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623133950.96060-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260623133950.96060-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 13:21:07 -0400
X-Gm-Features: AVVi8CePImp-q12I9OOaILlUWpW3YVGQf8E_KUvKDvOzXkK-c25SuSvLzz-0LYk
Message-ID: <CAEjxPJ4m7__fzUnv2KP2hqLAzNvEOqn_xkH_oEMxP7hfWpHdkA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: avoid 0 as NULL pointer constant
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:40=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> fts_close(3) takes a pointer as argument; use `(void*)0` instead of pure
> `0` to please building with `-Wzero-as-null-pointer-constant`. Avoid
> using NULL to not require <stddef.h>.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 0e465f94..ae8586c6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -29,7 +29,7 @@ endif
>
>  # check for fts_* availability
>  H :=3D \#
> -ifneq (yes,$(shell printf '${H}include <fts.h>\nint main(void){return ft=
s_close(0);}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -Werror=3Dimplicit-f=
unction-declaration -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
> +ifneq (yes,$(shell printf '${H}include <fts.h>\nint main(void){return ft=
s_close((void*)0);}' | $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -Werror=3Dimp=
licit-function-declaration -x c -o /dev/null - >/dev/null 2>&1 && echo yes)=
)
>  export FTS_LDLIBS :=3D -lfts
>  endif
>
> --
> 2.53.0
>
>
