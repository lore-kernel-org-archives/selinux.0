Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E932E1723
	for <selinux@vger.kernel.org>; Fri, 22 Aug 2025 20:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755895514; cv=none; b=ulZiX21F/sufRSlNKeq8QPep1HCQdbfitjQ1wsaKuPkSsD2ufZmNdDMdje7HnSZrep9nBuU8diYGgdSPRx4jb90J8xFU2Q8ior9IAaDLaqrVDdyZ13tQHWFeRREg43XkQ+sOElRNvVOY8q9fyrqz080nrM37B1fH3PrGQ3XVHIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755895514; c=relaxed/simple;
	bh=FppbUkkuDBCNhvS9ysIo/hrG7giHrLQyR/P0bRPzaCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVw/cBQCBuV+yTMBym13j0gtDsR6XED7fMOv+bYBzDjeFuEihP+/FzAy99V180iGWh1EEHgRdeztGlL5Io2owwcy8GA0wOfHWQKuxF4MbXTR0xRG435Rkw38OWI1rG4OWTp0Eld1hhFtE4dTDvPtjcYXgYp9i1jV47DV12ZD3fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I8Zg25xw; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I8Zg25xw"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b49c622e598so640916a12.1
        for <selinux@vger.kernel.org>; Fri, 22 Aug 2025 13:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755895512; x=1756500312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPJhEisFp5RIuunPMpN4KZpGxRCTcK4wip8JiWHd0Mc=;
        b=I8Zg25xw7uWIxJM06QGIlysqbOCjCe6TnmlSDwOZA3LYHkb7uDhovCRQ5k+4sqL9db
         N2sM2hhZRbItdQ/MRtQSKjziDQN9tEsLFBsA4KqVMeRF0RroLsCPZ01RQ95FvFsf97g6
         3NXQKEvHm4aglmYeOThN+8/4fg9UvgRRpO7nJHqIBXly6f1K3p1l5Mvwc8KAr1F3zOs2
         qDukRkDSFlPn3wkIy0rw2bl47QKoQVKDJFGD4pQ6YWojAKxmLTUOR4+urcDxm/OL8GSW
         GjfgypQD2wDGqj41P/Jpe++cV+qdBvBWLNQ8Q3s/OcUqG7cLUWX+LLMPETY4tdzmRikw
         4wlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755895512; x=1756500312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPJhEisFp5RIuunPMpN4KZpGxRCTcK4wip8JiWHd0Mc=;
        b=PvkroEM3EjjBHGI0zdCp1Zr+CLirmq8PBqr1xWTDWcblDc2Y/Mgr7LrTAYg2qhf6Ww
         ezj3N9em6c8hJW+yrrX7xnBFHdQIo64M8CFYULHoM99/KYPh1RFKanIbw1dTAUBLExSo
         MAIu5J3TvyXgD0aB8HimkfwXuajWs8zaOgBzkItnP6D6oMjcpeTmPpB0pyv0DrUXbn4o
         glX2lKknWeJAxPTE3QkPR+hZypAVhIWHzzbJnkBPfdVkUuyLYeQxCAXS6lmwO2QxyQWB
         XfTlA24iICkDUfUG1Ge0tWg1hguCo6itCPsW6NprhZhL5XmEYZCNb0X4aa5DFgm9ZS+U
         vOxA==
X-Forwarded-Encrypted: i=1; AJvYcCV4EMGT1a7HApAD5dvJ/36GkgeCS2R8ZjlMoRAaDoFSyAnHjY7fWBUjP1p8lxKzFoNBhPhefmwC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+z1+qbbEkIgxsUmK6CTqHsMIr+OVm4/+bPef23iokERxQSsRF
	auf7RGxoAKTHgirtursO1ljPzJn0lmHTlJCb6ZSt0/RoXYTjUJxXDUPduPHNditGiBxyJJQz8Lv
	HgpgELNLnHEn3AxStWI1nzif4nTsnC7u63Cvgzgky
