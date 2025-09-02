Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A210925EFBF
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827441; cv=none; b=cd58q8EhzJar4xZUEmyKDZFIH2u76QsRmFcJkmPlmEUX/tTrJ9Wz5/DSf8Ah7miX4JBSfnJ2j9Mew7s0X1vmhzqjDe3cLDCI6fi2pHs3hb4PVVkdvWsLvy0mSqXmiE4L9JrRltfj4jMdI0HfaAEyBlavENZ8AoVA++VnUcsZ3Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827441; c=relaxed/simple;
	bh=tE6SO5xCS0UXrNRulBlAFbZQ+eLvSC7RvTHAD4+tNHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SL1UJAvsicnWaTScrhBs0hLFRHwzsHCXvdponI9st55HAYW9y/WkmMN+OKVKRVv1cvvCg2vay3ywa/4aMb2v+FRnVYRuWEa9XVOnxDw5Z4mS3YRYRjxrxfXz1L7O0FITBVbbBDOf3ySfRjcIq1dK3TRxh4v0HUAYFdWhSi0eAPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUcGhpkI; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUcGhpkI"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-327f87275d4so4082868a91.1
        for <selinux@vger.kernel.org>; Tue, 02 Sep 2025 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756827439; x=1757432239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+BjPWsWqjEIsAzc09Izq6XAKHdKo2rR4CYT7RxuaTo=;
        b=CUcGhpkI5OOwMfqe/mTBtkcYIp9o8E8fUNugao/u039+oAaIN3FYNMgwssAqQjp+1m
         g8aAA+OikqmxHuvbS1Pp4c3KCoYK0GW2w3uoJCYC13+yRz3uwp2WGD0T38vJR2DPQJik
         Ns91yPPLfPAs5tr06pkZGVZTrz2nnqJgWQJMaWPsDn2JHf0sZte5r0iyKMEntBQlIVCK
         rb8pQAHq2BcLOiSbZ3NeWFRwQqULZiGEpPMi/bHNnODhhtQm+zHUKCW60z4we8gbUdc1
         RGlaTzT/q1IqOU0n3msUKxd/aSM45VQXIN04O77fzpKhJCdDsfwU9Pvr3zc+SCk7SSVs
         sQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756827439; x=1757432239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+BjPWsWqjEIsAzc09Izq6XAKHdKo2rR4CYT7RxuaTo=;
        b=Ooi+XOES860E308TtPX9KC4dX+UUVs5AMs7ugfGDDy4eOvq2yPVyuTeGmJmYVtf9QH
         jcwyb04tihe1dj6XHGjBk198rM6RyRl5daJqc5T7F5ZPYVIFDXhtCqsGw4796cX83skb
         x68E7jNuLKMFzSVUd6meChkQn0p0504QInrDE+hNt2zTk2rcBVLnT5pCnVQlac0v0nKn
         6Mmh54/smyisruW/iyPcmvQzzH47DV8Idl3KpnNumejEFuR2Wdpq/Xy5irpaIU1FrNmM
         1bzTHhh7uJArCO68ypgtrWHxQzvr/I/tvYoiBL22grPPz/RRtUGXnt9lNdjG2fI1QCWR
         pCUg==
X-Forwarded-Encrypted: i=1; AJvYcCUBqRwye45GUJ5fxR1FH5tlTPCXsbmPHGECaCSlPSLIJ/rKinSHQIzwwhhgqdvnXwBU+G5nwUU+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4zZuWDbfwW0vnl0Tnul7GYo7V64iTCMbHrCSB0IOPhvJ/MrpW
	KmlzEQQXx7cqR73miOOKf29H4X9atsJ1TtTrFUUsG7XW+yCQXHWOYWcBDaUXQ1BHU1HekbfhU7m
	/7DSZdkzA1X7cSh2FraCJ4dt9N8pRi5U=
X-Gm-Gg: ASbGncvoIWTONOXycaB195rB9mcDydFnymFIcvTDABbOhc0hc/69c2YmovJ+tzhy/nn
	uudRmj1PnttkWg2hKt3rBfw5d9JGNZ+AvugTnHianD5z/c+wdDOyFME8H74P6pVndMgy9T13d6J
	V/HrlY75AWdoUWvka857BWd+MdFn3KoHvdfmFepNoCQbJvf5Le8pzsZbaQcGq0LMIUeXS1VFJk/
	ePDNeT98x/NlAgSFA==
X-Google-Smtp-Source: AGHT+IFgKwiFOgQqQN0FCfVDxjtFV9kKSEr5YfBg7mts+Tsgkmr/1LlEg52j+O9rSZ9Whn3nn11QmRnYyJeTW2/nV6Y=
X-Received: by 2002:a17:90b:37d0:b0:32b:554f:320b with SMTP id
 98e67ed59e1d1-32b554f374emr297839a91.25.1756827438796; Tue, 02 Sep 2025
 08:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902055026.617170-1-tweek@google.com>
In-Reply-To: <20250902055026.617170-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 2 Sep 2025 11:37:07 -0400
X-Gm-Features: Ac12FXxi-tbMVaYhJ3coEa-zIt6QnUpEVHuzatvpNZWI0TrXPBQzc-2UkdjvNJY
Message-ID: <CAEjxPJ7Lemixa3Z8ipq+mPfbaBDMGZCLK729A4xswxEW2-2=dw@mail.gmail.com>
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

Just a reminder for the other SELinux userspace maintainers that we
need to wait until we see which policy capability ends up being
reserved in the upstream kernel before applying this patch.
And a reminder of the following longstanding open issue that is
relevant, https://github.com/SELinuxProject/selinux/issues/55

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
