Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2088DC48BD6
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD16E2080C
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mwsOD8Le"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfFZXIS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:08:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43683 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZXIS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 19:08:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so66684pgv.10
        for <selinux@vger.kernel.org>; Wed, 26 Jun 2019 16:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J2R1CmZxkSBQXvpxUwjQOstXArpoqc4whMVfSpDum8M=;
        b=mwsOD8LeboGIamuekbIPgOL4TeLkTNUkA066o870kdbqc0Ls2xaMk/fgivGPZvc41K
         LWvoxWNXCo8smf8EuoFK7cZA0tnO6xwnAhMKzAKTQHCDLCUX365tnmbRV7rySCygn/ID
         5ramWjC97FT69WAkIPtmuMuuIhfoXHGvk0gP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J2R1CmZxkSBQXvpxUwjQOstXArpoqc4whMVfSpDum8M=;
        b=ARO0d9i1SS74aQV9jREN6d5d4D5VxuPgHl3j0mL6lkAqjFZlrUAjnUaw5zBZwjMv/j
         blGe9pvVZUhODdxdtY3UiRRCtZr7P1h1evMabOvEFiUsc18hMLDZrBSe0Pjh6AU7wuwX
         tHFDjRP4hhjqP9Kr/ipiC060TR9+vFU123YXazlccWxMryJLb9V7JgqLXNF8OdPkJCae
         YCPJSZy4RhbOXAwyXkT2NrCujoTSyOgSfhHbV/wm9UVr4Wp2c6TOUgg83BESQXnOyHVh
         U55ZEvBzrP+EklcxpBk10NmKQLPmI8gC1sEJwO0OEXE4yzzMU4CsQWIBzu3J8C9NQ+Pb
         iDyg==
X-Gm-Message-State: APjAAAXQFp9FKBSF+ePZ9OGi4hoJT3tqv7HItq0nfhdFdSbrJFoZQc6Q
        NQ+FeAqG3NlIGMqqXpXgAZY8Xg==
X-Google-Smtp-Source: APXvYqwRZi+cYVaqIN/o+QIA8GOwpNVeSCLOdrOfLLusIwJVFABi6Nu4peZbdAaiHAWg2Ub1zrDZCA==
X-Received: by 2002:a65:4085:: with SMTP id t5mr446029pgp.109.1561590497723;
        Wed, 26 Jun 2019 16:08:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j24sm163051pgg.86.2019.06.26.16.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 16:08:17 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:08:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v4 10/23] LSM: Use lsmblob in security_ipc_getsecid
Message-ID: <201906261608.EEE380F9@keescook>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-11-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626192234.11725-11-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 26, 2019 at 12:22:21PM -0700, Casey Schaufler wrote:
> There may be more than one LSM that provides IPC data
> for auditing. Change security_ipc_getsecid() to fill in
> a lsmblob structure instead of the u32 secid. The
> audit data structure containing the secid will be updated
> later, so there is a bit of scaffolding here.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/security.h |  7 ++++---
>  kernel/auditsc.c         |  5 ++++-
>  security/security.c      | 12 +++++++++---
>  3 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 7b4667cc4930..41dc3053094e 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -417,7 +417,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  			unsigned long arg4, unsigned long arg5);
>  void security_task_to_inode(struct task_struct *p, struct inode *inode);
>  int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
> -void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
> +void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
>  int security_msg_msg_alloc(struct msg_msg *msg);
>  void security_msg_msg_free(struct msg_msg *msg);
>  int security_msg_queue_alloc(struct kern_ipc_perm *msq);
> @@ -1102,9 +1102,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
>  	return 0;
>  }
>  
> -static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
> +static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,
> +					 struct lsmblob *blob)
>  {
> -	*secid = 0;
> +	lsmblob_init(blob, 0);
>  }
>  
>  static inline int security_msg_msg_alloc(struct msg_msg *msg)
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index d31914088a82..148733ec3c72 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2268,11 +2268,14 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
>  void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
>  {
>  	struct audit_context *context = audit_context();
> +	struct lsmblob blob;
>  	context->ipc.uid = ipcp->uid;
>  	context->ipc.gid = ipcp->gid;
>  	context->ipc.mode = ipcp->mode;
>  	context->ipc.has_perm = 0;
> -	security_ipc_getsecid(ipcp, &context->ipc.osid);
> +	security_ipc_getsecid(ipcp, &blob);
> +	/* scaffolding on the [0] - change "osid" to a lsmblob */
> +	context->ipc.osid = blob.secid[0];
>  	context->type = AUDIT_IPC;
>  }
>  
> diff --git a/security/security.c b/security/security.c
> index 0c7784a243e7..5245d4d1e799 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1795,10 +1795,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
>  	return call_int_hook(ipc_permission, 0, ipcp, flag);
>  }
>  
> -void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
> +void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob)
>  {
> -	*secid = 0;
> -	call_void_hook(ipc_getsecid, ipcp, secid);
> +	struct security_hook_list *hp;
> +
> +	lsmblob_init(blob, 0);
> +	hlist_for_each_entry(hp, &security_hook_heads.ipc_getsecid, list) {
> +		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +			continue;
> +		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->lsmid->slot]);
> +	}
>  }
>  
>  int security_msg_msg_alloc(struct msg_msg *msg)
> -- 
> 2.20.1
> 

-- 
Kees Cook
