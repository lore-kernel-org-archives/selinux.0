Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865A4183CAD
	for <selinux@vger.kernel.org>; Tue, 10 Sep 2024 21:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726002481; cv=none; b=DkfVio61Ux6dtBVkmrDKwT8UYzJWk15sVtL7IvffXtUsplq6pDauEGQupPCZqC3lB/1/ebq2Noq5IH2dhFphIXdtz1emd9NvOMY/8oFOE19pNGSqg38Zrqhu38jovZKSWxMeGIUDzFccG5MqSjYO3Y/mJKqmTCoOD6aWut5knf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726002481; c=relaxed/simple;
	bh=KExRflW8J1qrGZemxSMBTuo2DT5ZtIVX+177fgt01io=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=hexJxL2CAcsXKk3tj30Hlu+iv8NW6LaXdELNXfR003y1vFlm6bSqW5028tYRejOatNMV9xd5WGtOiAx2HHMS+3ZM4VszyR57NdUGwoI54qzI2NWJiioVWWdyJm6hr8XNja5GFFquVJxfu7vEFv41GCXQ9aqUWqX0vRmXECSGjHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=W49oBH0o; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="W49oBH0o"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a9af813f6cso282830585a.3
        for <selinux@vger.kernel.org>; Tue, 10 Sep 2024 14:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726002478; x=1726607278; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xsgweXIpmstBe5GJ597qL3m2SDBc+q8DcPeq2Npix+U=;
        b=W49oBH0onyfkZgIj2/9fQl4mU2iRC0wGidJp73eZ9nryWWwjm27dyEHJdtNZDaLEH6
         x6BvEp5/ErQS2iFTCu4d9YRkdsWDfsjiWxE1wxdSg23EN4Rl23Id2x5xIEMq9Zv/ursx
         k7UIZlVf9ObsF5UWTkbwFroUkE1Qwj/msqVo58/zFJ2RF82rUyOPGEdsANqlT4mh1sDy
         mCOJbKboJK64hErhvbLOkABqpVkY4ouJp+fvKiYDW7fUSBj7T/8y2KtCDal0XqC4FFw/
         lDP2pItHyQHa7qOzQVuIdtnSb3NBd6gZd2lB0dn4og1DqHhM+WDGZgAueOyVAEJsk42G
         OAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726002478; x=1726607278;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xsgweXIpmstBe5GJ597qL3m2SDBc+q8DcPeq2Npix+U=;
        b=e7YeuEu8oeU4cYrmtBB7FSowqi6wUG+oa6oYpcGGx7IU/Z4RGobxEzgg6l67lt2Bm+
         CxmJhT4HYxNOvZa1rxLnuLppIJw203D4F00RNx4zSo0nxAqfMwsY7ZtXBJZZAtPCj9k6
         lnmDGnGLD/l1+bki0qTKB0UvPciBh/EOzZ0Lbn21oTlAIkP5y9S2xi3IM6tpox9ckLqM
         +si4vaO24dyvO1llloHlWFBTVprMTrldDhp3wOQ9q64UVamnIf4vXg/KSVBCxjv30nvN
         WSuMcHndbEqfTe2kHqy7S7hn5R2GvpP7uhXIgSfxQTP/pfSvonbjjjPB95yRwr9fXU6Y
         BwhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGTnVbfGvS+qZP/jrhZuCurdOWMjXYKv6vLyRCuiDIaaGCWoIWPEOn+Tj5p50HIg7Tsvlxcawh@vger.kernel.org
X-Gm-Message-State: AOJu0YxbGPS5I5o+ztnWeEYS0DLeNClgg09aB5woiM6ljR2kFrNzd12i
	6YkdG/NyDitZSl6V11BogQGzZ5MnkORXApOwvVEgyc3djQIELSNt0z0LPvw8kA==
X-Google-Smtp-Source: AGHT+IGdN3Bip/QFL1/JxWNAkcL/JUmgw8uKd+/pDtMXUXN6GSGIZoTS92X+BzdXp0VO+irY5HiZ9w==
X-Received: by 2002:a05:620a:491:b0:7a9:9ed7:b49f with SMTP id af79cd13be357-7a99ed7bed2mr1837046285a.38.1726002478185;
        Tue, 10 Sep 2024 14:07:58 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a79972e3sm343656385a.68.2024.09.10.14.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 14:07:57 -0700 (PDT)
