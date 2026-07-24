Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1C3439012
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903053; cv=pass; b=JpmoNftL5NdLe0OWGkufBMPVGqC5www0Ueu6RGi4oTgERcsRMXbmNTOgHegxJrB0Bg+vBcJGGjV8QYIXpRok16jpmC3aEBbTOtewUSBs6/jTSvnMFjdIxkMkjDrodK1dovG9B13WaFhYUJpABI5/xfwJP6HVsweAOx4d3ZA6+AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903053; c=relaxed/simple;
	bh=T6g12TOvgZqgjGgZSs/8Y4B6o1DVf8aRD3qQmTzgTEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8JKFsqmBtg5nGNRiHZN2Slreig4tiCkGuEsB8XRChMNwYQHQ8d9WloPyHb/xX1GCtEgGWwF0Jrvs5da/bf2Wal6tF0b1IiuwqBEfs5CwHYrCR2Byp+ZUoYujXGgNuDu+ImoXxOjR7e0ezMUQrLDIultnPBS/wKyAAP5qIirMS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBe3wLhB; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBe3wLhB"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-448b89f700fso361937fac.2
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 07:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784903050; cv=none;
        d=google.com; s=arc-20260327;
        b=ETsGTCqipYDH68IC8pND8iPhId99wnHrQ+cBsaazN32F7IkNwlOr7twkKFYXIDTFqD
         vckai7QOl8t/WpOXDZthc9JrdkX/mImykYmla2OUQFt25SuJKrb/PWUQ9+WTaCbV84r0
         OrAsDub6YBHg9ib3rkdBwdha5jn8v+KU0aEfpcklhdF7g/Mt5KEtejDV3hgLocZNBdM6
         31LUclAvp1iS8eRx6prl2E/aWI0zso793dMXqflOcTim6IjrDMkCXYDP6tWUOnABCimT
         Ac+pta+J8h+I6OagKfSU4n6MOlaEcwII3y0kaSYYq4U+RYOv66LHUFI8GUiB+DylXq6B
         cBLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xbkEQ5sbT2uAmhu01ZtZIpjXjclMLydN1ac6fAS15Ho=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=KwL9PLncbVBF7MfVv8ptWsjmegMdP1VzTEz6gdAG3xB9JocX+uh3u7SSFNYmZyo0bv
         zFnTA1GOnxlhV+bms5VmB44FO4DBWlfFjHxNyPrCmTnOV+F8RkKOUzkN0T1AAPxHZ597
         LbiAPX1INTfpdUJeTbydNxggs/cLOB58P7uWDJ/1jL7HnXFFLQsF+XKsN4ojo4A47E11
         j9QzdnPzUKGXlDViEJkkZMY43xn2vCMoGVqQ/hZkwq7tjYbo70cOAH3NMr1YFrP4opHs
         TzO7Ql4CSv7U4za5FDb79jQ7GJLpYLcPyjCpJt+3CD8BlDEuEHuXtJCEALDX4X+PvdrU
         cl9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784903050; x=1785507850; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xbkEQ5sbT2uAmhu01ZtZIpjXjclMLydN1ac6fAS15Ho=;
        b=bBe3wLhBuVAfDKG0a9oj+k1z33Aiu6Eg9x3p9g6XLK1iRpRf9pL3Ts1r+UTO3ZZfUA
         2IHD8Cvlx9PYPQISEuLuCZqw8dNHt/7YyZ0I7UqieyjrqUxZn+U29Nswv9ARLMNYSL3D
         WOUuqynquNprv9RffWr6Tk39d3lASiDpEC74I8BZicgSZNM1pavG/N0+NDU+fuOBCcav
         Yw2FJ1/RYIfDptC1aiO1//Q2I+PObYZDNOdZeKwBYw2calaiwfC6B81kKxgKw7+NvP65
         327n/kfuGhoF3lBN77G7T1GQboICf5QVhbDJYB7d8Lw3qaViT0P50+ZLT8vDEHavks7L
         SDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784903050; x=1785507850;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xbkEQ5sbT2uAmhu01ZtZIpjXjclMLydN1ac6fAS15Ho=;
        b=HK/JLZ+gpnDikxF8LU7AIIFi9SK5CBT3YAV73G19E6XDixjtdksNeK/AAPpAQYPdvq
         b2+B0DUSeWbBcYuqZvHZ5puY6zLrPyOuycKgU0XqnYdCM66u0tRyWz8YnUJQAh1tQGnP
         sZ7+ncDANXU7/9v+1Ob06+SGJEIC2bM7hl2dNl0bvOdP5ACCx/uI0mrQXhWpu2lsohNr
         bAYvrc20bJ0fKuCy4umiS7mhSt+sZyxfL3v1YdL2h3GEgI5Bp3ryXkXWTuKAE+9UsDzZ
         Nhimm4yXrgOPw5FdxCqXFH5jUWIEMC0RDUieX5ymHnZ9tgZM93nUCKt1q0LwAjoqQdxz
         9JvQ==
