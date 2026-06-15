Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78E440B390
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540602; cv=pass; b=VD9uSP9RBz4TA6jLDCCbrHL/QGS6eGv0LtOUx95XpOwjqzulT/n2gH7iUEQnFZUBUxAtSfEl34LK2zxpLD6pMjX+Gw0i6JV08rmBIlbhF1bOJ32iJHlDgUjiJTKIQct4/Gzvy9JyknKvXuiJxz+YmTILEyggudpskO9gF1B6nqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540602; c=relaxed/simple;
	bh=wfZapu8wUHkB1RXZXx8PX21cIKNcngFQpLeo+hZQJZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ekb8Bxvso/jVFKescr5fre3Gclpf7An88mQJCAlgwP7xOoSv2UUZhftJqahOFgwXZEc8iyzZTKNENuMBvEGaGNO0WmfWAQMydow7xUlNV3yWAxF5/53lZg8ObNEG5sqDIVkRi2JBSu+UJRe63cmfZztl9z9SaIutLxykFDwtSLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+IPax4d; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+IPax4d"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36bdda53d99so1352431a91.0
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 09:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781540600; cv=none;
        d=google.com; s=arc-20240605;
        b=ZMqHDMWNQpPJIiHQVI5ApyMSy6kZtoNsAuaw4oqXqEEumqLtePS0Ub3QL2lciXOYgv
         wtfxOG41F8ylVZqEn4poPc8j0TWvb0CJBm5VUPa0FTl3lhII1bicr0gDTrg4htpM+zbX
         xMmIEBNDeuWqAkXG8z0Z32fZzpwOkNLGmWIwNkcB+hvHaSd+It36oVzqmQUuNRM4wt4q
         VsgvQHcajGZJlBw6+LcBtZ9IWBLYkCXO3zxtOswqqb1DsueA00Hg7Ty4QRGpuS3HfseQ
         UzEynHlrtHRma50B0A3kOAjN1IOhrE59tBLejMURDObgOJ3lp0/ttMXsCQVySbvBCTpX
         wz4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZGU5XKtNy/0xgaSqKXiFbH3gu4jP92xzjq61U1xWB8s=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=H2N2ObO8lb4ZVQrjG9q6zcKBjqXwMwRqu5y+9LelgbQKThg6gIsm4MbcbYv7qOt0Ho
         ylKtYLXPL21PUVb3oq/ZTPDlxeRXtq8AbGU7C28tAvMTk3wPTj/DIseXDLJLbtIFp9iW
         0gCWV1zswDLFY0W4fzKUxkqZdKSzYl4VthqvPFW8cinl7G2bKcx9PT/1DH5XrvTgRdUJ
         rkAXdyEHSYUk7wpXdv5mo+A/CyHF2EUsIhq5GUyN7KmGCyhRG9h/iRRCwGlNB3YCLVKT
         xGuLbM1vphH3MgHeJLTxn/DOgf0KqvlJYylhpkU8mNgiXNNIArdD08KsQRIITM5L2dlZ
         FPFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781540600; x=1782145400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGU5XKtNy/0xgaSqKXiFbH3gu4jP92xzjq61U1xWB8s=;
        b=o+IPax4dtpT1whMfYTX+l79cfBaQV2hN9eVs//upWmXgtynx6BAVJWn3lyE9EA5K7q
         +0PwxhtyCVm2P7sjd++MRmU6NIem5k2VnA9aWU8m6y4W3UlSbHCC+lO4dLAeeOzCGaC+
         ukfV3ad3hAYt9sjvR4Pxujw7ut3MyzF+SyiSy+Y/nIKmhGzA7t6xjt5gby7ZWEe8bvVK
         jMIv4BwSDy7yeRrs48tOvmwdnySeIu928wMnBKIfnp4H4uOV9FFjz1B+nhk8Fm1S9Ej4
         e4SxXq4+Mr4NpLlm18nu0ejGSflag+/pwMgnLKDE5kVI4tcXaNmAk6rHA+Y8hcl71qbE
         0mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781540600; x=1782145400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZGU5XKtNy/0xgaSqKXiFbH3gu4jP92xzjq61U1xWB8s=;
        b=CYbebN9xmc0akj+gmmwDjG+Zfwi9v85OkjIWBl2kBaKB9dgdoYxwYt+F/uO/+6gePX
         umkqQrxRCwtZycOhSx4QIgRxyxfmhV9YkdjG3IsrYpu2L9jsgiSfbWpu2Gb+EzjExPVv
         nXqpG1GPYQ8CXJZvAsTiCpG53H4cwwWf6tXX48kbHDL3O+P+Gqy6YsgSmaUwrh73ckkN
         IC5Fv+OPIH91YfSOKfBc5bel5Db3+odOI6ZL3wKxmvVxv4QGI0U/WUPW6/qXMEi2af91
         N3SV4drDtRXscpUyLD1FezhDxu+Zr1fz4TeHh22mczGRK8llyNK/q82UBGTgmnRLo8oL
         CvLA==
