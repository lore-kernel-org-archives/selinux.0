Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53B53D7D69
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228257; cv=pass; b=Iiug1PclYLjV4DzSb+m1CAaNR+JwVvzkIRtF8MlfY5Qxlt9zcaTA4VnmTtHiH8JVz/fMHSpFmCdFcWrHucuBUKx8HpbwrNgf7mlPIlQ/prBf4N2g7scNlmtGM5CQ/z68ZffD/9cenQMMTa5YhidZtvIZFh10Q4mzcY97qn0jN6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228257; c=relaxed/simple;
	bh=K4w9gwS0TKqkVWdC7RD5BYZt+DsFTcNM846sTSllPpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jAKfk7SCIf9JqXsNZSFPS9UoOIucbQ8YBuSIiwbB7kTKzmUnIDcclGzeFLr7NynUB0WX5Oq69GG3lfPI2WdmX/9LFEHTvHcBVkkrT83F1WIffSSizOFmw3drtK4SUnJDG8YMEURdINRexhg/CFmo4bcNQHbubvNB90L633d8dAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8jOI8eY; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8jOI8eY"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37d55e8d3e3so654783a91.0
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 08:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782228256; cv=none;
        d=google.com; s=arc-20260327;
        b=iO7DscWrfJnYaJH159Yohb3yl2ww+5TekoDvZlpCRCwdCHpyChHDoMBSKNxukP+BKV
         408WBVhanTdEuk5a1GFofXyiBjT+lrqNibMA8zMxBF6Y150VZkcr/dgBfvj+398t27JJ
         +0n1+Oqgd5VNwA2avMGGilSkFQZvOwzLbdYqi0kEOk3HtrKunvNWeb8L446dMJ0/klPN
         aBZeNSgVFhOaMo8KuZF2nYRpTN2ve6YOaVlTT+w06lvJPlDpHqggLuLjYmdnWHDIgabV
         ivZv26wYDvEGOBkgxQF9/C+nK1sy5ReZC++qJlqdHMj/QLi6WBVG5weojX5GTtODGu11
         Vdig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xgJW4BbE4ZtYFwcVsLdeyAFBDpT6r7V+QSstIDF14zY=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=ayri8U0IJ2RYw8RDUoSyR1BpeyS1ne+e4YpjtOSRhUsb5Rj2ivCM2uLRXncu32vTYm
         +7ejpxek02YK+wVuGxJVU7riQQWqf+Aq82yZ+TyvZ+6Iwm/IRcTHxKxQ6gfACzry99iA
         IJl5t3Upg4LvRIyaWPv4IReeaz9BSh4nVxjRX5IA556tUhu2DCZ2TYCnqYQ5Sm2RU2N/
         ZA3mKJmcrPy2hqJOtfjG4X92D8gg9VzsxGSbl1VAAFQIjpjb28wD+W9lN18pI3HVYVYq
         GubQOII2/GrSphmg/5aW4IHS+HBNvxZtfUEAbwWQ4bdN1dgIu+mHnyMM3+8RtSTJyyTk
         G2cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782228256; x=1782833056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgJW4BbE4ZtYFwcVsLdeyAFBDpT6r7V+QSstIDF14zY=;
        b=l8jOI8eYuFrKVg8EY0BkcvcGGf07eJda8Eg4WxxqNIurpvoyfWKVqI6rFykY5g97MK
         R9vRlcneddE9BUdL8gW9s3zWpj967JxfV+k89Or2aRai1h6rvXUyU22wOd5Xu/galmYF
         lG565YNzsu4JUTDrIW5IrMp4iDvnFhq2b66k11MvVh+d6nPeaWbJBxYfkMh0/a3XlP1e
         hjweHxGaJwX0MF2Vnl5+Z5dW8rPQCJToBGsh8A9122c9maokXFa6Eu5+ji52TxM3CFGj
         AL0Vcv0GYWnrWS+6hH+Q39DuykJgHcPWpRZypjec4JzQosuITHt8oUZTeNWJxnzkgobU
         8dhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782228256; x=1782833056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xgJW4BbE4ZtYFwcVsLdeyAFBDpT6r7V+QSstIDF14zY=;
        b=BfD+tEkFc9tB3ltB2qkbRWd01xipx+t8pzGkJwkcTMigZM+OlnZOOeSc/urW/5hV0L
         4FqEZqtpqPmLOfXk7dOpKvky2D9f+ge8slSnB4rJk8OGEDhWDlSBiDb+dzceI8OnTgPW
         s5GtUiWx+9IuWQOq1f75sdzqoEshNUFJNryRzVLXFaxJWcZrY3soPC7uZcl4j2/0FTpd
         4bWTn8UZ9BTk9tnybKjxwcxdm+SJKSlsHdU83zEa7Oxm04Sf4H7jzNYfC7W5ceJwy3aB
         FhsgHjOqGSb79JDj5/QKJuE+VDHIrWfJkGkPZMqNd8t03rca9koV6EcXcqqi+FQS1C7U
         cHiA==
