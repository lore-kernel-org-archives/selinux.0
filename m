Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0850C1AE05B
	for <selinux@vger.kernel.org>; Thu, 29 Aug 2024 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938510; cv=none; b=BkbcZooHnrqAdbSbZCW48XIBVFikJTObp0I3EORqiJKPvalnQthDgCrmh2YkCTQgT00Li88CN7ECln7kmzpPnuXKBm5I6e9/sSu67vjcKXAMnFXUUfb5OMcs8ToUJUiUW8L+ZoXOdPkrGclgwcn+JkoAYdzIOqFDMvTo1sQ+TYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938510; c=relaxed/simple;
	bh=ymK8+XFQSUnDqMgzzHoaDnGl1J/d7jjJgWmbW2pf5PY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFRVZ93n7gSEnDnCNMydaInr8Ilvwik6UNl5HLvKiOoY255qwo1r6heS57wyKlwsGxmJYbZpFFD2p7AuWNYi+fgGfLWDHJtenLrCNPAYxQNhkIawYGxdzsELDaPMG8GQOFX10UUEofrAbtM1O/EAoFhmOF5oRgQrofEi7gKtJ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCfRAh83; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCfRAh83"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d69e2a88e8so461537a91.2
        for <selinux@vger.kernel.org>; Thu, 29 Aug 2024 06:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724938508; x=1725543308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrU6E8zM+4UEmVey4L8PQrWBF07ExFf+EZ42usArf6g=;
        b=VCfRAh83tpxsxkiem19jMI0Q7URLF8Mxon84NiE1ftaV0EKHtIx8tSXQm0JY5ea2x4
         mofBe/xYBBYY3cMvpe4d844UZPBvxsj5XJ/M21KRpHZ0ErcaPPLyF9FX30BRxQnL2anK
         n+hU9LqOZ/9QmdWyL0mGd+qX2YhtiXolMkZ64llqlRnS8BCoxBD9NRz0N5qXJE9CNdRG
         NXzPVvJ83GePc/7s/HeV39jrPR5i6SdImbl/Fn4N/HZ4zeS/KswMFfS9D71O00iSXSdc
         j+XTijCaEIWThdUiu0eVeo3hsA8DDxOekOHtrVHAT9vxxW4flUdhJA8Xw1dXeqpO9sCP
         9mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724938508; x=1725543308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrU6E8zM+4UEmVey4L8PQrWBF07ExFf+EZ42usArf6g=;
        b=o3uA553ljCcU3r7KH2Ztgb3z0Uyq6DMoM3v4GtwNsmngcyykWAvHnpat5y0ehnyvr5
         KwWAeOWhyBIKQp8jtMVVzniNnsUftK+qoshnjC0B3xcAUhkXob+37nRLvt8OjNB6lRJz
         rgDp/XDeHD2HnCKTKKjjFPNH0/I4vTy9iGbsllcPT5TiGgXHQ3M7CrCdMtjdgt6mL7yR
         5d5ODgoWHX3pRpT+5pONc74EJ5RtWrKQOjFzO90SwetdRC8Mxj9TXpOOmq4qGBpZGQGz
         IUYkeXLuZoRv0VMK4kFuaQXKfKP/AR9xxrwc3IIhMm87XWBXSmzwf9Vqi8SDHdwEL15k
         +qZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX20EUCEOUhsGmaINlrjc3l7frME9UYSS+fk8/JJPxxr0bLH7yKcJRHtwusnBN07Tn8zyIf3op@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9sk1BYOYNmwfSgD7MuhohsMyCTIcJhbB32QlE2cY7Mg+/A/kb
	WgfXsqc5vAnXEF7Pc+wTqPpplwuG97+yj/Bvpgr8odxPGWPQzzzf7C6FDeuALeTuOCNDhVsxsTN
	soY1Dp0Ksy/u9Hyg9rSrX+C1bbiw=
