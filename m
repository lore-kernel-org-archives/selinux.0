Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB16B2D9EDF
	for <selinux@vger.kernel.org>; Thu,  9 Oct 2025 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760017952; cv=none; b=M+dconiNPAY/2FJ4iWWMbgEOaWlJTU3yhxPjuI71jQ9MM0cwnewtZTv56tbOEKkknbpK70xBxnT7bZz6QPHKvAEQntPkKVwsgyfWpglBKTpctJ6iU72MkScawF3MB+fnaf9fuyFYp3AweTJ+eKSHvUINxJhfJlvcHIlbMxUcS+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760017952; c=relaxed/simple;
	bh=Z2VMeBVZC/piR6bQRTsS2TbOV6MFsBdr1MsqBGjK/UE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSzSD+ucRcunlW246/WB7EhKmNf9Ijigb7TpOyrO9RFdEpMkt05Tfft+P4L/TlPRIpyeTC2qY13suQuGl9GQIip3pUaHShZGQ4pInm9amkeAmrHQQKFB+5xNWoAb9E1z753qIC7g+oT/5WZTSCo5GYYe/78IsafwsD3xlOvNh8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aj4X7tCm; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aj4X7tCm"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33082aed31dso1109671a91.3
        for <selinux@vger.kernel.org>; Thu, 09 Oct 2025 06:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760017950; x=1760622750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7G6tC374HuvSoa0Sq687nOy+RMocZylNFw7IVwqfGxY=;
        b=aj4X7tCmxCAkzmBpW9JtSaMVkYmdQvjEpZZsnV5MH4R1Uzhqqbo5Z/4Mv9JjPVBBU3
         gQ/HkUDpSK6tcW3rLPwhP06zyVbZ9zfdV1rigAfNFdoOaYwxaHfBnI6OMxZUYLi8hAQX
         vQ9Ox2E5FTlROLdMej6wQHLOJRQdeoZTLjBgTnUi7FUUHuka5ZiAsK+eq4N92i0l2ZMA
         uHOdhkEvdxnG2pC5eKjiXX0ZuefRUPWGQXpzBn1J7rSFc79sV8B36zjkq8989xpgLPbP
         f366lAD2plDqj8/0eR0Ogc80pbahTGnPFoiFCwm2GvsTgHvYH3ViJQa9oLhQMiGtaVOr
         lKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760017950; x=1760622750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7G6tC374HuvSoa0Sq687nOy+RMocZylNFw7IVwqfGxY=;
        b=HiudVXOxKpwurpnFQY2uXiOxv5j7V2cEqBI5e+i6uhTmc9mq+ILXs1j1lm1ysOBW9/
         XTdezykH/UpeRN8KDrjpr5bEer9iUWWHUL5NXU8JsMKgjLpfer7Na2YkHs/3fYtNlJCT
         u8X69n0evt4azpxhhTaBl2GH3dv5+eoxJQceVLz25MD9FIV8bG7APxykcoSDsPSYhs5B
         NxxblhdRRyi3xgkEf82X6yogS5bUz8z/s1XejP0gm8RPVH5bRVg3YRtmOxRtUeKKZAQT
         kplfjaieXRbMIcUeK+zIYCmeJCZY7Et8U1eECJ79bHvhcc87j5MIEDFczh0Y15N+QSBN
         sPCA==
X-Gm-Message-State: AOJu0Yy6nLd0GKK7E51hcSpPc4lmLUrXG4umQVXh4U6xTULqKAPZYjhB
	Hcx5c4+Lw9vz0ISbj6BB7d2TGGQaqNLZ+tQFbM27ZRBZwAmMMU4t9taWkmJ2HDvU22ErYzZ/GR+
	AeuuSia7ukzrcbOcSAGR6nQrtTJyy8VQ4e1Ne
X-Gm-Gg: ASbGncs0OLwhVNimvRe5z6Tl7yBh5CqgBZq9GriSnzgvKOB6OtyJpANYE3g7XfFPj8h
	yrnOM4yX/Y5ijhBkEs4V6UqXTwufwF2ta1NJARpsvRxLNaTeLwufSJhjHHTCjT5RyjhWwbyc1n6
	z/4QqLX0y3zLtWitPmtn8nDM5tmOpYdZ15gw8m7I9R5J2CsME6QG/J//06GoDp9vvCvhMMT0EBm
	yK8dLurhF8z9eIkZaLZ1V3jWbYMzb4=
