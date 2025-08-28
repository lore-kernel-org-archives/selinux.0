Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F9915B54A;
	Thu, 28 Aug 2025 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386541; cv=none; b=uBKa3jGsz/jeJTVmUVS2bwFWrH6BQzwuAjyrMHn2wIVlxff8uWsrAdIaBd9nmOflhU7jw9DyoBfF5eFNE4ChNtZwjbmGgOsYzJG7QUS5+snW8z66RD66B0T+XGIhtgFq25fRexzCBBnq5x5BMJI8wwbt8bBbe4uTB9829a87bdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386541; c=relaxed/simple;
	bh=iJxkRNGF0qNm2/a68HQMqhq5i3qJlyN1dJGOak8lZhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfzgwMdGbz6UeCUzUKCXdNDLjolAlZL2PSgud0jJ9bqYAXFaRvWfb9u2gvfVHsxf0KixbS0lbN/PEspKAQ+yNrct9tqz2AZ0FChJFEP/aq/bI48d0X/v2FvwaUo/T0080bHtUlwXjSU2ONL92Pd9gurl/mT9SxKRXgxHmfsLeH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgbQn/FD; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgbQn/FD"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-327771edfbbso971736a91.0;
        Thu, 28 Aug 2025 06:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756386539; x=1756991339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvhomtO4DwakeG1+rtCtiLjt0uJV+P5XvM8piJEihZg=;
        b=TgbQn/FDmwauMY0I1FgmuX4yaC8RvJB9SRZjOF1e4oRtHiT6chzs7zN9+gFsXDlyu7
         dQOsXcsW3awYsuorFgwTbtZBBQpHaJ2GQxDKH4xtHEt983rDlbrLMiX/Af0xeu1+/kgq
         fQSox80XpB8hYlQkshFtlM5SebFB0eUm2xRrzrSTcNtDvu6N+gMQ36+xJLzqubAXGJh0
         CIY4TeofDuMwuWL3U4ivdA8bcHfKviYYn05X8Ovvwaxg6z3xa+Ojw6MprQ4OdGLKs161
         CA5j5G/ouemXmpJ8Bbv5PHBV4Cm/LIbTD0W33i9ClXCTz0QoFMXtC0nFJf4HLQWg+8JI
         oxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386539; x=1756991339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvhomtO4DwakeG1+rtCtiLjt0uJV+P5XvM8piJEihZg=;
        b=H9ZEa8f+qsq7W3bn4pircMJCxI3MYpMDMxXHVHLCHT0VIYtll5SPOcrf+TdK2Fi+cI
         MbksDhRe2MmSbAqIjTZ3hVju6XSGBu77cOHSQ3q54PeDuIin3bmXQYpegpqcJmYT6mFD
         hg6z4Io3Y0549eSBOfQv78GxSpSCmMjQbgtKc+J7Sb4rqJZ5mTOzGfICqXKShA25I3Zd
         xN+93gUZ79acIdJNnxOLRlpMPe1JxCsoG3tAwBKAn0PiMTYZdxu1B6HC3HBrxMQMzPrV
         Ih+Swv3TZz/zVg88lkkF6PyWL/ZKhRGn40cex7bmkc7Z+/8CGdaYqFVlBNcwMKeS2I+g
         DzhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYuFqJvfu8Pj19l9R8Ok4CMpaTpHERFHyVgSTXohO/7QXFsHh++CxkHKsWXkEiunrB6NczDOH3Xg==@vger.kernel.org, AJvYcCXim6oHArX4q2xxQFUbK50yBAsZp2+njy0417oteUnYqHHoXnW2JbLWjYBch4HwAC5Pafug7V6xWWjV+Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzM01IbZC1BXyuVZ/oLjjXzbGcqceYs8K6H3EjpBOe9mHwRid1
	gg5pE+fGh0Uajtv3tH+LbN+845UR6ojKE/38RHgr63GNm6Xs+WpKXJjdXcMhB78b1TyDSqAVSSr
	0yNeQnRrvVOKsGz3Y9nBNKYXmqDl/Hpg=
X-Gm-Gg: ASbGnctvVM6b8hzdg1Jzr4yHUbM+5IBrsZSuU1pbnDGuvVdK4/JgiRcwsNzhRxg2zJX
	wbijjYtqTb6uW5NMOYoOioo0n3OMKck/8RPz/KC8TvELR2tyPcLYHPhQf9OHr1BaqcQXWKy5Lq9
	o1HTCw2Pnt3Vi0RC0S4LqOaj6OOMCkH+LO1SOs2BkHvcy6Gyt8ekf48Vb1BzPyj1xMNP+RrJVut
	fLQiyw=
X-Google-Smtp-Source: AGHT+IHKOQI4wq68UTSVfowK93Ay2Usq+Z4cugsDDMakFbw6QbzKTxxqLjIN0VmU4V1nzpF+Wbvnm01f1s6+k/FamA0=
X-Received: by 2002:a17:90b:180b:b0:327:ced1:26e2 with SMTP id
 98e67ed59e1d1-327ced12a9emr628290a91.18.1756386539327; Thu, 28 Aug 2025
 06:08:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827222224.1648500-1-nkapron@google.com>
