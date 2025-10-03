Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5449013A258
	for <selinux@vger.kernel.org>; Fri,  3 Oct 2025 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511751; cv=none; b=hfPW5fuWkfoeQf6SkQHapmvHmwArGEKHLah7MXdKZrxwXKGLRm1L6FjpmT9z4yth8kbjcqNuBa1E4ewG10Uh4P3l9bM9a10GZFozpvdXPc5YHQjlvLQMk1z1kf4aMpOAXwL0FGDQYyEVKSHqVeMvayyCoT6qwCrI/U5w9TOI7tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511751; c=relaxed/simple;
	bh=0NPoiZbcuTljKRE9IE9cfxsjid914W1BOeaB5B1MAWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbRrGNnQU0PP0Ktz7DtBM7e7bEt4Jo0YwRboOzJA1iIry3VD3coSV0RkZp2cxuOGrBfD1eeY+BA4uBwMbdS/QVX5WVcFfnzee5X6TjwqiZLhAQXBQTk5hvSJHbR+cqs6L2r0sQ3lyoVexnN/aZQQB/w4WQLEG7RlaT6pqM2JkRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmHnmAH3; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmHnmAH3"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-330631e534eso2732937a91.0
        for <selinux@vger.kernel.org>; Fri, 03 Oct 2025 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759511750; x=1760116550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQrIlPYCeDMFS6g0Xw3ObCA9wB0GS/RdHfZWbwbQfmg=;
        b=JmHnmAH3+dJvXRjVAyKivmPwC40LrbU/62b4pnMI+im1Dst/p5ZGPyvhu3x+Q3LMvD
         kpDG1PKVlslwRAoo3OOOSmoI/Whho2FqSb9kI1rISCgt1NZf2YS/Je2E7/yiqu1jNRg1
         UDWUjq7OfxyaB0aMMKX6DwYs3eS3rgDkXAHyaUR4dTWeoqrvq3o8Z3TLKgtc+W2Iuny0
         A0pJYBZ/DZJGOe7dpX6Nb6Jc5JZMTIKQbiH2RBTbA26+S/do5zx4Pqkw8DGZdmygvqMN
         ZWzsYml3WSAWh3BC2wN6ijtoQEh4ISv5JzZ21g1Z7s45k4BVvN6q1Zq7XyLb+tS3aDJZ
         d1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759511750; x=1760116550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQrIlPYCeDMFS6g0Xw3ObCA9wB0GS/RdHfZWbwbQfmg=;
        b=EaqJd041GJ3IslW+iwTGJccgTKrRbq5tA0kyCnphemXV5aYxietZzbBQ/5dR7f4PzW
         sCKasM77my2awSmOEqeBvZ7EzMI/7hUfPCeIIXZvYrRJ8pc6XpzZJoOLmvAjThf3Ze5U
         F/fTcYc0PAW9+jhKtqs8Mhz6WLQsRpAQwND/+sGAxfKOWQKX77qZmBwG86RiwcEqod/C
         zCsjeZPmO2ag4MfCuCgLX0j0Jz5SJvmzlKz3JxxhCpFnbUx9HJ6+VZGB5YmIz8iEOYwA
         P7AJlD4Ka6hXFQtoczLdaydrgd/Ez0LlB5wSLBBS7ZL+QqlC/nbG5sXcWgbnOsha9Mhe
         C7pg==
X-Forwarded-Encrypted: i=1; AJvYcCVAA1suCluShEnOhaCFUUY4zTjDlYsDAxMzkK0cpx1txXM314cY4eb4OLQfXtQRq7x2WIYepUkX@vger.kernel.org
X-Gm-Message-State: AOJu0YyzP7FTGDfGINOlT/UFzGIqT29juVXgZXXzlMqgVm+zwgu9M+aK
	W+lFnrA5e/sICmRv+AmXS+Knjkks/ifdHfc7g5RPkMqcd7bc/Noe015GGRvv+/GS2QVi7qjNhTf
	RRvOoUQ4SB3F1A+LsHklLHHr9q0m2/tw=
