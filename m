Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7503E7152
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948280; cv=pass; b=uaYz5h0d5tZ5HBklZC3B8MC7HGFXExaiZfvTZJ6IAmgVUEG1OsH4lRmsQrJarzlXn5zNe5Dv/UtQGSm7YVzqG3b8Zh9k9vNEbm4hh3DSp0ov1L+wo+8vrnJrXlvPlOADHi3xt0h8yPJ7+Z1D5WDSeosKb6FCrdwCjvTHtCpz3EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948280; c=relaxed/simple;
	bh=k2qFt6qY2IXpoE1pYK8pQT2+aVBr1Tm3YDOAlnbGygE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBnCfH62r0ow1o3Ej1gx466Bx0dmb9kQaAP9uXG1b2jK1H1xt3l/kzeUniCNTP3bvCCu4KcntM1akyOPNSuRfxXnRrc3Q1wCkFIVnEqt6wl0VzK4PQ+BI6MyrPkGt1PL139IQ2i3tibcbCNoRP4lhi4eZW+pmUaufZuIpg1pFR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D62CzBts; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D62CzBts"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-396770cdcfdso49711051fa.0
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 12:51:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780948278; cv=none;
        d=google.com; s=arc-20240605;
        b=bwx0dUAG6oVii2NZj0ser7AQ2/QBb8p8ucBp0izQDWfuQKFExfM9qR7V96DEHj6WwY
         EpsUPIhCY3svZG8GJ6dqaICL0q7Bgy1cXzyKpFW8WilqzYLEKyctnf5f2mricJBW3HAb
         IfsBAq6YFXCjCJwlO15DG7xqBPabM2q6om60w6t7SvRFXSGjYL61n/hntkNqVphdSVIN
         lg6yjLHJKBKwKymHufRQgBnDY8s5ZhKWkB6G9sYDJFQkYz34bM0SClqOCv0vSqcVuyRn
         ff/ZOmItMRyCzmZc8I+WKjjv2u2p6oyjoH6fr2lLjSHSpZo+j+hYScjUEDrA8zyYvcvN
         l6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ym5dHbjla3/ye7E0GpuNQNQUQEJcvzJi7yUhQygxHJA=;
        fh=vavl48DikL+NIBRgeTDyB7iJmOd/sXAUthXzgkMi/qE=;
        b=AJbO4cO6f9QimfSPhpz+0Bqt8hzxQaSYVtDBWXV1Mph0n0gF/YzUOdrga6rk2BE7rt
         xptbsEDNxqwq/h++ex3hw9WwHgKSK4MOzWiDg+swyrGL+Lb2Rqqq5KZIiEnkVjQbfUTP
         QaWC170WYKb86wwEZ7XpeF3yUZ9RPCOdNH6gQDA8qP/BJejzEvG7uQpUSCI9RbTsMZnF
         6oxtf+9GNTbaFO0y67T1sF6sEl5AfeFVb0UsjSvcTzlBrbuUW81+r1RY/pVD7tTq1HZb
         G50VFI+bzszVLAbSH1BH9Wy52dTCxic99kp5zWvGOxuTOK96sutyMnBMDkqlRGcne9Pl
         6dKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780948277; x=1781553077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ym5dHbjla3/ye7E0GpuNQNQUQEJcvzJi7yUhQygxHJA=;
        b=D62CzBtsqQ5VAIi3f6Q1zoVtXG9c1FPIFyKFmqFZ2YQEH1s402NNw84I+CtOsnutwh
         Q2GRGo+V9wvqN/AtwMEJDIvmtpWdZruGhZ+VNJEsqoMb3jwHmtm+I1zUrAAdeM3Fhu3J
         goGWQPR0V67c6rUXwOjfy7RyHEZ22AUEHaqHH4NoJzXT0dlmXA3X1dgoR/kNNW+d52L6
         T5LKg5GHggz4qh31qDkUaQX2XNPTU8PfKmpk4NjBK5f0FSR7fQi+w49EJ93AZjOR2XWp
         PF4tZ5Uf9P2uj/OhTKC/u+s4vSrpuBHLW2cizqQl5ivBnqAQHeTNtUjlsck2vBUY5Skr
         QhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780948277; x=1781553077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ym5dHbjla3/ye7E0GpuNQNQUQEJcvzJi7yUhQygxHJA=;
        b=nfZyRu+VGtWRkieTDuNyMSpPzb32zdMj/6ojlVUvEF3YEBOlrdMI5CGN6WxaNTr5qq
         PNx/i7evisyqFQYqyWrRfHacD5f8oDJOAybgIpehSD+StzqxcL5P95QGYkOzR2pWIh47
         JC5PQ/PwSMa7phCJAXDpaUiUONic0Dp3FB5yG9FgcAzqI3uiI43Nvp1nx0pQ5N4r9FSd
         eHe61YH783aOPqEJl+q1qXrHpEyHgDfLP6EtexTtyjunhArLVoACpP5Jq5dnRYWqzVxX
         YGcFxvyEVZcdSkE51cqWxqhlX3fT9qLCZKK+itJVCr9hGkdFXsa2SPUSnZeexilaFPfB
         4/5Q==
