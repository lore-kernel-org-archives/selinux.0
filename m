Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E72F2144C7
	for <selinux@vger.kernel.org>; Fri, 10 Oct 2025 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760110816; cv=none; b=rC3lxuanPpYzYCEew0Xmt9o6u4A9QMzVIt8ZY+Xj9/Bn2poLl9ppiO5A4/1Rw8ySsX0itZTM/VPFnSXKRpUtV08bpw3pwnlMC9zSmDUSyFA0ojlpleU3o9hfJk3lsJmbfa+RLiWkIdDIItuPnZilg3nFsX2Rq4Ib+uKAZgo5lnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760110816; c=relaxed/simple;
	bh=aePiTA0If1YKgmq1qCxdxdEjTrxcppl/znZcLGWx9oA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=eu7zhIuyBOS6gFvBOcLE3PNiKBJ7YXPI2MrYkKq1MC7P9mlWZWLvSD+phiYeRL6jQ82Iha6zGOkJZiw4VfVY7zP/RzGHVgq5wajxBq+AFBbAJVNg43+Z195qRFK+HK41OWZImF7qTU5Xbz+8KEsrhyQke+7KNvT4e0MGYH3NHxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WLIFmtoZ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WLIFmtoZ"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so3849148a12.3
        for <selinux@vger.kernel.org>; Fri, 10 Oct 2025 08:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760110813; x=1760715613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aePiTA0If1YKgmq1qCxdxdEjTrxcppl/znZcLGWx9oA=;
        b=WLIFmtoZFg/mO3z2PY+kOXOlH1tM9Ki7eh63CAsQKWmO6yky4wa5GLbf4Fqp/+Joxb
         xNeopf3Sy3R28MEzdeR4w9CNguS2QWlo4hnX7KvswAvUscv7WSlCWlvzoLfPMaKGBcl4
         CWAMQNBF4gZuYnUJR+fZutp1daPRbgTQIfHM+MPddYOzHXI/um6HBThA4JOzrhnGwsVH
         PFiCLpOVeI3qyk9BRIVCiyF8ABOxFKqit7BQA7V1ErfPQvL49UVMPZ43Q+HqrCabkDB8
         9Q6VWs3vki1hErjVuAEmSR8n1oRfEl6l/UfkWVVRa8f01A1VfWOJH25GetncGRKgg5ig
         oT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760110813; x=1760715613;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aePiTA0If1YKgmq1qCxdxdEjTrxcppl/znZcLGWx9oA=;
        b=Ky5FFh7gkqUdTDR24yRxHpWggGkj1Pep5LONxTCltux9ybrDZlH6/tNUIV52X5Hh4T
         Y93QP1qXqTwzDPdg3ECCCxMx+6EGB4W/VpgwBvgmTPz+WjYZURI+Dbqv7Nq7VWviSF3P
         VGyEnMdT/Xl0Y/ZJIJ20Ef2VR13sBI6kc9qcIxKULCCfWwRFmVgh9UJbn1BG4qfhG1JU
         rAaOz5cQgz+e0rYhkm+aSQQIGBfES/fG1H+5BuX5Om8u7KZAEDbpJGx9rHQtIU6aN/s8
         n3dTKetpeAX5Cg+nN3NEP2yEUSP+Wly34mxQccJol2p6nqjwCVOPDieZc7O61LMkyEz3
         cAoA==
X-Gm-Message-State: AOJu0YyrcBfwih9zBg1dTRv0k8agX9G/sQQKP+S3/8xcUqYrBYm18/Tv
	m6ozIXRXY2i5gigaYQIhiOG+J4c95Y48FWRPitjh8Zu9yN2WgJv40VpC
X-Gm-Gg: ASbGncuoONYiTFqGMuGw70OZd05hbmy8PvKWwfDu3GVyY+RdmbK66qgfVYbjpkn3t2h
	/ZNVGk0mC0nslTnVir+byy1vHvmCNQ+mqkxJ6LFDBqUaOGzQxRFTu0IzDR4OySGfRrW+uPHV907
	Q9lOaaaNGoTMWlFuyeMxIQNgcK2AuH/QOSFqPp1vT8WAISPmAbb5uiYu0Ny/ytib5o76tAm7eKp
	XjE0j7kmAg30Lh88Z9InHJU/uOBwDY9FAooTjqI1Y3/jjOklaLLHzvEcnSafUvnn6sP08pNfFnm
	2yzuT6kdnfwWobTFQZ2l8u/rZyT+GeV0m92gh6Pmmm+axqgO2xPJsOkcBo48FUeAsXRhyJ+Ta0m
	L5+J231eU4+eXpCCvKz8Itn/WBHaVVZUjpFKfnv1Vr1GvFNPX1fgHbiuSwDlyiQ==
