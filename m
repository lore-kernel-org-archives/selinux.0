Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D123ED3A3
	for <selinux@vger.kernel.org>; Tue, 19 May 2026 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198671; cv=pass; b=bh4IGjNm6qHW3/I5FGZTFZ6IQnb8HUzuZOb0wfBioXJinhkbsU7AMw+kMrnzvr7JlJ6JZJYmm77Y9RtRs5KH6jMtd/pGPYREaE8imvK83HgnxGeCsa7N27dQK5E6XJYSU3rmvbDvU+CtuMvcGxdgUWx7FlugUxh/YZ37JBsGKGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198671; c=relaxed/simple;
	bh=MjmPIS5POhSIOTAdtl53+TbG6FNEsDUlw3IuNwnMKws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGTv4UCySUHGaI2ME1rsn3Oqvl0tGMs5VvA7VA2cCz515td+ytqd6kXb4Qb8cnCo3sZNw9WMMluuq4onXtxIDn8hwrujjQVhsPFqBWkHhPCNSLedIkjpeAAQLmCuLcobyqcOkr9MTjIyk0FobTtUU9lO2M2JAU+np+iYTEazR0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=KqDlH6Wn; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KqDlH6Wn"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7c23248f3a3so32156807b3.1
        for <selinux@vger.kernel.org>; Tue, 19 May 2026 06:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779198668; cv=none;
        d=google.com; s=arc-20240605;
        b=le5dr33k7jX+zdpoYlp4MeIzqvpv1lgoQfy5AsJhI0OYSlQFyko6fSjHGU+HpPN/2n
         d/jnY2vuzrJl3xa0mgbX6Igyso0qBYqHcP0QIzjajVkPKe3ySgh62LLrrlceWNlMbMi9
         /qAqMxxuKL8dQqG0qZPdTfFhQuGgAI7BwYlnXCJc/pKTv2TGyilF7fBEjmDY1XO48fes
         kLYc7yN9xif2H68ojO0UXqWfL2f5N7Kyh6yXVIlgt3CdSc1NG6YaNjmnyIrbbSnaJ4Y9
         dJTfY4uQYPqDKFBlsj9GS26J0/waitTiudGivO/M5//51bqCP+5XzsANW+3jRKQEPQQ/
         5+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xToc4ax1ZeAWa+BCF00ypSwyqlJz7cJxEpXxSdyr3Hw=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=Y/W53wsLeBLakE50njQgEv6OxNnunNQM7V7Y6FdT8sZTkDM/rXaRnZkwiHi2MuflZO
         2EfsdraJwhqt00hMfVm9/KYFOjQ02nAfjle/UFzwLVZOFrFTcId3frY6h0tFoYTY1iq+
         32EzG6yu/rJ3cUlR1qPipdOfytzNA0VIKP0iiuqSs1YcilIODsU4JwoQ8MfF8TuO8+2C
         JyKlucW9j4A+so9ABldO0mARZs3E2EZxUEUgiGya2Laqo0H0n5sex4NSwVLIYRUHa9hd
         Xr/4UDYOW8lDHJh6RRzde7uGcCEkXN85xvRdvkc1SUXn+7fQ2cUM8W1GtkGpGmrmXQhR
         Wwjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1779198668; x=1779803468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xToc4ax1ZeAWa+BCF00ypSwyqlJz7cJxEpXxSdyr3Hw=;
        b=KqDlH6Wnvcj39gpZ1poTJd0hunKkElJHvSWdccbQhVK2VsjdSA2tS8Ey5UHhmbZGi8
         Zms0cZkvXO2n6bxJAwfOg0f1TFKbNGQaHJtqEenc9be6E5YjylpLzwESfp4M0jk/0Zs6
         wYSsG0uCiw97xAczes8nTTdaGJJICPJwhFslSmORm1WCoI353Q4bvkcA7An0JDh11A8m
         IQi8qubCtDznGePOy3pBWOjelrOwBPe396B92PlXoXnK5wMoH49ENuvp6UfPKJFgLO5B
         VALQ0Y4NLwSfBQ1bo4bYR/KLlMcgX3OUi6r7WWxws4tJvR+9HMQAvR2aSYx07KLURZrX
         IjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198668; x=1779803468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xToc4ax1ZeAWa+BCF00ypSwyqlJz7cJxEpXxSdyr3Hw=;
        b=dAYHCK6xIoqvVoQOMyyP+NYshA7H11JsmlnCxxqTjFcgW5zqKmw33ykA1OqlFNsKbL
         aGgDMl8c2dG3VSVgk0Y77vn267xuGUuV9SotvHRg1wMd6XqNMcFjlgAeeNf0yUw6QEqI
         uRcyoMUo+vLzfty1Cve1cdxL3482xqtN+JA2j+CWMJmw+L60k5L9/YrQBS/BGKSTOmDI
         0Sf/hGz1Z6a689Grm/71hzniwOfXeuhRjIRgzzSKtkIqqe/uoEPYutqXARU7yGVWrSWY
         H/GZrmTQnab1u8zNEe6gi0AW1rwBif4NGqFNFN1Mb992JGjIp+4XRh7YzkiylsTP0kug
         QEGg==
