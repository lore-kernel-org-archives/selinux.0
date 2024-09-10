Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B9B184522
	for <selinux@vger.kernel.org>; Tue, 10 Sep 2024 12:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725972060; cv=none; b=Qv62iy9WYvvBZ1MJB9V4DMwddyKeiFwgQVkGk7k3dQpdQ0NHO9o9JUOZpFOIhU1UFWzfdvoeTdEDLdOWDJkndDsS5q/PXc0p1DEDFWD5fini1q7SqgdnxmKG+8aNsTTHKo8PxBRYfPa2gUsXKFy7OK0V11BKx6cF3DHoT7QkzAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725972060; c=relaxed/simple;
	bh=FY+Wmho5ucjBt50ZZfn1YLfgczeATuACJmS0tckO/ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbCv8079zKepygxN3p9T+6FRf2KO2F/8GfNJDzl4gE4SXGhwuveOWPbgjvkUJ6oBT6vI+r3DldDbposyy55JDnCds5i+lEoYiQ1Ca93oH2DtMWdjiWT7iXDdX3BP1uUWSspzyS2SQ732D8abV1JK7SekWvoDtG/dnArr7wz4CbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Md20j38W; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md20j38W"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d87f34a650so3766578a91.1
        for <selinux@vger.kernel.org>; Tue, 10 Sep 2024 05:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725972058; x=1726576858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJe6lgGRR1fXJ2I9VJ/2iY4NV1siP5s1xx0EEN9i7Ac=;
        b=Md20j38WicVFGV61khsaHjbfC1D8zPsRrUqKk1zV8/YKjzV6bnteJoi3CC2Nk9h83t
         Znm6H+IuBbcumunIbkpW5KrCCJfaW8kAPpFTX0JxL/ZbK2tFwYQj7CgB7O7v+MYJkzoj
         ilA4DwOtt2maQAWphApLDGc+yEbmdPBw2bz9ZcfwZK7COqVbpefiv0kCunIi50ilVBSd
         UxOy2ZpBxe6prlvFLy6t5/NeUpfqyje5sAUrh79kneTAVMXq7913lmhUfb7Q8NRlAmge
         Q+Bfx9nxHu+jFzOkdDeQUqKVc4ND+1mrgCKnEgOxDqgEvBicbqMlwVzPhsKzyVc9hlw4
         G4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725972058; x=1726576858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJe6lgGRR1fXJ2I9VJ/2iY4NV1siP5s1xx0EEN9i7Ac=;
        b=SGInCMJF6//T+rr68cPliGFCtS5ILQlfxNU/WSchfziCNxw8asE0CZAFKVx+oaFJ4M
         6LBVrCE7toskqaT2iSqC5v3TMDMLHfvkSv2vxUaHPkFnNHrpe16Fs+XZV8AyzG9hFOwH
         B65BWzBD/w9Tmwf2iwlKpqLcY+ber94kg+BGRPgwxmAyPs722p62z80f7eNKULnMqFNa
         46SNRkogyCGFbEcqFxu43c/1A2fK1QRHkHS3fTf2ywSpza0tLpY+S/T2flPdEuM1RB5q
         kwwqUsCg9rIgYcFXj/IDIpf9kmIxSCWnDqV/W4ctFglV4iqrlnE34IT8VbO1duj8B7EF
         iWIg==
X-Forwarded-Encrypted: i=1; AJvYcCWCKprV50GvSwf5sqHgVn9p1otySyVNaNtrCe8sgJJNFeN2NkjyugCrbTzPcHfctjiN5BoZMgAd@vger.kernel.org
X-Gm-Message-State: AOJu0YzMjJvkfEiVP266gq8hEOHhiTCjyYZzHZwaTZLOW2toP84Fp6vZ
	Bht3VZ8zNMvRW/nLBIGlaQBSDfrwpSpnS4Ku8TxpHqm3T8rY7kXXmP05fRTkuPmzTHsJriHA2Zu
	rnuxzDwBZ6sDfHqCAMTkJyE0X/pk=
