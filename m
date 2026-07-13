Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A5A26F2B0
	for <selinux@vger.kernel.org>; Mon, 13 Jul 2026 20:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783976375; cv=none; b=UNAvvdKE8zSEkdZy7ISMB/3/k/3TxwDJupXqE1RH8JJPIIw9IceqmwK+8vvfRDIzhHZsmttWPzujHak8XticlTqcISfjODreLjBO7o92+2sONcOffeVqERUgHkty0iWZdmVXNpr7oyZGfFmepHAdaPW2L/JHahKhJK383zVrP/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783976375; c=relaxed/simple;
	bh=h76Xc30bjMofZVOlhnDZ1l4zxw3Zs+CV0i6MER6Ex4Y=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=W/BLBpghtpjo2TZ+adUlcTtbxfyNsHq6zEftyASk5TMR0ns1YSimvr53xAZpZ+0fwP9JTT/cmC1DPss1+xFSnbCtSd0klL4ljc7wVxhJXpabT8Kpi4Wwx/p3u/zm9ki2KXvkgIBepc/u2tKIrCzBaehatkr1Q+GH8pjcMgV1SUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XbOZ6EjS; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XbOZ6EjS"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e4fd65b2bso25087885a.0
        for <selinux@vger.kernel.org>; Mon, 13 Jul 2026 13:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783976372; x=1784581172; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XgTw/JZdgmN9u8R3T8FYzq+6QulF3LsVIbRSg/RKizc=;
        b=XbOZ6EjS7jJhWDBeK50CdJZuWwdIPz3nj4meO2CyG9m24DYcCWqPBDjO6laNrvcASX
         AgiM+b+/+dGS67zLL0uLdsQG2pSBtE24u57tKAUaabLH1nBVQK+eju2R0FTdNYqnx8kE
         iRn8ebyJuF2XU6zXFsWvyBZ7yuNOy3GSbpwBxUISYopKygxab3H2ZvVupBi0UMdAVPFe
         /ACJDG1KAQ0A7yPHhuPyAz3keJq/Vsl0ZFGcPJEHiF0FUXNqDLa4rt1W7ku5F1yh1/NV
         ai9qajUEL6FBpQ7XL4rJrQE9zyAI2Lv4qjGKsACuKEIf2thYVVWZeBGFl3biRp+fI3P2
         FaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783976372; x=1784581172;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XgTw/JZdgmN9u8R3T8FYzq+6QulF3LsVIbRSg/RKizc=;
        b=pg1GYxWiIXuVK9yfQBZVUjtx/pMiCxXmL/uHHNyK5av3ZfabLdDT6LwdLjqJdEGtgd
         4JwGWMSsBNr18ifAMxrzQYaJcnIVHQ1tvXcRsjn2CbjgXxpQRAlACA+UpcIj9otKw4Ye
         VHYc0FsRENMwH+ImOvJvYokAWq7n6stBFRSMtmDrOiu9QJzGi1QBA+BH3zK8dmNk59LH
         TQNDS83L4zqIgRPSTBzDEfqF9hVNQpFPn/f9rWsaSTtl4fp7XOp4yO+Ctucu6AkKwO1s
         nxDWVY+Tw1/O9ZKZM+/zdsMfEkM176DrTGe2XJAbGRB4akkkfMnK8zFddehDoZvQguik
         TqFw==
X-Forwarded-Encrypted: i=1; AHgh+RpgDvFZK4VIIqK7az5EDj+HGCCo+pp/1XYDP1fJFw7Evjt7ghsf74J4+VHi+bsTOP6bic2AZcXo@vger.kernel.org
X-Gm-Message-State: AOJu0YwhOjWYwBpIjTUzwFTJ0lRXtFzBcXF2FMs3YNEwD4q7ErCfSvqZ
	889QlUTGxYbsMcEuQBCgdtoMYzFHr21i9Sw5dys32HbgO6NcDMIXfkRwK4t/10ZZ3Q==
