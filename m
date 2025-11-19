Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BF036A030
	for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567437; cv=none; b=sXYIecMpmbjVpe4hDPulDOhYbZ1W25S4M9I3x9cRFLcqa/nKv8Rb0mRMXb2fC1BQsDV1fe6Ambe+9FdwfQg2FhG+d0mEyiuZmmIHhFPhLwKnn8ht1RhQwubrjeoFIILBzZaEsljvxyb3WAT92qPd37OB67nt9KXCOuBNwWyxhnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567437; c=relaxed/simple;
	bh=itg/LUFamhZogxZaQBHXz/8KMjeqy4/lfwoOi1+uYG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXczuZS6NaK6mujGhFtm6xHKfDHNsfYIM1w3Z4l9HXTMcLW2wq3bKTEc5k5xYJFOIsujh8si0P4dtZRgTrqAUzTAqQxo1YsseY77eKJYhmNhyn2i6xmCsl2jpzmJfM5XpKo6Z55nuxRVnjgyI3EaMiy9iavaKLg8Pi/ihfFfmP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HLMUvGdK; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HLMUvGdK"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3418ac74bffso4960809a91.1
        for <selinux@vger.kernel.org>; Wed, 19 Nov 2025 07:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763567434; x=1764172234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0tKbMWJYExbbwiUVlMAFoF70l3EP9xpBcRy9Kvv8TU=;
        b=HLMUvGdKK0gYOU4hVufSMG6DPjn8v/XIigiriZ8I0SR56hx7jIhjwYmRYqYpaTEUmp
         X32jcMCIdBLdtnjOBcOLqAKIAwl9/qdlK8swMaNKWhYC58XdFOfM74n7HIb8LsVaxqXw
         j0lLEIm+CPCVeVAHZ/X+esrNmxQFd7IkBGuWBqLpJ/N0IyWB9qtghkem3lKQPOlQ50cs
         DX/AwKUlfE7DHWyJwi06ORDCNW+ygJkQv1AYLOGQ5/h9XSdgqBwbG91wtuS7/vzn0QqG
         tNAadzPRyKOZHfQuEjQZTfM7V4IDvl90xgBIYLkPdBuOkvh1URAD3YUN7x3G9iCjo5d1
         SJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567434; x=1764172234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c0tKbMWJYExbbwiUVlMAFoF70l3EP9xpBcRy9Kvv8TU=;
        b=rUGTzNw5L4RwzxO/Q/I1VPux7EGX4+kPtuOe1XGt38UXr54Cp01j8QWqqzjqZnD0ec
         0Pp66hnYKelk5w+XTWn7k1h0ZOoQAlEdnjh8J5Eec0Mb6ij8+hgJ4GdE9pTmt6wmpyhi
         gV0C4Yr4njOl3GwVO3oz9KY+eGWe+FRXgcRAyLuzKHYc8o/mSMG8miPRavZVBjCquepV
         n4dY7McmGU+EMbcvakAvEmLzEsQgrsPkFNdVXXOY9qrrLUTAyThfbDfZoa86L1I4bMOr
         b63OORW8URVKEDCKhBecAQ/Wfd3rCdSUcta5OdjTR7Dp9I3ducQUaGBYlhWHXI67Iz+x
         l/HA==
X-Gm-Message-State: AOJu0YxZuZ7enNhx9j87vrUiBZqZS1x3DwkCm9OI3D6oYNOP0/3TSaY3
	bwhcYrxRK5wI99IRu4YlH0DY1lXfiSUnBDcO0ZrVnknZEJQcSOSq5DuX8vhd5AdRQGnIPiOppAX
	j/zksTRWkMQo3dOGxmG1gBXkEb+QsNxn146yqX2oxMFYvIUocVcQ=
X-Gm-Gg: ASbGnctgOcviWPbvsuZyQxGkDfNtzVKIQMG6FrX5mE32hFIRA2zahJhXchIhKog1g2y
	RsVTZ3nzPvB5Ug14KOex/pAfzeenzn9E887hHb6sT9QQiZDGL8wCNGOSeMxWrhldaYdRTL+uvIP
	htEntwBz/N6b1qCTckB//qenr37gQm7WrixCkifnPjBTFJrc0wxjVgj6tEAejAjewWME5XytvU9
	VF23qcooq0boiLfoQOtkmx7Cno7TMxnWD3HGzq1YGfd4w5aImnMR9hNXNhVDGujsft1oFg=
X-Google-Smtp-Source: AGHT+IFjNbZc3x+tt7u7IzKqPpBmobg9K5zEi2ekt+A0xIQnu7lshgMM8wB0zQWxQH97uryDLcxvRHZcEFCz/zO2hEY=
X-Received: by 2002:a17:90a:d446:b0:340:5b6a:5bb0 with SMTP id
 98e67ed59e1d1-343fa73f285mr20946692a91.26.1763567433662; Wed, 19 Nov 2025
 07:50:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119020334.521449-4-paul@paul-moore.com> <20251119020334.521449-5-paul@paul-moore.com>
In-Reply-To: <20251119020334.521449-5-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 19 Nov 2025 10:50:21 -0500
X-Gm-Features: AWmQ_bkIbWI6Ac1DL5IWf9fL9e93yFQwczJQBUDLCWL2GoJ7Zx_yMp9uRO4n9tk
Message-ID: <CAHC9VhQaR9r9uWuJ4h_HoDtyGu1M2tU+ASkWxsFOf6OR_thNUw@mail.gmail.com>
Subject: Re: [PATCH 2/3] selinux: move avdcache to per-task security struct
To: selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 9:03=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> From: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> The avdcache is meant to be per-task; move it to a new
> task_security_struct that is duplicated per-task.
>
> Cc: stable@vger.kernel.org
> Fixes: 5d7ddc59b3d89b724a5aa8f30d0db94ff8d2d93f ("selinux: reduce path wa=
lk overhead")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c          | 31 ++++++++++++++++++-------------
>  security/selinux/include/objsec.h | 13 +++++++++++--
>  2 files changed, 29 insertions(+), 15 deletions(-)

...

> diff --git a/security/selinux/include/objsec.h b/security/selinux/include=
/objsec.h
> index e71ce352bc97..6cc5104fd2f2 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -177,6 +181,11 @@ static inline struct cred_security_struct *selinux_c=
red(const struct cred *cred)
>         return cred->security + selinux_blob_sizes.lbs_cred;
>  }
>
> +static inline struct task_security_struct *selinux_task(const struct tas=
k_struct *task)
> +{
> +       return task->security + selinux_blob_sizes.lbs_task;
> +}

FYI, I just noticed this and fixed it, but selinux_task() needed to be
wrapped to fit under 80 characters.

--=20
paul-moore.com
