Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C30315761;
	Thu, 21 Aug 2025 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781205; cv=none; b=DMOr2Ez6aLg4sOlx8t2ODglJTFqqW7ehUhgPoj84LwjGEzJnjGdViSV90gd9S5mI8/gqPtHF+eVEAB9/ddqO58jesLJTlvwyZOjmD7hjD5F9/dTq6NBoND1OMGy6JD+57TgXIsoAXl12llY1uYqjgRf1GpaM4MwKnxj+dF/tIJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781205; c=relaxed/simple;
	bh=4KrfimWBNwAtJPyUf+qP1dpHV5DKSwK8yzQl9Mt3TFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6GxhQA3c52dY3y2S2vM1clcwwhofuWPertwprJL2kM8mRkEtYiBwlF97sFArCiCHGHa8x23qKmHlWHHBLaxK2FqSl2ez4p/gpjlYx4UGWftoj6gw8V1gmFZzmzX2CPvv9TqVzCLHb7drP4Dt+0zjb3QWTTkK4w3NeO8K6jW2rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blyoPFAt; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blyoPFAt"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-324fb2bb099so424926a91.3;
        Thu, 21 Aug 2025 06:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755781203; x=1756386003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=porHcg3o+CIlMILgXPZ+Bm8oPIC1CRCMt8yqWjRC8KA=;
        b=blyoPFAtzrBpHiPnB5let5tRC8pEgUglXHugS/Jxuhen6ccb6HCEcPz+na5QKz8kK2
         NGSvbE9ocDTJ59YDxidQnVk06FtK0yK2XUhZtjbnfy0iR2XtURi2wEAOqwgkpYTVjxfo
         OlN6LnNazXXbGzglYhh3upaLCnPUwW9hwFWIis/RZwFsKcpm+tYrmBku67kmgSi16WCt
         RgQR3/T/YmQ7vm7SJb92IoD6jZZiD39uLrsoCv0aRGWZsPfYYyBpfN54CxkeRyS/zjGj
         /p1WjJT4uGdItkWmLF1tbzBP/qVgfNaxU6ggVxoRAqjxrTgBUB5l6PAvhtabLxsSkOcI
         VESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755781203; x=1756386003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=porHcg3o+CIlMILgXPZ+Bm8oPIC1CRCMt8yqWjRC8KA=;
        b=J+uwFpkNPPtTpH9e1yHXjIloDshoIQ7xPHSw0FeDNYqvVonEprXtD5f8E4TT2JrlsJ
         kIKepIZ9u+f0pj7WSGHTEhwQOLoBGhltdJn+CRQMVHAdu98iYzv7JPZZKbcMi8qmdqff
         RRMX0r6FFN5IWHitJJVWxHdXV1Jr81MmhKYB+Q57tfJ9tO8J2NlqaDWq3VRz6IUmDY1n
         9kH1pTEl/p3ndsapROHQKHs/yg0KaG685mTIQ0DoaGv2Q2MTZscEevJZKPbufasEL1HE
         VHEaB/MrrElrc0JgHZmnhe2Q96qGPQ2fr1j5ZpDgAhkjuPr8CIpzZO5uEACeY1qlSjKB
         9aLw==
X-Forwarded-Encrypted: i=1; AJvYcCUsDDfPmsmbQPHerTzYNDShiYsc9qOEKHFOUSx0NlG6a/ePShrQzK02bXHqCCRZqn8bNlSYrJZINOHGxI8=@vger.kernel.org, AJvYcCWiYdxLmLfi0XOd5T33ZF+o79ko94jDHpKI5Ebd1EtVo2DXyzAgaL0yKAYAn7p/xuVPwQRdyLkH3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzN+QFDuGmilb+TF3rTjkmSHsXVGIA9BICh7mqLWEgPGMaMU3Iz
	b0jUxMhPl1GAZXeMrMF4EjR/gOsPSUb9NM4Tj/GnqHQFFDgU6XWbq+GWZF2/OZDhF4hPcTWm8im
	t4thFID1/6YEhRuy8Ww8cSVrscPvBaYI=