X-Google-Smtp-Source: AGHT+IGr9rRhUg1XkU5u87keg7IiQcn4pMTKwTMjWGpyQH/A26+O6NC5IVNEG5sH72PuuIGyRa6dRg==
X-Received: by 2002:a05:6402:35c7:b0:639:fa9e:35ee with SMTP id 4fb4d7f45d1cf-639fa9e3bcbmr6395532a12.7.1760110812550;
        Fri, 10 Oct 2025 08:40:12 -0700 (PDT)
Received: from [127.0.0.1] ([61.8.147.206])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c1348b2sm2581436a12.37.2025.10.10.08.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 08:40:12 -0700 (PDT)
Date: Fri, 10 Oct 2025 17:40:08 +0200 (GMT+02:00)
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com,
	john.johansen@canonical.com, casey@schaufler-ca.com,
	serge@hallyn.com
Message-ID: <4de3044e-22f6-42b0-874f-ac1a9a7c8e48@googlemail.com>
In-Reply-To: <20251009132421.20903-2-stephen.smalley.work@gmail.com>
References: <20251009132421.20903-2-stephen.smalley.work@gmail.com>
Subject: Re: [RFC PATCH v3] libselinux: add selinux_unshare() and
 is_selinux_unshared()
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <4de3044e-22f6-42b0-874f-ac1a9a7c8e48@googlemail.com>

