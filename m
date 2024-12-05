Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F79B1DE2A5
	for <selinux@vger.kernel.org>; Thu,  5 Dec 2024 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733392395; cv=none; b=kQ9Ay8dEnZt4uQufyGOg0tvYB1/gXrZ5HPJvxCVcEPUUrrpf8tVl5SaM7khGKtyUdQJOTPJYjyrjWn88d4l7MU0OQjL0usEP4ipnsdvv3T8ILOWYOpkgMvJaTmqiMPAPEHg9XKtL7aDsO1XAF6n+HbjHLRKNzGiV+Os5mH5M0k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733392395; c=relaxed/simple;
	bh=cBPPSHf1OwNa+KsxQUPUt8mrSzhf6LIVJq5T0OERZWc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=O2+NsP+1z2ESoWbmvB3fTsbvD/czr6iIFxjA552Dltlc2ClhX1wfbxT0TI7U+YHveyIUs4VIvzcvN0gLuMWzkYmHxhmnPOXvf90POX53A6i0ln8a4bVG2VZzSlQ2VfQ5eUYSXSZaKAZDu0tdrkCXoW8owctuv4gqR5a4Tbb+JaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=AIeYw/VP; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AIeYw/VP"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5ceca0ec4e7so784076a12.0
        for <selinux@vger.kernel.org>; Thu, 05 Dec 2024 01:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1733392389; x=1733997189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBPPSHf1OwNa+KsxQUPUt8mrSzhf6LIVJq5T0OERZWc=;
        b=AIeYw/VPnvH5c42wuUP4ag3/M94QAxkp0ctZDC0nAq2MqrI4MGKeKliQUQCxLTqbtz
         iumpoqvtRgAn05j5/WT7XebG3j0U3ReH5VxwzB42oJxRem1LB6escIeIDsAXi1dDb0vN
         TL0BoY0d0vBtbYuq/3tknSEycEzaEh0NqvEi1RKpWi3X+N+2oSlg0lBHmQWAIkxx6SFU
         rQZEjhWGcM30n/3JdlEs2BQ9iIcb6xIN6WdoTFI9ce3RdVZ7ApBX1YYc8bu3z+kbUa3E
         eflxTyb4myx/MZmQyRB82xFwzDr+nsRB493FidcNtDJzl9red0Cn7nkvARa5s5tpaiTu
         TfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733392389; x=1733997189;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cBPPSHf1OwNa+KsxQUPUt8mrSzhf6LIVJq5T0OERZWc=;
        b=S84NLS9ucs+Zs7qQ+zkPs/CozgDdrmbbjtm9jHsXQsn+bXnUfluhsIZi3IguW/9nOf
         GnV8dmf21KAswaxk+ReI1sXadWWMKL9p9LTidrDLPjt0c0GqmtsHu7oUhh2ieLidpRln
         aRjxHKXWWe/bDVzORa6veuQZ3hFZn9C26XnRuiGIM9uF2mOM79WBmFZM+oHIA5lcluhB
         1hnJfADJuzxjqczT2Ey5IvssqSAjICQtTOIF6w6pczmoL/6jXvvTc1i49qm3HXPXVYGu
         8SZjs1V0bIB32wRYc1wqSN8Rhcg4iCLet8dIulTyoioKtzc6cOGdWnn/6iqS7A5QvOCs
         0b/Q==
X-Gm-Message-State: AOJu0YxxS31onFmSNnkNl5p1Gh3HNwEFSshgA0P0gb92RA8ZEl1t6tDv
	VbOQHyTnhKuaplDi+V/jRe8PfnE8qRv9sCj7R9w4oV8FQwrFDN00
X-Gm-Gg: ASbGncuoopFGDFt9VDHhBK3jaM/r3fzMP4RGfWoNNQatCWQ3n2Zz1E0sSXnmVrwRH6A
	B8DCzPwjm9dpWLn7scLOzrlPfuozl2WsV4PP5K8utjeTLm5JB5bMjnwANqA84ZnUNREI+AtpukM
	ukl3Qnwcd0MNbKj3aZFzWQC47NKecZmYUXGKq5rnIxCDuHsSupM+VgUKoyhL8BIhujdsPJ5c0jw
	GODdj9XmJXazcjqdgaQJD9CISBUcpnJZMt8dqQ31opkMt68UMihWPDUHWZLLN1A924P8gr0JZqX
	2c8FE17P3D2kDElkFOIrX7wjTkOG
X-Google-Smtp-Source: AGHT+IFGhBQEzR9pF4ORY2T4fHZfdcKhf18N+Z10vszQfpkBCt0iOacwGl9PzmkXnOShyPkju9EceA==
X-Received: by 2002:a05:6402:2553:b0:5d0:c9e6:30b9 with SMTP id 4fb4d7f45d1cf-5d10cb4f1f1mr9054394a12.3.1733392389320;
        Thu, 05 Dec 2024 01:53:09 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-001-142-186.77.1.pool.telefonica.de. [77.1.142.186])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b608bacsm580763a12.38.2024.12.05.01.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 01:53:08 -0800 (PST)
