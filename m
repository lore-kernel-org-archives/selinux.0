Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193C919DF4A
	for <selinux@vger.kernel.org>; Fri, 19 Sep 2025 12:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285164; cv=none; b=DTrI3cVeqfNN5kbMIn9635W6VUgAr1vTAs9vr+U4mfGo/dc/mJwxdzb/R0G1rfQtnPcHvfg2JBiastqDgYRh48q3H7ZyouMbUjiqvfLGiSwuV2FA6M8744rJf4WlOc8hH+fZco/M0HUb8092V6rPhZgcd9aPcaKoxejU933n3ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285164; c=relaxed/simple;
	bh=HWeIQmoGW16YFe3QGX1AqYaaW5trzMg9jrb/9wwet+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=aiU64UfQ5daEh1kcNc+LAELxLZke9bxNKcVax93pNDu/AohDtZ8ZnuJmQ5GcbZaq+080v+SjPAVp9Tl6AHTngLMCrZgU8sFp3ELWbJ6/KcQVvv2m/YECxUuRyy9B/Dpn55waIDp3A1FWkxuOEl4MLMYH7xzNfPg5shB8idIZgm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNiI+xgl; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNiI+xgl"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so1370395a91.0
        for <selinux@vger.kernel.org>; Fri, 19 Sep 2025 05:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758285162; x=1758889962; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfkEXHKWaPqMyc6jyOCd/qO+uVJugjdCCodHBO2FBZM=;
        b=YNiI+xglWW5P3A3gFLaCEhLRL4Cdsj6iFugZJ74i2+TLXojV01Oa6pL1dcvSZpBZYk
         ZIOkbPsssW0MmxizTkGf9Isv3xS0nyhY/e2ULOVN/LH9879KVYxhs3I3aAl/tNiwpB2B
         SWWzuliNwRWQOcvErL3mMu8cFA2WXUUJRqihuAqZq2jddey8caeTxwEta57ijzSF7nuH
         N3BjaTBBD3EB3PLYToqGp9pxIO4HsSRzOQIyYqFkabiguxgKnVzcKqLUQ32O9CLcGXdC
         iOYZFjHdYFkTXqq8DOVEyelv/47B3wFOP/saHajVGHjg4JN6B+fQvvaFKPa0i1MBDbYG
         98Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758285162; x=1758889962;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfkEXHKWaPqMyc6jyOCd/qO+uVJugjdCCodHBO2FBZM=;
        b=CTxx1bZLKaHxKm/qrZJF/rZuIeMjqde4HMYfYHZCmZ9B2QJqx/ZGlCAs0s251xHtVi
         qi0+Phs6jpVTEYy//7IGDhGyx2TebFah4hcuhPuyWxP1qEljI6dp8APBbPLGR4z3DAKC
         2k0GcrhRfwbre+yXDvsg9WT37WO+5SmsxqcMzkwTM4F4cIRs8J5iv+5byvYolQ2SzuNf
         fa/ysR5H8zXNOdkX7ZSXySi97sF2yBneb06IQULQDUKC25VX4ySrBVfEr8O8jMLo5ido
         Dlu3iNUivdYQWtCEcxo9l+T5jai/o2Ik7cbSmLMu+FiDCgceItBNDVXo1RX1vB07J2Wh
         j9OQ==
X-Gm-Message-State: AOJu0Yzl9h5Sh4rSkgVVtyX1WdPUg2flo2I2199BF808/pZ7Fk2cDCi2
	pT/uQv28/Di5ElZb06ZET2gl4pFfi30QE8FamOmz703ftNISCVJzHyhzbKmeIz87RGDoLEmP/ZT
	1O0Hhsp5+dxqJgzE8n3LfAMcy/UmX2vwWgJj7
X-Gm-Gg: ASbGncvpCNFeS/BfnsPSCctPN+/+HvtXqvx0KmHQSLX6VqA7SuvtkAvUa5TmORY5Svl
	LEhPThM+MulLIDSAZ3HBFVsKr3VOcJbMs/bAcSASW59e/ieWFVBzaBEzN9DhtjClBdFp/5cLsbP
	iq8jxX9KALQh57WFkg7DV3YRiCxpabgnNIHLQmU/63kLn8GvRPqZFLS7TGOKXJRVH8+wKVau5fK
	+21K4k=
