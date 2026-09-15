Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA47642F712;
	Tue, 15 Sep 2026 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491851; cv=none; b=VnNhCzALSNrq+NNaxYePrnS+y8kEafOvgpCmflpnLK7HUb4AVnwTVcbUQgPzri3uVGTZ3DkRDpMWIO4mX3+hNpFGDhfTRVuJLf6ueYDSmwV/5NxRnJH95pqBole89sIgu4gFq7S5myjfpzVwMW+klNSJ1QlEg4SoO51GUAJFz+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491851; c=relaxed/simple;
	bh=AQ/9IN5OXYTHakGvdy0opHCSK4Z4C1mt79b6bh3UUIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/cs+yzaGJ4bd2/aYvEi31wPhR5jzibMgkdmgV7FqkFP+cgaHhTLdcT2eTopFmkml7y8AwxPkWdcR4jwmUHsDeAWoxBzOl9WOUEXp6VoheDaUvGBJkvrqt42wttTYB6vwR0QgPwvgolgGsgG786oA5e9+CqWLT5K4FrkGlxvYpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRG+dve/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRG+dve/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351091F000FF;
	Tue, 15 Sep 2026 17:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789491847;
	bh=PQzh3VGckL53Mndb/s9icBKbUyH8gPEYoAfCQcTHMv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WRG+dve/iOrdQlsX6mrm2ROLt8HNIAmXP0TjZwot1akZghPwDQpk9LA7Cl2xzNmBN
	 QGMi+zcjyBU46HINFulvtdJcFRqcc0K41hX0W0PFfUMn45aOEXZoQFNvjr9TLVECTi
	 7CZMo8dNZEMOYqZbh5KvglLerLodgm3zExj2AJQNmtCJ0OiqXNCuKl1p4ZFENZcxKr
	 sSCtU5j2RXL273vrOWqtWPjLFye4dTJrQsRN41l8K3h7jpLNJXzGkNgwEVMFur2QlS
	 jIqY6OV5Szw6LMjfqTMI96VMnfYSjVe9+siSqyFkosH2Y9SPBr7Euj9vrzCOf8ti44
	 sbXzIkrE+QEFQ==
Date: Tue, 15 Sep 2026 12:04:03 -0500
From: "Serge Hallyn (AMD)" <sergeh@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Jeff Xu <jeffxu@google.com>,
	=?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/3] proc: query LSMs for introspective mem access (if
 PROC_MEM_FORCE_ALWAYS)
Message-ID: <aql6gyQJoxEjx0xY@shallyn-amd>
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
 <20260907-selinux-pokemem-v3-2-0bafbaeafe50@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907-selinux-pokemem-v3-2-0bafbaeafe50@google.com>

