Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBFD537FF
	for <selinux@vger.kernel.org>; Wed, 12 Jun 2024 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718228623; cv=none; b=l5V+QIO+KbMwi6MSWs2zco6ZM+MELsYVAQ+NBPUpzndp00e3lPdh8XHLFB4FagHG19vld2ojJjdbWfkHK7ax3PIoa+rXGF3bNExkqp9BnV+XmmF34sqoqts/6ZLd7K/CpAvDPWCXaZJpPB8J3JUmNvEs/lcAdUUdoF4xfkliM/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718228623; c=relaxed/simple;
	bh=fu1M9lWhRUD8wRdmq/h32XCfO82gXRNhQRHjhGNYpVY=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=BO6HtHR0h1RgBhWG0Qc36nGzSafMTe0n24JZzs1Rhdd4UE4A6OuaKnVqWa3CcFZnJ6huUQbrUEkg3ogqKYYdZ3MADnHf+6fQ7f2+qI/LUlZ/04WhyU/pGCgvnEM2pAYH2Z/5Saaqa0YkoFUASJhk0SjaQP/hAL6hmA/94OfOJ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SIKgFwFP; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SIKgFwFP"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62a2a6a5ccfso4167417b3.3
        for <selinux@vger.kernel.org>; Wed, 12 Jun 2024 14:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718228620; x=1718833420; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H5P+IbdHtppUszGApidFOa9Hm6YpZkzCVF9qJbTn8jo=;
        b=SIKgFwFPzAgVLcAK5KZvOkSypriDmquKjdzdySQLw/7qPz/SN3M7A8eaTSaXnoLCYb
         4TE5igJzUSb34Lq688fda+G1MZDZs8e6PmMFmGdSj5N0zDoi+ERvEF+sqFDEJDg7nIzP
         sdtUFaG8zKrtm8DXqlWgzI3R1rzhsjxGnPh3TjRllwNpIg3ARkpKas2qH6F3zuYqqKjy
         vor4cWoCsMyR3ryYM3IaIQMUVNkDeZJdYFNTxztXJhzkhIT1tf/ya4u3RSFPFFvp/iFZ
         W+lw21YxzDnz5h/6SSWdqwCb8iDX3T3E/Skqqq9vG4+R/oUqAeeOTyB3VwWSlmVnRC3f
         GuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718228620; x=1718833420;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H5P+IbdHtppUszGApidFOa9Hm6YpZkzCVF9qJbTn8jo=;
        b=CXnQlW3G8/A80M1Ans37W9NECyof0NroL+PU4CteTWdkX+rLfBoGuqIsCB1fLIf0hD
         jVgLAoHERuR16VZwv7mY6XDC83W6hooh9/d3bdEaa9pLySMJ2L7oGqL9F60u0Za/+0w4
         3J92H3jmoPd49uOzU/8OecSBOPyK6vSk/w3K4QRmbUtivtz8yIqUQjW/IfiaMqLLo3QZ
         UqppaQrTE0v+w0X9ND4qxcVmWjIOJB4tegjomspHWA67ed/WwhBSstDytHqYzSdnfVpy
         ztn8Blr428gecLlhk5forQZakt+xV45/6HNN0OB8MvOm0oTcd/SEptNMV+q1r61dt2K1
         Vd4A==
X-Forwarded-Encrypted: i=1; AJvYcCWNEoKMW5s9O4bfvv9TxBQe53zZIpY/fGTmS8jMB6XdMkCHXParUYbOWQZpXBcDNSMoIWhN4qjPnZeyKIghIldxClc4JifZ0w==
X-Gm-Message-State: AOJu0Yy+oqjWHM7vxDNhmSImLDJ2H/80mpNxqOViQwZ9ON0pWlRDSeuA
	abukVXnPagHBGqFc+R95uxgNBRn7rQWnMRErSoRoLAChAKTwYFyVmWjwwRpg4w==
X-Google-Smtp-Source: AGHT+IEzCkGmcURuwumylkliwQQS7tKCwphHhO+nQwNDPDQUW3WVTWS6GxOh4TbgC9Y2HEAECiLJvA==
X-Received: by 2002:a81:c546:0:b0:61a:cd65:3010 with SMTP id 00721157ae682-62fb91269a1mr30015217b3.30.1718228620242;
        Wed, 12 Jun 2024 14:43:40 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2d6e933sm190801cf.44.2024.06.12.14.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 14:43:39 -0700 (PDT)
Date: Wed, 12 Jun 2024 17:43:39 -0400
Message-ID: <00d88046025c611f2bf94708ffc65ecc@paul-moore.com>
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
To: GUO Zihua <guozihua@huawei.com>, <john.johansen@canonical.com>, <jmorris@namei.org>, <serge@hallyn.com>, <zohar@linux.ibm.com>, <roberto.sassu@huawei.com>, <dmitry.kasatkin@gmail.com>, <stephen.smalley.work@gmail.com>, <casey@schaufler-ca.com>, <eparis@redhat.com>
Cc: <eric.snowberg@oracle.com>, <omosnace@redhat.com>, <audit@vger.kernel.org>, <apparmor@lists.ubuntu.com>, <linux-security-module@vger.kernel.org>, <linux-integrity@vger.kernel.org>, <selinux@vger.kernel.org>
Subject: Re: [PATCH v3] ima: Avoid blocking in RCU read-side critical section
References: <20240507012541.796421-1-guozihua@huawei.com>
In-Reply-To: <20240507012541.796421-1-guozihua@huawei.com>