X-Gm-Message-State: AOJu0YyAAq7VbXT3avmR0gGsMrxjLgkbdC27B1P0IYzxdjfYJZnHD3fm
	75SmMjZWX/GHZxh4hno3qvEsxkT2+cf2Hld9Gd6XSPMF6feUhZeeWovoETGMqNe2eiy0sU3m7ZR
	9EZiZPx67IAK2btSF72Z/ioAnkb30Q4XiYGGV
X-Gm-Gg: AfdE7cluW5HC3UUjN3xl/86VsCdRg0JlzmApJB/o6259arS7zJr1+Ze9Y2ykWoruUOo
	M/Vz3PkWZXrTOiLTOb0+8AgOHIE+OzJLjB9sDCE2CUbAkqsvlH1IoH/PAjQ5QskaYzopz1DkCQm
	xbX8bBMFDDylRgB5WkpB26VemfJv+EIQe+wVT9syWlz29sP7SKo4mjcNmbquaZ9hvkMQg2z7m0G
	dJrpH9YIBgaqT4ZqVSl4+Zy9qNrerf75tpSKWoY3wo/1jqOaYRaaqlA+q/wilEiRcI6r39nodvA
	qQ0jT7Q=
X-Received: by 2002:a17:90b:5743:b0:36d:b12b:f57d with SMTP id
 98e67ed59e1d1-37dcd701bbdmr3308922a91.12.1782228255812; Tue, 23 Jun 2026
 08:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623134215.98273-1-cgoettsche@seltendoof.de> <20260623134215.98273-15-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-15-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 11:24:03 -0400
X-Gm-Features: AVVi8CcFUcwQ0bnK-1relNFn2DzUOB328ms8BPvtjfldhKBUHhUWjoZPDthMyc4
Message-ID: <CAEjxPJ7ND905RnQymEo1+Js0GpGO3DxMymmVKcP=FtoTKnSvLw@mail.gmail.com>
Subject: Re: [PATCH 16/24] libselinux: simplify canonicalize_context() fallback
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:43=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Drop the original context directly via strdup() on the EINVAL fallback
> instead of copying it back into buf with strncpy(). This also fixes a
> non-EINVAL read() failure being reported as success with an empty
> context.
>
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/canonicalize_context.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/libselinux/src/canonicalize_context.c b/libselinux/src/canon=
icalize_context.c
> index d406f054..6e23c297 100644
> --- a/libselinux/src/canonicalize_context.c
> +++ b/libselinux/src/canonicalize_context.c
> @@ -44,13 +44,15 @@ int security_canonicalize_context_raw(const char *con=
, char **canoncon)
>
>         memset(buf, 0, size);
>         ret =3D read(fd, buf, size - 1);
> -       if (ret < 0 && errno =3D=3D EINVAL) {
> +       if (ret < 0) {
>                 /* Fall back to the original context for kernels
>                    that do not support the extended interface. */
> -               strncpy(buf, con, size);
> +               if (errno !=3D EINVAL)
> +                       goto out;
> +               *canoncon =3D strdup(con);
> +       } else {
> +               *canoncon =3D strdup(buf);
>         }
> -
> -       *canoncon =3D strdup(buf);
>         if (!(*canoncon)) {
>                 ret =3D -1;
>                 goto out;
> --
> 2.53.0
>
>