X-Google-Smtp-Source: AGHT+IFAqnP3VMs+dJ7OdtT7dv/uc+G4JQ5S+pxTBK0/zy4d+u9Wa9b5iqKpwHRNA2qT571SLAdMEVAX5+heUtebDiU=
X-Received: by 2002:a17:90a:cf94:b0:2da:88b3:cff8 with SMTP id
 98e67ed59e1d1-2db671989fbmr4512736a91.6.1725972057644; Tue, 10 Sep 2024
 05:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910013535.3680953-1-tweek@google.com>
In-Reply-To: <20240910013535.3680953-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 10 Sep 2024 08:40:46 -0400
Message-ID: <CAEjxPJ7ybRT+ovmXL821+SSjO=RoSECHHzkoLeM4ge0buq4Dfg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: Add netlink xperm support
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: paul@paul-moore.com, brambonne@google.com, jeffv@google.com, 
	selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 9:35=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@google=
.com> wrote:
>
> Reuse the existing extended permissions infrastructure to support
> policies based on the netlink message types.
>
> A new policy capability "netlink_xperm" is introduced. When disabled,
> the previous behaviour is preserved. That is, netlink_send will rely on
> the permission mappings defined in nlmsgtab.c (e.g, nlmsg_read for
> RTM_GETADDR on NETLINK_ROUTE). When enabled, the mappings are ignored
> and the generic "nlmsg" permission is used instead.
>
> The new "nlmsg" permission is an extended permission. The 16 bits of the
> extended permission are mapped to the nlmsg_type field.
>
> Example policy on Android, preventing regular apps from accessing the
> device's MAC address and ARP table, but allowing this access to
> privileged apps, looks as follows:
>
> allow netdomain self:netlink_route_socket {
>         create read getattr write setattr lock append connect getopt
>         setopt shutdown nlmsg
> };
> allowxperm netdomain self:netlink_route_socket nlmsg ~{
>         RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> };
> allowxperm priv_app self:netlink_route_socket nlmsg {
>         RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> };
>
> The constants in the example above (e.g., RTM_GETLINK) are explicitly
> defined in the policy.
>
> It is possible to generate policies to support kernels that may or
> may not have the capability enabled by generating a rule for each
> scenario. For instance:
>
> allow domain self:netlink_audit_socket nlmsg_read;
> allow domain self:netlink_audit_socket nlmsg;
> allowxperm domain self:netlink_audit_socket nlmsg { AUDIT_GET };
>
> The approach of defining a new permission ("nlmsg") instead of relying
> on the existing permissions (e.g., "nlmsg_read", "nlmsg_readpriv" or
> "nlmsg_tty_audit") has been preferred because:
>   1. This is similar to the other extended permission ("ioctl");
>   2. With the new extended permission, the coarse-grained mapping is not
>      necessary anymore. It could eventually be removed, which would be
>      impossible if the extended permission was defined below these.
>   3. Having a single extra extended permission considerably simplifies
>      the implementation here and in libselinux.
>
> The class NETLINK_GENERIC is excluded from using this extended
> permission because the nlmsg_type field is referencing the family id
> which is dynamically associated.
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> Signed-off-by: Bram Bonn=C3=A9 <brambonne@google.com>

