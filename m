Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786413D9DB1
	for <selinux@vger.kernel.org>; Wed,  8 Apr 2026 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672597; cv=pass; b=YSCacjDn0eG8/Y7BcxsTCXEZJyps5wkhm7JAy8gihMbjQlryqdk4shIXVzzmpvIA47Agssbh9plCHpWyorYWx5JwuCj2/HE/horcntxREkkdarUEXjp6R192SPq7ecqYrYPNhFgry4EStl+8F3Ms8TDE6l2iPjrb93R5j/o4UJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672597; c=relaxed/simple;
	bh=Kk2+dP44UCAXbh1I1BEijucJumgyTn1CfOLUdd2rsws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVXCMgNLmZKDn69VfGa6PnSw75En8GMCNX4EoiK6V1wN9T12mL92WOpFfh2QHFfSOEP0mooDjmxggYbz2DkcXGPxzmIyU9VLKsERBsmHSsRECCw9jhgXbQ/VrM6bV8jX0vz1vRxbfiAkJ1EzXhO1PtxLRf6w7W3XtrEN/CC7uBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEVnDsID; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEVnDsID"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aaed195901so354385ad.0
        for <selinux@vger.kernel.org>; Wed, 08 Apr 2026 11:23:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775672596; cv=none;
        d=google.com; s=arc-20240605;
        b=HBkNrbNnxr1F0aQu4DVfqofnaSEFf1Ti+NIsIPITpBBmLBD184ZpCBKU8mi0DTx/FM
         WTg6kmiabRb6Kv+6SbTsKA6raFg3GVmLYvirRbwj1X2s0VJxZg473CGFpKM4FlZIHnCk
         LrS69VuyoDovWhMaXpLQde30s5861zEgiG2fXbjJ/xf0PrHU6FgJj9LJ/hC3Ldp5YOFX
         p7BXg0Z7IQ/thgNcNeRqhwYjM5aXiluYMQXqoR7/sZ8IfeXwIZuJH5GkhAx0rautd1j9
         NhAIzPLWFvhwRSarFdDgObik1+vtbxVefWDSEhA1M/B59JkmOw7LVW7cU1ak0cKNXEYt
         HaaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=leq3cPTcAMRWmqjASpRrveogKnxWbRjBcRWMID4Uc3I=;
        fh=PQ9c0cqNZEx8z6DXNbb0bdcSA3mtTzKxO1NP01n5Va0=;
        b=fkoehZ8DZ6WQEs2wXRd5bAmRaNMcF5DhjjrXsjOvfEWO0svqiVei2JVeGjADkp0mm3
         Z4uxxMnf9LUcK0QcXS+s4bx1RYPOref7q1F9MVIweanzHZktctDRPnvcOx3YjvC8bqkb
         Eu6o5en6KbYtU0NM4cQUQW7g01IKwR1kXSHzhhb76RjxeFZIaAbngcQGXXXxDyeK3YVH
         xOcYj2QjE6MzZGehfD/h7X39eYpwrox7ONRtYqZjurdGdN9YFhXpqeGq/c3lwUXRUa4K
         Bz/5zC9r/GUKsEWqfgn8qG1IIsFt+uyiCoDCFskuoAM1362wORxJA0xyrUa+Y3daOrMk
         PKsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775672596; x=1776277396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leq3cPTcAMRWmqjASpRrveogKnxWbRjBcRWMID4Uc3I=;
        b=TEVnDsID8lAtc/UWJDkG1Xnb90ycuHJ0sM9lT6brTrcpQhHQ+0IFTwaKTGJDSvePXq
         gYytmCrYQ13YTO3xSu5oeXmsz1MTjLhH5R4yQS9aVfd65UJILuRE3NPnToGL1KpZwQXn
         Ee6raW/iUKQb9pKVdIYyDlsqjZt1FwEmzo01/c0Hc8pKTOwR0JvJFZQj8PaTxBEVHJEg
         z1WqS2TDce3arc/P6mDFL8CZkQgHtR7vuzx2MF8kv2WiXkNCVdBELI+m58kmCN4Q3/DY
         iXfj30bU09A0n3FRIFfrlGrAmrvZd0lQ/jKOXNGovzZrWDL67B9KBEtenJpy6+2XZeuh
         sdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775672596; x=1776277396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=leq3cPTcAMRWmqjASpRrveogKnxWbRjBcRWMID4Uc3I=;
        b=ADWYohn62jdfVk3wsORBjA7nm6CBHbvPASq76XifzmJA+bpDBEWwrBFkQxRVK1PFqi
         l6FtK+qSbB/mN2ei2SZk7gs+SphF3RS/citxlNz2lxWTIdLXlRNWak3SMBx1adGYwieI
         ExKLptr9UlRAjA0p6NIbwPzDPomMiQWIYpvfmu/92NDlQ/mKKtSYPTv7lz/1l7KaHUGd
         p8C/9PXDlcVIkMZtt4BG700Lt+ccyDum40eloPOlBAUOMzXGUZ350NbCAF/FY5sXHo5H
         /fcrmcINVZ2fxyGARXZVE5pBp3EiBAc8Hcqc34iJeSUnqEkWl2aXGOGg+9lZnAy4CFF6
         lzWA==
