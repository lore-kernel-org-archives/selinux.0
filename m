Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6FBC433F5
	for <selinux@archiver.kernel.org>; Wed,  2 Mar 2022 22:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiCBWdW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Mar 2022 17:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiCBWdV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Mar 2022 17:33:21 -0500
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDADB90
        for <selinux@vger.kernel.org>; Wed,  2 Mar 2022 14:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646260348; bh=0J6z8avBzTiM5nTHk4kgQd5ArUz4NdMv74W/GQoWZdw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZdHOYGwXAOHqUwhOn9EUt/pPywHYIqgwjzIGdnbC7FyuX1C7hVil1JvUSW7SThw8dtZI1zXB7ceSwDkV85W6P72xkayGhrk3nnDcQ9UyweUWM5SvJs6qYTxjhJQGnwjwZRpuaTIzOkINmXb4EIubiaKuhjqF7ANAyk/105fTc/kBnKKO6mjwCYgHK9iQkVj0A8SWJ95N+Y4j7mGtxs3ragx6DBAZ7PTFSDv4kVdHYrmnC9AHEUbMJgiwr4BnpZ0rFgAHJHe8Ce9WTEYi7dVsp/HsfCbzcHITa8kFXreGpN+AOTc00VF2L7wUrPF0aiwR7cG63zZVCgjz+Dec6f2S7g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646260348; bh=8elccz1AVYSt7/szH6vPJK7lDtbS3bzdi6cdekFtNi4=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=tpbbNqUC3tnWZ5g9CdU350nQI2Go1kQ9IWhUL0Obc036G1M4dZqIgeLX4nZS5iXcqmv0E2eLfgOp2VVGrH23YdQQ5KMQnESZklYzfbbWd5OVKtEt/15YCDXz1NrkcxMsbqbz/1Dpr/Pkqj84JVu0XyPEHG6sEtToAXWi/vcR3rMs9AirTLwDpS/XRuObzwsfHuMJ5DEYgH6x7sjk+cAqqRrIIU+BIPX6bQokNPpky+F/cmDH3h+Q8yqSZZ8T66Tss3z7YpA3U3cXgud5rclPnm8iM8cpK4cYGj9XZEEDKXvAcXHgeq2IQmmuoP8SSzm7K5CJdzC8NKfk9TXRXxpf0g==