X-Gm-Message-State: AOJu0YyUpNwzo2JMcWwXCWUys1/wr+HGwO290sNCPPi1EF1ALbPPRdoS
	2Qilz/iQjkO/FN+gk3zDBnUTDiAKRaNF+vgIhfOH0+EFIGYVO3F/Sj3sWZ2kSOF1s+bWW5GcaMg
	q2iD4VQw73VuAlsYN8KaE04NUZzxGhVk=
X-Gm-Gg: Acq92OFq/86JQJipSSA4YCBwUkzo9AfuOgh8ctzs+Eap3b8ZeTJblVi2pNDUnU/pmog
	+7ta3ksNs8sk1JYLwleiAvJDagYcd0JeNjG/DLyJtT7ry0EL9/73xg2D5RvAFrh7EnXE3wI46Lk
	AyEp2GxpbFyojlXc79ubojwMO+Q8iTP0J0begplxSE8/IT2Zgy91muXPDCeGSXvUE/90oJUq+2B
	xSj0FYxCSo6Ex1KXyeODG4ZH1pOCr9OQ91MQ82rSf0RSET5OlXWr2QM3FucAuoEUcBcjfHE7aER
	R4rFRsE=
X-Received: by 2002:a17:902:f608:b0:2c6:9358:3ad5 with SMTP id
 d9443c01a7336-2c693583c21mr30923725ad.17.1781540600160; Mon, 15 Jun 2026
 09:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614174806.35097-1-kalevi@kolttonen.fi>
In-Reply-To: <20260614174806.35097-1-kalevi@kolttonen.fi>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 12:23:09 -0400
X-Gm-Features: AVVi8Cf0OCLqMlhUi9mt_iS82pugsZZP5Nh9wmU3VqRYIWkMc4BRxrRUTz5jw8Y
Message-ID: <CAEjxPJ52199+eCagrysp7HBj7jiCTMVA357vOGy_fbys6+5kWQ@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: use null character in strings
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 1:48=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  mcstrans/src/mls_level.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mcstrans/src/mls_level.c b/mcstrans/src/mls_level.c
> index fedceba5..7235fdb5 100644
> --- a/mcstrans/src/mls_level.c
> +++ b/mcstrans/src/mls_level.c
> @@ -22,8 +22,8 @@ mls_level_t *mls_level_from_string(char *mls_context)
>                 p++;
>
>         delim =3D *p;
> -       if (delim !=3D 0)
> -               *p++ =3D 0;
> +       if (delim !=3D '\0')
> +               *p++ =3D '\0';
>
>         if (*scontextp !=3D 's')
>                 goto err;
> @@ -36,13 +36,13 @@ mls_level_t *mls_level_from_string(char *mls_context)
>                         while (*p && *p !=3D ',' && *p !=3D '-')
>                                 p++;
>                         delim =3D *p;
> -                       if (delim !=3D 0)
> -                               *p++ =3D 0;
> +                       if (delim !=3D '\0')
> +                               *p++ =3D '\0';
>
>                         /* Separate into level if exists */
>                         if ((lptr =3D strchr(scontextp, '.')) !=3D NULL) =
{
>                                 /* Remove '.' */
> -                               *lptr++ =3D 0;
> +                               *lptr++ =3D '\0';
>                         }
>
>                         if (*scontextp !=3D 'c')
> @@ -170,6 +170,6 @@ char *mls_level_to_string(mls_level_t *l)
>                 p +=3D sprintf(p, "c%d", i - 1);
>         }
>
> -       *(result + len) =3D 0;
> +       *(result + len) =3D '\0';
>         return result;
>  }
> --
> 2.54.0
>
>