X-Gm-Message-State: AOJu0YyDaefuG4dbfYeky3nEmMYC2Xa/lI3JwtLSUMlZoQo59ZZ0vGmv
	oRWsd0P8KlbAGDVAqbUMQHnQezMGjxkFdtfN1WQ4FGcpoKDSnp8NUu8pYyBqv+RavujKjnZCSS0
	1KIPlbf1RR7zpPMTrrVwC/sGLRHcBBkA=
X-Gm-Gg: Acq92OFYONQG3z8GbrPXYeFh72ybjoHc8aI5vRrVvq6ortWCr/W9pq1rczvwE2IO3Et
	UOx8Os6asbMibdiI2XlqtbZzYDyCdDSeBVBNefrVSg83BTVv+em90ur1R1M3eXq52C+yExkMYR0
	wWM1WG8CQ5eVbzNWymtDj/J+PV+PrkdE3rV0aYMBhdI9w5cbbLvZ5PR4AMWxDPNhFBDHRv7VTKB
	zB+zlycOYELNrcJZ7xy+0O5sm5arxQLYlWnwp1nFJb1oGS3gNbLR/rAFx1QBPM1uFI1mwuijNaO
	NyOcm8QbNKGXaoBMUKAgQgk/BMgLwRjGTyyETXLsow==
X-Received: by 2002:a05:690c:f15:b0:79f:3715:1980 with SMTP id
 00721157ae682-7c95a37c674mr228167617b3.12.1779198667665; Tue, 19 May 2026
 06:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219132151.34299-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260219132151.34299-1-cgoettsche@seltendoof.de>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Tue, 19 May 2026 15:50:56 +0200
X-Gm-Features: AVHnY4Jw4IcV8WaGDkqsjj-EQYkzIX7v_VsLNIldplW1eBobKV-abwLN5NC1nXw
Message-ID: <CAJ2a_DcODAx5xGABLHbuTjKgGpAB46KNdHC31ffWGj1h4m-ARw@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: improve restorecon progress locking
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Feb 2026 at 14:21, Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Use an atomic counter to avoid acquiring the synchronizing mutex for
> each file.  Only acquire when actually writing to stdout.
>
> Also reset the scanned file count at startup in case the calling process
> calls selinux_restorecon(3) multiple times during its lifetime.
>
> Suggested-by: Copilot
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Kindly ping.

> ---
> v2: use GCC builtin __atomic_add_fetch() instead of C11 atomics for musl
> support
> ---
>  libselinux/src/selinux_restorecon.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 8fadf4d2..ac9f6bc5 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -39,8 +39,6 @@
>  #include "label_file.h"
>  #include "sha1.h"
>
> -#define STAR_COUNT 1024
> -
>  static struct selabel_handle *fc_sehandle =3D NULL;
>  static bool selabel_no_digest;
>  static char *rootpath =3D NULL;
> @@ -694,19 +692,23 @@ static int restorecon_sb(const char *pathname, cons=
t struct stat *sb,
>         }
>
>         if (flags->progress) {
> -               __pthread_mutex_lock(&progress_mutex);
> -               fc_count++;
> -               if (fc_count % STAR_COUNT =3D=3D 0) {
> +               const unsigned STAR_COUNT =3D 1024;
> +               uint64_t fc_count_local;
> +
> +               fc_count_local =3D __atomic_add_fetch(&fc_count, 1, __ATO=
MIC_RELAXED);
> +
> +               if (fc_count_local % STAR_COUNT =3D=3D 0) {
> +                       __pthread_mutex_lock(&progress_mutex);
>                         if (flags->mass_relabel && efile_count > 0) {
> -                               float pc =3D (fc_count < efile_count) ? (=
100.0 *
> -                                            fc_count / efile_count) : 10=
0;
> +                               float pc =3D (fc_count_local < efile_coun=
t) ? (100.0 *
> +                                            fc_count_local / efile_count=
) : 100;
>                                 fprintf(stdout, "\r%-.1f%%", (double)pc);
>                         } else {
> -                               fprintf(stdout, "\r%" PRIu64 "k", fc_coun=
t / STAR_COUNT);
> +                               fprintf(stdout, "\r%" PRIu64 "k", fc_coun=
t_local / STAR_COUNT);
>                         }
>                         fflush(stdout);
> +                       __pthread_mutex_unlock(&progress_mutex);
>                 }
> -               __pthread_mutex_unlock(&progress_mutex);
>         }
>
>         if (flags->add_assoc) {
> @@ -1118,6 +1120,8 @@ static int selinux_restorecon_common(const char *pa=
thname_orig,
>         int fts_flags, error;
>         struct dir_hash_node *current =3D NULL;
>
> +       fc_count =3D 0;
> +
>         if (state.flags.verbose && state.flags.progress)
>                 state.flags.verbose =3D false;
>
> --
> 2.51.0
>