X-Gm-Message-State: AOJu0Yy5OMJUcZgLcSIYzw3LGNhCOkByfY4PDn4E7U5YM0qqIeGsI3mc
	PjaSOb1fR8W9SjIrtyFRfhbrUe+SaicVuQavqfy9GyJTk2QlVPp+64NNKbZIUoSkcNDzW4c1ICk
	PzmPAG8LWnxpKVYpoUUHzJoiJ+Mu8QwN0vQ==
X-Gm-Gg: AR+sD12LLXYrbdtES7KjMrB7ETNTcB+6Sqgs+WTaYAhE3h5ZBpaUrJUhqPKY9rA4QPY
	ueq/bhbHtCX+bVfdVElcuzztoLI3wm0++NuzQnbjC5kHc3YZ1Ztz57QWUuDsO2SyRdKSwj4dizw
	009EyNEN94ai+pyuhk7ACsQ2q7lfBm8ZvEKew+eA7BimI35o5oKZw7XBiv1ZOng5UYRZan34NTs
	aqWL8kyZULjhEfrApvz4xd7CTFz6/RAlYYNe3BdvDxWLo6VAOA2pqsDeIx4Ow==
X-Received: by 2002:a05:6870:3042:b0:448:bcc3:9190 with SMTP id
 586e51a60fabf-457a0d103a3mr4842444fac.14.1784903049758; Fri, 24 Jul 2026
 07:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721175303.61692-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260721175303.61692-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 10:23:57 -0400
X-Gm-Features: AUfX_mxuqEEjhUNd0HNU7z_ZYlv0JhM4urXolky27RA4sIkJ-dBrK4VtzbmYsZQ
Message-ID: <CAEjxPJ59FCf11jBW9ycDvO9RbH0FH+FuT+_GJMO9yhqCaqqY1w@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: increase context length limit in secolor.conf
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 1:53=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The 255 character limit on context strings in secolor.conf causes
> mcstrans color translations to fail for legitimate contexts.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/333
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged, maybe switch to %ms in the future.

> ---
>  mcstrans/src/mcscolor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mcstrans/src/mcscolor.c b/mcstrans/src/mcscolor.c
> index fd8a248b..e4a0db74 100644
> --- a/mcstrans/src/mcscolor.c
> +++ b/mcstrans/src/mcscolor.c
> @@ -225,7 +225,7 @@ static int add_mnemonic(const char *name, uint32_t co=
lor)
>     May modify the data pointed to by the buffer parameter */
>  static int process_color(char *buffer, int line)
>  {
> -       char rule[10], pat[256], f[256], b[256];
> +       char rule[10], pat[4096], f[256], b[256];
>         uint32_t i, fg, bg;
>         int ret;
>
> @@ -234,7 +234,7 @@ static int process_color(char *buffer, int line)
>         if (buffer[0] =3D=3D '#' || buffer[0] =3D=3D '\0')
>                 return 0;
>
> -       ret =3D sscanf(buffer, "%8s %255s =3D %255s %255s", rule, pat, f,=
 b);
> +       ret =3D sscanf(buffer, "%8s %4095s =3D %255s %255s", rule, pat, f=
, b);
>         if (ret =3D=3D 4) {
>                 if (find_mnemonic(f, &fg) =3D=3D 0 && find_mnemonic(b, &b=
g) =3D=3D 0)
>                         for (i =3D 0; i < N_COLOR; i++)
> --
> 2.55.0
>
