Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DB61CD210
	for <selinux@vger.kernel.org>; Mon, 16 Dec 2024 06:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734331345; cv=none; b=ml17sGWuK11HabvsnxPisjyazrCH9PhIVjLEPuTEarrqckdmk6UD5aj1DhdnRsZG2ZlmiZpUcLHQbtGuUdj/HK2MTK3oVNa1dT/m8hR8EKQDp7qeAYNNffLqqw10HjoLtFKVYlZ+/LWoe9vIzee6Ti6aoVXJWeUnreAQZM8fCDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734331345; c=relaxed/simple;
	bh=+Ox6TCdRSBslFljqqt6HlttAfATgePjWsrsiB5oc0Y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dp2XaNtZdSjfo3pu7Qvgd99NpsKK5fCzmWN78zbcJnmwhz7oM+gzrkVtbDXuOmG9oOTr3GCq29+bwJVfunmF1PI1QD4MatZub2eFFAhAb35BMyLzncF/zuXjKQhju4FgOoKiz/d2W1fOYCKBAaFsmkzPqo6sm6/wXnNZsLc257c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wqaB4UUh; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wqaB4UUh"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53e3a2264e1so6469e87.0
        for <selinux@vger.kernel.org>; Sun, 15 Dec 2024 22:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734331341; x=1734936141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfuSrSA2gESmnCxc6b7uV6jZMnyEpYlmXiswvWf1ZGw=;
        b=wqaB4UUhcGmmvEj4cheUtBHvk57UICk8knNVrtRyTzIKUz0niiyOwx4cmg0TBGQGpR
         1GZYeJWRXeCItDftq9i3xh1BZ9US4Ml4CH/0pAB1KSuxMNw3biUMkYBbyMhRZKg4RZ7p
         LNPmOxNGWYtVO+zlWyGC5gQrbZXxXDlhPSFUMn4bJKMNrIXw2OWsdeuln4bTjE5z+cEK
         U50ldH+KL8Rbzi8lygw5glDaND3KDX7Smn2jbQvaKjER+0ac1YfZAyjn9LU7XWmJUHrI
         j78nPAZ5gLmFsZ8ZN2ah87+xtxL9PxAyHehzaFcN9cIxI2sctkpmqXKixbZ+/BUnUJjA
         Ae7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734331341; x=1734936141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfuSrSA2gESmnCxc6b7uV6jZMnyEpYlmXiswvWf1ZGw=;
        b=gf5wPiWVM5FzfaBUlbcQ11/PfwffIOA023HlNnsc7s53KQcXCxEjGrle7UHp0fK0/2
         FkLIE0MLzqTSsFMgsbSy7nzatnYm8O9Tvr8p9WlrV5x99LByNDYGxPNtH//0LicMkm8e
         XcW6NTdDs0hBklakzURKrtvNuBocbsPvXmioKZHCEvFuwPDagi8qLAS1hex6xmChR7IF
         xrnlTe005gub4/leudyDAKxH+tUmBfCwVACN3fwwZh6B56vPyTCFl8NE3GGRuReU2Vhu
         RXqq3D3r+DcaF92ZNXspw23B/o4qETcrKelvMshxAWdn5od/q6clhawBfsIMuvT6evWW
         hQzg==
X-Forwarded-Encrypted: i=1; AJvYcCXvpGmOVAC260gYdsK/DyXoRcbNXG2/aqEWgrdxD3M9kXbn+MzeglWVxT9BMI3cnkkQKRUZC0UC@vger.kernel.org
X-Gm-Message-State: AOJu0YyOAfqDa28cgMcvw2LTbt5e6dOuuvmyOCyDzC7n7BmBNoZ/y8gd
	+5aI97GHXxrf5BSzzrnALvnQvjU6RnCObu9mAm6W/c1H6j3jYPtYd7V0RZ2NbjE7iqZ8orAAFEo
	Walj+10VYUrdQk5AayGLk5jKrknaidK2vp8E1