X-Google-Smtp-Source: AGHT+IGRKGb/28wTciwWkfjARru9jGrvFF5EP3KN4qldMw5BCDEYigCoPyQD919LL4nf8ExttfXaVGGRwfwHHP3euyg=
X-Received: by 2002:a17:90b:584e:b0:32b:6151:d1b with SMTP id
 98e67ed59e1d1-33097fed873mr3822542a91.8.1758285161982; Fri, 19 Sep 2025
 05:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918135118.9896-2-stephen.smalley.work@gmail.com> <CAEjxPJ4C7E_gxOkrEWtts+dwvQg0Nx7WuNT7ZAmL3u_3jisT7Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4C7E_gxOkrEWtts+dwvQg0Nx7WuNT7ZAmL3u_3jisT7Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 19 Sep 2025 08:32:30 -0400
X-Gm-Features: AS18NWBi7aDNuzL162UO7UnFfgNrI22NFOyN6bEVvRR5N_oEcRXe7iUKvlO8GXA
Message-ID: <CAEjxPJ5zy-904LqfJjUn6EHDCRhBZorykUL0tAhJpW4+Haqa3A@mail.gmail.com>
Subject: Re: [RFC PATCH selinuxns] libselinux: add selinux_unshare()
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 10:36=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Sep 18, 2025 at 9:53=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > RFC only, this demonstrates how to implement unsharing of the SELinux
> > namespace using the lsm_set_self_attr(LSM_UNSHARE_SELINUX...) system
> > call instead of the /sys/fs/selinux/unshare interface.
>
> The above should read lsm_set_self_attr(LSM_ATTR_UNSHARE, ...) instead
> but the code is correct.
>
> >
> > Provide a selinux_unshare() wrapper for
> > lsm_set_self_attr(LSM_ATTR_UNSHARE...) and other required processing
> > when unsharing the SELinux namespace.
> >
> > Add a selinux_unshare() interface to unshare the SELinux namespace, and
> > a unshareselinux utility to run a shell or command in its own SELinux
> > and mount namespaces. The selinux_unshare() interface expects the calle=
r
> > to have already unshared its mount namespace and created a
> > MS_REC|MS_PRIVATE mount of / prior to invoking it so that it can freely
> > modify the selinuxfs mount as needed by the unshare operation. The
> > unshareselinux utility demonstrates how to do this prior to calling
> > selinux_unshare(). Upon a successful return from selinux_unshare(),
> > the SELinux namespace will be unshared and there will be no selinuxfs
> > mount on /sys/fs/selinux.  The caller can then proceed to mount a new
> > selinuxfs filesystem private to the new namespace, load a policy,
> > set enforcing mode, etc, as is commonly handled by init/systemd during
> > boot.

An example of how this selinux_unshare(3) API would be used by a
container runtime can be found in:
https://lore.kernel.org/selinux/20250919122100.181107-2-stephen.smalley.wor=
k@gmail.com/

