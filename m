Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8D64A4842;
	Fri, 18 Sep 2026 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716495; cv=none; b=hVozF4ViVrtM1E9zHhzizvI1Y6s7ulswD7Kw/vUiOOs7x0h+ssX68snCrfLhPll26Zhs1PUJOnuy93RmyEBm98hBpjMI7EKrgDd6GMhPrRF7Wn9oZsIHLwC1RBEk9R9u0/MgKQuEYLWCHQ0P9bz7uL8MnBlb0pCJherjbqzvd5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716495; c=relaxed/simple;
	bh=z9d99/rxOW1nQfP5fM1K+vdvqvuf3TqZ0MmNsHP0Lps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9Q8n9tjEp2wc/fi/Y7qCVdtIL88DKGq4EySdeobAvRzyN17uk5xvYJ8Nq35dZN66iw1cd9ZMLRkBBDtulbzzG7cVMzygCCTzSGX75F4NzzS2awYFCZh79qEFttpvUfbFvbgBybONQYIb9cUwZlnyZiSTMjnG0a5VSnQHWAtOA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoaD5iIE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoaD5iIE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DEB1F000FF;
	Fri, 18 Sep 2026 07:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789716482;
	bh=mtFqLx8WMWdyHMx6wmboMfxQCGzliJI+dmsZqGbwLQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RoaD5iIEoCPQrHXU+U8wVKNg9pVdgksf27ihSN/Nt1uEp5387yrjNavwuZG0bw2uE
	 07OkGmtl3iNUi99eiMveVonJHcjfhPZHVba68XHil6+FVCLohoHi3YJQAUvKGeKSV3
	 6jjvfg7PYdJfdHaKGeDvINW3RDruYRnbpUR/C8vaWrVDFyBhu3JOrxkDcFar6Xq2eL
	 z9AppVILc+MWfJCUdUoj6M79FKSHvX6lo7C3p+QeO4cNCFij1LL+zmvkPaOHLdij/c
	 xUvhuq0VvKaF3PGb4xJGAFTxkMgv2MKj93kawcXpt7e1UOCHm/ocTzlfXNuxpSwSWx
	 WNvIJKU4+uRGw==
Date: Fri, 18 Sep 2026 09:27:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnacek@gmail.com, 
	linux-security-module@vger.kernel.org, mic@digikod.net, serge@hallyn.com, jack@suse.cz, 
	jmorris@namei.org
Subject: Re: [PATCH] lsm: initialize the security blob for the initial
 namespaces
Message-ID: <20260918-kernbereich-altkleider-gespuckt-3b9488e49810@brauner>
References: <20260916194824.37332-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916194824.37332-1-stephen.smalley.work@gmail.com>

