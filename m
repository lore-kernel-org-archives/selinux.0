Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F37EECAAA1
	for <selinux@archiver.kernel.org>; Sat, 10 Sep 2022 02:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiIJCv3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Sep 2022 22:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIJCv2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Sep 2022 22:51:28 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8F061B14;
        Fri,  9 Sep 2022 19:51:26 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 8DD1C128B; Fri,  9 Sep 2022 21:51:24 -0500 (CDT)
Date:   Fri, 9 Sep 2022 21:51:24 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        linux-audit@redhat.com, Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH RFC] LSM: lsm_self_attr system call to get security
 module attributes
Message-ID: <20220910025124.GA24133@mail.hallyn.com>
References: <5a9ff61e-cfe1-7385-aa17-5b800e489a9a.ref@schaufler-ca.com>
 <5a9ff61e-cfe1-7385-aa17-5b800e489a9a@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a9ff61e-cfe1-7385-aa17-5b800e489a9a@schaufler-ca.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 09, 2022 at 06:01:33PM -0700, Casey Schaufler wrote:
> This is probably a tin-man proposal for the first in a series of
> system calls dealing with Linux security module data. It is based
> on suggestions by Paul Moore, however the flaws in design and
> implementation are all mine.
> 
> Create a system call lsm_self_attr() to provide the security
> module maintained attributes of the current process. Historically
> these attributes have been exposed to user space via entries in
> procfs under /proc/self/attr.
> 
> Attributes are provided as a collection of lsm_ctx structures
> which are placed into a user supplied buffer. Each structure
> identifies the security module providing the attribute, which
> of the possible attributes is provided, the size of the
> attribute, and finally the attribute value as a nul terminated
> string.
> 
> An LSM ID table is introduced to map IDs to security modules.

Probably best to cc: linux-api right off the bat, right?

> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> 
> --
>  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>  include/linux/syscalls.h               |   1 +
>  include/uapi/asm-generic/unistd.h      |   5 +-
>  include/uapi/linux/lsm.h               |  67 +++++++++++++
>  kernel/sys_ni.c                        |   3 +
>  security/Makefile                      |   2 +-
>  security/lsm_syscalls.c                | 166 +++++++++++++++++++++++++++++++++
>  7 files changed, 243 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index c84d12608cd2..56d5c5202fd0 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -372,6 +372,7 @@
>  448	common	process_mrelease	sys_process_mrelease
>  449	common	futex_waitv		sys_futex_waitv
>  450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
> +451	common	lsm_self_attr		sys_lsm_self_attr
>  
>  #
>  # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index a34b0f9a9972..7f87ef8be546 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1056,6 +1056,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
>  asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
>  					    unsigned long home_node,
>  					    unsigned long flags);
> +asmlinkage long sys_lsm_self_attr(struct lsm_ctx *ctx, size_t *size, int flags);
>  
>  /*
>   * Architecture-specific system calls
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 45fa180cc56a..aa66718e1b48 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -886,8 +886,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
>  #define __NR_set_mempolicy_home_node 450
>  __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
>  
> +#define __NR_lsm_self_attr 451
> +__SYSCALL(__NR_lsm_self_attr, sys_lsm_self_attr)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 451
> +#define __NR_syscalls 452
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> new file mode 100644
> index 000000000000..ec7bb1a7b943
> --- /dev/null
> +++ b/include/uapi/linux/lsm.h
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Linus Security Modules (LSM) - User space API
> + *
> + * Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> + * Copyright (C) Intel Corporation
> + */
> +
> +#ifndef _UAPI_LINUX_LSM_H
> +#define _UAPI_LINUX_LSM_H
> +
> +#include <linux/types.h>
> +#include <linux/unistd.h>
> +
> +/**
> + * struct lsm_ctx - LSM context
> + * @id: the LSM id number, see LSM_ID_XXX
> + * @flags: context specifier and LSM specific flags
> + * @ctx_len: the size of @ctx
> + * @ctx: the LSM context, a nul terminated string
> + *
> + * @ctx in a nul terminated string.
> + * 	(strlen(@ctx) < @ctx_len) is always true.
> + * 	(strlen(@ctx) == @ctx_len + 1) is not guaranteed.
> + */
> +struct lsm_ctx {
> +	unsigned int	id;
> +	unsigned int	flags;
> +	__kernel_size_t		ctx_len;
> +	unsigned char	ctx[];
> +};
> +
> +/*
> + * ID values to identify security modules.
> + * A system may use more than one security module.
> + * 
> + * LSM_ID_XXX values 32 and below are reserved for future use
> + */
> +#define LSM_ID_SELINUX		33
> +#define LSM_ID_SMACK		34
> +#define LSM_ID_TOMOYO		35
> +#define LSM_ID_IMA		36
> +#define LSM_ID_APPARMOR		37
> +#define LSM_ID_YAMA		38
> +#define LSM_ID_LOADPIN		39
> +#define LSM_ID_SAFESETID	40
> +#define LSM_ID_LOCKDOWN		41
> +#define LSM_ID_BPF		42
> +#define LSM_ID_LANDLOCK		43
> +
> +/*
> + * Flag values.
> + *
> + * LSM_ATTR_XXX values identify the /proc/.../attr entry that the
> + * context represents. Not all security modules provide all of these
> + * values. Some security modules provide none of them.
> + */
> +/* clang-format off */
> +#define LSM_ATTR_CURRENT	(1UL << 0)
> +#define LSM_ATTR_EXEC		(1UL << 1)
> +#define LSM_ATTR_FSCREATE	(1UL << 2)
> +#define LSM_ATTR_KEYCREATE	(1UL << 3)
> +#define LSM_ATTR_PREV		(1UL << 4)
> +#define LSM_ATTR_SOCKCREATE	(1UL << 5)
> +/* clang-format on */
> +
> +#endif /* _UAPI_LINUX_LSM_H */
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index a492f159624f..c579ffc50454 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -262,6 +262,9 @@ COND_SYSCALL_COMPAT(recvmsg);
>  /* mm/nommu.c, also with MMU */
>  COND_SYSCALL(mremap);
>  
> +/* security/lsm_syscalls.c */
> +COND_SYSCALL(lsm_attr_self);
> +
>  /* security/keys/keyctl.c */
>  COND_SYSCALL(add_key);
>  COND_SYSCALL(request_key);
> diff --git a/security/Makefile b/security/Makefile
> index 18121f8f85cd..409c47a25fcf 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -6,7 +6,7 @@
>  obj-$(CONFIG_KEYS)			+= keys/
>  
>  # always enable default capabilities
> -obj-y					+= commoncap.o
> +obj-y					+= commoncap.o lsm_syscalls.o
>  obj-$(CONFIG_MMU)			+= min_addr.o
>  
>  # Object file lists
> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> new file mode 100644
> index 000000000000..fba8aeea1a10
> --- /dev/null
> +++ b/security/lsm_syscalls.c
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * System calls implementing the Linux Security Module API.
> + *
> + *  Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> + *  Copyright (C) Intel Corporation
> + */
> +
> +#include <asm/current.h>
> +#include <linux/compiler_types.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/security.h>
> +#include <linux/stddef.h>
> +#include <linux/syscalls.h>
> +#include <linux/types.h>
> +#include <uapi/linux/lsm.h>
> +
> +struct id_map {
> +	char *name;
> +	int id;
> +};
> +
> +static const struct id_map lsm_attr_names[] = {
> +	{ "current",	LSM_ATTR_CURRENT, },
> +	{ "exec",	LSM_ATTR_EXEC, },
> +	{ "fscreate",	LSM_ATTR_FSCREATE, },
> +	{ "keycreate",	LSM_ATTR_KEYCREATE, },
> +	{ "prev",	LSM_ATTR_PREV, },
> +	{ "sockcreate",	LSM_ATTR_SOCKCREATE, },
> +};
> +
> +static const struct id_map lsm_names[] = {
> +	{ "selinux",	LSM_ID_SELINUX, },
> +	{ "smack",	LSM_ID_SMACK, },
> +	{ "tomoyo",	LSM_ID_TOMOYO, },
> +	{ "ima",	LSM_ID_IMA, },
> +	{ "apparmor",	LSM_ID_APPARMOR, },
> +	{ "yama",	LSM_ID_YAMA, },
> +	{ "loadpin",	LSM_ID_LOADPIN, },
> +	{ "safesetid",	LSM_ID_SAFESETID, },
> +	{ "lockdown",	LSM_ID_LOCKDOWN, },
> +	{ "bpf",	LSM_ID_BPF, },
> +	{ "landlock",	LSM_ID_LANDLOCK, },
> +};
> +
> +/**
> + * lsm_self_attr - Return current task's security module attributes
> + * @ctx: the LSM contexts
> + * @size: size of @ctx, updated on return
> + * @flags: reserved for future use, must be zero
> + *
> + * Returns the calling task's LSM contexts. On success this
> + * function returns the number of @ctx array elements. This value
> + * may be zero if there are no LSM contexts assigned. If @size is
> + * insufficient to contain the return data -E2BIG is returned and
> + * @size is set to the minimum required size. In all other cases
> + * a negative value indicating the error is returned.
> + */
> +SYSCALL_DEFINE3(lsm_self_attr,
> +	       struct lsm_ctx __user *, ctx,
> +	       size_t __user *, size,
> +	       int, flags)
> +{
> +	struct lsm_ctx *final = NULL;
> +	struct lsm_ctx *interum;
> +	struct lsm_ctx *ip;
> +	void *curr;
> +	char **interum_ctx;
> +	char *cp;
> +	size_t total_size = 0;
> +	int count = 0;
> +	int attr;
> +	int lsm;
> +	int len;
> +	int rc = 0;
> +	int i;
> +
> +	interum = kzalloc(ARRAY_SIZE(lsm_attr_names) * ARRAY_SIZE(lsm_names) *
> +			  sizeof(*interum), GFP_KERNEL);
> +	if (interum == NULL)
> +		return -ENOMEM;
> +	ip = interum;
> +
> +	interum_ctx = kzalloc(ARRAY_SIZE(lsm_attr_names) *
> +			      ARRAY_SIZE(lsm_names) * sizeof(*interum_ctx),
> +			      GFP_KERNEL);
> +	if (interum_ctx == NULL) {
> +		kfree(interum);
> +		return -ENOMEM;
> +	}
> +
> +	for (attr = 0; attr < ARRAY_SIZE(lsm_attr_names); attr++) {
> +		for (lsm = 0; lsm < ARRAY_SIZE(lsm_names); lsm++) {
> +			len = security_getprocattr(current,
> +						   lsm_names[lsm].name,
> +						   lsm_attr_names[attr].name,
> +						   &cp);
> +			if (len <= 0)
> +				continue;
> +
> +			ip->id = lsm_names[lsm].id;
> +			ip->flags = lsm_attr_names[attr].id;
> +			ip->ctx_len = len;
> +			interum_ctx[count] = cp;
> +			/*
> +			 * Security modules have been inconsistent about
> +			 * including the \0 terminator in the size. Add
> +			 * space for it from an abundance of caution.
> +			 * At least one security module adds a \n at the
> +			 * end of a context to make it look nicer. Change
> +			 * that to a \0 so that user space does't have to
> +			 * work around it. Because of this meddling it is
> +			 * safe to assume that lsm_ctx.name is terminated
> +			 * and that strlen(lsm_ctx.name) < lsm.ctx_len.
> +			 */
> +			total_size += sizeof(*interum) + len + 1;
> +			cp = strnchr(cp, len, '\n');
> +			if (cp != NULL)
> +				*cp = '\0';
> +			ip++;
> +			count++;
> +		}
> +	}
> +
> +	if (count == 0)
> +		goto free_out;
> +
> +	final = kzalloc(total_size, GFP_KERNEL);
> +	if (final == NULL) {
> +		rc = -ENOMEM;
> +		goto free_out;
> +	}
> +
> +	curr = final;
> +	ip = interum;
> +	for (i = 0; i < count; i++) {
> +		memcpy(curr, ip, sizeof(*interum));
> +		curr += sizeof(*interum);
> +		memcpy(curr, interum_ctx[i], ip->ctx_len);
> +		curr += interum[i].ctx_len;
> +		ip++;
> +	}
> +
> +	if (get_user(len, size)) {
> +		rc = -EFAULT;
> +		goto free_out;
> +	}
> +	if (total_size > len) {
> +		rc = -ERANGE;
> +		goto free_out;
> +	}
> +	if (copy_to_user(ctx, final, total_size) != 0 ||
> +	    put_user(total_size, size) != 0)
> +		rc = -EFAULT;
> +	else
> +		rc = count;
> +
> +free_out:
> +	for (i = 0; i < count; i++)
> +		kfree(interum_ctx[i]);
> +	kfree(interum_ctx);
> +	kfree(interum);
> +	kfree(final);
> +	return rc;
> +}