X-Gm-Message-State: AOJu0YyMqFap0/R7s7FC4yDzL5UJUkDZt+aYWyhYhJCSpfDffLKuBWV6
	SkHNQ507lcQkNLvDumfBVcMNawi4Wr4uDrtIfOJ5S+RLEL/6hfvSx5X1pWRnJax6bERJjMo713J
	94oF8Rsad1xwVWIeJZUSEUGl+QerKjGc=
X-Gm-Gg: Acq92OHzGpTwVIuNyIbOxfmv8LReIw+tCPJPjbeT7TirPzwvVgDNEiQ7uZHrJr30R3/
	S//Z34UwpVnnh4VGWQ+XagQLvo/+SbHaQ1UyK8mtM80nB34+lJBghBAdxh9x/iMp07x5wa65p3P
	xvCgdgXCgQFE88BuPBeCvFxT9Q2/ES4JCXs5/CgUK6lKLh1vM/iL6uJ0CaaDqFfW9EZNJ/7QsxS
	juSl0gG+mIxePfT3cE+o3EjZ5pfEnLin+RBnwVF7m703z83YKF6dFy0wSAdSfD46h+5bR7vs5jJ
	6J3+rbD1BwlkP1z9H8i61q6sLg==
X-Received: by 2002:a05:6512:10c5:b0:5a8:fbe0:bc6d with SMTP id
 2adb3069b0e04-5aa87b514c1mr5278270e87.14.1780948277443; Mon, 08 Jun 2026
 12:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608164444.313701-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260608164444.313701-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 8 Jun 2026 15:51:06 -0400
X-Gm-Features: AVVi8Ce20R8kUXrlE5MOJ8GJQl6lFkUjW3DFcMQwRby7MNOm-b2QHFTsiEEnygg
Message-ID: <CAP+JOzTzD0z_PacC81nh2sDpHLWY7WJ261gjzrXDraWcuF4cAA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: label_backends_android: fix
 non-anti-symmetric cmp function
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 12:45=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> qsort(3) requires its comparison function to be anti-symmetric.  The
> current cmp() function used by the Android label backends is not
> anti-symmetric in the case of a key starting with "*".  Fix it.
>
> Arguably we should be checking for an exact match for "*" both in
> cmp() and in property_lookup() but this might break compatibility.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/label_backends_android.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/lab=
el_backends_android.c
> index 4f12d0d7..f1a3050a 100644
> --- a/libselinux/src/label_backends_android.c
> +++ b/libselinux/src/label_backends_android.c
> @@ -4,6 +4,7 @@
>   */
>
>  #include <stdarg.h>
> +#include <stdbool.h>
>  #include <string.h>
>  #include <ctype.h>
>  #include <errno.h>
> @@ -32,11 +33,11 @@ struct saved_data {
>  static int cmp(const void *A, const void *B)
>  {
>         const struct spec *sp1 =3D A, *sp2 =3D B;
> +       bool wild1 =3D (sp1->property_key[0] =3D=3D '*');
> +       bool wild2 =3D (sp2->property_key[0] =3D=3D '*');
>
> -       if (strncmp(sp1->property_key, "*", 1) =3D=3D 0)
> -               return 1;
> -       if (strncmp(sp2->property_key, "*", 1) =3D=3D 0)
> -               return -1;
> +       if (wild1 !=3D wild2)
> +               return wild1 - wild2;
>
>         size_t L1 =3D strlen(sp1->property_key);
>         size_t L2 =3D strlen(sp2->property_key);
> --
> 2.54.0
>
