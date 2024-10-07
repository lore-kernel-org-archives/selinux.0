Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376E21DE8AC
	for <selinux@vger.kernel.org>; Mon,  7 Oct 2024 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333093; cv=none; b=ROxqMTtI/KcgYHhbP96l7rLG/WD9jTmKhzAnNBKnZ5L5oXw67WGCJcVQIcWGQlx9XXBcQLpovayL4WxnUiZaTHvPiEit0EaN/Iz9kDfbTCgrX5QXu1UWxBb4V45iaCBLx+MfbEphBZHbzGKQTrOD92TgE0L/7lE0DWf5LMzLoCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333093; c=relaxed/simple;
	bh=PYKEr2B+SDYlVErhgovvnQofAgZOgFTio7aCeWLNlk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJT3sbdzOwkwptKNOYtX1eg8zQw6o1ObaZACA1qpA3scywHzUANku/7vNB38ZXay30EfkHZEtGHg+C9njPo5KpgA0zINrAYCzaf+27yCnQhoR6tSVRhwh6JmS3ZDnetEusjDfVUkqcCVpnwzVEmzBLLUVswZ2bM/bnyrnTA37DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gKc+97Dp; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gKc+97Dp"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e2772f7df9so38525087b3.2
        for <selinux@vger.kernel.org>; Mon, 07 Oct 2024 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728333090; x=1728937890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBiTcINckjsPPCzqH8Hwn1CX5uyzyNr1YVefI3fCfS0=;
        b=gKc+97Dp8P2WJNHIVfRPupP9Ob9yN+gylOG3AEPhIsPCLYCpVacZqQE0Txho4gYYFf
         gklabx+6RJq7y0f3psAZF4u6xcnUCFeUMXXJa7vd1opv1r4jSRJkGY+F3mkJuHmdlt4e
         YOPSvW1uJ867X8RUy1oGE1c9PnPbHRhQgDbHCkZQ4V7EITN8gs3o4H7wUQlpBWfaH4tU
         5jSqkj0UKrLpqoQCkbdGwKnFmPDfaqC3uOsjVv3Ke/3w8mVjWUsZSnEu4MqdhOuL6R5W
         7oYPa/8NQvFiOwEEVkDojpHhegjqeCmbBCRS3QjdVLZ0zs/kVi9YFq2rE+mSAg6l32DX
         aEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728333090; x=1728937890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBiTcINckjsPPCzqH8Hwn1CX5uyzyNr1YVefI3fCfS0=;
        b=gQsSr/kxB57oCULZnwy1RKjbBp9v3+6rpAj9A0pSd/WmXjAorhPIul+jbCIw2I2sXh
         jzYCOZ3scHHaY1RdKr79vS18Iss2YNup3ZGeBswrqewgglrNvc62vCoOXrX1H57YkELZ
         xeeufpWWx8Es4DA1w631On3gOzC6n4WS63Nu+vMwMG5BPT8JKYAns8AgkR0OL3Q3fosm
         8RDiWSPGEHPjSvp8/rWRJP1jA8418XhlN4T7WxT2iVC+ogBlUTr4WX2Cobqg7GX4JPka
         G1g7N4Waxj09WVflL3FL7iFsHyiSPzZev/iHqrLttDLjOPo47J2NK6VAFIzvOxeufUy4
         BG1g==
X-Forwarded-Encrypted: i=1; AJvYcCUzfvBmwNSsNUv0tw11oiXNOcT7AhXyXWZ9pBMQuI714JTEZyHWv5GlwqShH5YCkymElM/aTStH@vger.kernel.org
X-Gm-Message-State: AOJu0YzyDQ0Ioh+j9b+uuKbkleUypBrd1VeeQ/4iAfI2i+1g3rNGrxhH
	762A9L5OPKHPHKopSTffSG+R4kvxDR0QFh7+MLPXmveQvZk2LnPSWiO+lewkOaJSX/UCxc0COTv
	08ZjW04Kp/WCEUMc4Nk1lQNEYKoPTHjDw3ZvW
X-Google-Smtp-Source: AGHT+IFTya/F4Vx8U0n3rL11/fGls2NkqpZw3YY7sGRev5bALhJoxnJJ351kmjOVNPLMuBxz0zjJJDXsTp2zoeGAppo=
X-Received: by 2002:a05:690c:6908:b0:6a9:4fdd:94e5 with SMTP id
 00721157ae682-6e2c6ffb5famr118919537b3.13.1728333090111; Mon, 07 Oct 2024
 13:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912014503.835759-1-tweek@google.com> <34803d945f405dc2e4e798cdaf057994@paul-moore.com>
