Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B7DC48BD6
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79ACA21670
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfFZXwD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:52:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35394 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfFZXwC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 19:52:02 -0400
Received: from static-50-53-46-226.bvtn.or.frontiernet.net ([50.53.46.226] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1hgHhk-0002cw-JD; Wed, 26 Jun 2019 23:51:56 +0000
Subject: Re: [PATCH v4 09/23] LSM: Use lsmblob in security_secid_to_secctx
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-10-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <91c2deaf-2652-c148-abf3-fb0be2e6a310@canonical.com>
Date:   Wed, 26 Jun 2019 16:51:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190626192234.11725-10-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/26/19 12:22 PM, Casey Schaufler wrote:
> Change security_secid_to_secctx() to take a lsmblob as input
> instead of a u32 secid. It will then call the LSM hooks
> using the lsmblob element allocated for that module. The
> callers have been updated as well. This allows for the
> possibility that more than one module may be called upon
> to translate a secid to a string, as can occur in the
> audit code.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>


> ---
>  drivers/android/binder.c                |  4 +++-
>  include/linux/security.h                |  5 +++--
>  include/net/scm.h                       |  5 ++---
>  kernel/audit.c                          |  9 +++++++--
>  kernel/auditsc.c                        | 14 ++++++++++----
>  net/ipv4/ip_sockglue.c                  |  3 +--
>  net/netfilter/nf_conntrack_netlink.c    |  8 ++++++--
>  net/netfilter/nf_conntrack_standalone.c |  4 +++-
>  net/netfilter/nfnetlink_queue.c         |  8 ++++++--
>  net/netlabel/netlabel_unlabeled.c       | 18 ++++++++++++++----
>  net/netlabel/netlabel_user.c            |  6 +++---
>  security/security.c                     | 16 +++++++++++++---
>  12 files changed, 71 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 8685882da64c..1962f6b8abd0 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3120,9 +3120,11 @@ static void binder_transaction(struct binder_proc *proc,
>  
>  	if (target_node && target_node->txn_security_ctx) {
>  		u32 secid;
> +		struct lsmblob blob;
>  
>  		security_task_getsecid(proc->tsk, &secid);
> -		ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
> +		lsmblob_init(&blob, secid);
> +		ret = security_secid_to_secctx(&blob, &secctx, &secctx_sz);
>  		if (ret) {
>  			return_error = BR_FAILED_REPLY;
>  			return_error_param = ret;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 30337f1a9056..7b4667cc4930 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -446,7 +446,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>  			 size_t size);
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>  int security_ismaclabel(const char *name);
> -int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
> +int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen);
>  int security_secctx_to_secid(const char *secdata, u32 seclen,
>  			     struct lsmblob *blob);
>  void security_release_secctx(char *secdata, u32 seclen);
> @@ -1224,7 +1224,8 @@ static inline int security_ismaclabel(const char *name)
>  	return 0;
>  }
>  
> -static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
> +static inline int security_secid_to_secctx(struct lsmblob *blob,
> +					   char **secdata, u32 *seclen)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/include/net/scm.h b/include/net/scm.h
> index e2e71c4bf9d0..31ae605fcc0a 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -97,9 +97,8 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
>  	int err;
>  
>  	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
> -		/* Scaffolding - it has to be element 0 for now */
> -		err = security_secid_to_secctx(scm->lsmblob.secid[0],
> -					       &secdata, &seclen);
> +		err = security_secid_to_secctx(&scm->lsmblob, &secdata,
> +					       &seclen);
>  
>  		if (!err) {
>  			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
> diff --git a/kernel/audit.c b/kernel/audit.c
> index c89ea48c70a6..d0338411d75d 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1430,7 +1430,10 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>  	case AUDIT_SIGNAL_INFO:
>  		len = 0;
>  		if (audit_sig_sid) {
> -			err = security_secid_to_secctx(audit_sig_sid, &ctx, &len);
> +			struct lsmblob blob;
> +
> +			lsmblob_init(&blob, audit_sig_sid);
> +			err = security_secid_to_secctx(&blob, &ctx, &len);
>  			if (err)
>  				return err;
>  		}
> @@ -2073,12 +2076,14 @@ int audit_log_task_context(struct audit_buffer *ab)
>  	unsigned len;
>  	int error;
>  	u32 sid;
> +	struct lsmblob blob;
>  
>  	security_task_getsecid(current, &sid);
>  	if (!sid)
>  		return 0;
>  
> -	error = security_secid_to_secctx(sid, &ctx, &len);
> +	lsmblob_init(&blob, sid);
> +	error = security_secid_to_secctx(&blob, &ctx, &len);
>  	if (error) {
>  		if (error != -EINVAL)
>  			goto error_path;
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 18ee5556c086..d31914088a82 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -947,6 +947,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>  	char *ctx = NULL;
>  	u32 len;
>  	int rc = 0;
> +	struct lsmblob blob;
>  
>  	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
>  	if (!ab)
> @@ -956,7 +957,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>  			 from_kuid(&init_user_ns, auid),
>  			 from_kuid(&init_user_ns, uid), sessionid);
>  	if (sid) {
> -		if (security_secid_to_secctx(sid, &ctx, &len)) {
> +		lsmblob_init(&blob, sid);
> +		if (security_secid_to_secctx(&blob, &ctx, &len)) {
>  			audit_log_format(ab, " obj=(none)");
>  			rc = 1;
>  		} else {
> @@ -1198,7 +1200,10 @@ static void show_special(struct audit_context *context, int *call_panic)
>  		if (osid) {
>  			char *ctx = NULL;
>  			u32 len;
> -			if (security_secid_to_secctx(osid, &ctx, &len)) {
> +			struct lsmblob blob;
> +
> +			lsmblob_init(&blob, osid);
> +			if (security_secid_to_secctx(&blob, &ctx, &len)) {
>  				audit_log_format(ab, " osid=%u", osid);
>  				*call_panic = 1;
>  			} else {
> @@ -1349,9 +1354,10 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
>  	if (n->osid != 0) {
>  		char *ctx = NULL;
>  		u32 len;
> +		struct lsmblob blob;
>  
> -		if (security_secid_to_secctx(
> -			n->osid, &ctx, &len)) {
> +		lsmblob_init(&blob, n->osid);
> +		if (security_secid_to_secctx(&blob, &ctx, &len)) {
>  			audit_log_format(ab, " osid=%u", n->osid);
>  			if (call_panic)
>  				*call_panic = 2;
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index 2a5c868ce135..e05f4ef68bd8 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -139,8 +139,7 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
>  	if (err)
>  		return;
>  
> -	/* Scaffolding - it has to be element 0 */
> -	err = security_secid_to_secctx(lb.secid[0], &secdata, &seclen);
> +	err = security_secid_to_secctx(&lb, &secdata, &seclen);
>  	if (err)
>  		return;
>  
> diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
> index 66c596d287a5..ca0968f13240 100644
> --- a/net/netfilter/nf_conntrack_netlink.c
> +++ b/net/netfilter/nf_conntrack_netlink.c
> @@ -330,8 +330,10 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
>  	struct nlattr *nest_secctx;
>  	int len, ret;
>  	char *secctx;
> +	struct lsmblob blob;
>  
> -	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
> +	lsmblob_init(&blob, ct->secmark);
> +	ret = security_secid_to_secctx(&blob, &secctx, &len);
>  	if (ret)
>  		return 0;
>  
> @@ -615,8 +617,10 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
>  {
>  #ifdef CONFIG_NF_CONNTRACK_SECMARK
>  	int len, ret;
> +	struct lsmblob blob;
>  
> -	ret = security_secid_to_secctx(ct->secmark, NULL, &len);
> +	lsmblob_init(&blob, ct->secmark);
> +	ret = security_secid_to_secctx(&blob, NULL, &len);
>  	if (ret)
>  		return 0;
>  
> diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
> index c2ae14c720b4..c793103f3cd7 100644
> --- a/net/netfilter/nf_conntrack_standalone.c
> +++ b/net/netfilter/nf_conntrack_standalone.c
> @@ -175,8 +175,10 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
>  	int ret;
>  	u32 len;
>  	char *secctx;
> +	struct lsmblob blob;
>  
> -	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
> +	lsmblob_init(&blob, ct->secmark);
> +	ret = security_secid_to_secctx(&blob, &secctx, &len);
>  	if (ret)
>  		return;
>  
> diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
> index 0dcc3592d053..59211bff90ab 100644
> --- a/net/netfilter/nfnetlink_queue.c
> +++ b/net/netfilter/nfnetlink_queue.c
> @@ -309,13 +309,17 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
>  {
>  	u32 seclen = 0;
>  #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
> +	struct lsmblob blob;
> +
>  	if (!skb || !sk_fullsock(skb->sk))
>  		return 0;
>  
>  	read_lock_bh(&skb->sk->sk_callback_lock);
>  
> -	if (skb->secmark)
> -		security_secid_to_secctx(skb->secmark, secdata, &seclen);
> +	if (skb->secmark) {
> +		lsmblob_init(&blob, skb->secmark);
> +		security_secid_to_secctx(&blob, secdata, &seclen);
> +	}
>  
>  	read_unlock_bh(&skb->sk->sk_callback_lock);
>  #endif
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index 2976370e41aa..2d8dd5b84457 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -389,6 +389,7 @@ int netlbl_unlhsh_add(struct net *net,
>  	struct audit_buffer *audit_buf = NULL;
>  	char *secctx = NULL;
>  	u32 secctx_len;
> +	struct lsmblob blob;
>  
>  	if (addr_len != sizeof(struct in_addr) &&
>  	    addr_len != sizeof(struct in6_addr))
> @@ -451,7 +452,8 @@ int netlbl_unlhsh_add(struct net *net,
>  unlhsh_add_return:
>  	rcu_read_unlock();
>  	if (audit_buf != NULL) {
> -		if (security_secid_to_secctx(secid,
> +		lsmblob_init(&blob, secid);
> +		if (security_secid_to_secctx(&blob,
>  					     &secctx,
>  					     &secctx_len) == 0) {
>  			audit_log_format(audit_buf, " sec_obj=%s", secctx);
> @@ -488,6 +490,7 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>  	struct net_device *dev;
>  	char *secctx;
>  	u32 secctx_len;
> +	struct lsmblob blob;
>  
>  	spin_lock(&netlbl_unlhsh_lock);
>  	list_entry = netlbl_af4list_remove(addr->s_addr, mask->s_addr,
> @@ -507,8 +510,10 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>  					  addr->s_addr, mask->s_addr);
>  		if (dev != NULL)
>  			dev_put(dev);
> +		if (entry != NULL)
> +			lsmblob_init(&blob, entry->secid);
>  		if (entry != NULL &&
> -		    security_secid_to_secctx(entry->secid,
> +		    security_secid_to_secctx(&blob,
>  					     &secctx, &secctx_len) == 0) {
>  			audit_log_format(audit_buf, " sec_obj=%s", secctx);
>  			security_release_secctx(secctx, secctx_len);
> @@ -550,6 +555,7 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>  	struct net_device *dev;
>  	char *secctx;
>  	u32 secctx_len;
> +	struct lsmblob blob;
>  
>  	spin_lock(&netlbl_unlhsh_lock);
>  	list_entry = netlbl_af6list_remove(addr, mask, &iface->addr6_list);
> @@ -568,8 +574,10 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>  					  addr, mask);
>  		if (dev != NULL)
>  			dev_put(dev);
> +		if (entry != NULL)
> +			lsmblob_init(&blob, entry->secid);
>  		if (entry != NULL &&
> -		    security_secid_to_secctx(entry->secid,
> +		    security_secid_to_secctx(&blob,
>  					     &secctx, &secctx_len) == 0) {
>  			audit_log_format(audit_buf, " sec_obj=%s", secctx);
>  			security_release_secctx(secctx, secctx_len);
> @@ -1090,6 +1098,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>  	u32 secid;
>  	char *secctx;
>  	u32 secctx_len;
> +	struct lsmblob blob;
>  
>  	data = genlmsg_put(cb_arg->skb, NETLINK_CB(cb_arg->nl_cb->skb).portid,
>  			   cb_arg->seq, &netlbl_unlabel_gnl_family,
> @@ -1144,7 +1153,8 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>  		secid = addr6->secid;
>  	}
>  
> -	ret_val = security_secid_to_secctx(secid, &secctx, &secctx_len);
> +	lsmblob_init(&blob, secid);
> +	ret_val = security_secid_to_secctx(&blob, &secctx, &secctx_len);
>  	if (ret_val != 0)
>  		goto list_cb_failure;
>  	ret_val = nla_put(cb_arg->skb,
> diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
> index 4676f5bb16ae..2ccc6567e2a2 100644
> --- a/net/netlabel/netlabel_user.c
> +++ b/net/netlabel/netlabel_user.c
> @@ -100,6 +100,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
>  	struct audit_buffer *audit_buf;
>  	char *secctx;
>  	u32 secctx_len;
> +	struct lsmblob blob;
>  
>  	if (audit_enabled == AUDIT_OFF)
>  		return NULL;
> @@ -112,10 +113,9 @@ struct audit_buffer *netlbl_audit_start_common(int type,
>  			 from_kuid(&init_user_ns, audit_info->loginuid),
>  			 audit_info->sessionid);
>  
> +	lsmblob_init(&blob, audit_info->secid);
>  	if (audit_info->secid != 0 &&
> -	    security_secid_to_secctx(audit_info->secid,
> -				     &secctx,
> -				     &secctx_len) == 0) {
> +	    security_secid_to_secctx(&blob, &secctx, &secctx_len) == 0) {
>  		audit_log_format(audit_buf, " subj=%s", secctx);
>  		security_release_secctx(secctx, secctx_len);
>  	}
> diff --git a/security/security.c b/security/security.c
> index ad9aaa46ed04..0c7784a243e7 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1975,10 +1975,20 @@ int security_ismaclabel(const char *name)
>  }
>  EXPORT_SYMBOL(security_ismaclabel);
>  
> -int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
> +int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
>  {
> -	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, secid, secdata,
> -				seclen);
> +	struct security_hook_list *hp;
> +	int rc;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
> +		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +			continue;
> +		rc = hp->hook.secid_to_secctx(blob->secid[hp->lsmid->slot],
> +					      secdata, seclen);
> +		if (rc != 0)
> +			return rc;
> +	}
> +	return 0;
>  }
>  EXPORT_SYMBOL(security_secid_to_secctx);
>  
> 

