Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FC1C2BA80
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 18:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BBD2076E
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 18:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CzRcLB+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgDGSnV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:43:21 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38322 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgDGSnV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Apr 2020 14:43:21 -0400
Received: by mail-pj1-f65.google.com with SMTP id m15so128700pje.3
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2020 11:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aWFfuPdMIgsENljoUMiI9SU8Q9i1frzzzO5RCjP6DXA=;
        b=CzRcLB+7i4ujBte5RJB1+PtpWIyFh0eIWbIEFQqztMUgfSDzMFXCGoI6bgrXYWSjVK
         AgqBwJAIkMfZclWGJ7eEpcDXgrvGJgFWLwTUWI3rNIs+0JC6nqOByxKxb+AV5Dy1cfhS
         aK93JQGmqywbO6EVfdiOIPof5Ms77vb+P9TPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aWFfuPdMIgsENljoUMiI9SU8Q9i1frzzzO5RCjP6DXA=;
        b=a4JWuZx1NJZgx8BCdDrS061JmhF9tCeuHQzLtaI5z/3d9L7+evh8COSbMUnM/tyOu7
         wYT5HJdZNaPFWDDkFmxyYh/OmNbGLh8ehxN2ZDYVNE2NcXqwxGa+9xbZxzErn7nrLEgp
         mOE/UU68gjyWvwZH9rO0PL8SZMhtB8SmcSiY6GdBJkgkOId3srYVaUI+8uEomIJaUi3w
         BVp23mCkQ9eHtbyaXxvvzsoElGTGQnymA2WyJTLaGl0OSN0E6DVpRBe02hbcz7fSTO7C
         3u6N0K/gsKaPx83yGCXxjq3NlxqB8w3mJ9lVoo1Pez1QoSh3sFqat1x+uOgInnnNuScC
         z7Dg==
X-Gm-Message-State: AGi0PubISk9wXFDqLt9IAEFG3YhAAqdQLBBpS2hRQWAZxUkrE9OAyQMu
        xCD0QZev5Qq1Df7/hWErTHgt6iPCBYk=
X-Google-Smtp-Source: APiQypIQWcKUX9MPeWoVlEbvqbawPoymLCYJtWqfDxC5vuwpRfHdMIBJ+EJJrj0M2jdeVcsJL+Ra4A==
X-Received: by 2002:a17:902:8c94:: with SMTP id t20mr3571272plo.336.1586284998202;
        Tue, 07 Apr 2020 11:43:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k12sm1366131pgj.33.2020.04.07.11.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 11:43:17 -0700 (PDT)
Date:   Tue, 7 Apr 2020 11:43:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: Re: [PATCH v16 20/23] Audit: Add a new record for multiple subject
 LSM attributes
Message-ID: <202004071143.60C2D1F29@keescook>
References: <20200407000159.43602-1-casey@schaufler-ca.com>
 <20200407000159.43602-21-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407000159.43602-21-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 06, 2020 at 05:01:56PM -0700, Casey Schaufler wrote:
