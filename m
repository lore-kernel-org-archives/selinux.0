Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5443C2367A7
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377741; cv=none; b=i1cDNX6Rfr2uCwnaDziRo0baBbPx/JSIDeAUULRRd6co3Y958kSyN+S2wOBodylFctPlOCIhErdnO01Ip90PhN6V9VRfXx8TC81FXjdYYgSph7h+CmxyU/4DgGVtOLAdIg8tzbVASWPDNTNYYu2bW8SJ8g205igJjtBhfAxHFjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377741; c=relaxed/simple;
	bh=S57NWAWD6jEEZByXV/oBbuCAZdaxRdZbuD7tFPL23fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5vn1PuT2Jp3CnTIAhKgdztnnIE1M80JIgUfbyRio6h41e6XWAl9NFzoF3fwUoDOR2JjNgikZfXv9n7AgH/dgzEmlkDqc8XT7W1WZjOfMCi11uKYR7xMLOukdRtY6Nt9nRJ3/ly695ciKUqtVdBZT6lYrHR4eFjOAmCLYWvy0D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E573frTk; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E573frTk"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3054ef26da3so1604813a91.3
        for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 06:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744377739; x=1744982539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S57NWAWD6jEEZByXV/oBbuCAZdaxRdZbuD7tFPL23fA=;
        b=E573frTkuIm7VUusbi/fzolnvg0foP6xJFI+GtMoy4oGDwzxe+Sd9uBpS7BbSUoH17
         2jOCnSNearIvKJUx0Ru9Z2X564do46QQAL98yfHnV4M9v2LyIXDXw5y4pfWDoEgOM9Dh
         9ZZ4h3MZI+mY6NxreQlMLUjLTKLQoF3lZv08MkRu+YhXqq+s/e+dzXKpcXWsHpWjJ8RM
         2FYXP8/xyyFh+0Q6u+wiQROW1RNgtQbQfg47V0pZHIdP3BZZZxFlNNJ7d579iF8jzrwe
         KTblYy2uKlB/Z1HGlZEF/Xa9+P8aReA4PYUK/asMap61+ZUCtTBpP5lkWqt7ySuaszMU
         eLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744377739; x=1744982539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S57NWAWD6jEEZByXV/oBbuCAZdaxRdZbuD7tFPL23fA=;
        b=mtcfp9clZC4lU2sGj4G0EzJXJWGuPZkcZbWNewn0Jzq/3Kqi7X0JtFB9MoD5hf3bEc
         F33Zy/nMRS7Exwc7zg3ctQFb9klNlKCvQjnaJjkBA/evIW0CBiYKC/3MPI04CKY5TVey
         vk7CR0V6DJHOgeh5Geb2RiQ3OMAZZLcy0a1WSgRa78TFNEzwmLrD+PMVGMZ6o1TBu7Qg
         JwdLOlE8BNaU0sNsHaqYC0m2NA5vBMC9kK8itE5HLIhO+O5tECQvoWVoq3MYLFqOEfNo
         Qv0F6wEekdeB+ZdmlZg4zhzw8PYXdSB9/nXQ6rNK2vm5zmKUuJf/LxKUAR1J8Joi27Vg
         GY3Q==
X-Gm-Message-State: AOJu0Ywi62CR7vLmgEzdD9FeNJIe70wE0ZeXnrFlahyNdNBufEMl1jE+
	ml8+G6XrI4tYMsym9mkD/IzwXp1XcFguS3NjNYqJzbk+JY1417tsnu8SQorHhNWQvQ5eVWr+7aW
	IzTATAK9vyednv9OE45qyj7f8SnE=
X-Gm-Gg: ASbGncsk6b7muN40qXw9yBfN3pgS9/9NMVmC3FM2vIPtz4OiwFS8oK06XMxVKK/+3D1
	6TGhY+qbfQTzX6vIlMd91qV8eIHWMrm4KT4kczIg1UBwyvtOPkiq8g7s1n1SqoK+nzFrG+oEauF
	QA726vYlVxuzTHVw8+jGEVNw==
X-Google-Smtp-Source: AGHT+IFCaSXtreCZnJ0Jz+EjTJ57KYjE65XssfbPdf2ZXACoLs9YnPzl8KPpOOBbJ/8DZiG2uf7kX0lLAjosiySDpNI=
X-Received: by 2002:a17:90b:524f:b0:305:5f32:d9f0 with SMTP id
 98e67ed59e1d1-3082367e7b4mr4254331a91.19.1744377739458; Fri, 11 Apr 2025
 06:22:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGraAqv-rRTqtosNDu_T+eZ-YDVB_V3FR=t63S9BzfRU2OHmSg@mail.gmail.com>
In-Reply-To: <CAGraAqv-rRTqtosNDu_T+eZ-YDVB_V3FR=t63S9BzfRU2OHmSg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 11 Apr 2025 09:22:07 -0400
X-Gm-Features: ATxdqUGvu-Ndph_a9zvjizNeV9W2fB4amkU1z5QcLTU8LbtRU7ke4YAnKKEPQKo
Message-ID: <CAEjxPJ4u6MRZq-3BKbWeGBBjHVom-p_XwvwPpXMu=m5AbsJ8Ag@mail.gmail.com>
Subject: Re: context label has been changed problem
To: geng sun <sun.gengeration.sun@gmail.com>
Cc: selinux@vger.kernel.org, Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 9:01=E2=80=AFAM geng sun <sun.gengeration.sun@gmail.=
com> wrote:
>
> Dear SELinux developers,
>
> There is a problem in Android. When the system boots into the kernel,
> the symlink file device_info was initially labeled as:
> "u:object_r:sysfs_deviceinfo:s0 0 1970-04-09 06:12 device_info ->
> ../../devices/virtual/deviceinfo/device_info"
>
> by the following rule:
> /sys/class/deviceinfo(/*)? u:object_r:sysfs_deviceinfo:s0
>
> However, after 10=E2=80=9320 minutes, we observed that the SELinux contex=
t changed to:
> "u:object_r:sysfs:s0 0 1970-01-17 09:43 device_info ->
> ../../devices/virtual/deviceinfo/device_info"
>
> Additionally, the parent directory was not changed:
> "u:object_r:sysfs_deviceinfo:s0 0 2025-03-24 08:26 /sys/class/deviceinfo"
> The GKI kernel tag we are using is android14-6.1-2024-12_r1.
> Do you have any ideas about this problem?
>
> Thanks.

Do you have a genfscon rule in the policy for this file?
