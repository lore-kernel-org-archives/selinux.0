Received: from mail-oo2-f35.google.com (mail-oo2-f35.google.com [74.125.231.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A2636E477
	for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736115; cv=pass; b=LoUOBPQA20CFHE7IUS8nRWd7BWrUzgbF1sBDSKw9tAX/8nyN3jUkbOJUteONrRh6jFytczNWUk0UJxL91CNm6xWyCPcWOqYh6MV1U3sdCXvqr3I9Sp2f+0zStbtmA9yQ5xW2L0k7AKS0PrHb+BBpUzGij7VClMK+DdCIlVk3qWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736115; c=relaxed/simple;
	bh=70naieZ3UsrNuhQQREPLWPaGB9WxsbhUKdI7BXo5+wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pbdng1XhkA+g45/sP6S7V94mnQKPl5Ws9n6lHj8Ul8Y0sfLLbFF21zc8IcBnU1KkURWUeodsKe7VxOaMYvwPMJZ7kdp0YIKsxEpJj2pLbO7JijKBKA2DmLZPZr7ThtAdvpXP3hKLC5AOntXUP8wB61aygkI1aNzJpncVdDMLiT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSm0ElPl; arc=pass smtp.client-ip=74.125.231.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSm0ElPl"
Received: by mail-oo2-f35.google.com with SMTP id 006d021491bc7-6b1ae736c64so492010eaf.2
        for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 05:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789736111; cv=none;
        d=google.com; s=arc-20260327;
        b=gBCGhsA120E9qD4dudO/MWny0BLkrRoUj88vL/4RaxXbsZRi0dMt1kRbt0C5aDrizP
         +anxIIZgCQBJ+DfuP0u20hd6K59Z8ts811wtBgk84sMyKtBCNtgr/LBskBhTqG+lcMpH
         81oacU5zzraXiPdCCovzJjdpnS004wuK224xxjC+19Gu5BVbsC0n7qDtQMzxqdBr6hEu
         mdQ6b+ZeYyevs8pevkNOkBpYDagNgpd2uh726awJMU2srQKw9QV68F8vCjjRx0CgI4YB
         lSqVZ88M9droM1vgcCm8bUFAstRltOzFgWcZBQSkohoQVYg1JFgcPl0+44UWN9wlBFxZ
         Fpqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fznDqvZ8t6eixLAtS8PczvzvzI12PcGWxlPk+YO8Zrw=;
        fh=OjrGsL+jUfliajWZCBAb9atq/Vsmsl6YorbWUSBRnCM=;
        b=e7VCjwqrCri7h3gb5KTlBmUHkxGv4nzPevkN2Qc0ULci/HBh+HDH4d73OU0GSrdrIy
         +DplT++97mHw/e/LMtWvhQQYoppLxRoWU4H7p1HyHSICosUtizF1w5vUyDr/KIuF6HRN
         qnHn+eIFBra7mutBe+5vxdWBQeh0CJ0zTHi5dkmTTMH/HvwNFnazM/EO+3ayCJlwimh2
         PFSbLT9dI3F6A2++s7Y/TpVNoZb03TnLBdAD/7IPBJngU5yJfhA19fPtLHGK7MXQkyBb
         xDdxtFA0/JLCdoiHoSuXtflXwaw/kkV+CaQpwyr72bzWDJSPtzWdagbORdwS4L/rgbem
         kgeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789736111; x=1790340911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fznDqvZ8t6eixLAtS8PczvzvzI12PcGWxlPk+YO8Zrw=;
        b=NSm0ElPlInhxG6Pxo95JhcxY8060Tic1braxVPvq06Gz7R4EgcPZV78ldtU42ToBcr
         E1afl9Zm4e5wkbuAJkBHnKZ8cm6nJFPdeebctEHEhfMAgwoCJVqgo1ITPIfZvaXcI+TF
         lmYzPVO2Zhe5wYodrTw2EqMmhEsxa9KBYUVZ9fsLy7r1TvlMQsT77UCnAyHOOW4/pl9x
         4ZO3cW9JyVe93jdWwS4bnFp9cJ4s1OIDpMkcxJc4D/gdbkq1sSUIINtLtfo9sxm8eaFq
         eOY2iIxwyr3hXZsN+IWxWyb8q9I9mZIaKEWBeZzJLqauCILVbt3lnc3vsSTtgXM56CfS
         fjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789736111; x=1790340911;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fznDqvZ8t6eixLAtS8PczvzvzI12PcGWxlPk+YO8Zrw=;
        b=Tfwp1zhov8p1+pRYuHv3Scn5CerhrOov0ILGrp+ubxRVJTC00KWMfO8HL1KPHK+XUR
         NbgFxZaFL1iEG0mSSReBnwK7pn4UOBlixDmE3OM58db1Mibwc2haGg0EwA0+Cph2qhTZ
         HO1k0cp7V1niG1h/dG4OzZHq4CGzMLNn0fti7h2L9tlCD+6Dp65SpcJOXysay7YUN7mB
         z4bx8Ff/SSnKl2PtqvNgAQlvKzHeLyIN6+/tW0OiFGUoaJo4EcHsNL4sYfxavJQ/JMRw
         q9SFfQvXGDak5g0LN6y00E2xOB6n6WFoOwHXf1NOuCCy8Pju170drYzUC62COikMYM2L
         poRQ==
X-Gm-Message-State: AFuF++kJ4lpb9v7O1ERBxskkkIzzAFUfebcm674heP8tiDLAdpf+BaMA
	Q1eEQiFXD5IcOM+2nu3oATUp8hc5tdlGiJSbBNnIv20f3ulChtehvu+DAX4RnjC7iwGCw7wkhRo
	P2UfOE9dPJt2ZCcbsDCgmBYQz5M00wvY=
X-Gm-Gg: AYBFou0CkiDLLXs8TayiVeQXRNuMOQGqLIaCAKCnxSM2t3PY0p0wmM8C/amCNYt95BR
	3mBKgjrNRw2ECGZdc/1p9X0WwpiTFKkbPSoT/VLZlNoPmbCQPRgNjYbHm3jDCHL3Mzp5F3jwV9i
	p0vTo4nIgSvAwQOa6F6hRNustwlZzg84xSI8dBdddxf6309X5o/tt6nCZXinTjESMP13/pxNhs0
	Sv98wqM29Xkn3b3tc6gcHO67nu2yrlD3P35R6HuWDIeTMm86v1Elo6a4JyqFU+JwcXYC+nPj6i5
	XxQ0BgRGrsuDZA7ZX0cF1ZsHO2m98/KM/ZfnzDYOilEr/dfPgvhBWas=
X-Received: by 2002:a05:6820:1c9c:b0:6c0:c954:e534 with SMTP id
 006d021491bc7-6ca9c0597e2mr2266667eaf.38.1789736111293; Fri, 18 Sep 2026
 05:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916194824.37332-1-stephen.smalley.work@gmail.com> <20260918-kernbereich-altkleider-gespuckt-3b9488e49810@brauner>
In-Reply-To: <20260918-kernbereich-altkleider-gespuckt-3b9488e49810@brauner>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 18 Sep 2026 08:55:00 -0400
X-Gm-Features: AcwNN1UhxtwoSIE8m7i0Ih2QsSeuF7_CCE4neiBP84u9kEww775wYy8_yIPLYNs
Message-ID: <CAEjxPJ5dQ1khsycqtuFw_3DH=VMjnpxGgcqBs8gr1B_9VJnHgA@mail.gmail.com>
Subject: Re: [PATCH] lsm: initialize the security blob for the initial namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnacek@gmail.com, 
	linux-security-module@vger.kernel.org, mic@digikod.net, serge@hallyn.com, 
	jack@suse.cz, jmorris@namei.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 3:28=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Sep 16, 2026 at 03:48:24PM -0400, Stephen Smalley wrote:
> > Commit f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> > added a security blob to struct ns_common and allocates it from
> > __ns_common_init(). Most initial namespaces (init_user_ns,
> > init_uts_ns, init_pid_ns, init_mnt_ns, and, depending on
> > configuration, init_ipc_ns, init_cgroup_ns and init_time_ns) are
> > however set up statically via NS_COMMON_INIT() and never pass through
> > __ns_common_init(), so their ns_security pointer is left NULL for the
> > lifetime of the system. Any LSM that registers an lbs_ns blob and
> > dereferences its slice on one of those namespaces (for example from
> > the namespace_install hook when a task setns()'s back into an initial
> > namespace) will fault.
> >
> > Allocate the blob and run the namespace_init hook for each of these
> > namespaces at the end of security_init(), after all ordered LSMs have
> > registered their hooks, so every LSM sees the initial namespaces the
> > same way it sees init_net (which is initialized at runtime via
> > ns_common_init(&init_net) from net_ns_init() immediately after
> > security_init()) and does not need to special-case them in its own
> > ->init() callback.
> >
> > Provide an init_ns_common_for_each() iterator in kernel/nscommon.c so
> > the list of statically-defined initial namespaces and their Kconfig
> > guards live next to the rest of the ns_common infrastructure. init_net
> > is intentionally excluded: pre-initializing it here would leak once
> > __ns_common_init() clears ns_security and re-allocates.
> >
> > Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  include/linux/ns_common.h |  1 +
> >  kernel/nscommon.c         | 45 +++++++++++++++++++++++++++++++++++++++
> >  security/lsm_init.c       | 11 ++++++++++
> >  3 files changed, 57 insertions(+)
> >
> > diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
> > index c8e227a3f9e2..742627000453 100644
> > --- a/include/linux/ns_common.h
> > +++ b/include/linux/ns_common.h
> > @@ -11,6 +11,7 @@
> >  bool is_current_namespace(struct ns_common *ns);
> >  int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct p=
roc_ns_operations *ops, int inum);
> >  void __ns_common_free(struct ns_common *ns);
> > +int init_ns_common_for_each(int (*fn)(struct ns_common *ns));
> >  struct ns_common *__must_check ns_owner(struct ns_common *ns);
> >
> >  static __always_inline bool is_ns_init_inum(const struct ns_common *ns=
)
> > diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> > index e72426bba29a..4f3cba5518d7 100644
> > --- a/kernel/nscommon.c
> > +++ b/kernel/nscommon.c
> > @@ -1,11 +1,17 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /* Copyright (c) 2025 Christian Brauner <brauner@kernel.org> */
> >
> > +#include <linux/cgroup.h>
> > +#include <linux/ipc_namespace.h>
> > +#include <linux/mnt_namespace.h>
> >  #include <linux/ns_common.h>
> >  #include <linux/nstree.h>
> > +#include <linux/pid_namespace.h>
> >  #include <linux/proc_ns.h>
> >  #include <linux/security.h>
> > +#include <linux/time_namespace.h>
> >  #include <linux/user_namespace.h>
> > +#include <linux/uts_namespace.h>
> >  #include <linux/vfsdebug.h>
> >
> >  #ifdef CONFIG_DEBUG_VFS
> > @@ -101,6 +107,45 @@ int __ns_common_init(struct ns_common *ns, u32 ns_=
type, const struct proc_ns_ope
> >       return 0;
> >  }
> >
> > +/**
> > + * init_ns_common_for_each - iterate the statically-defined initial na=
mespaces
> > + * @fn: callback invoked with each initial ns_common
> > + *
> > + * Walk the initial namespaces that are set up via NS_COMMON_INIT() at=
 compile
> > + * time and therefore never pass through __ns_common_init(). The initi=
al
> > + * network namespace is intentionally excluded: it is initialized at r=
untime
> > + * via ns_common_init(&init_net) from net_ns_init().
> > + *
> > + * Return: the first non-zero return from @fn, or 0.
> > + */
> > +int __init init_ns_common_for_each(int (*fn)(struct ns_common *ns))
> > +{
> > +     struct ns_common *set[] =3D {
> > +             to_ns_common(&init_user_ns),
> > +             to_ns_common(&init_uts_ns),
> > +             to_ns_common(&init_pid_ns),
> > +             from_mnt_ns(&init_mnt_ns),
> > +#if defined(CONFIG_POSIX_MQUEUE) || defined(CONFIG_SYSVIPC)
> > +             to_ns_common(&init_ipc_ns),
> > +#endif
> > +#ifdef CONFIG_CGROUPS
> > +             to_ns_common(&init_cgroup_ns),
> > +#endif
> > +#ifdef CONFIG_TIME_NS
> > +             to_ns_common(&init_time_ns),
> > +#endif
> > +     };
> > +     unsigned int i;
> > +     int ret;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(set); i++) {
> > +             ret =3D fn(set[i]);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +     return 0;
> > +}
> > +
> >  void __ns_common_free(struct ns_common *ns)
> >  {
> >       security_namespace_free(ns);
> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index dbda7771013b..60e15215f6bd 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -7,6 +7,7 @@
> >
> >  #include <linux/init.h>
> >  #include <linux/lsm_hooks.h>
> > +#include <linux/ns_common.h>
> >
> >  #include "lsm.h"
> >
> > @@ -490,6 +491,16 @@ int __init security_init(void)
> >               lsm_init_single(*lsm);
> >       }
> >
> > +     /*
> > +      * The initial namespaces are set up statically via NS_COMMON_INI=
T()
> > +      * and never pass through __ns_common_init(), so allocate their
> > +      * security blobs and run the namespace_init hooks now that all L=
SMs
> > +      * are registered. init_net is not covered here; it is initialize=
d
> > +      * at runtime from net_ns_init() shortly after security_init().
> > +      */
> > +     if (init_ns_common_for_each(security_namespace_init))
> > +             panic("initial LSM ns alloc failed\n");
>
> Wouldn't it be nicer to turn this around and call
> security_namespace_init from the ns common code and avoid the callback?
> Especially since there's only one.

Good idea. I'll send a v2 that does this.