X-Gm-Gg: ASbGncuuEKaqXesn2pc0v6/69E6JRVprxvoJjoC53+njnns/GvFbph+Uc9dLPL59eGa
	gkovw8wO8jq5Tb/mdl3jJ6JYj5MWJiPVNin1dDw==
X-Google-Smtp-Source: AGHT+IHXjC4fLSWnkEdkcNG2rc5t9o6vovgbrikqFXH9uSx2E/O5eTHMk4jgvFGMXP2Ur42QMoKRi86qKen4eBcbjww=
X-Received: by 2002:a05:6512:2099:b0:53b:4c7c:a792 with SMTP id
 2adb3069b0e04-54120b1c795mr163650e87.6.1734331341017; Sun, 15 Dec 2024
 22:42:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205014951.1451858-1-tweek@google.com> <d1c9371289fa2823e032a489925ad03f@paul-moore.com>
In-Reply-To: <d1c9371289fa2823e032a489925ad03f@paul-moore.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Mon, 16 Dec 2024 17:42:02 +1100
Message-ID: <CA+zpnLeQqsJ+WwAZGe_pfBTpzV9ZsjQHm45uPVEH1H6-Jw2qgg@mail.gmail.com>
Subject: Re: [PATCH] selinux: match extended permissions to their base permissions
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Jeffrey Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 1:27=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Dec  4, 2024 "=3D?UTF-8?q?Thi=3DC3=3DA9baud=3D20Weksteen?=3D" <tweek@g=
oogle.com> wrote:
> >
> > In commit d1d991efaf34 ("selinux: Add netlink xperm support") a new
> > extended permission was added ("nlmsg"). This was the second extended
> > permission implemented in selinux ("ioctl" being the first one).
> >
> > Extended permissions are associated with a base permission. It was foun=
d
> > that, in the access vector cache (avc), the extended permission did not
> > keep track of its base permission. This is an issue for a domain that i=
s
> > using both extended permissions (i.e., a domain calling ioctl() on a
> > netlink socket). In this case, the extended permissions were
> > overlapping.
> >
> > Keep track of the base permission in the cache. A new field "base_perm"
> > is added to struct extended_perms_decision to make sure that the
> > extended permission refers to the correct policy permission. A new fiel=
d
> > "base_perms" is added to struct extended_perms to quickly decide if
> > extended permissions apply.
> >
> > While it is in theory possible to retrieve the base permission from the
> > access vector, the same base permission may not be mapped to the same
> > bit for each class (e.g., "nlmsg" is mapped to a different bit for
> > "netlink_route_socket" and "netlink_audit_socket"). Instead, use a
> > constant (AVC_EXT_IOCTL or AVC_EXT_NLMSG) provided by the caller.
> >
> > Fixes: d1d991efaf34 ("selinux: Add netlink xperm support")
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > ---
> >  security/selinux/avc.c              | 61 ++++++++++++++++-------------
> >  security/selinux/hooks.c            |  6 +--
> >  security/selinux/include/avc.h      |  5 ++-
> >  security/selinux/include/security.h |  3 ++
> >  security/selinux/ss/services.c      | 23 ++++++++++-
> >  5 files changed, 65 insertions(+), 33 deletions(-)
>
> Just to make sure we are on the same page with this, my opinion is that
> this should go up to Linus during the v6.13-rcX cycle as part of
> selinux/stable-6.13, but not marked for the stable kernels as the netlink
> xperm support was first added in v6.13-rc1; does that sound right to you?

Thanks Paul. Yes, that sounds right.

