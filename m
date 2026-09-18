Received: from mail-oo2-f23.google.com (mail-oo2-f23.google.com [74.125.231.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B94FD7BA
	for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.151
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739730; cv=pass; b=V3HRJH2LF36+TEPz2UNi0eyc6GVzpyFMwB/Yyqk3HhYMnQQyW5XS6dVtt/zSHsy5bIuPc7Wr0Be2O1199kQUaQMEipz8Dcf/VEaeV8qgQANb9exDXoYkBuQ0LyjBUD8Jb5zl1EF0qwzQi8U+UdG0dGnz0W7uV2XmLDcVZV9ILo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739730; c=relaxed/simple;
	bh=rwTlp4Ke7VoBGKmaQ2Q4S8hUY7bacR9Zkn6kw0nnIhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AF4GNLCQwasXpGhUXdj/YRzk/+cV+Lniu4iggwi2ALpvUgVeFPfTXdmv7sfIzlhOGcih5KAPfaa6ntBcaSUEJ5m6jS2h3qr7RSi/pyskCGrtlvcP1D7hPoUc7ySye8Yly8Zg3PZKie12WtRGu90udxKdfpm64KOsHZHI/kQsP3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1A2daR+; arc=pass smtp.client-ip=74.125.231.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1A2daR+"
Received: by mail-oo2-f23.google.com with SMTP id 006d021491bc7-6c72bd8a02fso473094eaf.0
        for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 06:55:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789739721; cv=none;
        d=google.com; s=arc-20260327;
        b=ppF7A641zIg5JmBUIW6UfeDy2QqFiZmQ6SSI08iUmzXtUk+GWddflV9Vg3mDe74z1r
         0i6WTmlNTrU9GGhPrpeHIxeCzpgbbABGeBTVd/QCIp2nM7Qp78N5nEI3EKiRmN7YoLUA
         UwlZhOMl/ZJ5Jt68QyjyQ5P9nckwRBzVFLgeE1YkU9Pc07qWqq0EFA3OYZQpMWdvu65m
         Znc620pXuz4JmHYgT4hdye6r/+qkULg0QuATX8yCmMuZYl/ZfikyTZF9vJWCTWCwGglB
         O6JMNMzWZckjqx2zyTY2wk5NjLgKzFxAv20TY5tx6UBTIWwj/AoFcBz+LEjYt695BaFd
         h9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0wAUZdOFsq2U4/8UnTUuAJeCmFp6nbXI+dOS5+/R6Ro=;
        fh=OjrGsL+jUfliajWZCBAb9atq/Vsmsl6YorbWUSBRnCM=;
        b=sGT4knLCtw3jQoAMxqkDx6ZXJbu3HhQ7ddV78kwzSckUIlHmkUOk+R20hb9qv4ebS1
         a+s40ln8fpvc6hMjnANMENERmUYNXoDblW+kaiD9Q/UH1to7pB7QsWywBc/zAVar7yGy
         sHhjwz5oXw3XwOYN2Ujh0bJqVTbi2MLc1WcvIvV4eh2emWUL+Hzy8AxJaxhnBTu2FtSY
         DORLUPssMHvtycD6zOizkQlUhrJxToUfD2N9kyBT0vNeeVMgYfRlPXam/Wz2qX6j+DXz
         FwZTZlrhpUDRt6pOpyiQmAiDkRtQZOcN16SOLjRW9d3ZdxmgtNHDTQBdiVc2ZYwza7er
         fh5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789739721; x=1790344521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0wAUZdOFsq2U4/8UnTUuAJeCmFp6nbXI+dOS5+/R6Ro=;
        b=L1A2daR+j64zJbrzliDgz+98UGbrA98iiQZ00SJ23fn2aVfm/t+H+6+XLPNrVjEiNu
         KctuZoTaou+jEXXYyQq+p3d9v9VY2leAZHr9vrCRefhNcvujE8i61zeXkLgZRgw5kmdv
         +DCmMvox4NT8xilkc+4t0FXeaOPMOPmtds8DC+4USlR4uZCKNYOwaodZwf5VcaWFnv6q
         qAebgiwBeFm7deRU4wWLkyiqL4qK9FJCiunMngo5KO0WXHykGh/mg4mxuLsPBSSbnE8x
         COyg3291DFwJdSkdrh/IeNLO8+a2L1w2giy8hNuQlbz0iZAIerYOr+VaXJ/YldeGzGgR
         ZVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789739721; x=1790344521;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0wAUZdOFsq2U4/8UnTUuAJeCmFp6nbXI+dOS5+/R6Ro=;
        b=klOGZ8tayZqypUR58lRPU+WRI+5no+Nbc9VLvnTmxxNTzKDSbX4AIH5lzUz3srarGD
         dBuaNvrYBdy/Az8xnZK7xynwTByJgmUV9FH1Zx6Tv39Gg+wnbplSD5lhfsB1/GTD6/6o
         qlgThp7rU0tubuhvdTuS85D2bDUnvLlhjBjVOESqh9/FCnA2QZsjU0iGsvZa8l+0VNPw
         HY3yOJKmx+t2Hkj83oYnbI62VGJ4qnV0wCvYDg2go8GPwIPWodVM6fRHbfuYGPkQhN3T
         XhUtdR+iCLsOuHyEgHmP7snpE6ijODo0CjKyEyd9NdGrcA57enSRXEAxpodhgeLAslPM
         9xRA==
X-Gm-Message-State: AFuF++mDyjSaXEnyk3b++w1wQM35LMhNY57/wLTq3M03BEePQrVP9zjN
	suvF0eKAJ9V9QWieUebRKZo2CvSGQA9WtjpDyfQDHgo7SyVHGyDo/IJEkpqkVDZbEvdb5Gtb0X1
	qpG3xTUks0uq27Lcm9JE05ALDT6x3gB1fsw15
X-Gm-Gg: AYBFou1ii+gW8FB5T92eTeKOapTGIojU3KWKuqtDk4a6vIFWfGcBXl+7bR4z+LfGpAT
	83ImA4HNbsT+K+qGb19u7VHbAENZSFpsbkXfpGOZRhA9Su9+4hAtdRQM8ujoXl3twK2v0g2hvpy
	meT0mWXFaH0X8ZZbxJYmNpNMVaxqdC2HddMyKZPwVjmrEa09+iqUgiH+t1vBA2cgJRItGcp12Yo
	ogN0Wy3yK4lZLo+A8vVoNuJqmudNmzqHy0Doev6ytbF3qW1m0y2kWTq8GOpwTu2cQqBVPWJuYls
	vupxxyo1kHvZ8e2jeFS/qpZL9XYL0OeKtM7yOR87Uz8cpdTf7TBNlCk=
X-Received: by 2002:a05:6820:2219:b0:6b1:61b8:7ed5 with SMTP id
 006d021491bc7-6ca9a132698mr2237995eaf.1.1789739720789; Fri, 18 Sep 2026
 06:55:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916194824.37332-1-stephen.smalley.work@gmail.com>
 <20260918-kernbereich-altkleider-gespuckt-3b9488e49810@brauner> <CAEjxPJ5dQ1khsycqtuFw_3DH=VMjnpxGgcqBs8gr1B_9VJnHgA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5dQ1khsycqtuFw_3DH=VMjnpxGgcqBs8gr1B_9VJnHgA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 18 Sep 2026 09:55:10 -0400
X-Gm-Features: AcwNN1W2OwVweaYeUex8SpmU9_IU0uiv36kXKP-SWXXT6pSF92ewgTIRHMoWNHQ
Message-ID: <CAEjxPJ5+WN1vvZg3x5idtVrqHNWaQJQ17uBwRN1Kw68zYH+Rvw@mail.gmail.com>
Subject: Re: [PATCH] lsm: initialize the security blob for the initial namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnacek@gmail.com, 
	linux-security-module@vger.kernel.org, mic@digikod.net, serge@hallyn.com, 
	jack@suse.cz, jmorris@namei.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 8:55=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Sep 18, 2026 at 3:28=E2=80=AFAM Christian Brauner <brauner@kernel=
.org> wrote:
> >
> > On Wed, Sep 16, 2026 at 03:48:24PM -0400, Stephen Smalley wrote:
> > > Commit f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> > > added a security blob to struct ns_common and allocates it from
> > > __ns_common_init(). Most initial namespaces (init_user_ns,
> > > init_uts_ns, init_pid_ns, init_mnt_ns, and, depending on
> > > configuration, init_ipc_ns, init_cgroup_ns and init_time_ns) are
> > > however set up statically via NS_COMMON_INIT() and never pass through
> > > __ns_common_init(), so their ns_security pointer is left NULL for the
> > > lifetime of the system. Any LSM that registers an lbs_ns blob and
> > > dereferences its slice on one of those namespaces (for example from
> > > the namespace_install hook when a task setns()'s back into an initial
> > > namespace) will fault.
> > >
> > > Allocate the blob and run the namespace_init hook for each of these
> > > namespaces at the end of security_init(), after all ordered LSMs have
> > > registered their hooks, so every LSM sees the initial namespaces the
> > > same way it sees init_net (which is initialized at runtime via
> > > ns_common_init(&init_net) from net_ns_init() immediately after
> > > security_init()) and does not need to special-case them in its own
> > > ->init() callback.
> > >
> > > Provide an init_ns_common_for_each() iterator in kernel/nscommon.c so
> > > the list of statically-defined initial namespaces and their Kconfig
> > > guards live next to the rest of the ns_common infrastructure. init_ne=
t
> > > is intentionally excluded: pre-initializing it here would leak once
> > > __ns_common_init() clears ns_security and re-allocates.
> > >
> > > Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > >  include/linux/ns_common.h |  1 +
> > >  kernel/nscommon.c         | 45 +++++++++++++++++++++++++++++++++++++=
++
> > >  security/lsm_init.c       | 11 ++++++++++
> > >  3 files changed, 57 insertions(+)
> > >
> > > diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
> > > index c8e227a3f9e2..742627000453 100644
> > > --- a/include/linux/ns_common.h
> > > +++ b/include/linux/ns_common.h
> > > @@ -11,6 +11,7 @@
> > >  bool is_current_namespace(struct ns_common *ns);
> > >  int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct=
 proc_ns_operations *ops, int inum);
> > >  void __ns_common_free(struct ns_common *ns);
> > > +int init_ns_common_for_each(int (*fn)(struct ns_common *ns));
> > >  struct ns_common *__must_check ns_owner(struct ns_common *ns);
> > >
> > >  static __always_inline bool is_ns_init_inum(const struct ns_common *=
ns)
> > > diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> > > index e72426bba29a..4f3cba5518d7 100644
> > > --- a/kernel/nscommon.c
> > > +++ b/kernel/nscommon.c
> > > @@ -1,11 +1,17 @@
> > >  // SPDX-License-Identifier: GPL-2.0-only
> > >  /* Copyright (c) 2025 Christian Brauner <brauner@kernel.org> */
> > >
> > > +#include <linux/cgroup.h>
> > > +#include <linux/ipc_namespace.h>
> > > +#include <linux/mnt_namespace.h>
> > >  #include <linux/ns_common.h>
> > >  #include <linux/nstree.h>
> > > +#include <linux/pid_namespace.h>
> > >  #include <linux/proc_ns.h>
> > >  #include <linux/security.h>
> > > +#include <linux/time_namespace.h>
> > >  #include <linux/user_namespace.h>
> > > +#include <linux/uts_namespace.h>
> > >  #include <linux/vfsdebug.h>
> > >
> > >  #ifdef CONFIG_DEBUG_VFS
> > > @@ -101,6 +107,45 @@ int __ns_common_init(struct ns_common *ns, u32 n=
s_type, const struct proc_ns_ope
> > >       return 0;
> > >  }
> > >
> > > +/**
> > > + * init_ns_common_for_each - iterate the statically-defined initial =
namespaces
> > > + * @fn: callback invoked with each initial ns_common
> > > + *
> > > + * Walk the initial namespaces that are set up via NS_COMMON_INIT() =
at compile
> > > + * time and therefore never pass through __ns_common_init(). The ini=
tial
> > > + * network namespace is intentionally excluded: it is initialized at=
 runtime
> > > + * via ns_common_init(&init_net) from net_ns_init().
> > > + *
> > > + * Return: the first non-zero return from @fn, or 0.
> > > + */
> > > +int __init init_ns_common_for_each(int (*fn)(struct ns_common *ns))
> > > +{
> > > +     struct ns_common *set[] =3D {
> > > +             to_ns_common(&init_user_ns),
> > > +             to_ns_common(&init_uts_ns),
> > > +             to_ns_common(&init_pid_ns),
> > > +             from_mnt_ns(&init_mnt_ns),
> > > +#if defined(CONFIG_POSIX_MQUEUE) || defined(CONFIG_SYSVIPC)
> > > +             to_ns_common(&init_ipc_ns),
> > > +#endif
> > > +#ifdef CONFIG_CGROUPS
> > > +             to_ns_common(&init_cgroup_ns),
> > > +#endif
> > > +#ifdef CONFIG_TIME_NS
> > > +             to_ns_common(&init_time_ns),
> > > +#endif
> > > +     };
> > > +     unsigned int i;
> > > +     int ret;
> > > +
> > > +     for (i =3D 0; i < ARRAY_SIZE(set); i++) {
> > > +             ret =3D fn(set[i]);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +     return 0;
> > > +}
> > > +
> > >  void __ns_common_free(struct ns_common *ns)
> > >  {
> > >       security_namespace_free(ns);
> > > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > > index dbda7771013b..60e15215f6bd 100644
> > > --- a/security/lsm_init.c
> > > +++ b/security/lsm_init.c
> > > @@ -7,6 +7,7 @@
> > >
> > >  #include <linux/init.h>
> > >  #include <linux/lsm_hooks.h>
> > > +#include <linux/ns_common.h>
> > >
> > >  #include "lsm.h"
> > >
> > > @@ -490,6 +491,16 @@ int __init security_init(void)
> > >               lsm_init_single(*lsm);
> > >       }
> > >
> > > +     /*
> > > +      * The initial namespaces are set up statically via NS_COMMON_I=
NIT()
> > > +      * and never pass through __ns_common_init(), so allocate their
> > > +      * security blobs and run the namespace_init hooks now that all=
 LSMs
> > > +      * are registered. init_net is not covered here; it is initiali=
zed
> > > +      * at runtime from net_ns_init() shortly after security_init().
> > > +      */
> > > +     if (init_ns_common_for_each(security_namespace_init))
> > > +             panic("initial LSM ns alloc failed\n");
> >
> > Wouldn't it be nicer to turn this around and call
> > security_namespace_init from the ns common code and avoid the callback?
> > Especially since there's only one.
>
> Good idea. I'll send a v2 that does this.

The v2 patch can be found at
https://lore.kernel.org/linux-security-module/20260918134422.17053-2-stephe=
n.smalley.work@gmail.com/T/#u
