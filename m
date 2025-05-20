Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC84256C9D
	for <selinux@vger.kernel.org>; Tue, 20 May 2025 23:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747784289; cv=none; b=bRZ3wgr5TBlEeR1R+C7ac18r/yfe8ogB5JX1EOGWjCkkjmspG6BlaiVpq0XIzrItI1wmQXDMfG+oZSSaGuP0fTIX/enrV0o4mhRM3iO6qDVDAPN61FTBDEce7FpVY4rnOrYDFdg2G4QG5cbs02stl8zn4yxGlC/uIid3aumZZb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747784289; c=relaxed/simple;
	bh=4P8AQQRvKv3tx6LqrdhzXwbbB140sKvhJU0R7VeFCVo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=KwhtV2ZhWpJPdmqEoNSWiFf8IV/6tBfGtjgu++b/zQiSV1FALDRh3uTd2wp41LJcZpRoS/9Z2bSX9pWiH0jqbpMLQuUuaHPELDU3TmzyHQcoKgFwpEnOaVhh1VLRWZJRftTCDuSO8IgE9DK/idmBF3jDoj4HrjXT82W1XVX9ljU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BbVmYS/p; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BbVmYS/p"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476b4c9faa2so86695171cf.3
        for <selinux@vger.kernel.org>; Tue, 20 May 2025 16:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747784285; x=1748389085; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5JwCS3D5qB0ZVpIfZDoO/dxJhD7NpU15bju12GZYws=;
        b=BbVmYS/pxMWNNmvflh3/FS53imAnfLZditWeh6KBGMIx0427ToXkGn8sBnjGSSwQ8/
         u7ydHpjZ0jMAs+vkkONjDo9okH08ZCtPnibmg0mCKlFGK1RM8/I2LVxMaLb/eiSRq9Vs
         apaMeA/qlLQKlVh4I1nvBsHAijOM7mevp7mc8TVTCzskJx/itqSXvVOfwS241cX2/h/Q
         Mm1mjVkpK/07t7utW/7KTvNJMQ3EsjDvUzKMeDF34+I2ogBmoRCD3fjftuVzRn6qpORE
         2RtARVDbnz9G9DwzG5n7jgOM1rbz0coyc9Nj8vmzX7A9YHSMg9COA58yjNvecuuBBV3y
         SgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747784285; x=1748389085;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m5JwCS3D5qB0ZVpIfZDoO/dxJhD7NpU15bju12GZYws=;
        b=Mw+Z81ezJIj7gSLIbZaBEWfiDXL8bFM6mOlrKANW8mjaceEszC7MpL27EYFlxgASgU
         HKKkM2ruzV2qL+yWM/ID528jsjXh2a3cSUZO7D4kSPFVa1EZsrXvWyI705J2hMGt2O6T
         COF95vPC5LnAoF1tc09ljPdD4awVjMJ9/EbjaNuJG0EdU2jXsVw7nXFoZI8me2D7/7fJ
         RhH4U13OdrXo220A5dr5QoN4r0RCJOSbh9rPzWBQMer8mvaMxBoPYkiDHmM6I7uJRWGR
         zw6URRAvmqU0NxU1b8vJPWLkvXccwzmuRwQrqRrwlwg30hQhmqcxEbZNStWRjFw1VXKM
         cDpw==
X-Forwarded-Encrypted: i=1; AJvYcCW3iGfbnbrHaTgUHNRhID60aaqHqM5gbAQzwhPqh4UpTNzj5iYYXivrldYNaPWJGkZtCxtikyjD@vger.kernel.org
X-Gm-Message-State: AOJu0YydLd0dcDcSDlDnTTM7MeR9v0h3Mhv7cK8+U/Yi4LqOCIUPkonL
	yja3mb8ab1SMcMEn7hyjAnfEQl905QekWL1J37hKdPw7u4SThR/eegKVD0o5Lirv0p4Z6vJEyJC
	fRQjS1g==
X-Gm-Gg: ASbGncuU+DG/Shqnu9LzLMsMrYjlZzUqf2+h4+tbSvEMSi8BNpC8/HvvvF3sj8LMoa+
	i26BYFiDSLjdmOKIg65bc+RaNwsJVz8sHi8WuZxOF604xYtqtFj84ge8OSbox7zsDk2jvaUqP4F
	T69DOxCq9AXjqYkSGBs8BPJjnGWzsWF9RVk0L4a7bOrDm1po78xE+hw7d69mcX5EOx8k1Xr+cMF
	n4o1T9fb1cqkf3pA1v3hSMBt2q60XqKS2Cgy76P+2KUTueY65jGZU2PK5lz6xtXRQmp560eEsx1
	tDJRgzQfIOwk1PMjVncjBGT0H7lD2EfWaxMNiDpu+3du5Kc5U4u5itQP9qDuvLM1rrTXToM8DhL
	mGjjgPrxORiIVsbFLyjKY
X-Google-Smtp-Source: AGHT+IH6TIe+WIEGVeIFwNzMxSmdRMqCt9npq73pWfBtUCvWFhTDLiXaEEVM7DZ159mr3FSIrlRRHA==
X-Received: by 2002:a05:622a:98d:b0:48f:5d4f:8e86 with SMTP id d75a77b69052e-494ae4ac4b0mr380667251cf.50.1747784285362;
        Tue, 20 May 2025 16:38:05 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-494ae4ff75esm76439991cf.59.2025.05.20.16.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 16:38:04 -0700 (PDT)
