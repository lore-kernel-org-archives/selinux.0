Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8EB4C9F
	for <selinux@vger.kernel.org>; Thu, 26 Sep 2024 00:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727311698; cv=none; b=SZl8wDIedGEyuo7puBryVjfV1Kp7JrqOV9MuTdWdyPVBNEAnJpoKTUf2WBKkWhs1Y49KuFlce7xz4vn49oH0IicbeItdTfwse6DVZTzZZqi5Z00zciuhkOSoHgG+J7U1UXWXE1k8MDd7PI0P8uke9QqG4R5fr+s/CQ7j24Evb6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727311698; c=relaxed/simple;
	bh=bickZFj/5dBUBbAxdY2LFvU8nYeB07m/i7ZN43wDG3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9zgRvq65CFFc0TCNKy7l5ZIWimek/5K7D6mhfusiQ1QhN8JuvhOUDDx6MVi+FvwuphdH1OH0REhK2OCxP26FkyrEhFNoENEyAJcHanVo3cBi3AsaOHhdgvsv+bJk55CwXUnR4gdA3Gl6o9sWpFPzzy/sRP0wZX0ySsys7hg70c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JSvACkx+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JSvACkx+"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb1dd2886so117765e9.0
        for <selinux@vger.kernel.org>; Wed, 25 Sep 2024 17:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727311695; x=1727916495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jd2oewE7mZKmU5uTRAXDzHekq6Y7fBYQ0PKfxBHZxC4=;
        b=JSvACkx+B3zaZ2RNkAw6JlV68FeLB6ia9tflSCGf6swkVelTkDV1X1Y5KCuOYqZQ9k
         u4z5BrnhDI/FvZ8EaZR2Q+n5g9kOmgZkeF8iGBln7nfZ6pOuq4l6lTn8b/jYNkwrjQQE
         n1fGl+/ZGaFRG5noLCMynGmogtV+XF3/CLAcDkGg+CCbgHxBqLh/XQAmMLH8XP/YnEfE
         YWGtQnb7QLzvZQhRe0STWXk3jYCU4tFdvAJXz0/UFsr8DUmsKiDiVxbVt73hxmmuGdDr
         NrIuqOXjfWQzygvC2yN2wd67fkMvyj0Vnlgy3iy9jev86IDyjxysMNUkTlazlOUMxLJo
         8XHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727311695; x=1727916495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jd2oewE7mZKmU5uTRAXDzHekq6Y7fBYQ0PKfxBHZxC4=;
        b=GaQsUrWF+wcsUZ4/32Q/oKAhn4z2ATAQnBVn4lCJaqqTyy57LcASB00KVHDNXtYRzW
         7g9+DsSg4EDPl7afE8I0Y3zgEzZvKm15FmE3GcvrgnGWz0hcvoQhsIPflMAPADCe3bQW
         gDDfXwEF4D3iE0ju5whbJkZBVrrEFUOLpO2vgqV4btjfA7sOjqwE/l11mbwf3n+FKH35
         b1K9fOX6oI4HFO09Oq0WgLZIlCZG8yeC9pjv5+2kLnGJv1c3KelMNw3JnJa+JITvJOhq
         aBFyXGXlWWUqOKNCINDz4M4Or+3IhqeIVhTGAS0HzZZIwzAuaJKSJ635IrhZymcidCn8
         1OSw==
X-Gm-Message-State: AOJu0YwAzAnAQY5Luc55z44131BZbLhT7UaWRBnzq2MpF33ZTX13aCpu
	YWX+E+cApujoYVb5Lb9/Hxy6pVNIMXT6eK/y/NrE9hANUmWrtbwSCHBODWkHHOeXz8XSNhWMkB5
	nmDi5/8l1WDUvsDCgbguUZPS6FRNNRFqq93RTDciQtjfOXd7SrllX
X-Google-Smtp-Source: AGHT+IEdLhT7c74ArywjQ+nV22UFYuqjXYOcmL8XcgBhCTY0gSSDMFXy03q2KXTMG3Cd7f8R6VX6bfxbF51440m1Qxw=
X-Received: by 2002:a05:600c:c8c:b0:42b:a8fc:3937 with SMTP id
 5b1f17b1804b1-42f529b1ea6mr2095555e9.4.1727311694335; Wed, 25 Sep 2024
 17:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925201106.16134-3-paul@paul-moore.com>