X-Gm-Gg: AfdE7ckDQZSPFxjVSi3OD8a2KZsRQX4L9wtNeOnd8bkQ3E1mCtdMD51XxWlC8qq+vKG
	+KYDMuJ/f56nJVAOrl0YCcb5FeGtZ3qf4oKU8O41ju4qRxEELzy4OIkF8uq8gY2Ti5+PR0pKBoW
	pL/hCSs4Aso0vf0UhN8FcYxnfm+kg/BTJaNgReTUfzUGls5JDjjRgLgNZjwVzGq23lZPSYuyd7j
	j4edD2uKjGPqhRkBvaG6nDAgrV5+ZcmmeFrLoMekhrDjiDBnyfQLF7BvOY8r6uGrBVH5dadFOp4
	xQtyqVnHK+FQSJ+b2jtm+s3kypVG6Nmi7KqvHmcWlvyOde8tk/ByGyUCITGn1GdZntTxPr8doC4
	4NuOA9j2aLaqIzvBaBCJ3txZ1KAEvxl4f+kYEpUaIBZw/Mx2vsvGbvXXcq8rBV1+uXH9dOv1xsM
	KA38vmvROtntbwabWXIkqBWUIGHbwmOIn2TODCFF+9zx8ct6c7TXamKAGUAA==
X-Received: by 2002:a05:620a:444e:b0:92e:c118:18cd with SMTP id af79cd13be357-92ef2cd6b43mr1063124985a.88.1783976372408;
        Mon, 13 Jul 2026 13:59:32 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee59223e7sm1181647785a.0.2026.07.13.13.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 13:59:31 -0700 (PDT)
Date: Mon, 13 Jul 2026 16:59:30 -0400
Message-ID: <c4e963c1d1d059f6b229e2fe13a4386c@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260713_1552/pstg-lib:20260713_1057/pstg-pwork:20260713_1552
From: Paul Moore <paul@paul-moore.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] selinux: fix incorrect execmem checks on overlayfs
References: <20260703114733.1243995-1-omosnace@redhat.com>
In-Reply-To: <20260703114733.1243995-1-omosnace@redhat.com>