X-Gm-Gg: ASbGncu8QtTmTijN5yxFoBBTy2+3kot7vBMDBNHAs/PnDCENwPJagOvqPdn+IVd5ybc
	hmT58pAlbk0DXhZvhfYG4499Sz18gL716rLDAjdARcsRX6olQ1RO8oa3YNVphklRLC6NXqJdcDZ
	gYCOk/Y7VFjOis3xCr2HScy4o3tSMm/V7yaHbrOAfmpGDYirHHTJA+3NU9ABbSEQPLHHvwmdiu/
	uQjJzaiikW0/qLrGs3WV0o0lZwwi22Ud1Yx3WTb3w==
X-Google-Smtp-Source: AGHT+IFcEuKic+Tf8lUTRJaPEPEhT5Rl6gMjc2kZRCXF5TJDM1b458clM5LKQjmau6j6GSyui8n/y0pdq1kHCcaAE+w=
X-Received: by 2002:a17:90b:4d0b:b0:32e:43ae:e7e9 with SMTP id
 98e67ed59e1d1-339c27a50ffmr4890684a91.17.1759511749562; Fri, 03 Oct 2025
 10:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003131959.23057-3-stephen.smalley.work@gmail.com>
In-Reply-To: <20251003131959.23057-3-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 3 Oct 2025 13:15:38 -0400
X-Gm-Features: AS18NWDnIjAoE56yw_HjZFFUH0XaIXMln7NGShezn1DAyMFjLswB1bLYS-dxnTg
Message-ID: <CAEjxPJ4bdDA4mcPcYv1wyfbvBOYjg0018Q8QwYcMUUZAbvoCRg@mail.gmail.com>
Subject: Re: [PATCH] include/uapi/linux/lsm.h,Documentation/userspace-api/lsm.rst:
 introduce LSM_ATTR_UNSHARE
To: paul@paul-moore.com
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	john.johansen@canonical.com, casey@schaufler-ca.com, serge@hallyn.com, 
	corbet@lwn.net, jmorris@namei.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 9:23=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> This defines a new LSM_ATTR_UNSHARE attribute for the
> lsm_set_self_attr(2) and lsm_get_self_attr(2) system calls. When
> passed to lsm_set_self_attr(2), the LSM-specific namespace for the
> specified LSM id is immediately unshared in a similar manner to the
> unshare(2) system call for other Linux namespaces. When passed to
> lsm_get_self_attr(2), the return value is a boolean (0 or 1) that
> indicates whether the LSM-specific namespace for the specified LSM id
> has been unshared and not yet fully initialized (e.g. no policy yet
> loaded).

Upon implementing the 2nd part for SELinux, it turns out that the
lsm_get_self_attr(2) call can't unambiguously return 0 or 1 due to the
current interface definition, so will be spinning a v2 that instead
sets the *size argument accordingly.

>
> Link: https://lore.kernel.org/selinux/20250918135904.9997-2-stephen.small=
ey.work@gmail.com/
> Link: https://lore.kernel.org/selinux/CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=3DUE=
BjqQZQ4UBy7yds3eVQ@mail.gmail.com/
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  Documentation/userspace-api/lsm.rst | 9 +++++++++
>  include/uapi/linux/lsm.h            | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspac=
e-api/lsm.rst
> index a76da373841b..93638c1e275a 100644
> --- a/Documentation/userspace-api/lsm.rst
> +++ b/Documentation/userspace-api/lsm.rst
> @@ -48,6 +48,15 @@ creating socket objects.
>  The proc filesystem provides this value in ``/proc/self/attr/sockcreate`=
`.
>  This is supported by the SELinux security module.
>
> +``LSM_ATTR_UNSHARE`` is used to unshare the LSM-specific namespace for
> +the process. When passed to ``lsm_set_self_attr(2)``, the LSM-specific
> +namespace for the specified LSM id is immediately unshared
> +in a similar manner to the ``unshare(2)`` system call for other
> +Linux namespaces. When passed to ``lsm_get_self_attr(2)``,
> +the return value is a boolean (0 or 1) that indicates whether the
> +LSM-specific namespace for the specified LSM id has been unshared
> +and not yet fully initialized (e.g. no policy yet loaded).
> +
>  Kernel interface
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index 938593dfd5da..fb1b4a8aa639 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -83,6 +83,7 @@ struct lsm_ctx {
>  #define LSM_ATTR_KEYCREATE     103
>  #define LSM_ATTR_PREV          104
>  #define LSM_ATTR_SOCKCREATE    105
> +#define LSM_ATTR_UNSHARE       106
>
>  /*
>   * LSM_FLAG_XXX definitions identify special handling instructions
> --
> 2.51.0
>