Date: Thu, 5 Dec 2024 10:53:07 +0100 (GMT+01:00)
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
To: Takaya Saeki <takayas@chromium.org>
Cc: selinux@vger.kernel.org, tweek@google.com, nnk@google.com,
	jeffv@google.com, Junichi Uekawa <uekawa@chromium.org>
Message-ID: <206b1563-c3c3-4e6c-b7b8-da1d44640772@googlemail.com>
In-Reply-To: <CAH9xa6dmxzcooYYya5kH=KwfhhKUJSq9LYVKiwxj1sxsDB3h-w@mail.gmail.com>
References: <CAH9xa6dmxzcooYYya5kH=KwfhhKUJSq9LYVKiwxj1sxsDB3h-w@mail.gmail.com>
Subject: Re: [RFC] genfscon wildcard support for faster sysfs labeling
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <206b1563-c3c3-4e6c-b7b8-da1d44640772@googlemail.com>

Dec 5, 2024 09:53:33 Takaya Saeki <takayas@chromium.org>:

> Hello SELinux developers,
>
> I propose wildcard match support in genfscon to improve sysfs labeling
> performance, and I would like to hear your opinions on it.
>
> Currently, labeling numerous dynamic sysfs entries (e.g.,
> `/sys/devices/pci0000:00/0000:00:03.1/<...>/0000:04:00.1/wakeup`)
> requires either listing all specific PCI paths in genfscon entries,
> which are hard to maintain, or using slow regex rules in file_contexts
> with restorecon. On our test device, `restorecon -R /sys` takes 2.7
> seconds with regular expression rules.

Out of curiosity: can you give libselinux 3.8-rc1 a try, which might/should=
 improve the runtime?

