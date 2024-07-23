Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0AF13C9D3
	for <selinux@vger.kernel.org>; Tue, 23 Jul 2024 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721761918; cv=none; b=M32NHhZGwt1uF2HD3b+OyicodKsdGnZlSvHTn9nvPbUxJJqQf2Yk5dGRJ3z1xeMnxZoeLvMrY9Mg3Z10D3jE+A9sIaUEDJT4zr5jBbaf0CvNmGMcFU8pYSnbE+0GEXc7yxmKioy1ImI/bTqeNXElDmMtpmPERaMquSVMBniIHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721761918; c=relaxed/simple;
	bh=6U0Tq5B7JnerkLFkycx8xn+prDOksp9DSp4/253ggmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXpvyexv4FO5KVIr9bG5VPXXg60yS+kr5iFBOh5ycdEYRqIPKhYx2rvChvsayxPOJrTsQ7mP9v+YJp1SyBX3V+yXquN0R0fWut/BsFwe8vz1OPAVQ6uCCmiF9pahSZ3mduUdLIRKptVfWyuKPKwGzb+Mj83FxfnaVllSf4wjjV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N/zUXgHy; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N/zUXgHy"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-66ca536621cso28540247b3.3
        for <selinux@vger.kernel.org>; Tue, 23 Jul 2024 12:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721761915; x=1722366715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOy7RSuxopCa1Vmv50B8DbwRjQIex4syrWJ20Zar430=;
        b=N/zUXgHyswU71SzgqjJzfKZeJXUuq2X3YPYU2IOsJvRFijDymlDSahCKSFl9C/QNPY
         ywLtgm0Qniw8/U6MjkwLjKtva8NRHr4h7nqS+U4kSWzHcWbigk1I5gG+ApeuT/KD1cgU
         Z0mq0ea9f7vIRo2mJT4uqkpnX5zO0WqorvkRnuilDIcskYL08YNxS9dec44f5tmWwKIt
         ZcRCTvUE5nphGvgWwgPKcVpFY+UROTYAVGt4YS2UjmM8w2LPZGvxxTaCKOcWx0zChb2g
         EPXESvHMjHFlE+qW/NBiwq748IRQX7mR1f4f67I/eUoT1XASDl2ShSZKDRrdVkzf4tXO
         pWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721761915; x=1722366715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOy7RSuxopCa1Vmv50B8DbwRjQIex4syrWJ20Zar430=;
        b=cXgrpS9a33ESHjM0x77ofbjafPiUcIT/wxssPNSO2anlRHenwtX5lOk87Vv946GjHL
         IZKRiVp2D56WZOg7+U3CiA1oMgG0KfVnePFZ1tmYsaCE7Uh9Lc9HXk82L3532VdMFvYX
         SR6trs0Oaqor2RvnPInnZ9Q23snLGw3wm8DggG4n2ordp1gsFHUsozeE81JN047mDe+8
         80OZ23SSPYrGJqPllg2ZKH1EfCfLtTcOOwggQPuLPpDmsDXpYBnCAI+g83DCve68+BVO
         l0+QnnWlI3oRe6PoHovsxJ6eaU+oCfzFEMeKVVfny3UP5wPS+rjgrueDit8Z/fzdxPuV
         YGLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp3VBTApfy77iXOdMFEUQU4LeUTY4j3Yn4/BrPTueqz2Cg9x24pX0QuMsJRoHKQk6IWaPiPfDiYlYrRABSEmowI32+1fiUIg==
X-Gm-Message-State: AOJu0YwO/JtcR39XcpwrmvM0q9yMdo5jmFHWQ8mbU3KJe3/m3ssRbUJO
	kWpoCT5lKZBskYsF4dMydF3yo0keU9dIaAt92dtgdImIRSkR6H0ydGXb0hcQ1z+xf4taL7khpmw
	j8h8I23O1vZU8YrI3NS9xNqa1BT+YGvGciu4t
