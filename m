Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0AA37F742
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613302; cv=pass; b=QT4xB1sRPSjrEyz8iiIC+0s//vJw41DA+joxrfD77XPSrN7ib65DRiw8XlcSBYdDSOzZqpcyszO07zhGa725EFLdd0tFZ7DuYKxgmJC7l3tfeCRvqe9dnY+BX3noj94v8wMASy6v4PlCHlTWiwyNbpLlmeDdStxz0FPz8MoPQfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613302; c=relaxed/simple;
	bh=LPcRp3WDNkFHSwT3fYcG7mTQ95C0umGk59DiBshj1ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGinTfab6/JZPPOkG0dFSRq3eUDAMytTEMxjSEoArLgHVk4mSbbwNDQ2OmOvliq0wLtRlzOorecQIKOMUO/VfFighBsq0YciDRb1db4ZLbtm3bBEPvq8PEqpCd75spEoaq8EEg5afRsq+muSd/QGmORgIISwAjOXu8wcSLHe+eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euB4o8LG; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euB4o8LG"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3938cc204a7so47374821fa.1
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 12:15:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778613300; cv=none;
        d=google.com; s=arc-20240605;
        b=GGC5G9nlrorG52CpUYUkreWSdm8fiWzOdUBiHRvjKcUr72fCJX1NtFdvVP9HlzJ7Jw
         BKsBxq0TD3DSMOhp0OwHXZ4ssLCOgLYA2X6g2yUg66lKO6/G984EZtcfFjKg4YQp8Cr6
         XOJutNKI791McDbfnqQ515J1r9hZOEc/KJnmbYNTZKTruBpH4a1RwGSB7aHhxBIVi0v7
         bj/RHRXDhx+f+hmfIyvYVNRrEo89vsWXsNyLYKtgdDQnPEXCptzMViurnotgadZIkBUP
         fLqoFwh/C+GA36Xej2n8FiFAfw5dPlmSDaGgOZqYXf5G6XpAxg0XB2iIkVWsX73HAChD
         PfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EgYFCXIAxe43Qg073vRR2oG3WBDoVPR/DCogTMe3ZQo=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=YUSqH7o/+K/Nzr6kbuJ64iX7Dgno60pEfCRnR1HfZEEIWXWN/MHK8dqfGlFv9bOlSR
         LcebSwl7ruWUBhZ9fGlYfcwQLu1tIxs4OnknIgQfB3PjOu9ouypf0KuBrpXV2EVdGz2a
         kmThxAS4l3AKEGswvu2l4xqYtofuk35l2r6LaUuSJ+DAMen6aI2F6zH4rRNowjc7xRfl
         bB4fJe0BpdjKWdwKuejCUfm+KvJBMyy78UvKUC8Ap645JEKWmpKBWzZ5zlT9wFeSriff
         xYV1H1ntSGfEYXivCWXA0umaJ/laPnMhlXyJUQ3Rk5sTrCdnTDGLer+QiDifRYuTRs+2
         /pEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778613300; x=1779218100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgYFCXIAxe43Qg073vRR2oG3WBDoVPR/DCogTMe3ZQo=;
        b=euB4o8LGmwCbGb1vtFQCnJqZ2BDmCt0qLYctjWY4maC4Z8A7ehfdeFpMQzT0dVc//s
         qDoYBQfGky/giwpt/xl/kHtMY6071JyK4GW0UBPmB9H8Ch1x3j17NKNuYt8gJ2AWBN+p
         A5wq86g7LMS6fHu6LXaVBmw0k0k0VWk96IVRg8G36Nx8/FISgC4MgFJSQKcXxkl5g9Va
         kyBC9ZUBpENVzSIxT++12jGU75hu6J0oDuYoiYkPfBoT0DheUhYc/KoNXF6y1dH2dPZE
         yuzh7POhjjTwPKC86wp5i9B8UcwO+WwKrAshIqGC1kt78T0JdyhJ2bFSQYldw+FPubWY
         jZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778613300; x=1779218100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EgYFCXIAxe43Qg073vRR2oG3WBDoVPR/DCogTMe3ZQo=;
        b=BRuY94O+lCorwq9KuIdlUZ3L0AWQAMivtHovuu4t0ujYGA/D16mmow34cAe6ansRLl
         tQBm2q9D/9Ws1c1/nNVKLHWk6oWNHDB/y9NnxjmHa1KV4Zw4MiyCuBDJsj5M1F83S28X
         YPN1wqvdeRz3w3PWu8HuwR0P3O3F8gbtRB9Rs2wMnTj5d/FgWUiMuxUXVhxenctfTUHl
         mg0hpuRAivZ9muzfMv0Cf5eDy+6r2su9CHiOhq2DagkZFuDrHarxLg+MwadwRq2v1yYI
         JI9kHt0lCMt1QCPcDBiOgS7zt+/eEvai36gVUQ/LiH7J03ci1d3RtkTnKxZ9ZBqAZlEj
         x5Ug==
X-Gm-Message-State: AOJu0YwHQ0gHW8mrzuLDyESX3o8az6OYQ4ZnuhgGwEb+/BJNAcMc/ntl
	ffPav2UVjGCeImjZfvwcQb167wuAaTo9JMx5fdISO24UU8fk+n05TD+s4mLxoRWSML9yiZlDgzl
	loWltfviL+mpKBkEd79ytvlzVwls43F6DtLv1
X-Gm-Gg: Acq92OEpg7vjo4OUzPE9LXs6VRivwTOlbzaM8YKh7Kif9bZKUmP7v0XfGmFrGZnOBGh
	WtTaPisdoJW6vwM5lX6b3ORGHUJU32dVdX661wTW8Lwu+GImsStNbeZjOIJtWUuAHdfSZ07Mns+
	/0FR0JGVarz+WX3xeeRPJl4p+WPooqXRO+TdvyTMXtB5cdqvJVza625acaQLiDT9MFyqudibx6S
	ShDW+jmFMaz94vbySW3f/ZlObix26Pz4mb0PUMSOfLn5jEW0U2BQSTHfnOB7FAVFjUUELgYrX+e
	ITXG
X-Received: by 2002:a05:651c:41ca:b0:38e:ecd7:a5ad with SMTP id
 38308e7fff4ca-3944b5ab4d9mr569841fa.20.1778613299282; Tue, 12 May 2026
 12:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512183402.751341-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260512183402.751341-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 12 May 2026 15:14:47 -0400
X-Gm-Features: AVHnY4KL6WLUXNj22EGCgeC_suAZ03NBlFhV3yxhvFRGI0rGvf1LXfIJtUoT79Q
Message-ID: <CAP+JOzSJc926t7oSXyRc=TKtmtr643tLBmv1HgwR2405Mi3nHA@mail.gmail.com>
Subject: Re: [PATCH] sandbox/seunshare: pass O_NOFOLLOW to openat()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 2:34=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> We do not want to follow symlinks here.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  sandbox/seunshare.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
> index 2512a18c..4e441b3c 100644
> --- a/sandbox/seunshare.c
> +++ b/sandbox/seunshare.c
> @@ -428,7 +428,7 @@ static bool rm_rf(int targetfd, const char *path) {
>         }
>
>         if (S_ISDIR(statbuf.st_mode)) {
> -               const int newfd =3D openat(targetfd, path, O_RDONLY | O_D=
IRECTORY | O_CLOEXEC);
> +               const int newfd =3D openat(targetfd, path, O_RDONLY | O_D=
IRECTORY | O_NOFOLLOW | O_CLOEXEC);
>                 if (newfd < 0) {
>                         perror("openat");
>                         return false;
> --
> 2.54.0
>