X-YMail-OSG: JWjRXucVM1n.peeeYZAUPDvuaDEwlA7KtnPW4HjMKYNkMnfv3DMU_3rmt7_z5pf
 5gjJDpXlW6ldBgDkwP2dm3TriFl9qXOfvoW.bvMAze8PVCRn.jxnWvECWJSVW53fwX5rwd3n5.Ih
 FPp6NUDuIFAmoPBHXyonIJE_1Y1HpPxwky9lVm1iW4uzfyMgb4bnE3nF6bjzD_Bo.MEcy92YJ4Hi
 tJsXLvzI.rzx0s8jn8bNI3aYPNhzhjf3p41LpimpHNre9JYt4f3hgdaQuaZ0_7Boi4p4WUah3D3w
 _uYWInMWEofOShFEfPH_rcnxQVD0ZBZ151UUCBxJR6X996jlnhbXDBPytwd.1g.pMkAkUmVuSOGn
 J8O6DHCXU2R9M5JsE2Glnp_0Bt.jJsURqLBAPYacJ5NzXSLAwdrEIlUf56whjzzwhvY94xfJi_h_
 9Px5hSQDtO2IKXPE1o4R9t19BSBxWBSJ21jkiNPb_qZGFPMO0yvI..2ieCXDcfcQanoWQGU8V78_
 08vIarzyh3EnqX4TjCTnzV4AT6g_ZioTtGY8xhOXCVIjuWn_UY6pmfs2kxjoa6vpqsXnSjHT6SNr
 rqz_g8ypcKrxba23vsg7GhHQzBd97rEhaZ9BZCx5hPdmkUYINOSR_l1M9x1Oq6_eJIY8bg10KRXu
 wFWK51UXZcopYP3ljVz96br9hQFSrQtmLkW_Uz9Fjdq3yjqjg9dRdNoDZKXdfQzbP73opz8GBSYG
 1iWAXxjbrMPAV0lp3mgUy9Fa8wL7GgqO8JzeagHRG5LCea0mJ1NdjfoOlUnnZsW.0XX7MrgAuP71
 RZDf_HbH5FbWn5j2inX.mmGWs6JmVy8XRqki4NF_83U73yAh48mqmNPwgFQJ9At3cDaAKM2LMbRb
 oDAco7dHJD5K2dMDvA2UqRzMvbjdyilnH54t3vbsVNzpeDtWlDEBz4WM8MfBxMs77zN0k8B3xRno
 ZdktCPT8EmVM6LKNsPKP2AeAhsujBCLEjCz7kWW0JayO9wtg5x54o0OFOJY2ThfOkEkq4WKhiwsI
 jkibmxyKNgRCFb2zOI3Zua1geSf2EDPhwuXoKWQ80CGyRvVuP64m8v8wYECtwApIUZ3NSMLuoPV8
 kKq6BBbJ8WHzwAGrnTnZZNtivk7eZmBZbxdpp0ELFr2O9pI55RhWPa4oAEh.GjXH3oNONSGQUU1c
 W5CAeH37vB9nmhK4HMjCtE9yP7wTWIsh_TfiBnXuwoFwiMRUWRGM6pfFo8bzQTVVY2gDhQ4hYKk6
 QNPiPVykdUxgFYf6Qm4_HwTLSd4LLGQrrs0yLomRyqO_LFJ97Fxm7lahS1P2dKtABULzPQyRSQDL
 iv7j18qVCfBm110oXlVs21LyZ5xJEtQR9BGRO2L30_xR4qD4iV.UU71tfObf270K1R9KeLtvvQlj
 AE3EZkOAH049bupqfUeVyAkK4DFZFNiU3LHs0SAsyBdOMA_mgPvb6.W83CIOaShzKf5uBggoGdjF
 l1x2OdDOU6FNY2gxApdwKamnfXiWACxiHkcP0huHqiCoS2RXY89nOmKnQVq8Uw8rDEvGqfmQsUZr
 4jez5RInjs93VCAv0GspGeeyGabMLcrR4mB1Q6GMG0XHR9yHtsdkNU5cCnJW5Qh_wV9vrNLDaC_N
 Fn9Tc1Fx7wt_hIJYg_fN0g7t7wxh.WXcEa7_SbZ4OzujNwv9RvCwJz7N0LKQ74Xyl5G0XVQHacns
 5U0wJ9Z1_L4voxVmVDSJulyMJvLfINcPDMLYQ.MBJwhZcKboiL9G2tSIjtHPqxbFV4cP8rO5.Yfh
 IZKN9hGBBC8yvpOZAW_afjpC1zrJ_EQdRLQOQ3wavYagtN1kgn_Bdp_2sWX.uJSpIG5vBCz_JxL8
 Viw5CA7xe2pmsGvMql1.gws4mesV731z.YedkW0fl3F7RE0JC0dj9rBSvd3cp0eSLeu8LYx2V.mM
 ND8yuuAZqcLtuqqBCOCgS.iWpPDdKDDzbuM.TTUVuTa0riQ.pULcEJC82gp0uUlArcxJduHg_3UX
 ieqsCLC2JnHlk0DpTkBmkftAI_Sjndagjdjr8vY4GcvoRhR0ehPV7oZNtb43JnZA.hletQMoJWn5
 GfBsoM4PIosNSec9y__AyvtKgU3zQ24LSnYWvxJ7R7V9bADi8P_16GsXWPIZblsF8Idrnb2hoVyj
 zpLNvlOpk43VwJPHlCw81fO9Z7zNkhvOVn9HDGXIR3Ejo_ebyzFTYZ6P4sraZuvIjJtb07h8OP34
 Uv5i2e9rdtjkDAEUX
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Wed, 2 Mar 2022 22:32:28 +0000
Received: by kubenode527.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID fc2c5faaa0feae334c91c83d128cb940;
          Wed, 02 Mar 2022 22:32:25 +0000 (UTC)
Message-ID: <2f32ffa3-7165-f989-b162-4aab162b5027@schaufler-ca.com>
Date:   Wed, 2 Mar 2022 14:32:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v32 24/28] Audit: Add framework for auxiliary records
Content-Language: en-US
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp
References: <20220202235323.23929-1-casey@schaufler-ca.com>
 <20220202235323.23929-25-casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220202235323.23929-25-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19724 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/2/2022 3:53 PM, Casey Schaufler wrote:
> Add a list for auxiliary record data to the audit_buffer structure.
> Add the audit_stamp information to the audit_buffer as there's no
> guarantee that there will be an audit_context containing the stamp
> associated with the event. At audit_log_end() time create auxiliary
> records (none are currently defined) as have been added to the list.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

I'm really hoping for either Acks or feedback on this approach.