X-Gm-Gg: ASbGncvviYcLf1hzKYmzueTREYQrN+MqyGiT9D3zc35Jo0k5SICMCs9jNcX3q05D0Lv
	UtEbuj0MN5YbKYZFu6lbY88lTkDayfLzCZrGy+RWUTlJRp+/Lr5BDvPf51MPIbMAFdH+FLdyy0y
	EWlrdzv+T/kGaZjCcvvHh3NB3E/Hyf7X9m1x6cryWe6OHZASxZyiEoEZAeKiOX18KwS96PPuzl6
	Y15pdk=
X-Google-Smtp-Source: AGHT+IEseLmqhypcA8hxPueCpLuTQOpnoAeGd2rXXtub95U2zol/Z4aBXKVTyYKfNo1S21aJewQscGd1mSXj4uHONQM=
X-Received: by 2002:a17:902:e892:b0:243:8f:6db5 with SMTP id
 d9443c01a7336-2462ee0baa0mr71583245ad.6.1755895512376; Fri, 22 Aug 2025
 13:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-67-paul@paul-moore.com>
In-Reply-To: <20250814225159.275901-67-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 22 Aug 2025 16:45:01 -0400
X-Gm-Features: Ac12FXwAmBOh1Qla5u9ysof2AD0FPd676U7pDGbNXskY4u6RCqn1903OQNx1Eek
Message-ID: <CAHC9VhS3KdVO9n-dgk1qFzTae0i+Oab8atMmt0CAsMEm1D4v5w@mail.gmail.com>
Subject: Re: [PATCH v3 31/34] ima,evm: move initcalls to the LSM framework
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 6:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> This patch converts IMA and EVM to use the LSM frameworks's initcall
> mechanism.  There was a minor challenge in this conversion that wasn't
> seen when converting the other LSMs brought about by the resource
> sharing between the two related, yes independent IMA and EVM LSMs.
> This was resolved by registering the same initcalls for each LSM and
> including code in each registered initcall to ensure it only executes
> once during each boot.
>
> It is worth mentioning that this patch does not touch any of the
> "platform certs" code that lives in the security/integrity/platform_certs
> directory as the IMA/EVM maintainers have assured me that this code is
> unrelated to IMA/EVM, despite the location, and will be moved to a more
> relevant subsystem in the future.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/integrity/Makefile       |  2 +-
>  security/integrity/evm/evm_main.c |  6 ++---
>  security/integrity/iint.c         |  4 +--
>  security/integrity/ima/ima_main.c |  6 ++---
>  security/integrity/initcalls.c    | 41 +++++++++++++++++++++++++++++++
>  security/integrity/initcalls.h    | 28 +++++++++++++++++++++
>  6 files changed, 78 insertions(+), 9 deletions(-)
>  create mode 100644 security/integrity/initcalls.c
>  create mode 100644 security/integrity/initcalls.h

Mimi, Roberto, I believe I've incorporated all of your feedback thus
far, does this patch look okay to you?  If so, can I get an ACK from
one or both of you?

