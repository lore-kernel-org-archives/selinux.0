Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519DA269CE7
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229377; cv=pass; b=YZ8Izq0d1xo+VOf5hBsOlYmY5q5NvrekvRzNWsAIRCXiD8MhghtMfLZrOyE0dH3fF5zJpM2depZhy1GB91uMF+teIlQq1tYfhOqg5mOM0krhi8gr41jYjKYPrHfV+oPLxTlHSsfN9rJLs6zUVMFXyIuspZKfBxtqNFNXvVoHeeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229377; c=relaxed/simple;
	bh=yOjLxA1cUvAa/E6slV9XilxJnKl9Y1ADKEZl3hNjEQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jihe8FtiCZkEkwjekHu3U6wRSsY4TGgHnY8OyoI+4+HwC7xZE4es67/z2YQGefVZyRS2muS21NTT9zRaVYbiuisNdaFjkVoLw5Cd5t9q8DZLXjxi5dkAfS2nKQe9VQ1wpK8a1IyYJquBqm4ssOW6uNdWgCV5KbAvF33xiD7uZJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nM2zxIce; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nM2zxIce"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8894560c89so2075355a12.0
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782229375; cv=none;
        d=google.com; s=arc-20240605;
        b=k/OopuhfeHxEIsaoFwRULghUeJKUfWVuBtz5iSIQnH0arfDUVERO84QN5qhzn1A8Sr
         XPqMdzEEpJUn2bJUXSLRHUoavwPbGJWRTM3eyPIrC3GIZACsI0E+ppLmDfMpim6mS2rp
         che8iVTei07bvk2CjgNDPpNLOYjR4jPNOHiy95BQ+Wciuct5E2EXTH7eMMao+g0IfzYk
         2ZyrGbsedVw40W6NknVOiRw3WN49IaOR8ywvWSJEKVbZb570S5qIhbCIujauTTYjpmCm
         HVAKnP/rjMlMlL2UsjZ0/hCh1glKrYXBjRl+WdUoo1jraqwW3tNUSoFvygYeIa+ElT3L
         QduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jV0Nz5hhEPXiKtS3cSVPG5wpZnbXw9oJf5d0vxIdIbY=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=SZQZ/7UNkgfa719qHfDymGDLS0pcr/qp3tR8lmhU8m3uWiccL/BD0x2JdduCXKCY/A
         Nm1wRPnw4F8hVuQIpmjNQ8EU+odMlWqtrNJ3LBgcL75xeap0xCiqVyPPiM9VeDVjEyFf
         szXoEKCme4uZKaOHplznn0gjQU+pZZ07gBAp7VlOO3XYac4h2Hij1YS72axmLr/em8DM
         1oEeWc7Eczu4Q4VpukVMnTX2Y83uiIq9vO7poY/X8NBbU/vAqM/agl9BwemAzrDYcFz8
         va3bl+T2T1NmQBw5c5IyG6mvw/J1DV6GsDZ56wW0N0EX+wGQmX/QJ0lot9slRDHrG26B
         GUMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782229375; x=1782834175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jV0Nz5hhEPXiKtS3cSVPG5wpZnbXw9oJf5d0vxIdIbY=;
        b=nM2zxIceNhA+3x7VHPgWTK5Bl0sw3EPXIFYHUuOtUOf36C1omn1y1jn6Uil65+UN7H
         CGCeVsIAxXE5s294lYqlnYLS5Q+2xWqULiKACZEqRa6xgYSLanfPXZr3iOLHgwUrcyDJ
         //Vp1Ye08NBopU4VQOuOefUBvfpVn0HcWjNwf4BAtbn0deeBki9FVg2ncA1n1q+zQmWJ
         7/dhpb+MFxE4B04Bf4ocY26tVM5X9HJdI1WmE+FIIiCd6vyORMjr3bU2akNMhrtXU3k0
         yQrVoaPmNiyvZTGKnJ5xRiCzPZoAhgODbU08j5t3dtQV67LleuEpwrKG+whTufrbh+yp
         ej8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782229375; x=1782834175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jV0Nz5hhEPXiKtS3cSVPG5wpZnbXw9oJf5d0vxIdIbY=;
        b=jp6T8zWuqb0cywu19BkEOPBm/ru6cDMokPF+s3D3Vbo3JzBCX4iEaOr1rkT+CD1MA0
         7WkqQflk6VB5t4X1WWpTo/k6tdaAttgEce+CKPbrzak9zRgk7PgLhMpYcTe70NPlx6HO
         zQFEwBlr/ubtk8HgM7r02aC956LzUi1iU3nXLJ0f5LlprM2haNeZ7sKuEbrY+bd9P9RJ
         LlFCq531iPrFB4FR8xtD6Io5FsXz706ELXwu3rCAMVfZYKGQP6dfBCxepPu4AO5wp1U3
         dm327Brh9jWtqpAosiZ5l8poYgUfHB/AigQE6vov6RmItbem4GBsJSq9MT2RwnY+1YG+
         OmVg==