>
> > diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> > index cc0b0af20296..1f2680bcc43a 100644
> > --- a/security/selinux/avc.c
> > +++ b/security/selinux/avc.c
> > @@ -174,13 +174,15 @@ int avc_get_hash_stats(char *page)
> >   * using a linked list for extended_perms_decision lookup because the =
list is
> >   * always small. i.e. less than 5, typically 1
> >   */
> > -static struct extended_perms_decision *avc_xperms_decision_lookup(u8 d=
river,
> > -                                     struct avc_xperms_node *xp_node)
> > +static struct extended_perms_decision *
> > +avc_xperms_decision_lookup(u8 driver, u8 base_perm,
> > +                        struct avc_xperms_node *xp_node)
> >  {
> >       struct avc_xperms_decision_node *xpd_node;
> >
> >       list_for_each_entry(xpd_node, &xp_node->xpd_head, xpd_list) {
> > -             if (xpd_node->xpd.driver =3D=3D driver)
> > +             if (xpd_node->xpd.driver =3D=3D driver &&
> > +                 xpd_node->xpd.base_perm =3D=3D base_perm)
> >                       return &xpd_node->xpd;
> >       }
> >       return NULL;
> > @@ -205,11 +207,12 @@ avc_xperms_has_perm(struct extended_perms_decisio=
n *xpd,
> >  }
> >
> >  static void avc_xperms_allow_perm(struct avc_xperms_node *xp_node,
> > -                             u8 driver, u8 perm)
> > +                               u8 driver, u8 base_perm, u8 perm)
> >  {
> >       struct extended_perms_decision *xpd;
> >       security_xperm_set(xp_node->xp.drivers.p, driver);
> > -     xpd =3D avc_xperms_decision_lookup(driver, xp_node);
> > +     xp_node->xp.base_perms |=3D base_perm;
>
> Should this be a "=3D base_perm" instead of a "|=3D base_perm"?  Would th=
is
> work with multiple base_perm values?  Would we want it to work for
> multiple base_perm values?
>
> These questions also applies to similar logic later in the patch.

I believe this is correct. This part should be able to work with
multiple base_perm values. Here, base_perms act as a bitmap of all the
extended permissions that are defined for this avc_entry. A few
examples: for a netlink route socket with defined nlmsg extended
permissions, this would be just AVC_EXT_NLMSG; for a device which has
ioctl extended permissions defined, that would be AVC_EXT_IOCTL; and
for a netlink socket with both ioctl and nlmsg extended permissions
defined, it would be (AVC_EXT_IOCTL|AVC_EXT_NLMSG).

xp.base_perms is an early indicator to know if there might be some
extended permissions defined. If this is not matching, great, we can
return early. Otherwise, we'll have to go through the decision nodes
to find the relevant node. base_perms is a similar optimization as
xp.drivers, which keeps a bitmap of the drivers we know we may have
some policy for.

> > +     xpd =3D avc_xperms_decision_lookup(driver, base_perm, xp_node);
> >       if (xpd && xpd->allowed)
> >               security_xperm_set(xpd->allowed->p, perm);
> >  }
> > @@ -245,6 +248,7 @@ static void avc_xperms_free(struct avc_xperms_node =
*xp_node)
> >  static void avc_copy_xperms_decision(struct extended_perms_decision *d=
est,
> >                                       struct extended_perms_decision *s=
rc)
> >  {
> > +     dest->base_perm =3D src->base_perm;
> >       dest->driver =3D src->driver;
> >       dest->used =3D src->used;
> >       if (dest->used & XPERMS_ALLOWED)
> > @@ -272,6 +276,7 @@ static inline void avc_quick_copy_xperms_decision(u=
8 perm,
> >        */
> >       u8 i =3D perm >> 5;
> >
> > +     dest->base_perm =3D src->base_perm;
> >       dest->used =3D src->used;
> >       if (dest->used & XPERMS_ALLOWED)
> >               dest->allowed->p[i] =3D src->allowed->p[i];
> > @@ -357,6 +362,7 @@ static int avc_xperms_populate(struct avc_node *nod=
e,
> >
> >       memcpy(dest->xp.drivers.p, src->xp.drivers.p, sizeof(dest->xp.dri=
vers.p));
> >       dest->xp.len =3D src->xp.len;
> > +     dest->xp.base_perms =3D src->xp.base_perms;
> >
> >       /* for each source xpd allocate a destination xpd and copy */
> >       list_for_each_entry(src_xpd, &src->xpd_head, xpd_list) {
> > @@ -807,6 +813,7 @@ int __init avc_add_callback(int (*callback)(u32 eve=
nt), u32 events)
> >   * @event : Updating event
> >   * @perms : Permission mask bits
> >   * @driver: xperm driver information
> > + * @base_perm: the base permission associated with the extended permis=
sion
> >   * @xperm: xperm permissions
> >   * @ssid: AVC entry source sid
> >   * @tsid: AVC entry target sid
> > @@ -820,10 +827,9 @@ int __init avc_add_callback(int (*callback)(u32 ev=
ent), u32 events)
> >   * otherwise, this function updates the AVC entry. The original AVC-en=
try object
> >   * will release later by RCU.
> >   */
> > -static int avc_update_node(u32 event, u32 perms, u8 driver, u8 xperm, =
u32 ssid,
> > -                        u32 tsid, u16 tclass, u32 seqno,
> > -                        struct extended_perms_decision *xpd,
> > -                        u32 flags)
> > +static int avc_update_node(u32 event, u32 perms, u8 driver, u8 base_pe=
rm,
> > +                        u8 xperm, u32 ssid, u32 tsid, u16 tclass, u32 =
seqno,
> > +                        struct extended_perms_decision *xpd, u32 flags=
)
> >  {
> >       u32 hvalue;
> >       int rc =3D 0;
> > @@ -880,7 +886,7 @@ static int avc_update_node(u32 event, u32 perms, u8=
 driver, u8 xperm, u32 ssid,
> >       case AVC_CALLBACK_GRANT:
> >               node->ae.avd.allowed |=3D perms;
> >               if (node->ae.xp_node && (flags & AVC_EXTENDED_PERMS))
> > -                     avc_xperms_allow_perm(node->ae.xp_node, driver, x=
perm);
> > +                     avc_xperms_allow_perm(node->ae.xp_node, driver, b=
ase_perm, xperm);
> >               break;
> >       case AVC_CALLBACK_TRY_REVOKE:
> >       case AVC_CALLBACK_REVOKE:
> > @@ -987,10 +993,9 @@ static noinline void avc_compute_av(u32 ssid, u32 =
tsid, u16 tclass,
> >       avc_insert(ssid, tsid, tclass, avd, xp_node);
> >  }
> >
> > -static noinline int avc_denied(u32 ssid, u32 tsid,
> > -                            u16 tclass, u32 requested,
> > -                            u8 driver, u8 xperm, unsigned int flags,
> > -                            struct av_decision *avd)
> > +static noinline int avc_denied(u32 ssid, u32 tsid, u16 tclass, u32 req=
uested,
> > +                            u8 driver, u8 base_perm, u8 xperm,
> > +                            unsigned int flags, struct av_decision *av=
d)
> >  {
> >       if (flags & AVC_STRICT)
> >               return -EACCES;
> > @@ -999,7 +1004,7 @@ static noinline int avc_denied(u32 ssid, u32 tsid,
> >           !(avd->flags & AVD_FLAGS_PERMISSIVE))
> >               return -EACCES;
> >
> > -     avc_update_node(AVC_CALLBACK_GRANT, requested, driver,
> > +     avc_update_node(AVC_CALLBACK_GRANT, requested, driver, base_perm,
> >                       xperm, ssid, tsid, tclass, avd->seqno, NULL, flag=
s);
> >       return 0;
> >  }
> > @@ -1012,7 +1017,8 @@ static noinline int avc_denied(u32 ssid, u32 tsid=
,
> >   * driver field is used to specify which set contains the permission.
> >   */
> >  int avc_has_extended_perms(u32 ssid, u32 tsid, u16 tclass, u32 request=
ed,
> > -                        u8 driver, u8 xperm, struct common_audit_data =
*ad)
> > +                        u8 driver, u8 base_perm, u8 xperm,
> > +                        struct common_audit_data *ad)
> >  {
> >       struct avc_node *node;
> >       struct av_decision avd;
> > @@ -1047,22 +1053,23 @@ int avc_has_extended_perms(u32 ssid, u32 tsid, =
u16 tclass, u32 requested,
> >       local_xpd.auditallow =3D &auditallow;
> >       local_xpd.dontaudit =3D &dontaudit;
> >
> > -     xpd =3D avc_xperms_decision_lookup(driver, xp_node);
> > +     xpd =3D avc_xperms_decision_lookup(driver, base_perm, xp_node);
> >       if (unlikely(!xpd)) {
> >               /*
> >                * Compute the extended_perms_decision only if the driver
> > -              * is flagged
> > +              * is flagged and the base permission is known.
> >                */
> > -             if (!security_xperm_test(xp_node->xp.drivers.p, driver)) =
{
> > +             if (!security_xperm_test(xp_node->xp.drivers.p, driver) |=
|
> > +                 !(xp_node->xp.base_perms & base_perm)) {
> >                       avd.allowed &=3D ~requested;
> >                       goto decision;
> >               }
> >               rcu_read_unlock();
> > -             security_compute_xperms_decision(ssid, tsid, tclass,
> > -                                              driver, &local_xpd);
> > +             security_compute_xperms_decision(ssid, tsid, tclass, driv=
er,
> > +                                              base_perm, &local_xpd);
> >               rcu_read_lock();
> > -             avc_update_node(AVC_CALLBACK_ADD_XPERMS, requested,
> > -                             driver, xperm, ssid, tsid, tclass, avd.se=
qno,
> > +             avc_update_node(AVC_CALLBACK_ADD_XPERMS, requested, drive=
r,
> > +                             base_perm, xperm, ssid, tsid, tclass, avd=
.seqno,
> >                               &local_xpd, 0);
> >       } else {
> >               avc_quick_copy_xperms_decision(xperm, &local_xpd, xpd);
> > @@ -1075,8 +1082,8 @@ int avc_has_extended_perms(u32 ssid, u32 tsid, u1=
6 tclass, u32 requested,
> >  decision:
> >       denied =3D requested & ~(avd.allowed);
> >       if (unlikely(denied))
> > -             rc =3D avc_denied(ssid, tsid, tclass, requested,
> > -                             driver, xperm, AVC_EXTENDED_PERMS, &avd);
> > +             rc =3D avc_denied(ssid, tsid, tclass, requested, driver,
> > +                             base_perm, xperm, AVC_EXTENDED_PERMS, &av=
d);
> >
> >       rcu_read_unlock();
> >
> > @@ -1110,7 +1117,7 @@ static noinline int avc_perm_nonode(u32 ssid, u32=
 tsid, u16 tclass,
> >       avc_compute_av(ssid, tsid, tclass, avd, &xp_node);
> >       denied =3D requested & ~(avd->allowed);
> >       if (unlikely(denied))
> > -             return avc_denied(ssid, tsid, tclass, requested, 0, 0,
> > +             return avc_denied(ssid, tsid, tclass, requested, 0, 0, 0,
> >                                 flags, avd);
> >       return 0;
> >  }
> > @@ -1158,7 +1165,7 @@ inline int avc_has_perm_noaudit(u32 ssid, u32 tsi=
d,
> >       rcu_read_unlock();
> >
> >       if (unlikely(denied))
> > -             return avc_denied(ssid, tsid, tclass, requested, 0, 0,
> > +             return avc_denied(ssid, tsid, tclass, requested, 0, 0, 0,
> >                                 flags, avd);
> >       return 0;
> >  }
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index f5a08f94e094..011d9121b3ab 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3688,8 +3688,8 @@ static int ioctl_has_perm(const struct cred *cred=
, struct file *file,
> >               return 0;
> >
> >       isec =3D inode_security(inode);
> > -     rc =3D avc_has_extended_perms(ssid, isec->sid, isec->sclass,
> > -                                 requested, driver, xperm, &ad);
> > +     rc =3D avc_has_extended_perms(ssid, isec->sid, isec->sclass, requ=
ested,
> > +                                 driver, AVC_EXT_IOCTL, xperm, &ad);
> >  out:
> >       return rc;
> >  }
> > @@ -5952,7 +5952,7 @@ static int nlmsg_sock_has_extended_perms(struct s=
ock *sk, u32 perms, u16 nlmsg_t
> >       xperm =3D nlmsg_type & 0xff;
> >
> >       return avc_has_extended_perms(current_sid(), sksec->sid, sksec->s=
class,
> > -                     perms, driver, xperm, &ad);
> > +                                   perms, driver, AVC_EXT_NLMSG, xperm=
, &ad);
> >  }
> >
> >  static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
> > diff --git a/security/selinux/include/avc.h b/security/selinux/include/=
avc.h
> > index 96a614d47df8..281f40103663 100644
> > --- a/security/selinux/include/avc.h
> > +++ b/security/selinux/include/avc.h
> > @@ -136,8 +136,11 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid, u16 t=
class, u32 requested,
> >  int avc_has_perm(u32 ssid, u32 tsid, u16 tclass, u32 requested,
> >                struct common_audit_data *auditdata);
> >
> > +#define AVC_EXT_IOCTL        (1 << 0) /* Cache entry for an ioctl exte=
nded permission */
> > +#define AVC_EXT_NLMSG        (1 << 1) /* Cache entry for an nlmsg exte=
nded permission */
> >  int avc_has_extended_perms(u32 ssid, u32 tsid, u16 tclass, u32 request=
ed,
> > -                        u8 driver, u8 perm, struct common_audit_data *=
ad);
> > +                        u8 driver, u8 base_perm, u8 perm,
> > +                        struct common_audit_data *ad);
> >
> >  u32 avc_policy_seqno(void);
> >
> > diff --git a/security/selinux/include/security.h b/security/selinux/inc=
lude/security.h
> > index c7f2731abd03..0f6ff19d420c 100644
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -239,6 +239,7 @@ struct extended_perms_data {
> >  struct extended_perms_decision {
> >       u8 used;
> >       u8 driver;
> > +     u8 base_perm;
> >       struct extended_perms_data *allowed;
> >       struct extended_perms_data *auditallow;
> >       struct extended_perms_data *dontaudit;
> > @@ -247,6 +248,7 @@ struct extended_perms_decision {
> >  struct extended_perms {
> >       u16 len; /* length associated decision chain */
> >       struct extended_perms_data drivers; /* flag drivers that are used=
 */
> > +     u8 base_perms; /* which base permissions are covered */
>
> Would it be better to locate "base_perms" after "len", before "drivers"?

That makes sense. I'll update this part in the next version.

>
> >  };
> >
> >  /* definitions of av_decision.flags */
> > @@ -257,6 +259,7 @@ void security_compute_av(u32 ssid, u32 tsid, u16 tc=
lass,
> >                        struct extended_perms *xperms);
> >
> >  void security_compute_xperms_decision(u32 ssid, u32 tsid, u16 tclass, =
u8 driver,
> > +                                   u8 base_perm,
> >                                     struct extended_perms_decision *xpe=
rmd);
> >
> >  void security_compute_av_user(u32 ssid, u32 tsid, u16 tclass,
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/servi=
ces.c
> > index 971c45d576ba..04ac4138a8b7 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -582,7 +582,7 @@ static void type_attribute_bounds_av(struct policyd=
b *policydb,
> >  }
> >
> >  /*
> > - * Flag which drivers have permissions.
> > + * Flag which drivers have permissions and which base permissions are =
covered.
> >   */
> >  void services_compute_xperms_drivers(
> >               struct extended_perms *xperms,
> > @@ -592,12 +592,19 @@ void services_compute_xperms_drivers(
> >
> >       switch (node->datum.u.xperms->specified) {
> >       case AVTAB_XPERMS_IOCTLDRIVER:
> > +             xperms->base_perms |=3D AVC_EXT_IOCTL;
> >               /* if one or more driver has all permissions allowed */
> >               for (i =3D 0; i < ARRAY_SIZE(xperms->drivers.p); i++)
> >                       xperms->drivers.p[i] |=3D node->datum.u.xperms->p=
erms.p[i];
> >               break;
> >       case AVTAB_XPERMS_IOCTLFUNCTION:
> > +             xperms->base_perms |=3D AVC_EXT_IOCTL;
> > +             /* if allowing permissions within a driver */
> > +             security_xperm_set(xperms->drivers.p,
> > +                                     node->datum.u.xperms->driver);
> > +             break;
> >       case AVTAB_XPERMS_NLMSG:
> > +             xperms->base_perms |=3D AVC_EXT_NLMSG;
> >               /* if allowing permissions within a driver */
> >               security_xperm_set(xperms->drivers.p,
> >                                       node->datum.u.xperms->driver);
> > @@ -632,6 +639,7 @@ static void context_struct_compute_av(struct policy=
db *policydb,
> >       avd->auditdeny =3D 0xffffffff;
> >       if (xperms) {
> >               memset(&xperms->drivers, 0, sizeof(xperms->drivers));
> > +             xperms->base_perms =3D 0;
> >               xperms->len =3D 0;
>
> Are we better off replacing the above with one memset(), e.g.
> 'memset(xperms, 0, sizeof(*xperms))'?
>

Ack, that makes sense as well.

> >       }
> >
> > @@ -969,14 +977,23 @@ void services_compute_xperms_decision(struct exte=
nded_perms_decision *xpermd,
> >  {
> >       switch (node->datum.u.xperms->specified) {
> >       case AVTAB_XPERMS_IOCTLFUNCTION:
> > -     case AVTAB_XPERMS_NLMSG:
> >               if (xpermd->driver !=3D node->datum.u.xperms->driver)
> >                       return;
> > +             if (xpermd->base_perm !=3D AVC_EXT_IOCTL)
> > +                     return;
>
> Shouldn't we check the base_perm field before we check the driver field?
>
> The same question applies to the other cases below.
>

It shouldn't matter. In this first part of
services_compute_xperms_decision, we are trying to find a reason to
skip the avtab_node (that is, find a reason why this node doesn't
apply). Here, if this is not the right driver or if this is not the
right base permission, we should skip (aka return). I can merge both
"if" if that helps with the readability maybe.

> >               break;
> >       case AVTAB_XPERMS_IOCTLDRIVER:
> >               if (!security_xperm_test(node->datum.u.xperms->perms.p,
> >                                       xpermd->driver))
> >                       return;
> > +             if (xpermd->base_perm !=3D AVC_EXT_IOCTL)
> > +                     return;
> > +             break;
> > +     case AVTAB_XPERMS_NLMSG:
> > +             if (xpermd->driver !=3D node->datum.u.xperms->driver)
> > +                     return;
> > +             if (xpermd->base_perm !=3D AVC_EXT_NLMSG)
> > +                     return;
> >               break;
> >       default:
> >               BUG();
> > @@ -1006,6 +1023,7 @@ void security_compute_xperms_decision(u32 ssid,
> >                                     u32 tsid,
> >                                     u16 orig_tclass,
> >                                     u8 driver,
> > +                                   u8 base_perm,
> >                                     struct extended_perms_decision *xpe=
rmd)
> >  {
> >       struct selinux_policy *policy;
> > @@ -1019,6 +1037,7 @@ void security_compute_xperms_decision(u32 ssid,
> >       struct ebitmap_node *snode, *tnode;
> >       unsigned int i, j;
> >
> > +     xpermd->base_perm =3D base_perm;
> >       xpermd->driver =3D driver;
> >       xpermd->used =3D 0;
> >       memset(xpermd->allowed->p, 0, sizeof(xpermd->allowed->p));
> > --
> > 2.47.0.338.g60cca15819-goog
>
> --
> paul-moore.com