X-Google-Smtp-Source: AGHT+IF6b9/gWj1szdiVQq+bluUgGT6wOwD/nPTpmSdNnN866HVGwaV/0vErENpdHLQVEMBw6b8RXly6/Ye2dphn0II=
X-Received: by 2002:a05:690c:2c84:b0:632:7161:d16c with SMTP id
 00721157ae682-66e4d7fac07mr38352757b3.28.1721761915239; Tue, 23 Jul 2024
 12:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhSFAj5Nr010pURESOX13kfAuj3NYGmG3Xt4bCRPYuJuiA@mail.gmail.com>
 <20240722062139.1740728-1-tweek@google.com>
In-Reply-To: <20240722062139.1740728-1-tweek@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 23 Jul 2024 15:11:44 -0400
Message-ID: <CAHC9VhSCVLbDD_ZuAX3TNKd765qVVvvhznL4wMhmFsg1BDW1Jw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: Add netlink xperm support
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: brambonne@google.com, jeffv@google.com, sds@tycho.nsa.gov, 
	selinux@vger.kernel.org, stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 2:21=E2=80=AFAM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
>
> > > > > Reuse the existing extended permissions infrastructure to support
> > > > > sepolicy for different netlink message types.
>
> (Following up on this patch).
>
> > > > >
> > > > > When individual netlink message types are omitted only the existi=
ng
> > > > > permissions are checked. As is the case for ioctl xperms, this fe=
ature
> > > > > is intended to provide finer granularity for nlmsg_read and nlmsg=
_write
> > > > > permissions, as they may be too imprecise. For example, a single
> > > > > NETLINK_ROUTE socket may provide access to both an interface's IP
> > > > > address and to its ARP table, which might have different privacy
> > > > > implications. In addition, the set of message types has grown ove=
r time,
> > > > > so even if the current list is acceptable, future additions might=
 not be.
> > > > > It was suggested before on the mailing list [1] that extended per=
missions
> > > > > would be a good fit for this purpose.
> > > > >
> > > > > Existing policy using the nlmsg_read and nlmsg_write permissions =
will
> > > > > continue to work as-is. Similar to ioctl xperms, netlink xperms a=
llow
> > > > > for a more fine-grained policy where needed.
> > > > >
> > > > > Example policy on Android, preventing regular apps from accessing=
 the
> > > > > device's MAC address and ARP table, but allowing this access to
> > > > > privileged apps, looks as follows:
> > > > >
> > > > > allow netdomain self:netlink_route_socket {
> > > > >         create read getattr write setattr lock append connect get=
opt
> > > > >         setopt shutdown nlmsg_read
> > > > > };
> > > > > allowxperm netdomain self:netlink_route_socket nlmsg ~{
> > > > >         RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> > > > > };
> > > > > allowxperm priv_app self:netlink_route_socket nlmsg {
> > > > >         RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> > > > > };
> > > > >
> > > > > Android currently uses code similar to [1] as a temporary workaro=
und to
> > > > > limit access to certain netlink message types; our hope is that t=
his patch
> > > > > will allow us to move back to upstream code with an approach that=
 works for
