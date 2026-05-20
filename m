Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADFD2C15A9
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284148; cv=pass; b=Tjq9S5V5l4z3tXZOtMbyXZkImZVA2GJFapZWd+1COZr0KRK6oWAj/J+Gyjlt/0mbarj/KlO8tgKiJo9Tb4imHXtqGabZrEAzD0hIsGpxjBW6tc8UwN0CAmkBN/+RMUf44UNmJHJT8rTJ6LlcDAaTBYlxNj3CSG3TbJzI3Uh/Z/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284148; c=relaxed/simple;
	bh=UxQQsGISd0itPrfnqg8oErixDNkR5G6/4935k6HUGbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFxp9xb6JTX9MlW2nAvfY9AeeqyLj/LCYL70bfost395QIvS+fSFP5OnX1FXFg9U4xQLXkBxaZl16VH71KDxX1/i81kzpAzKzD8vWaVICNQ1lvncWQHT+LXunUa2akV/sqsr8yA8EE5EtZmu6HU04JSQBz9vptKfV2Ibf4jqGls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z63TMEtN; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z63TMEtN"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba1e9d3687so31672595ad.3
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 06:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779284147; cv=none;
        d=google.com; s=arc-20240605;
        b=imlI9RgmxaQSas91zmF0PZDCOjfNaK4t2xpfn+sUYRgBFjzTPrVbZUZ5wGTsB31gwV
         2ryAyF0G0+jWKA9S9oCoP2Lx9PfGE9w6a6JfZvw1+E04YYMYp2JEO0IY0HeDNkVb5g6k
         ap0yScqAAh+RmuX+bLV3rvJvTT1dgiyIR+GFL3CYWbUcb+AjC13nmqoAHgnvtYgeXoBX
         WmvUMOfAw7VEEVHbDLYQ3uPFsOfFI3eG/JWzTO63f5e1+PYixCoReOLqsaa3ekWG9Xux
         2sSqqgSIGWqF/IXzSF2vEBS+wfMb75DZ9u5REYe834VknwuX8kIOldeiUaXkPVNaRT9X
         EHAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bGo4mCH3hZwzWL8G+Nbk8g/EI9I4K9PRGUaDkvvpNWQ=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=Dyaa3TUFrau9dUCnrrfBfHHGbXaCkx9EiUvamW4VavxvbaSUd01NdrHrCln2+foG0r
         yaj6hEMzowOZqVYPee+7hOkBkhMhSaWbn5XxmeFPLxTHBrtJmfXMiw0w5Wy3WwFwBw5l
         sG2bHXhZXY5nimoDBBmaDPTlV77cHjgUEkbetnUzq1T/sGebDYWAt2wWcIGKDKc2iPO3
         2FXr6PboBb8rb94ctNv3AEljlulY42xL6c2s95ptxMa/fwFvmuetFzsA2PkZQKhhQel6
         fMiSl7yDfmWmfiz1gC8LWnLMBA++5OZ+t7swBbdSKJrHKaXNNlGBH5V6F84vPgdueitg
         IJ5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779284147; x=1779888947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGo4mCH3hZwzWL8G+Nbk8g/EI9I4K9PRGUaDkvvpNWQ=;
        b=Z63TMEtNxG5E55QJiOaIJpZZG9bN67RlHba3J7x787o+5YAhyc7NhmIEFI4Or6DLov
         qlLo2IJpL6E/IkWeyjUqaDHT6dqVDeUs0BOXcvSvYeUsinI/8EaFlNlPsssKLLiZEb+L
         eJ8mxZ3k/CSTdahbj7t8ww/RFqx0FfR7OBrakIzeaxyu5MR6HzxwyhbbSTj/79gQBmSc
         pHdzmw1WFo6hkeQgThoZhpV/Lht7NzlUqMFYT/YaXWEZ6iVaETlfQC+vKJ8QcTrKCkV9
         QecqBQhyRfSpRSyURcyhdKETWMKvY+GgLNkUEE2/nZVen3RUjYMEaTw/sjnPns14eI2a
         13Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779284147; x=1779888947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bGo4mCH3hZwzWL8G+Nbk8g/EI9I4K9PRGUaDkvvpNWQ=;
        b=WiFniMOd7pzAHhVgDoJrntqpxLQIKaMJMdIr4+sxuBf97sxKciHQbyjcBdzXdbm1zr
         NnCruHz8Ei7d+6B+DAZ941rfUIuGk/CCsGLSJjUg3y8wihy9N7MaGHR2pGSDeo6augXs
         Q6xAMZUCdnoXNYSj2NWyBSgDEWxxkUOq/cjsk/END04+Dw75EyVhGHZ1fbrrWUwm+CsK
         HTuAmXG6S3Xp+uXZYYhOEkfLcIq9ZjQRhOBikolbiHToZvdad6wYqNoKNAcAUFzNurAh
         jlGzqn+XuBXTFI4HMxY33ttNbOxrqA7fNsN9En6N2aPed46WMr3+1DGUfFatA3m9lSmo
         SVtw==