> diff --git a/security/integrity/Makefile b/security/integrity/Makefile
> index 92b63039c654..6ea330ea88b1 100644
> --- a/security/integrity/Makefile
> +++ b/security/integrity/Makefile
> @@ -5,7 +5,7 @@
>
>  obj-$(CONFIG_INTEGRITY) +=3D integrity.o
>
> -integrity-y :=3D iint.o
> +integrity-y :=3D iint.o initcalls.o
>  integrity-$(CONFIG_INTEGRITY_AUDIT) +=3D integrity_audit.o
>  integrity-$(CONFIG_INTEGRITY_SIGNATURE) +=3D digsig.o
>  integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) +=3D digsig_asymmetric.o
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/e=
vm_main.c
> index db8e324ed4e6..823573bcaa27 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -25,6 +25,7 @@
>  #include <crypto/hash.h>
>  #include <crypto/hash_info.h>
>  #include <crypto/utils.h>
> +#include "../initcalls.h"
>  #include "evm.h"
>
>  int evm_initialized;
> @@ -1112,7 +1113,7 @@ void __init evm_load_x509(void)
>  }
>  #endif
>
> -static int __init init_evm(void)
> +int __init init_evm(void)
>  {
>         int error;
>         struct list_head *pos, *q;
> @@ -1179,6 +1180,5 @@ DEFINE_LSM(evm) =3D {
>         .init =3D init_evm_lsm,
>         .order =3D LSM_ORDER_LAST,
>         .blobs =3D &evm_blob_sizes,
> +       .initcall_late =3D integrity_late_init,
>  };
> -
> -late_initcall(init_evm);
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 068ac6c2ae1e..a4b88d67ff43 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -11,6 +11,7 @@
>   */
>  #include <linux/security.h>
>  #include "integrity.h"
> +#include "initcalls.h"
>
>  struct dentry *integrity_dir;
>
> @@ -42,7 +43,7 @@ void __init integrity_load_keys(void)
>                 evm_load_x509();
>  }
>
> -static int __init integrity_fs_init(void)
> +int __init integrity_fs_init(void)
>  {
>         integrity_dir =3D securityfs_create_dir("integrity", NULL);
>         if (IS_ERR(integrity_dir)) {
> @@ -58,4 +59,3 @@ static int __init integrity_fs_init(void)
>         return 0;
>  }
>
> -late_initcall(integrity_fs_init)
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index eade8e1e3cb1..06ae59cd77f4 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -28,6 +28,7 @@
>  #include <linux/iversion.h>
>  #include <linux/evm.h>
>  #include <linux/crash_dump.h>
> +#include "../initcalls.h"
>
>  #include "ima.h"
>
> @@ -1202,7 +1203,7 @@ static int ima_kernel_module_request(char *kmod_nam=
e)
>
>  #endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
>
> -static int __init init_ima(void)
> +int __init init_ima(void)
>  {
>         int error;
>
> @@ -1283,6 +1284,5 @@ DEFINE_LSM(ima) =3D {
>         .init =3D init_ima_lsm,
>         .order =3D LSM_ORDER_LAST,
>         .blobs =3D &ima_blob_sizes,
> +       .initcall_late =3D integrity_late_init,
>  };
> -
> -late_initcall(init_ima);       /* Start IMA after the TPM is available *=
/
> diff --git a/security/integrity/initcalls.c b/security/integrity/initcall=
s.c
> new file mode 100644
> index 000000000000..6afa411068f2
> --- /dev/null
> +++ b/security/integrity/initcalls.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * IMA/EVM initcalls
> + *
> + */
> +
> +#include <linux/init.h>
> +
> +#include "initcalls.h"
> +
> +/**
> + * integrity_late_init - late_initcalls for IMA/EVM
> + *
> + * This helper function wraps all of the late_initcalls for both IMA and=
 EVM.
> + * It can be called multiple times, e.g. once from IMA and once from EVM=
,
> + * without problem as it maintains an internal static state variable whi=
ch
> + * ensures that any setup/initialization is only done once.
> + */
> +int __init integrity_late_init(void)
> +{
> +       int rc =3D 0, rc_tmp;
> +       static bool setup =3D false;
> +
> +       if (setup)
> +               return 0;
> +       setup =3D true;
> +
> +       rc_tmp =3D integrity_fs_init();
> +       if (!rc && rc_tmp)
> +               rc =3D rc_tmp;
> +
> +       rc_tmp =3D init_ima();
> +       if (!rc && rc_tmp)
> +               rc =3D rc_tmp;
> +
> +       rc_tmp =3D init_evm();
> +       if (!rc && rc_tmp)
> +               rc =3D rc_tmp;
> +
> +       return rc;
> +}
> diff --git a/security/integrity/initcalls.h b/security/integrity/initcall=
s.h
> new file mode 100644
> index 000000000000..b56e9c576505
> --- /dev/null
> +++ b/security/integrity/initcalls.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _INTEGRITY_INITCALLS_H
> +#define _INTEGRITY_INITCALLS_H
> +
> +int integrity_fs_init(void);
> +
> +#ifdef CONFIG_IMA
> +int init_ima(void);
> +#else
> +static inline int init_ima(void)
> +{
> +       return 0;
> +}
> +#endif
> +
> +#ifdef CONFIG_EVM
> +int init_evm(void);
> +#else
> +static inline int init_evm(void)
> +{
> +       return 0;
> +}
> +#endif
> +
> +int integrity_late_init(void);
> +
> +#endif
> --
> 2.50.1

--=20
paul-moore.com
