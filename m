Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A39470135
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662931; cv=pass; b=UEPhqyuYh7oo3W5lFHG02csEFTdzbFf8eLrHiD+qulFr0GuCqXtusAd4qcMTo1sAxDegN9g1qI0Y1KoskaAOWUbOEzJZ10Y0KHlfcAYNBChufz0vdN7Wsaz/0fWsXTvtzjJAUNZ9+FXacQ1vjUsQpaSpZSImDrIvCcKTBhoQYtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662931; c=relaxed/simple;
	bh=diE1whOjkH0bFyv2mngPR7d0WHSuyf1mh2P0sqK0PsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sztfzvSwCvewyi50jE3CmME6lG+Ijh+rs//bY0KUMcCsEelRdpqf44D9qiN3NFbVanDyazYU2lOxg/poc4Xxgyz895W6JVs5kdZGgIMUE9uE03WLP0lJmEubCg6NJ67JN6o2IXEUxEUG4w0/H1nXD+3U/8GI7Ui9Mdoj/k3NUSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gR/ukDGi; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR/ukDGi"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9e7391839cso7465458a12.0
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 12:42:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784662929; cv=none;
        d=google.com; s=arc-20260327;
        b=iv0fdlJJR6LllbNTOggre6wO58aqiI+rwqOzL5PNYlGH8OJFRMn4NvnNyk0xtHCBVB
         tYmjVIz+PNkCgxbbaISVxahIUhIp8VYoCgFE3Y3iIyF6CkC3wA/GotTuOxCBjeUjc9Se
         53DblGGu5+AiXYqRmZdTikUeGke9FpMiHDcLAQqZ7VVv5TcX6bm5h2AmXdfqZjP8MVr/
         1QO1SaowmwJb//c5vOws3fF7DFyxpjvOO/xjKziQmRjCY/SRB3+MRO7crvDsSBjCcTLk
         02hr3hKaq78ojxjsxtZbOZfk0uD2KnoUy4Yug38hKgbS4LCHtbFxRAGcSBaDBJ6wKQH/
         rxaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bQgdgXuohWCBmTIQhuZGp6mXcVkcYSfhjCspOTO8eLE=;
        fh=o4EWA82M+vtfNglaTzMFhY8rIYTLnPpjxHW+AHnzuHs=;
        b=hgGQLbhLLMFh3jUC6E5tgltOYdr1q6fjUF8JUBHdQEPImNI0JgCtyjkp53ZNLf8Oya
         fOzOkw2Lg6Ww0d7qPAYoWPPwTg7BUXElZnvoXrOWked2D438perN4xtFW9dNHeGJRllo
         1dvq54G/Tto/B4Z6945WCmOS7iwXfKU5Xgt9qRHpZK8VSNBlljn4Hlj5qizU5JKp0XUT
         LxceIBkCv2eBzhYUGjSjJk74s1/vFDcsTCqh4MBkCTmhzwmfOpCwQlQXFCY+ssnFRnA5
         2Q8xjI9cOuO90NuZfPnT6+sxajEtSCiNGtn4WVR2MR98TVeFyjn2IkyHAgi1dziyjh2E
         87kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784662929; x=1785267729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bQgdgXuohWCBmTIQhuZGp6mXcVkcYSfhjCspOTO8eLE=;
        b=gR/ukDGi5A1hJyzKP8OmZp7G+eLRduHfa3dx83MukMynwzAD6z3CZh0wFVqrTrOYeD
         kTbFAQhm8C3TGnsDb3GbcFzw1sm4JERvNBmwJ58IO0PR1i782M+gIagvfGy6sA0ID3z3
         m6D8Cz05VcgjeoA/QMMaIsubR2kasXwuis3TVQL83MWCVzsY9df0omZEYVBSoJaHdfOX
         wnCS+PT/J5trZb7RrjSAELOVkrwoeK4NWtiegQmhkb5S1ay9iuAjaD58AFSltYIwiJp/
         MiVaPJPofSDV8DflR50Sx00FpDMeCM8yS67DVprhc+vXhGZ6g2WRq8a2HF18breZK/Jw
         tDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784662929; x=1785267729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bQgdgXuohWCBmTIQhuZGp6mXcVkcYSfhjCspOTO8eLE=;
        b=sIiu77JYDPgB1Mhy+4BcQrazk5uuUERv8YGB1+7dLCZcfXJdGtiHNV/bIqLY+40J0T
         /GvTQ001HNKE1WCHP6ccneYh19qkie16MnECm8zAoABfPhRTS0c2aVFvdXYMcGSR/3JZ
         qisIpks+TKG0tl4F5+lJol/xuVw2SZvpVna1qJ6q0dmIw71pu2dFTSq3G4XNSXodQ9D+
         H5wuvLv1h7bZDgiXUrzinMZQ8DFfW7l4Et3Owc/XM2DH70JNqR+lcL3JGIj1q4pOO2G7
         smrV9/HkZ3K77Rwz/X4M8RQDtIivddYSGS2ARyaUXwinYuQ8mAvxeQBkUawUo0wzqcEw
         0H8w==
