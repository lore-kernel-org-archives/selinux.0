Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC5D47884C
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628679; cv=pass; b=d6k8o/wPebwbf/n8ml8tRNGlkUjii5nQpqiijntSIz3QSU/6U54pE7GcKTpnABAi5OWZoeZJUBc2sFWylfA3UaGN14gjUDY6GS2ss+JYcStRtsq7wGP9cKctJVP+NMzZPFREe/k46klQTq7YtxYuP2XYySRrzY0ENM/USd8pfqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628679; c=relaxed/simple;
	bh=oStm0PntjVX16WQw+X/FbQ//b5ZbZTZ3GnePZwlzPMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBBYeHEx4vcrVC0x7IS+VGxJpW4l7+X6gZNxj63FbmgybV3O2fI/kiXKu71Z3ldUU+DohKEBWiN+cSWvdreRakKen9y6T4BsAywHmKiqyHvFqi2AuHae59yYwStF6P6s8Il/y7Ar61Hg9gpfOIzyyRBdCa7e0fziSFBoYNNWbgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejkF5egq; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejkF5egq"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8422a92b6d6so38019b3a.1
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 09:51:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781628677; cv=none;
        d=google.com; s=arc-20240605;
        b=lAnYLx0DiNOhtiM+wFkjbnu818po5SQXcibGD/tsTJ4JW8ov1HEEKJcSIKwpuC1vz5
         IwwIJ4/kCAhfGNDTdi+pvPdVq4vcN/1ESh7FJIGovKJd7X/yVDsqmfD6WmEuL8v4kaU5
         zAzs+8J/Yjv9IsX2evMSunVpSIFpXSx+Jgbhq3xtT3w0aFFxsfSRHtTQAGB8Qq5MTawO
         rC+ma/uc17JTdm74V4WguqalIJ7yxE/Blm4IMXoaBLidMZ00XwLaMVDyi86gqbTrYTE5
         M3CGLzG3JMyMzjMilZc1VeM2ueryR0WQdgNdvumXq9pIvZwg4I0Vpye/PUYUM3MOP8XR
         ej4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pQ0IYI2/LkgoceBIsgqCejWDWUKTpMxR4PRuzmZhqsQ=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=Zr54m4LIko9EocS+hIsAGh8zeHxdifCEJTw/euhF3ZGMY07VEpKiF2lAhYT24BFZ2s
         zYOOBLERKlXqWZqiJSuGkyhh4MXsPoslJU1VrxZKh5x+gj4QVI0DY0EDy6iGHNJ3F4nz
         JiwPQRERRX0oKyj4BSJ57os+MzSsoa0dhd6goh29wb/343uYCVVBRaj8d5e2jF62j80S
         NoppDAWiu4AD1FkahrH9f75ha4rwhDp0d7BN+MNpJs79kbTVPDrHjTX7YgLwy8zuLJWr
         q5s6N2wpzDBd/elfL4sK44WJjDYimjn5oGC7+G8HCQPYedxvbPtfKRxCR6RvpXQk68Tn
         3mJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781628677; x=1782233477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQ0IYI2/LkgoceBIsgqCejWDWUKTpMxR4PRuzmZhqsQ=;
        b=ejkF5egqqHXfCylXnqvVdgkZHmxEOFagxovSKQ+pgV/1NHwqpsBqra/3k/qGB58zJ4
         ztNd3wCB9zEmPaBI+CAtLRBzwhkTAQZfbKaZn1huqzWvsFQaBYUinnL15scOH9qdy04R
         U30QRV+ybyGs4TwLTWRYCyCMvqUJ6VeyQy55RD28MAr0ZnuZ7HCVihTqml/IEDTi2F0X
         SPvd8SP1fisSxH2jcPUaVdJHZALRazcuUWy1Xu0gbp8cpHak0T7QmxC2ldwLSrV3ouxq
         spmiB4DObZHMHsxDuqlqRsh1TAwHdSi9d+BONoBw9gq+GR/tA+Lh8qIFAWmjreCYUgsl
         Omog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628677; x=1782233477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pQ0IYI2/LkgoceBIsgqCejWDWUKTpMxR4PRuzmZhqsQ=;
        b=BL00D9T+d9PR8Vqyd3XSAZHxclj1w1SCO7a6d1OcSOCgA4jyG8eu0zu2+13Gw/1Ngj
         GhKacSLFHETQPJtqK6KCikKuRo3Jol0FBjN8AckdszgcIDBI836EVG70XhQiBESfpAFE
         W0gW9u0zB+/VUkGTodnT6w2Gn3Qhk3NHAU6CHOlhIvOKAX14amrKN2JmL+HJtaKMNzzX
         nS36s8XD+oA6iFo4AhqIsYXBHhms/1qpK6PFLyUXqugSaM0qf7ff8sQ9OdvMlo8C/4l1
         X5J9bgAaQrq5xFQuaJqSLkTDqQDdgs7dR/WvzHzMey0G4gWks8OrElvLrh9TG7MU/cff
         hbtA==
