Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50A5C31E49
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 05:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730F7208CB
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 05:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YwydX0pm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbfFSFDJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:03:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45761 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfFSFDJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 01:03:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id r1so8983595pfq.12
        for <selinux@vger.kernel.org>; Tue, 18 Jun 2019 22:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=knTgEv4tFZxUgNwSuCiTCF3ieRAAJ44+izr+/XqK5jg=;
        b=YwydX0pmHeiy5E8GtX4j66sMzoBoaiFsNyhoeLZnW0hig6mzN0GmykSDQbeBAVMC7m
         WqvnCWy7JX3s3aSPftsXoC1eSWmla7pGNk0E7pcDkkF4kOpZil5H/WFdkdrRmIKKElM4
         pTswaukOKR3kbUDaE9p6iKEuKJ7nh9uedQqss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=knTgEv4tFZxUgNwSuCiTCF3ieRAAJ44+izr+/XqK5jg=;
        b=smxtwTrXHzXoiKldMZ7X6iolv9CtQE+0iexVEmBVy+/i9tjIUcRLfjBkLDTLBCkV7y
         mfwX5ymuB3qD6bWhH/B3D4qIuGDUYTLVprbAQuVYGR/6lYVSs1Ov9vG6jTaEFMAA3KcW
         Xx7ox6aNQl9edRScQ8bsUPJGUe2dT7pdCDy1U8HW+j0JwhZQmgyVMqb/QjKdU2mdI6Iz
         vvXf12Qu1mWnQ6Tv8ZY+Doys1sMh5Sxdp9pcHeIUETSVZPWSbO1y0xdWYcbChf7sr6Zl
         3stRuAJ2RE4K1/IW/l2Z1gcwua4hDAoXJRdqQeTvrHGrB50ulkQ05bsI+DW9PJgNMiTT
         C6Jg==
X-Gm-Message-State: APjAAAV842OrwuDL5G0oToF6P6UExrnkWsBisVNCUl5BNJkBFzBYK3Br
        k+GDTQ1M6tqczhIa7S97DnfbFA==
X-Google-Smtp-Source: APXvYqyNwIb4aDyjym3mb/8eXLdL5hbnaPsveVZ1tnGvvZs1BfcqFt03a7iCAb1yucavD/q7S84KHQ==
X-Received: by 2002:aa7:804c:: with SMTP id y12mr121198388pfm.94.1560920588756;
        Tue, 18 Jun 2019 22:03:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x3sm469972pja.7.2019.06.18.22.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 22:03:07 -0700 (PDT)
Date:   Tue, 18 Jun 2019 22:03:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v2 09/25] LSM: Use lsmblob in security_secid_to_secctx
Message-ID: <201906182202.B85CFA6@keescook>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
 <20190618230551.7475-10-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618230551.7475-10-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 18, 2019 at 04:05:35PM -0700, Casey Schaufler wrote:
> Change security_secid_to_secctx() to take a lsmblob as input
> instead of a u32 secid. It will then call the LSM hooks
> using the lsmblob element allocated for that module. The
> callers have been updated as well. This allows for the
> possibility that more than one module may called upon
> to translate a secid to a string, as can occur in the
> audit code.

Cool. The progression of scaffolding here is pretty clear to me.

-Kees

> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  drivers/android/binder.c                |  4 +++-
>  include/linux/security.h                |  5 +++--
>  include/net/scm.h                       |  4 +---
>  kernel/audit.c                          |  9 +++++++--
>  kernel/auditsc.c                        | 13 +++++++++----
>  net/ipv4/ip_sockglue.c                  |  3 +--
>  net/netfilter/nf_conntrack_netlink.c    |  8 ++++++--
>  net/netfilter/nf_conntrack_standalone.c |  4 +++-
>  net/netfilter/nfnetlink_queue.c         |  8 ++++++--
>  net/netlabel/netlabel_unlabeled.c       | 18 ++++++++++++++----
>  net/netlabel/netlabel_user.c            |  6 +++---
>  security/security.c                     | 14 +++++++++++---
>  12 files changed, 67 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 8685882da64c..a3204fbc1f28 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3120,9 +3120,11 @@ static void binder_transaction(struct binder_proc *proc,
>  
>  	if (target_node && target_node->txn_security_ctx) {
>  		u32 secid;
> +		struct lsmblob le;
>  
>  		security_task_getsecid(proc->tsk, &secid);
> -		ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
> +		lsmblob_init(&le, secid);
> +		ret = security_secid_to_secctx(&le, &secctx, &secctx_sz);
>  		if (ret) {
>  			return_error = BR_FAILED_REPLY;
>  			return_error_param = ret;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index dcaaa63b79b3..c9ed83e57a97 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -442,7 +442,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>  			 size_t size);
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>  int security_ismaclabel(const char *name);
> -int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
> +int security_secid_to_secctx(struct lsmblob *l, char **secdata, u32 *seclen);
>  int security_secctx_to_secid(const char *secdata, u32 seclen,
>  			     struct lsmblob *l);
>  void security_release_secctx(char *secdata, u32 seclen);
> @@ -1220,7 +1220,8 @@ static inline int security_ismaclabel(const char *name)
>  	return 0;
>  }
>  
> -static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
> +static inline int security_secid_to_secctx(struct lsmblob *l,
> +					   char **secdata, u32 *seclen)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/include/net/scm.h b/include/net/scm.h
> index c87a17101c86..bcb0f8560cdf 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -97,9 +97,7 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
>  	int err;
>  
>  	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
> -		/* Scaffolding - it has to be element 1 for now */
> -		err = security_secid_to_secctx(scm->lsmblob.secid[1],
> -					       &secdata, &seclen);
> +		err = security_secid_to_secctx(&scm->lsmblob, &secdata, &seclen);
>  
>  		if (!err) {
>  			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
> diff --git a/kernel/audit.c b/kernel/audit.c
> index c89ea48c70a6..5efd78ced915 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1430,7 +1430,10 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>  	case AUDIT_SIGNAL_INFO:
>  		len = 0;
>  		if (audit_sig_sid) {
> -			err = security_secid_to_secctx(audit_sig_sid, &ctx, &len);
> +			struct lsmblob le;
> +
> +			lsmblob_init(&le, audit_sig_sid);
> +			err = security_secid_to_secctx(&le, &ctx, &len);
>  			if (err)
>  				return err;
>  		}
> @@ -2073,12 +2076,14 @@ int audit_log_task_context(struct audit_buffer *ab)
>  	unsigned len;
>  	int error;
>  	u32 sid;
> +	struct lsmblob le;
>  
>  	security_task_getsecid(current, &sid);
>  	if (!sid)
>  		return 0;
>  
> -	error = security_secid_to_secctx(sid, &ctx, &len);
> +	lsmblob_init(&le, sid);
> +	error = security_secid_to_secctx(&le, &ctx, &len);
>  	if (error) {
>  		if (error != -EINVAL)
>  			goto error_path;
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 93c74205ef40..67d3f71a095a 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -946,6 +946,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>  	char *ctx = NULL;
>  	u32 len;
>  	int rc = 0;
> +	struct lsmblob le;
>  
>  	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
>  	if (!ab)
> @@ -955,7 +956,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>  			 from_kuid(&init_user_ns, auid),
>  			 from_kuid(&init_user_ns, uid), sessionid);
>  	if (sid) {
> -		if (security_secid_to_secctx(sid, &ctx, &len)) {
> +		lsmblob_init(&le, sid);
> +		if (security_secid_to_secctx(&le, &ctx, &len)) {
>  			audit_log_format(ab, " obj=(none)");
>  			rc = 1;
>  		} else {
> @@ -1197,7 +1199,9 @@ static void show_special(struct audit_context *context, int *call_panic)
>  		if (osid) {
>  			char *ctx = NULL;
>  			u32 len;
> -			if (security_secid_to_secctx(osid, &ctx, &len)) {
> +			struct lsmblob le;
> +			lsmblob_init(&le, osid);
> +			if (security_secid_to_secctx(&le, &ctx, &len)) {
>  				audit_log_format(ab, " osid=%u", osid);
>  				*call_panic = 1;
>  			} else {
> @@ -1348,9 +1352,10 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
>  	if (n->osid != 0) {
>  		char *ctx = NULL;
>  		u32 len;
> +		struct lsmblob le;
>  
> -		if (security_secid_to_secctx(
> -			n->osid, &ctx, &len)) {
> +		lsmblob_init(&le, n->osid);
> +		if (security_secid_to_secctx(&le, &ctx, &len)) {
>  			audit_log_format(ab, " osid=%u", n->osid);
>  			if (call_panic)
>  				*call_panic = 2;
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index fbe2147ee595..e05f4ef68bd8 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -139,8 +139,7 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
>  	if (err)
>  		return;
>  
> -	/* Scaffolding - it has to be element 1 */
> -	err = security_secid_to_secctx(lb.secid[1], &secdata, &seclen);
> +	err = security_secid_to_secctx(&lb, &secdata, &seclen);
>  	if (err)
>  		return;
>  
> diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
> index 66c596d287a5..6098b586da07 100644
> --- a/net/netfilter/nf_conntrack_netlink.c
> +++ b/net/netfilter/nf_conntrack_netlink.c
> @@ -330,8 +330,10 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
>  	struct nlattr *nest_secctx;
>  	int len, ret;
>  	char *secctx;
> +	struct lsmblob le;
>  
> -	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
> +	lsmblob_init(&le, ct->secmark);
> +	ret = security_secid_to_secctx(&le, &secctx, &len);
>  	if (ret)
>  		return 0;
>  
> @@ -615,8 +617,10 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
>  {
>  #ifdef CONFIG_NF_CONNTRACK_SECMARK
>  	int len, ret;
> +	struct lsmblob le;
>  
> -	ret = security_secid_to_secctx(ct->secmark, NULL, &len);
> +	lsmblob_init(&le, ct->secmark);
> +	ret = security_secid_to_secctx(&le, NULL, &len);
>  	if (ret)
>  		return 0;
>  
> diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
> index c2ae14c720b4..6e6fb1f9f6ba 100644
> --- a/net/netfilter/nf_conntrack_standalone.c
> +++ b/net/netfilter/nf_conntrack_standalone.c
> @@ -175,8 +175,10 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
>  	int ret;
>  	u32 len;
>  	char *secctx;
> +	struct lsmblob le;
>  
> -	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
> +	lsmblob_init(&le, ct->secmark);
> +	ret = security_secid_to_secctx(&le, &secctx, &len);
>  	if (ret)
>  		return;
>  
> diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
> index 0dcc3592d053..105018d19318 100644
> --- a/net/netfilter/nfnetlink_queue.c
> +++ b/net/netfilter/nfnetlink_queue.c
> @@ -309,13 +309,17 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
>  {
>  	u32 seclen = 0;
>  #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
> +	struct lsmblob le;
> +
>  	if (!skb || !sk_fullsock(skb->sk))
>  		return 0;
>  
>  	read_lock_bh(&skb->sk->sk_callback_lock);
>  
> -	if (skb->secmark)
> -		security_secid_to_secctx(skb->secmark, secdata, &seclen);
> +	if (skb->secmark) {
> +		lsmblob_init(&le, skb->secmark);
> +		security_secid_to_secctx(&le, secdata, &seclen);
> +	}
>  
>  	read_unlock_bh(&skb->sk->sk_callback_lock);
>  #endif
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index 30873e671d05..46ac9721e261 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -389,6 +389,7 @@ int netlbl_unlhsh_add(struct net *net,
>  	struct audit_buffer *audit_buf = NULL;
>  	char *secctx = NULL;
>  	u32 secctx_len;
> +	struct lsmblob le;
>  
>  	if (addr_len != sizeof(struct in_addr) &&
>  	    addr_len != sizeof(struct in6_addr))
> @@ -451,7 +452,8 @@ int netlbl_unlhsh_add(struct net *net,
>  unlhsh_add_return:
>  	rcu_read_unlock();
>  	if (audit_buf != NULL) {
> -		if (security_secid_to_secctx(secid,
> +		lsmblob_init(&le, secid);
> +		if (security_secid_to_secctx(&le,
>  					     &secctx,
>  					     &secctx_len) == 0) {
>  			audit_log_format(audit_buf, " sec_obj=%s", secctx);
> @@ -488,6 +490,7 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>  	struct net_device *dev;
>  	char *secctx;
>  	u32 secctx_len;
> +	struct lsmblob le;
>  
>  	spin_lock(&netlbl_unlhsh_lock);
>  	list_entry = netlbl_af4list_remove(addr->s_addr, mask->s_addr,
> @@ -507,8 +510,10 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>  					  addr->s_addr, mask->s_addr);
>  		if (dev != NULL)
>  			dev_put(dev);
> +		if (entry != NULL)
> +			lsmblob_init(&le, entry->secid);
>  		if (entry != NULL &&
> -		    security_secid_to_secctx(entry->secid,
> +		    security_secid_to_secctx(&le,
>  					     &secctx, &secctx_len) == 0) {
>  			audit_log_format(audit_buf, " sec_obj=%s", secctx);
>  			security_release_secctx(secctx, secctx_len);
> @@ -550,6 +555,7 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>  	struct net_device *dev;
>  	char *secctx;
>  	u32 secctx_len;
> +	struct lsmblob le;
>  
>  	spin_lock(&netlbl_unlhsh_lock);
>  	list_entry = netlbl_af6list_remove(addr, mask, &iface->addr6_list);
> @@ -568,8 +574,10 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>  					  addr, mask);
>  		if (dev != NULL)
>  			dev_put(dev);
> +		if (entry != NULL)
> +			lsmblob_init(&le, entry->secid);
>  		if (entry != NULL &&
> -		    security_secid_to_secctx(entry->secid,
> +		    security_secid_to_secctx(&le,
>  					     &secctx, &secctx_len) == 0) {
>  			audit_log_format(audit_buf, " sec_obj=%s", secctx);
>  			security_release_secctx(secctx, secctx_len);
> @@ -1090,6 +1098,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>  	u32 secid;
>  	char *secctx;
>  	u32 secctx_len;
> +	struct lsmblob le;
>  
>  	data = genlmsg_put(cb_arg->skb, NETLINK_CB(cb_arg->nl_cb->skb).portid,
>  			   cb_arg->seq, &netlbl_unlabel_gnl_family,
> @@ -1144,7 +1153,8 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>  		secid = addr6->secid;
>  	}
>  
> -	ret_val = security_secid_to_secctx(secid, &secctx, &secctx_len);
> +	lsmblob_init(&le, secid);
> +	ret_val = security_secid_to_secctx(&le, &secctx, &secctx_len);
>  	if (ret_val != 0)
>  		goto list_cb_failure;
>  	ret_val = nla_put(cb_arg->skb,
> diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
> index 4676f5bb16ae..4145adf55a22 100644
> --- a/net/netlabel/netlabel_user.c
> +++ b/net/netlabel/netlabel_user.c
> @@ -100,6 +100,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
>  	struct audit_buffer *audit_buf;
>  	char *secctx;
>  	u32 secctx_len;
> +	struct lsmblob le;
>  
>  	if (audit_enabled == AUDIT_OFF)
>  		return NULL;
> @@ -112,10 +113,9 @@ struct audit_buffer *netlbl_audit_start_common(int type,
>  			 from_kuid(&init_user_ns, audit_info->loginuid),
>  			 audit_info->sessionid);
>  
> +	lsmblob_init(&le, audit_info->secid);
>  	if (audit_info->secid != 0 &&
> -	    security_secid_to_secctx(audit_info->secid,
> -				     &secctx,
> -				     &secctx_len) == 0) {
> +	    security_secid_to_secctx(&le, &secctx, &secctx_len) == 0) {
>  		audit_log_format(audit_buf, " subj=%s", secctx);
>  		security_release_secctx(secctx, secctx_len);
>  	}
> diff --git a/security/security.c b/security/security.c
> index 44927bf13d32..561a41eccbd9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1987,10 +1987,18 @@ int security_ismaclabel(const char *name)
>  }
>  EXPORT_SYMBOL(security_ismaclabel);
>  
> -int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
> +int security_secid_to_secctx(struct lsmblob *l, char **secdata, u32 *seclen)
>  {
> -	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, secid, secdata,
> -				seclen);
> +	struct security_hook_list *hp;
> +	int rc;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
> +		rc = hp->hook.secid_to_secctx(l->secid[hp->slot],
> +					      secdata, seclen);
> +		if (rc != 0)
> +			return rc;
> +	}
> +	return 0;
>  }
>  EXPORT_SYMBOL(security_secid_to_secctx);
>  
> -- 
> 2.20.1
> 

-- 
Kees Cook