> Wildcard matching offers a good balance here. The patch below allows us
> to avoid the slowdowns of regex while keeping genfscon maintainable for
> diverse hardware.
>
> This requires defining precedence when multiple wildcards match. I
> suggest prioritizing longer matches, which is the existing behavior. For
> example, given the rules `/sys/devices/*/wakeup` and
> `/sys/devices/*/wakeup/*/uevent` (note `*` also matches `/`), the path
> `/devices/LNXSYSTM:00/PNP0C14:01/wakeup/wakeup57/uevent` would match
> both, but the second rule would be applied. Users can control the
> precedence by writing concrete parent directories.
>
> There are also cases where multiple rules of the same length match
> against a path. To remove this ambiguity, we can document the current
> behavior that the first matching rule in the genfscon file takes
> precedence. Users should not rely on this rule but should specify paths
> that are concrete enough, though.
>
> I'd appreciate your feedback.
>
> Signed-off-by: Takaya Saeki <takayas@chromium.org>
> ---
> security/selinux/include/policycap.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 1 +
> security/selinux/include/policycap_names.h |=C2=A0 1 +
> security/selinux/include/security.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 6 +++
> security/selinux/ss/policydb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 56 ++++++++++++++++++----
> security/selinux/ss/services.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 +++--
> 5 files changed, 66 insertions(+), 11 deletions(-)
>
> diff --git a/security/selinux/include/policycap.h
> b/security/selinux/include/policycap.h
> index 079679fe7254..2b4014a826f0 100644
> --- a/security/selinux/include/policycap.h
> +++ b/security/selinux/include/policycap.h
> @@ -15,6 +15,7 @@ enum {
> =C2=A0 POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
> =C2=A0 POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
> =C2=A0 POLICYDB_CAP_NETLINK_XPERM,
> + POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
> =C2=A0 __POLICYDB_CAP_MAX
> };
> #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> diff --git a/security/selinux/include/policycap_names.h
> b/security/selinux/include/policycap_names.h
> index e080827408c4..17e5c51f3cf4 100644
> --- a/security/selinux/include/policycap_names.h
> +++ b/security/selinux/include/policycap_names.h
> @@ -18,6 +18,7 @@ const char *const
> selinux_policycap_names[__POLICYDB_CAP_MAX] =3D {
> =C2=A0 "ioctl_skip_cloexec",
> =C2=A0 "userspace_initial_context",
> =C2=A0 "netlink_xperm",
> + "genfs_wildcard",
> };
> /* clang-format on */
>
> diff --git a/security/selinux/include/security.h
> b/security/selinux/include/security.h
> index c7f2731abd03..ccd80fb037d5 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -201,6 +201,12 @@ static inline bool selinux_policycap_netlink_xperm(v=
oid)
> =C2=A0 selinux_state.policycap[POLICYDB_CAP_NETLINK_XPERM]);
> }
>
> +static inline bool selinux_policycap_genfs_seclabel_wildcard(void)
> +{
> + return READ_ONCE(
> + selinux_state.policycap[POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]);
> +}
> +
> struct selinux_policy_convert_data;
>
> struct selinux_load_state {
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index 383f3ae82a73..959e98fae3d5 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1090,29 +1090,59 @@ static int context_read_and_validate(struct
> context *c, struct policydb *p,
> =C2=A0 * binary representation file.
> =C2=A0 */
>
> -static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
> +static int entry_read(char **bufp, gfp_t flags, void *fp, u32 entry_len,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 buf_len)
> {
> =C2=A0 int rc;
> - char *str;
> + char *buf;
>
> - if ((len =3D=3D 0) || (len =3D=3D (u32)-1))
> + if ((buf_len =3D=3D 0) || (buf_len =3D=3D (u32)-1) || (buf_len < entry_=
len))
> =C2=A0 return -EINVAL;
>
> - str =3D kmalloc(len + 1, flags | __GFP_NOWARN);
> - if (!str)
> + buf =3D kmalloc(buf_len, flags | __GFP_NOWARN);
> + if (!buf)
> =C2=A0 return -ENOMEM;
>
> - rc =3D next_entry(str, fp, len);
> + rc =3D next_entry(buf, fp, entry_len);
> =C2=A0 if (rc) {
> - kfree(str);
> + kfree(buf);
> =C2=A0 return rc;
> =C2=A0 }
>
> + *bufp =3D buf;
> + return 0;
> +}
> +
> +static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
> +{
> + int rc;
> + char *str;
> +
> + rc =3D entry_read(&str, flags, fp, len, len + 1);
> + if (rc)
> + return rc;
> +
> =C2=A0 str[len] =3D '\0';
> =C2=A0 *strp =3D str;
> =C2=A0 return 0;
> }
>
> +static int str_read_with_padding(char **strp, gfp_t flags, void *fp, u32=
 len,
> + char padding)
> +{
> + int rc;
> + char *str;
> +
> + rc =3D entry_read(&str, flags, fp, len, len + 2);
> + if (rc)
> + return rc;
> +
> + str[len] =3D padding;
> + str[len + 1] =3D '\0';
> + *strp =3D str;
> + return 0;
> +}
> +
> static int perm_read(struct policydb *p, struct symtab *s, void *fp)
> {
> =C2=A0 char *key =3D NULL;
> @@ -2193,7 +2223,17 @@ static int genfs_read(struct policydb *p, void *fp=
)
> =C2=A0 if (!newc)
> =C2=A0 goto out;
>
> - rc =3D str_read(&newc->u.name, GFP_KERNEL, fp, len);
> + if (ebitmap_get_bit(
> +=C2=A0=C2=A0=C2=A0=C2=A0 &p->policycaps,
> +=C2=A0=C2=A0=C2=A0=C2=A0 POLICYDB_CAP_GENFS_SECLABEL_WILDCARD))
> + /* Append a wildcard '*' to make it a wildcard pattern */
> + rc =3D str_read_with_padding(&newc->u.name,
> +=C2=A0=C2=A0=C2=A0 GFP_KERNEL, fp, len,
> +=C2=A0=C2=A0=C2=A0 '*');
> + else
> + /* Prefix pattern */
> + rc =3D str_read(&newc->u.name, GFP_KERNEL, fp,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len);
> =C2=A0 if (rc)
> =C2=A0 goto out;
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 971c45d576ba..da4d22220fe8 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -48,6 +48,7 @@
> #include <linux/audit.h>
> #include <linux/vmalloc.h>
> #include <linux/lsm_hooks.h>
> +#include <linux/parser.h>
> #include <net/netlabel.h>
>
> #include "flask.h"
> @@ -2861,9 +2862,15 @@ static inline int __security_genfs_sid(struct
> selinux_policy *policy,
>
> =C2=A0 for (c =3D genfs->head; c; c =3D c->next) {
> =C2=A0 size_t len =3D strlen(c->u.name);
> - if ((!c->v.sclass || sclass =3D=3D c->v.sclass) &&
> -=C2=A0=C2=A0=C2=A0=C2=A0 (strncmp(c->u.name, path, len) =3D=3D 0))
> - break;
> + if (selinux_policycap_genfs_seclabel_wildcard()) {
> + if ((!c->v.sclass || sclass =3D=3D c->v.sclass) &&
> +=C2=A0=C2=A0=C2=A0=C2=A0 (match_wildcard(c->u.name, path)))
> + break;
> + } else {
> + if ((!c->v.sclass || sclass =3D=3D c->v.sclass) &&
> +=C2=A0=C2=A0=C2=A0=C2=A0 (strncmp(c->u.name, path, len)))
> + break;
> + }
> =C2=A0 }
>
> =C2=A0 if (!c)
> --
> 2.47.0.338.g60cca15819-goog

