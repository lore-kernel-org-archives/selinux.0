Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8626FC48BD3
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DAE21738
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g4oMfQFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfFZXPT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:15:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41311 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfFZXPS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 19:15:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id m7so160574pls.8
        for <selinux@vger.kernel.org>; Wed, 26 Jun 2019 16:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UYucw2hhm0mJdnK0Zo+EWmO3mDWvEBwLt83u1R8V52M=;
        b=g4oMfQFiH/vqolRJzekItEYq1PvHJlTme+7UNYr7O9/RgaGjUoW38sN7D1O35tU5Aj
         CXKUVq+tb4QPMDM4hh4jTSGz1QCt5gt3WGYeZci1DnNmYFU9fGdqFXqfH/ZU7EDAe7iq
         ePNO83xO9uPvdgp/BiTYlFRJepopeRwa+cliU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UYucw2hhm0mJdnK0Zo+EWmO3mDWvEBwLt83u1R8V52M=;
        b=lS0mitplYBtNRIWsYsTB5LEIs3ALOcH0fJFfZ/+1EE/Dqj4j5w4QDPCyqbwKJ06q8t
         G6jyCK6NGuJcefNh+N4f9dckEnI1DKdcksDb/b7Dc/wKlIN0m7YpZL/9mEz4wbYt2h0/
         rECLU6l2fIMxIkDdShj63FgmaRB/7HhD12o7lhUC0IQQRH6ClbAgjacVxWcHGxXMx4GN
         qpXbk2aQPMx9ge6IvmHKQKB+7/4FkeNwsnniIZKOWGtE+gjBHEbGOX00yRV4FBIEzmyP
         EVaM51MJgq82cdUX+9iso4GSF76/i5gb7zm/otvrsshxgEkJQ20DiFAyyVbItI4az4rp
         1lzw==
X-Gm-Message-State: APjAAAVUtX6kaq2XpVF1mgn2DMDOr3kv+RU27Fpjbx+SR9eM7ld2xgC9
        WE29LoeKPSzZXe1RhP3pqp5rJg==
X-Google-Smtp-Source: APXvYqxjgKc0ifbvFuRnS9BpAqe9lJ+fcQ3l9cHK2nG8/jtPg/nrHkJ3nTw272pDiomJn1Ds1eSscA==
X-Received: by 2002:a17:902:8a94:: with SMTP id p20mr715995plo.312.1561590917748;
        Wed, 26 Jun 2019 16:15:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y10sm322040pfm.66.2019.06.26.16.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 16:15:16 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:15:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v4 17/23] LSM: Use lsmcontext in security_secid_to_secctx
