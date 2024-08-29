Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28FA1B1503
	for <selinux@vger.kernel.org>; Thu, 29 Aug 2024 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935858; cv=none; b=QhUc4gABRK2j+aHTm+AJ25uiBsaSYR19eNcANln7GFcbDnKaRb3wZZLI+SlRO8Aq8T+z6wZ8Oam5zudvf+yXzwamzA5+ct8xetfQY8ujPPcKzj3ZENOGEDfIQ+tGqyyrIzNVvILq/KI1J8FRkW4+yKPtXLx+2Z0UUeu9Gkn4g94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935858; c=relaxed/simple;
	bh=SPeizuJOwiJmwGKcjweRIsjTiMGm7yI69MiXhAibrLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIjhpgb+nQSsXGvDefmPiCyiLBuQqg952yWMIuQVzNySD+aAgxXLpzoOT19qsaWh7+BVqoHNKn7fY3dD1oT2RdlQRDMExbD728VnUtQ7XDYDrOnDX8V6dFr2Q06i2Yegpnyp47c7nCVgKWRZwPpzxr43LxoykkILWqEr0gGeKnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOPT5jw9; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOPT5jw9"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3df02c407c4so345201b6e.1
        for <selinux@vger.kernel.org>; Thu, 29 Aug 2024 05:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724935856; x=1725540656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKKXUyRho1uDjOytwh4sxPYXXnLCjdUyRmDN7RlODXo=;
        b=OOPT5jw9+5y8/4fvkscYSfA3RC8rLw93XWoUviSn9OpQPsbD5VDFHy37ZrTbWGaqsd
         UHw8P7O53+xzX6V1wZN1SQLNDSchzzlBEeAB8hcYtDUhMQpkZ2jX0/c7WOUr/zrSYItW
         skI0HrkKHIvEFnS6Fl4pczFNckbxkRV73zU9o5cJyVo7eZhV0FXUiFNj1jTrXkCSBb3g
         Jxqm7p33WJI3j9xpkJt3XKV8tN0r6AujBBLjnZbr51GVDhHxP6dWH2M70YA+/nHJdA5o
         qrN4AEPiA2IaqUkgjSDH5VuEY3TG2FHpMgvXhEnBmgUt4SV78APTroqwODjY6UTwyH6m
         xNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724935856; x=1725540656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKKXUyRho1uDjOytwh4sxPYXXnLCjdUyRmDN7RlODXo=;
        b=L8htkx2MLWoKSUxSgtnsGHUcPsXGBFhK4ndfSdRI9UHEbK+ZVr4iRKcKzJdJvyAGdK
         boXV6YIL36p1K4+0jRKLBwu1lH9wHhAuoQdR6JH0IrGwOPgL4kj2l78hZynyfH1t95/v
         in4GRkLrSR/UTY/Fuyz/dskhdPdSdsZwgt3HhLSjf3fXRweG6XzJWVkkxfWKbVzq4g6X
         /GWOtEsiTiWU+TXukSHY13v+qjBcW7G1S2vyqGEcsHYwjKMNS1h7cS6ugyxmul4DpAyd
         W0qRR/9zuOZb6AJrq0Qau6UXEk4R/9YKQJUDjARFiUi4I0FB1LGfWD4inMRUQ0LMTf5X
         DTNw==
X-Forwarded-Encrypted: i=1; AJvYcCVF8ZoUARWs4RTLbYlzDNCGBv5TCTHLF4lNaMTMuIG5s/IbUhneLgiQqW0EIMo2Fb0YAXc87I/P@vger.kernel.org
X-Gm-Message-State: AOJu0YzrF56CFqrDG0kYHiILxedcxBG1bfywSAgigRhbVygoco3URyix
	6oK2giftQYj/RYP8PZPpSTBgv83/R3zDf51gjqg5gGKi8gL9U8SFDMAQjCng0kVCEd4Mw88R32Z
	1fCjtBFyj/rgiGHdFeV8HrE4p2j8=
X-Google-Smtp-Source: AGHT+IHttym0JnXYI41uVNOBGF+3lsqKqW9MEhCgDikZWJ3DlVybRJTpOkunfim1eQtuW1+0jOESFmbcjRVJVg1oh7c=
X-Received: by 2002:a05:6808:f08:b0:3d9:22c5:a1d7 with SMTP id
 5614622812f47-3df05e4a904mr2744352b6e.45.1724935855627; Thu, 29 Aug 2024
 05:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822003757.1998016-1-tweek@google.com> <20240822003757.1998016-3-tweek@google.com>
In-Reply-To: <20240822003757.1998016-3-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 29 Aug 2024 08:50:44 -0400
Message-ID: <CAEjxPJ4ruovTZxTpQ1hvT_knrZxSBj2dVEtOwvZe7hH-8DdWSQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] libsepol: Add policy capability netlink_xperm
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: paul@paul-moore.com, brambonne@google.com, jeffv@google.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 8:39=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
>
> This capability can be enabled to change the kernel's behaviour and use
> the extended permissions for netlink messages.
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsepol/include/sepol/policydb/polcaps.h | 1 +
>  libsepol/src/polcaps.c                    | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include=
/sepol/policydb/polcaps.h
> index 14bcc6cb..1aa9b30a 100644
> --- a/libsepol/include/sepol/policydb/polcaps.h
> +++ b/libsepol/include/sepol/policydb/polcaps.h
> @@ -16,6 +16,7 @@ enum {
>         POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
>         POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
>         POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
> +       POLICYDB_CAP_NETLINK_XPERM,
>         __POLICYDB_CAP_MAX
>  };
>  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> index 8289443a..6b28c84e 100644
> --- a/libsepol/src/polcaps.c
> +++ b/libsepol/src/polcaps.c
> @@ -15,6 +15,7 @@ static const char * const polcap_names[POLICYDB_CAP_MAX=
 + 1] =3D {
>         [POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS]          =3D "genfs_seclab=
el_symlinks",
>         [POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]               =3D "ioctl_skip_c=
loexec",
>         [POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]        =3D "userspace_in=
itial_context",
> +       [POLICYDB_CAP_NETLINK_XPERM]                    =3D "netlink_xper=
m",
>  };
>
>  int sepol_polcap_getnum(const char *name)
> --
> 2.46.0.184.g6999bdac58-goog
>