X-Gm-Gg: ASbGncs+t/MLT8dSdYB2LQRtQ+Agjxj62FHBXXRiOTZ+RFe2JH3It8hl9gfU+2seT18
	bDG+zJ19HtgqCyFALVFHpqQsMdTVsHJusDz2FcUuRldoOXrkp0YxxV9WCEXDykwNNE/wh9hqmRY
	2pKAAMgl7+MzJnsVb1aSnkgj/Pv1Qbougtmo4tOm9mMWO9VbHtYd258JyNv3k8gTw7zLssGM9Af
	7mOQWQ=
X-Google-Smtp-Source: AGHT+IGhfF7ZuE01O8iuJxPeUZxW4tnDVFdj7yiQ0fXUgOVpDWzyJZ6B2kePNFYCIjZ1J5z94V5nPCW/1PVlqBK8OL8=
X-Received: by 2002:a17:90b:1cce:b0:31e:d4e3:4002 with SMTP id
 98e67ed59e1d1-324ed0d6fcdmr3057651a91.2.1755781203014; Thu, 21 Aug 2025
 06:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820212302.2325779-1-nkapron@google.com>
In-Reply-To: <20250820212302.2325779-1-nkapron@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 21 Aug 2025 08:59:51 -0400
X-Gm-Features: Ac12FXy53CXh_ByAd_wEhfKRh7orVilBeqNXVQCpecz66dlkirgVwdHriDPCuE0
Message-ID: <CAEjxPJ4Vi9rXXkvPUoS-tjHks_6oevdkhrjvSeX_Rh5VV5gBBw@mail.gmail.com>
Subject: Re: [PATCH] selinux: enable per-file labeling for functionfs
To: Neill Kapron <nkapron@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, kernel-team@android.com, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 5:23=E2=80=AFPM Neill Kapron <nkapron@google.com> w=
rote:
>
> This patch adds support for genfscon per-file labeling of functionfs
> files as well as support for userspace to apply labels after new
> functionfs endpoints are created.
>
> This allows for separate labels and therefore access control on a
> per-endpoint basis. An example use case would be for the default
> endpoint EP0 used as a restricted control endpoint, and additional
> usb endpoints to be used by other more permissive domains.
>
> It should be noted that if there are multiple functionfs mounts on a
> system, genfs file labels will apply to all mounts, and therefore will no=
t
> likely be as useful as the userspace relabeling portion of this patch -
> the addition to selinux_is_genfs_special_handling().
>
> Signed-off-by: Neill Kapron <nkapron@google.com>

Did you confirm that functionfs is safe wrt genfscon-based and
userspace labeling, as per:
https://github.com/SELinuxProject/selinux-kernel/issues/2

Also as per that longstanding open issue, we'd welcome patches to
generalize the current hardcoded list of filesystem types to
instead lookup the filesystem type in the policy to see if it should
support genfscon and/or userspace labeling.

> ---
>  security/selinux/hooks.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e474cd7398ef..54b82c814b4d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -474,6 +474,7 @@ static int selinux_is_genfs_special_handling(struct s=
uper_block *sb)
>                 !strcmp(sb->s_type->name, "debugfs") ||
>                 !strcmp(sb->s_type->name, "tracefs") ||
>                 !strcmp(sb->s_type->name, "rootfs") ||
> +               !strcmp(sb->s_type->name, "functionfs") ||
>                 (selinux_policycap_cgroupseclabel() &&
>                  (!strcmp(sb->s_type->name, "cgroup") ||
>                   !strcmp(sb->s_type->name, "cgroup2")));
> @@ -741,6 +742,7 @@ static int selinux_set_mnt_opts(struct super_block *s=
b,
>             !strcmp(sb->s_type->name, "binder") ||
>             !strcmp(sb->s_type->name, "bpf") ||
>             !strcmp(sb->s_type->name, "pstore") ||
> +           !strcmp(sb->s_type->name, "functionfs") ||
>             !strcmp(sb->s_type->name, "securityfs"))
>                 sbsec->flags |=3D SE_SBGENFS;
>
> --
> 2.51.0.261.g7ce5a0a67e-goog
>
