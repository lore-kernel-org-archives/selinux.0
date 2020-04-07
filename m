Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89578C2D0EC
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 18:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9C220730
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 18:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QAeiXYCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgDGSl2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:41:28 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51256 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgDGSl1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Apr 2020 14:41:27 -0400
Received: by mail-pj1-f66.google.com with SMTP id n4so129107pjp.1
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2020 11:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4iSXnK+r3XUqMC5ZNqDl47FITYmKD31Ulwd1Kd1nS1Y=;
        b=QAeiXYCMQkvLnNIvjoyeOKJjFdD4QHpNbKKUbl6M8BRq/0d/LaQN0ly+8Upbw3b6nu
         qBU/aHEe4TH5SJNUi8O6ndlXe8f3lbb6QWpj9MFMTE3/Yi/o9zuPwpnrmwaJWGW53JdW
         rvDWU+V5ObCibZZTGRAba4fzgkKvuxG3VbCJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4iSXnK+r3XUqMC5ZNqDl47FITYmKD31Ulwd1Kd1nS1Y=;
        b=PjzDAvyD+qouW0TBYLz2e8hRnO9QWyrj49IW2Eg/p9uDNOWCKGSQ9bqeMZf/wl12BC
         vhC4tM8WTqqZsWlXKH/Xa4fIM0XDXHOjOcDcBMZK1vdgazYq62LT+t6bajCWb1aA8f1A
         Obi0MuwhBf0hRpk/BLXGyOYycWH9FHsMCNPpsnZpc8OchqSwSV0UZnS5yJx0tHWdMXr1
         YK4u/GdrZhI+UoOqZQMB3Xko9D3PKhoEI/IP4kZfAeHfBROF19OE00rv23hmTnwVqXwp
         cjOiPdApbECYke5dCR6Jzouu1vMUqI6mthWXKgYWSMQG+zAWJXkns3yvgq2H+KEqhIeZ
         XfXw==
X-Gm-Message-State: AGi0PubRQbgHYbVohdAgHellBAZeP908CKsBvbby5lVKyR8vhMnmS2ox
        i3NMsaoHFTQ9EPXqIhKFgWpIxQ==
X-Google-Smtp-Source: APiQypIBcKNccD64BGznoeVtkLvXQwDxglXqycluhTkEDP9xiZJ0Nx+Tyx8ZTYJ7o6Aaeh75cPVDng==
X-Received: by 2002:a17:90a:cb18:: with SMTP id z24mr723008pjt.67.1586284886939;
        Tue, 07 Apr 2020 11:41:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mu15sm2396662pjb.30.2020.04.07.11.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 11:41:26 -0700 (PDT)
Date:   Tue, 7 Apr 2020 11:41:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: Re: [PATCH v16 16/23] LSM: Use lsmcontext in security_inode_getsecctx
Message-ID: <202004071141.51D1FE524C@keescook>
References: <20200407000159.43602-1-casey@schaufler-ca.com>
 <20200407000159.43602-17-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407000159.43602-17-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 06, 2020 at 05:01:52PM -0700, Casey Schaufler wrote:
> Change the security_inode_getsecctx() interface to fill
> a lsmcontext structure instead of data and length pointers.
> This provides the information about which LSM created the
> context so that security_release_secctx() can use the
> correct hook.
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  fs/nfsd/nfs4xdr.c        | 23 +++++++++--------------
>  include/linux/security.h |  5 +++--
>  security/security.c      | 13 +++++++++++--
>  3 files changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index df308b1b37fa..ac8eb77d0053 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2379,11 +2379,11 @@ nfsd4_encode_layout_types(struct xdr_stream *xdr, u32 layout_types)
>  #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>  static inline __be32
>  nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
> -			    void *context, int len)
> +			    struct lsmcontext *context)
>  {
>  	__be32 *p;
>  
> -	p = xdr_reserve_space(xdr, len + 4 + 4 + 4);
> +	p = xdr_reserve_space(xdr, context->len + 4 + 4 + 4);
>  	if (!p)
>  		return nfserr_resource;
>  
> @@ -2393,13 +2393,13 @@ nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
>  	 */
>  	*p++ = cpu_to_be32(0); /* lfs */
>  	*p++ = cpu_to_be32(0); /* pi */
> -	p = xdr_encode_opaque(p, context, len);
> +	p = xdr_encode_opaque(p, context->context, context->len);
>  	return 0;
>  }
>  #else
>  static inline __be32
>  nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
> -			    void *context, int len)
> +			    struct lsmcontext *context)
>  { return 0; }
>  #endif
>  
> @@ -2496,9 +2496,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  	int err;
>  	struct nfs4_acl *acl = NULL;
>  #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
> -	struct lsmcontext scaff; /* scaffolding */
> -	void *context = NULL;
> -	int contextlen;
> +	struct lsmcontext context = { };
>  #endif
>  	bool contextsupport = false;
>  	struct nfsd4_compoundres *resp = rqstp->rq_resp;
> @@ -2556,7 +2554,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  	     bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
>  		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
>  			err = security_inode_getsecctx(d_inode(dentry),
> -						&context, &contextlen);
> +						       &context);
>  		else
>  			err = -EOPNOTSUPP;
>  		contextsupport = (err == 0);
> @@ -2986,8 +2984,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  
>  #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>  	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
> -		status = nfsd4_encode_security_label(xdr, rqstp, context,
> -								contextlen);
> +		status = nfsd4_encode_security_label(xdr, rqstp, &context);
>  		if (status)
>  			goto out;
>  	}
> @@ -2999,10 +2996,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  
>  out:
>  #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
> -	if (context) {
> -		lsmcontext_init(&scaff, context, contextlen, 0); /*scaffolding*/
> -		security_release_secctx(&scaff);
> -	}
> +	if (context.context)
> +		security_release_secctx(&context);
>  #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
>  	kfree(acl);
>  	if (tempfh) {
> diff --git a/include/linux/security.h b/include/linux/security.h
> index ec64ccd2e168..fac5547dd89e 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -556,7 +556,7 @@ void security_release_secctx(struct lsmcontext *cp);
>  void security_inode_invalidate_secctx(struct inode *inode);
>  int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
> -int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
> +int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
>  int security_locked_down(enum lockdown_reason what);
>  #else /* CONFIG_SECURITY */
>  
> @@ -1382,7 +1382,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
>  {
>  	return -EOPNOTSUPP;
>  }
> -static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
> +static inline int security_inode_getsecctx(struct inode *inode,
> +					   struct lsmcontext *cp)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/security/security.c b/security/security.c
> index 356c5cd94c48..84f33bd4990a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2211,9 +2211,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
>  }
>  EXPORT_SYMBOL(security_inode_setsecctx);
>  
> -int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
> +int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp)
>  {
> -	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ctxlen);
> +	struct security_hook_list *hp;
> +
> +	memset(cp, 0, sizeof(*cp));
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecctx, list) {
> +		cp->slot = hp->lsmid->slot;
> +		return hp->hook.inode_getsecctx(inode, (void **)&cp->context,
> +						&cp->len);
> +	}
> +	return -EOPNOTSUPP;
>  }
>  EXPORT_SYMBOL(security_inode_getsecctx);
>  
> -- 
> 2.24.1
> 

-- 
Kees Cook