X-Gm-Message-State: AOJu0Yz152Zjzfb2j08biz3lLkVjjlDlWm/rGI4JG+yBOE2seEv5s1Se
	hfLdgVq31ccfxB7o6MTOxKL6luF3zoJDJFwgLGUDor74o2u9WLKOy3CmX4rcOQfI3i/RuclFciS
	fY+FPxni26EXrFiQ2K4gocTG7EQZyMnA=
X-Gm-Gg: Acq92OGFDj+dYVTtAM8XxhU+yHw4IzzhkB9TDdgxq/Yi8QHVjijJan7iciCryHJGuIP
	PDsPIbsbJ5H5DNz0FEaaqAQVvYN4Swwgv1SDmfdcmNM6Rlf82Qt4X/xAKSLqoPeYNiORwkgfIUw
	qrwOkcZ6ep8r/rSmk7wuR3s2QVZPqc8WOCnN/y21NWO9ECPzTlsgOk/fBFYXw1gcSXvMF/TeRCH
	I8qKQJ44xSuAK0vP0lG07tluZYPpMZOrv6ICuX0csMoMNcwO9LaITLVuoRz/9UN1sgAJkNz2+R5
	NPtNYR0=
X-Received: by 2002:a05:6a00:92a2:b0:842:446a:4cb5 with SMTP id
 d2e1a72fcca58-84513cb66c5mr3685129b3a.0.1781628677501; Tue, 16 Jun 2026
 09:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616164148.50283-1-jwcart2@gmail.com>
In-Reply-To: <20260616164148.50283-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 16 Jun 2026 12:51:04 -0400
X-Gm-Features: AVVi8Cf43vn8RiPSx6iHZcNkn2L_C3rRWtRRbL3lyW41QwD1igVqYgjdjKJ74Ms
Message-ID: <CAEjxPJ5M+W3BSimSLJ6rAHuj2Pytis5fuGJuryg+NO_7wwgbeg@mail.gmail.com>
Subject: Re: [PATCH] secilc: Use fstat instead of stat to avoid TOCTOU issues
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 12:42=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
>
> For secilc, secilcheck, secil2tree, and secil2conf use fstat instead
> of stat to avoid TOCTOU issues.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  secilc/secil2conf.c | 2 +-
>  secilc/secil2tree.c | 2 +-
>  secilc/secilc.c     | 2 +-
>  secilc/secilcheck.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/secilc/secil2conf.c b/secilc/secil2conf.c
> index 4046e603..9c028656 100644
> --- a/secilc/secil2conf.c
> +++ b/secilc/secil2conf.c
> @@ -147,7 +147,7 @@ int main(int argc, char *argv[])
>                         rc =3D SEPOL_ERR;
>                         goto exit;
>                 }
> -               rc =3D stat(argv[i], &filedata);
> +               rc =3D fstat(fileno(file), &filedata);
>                 if (rc =3D=3D -1) {
>                         fprintf(stderr, "Could not stat file: %s\n", argv=
[i]);
>                         goto exit;
> diff --git a/secilc/secil2tree.c b/secilc/secil2tree.c
> index f0f02eb3..039d1524 100644
> --- a/secilc/secil2tree.c
> +++ b/secilc/secil2tree.c
> @@ -155,7 +155,7 @@ int main(int argc, char *argv[])
>                         rc =3D SEPOL_ERR;
>                         goto exit;
>                 }
> -               rc =3D stat(argv[i], &filedata);
> +               rc =3D fstat(fileno(file), &filedata);
>                 if (rc =3D=3D -1) {
>                         fprintf(stderr, "Could not stat file: %s\n", argv=
[i]);
>                         goto exit;
> diff --git a/secilc/secilc.c b/secilc/secilc.c
> index 70359b75..016ffef3 100644
> --- a/secilc/secilc.c
> +++ b/secilc/secilc.c
> @@ -282,7 +282,7 @@ int main(int argc, char *argv[])
>                         rc =3D SEPOL_ERR;
>                         goto exit;
>                 }
> -               rc =3D stat(argv[i], &filedata);
> +               rc =3D fstat(fileno(file), &filedata);
>                 if (rc =3D=3D -1) {
>                         fprintf(stderr, "Could not stat file: %s\n", argv=
[i]);
>                         rc =3D SEPOL_ERR;
> diff --git a/secilc/secilcheck.c b/secilc/secilcheck.c
> index 45176df4..ee141bc0 100644
> --- a/secilc/secilcheck.c
> +++ b/secilc/secilcheck.c
> @@ -148,7 +148,7 @@ static int add_cil_file(const char *filename, struct =
cil_db *cdb)
>                 fprintf(stderr, "Could not open file: %s\n", filename);
>                 goto exit;
>         }
> -       if (stat(filename, &filedata) < 0) {
> +       if (fstat(fileno(file), &filedata) < 0) {
>                 fprintf(stderr, "Could not stat file: %s\n", filename);
>                 goto exit;
>         }
> --
> 2.54.0
>