X-Gm-Message-State: AOJu0YyD7Xl/xi3+GlNp0EkBuDp9VGTY+Lb3WNNCOfgSZkyGnXnSHJjh
	OJtypXs4q+ijBMX4a3fIctpq96zRL4CbWv86bmlttyikXQNxo2MPPmXV0FdqnnFxGmEtZsTREpb
	OTIbEAGA6IR6h0N5z5AXN5hXArRoZ5UjvjA==
X-Gm-Gg: Acq92OG4dQo2GOUPsd5eSvHBvgnURul4464fTXIJd4gsKKu0GuumoGHk3zZSukV25l/
	754Ve8WHyyH4pAfSFvOmka0nLJTosaierBq9JwXRqy1SG6M1TsiHEzmK3wVZWFETK7ynBdisYz0
	BVGaSf+3UZOcaS15rfpfMu7jWkCaei0RRUiH9Pdne1CNHc022hYA+5tp/t2lgnSbUMAZKJUw3y+
	MB4ZSS/RHRZQzzBihn6zfN4BZXpmeNdWTtkCCE+wtr9V0Age6oOyZMcwhyKGv6aUxQuahZLUsYx
	Q8Ox54IkWVw0bu/5TA==
X-Received: by 2002:a17:902:e2d4:b0:2bc:8359:66f with SMTP id
 d9443c01a7336-2bd7e95321bmr182474005ad.35.1779284146897; Wed, 20 May 2026
 06:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520121051.20863-1-cgoettsche@seltendoof.de> <20260520121051.20863-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260520121051.20863-2-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 20 May 2026 09:35:36 -0400
X-Gm-Features: AVHnY4I1ILlKlDwn-IbINlbu11Wy4292FXRfVtv2pcjwVsEbpH6IoBO5GALvRfY
Message-ID: <CAEjxPJ7kiE_-X-KrHFOxDo=Qg6khJXu-4jme5qEEfs8z3PZbWQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libselinux: improve restorecon progress locking
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 8:13=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Use an atomic counter to avoid acquiring the synchronizing mutex for
> each file.  Only acquire when actually writing to stdout.
>
> Suggested-by: Copilot
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2: extract fc_count reset into separate commit
> ---
>  libselinux/src/selinux_restorecon.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 8b6eba0c..b4d58b05 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -40,8 +40,6 @@
>  #include "label_file.h"
>  #include "sha1.h"
>
> -#define STAR_COUNT 1024
> -
>  static struct selabel_handle *fc_sehandle =3D NULL;
>  static bool selabel_no_digest;
>  static char *rootpath =3D NULL;
> @@ -734,19 +732,23 @@ static int restorecon_sb(int fd, const char *pathna=
me, const struct stat *sb,
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

Do we actually need to take a mutex at all here?

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
> --
> 2.53.0
>
>