> ---
>   kernel/audit.c | 84 ++++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 74 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index f012c3786264..559fb14e0380 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -191,15 +191,25 @@ static struct audit_ctl_mutex {
>    * should be at least that large. */
>   #define AUDIT_BUFSIZ 1024
>   
> +/* The audit_context_entry contains data required to create an
> + * auxiliary record.
> + */
> +struct audit_context_entry {
> +	struct list_head	list;
> +	int			type;	/* Audit record type */
> +};
> +
>   /* The audit_buffer is used when formatting an audit record.  The caller
>    * locks briefly to get the record off the freelist or to allocate the
>    * buffer, and locks briefly to send the buffer to the netlink layer or
>    * to place it on a transmit queue.  Multiple audit_buffers can be in
>    * use simultaneously. */
>   struct audit_buffer {
> -	struct sk_buff       *skb;	/* formatted skb ready to send */
> -	struct audit_context *ctx;	/* NULL or associated context */
> -	gfp_t		     gfp_mask;
> +	struct sk_buff		*skb;	/* formatted skb ready to send */
> +	struct audit_context	*ctx;	/* NULL or associated context */
> +	struct list_head	aux_records;	/* aux record data */
> +	struct audit_stamp	stamp;	/* event stamp */
> +	gfp_t			gfp_mask;
>   };
>   
>   struct audit_reply {
> @@ -1765,6 +1775,7 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
>   
>   	ab->ctx = ctx;
>   	ab->gfp_mask = gfp_mask;
> +	INIT_LIST_HEAD(&ab->aux_records);
>   
>   	return ab;
>   
> @@ -1825,7 +1836,6 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
>   				     int type)
>   {
>   	struct audit_buffer *ab;
> -	struct audit_stamp stamp;
>   
>   	if (audit_initialized != AUDIT_INITIALIZED)
>   		return NULL;
> @@ -1880,14 +1890,14 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
>   		return NULL;
>   	}
>   
> -	audit_get_stamp(ab->ctx, &stamp);
> +	audit_get_stamp(ab->ctx, &ab->stamp);
>   	/* cancel dummy context to enable supporting records */
>   	if (ctx)
>   		ctx->dummy = 0;
>   	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
> -			 (unsigned long long)stamp.ctime.tv_sec,
> -			 stamp.ctime.tv_nsec/1000000,
> -			 stamp.serial);
> +			 (unsigned long long)ab->stamp.ctime.tv_sec,
> +			 ab->stamp.ctime.tv_nsec/1000000,
> +			 ab->stamp.serial);
>   
>   	return ab;
>   }
> @@ -2378,7 +2388,7 @@ int audit_signal_info(int sig, struct task_struct *t)
>   }
>   
>   /**
> - * audit_log_end - end one audit record
> + * __audit_log_end - end one audit record
>    * @ab: the audit_buffer
>    *
>    * We can not do a netlink send inside an irq context because it blocks (last
> @@ -2386,7 +2396,7 @@ int audit_signal_info(int sig, struct task_struct *t)
>    * queue and a kthread is scheduled to remove them from the queue outside the
>    * irq context.  May be called in any context.
>    */
> -void audit_log_end(struct audit_buffer *ab)
> +void __audit_log_end(struct audit_buffer *ab)
>   {
>   	struct sk_buff *skb;
>   	struct nlmsghdr *nlh;
> @@ -2408,6 +2418,60 @@ void audit_log_end(struct audit_buffer *ab)
>   		wake_up_interruptible(&kauditd_wait);
>   	} else
>   		audit_log_lost("rate limit exceeded");
> +}
> +
> +/**
> + * audit_log_end - end one audit record
> + * @ab: the audit_buffer
> + *
> + * Let __audit_log_end() handle the message while the buffer housekeeping
> + * is done here.
> + * If there are other records that have been deferred for the event
> + * create them here.
> + */
> +void audit_log_end(struct audit_buffer *ab)
> +{
> +	struct audit_context_entry *entry;
> +	struct audit_context mcontext;
> +	struct audit_context *mctx;
> +	struct audit_buffer *mab;
> +	struct list_head *l;
> +	struct list_head *n;
> +
> +	if (!ab)
> +		return;
> +
> +	__audit_log_end(ab);
> +
> +	if (list_empty(&ab->aux_records)) {
> +		audit_buffer_free(ab);
> +		return;
> +	}
> +
> +	if (ab->ctx == NULL) {
> +		mcontext.stamp = ab->stamp;
> +		mctx = &mcontext;
> +	} else
> +		mctx = ab->ctx;
> +
> +	list_for_each_safe(l, n, &ab->aux_records) {
> +		entry = list_entry(l, struct audit_context_entry, list);
> +		mab = audit_log_start(mctx, ab->gfp_mask, entry->type);
> +		if (!mab) {
> +			audit_panic("alloc error in audit_log_end");
> +			continue;
> +		}
> +		switch (entry->type) {
> +		/* Don't know of any quite yet. */
> +		default:
> +			audit_panic("Unknown type in audit_log_end");
> +			break;
> +		}
> +		__audit_log_end(mab);
> +		audit_buffer_free(mab);
> +		list_del(&entry->list);
> +		kfree(entry);
> +	}
>   
>   	audit_buffer_free(ab);
>   }