Passes my tests from
https://lore.kernel.org/selinux/CA+zpnLda-npA5XJzYewxhQ9HeE5MKiM63QGkWRrjPW=
ZCbJK1_w@mail.gmail.com/T/#t

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v2: Reorder classmap.h to keep the new permission "nlmsg" at the end.
>
>  security/selinux/hooks.c                   | 56 +++++++++++++---
>  security/selinux/include/classmap.h        |  8 +--
>  security/selinux/include/policycap.h       |  1 +
>  security/selinux/include/policycap_names.h |  1 +
>  security/selinux/include/security.h        |  6 ++
>  security/selinux/nlmsgtab.c                | 21 ++++++
>  security/selinux/ss/avtab.h                |  5 +-
>  security/selinux/ss/services.c             | 78 ++++++++++++----------
>  8 files changed, 125 insertions(+), 51 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 400eca4ad0fb..d1ef898a8481 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4592,14 +4592,10 @@ static int socket_sockcreate_sid(const struct tas=
k_security_struct *tsec,
>                                        secclass, NULL, socksid);
>  }
>
> -static int sock_has_perm(struct sock *sk, u32 perms)
> +static bool sock_skip_has_perm(u32 sid)
>  {
> -       struct sk_security_struct *sksec =3D sk->sk_security;
> -       struct common_audit_data ad;
> -       struct lsm_network_audit net;
> -
> -       if (sksec->sid =3D=3D SECINITSID_KERNEL)
> -               return 0;
> +       if (sid =3D=3D SECINITSID_KERNEL)
> +               return true;
>
>         /*
>          * Before POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT, sockets that
> @@ -4613,7 +4609,19 @@ static int sock_has_perm(struct sock *sk, u32 perm=
s)
>          * setting.
>          */
>         if (!selinux_policycap_userspace_initial_context() &&
> -           sksec->sid =3D=3D SECINITSID_INIT)
> +           sid =3D=3D SECINITSID_INIT)
> +               return true;
> +       return false;
> +}
> +
> +
> +static int sock_has_perm(struct sock *sk, u32 perms)
> +{
> +       struct sk_security_struct *sksec =3D sk->sk_security;
> +       struct common_audit_data ad;
> +       struct lsm_network_audit net;
> +
> +       if (sock_skip_has_perm(sksec->sid))
>                 return 0;
>
>         ad_net_init_from_sk(&ad, &net, sk);
> @@ -5939,6 +5947,26 @@ static unsigned int selinux_ip_postroute(void *pri=
v,
>  }
>  #endif /* CONFIG_NETFILTER */
>
> +static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 perms, u16=
 nlmsg_type)