X-Gm-Message-State: AOJu0YwK/cMUPPsQw2xNsMjknw9cBZfMNAIs3EzWod1FZrcwI7+uotkF
	bTBjR8/qVrYXYLpG3AzrbRfLx1tryIV1syxGIux8z9DxvF5AQCye18/SGHxcq9GL4hSO5ArZndr
	n5aD47cKq+2rHYOtHG+4CHBF9IRTrqo8=
X-Gm-Gg: AR+sD11J6ZJcPxwBl1Tx+PMTVcTG0uSEl5jLy1XGln/f18LIp3aUPTld+RRHjrv5OAk
	BsRZkIcietkKUvV2XcSu44uNvEWpCyYQ/6aXDHX8/aHiCkqMpxwgcv7HnZAfpqbNTH0ihUvLsJy
	6wsE1bYyOgk4D3/VcdPNjUnpXf+wg1IYmU7Sy55umHkUMlp/3H49A+AGoU7P5AEe0cY1dLocDBM
	64n1o5VrxiZ/1Hl07SYGwsNiJyFHl79GIn2apKC72MR5ldURPgyeba3sjQF5Q==
X-Received: by 2002:a05:6a21:7105:b0:3c3:6ea3:f3d9 with SMTP id
 adf61e73a8af0-3c3ad9ec20dmr22477495637.70.1784662928865; Tue, 21 Jul 2026
 12:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720105606.305073-1-pmatyas@redhat.com> <20260721110839.431114-1-pmatyas@redhat.com>
