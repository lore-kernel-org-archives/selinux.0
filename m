Return-Path: <SRS0=M/73=ZN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17589C43215
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 19:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD74F206D8
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 19:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfKUTAU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:00:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59525 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUTAT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Nov 2019 14:00:19 -0500
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1iXrgX-00057s-Dz; Thu, 21 Nov 2019 19:00:09 +0000
Subject: Re: [PATCH v11 14/25] LSM: Ensure the correct LSM context releaser
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20191113181925.2437-1-casey@schaufler-ca.com>
 <20191113181925.2437-15-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <cc57e331-7584-a487-e600-4042561c572d@canonical.com>
Date:   Thu, 21 Nov 2019 11:00:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113181925.2437-15-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/13/19 10:19 AM, Casey Schaufler wrote:
> Add a new lsmcontext data structure to hold all the information
> about a "security context", including the string, its size and
> which LSM allocated the string. The allocation information is
> necessary because LSMs have different policies regarding the
> lifecycle of these strings. SELinux allocates and destroys
> them on each use, whereas Smack provides a pointer to an entry
> in a list that never goes away.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: linux-integrity@vger.kernel.org
> cc: netdev@vger.kernel.org

Acked-by: John Johansen <john.johansen@canonical.com>


> ---
>  drivers/android/binder.c                | 10 +++++--
>  fs/ceph/xattr.c                         |  6 +++-
>  fs/nfs/nfs4proc.c                       |  8 +++--
>  fs/nfsd/nfs4xdr.c                       |  7 +++--
>  include/linux/security.h                | 39 +++++++++++++++++++++++--
>  include/net/scm.h                       |  5 +++-
>  kernel/audit.c                          | 14 ++++++---
>  kernel/auditsc.c                        | 12 ++++++--
>  net/ipv4/ip_sockglue.c                  |  4 ++-
>  net/netfilter/nf_conntrack_netlink.c    |  4 ++-
>  net/netfilter/nf_conntrack_standalone.c |  4 ++-
>  net/netfilter/nfnetlink_queue.c         | 13 ++++++---
>  net/netlabel/netlabel_unlabeled.c       | 19 +++++++++---
>  net/netlabel/netlabel_user.c            |  4 ++-
>  security/security.c                     | 18 ++++++++----
>  security/smack/smack_lsm.c              | 14 ++++++---
>  16 files changed, 141 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 3a7fcdc8dbe2..49b84b6fafd9 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2865,6 +2865,7 @@ static void binder_transaction(struct binder_proc *proc,
>  	int t_debug_id = atomic_inc_return(&binder_last_id);
>  	char *secctx = NULL;
>  	u32 secctx_sz = 0;
> +	struct lsmcontext scaff; /* scaffolding */
>  
>  	e = binder_transaction_log_add(&binder_transaction_log);
>  	e->debug_id = t_debug_id;
> @@ -3161,7 +3162,8 @@ static void binder_transaction(struct binder_proc *proc,
>  			t->security_ctx = 0;
>  			WARN_ON(1);
>  		}
> -		security_release_secctx(secctx, secctx_sz);
> +		lsmcontext_init(&scaff, secctx, secctx_sz, 0);
> +		security_release_secctx(&scaff);
>  		secctx = NULL;
>  	}
>  	t->buffer->debug_id = t->debug_id;
> @@ -3494,8 +3496,10 @@ static void binder_transaction(struct binder_proc *proc,
>  	binder_alloc_free_buf(&target_proc->alloc, t->buffer);
>  err_binder_alloc_buf_failed:
>  err_bad_extra_size:
> -	if (secctx)
> -		security_release_secctx(secctx, secctx_sz);
> +	if (secctx) {
> +		lsmcontext_init(&scaff, secctx, secctx_sz, 0);
> +		security_release_secctx(&scaff);
> +	}
>  err_get_secctx_failed:
>  	kfree(tcomplete);
>  	binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index cb18ee637cb7..ad501b5cad2c 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -1271,12 +1271,16 @@ int ceph_security_init_secctx(struct dentry *dentry, umode_t mode,
>  
>  void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx)
>  {
> +#ifdef CONFIG_CEPH_FS_SECURITY_LABEL
> +	struct lsmcontext scaff; /* scaffolding */
> +#endif
>  #ifdef CONFIG_CEPH_FS_POSIX_ACL
>  	posix_acl_release(as_ctx->acl);
>  	posix_acl_release(as_ctx->default_acl);
>  #endif
>  #ifdef CONFIG_CEPH_FS_SECURITY_LABEL
> -	security_release_secctx(as_ctx->sec_ctx, as_ctx->sec_ctxlen);
> +	lsmcontext_init(&scaff, as_ctx->sec_ctx, as_ctx->sec_ctxlen, 0);
> +	security_release_secctx(&scaff);
>  #endif
>  	if (as_ctx->pagelist)
>  		ceph_pagelist_release(as_ctx->pagelist);
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index caacf5e7f5e1..74e9f4b7cc07 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -131,8 +131,12 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>  static inline void
>  nfs4_label_release_security(struct nfs4_label *label)
>  {
> -	if (label)
> -		security_release_secctx(label->label, label->len);
> +	struct lsmcontext scaff; /* scaffolding */
> +
> +	if (label) {
> +		lsmcontext_init(&scaff, label->label, label->len, 0);
> +		security_release_secctx(&scaff);
> +	}
>  }
>  static inline u32 *nfs4_bitmask(struct nfs_server *server, struct nfs4_label *label)
>  {
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 533d0fc3c96b..b17aad082bde 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2421,6 +2421,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  	int err;
>  	struct nfs4_acl *acl = NULL;
>  #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
> +	struct lsmcontext scaff; /* scaffolding */
>  	void *context = NULL;
>  	int contextlen;
>  #endif
> @@ -2923,8 +2924,10 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>  
>  out:
>  #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
> -	if (context)
> -		security_release_secctx(context, contextlen);
> +	if (context) {
> +		lsmcontext_init(&scaff, context, contextlen, 0); /*scaffolding*/
> +		security_release_secctx(&scaff);
> +	}
>  #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
>  	kfree(acl);
>  	if (tempfh) {
> diff --git a/include/linux/security.h b/include/linux/security.h
> index f7bc7aef95cb..9bb11d9f1348 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -126,6 +126,41 @@ enum lockdown_reason {
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
>  
> +/*
> + * A "security context" is the text representation of
> + * the information used by LSMs.
> + * This structure contains the string, its length, and which LSM
> + * it is useful for.
> + */
> +struct lsmcontext {
> +	char	*context;	/* Provided by the module */
> +	u32	len;
> +	int	slot;		/* Identifies the module */
> +};
> +
> +/**
> + * lsmcontext_init - initialize an lsmcontext structure.
> + * @cp: Pointer to the context to initialize
> + * @context: Initial context, or NULL
> + * @size: Size of context, or 0
> + * @slot: Which LSM provided the context
> + *
> + * Fill in the lsmcontext from the provided information.
> + * This is a scaffolding function that will be removed when
> + * lsmcontext integration is complete.
> + */
> +static inline void lsmcontext_init(struct lsmcontext *cp, char *context,
> +				   u32 size, int slot)
> +{
> +	cp->slot = slot;
> +	cp->context = context;
> +
> +	if (context == NULL || size == 0)
> +		cp->len = 0;
> +	else
> +		cp->len = strlen(context);
> +}
> +
>  /*
>   * Data exported by the security modules
>   *
> @@ -496,7 +531,7 @@ int security_ismaclabel(const char *name);
>  int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen);
>  int security_secctx_to_secid(const char *secdata, u32 seclen,
>  			     struct lsmblob *blob);
> -void security_release_secctx(char *secdata, u32 seclen);
> +void security_release_secctx(struct lsmcontext *cp);
>  void security_inode_invalidate_secctx(struct inode *inode);
>  int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
> @@ -1310,7 +1345,7 @@ static inline int security_secctx_to_secid(const char *secdata,
>  	return -EOPNOTSUPP;
>  }
>  
> -static inline void security_release_secctx(char *secdata, u32 seclen)
> +static inline void security_release_secctx(struct lsmcontext *cp)
>  {
>  }
>  
> diff --git a/include/net/scm.h b/include/net/scm.h
> index 31ae605fcc0a..30ba801c91bd 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -92,6 +92,7 @@ static __inline__ int scm_send(struct socket *sock, struct msghdr *msg,
>  #ifdef CONFIG_SECURITY_NETWORK
>  static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
>  {
> +	struct lsmcontext context;
>  	char *secdata;
>  	u32 seclen;
>  	int err;
> @@ -102,7 +103,9 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
>  
>  		if (!err) {
>  			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
> -			security_release_secctx(secdata, seclen);
> +			/*scaffolding*/
> +			lsmcontext_init(&context, secdata, seclen, 0);
> +			security_release_secctx(&context);
>  		}
>  	}
>  }
> diff --git a/kernel/audit.c b/kernel/audit.c
> index ba9f78e36d1e..35970e7191b6 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1180,6 +1180,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>  	struct audit_sig_info   *sig_data;
>  	char			*ctx = NULL;
>  	u32			len;
> +	struct lsmcontext	scaff; /* scaffolding */
>  
>  	err = audit_netlink_ok(skb, msg_type);
>  	if (err)
> @@ -1424,15 +1425,18 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>  		}
>  		sig_data = kmalloc(sizeof(*sig_data) + len, GFP_KERNEL);
>  		if (!sig_data) {
> -			if (lsmblob_is_set(&audit_sig_lsm))
> -				security_release_secctx(ctx, len);
> +			if (lsmblob_is_set(&audit_sig_lsm)) {
> +				lsmcontext_init(&scaff, ctx, len, 0);
> +				security_release_secctx(&scaff);
> +			}
>  			return -ENOMEM;
>  		}
>  		sig_data->uid = from_kuid(&init_user_ns, audit_sig_uid);
>  		sig_data->pid = audit_sig_pid;
>  		if (lsmblob_is_set(&audit_sig_lsm)) {
>  			memcpy(sig_data->ctx, ctx, len);
> -			security_release_secctx(ctx, len);
> +			lsmcontext_init(&scaff, ctx, len, 0);
> +			security_release_secctx(&scaff);
>  		}
>  		audit_send_reply(skb, seq, AUDIT_SIGNAL_INFO, 0, 0,
>  				 sig_data, sizeof(*sig_data) + len);
> @@ -2061,6 +2065,7 @@ int audit_log_task_context(struct audit_buffer *ab)
>  	unsigned len;
>  	int error;
>  	struct lsmblob blob;
> +	struct lsmcontext scaff; /* scaffolding */
>  
>  	security_task_getsecid(current, &blob);
>  	if (!lsmblob_is_set(&blob))
> @@ -2074,7 +2079,8 @@ int audit_log_task_context(struct audit_buffer *ab)
>  	}
>  
>  	audit_log_format(ab, " subj=%s", ctx);
> -	security_release_secctx(ctx, len);
> +	lsmcontext_init(&scaff, ctx, len, 0);
> +	security_release_secctx(&scaff);
>  	return 0;
>  
>  error_path:
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index c1e3ac8eb1ad..8790e7aafa7d 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -962,6 +962,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>  				 struct lsmblob *blob, char *comm)
>  {
>  	struct audit_buffer *ab;
> +	struct lsmcontext lsmcxt;
>  	char *ctx = NULL;
>  	u32 len;
>  	int rc = 0;
> @@ -979,7 +980,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>  			rc = 1;
>  		} else {
>  			audit_log_format(ab, " obj=%s", ctx);
> -			security_release_secctx(ctx, len);
> +			lsmcontext_init(&lsmcxt, ctx, len, 0); /*scaffolding*/
> +			security_release_secctx(&lsmcxt);
>  		}
>  	}
>  	audit_log_format(ab, " ocomm=");
> @@ -1192,6 +1194,7 @@ static void audit_log_fcaps(struct audit_buffer *ab, struct audit_names *name)
>  
>  static void show_special(struct audit_context *context, int *call_panic)
>  {
> +	struct lsmcontext lsmcxt;
>  	struct audit_buffer *ab;
>  	int i;
>  
> @@ -1225,7 +1228,8 @@ static void show_special(struct audit_context *context, int *call_panic)
>  				*call_panic = 1;
>  			} else {
>  				audit_log_format(ab, " obj=%s", ctx);
> -				security_release_secctx(ctx, len);
> +				lsmcontext_init(&lsmcxt, ctx, len, 0);
> +				security_release_secctx(&lsmcxt);
>  			}
>  		}
>  		if (context->ipc.has_perm) {
> @@ -1371,6 +1375,7 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
>  		char *ctx = NULL;
>  		u32 len;
>  		struct lsmblob blob;
> +		struct lsmcontext lsmcxt;
>  
>  		lsmblob_init(&blob, n->osid);
>  		if (security_secid_to_secctx(&blob, &ctx, &len)) {
> @@ -1379,7 +1384,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
>  				*call_panic = 2;
>  		} else {
>  			audit_log_format(ab, " obj=%s", ctx);
> -			security_release_secctx(ctx, len);
> +			lsmcontext_init(&lsmcxt, ctx, len, 0); /* scaffolding */
> +			security_release_secctx(&lsmcxt);
>  		}
>  	}
>  
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index 1ca97d0cb4a9..96d56a30ecca 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -130,6 +130,7 @@ static void ip_cmsg_recv_checksum(struct msghdr *msg, struct sk_buff *skb,
>  
>  static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
>  {
> +	struct lsmcontext context;
>  	struct lsmblob lb;
>  	char *secdata;
>  	u32 seclen;
> @@ -144,7 +145,8 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
>  		return;
>  
>  	put_cmsg(msg, SOL_IP, SCM_SECURITY, seclen, secdata);
> -	security_release_secctx(secdata, seclen);
> +	lsmcontext_init(&context, secdata, seclen, 0); /* scaffolding */
> +	security_release_secctx(&context);
>  }
>  
>  static void ip_cmsg_recv_dstaddr(struct msghdr *msg, struct sk_buff *skb)
> diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
> index 0412f6744185..78791e015d8b 100644
> --- a/net/netfilter/nf_conntrack_netlink.c
> +++ b/net/netfilter/nf_conntrack_netlink.c
> @@ -332,6 +332,7 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
>  	int len, ret;
>  	char *secctx;
>  	struct lsmblob blob;
> +	struct lsmcontext context;
>  
>  	lsmblob_init(&blob, ct->secmark);
>  	ret = security_secid_to_secctx(&blob, &secctx, &len);
> @@ -349,7 +350,8 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
>  
>  	ret = 0;
>  nla_put_failure:
> -	security_release_secctx(secctx, len);
> +	lsmcontext_init(&context, secctx, len, 0); /* scaffolding */
> +	security_release_secctx(&context);
>  	return ret;
>  }
>  #else
> diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
> index 183a85412155..8601fcb99f7a 100644
> --- a/net/netfilter/nf_conntrack_standalone.c
> +++ b/net/netfilter/nf_conntrack_standalone.c
> @@ -176,6 +176,7 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
>  	u32 len;
>  	char *secctx;
>  	struct lsmblob blob;
> +	struct lsmcontext context;
>  
>  	lsmblob_init(&blob, ct->secmark);
>  	ret = security_secid_to_secctx(&blob, &secctx, &len);
> @@ -184,7 +185,8 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
>  
>  	seq_printf(s, "secctx=%s ", secctx);
>  
> -	security_release_secctx(secctx, len);
> +	lsmcontext_init(&context, secctx, len, 0); /* scaffolding */
> +	security_release_secctx(&context);
>  }
>  #else
>  static inline void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
> diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
> index bfa7f12fde99..cc3ef03ee198 100644
> --- a/net/netfilter/nfnetlink_queue.c
> +++ b/net/netfilter/nfnetlink_queue.c
> @@ -395,6 +395,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>  	enum ip_conntrack_info uninitialized_var(ctinfo);
>  	struct nfnl_ct_hook *nfnl_ct;
>  	bool csum_verify;
> +	struct lsmcontext scaff; /* scaffolding */
>  	char *secdata = NULL;
>  	u32 seclen = 0;
>  
> @@ -625,8 +626,10 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>  	}
>  
>  	nlh->nlmsg_len = skb->len;
> -	if (seclen)
> -		security_release_secctx(secdata, seclen);
> +	if (seclen) {
> +		lsmcontext_init(&scaff, secdata, seclen, 0);
> +		security_release_secctx(&scaff);
> +	}
>  	return skb;
>  
>  nla_put_failure:
> @@ -634,8 +637,10 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>  	kfree_skb(skb);
>  	net_err_ratelimited("nf_queue: error creating packet message\n");
>  nlmsg_failure:
> -	if (seclen)
> -		security_release_secctx(secdata, seclen);
> +	if (seclen) {
> +		lsmcontext_init(&scaff, secdata, seclen, 0);
> +		security_release_secctx(&scaff);
> +	}
>  	return NULL;
>  }
>  
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index e279b81d9545..288c005b44c7 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -373,6 +373,7 @@ int netlbl_unlhsh_add(struct net *net,
>  	struct net_device *dev;
>  	struct netlbl_unlhsh_iface *iface;
>  	struct audit_buffer *audit_buf = NULL;
> +	struct lsmcontext context;
>  	char *secctx = NULL;
>  	u32 secctx_len;
>  	struct lsmblob blob;
> @@ -443,7 +444,9 @@ int netlbl_unlhsh_add(struct net *net,
>  					     &secctx,
>  					     &secctx_len) == 0) {
>  			audit_log_format(audit_buf, " sec_obj=%s", secctx);
> -			security_release_secctx(secctx, secctx_len);
> +			/* scaffolding */
> +			lsmcontext_init(&context, secctx, secctx_len, 0);
> +			security_release_secctx(&context);
>  		}
>  		audit_log_format(audit_buf, " res=%u", ret_val == 0 ? 1 : 0);
>  		audit_log_end(audit_buf);
> @@ -474,6 +477,7 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>  	struct netlbl_unlhsh_addr4 *entry;
>  	struct audit_buffer *audit_buf;
>  	struct net_device *dev;
> +	struct lsmcontext context;
>  	char *secctx;
>  	u32 secctx_len;
>  	struct lsmblob blob;
> @@ -502,7 +506,9 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>  		    security_secid_to_secctx(&blob,
>  					     &secctx, &secctx_len) == 0) {
>  			audit_log_format(audit_buf, " sec_obj=%s", secctx);
> -			security_release_secctx(secctx, secctx_len);
> +			/* scaffolding */
> +			lsmcontext_init(&context, secctx, secctx_len, 0);
> +			security_release_secctx(&context);
>  		}
>  		audit_log_format(audit_buf, " res=%u", entry != NULL ? 1 : 0);
>  		audit_log_end(audit_buf);
> @@ -539,6 +545,7 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>  	struct netlbl_unlhsh_addr6 *entry;
>  	struct audit_buffer *audit_buf;
>  	struct net_device *dev;
> +	struct lsmcontext context;
>  	char *secctx;
>  	u32 secctx_len;
>  	struct lsmblob blob;
> @@ -566,7 +573,8 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>  		    security_secid_to_secctx(&blob,
>  					     &secctx, &secctx_len) == 0) {
>  			audit_log_format(audit_buf, " sec_obj=%s", secctx);
> -			security_release_secctx(secctx, secctx_len);
> +			lsmcontext_init(&context, secctx, secctx_len, 0);
> +			security_release_secctx(&context);
>  		}
>  		audit_log_format(audit_buf, " res=%u", entry != NULL ? 1 : 0);
>  		audit_log_end(audit_buf);
> @@ -1080,6 +1088,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>  	int ret_val = -ENOMEM;
>  	struct netlbl_unlhsh_walk_arg *cb_arg = arg;
>  	struct net_device *dev;
> +	struct lsmcontext context;
>  	void *data;
>  	u32 secid;
>  	char *secctx;
> @@ -1147,7 +1156,9 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>  			  NLBL_UNLABEL_A_SECCTX,
>  			  secctx_len,
>  			  secctx);
> -	security_release_secctx(secctx, secctx_len);
> +	/* scaffolding */
> +	lsmcontext_init(&context, secctx, secctx_len, 0);
> +	security_release_secctx(&context);
>  	if (ret_val != 0)
>  		goto list_cb_failure;
>  
> diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
> index 893301ae0131..ef139d8ae7cd 100644
> --- a/net/netlabel/netlabel_user.c
> +++ b/net/netlabel/netlabel_user.c
> @@ -84,6 +84,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
>  					       struct netlbl_audit *audit_info)
>  {
>  	struct audit_buffer *audit_buf;
> +	struct lsmcontext context;
>  	char *secctx;
>  	u32 secctx_len;
>  	struct lsmblob blob;
> @@ -103,7 +104,8 @@ struct audit_buffer *netlbl_audit_start_common(int type,
>  	if (audit_info->secid != 0 &&
>  	    security_secid_to_secctx(&blob, &secctx, &secctx_len) == 0) {
>  		audit_log_format(audit_buf, " subj=%s", secctx);
> -		security_release_secctx(secctx, secctx_len);
> +		lsmcontext_init(&context, secctx, secctx_len, 0);/*scaffolding*/
> +		security_release_secctx(&context);
>  	}
>  
>  	return audit_buf;
> diff --git a/security/security.c b/security/security.c
> index c2874f6587d2..c05ef9d0c8ed 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2144,17 +2144,23 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
>  }
>  EXPORT_SYMBOL(security_secctx_to_secid);
>  
> -void security_release_secctx(char *secdata, u32 seclen)
> +void security_release_secctx(struct lsmcontext *cp)
>  {
>  	struct security_hook_list *hp;
> -	int *display = current->security;
> +	bool found = false;
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
> -		if (display == NULL || *display == LSMBLOB_INVALID ||
> -		    *display == hp->lsmid->slot) {
> -			hp->hook.release_secctx(secdata, seclen);
> -			return;
> +		if (cp->slot == hp->lsmid->slot) {
> +			hp->hook.release_secctx(cp->context, cp->len);
> +			found = true;
> +			break;
>  		}
> +
> +	memset(cp, 0, sizeof(*cp));
> +
> +	if (!found)
> +		pr_warn("%s context \"%s\" from slot %d not released\n",
> +			__func__, cp->context, cp->slot);
>  }
>  EXPORT_SYMBOL(security_release_secctx);
>  
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index aac8cb0de733..4e464e5e942e 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4483,11 +4483,16 @@ static int smack_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
>  	return 0;
>  }
>  
> -/*
> - * There used to be a smack_release_secctx hook
> - * that did nothing back when hooks were in a vector.
> - * Now that there's a list such a hook adds cost.
> +/**
> + * smack_release_secctx - do everything necessary to free a context
> + * @secdata: Unused
> + * @seclen: Unused
> + *
> + * Do nothing but hold a slot in the hooks list.
>   */
> +static void smack_release_secctx(char *secdata, u32 seclen)
> +{
> +}
>  
>  static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
>  {
> @@ -4730,6 +4735,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(ismaclabel, smack_ismaclabel),
>  	LSM_HOOK_INIT(secid_to_secctx, smack_secid_to_secctx),
>  	LSM_HOOK_INIT(secctx_to_secid, smack_secctx_to_secid),
> +	LSM_HOOK_INIT(release_secctx, smack_release_secctx),
>  	LSM_HOOK_INIT(inode_notifysecctx, smack_inode_notifysecctx),
>  	LSM_HOOK_INIT(inode_setsecctx, smack_inode_setsecctx),
>  	LSM_HOOK_INIT(inode_getsecctx, smack_inode_getsecctx),
> 

