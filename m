Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA5F24887D
	for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749578346; cv=none; b=cydeZJto/ymKlzZsbjDV4lHMLarE85J/Vq8imYzQoFRP5rDvK22hsFnt4P+G2lyA9dov0XgkTb49fRCErxEm34Pd32wRE64+1DFdEN1gzFgMGCiAKwwDyYkBJBZnyQ6FO98IEhLAnZspMgGRkgW0fwNkOrxgzfl7pRRG5YqD/SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749578346; c=relaxed/simple;
	bh=l7dA3JXoBHsGI2AXVfBjSiuqjfn+XlHE3Id393Rj6iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/ck45GP20By8lDl/G4Ih+aHb/+KzZU1n4BrW06uTiGD+29mBW0xhrdyR68OyOnSXatgV5+rj19RD/gWvE8Zcvl9LELXzLqmgSYocovMRD2fviKywXXQv9Hy1EpDxggt9jKsxIqu02IcJ3fbGgbfnJMN3o+kNZ+v56esERW9/D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1Ua7Y4y; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1Ua7Y4y"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-87ec80fc3b4so1973543241.3
        for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 10:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749578344; x=1750183144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D45mii3ZRgygef+/V5sWths0PhNX0QahUhKImPgsUQQ=;
        b=e1Ua7Y4yAo5yRMrCXfrCL3ObWz+O3jo9HdYnuljN78RwCtCJyWaXTVuTsRRNp2eP/e
         LhgNmO3ptMeezKo8bsFeDIlqWE/TKF5uZfupY70XWJS9/jBtatQD77lD3d9fcHEik7DE
         gnRvh+XVpBfXhUYrBYVLjbb5LE0uRGG5fz9B+09YO+qASeEoijud5YMId5P6qKfJnaPe
         cWu81J4G/V1U9qt5YPMfq07jffWZ91LL9xgpv3+wF3GHBj8TiZHIFq9o665C5O0+uJMe
         ffW/VibRCwY8VifcxT1DHX3HVXbVDAGW7+dWmNMKy/w1N9zEdcOQNnxJfLfvVqrfINwq
         rnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749578344; x=1750183144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D45mii3ZRgygef+/V5sWths0PhNX0QahUhKImPgsUQQ=;
        b=OUgG7esXOFdZ9xs0/FX8CJ/PqinZRF124Yhz0Zy3TVjgfjj3lr6z4TYyhRAHVd933F
         FF811fcZykW2P+ib1Z/oS35rIZmgrCb/k/3PEimnVFnt8ajh36bWLmIGBBFKNOGZynDx
         vEGON4BYRNAIiL1EcaakdZaqJ/KxWEgtb8P/abMXok8u6FCXQUc0fBl4sUGpv7gyImbo
         SYZWZe1K/EDVdnS38pQAp0UEA0rSyRryQRLN+qYu7lsG0U89C9VfLprYC04drLByZCgv
         P44TnJSFY5px8rdvwImRxet0/PYea8kTb63J4lB3+Pp3SbAPItr/86lQDlzRrdnu4kyC
         CYTg==
X-Gm-Message-State: AOJu0Yzf/kRmDZr9uiyI/IuZNKlGdQ7+YMlK1aw0RVbIkSAXQ6d3HyzN
	kZfIrapOv9Ni5wnLZfFn74m+lnyddC6Y5H3naTJX4PRdTZsDdy7uXNgVPcepxqsCj20g6mslfTf
	WL/wlJ4sAEQyeeHG/pCuquhd46I9ddfQPBQ==
X-Gm-Gg: ASbGncu+IRFgX89QdYhwriedUJg9nyrRnO5RBDlad8n/9At6l/bj5dX6pwooHsQ0bSu
	4JWVGjET5LY8w6n/ReVhPNxCr3KtrJKZ66/MGRu/ltpcPDnBMeb2Z/qsYjdtTZqxRsdbhBv7fRb
	Nd0uJzfRWmSV55n+tVbuSzIXX8t9Nt9RAu5o6TnOp+qJ8=
X-Google-Smtp-Source: AGHT+IGYfTlxlzABB+1jXIjLww+zb7/zVyoHMvGYd9OYvLUItZUfTp5D9lrbZb+baerIBOx3F6p8TZ3IbpiAzyU1esI=
X-Received: by 2002:a05:6102:2ad1:b0:4e6:245b:cf57 with SMTP id
 ada2fe7eead31-4e7baff535cmr158324137.24.1749578343677; Tue, 10 Jun 2025
 10:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530051322.1678251-1-inseob@google.com>
In-Reply-To: <20250530051322.1678251-1-inseob@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 10 Jun 2025 13:58:52 -0400
X-Gm-Features: AX0GCFsKBHwPakDCT1p_tdrLMaH4eJRSX32fK58F3pZ7B70wCzvBTTBikGOmVBk
Message-ID: <CAP+JOzRCJYUyDZnUeN6VxrX71GBsWunNHxjFS+U-RKtJhFHb8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] libsepol: support wildcard network interface names
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, takayas@google.com, tweek@google.com, 
	stephen.smalley.work@gmail.com, cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 1:14=E2=80=AFAM Inseob Kim <inseob@google.com> wrot=
e:
>
> Add support for wildcard matching of network interface names.  This is
> useful for auto-generated interfaces, for example podman creates network
> interfaces for containers with the naming scheme podman0, podman1,
> podman2, ...
>
> To maintain backward compatibility guard this feature with a new policy
> capability 'netif_wildcard'.
>
> Netifcon definitions are compared against in the order given by the
> policy, so userspace tools should sort them in a reasonable order.
>
> Signed-off-by: Inseob Kim <inseob@google.com>

This patch won't be needed now since Christian has posted the netif
wildcard patches. (Of course, you didn't know he was going to post
them when you sent this.)
Thanks,
Jim

> ---
>  libsepol/include/sepol/policydb/polcaps.h | 1 +
>  libsepol/src/polcaps.c                    | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include=
/sepol/policydb/polcaps.h
> index 1aa9b30a..7bebe4da 100644
> --- a/libsepol/include/sepol/policydb/polcaps.h
> +++ b/libsepol/include/sepol/policydb/polcaps.h
> @@ -17,6 +17,7 @@ enum {
>         POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
>         POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
>         POLICYDB_CAP_NETLINK_XPERM,
> +       POLICYDB_CAP_NETIF_WILDCARD,
>         __POLICYDB_CAP_MAX
>  };
>  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> index 6b28c84e..ec6c902d 100644
> --- a/libsepol/src/polcaps.c
> +++ b/libsepol/src/polcaps.c
> @@ -16,6 +16,7 @@ static const char * const polcap_names[POLICYDB_CAP_MAX=
 + 1] =3D {
>         [POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]               =3D "ioctl_skip_c=
loexec",
>         [POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]        =3D "userspace_in=
itial_context",
>         [POLICYDB_CAP_NETLINK_XPERM]                    =3D "netlink_xper=
m",
> +       [POLICYDB_CAP_NETIF_WILDCARD]                   =3D "netif_wildca=
rd",
>  };
>
>  int sepol_polcap_getnum(const char *name)
> --
> 2.49.0.1238.gf8c92423fb-goog
>
>