In-Reply-To: <20260721110839.431114-1-pmatyas@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 15:41:57 -0400
X-Gm-Features: AUfX_mztILYBhm3zH24AHOpdwY0Dfsa9HHwX2WmiYc-NvcrpykrgLxNNW9TAU3k
Message-ID: <CAEjxPJ7Bg8FV12YqHxOzHr+Z3za6M1hoCOV_OL68PJ1Jf23G+A@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: add module package fuzzer
To: Petr Matyas <p.matyas13@gmail.com>
Cc: selinux@vger.kernel.org, Petr Matyas <pmatyas@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 7:16=E2=80=AFAM Petr Matyas <p.matyas13@gmail.com> =
wrote:
>
> Add a libFuzzer target for the binary module package format
> (.mod/.pp) read by sepol_module_package_read(). On a valid package,
> also exercises sepol_module_package_to_cil() to cover the CIL
> conversion path for module policies.
>
> The seed corpus contains a minimal module package produced by
> checkmodule + semodule_package to give the fuzzer a structurally
> correct starting point.
>
> Wire the new fuzzer into scripts/oss-fuzz.sh alongside the existing
> libsepol and checkpolicy fuzzers.
>
> Signed-off-by: Petr Matyas <pmatyas@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsepol/fuzz/min_mod.pp              | Bin 0 -> 859 bytes
>  libsepol/fuzz/module-package-fuzzer.c |  47 ++++++++++++++++++++++++++
>  scripts/oss-fuzz.sh                   |  11 ++++++
>  3 files changed, 58 insertions(+)
>  create mode 100644 libsepol/fuzz/min_mod.pp
>  create mode 100644 libsepol/fuzz/module-package-fuzzer.c
>
> diff --git a/libsepol/fuzz/min_mod.pp b/libsepol/fuzz/min_mod.pp
> new file mode 100644
> index 0000000000000000000000000000000000000000..264bd4406bf94b1c0044d46d0=
ca82fcdc4716f88
> GIT binary patch
> literal 859
> zcmb`FOA5k35Jbxl=3DuVd|J%Q*A+_=3D+~2MCyq;4dTjfQwu~Jg+OIFa^zEK*a~mbWhh*
> zC(yS?b#DP+3;|pp)qMb9y%;ZdX?Yp1d{Q1=3D8^EZR_3@$y;IvDllTSJTW|Qf>?pS0_
> zHBrrzoHHN0Jnz=3D6t<MgUaFAqvvv+Y3Wp+eUE^I&aR86ez;Ih;mqe31{=3D)Jy=3D*gJYM
> z)YoZe5nJ0l^b4_C<_yiy`HMz`Zw0+SohO>SzP<k!{0FXMy?QKdaP72i-21Sn6|wj4
> Fcmk%9EE)g+
>
> literal 0
> HcmV?d00001
>
> diff --git a/libsepol/fuzz/module-package-fuzzer.c b/libsepol/fuzz/module=
-package-fuzzer.c
> new file mode 100644
> index 00000000..2516970b
> --- /dev/null
> +++ b/libsepol/fuzz/module-package-fuzzer.c
> @@ -0,0 +1,47 @@
> +#include <sepol/debug.h>
> +#include <sepol/module.h>
> +#include <sepol/module_to_cil.h>
> +
> +extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
> +
> +// set to 1 to enable more verbose libsepol logging
> +#define VERBOSE 0
> +
> +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
> +{
> +       sepol_module_package_t *mod =3D NULL;
> +       struct sepol_policy_file *spf =3D NULL;
> +       FILE *devnull =3D NULL;
> +
> +       sepol_debug(VERBOSE);
> +
> +       if (sepol_policy_file_create(&spf))
> +               goto exit;
> +
> +       sepol_policy_file_set_mem(spf, (char *)data, size);
> +
> +       if (sepol_module_package_create(&mod))
> +               goto exit;
> +
> +       if (sepol_module_package_read(mod, spf, VERBOSE))
> +               goto exit;
> +
> +       devnull =3D fopen("/dev/null", "we");
> +       if (!devnull)
> +               goto exit;
> +
> +       /* sepol_module_package_read() stores contexts sections as raw bl=
obs
> +        * without validating their text syntax; sepol_module_package_to_=
cil()
> +        * is the first place that parses them, so a graceful error retur=
n here
> +        * is expected behaviour for malformed input, not a bug. */
> +       (void)sepol_module_package_to_cil(devnull, mod);
> +
> +exit:
> +       if (devnull)
> +               fclose(devnull);
> +       sepol_module_package_free(mod);
> +       sepol_policy_file_free(spf);
> +
> +       /* Non-zero return values are reserved for future use. */
> +       return 0;
> +}
> diff --git a/scripts/oss-fuzz.sh b/scripts/oss-fuzz.sh
> index 9376b6e4..08e06975 100755
> --- a/scripts/oss-fuzz.sh
> +++ b/scripts/oss-fuzz.sh
> @@ -74,6 +74,17 @@ $CXX $CXXFLAGS $LIB_FUZZING_ENGINE binpolicy-fuzzer.o =
"$DESTDIR/usr/lib/libsepol
>
>  zip -j "$OUT/binpolicy-fuzzer_seed_corpus.zip" libsepol/fuzz/policy.bin
>
> +## module package fuzzer ##
> +
> +# CFLAGS, CXXFLAGS and LIB_FUZZING_ENGINE have to be split to be accepte=
d by
> +# the compiler/linker so they shouldn't be quoted
> +# shellcheck disable=3DSC2086
> +$CC $CFLAGS -c -o module-package-fuzzer.o libsepol/fuzz/module-package-f=
uzzer.c
> +# shellcheck disable=3DSC2086
> +$CXX $CXXFLAGS $LIB_FUZZING_ENGINE module-package-fuzzer.o "$DESTDIR/usr=
/lib/libsepol.a" -o "$OUT/module-package-fuzzer"
> +
> +zip -j "$OUT/module-package-fuzzer_seed_corpus.zip" libsepol/fuzz/min_mo=
d.pp
> +
>  ## checkpolicy fuzzer ##
>
>  make -C checkpolicy clean
> --
> 2.55.0
>
>