X-Gm-Message-State: AOJu0YynVFEYfza8EgVKEMN475AhGy9drbDPe4iPiJ+/v7jp6tmN+L4Y
	UONWp35QpGZc6XLo7MNF4Fc8mfPPYNt+uNt8VetcRBSU1ExXRUcIDrInea1am4KIlp29fgjBp4V
	qn7P8oVyqCAOf0zxaIVjyu9AgNQPQKqmA/g==
X-Gm-Gg: AeBDietgtdDFxnQBcB+T3U2n/Jw00q6c690v2cB+9ybKpUPqpQbmBvVK3LwJRIgDKOT
	Fr++iS+IWaEW8o8TUNpGpk0ZHw2cCkWLZkGaOtO5Y41X4gpvk3UNYuj6h5/y2VwEW9i3H67vp4d
	7Bh50qm/PVlZcRTpyiOTOga0Y7LuQJyObab9FZX9mL7kmxg0szXHJfiWbpMB+y0AKws4/gljt7g
	bNSZYnww19AM5arF1CoFwGxgXYfcdVPTfmkfO0PZlzSbaEHs0zzaYeFCnZMj1C+urjYPV9ao9O5
	QAGA7Fo=
X-Received: by 2002:a17:903:3b84:b0:2b0:4579:ae6 with SMTP id
 d9443c01a7336-2b28186a051mr205204855ad.38.1775672595771; Wed, 08 Apr 2026
 11:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408174510.16051-2-stephen.smalley.work@gmail.com> <CAHC9VhT29U5TGMNgqJ3xz7rW8xe0SEFHa-Tk8ngw=Zn1k3Fm_w@mail.gmail.com>
In-Reply-To: <CAHC9VhT29U5TGMNgqJ3xz7rW8xe0SEFHa-Tk8ngw=Zn1k3Fm_w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 8 Apr 2026 14:23:03 -0400
X-Gm-Features: AQROBzCjqzoHKwrRdOjHo-co7ieWR3mpj-1dL_cE6ihpXp7hwB9zCjShStKKQfY
Message-ID: <CAEjxPJ6S2QFWogwMB7itdLzFdesqygNK+Hz2PUvDB1Sj7JnPjQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: fix avdcache auditing
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 1:58=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Wed, Apr 8, 2026 at 1:45=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > The per-task avdcache was incorrectly saving and reusing the
> > audited vector computed by avc_audit_required() rather than
> > recomputing based on the currently requested permissions and
> > distinguishing the denied versus allowed cases. As a result,
> > some permission checks were not being audited, e.g.
> > directory write checks after a previously cached directory
> > search check. This manifests as unaudited permission denials
> > even after removing all dontaudit rules.
> >
> > Fixes: dde3a5d0f4dce ("selinux: move avdcache to per-task security stru=
ct")
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  security/selinux/hooks.c          | 25 +++++++++++++++----------
> >  security/selinux/include/objsec.h |  3 ++-
> >  2 files changed, 17 insertions(+), 11 deletions(-)
>
> Of course I hit send on my reply to your v1 patch only to see a v2 in
> my inbox :)
>
> Do you have a quick changelog of the changes between v1 and v2?  It
> looks like the inode permission code changed ...

v2 splits out the enforcing_enabled && !avdc->permissive test from the
unlikely(denied) test because we only set rc =3D -EACCES if enforcing
but we want to use the auditdeny vector for computing audited
regardless if this is a permission denial.

