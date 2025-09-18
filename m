Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B68F30C0FA
	for <selinux@vger.kernel.org>; Thu, 18 Sep 2025 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206220; cv=none; b=Gji3x3HQ0M4MJRi5TuTeJ/n02f1Od9Uih1BIFiGwr400L1lwd+YXycTDuCop0IBFAsMphWwCiWw+D207pcUd4ayoUlyKQBG0I7V2rgVTtyhIZtq6FDsRVJvbuRZQCS6u9+AQPXwOB2cX7coWb+Y4r92keXjszp1WroERqO2EJaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206220; c=relaxed/simple;
	bh=xwdpCme9UV+7JqZiFJMS+HRCaB90dmTBRTS5Pva9Osw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=dK0zoEtttsuXHB7ND7FTRL32e56sxwrpt4H/2TkIAxTnYoPmCK8mYpb1gQ9HnkrNSnUgtwkeAnaL21PJUYElwvPLVwftSiaU3v5zIelTYobp9a7Ay/o5aReiZEhHMzTYP82TOicCiaxBwL9n7mrhUiKFjJ1BFCERU7fhVMl3hKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDn6yYQ4; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDn6yYQ4"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4c29d2ea05so1607110a12.0
        for <selinux@vger.kernel.org>; Thu, 18 Sep 2025 07:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758206218; x=1758811018; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pV5h7kJ+/artT8oMhVuZ0C+L4jPUMz8p4gR/xNmC0FE=;
        b=YDn6yYQ4GbivwajTKX1zQKmVBnVC9YMdU4qkAYNEVwceX6UhYs08jwSLJdLU1l4MQw
         mrrp+APAd/XmaoIt9i6Hq6IBj8KRo48mQRP2YfR5Wh7yy/HbkV2njdAqcTRl/ZrJV4cP
         LwCuoSwx6ekQhMRPbuwP3LJzTY0e7sxdXRGPCvXQjXAx+jLPUudl7lTV8I+ifZGpyrcW
         G9mhtKfSHtcmpiOxEoARzFvMYiFHMlVE4F1+GnkzL7maUw0OAgxR6KZEl89ZNTZX9toD
         M1eIwCkXLC+ON55a9FCVXJ7q5780tHD0Fb6lM5Vp0M++IsstpwSXNpODH8Py7NPT/Yvs
         x1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758206218; x=1758811018;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pV5h7kJ+/artT8oMhVuZ0C+L4jPUMz8p4gR/xNmC0FE=;
        b=LGzWXmGFeaxSDPQNphz1wKCbtHs5LRvqdwu6wjSOHJT6CBVVR48mo2g/jIQDbgrLgy
         sWI80DqpCaLhAslxBG/T6hty3R0XUIHU67TeBWGmQCfqAWqmY5jbGcjOshSq42ZPjq0m
         osIRzCPUZWnX5PC6uurXvSMc0Id3ccx+JvDBYkl7qC5O062LYC5I4kX+Yy+2nRBOpCFi
         ghh17QAlRJ4t+yWjY1pHzmEO75mxhLBc/Usrr3zBFC+XOcXJeiXkcF+XkD0zLm8cF7Is
         Tmhv8LxjBKFnBwHQQXInlIe8+hDFyYTOq1iiTTrms38t7aZP0Wqpr2xpeNaBiwXB/ENq
         vAuw==
X-Gm-Message-State: AOJu0YzHcsJV0jJNz1dknQk9kQPTXscWJYSXhJwMLhOyqfsu/D2vRCbL
	SqRW5RRRXt3C3SdtzGXvTYv+7Cl25f836bR9IBKl03COZHdcdvCWU4ifkKUBUD0j4eS2M30fcz5
	VQZb4qnkAJ1bTFFOzmQOjXEvrZha2g+HE4kqy