> +{
> +       struct sk_security_struct *sksec =3D sk->sk_security;
> +       struct common_audit_data ad;
> +       struct lsm_network_audit net;
> +       u8 driver;
> +       u8 xperm;
> +
> +       if (sock_skip_has_perm(sksec->sid))
> +               return 0;
> +
> +       ad_net_init_from_sk(&ad, &net, sk);
> +
> +       driver =3D nlmsg_type >> 8;
> +       xperm =3D nlmsg_type & 0xff;
> +
> +       return avc_has_extended_perms(current_sid(), sksec->sid, sksec->s=
class,
> +                       perms, driver, xperm, &ad);
> +}
> +
>  static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
>  {
>         int rc =3D 0;
> @@ -5964,7 +5992,17 @@ static int selinux_netlink_send(struct sock *sk, s=
truct sk_buff *skb)
>
>                 rc =3D selinux_nlmsg_lookup(sclass, nlh->nlmsg_type, &per=
m);
>                 if (rc =3D=3D 0) {
> -                       rc =3D sock_has_perm(sk, perm);
> +                       /* For Generic Netlink, nlmsg_type is mapped to t=
he
> +                        * family id which is dynamically assigned.
> +                        * Ignore extended permissions for this type.
> +                        */
> +                       if (selinux_policycap_netlink_xperm() &&
> +                               (sclass !=3D SECCLASS_NETLINK_GENERIC_SOC=
KET)) {
> +                               rc =3D nlmsg_sock_has_extended_perms(
> +                                       sk, perm, nlh->nlmsg_type);
> +                       } else {
> +                               rc =3D sock_has_perm(sk, perm);
> +                       }
>                         if (rc)
>                                 return rc;
>                 } else if (rc =3D=3D -EINVAL) {
> diff --git a/security/selinux/include/classmap.h b/security/selinux/inclu=
de/classmap.h
> index 7229c9bf6c27..cb2a52dcf0d7 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -96,17 +96,17 @@ const struct security_class_mapping secclass_map[] =
=3D {
>         { "shm", { COMMON_IPC_PERMS, "lock", NULL } },
>         { "ipc", { COMMON_IPC_PERMS, NULL } },
>         { "netlink_route_socket",
> -         { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", NULL } },
> +         { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", "nlmsg", NULL=
 } },
>         { "netlink_tcpdiag_socket",
> -         { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", NULL } },
> +         { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", "nlmsg", NULL=
 } },
>         { "netlink_nflog_socket", { COMMON_SOCK_PERMS, NULL } },
>         { "netlink_xfrm_socket",
> -         { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", NULL } },
> +         { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", "nlmsg", NULL=
 } },
>         { "netlink_selinux_socket", { COMMON_SOCK_PERMS, NULL } },
>         { "netlink_iscsi_socket", { COMMON_SOCK_PERMS, NULL } },
>         { "netlink_audit_socket",
>           { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", "nlmsg_relay"=
,
> -           "nlmsg_readpriv", "nlmsg_tty_audit", NULL } },
> +           "nlmsg_readpriv", "nlmsg_tty_audit", "nlmsg", NULL } },
>         { "netlink_fib_lookup_socket", { COMMON_SOCK_PERMS, NULL } },
>         { "netlink_connector_socket", { COMMON_SOCK_PERMS, NULL } },
>         { "netlink_netfilter_socket", { COMMON_SOCK_PERMS, NULL } },
> diff --git a/security/selinux/include/policycap.h b/security/selinux/incl=
ude/policycap.h
> index dc3674eb29c1..079679fe7254 100644
> --- a/security/selinux/include/policycap.h
> +++ b/security/selinux/include/policycap.h
> @@ -14,6 +14,7 @@ enum {
>         POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
>         POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
>         POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
> +       POLICYDB_CAP_NETLINK_XPERM,
>         __POLICYDB_CAP_MAX
>  };
>  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> diff --git a/security/selinux/include/policycap_names.h b/security/selinu=
x/include/policycap_names.h
> index 2cffcc1ce851..e080827408c4 100644
> --- a/security/selinux/include/policycap_names.h
> +++ b/security/selinux/include/policycap_names.h
> @@ -17,6 +17,7 @@ const char *const selinux_policycap_names[__POLICYDB_CA=
P_MAX] =3D {
>         "genfs_seclabel_symlinks",
>         "ioctl_skip_cloexec",
>         "userspace_initial_context",
> +       "netlink_xperm",
>  };
>  /* clang-format on */
>
> diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
> index 289bf9233f71..c7f2731abd03 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -195,6 +195,12 @@ static inline bool selinux_policycap_userspace_initi=
al_context(void)
>                 selinux_state.policycap[POLICYDB_CAP_USERSPACE_INITIAL_CO=
NTEXT]);
>  }
>
> +static inline bool selinux_policycap_netlink_xperm(void)
> +{
> +       return READ_ONCE(
> +               selinux_state.policycap[POLICYDB_CAP_NETLINK_XPERM]);
> +}
> +
>  struct selinux_policy_convert_data;
>
>  struct selinux_load_state {
> diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
> index 8ff670cf1ee5..0dac942156d6 100644
> --- a/security/selinux/nlmsgtab.c
> +++ b/security/selinux/nlmsgtab.c
> @@ -170,6 +170,27 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type,=
 u32 *perm)
>  {
>         int err =3D 0;
>
> +       if (selinux_policycap_netlink_xperm()) {
> +               switch (sclass) {
> +               case SECCLASS_NETLINK_ROUTE_SOCKET:
> +                       *perm =3D NETLINK_ROUTE_SOCKET__NLMSG;
> +                       break;
> +               case SECCLASS_NETLINK_TCPDIAG_SOCKET:
> +                       *perm =3D NETLINK_TCPDIAG_SOCKET__NLMSG;
> +                       break;
> +               case SECCLASS_NETLINK_XFRM_SOCKET:
> +                       *perm =3D NETLINK_XFRM_SOCKET__NLMSG;
> +                       break;
> +               case SECCLASS_NETLINK_AUDIT_SOCKET:
> +                       *perm =3D NETLINK_AUDIT_SOCKET__NLMSG;
> +                       break;
> +               default:
> +                       err =3D -ENOENT;
> +                       break;
> +               }
> +               return err;
> +       }
> +
>         switch (sclass) {
>         case SECCLASS_NETLINK_ROUTE_SOCKET:
>                 /* RTM_MAX always points to RTM_SETxxxx, ie RTM_NEWxxx + =
3.
> diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
> index 8e8820484c55..f4407185401c 100644
> --- a/security/selinux/ss/avtab.h
> +++ b/security/selinux/ss/avtab.h
> @@ -53,8 +53,9 @@ struct avtab_key {
>   */
>  struct avtab_extended_perms {
>  /* These are not flags. All 256 values may be used */
> -#define AVTAB_XPERMS_IOCTLFUNCTION 0x01
> -#define AVTAB_XPERMS_IOCTLDRIVER   0x02
> +#define AVTAB_XPERMS_IOCTLFUNCTION     0x01
> +#define AVTAB_XPERMS_IOCTLDRIVER       0x02
> +#define AVTAB_XPERMS_NLMSG             0x03
>         /* extension of the avtab_key specified */
>         u8 specified; /* ioctl, netfilter, ... */
>         /*
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index e33e55384b75..48d5748f03da 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -582,8 +582,7 @@ static void type_attribute_bounds_av(struct policydb =
*policydb,
>  }
>
>  /*
> - * flag which drivers have permissions
> - * only looking for ioctl based extended permissions
> + * Flag which drivers have permissions.
>   */
>  void services_compute_xperms_drivers(
>                 struct extended_perms *xperms,
> @@ -591,14 +590,18 @@ void services_compute_xperms_drivers(
>  {
>         unsigned int i;
>
> -       if (node->datum.u.xperms->specified =3D=3D AVTAB_XPERMS_IOCTLDRIV=
ER) {
> +       switch (node->datum.u.xperms->specified) {
> +       case AVTAB_XPERMS_IOCTLDRIVER:
>                 /* if one or more driver has all permissions allowed */
>                 for (i =3D 0; i < ARRAY_SIZE(xperms->drivers.p); i++)
>                         xperms->drivers.p[i] |=3D node->datum.u.xperms->p=
erms.p[i];
> -       } else if (node->datum.u.xperms->specified =3D=3D AVTAB_XPERMS_IO=
CTLFUNCTION) {
> +               break;
> +       case AVTAB_XPERMS_IOCTLFUNCTION:
> +       case AVTAB_XPERMS_NLMSG:
>                 /* if allowing permissions within a driver */
>                 security_xperm_set(xperms->drivers.p,
>                                         node->datum.u.xperms->driver);
> +               break;
>         }
>
>         xperms->len =3D 1;
> @@ -942,55 +945,58 @@ static void avd_init(struct selinux_policy *policy,=
 struct av_decision *avd)
>         avd->flags =3D 0;
>  }
>
> -void services_compute_xperms_decision(struct extended_perms_decision *xp=
ermd,
> -                                       struct avtab_node *node)
> +static void update_xperms_extended_data(u8 specified,
> +                                       struct extended_perms_data *from,
> +                                       struct extended_perms_data *xp_da=
ta)
>  {
>         unsigned int i;
>
> -       if (node->datum.u.xperms->specified =3D=3D AVTAB_XPERMS_IOCTLFUNC=
TION) {
> +       switch (specified) {
> +       case AVTAB_XPERMS_IOCTLDRIVER:
> +               memset(xp_data->p, 0xff, sizeof(xp_data->p));
> +               break;
> +       case AVTAB_XPERMS_IOCTLFUNCTION:
> +       case AVTAB_XPERMS_NLMSG:
> +               for (i =3D 0; i < ARRAY_SIZE(xp_data->p); i++)
> +                       xp_data->p[i] |=3D from->p[i];
> +               break;
> +       }
> +
> +}
> +
> +void services_compute_xperms_decision(struct extended_perms_decision *xp=
ermd,
> +                                       struct avtab_node *node)
> +{
> +       switch (node->datum.u.xperms->specified) {
> +       case AVTAB_XPERMS_IOCTLFUNCTION:
> +       case AVTAB_XPERMS_NLMSG:
>                 if (xpermd->driver !=3D node->datum.u.xperms->driver)
>                         return;
> -       } else if (node->datum.u.xperms->specified =3D=3D AVTAB_XPERMS_IO=
CTLDRIVER) {
> +               break;
> +       case AVTAB_XPERMS_IOCTLDRIVER:
>                 if (!security_xperm_test(node->datum.u.xperms->perms.p,
>                                         xpermd->driver))
>                         return;
> -       } else {
> +               break;
> +       default:
>                 BUG();
>         }
>
>         if (node->key.specified =3D=3D AVTAB_XPERMS_ALLOWED) {
>                 xpermd->used |=3D XPERMS_ALLOWED;
> -               if (node->datum.u.xperms->specified =3D=3D AVTAB_XPERMS_I=
OCTLDRIVER) {
> -                       memset(xpermd->allowed->p, 0xff,
> -                                       sizeof(xpermd->allowed->p));
> -               }
> -               if (node->datum.u.xperms->specified =3D=3D AVTAB_XPERMS_I=
OCTLFUNCTION) {
> -                       for (i =3D 0; i < ARRAY_SIZE(xpermd->allowed->p);=
 i++)
> -                               xpermd->allowed->p[i] |=3D
> -                                       node->datum.u.xperms->perms.p[i];
> -               }
> +               update_xperms_extended_data(node->datum.u.xperms->specifi=
ed,
> +                                           &node->datum.u.xperms->perms,
> +                                           xpermd->allowed);
>         } else if (node->key.specified =3D=3D AVTAB_XPERMS_AUDITALLOW) {
>                 xpermd->used |=3D XPERMS_AUDITALLOW;
> -               if (node->datum.u.xperms->specified =3D=3D AVTAB_XPERMS_I=
OCTLDRIVER) {
> -                       memset(xpermd->auditallow->p, 0xff,
> -                                       sizeof(xpermd->auditallow->p));
> -               }
> -               if (node->datum.u.xperms->specified =3D=3D AVTAB_XPERMS_I=
OCTLFUNCTION) {
> -                       for (i =3D 0; i < ARRAY_SIZE(xpermd->auditallow->=
p); i++)
> -                               xpermd->auditallow->p[i] |=3D
> -                                       node->datum.u.xperms->perms.p[i];
> -               }
> +               update_xperms_extended_data(node->datum.u.xperms->specifi=
ed,
> +                                           &node->datum.u.xperms->perms,
> +                                           xpermd->auditallow);
>         } else if (node->key.specified =3D=3D AVTAB_XPERMS_DONTAUDIT) {
>                 xpermd->used |=3D XPERMS_DONTAUDIT;
> -               if (node->datum.u.xperms->specified =3D=3D AVTAB_XPERMS_I=
OCTLDRIVER) {
> -                       memset(xpermd->dontaudit->p, 0xff,
> -                                       sizeof(xpermd->dontaudit->p));
> -               }
> -               if (node->datum.u.xperms->specified =3D=3D AVTAB_XPERMS_I=
OCTLFUNCTION) {
> -                       for (i =3D 0; i < ARRAY_SIZE(xpermd->dontaudit->p=
); i++)
> -                               xpermd->dontaudit->p[i] |=3D
> -                                       node->datum.u.xperms->perms.p[i];
> -               }
> +               update_xperms_extended_data(node->datum.u.xperms->specifi=
ed,
> +                                           &node->datum.u.xperms->perms,
> +                                           xpermd->dontaudit);
>         } else {
>                 BUG();
>         }
> --
> 2.46.0.598.g6f2099f65c-goog
>