In-Reply-To: <20250827222224.1648500-1-nkapron@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 28 Aug 2025 09:08:48 -0400
X-Gm-Features: Ac12FXyuN1Byx-wSgubWxpD86t3QKFNyAnpuKSQ6RHk1qhXNp667qnH7glyoWro
Message-ID: <CAEjxPJ4QKnzgoSYgfy8+CqjRigEbW7=B5t4fO4djbO5GnLtCOg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: enable per-file labeling for functionfs
To: Neill Kapron <nkapron@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 6:22=E2=80=AFPM Neill Kapron <nkapron@google.com> w=
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
> This patch introduces the functionfs_seclabel policycap to maintain
> existing functionfs genfscon behavior unless explicitly enabled.
>
> Signed-off-by: Neill Kapron <nkapron@google.com>
>
> Changes since v1:
> - Add functionfs_seclabel policycap
> - Move new functionality to the end of existing lists

This isn't actually a multi-patch series for the kernel, so don't use
the patch 1/2, patch 2/2 notation since that confuses b4 (it tries to
pull in the 2nd patch for libsepol and unsurprisingly that won't apply
to the kernel). Not sure that warrants re-posting (defer to Paul). The
patch itself looks fine to me but we now have 3 pending patches each
of which is trying to claim the next available policy capability bit,
so we'll ultimately need to de-conflict for upstream merge. Otherwise,
you can add my:

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/hooks.c                   | 8 ++++++--
>  security/selinux/include/policycap.h       | 1 +
>  security/selinux/include/policycap_names.h | 1 +
>  security/selinux/include/security.h        | 6 ++++++
>  4 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e474cd7398ef..333bb6cba25e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -476,7 +476,9 @@ static int selinux_is_genfs_special_handling(struct s=
uper_block *sb)
>                 !strcmp(sb->s_type->name, "rootfs") ||
>                 (selinux_policycap_cgroupseclabel() &&
>                  (!strcmp(sb->s_type->name, "cgroup") ||
> -                 !strcmp(sb->s_type->name, "cgroup2")));
> +                 !strcmp(sb->s_type->name, "cgroup2"))) ||
> +               (selinux_policycap_functionfs_seclabel() &&
> +                !strcmp(sb->s_type->name, "functionfs"));
>  }
>
>  static int selinux_is_sblabel_mnt(struct super_block *sb)
> @@ -741,7 +743,9 @@ static int selinux_set_mnt_opts(struct super_block *s=
b,
>             !strcmp(sb->s_type->name, "binder") ||
>             !strcmp(sb->s_type->name, "bpf") ||
>             !strcmp(sb->s_type->name, "pstore") ||
> -           !strcmp(sb->s_type->name, "securityfs"))
> +           !strcmp(sb->s_type->name, "securityfs") ||
> +           (selinux_policycap_functionfs_seclabel() &&
> +            strcmp(sb->s_type->name, "functionfs")))
>                 sbsec->flags |=3D SE_SBGENFS;
>
>         if (!strcmp(sb->s_type->name, "sysfs") ||
> diff --git a/security/selinux/include/policycap.h b/security/selinux/incl=
ude/policycap.h
> index 7405154e6c42..135a969f873c 100644
> --- a/security/selinux/include/policycap.h
> +++ b/security/selinux/include/policycap.h
> @@ -17,6 +17,7 @@ enum {
>         POLICYDB_CAP_NETLINK_XPERM,
>         POLICYDB_CAP_NETIF_WILDCARD,
>         POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
> +       POLICYDB_CAP_FUNCTIONFS_SECLABEL,
>         __POLICYDB_CAP_MAX
>  };
>  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> diff --git a/security/selinux/include/policycap_names.h b/security/selinu=
x/include/policycap_names.h
> index d8962fcf2ff9..ff8882887651 100644
> --- a/security/selinux/include/policycap_names.h
> +++ b/security/selinux/include/policycap_names.h
> @@ -20,6 +20,7 @@ const char *const selinux_policycap_names[__POLICYDB_CA=
P_MAX] =3D {
>         "netlink_xperm",
>         "netif_wildcard",
>         "genfs_seclabel_wildcard",
> +       "functionfs_seclabel",
>  };
>  /* clang-format on */
>
> diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
> index 7f19972f7922..0f954a40d3fc 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -203,6 +203,12 @@ static inline bool selinux_policycap_netlink_xperm(v=
oid)
>                 selinux_state.policycap[POLICYDB_CAP_NETLINK_XPERM]);
>  }
>
> +static inline bool selinux_policycap_functionfs_seclabel(void)
> +{
> +       return READ_ONCE(
> +               selinux_state.policycap[POLICYDB_CAP_FUNCTIONFS_SECLABEL]=
);
> +}
> +
>  struct selinux_policy_convert_data;
>
>  struct selinux_load_state {
> --
> 2.51.0.318.gd7df087d1a-goog
>