X-Gm-Message-State: AOJu0Yxv8rBkbTmA0gwWP/J8UNX/7HDoFC/rZoh80iuLkKxqGsPYR9HS
	8FLLgydpwOQPIjkGSicXtXw9pxGh3vuh+Ayj412ahyl78Io5ud5GGy0SwSWEZv01byhzRcfSPuf
	5Gvrx7sq1gpGfiGsJzeJeir7YtrP2Aro=
X-Gm-Gg: AfdE7clxIG936d+f79tt0fXGNrTwl3ykg4kUunvrpnlrvTm7CrLsl0dXwG6LrrNVn0n
	xA/LoTazl2AVc9PwvXiLq4o7KwRSQzTqBz3dPtQ3cftqtJ2R2xjI+lTpt8Y66epDwoMNDERzoLz
	wiDjaw+TrLwlWmuXW576/dhp9vcLwlqKAKw0RJB1SweZtckuPXNbxErHTqfbZcrcayWL+Ets91W
	bOcMk3PFZ6rjQtoG+jzqX6NQ+qNRKzh2NJiJRQXQwuAD8NSG3dj1Pr3SuXuXYdBLnTBI7Tv
X-Received: by 2002:a05:6a21:9e11:b0:3b4:71c1:ab29 with SMTP id
 adf61e73a8af0-3bb3221844emr23372664637.16.1782229375363; Tue, 23 Jun 2026
 08:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-19-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-19-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 11:42:44 -0400
X-Gm-Features: AVVi8Cf7spN22NLr9NDreGWk0LMV_oA_7pl3Ps59KhOftCvZre4FDsJcVtXUl0g
Message-ID: <CAEjxPJ5TU3zHiinrqQPwj0cddK+F7wx-nY12J4xtHDW5xYmdSg@mail.gmail.com>
Subject: Re: [PATCH 20/24] libselinux/audit2why: do not return a value with a
 pending exception
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:44=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> init() returned Py_BuildValue("i", result) even when __policy_init() had =
set an
> exception and returned non-zero; return NULL so the exception propagates.
> Likewise analyze() ignored an exception set by check_booleans() (e.g. a l=
ibsepol
> boolean query failure) and went on to build a result object; detect the p=
ending
> exception, free the partial boolean list, and return NULL.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

As with the previous one, needs the patch that defines free_bools() to
be moved before it.

> ---
>  libselinux/src/audit2why.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> index c6c4c223..cae13f19 100644
> --- a/libselinux/src/audit2why.c
> +++ b/libselinux/src/audit2why.c
> @@ -311,6 +311,9 @@ static PyObject *init(PyObject *self __attribute__((u=
nused)), PyObject *args)
>         if (!PyArg_ParseTuple(args, "|s:policy_init", &init_path))
>                 return NULL;
>         result =3D __policy_init(init_path);
> +       if (result)
> +               /* __policy_init() set a Python exception */
> +               return NULL;
>         return Py_BuildValue("i", result);
>  }
>
> @@ -335,6 +338,7 @@ static PyObject *analyze(PyObject *self __attribute__=
((unused)), PyObject *args)
>         sepol_access_vector_t perm, av;
>         struct sepol_av_decision avd;
>         int rc;
> +       int nbools;
>         int i =3D 0;
>
>         if (!PyArg_ParseTuple(args, "sssO!:audit2why", &scon, &tcon, &tcl=
assstr,
> @@ -401,7 +405,12 @@ static PyObject *analyze(PyObject *self __attribute_=
_((unused)), PyObject *args)
>                 avc->tsid =3D tsid;
>                 avc->tclass =3D tclass;
>                 avc->av =3D av;
> -               if (check_booleans(&bools) =3D=3D 0) {
> +               nbools =3D check_booleans(&bools);
> +               if (PyErr_Occurred()) {
> +                       free_bools(bools);
> +                       return NULL;
> +               }
> +               if (nbools =3D=3D 0) {
>                         if (av & ~avd.auditdeny) {
>                                 RETURN(DONTAUDIT)
>                         } else {
> --
> 2.53.0
>
>
