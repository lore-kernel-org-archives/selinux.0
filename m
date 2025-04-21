Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32430184;
	Mon, 21 Apr 2025 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745248641; cv=none; b=QUpUvWZOSypTIobkMcDNS7XCb7K9n//QMOr4Gpv75lyX6uVeU+8oEyFNRWhtg6JYmcCSy6k0VXdyHqpKH0EdnI1uzXvUc8gKh6Heo3uIpmwxr8FoyWWeo2IJr2cELJSKMUp8s5UfVcDjUy7EShWVaDgZcyIomYcwPH1uHXyJYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745248641; c=relaxed/simple;
	bh=gExts8hN026UkLytr9zkYUmL6B8PuMW88zMsupQBzlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acFRIfyBGjci9iAGXVDr4abvJHNVExS3dDdpqRn5as07RUIWivQGXmqA3XELIKyWVdknYbelNZ0C+0JRR0XIbqTyaSXs2EgMBKYE7u8XSwjuPPEEp0Bf7WQpFfZ3fYZWwM2O/GFR8nRfCoT/vhAQE3eqQkICDaUStGgWgPFEViY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfiwpdZo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfiwpdZo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CA5C4CEE4;
	Mon, 21 Apr 2025 15:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745248640;
	bh=gExts8hN026UkLytr9zkYUmL6B8PuMW88zMsupQBzlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfiwpdZoQHWUxxruVQBYPK45hGSCKgLQvZ9Lk31PbdjCvCGKsN+jz64gG0u6hSj7T
	 62Aitl1Wwg7HaNq1s5URC8ekBv3VXtB+EuYQPro2DGCSnLBfqTO3kNxoKS9r0jdIdj
	 jNjmv0kRVyQj5rxRd7haMXhuA+HRyrxA5nLUDZtv38wlQPFJKqQXmIQSQQEVrbaYi+
	 vCLIra4epM8Pl/ZHYvjeZe1U8L2Rx+BLOX12mcY6WgJOi3gehTsTb7McIG/jX3Jjvc
	 vPdetHf9nvdJxvGCHgdbIJhdYkm9HCPGX7KZb4x5ds7zlVlbP0gguIkJSmbEhSFbf1
	 oxUA7SuohlpWw==
Date: Mon, 21 Apr 2025 16:17:13 +0100
From: Simon Horman <horms@kernel.org>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	donald.hunter@gmail.com, gregkh@linuxfoundation.org,
	arve@android.com, tkjos@android.com, maco@android.com,
	joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com,
	surenb@google.com, omosnace@redhat.com, shuah@kernel.org,
	arnd@arndb.de, masahiroy@kernel.org, bagasdotme@gmail.com,
	tweek@google.com, paul@paul-moore.com, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
	hridya@google.com, smoreland@google.com, ynaffit@google.com,
	kernel-team@android.com
Subject: Re: [PATCH RESEND v17 2/3] binder: report txn errors via generic
 netlink
Message-ID: <20250421151713.GP2789685@horms.kernel.org>
References: <20250417002005.2306284-1-dualli@chromium.org>
 <20250417002005.2306284-3-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417002005.2306284-3-dualli@chromium.org>

On Wed, Apr 16, 2025 at 05:20:03PM -0700, Li Li wrote:
> From: Li Li <dualli@google.com>
> 
> Introduce generic netlink messages into the binder driver so that the
> Linux/Android system administration processes can listen to important
> events and take corresponding actions, like stopping a broken app from
> attacking the OS by sending huge amount of spamming binder transactions.
> 
> The binder netlink sources and headers are automatically generated from
> the corresponding binder netlink YAML spec. Don't modify them directly.
> 
> Signed-off-by: Li Li <dualli@google.com>

Hi Li Li,

> diff --git a/drivers/android/binder.c b/drivers/android/binder.c

...