>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 6ef9c1aade65..c279ebdb3a33 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3185,15 +3185,13 @@ static inline int task_avdcache_search(struct t=
ask_security_struct *tsec,
> >   * @tsec: the task's security state
> >   * @isec: the inode associated with the cache entry
> >   * @avd: the AVD to cache
> > - * @audited: the permission audit bitmask to cache
> >   *
> > - * Update the AVD cache in @tsec with the @avdc and @audited info asso=
ciated
> > + * Update the AVD cache in @tsec with the @avd info associated
> >   * with @isec.
> >   */
> >  static inline void task_avdcache_update(struct task_security_struct *t=
sec,
> >                                         struct inode_security_struct *i=
sec,
> > -                                       struct av_decision *avd,
> > -                                       u32 audited)
> > +                                       struct av_decision *avd)
> >  {
> >         int spot;
> >
> > @@ -3205,7 +3203,8 @@ static inline void task_avdcache_update(struct ta=
sk_security_struct *tsec,
> >         spot =3D (tsec->avdcache.dir_spot + 1) & (TSEC_AVDC_DIR_SIZE - =
1);
> >         tsec->avdcache.dir_spot =3D spot;
> >         tsec->avdcache.dir[spot].isid =3D isec->sid;
> > -       tsec->avdcache.dir[spot].audited =3D audited;
> > +       tsec->avdcache.dir[spot].auditallow =3D avd->auditallow;
> > +       tsec->avdcache.dir[spot].auditdeny =3D avd->auditdeny;
> >         tsec->avdcache.dir[spot].allowed =3D avd->allowed;
> >         tsec->avdcache.dir[spot].permissive =3D avd->flags & AVD_FLAGS_=
PERMISSIVE;
> >         tsec->avdcache.permissive_neveraudit =3D
> > @@ -3249,11 +3248,17 @@ static int selinux_inode_permission(struct inod=
e *inode, int requested)
> >         rc =3D task_avdcache_search(tsec, isec, &avdc);
> >         if (likely(!rc)) {
> >                 /* Cache hit. */
> > -               audited =3D perms & avdc->audited;
> >                 denied =3D perms & ~avdc->allowed;
> > -               if (unlikely(denied && enforcing_enabled() &&
> > -                            !avdc->permissive))
> > -                       rc =3D -EACCES;
> > +               if (unlikely(denied)) {
> > +                       if (enforcing_enabled() && !avdc->permissive)
> > +                               rc =3D -EACCES;
> > +                       audited =3D denied & avdc->auditdeny;
> > +                       if ((requested & MAY_ACCESS) &&
> > +                               !(FILE__AUDIT_ACCESS & avdc->auditdeny)=
)
> > +                               audited =3D 0;
> > +               } else {
> > +                       audited =3D requested & avdc->auditallow;
> > +               }
> >         } else {
> >                 struct av_decision avd;
> >
> > @@ -3263,7 +3268,7 @@ static int selinux_inode_permission(struct inode =
*inode, int requested)
> >                 audited =3D avc_audit_required(perms, &avd, rc,
> >                         (requested & MAY_ACCESS) ? FILE__AUDIT_ACCESS :=
 0,
> >                         &denied);
> > -               task_avdcache_update(tsec, isec, &avd, audited);
> > +               task_avdcache_update(tsec, isec, &avd);
> >         }
> >
> >         if (likely(!audited))
> > diff --git a/security/selinux/include/objsec.h b/security/selinux/inclu=
de/objsec.h
> > index 5bddd28ea5cb..baf7564c6a2f 100644
> > --- a/security/selinux/include/objsec.h
> > +++ b/security/selinux/include/objsec.h
> > @@ -33,7 +33,8 @@
> >  struct avdc_entry {
> >         u32 isid; /* inode SID */
> >         u32 allowed; /* allowed permission bitmask */
> > -       u32 audited; /* audited permission bitmask */
> > +       u32 auditallow; /* auditallow permission bitmask */
> > +       u32 auditdeny; /* auditdeny aka ~dontaudit permission bitmask *=
/
> >         bool permissive; /* AVC permissive flag */
> >  };
> >
> > --
> > 2.53.0
>
> --
> paul-moore.com
