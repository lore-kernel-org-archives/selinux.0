Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120E41F3D28;
	Tue,  7 Jan 2025 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258750; cv=none; b=Uk7JbIqjE2N+7hRBBmw8EQqkHx6zyl8LmANip4RJsmVF8Ws7ZZnG4giNhIqEtQv61zdfP7G+vspwx7QpshOxq76nwGsuxwsAswV9dwSppoZixt9EwtM8JW+sbGrWj1X1T+C1vHLbGjUBTOHUHGkih7bPV5KuXNe0uv5ljPOiWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258750; c=relaxed/simple;
	bh=3bC+tt/tkpsjnf3Sk8QNcmJWfrjb6U9Hh8ZMcrCOkCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIn2JUBYVkBftt4jWJTOjNEvnY+cOdSBUHN5LBs0Tlyfd5huQkDUjWXQEWWZcm9W7ldwU6HKvN1aFLfK3kRpg42JuPrTI9lVXruty7fRo9//aViBq4k0kYa1qhBpordjOmvuvieSnyylLFSJrldscJM7nHw7PBOxXinBNUw+wM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=VFj/Mbd3; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VFj/Mbd3"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e549a71dd3dso6272723276.0;
        Tue, 07 Jan 2025 06:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1736258746; x=1736863546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHVjIzLvyGRcBtjNbLL/xyb7E5vuoQFJEgdfAWywMng=;
        b=VFj/Mbd3dLXycDYaHpDgyDneck9kWDWudfsuIkiWJFLaGIAYe6YtBeFj1QfA6pwUMK
         WDhdHdV/qkEPHVKxJise8OoyXpvfge0a+sEzSeo9r4lZHAbbJ3dJYY0RWTpEVbxdbY4K
         BJBMYJRi5HZv66vCq9jI+YpcrPdCRJ06Oriet0rs6Y0aISeofV079XW1vl0GK9UHuKFf
         H3vfVDKBLFwUm87/54IT14lQBRycTSpzatv0qK40fkIgezZU4gmEyH75UMrJAzAjS69/
         M2zceiG+VdkndNbCN6MF3IHTONU1MV5En/lGLs8i/anjcrQYPbuLYcJ4EhyUHmsM4YdS
         tifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258746; x=1736863546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHVjIzLvyGRcBtjNbLL/xyb7E5vuoQFJEgdfAWywMng=;
        b=ZlflDv9C0VhnbNW+dChU9subs4feGvz6p51hqAwnwBXcQOnG+ylyVxj2bZM7xA/7cw
         wa/iHgOa6b1ufQnAmXpKEk7q0EnoH1r7LmRBmom/VVw/uROyCaTE68HwM0kAk5uscoGO
         KcQ4tCaxGh2xhtEkfsxWLggv0KVGg0UoXn2HmCfBZejgcoR5von0BkIbFnPNPo4XFyEV
         HYSgvo5aBxrRU/rMYESVrTfN29i28cyyQY0rtYB4bjex29uDak5kk0I9qUtjlbQmvCJy
         /BioX0CpVnqVDU9KH3Uux/TtOs/yxVTifYY2mv8xrgdPMSjq5NO5QqLhDv80yL9uvkee
         +1eg==
X-Forwarded-Encrypted: i=1; AJvYcCUK4gii70xUZW8KF9/aEw6nY/n/AdgvRLo1p06X3CQTUpsm+H3yUCvuIhl/mqoX9i4sWNqJb0Al0icTqlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjPsK2/PfNZ1WKN4C7DyL/3sO6FKMNmu4Jk0jRLnEGKdPjCdAI
	UeN4KzcKNCq+Wc2e1ZaJ6DIaOE4rU4W4dv/6vgXkPifKMMQeIpb3kzgjb5mGQbsAltSoVRlE3SB
	E9faNYTQ+E399PJHjU64KvNIcmMEprzgEe5E=
X-Gm-Gg: ASbGncv06ouZG+lxa7HlRQQbCsCHNor0+WSLO4/sPeHwONEAZAdhiN0tQKLBEAHMLVI
	onTd6+O7xgf0QjGUWlYzzVBo77CuDb2atFMU+
X-Google-Smtp-Source: AGHT+IH6q4C6mMp5olTt4sGag1740rTP0Pzug36chJ/cclYY0AG9azo/tKWADMhY2oOeMKwfTuA8Ianx/eUAJspLGq0=
X-Received: by 2002:a05:690c:3604:b0:6ef:7312:d05c with SMTP id
 00721157ae682-6f3f80d2d0bmr527112787b3.2.1736258745670; Tue, 07 Jan 2025
 06:05:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217135517.534645-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241217135517.534645-1-cgoettsche@seltendoof.de>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Tue, 7 Jan 2025 15:05:35 +0100
Message-ID: <CAJ2a_DdDnBeCgXuoVC0yRZT6+R8h4z85q+Vw81Oaw5ahvm7dJQ@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: support wildcard network interface names
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	=?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, GUO Zihua <guozihua@huawei.com>, 
	Canfeng Guo <guocanfeng@uniontech.com>, linux-kernel@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Dec 2024 at 15:11, Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Add support for wildcard matching of network interface names.  This is
> useful for auto-generated interfaces, for example podman creates network
> interfaces for containers with the naming scheme podman0, podman1,
> podman2, ...
>
> Since the wildcard characters '?' and '*' should be very uncommon in
> network interface names, and thus if netifcon definitions, avoid
> introducing a new policy version or capability.
>
> Netifcon definitions are compared against in the order given by the
> policy, so userspace tools should sort them in a reasonable order.

Kindly ping.
Any comments on this one?

> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/security.h | 2 +-
>  security/selinux/ss/services.c      | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
> index 10949df22fa4..f6e7ba57a1fc 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -298,7 +298,7 @@ int security_ib_pkey_sid(u64 subnet_prefix, u16 pkey_=
num, u32 *out_sid);
>
>  int security_ib_endport_sid(const char *dev_name, u8 port_num, u32 *out_=
sid);
>
> -int security_netif_sid(char *name, u32 *if_sid);
> +int security_netif_sid(const char *name, u32 *if_sid);
>
>  int security_node_sid(u16 domain, void *addr, u32 addrlen, u32 *out_sid)=
;
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 55fdc7ca232b..2f878fa99692 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -46,6 +46,7 @@
>  #include <linux/in.h>
>  #include <linux/sched.h>
>  #include <linux/audit.h>
> +#include <linux/parser.h>
>  #include <linux/vmalloc.h>
>  #include <linux/lsm_hooks.h>
>  #include <net/netlabel.h>
> @@ -2554,7 +2555,7 @@ int security_ib_endport_sid(const char *dev_name, u=
8 port_num, u32 *out_sid)
>   * @name: interface name
>   * @if_sid: interface SID
>   */
> -int security_netif_sid(char *name, u32 *if_sid)
> +int security_netif_sid(const char *name, u32 *if_sid)
>  {
>         struct selinux_policy *policy;
>         struct policydb *policydb;
> @@ -2576,7 +2577,7 @@ int security_netif_sid(char *name, u32 *if_sid)
>
>         c =3D policydb->ocontexts[OCON_NETIF];
>         while (c) {
> -               if (strcmp(name, c->u.name) =3D=3D 0)
> +               if (match_wildcard(c->u.name, name))
>                         break;
>                 c =3D c->next;
>         }
> --
> 2.45.2
>
