Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DF621CA13;
	Wed, 26 Aug 2026 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749628; cv=none; b=QE8A9XyGGObDF8L+JeQq1LoURLCOt7HZ0NtepBCkdBrRLRt4HbWC5DBzZwZv8CQH010aNwkkVfqflZ/XI8FXRZezbOy/Snfcn6aUqiGl7XPSFwkivJ90uM5FZ/4fSpP3ZiW/DUcRX0Fo18mXYMosQemM5FmWefcZARLmqtLs+/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749628; c=relaxed/simple;
	bh=LkDPqDFg345DgqQ3m4DE3To0vpnoKah/CSfR9DfbKng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOqT7w6ZxqXvBFTtHMKnTo1jGT43h9tMQnaKd2TJMnjvg0pWAogNvfbgsDd6zcv1vv2Tm4+FuMG++JpUWboPU0ck8BRd2ZbznEV3NTptvIHQNiEFcwI6oqAkOLO2C+iiUJppKl3u0zkOGlCMu8p4/gIifR/HC89fA9FMVuWo8oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxEG+kxn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxEG+kxn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857CE1F000E9;
	Wed, 26 Aug 2026 13:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787749627;
	bh=N0uNhOoF0fsO+S9VbNFdNjCWH58LGVPdM6KbXTCpaA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NxEG+kxnT6FOnlnSVrSWAVpAwTa7C5QXPrvPYzfYGHPS9FRNdKlXul8HG8zGK8elf
	 0mygCqOfR9eM3G+dQWdg/bMGnFWpcK2y8v4Yclu6jZMtaLboZWmhcv42qxKucUSKFP
	 klimZ00U2FyUxGwskveMz1JD1boi8Z7yoZ0o18WqhCyQyYbxFq6O8mJq/8BuUCK+rw
	 X28C16uva8QqUxBsalSioByWTAnep1PC9q0C9uJ+8+5S50+0X8O1fmOurQORIC978i
	 4NYcPfTIvqas2AY0e9QaKcmIFCW7ZeLQTXg6L2jmmIVYWqK/pIVylvBOqv8wMV0jF+
	 9vSuVy515ZNHg==
Date: Wed, 26 Aug 2026 14:06:59 +0100
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
Subject: Re: [PATCH v2 2/3] proc: query LSMs for introspective mem access (if
 PROC_MEM_FORCE_ALWAYS)
Message-ID: <ao7kzYoGRrhkaoB4@gremlin>
References: <20260825-selinux-pokemem-v2-0-b46bc64916d8@google.com>
 <20260825-selinux-pokemem-v2-2-b46bc64916d8@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-selinux-pokemem-v2-2-b46bc64916d8@google.com>

On Tue, Aug 25, 2026 at 08:39:18PM +0200, Jann Horn wrote:
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

Thanks for the name change! :)

Nothing stands out so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  fs/proc/base.c                |  9 +++++++++
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  security/security.c           | 20 ++++++++++++++++++++
>  4 files changed, 36 insertions(+)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index bec6197329dc..dc6fdcb47b79 100644
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
> @@ -886,6 +893,8 @@ static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
>  		}
>  		return ptrace_active;
>  	default:
> +		if (priv->opened_by_owner)
> +			return security_mem_foll_force_opened_by_owner(file->f_cred) == 0;
>  		return true;
>  	}
>  }
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 65c9609ec207..50e3f0abc676 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -36,6 +36,7 @@ LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
>  LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
>  	 unsigned int mode)
>  LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
> +LSM_HOOK(int, 0, mem_foll_force_opened_by_owner, const struct cred *subject)
>  LSM_HOOK(int, 0, capget, const struct task_struct *target, kernel_cap_t *effective,
>  	 kernel_cap_t *inheritable, kernel_cap_t *permitted)
>  LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 153e9043058f..74eb876054b0 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -338,6 +338,7 @@ int security_binder_transfer_file(const struct cred *from,
>  				  const struct cred *to, const struct file *file);
>  int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
>  int security_ptrace_traceme(struct task_struct *parent);
> +int security_mem_foll_force_opened_by_owner(const struct cred *subject);
>  int security_capget(const struct task_struct *target,
>  		    kernel_cap_t *effective,
>  		    kernel_cap_t *inheritable,
> @@ -676,6 +677,11 @@ static inline int security_ptrace_traceme(struct task_struct *parent)
>  	return cap_ptrace_traceme(parent);
>  }
>
> +static inline int security_mem_foll_force_opened_by_owner(const struct cred *subject)
> +{
> +	return 0;
> +}
> +
>  static inline int security_capget(const struct task_struct *target,
>  				   kernel_cap_t *effective,
>  				   kernel_cap_t *inheritable,
> diff --git a/security/security.c b/security/security.c
> index 71aea8fdf014..fff26ff65e07 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -595,6 +595,26 @@ int security_ptrace_traceme(struct task_struct *parent)
>  	return call_int_hook(ptrace_traceme, parent);
>  }
>
> +/**
> + * security_mem_foll_force_opened_by_owner() - Check if introspective FOLL_FORCE is allowed
> + * @subject: credentials of the process accessing its own memory
> + *
> + * Check if FOLL_FORCE is allowed for accessing process memory through
> + * /proc/$pid/mem in the case where the opener's MM was the same as the target
> + * MM, meaning the security_ptrace_access_check() hook was bypassed on open().
> + * (current->mm does not matter for this; for example, if write() is called on
> + * an FD that was received from another process which obtained it with
> + * open("/proc/self/mem"), this hook still runs.)
> + *
> + * This is only used when the system is configured with PROC_MEM_FORCE_ALWAYS.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_mem_foll_force_opened_by_owner(const struct cred *subject)
> +{
> +	return call_int_hook(mem_foll_force_opened_by_owner, subject);
> +}
> +
>  /**
>   * security_capget() - Get the capability sets for a process
>   * @target: target process
>
> --
> 2.55.0.860.g4b6b3295ed-goog
>

--
Cheers, Lorenzo
