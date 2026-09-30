Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8031C4CE677
	for <selinux@vger.kernel.org>; Wed, 30 Sep 2026 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790772531; cv=pass; b=fMpjLGW1fG5CRguEsJ2BBTEiefVYkxg5ryi4XNl7AXAEbCWB/uk7rvn3nFX5uk38pn6afSl9XkWdo8Boi0ydiIWGL3BDpdVMvUxD7mk737PDyttTsruQUw72S7N/jZ4+yioH1zgiZzx6zx9ZmKW5GyTR6xd+i+VCccn1g6CYIoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790772531; c=relaxed/simple;
	bh=N3FMAvWEt17Bf7x0sLTX/js5UtRHBqOSYKoNkgngcFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KANKa4hR9a/v/3WPUqHTsRQALx14Of6IEyErgOzZ+BKfYciWm2pq6EjfOtnvwfgXMF8uer6Ra7DVG40zIIDDDIXZs8uiRQmUgGSABCE3nxlM9dKh2rhPPXWX2+Llf4jLstgxb7zWQ0M93tk1spcZenBjDaCj2/lEoZ0BIYGbiys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjoqcIbj; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjoqcIbj"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8ab441c70f2so16046127b3.1
        for <selinux@vger.kernel.org>; Wed, 30 Sep 2026 05:48:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790772523; cv=none;
        d=google.com; s=arc-20260327;
        b=GyyhMgWYB5UVh4yTTE3nnZCiNDfjy1XB5v7saUed7k9uOuwWXh+5bIaOH3b4QnpN/K
         T/wzgEA31j1am1X96+VzlNbm94EvcqP2Zryy7EOyfpfpXiXDYaHDaHLtPkOpuDBP3DCS
         qm0rBPLqE4ZpbNfZzJ0ErL4Dc+tNvFliXFZzcky1BJ8qtUpLnmSy5n6bQBs1lZt298jJ
         RVRYBihjvI/0T1UP/rbwm4G7t6V87b7Ns68WgywDXyYPwMXiZk15MO/F3617ytF1FQmQ
         Vrfek6NkuDpWjE4fRkdambb8XPIU87Dtctla7XhCGeGBjPL+dZ9hJed3uI8guBamVlR0
         gwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t7NycjNM/piEGewXqAmxiDWI4rObE1LmP0En6O75Xlg=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=RJ2nW62IaA11ct1pPzVN2AuUAocKD95Qu8N0w4SXgIS5DuOnvTRjpnLrXS5UAyvzS9
         X9NsHtrrIALNdUjnC/BOHEMbAYv/zpyPfxaIp5UpsaNlNACbtPyCsD2KiOdcCKnFUlyv
         OImzJ6mZh8J+UmWeFaR08uzcqPS8n0ZQtOm59n2bn6favfRn85vGBZ4t8+PjNvmVgpMH
         bTZzn7LYqu6gxZBir5cLfA6MAcVJuDIde4GAZGcrF+/mCO3dV9uvWfHT0gGzpyIRfOJR
         R+pCJ1IzRFEd06Mk8EMz8ZNWHHcZIe7h0rLjtyiDlI7Cy34gv60hu6dO1noIHL82kpMz
         4HTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790772523; x=1791377323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t7NycjNM/piEGewXqAmxiDWI4rObE1LmP0En6O75Xlg=;
        b=FjoqcIbjPuzqHNUEMUojwlkxD1KAiToascJZ++Bx+qfggH18kYDvjFS3rGBey5CDZv
         jIJm8SI2DBqbmx6XKXcUm1MNQD7Taki7z4hR/jHpY018DArtC5GLdOfEBw+CTiU2YdQx
         U4dMElFw7p5hAEniScFi856NBDHmPch2mfZ7nM2wF8aqstcngvE1jKExeAc3ntvcTTSI
         taDg9GrtpQVH/kxrwfje06wFVDjHEUrAIotVwKC8N/u70dxZi7W1MhJ0xALu9zU4j8yG
         0wxuMoo3DC2qKFWqYbbgbLlIjksrKwtdvqTOS09VufXZcl8X3Zhv1QTkVAiFqCec1o9Q
         XyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790772523; x=1791377323;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t7NycjNM/piEGewXqAmxiDWI4rObE1LmP0En6O75Xlg=;
        b=K6l5R4o7BBNNeQ9P2OHqOGd4Gxofgj8mP34EjDuiQCKqvwKeRGf9sH6adQ2Zlw9990
         mWTEg9kaB9fY0yOG6BOhstDLAJeO8yx5YuPi+m8l+tl8nZ6KC6uQPcUDu5JByaCsKAhK
         AwAMzjY8oR1cfnDv7p/0p2Dq4BuvTVJZ2Ga2j36UQPfKTQYudTTLif8WVigSvOmh5JIk
         hU9mZDmA9wLx3ZL0JsBEcwpEpScVzHaC4AOQ/0E0plS+bdqYKz6BHG+OoU5S2IVHNMh5
         T4RC/KMHsI3KCTDNTvdZTo4b/eAokX/aiGblHhCnjUDLPa7z4sDEtBrHSQwZn00o6Oew
         QGQA==
