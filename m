Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7546B3D0BEC
	for <selinux@vger.kernel.org>; Thu,  1 Oct 2026 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865927; cv=pass; b=u0OVfasqUWo+2NwkZ34blIt0qTv88UfawkhkNBS5hR+wPlYI3KxKm2Rt7Gdr4mBHiEAh41aMn94Uqfcf1REp5dE7KJgDFpH4ymt2F0VB0qt+//YraaJLulVpwxQuxPIZ6o37b9/Epu2vI43hkYmhCJ61sp8j/IldCTXBNjQk/Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865927; c=relaxed/simple;
	bh=EfcIbf03CmVKFttZ3yqg/F6BHPn0/kcA4F5t3C0KCpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9+lVsalfXaOPGGZK6E0Q+xJaGDzdHmMuZUezPBF7BloZjuCtSsoreQkQitRJAmPhPK5Y2OUJ1wn4V9/hn2gJ3TGJ8ZezTyHJ5vMwdD0UoK2nfXClgplW89+OLBSZn6Mpqzs7RHYeFzILwV273mP6guE0tbNJcTopDKMXYjPB4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlZ601Yh; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlZ601Yh"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43ac8d1eso62604577b3.2
        for <selinux@vger.kernel.org>; Thu, 01 Oct 2026 07:45:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790865925; cv=none;
        d=google.com; s=arc-20260327;
        b=P4WEJ+i+z5DF2KWYNXfdbtsanopiYMwIPbLyiV+TOEPPFVBEylqiDKBV2mdoqegVfP
         l69GwLpnRQ/qcNNZLfwpW6j6JKNesv7anIjLan1lpDrubP2zfrrubBhxFQTl4K7ntRKB
         ZzMP5BtmB7E/K4eFNdzL3DB4S0QojguFAv63tFqEOSV9wOvPhnB2Xei+N3BBqMn295TQ
         eti+4k3uSjmTzp/ds7XjK9Z8+N4tVfS8MWBQ9FQDUwiZB3H4Z8Z1/eDpUcuzD1/LbVMa
         YxDMsT+uuPHsp39NuEodSBEGon+Vbm+pZVT15qzoobnxMimGCU1U/lC+KJf38PKlb17M
         yO3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P2GkljSPBf3wHrnohH+5fDAb/8miSiVkbPp9cPkU7bs=;
        fh=ljUYtV4DzuF0ps1+6FWelP9jOHsXGOCfPvwEijZReO0=;
        b=H0mS0DmI286vIMsHiOWL79BmLQ7+V1dB959jVDX3gafSp/QZz4Nxv1QapmEF+L7GJ+
         BXyNQbzh1sO+gcX88A3gywJsOOxlzJ3+JOOrv6td21QzDs1HsSrYxZPDIJ/LT0X1St2D
         iJJ5ObSItzv6XlLglVqJwT5Aq7s0Inay/+2XCVu+S7mwENxn/LzbdncTXQyoWoz6uNaP
         iYz9GvSMt0qhANbt2B+BdT2P+9JAvTcbQu9X6cr7DSuK6qWznJwj0WDHpPM/PbjcRDZY
         bvNZ0yCpnLqDqfQCSlYPO8VcH8/8GiVr0l8sOYi5iZGC02Cqq/1Y7cR+ZJMcrpSFLifr
         pYtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790865925; x=1791470725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P2GkljSPBf3wHrnohH+5fDAb/8miSiVkbPp9cPkU7bs=;
        b=GlZ601YhWbv1zEVT5kWI9vEX6KuE0tljjKyyhejkWF2L+ZFdz2D9ICFDBe4aqmH4jU
         nmnG5cRHs53nSt4733goIKTtp+LwQ2dCI8p+yb3i6T2glNUFBsEWKoq/Utc8s5uCePov
         EyMnM/QwHs9g2z3gSQBYkI8v2nUbwjmnplSGaA4C8uGjaIGTPGRvadFvoDhKg0KAZzAe
         Mcm1iUYv2INjUdfWpcXPZSF+hSzkOmtz4DG7mNAO4UdesFAsY5fEcTcT/hO2M228KbGP
         oFaw0A2U4Y3/GUychr7PZ9wLU0tbWFX7oQd5e6rjFl1Er8roZPbYsFqyTc1Wq4rHp3YC
         uG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790865925; x=1791470725;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P2GkljSPBf3wHrnohH+5fDAb/8miSiVkbPp9cPkU7bs=;
        b=FogOGajw+m/YNl1XDGSleInWegZsQbwI8QmxFBVwxD71ZvPIL9hpP1RtJ4KRYtJd1P
         3lSVyCIi2jA4w07LH53iUrZCM6CDEI/a4n5+zpoO6ROlWunf6ABaAcTxj15SGNhrJNl4
         xSqA92oSHUf1BxRH5Kns+M9C8TBW89DTb50/NmRRhYGubXFQuB88bY0QTmD7H/248oIz
         wgtKkksGobB2mQlwD+YLoBDpYKfdDcTpzJyh+uXNWFL0wQcmZUEl/55jQpbCNRfNI6LY
         181gjEgbX7OLy2ewF7BYkwCVPlK7+bxWnO9MpVyXneY/K9fKL6WvGBJdSIYXl2tUjM4K
         1O0w==
X-Gm-Message-State: AFq9FYICAQzb74sthkRjbe1e+Kw9dBhZUu2Qa4NIwaP2ObDwxxANhKFP
	sraQQmJvzGAb6bCKmAYRryXLsmGxQ5qK6+TqBWbwOInWGex9MzF4T5Ao/CtlnwYZeABmszGotih
	4KgQhdbm6Dctu/GNS2ajxYyg7GP/0wxQ=