On Wed, Sep 16, 2026 at 03:48:24PM -0400, Stephen Smalley wrote:
> Commit f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> added a security blob to struct ns_common and allocates it from
> __ns_common_init(). Most initial namespaces (init_user_ns,
> init_uts_ns, init_pid_ns, init_mnt_ns, and, depending on
> configuration, init_ipc_ns, init_cgroup_ns and init_time_ns) are
> however set up statically via NS_COMMON_INIT() and never pass through
> __ns_common_init(), so their ns_security pointer is left NULL for the
> lifetime of the system. Any LSM that registers an lbs_ns blob and
> dereferences its slice on one of those namespaces (for example from
> the namespace_install hook when a task setns()'s back into an initial
> namespace) will fault.
> 
> Allocate the blob and run the namespace_init hook for each of these
> namespaces at the end of security_init(), after all ordered LSMs have
> registered their hooks, so every LSM sees the initial namespaces the
> same way it sees init_net (which is initialized at runtime via
> ns_common_init(&init_net) from net_ns_init() immediately after
> security_init()) and does not need to special-case them in its own
> ->init() callback.
> 
> Provide an init_ns_common_for_each() iterator in kernel/nscommon.c so
> the list of statically-defined initial namespaces and their Kconfig
> guards live next to the rest of the ns_common infrastructure. init_net
> is intentionally excluded: pre-initializing it here would leak once
> __ns_common_init() clears ns_security and re-allocates.
> 
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  include/linux/ns_common.h |  1 +
>  kernel/nscommon.c         | 45 +++++++++++++++++++++++++++++++++++++++
>  security/lsm_init.c       | 11 ++++++++++
>  3 files changed, 57 insertions(+)
> 
> diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
> index c8e227a3f9e2..742627000453 100644
> --- a/include/linux/ns_common.h
> +++ b/include/linux/ns_common.h
> @@ -11,6 +11,7 @@
>  bool is_current_namespace(struct ns_common *ns);
>  int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops, int inum);
>  void __ns_common_free(struct ns_common *ns);
> +int init_ns_common_for_each(int (*fn)(struct ns_common *ns));
>  struct ns_common *__must_check ns_owner(struct ns_common *ns);
>  
>  static __always_inline bool is_ns_init_inum(const struct ns_common *ns)
> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> index e72426bba29a..4f3cba5518d7 100644
> --- a/kernel/nscommon.c
> +++ b/kernel/nscommon.c
> @@ -1,11 +1,17 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2025 Christian Brauner <brauner@kernel.org> */
>  
> +#include <linux/cgroup.h>
> +#include <linux/ipc_namespace.h>
> +#include <linux/mnt_namespace.h>
>  #include <linux/ns_common.h>
>  #include <linux/nstree.h>
> +#include <linux/pid_namespace.h>
>  #include <linux/proc_ns.h>
>  #include <linux/security.h>
> +#include <linux/time_namespace.h>
>  #include <linux/user_namespace.h>
> +#include <linux/uts_namespace.h>
>  #include <linux/vfsdebug.h>
>  
>  #ifdef CONFIG_DEBUG_VFS
> @@ -101,6 +107,45 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
>  	return 0;
>  }
>  
> +/**
> + * init_ns_common_for_each - iterate the statically-defined initial namespaces
> + * @fn: callback invoked with each initial ns_common
> + *
> + * Walk the initial namespaces that are set up via NS_COMMON_INIT() at compile
> + * time and therefore never pass through __ns_common_init(). The initial
> + * network namespace is intentionally excluded: it is initialized at runtime
> + * via ns_common_init(&init_net) from net_ns_init().
> + *
> + * Return: the first non-zero return from @fn, or 0.
> + */
> +int __init init_ns_common_for_each(int (*fn)(struct ns_common *ns))
> +{
> +	struct ns_common *set[] = {
> +		to_ns_common(&init_user_ns),
> +		to_ns_common(&init_uts_ns),
> +		to_ns_common(&init_pid_ns),
> +		from_mnt_ns(&init_mnt_ns),
> +#if defined(CONFIG_POSIX_MQUEUE) || defined(CONFIG_SYSVIPC)
> +		to_ns_common(&init_ipc_ns),
> +#endif
> +#ifdef CONFIG_CGROUPS
> +		to_ns_common(&init_cgroup_ns),
> +#endif
> +#ifdef CONFIG_TIME_NS
> +		to_ns_common(&init_time_ns),
> +#endif
> +	};
> +	unsigned int i;
> +	int ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(set); i++) {
> +		ret = fn(set[i]);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
>  void __ns_common_free(struct ns_common *ns)
>  {
>  	security_namespace_free(ns);
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index dbda7771013b..60e15215f6bd 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/init.h>
>  #include <linux/lsm_hooks.h>
> +#include <linux/ns_common.h>
>  
>  #include "lsm.h"
>  
> @@ -490,6 +491,16 @@ int __init security_init(void)
>  		lsm_init_single(*lsm);
>  	}
>  
> +	/*
> +	 * The initial namespaces are set up statically via NS_COMMON_INIT()
> +	 * and never pass through __ns_common_init(), so allocate their
> +	 * security blobs and run the namespace_init hooks now that all LSMs
> +	 * are registered. init_net is not covered here; it is initialized
> +	 * at runtime from net_ns_init() shortly after security_init().
> +	 */
> +	if (init_ns_common_for_each(security_namespace_init))
> +		panic("initial LSM ns alloc failed\n");

Wouldn't it be nicer to turn this around and call
security_namespace_init from the ns common code and avoid the callback?
Especially since there's only one.
