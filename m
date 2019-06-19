Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9699C31E49
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 05:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A63D2084A
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 05:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kkU3k+va"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbfFSFgm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:36:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46529 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730428AbfFSFgm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 01:36:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so6691217pls.13
        for <selinux@vger.kernel.org>; Tue, 18 Jun 2019 22:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8fSz6MrYFJIOOb/OEz2mNheetYH6xjbCa6bjk2EtkjE=;
        b=kkU3k+vaCCVZQ6aC+8AiGYOcP8X+gtDQ4Zjz1S90qLT4VDelC2cm0OkuMl1Nkv/f4d
         qyYJPrb+ZdPNITryVIUS/we2Xj0+8s6dWrsU8Gd/3RS28MtKQpOl5Dv8mH6rBTN7QiTQ
         v2thdtZxEz6TiEUvcjd7JVa16usJMxWSQ4oBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8fSz6MrYFJIOOb/OEz2mNheetYH6xjbCa6bjk2EtkjE=;
        b=WD6K17JuLsXj7lwCioNrvW0YFClOQanLPKwOkFy3EhS0ZkcAeRYrqk0zQRNppMbii6
         9N4XDdbFUoxqToibAqHxx6Pr4E0b8+dB36W8Fmh4LU80xT48URl+b4Q/WC/sQmw1wv8B
         8AYUC7nkMjiUnW8xrgDuIXz/PuxEV5je9U2K8iJ/SibWpRHs0ssPbbxcGEvNAcBtGbtl
         1mtELHRmQz8EXvrzw7g8g9m6Mfda72TxkPLrC7hxdlZ+xwXmvSYfKOwS/UkiXpEjxs+5
         wRroFBVlPhnziBQ9i6TBjLiawNfEvQ7KIMgy8Lzrm8HkdlegrZVzeSvJVwXqI1wyF8GD
         hj4w==
X-Gm-Message-State: APjAAAUoN4rwBMd0Qpp5rGBB1FUslK1Bz1zgNQbNvYlR8H2qGJ2ASTaa
        ko9oZl+IG5ZQQNQKZr50eBIp/w==
X-Google-Smtp-Source: APXvYqyv9coyIao6fDVGWM1l75yQgZSI/jUtxEWUycVt9YuJ0s778GwY4wEdlyqMvOyS4ttfXMSPew==
X-Received: by 2002:a17:902:205:: with SMTP id 5mr109773894plc.165.1560922601000;
        Tue, 18 Jun 2019 22:36:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ci15sm538918pjb.12.2019.06.18.22.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 22:36:40 -0700 (PDT)
Date:   Tue, 18 Jun 2019 22:36:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v2 17/25] LSM: Use lsmcontext in security_secid_to_secctx
Message-ID: <201906182236.55051A1@keescook>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
 <20190618230551.7475-18-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618230551.7475-18-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 18, 2019 at 04:05:43PM -0700, Casey Schaufler wrote:
> Replace the (secctx,seclen) pointer pair with a single
> lsmcontext pointer to allow return of the LSM identifier
> along with the context and context length. This allows
> security_release_secctx() to know how to release the
> context. Callers have been modified to use or save the
> returned data from the new structure.

I like these because they're obviously sensible changes: swap two args
for one. :)

-Kees

> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  drivers/android/binder.c                | 24 ++++++---------
>  include/linux/security.h                |  4 +--
>  include/net/scm.h                       |  8 ++---
>  kernel/audit.c                          | 29 +++++++-----------
>  kernel/auditsc.c                        | 31 +++++++------------
>  net/ipv4/ip_sockglue.c                  |  7 ++---
>  net/netfilter/nf_conntrack_netlink.c    | 14 +++++----
>  net/netfilter/nf_conntrack_standalone.c |  7 ++---
>  net/netfilter/nfnetlink_queue.c         |  5 +++-
>  net/netlabel/netlabel_unlabeled.c       | 40 ++++++++-----------------
>  net/netlabel/netlabel_user.c            |  7 ++---
>  security/security.c                     |  9 +++---
>  12 files changed, 71 insertions(+), 114 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index f11b5ca5bc30..aad7cdc8137f 100644
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
>  		struct lsmblob le;
>  
>  		security_task_getsecid(proc->tsk, &le);
> -		ret = security_secid_to_secctx(&le, &secctx, &secctx_sz);
> +		ret = security_secid_to_secctx(&le, &lsmctx);
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
> index 8bd4f28ef532..1fd87e80656f 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -475,7 +475,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>  			 size_t size);
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>  int security_ismaclabel(const char *name);
> -int security_secid_to_secctx(struct lsmblob *l, char **secdata, u32 *seclen);
> +int security_secid_to_secctx(struct lsmblob *l, struct lsmcontext *cp);
>  int security_secctx_to_secid(const char *secdata, u32 seclen,
>  			     struct lsmblob *l);
>  void security_release_secctx(struct lsmcontext *cp);
> @@ -1257,7 +1257,7 @@ static inline int security_ismaclabel(const char *name)
>  }
>  
>  static inline int security_secid_to_secctx(struct lsmblob *l,
> -					   char **secdata, u32 *seclen)
> +					   struct lsmcontext *cp)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/include/net/scm.h b/include/net/scm.h
> index d3e0ac961a11..4a6ad8caf423 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -93,16 +93,14 @@ static __inline__ int scm_send(struct socket *sock, struct msghdr *msg,
>  static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
>  {
>  	struct lsmcontext context;
> -	char *secdata;
> -	u32 seclen;
>  	int err;
>  
>  	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
> -		err = security_secid_to_secctx(&scm->lsmblob, &secdata, &seclen);
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
> index 0467b2d284fa..33a08f49b52e 100644
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
>  	struct lsmblob le;
> -	struct lsmcontext scaff; /* scaffolding */
> +	struct lsmcontext context;
>  
>  	security_task_getsecid(current, &le);
>  	if (!lsmblob_is_set(&le))
>  		return 0;
>  
> -	error = security_secid_to_secctx(&le, &ctx, &len);
> +	error = security_secid_to_secctx(&le, &context);
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
> index 917e7550767a..847c1d59212d 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -942,9 +942,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>  				 struct lsmblob *l, char *comm)
>  {
>  	struct audit_buffer *ab;
> -	struct lsmcontext lsmcxt;
> -	char *ctx = NULL;
> -	u32 len;
> +	struct lsmcontext lsmctx;
>  	int rc = 0;
>  
>  	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
> @@ -955,13 +953,12 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>  			 from_kuid(&init_user_ns, auid),
>  			 from_kuid(&init_user_ns, uid), sessionid);
>  	if (lsmblob_is_set(l)) {
> -		if (security_secid_to_secctx(l, &ctx, &len)) {
> +		if (security_secid_to_secctx(l, &lsmctx)) {
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
> @@ -1173,7 +1170,6 @@ static void audit_log_fcaps(struct audit_buffer *ab, struct audit_names *name)
>  
>  static void show_special(struct audit_context *context, int *call_panic)
>  {
> -	struct lsmcontext lsmcxt;
>  	struct audit_buffer *ab;
>  	int i;
>  
> @@ -1197,16 +1193,14 @@ static void show_special(struct audit_context *context, int *call_panic)
>  				 from_kgid(&init_user_ns, context->ipc.gid),
>  				 context->ipc.mode);
>  		if (osid) {
> -			char *ctx = NULL;
> -			u32 len;
> +			struct lsmcontext lsmcxt;
>  			struct lsmblob le;
>  			lsmblob_init(&le, osid);
> -			if (security_secid_to_secctx(&le, &ctx, &len)) {
> +			if (security_secid_to_secctx(&le, &lsmcxt)) {
>  				audit_log_format(ab, " osid=%u", osid);
>  				*call_panic = 1;
>  			} else {
> -				audit_log_format(ab, " obj=%s", ctx);
> -				lsmcontext_init(&lsmcxt, ctx, len, 0);
> +				audit_log_format(ab, " obj=%s", lsmcxt.context);
>  				security_release_secctx(&lsmcxt);
>  			}
>  		}
> @@ -1351,20 +1345,17 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
>  				 MAJOR(n->rdev),
>  				 MINOR(n->rdev));
>  	if (n->osid != 0) {
> -		char *ctx = NULL;
> -		u32 len;
>  		struct lsmblob le;
> -		struct lsmcontext lsmcxt;
> +		struct lsmcontext lsmctx;
>  
>  		lsmblob_init(&le, n->osid);
> -		if (security_secid_to_secctx(&le, &ctx, &len)) {
> +		if (security_secid_to_secctx(&le, &lsmctx)) {
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
> index 93f308b5845d..8d9943b925d7 100644
> --- a/net/netfilter/nf_conntrack_netlink.c
> +++ b/net/netfilter/nf_conntrack_netlink.c
> @@ -328,13 +328,12 @@ static int ctnetlink_dump_mark(struct sk_buff *skb, const struct nf_conn *ct)
>  static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
>  {
>  	struct nlattr *nest_secctx;
> -	int len, ret;
> -	char *secctx;
> +	int ret;
>  	struct lsmblob le;
>  	struct lsmcontext context;
>  
>  	lsmblob_init(&le, ct->secmark);
> -	ret = security_secid_to_secctx(&le, &secctx, &len);
> +	ret = security_secid_to_secctx(&le, &context);
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
>  	struct lsmblob le;
> +	struct lsmcontext context;
>  
>  	lsmblob_init(&le, ct->secmark);
> -	ret = security_secid_to_secctx(&le, NULL, &len);
> +	ret = security_secid_to_secctx(&le, &context);
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
> index 0bde6a4426e3..3085a090af7a 100644
> --- a/net/netfilter/nf_conntrack_standalone.c
> +++ b/net/netfilter/nf_conntrack_standalone.c
> @@ -173,19 +173,16 @@ static void ct_seq_stop(struct seq_file *s, void *v)
>  static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
>  {
>  	int ret;
> -	u32 len;
> -	char *secctx;
>  	struct lsmblob le;
>  	struct lsmcontext context;
>  
>  	lsmblob_init(&le, ct->secmark);
> -	ret = security_secid_to_secctx(&le, &secctx, &len);
> +	ret = security_secid_to_secctx(&le, &context);
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
> index ba767bdd1a9a..60948538711b 100644
> --- a/net/netfilter/nfnetlink_queue.c
> +++ b/net/netfilter/nfnetlink_queue.c
> @@ -310,6 +310,7 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
>  	u32 seclen = 0;
>  #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
>  	struct lsmblob le;
> +	struct lsmcontext context;
>  
>  	if (!skb || !sk_fullsock(skb->sk))
>  		return 0;
> @@ -318,10 +319,12 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
>  
>  	if (skb->secmark) {
>  		lsmblob_init(&le, skb->secmark);
> -		security_secid_to_secctx(&le, secdata, &seclen);
> +		security_secid_to_secctx(&le, &context);
> +		*secdata = context.context;
>  	}
>  
>  	read_unlock_bh(&skb->sk->sk_callback_lock);
> +	seclen = context.len;
>  #endif
>  	return seclen;
>  }
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index 2f8c7415b6ff..35e7d595f2b9 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -388,8 +388,6 @@ int netlbl_unlhsh_add(struct net *net,
>  	struct netlbl_unlhsh_iface *iface;
>  	struct audit_buffer *audit_buf = NULL;
>  	struct lsmcontext context;
> -	char *secctx = NULL;
> -	u32 secctx_len;
>  	struct lsmblob le;
>  
>  	if (addr_len != sizeof(struct in_addr) &&
> @@ -454,12 +452,9 @@ int netlbl_unlhsh_add(struct net *net,
>  	rcu_read_unlock();
>  	if (audit_buf != NULL) {
>  		lsmblob_init(&le, secid);
> -		if (security_secid_to_secctx(&le,
> -					     &secctx,
> -					     &secctx_len) == 0) {
> -			audit_log_format(audit_buf, " sec_obj=%s", secctx);
> -			/* scaffolding */
> -			lsmcontext_init(&context, secctx, secctx_len, 0);
> +		if (security_secid_to_secctx(&le, &context) == 0) {
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
>  	struct lsmblob le;
>  
>  	spin_lock(&netlbl_unlhsh_lock);
> @@ -517,11 +510,9 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>  		if (entry != NULL)
>  			lsmblob_init(&le, entry->secid);
>  		if (entry != NULL &&
> -		    security_secid_to_secctx(&le,
> -					     &secctx, &secctx_len) == 0) {
> -			audit_log_format(audit_buf, " sec_obj=%s", secctx);
> -			/* scaffolding */
> -			lsmcontext_init(&context, secctx, secctx_len, 0);
> +		    security_secid_to_secctx(&le, &context) == 0) {
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
>  	struct lsmblob le;
>  
>  	spin_lock(&netlbl_unlhsh_lock);
> @@ -584,10 +573,9 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>  		if (entry != NULL)
>  			lsmblob_init(&le, entry->secid);
>  		if (entry != NULL &&
> -		    security_secid_to_secctx(&le,
> -					     &secctx, &secctx_len) == 0) {
> -			audit_log_format(audit_buf, " sec_obj=%s", secctx);
> -			lsmcontext_init(&context, secctx, secctx_len, 0);
> +		    security_secid_to_secctx(&le, &context) == 0) {
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
>  	struct lsmblob le;
>  
>  	data = genlmsg_put(cb_arg->skb, NETLINK_CB(cb_arg->nl_cb->skb).portid,
> @@ -1163,15 +1149,13 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>  	}
>  
>  	lsmblob_init(&le, secid);
> -	ret_val = security_secid_to_secctx(&le, &secctx, &secctx_len);
> +	ret_val = security_secid_to_secctx(&le, &context);
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
> index fba861c4ffbb..52d1ea2bd605 100644
> --- a/net/netlabel/netlabel_user.c
> +++ b/net/netlabel/netlabel_user.c
> @@ -99,8 +99,6 @@ struct audit_buffer *netlbl_audit_start_common(int type,
>  {
>  	struct audit_buffer *audit_buf;
>  	struct lsmcontext context;
> -	char *secctx;
> -	u32 secctx_len;
>  	struct lsmblob le;
>  
>  	if (audit_enabled == AUDIT_OFF)
> @@ -116,9 +114,8 @@ struct audit_buffer *netlbl_audit_start_common(int type,
>  
>  	lsmblob_init(&le, audit_info->secid);
>  	if (audit_info->secid != 0 &&
> -	    security_secid_to_secctx(&le, &secctx, &secctx_len) == 0) {
> -		audit_log_format(audit_buf, " subj=%s", secctx);
> -		lsmcontext_init(&context, secctx, secctx_len, 0);/*scaffolding*/
> +	    security_secid_to_secctx(&le, &context) == 0) {
> +		audit_log_format(audit_buf, " subj=%s", context.context);
>  		security_release_secctx(&context);
>  	}
>  
> diff --git a/security/security.c b/security/security.c
> index d25c099b46d1..2ea810fc4a45 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -457,7 +457,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  		    hooks[i].head ==
>  			&security_hook_heads.socket_getpeersec_dgram ||
>  		    hooks[i].head == &security_hook_heads.secctx_to_secid ||
> -		    hooks[i].head == &security_hook_heads.secid_to_secctx ||
>  		    hooks[i].head == &security_hook_heads.release_secctx ||
>  		    hooks[i].head == &security_hook_heads.ipc_getsecid ||
>  		    hooks[i].head == &security_hook_heads.task_getsecid ||
> @@ -2057,15 +2056,17 @@ int security_ismaclabel(const char *name)
>  }
>  EXPORT_SYMBOL(security_ismaclabel);
>  
> -int security_secid_to_secctx(struct lsmblob *l, char **secdata, u32 *seclen)
> +int security_secid_to_secctx(struct lsmblob *l, struct lsmcontext *cp)
>  {
>  	int *display = current->security;
>  	struct security_hook_list *hp;
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list)
> -		if (*display == LSMDATA_INVALID || *display == hp->slot)
> +		if (*display == LSMDATA_INVALID || *display == hp->slot) {
> +			cp->slot = hp->slot;
>  			return hp->hook.secid_to_secctx(l->secid[hp->slot],
> -							secdata, seclen);
> +							&cp->context, &cp->len);
> +		}
>  	return 0;
>  }
>  EXPORT_SYMBOL(security_secid_to_secctx);
> -- 
> 2.20.1
> 

-- 
Kees Cook
