Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9EDC2D0BF
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 17:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2939A227BF
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 17:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="FKzTF1lY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfLRRD3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:03:29 -0500
Received: from UCOL19PA34.eemsg.mail.mil ([214.24.24.194]:14557 "EHLO
        UCOL19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbfLRRD3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 12:03:29 -0500
X-EEMSG-check-017: 63567850|UCOL19PA34_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="63567850"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Dec 2019 17:02:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576688559; x=1608224559;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=q9DdLc8AGEh2YrzHiROMw96F1FmZoMMJWXK63hi27cE=;
  b=FKzTF1lYtL0p15E9IvAF0+ocO6ZPX+SQ7ovP1qM4XL3DlQQHMuDdzB2Y
   bf9iF4i3WYbR3SjgMqswOr49Yu9AfW3W2ljO6D9YAysso/jcNbCdynegu
   w1QWmfAO0qgj/J5t642CgKIJAa/rP5lw5jZCKPKwMjjFEjcZj8V78bKtw
   MNJsZ4LdlWFhDx2+jFZE+m9tAA/053E7Obyd1LXPgQTg/QCIH18euRXAl
   NypsDnm5w58AVt8TletwCA/46N5y3sINmBw6bNv5eJHFVUIPFlH4Y4aiK
   QvrSHxLDS5l9Zo9zIKIrItD/Pd5FE91o1Zkb7C8sDqz8W5bh9i4vB9X79
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="31241601"
IronPort-PHdr: =?us-ascii?q?9a23=3ACbXSwR25nZSUrr3dsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesSLf3xwZ3uMQTl6Ol3ixeRBMOHsqkC0bKH+PG5EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMhm6sQHcusYSjId/N6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU8lfTSxBBp63YZUJAeQPIO1Uq5DxqlUKoBe7AwSnGeHhxSJShnLuwKM0ze?=
 =?us-ascii?q?ohHwHF0gIuEd0Bv3bbo8n6OqoJTeC4zrPFwSnfY/5Y2zrw7pXDfBA7ofGLWL?=
 =?us-ascii?q?J9adffyVUxGAPdjlWft4rlNC6I2OQIqWeb6+5gWvyvimU6rAxxuSWgxtw3h4?=
 =?us-ascii?q?nVhoMa1lDE9SJjzIYzPt23UlR3YdGjEJtOriyXMZZ9TMA6Q2xwpSo3xbILtY?=
 =?us-ascii?q?S7cSQX0pgr2RHSZ+Kdf4SV5B/oSfyfLi1ihH1/fbKynxOy8U+9xeLiTsS0y1?=
 =?us-ascii?q?NKrjZdktnLq3ANywTf6siZRft5+UeswSqP2BrJ6uFFPEA0jrDXK58nwr4+kZ?=
 =?us-ascii?q?oTqlrMETPslEXqjK6ZakUk+u+y5+ThfrrmvYOTO5VxigH/NqQigs2/AeImPQ?=
 =?us-ascii?q?gSR2WX5Oux2bL58UD5XblGlOM6n6bHvJzAOMgXvqu5DBVU0oYn5Ra/FTCm0N?=
 =?us-ascii?q?EAkHkcMV1FYwmKj5TpOl7SIPD4Cu2zg1K3kDhx3fzGMbrhAovVInjZjLjhZa?=
 =?us-ascii?q?p961JbyAcr0d9Q/YlUBa8BIf/oQU/+qNzYAQUkMwy6x+boFs992poCVm2VGK?=
 =?us-ascii?q?OWLKTSsVqQ7OI1P+aMfJMVuCr6K/U9+/Hhl2Q5lkEdfKWzxpsYdHC4Ee57I0?=
 =?us-ascii?q?WXZXrjnM0BHHwLvgo4UOzlllmCXSRPaHa1WqI2/is7B56+DYffWoCth6SM3C?=
 =?us-ascii?q?W+Hp1RfGBGEFGMEWzzeoWCQfgMbTydIs57njwDT7ihRJcr1Quyuw/i17pnMu?=
 =?us-ascii?q?3U9zUctZLi0th1+uLSmQgp9TNqE8udznuNT2BonmIIXjM22ad/rlFgyleHz6?=
 =?us-ascii?q?d1mOJYFdNN6PNTSAs6NoDTz/Z8C9/sXgLNZNCJSEypQt++GzE+Usoxw8MSY0?=
 =?us-ascii?q?Z6A9iilQ7M3y6rA78TiryKC4c58rzT33fvPcZx0XXG27c7j1kgXMRPMXeqhq?=
 =?us-ascii?q?ll9wjcH4TJiVmWl762daQA2y7A7GSDwnSQs0FDTAFwVqLFXXMEa0TKrdT5/E?=
 =?us-ascii?q?TCT7qvCbQ6NwtN08mCKrFFatfxl1VJWO/jOMjCY2K2g2qwBxGIxrOKbIbweW?=
 =?us-ascii?q?Ud2yXdB1ICkwAI43mGMxMzCTu7rGLYCzxuE1PvbF/2/ul6sn+0Ukg0zwSSZU?=
 =?us-ascii?q?17y7W14gIVheCbS/4LxrILpiEhqzppHFa82dLaEtmAqBR7fKVaf9w95ExK1W?=
 =?us-ascii?q?PAuwx5OZygMb5tikQFcwttvEPuyg93BZ9ancgssnwm1ghyKbqA2lNbazyYxY?=
 =?us-ascii?q?zwOqHQKmTq5BCgcbPW2lXF3daO4KgP9fA4p0zmvAGuEUoi6Wto38NJ3Hub45?=
 =?us-ascii?q?WZRDYVBLn4SUsmvyNxp7jHbC0w/cuA3nR3PLicqTTC0s8nAOY/jx2pOdxYNf?=
 =?us-ascii?q?XAXAT7CMALQdOlKOU3lVykdDoFOvxf8Og/OMbiP/mD37SxPf1ImjujgGUB55?=
 =?us-ascii?q?pylgqI9ixhWqvT0p0Y2fCEz06CUDvhiFqJrM/6g8ZHaCsUE275zjLrQMZKa6?=
 =?us-ascii?q?lze5sbIXmhLtfxxdhkgZPpHXlC+w2NHVQDjfS1dAKSYlq15ghZ0UAasDTzgi?=
 =?us-ascii?q?ej5yBlmDEu6KyE1WrBxPq0J0lPAXJCWGQ31QSkGoOzld1PGRHzPgU=3D?=
X-IPAS-Result: =?us-ascii?q?A2BKAABkWvpd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF8gXaBbSASKoQEiQOGWgaBEiWJaooihyMJAQEBAQEBAQEBNwEBh?=
 =?us-ascii?q?EACgj04EwIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIwQRQRALGAICJgICV?=
 =?us-ascii?q?wYBDAYCAQGCXz+CUyWtfn8zhU+DO4FBgQ4ojDJ5gQeBEScMA4JdPodZgl4Ej?=
 =?us-ascii?q?UKJTEaXNYI/gkOTSgYbmk4tjiGcXyKBWCsIAhgIIQ87gmxQGA2NHheOQSMDM?=
 =?us-ascii?q?I8tAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Dec 2019 17:02:38 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBIH25ZZ037781;
        Wed, 18 Dec 2019 12:02:06 -0500
Subject: Re: [PATCH v12 17/25] LSM: Use lsmcontext in security_inode_getsecctx
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-18-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6740b5a0-db70-9281-f3ca-7cb4822e0889@tycho.nsa.gov>
Date:   Wed, 18 Dec 2019 12:02:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-18-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:36 PM, Casey Schaufler wrote:
> Change the security_inode_getsecctx() interface to fill
> a lsmcontext structure instead of data and length pointers.
> This provides the information about which LSM created the
> context so that security_release_secctx() can use the
> correct hook.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   fs/nfsd/nfs4xdr.c        | 23 +++++++++--------------
>   include/linux/security.h |  5 +++--
>   security/security.c      | 13 +++++++++++--
>   3 files changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index e20011281915..98d20178e60f 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2304,11 +2304,11 @@ nfsd4_encode_layout_types(struct xdr_stream *xdr, u32 layout_types)
>   #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>   static inline __be32
>   nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
> -			    void *context, int len)
> +			    struct lsmcontext *context)
>   {
>   	__be32 *p;
>   
> -	p = xdr_reserve_space(xdr, len + 4 + 4 + 4);
> +	p = xdr_reserve_space(xdr, context->len + 4 + 4 + 4);
>   	if (!p)
>   		return nfserr_resource;
>   
> @@ -2318,13 +2318,13 @@ nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
>   	 */
>   	*p++ = cpu_to_be32(0); /* lfs */
>   	*p++ = cpu_to_be32(0); /* pi */
> -	p = xdr_encode_opaque(p, context, len);
> +	p = xdr_encode_opaque(p, context->context, context->len);
>   	return 0;
>   }
>   #else
>   static inline __be32
>   nfsd4_encode_security_label(struct xdr_stream *xdr, struct svc_rqst *rqstp,
> -			    void *context, int len)
> +			    struct lsmcontext *context)
>   { return 0; }
>   #endif
>   
> @@ -2421,9 +2421,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>   	int err;
>   	struct nfs4_acl *acl = NULL;
>   #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
> -	struct lsmcontext scaff; /* scaffolding */
> -	void *context = NULL;
> -	int contextlen;
> +	struct lsmcontext context = { };
>   #endif
>   	bool contextsupport = false;
>   	struct nfsd4_compoundres *resp = rqstp->rq_resp;
> @@ -2481,7 +2479,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>   	     bmval0 & FATTR4_WORD0_SUPPORTED_ATTRS) {
>   		if (exp->ex_flags & NFSEXP_SECURITY_LABEL)
>   			err = security_inode_getsecctx(d_inode(dentry),
> -						&context, &contextlen);
> +						       &context);
>   		else
>   			err = -EOPNOTSUPP;
>   		contextsupport = (err == 0);
> @@ -2911,8 +2909,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>   
>   #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>   	if (bmval2 & FATTR4_WORD2_SECURITY_LABEL) {
> -		status = nfsd4_encode_security_label(xdr, rqstp, context,
> -								contextlen);
> +		status = nfsd4_encode_security_label(xdr, rqstp, &context);
>   		if (status)
>   			goto out;
>   	}
> @@ -2924,10 +2921,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>   
>   out:
>   #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
> -	if (context) {
> -		lsmcontext_init(&scaff, context, contextlen, 0); /*scaffolding*/
> -		security_release_secctx(&scaff);
> -	}
> +	if (context.context)
> +		security_release_secctx(&context);
>   #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
>   	kfree(acl);
>   	if (tempfh) {
> diff --git a/include/linux/security.h b/include/linux/security.h
> index a5eba06a9382..d0fab9f5dddf 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -537,7 +537,7 @@ void security_release_secctx(struct lsmcontext *cp);
>   void security_inode_invalidate_secctx(struct inode *inode);
>   int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>   int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
> -int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
> +int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
>   int security_locked_down(enum lockdown_reason what);
>   #else /* CONFIG_SECURITY */
>   
> @@ -1362,7 +1362,8 @@ static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
>   {
>   	return -EOPNOTSUPP;
>   }
> -static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
> +static inline int security_inode_getsecctx(struct inode *inode,
> +					   struct lsmcontext *cp)
>   {
>   	return -EOPNOTSUPP;
>   }
> diff --git a/security/security.c b/security/security.c
> index 8aa107b57af9..963641acf9dc 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2207,9 +2207,18 @@ int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
>   }
>   EXPORT_SYMBOL(security_inode_setsecctx);
>   
> -int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
> +int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp)
>   {
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
>   }
>   EXPORT_SYMBOL(security_inode_getsecctx);
>   
> 

