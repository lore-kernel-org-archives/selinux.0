Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F923C345D
	for <selinux@vger.kernel.org>; Thu,  1 Oct 2026 14:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790864550; cv=pass; b=LYGQW1EoWSAYoTQ2BBpgOOp0SlG3BVgxNekgz8BmuIgp8OvVfm25hcLxvH7OS4BCn6cbsuqZwhKb+UNOueGxYlj+N1I4EMiWUZXSQumT0jqV8THm44NPS9bMlQCKYvjKejEJwACea0YNheIlRcwh8A6kcV2OcRj6+M5xp4dlCcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790864550; c=relaxed/simple;
	bh=/s4CRjVdNntDevuWMj9YCJs0HJEAg/yUIO9RPJiKR48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLCzB9GnvbtlsQ3gd/a0yp34ixTzCngB2J5McAIG0yr4MYAnDS32GCXCWc9Sqo+p6DDM2yqBNYD50z2rm9K+MHlMun2hc8ayrJX8lSKwr+pGKi6N+97ja3COiccMvEQT6+nLQjHxVsigj30GHUGKtt8YRVNGRze+Pn+WVRHLER4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffyE+1Ml; arc=pass smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffyE+1Ml"
Received: by mail-yx2-f41.google.com with SMTP id 00721157ae682-8a860e532eeso63307457b3.3
        for <selinux@vger.kernel.org>; Thu, 01 Oct 2026 07:22:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790864547; cv=none;
        d=google.com; s=arc-20260327;
        b=l1ySsPa79yUcdtuStSvVrXGocIk/wI5zMH4JyPh4HzXDjRh6jQyPo99F1XfV7iLtdX
         u5ntsbk8NmBlZJSbvFqHgl9TlCy+pz0BqNJHp5Lci+vtzKl0CNTreG1m81g+jY3N8t5y
         PMVM+YRhmRd9FSwW26eNfvKxX/eTqUcbFD3aZ+azoQUub2WLW3qp1YmNcCh1mDSWKOaQ
         rjOgO6RLcCKPBeCns8HRTtBkujc8VtaByvn8WsWeFuvAYnJ1xaPQ1H+CbFL7tl1kjYrt
         UT+A00lCvuKCeIH8j8wnv0NBBKslds3zNUYmKgq3OwT3T10T75RvzRH32L1SKJcmQ8R7
         ontw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UBWGVCVTQcBx3WeQeBCc1vjMHlHFkbot8wQJtHKgqI0=;
        fh=ljUYtV4DzuF0ps1+6FWelP9jOHsXGOCfPvwEijZReO0=;
        b=P4yKgmgmIoKZzGSmQRDy/w26mlofuVjIkC3AGsqipc5kJ8YjJ2/fPJiqGkTjyAabHv
         qIpRdXhHSWqr22lC4c77hbTNRM7DKTeTtY/gL0thZAn8MDaVKI6z6rIQfvHGnkFfgNt6
         lTxtTiZVOuIxgFHzyjO7zBVkLzYfFNUkJXFiAIoaLX//Eu55/vwsFjFRH+zLbH6SQ8YM
         klCMWSjBtJRKyE0UghgQa1CggE5I7i/HwzLCsaycwpg8ki261rWTg+APqFVzzafMl9Lz
         ZMlMLd0W4CRnzSOofnQkgXbFh+jYx16u3APdWinjx4L5zAQ1/OzBEJeQdrhdmGdnPq8l
         eAuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790864547; x=1791469347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UBWGVCVTQcBx3WeQeBCc1vjMHlHFkbot8wQJtHKgqI0=;
        b=ffyE+1MlbDX6M8/UUFXPskODXQybrvdfjRHd5nTVqDMbLawknIyJZlMPacnJropwfk
         gXhSqWVbKpgle/pOv5hToGKr02BfcgwEe/8tmjpSj4kDSKdCPyd8FcCdqplf03gMJl9t
         bUxdsnUrQnXJS49ceN+f/q/05PoeyRorM4RlBig35fFUzBDgNF3FT4pk7RMFf/yCqLWL
         MhyxE40GWuJqG07ZxzIArgFraF3BNoQmv+uCvSBt6RinHF8QDNk8lcXNmJFm9cDmojbT
         X0zct6Kp2C5AaKaI3d8R/6uYnNdE611XGdFeUxdJzaVCRXMFRftqhiKQdNCfhrViajyf
         jPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790864547; x=1791469347;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UBWGVCVTQcBx3WeQeBCc1vjMHlHFkbot8wQJtHKgqI0=;
        b=zuzxGptILodNGvC7QJB9LEK0uo3QNjhYtIsEG+L2i525zk4Fqmiub71C6HDy/PlmPB
         PrwMzfBUavzdF0Lm/cr2xUhS0+WRHvXEa2LALcqAzrleBuT/QWQBKhjS8kwaQZgr4nQa
         I122BQ+Z8+whx6x9Y1BrU7769d+NCgc2pEXlVCYzUSqI2V/zO2HoR2JfdqANdkzw6pTu
         uaOiZ/yybxNp8PFgc2hUfme82EeAvJVkwAruKsjebYbjw7SEnT/jVyMAj4H8QnQpc76S
         mbPYYVTkRI7nFZXkfG5W7a5QyvaHooMZC0yxLaIVabC4u6W/90f37Jg6asxiE/vxbhod
         XZnw==