On Jul  3, 2026 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> 
> The commit fixing the overlayfs mmap() and mprotect() access checks
> failed to skip the execmem check in __file_map_prot_check() for the case
> where the "mounter check" is being performed. This check should be
> performed only against the credentials of the task that is calling
> mmap()/mprotect(), since it doesn't pertain to the file itself, but
> rather just gates the ability of the calling task to get an executable
> memory mapping in general.
> 
> The purpose of the "mounter check" is to guard against using an
> overlayfs mount to gain file access that would otherwise be denied to
> the mounter. For execmem this is not relevant, as there is no further
> file access granted based on it (notice that the file's context is not
> used as the target in the check), so checking it also against the
> mounter credentials would be incorrect.
> 
> Fix this by passing a boolean to [__]file_map_prot_check() and
> selinux_mmap_file_common() that indicates if we are doing the "mounter
> check" and skiping the execmem check in that case. Since this boolean
> also indicates if we use current_cred() or the mounter cred as the
> subject, also remove the "cred" argument from these functions and
> determine it based on the boolean and the file struct.
> 
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access checks")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c | 39 ++++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1a713d96206f5..87790f6f0d4de 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3969,13 +3969,14 @@ static int selinux_file_ioctl_compat(struct file *file, unsigned int cmd,
>  
>  static int default_noexec __ro_after_init;
>  
> -static int __file_map_prot_check(const struct cred *cred,
> -				 const struct file *file, unsigned long prot,
> -				 bool shared, bool bf_user_file)
> +static int __file_map_prot_check(const struct file *file, unsigned long prot,
> +				 bool shared, bool mounter_check,
> +				 bool bf_user_file)
>  {
>  	struct inode *inode = NULL;
>  	bool prot_exec = prot & PROT_EXEC;
>  	bool prot_write = prot & PROT_WRITE;
> +	const struct cred *cred = mounter_check ? file->f_cred : current_cred();

Moving the cred lookup down into these functions makes me nervous that
we could run into a problem someday when 'mounter_check' is true and
'file' is NULL (contrived given the current code, yes, but we've been
burned by code changes before).

Let's protect this cred lookup to ensure that 'file' is non-NULL before
we reference it.

>  	if (file) {
>  		if (bf_user_file)
> @@ -3984,7 +3985,7 @@ static int __file_map_prot_check(const struct cred *cred,
>  			inode = file_inode(file);
>  	}
>  
> -	if (default_noexec && prot_exec &&
> +	if (!mounter_check && default_noexec && prot_exec &&
>  	    (!file || IS_PRIVATE(inode) || (!shared && prot_write))) {
>  		int rc;
>  		u32 sid = cred_sid(cred);
> @@ -4013,11 +4014,11 @@ static int __file_map_prot_check(const struct cred *cred,
>  	return 0;
>  }
>  
> -static inline int file_map_prot_check(const struct cred *cred,
> -				      const struct file *file,
> -				      unsigned long prot, bool shared)
> +static inline int file_map_prot_check(const struct file *file,
> +				      unsigned long prot, bool shared,
> +				      bool mounter_check)
>  {
> -	return __file_map_prot_check(cred, file, prot, shared, false);
> +	return __file_map_prot_check(file, prot, shared, mounter_check, false);
>  }
>  
>  static int selinux_mmap_addr(unsigned long addr)
> @@ -4033,9 +4034,11 @@ static int selinux_mmap_addr(unsigned long addr)
>  	return rc;
>  }
>  
> -static int selinux_mmap_file_common(const struct cred *cred, struct file *file,
> -				    unsigned long prot, bool shared)
> +static int selinux_mmap_file_common(struct file *file, unsigned long prot,
> +				    bool shared, bool mounter_check)
>  {
> +	const struct cred *cred = mounter_check ? file->f_cred : current_cred();

See above comments.

>  	if (file) {
>  		int rc;
>  		struct common_audit_data ad;
> @@ -4047,15 +4050,16 @@ static int selinux_mmap_file_common(const struct cred *cred, struct file *file,
>  			return rc;
>  	}
>  
> -	return file_map_prot_check(cred, file, prot, shared);
> +	return file_map_prot_check(file, prot, shared, mounter_check);
>  }
>  
>  static int selinux_mmap_file(struct file *file,
>  			     unsigned long reqprot __always_unused,
>  			     unsigned long prot, unsigned long flags)
>  {
> -	return selinux_mmap_file_common(current_cred(), file, prot,
> -					(flags & MAP_TYPE) == MAP_SHARED);
> +	return selinux_mmap_file_common(file, prot,
> +					(flags & MAP_TYPE) == MAP_SHARED,
> +					false);
>  }
>  
>  /**
> @@ -4087,8 +4091,9 @@ static int selinux_mmap_backing_file(struct vm_area_struct *vma,
>  	if (vma->vm_flags & VM_EXEC)
>  		prot |= PROT_EXEC;
>  
> -	return selinux_mmap_file_common(backing_file->f_cred, backing_file,
> -					prot, vma->vm_flags & VM_SHARED);
> +	return selinux_mmap_file_common(backing_file, prot,
> +					vma->vm_flags & VM_SHARED,
> +					true);
>  }
>  
>  static int selinux_file_mprotect(struct vm_area_struct *vma,
> @@ -4149,11 +4154,11 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
>  		}
>  	}
>  
> -	rc = __file_map_prot_check(cred, file, prot, shared, backing_file);
> +	rc = __file_map_prot_check(file, prot, shared, false, backing_file);
>  	if (rc)
>  		return rc;
>  	if (backing_file) {
> -		rc = file_map_prot_check(file->f_cred, file, prot, shared);
> +		rc = file_map_prot_check(file, prot, shared, true);
>  		if (rc)
>  			return rc;
>  	}
> -- 
> 2.55.0

--
paul-moore.com
