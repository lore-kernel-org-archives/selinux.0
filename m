Return-Path: <SRS0=BI9l=UV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6620DC43613
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C1D2073F
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="emnBehra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfFVW5A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 22 Jun 2019 18:57:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36617 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfFVW5A (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 22 Jun 2019 18:57:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id f21so5096173pgi.3
        for <selinux@vger.kernel.org>; Sat, 22 Jun 2019 15:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SKYDkxGDZb6dzumwdcavPCPSpvIGp4TSmuPjwz7bd/A=;
        b=emnBehramvSwv/ixcSswXWghK40fbMbaJL9mW/Xso0YlntICaLXBCbq9SrP/XflgUI
         RatkPxs7oPc70mvCE6NsPFcJ8aJQwUCcM9ABRlTwj0wZEuiVpJbTHWKBojgG59Q7sArK
         Qt+/KIzzv71zApDICKbYjUXRh5UOXinP6S3hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SKYDkxGDZb6dzumwdcavPCPSpvIGp4TSmuPjwz7bd/A=;
        b=cE4W4pvneaMeDNpr6BTJ+5DKJ+WjtqSB3HbdZro4R3ZjCeyIXwZDpq7stSXps3MgL9
         kLwqDA4XDMNlXvai+lnMAW0Z/WdDCeZVGGoc2cKl06KrMaza/0xJGFOFRarf0Iq9I2le
         H8cmyGkcEXDkFgsV9Hfztvm0kH/J2W98c7bjK4lNAegtApHT7MWLcvCjMWKG7TdYfks2
         mkkLUGXmr04GmYopuupjN/h4eWMQGXVOuVBL55XelQJon/gIOqCeFMbGp2Bh1vBHQlrQ
         7CVROPz2kK9JFhV5BwDTBJs3Zsh3ABaUqrnLL3kdoqkGGKzf2BwzYdPFV3a19afxBGSd
         psKg==
X-Gm-Message-State: APjAAAUiIEHm3L50DJvS4ICOHIiTmtLd/PMUXxoObvh5g3W7ZJR5dnE0
        pNgqnauqREk09juDbHxBhdO6jg==
X-Google-Smtp-Source: APXvYqynPXg5eB2AXYXduf5VjM+bP/GfV1cQC8xoLrQcn37hm+aGrbO1NeLiwDUhu9Sl0aBrlaYNFQ==
X-Received: by 2002:a63:7749:: with SMTP id s70mr12856470pgc.242.1561244219333;
        Sat, 22 Jun 2019 15:56:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 14sm6616645pgp.37.2019.06.22.15.56.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 15:56:58 -0700 (PDT)
