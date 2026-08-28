Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274975B5AB
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 01:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787879454; cv=none; b=JPKwGOSTx4uxi0pMNjpLYavZOZv+SP2OphhOnKhRVhpKr4LR/WPcDu3GG1UZ2SXzZWjITLo5o37nElDXEc+Teg6IFUCpT1jdMfAQ4NdEIK571tpFXBST0/yO+Rqy0KwbVAWSVqSxaB1zNhj0hUUeLVVJ65BXmgl2fm1yXV2o8A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787879454; c=relaxed/simple;
	bh=wIEeS+LwYTnRIYj5ZqZqnhCJG8waLUCHcVYFZ62yyKY=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=h2aK1810qOfuP7ZzdmZrlVUro73l1NWkR9UMiJuoCGglFbcri93mZ7qGhcQ4hD9mogjYtAtUgMnC5lP+AzgmTk42C8qwS22kqW7G856DaetVH310TJmbH6/TbRSd2YovcY23TQM8DCFnDIlVb8mbleyekNC+zN5N+/aLCdqK+i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AHXcPHTq; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AHXcPHTq"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-52d8748cde5so3694301cf.0
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 18:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787879447; x=1788484247; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F2FIz9UYX+IlSwKp5E5JXDBaBYS18bmjz6r6fwuVCck=;
        b=AHXcPHTqnZa6w/ozGXcB1Zxb3/q9ETgZwzkXvBAvOTjJmsv3Ar+Ww2svNXRbKqwZQ2
         /icLl2ujY6yGIpUFAyHQYKYUE5DvZIDMt18rtLRSPZZE7GneuT5TV4DgintgNE/UOtir
         YVZBOpb/vu6tm9Zy1hCuIibYgC/bnX5W5gN3POQctMcsO/osj9TPWJ5PbPKmGNMp1v3T
         YGGC3oF+linRv+RqM4XAvoiVh3Qlf2CyfYVGtla26sGtB+cQLTi+41OFbA7I8ULzpb/h
         RK4JsdjSz5jcHAKOJdyVMQclGNbkM2PMn2IAMJ+aTyD2ZBqDzhltoIA4Gc8Rpyh3pjVn
         LrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787879447; x=1788484247;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F2FIz9UYX+IlSwKp5E5JXDBaBYS18bmjz6r6fwuVCck=;
        b=gWuGG5A31B7GRXdmZwqc6GN/OVu6PAOb6sp+VyrzaHm9bmIcJvIh+pfjx8xGS034LT
         D3dqI8QgOVBkc2qlPe8mfA0SPclUxQNYN5dp+yV9WI8RG35OVqY/NXzu4MrWBt/uUHzm
         SMXxqoUZnEfaYVzn+8g2zgWvOBbtjcde83m+fJiqVukFML7TmZWKSlWCKCT6fE/u+wKC
         Ung3KsyQ9R7VO8Hwa6CVNT/nHyVbqrYOHLFt1P/2pDC2WSHbqB2u+O0GV0QNLMX2IYQB
         m+99f7eMbCjLhQ04v2DBJtz1/35aMHHYU+a5Os4XcY9SrbINRViE3Y6G8gy+RNhtl3IS
         h9IQ==
X-Forwarded-Encrypted: i=1; AHgh+RoMtm++8yZnnIDIqtgQysshEn0Kq5tlXIkh9wJ5g9Y+F6msXPI6U9W38+nEK9L9DNOEmaRWTUMk@vger.kernel.org
X-Gm-Message-State: AFuF++knIof4/K8/zFHi59s+qVd6UzY1q2l0BHIa/fgpKGxfaRbVTFmR
	0d2SGaYg/K4zcxu1R8S1Venoa/2Efa6DXasgQQBkEVeS+kYFJ1YGj7NxJQDUo4s1WA==
X-Gm-Gg: AR+sD13VW+Oi2j0Ezu4tvcLhMBFsDa0A39AQdEJjWn4U2HMRCnaFfQAG8CLxmzZqtJ5
	ZgTLAJsBAfDqe7fZYnaFgE6ZjC1b1eoyQ4HnXxN77nZsTLi6KmzyoTUt6SPqM1i9Lr8vzjg+6Tm
	50Xlz9kJMD4AQzMMHpU6Z4j/7QpOITRDUd2IKkFSyG4QtkIJTcdrL5SoTduxWOtEeNRABERArln
	Mw5ZNpsJGdPp2MyiGVzxiT2SiTNxWK3VdMP29MxcQBJaYAnKcSb0hCuBky1JeAzc8Jkj1Q21uu7
	ZyHG2fnYvSio+L4Tqniv806RXOatlrGkMoYk0ikRcK4AnhMLn4MhcLIRGrD4axNTn/KFtR3Gsf7
	M1+U5BoFmcVnqFna/ttpxEd3cDQvMcGHo5RL3BjwVzbNq4PupSrbiVPYxi3OqyNyOsd4Bd9gKT6
	FHRkcjgmr3IKUKrt2Ns+O2Cb4tHa4jWQQsHd92TVFlJdp8qbtkNkO/r48CbUemvWkZKYenvfyuP
	WWX5/Q/lOgiX60XsaqsDg4HYt49mKI3DA==
X-Received: by 2002:a05:622a:6118:b0:52f:64c4:8094 with SMTP id d75a77b69052e-52fb965d4a1mr42496571cf.39.1787879446638;
        Thu, 27 Aug 2026 18:10:46 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52fbe7f9bafsm2634591cf.19.2026.08.27.18.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 18:10:45 -0700 (PDT)
Date: Thu, 27 Aug 2026 21:10:44 -0400
Message-ID: <82929c994076d95f99560ecc67f6cfce@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260827_1122/pstg-lib:20260827_1501/pstg-pwork:20260827_1122
From: Paul Moore <paul@paul-moore.com>
To: Jann Horn <jannh@google.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, =?utf-8?q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 2/3] proc: query LSMs for introspective mem access (if  PROC_MEM_FORCE_ALWAYS)
References: <20260825-selinux-pokemem-v2-2-b46bc64916d8@google.com>
In-Reply-To: <20260825-selinux-pokemem-v2-2-b46bc64916d8@google.com>

On Aug 25, 2026 Jann Horn <jannh@google.com> wrote:
> 
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
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
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

First things first, we've got to shorten that hook name :)  What do you
think of security_proc_mem_foll_force()?

Beyond that, we really try to avoid making LSM hook calls conditional.  It
can limit what an LSM can enforce, it tends to be a bit more fragile, and
it adds some unnecessary work in the case where CONFIG_SECURITY is
disabled.  I would suggest passing 'opened_by_owner' flag as a second
parameter to the LSM hook and calling the hook unconditionally in the
default switch case as a replacement for the 'return true;' statement.  I
understand it may seem a bit odd, but we try to make the LSM interface as
generic as possible with respect to different models and this is one way
we do that.  It also ensures we don't have to process the 'opened_by_owner'
check in that case where the LSM is disabled.

> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 65c9609ec207..50e3f0abc676 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -36,6 +36,7 @@ LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
>  LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
>  	 unsigned int mode)
>  LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
> +LSM_HOOK(int, 0, mem_foll_force_opened_by_owner, const struct cred *subject)

See the default/disabled return value discussion below.

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

With proc_mem_foll_force() currently returning true/1 in this case,
shouldn't the LSM hook return true/1 when disabled?

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

Please don't forget to change the LSM callback name when you are changing
the LSM hook name.

--
paul-moore.com