In-Reply-To: <34803d945f405dc2e4e798cdaf057994@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 7 Oct 2024 16:31:19 -0400
Message-ID: <CAHC9VhQpYuTjHP+TYZpD+N=SJVOOfsrjJKrsX2y2CMJb-dWiUA@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: Add netlink xperm support
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: brambonne@google.com, jeffv@google.com, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 8:02=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Sep 11, 2024 "=3D?UTF-8?q?Thi=3DC3=3DA9baud=3D20Weksteen?=3D" <tweek@g=
oogle.com> wrote:
> >
> > Reuse the existing extended permissions infrastructure to support
> > policies based on the netlink message types.
> >
> > A new policy capability "netlink_xperm" is introduced. When disabled,
> > the previous behaviour is preserved. That is, netlink_send will rely on
> > the permission mappings defined in nlmsgtab.c (e.g, nlmsg_read for
> > RTM_GETADDR on NETLINK_ROUTE). When enabled, the mappings are ignored
> > and the generic "nlmsg" permission is used instead.
> >
> > The new "nlmsg" permission is an extended permission. The 16 bits of th=
e
> > extended permission are mapped to the nlmsg_type field.
> >
> > Example policy on Android, preventing regular apps from accessing the
> > device's MAC address and ARP table, but allowing this access to
> > privileged apps, looks as follows:
> >
> > allow netdomain self:netlink_route_socket {
> >       create read getattr write setattr lock append connect getopt
> >       setopt shutdown nlmsg
> > };
> > allowxperm netdomain self:netlink_route_socket nlmsg ~{
> >       RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> > };
> > allowxperm priv_app self:netlink_route_socket nlmsg {
> >       RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> > };
> >
> > The constants in the example above (e.g., RTM_GETLINK) are explicitly
> > defined in the policy.
> >
> > It is possible to generate policies to support kernels that may or
> > may not have the capability enabled by generating a rule for each
> > scenario. For instance:
> >
> > allow domain self:netlink_audit_socket nlmsg_read;
> > allow domain self:netlink_audit_socket nlmsg;
> > allowxperm domain self:netlink_audit_socket nlmsg { AUDIT_GET };
> >
> > The approach of defining a new permission ("nlmsg") instead of relying
> > on the existing permissions (e.g., "nlmsg_read", "nlmsg_readpriv" or
> > "nlmsg_tty_audit") has been preferred because:
> >   1. This is similar to the other extended permission ("ioctl");
> >   2. With the new extended permission, the coarse-grained mapping is no=
t
> >      necessary anymore. It could eventually be removed, which would be
> >      impossible if the extended permission was defined below these.
> >   3. Having a single extra extended permission considerably simplifies
> >      the implementation here and in libselinux.
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > Signed-off-by: Bram Bonn=C3=A9 <brambonne@google.com>
> > ---
> > v3:
> >   - Remove condition on SECCLASS_NETLINK_GENERIC_SOCKET in
> >     selinux_netlink_send.
> >   - Remove comment in selinux_netlink_send.
> >   - Add comment in selinux_nlmsg_lookup.
> >   - Update commit message.
> > v2: Reorder classmap.h to keep the new permission "nlmsg" at the end.
> >
> >  security/selinux/hooks.c                   | 51 +++++++++++---
> >  security/selinux/include/classmap.h        |  8 +--
> >  security/selinux/include/policycap.h       |  1 +
> >  security/selinux/include/policycap_names.h |  1 +
> >  security/selinux/include/security.h        |  6 ++
> >  security/selinux/nlmsgtab.c                | 27 ++++++++
> >  security/selinux/ss/avtab.h                |  5 +-
> >  security/selinux/ss/services.c             | 78 ++++++++++++----------
> >  8 files changed, 126 insertions(+), 51 deletions(-)
>
> Looks good to me, thanks for the revision.  We're in the merge window
> right now so I'm going to merge this into selinux/dev-staging now and
> I'll move it into selinux/dev after -rc1 is released.

Thanks for your patience, I just merged this into selinux/dev, you
should see it upstream shortly.

--=20
paul-moore.com