Date:   Sat, 22 Jun 2019 15:56:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v3 19/24] LSM: Use lsmcontext in security_inode_getsecctx
Message-ID: <201906221556.FEDFFE7603@keescook>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-20-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621185233.6766-20-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 21, 2019 at 11:52:28AM -0700, Casey Schaufler wrote:
> Change the security_inode_getsecctx() interface to fill
> a lsmcontext structure instead of data and length pointers.
> This provides the information about which LSM created the
> context so that security_release_secctx() can use the
> correct hook. A lsmcontext is used within kernfs to store
> the security information as well.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  fs/kernfs/dir.c             |  8 ++------
>  fs/kernfs/inode.c           | 34 ++++++++++++----------------------
>  fs/kernfs/kernfs-internal.h |  3 +--
>  fs/nfsd/nfs4xdr.c           | 23 +++++++++--------------
>  include/linux/security.h    |  5 +++--
>  security/security.c         | 13 +++++++++++--
>  6 files changed, 38 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 92afad387237..1d000289d8b7 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -532,12 +532,8 @@ void kernfs_put(struct kernfs_node *kn)
>  	kfree_const(kn->name);
>  
>  	if (kn->iattr) {
> -		struct lsmcontext scaff; /* scaffolding */
> -		if (kn->iattr->ia_secdata) {
> -			lsmcontext_init(&scaff, kn->iattr->ia_secdata,
> -					kn->iattr->ia_secdata_len, 0);
> -			security_release_secctx(&scaff);
> -		}
> +		if (kn->iattr->ia_context.context)
> +			security_release_secctx(&kn->iattr->ia_context);
>  		simple_xattrs_free(&kn->iattr->xattrs);
>  		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
>  	}
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index 02cde9dac5ee..ffbf7863306d 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -135,21 +135,14 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
>  	return error;
>  }
>  
> -static int kernfs_node_setsecdata(struct kernfs_iattrs *attrs, void **secdata,
> -				  u32 *secdata_len)
> +static void kernfs_node_setsecdata(struct kernfs_iattrs *attrs,
> +				   struct lsmcontext *cp)
>  {
> -	void *old_secdata;
> -	size_t old_secdata_len;
> +	struct lsmcontext old_context;
>  
> -	old_secdata = attrs->ia_secdata;
> -	old_secdata_len = attrs->ia_secdata_len;
> -
> -	attrs->ia_secdata = *secdata;
> -	attrs->ia_secdata_len = *secdata_len;
> -
> -	*secdata = old_secdata;
> -	*secdata_len = old_secdata_len;
> -	return 0;
> +	old_context = attrs->ia_context;
> +	attrs->ia_context = *cp;
> +	*cp = old_context;
>  }
>  
>  ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size)
> @@ -192,8 +185,8 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
>  		 * persistent copy in kernfs_node.
>  		 */
>  		set_inode_attr(inode, &attrs->ia_iattr);
> -		security_inode_notifysecctx(inode, attrs->ia_secdata,
> -					    attrs->ia_secdata_len);
> +		security_inode_notifysecctx(inode, attrs->ia_context.context,
> +					    attrs->ia_context.len);
>  	}
>  
>  	if (kernfs_type(kn) == KERNFS_DIR)
> @@ -350,8 +343,6 @@ static int kernfs_security_xattr_set(const struct xattr_handler *handler,
>  	struct kernfs_node *kn = inode->i_private;
>  	struct kernfs_iattrs *attrs;
>  	struct lsmcontext context;
> -	void *secdata;
> -	u32 secdata_len = 0;
>  	int error;
>  
>  	attrs = kernfs_iattrs(kn);
> @@ -361,18 +352,17 @@ static int kernfs_security_xattr_set(const struct xattr_handler *handler,
>  	error = security_inode_setsecurity(inode, suffix, value, size, flags);
>  	if (error)
>  		return error;
> -	error = security_inode_getsecctx(inode, &secdata, &secdata_len);
> +	error = security_inode_getsecctx(inode, &context);
>  	if (error)
>  		return error;
>  
>  	mutex_lock(&kernfs_mutex);
> -	error = kernfs_node_setsecdata(attrs, &secdata, &secdata_len);
> +	kernfs_node_setsecdata(attrs, &context);
>  	mutex_unlock(&kernfs_mutex);
>  
> -	if (secdata) {
> -		lsmcontext_init(&context, secdata, secdata_len, 0);
> +	if (context.context)
>  		security_release_secctx(&context);
> -	}
> +
>  	return error;
>  }
>  
> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> index 0b7d197a904c..844a028d282f 100644
> --- a/fs/kernfs/kernfs-internal.h
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -21,8 +21,7 @@
>  
>  struct kernfs_iattrs {
>  	struct iattr		ia_iattr;
> -	void			*ia_secdata;
> -	u32			ia_secdata_len;
> +	struct lsmcontext	ia_context;
>  
>  	struct simple_xattrs	xattrs;
>  };
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index bb3db033e144..1209083565dd 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2304,11 +2304,11 @@ nfsd4_encode_layout_types(struct xdr_stream *xdr, u32 layout_types)
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
> @@ -2318,13 +2318,13 @@ nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
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
> @@ -2420,9 +2420,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  	__be32 status;
>  	int err;
>  	struct nfs4_acl *acl = NULL;
> -	struct lsmcontext scaff; /* scaffolding */
> -	void *context = NULL;
> -	int contextlen;
> +	struct lsmcontext context;
>  	bool contextsupport = false;
>  	struct nfsd4_compoundres *resp = rqstp->rq_resp;
>  	u32 minorversion = resp->cstate.minorversion;
> @@ -2479,7 +2477,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  	     bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
>  		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
>  			err = security_inode_getsecctx(d_inode(dentry),
> -						&context, &contextlen);
> +						       &context);
>  		else
>  			err = -EOPNOTSUPP;
>  		contextsupport = (err == 0);
> @@ -2908,8 +2906,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  	}
>  
>  	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
> -		status = nfsd4_encode_security_label(xdr, rqstp, context,
> -								contextlen);
> +		status = nfsd4_encode_security_label(xdr, rqstp, &context);
>  		if (status)
>  			goto out;
>  	}
> @@ -2920,10 +2917,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
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
> index 2a2785a4e752..bfdb06bc5466 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -485,7 +485,7 @@ void security_release_secctx(struct lsmcontext *cp);
>  void security_inode_invalidate_secctx(struct inode *inode);
>  int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
> -int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
> +int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
>  #else /* CONFIG_SECURITY */
>  
>  static inline int call_lsm_notifier(enum lsm_event event, void *data)
> @@ -1286,7 +1286,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
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
> index 842ac65abc08..b2ffcd1f3057 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2139,9 +2139,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
>  }
>  EXPORT_SYMBOL(security_inode_setsecctx);
>  
> -int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
> +int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp)
>  {
> -	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ctxlen);
> +	int *display = current->security;
> +	struct security_hook_list *hp;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecctx, list)
> +		if (*display == 0 || *display == hp->slot) {
> +			cp->slot = hp->slot;
> +			return hp->hook.inode_getsecctx(inode,
> +					(void **)&cp->context, &cp->len);
> +		}
> +	return -EOPNOTSUPP;
>  }
>  EXPORT_SYMBOL(security_inode_getsecctx);
>  
> -- 
> 2.20.1
> 

-- 
Kees Cook