On May  6, 2024 GUO Zihua <guozihua@huawei.com> wrote:
> 
> A panic happens in ima_match_policy:
> 
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
> PGD 42f873067 P4D 0
> Oops: 0000 [#1] SMP NOPTI
> CPU: 5 PID: 1286325 Comm: kubeletmonit.sh Kdump: loaded Tainted: P
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> RIP: 0010:ima_match_policy+0x84/0x450
> Code: 49 89 fc 41 89 cf 31 ed 89 44 24 14 eb 1c 44 39 7b 18 74 26 41 83 ff 05 74 20 48 8b 1b 48 3b 1d f2 b9 f4 00 0f 84 9c 01 00 00 <44> 85 73 10 74 ea 44 8b 6b 14 41 f6 c5 01 75 d4 41 f6 c5 02 74 0f
> RSP: 0018:ff71570009e07a80 EFLAGS: 00010207
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000200
> RDX: ffffffffad8dc7c0 RSI: 0000000024924925 RDI: ff3e27850dea2000
> RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffabfce739
> R10: ff3e27810cc42400 R11: 0000000000000000 R12: ff3e2781825ef970
> R13: 00000000ff3e2785 R14: 000000000000000c R15: 0000000000000001
> FS:  00007f5195b51740(0000) GS:ff3e278b12d40000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000010 CR3: 0000000626d24002 CR4: 0000000000361ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  ima_get_action+0x22/0x30
>  process_measurement+0xb0/0x830
>  ? page_add_file_rmap+0x15/0x170
>  ? alloc_set_pte+0x269/0x4c0
>  ? prep_new_page+0x81/0x140
>  ? simple_xattr_get+0x75/0xa0
>  ? selinux_file_open+0x9d/0xf0
>  ima_file_check+0x64/0x90
>  path_openat+0x571/0x1720
>  do_filp_open+0x9b/0x110
>  ? page_counter_try_charge+0x57/0xc0
>  ? files_cgroup_alloc_fd+0x38/0x60
>  ? __alloc_fd+0xd4/0x250
>  ? do_sys_open+0x1bd/0x250
>  do_sys_open+0x1bd/0x250
>  do_syscall_64+0x5d/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x65/0xca
> 
> Commit c7423dbdbc9e ("ima: Handle -ESTALE returned by
> ima_filter_rule_match()") introduced call to ima_lsm_copy_rule within a
> RCU read-side critical section which contains kmalloc with GFP_KERNEL.
> This implies a possible sleep and violates limitations of RCU read-side
> critical sections on non-PREEMPT systems.
> 
> Sleeping within RCU read-side critical section might cause
> synchronize_rcu() returning early and break RCU protection, allowing a
> UAF to happen.
> 
> The root cause of this issue could be described as follows:
> |	Thread A	|	Thread B	|
> |			|ima_match_policy	|
> |			|  rcu_read_lock	|
> |ima_lsm_update_rule	|			|
> |  synchronize_rcu	|			|
> |			|    kmalloc(GFP_KERNEL)|
> |			|      sleep		|
> ==> synchronize_rcu returns early
> |  kfree(entry)		|			|
> |			|    entry = entry->next|
> ==> UAF happens and entry now becomes NULL (or could be anything).
> |			|    entry->action	|
> ==> Accessing entry might cause panic.
>
> To fix this issue, we are converting all kmalloc that is called within
> RCU read-side critical section to use GFP_ATOMIC.
> 
> Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_match()")
> Cc: stable@vger.kernel.org
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> Acked-by: John Johansen <john.johansen@canonical.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
> v3:
>   ima_lsm_copy_rule takes a GFP flag as input as well.
> v2:
>   Changed the audit_rule_init security hook to accept a new GFP flag, as
> per Stephen's suggestion.
> 
> ---
>  include/linux/lsm_hook_defs.h       |  2 +-
>  include/linux/security.h            |  5 +++--
>  kernel/auditfilter.c                |  5 +++--
>  security/apparmor/audit.c           |  6 +++---
>  security/apparmor/include/audit.h   |  2 +-
>  security/integrity/ima/ima_policy.c | 15 +++++++++------
>  security/security.c                 |  6 ++++--
>  security/selinux/include/audit.h    |  4 +++-
>  security/selinux/ss/services.c      |  5 +++--
>  security/smack/smack_lsm.c          |  3 ++-
>  10 files changed, 32 insertions(+), 21 deletions(-)

With the exception of one small gotcha (see below), this looks okay to
me.  At Mimi's request I'm going to merge this into the LSM tree, via
lsm/stable-6.10, where I'll give it a few days in linux-next before
sending it up to Linus.

Thanks everyone :)

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 146667937811..a4943628d75a 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4696,7 +4696,8 @@ static int smack_post_notification(const struct cred *w_cred,
>   * Prepare to audit cases where (@field @op @rulestr) is true.
>   * The label to be audited is created if necessay.
>   */
> -static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
> +static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
> +				 gfp_t gfp)

You forgot to add the new @gfp parameter to the function's header
comment block.  I'm going to add the following as the text is used in
other Smack functions, if anyone has any objections please let me know.

  " * @gfp: type of the memory for the allocation"

>  {
>  	struct smack_known *skp;
>  	char **rule = (char **)vrule;

--
paul-moore.com
