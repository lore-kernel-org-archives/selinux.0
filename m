Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805B85733E;
	Thu, 27 Aug 2026 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787852805; cv=none; b=ZafL3cqfPgY02O1ZyAWziNetOJrH+gPhQrXijv9vHqQzl5h05IDua5Rc38GGryaCBlKw9CehrNJTC38MALEtfd3lx9GSXAJQSo80KEU3M5Eqabw+V0uQsZJ9sbc7iZNneWuEg9gqL4YYzovhDgEghZaL0KmDNAKUdS56eJVnXyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787852805; c=relaxed/simple;
	bh=ptA/xWbq8+SD+2Ch3QmBRQyO4sclv1PA/gFeSLbI0WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwxyBbolcMr+avm5jXYlWooUuBEC9mb4dNv/1l+KICCuVhFTmVFkyKpSQoxyy2HtPeNn3+qSD5nashGHkxg9fA2ljf5qK//M0HzVC/s/T60YvDLERXwKacWfMCURfZA6V8142hBwLzL2fp2FHkXW741jmg0Vp2rP1OaU5cpK5kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CP+igfjs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CP+igfjs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06371F000E9;
	Thu, 27 Aug 2026 17:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787852804;
	bh=kiHY7Snf377oa7VYd1mbKOFtc64xcuOE4VHGz2nzZeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CP+igfjszNlZbIUl7rnHGKc5raqEHjwLHnJe417BWX3yWF9HaM6DN85AdSyFdpafR
	 Vs4wm/WpPGSXKAbNEA/53AhUN6oEC7hN4jHHCkhXbAMRBor1W42XhpsHhsVCbuN3sq
	 pVqH7VlFQru3zOkJ+Ppn3rsCpseAJ9UL5iXp0XKdaag17hYjN16BifGsha9HFLe5yi
	 BZgX0MQ4oBHg+iEv49WYDHIpSXDfDsIAYSmVkrrbaIS/k4FGHHw2vz/m2uDgtQS4P7
	 H99s1MB3vgV9u2lVYfJL53d4tk59HUNmhpJDyasvRkRSVFKdr5TL1fJCmbDtuBesoW
	 G4dI2uPeb2enQ==
Date: Thu, 27 Aug 2026 18:46:37 +0100
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
Subject: Re: [PATCH v2 3/3] selinux: require PROCESS__PTRACE for FOLL_FORCE
 introspection
Message-ID: <apB32VUayqL37wyf@gremlin>
References: <20260825-selinux-pokemem-v2-0-b46bc64916d8@google.com>
 <20260825-selinux-pokemem-v2-3-b46bc64916d8@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-selinux-pokemem-v2-3-b46bc64916d8@google.com>

On Tue, Aug 25, 2026 at 08:39:19PM +0200, Jann Horn wrote:
> On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process can
> only create anonymous executable memory via /proc/self/mem if it has
> PROCESS__PTRACE (like when using /proc/$pid/mem of another process).
>
> This closes a hole in code integrity enforcement that Project Zero has used
> in a remote Android exploit chain:
> It was possible to use a memory corruption bug in a service without
> EXECMEM/EXECMOD/PTRACE permission to overwrite executable code via
> /proc/self/mem, which made it possible to load and run shellcode containing
> a kernel exploit.
>
> Signed-off-by: Jann Horn <jannh@google.com>

Not really my area but in general looks reasonable so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  security/selinux/hooks.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 18dd28b2bb13..2c2c60e9e0fe 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2157,6 +2157,27 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
>  			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
>  }
>
> +/*
> + * Decide whether it should be possible to read non-readable VMAs and write
> + * non-writable VMAs via /proc/self/mem.
> + * This only applies to systems configured with PROC_MEM_FORCE_ALWAYS, and only
> + * triggers on accesses that are not visible to selinux_ptrace_access_check()
> + * because of the introspection exceptions in may_access_mm() and
> + * __ptrace_may_access().
> + *
> + * This allows a process to overwrite read-only code in its own address space.
> + *
> + * Creating an audit record on denial doesn't make sense here, since we can't
> + * tell whether FOLL_FORCE matters for the accessed VMAs.
> + */
> +static int selinux_mem_foll_force_opened_by_owner(const struct cred *subject)
> +{
> +	struct av_decision avd;
> +	u32 sid = cred_sid(subject);
> +
> +	return avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, PROCESS__PTRACE, 0, &avd);
> +}
> +
>  static int selinux_capget(const struct task_struct *target, kernel_cap_t *effective,
>  			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
>  {
> @@ -7558,6 +7579,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>
>  	LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
> +	LSM_HOOK_INIT(mem_foll_force_opened_by_owner, selinux_mem_foll_force_opened_by_owner),
>  	LSM_HOOK_INIT(capget, selinux_capget),
>  	LSM_HOOK_INIT(capset, selinux_capset),
>  	LSM_HOOK_INIT(capable, selinux_capable),
>
> --
> 2.55.0.860.g4b6b3295ed-goog
>

--
Cheers, Lorenzo
