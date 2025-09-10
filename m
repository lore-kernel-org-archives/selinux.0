Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C5A22A4DA
	for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514021; cv=none; b=eTkhkVNfAldWASiF5LOEGeOzTFsb/z2dce4OWXkFvrtiXvBnH/d+9RaL5i4GJoRAQObbRMxMFc3OrpfsEwSOuV4F6xu/TVhhHWrea1sg8olH2p5xegjZN2f4wYUMM/bESpNE77zy/FpaEpbTBpJzcf6BAdZGceFVTmgqxObqUIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514021; c=relaxed/simple;
	bh=LYWVRXoknn+pEJv5bCGAElDDSBK8jPhFpEQkVBMJ6rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvxQ3Pzhz29B6yiMFLpMOITLK+dW9h3whn+W/Vdbv7ZcWWnNaQqse6U5KXp5XuOgYkoIIVLCGuWOshNOebyHBJzdAnxISCLM+7yik7lX7NozqkEmz2bDFHuzsb/8wdnPENfZVO43fhiiaaOe4zxm9Zvld4vnhyye7cbO93/A3Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQEdJd1e; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQEdJd1e"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32b4c6a2a98so7143514a91.1
        for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 07:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757514020; x=1758118820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpjXvpwrv8v+Wapnmm9zl0oSDPtqQwNHfrbi2igun6E=;
        b=bQEdJd1eib3CwB6+N4Y6doQYvX4EGXFgVwrXFBlxGMToTZkIjBNcPyAov5dI2tXDrj
         kNn16S8Dafzzag7fjhHmPvYXuSvA6nQSA6O76M/mVstzbpZ6LI0lRGNlYqicU++umY08
         BxY7JOw3+s3nFBZ1f2FnMipSFsFOyWgumjj3jZytCMiRIEWrGWiihwDxnwbUE93ecjnS
         pKRPHFE5MJMWep2++gCa+HTq/jYuV9GQ/K3Zsl54ZzJMW5KqQej795MiVNH05xdxVj54
         k8fHLwa1eHTLd2I38tpJn8VssA+l0DlgJO/KLw4hTSmQX+JRkPGbc22FXRgTD4ufQQqp
         1WVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757514020; x=1758118820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpjXvpwrv8v+Wapnmm9zl0oSDPtqQwNHfrbi2igun6E=;
        b=ZLMw2fLCaTf7AS+pw3pmse9ociiW3ooQ155jHPs6a9TWWODCXMp4KbddloNkXYPO1P
         zKXzOQpWVL++4SdORsh6PsrzsqiOoF79ixTzfC0KRsU7uSx+QU2XK83MEiYRbAO525Jk
         y3ZyzXUxD7ojUEookZ2W1Nikglg6o3/fr4HBZHD7zrA59go6Vzg1D5GvRJe2tphX8aJK
         4/z7dIeJl0fzT20CPyeZqJOrfvV4git5+LwLkPUyWt0rKuBthbrfNICSSO847A7VwBDL
         eXvl223R0zStwBDzJA1qLe785agi7UbBUHxwyWHQX6eTDLzmQNLzszJ4/3844/WT90iE
         2MxA==
X-Forwarded-Encrypted: i=1; AJvYcCWrOu5JBsJzju8p9f+3+70Cj5onAB695qmljCZhB9lN2DdF+ZDQ/SG7O0NSv4EBh6G97IC6Pu15@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7+mSGpi5iCIHnaIE2FrO2k0NHESt3k3zzB0+Y92I9Wpguir7T
	puSpcrUCZaOVJyfzujmfYObZ16MWNogdd2W+LtP6qo4vTCWJv2luY7dEniBZTC10v4AxbYjmJ2E
	oi6ZDiHYIY+YXpq8AabYQ3xGBtepv3ering==
X-Gm-Gg: ASbGnctdbYwX+q5rJVplePX+DgsgzGU6OHFyhUJ9momx0mTiktWUBaCLKKdC6N36bNA
	wTbtibsj41kUfEKRbf4RT429hJmu9GOUnpx3KG+MaTnI/oFI7FWYSqbWNeluHxeGG9ToCdB/483
	1UQXLSGDY1BLX4GrgAcfQfkvafFCIiSI0JGu9CzXEdKtVgYtG0EtDUIEOFtuWn0UqLgFamPg+EF
	NHAqSE=
X-Google-Smtp-Source: AGHT+IEQXsO3HYGNklDmuKkSIdFObmWboz6ozH1xkn2C7S/mm1nH8MToBG7yTqfG5fBhZwJDj/LAWTA9Y6faHe1aAv0=
X-Received: by 2002:a17:90b:1343:b0:329:d8d2:3602 with SMTP id
 98e67ed59e1d1-32d43fb6f0amr22743697a91.17.1757514019634; Wed, 10 Sep 2025
 07:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902055026.617170-1-tweek@google.com>
In-Reply-To: <20250902055026.617170-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 10 Sep 2025 10:20:08 -0400
X-Gm-Features: Ac12FXyrJZUjQ7l7q3kmojgHwaLadHmuqh1tARqNLpbn2EeLMuaXHqcHibnkL2w
Message-ID: <CAEjxPJ6HmLe5c-iosTvfDYy5EVz8xNRq0=A-jDKTKXvCNWMypA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: add memfd_class capability
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 1:50=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@google=
.com> wrote:
>
> memfd_class was declared upstream in [1]. Add it to the list of known
> capabilities.
>
> [1] https://lore.kernel.org/selinux/20250826031824.1227551-1-tweek@google=
.com/
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Will re-base on merge.

> ---
>  libsepol/include/sepol/policydb/polcaps.h | 1 +
>  libsepol/src/polcaps.c                    | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include=
/sepol/policydb/polcaps.h
> index 0835ea21..1f8e8bdb 100644
> --- a/libsepol/include/sepol/policydb/polcaps.h
> +++ b/libsepol/include/sepol/policydb/polcaps.h
> @@ -19,6 +19,7 @@ enum {
>         POLICYDB_CAP_NETLINK_XPERM,
>         POLICYDB_CAP_NETIF_WILDCARD,
>         POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
> +       POLICYDB_CAP_MEMFD_CLASS,
>         __POLICYDB_CAP_MAX
>  };
>  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> index 7ac0ae7c..22f0905f 100644
> --- a/libsepol/src/polcaps.c
> +++ b/libsepol/src/polcaps.c
> @@ -18,6 +18,7 @@ static const char * const polcap_names[POLICYDB_CAP_MAX=
 + 1] =3D {
>         [POLICYDB_CAP_NETLINK_XPERM]                    =3D "netlink_xper=
m",
>         [POLICYDB_CAP_NETIF_WILDCARD]                   =3D "netif_wildca=
rd",
>         [POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]          =3D "genfs_seclab=
el_wildcard",
> +       [POLICYDB_CAP_MEMFD_CLASS]                      =3D "memfd_class"=
,
>  };
>
>  int sepol_polcap_getnum(const char *name)
> --
> 2.51.0.338.gd7d06c2dae-goog
>