In-Reply-To: <20240925201106.16134-3-paul@paul-moore.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Thu, 26 Sep 2024 10:47:55 +1000
Message-ID: <CA+zpnLceV4b0ittytzn3OHw+b4h2Wpa76LSyjsjZkz-xtoHhcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: streamline selinux_nlmsg_lookup()
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 6:11=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Streamline the code in selinux_nlmsg_lookup() to improve the code flow,
> readability, and remove the unnecessary local variables.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/nlmsgtab.c | 90 ++++++++++++++++---------------------
>  1 file changed, 39 insertions(+), 51 deletions(-)
>
> diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
> index acc7d74b99d5..f68b4f493de6 100644
> --- a/security/selinux/nlmsgtab.c
> +++ b/security/selinux/nlmsgtab.c
> @@ -168,34 +168,12 @@ static int nlmsg_perm(u16 nlmsg_type, u32 *perm, co=
nst struct nlmsg_perm *tab, s
>
>  int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
>  {
> -       int err =3D 0;
> -
> -       if (selinux_policycap_netlink_xperm()) {
> -               switch (sclass) {
> -               case SECCLASS_NETLINK_ROUTE_SOCKET:
> -                       *perm =3D NETLINK_ROUTE_SOCKET__NLMSG;
> -                       break;
> -               case SECCLASS_NETLINK_TCPDIAG_SOCKET:
> -                       *perm =3D NETLINK_TCPDIAG_SOCKET__NLMSG;
> -                       break;
> -               case SECCLASS_NETLINK_XFRM_SOCKET:
> -                       *perm =3D NETLINK_XFRM_SOCKET__NLMSG;
> -                       break;
> -               case SECCLASS_NETLINK_AUDIT_SOCKET:
> -                       *perm =3D NETLINK_AUDIT_SOCKET__NLMSG;
> -                       break;
> -               /* While it is possible to add a similar permission to ot=
her
> -                * netlink classes, note that the extended permission val=
ue is
> -                * matched against the nlmsg_type field. Notably,
> -                * SECCLASS_NETLINK_GENERIC_SOCKET uses dynamic values fo=
r this
> -                * field, which means that it cannot be added as-is.
> -                */
> -               default:
> -                       err =3D -ENOENT;
> -                       break;
> -               }
> -               return err;
> -       }
> +       /* While it is possible to add a similar permission to other netl=
ink
> +        * classes, note that the extended permission value is matched ag=
ainst
> +        * the nlmsg_type field. Notably, SECCLASS_NETLINK_GENERIC_SOCKET=
 uses
> +        * dynamic values for this field, which means that it cannot be a=
dded
> +        * as-is.
> +        */
>
>         switch (sclass) {
>         case SECCLASS_NETLINK_ROUTE_SOCKET:
> @@ -205,42 +183,52 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type=
, u32 *perm)
>                  * before updating the BUILD_BUG_ON() macro!
>                  */
>                 BUILD_BUG_ON(RTM_MAX !=3D (RTM_NEWTUNNEL + 3));
> -               err =3D nlmsg_perm(nlmsg_type, perm, nlmsg_route_perms,
> -                                sizeof(nlmsg_route_perms));
> -               break;
>
> +               if (selinux_policycap_netlink_xperm()) {
> +                       *perm =3D NETLINK_ROUTE_SOCKET__NLMSG;
> +                       return 0;
> +               }
> +               return nlmsg_perm(nlmsg_type, perm, nlmsg_route_perms,
> +                                 sizeof(nlmsg_route_perms));
> +               break;
>         case SECCLASS_NETLINK_TCPDIAG_SOCKET:
> -               err =3D nlmsg_perm(nlmsg_type, perm, nlmsg_tcpdiag_perms,
> -                                sizeof(nlmsg_tcpdiag_perms));
> +               if (selinux_policycap_netlink_xperm()) {
> +                       *perm =3D NETLINK_TCPDIAG_SOCKET__NLMSG;
> +                       return 0;
> +               }
> +               return nlmsg_perm(nlmsg_type, perm, nlmsg_tcpdiag_perms,
> +                                 sizeof(nlmsg_tcpdiag_perms));
>                 break;
> -
>         case SECCLASS_NETLINK_XFRM_SOCKET:
>                 /* If the BUILD_BUG_ON() below fails you must update the
>                  * structures at the top of this file with the new mappin=
gs
>                  * before updating the BUILD_BUG_ON() macro!
>                  */
>                 BUILD_BUG_ON(XFRM_MSG_MAX !=3D XFRM_MSG_GETDEFAULT);
> -               err =3D nlmsg_perm(nlmsg_type, perm, nlmsg_xfrm_perms,
> -                                sizeof(nlmsg_xfrm_perms));
> -               break;
>
> -       case SECCLASS_NETLINK_AUDIT_SOCKET:
> -               if ((nlmsg_type >=3D AUDIT_FIRST_USER_MSG &&
> -                    nlmsg_type <=3D AUDIT_LAST_USER_MSG) ||
> -                   (nlmsg_type >=3D AUDIT_FIRST_USER_MSG2 &&
> -                    nlmsg_type <=3D AUDIT_LAST_USER_MSG2)) {
> -                       *perm =3D NETLINK_AUDIT_SOCKET__NLMSG_RELAY;
> -               } else {
> -                       err =3D nlmsg_perm(nlmsg_type, perm, nlmsg_audit_=
perms,
> -                                        sizeof(nlmsg_audit_perms));
> +               if (selinux_policycap_netlink_xperm()) {
> +                       *perm =3D NETLINK_XFRM_SOCKET__NLMSG;
> +                       return 0;
>                 }
> +               return nlmsg_perm(nlmsg_type, perm, nlmsg_xfrm_perms,
> +                                 sizeof(nlmsg_xfrm_perms));
>                 break;
> -
> -       /* No messaging from userspace, or class unknown/unhandled */
> -       default:
> -               err =3D -ENOENT;
> +       case SECCLASS_NETLINK_AUDIT_SOCKET:
> +               if (selinux_policycap_netlink_xperm()) {
> +                       *perm =3D NETLINK_XFRM_SOCKET__NLMSG;

Should it be NETLINK_AUDIT_SOCKET__NLMSG here?
