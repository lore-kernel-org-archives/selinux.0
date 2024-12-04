Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149823FB0E
	for <selinux@vger.kernel.org>; Wed,  4 Dec 2024 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350101; cv=none; b=RE2KkOpdmZLmZ3f0fuTkDhNIm013wH0kL7/Y/dpFiWhTI6ESDL36aXlgs70Ro65KRhvJDKZlHh8SAAsXCp1IX63a6Fi3FonkrMZV2CTsXZpzAUhhgrl+WCpwnda9DqEwEjY+MVGeIcwPpMnTaWdJnjLE+uxR0iyADbm7gKHInxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350101; c=relaxed/simple;
	bh=q5OhOzwVG+k/pOiLTI389gqSC97MS66v9zEBOF5UeMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGIuxNKo+Fxd5GdSAtKPYkkyICj7z32PFeuGXbEmIzS0bY0SQNqUdZgdCkOCihdVKPTJnKNLZpGEejbbv4LR+fyWA9K9LlhkitvqDCXNeJkKTyk3VoQEd7CC5x5nGtl89lKStCjzqcUlO/3pix49fsOtWtWxusAwt775+aaq6pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LWnw+FQf; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LWnw+FQf"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e3983426f80so380609276.1
        for <selinux@vger.kernel.org>; Wed, 04 Dec 2024 14:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733350099; x=1733954899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrwnGgCCWRQTdxJ9OT4Enu4LhAL/3xLqgw2hy87dtYc=;
        b=LWnw+FQfpWHpcO+EjOSRusQbv+QgZD/t6U3luZHTfQ5leJFP7CT4rAbBY7NnMd8CgA
         0ttbCkn5VzZ5vw1AhmihemJhZGxdZLgG2QtSMQWlNEbG+jjTkbZPvzcvZsqU6iL1wbPD
         AMyLCbXwONlR/8Dwtb93r0zNqdxurt7rjkb4ARTk5Xobt8kioITIMtYhRP9vqDFwZUQV
         Hm6Tba9M9Ri1soDZ9u57Sy2vOHEzrnI2zBz/NKQZ8bgRuB9ITims6UYF4pGTMQnPwfXb
         Smrc2y4egKsMZMzKWWBWZBChjNYXKNA1pIEnD0EyDmVMW2FP/XFHFvEzDzIldAJv8irp
         8U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733350099; x=1733954899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrwnGgCCWRQTdxJ9OT4Enu4LhAL/3xLqgw2hy87dtYc=;
        b=rPUVfLFMXHqshDwYtGr7ztUN4jQD6df950Iap1L8j7qqXxKrHwDfRyzeF7TBPy040T
         /1nCSRsWpas8QuIFroSqVTI7e6sPThrfHg1nUeRupIKV5gIvP0CEv2Bw/45ouzN97jP0
         mSI5YJWJkcw88z1q5123msUV3uxeAn+R2L7CvbNrb/1fgSL7SZqauS3pd/jpx5qM6Mmo
         4A0lgitc3vuVK2a8MYpmvqjVp07qKOSFhaRc48XqXA7rWPng0BXpScXsN2yAruPrTcb7
         pXLLgqR99Q9a7v4/Q2+zeSzbv2mFvWAb8GFXfzfgzsa8MCKNfjm5SQ1CNGZm5hvGTlq7
         Lwvw==
X-Forwarded-Encrypted: i=1; AJvYcCXfa4Ar3bS9PKTK7KDfZoNVX7KK1h8L2koD86vpTc6hkm9UPX88eBHv5iw24CJgyejKp0ZT1PHX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8/G0fs32M02NpZ2TQI0kVG2wN9hnd1dCw+T/6ELOJizCPBaAB
	Z/UngYKCNmLuvO/jKTrrbB+CEe2xI9q3u9qLAAYLsk6y5fOzzHyE8s87TxK5YIMJDzMheU23gOE
	WLkBMYxG08HwI0itYlLoWhe2s9mMlDfBDM+xv
X-Gm-Gg: ASbGncvvD0tNwjlVSqwGjm50MUE+WhlqRz9vex1rJYpZcVdsjYB6f/hmUtzS+P6/0rr
	Xb+zYU0ysO+Bb/z7lxaOYnNpwmfqwAw==
X-Google-Smtp-Source: AGHT+IG9J5dfJZtkdH4Xl4lwZXjltkdTFM/VIpSFWhQTq9Yxj5XvuqJj4SKWPdWcqJCxskqSjKkd2zQirO/VWFATcUE=
X-Received: by 2002:a05:6902:1a43:b0:e39:a15b:907d with SMTP id
 3f1490d57ef6-e39d4387f53mr7736105276.50.1733350098841; Wed, 04 Dec 2024
 14:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203222741.1739916-1-tweek@google.com>
In-Reply-To: <20241203222741.1739916-1-tweek@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 4 Dec 2024 17:08:08 -0500
Message-ID: <CAHC9VhQxcNtVLkORLFkd=a=_aEfYreRJt-xs3ZRdXwqd9sjBmg@mail.gmail.com>
Subject: Re: [PATCH] selinux: ignore unknown extended permissions
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Jeffrey Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 5:27=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@google=
.com> wrote:
>
> When evaluating extended permissions, ignore unknown permissions instead
> of calling BUG(). This commit ensures that future permissions can be
> added without interfering with older kernels.
>
> Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> ---
>  security/selinux/ss/services.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 971c45d576ba..2fa8aebcb2e5 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -979,7 +979,8 @@ void services_compute_xperms_decision(struct extended=
_perms_decision *xpermd,
>                         return;
>                 break;
>         default:
> -               BUG();
> +               // An unknown extended permission has been found. Ignore =
it.
> +               return;

There is also a BUG() call lower in the function when it generates the
extended data, do you want to update/remove that as well?

It also seems like we should have a pr_warn_once() or
pr_warn_ratelimited() message here to alert the admin of a mismatch
between the policy and the kernel.

>         }
>
>         if (node->key.specified =3D=3D AVTAB_XPERMS_ALLOWED) {
> --

--=20
paul-moore.com
