Return-Path: <SRS0=g6d+=UX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C9CC4646B
	for <selinux@archiver.kernel.org>; Mon, 24 Jun 2019 21:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5F8204FD
	for <selinux@archiver.kernel.org>; Mon, 24 Jun 2019 21:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfFXVrI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:47:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54053 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729667AbfFXVrI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Jun 2019 17:47:08 -0400
Received: from static-50-53-46-226.bvtn.or.frontiernet.net ([50.53.46.226] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1hfWnl-0006Ge-JD; Mon, 24 Jun 2019 21:47:02 +0000
From:   John Johansen <john.johansen@canonical.com>
Subject: [PATCH v3 19/24] LSM: Use lsmcontext in security_inode_getsecctx
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-20-casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <6de1466d-5473-b7b1-b901-404e1e12243a@canonical.com>
Date:   Mon, 24 Jun 2019 14:46:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190621185233.6766-20-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/21/19 11:52 AM, Casey Schaufler wrote:
> Change the security_inode_getsecctx() interface to fill
> a lsmcontext structure instead of data and length pointers.
> This provides the information about which LSM created the
> context so that security_release_secctx() can use the
> correct hook. A lsmcontext is used within kernfs to store
> the security information as well.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

with the issue below fixed

Reviewed-by: John Johansen <john.johansen@canonical.com>


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

should be
		if (*display == LSMBLOB_INVALID || *display == hp->slot)

> +			cp->slot = hp->slot;
> +			return hp->hook.inode_getsecctx(inode,
> +					(void **)&cp->context, &cp->len);
> +		}
> +	return -EOPNOTSUPP;
>  }
>  EXPORT_SYMBOL(security_inode_getsecctx);
>  
> 