X-Gm-Message-State: AFq9FYKu2U1Ap2qpFWPRepjZsMCR+buZKrFqJ/GJ4tYe2OQy2L1yGD63
	GNQIK3FwdnfiVuJAJDKPEhEpwZBVihtqxEZWKNqGQQs7A0LglAIcJ+YYFRhWsU59liY3X2mFAxM
	zwPUwpox4sMJ4pP+NQEsDbQnBZopmaf4=
X-Gm-Gg: AYBFou1fv8skSYfVS6LlzBWUzu64/FY1LqLIY+FcOgvM5o6RL2pVd+EuP+JFse4syRW
	cH90IPvKM3oonFHpA97hoA3EWAjg/TMSqkS3xP/U/JDglU7P7aHcUw31wfLQX5zItHjwfC8ZkMr
	Fs0Zmb752Tc5E2rd9LfMgoFYQJZB/4NzXe3lrSqOBU+t/2qOd35poQ8SNrBbGtKHwBbIs23ZOtC
	wJUqZxSgzZEbsGbJk5S/NjpmyH3w9Q+fF7gUv2GB3plmU8/tv2KmUFmGXlJKFYRZR1L4KZMhkLB
	BxsFKSrUYORVzrTU145FxDYu1Y6OC3h4vhzH5CZXzaxE4H0LfooN7D4+rebdTuJ8WDI=
X-Received: by 2002:a05:690c:399:b0:8ac:927:f7d1 with SMTP id
 00721157ae682-8ac92d31c24mr5171927b3.22.1790772522831; Wed, 30 Sep 2026
 05:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de> <20260928155753.2259807-19-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-19-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 30 Sep 2026 08:48:31 -0400
X-Gm-Features: AclHuK_M4CQdSjFJkpS9JX9zAzxUbI3TEKsScI45lXXXkjkHdisjLFvpxOg9dv8
Message-ID: <CAEjxPJ5oW8QPVeiwPst0kAjKKL=CJLaL5H-44fYD4sdV-MMpeA@mail.gmail.com>
Subject: Re: [PATCH v2 20/21] tests: fail on compiler warnings and enable Wextra
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 5:37=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Warnings issued by -Wall and -Wextra most of the time point to actual
> issues in the code.  Treat them as errors, so the resulting test run
> failure will be investigated and the issue handled.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Again, you can keep Reviewed-by, Acked-by, Tested-by tags across patch
versions as long as there are no substantive changes.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v2: use correct plural in commit message
> ---
>  tests/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/Makefile b/tests/Makefile
> index d1edd4d..1118089 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -6,7 +6,7 @@ INCLUDEDIR ?=3D $(PREFIX)/include
>  SELINUXFS ?=3D /sys/fs/selinux
>  FILESYSTEMS ?=3D ext4 xfs jfs vfat btrfs f2fs
>
> -export CFLAGS+=3D-g -O0 -Wall -D_GNU_SOURCE
> +export CFLAGS+=3D-g -O0 -Werror -Wall -Wextra -Wno-unused-parameter -D_G=
NU_SOURCE
>
>  DISTRO=3D$(shell ./os_detect)
>  SELINUXFS :=3D $(shell cat /proc/mounts | grep selinuxfs | cut -f 2 -d '=
 ')
> --
> 2.55.0
>
>