X-Google-Smtp-Source: AGHT+IHHbCAqW6+dX4aU3nTujP6UnBoTygIrHsmYM8CBU+a6FZ2baIeiQn5+TgWkwbi+5I1rRggeXIfN8qu6bH41s2s=
X-Received: by 2002:a17:90b:4b04:b0:32e:8c14:5d09 with SMTP id
 98e67ed59e1d1-33b51105bbfmr10408895a91.7.1760017949509; Thu, 09 Oct 2025
 06:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009132421.20903-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20251009132421.20903-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 9 Oct 2025 09:52:18 -0400
X-Gm-Features: AS18NWDkXznKl2fFPkqIE8BiT_Y9KjBEg6jd9IXrJu1VxspP2g9-vakQpy6TcLo
Message-ID: <CAEjxPJ6bQO0t2Xujj-DaHFuQduLK4ApHjakZuTP+QtC4MAPZOA@mail.gmail.com>
Subject: Re: [RFC PATCH v3] libselinux: add selinux_unshare() and is_selinux_unshared()
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, john.johansen@canonical.com, casey@schaufler-ca.com, 
	serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 9:28=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> RFC only, this demonstrates how to implement unsharing of the SELinux
> namespace using the lsm_set_self_attr(LSM_ATTR_UNSHARE, ...) system
> call and how to implement detection of whether one is in an unshared
> SELinux namespace that has not yet been fully initialized using
> the lsm_get_self_attr(LSM_ATTR_UNSHARE, ...) system call.
>
> Provide a selinux_unshare() wrapper for
> lsm_set_self_attr(LSM_ATTR_UNSHARE, ...) and other required processing
> when unsharing the SELinux namespace, and an is_selinux_unshared()
> wrapper for lsm_get_self_attr(LSM_ATTR_UNSHARE, ...) for detecting
> whether one is in an unshared SELinux namespace that has not yet
> been fully initialized.
>
> Add a selinux_unshare() interface to unshare the SELinux namespace, and
> a unshareselinux utility to run a shell or command in its own SELinux
> and mount namespaces. The selinux_unshare() interface expects the caller
> to have already unshared its mount namespace and created a
> MS_REC|MS_PRIVATE mount of / prior to invoking it so that it can freely
> modify the selinuxfs mount as needed by the unshare operation. The
> unshareselinux utility demonstrates how to do this prior to calling
> selinux_unshare(). Upon a successful return from selinux_unshare(),
> the SELinux namespace will be unshared and there will be no selinuxfs
> mount on /sys/fs/selinux.  The caller can then proceed to mount a new
> selinuxfs filesystem private to the new namespace, load a policy,
> set enforcing mode, etc, as is commonly handled by init/systemd during
> boot.
>
> Add an is_selinux_unshared() interface to detect whether one is in
> an unshared SELinux namespace that has not yet been fully initialized
> (i.e. no policy loaded yet), and a selinuxunshared utility to use
> it from a shell or script.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v3 changes is_selinux_unshared() to return 0 if lsm_get_self_attr(2)
> sets errno to ENOSYS or EOPNOTSUPP to allow callers to treat its
> return value as a boolean and avoid needing to handle these cases
> themselves.

For LSM maintainers not on the original distribution, here are the
corresponding patches for systemd that use these APIs:
https://lore.kernel.org/selinux/20251006143052.271761-2-stephen.smalley.wor=
k@gmail.com/T/#t

WRT the is_selinux_unshared() -> lsm_get_self_attr(LSM_ATTR_UNSHARE,
...), I originally tried to use it here:
https://lore.kernel.org/selinux/CAEjxPJ7zHgiSnd8jTGvBQm=3DZ=3DQr645poO51f1N=
5shMhCLnXVJg@mail.gmail.com/T/#u
but that failed because systemd-nspawn sets a seccomp allow-list that
doesn't include the lsm_[gs]et_self_attr(2) system calls.

I could of course add them to its allow-list but it isn't strictly
required for this purpose since I can detect that I am in a SELinux
namespace using the environment variable approach instead.

This is one downside of the system call-based interface versus the
selinuxfs and proc-based interfaces; any container or sandboxing
runtime that sets an allow-list will need updating to permit access to
the new interfaces.