Oct 9, 2025 15:28:19 Stephen Smalley <stephen.smalley.work@gmail.com>:

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
> mount on /sys/fs/selinux.=C2=A0 The caller can then proceed to mount a ne=
w
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
>
> libselinux/include/selinux/selinux.h |=C2=A0 23 ++++++
> libselinux/src/libselinux.map=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 6 ++
> libselinux/src/unshare.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 117 +++++++++++++++++++++++++++
> libselinux/utils/.gitignore=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +
> libselinux/utils/selinuxunshared.c=C2=A0=C2=A0 |=C2=A0 24 ++++++
> libselinux/utils/unshareselinux.c=C2=A0=C2=A0=C2=A0 |=C2=A0 42 ++++++++++
> 6 files changed, 214 insertions(+)
> create mode 100644 libselinux/src/unshare.c
> create mode 100644 libselinux/utils/selinuxunshared.c
> create mode 100644 libselinux/utils/unshareselinux.c
>
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/se=
linux/selinux.h
> index b1431e5d..92186ddc 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -760,6 +760,29 @@ extern int selinux_lsetfilecon_default(const char *p=
ath);
> =C2=A0 */
> extern void selinux_reset_config(void);
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
> #ifdef __cplusplus
> }
> #endif
> diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.ma=
p
> index ab002f01..77f5790c 100644
> --- a/libselinux/src/libselinux.map
> +++ b/libselinux/src/libselinux.map
> @@ -262,3 +262,9 @@ LIBSELINUX_3.9 {
> =C2=A0=C2=A0 global:
> =C2=A0=C2=A0=C2=A0=C2=A0 context_to_str;
> } LIBSELINUX_3.8;
> +
> +LIBSELINUX_4.0 {
> +=C2=A0 global:
> +=C2=A0=C2=A0=C2=A0 selinux_unshare;
> +=C2=A0=C2=A0=C2=A0 is_selinux_unshared;
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
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 uint32_t size, uint32_t flags)
> +{
> +=C2=A0=C2=A0 return syscall(__NR_lsm_set_self_attr, attr, ctx, size, fla=
gs);
> +}
> +#endif
> +
> +#ifndef HAVE_LSM_GET_SELF_ATTR
> +#define HAVE_LSM_GET_SELF_ATTR 1
> +static int lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 uint32_t *size, uint32_t flags)
> +{
> +=C2=A0=C2=A0 return syscall(__NR_lsm_get_self_attr, attr, ctx, size, fla=
gs);
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
> +=C2=A0=C2=A0 struct lsm_ctx ctx;
> +=C2=A0=C2=A0 int ret;
> +
> +=C2=A0=C2=A0 ctx.id =3D LSM_ID_SELINUX;
> +=C2=A0=C2=A0 ctx.flags =3D 0;
> +=C2=A0=C2=A0 ctx.len =3D sizeof(ctx);
> +=C2=A0=C2=A0 ctx.ctx_len =3D 0;
> +
> +=C2=A0=C2=A0 /* Unshare the SELinux namespace */
> +=C2=A0=C2=A0 ret =3D lsm_set_self_attr(LSM_ATTR_UNSHARE, &ctx, sizeof(ct=
x), 0);
> +=C2=A0=C2=A0 if (ret < 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
> +
> +=C2=A0=C2=A0 /* Unmount the selinuxfs which refers to the old/parent nam=
espace */
> +=C2=A0=C2=A0 ret =3D umount(SELINUXMNT);
> +=C2=A0=C2=A0 if (ret < 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> +
> +=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0 * Caller is responsible for mounting new selinuxfs, l=
oading policy,
> +=C2=A0=C2=A0=C2=A0 * setting enforcing mode, etc.
> +=C2=A0=C2=A0=C2=A0 */
> +
> +=C2=A0=C2=A0 return 0;
> +}
> +
> +struct selinux_ctx {
> +=C2=A0=C2=A0 struct lsm_ctx lsmctx;
> +=C2=A0=C2=A0 char unshared;
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
> +=C2=A0=C2=A0 struct selinux_ctx ctx;
> +=C2=A0=C2=A0 uint32_t size =3D sizeof(ctx);
> +=C2=A0=C2=A0 int ret;
> +
> +=C2=A0=C2=A0 ctx.lsmctx.id =3D LSM_ID_SELINUX;
> +=C2=A0=C2=A0 ctx.lsmctx.flags =3D 0;
> +=C2=A0=C2=A0 ctx.lsmctx.len =3D sizeof(ctx);
> +=C2=A0=C2=A0 ctx.lsmctx.ctx_len =3D 0;
> +
> +=C2=A0=C2=A0 ret =3D lsm_get_self_attr(LSM_ATTR_UNSHARE, (struct lsm_ctx=
 *)&ctx,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 &size, LSM_FLAG_SINGLE);
> +=C2=A0=C2=A0 if (ret < 0 && (errno =3D=3D ENOSYS || errno =3D=3D EOPNOTS=
UPP))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> +=C2=A0=C2=A0 if (ret < 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> +=C2=A0=C2=A0 return ctx.unshared;
> +}
> diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
> index 2e10b14f..ffd2bc8e 100644
> --- a/libselinux/utils/.gitignore
> +++ b/libselinux/utils/.gitignore
> @@ -30,3 +30,5 @@ setfilecon
> togglesebool
> selinux_check_access
> validatetrans
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
> +=C2=A0=C2=A0 int ret;
> +
> +=C2=A0=C2=A0 if (argc !=3D 1) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "usage: %s\n", argv=
[0]);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(-1);
> +=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0 ret =3D is_selinux_unshared();
> +=C2=A0=C2=A0 if (ret < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror(argv[0]);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(-1);
> +=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0 printf("%d\n", ret);
> +
> +=C2=A0=C2=A0 exit(!ret);
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
> +=C2=A0=C2=A0 int ret;
> +
> +=C2=A0=C2=A0 ret =3D unshare(CLONE_NEWNS);
> +=C2=A0=C2=A0 if (ret < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror("unshare(CLONE_NEWNS)");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
> +=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0 ret =3D mount("none", "/", NULL, MS_REC | MS_PRIVATE, NULL)=
;
> +=C2=A0=C2=A0 if (ret < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror("mount(/)");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
> +=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0 ret =3D selinux_unshare();
> +=C2=A0=C2=A0 if (ret < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror("selinux_unshare");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
> +=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0 if (argc < 2) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr, "usage: %s command =
args...\n", argv[0]);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
> +=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0 execvp(argv[1], &argv[1]);
> +=C2=A0=C2=A0 perror(argv[1]);

Nit picking:

+ exit(1);

> +}
> --
> 2.51.0