X-Google-Smtp-Source: AGHT+IEgqRDzRb597xnH4IzEaogUGPhbufKyM5ApGVYuIt6Q13uIeYPWFU3+u8/6yhs7L5n73Ot72EhR6G/CIuRia30=
X-Received: by 2002:a17:90a:8d14:b0:2d8:27c3:87d7 with SMTP id
 98e67ed59e1d1-2d85617c02emr2815717a91.8.1724938508014; Thu, 29 Aug 2024
 06:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820002723.1345639-1-tweek@google.com>
In-Reply-To: <20240820002723.1345639-1-tweek@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 29 Aug 2024 09:34:55 -0400
Message-ID: <CAEjxPJ7e+zAf=st3QNh4B8ho4y1tMt9-fqZHeAUQTFE0yEKNeQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: Add netlink xperm support
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: paul@paul-moore.com, brambonne@google.com, jeffv@google.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 8:27=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
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

Expect you will re-spin with nlmsg permission added to the end of the
permissions lists, but since the patches work regardless and we have
previously added permissions (e.g. map permission) that displaced
other permission definitions since we introduced the dynamic
class/perm support, I'll go ahead and add my:
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> I previously suggested to rename the constants AVTAB_XPERMS_IOCTLDRIVER
> and AVTAB_XPERMS_IOCTLFUNCTION as they have a similar purpose to the new
> AVTAB_XPERMS_NLMSG. However, there is no other information in the
> avtab_datum structure to link the extended permission to the original
> permission. So it is still necessary to capture which permission is
> specified in struct avtab_extended_perms.
>
>  security/selinux/hooks.c                   | 56 +++++++++++++---
>  security/selinux/include/classmap.h        | 10 +--
>  security/selinux/include/policycap.h       |  1 +
>  security/selinux/include/policycap_names.h |  1 +
>  security/selinux/include/security.h        |  6 ++
>  security/selinux/nlmsgtab.c                | 21 ++++++
>  security/selinux/ss/avtab.h                |  5 +-
>  security/selinux/ss/services.c             | 78 ++++++++++++----------
>  8 files changed, 126 insertions(+), 52 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 55c78c318ccd..c30fad37c013 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4582,14 +4582,10 @@ static int socket_sockcreate_sid(const struct tas=
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
> @@ -4603,7 +4599,19 @@ static int sock_has_perm(struct sock *sk, u32 perm=
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
> @@ -5929,6 +5937,26 @@ static unsigned int selinux_ip_postroute(void *pri=
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
> @@ -5954,7 +5982,17 @@ static int selinux_netlink_send(struct sock *sk, s=
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
> index 7229c9bf6c27..c95bf89c9ce5 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -96,17 +96,17 @@ const struct security_class_mapping secclass_map[] =
=3D {
>         { "shm", { COMMON_IPC_PERMS, "lock", NULL } },
>         { "ipc", { COMMON_IPC_PERMS, NULL } },
>         { "netlink_route_socket",
> -         { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", NULL } },
> +         { COMMON_SOCK_PERMS, "nlmsg", "nlmsg_read", "nlmsg_write", NULL=
 } },
>         { "netlink_tcpdiag_socket",
> -         { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", NULL } },
> +         { COMMON_SOCK_PERMS, "nlmsg", "nlmsg_read", "nlmsg_write", NULL=
 } },
>         { "netlink_nflog_socket", { COMMON_SOCK_PERMS, NULL } },
>         { "netlink_xfrm_socket",
> -         { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", NULL } },
> +         { COMMON_SOCK_PERMS, "nlmsg", "nlmsg_read", "nlmsg_write", NULL=
 } },
>         { "netlink_selinux_socket", { COMMON_SOCK_PERMS, NULL } },
>         { "netlink_iscsi_socket", { COMMON_SOCK_PERMS, NULL } },
>         { "netlink_audit_socket",
> -         { COMMON_SOCK_PERMS, "nlmsg_read", "nlmsg_write", "nlmsg_relay"=
,
> -           "nlmsg_readpriv", "nlmsg_tty_audit", NULL } },
> +         { COMMON_SOCK_PERMS, "nlmsg", "nlmsg_read", "nlmsg_write",
> +           "nlmsg_relay", "nlmsg_readpriv", "nlmsg_tty_audit", NULL } },
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
> 2.46.0.184.g6999bdac58-goog
>
