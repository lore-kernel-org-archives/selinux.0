Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62C638837A;
	Fri, 21 Aug 2026 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787338606; cv=none; b=WnO1Mc7CFt92Q68ZDRSQ2FjvRr9eYA99Qc3i3FY/d2bD8QST0t5nBBrAnJiYsONphLD9I92MrjCNmDdd7VMiPNSTOi3FAr4NIsdIBYE9yUZWubUC7/aAx6XhfE07/GPffH2VTDTSQTH4p6W83mcGoRJrCJZYf627m7TTPFKnQkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787338606; c=relaxed/simple;
	bh=1KpZmKEJQ7X5VZkSeRdiddTD36aoG3CXbYPnXDhvgn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKrwZQ+0YS+NgOUEWKlSIYBcB7X3QF1aA8I4eHUH1OwSB60ksQJIp+gPDlwnR5elP9mdKJ6qTxWogtRID+1/uWWFvwRnoBcnaqgTKF4+LDao/LGyu3E9G7y/g0JhUmTlZtzW9Qq9N2VpDmOvfG2UL3hVqGqneUz9KwnaO7fyXAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkQCNnKS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkQCNnKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578281F000E9;
	Fri, 21 Aug 2026 18:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787338605;
	bh=ujt60NbqKdENBZQ77CfcHaeZZJdQN/p1Z76EsgS+bZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AkQCNnKSYtat8UOrPuf3sJGUEh9Lh4vv8cbwauS2+Ujg9OR7NymCiidbW3iofdpqh
	 2UTIvDx/sbK+DCcqDmnjJ0+dYnszaWEFLJZpba7EMR1VYBMV6sv9tU+fiqCmvLn9tC
	 LH9DMx678+JdiqTYy+EYOXbMvxH4opD9EtFNKl8Yb4zD/TPGH+WAyk28xShPYxtIsF
	 O9ssFux5L5RUDcGOW4BeljnVwHa4hlt8tYY2q1zhH2Om5asNwkbl6TqOEoLTdpRxsu
	 ZzchuFaq5oc21qL4Bz1vZM8F1ud+eeWayItx+1N0O/b0xrBQASVryR+pvI35Sy1K03
	 tCTJLEnmsG7mQ==
Date: Fri, 21 Aug 2026 19:56:37 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?utf-8?B?VGhpw6liYXVk?= Weksteen <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] selinux: require EXECMEM or PTRACE for FOLL_FORCE
 introspection
Message-ID: <aoie0oyojqdHciKM@gremlin>
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-3-90cd2357ee05@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-selinux-pokemem-v1-3-90cd2357ee05@google.com>

On Tue, Aug 18, 2026 at 09:51:07PM +0200, Jann Horn wrote:
> On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process can
> only create anonymous executable memory via /proc/self/mem if it has one
> of:
>
>  - EXECMEM (like for other methods of creating anonymous executable pages)
>  - PTRACE (like when using /proc/$pid/mem of another process)
>
> This closes a hole in EXECMEM enforcement that Project Zero has used in a
> remote Android exploit chain:
> It was possible to use a memory corruption bug in a service without EXECMEM
> permission to overwrite executable code via /proc/self/mem, which made it
> possible to load and run shellcode with a kernel exploit.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  security/selinux/hooks.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 18dd28b2bb13..905137c47321 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2157,6 +2157,32 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
>  			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
>  }
>
> +/*
> + * Decide whether it should be possible to read non-readable VMAs and write
> + * non-writable VMAs via /proc/self/mem.
> + * This only applies to systems configured with PROC_MEM_FORCE_ALWAYS, and only
> + * triggers on accesses that are not visible to selinux_ptrace_access_check().

It might be worth mentioning may_access_mm() here, and obviously propagate the
suggested name change introspection -> opened_by_owner or fd_from_order maybe
even?

> + *
> + * This allows a process to overwrite read-only code in its own address space.
> + *
> + * Creating an audit record on denial doesn't make sense here, since we can't
> + * tell whether FOLL_FORCE matters for the accessed VMAs.
> + */
> +static int selinux_introspect_mem_foll_force(const struct cred *subject)
> +{
> +	struct av_decision avd;
> +	int rc;
> +	u32 sid = cred_sid(subject);
> +
> +	/* Allow if the process is generally allowed to have executable anonymous memory. */
> +	rc = avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, PROCESS__EXECMEM, 0, &avd);

But does it make sense for the shared-by-fd case? In that case you're now
updating execmem for another process's memory right?



> +
> +	/* Also allow if selinux_ptrace_access_check() would allow it. */
> +	if (rc)
> +		rc = avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, PROCESS__PTRACE, 0, &avd);
> +	return rc;
> +}
> +
>  static int selinux_capget(const struct task_struct *target, kernel_cap_t *effective,
>  			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
>  {
> @@ -7558,6 +7584,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>
>  	LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
> +	LSM_HOOK_INIT(introspect_mem_foll_force, selinux_introspect_mem_foll_force),
>  	LSM_HOOK_INIT(capget, selinux_capget),
>  	LSM_HOOK_INIT(capset, selinux_capset),
>  	LSM_HOOK_INIT(capable, selinux_capable),
>
> --
> 2.55.0.737.g08866a6d13-goog
>

--
Cheers, Lorenzo