> > > > > everyone.
> > > > >
> > > > > [1] https://lore.kernel.org/selinux/CAHC9VhRSUhozBycHMZcMaJsibJDx=
NMsTsKVT2zOnW=3D5H4R4mdg@mail.gmail.com/
> > > > >
> > > > > Signed-off-by: Bram Bonne <brambonne@google.com>
> > > > > ---
> > > > >  security/selinux/hooks.c       | 24 +++++++++++++++++++++++-
> > > > >  security/selinux/ss/avtab.h    |  1 +
> > > > >  security/selinux/ss/services.c | 23 ++++++++++++++++++++++-
> > > > >  3 files changed, 46 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > > index e7ebd45ca345..a503865fabed 100644
> > > > > --- a/security/selinux/hooks.c
> > > > > +++ b/security/selinux/hooks.c
> > > > > @@ -4662,6 +4662,28 @@ static int sock_has_perm(struct sock *sk, =
u32 perms)
> > > > >                             &ad);
> > > > >  }
> > > > >
> > > > > +static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 pe=
rms, u16 nlmsg_type)
> > > > > +{
> > > > > +       struct sk_security_struct *sksec =3D sk->sk_security;
> > > > > +       struct common_audit_data ad;
> > > > > +       struct lsm_network_audit net =3D {0,};
> > > > > +       u8 xperm;
> > > > > +
> > > > > +       if (sksec->sid =3D=3D SECINITSID_KERNEL)
> > > > > +               return 0;
> > > > > +
> > > > > +       ad.type =3D LSM_AUDIT_DATA_NET;
> > > > > +       ad.u.net =3D &net;
> > > > > +       ad.u.net->sk =3D sk;
> > > > > +
> > > > > +       // nlmsg_types comfortably fit into a single driver, see =
RTM_MAX in uapi/linux/rtnetlink.h
> > > > > +       xperm =3D nlmsg_type & 0xff;
> > > >
> > > > This seems like a dangerous assumption; obviously not all netlink
> > > > users are rtnetlink. Even if all existing netlink users follow this=
,
> > > > nothing prevents userspace from creating a netlink message that
> > > > violates it AFAIK, at which point you will just silently discard th=
e
> > > > higher bits. If we think we can get away with this restriction, the=
n
> > > > we need to enforce it here (i.e. return an error if they do not fit=
);
> > > > if not,
> > > > then we likely need to support multiple drivers with a simple mappi=
ng
> > > > of the upper bits to driver.
>
> Agreed. Mapping the upper bits to the driver field would work.
>
> In this case, AVTAB_XPERMS_NLMSG proposed here would have the exact same
> implementation as AVTAB_XPERMS_IOCTLFUNCTION. An option could be to renam=
e the
> AVTAB_XPERMS_IOCTLFUNCTION constant (for example, to AVTAB_XPERMS_PERMS, =
and
> similarly moving AVTAB_XPERMS_IOCTLDRIVER to AVTAB_XPERMS_DRIVER). This i=
s
> describing more how struct avtab_extended_perms is being used rather than
> focusing on its original meaning. (That is, the driver and perms fields a=
re
> historically related to ioctl, but they have their own meanings in the xp=
erm
> implementation).
>
> The alternative is simply to have that new constant (AVTAB_XPERMS_NLMSG, =
maybe
> renamed to AVTAB_XPERMS_NETLINK_MSGTYPE, to be more explicit?).

Considering that the original patch is almost three years old at this
point, if you're interested in picking up this work I'd suggest
starting by picking one of the options above that you like the most
and preparing a patch(set) that works on the current development
trees.  At this point all I remember about this patchset is that it
existed.  If I'm going to spend the time to go back and re-review
something, I'd rather it be a bit more recent than three years ;)

> > > Looks like generic netlink puts the family id into the message type
> > > field, with the actual command in the separate generic netlink header
> > > in the payload. generic netlink family ids appear to be dynamically
> > > allocated, with GENL_MAX_ID defined as 1023. genl-ctrl-list on a
> > > sample Linux system reports ids from 0x10 through 0x1f so those would
> > > fit but there isn't anything in the code to prevent higher ids from
> > > being allocated up to the max. And if someday you want to be able to
> > > filter generic netlink messages at the per-command level, you'd
> > > further need to deal with the separate cmd field.
> >
> > There is also NETLINK_AUDIT which currently has message types defined
> > up to 2000.  The netlink message header format allows for 16 bit
> > message types (look at the nlmsghdr struct) and I think it would be a
> > mistake if the SELinux netlink/xperms code didn't support a full 16
> > bits for the message type.
> >
> > As far as NETLINK_GENERIC is concerned, yes, that's a bit of a
> > nuisance both with the dynamic family IDs and buried message types.
> > On the plus side, there are existing kernel functions that will
> > resolve the generic netlink family IDs to a genl_family struct but
> > those are currently private to the generic netlink code; I imagine if
> > there was a need those functions (or something similar) could be made
> > available outside of the genetlink.c.  Once you've matched on
> > NETLINK_GENERIC and done the family resolution, it should just be a
> > matter of doing the generic netlink command lookup in the context of
> > the family, which really shouldn't be much different than looking up
> > the message type of a conventional netlink message.
>
> I can see how the resolution for cmd can be done, but I am not sure how t=
he
> family should be handled. I don't think it is ok to not correlate the fam=
ily to
> some data in the policy.

Yes, the family needs to be represented in the policy and using
precedence as a guide I would suggest encoding the netlink family
types as object classes.  You'll need a generic netlink "default" for
those generic netlink families that aren't explicitly defined, but
that shouldn't be too hard to implement.

--=20
paul-moore.com