> >
> > If/when this gets merged, the new selinux_unshare() symbol should
> > be moved to its own version in libselinux.map.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  libselinux/include/selinux/selinux.h | 13 +++++
> >  libselinux/src/libselinux.map        |  1 +
> >  libselinux/src/unshare.c             | 71 ++++++++++++++++++++++++++++
> >  libselinux/utils/.gitignore          |  1 +
> >  libselinux/utils/unshareselinux.c    | 42 ++++++++++++++++
> >  5 files changed, 128 insertions(+)
> >  create mode 100644 libselinux/src/unshare.c
> >  create mode 100644 libselinux/utils/unshareselinux.c
> >
> > diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/=
selinux/selinux.h
> > index b1431e5d..1a68c29f 100644
> > --- a/libselinux/include/selinux/selinux.h
> > +++ b/libselinux/include/selinux/selinux.h
> > @@ -760,6 +760,19 @@ extern int selinux_lsetfilecon_default(const char =
*path);
> >   */
> >  extern void selinux_reset_config(void);
> >
> > +/*
> > + * Unshare the SELinux namespace.
> > + * Prior to invoking this API, the caller must have unshared the
> > + * mount namespace (CLONE_NEWNS) and mounted a MS_REC|MS_PRIVATE
> > + * / filesystem so that selinux_unshare() can freely modify any
> > + * existing selinuxfs mount as needed for the unshare.
> > + * Returns 0 on success, in which case the SELinux namespace has
> > + * been unshared and any old selinuxfs mount will have been unmounted.
> > + * The caller can then proceed to mount a new selinuxfs filesystem
> > + * for the new namespace, load a policy, set enforcing mode, etc.
> > + */
> > +extern int selinux_unshare(void);
> > +
> >  #ifdef __cplusplus
> >  }
> >  #endif
> > diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.=
map
> > index ab002f01..f3966880 100644
> > --- a/libselinux/src/libselinux.map
> > +++ b/libselinux/src/libselinux.map
> > @@ -251,6 +251,7 @@ LIBSELINUX_3.5 {
> >    global:
> >      getpidprevcon;
> >      getpidprevcon_raw;
> > +    selinux_unshare;
> >  } LIBSELINUX_3.4;
> >
> >  LIBSELINUX_3.8 {
> > diff --git a/libselinux/src/unshare.c b/libselinux/src/unshare.c
> > new file mode 100644
> > index 00000000..d2fc7e20
> > --- /dev/null
> > +++ b/libselinux/src/unshare.c
> > @@ -0,0 +1,71 @@
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE
> > +#endif
> > +
> > +#include <sched.h>
> > +#include <stdint.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <fcntl.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <sys/mount.h>
> > +#include <sys/vfs.h>
> > +#include <sys/statvfs.h>
> > +#include <sys/syscall.h>
> > +#include <linux/lsm.h>
> > +
> > +#include "selinux_internal.h"
> > +#include "policy.h"
> > +
> > +#ifndef LSM_ATTR_UNSHARE
> > +#define LSM_ATTR_UNSHARE 106
> > +#endif
> > +
> > +#ifndef __NR_lsm_set_self_attr
> > +#define __NR_lsm_set_self_attr 460
> > +#endif
> > +
> > +#ifndef HAVE_LSM_SET_SELF_ATTR
> > +#define HAVE_LSM_SET_SELF_ATTR 1
> > +static int lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
> > +                            uint32_t size, uint32_t flags)
> > +{
> > +       return syscall(__NR_lsm_set_self_attr, attr, ctx, size, flags);
> > +}
> > +#endif
> > +
> > +/*
> > + * Precondition: caller must have already done unshare(CLONE_NEWNS) or
> > + * been created via clone(CLONE_NEWNS) and mounted a MS_REC|MS_PRIVATE
> > + * / filesystem so that any pre-existing selinuxfs mount can be
> > + * modified freely by selinux_unshare(). See ../utils/unshareselinux.c
> > + * for an example.
> > + */
> > +int selinux_unshare(void)
> > +{
> > +       struct lsm_ctx ctx;
> > +       int ret;
> > +
> > +       ctx.id =3D LSM_ID_SELINUX;
> > +       ctx.flags =3D 0;
> > +       ctx.len =3D sizeof(ctx);
> > +       ctx.ctx_len =3D 0;
> > +
> > +       /* Unshare the SELinux namespace */
> > +       ret =3D lsm_set_self_attr(LSM_ATTR_UNSHARE, &ctx, sizeof(ctx), =
0);
> > +       if (ret < 0)
> > +               return -1;
> > +
> > +       /* Unmount the selinuxfs which refers to the old/parent namespa=
ce */
> > +       ret =3D umount(SELINUXMNT);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       /*
> > +        * Caller is responsible for mounting new selinuxfs, loading po=
licy,
> > +        * setting enforcing mode, etc.
> > +        */
> > +
> > +       return 0;
> > +}
> > diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
> > index 2e10b14f..bb290d90 100644
> > --- a/libselinux/utils/.gitignore
> > +++ b/libselinux/utils/.gitignore
> > @@ -30,3 +30,4 @@ setfilecon
> >  togglesebool
> >  selinux_check_access
> >  validatetrans
> > +unshareselinux
> > diff --git a/libselinux/utils/unshareselinux.c b/libselinux/utils/unsha=
reselinux.c
> > new file mode 100644
> > index 00000000..b396b4fe
> > --- /dev/null
> > +++ b/libselinux/utils/unshareselinux.c
> > @@ -0,0 +1,42 @@
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE
> > +#endif
> > +
> > +#include <sched.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <sys/mount.h>
> > +#include <selinux/selinux.h>
> > +
> > +int main(int argc, char **argv)
> > +{
> > +       int ret;
> > +
> > +       ret =3D unshare(CLONE_NEWNS);
> > +       if (ret < 0) {
> > +               perror("unshare(CLONE_NEWNS)");
> > +               exit(1);
> > +       }
> > +
> > +       ret =3D mount("none", "/", NULL, MS_REC | MS_PRIVATE, NULL);
> > +       if (ret < 0) {
> > +               perror("mount(/)");
> > +               exit(1);
> > +       }
> > +
> > +       ret =3D selinux_unshare();
> > +       if (ret < 0) {
> > +               perror("selinux_unshare");
> > +               exit(1);
> > +       }
> > +
> > +       if (argc < 2) {
> > +               fprintf(stderr, "usage: %s command args...\n", argv[0])=
;
> > +               exit(1);
> > +       }
> > +
> > +       execvp(argv[1], &argv[1]);
> > +       perror(argv[1]);
> > +}
> > --
> > 2.50.1
> >