> Create a new audit record type to contain the subject information
> when there are multiple security modules that require such data.
> This record is emitted before the other records for the event, but
> is linked with the same timestamp and serial number.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Cc: linux-audit@redhat.com
> ---
>  drivers/android/binder.c                |  2 +-
>  include/linux/security.h                |  9 +++-
>  include/net/scm.h                       |  3 +-
>  include/uapi/linux/audit.h              |  1 +
>  kernel/audit.c                          | 56 +++++++++++++++++++------
>  kernel/auditsc.c                        |  7 ++--
>  net/ipv4/ip_sockglue.c                  |  2 +-
>  net/netfilter/nf_conntrack_netlink.c    |  4 +-
>  net/netfilter/nf_conntrack_standalone.c |  2 +-
>  net/netfilter/nfnetlink_queue.c         |  2 +-
>  net/netlabel/netlabel_unlabeled.c       | 11 +++--
>  net/netlabel/netlabel_user.c            |  2 +-
>  security/security.c                     | 51 ++++++++++++++++++++--
>  13 files changed, 118 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index c76fc2abd091..e79c4948ab12 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3109,7 +3109,7 @@ static void binder_transaction(struct binder_proc *proc,
>  		size_t added_size;
>  
>  		security_task_getsecid(proc->tsk, &blob);
> -		ret = security_secid_to_secctx(&blob, &lsmctx);
> +		ret = security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_DISPLAY);
>  		if (ret) {
>  			return_error = BR_FAILED_REPLY;
>  			return_error_param = ret;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index fac5547dd89e..896b939f5d62 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -178,6 +178,8 @@ struct lsmblob {
>  #define LSMBLOB_INVALID		-1	/* Not a valid LSM slot number */
>  #define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
>  #define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
> +#define LSMBLOB_DISPLAY		-4	/* Use the "display" slot */
> +#define LSMBLOB_FIRST		-5	/* Use the default "display" slot */
>  
>  /**
>   * lsmblob_init - initialize an lsmblob structure.
> @@ -240,6 +242,8 @@ static inline u32 lsmblob_value(const struct lsmblob *blob)
>  	return 0;
>  }
>  
> +const char *security_lsm_slot_name(int slot);
> +
>  /* These functions are in security/commoncap.c */
>  extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
>  		       int cap, unsigned int opts);
> @@ -549,7 +553,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>  			 size_t size);
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>  int security_ismaclabel(const char *name);
> -int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp);
> +int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
> +			     int display);
>  int security_secctx_to_secid(const char *secdata, u32 seclen,
>  			     struct lsmblob *blob);
>  void security_release_secctx(struct lsmcontext *cp);
> @@ -1354,7 +1359,7 @@ static inline int security_ismaclabel(const char *name)
>  }
>  
>  static inline int security_secid_to_secctx(struct lsmblob *blob,
> -					   struct lsmcontext *cp)
> +					   struct lsmcontext *cp, int display)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/include/net/scm.h b/include/net/scm.h
> index 4a6ad8caf423..8b5a4737e1b8 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -96,7 +96,8 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
>  	int err;
>  
>  	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
> -		err = security_secid_to_secctx(&scm->lsmblob, &context);
> +		err = security_secid_to_secctx(&scm->lsmblob, &context,
> +					       LSMBLOB_DISPLAY);
>  
>  		if (!err) {
>  			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY,
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index a534d71e689a..2e6dbf907ee3 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -138,6 +138,7 @@
>  #define AUDIT_MAC_UNLBL_STCDEL	1417	/* NetLabel: del a static label */
>  #define AUDIT_MAC_CALIPSO_ADD	1418	/* NetLabel: add CALIPSO DOI entry */
>  #define AUDIT_MAC_CALIPSO_DEL	1419	/* NetLabel: del CALIPSO DOI entry */
> +#define AUDIT_MAC_TASK_CONTEXTS	1420	/* Multiple LSM contexts */
>  
>  #define AUDIT_FIRST_KERN_ANOM_MSG   1700
>  #define AUDIT_LAST_KERN_ANOM_MSG    1799
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 013a90dd2bd5..00a4fbecfdf7 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1419,7 +1419,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>  	case AUDIT_SIGNAL_INFO:
>  		if (lsmblob_is_set(&audit_sig_lsm)) {
>  			err = security_secid_to_secctx(&audit_sig_lsm,
> -						       &context);
> +						       &context, LSMBLOB_FIRST);
>  			if (err)
>  				return err;
>  		}
> @@ -2058,28 +2058,58 @@ void audit_log_key(struct audit_buffer *ab, char *key)
>  
>  int audit_log_task_context(struct audit_buffer *ab)
>  {
> +	int i;
>  	int error;
> +	bool sep = false;
>  	struct lsmblob blob;
> -	struct lsmcontext context;
> +	struct lsmcontext lsmdata;
> +	struct audit_buffer *lsmab = NULL;
> +	struct audit_context *context = NULL;
>  
>  	security_task_getsecid(current, &blob);
>  	if (!lsmblob_is_set(&blob))
>  		return 0;
>  
> -	error = security_secid_to_secctx(&blob, &context);
> -	if (error) {
> -		if (error != -EINVAL)
> -			goto error_path;
> -		return 0;
> +	/*
> +	 * If there is more than one security module that has a
> +	 * subject "context" it's necessary to put the subject data
> +	 * into a separate record to maintain compatibility.
> +	 */
> +	if (security_lsm_slot_name(1) != NULL) {
> +		audit_log_format(ab, " subj=?");
> +		context = ab->ctx;
> +		if (context)
> +			lsmab = audit_log_start(context, GFP_KERNEL,
> +						AUDIT_MAC_TASK_CONTEXTS);
>  	}
>  
> -	audit_log_format(ab, " subj=%s", context.context);
> -	security_release_secctx(&context);
> -	return 0;
> +	for (i = 0; i < LSMBLOB_ENTRIES; i++) {
> +		if (blob.secid[i] == 0)
> +			continue;
> +		error = security_secid_to_secctx(&blob, &lsmdata, i);
> +		if (error && error != -EINVAL) {
> +			audit_panic("error in audit_log_task_context");
> +			return error;
> +		}
> +
> +		if (context) {
> +			audit_log_format(lsmab, "%ssubj_%s=%s",
> +					 sep ? " " : "",
> +					 security_lsm_slot_name(i),
> +					 lsmdata.context);
> +			sep = true;
> +		} else
> +			audit_log_format(ab, " subj=%s", lsmdata.context);
> +
> +		security_release_secctx(&lsmdata);
> +		if (!context)
> +			break;
> +	}
> +
> +	if (context)
> +		audit_log_end(lsmab);
>  
> -error_path:
> -	audit_panic("error in audit_log_task_context");
> -	return error;
> +	return 0;
>  }
>  EXPORT_SYMBOL(audit_log_task_context);
>  
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index b7275860ba5f..4df540c32581 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -980,7 +980,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>  			 from_kuid(&init_user_ns, auid),
>  			 from_kuid(&init_user_ns, uid), sessionid);
>  	if (lsmblob_is_set(blob)) {
> -		if (security_secid_to_secctx(blob, &lsmctx)) {
> +		if (security_secid_to_secctx(blob, &lsmctx, LSMBLOB_FIRST)) {
>  			audit_log_format(ab, " obj=(none)");
>  			rc = 1;
>  		} else {
> @@ -1225,7 +1225,8 @@ static void show_special(struct audit_context *context, int *call_panic)
>  			struct lsmblob blob;
>  
>  			lsmblob_init(&blob, osid);
> -			if (security_secid_to_secctx(&blob, &lsmcxt)) {
> +			if (security_secid_to_secctx(&blob, &lsmcxt,
> +						     LSMBLOB_FIRST)) {
>  				audit_log_format(ab, " osid=%u", osid);
>  				*call_panic = 1;
>  			} else {
> @@ -1377,7 +1378,7 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
>  		struct lsmcontext lsmctx;
>  
>  		lsmblob_init(&blob, n->osid);
> -		if (security_secid_to_secctx(&blob, &lsmctx)) {
> +		if (security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_FIRST)) {
>  			audit_log_format(ab, " osid=%u", n->osid);
>  			if (call_panic)
>  				*call_panic = 2;
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index 27af7a6b8780..10b418029cdd 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -138,7 +138,7 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
>  	if (err)
>  		return;
>  
> -	err = security_secid_to_secctx(&lb, &context);
> +	err = security_secid_to_secctx(&lb, &context, LSMBLOB_DISPLAY);
>  	if (err)
>  		return;
>  
> diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
> index 2fa1e5bd781d..cd559fada596 100644
> --- a/net/netfilter/nf_conntrack_netlink.c
> +++ b/net/netfilter/nf_conntrack_netlink.c
> @@ -337,7 +337,7 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
>  	 * security_secid_to_secctx() will know which security module
>  	 * to use to create the secctx.  */
>  	lsmblob_init(&blob, ct->secmark);
> -	ret = security_secid_to_secctx(&blob, &context);
> +	ret = security_secid_to_secctx(&blob, &context, LSMBLOB_DISPLAY);
>  	if (ret)
>  		return 0;
>  
> @@ -651,7 +651,7 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
>  	struct lsmblob blob;
>  	struct lsmcontext context;
>  
> -	ret = security_secid_to_secctx(&blob, &context);
> +	ret = security_secid_to_secctx(&blob, &context, LSMBLOB_DISPLAY);
>  	if (ret)
>  		return 0;
>  
> diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
> index 383a4f44be63..9551e8be6ca4 100644
> --- a/net/netfilter/nf_conntrack_standalone.c
> +++ b/net/netfilter/nf_conntrack_standalone.c
> @@ -177,7 +177,7 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
>  	struct lsmcontext context;
>  
>  	lsmblob_init(&blob, ct->secmark);
> -	ret = security_secid_to_secctx(&blob, &context);
> +	ret = security_secid_to_secctx(&blob, &context, LSMBLOB_DISPLAY);
>  	if (ret)
>  		return;
>  
> diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
> index d07900c317fd..dc8902f8cea2 100644
> --- a/net/netfilter/nfnetlink_queue.c
> +++ b/net/netfilter/nfnetlink_queue.c
> @@ -316,7 +316,7 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, struct lsmcontext *context)
>  		 * blob. security_secid_to_secctx() will know which security
>  		 * module to use to create the secctx.  */
>  		lsmblob_init(&blob, skb->secmark);
> -		security_secid_to_secctx(&blob, context);
> +		security_secid_to_secctx(&blob, context, LSMBLOB_DISPLAY);
>  	}
>  
>  	read_unlock_bh(&skb->sk->sk_callback_lock);
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index c14a485ff045..d816909866cc 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -437,7 +437,8 @@ int netlbl_unlhsh_add(struct net *net,
>  unlhsh_add_return:
>  	rcu_read_unlock();
>  	if (audit_buf != NULL) {
> -		if (security_secid_to_secctx(lsmblob, &context) == 0) {
> +		if (security_secid_to_secctx(lsmblob, &context,
> +					     LSMBLOB_FIRST) == 0) {
>  			audit_log_format(audit_buf, " sec_obj=%s",
>  					 context.context);
>  			security_release_secctx(&context);
> @@ -492,7 +493,8 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>  		if (dev != NULL)
>  			dev_put(dev);
>  		if (entry != NULL &&
> -		    security_secid_to_secctx(&entry->lsmblob, &context) == 0) {
> +		    security_secid_to_secctx(&entry->lsmblob, &context,
> +					     LSMBLOB_FIRST) == 0) {
>  			audit_log_format(audit_buf, " sec_obj=%s",
>  					 context.context);
>  			security_release_secctx(&context);
> @@ -552,7 +554,8 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>  		if (dev != NULL)
>  			dev_put(dev);
>  		if (entry != NULL &&
> -		    security_secid_to_secctx(&entry->lsmblob, &context) == 0) {
> +		    security_secid_to_secctx(&entry->lsmblob, &context,
> +					     LSMBLOB_FIRST) == 0) {
>  			audit_log_format(audit_buf, " sec_obj=%s",
>  					 context.context);
>  			security_release_secctx(&context);
> @@ -1122,7 +1125,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>  		lsmb = (struct lsmblob *)&addr6->lsmblob;
>  	}
>  
> -	ret_val = security_secid_to_secctx(lsmb, &context);
> +	ret_val = security_secid_to_secctx(lsmb, &context, LSMBLOB_FIRST);
>  	if (ret_val != 0)
>  		goto list_cb_failure;
>  	ret_val = nla_put(cb_arg->skb,
> diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
> index 951ba0639d20..1941877fd16f 100644
> --- a/net/netlabel/netlabel_user.c
> +++ b/net/netlabel/netlabel_user.c
> @@ -100,7 +100,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
>  
>  	lsmblob_init(&blob, audit_info->secid);
>  	if (audit_info->secid != 0 &&
> -	    security_secid_to_secctx(&blob, &context) == 0) {
> +	    security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST) == 0) {
>  		audit_log_format(audit_buf, " subj=%s", context.context);
>  		security_release_secctx(&context);
>  	}
> diff --git a/security/security.c b/security/security.c
> index b7c2ed1eee42..d3bf71d66724 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -480,7 +480,31 @@ static int lsm_append(const char *new, char **result)
>   * Pointers to the LSM id structures for local use.
>   */
>  static int lsm_slot __lsm_ro_after_init;
> -static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES];
> +static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES] __lsm_ro_after_init;
> +
> +/**
> + * security_lsm_slot_name - Get the name of the security module in a slot
> + * @slot: index into the "display" slot list.
> + *
> + * Provide the name of the security module associated with
> + * a display slot.
> + *
> + * If @slot is LSMBLOB_INVALID return the value
> + * for slot 0 if it has been set, otherwise NULL.
> + *
> + * Returns a pointer to the name string or NULL.
> + */
> +const char *security_lsm_slot_name(int slot)
> +{
> +	if (slot == LSMBLOB_INVALID)
> +		slot = 0;
> +	else if (slot >= LSMBLOB_ENTRIES || slot < 0)
> +		return NULL;
> +
> +	if (lsm_slotlist[slot] == NULL)
> +		return NULL;
> +	return lsm_slotlist[slot]->lsm;
> +}
>  
>  /**
>   * security_add_hooks - Add a modules hooks to the hook lists.
> @@ -2169,13 +2193,32 @@ int security_ismaclabel(const char *name)
>  }
>  EXPORT_SYMBOL(security_ismaclabel);
>  
> -int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp)
> +int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
> +			     int display)
>  {
>  	struct security_hook_list *hp;
> -	int display = lsm_task_display(current);
>  
>  	memset(cp, 0, sizeof(*cp));
>  
> +	/*
> +	 * display either is the slot number use for formatting
> +	 * or an instruction on which relative slot to use.
> +	 */
> +	if (display == LSMBLOB_DISPLAY)
> +		display = lsm_task_display(current);
> +	else if (display == LSMBLOB_FIRST)
> +		display = LSMBLOB_INVALID;
> +	else if (display < 0) {
> +		WARN_ONCE(true,
> +			"LSM: %s unknown display\n", __func__);
> +		display = LSMBLOB_INVALID;
> +	} else if (display >= lsm_slot) {
> +		WARN_ONCE(true,
> +			"LSM: %s invalid display\n", __func__);
> +		display = LSMBLOB_INVALID;
> +	}
> +
> +
>  	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
>  		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>  			continue;
> @@ -2186,7 +2229,7 @@ int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp)
>  					&cp->context, &cp->len);
>  		}
>  	}
> -	return 0;
> +	return -EOPNOTSUPP;
>  }
>  EXPORT_SYMBOL(security_secid_to_secctx);
>  
> -- 
> 2.24.1
> 

-- 
Kees Cook
