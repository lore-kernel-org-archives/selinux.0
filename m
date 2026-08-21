Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6AA389104;
	Fri, 21 Aug 2026 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787338846; cv=none; b=sUScS5hvhbIOS0mTb2kSnltMeD9m+y03videg8hemC821Wg0tST8iatoPncOhiSHXj66p3b83idpKAXviHP4lI72dgT4tU/CMDly2xABDlS9vOepw8/brfmWpr5vFo4SQ/JeqRw3O4SeZM9fkPBWmYXTFY5y4Xcx1rA+ZaGDNls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787338846; c=relaxed/simple;
	bh=sJMt2+jcVX1k3HFVL2ohPOWYZ1ZC+u7VBGIFRLs38O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1jfuMi6dSxy/q3kei78f+4sCHozes3ZrHVebuu581In9NQcSfD6c2L4Qv6TWzmLKWomoZM2+DmtF2YpE9uCCNSoYXaW+SGid0vpTT1sUgdHcMgfGL8dWM0cSM0eyJM5v3SLnG3XumH/FzuCLZ8cfHb0q6+S7JGWryv04kDbrWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvGzyhO/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvGzyhO/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E5C1F00A3D;
	Fri, 21 Aug 2026 19:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787338844;
	bh=IEagc8SPvaN9Oa8aVDhOR1OaWuRI/QhLc1rk2xR/OeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PvGzyhO/TCg78i4TiCwfMnJRwrKx7JYZd3h0Y7oeoimxcZzu3dVhDc9n3IV3Hxx5x
	 wRuCEK/MZio1uqv0KZr8DYt9EI6twnrrm0D71OOF9CgvLRk0NWVDoJHUvN0YkHXlJK
	 sCRdrQhAcH9dogaUc3//75WN6R9lMm/InG/xkGpiiCmcAJqdwZGtTp0Ev80CmflA4q
	 ofmSK00z5G2iiA1fcljuDrSbJcoFhQX2LhkmvOyofNUYlfXehJD/fqUl/CS+jeYcIl
	 4hzD/J0JgIZrP3oJdw68GrBwXNAgDrZzjs5+IkT9z4XX2Lb2SpRCgr39slcYaB0hpe
	 hfx8qAZhxA2Lw==
Date: Fri, 21 Aug 2026 20:00:36 +0100
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
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if
 PROC_MEM_FORCE_ALWAYS)
Message-ID: <aoifijlkCRzeO4bj@gremlin>
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com>

On Tue, Aug 18, 2026 at 09:51:06PM +0200, Jann Horn wrote:
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
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  fs/proc/base.c                |  6 ++++++
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  security/security.c           | 15 +++++++++++++++
>  4 files changed, 28 insertions(+)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index bec6197329dc..3dfaef49bb70 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -851,6 +851,8 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
>  /* private_data for proc_mem_operations */
>  struct mem_private {
>  	struct mm_struct *mm;
> +	/* Was the ptrace access check bypassed due to introspection? */
> +	bool introspection;
>  };
>
>  static int mem_open(struct inode *inode, struct file *file)
> @@ -864,12 +866,14 @@ static int mem_open(struct inode *inode, struct file *file)
>  	priv->mm = proc_mem_open(inode, PTRACE_MODE_ATTACH);
>  	if (IS_ERR_OR_NULL(priv->mm))
>  		return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> +	priv->introspection = priv->mm == current->mm;
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
> @@ -886,6 +890,8 @@ static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
>  		}
>  		return ptrace_active;
>  	default:
> +		if (priv->introspection)
> +			return security_introspect_mem_foll_force(file->f_cred) == 0;

As per 3/3 I wonder if you need an additional parameter to cover the fd -> some
other process case?

Like:
	if (priv->owned_by_owner) {
		const bool is_remote = current->mm != priv->mm;

		return !security_fd_from_owner_mem_foll_force(file->f_cred,
				is_remote);
	}

(I'm not sure how LSM hooks are supposed to look :)

>  		return true;
>  	}
>  }
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 65c9609ec207..67452f71bedf 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -36,6 +36,7 @@ LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
>  LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
>  	 unsigned int mode)
>  LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
> +LSM_HOOK(int, 0, introspect_mem_foll_force, const struct cred *subject)
>  LSM_HOOK(int, 0, capget, const struct task_struct *target, kernel_cap_t *effective,
>  	 kernel_cap_t *inheritable, kernel_cap_t *permitted)
>  LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 153e9043058f..f8483be58bc8 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -338,6 +338,7 @@ int security_binder_transfer_file(const struct cred *from,
>  				  const struct cred *to, const struct file *file);
>  int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
>  int security_ptrace_traceme(struct task_struct *parent);
> +int security_introspect_mem_foll_force(const struct cred *subject);
>  int security_capget(const struct task_struct *target,
>  		    kernel_cap_t *effective,
>  		    kernel_cap_t *inheritable,
> @@ -676,6 +677,11 @@ static inline int security_ptrace_traceme(struct task_struct *parent)
>  	return cap_ptrace_traceme(parent);
>  }
>
> +static inline int security_introspect_mem_foll_force(const struct cred *subject)
> +{
> +	return 0;
> +}
> +
>  static inline int security_capget(const struct task_struct *target,
>  				   kernel_cap_t *effective,
>  				   kernel_cap_t *inheritable,
> diff --git a/security/security.c b/security/security.c
> index 71aea8fdf014..d0f790a534eb 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -595,6 +595,21 @@ int security_ptrace_traceme(struct task_struct *parent)
>  	return call_int_hook(ptrace_traceme, parent);
>  }
>
> +/**
> + * security_introspect_mem_foll_force() - Check if introspective FOLL_FORCE is allowed
> + * @subject: credentials of the process accessing its own memory
> + *
> + * Check if FOLL_FORCE is allowed for a process accessing its own memory, which
> + * bypasses the security_ptrace_access_check() hook.

This should be updated to also explicitly mention the fd case. As surely in that
case this is not true? Unless I'm missing something.

> + * This is only used when the system is configured with PROC_MEM_FORCE_ALWAYS.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_introspect_mem_foll_force(const struct cred *subject)
> +{
> +	return call_int_hook(introspect_mem_foll_force, subject);
> +}
> +
>  /**
>   * security_capget() - Get the capability sets for a process
>   * @target: target process
>
> --
> 2.55.0.737.g08866a6d13-goog
>

--
Cheers, Lorenzo