On Mon, Sep 07, 2026 at 11:00:17PM +0200, Jann Horn wrote:
> If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently have no
> good opportunity to block a process from overwriting read-only code in its
> own address space through FOLL_FORCE writes via /proc/self/mem.
> The security_ptrace_access_check() LSM hook is bypassed when a process
> opens /proc/self/mem because this is considered "introspection".
> 
> This causes a hole in SELinux EXECMEM enforcement, which tries to ensure
> that a process cannot create executable anonymous pages.
> 
> PROC_MEM_FORCE_PTRACE prevents that and ensures that such FOLL_FORCE
> accesses are only possible when the LSM allows ptrace() attachment; but it
> is unclear how quickly PROC_MEM_FORCE_PTRACE can be deployed in
> environments running lots of third-party code, such as Android.
> 
> So, introduce a new LSM hook that can forbid FOLL_FORCE specifically for
> such "introspective" accesses.
> 
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  fs/proc/base.c                | 14 ++++++++++++--
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  7 +++++++
>  security/security.c           | 25 +++++++++++++++++++++++++
>  4 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index bec6197329dc..295b21203c7f 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -851,6 +851,11 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
>  /* private_data for proc_mem_operations */
>  struct mem_private {
>  	struct mm_struct *mm;
> +	/*
> +	 * Was the ptrace access check on open bypassed because the opener used
> +	 * the same MM (introspection)?
> +	 */
> +	bool opened_by_owner;
>  };
>  
>  static int mem_open(struct inode *inode, struct file *file)
> @@ -864,12 +869,14 @@ static int mem_open(struct inode *inode, struct file *file)
>  	priv->mm = proc_mem_open(inode, PTRACE_MODE_ATTACH);
>  	if (IS_ERR_OR_NULL(priv->mm))
>  		return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> +	priv->opened_by_owner = priv->mm == current->mm;
>  	file->private_data = no_free_ptr(priv);
>  	return 0;
>  }
>  
>  static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
>  {
> +	struct mem_private *priv = file->private_data;
>  	struct task_struct *task;
>  	bool ptrace_active = false;
>  
> @@ -884,10 +891,13 @@ static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
>  					READ_ONCE(task->parent) == current;
>  			put_task_struct(task);
>  		}
> -		return ptrace_active;
> +		if (!ptrace_active)
> +			return false;
> +		break;
>  	default:
> -		return true;
> +		break;
>  	}
> +	return security_mem_foll_force(file->f_cred, priv->opened_by_owner) == 0;
>  }
>  
>  static ssize_t mem_rw(struct file *file, char __user *buf,
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 65c9609ec207..12f84a1e6fab 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -36,6 +36,7 @@ LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
>  LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
>  	 unsigned int mode)
>  LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
> +LSM_HOOK(int, 0, mem_foll_force, const struct cred *subject, bool opened_by_owner)
>  LSM_HOOK(int, 0, capget, const struct task_struct *target, kernel_cap_t *effective,
>  	 kernel_cap_t *inheritable, kernel_cap_t *permitted)
>  LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 153e9043058f..e8bc2e644241 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -338,6 +338,7 @@ int security_binder_transfer_file(const struct cred *from,
>  				  const struct cred *to, const struct file *file);
>  int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
>  int security_ptrace_traceme(struct task_struct *parent);
> +int security_mem_foll_force(const struct cred *subject, bool opened_by_owner);
>  int security_capget(const struct task_struct *target,
>  		    kernel_cap_t *effective,
>  		    kernel_cap_t *inheritable,
> @@ -676,6 +677,12 @@ static inline int security_ptrace_traceme(struct task_struct *parent)
>  	return cap_ptrace_traceme(parent);
>  }
>  
> +static inline int security_mem_foll_force(const struct cred *subject,
> +					  bool opened_by_owner)
> +{
> +	return 0;
> +}
> +
>  static inline int security_capget(const struct task_struct *target,
>  				   kernel_cap_t *effective,
>  				   kernel_cap_t *inheritable,
> diff --git a/security/security.c b/security/security.c
> index 71aea8fdf014..2cde1efdb7a6 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -595,6 +595,31 @@ int security_ptrace_traceme(struct task_struct *parent)
>  	return call_int_hook(ptrace_traceme, parent);
>  }
>  
> +/**
> + * security_mem_foll_force() - Check if FOLL_FORCE is allowed
> + * @subject: credentials using which /proc/$pid/mem was opened
> + * @opened_by_owner: whether checks on open() were bypassed because the opener
> + *                   has the same MM as the target
> + *
> + * Check if FOLL_FORCE is allowed for accessing process memory through
> + * /proc/$pid/mem. opened_by_owner signals whether the opener's MM was the same
> + * as the target MM, meaning the security_ptrace_access_check() hook was
> + * bypassed on open().
> + * (Current current->mm does not matter for this; for example, if write() is
> + * called on an FD that was received from another process which obtained it with
> + * open("/proc/self/mem"), @opened_by_owner is still true.)
> + *
> + * Note that this hook is only designed to be useful in the opened_by_owner
> + * case, where the subject credentials effectively also describe the object.

Given this, would it make more sense to call the hook something
like `security_mem_foll_force_self()` and only call it in the
opened_by_owner==true case?

I only suggest it because it seems to lower the cognitive load
when looking at this code, so it might make it easier to maintain.

> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_mem_foll_force(const struct cred *subject,
> +					    bool opened_by_owner)
> +{
> +	return call_int_hook(mem_foll_force, subject, opened_by_owner);
> +}
> +
>  /**
>   * security_capget() - Get the capability sets for a process
>   * @target: target process
> 
> -- 
> 2.55.0.1003.g10538fe699-goog
> 