X-Gm-Message-State: AFq9FYKyU2dS0S5DbmO+pSZ7KHbd4ylkStB4EXm/TmWJ5c86Ch6v71KU
	wlaI9Y0KW4KDxJ21haigQcbds/ieWKD1/I2hwdJBk1ACqeoYr3LHdiZOUQxuaDjMrGf1FRZqDK9
	XcTJ+aN6FG+VvqMiyqaBK/jZLmGY7ft0=
X-Gm-Gg: AYBFou3gKNVrJGxHcTL/UidsuxAM8qI43/c+kLeZJzf7T81bbntVFEHP+GFwaPtdxU7
	mRcKOb+OwtONiu5nSHg746T4TlhV88klTOByn5srqg1tn9EGFbKvsfz1meTxcGUmH7q7BnF2vF7
	YppHX6GAVvKx3bgfDnxSmQIVKdoiBTTwG1g2mFJEA12+BabEtPopHes9+wtWoRAvxn2Di9ANRKF
	c7SBiTpG/9RbJTCirA0LRDKiTTVrQLzjLoR613+uT/aBHQGYFZ3d8y41EVVOLlJB3a1BTH4f+OT
	WnEVJlEdM4hgK77HJfMT2BtPVMWVj+96AJKRg2UM85h0RkDvsKQZO/I=
X-Received: by 2002:a05:690c:386:b0:8ab:3918:33c9 with SMTP id
 00721157ae682-8ac93cfa849mr21307217b3.96.1790864547400; Thu, 01 Oct 2026
 07:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6ab19069-a348-42d0-89c3-3387b5d38c30@debian.org> <CAEjxPJ7_=ky-iy-6UHPS-Mh7GKc=BA-zyA4p96uKM3HEFEc=sg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7_=ky-iy-6UHPS-Mh7GKc=BA-zyA4p96uKM3HEFEc=sg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 1 Oct 2026 10:22:16 -0400
X-Gm-Features: AclHuK8A6icZVhrrvA1L_OTVcN7cbKAOYrHj4mIXqL1m7lGAl2TEiwCcjSMwBIM
Message-ID: <CAEjxPJ4LTaiSc37j1bYwUkC04+BLaXVz5xArRRGEvf3rHQS7+A@mail.gmail.com>
Subject: Re: selinux_kernfs_init_security() ignores genfscon-resolved parent
 label, breaks type_transition on cgroup2/sysfs
To: Laurent Bigonville <bigon@debian.org>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 11:46=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Sep 18, 2026 at 6:44=E2=80=AFAM Laurent Bigonville <bigon@debian.=
org> wrote:
> >
> > Hello,
> >
> > The other day I tried to troubleshoot (assisted with AI) why
> > "memory.pressure" files in the cgroup2 hierarchy were never getting
> > labeled memory_pressure_t, despite refpolicy defining:
> >
> >    type_transition init_t cgroup_t:file memory_pressure_t "memory.press=
ure";
> >
> > My understanding: selinux_kernfs_init_security() decides whether to
> > compute a transition for a new child by checking kernfs_xattr_get() on
> > the parent =E2=80=94 kernfs's own private, per-node xattr store =E2=80=
=94 and bails out
> > immediately if that returns -ENODATA. But /sys/fs/cgroup (and everythin=
g
> > under it) is still labeled cgroup_t for every other SELinux purpose,
> > including plain getxattr()/getfilecon() =E2=80=94 that value comes from=
 a
> > genfscon rule, resolved live, with no real stored xattr ever involved.
> > So the parent "has a label" as far as policy and every other check is
> > concerned, but not as far as this one specific kernel check is
> > concerned, and the type_transition never fires as a result.
> >
> > A simple way to confirm: force a real xattr to get persisted (e.g. chco=
n
> > system_u:object_r:cgroup_t:s0 /sys/fs/cgroup/system.slice/) and then
> > restart a service =E2=80=94 its memory.pressure then correctly shows up=
 as
> > memory_pressure_t.
> >
> > Tested on kernel 7.1.13 (Debian), refpolicy main branch,
> > cgroup_seclabel/genfs_seclabel_wildcard policy caps active.
> >
> > Has anyone got a view on whether this is intentional, and whether it'd
> > make sense for that check to fall back to a genfscon-resolved SID when
> > there's no stored xattr on the parent?
>
> Added Ondrej to the cc as the originator of this hook, first
> introduced by commit ec882da5cda9 "selinux: implement the
> kernfs_init_security hook", which says "The hook applies the same
> logic as selinux_determine_inode_label(), with the exception of the
> super_block handling, which will be enforced on the actual inodes
> later by other hooks."
>
> I think this mixed model of some files labeled by genfscon, others
> explicit, directory hasn't been explicitly set wasn't possible or
> considered at the time. If we were to change it, we'd need to check
> for regressions not only on cgroup but all kernfs-based filesystems.

So there are two possible fixes for this that wouldn't require any
kernel changes:
1. Enable the genfs_seclabel_wildcard policy capability (libsepol
3.9+, kernel 6.16+) and add a genfscon cgroup2 "*/memory.pressure"
rule in your policy.
2. chcon cgroup_t /sys/fs/cgroup at boot

We could modify the kernel as well but that will require some
additional plumbing beyond just modifying that one hook function. Can
you just use one of the two approaches above?
