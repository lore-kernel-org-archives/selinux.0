Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F7B42056;
	Fri, 29 Aug 2025 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756469901; cv=none; b=hLf8mjmUQGAknSq24gYfZ42AgUfSmRPKiy58+eXK2kxnih1DYCsCg/Y4Jyo5YYn6YrQErj+LZ8UR2JnF/xKCKonK4QnMcanO+MqZePdcJHYmnVtqwrawb0fF+Xe7GN4AjIwnO1INRIM9TdP8Lrq/dQsxbMIeru5DxyIjyZJ6x3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756469901; c=relaxed/simple;
	bh=BrcdaZ7tDPwr0614C2Zvoa3Tqdzs29IRf/cuSesfPJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cyJAbx3JKVip2IkgMig2Q1h08r4x8SBNg2ExpG9czoRI8oGCVxUzf8plE1mHa0vhJlQGm0LLTH/ofhR2MoboZ2fHDGU1Ce7+bXNWWujlD+CgfFO2BdtEH+sf6t7jqY1Fgf+TY0dUy46Jn1M8xkh6smuARPczIrWGajXfecqdHJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGVyF+l0; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGVyF+l0"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-323267872f3so1850083a91.1;
        Fri, 29 Aug 2025 05:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756469900; x=1757074700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxqdplfJQk0+acm87OC4qYNdUVsH7YBE7+0Bptcz7EA=;
        b=XGVyF+l0Rt4EvkWaSHEuWxJipWpGNke4z5EK0H2he4VLJX2BQXlhGC2Je3afOCCkUf
         v0QbuzgjtZuXefdSBKWOes6vV1cWPmAaqOvHXMy14mp3JbxGALCL3351Dgs6xS9g6TNc
         0U8mzPq1uElkt2hzKihMlA0yuFXmOUZYYPRRlU/Hx3ep22pcsbTrQjypD2eyjE5q1q4D
         iu4cF0R4rGv00KSfSzzD/IGtYTJFmiv/XBucBe+b/oo9mUIjs6Ank12+55OTd3gkFM0S
         6M7jUWO5AiGBCB/NAsZCaXsLPAjtw1FXeZYihatEYCvaV10IkAfmSObOs/QbHW1xqd1n
         8/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756469900; x=1757074700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxqdplfJQk0+acm87OC4qYNdUVsH7YBE7+0Bptcz7EA=;
        b=aYQCx4JjsrqTrT2qAaXOLfcWrpmXRVdilgUpykvr3EW3s8AzciX+ei0CdVBWe5h5aJ
         0y2i+zYAEtNYOt/xpZVfCO/n+n5cZQftfRB3P1cvWWaOUX6NSxWxtf+BsY+Fj3fJmvKd
         EJT6O4szgs5WzDjeshxSwzuU7iWjJprj9YdMBWRFS/o513Tz25mmFEiJECp5TQ6/v2gZ
         5TydCK0SDTUety9TUQY83kjgB5/n07UdvjqCHfJWCJo1mRb1b7W/NIo2yrUPEk3oqzqp
         MCuyal8hl7DloRqP7F77qEE8wFcKKLNTSAQlWZMDo3zONcolk7MvhjkrINDqQ+HIyn/V
         nKjA==
X-Forwarded-Encrypted: i=1; AJvYcCWiO1proJXx2QjzJ1VAcgssT5Z9JfUJhmKJD1f8o1TGF2X/+Ujt/ecKhnWONAsBUim50S1PzNmQpQ==@vger.kernel.org, AJvYcCWwOGDgKbFQPwt7kHlIe/Ra7SL/xk+fcE+FovbOWdXm+7nTMgZySWL3mH7TpZ9LnYFumzATuxgyuppW/sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJo81C2MkYzEAHAeGX0M2YHogpCXJkrN0Q8SR0ed46El41ubHv
	6OmHj1a5qeYuuXpr7eelcG1VrrDOyd8qSkIo3mPXMKQ+qK5N+afKkWO4qAcTWOmnoGTD7XBBMZg
	tfo40OTpahrAzFwDpa7IopL+EfJDYTBrHmw==
X-Gm-Gg: ASbGncvFwAF/Rtrhk9zDmiZzx7yczQI62KyaDST10pOhTLHkKg5SokeFHCoigdEMy8v
	bUbJTPu1AfsKygQsAXD9CR4pTuTBSOVqYUTJAA/OX+H5bUqg1O0NdFfRZnXessFc1D3wnq/CEa2
	irHfJJr4WSBJ3sHKe2r2FrSsRlvAaKuOyR+v2LKZUeVqbcBk2iHlA2V8/ZE8YJZPSDDx72mjVRK
	KmRAzs=
X-Google-Smtp-Source: AGHT+IFjN3TO8wxEPMhEA6GEJ2LrAEBikAiNtmvBiY06UmbUFn3yOiaj8IH7V5Db7/4H2uMg7Jd94XFwXEmG4tiJ+eo=
X-Received: by 2002:a17:90b:3890:b0:327:f37e:7af0 with SMTP id
 98e67ed59e1d1-327f37e8eedmr1773061a91.21.1756469899559; Fri, 29 Aug 2025
 05:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828170317.2322582-1-nkapron@google.com>
In-Reply-To: <20250828170317.2322582-1-nkapron@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 29 Aug 2025 08:18:08 -0400
X-Gm-Features: Ac12FXxTLGujFcJMocZkADU85ZRVqDyl3oPEsWLbQQuZktplkFCpcsc-evtb_b4
Message-ID: <CAEjxPJ7-M5OAiTLmOynP36HF6XmJKhH2kTFAGmhg8ohCkZuT8w@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: enable per-file labeling for functionfs
To: Neill Kapron <nkapron@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, kernel-team@android.com, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 1:03=E2=80=AFPM Neill Kapron <nkapron@google.com> w=
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

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

As before, don't rely on the policy capability bit remaining stable
until Paul merges this patch.
Also, not worth re-spinning IMHO but the changelog below normally goes
after the "---" before
the diffstat so that it doesn't get included in the commit message
since no one cares about
the in-submission changes once the patch is merged.

>
> Changes since v1:
> - Add functionfs_seclabel policycap
> - Move new functionality to the end of existing lists
>
> Changes since v2:
> - Sending as separate patches
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