Date: Tue, 20 May 2025 19:38:04 -0400
Message-ID: <a0842c097e2b73c93954e2a414b3fad2@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250520_1533/pstg-lib:20250520_1521/pstg-pwork:20250520_1533
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH 2/2] selinux: optimize selinux_inode_getattr/permission()  based on neveraudit|permissive
References: <20250502170450.27160-3-stephen.smalley.work@gmail.com>
In-Reply-To: <20250502170450.27160-3-stephen.smalley.work@gmail.com>

On May  2, 2025 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Extend the task avdcache to also cache whether the task SID is both
> permissive and neveraudit, and return immediately if so in both
> selinux_inode_getattr() and selinux_inode_permission().
> 
> The same approach could be applied to many of the hook functions
> although the avdcache would need to be updated for more than directory
> search checks in order for this optimization to be beneficial for checks
> on objects other than directories.
> 
> To test, apply https://github.com/SELinuxProject/selinux/pull/473 to
> your selinux userspace, build and install libsepol and secilc, and use
> the following CIL policy module:
> $ cat neverauditpermissive.cil
> (typeneveraudit unconfined_t)
> (typepermissive unconfined_t)
> 
> Without this module inserted, running the following commands:
>    perf record make -jN # on an already built allmodconfig tree
>    perf report --sort=symbol,dso
> yields the following percentages (only showing __d_lookup_rcu for
> reference and only showing relevant SELinux functions):
>    1.65%  [k] __d_lookup_rcu
>    0.53%  [k] selinux_inode_permission
>    0.40%  [k] selinux_inode_getattr
>    0.15%  [k] avc_lookup
>    0.05%  [k] avc_has_perm
>    0.05%  [k] avc_has_perm_noaudit
>    0.02%  [k] avc_policy_seqno
>    0.02%  [k] selinux_file_permission
>    0.01%  [k] selinux_inode_alloc_security
>    0.01%  [k] selinux_file_alloc_security
> for a total of 1.24% for SELinux compared to 1.65% for
> __d_lookup_rcu().
> 
> After running the following command to insert this module:
>    semodule -i neverauditpermissive.cil
> and then re-running the same perf commands from above yields
> the following non-zero percentages:
>    1.74%  [k] __d_lookup_rcu
>    0.31%  [k] selinux_inode_permission
>    0.03%  [k] selinux_inode_getattr
>    0.03%  [k] avc_policy_seqno
>    0.01%  [k] avc_lookup
>    0.01%  [k] selinux_file_permission
>    0.01%  [k] selinux_file_open
> for a total of 0.40% for SELinux compared to 1.74% for
> __d_lookup_rcu().

I still don't like the hacky nature of the approach, but it's hard to
ignore the performance improvement.

> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c          | 18 +++++++++++++++++-
>  security/selinux/include/objsec.h |  1 +
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index b8115df536ab..1a3806fdf3d6 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3184,6 +3184,8 @@ static inline void task_avdcache_update(struct task_security_struct *tsec,
>  	tsec->avdcache.dir[spot].audited = audited;
>  	tsec->avdcache.dir[spot].allowed = avd->allowed;
>  	tsec->avdcache.dir[spot].permissive = avd->flags & AVD_FLAGS_PERMISSIVE;

This obviously has nothing to do with your patch, but looking at this
code has me wondering what my thinking was putting the permissive field
in the avdc_entry struct instead of task_security_struct::avdcache.  We
should probably move that ...

> +	tsec->avdcache.permissive_neveraudit =
> +		(avd->flags == (AVD_FLAGS_PERMISSIVE|AVD_FLAGS_NEVERAUDIT));
>  }
>  
>  /**
> @@ -3210,10 +3212,15 @@ static int selinux_inode_permission(struct inode *inode, int requested)
>  	if (!mask)
>  		return 0;
>  
> +	tsec = selinux_cred(current_cred());
> +	if (tsec->avdcache.permissive_neveraudit &&
> +		tsec->sid == tsec->avdcache.sid &&
> +		tsec->avdcache.seqno == avc_policy_seqno())
> +		return 0;

Two things come to mind.  The first is that we should probably reorder
the conditional to reduce the comparisons we need to do when we don't
have a match.  We always need to check the SID and AVC seqno, so put
those first:

  if (tsec->sid == tsec->avdcache.sid &&
      tsec->avdcache.seqno == avc_policy_seqno() &&
      tsec->avdcache.permissive_neveraudit)
    return 0;

The second thing is that since we have this logic in at least one other
place there may be some value in encapsulting it in a static inline:

  static inline bool task_avdcache_permnoaudit(tsec)
  {
    if (tsec->sid == tsec->avdcache.sid &&
        tsec->avdcache.seqno == avc_policy_seqno() &&
        tsec->avdcache.permissive_neveraudit)
      return true;
    return false;
  }

>  	isec = inode_security_rcu(inode, requested & MAY_NOT_BLOCK);
>  	if (IS_ERR(isec))
>  		return PTR_ERR(isec);
> -	tsec = selinux_cred(current_cred());
>  	perms = file_mask_to_av(inode->i_mode, mask);
>  
>  	rc = task_avdcache_search(tsec, isec, &avdc);
> @@ -3277,6 +3284,15 @@ static int selinux_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  
>  static int selinux_inode_getattr(const struct path *path)
>  {
> +	struct task_security_struct *tsec;
> +
> +	tsec = selinux_cred(current_cred());
> +
> +	if (tsec->avdcache.permissive_neveraudit &&
> +		tsec->sid == tsec->avdcache.sid &&
> +		tsec->avdcache.seqno == avc_policy_seqno())
> +		return 0;

See above.

>  	return path_has_perm(current_cred(), path, FILE__GETATTR);
>  }

--
paul-moore.com