>
>  libselinux/include/selinux/selinux.h |  23 ++++++
>  libselinux/src/libselinux.map        |   6 ++
>  libselinux/src/unshare.c             | 117 +++++++++++++++++++++++++++
>  libselinux/utils/.gitignore          |   2 +
>  libselinux/utils/selinuxunshared.c   |  24 ++++++
>  libselinux/utils/unshareselinux.c    |  42 ++++++++++
>  6 files changed, 214 insertions(+)
>  create mode 100644 libselinux/src/unshare.c
>  create mode 100644 libselinux/utils/selinuxunshared.c
>  create mode 100644 libselinux/utils/unshareselinux.c
>
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/se=
linux/selinux.h
> index b1431e5d..92186ddc 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -760,6 +760,29 @@ extern int selinux_lsetfilecon_default(const char *p=
ath);
>   */
>  extern void selinux_reset_config(void);
>
> +/*
> + * Unshare the SELinux namespace.
> + * Prior to invoking this API, the caller must have unshared the
> + * mount namespace (CLONE_NEWNS) and mounted a MS_REC|MS_PRIVATE
> + * / filesystem so that selinux_unshare() can freely modify any
> + * existing selinuxfs mount as needed for the unshare.
> + * Returns 0 on success, in which case the SELinux namespace has
> + * been unshared and any old selinuxfs mount will have been unmounted.
> + * The caller can then proceed to mount a new selinuxfs filesystem
> + * for the new namespace, load a policy, set enforcing mode, etc.
> + */
> +extern int selinux_unshare(void);
> +
> +/*
> + * Returns 1 if the SELinux namespace was unshared and has not
> + * yet been fully initialized (i.e. policy not yet loaded).
> + * Returns 0 if SELinux namespaces are not supported by the kernel,
> + * or the SELinux namespace was not unshared, or the namespace has
> + * been fully initialized already.
> + * Return < 0 on any error other than ENOSYS or EOPNOTSUPP.
> + */
> +extern int is_selinux_unshared(void);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.ma=
p
> index ab002f01..77f5790c 100644
> --- a/libselinux/src/libselinux.map
> +++ b/libselinux/src/libselinux.map
> @@ -262,3 +262,9 @@ LIBSELINUX_3.9 {
>    global:
>      context_to_str;
>  } LIBSELINUX_3.8;
> +
> +LIBSELINUX_4.0 {
> +  global:
> +    selinux_unshare;
> +    is_selinux_unshared;
> +} LIBSELINUX_3.9;
> diff --git a/libselinux/src/unshare.c b/libselinux/src/unshare.c
> new file mode 100644
> index 00000000..cd3ec78c
> --- /dev/null
> +++ b/libselinux/src/unshare.c
> @@ -0,0 +1,117 @@
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +
> +#include <sched.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <sys/mount.h>
> +#include <sys/vfs.h>
> +#include <sys/statvfs.h>
> +#include <sys/syscall.h>
> +#include <linux/lsm.h>
> +
> +#include "selinux_internal.h"
> +#include "policy.h"
> +
> +#ifndef LSM_ATTR_UNSHARE
> +#define LSM_ATTR_UNSHARE 106
> +#endif
> +
> +#ifndef __NR_lsm_get_self_attr
> +#define __NR_lsm_get_self_attr 459
> +#endif
> +
> +#ifndef __NR_lsm_set_self_attr
> +#define __NR_lsm_set_self_attr 460
> +#endif
> +
> +#ifndef HAVE_LSM_SET_SELF_ATTR
> +#define HAVE_LSM_SET_SELF_ATTR 1
> +static int lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
> +                            uint32_t size, uint32_t flags)
> +{
> +       return syscall(__NR_lsm_set_self_attr, attr, ctx, size, flags);
> +}
> +#endif
> +
> +#ifndef HAVE_LSM_GET_SELF_ATTR
> +#define HAVE_LSM_GET_SELF_ATTR 1
> +static int lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
> +                            uint32_t *size, uint32_t flags)
> +{
> +       return syscall(__NR_lsm_get_self_attr, attr, ctx, size, flags);
> +}
> +#endif
> +
> +/*
> + * Precondition: caller must have already done unshare(CLONE_NEWNS) or
> + * been created via clone(CLONE_NEWNS) and mounted a MS_REC|MS_PRIVATE
> + * / filesystem so that any pre-existing selinuxfs mount can be
> + * modified freely by selinux_unshare(). See ../utils/unshareselinux.c
> + * for an example.
> + */
> +int selinux_unshare(void)
> +{
> +       struct lsm_ctx ctx;
> +       int ret;
> +
> +       ctx.id =3D LSM_ID_SELINUX;
> +       ctx.flags =3D 0;
> +       ctx.len =3D sizeof(ctx);
> +       ctx.ctx_len =3D 0;
> +
> +       /* Unshare the SELinux namespace */
> +       ret =3D lsm_set_self_attr(LSM_ATTR_UNSHARE, &ctx, sizeof(ctx), 0)=
;
> +       if (ret < 0)
> +               return -1;
> +
> +       /* Unmount the selinuxfs which refers to the old/parent namespace=
 */
> +       ret =3D umount(SELINUXMNT);
> +       if (ret < 0)
> +               return ret;
> +
> +       /*
> +        * Caller is responsible for mounting new selinuxfs, loading poli=
cy,
> +        * setting enforcing mode, etc.
> +        */
> +
> +       return 0;
> +}
> +
> +struct selinux_ctx {
> +       struct lsm_ctx lsmctx;
> +       char unshared;
> +};
> +
> +/*
> + * Returns 1 if the SELinux namespace was unshared and has not
> + * yet been fully initialized (i.e. policy not yet loaded).
> + * Returns 0 if SELinux namespaces are not supported by the kernel,
> + * or the SELinux namespace was not unshared, or the namespace has
> + * been fully initialized already.
> + * Return < 0 on any error other than ENOSYS or EOPNOTSUPP.
> + */
> +int is_selinux_unshared(void)
> +{
> +       struct selinux_ctx ctx;
> +       uint32_t size =3D sizeof(ctx);
> +       int ret;
> +
> +       ctx.lsmctx.id =3D LSM_ID_SELINUX;
> +       ctx.lsmctx.flags =3D 0;
> +       ctx.lsmctx.len =3D sizeof(ctx);
> +       ctx.lsmctx.ctx_len =3D 0;
> +
> +       ret =3D lsm_get_self_attr(LSM_ATTR_UNSHARE, (struct lsm_ctx *)&ct=
x,
> +                               &size, LSM_FLAG_SINGLE);
> +       if (ret < 0 && (errno =3D=3D ENOSYS || errno =3D=3D EOPNOTSUPP))
> +               return 0;
> +       if (ret < 0)
> +               return ret;
> +       return ctx.unshared;
> +}
> diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
> index 2e10b14f..ffd2bc8e 100644
> --- a/libselinux/utils/.gitignore
> +++ b/libselinux/utils/.gitignore
> @@ -30,3 +30,5 @@ setfilecon
>  togglesebool
>  selinux_check_access
>  validatetrans
> +unshareselinux
> +selinuxunshared
> diff --git a/libselinux/utils/selinuxunshared.c b/libselinux/utils/selinu=
xunshared.c
> new file mode 100644
> index 00000000..965f7ba3
> --- /dev/null
> +++ b/libselinux/utils/selinuxunshared.c
> @@ -0,0 +1,24 @@
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <selinux/selinux.h>
> +
> +int main(int argc, char **argv)
> +{
> +       int ret;
> +
> +       if (argc !=3D 1) {
> +               fprintf(stderr, "usage: %s\n", argv[0]);
> +               exit(-1);
> +       }
> +
> +       ret =3D is_selinux_unshared();
> +       if (ret < 0) {
> +               perror(argv[0]);
> +               exit(-1);
> +       }
> +
> +       printf("%d\n", ret);
> +
> +       exit(!ret);
> +}
> diff --git a/libselinux/utils/unshareselinux.c b/libselinux/utils/unshare=
selinux.c
> new file mode 100644
> index 00000000..b396b4fe
> --- /dev/null
> +++ b/libselinux/utils/unshareselinux.c
> @@ -0,0 +1,42 @@
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +
> +#include <sched.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <sys/mount.h>
> +#include <selinux/selinux.h>
> +
> +int main(int argc, char **argv)
> +{
> +       int ret;
> +
> +       ret =3D unshare(CLONE_NEWNS);
> +       if (ret < 0) {
> +               perror("unshare(CLONE_NEWNS)");
> +               exit(1);
> +       }
> +
> +       ret =3D mount("none", "/", NULL, MS_REC | MS_PRIVATE, NULL);
> +       if (ret < 0) {
> +               perror("mount(/)");
> +               exit(1);
> +       }
> +
> +       ret =3D selinux_unshare();
> +       if (ret < 0) {
> +               perror("selinux_unshare");
> +               exit(1);
> +       }
> +
> +       if (argc < 2) {
> +               fprintf(stderr, "usage: %s command args...\n", argv[0]);
> +               exit(1);
> +       }
> +
> +       execvp(argv[1], &argv[1]);
> +       perror(argv[1]);
> +}
> --
> 2.51.0
>
