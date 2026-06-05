Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEF6287510
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670458; cv=pass; b=QzNzi5KdhC1efGUnHE41INZMp4qAgE1LJyQ4z9Xrv6RG4GtclLLi/KsTivOcgTYtC67oP3/wNVxHW0iWNYQoklmjz4XlTGOPxdGKCznuqa5QvojtSLg3NmF3buSjMxGVKTdNyKLuEWIjup4J7NmSiE4zROAjhOMgZWBI4h2aJYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670458; c=relaxed/simple;
	bh=XxQ8Ta2wgZUASAPBJJfobAtXElieA6bWby/Q90Xbx3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmwQJdpi2g60X4AemExm4z+T74YfB2UfkrSESJ1ckA7YK/d78DWpFRBE6vnCPpoLbXG0szzcF1AqMmxQH618Qq0UeV6GEwWX1qCMDHHpbkNHpKmIGkHjG0vDKkZ9oQpLZzQxdo93Ju60aelT9v1Z4cURCrKG58cU3uQkWboY9C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1eDeeoy; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1eDeeoy"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39677245e15so19666841fa.1
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 07:40:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780670455; cv=none;
        d=google.com; s=arc-20240605;
        b=MatjMMw4RsBbNevDFhY7knpKNRLT1ycMp9X8aE9V1kU18+V+Tuxb9SyVwOIDhpKJoR
         vwgfiKhsqJ4r/oGyI6bkVGtmtH45NC00oX5dVrFMEH7fF4tHPgas61J01yW6b8HVdXSW
         CYt3Qq3Cw4jBRuuu6qAQu/a4AScH1jIVSy+6838TmNFDuMNGdrp52yRYQnGWteGKQtFs
         rdBiUflXKE/fy4aatiq0qv1c8kMuayKh9X1GMg0uabWHcO3boN79QEhARaHb/5wAd3HV
         dqtDqMAp/jz6zyiSEj9TVNZewQ/REuavC9DLiPwpbsODaBFMLLN3UT3EQOv59K7Jg6E4
         pzpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PNH0hRBxYnOcDQFqNldN0aKesE/B8FU3uodrGqD5Ij8=;
        fh=biLNIbUdiVI+HWgqVoISrU2pQus1fZiQi7u7sC8l6as=;
        b=SRom5Gkx1CChVerSmpTa7ET4JyLvWFqf4FVd/Vp71vRS7fmobhgjPWxaa4iDdH/LYa
         z7SIN0zM21sHRFH/TJuznV8Xmj0wi8cm2L71BtH/6ug6xsqzNsnr7d5JnFeVxj4yiKmA
         Se61f1XGufRFdfbE85mslSocTybfYPI0LcccgXFuiRbvUvxOb24OtaRknwrLqREAHUqc
         GGBSWWtG2lBiad/07Agzw75IRsCrN3aA6+qWbD8fFn6gry0PVJz9xdNV7I4F6OBJSqkM
         9QUFdWZPoZteRNm24831O7WQ6JHznPvx2Fd6kU9DgRluwZBsaMxGsiU9/m+ek8/hAZyB
         uw7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780670455; x=1781275255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNH0hRBxYnOcDQFqNldN0aKesE/B8FU3uodrGqD5Ij8=;
        b=E1eDeeoyL6IQ9qcXYQpxlSJfIb/V92cs1i9QTEkfbcnxUqM0Xb1W46zLkRKTIQ8fCB
         5fErL71bp75u5y1EUbjylAPhaMbQ7jNlWAMY4kx2rUcAnzoH4f8vo9qDAc2kqbK5M3b8
         gl98KVsoBK8drBFg7F7Sf8gTo8LxQh2cJw+L0EdQ2DlhsonpdtSlXsIe+c30JFRbDX8I
         N+lTFV7f4pzpUqna9xb5qasXL14niP7etxnq2ZD6eVcHMxTuL3PDkq0KYlKF7MVsms/x
         7+MRujDkQjECehYSY2LL8pMMDsxibJiGzIbLVhaWb7SDCApuMzZK8Ag4SRzxsm/3TI52
         q0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780670455; x=1781275255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PNH0hRBxYnOcDQFqNldN0aKesE/B8FU3uodrGqD5Ij8=;
        b=K0nhtaNbChRF2DUr8UXwc+zF5yk44HsOAlCOHO4YZTr+rsaiQFIg250tTYAfTyHzRb
         0vzo+lD28SbtFw0Dwrjid8wWgq4Spu2OWTQIq+Haepr7mkScRVWpTg9/uo1mIDKl+h+d
         3CF+FSCUYKVAgcgRgcrBFCS0gjqOy2o3vfvJgduZjZ2hFS8PPRfvE2sLmVca1fHMlPUU
         wSXNnLEZVOWaEsbrmc5JxxUlUpL39DEzhz/8e8wXegDvVu+DuQRJyPp/VRHKSFzbLo02
         qJbvmN7W+RHCGrwdpwyOsCIqNPZvMLx6V2gUF+4AKJYhUq5h5094NmGbSZFoLniqFHEJ
         GnLQ==
X-Gm-Message-State: AOJu0Yw+ScmvNxDFYQ2XYK65OnfUIhpNe71D1aUSv697EoMgF/a7PKeC
	H4xIlcPmD+36z2KC00cFm538US1eE22mmwaFSz52kv8iS8pu2FycnI3C7JQtY1tMoPMs54QNBRF
	uAPwWZzIoHk6ojKDOQfEfU1DQvMv7fLc=
X-Gm-Gg: Acq92OFQHHvJzqpJbAQLYqJjHW3okr2dbyOM30ntlHvu6a/q6TBWy8B1ezdPy2Osn9x
	fTvE5SqXNQa/SvFRgM56HlXO79CRDVOwNORHFuooysE+munQ2b2iPQVL+Dgxj5N0VExMtmP0HJ9
	u6qFGKlN/gtiZwOk6PC2uhVqqw8iD7YTanqePChkbapGTjCWL+FDC+A0bA+0duzwpszzrDqTX+t
	wrGQuVZpN5pkxFMyxAvkWHpuZXYh0xp1TBosAdjdAwrpik9c7zocnvNFdDrqTRa6V4QP0ufrvzG
	Bmrg6yJ3N6DDSKM=
X-Received: by 2002:a2e:bc02:0:b0:38e:58c7:cd1 with SMTP id
 38308e7fff4ca-396d09f1a9amr12430101fa.21.1780670455127; Fri, 05 Jun 2026
 07:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604174247.263844-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260604174247.263844-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 10:40:44 -0400
X-Gm-Features: AVVi8Cf-NHO31QfieM8iHLWG_3sohjgoetxXjVnUJgSY0xWLaNrlMKzX5NzVKig
Message-ID: <CAP+JOzSC0qStowRwpy1DjpOKGi1iu7WeGr2ksYYFYDyw_7f-Fw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: label: ensure specfile_list is NULL-terminated
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 1:43=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> selabel_digest_fini() walks the specfile_list until it reaches
> a NULL; we therefore need to ensure that there is always
> an extra NULL slot at the end.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/label.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index dcbd60ab..1ccd1abe 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -70,7 +70,7 @@ selabel_is_digest_set(const struct selinux_opt *opts, u=
nsigned n)
>                                 goto err;
>
>                         digest->specfile_list =3D
> -                               calloc(DIGEST_FILES_MAX, sizeof(char *));
> +                               calloc(DIGEST_FILES_MAX + 1, sizeof(char =
*));
>                         if (!digest->specfile_list)
>                                 goto err;
>
> --
> 2.54.0
>
