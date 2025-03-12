Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F959282F1;
	Wed, 12 Mar 2025 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784669; cv=none; b=hPU43iOS6yq3RlPjM+kgP6hYSLBn7B4E+Ydn44q+AW66KDgQoa3Gy8OQ6Utl1sZowgHBEkQb67uwedQoG0G1eNQ/kQm8qDqkAjR4yezgBD966Z7RpnehYS3lBi/858FXkxwVYtpyVpjM7VrpI72zWSs6HU6fXst0hxfWgRntHz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784669; c=relaxed/simple;
	bh=NUKmvCFfHH4W1XJIKs4M9ElG9Fs50YPkTV1BEEFxWbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phyKj8fJ6yihvgcpe15L6QgyO38JpbfFyApgvsBHgq3VXsZ95mEFHANK+u2p45+NlFE6RSlp139dEvXVOyhQXMSASs/XyYIiBtzO+8Jb8wj8x5BDxJ6GAA5hBB+cLyS0cMdJTjCJ0LwY2JlrzW+u+FBMroPtDJTj0bN4z3w5jio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pp/BbA7o; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pp/BbA7o"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2feb96064e4so12824580a91.1;
        Wed, 12 Mar 2025 06:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741784667; x=1742389467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrOEurKxcjjq8OkzdDYuj5GePA7tHx/oSCEN2/ELTlA=;
        b=Pp/BbA7oftMg6+CVtqSR5ANfAf82zXL37AnjP0wq/IbVRHWelphQyDCpAmA6Zc+YKU
         L7ZQnp6ic+YPuUm2Er3WXXPgrwJu97XIFNHieR+3C+FKjqigtL4iXLqLP65Uv44teGkI
         siJDMEgzB9mZTZhKaPtHMfj9tOAxkjDJH4pGIPivBYMwrL75qcptyOz8bAuR8nFhAgkZ
         MRl7sD1waKaxybG1lNcpQ2TP80Vcp30F6mjDWO+/CdD54GYN0O5i3w1yQGQNGkR0g32I
         ANPUSrkZ5yQzFUuJ3hOWRw0Z5d1UtXmY5S1kA6DrpAzPnqG3mKc3ctA3KYNW+Ab7WkJp
         oUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741784667; x=1742389467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrOEurKxcjjq8OkzdDYuj5GePA7tHx/oSCEN2/ELTlA=;
        b=kix8e8bSWMLr50cLAKy8rHSD4iSK+dgiqbS0+I3zEzOcZfQ809aX59G56bIkyjruf/
         P5Hov1sl/2ZyE/UtgJiNaH9BV/R/xYByPViZo1TQeZo3ZeDpr3qZWvOQwmD8BcEgdB2t
         Ne/a9iXtZK/AgBgc0Fz9VNBoQ+UHwFJBFQVcy8yhOIUjIJeWx7CyQhEVaXWwP4attdPB
         OI/XEy45xkFKoiEdJ5W2yYmW5c1zim7auEf3ksznhECksZOOPSzhwcyir0vl/67diB8b
         KpRDYKIHXKCT0UZaue6JCVeU18gP+MV5UErg3qN7iyxgh7jp07rFOEueGBW+zvwiM3S2
         ZwAA==
X-Forwarded-Encrypted: i=1; AJvYcCUOh5Fp6LlFa9DdHWUJIfSyxFOG4DcB73RxS5GLBHzhesrfTGinw97OMkri8XUOs1dNdGwvixqGLQ==@vger.kernel.org, AJvYcCXXElD2alcfihXx7nAr01UbNdJJviUQsVvuUYwh2GiGowESDoxf0fnv54MwWUbfBn7fuOiUtB7OMgcHcQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz/cCSI2xeT7JeMJIrJ9f8NKiywF4BK+Vp08W5BpNKUdnuUTJB
	TfzLC4vmo55Gq4+4Cg6pP3m/hIyKJPjR88fwBZP3cl2gIRKuuC5PcsY1wIDCX1yH7Dl9198ImVy
	86GIO1f5yiXWbPVsM//ujlXPgs/o=
X-Gm-Gg: ASbGnctuIuilTYOmTR7SBuhRPymnSZ99Z8jmdK+f6tNGZoK38J7UjikgIO8c2k7rhVt
	G6f6GQvmTQa06w4/vttNe8Io2BUUuIUgImGu/DjZGAPltYnxWMdCKrOIT1jOAXwkeOLf510N5iB
	4p78qwP7UkUv0hYNKSNjClER4o9A==
X-Google-Smtp-Source: AGHT+IEoZ46HX7CGcd1Ce5EO0f/LDiJHDc9sBv88EwwFZGAG63dkZ+OtOgIQK9Pb5EgZMrfO568zYNbdc3gkzhLOAmk=
X-Received: by 2002:a17:90a:d605:b0:2ee:df70:1ff3 with SMTP id
 98e67ed59e1d1-2ff7cd31b16mr39369425a91.0.1741784667175; Wed, 12 Mar 2025
 06:04:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312080055.8950-1-cgoettsche@seltendoof.de>
In-Reply-To: <20250312080055.8950-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 12 Mar 2025 09:04:15 -0400
X-Gm-Features: AQ5f1Jp7sUoTSeKT84PKyrSnseU9L-kbdBkqb8eAsqXjy0y2NLZRQhFKSWbe1N0
Message-ID: <CAEjxPJ4MAaN7P8ZtCcDhRvNt44LNyzL9azc-xNE54=tkW_4vjQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: get netlabel_wildcard policycap from policy
 instead of cache
To: cgzones@googlemail.com
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, GUO Zihua <guozihua@huawei.com>, 
	Canfeng Guo <guocanfeng@uniontech.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 4:01=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Retrieve the netlabel_wildcard policy capability in security_netif_sid()
> from the locked active policy instead of the cached value in
> selinux_state.
>
> Fixes: 8af43b61c17e ("selinux: support wildcard network interface names")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Do we have tests for this feature? I didn't see any.

> ---
>  security/selinux/ss/services.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 1b11648d9b85..e431772c6168 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2587,14 +2587,13 @@ int security_netif_sid(const char *name, u32 *if_=
sid)
>                 return 0;
>         }
>
> -       wildcard_support =3D selinux_policycap_netif_wildcard();
> -
>  retry:
>         rc =3D 0;
>         rcu_read_lock();
>         policy =3D rcu_dereference(selinux_state.policy);
>         policydb =3D &policy->policydb;
>         sidtab =3D policy->sidtab;
> +       wildcard_support =3D ebitmap_get_bit(&policydb->policycaps, POLIC=
YDB_CAP_NETIF_WILDCARD);
>
>         c =3D policydb->ocontexts[OCON_NETIF];
>         while (c) {
> --
> 2.47.2
>