Message-ID: <201906261615.64F9DE5@keescook>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-18-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626192234.11725-18-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 26, 2019 at 12:22:28PM -0700, Casey Schaufler wrote:
> Replace the (secctx,seclen) pointer pair with a single
> lsmcontext pointer to allow return of the LSM identifier
> along with the context and context length. This allows
> security_release_secctx() to know how to release the
> context. Callers have been modified to use or save the
> returned data from the new structure.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/android/binder.c                | 24 ++++++---------
>  include/linux/security.h                |  4 +--
>  include/net/scm.h                       |  9 ++----
>  kernel/audit.c                          | 29 +++++++-----------
>  kernel/auditsc.c                        | 31 +++++++------------
>  net/ipv4/ip_sockglue.c                  |  7 ++---
>  net/netfilter/nf_conntrack_netlink.c    | 14 +++++----
>  net/netfilter/nf_conntrack_standalone.c |  7 ++---
>  net/netfilter/nfnetlink_queue.c         |  5 +++-
>  net/netlabel/netlabel_unlabeled.c       | 40 ++++++++-----------------
>  net/netlabel/netlabel_user.c            |  7 ++---
>  security/security.c                     |  9 ++++--
>  12 files changed, 72 insertions(+), 114 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 89e574be34cc..5d417a7b9bb3 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2874,9 +2874,7 @@ static void binder_transaction(struct binder_proc *proc,
>  	binder_size_t last_fixup_min_off = 0;
>  	struct binder_context *context = proc->context;
>  	int t_debug_id = atomic_inc_return(&binder_last_id);
> -	char *secctx = NULL;
> -	u32 secctx_sz = 0;
> -	struct lsmcontext scaff; /* scaffolding */
> +	struct lsmcontext lsmctx;
>  
>  	e = binder_transaction_log_add(&binder_transaction_log);
>  	e->debug_id = t_debug_id;
> @@ -3123,14 +3121,14 @@ static void binder_transaction(struct binder_proc *proc,
>  		struct lsmblob blob;
>  
>  		security_task_getsecid(proc->tsk, &blob);
> -		ret = security_secid_to_secctx(&blob, &secctx, &secctx_sz);
> +		ret = security_secid_to_secctx(&blob, &lsmctx);
>  		if (ret) {
>  			return_error = BR_FAILED_REPLY;
>  			return_error_param = ret;
>  			return_error_line = __LINE__;
>  			goto err_get_secctx_failed;
>  		}
> -		extra_buffers_size += ALIGN(secctx_sz, sizeof(u64));
> +		extra_buffers_size += ALIGN(lsmctx.len, sizeof(u64));
>  	}
>  
>  	trace_binder_transaction(reply, t, target_node);
> @@ -3149,19 +3147,17 @@ static void binder_transaction(struct binder_proc *proc,
>  		t->buffer = NULL;
>  		goto err_binder_alloc_buf_failed;
>  	}
> -	if (secctx) {
> +	if (lsmctx.context) {
>  		size_t buf_offset = ALIGN(tr->data_size, sizeof(void *)) +
>  				    ALIGN(tr->offsets_size, sizeof(void *)) +
>  				    ALIGN(extra_buffers_size, sizeof(void *)) -
> -				    ALIGN(secctx_sz, sizeof(u64));
> +				    ALIGN(lsmctx.len, sizeof(u64));
>  
>  		t->security_ctx = (uintptr_t)t->buffer->user_data + buf_offset;
>  		binder_alloc_copy_to_buffer(&target_proc->alloc,
>  					    t->buffer, buf_offset,
> -					    secctx, secctx_sz);
> -		lsmcontext_init(&scaff, secctx, secctx_sz, 0);
> -		security_release_secctx(&scaff);
> -		secctx = NULL;
> +					    lsmctx.context, lsmctx.len);
> +		security_release_secctx(&lsmctx);
>  	}
>  	t->buffer->debug_id = t->debug_id;
>  	t->buffer->transaction = t;
> @@ -3481,10 +3477,8 @@ static void binder_transaction(struct binder_proc *proc,
>  	t->buffer->transaction = NULL;
>  	binder_alloc_free_buf(&target_proc->alloc, t->buffer);
>  err_binder_alloc_buf_failed:
> -	if (secctx) {
> -		lsmcontext_init(&scaff, secctx, secctx_sz, 0);
> -		security_release_secctx(&scaff);
> -	}
> +	if (lsmctx.context)
> +		security_release_secctx(&lsmctx);
>  err_get_secctx_failed:
>  	kfree(tcomplete);
>  	binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 046012a7255f..7255825aa697 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -481,7 +481,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>  			 size_t size);
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>  int security_ismaclabel(const char *name);
> -int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen);
> +int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp);
>  int security_secctx_to_secid(const char *secdata, u32 seclen,
>  			     struct lsmblob *blob);
>  void security_release_secctx(struct lsmcontext *cp);
> @@ -1263,7 +1263,7 @@ static inline int security_ismaclabel(const char *name)
>  }
>  
>  static inline int security_secid_to_secctx(struct lsmblob *blob,
> -					   char **secdata, u32 *seclen)
> +					   struct lsmcontext *cp)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/include/net/scm.h b/include/net/scm.h
> index 6c7c3c229e4a..4a6ad8caf423 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -93,17 +93,14 @@ static __inline__ int scm_send(struct socket *sock, struct msghdr *msg,
>  static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
>  {
>  	struct lsmcontext context;
> -	char *secdata;
> -	u32 seclen;
>  	int err;
>  
>  	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
> -		err = security_secid_to_secctx(&scm->lsmblob, &secdata,
> -					       &seclen);
> +		err = security_secid_to_secctx(&scm->lsmblob, &context);
>  
>  		if (!err) {
> -			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
> -			lsmcontext_init(&context, secdata, seclen, 0);/*scaffolding*/
> +			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY,
> +				 context.len, context.context);
>  			security_release_secctx(&context);
>  		}
>  	}
> diff --git a/kernel/audit.c b/kernel/audit.c
> index f844a2a642e6..436c23429319 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1191,9 +1191,8 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>  	struct audit_buffer	*ab;
>  	u16			msg_type = nlh->nlmsg_type;
>  	struct audit_sig_info   *sig_data;
> -	char			*ctx = NULL;
>  	u32			len;
> -	struct lsmcontext	scaff; /* scaffolding */
> +	struct lsmcontext	context;
>  
>  	err = audit_netlink_ok(skb, msg_type);
>  	if (err)
> @@ -1431,25 +1430,22 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>  	case AUDIT_SIGNAL_INFO:
>  		len = 0;
>  		if (lsmblob_is_set(&audit_sig_lsm)) {
> -			err = security_secid_to_secctx(&audit_sig_lsm, &ctx,
> -						       &len);
> +			err = security_secid_to_secctx(&audit_sig_lsm,
> +						       &context);
>  			if (err)
>  				return err;
>  		}
>  		sig_data = kmalloc(sizeof(*sig_data) + len, GFP_KERNEL);
>  		if (!sig_data) {
> -			if (lsmblob_is_set(&audit_sig_lsm)) {
> -				lsmcontext_init(&scaff, ctx, len, 0);
> -				security_release_secctx(&scaff);
> -			}
> +			if (lsmblob_is_set(&audit_sig_lsm))
> +				security_release_secctx(&context);
>  			return -ENOMEM;
>  		}
>  		sig_data->uid = from_kuid(&init_user_ns, audit_sig_uid);
>  		sig_data->pid = audit_sig_pid;
>  		if (lsmblob_is_set(&audit_sig_lsm)) {
> -			memcpy(sig_data->ctx, ctx, len);
> -			lsmcontext_init(&scaff, ctx, len, 0);
> -			security_release_secctx(&scaff);
> +			memcpy(sig_data->ctx, context.context, context.len);
> +			security_release_secctx(&context);
>  		}
>  		audit_send_reply(skb, seq, AUDIT_SIGNAL_INFO, 0, 0,
>  				 sig_data, sizeof(*sig_data) + len);
> @@ -2074,26 +2070,23 @@ void audit_log_key(struct audit_buffer *ab, char *key)
>  
>  int audit_log_task_context(struct audit_buffer *ab)
>  {
> -	char *ctx = NULL;
> -	unsigned len;
>  	int error;
>  	struct lsmblob blob;
> -	struct lsmcontext scaff; /* scaffolding */
> +	struct lsmcontext context;
>  
>  	security_task_getsecid(current, &blob);
>  	if (!lsmblob_is_set(&blob))
>  		return 0;
>  
> -	error = security_secid_to_secctx(&blob, &ctx, &len);
> +	error = security_secid_to_secctx(&blob, &context);
>  	if (error) {
>  		if (error != -EINVAL)
>  			goto error_path;
>  		return 0;
>  	}
>  
> -	audit_log_format(ab, " subj=%s", ctx);
> -	lsmcontext_init(&scaff, ctx, len, 0);
> -	security_release_secctx(&scaff);
> +	audit_log_format(ab, " subj=%s", context.context);
> +	security_release_secctx(&context);
>  	return 0;
>  
>  error_path:
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 9fab0e7d90c3..0478680cd0a8 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -943,9 +943,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>  				 struct lsmblob *blob, char *comm)
>  {
>  	struct audit_buffer *ab;
> -	struct lsmcontext lsmcxt;
> -	char *ctx = NULL;
> -	u32 len;
> +	struct lsmcontext lsmctx;
>  	int rc = 0;
>  
>  	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
> @@ -956,13 +954,12 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>  			 from_kuid(&init_user_ns, auid),
>  			 from_kuid(&init_user_ns, uid), sessionid);
>  	if (lsmblob_is_set(blob)) {
> -		if (security_secid_to_secctx(blob, &ctx, &len)) {
> +		if (security_secid_to_secctx(blob, &lsmctx)) {
>  			audit_log_format(ab, " obj=(none)");
>  			rc = 1;
>  		} else {
> -			audit_log_format(ab, " obj=%s", ctx);
> -			lsmcontext_init(&lsmcxt, ctx, len, 0); /*scaffolding*/
> -			security_release_secctx(&lsmcxt);
> +			audit_log_format(ab, " obj=%s", lsmctx.context);
> +			security_release_secctx(&lsmctx);
>  		}
>  	}
>  	audit_log_format(ab, " ocomm=");
> @@ -1174,7 +1171,6 @@ static void audit_log_fcaps(struct audit_buffer *ab, struct audit_names *name)
>  
>  static void show_special(struct audit_context *context, int *call_panic)
>  {
> -	struct lsmcontext lsmcxt;
>  	struct audit_buffer *ab;
>  	int i;
>  
> @@ -1198,17 +1194,15 @@ static void show_special(struct audit_context *context, int *call_panic)
>  				 from_kgid(&init_user_ns, context->ipc.gid),
>  				 context->ipc.mode);
>  		if (osid) {
> -			char *ctx = NULL;
> -			u32 len;
> +			struct lsmcontext lsmcxt;
>  			struct lsmblob blob;
>  
>  			lsmblob_init(&blob, osid);
> -			if (security_secid_to_secctx(&blob, &ctx, &len)) {
> +			if (security_secid_to_secctx(&blob, &lsmcxt)) {
>  				audit_log_format(ab, " osid=%u", osid);
>  				*call_panic = 1;
>  			} else {
> -				audit_log_format(ab, " obj=%s", ctx);
> -				lsmcontext_init(&lsmcxt, ctx, len, 0);
> +				audit_log_format(ab, " obj=%s", lsmcxt.context);
>  				security_release_secctx(&lsmcxt);
>  			}
>  		}
> @@ -1353,20 +1347,17 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
>  				 MAJOR(n->rdev),
>  				 MINOR(n->rdev));
>  	if (n->osid != 0) {
> -		char *ctx = NULL;
> -		u32 len;
>  		struct lsmblob blob;
> -		struct lsmcontext lsmcxt;
> +		struct lsmcontext lsmctx;
>  
>  		lsmblob_init(&blob, n->osid);
> -		if (security_secid_to_secctx(&blob, &ctx, &len)) {
> +		if (security_secid_to_secctx(&blob, &lsmctx)) {
>  			audit_log_format(ab, " osid=%u", n->osid);
>  			if (call_panic)
>  				*call_panic = 2;
>  		} else {
> -			audit_log_format(ab, " obj=%s", ctx);
> -			lsmcontext_init(&lsmcxt, ctx, len, 0); /* scaffolding */
> -			security_release_secctx(&lsmcxt);
> +			audit_log_format(ab, " obj=%s", lsmctx.context);
> +			security_release_secctx(&lsmctx);
>  		}
>  	}
>  
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index 7834c357b60b..80ae0c5a1301 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -132,20 +132,17 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
>  {
>  	struct lsmcontext context;
>  	struct lsmblob lb;
> -	char *secdata;
> -	u32 seclen;
>  	int err;
>  
>  	err = security_socket_getpeersec_dgram(NULL, skb, &lb);
>  	if (err)
>  		return;
>  
> -	err = security_secid_to_secctx(&lb, &secdata, &seclen);
> +	err = security_secid_to_secctx(&lb, &context);
>  	if (err)
>  		return;
>  
> -	put_cmsg(msg, SOL_IP, SCM_SECURITY, seclen, secdata);
> -	lsmcontext_init(&context, secdata, seclen, 0); /* scaffolding */
> +	put_cmsg(msg, SOL_IP, SCM_SECURITY, context.len, context.context);
>  	security_release_secctx(&context);
>  }
>  
> diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
> index 6954e6600583..403307ff0fff 100644
> --- a/net/netfilter/nf_conntrack_netlink.c
> +++ b/net/netfilter/nf_conntrack_netlink.c
> @@ -328,13 +328,12 @@ static int ctnetlink_dump_mark(struct sk_buff *skb, const struct nf_conn *ct)
>  static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
>  {
>  	struct nlattr *nest_secctx;
> -	int len, ret;
> -	char *secctx;
> +	int ret;
>  	struct lsmblob blob;
>  	struct lsmcontext context;
>  
>  	lsmblob_init(&blob, ct->secmark);
> -	ret = security_secid_to_secctx(&blob, &secctx, &len);
> +	ret = security_secid_to_secctx(&blob, &context);
>  	if (ret)
>  		return 0;
>  
> @@ -343,13 +342,12 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
>  	if (!nest_secctx)
>  		goto nla_put_failure;
>  
> -	if (nla_put_string(skb, CTA_SECCTX_NAME, secctx))
> +	if (nla_put_string(skb, CTA_SECCTX_NAME, context.context))
>  		goto nla_put_failure;
>  	nla_nest_end(skb, nest_secctx);
>  
>  	ret = 0;
>  nla_put_failure:
> -	lsmcontext_init(&context, secctx, len, 0); /* scaffolding */
>  	security_release_secctx(&context);
>  	return ret;
>  }
> @@ -620,12 +618,16 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
>  #ifdef CONFIG_NF_CONNTRACK_SECMARK
>  	int len, ret;
>  	struct lsmblob blob;
> +	struct lsmcontext context;
>  
>  	lsmblob_init(&blob, ct->secmark);
> -	ret = security_secid_to_secctx(&blob, NULL, &len);
> +	ret = security_secid_to_secctx(&blob, &context);
>  	if (ret)
>  		return 0;
>  
> +	len = context.len;
> +	security_release_secctx(&context);
> +
>  	return nla_total_size(0) /* CTA_SECCTX */
>  	       + nla_total_size(sizeof(char) * len); /* CTA_SECCTX_NAME */
>  #else
> diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
> index 79158ad0486e..fcb51ab2bb8b 100644
> --- a/net/netfilter/nf_conntrack_standalone.c
> +++ b/net/netfilter/nf_conntrack_standalone.c
> @@ -173,19 +173,16 @@ static void ct_seq_stop(struct seq_file *s, void *v)
>  static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
>  {
>  	int ret;
> -	u32 len;
> -	char *secctx;
>  	struct lsmblob blob;
>  	struct lsmcontext context;
>  
>  	lsmblob_init(&blob, ct->secmark);
> -	ret = security_secid_to_secctx(&blob, &secctx, &len);
> +	ret = security_secid_to_secctx(&blob, &context);
>  	if (ret)
>  		return;
>  
> -	seq_printf(s, "secctx=%s ", secctx);
> +	seq_printf(s, "secctx=%s ", context.context);
>  
> -	lsmcontext_init(&context, secctx, len, 0); /* scaffolding */
>  	security_release_secctx(&context);
>  }
>  #else
> diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
> index fe8403ef4e89..6da00c7add5b 100644
> --- a/net/netfilter/nfnetlink_queue.c
> +++ b/net/netfilter/nfnetlink_queue.c
> @@ -310,6 +310,7 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
>  	u32 seclen = 0;
>  #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
>  	struct lsmblob blob;
> +	struct lsmcontext context;
>  
>  	if (!skb || !sk_fullsock(skb->sk))
>  		return 0;
> @@ -318,10 +319,12 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
>  
>  	if (skb->secmark) {
>  		lsmblob_init(&blob, skb->secmark);
> -		security_secid_to_secctx(&blob, secdata, &seclen);
> +		security_secid_to_secctx(&blob, &context);
> +		*secdata = context.context;
>  	}
>  
>  	read_unlock_bh(&skb->sk->sk_callback_lock);
> +	seclen = context.len;
>  #endif
>  	return seclen;
>  }
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index 15b1945853be..4716e0011ba5 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -388,8 +388,6 @@ int netlbl_unlhsh_add(struct net *net,
>  	struct netlbl_unlhsh_iface *iface;
>  	struct audit_buffer *audit_buf = NULL;
>  	struct lsmcontext context;
> -	char *secctx = NULL;
> -	u32 secctx_len;
>  	struct lsmblob blob;
>  
>  	if (addr_len != sizeof(struct in_addr) &&
> @@ -454,12 +452,9 @@ int netlbl_unlhsh_add(struct net *net,
>  	rcu_read_unlock();
>  	if (audit_buf != NULL) {
>  		lsmblob_init(&blob, secid);
> -		if (security_secid_to_secctx(&blob,
> -					     &secctx,
> -					     &secctx_len) == 0) {
> -			audit_log_format(audit_buf, " sec_obj=%s", secctx);
> -			/* scaffolding */
> -			lsmcontext_init(&context, secctx, secctx_len, 0);
> +		if (security_secid_to_secctx(&blob, &context) == 0) {
> +			audit_log_format(audit_buf, " sec_obj=%s",
> +					 context.context);
>  			security_release_secctx(&context);
>  		}
>  		audit_log_format(audit_buf, " res=%u", ret_val == 0 ? 1 : 0);
> @@ -492,8 +487,6 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>  	struct audit_buffer *audit_buf;
>  	struct net_device *dev;
>  	struct lsmcontext context;
> -	char *secctx;
> -	u32 secctx_len;
>  	struct lsmblob blob;
>  
>  	spin_lock(&netlbl_unlhsh_lock);
> @@ -517,11 +510,9 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>  		if (entry != NULL)
>  			lsmblob_init(&blob, entry->secid);
>  		if (entry != NULL &&
> -		    security_secid_to_secctx(&blob,
> -					     &secctx, &secctx_len) == 0) {
> -			audit_log_format(audit_buf, " sec_obj=%s", secctx);
> -			/* scaffolding */
> -			lsmcontext_init(&context, secctx, secctx_len, 0);
> +		    security_secid_to_secctx(&blob, &context) == 0) {
> +			audit_log_format(audit_buf, " sec_obj=%s",
> +					 context.context);
>  			security_release_secctx(&context);
>  		}
>  		audit_log_format(audit_buf, " res=%u", entry != NULL ? 1 : 0);
> @@ -560,8 +551,6 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>  	struct audit_buffer *audit_buf;
>  	struct net_device *dev;
>  	struct lsmcontext context;
> -	char *secctx;
> -	u32 secctx_len;
>  	struct lsmblob blob;
>  
>  	spin_lock(&netlbl_unlhsh_lock);
> @@ -584,10 +573,9 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>  		if (entry != NULL)
>  			lsmblob_init(&blob, entry->secid);
>  		if (entry != NULL &&
> -		    security_secid_to_secctx(&blob,
> -					     &secctx, &secctx_len) == 0) {
> -			audit_log_format(audit_buf, " sec_obj=%s", secctx);
> -			lsmcontext_init(&context, secctx, secctx_len, 0);
> +		    security_secid_to_secctx(&blob, &context) == 0) {
> +			audit_log_format(audit_buf, " sec_obj=%s",
> +					 context.context);
>  			security_release_secctx(&context);
>  		}
>  		audit_log_format(audit_buf, " res=%u", entry != NULL ? 1 : 0);
> @@ -1105,8 +1093,6 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>  	struct lsmcontext context;
>  	void *data;
>  	u32 secid;
> -	char *secctx;
> -	u32 secctx_len;
>  	struct lsmblob blob;
>  
>  	data = genlmsg_put(cb_arg->skb, NETLINK_CB(cb_arg->nl_cb->skb).portid,
> @@ -1163,15 +1149,13 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>  	}
>  
>  	lsmblob_init(&blob, secid);
> -	ret_val = security_secid_to_secctx(&blob, &secctx, &secctx_len);
> +	ret_val = security_secid_to_secctx(&blob, &context);
>  	if (ret_val != 0)
>  		goto list_cb_failure;
>  	ret_val = nla_put(cb_arg->skb,
>  			  NLBL_UNLABEL_A_SECCTX,
> -			  secctx_len,
> -			  secctx);
> -	/* scaffolding */
> -	lsmcontext_init(&context, secctx, secctx_len, 0);
> +			  context.len,
> +			  context.context);
>  	security_release_secctx(&context);
>  	if (ret_val != 0)
>  		goto list_cb_failure;
> diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
> index 94aea4985b74..2d1307f65250 100644
> --- a/net/netlabel/netlabel_user.c
> +++ b/net/netlabel/netlabel_user.c
> @@ -99,8 +99,6 @@ struct audit_buffer *netlbl_audit_start_common(int type,
>  {
>  	struct audit_buffer *audit_buf;
>  	struct lsmcontext context;
> -	char *secctx;
> -	u32 secctx_len;
>  	struct lsmblob blob;
>  
>  	if (audit_enabled == AUDIT_OFF)
> @@ -116,9 +114,8 @@ struct audit_buffer *netlbl_audit_start_common(int type,
>  
>  	lsmblob_init(&blob, audit_info->secid);
>  	if (audit_info->secid != 0 &&
> -	    security_secid_to_secctx(&blob, &secctx, &secctx_len) == 0) {
> -		audit_log_format(audit_buf, " subj=%s", secctx);
> -		lsmcontext_init(&context, secctx, secctx_len, 0);/*scaffolding*/
> +	    security_secid_to_secctx(&blob, &context) == 0) {
> +		audit_log_format(audit_buf, " subj=%s", context.context);
>  		security_release_secctx(&context);
>  	}
>  
> diff --git a/security/security.c b/security/security.c
> index 3563b1e2f8f9..97b468f6e6a9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2081,7 +2081,7 @@ int security_ismaclabel(const char *name)
>  }
>  EXPORT_SYMBOL(security_ismaclabel);
>  
> -int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
> +int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp)
>  {
>  	struct security_hook_list *hp;
>  	int *display = current->security;
> @@ -2089,10 +2089,13 @@ int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
>  	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
>  		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>  			continue;
> -		if (*display == LSMBLOB_INVALID || *display == hp->lsmid->slot)
> +		if (*display == LSMBLOB_INVALID ||
> +		    *display == hp->lsmid->slot) {
> +			cp->slot = hp->lsmid->slot;
>  			return hp->hook.secid_to_secctx(
>  					blob->secid[hp->lsmid->slot],
> -					secdata, seclen);
> +					&cp->context, &cp->len);
> +		}
>  	}
>  	return 0;
>  }
> -- 
> 2.20.1
> 

-- 
Kees Cook