Date: Tue, 10 Sep 2024 17:07:57 -0400
Message-ID: <47697d5f8d557113244b7c044251fe09@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Jann Horn <jannh@google.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, John Johansen <john.johansen@canonical.com>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com, keyrings@vger.kernel.org, selinux@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 1/2] KEYS: use synchronous task work for changing parent  credentials
References: <20240805-remove-cred-transfer-v2-1-a2aa1d45e6b8@google.com>
In-Reply-To: <20240805-remove-cred-transfer-v2-1-a2aa1d45e6b8@google.com>

On Aug  5, 2024 Jann Horn <jannh@google.com> wrote:
> 
> keyctl_session_to_parent() involves posting task work to the parent task,
> with work function key_change_session_keyring.
> Because the task work in the parent runs asynchronously, no errors can be
> returned back to the caller of keyctl_session_to_parent(), and therefore
> the work function key_change_session_keyring() can't be allowed to fail due
> to things like memory allocation failure or permission checks - all
> allocations and checks have to happen in the child.
> 
> This is annoying for two reasons:
> 
>  - It is the only reason why cred_alloc_blank() and
>    security_transfer_creds() are necessary.
>  - It means we can't do synchronous permission checks.
> 
> Rewrite keyctl_session_to_parent() to run task work on the parent
> synchronously, so that any errors that happen in the task work can be
> plumbed back into the syscall return value in the child.
> This allows us to get rid of cred_alloc_blank() and
> security_transfer_creds() in a later commit, and it will make it possible
> to write more reliable security checks for this operation.
> 
> Note that this requires using TWA_SIGNAL instead of TWA_RESUME, so the
> parent might observe some spurious -EAGAIN syscall returns or such; but the
> parent likely anyway has to be ready to deal with the side effects of
> receiving signals (since it'll probably get SIGCHLD when the child dies),
> so that probably isn't an issue.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  security/keys/internal.h     |   8 ++++
>  security/keys/keyctl.c       | 107 +++++++++++++------------------------------
>  security/keys/process_keys.c |  86 ++++++++++++++++++----------------
>  3 files changed, 87 insertions(+), 114 deletions(-)

...

> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index ab927a142f51..e4cfe5c4594a 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -1616,104 +1616,63 @@ long keyctl_get_security(key_serial_t keyid,
>   * parent process.
>   *
>   * The keyring must exist and must grant the caller LINK permission, and the
>   * parent process must be single-threaded and must have the same effective
>   * ownership as this process and mustn't be SUID/SGID.
>   *
> - * The keyring will be emplaced on the parent when it next resumes userspace.
> + * The keyring will be emplaced on the parent via a pseudo-signal.
>   *
>   * If successful, 0 will be returned.
>   */
>  long keyctl_session_to_parent(void)
>  {
> -	struct task_struct *me, *parent;
> -	const struct cred *mycred, *pcred;
> -	struct callback_head *newwork, *oldwork;
> +	struct keyctl_session_to_parent_context ctx;
> +	struct task_struct *parent;
>  	key_ref_t keyring_r;
> -	struct cred *cred;
>  	int ret;
>  
>  	keyring_r = lookup_user_key(KEY_SPEC_SESSION_KEYRING, 0, KEY_NEED_LINK);
>  	if (IS_ERR(keyring_r))
>  		return PTR_ERR(keyring_r);
>  
> -	ret = -ENOMEM;
> -
> -	/* our parent is going to need a new cred struct, a new tgcred struct
> -	 * and new security data, so we allocate them here to prevent ENOMEM in
> -	 * our parent */
> -	cred = cred_alloc_blank();
> -	if (!cred)
> -		goto error_keyring;
> -	newwork = &cred->rcu;
> +	write_lock_irq(&tasklist_lock);
> +	parent = get_task_struct(rcu_dereference_protected(current->real_parent,
> +					lockdep_is_held(&tasklist_lock)));
> +	write_unlock_irq(&tasklist_lock);
>  
> -	cred->session_keyring = key_ref_to_ptr(keyring_r);
> -	keyring_r = NULL;
> -	init_task_work(newwork, key_change_session_keyring);
> +	/* the parent mustn't be init and mustn't be a kernel thread */
> +	if (is_global_init(parent) || (READ_ONCE(parent->flags) & PF_KTHREAD) != 0)
> +		goto put_task;

I think we need to explicitly set @ret if we are failing here, yes?
  
> -	me = current;
> -	rcu_read_lock();
> -	write_lock_irq(&tasklist_lock);
> +	ctx.new_session_keyring = key_ref_to_ptr(keyring_r);
> +	ctx.child_cred = current_cred();
> +	init_completion(&ctx.done);
> +	init_task_work(&ctx.work, key_change_session_keyring);
> +	ret = task_work_add(parent, &ctx.work, TWA_SIGNAL);
> +	if (ret)
> +		goto put_task;
>  
> -	ret = -EPERM;
> -	oldwork = NULL;
> -	parent = rcu_dereference_protected(me->real_parent,
> -					   lockdep_is_held(&tasklist_lock));
> +	ret = wait_for_completion_interruptible(&ctx.done);
>  
> -	/* the parent mustn't be init and mustn't be a kernel thread */
> -	if (parent->pid <= 1 || !parent->mm)
> -		goto unlock;
> -
> -	/* the parent must be single threaded */
> -	if (!thread_group_empty(parent))
> -		goto unlock;
> -
> -	/* the parent and the child must have different session keyrings or
> -	 * there's no point */
> -	mycred = current_cred();
> -	pcred = __task_cred(parent);
> -	if (mycred == pcred ||
> -	    mycred->session_keyring == pcred->session_keyring) {
> -		ret = 0;
> -		goto unlock;
> +	if (task_work_cancel(parent, &ctx.work)) {
> +		/*
> +		 * We got interrupted and the task work was canceled before it
> +		 * could execute.
> +		 * Use -ERESTARTNOINTR instead of -ERESTARTSYS for
> +		 * compatibility - the manpage does not list -EINTR as a
> +		 * possible error for keyctl().
> +		 */
> +		ret = -ERESTARTNOINTR;
> +	} else {
> +		/* task work is running or has been executed */
> +		wait_for_completion(&ctx.done);
> +		ret = ctx.result;
>  	}
>  
> -	/* the parent must have the same effective ownership and mustn't be
> -	 * SUID/SGID */
> -	if (!uid_eq(pcred->uid,	 mycred->euid) ||
> -	    !uid_eq(pcred->euid, mycred->euid) ||
> -	    !uid_eq(pcred->suid, mycred->euid) ||
> -	    !gid_eq(pcred->gid,	 mycred->egid) ||
> -	    !gid_eq(pcred->egid, mycred->egid) ||
> -	    !gid_eq(pcred->sgid, mycred->egid))
> -		goto unlock;
> -
> -	/* the keyrings must have the same UID */
> -	if ((pcred->session_keyring &&
> -	     !uid_eq(pcred->session_keyring->uid, mycred->euid)) ||
> -	    !uid_eq(mycred->session_keyring->uid, mycred->euid))
> -		goto unlock;
> -
> -	/* cancel an already pending keyring replacement */
> -	oldwork = task_work_cancel_func(parent, key_change_session_keyring);
> -
> -	/* the replacement session keyring is applied just prior to userspace
> -	 * restarting */
> -	ret = task_work_add(parent, newwork, TWA_RESUME);
> -	if (!ret)
> -		newwork = NULL;
> -unlock:
> -	write_unlock_irq(&tasklist_lock);
> -	rcu_read_unlock();
> -	if (oldwork)
> -		put_cred(container_of(oldwork, struct cred, rcu));
> -	if (newwork)
> -		put_cred(cred);
> -	return ret;
> -
> -error_keyring:
> +put_task:
> +	put_task_struct(parent);
>  	key_ref_put(keyring_r);
>  	return ret;
>  }

--
paul-moore.com