X-Gm-Gg: ASbGncuGi4OkWxUhLhj5epVw9eQRKXljVjJpENS8G69/Pba79jYyaCHTt+q1pQUlfoL
	MOA9t0datvFjQpUylfRfjOXTdBIez6/5qLWK3OP/AdqPXD+bFhWkWEqcB7AUVl9TcvWRscQOuyt
	WdIo+CYqCZWm6dG9c4/WaANSpadJhWtnUFk5WtmuHsSh9B3U42YGwj2X3SJFGseSwyLCm0JaMZ2
	L0zR/uDPYDW2/o106h2d4+4/A==
X-Google-Smtp-Source: AGHT+IHrU/ZUeqmZbBYywOfuZd4nnNOPWejbD3ORaZ6Zd8XwK+BdnUbyvmolhgX837jroHJJtcWNR1QAdK6H+VZONEc=
X-Received: by 2002:a17:90b:5910:b0:32d:e04e:8022 with SMTP id
 98e67ed59e1d1-3305c682385mr4289997a91.16.1758206218119; Thu, 18 Sep 2025
 07:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918135118.9896-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250918135118.9896-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 18 Sep 2025 10:36:46 -0400
X-Gm-Features: AS18NWDo7cPV8sSRoOwrvc0t6njNprLFWJZkWSbWrNZyKCZw4Mt-HhdwsSnKHqc
Message-ID: <CAEjxPJ4C7E_gxOkrEWtts+dwvQg0Nx7WuNT7ZAmL3u_3jisT7Q@mail.gmail.com>
Subject: Re: [RFC PATCH selinuxns] libselinux: add selinux_unshare()
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 9:53=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> RFC only, this demonstrates how to implement unsharing of the SELinux
> namespace using the lsm_set_self_attr(LSM_UNSHARE_SELINUX...) system
> call instead of the /sys/fs/selinux/unshare interface.

The above should read lsm_set_self_attr(LSM_ATTR_UNSHARE, ...) instead
but the code is correct.

>
> Provide a selinux_unshare() wrapper for
> lsm_set_self_attr(LSM_ATTR_UNSHARE...) and other required processing
> when unsharing the SELinux namespace.
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
> If/when this gets merged, the new selinux_unshare() symbol should
> be moved to its own version in libselinux.map.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  libselinux/include/selinux/selinux.h | 13 +++++
>  libselinux/src/libselinux.map        |  1 +
>  libselinux/src/unshare.c             | 71 ++++++++++++++++++++++++++++
>  libselinux/utils/.gitignore          |  1 +
>  libselinux/utils/unshareselinux.c    | 42 ++++++++++++++++
>  5 files changed, 128 insertions(+)
>  create mode 100644 libselinux/src/unshare.c
>  create mode 100644 libselinux/utils/unshareselinux.c
>
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/se=
linux/selinux.h
> index b1431e5d..1a68c29f 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -760,6 +760,19 @@ extern int selinux_lsetfilecon_default(const char *p=
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
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.ma=
p
> index ab002f01..f3966880 100644
> --- a/libselinux/src/libselinux.map
> +++ b/libselinux/src/libselinux.map
> @@ -251,6 +251,7 @@ LIBSELINUX_3.5 {
>    global:
>      getpidprevcon;
>      getpidprevcon_raw;
> +    selinux_unshare;
>  } LIBSELINUX_3.4;
>
>  LIBSELINUX_3.8 {
> diff --git a/libselinux/src/unshare.c b/libselinux/src/unshare.c
> new file mode 100644
> index 00000000..d2fc7e20
> --- /dev/null
> +++ b/libselinux/src/unshare.c
> @@ -0,0 +1,71 @@
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
> diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
> index 2e10b14f..bb290d90 100644
> --- a/libselinux/utils/.gitignore
> +++ b/libselinux/utils/.gitignore
> @@ -30,3 +30,4 @@ setfilecon
>  togglesebool
>  selinux_check_access
>  validatetrans
> +unshareselinux
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
> 2.50.1
>
