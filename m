Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0093225B092
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 01:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786669589; cv=none; b=tOE/Npv7v7+16EI0Pu3qDBiQlhgEuRnk+24GOB/A417K5pms2r+Phr+iDrOUDOURCuFjD0Ao2QGF+MtqwmYUA6pel5XVAf5JgSTUrXEhH9NO33obFaHjA58M2uIo1H4sgW40hfgeFCxrDdv3r6fDeUP7eEAzZb3PESNOvSZSiMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786669589; c=relaxed/simple;
	bh=LCawfRGCiZ7hCYVXuqAVRobR9wxgLA6WwfjJGGsVZp4=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=arh8W703/Y+0N6SVXIMTjKGxdGu1c1zAhPK7qQkEpIdB17vDiNQa1wjzCuW0MNr41VDA6exyQ/Vi5CnEXd/N+bjHiWA2l1jOH31/E7h5OO1D826rzzAki4ZJK/s8lD7dgH4s31/Y02PzW8kXwmfj+i4S/prMmpZ6upXusYZ90JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csoKLqPQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csoKLqPQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AE21F000E9
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 01:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786669587;
	bh=576vpelqxFx8hr/wpaiYoc/UAFlHGSglv7qtCFyvdoA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=csoKLqPQj9QpF7DsnH/PVgMHH/NE5CzO1vJnCTROc1zK3DzFuhnzSK+GItUzwIGtA
	 IWWhOpjG4lCK5d4NKhk7wSONXL+PF0I9qBMaDnSpOP9EhxOYO9Ea2l+sneCTC6yXuQ
	 0Lnd1WUDwspBfsTcsgzphMJ4j2dc5gF/qGDjB7Vlhn3EA6mMqhte6UxBkb19waZi8w
	 2sChuoxtwvuqHDctAI0nGydY6NrFSS2BsvOO+T5mnAFfJq78szIQOodXzvR6kNYED3
	 YUYC9PBNRYaABJUJy2W4XB+lK7fsb7eLWQh4zAYvZ62dxq4pAvh0F0MkZFVdAsf4ed
	 39dzhgSC2eZlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] net, smack: Create a function to set secmarks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260813204854.19211-2-casey@schaufler-ca.com>
References: <20260813204854.19211-1-casey@schaufler-ca.com>
 <20260813204854.19211-2-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:06:26 +0000
Message-Id: <20260814010627.54AE21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The helper `secxa_set_secmark` causes build failures under two vali=
d kernel configurations: when `CONFIG_SECURITY=3Dy` with `CONFIG_NETWORK_SE=
CMARK=3Dn` (invalid struct member access), and when `CONFIG_SECURITY=3Dn` w=
ith `CONFIG_NETWORK_SECMARK=3Dy` (implicit function declaration).
--

--- Patch [1]: [PATCH 1/7] net, smack: Create a function to set secmarks ---
commit e74441b7e906ce8624528752b177a2d903d76f44
Author: Casey Schaufler <casey@schaufler-ca.com>

net, smack: Create a function to set secmarks

This patch creates a helper function secxa_set_secmark() to assign a secmark
to an skb, replacing direct assignments to skb->secmark. This allows for
cases where assigning a secmark is more complex.

> diff --git a/include/linux/lsm_secxa.h b/include/linux/lsm_secxa.h
> new file mode 100644
> index 0000000000000..f4c732d26680c
> --- /dev/null
> +++ b/include/linux/lsm_secxa.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (C) 2026 Casey Schaufler <casey@schaufler-ca.com>
> + */
> +
> +#ifndef __LINUX_LSM_SECXA_H
> +#define __LINUX_LSM_SECXA_H
> +
> +#ifdef CONFIG_SECURITY
> +
> +#include <linux/security.h>
> +#include <linux/skbuff.h>
> +
> +static inline void secxa_set_secmark(struct sk_buff *skb, u32 secxa)
> +{
> +	skb->secmark =3D secxa;

[Severity: Low]
Could this cause build failures under certain configurations?

If CONFIG_SECURITY is enabled but CONFIG_NETWORK_SECMARK is disabled,
skb->secmark won't exist in struct sk_buff, which would result in an invalid
member access error here.

Additionally, if CONFIG_SECURITY is disabled but CONFIG_NETWORK_SECMARK is
enabled, this function won't be declared. This would cause implicit function
declaration errors in modules like xt_CONNSECMARK.c that call it.

Should this helper be guarded by CONFIG_NETWORK_SECMARK instead of
CONFIG_SECURITY, or perhaps both?

> +}
> +
> +#endif /* CONFIG_SECURITY */
> +
> +#endif  /* __LINUX_LSM_SECXA_H */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813204854.1921=
1-1-casey@schaufler-ca.com?part=3D1