>  static void binder_transaction(struct binder_proc *proc,
>  			       struct binder_thread *thread,
>  			       struct binder_transaction_data *tr, int reply,
> @@ -3683,10 +3764,14 @@ static void binder_transaction(struct binder_proc *proc,
>  		return_error_line = __LINE__;
>  		goto err_copy_data_failed;
>  	}
> -	if (t->buffer->oneway_spam_suspect)
> +	if (t->buffer->oneway_spam_suspect) {
>  		tcomplete->type = BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT;
> -	else
> +		if (binder_netlink_enabled(proc, BINDER_FLAG_SPAM))
> +			binder_netlink_report(context, BR_ONEWAY_SPAM_SUSPECT,
> +					      reply, t);
> +	} else {
>  		tcomplete->type = BINDER_WORK_TRANSACTION_COMPLETE;
> +	}
>  	t->work.type = BINDER_WORK_TRANSACTION;
>  
>  	if (reply) {
> @@ -3736,8 +3821,12 @@ static void binder_transaction(struct binder_proc *proc,
>  		 * process and is put in a pending queue, waiting for the target
>  		 * process to be unfrozen.
>  		 */
> -		if (return_error == BR_TRANSACTION_PENDING_FROZEN)
> +		if (return_error == BR_TRANSACTION_PENDING_FROZEN) {
>  			tcomplete->type = BINDER_WORK_TRANSACTION_PENDING;
> +			if (binder_netlink_enabled(proc, BINDER_FLAG_ASYNC_FROZEN))
> +				binder_netlink_report(context, return_error,
> +						      reply, t);
> +		}
>  		binder_enqueue_thread_work(thread, tcomplete);
>  		if (return_error &&
>  		    return_error != BR_TRANSACTION_PENDING_FROZEN)
> @@ -3799,6 +3888,10 @@ static void binder_transaction(struct binder_proc *proc,

The code preceding this hunk looks like this:

err_alloc_tcomplete_failed:
	if (trace_binder_txn_latency_free_enabled())
		binder_txn_latency_free(t);
	kfree(t);
	binder_stats_deleted(BINDER_STAT_TRANSACTION);
err_alloc_t_failed:
err_bad_todo_list:
err_bad_call_stack:
err_empty_call_stack:
err_dead_binder:
err_invalid_target_handle:
	if (target_node) {
		binder_dec_node(target_node, 1, 0);
		binder_dec_node_tmpref(target_node);
	}

1. The labels err_bad_todo_list, err_bad_call_stack,
   err_empty_call_stack, and err_invalid_target_handle may
   be jumped to before t is initialised.

2. In the err_alloc_tcomplete_failed label t is kfree'd.

However, the call to binder_netlink_report below will dereference t.

Flagged by Smatch.

>  		binder_dec_node_tmpref(target_node);
>  	}
>  
> +	if (binder_netlink_enabled(proc, BINDER_FLAG_FAILED))
> +		binder_netlink_report(context, return_error,
> +				      reply, t);
> +
>  	binder_debug(BINDER_DEBUG_FAILED_TRANSACTION,
>  		     "%d:%d transaction %s to %d:%d failed %d/%d/%d, code %u size %lld-%lld line %d\n",
>  		     proc->pid, thread->pid, reply ? "reply" :

...

> +/**
> + * binder_nl_report_setup_doit() - netlink .doit handler
> + * @skb:	the metadata struct passed from netlink driver
> + * @info:	the generic netlink struct passed from netlink driver
> + *
> + * Implements the .doit function to process binder netlink commands.
> + */
> +int binder_nl_report_setup_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct binder_context *context = NULL;
> +	struct binder_device *device;
> +	struct binder_proc *proc;
> +	u32 flags, pid;
> +	bool found;
> +	void *hdr;
> +	int ret;
> +
> +	ret = security_binder_setup_report(current_cred());
> +	if (ret < 0) {
> +		NL_SET_ERR_MSG(info->extack, "Permission denied");
> +		return ret;
> +	}
> +
> +	if (nla_len(info->attrs[BINDER_A_CMD_CONTEXT])) {
> +		/* Search the specified binder context */
> +		hlist_for_each_entry(device, &binder_devices, hlist) {
> +			if (!nla_strcmp(info->attrs[BINDER_A_CMD_CONTEXT],
> +					device->context.name)) {
> +				context = &device->context;
> +				break;
> +			}
> +		}
> +
> +		if (!context) {
> +			NL_SET_ERR_MSG(info->extack, "Invalid binder context");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	pid = nla_get_u32(info->attrs[BINDER_A_CMD_PID]);
> +	flags = nla_get_u32(info->attrs[BINDER_A_CMD_FLAGS]);
> +
> +	if (!pid) {
> +		if (!context) {
> +			NL_SET_ERR_MSG(info->extack,
> +				       "Invalid binder context and pid");
> +			return -EINVAL;
> +		}
> +
> +		/* Set the global flags for the whole binder context */
> +		context->report_flags = flags;
> +	} else {
> +		/* Set the per-process flags */
> +		found = false;
> +		mutex_lock(&binder_procs_lock);
> +		hlist_for_each_entry(proc, &binder_procs, proc_node) {
> +			if (proc->pid == pid
> +			    && (proc->context == context || !context)) {
> +				proc->report_flags = flags;
> +				found = true;
> +			}
> +		}
> +		mutex_unlock(&binder_procs_lock);
> +
> +		if (!found) {
> +			NL_SET_ERR_MSG_FMT(info->extack,
> +					   "Invalid binder report pid %u",
> +					   pid);
> +			return -EINVAL;
> +		}
> +	}

Within the above conditions it is assumed that context may be NULL.

> +
> +	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!skb) {
> +		pr_err("Failed to alloc binder netlink reply message\n");
> +		return -ENOMEM;
> +	}
> +
> +	hdr = genlmsg_iput(skb, info);
> +	if (!hdr)
> +		goto free_skb;
> +
> +	if (nla_put_string(skb, BINDER_A_CMD_CONTEXT, context->name) ||

But here context is dereferenced unconditionally.
This does not seem consistent.

Flagged by Smatch.

> +	    nla_put_u32(skb, BINDER_A_CMD_PID, pid) ||
> +	    nla_put_u32(skb, BINDER_A_CMD_FLAGS, flags))
> +		goto cancel_skb;
> +
> +	genlmsg_end(skb, hdr);
> +
> +	if (genlmsg_reply(skb, info)) {
> +		pr_err("Failed to send binder netlink reply message\n");
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +
> +cancel_skb:
> +	pr_err("Failed to add reply attributes to binder netlink message\n");
> +	genlmsg_cancel(skb, hdr);
> +free_skb:
> +	pr_err("Free binder netlink reply message on error\n");
> +	nlmsg_free(skb);
> +	ret = -EMSGSIZE;
> +
> +	return ret;
> +}

...
