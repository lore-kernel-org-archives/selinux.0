Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E21654768
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291133; cv=pass; b=oKbJdGx1TRENINGFJqSen83AWqrIPNJhRESSrJZ4ikfUvjiH56Sqg6j8C5AFroh16YpmA2Q7KxlR6HFWynXWMMt1fNmEtPMneGC24W04vnez9QtGJlfMR2g6SN+1ZenTj6+rBdIqVPjmpb45NZBJoIp5tw7rbdhUy2yPEnw4caA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291133; c=relaxed/simple;
	bh=UPTiZCFmNyc1B6pXadLHj8A2Aun3RP5sYkJofPvX86I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtNjmOlYjY9rOx2uMPy4e4a6b83jLBXCkMeA8cLT9ljIchw/WIAZ6QaOALBr9aEwTUGk3jB7nSBzx1eWv+d/6HKhL8PQl2mjBiK7M+RHMIhMulmUSI4jMS6MZH0U3cqKmCDucb+feeKFKeYTC2+VCOiAYyf4Jtnc7zwi5nuqlM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jT8q1EY+; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jT8q1EY+"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b4650d5f5cso19858645ad.0
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 08:32:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779291131; cv=none;
        d=google.com; s=arc-20240605;
        b=Tm7yMz5GRhwfXzvRnzMAYNS6i73ASEHyisr+x4LWKUGopDh12ol1GVztek8CsHu6CG
         ldRJRq3d6KrNaq6RaY9v6fqvgCZkqRp2xb1aG1xaYAdSVwmhnz+yZOK5ECO1p71xqEYZ
         xMTPLEtzj/UcFC3pwSrMHs/M6pWq5kKEM39naYCd1GnNE5+tCdPNwc1LThmT37tE5rL0
         1ssJGoj88qcX8UIK9JJN2Ak1Y2+4VG26H85a3rvPjDZf9MSptYRA4JUvO8vDFABxLblI
         6BXTr0+bAtZg1lh2jjxJ3yJvvx+8fYoQq9An7E1oO+g0b2wGbQEQyMprdiw6epn5fKqF
         TRTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wDgQmpZJUsCyRK+Dyf8xEWgNiL8supU+AbvdpTAIXY8=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=lIh84bhG3+gMGgoULaK+FDqMIC22dk1F0jBRvsT6J1n3LUza8z2sc96CTACdNXexeW
         VZ775CelbbeBqQjv3/aoFtt+95cB3dFZKgYHOpFB0hbxAgWzqiBOKzLhFLqmy7jFwu5b
         TY9Uu2nWHq+4mAJRdMpll9XwWpcbcmzExcyEK2eqkpv5fTCBGY4/91lkQAAF0+UCarHc
         IIDYPpq2D72hRtJuRdqAXUo+YfGkX8Q3Zyh6YpLLRIvaKeBk/P1tMnvi7voaGpybuvmn
         A7Czmu1VGgC0lyhRoUf8XsAMnUQyqaF0eQrECSs9HBNN5o2rkxCqsKVZPtvi8CMNXdTc
         HIsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779291131; x=1779895931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDgQmpZJUsCyRK+Dyf8xEWgNiL8supU+AbvdpTAIXY8=;
        b=jT8q1EY+FaybW1e27z/DPv07ZUf9Cfj14kRWkpGATQznM0r4Gmzf7842K6aMKYfOtm
         Qn4HVNW+pA+z0aUgi7NYqkocl0J+ehqUFSbFedj3W0BYcqRoOKiOrPE/jog0pvgZZwrd
         6ASRhSOUOXJOBrR10vNgierLhLT1JK2y/b5tiWzdf/qNJRj3aCsbsPMeANDKBZzS9Ekj
         Iw5SBegQ6BZXT+lVpG0P+s5jG0m/sL0rU3pUeGGr8jFd/rHSTly6MPjSHLxqT+Sl8X9F
         esim4EeqXSxPFKSRz6zJfwsPphOH2ml/iHhJbP/sBvJg2rFui2NnZcS5NIy42yoWxjt5
         nIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779291131; x=1779895931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wDgQmpZJUsCyRK+Dyf8xEWgNiL8supU+AbvdpTAIXY8=;
        b=PoYH8h8ZS8lzkttaNOoVO+HndsxHxWWbwZUKO/OZtcC3v4WSB7DTAGldu/tmAPSnxz
         Ltd1pyuqRt2+DVHUfZjWYHOU9DHbe49m0MYjXri+6+jY4vKXF1ucU8SPBfHdTPI9jxMd
         zyKG7J0Y4+LhRHolJt8BfFZD6ouYq6ijxOSvpQ8M0PCl9uZRjAbZYHMNWnfk9wQKhs0Q
         459FICr+uV7lJLRQkLnQ9wLqtzWDrJkxNqKmg8NUh4uAmRzm+vRR4IDhR6Rxh3DuBado
         W2mD9M7SbmQZE/IzLa3LS/MiOddn/Oz1nJYFLpdptIEQ9Bx6Hy+S6TlESQ4zP0R4hPxf
         aWOQ==
X-Gm-Message-State: AOJu0YykMX3zqlV6KCCngXCUhFeQys7W9MuOqtJfbOv8nkOQi+XkjABM
	sRgioNTKvYUw8miHvJzOGZ424usAILRsF55yaQVW/Hh3Y57Hnygbz45XaJARhgl2NFTW9xqrjtD
	mpB6Ynzb4UwgDYJjptfN5e1gM/fc0id90pA==
X-Gm-Gg: Acq92OFg+H22WCrkVZC9Dof2cQtRPChQAtokfphB4fxwTzIFbcRPX3m2o6l09vbvODa
	zueeKEIikR9E5axiPuPUxLPoWOUqI4h5B32yZrZ3KNcIREDImOMUBhWxs9oYPdpZTfWbxfHN8l6
	VUSMnHk9rOM8ZM+aA+dNtbsEk+6BlS6hr+fuEdzYwg2+kpydy/tP3uBVW7Zv5JEK3ySkan+hm2E
	wz30UHnp2FnlnSoOC+hEo0Iac122Ri927N9yvGqSp1S6552RvrzSoKQOhrUz9c2x0ojn6SpoJpi
	ZPr+doctfYexXcY99w==
X-Received: by 2002:a17:903:41c4:b0:2be:3dbc:eee5 with SMTP id
 d9443c01a7336-2be3dbcef6dmr58653235ad.2.1779291131433; Wed, 20 May 2026
 08:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520121051.20863-1-cgoettsche@seltendoof.de> <20260520121051.20863-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260520121051.20863-2-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 20 May 2026 11:32:00 -0400
X-Gm-Features: AVHnY4K8TTRLG6MwRbRErukG0L-pyZJdNcCNuCQa9_aJF3IY7TIaOg4Q1Gf6zKY
Message-ID: <CAEjxPJ6E7k18phrgQGFmezYxp8sgY76ZRaXon3XsajPmw4_Bnw@mail.gmail.com>
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

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

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