X-Gm-Gg: AYBFou3d2BDHSi33q6qm3HxgWppkL2xXJmHeebqp6UlSDe1J9pAVTqP7XXgBRK0zldo
	S3hq9P0RRYc8D6xb3TN8OG99VPpwQYMaGop8bMas6NXUSVCvVZ4dVM2OT7Txbui1rWdP5j3S3x+
	2Y+4TFf0Ly2umazZ2R/6TNj6e3YsdqooW++yoEp0Ym2YKgfxPudAXixdjkHTH21tY1vWOpvSC50
	owgjdyawuqSk9zhDkD9tV/20r5hDbTEw1PxgQ+VyL4gF4rDgqOovnQo950HXr2UczCHlr+t46qP
	xLjnQsnx/ofQe4g9bhMrj6M28BFSalnAc0F69C8GXpAGVS9QYB+AC9M=
X-Received: by 2002:a05:690c:6904:b0:8ab:37e5:6678 with SMTP id
 00721157ae682-8ac93fe414fmr24049327b3.44.1790865925256; Thu, 01 Oct 2026
 07:45:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6ab19069-a348-42d0-89c3-3387b5d38c30@debian.org>
 <CAEjxPJ7_=ky-iy-6UHPS-Mh7GKc=BA-zyA4p96uKM3HEFEc=sg@mail.gmail.com> <CAEjxPJ4LTaiSc37j1bYwUkC04+BLaXVz5xArRRGEvf3rHQS7+A@mail.gmail.com>
In-Reply-To: <CAEjxPJ4LTaiSc37j1bYwUkC04+BLaXVz5xArRRGEvf3rHQS7+A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 1 Oct 2026 10:45:13 -0400
X-Gm-Features: AclHuK9mh5-7gFw2IS1-SjntUruoYYwd_ghRuy-V5F0bZ2PDr9DGk1b393FEqvo
Message-ID: <CAEjxPJ6FBdnHvUmXfD7WNgsFRLy3JuFHkwN4p0=9Wm82L2nZXQ@mail.gmail.com>
Subject: Re: selinux_kernfs_init_security() ignores genfscon-resolved parent
 label, breaks type_transition on cgroup2/sysfs
To: Laurent Bigonville <bigon@debian.org>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 10:22=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Sep 18, 2026 at 11:46=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Sep 18, 2026 at 6:44=E2=80=AFAM Laurent Bigonville <bigon@debia=
n.org> wrote:
> > >
> > > Hello,
> > >
> > > The other day I tried to troubleshoot (assisted with AI) why
> > > "memory.pressure" files in the cgroup2 hierarchy were never getting
> > > labeled memory_pressure_t, despite refpolicy defining:
> > >
> > >    type_transition init_t cgroup_t:file memory_pressure_t "memory.pre=
ssure";
> > >
> > > My understanding: selinux_kernfs_init_security() decides whether to
> > > compute a transition for a new child by checking kernfs_xattr_get() o=
n
> > > the parent =E2=80=94 kernfs's own private, per-node xattr store =E2=
=80=94 and bails out
> > > immediately if that returns -ENODATA. But /sys/fs/cgroup (and everyth=
ing
> > > under it) is still labeled cgroup_t for every other SELinux purpose,
> > > including plain getxattr()/getfilecon() =E2=80=94 that value comes fr=
om a
> > > genfscon rule, resolved live, with no real stored xattr ever involved=
.
> > > So the parent "has a label" as far as policy and every other check is
> > > concerned, but not as far as this one specific kernel check is
> > > concerned, and the type_transition never fires as a result.
> > >
> > > A simple way to confirm: force a real xattr to get persisted (e.g. ch=
con
> > > system_u:object_r:cgroup_t:s0 /sys/fs/cgroup/system.slice/) and then
> > > restart a service =E2=80=94 its memory.pressure then correctly shows =
up as
> > > memory_pressure_t.
> > >
> > > Tested on kernel 7.1.13 (Debian), refpolicy main branch,
> > > cgroup_seclabel/genfs_seclabel_wildcard policy caps active.
> > >
> > > Has anyone got a view on whether this is intentional, and whether it'=
d
> > > make sense for that check to fall back to a genfscon-resolved SID whe=
n
> > > there's no stored xattr on the parent?
> >
> > Added Ondrej to the cc as the originator of this hook, first
> > introduced by commit ec882da5cda9 "selinux: implement the
> > kernfs_init_security hook", which says "The hook applies the same
> > logic as selinux_determine_inode_label(), with the exception of the
> > super_block handling, which will be enforced on the actual inodes
> > later by other hooks."
> >
> > I think this mixed model of some files labeled by genfscon, others
> > explicit, directory hasn't been explicitly set wasn't possible or
> > considered at the time. If we were to change it, we'd need to check
> > for regressions not only on cgroup but all kernfs-based filesystems.
>
> So there are two possible fixes for this that wouldn't require any
> kernel changes:
> 1. Enable the genfs_seclabel_wildcard policy capability (libsepol
> 3.9+, kernel 6.16+) and add a genfscon cgroup2 "*/memory.pressure"
> rule in your policy.
> 2. chcon cgroup_t /sys/fs/cgroup at boot
>
> We could modify the kernel as well but that will require some
> additional plumbing beyond just modifying that one hook function. Can
> you just use one of the two approaches above?

I should note that only the first approach fully fixes the issue for
all paths by which memory.pressure might be created in sub-trees. The
second one won't fix that. So the purely policy-based approach is best
if you can require libsepol 3.9+ and kernel 6.16+.
