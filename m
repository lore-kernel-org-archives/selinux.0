Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCCDC43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 16:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9432176D
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 16:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="mxSDn1Ta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfLRQGG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:06:06 -0500
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:50502 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfLRQGF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 11:06:05 -0500
X-EEMSG-check-017: 39292651|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="39292651"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Dec 2019 16:06:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576685163; x=1608221163;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=dhHUj/rgcZnIuB67+UskFPGlb9yhIMYZXfvXQeiHGXM=;
  b=mxSDn1TaCOwDTge18WBUBheaAfO4h+kJoCLBJSa4oW3nf9GCW559RtNY
   B9sgHHNoK1VBWKDziW1KqtS1lF1Q5wKn6CZOrNHBOuYjWdNPAEVPBmmSA
   3Lyq3hsGsc3D9pMvl8rUK3BdLzF6DeZWl/ydGPGkNdPg3Tnx+ng9q7oWZ
   wYeE8on7g1/eMHcFhNDW+o59AoEkkWy4VkxM2KzJGGKOpUWTKex2947E3
   ko2J9hY8JJVCJFc404z0hNzvfojivNPanbdPuEG2SgECF/gYW6+uZpc5F
   e9KFHIGmDuftW46WKAdPUnndivzZBSCp4XFYuvIuYjZT+dS4RQyna5+Ej
   w==;
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="36911130"
IronPort-PHdr: =?us-ascii?q?9a23=3ALNQoYhdv5STW3+Sz1XrTVwqalGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc2+YxWN2/xhgRfzUJnB7Loc0qyK6vumAzRRqsnQ+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLqMUanY9vJqkzxx?=
 =?us-ascii?q?bNv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4yydYsPC/cKM/heoYfzulACqQKyCReoCe/qzDJDm3340rAg0+?=
 =?us-ascii?q?k5DA/IwgIgEdINvnraotr6O6UdXvy6wqTT0TXObelb1Svh5IXGcB0sp+yHU7?=
 =?us-ascii?q?JqccrWzEkiDx7LjkmOpoz9PzOayOINuHWG4eplT+2vj2onpB9xozOywcoskZ?=
 =?us-ascii?q?TGhpkOx1DY9SR23IY1JdqiRE59et6rCoFcty6dN4toW84vRXxjtiUiyrAepJ?=
 =?us-ascii?q?K2cycHxI4nyhLCcfCLbYeF7gz5WOqMJzpzmWhrd6ilhxmo9Eit0uj8Vs6p31?=
 =?us-ascii?q?lUtidFidzMtmwV1xzU98iHVuNx/ke/1jaL0ADe8v1ELloularaNp4h2aQ8lp?=
 =?us-ascii?q?sVsUTNGS/2g1v5g7OMekU4+umn9+TnYrL8qp+aK4B0kR3xPr4rmsy+BeQ0Kg?=
 =?us-ascii?q?kOX26F9uSgzLDv4EL0TbpQgvA2j6XVqo7WKMsFqqKjHgNZyoMj5Ay+Dzei3t?=
 =?us-ascii?q?QYh34HLFdddRKckofpIErDIOz4DPijg1Ssly1nx/bdPrL7GJnNIX/DkKn5cb?=
 =?us-ascii?q?Zn90Fc0BYzzcxY559MFr4OOunzVVHxtdHDFR82Lwy0zPz6CNVz0oMRR3iPDr?=
 =?us-ascii?q?aFP6zIq1OH+uUvI+yUbo8PpDn9M+Ql5+LpjXIhhVASZ7Kp0oUXaXyiBfRpP0?=
 =?us-ascii?q?WZbmDxgtcPFWcFoBA+QffriF2ETT5ceXKyU7gg6TE8DYKsFZ3DSZy1gLydwC?=
 =?us-ascii?q?e7GYVbZmJDClCLC3fobYSEW+wXZSKUOMBhlyILVbm7R48mzxGuuxfwy6B7Ie?=
 =?us-ascii?q?rM5i0YqZXj2cBx5+3SkxEy6DN1A92G026TU250g3kIRz4q3KF/uEB9z1CD3r?=
 =?us-ascii?q?Vlg/xcC9Ne/O1JUggkOp7G1eB6CM79WhjHftiXTFaqWNKmASs+Ttgp2d8Bf1?=
 =?us-ascii?q?59G8m+jhDExyeqGKEal7iKBJwy76Ld0GP8J9hyy3nYzqktlVomTdVVNW2gmK?=
 =?us-ascii?q?F/8xLfB4nTk0WWj6yqb7gT3DbR9GefymqDpEJYXxBuXqXeQX8fYUzWrdfi60?=
 =?us-ascii?q?zeT7+uE7MnMg5Ayc6fL6tGcNrpjU9JRP37ItTRf3qxm3usBRaP3r6Mbo3qe2?=
 =?us-ascii?q?Ub3CnHCkgElAAT8myANQglGCihpXnTAyB0GlLpZEPs9+h+p2+hQU8w1Q2Fc0?=
 =?us-ascii?q?ph17+t8B4PmfOcU+8T3q4DuCo5szV7AlC9393LC9qBoQptZaZcbs0n4FdBy2?=
 =?us-ascii?q?3ZsxdwPp25I6BmgV4ebRp4s1n11xptCYVAjNIqo2kwwAp0N62UylFBdyuA15?=
 =?us-ascii?q?DqJrLXMnXy/Ayoa6POwlHRysuW+qMU5fQgsVrjoQWpGlMn83Vg1NlVyWWT6o?=
 =?us-ascii?q?/WAwoVVJKiGnowojNzvLzLKhI254rJ23lhK+HguTbZ1sMBH+Alwwuue9pFda?=
 =?us-ascii?q?iNUgT1FpteT8OnM+E73UOibhsZMuRf7oY1Od+rc72N36vvdORlmyi8jH9v5o?=
 =?us-ascii?q?l430PK8DBzDqbM3pAY07SD0wCaTTbgnRKktczqnY1sez4fBCy8xDLiCYoXYb?=
 =?us-ascii?q?d9Oc4QBGOvJdCn7stxioSrWHNC8lOnQVQc15yHYx2XOmfh0BVQ2EJfmnmunS?=
 =?us-ascii?q?+13nQgiD0yhraO1yzJheL5fVwIPXAdFzoqtkvlPYXh14NSZ0OvdQV80UL/tE?=
 =?us-ascii?q?s=3D?=
X-IPAS-Result: =?us-ascii?q?A2BXAAAPTfpd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF8gXaBbSASKoQEiQOGVAEBAQEBBoE3iWqKIocjCQEBAQEBAQEBA?=
 =?us-ascii?q?TcBAYRAAoI9OBMCEAEBAQQBAQEBAQUDAQFshUOCOykBgnkBAQEBAgEaCQQRQ?=
 =?us-ascii?q?QULCxgCAiYCAlcGAQwGAgEBgl8/glMFIK0PdX8zhU+DOoFBgQ4oinqBOHmBB?=
 =?us-ascii?q?4ERJw+CXT6HWYJeBI1CiGthRpc1gj+CQ5NKBhuaTi2OIZxfIoFYKwgCGAghD?=
 =?us-ascii?q?zuCbFAYDY0eF45BIwMwjyABAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Dec 2019 16:06:01 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBIG5ZvV009184;
        Wed, 18 Dec 2019 11:05:37 -0500
Subject: Re: [PATCH v12 15/25] LSM: Use lsmcontext in security_secid_to_secctx
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-16-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0180f458-a97d-4d47-d106-b8463cfeeb66@tycho.nsa.gov>
Date:   Wed, 18 Dec 2019 11:06:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-16-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:36 PM, Casey Schaufler wrote:
> Replace the (secctx,seclen) pointer pair with a single
> lsmcontext pointer to allow return of the LSM identifier
> along with the context and context length. This allows
> security_release_secctx() to know how to release the
> context. Callers have been modified to use or save the
> returned data from the new structure.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: netdev@vger.kernel.org

Usual disclaimer about needing to make sure netdev and perhaps others 
(audit, binder?) have acked these changes.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   drivers/android/binder.c                | 26 +++++++---------
>   include/linux/security.h                |  4 +--
>   include/net/scm.h                       | 10 ++-----
>   kernel/audit.c                          | 29 +++++++-----------
>   kernel/auditsc.c                        | 31 +++++++------------
>   net/ipv4/ip_sockglue.c                  |  7 ++---
>   net/netfilter/nf_conntrack_netlink.c    | 14 +++++----
>   net/netfilter/nf_conntrack_standalone.c |  7 ++---
>   net/netfilter/nfnetlink_queue.c         |  5 +++-
>   net/netlabel/netlabel_unlabeled.c       | 40 ++++++++-----------------
>   net/netlabel/netlabel_user.c            |  7 ++---
>   security/security.c                     | 10 +++++--
>   12 files changed, 74 insertions(+), 116 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 1bca4d589e87..3c5eee35aae6 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2859,9 +2859,7 @@ static void binder_transaction(struct binder_proc *proc,
>   	binder_size_t last_fixup_min_off = 0;
>   	struct binder_context *context = proc->context;
>   	int t_debug_id = atomic_inc_return(&binder_last_id);
> -	char *secctx = NULL;
> -	u32 secctx_sz = 0;
> -	struct lsmcontext scaff; /* scaffolding */
> +	struct lsmcontext lsmctx = { };
>   
>   	e = binder_transaction_log_add(&binder_transaction_log);
>   	e->debug_id = t_debug_id;
> @@ -3109,14 +3107,14 @@ static void binder_transaction(struct binder_proc *proc,
>   		size_t added_size;
>   
>   		security_task_getsecid(proc->tsk, &blob);
> -		ret = security_secid_to_secctx(&blob, &secctx, &secctx_sz);
> +		ret = security_secid_to_secctx(&blob, &lsmctx);
>   		if (ret) {
>   			return_error = BR_FAILED_REPLY;
>   			return_error_param = ret;
>   			return_error_line = __LINE__;
>   			goto err_get_secctx_failed;
>   		}
> -		added_size = ALIGN(secctx_sz, sizeof(u64));
> +		added_size = ALIGN(lsmctx.len, sizeof(u64));
>   		extra_buffers_size += added_size;
>   		if (extra_buffers_size < added_size) {
>   			/* integer overflow of extra_buffers_size */
> @@ -3143,24 +3141,22 @@ static void binder_transaction(struct binder_proc *proc,
>   		t->buffer = NULL;
>   		goto err_binder_alloc_buf_failed;
>   	}
> -	if (secctx) {
> +	if (lsmctx.context) {
>   		int err;
>   		size_t buf_offset = ALIGN(tr->data_size, sizeof(void *)) +
>   				    ALIGN(tr->offsets_size, sizeof(void *)) +
>   				    ALIGN(extra_buffers_size, sizeof(void *)) -
> -				    ALIGN(secctx_sz, sizeof(u64));
> +				    ALIGN(lsmctx.len, sizeof(u64));
>   
>   		t->security_ctx = (uintptr_t)t->buffer->user_data + buf_offset;
>   		err = binder_alloc_copy_to_buffer(&target_proc->alloc,
>   						  t->buffer, buf_offset,
> -						  secctx, secctx_sz);
> +						  lsmctx.context, lsmctx.len);
>   		if (err) {
>   			t->security_ctx = 0;
>   			WARN_ON(1);
>   		}
> -		lsmcontext_init(&scaff, secctx, secctx_sz, 0);
> -		security_release_secctx(&scaff);
> -		secctx = NULL;
> +		security_release_secctx(&lsmctx);
>   	}
>   	t->buffer->debug_id = t->debug_id;
>   	t->buffer->transaction = t;
> @@ -3216,7 +3212,7 @@ static void binder_transaction(struct binder_proc *proc,
>   	off_end_offset = off_start_offset + tr->offsets_size;
>   	sg_buf_offset = ALIGN(off_end_offset, sizeof(void *));
>   	sg_buf_end_offset = sg_buf_offset + extra_buffers_size -
> -		ALIGN(secctx_sz, sizeof(u64));
> +		ALIGN(lsmctx.len, sizeof(u64));
>   	off_min = 0;
>   	for (buffer_offset = off_start_offset; buffer_offset < off_end_offset;
>   	     buffer_offset += sizeof(binder_size_t)) {
> @@ -3492,10 +3488,8 @@ static void binder_transaction(struct binder_proc *proc,
>   	binder_alloc_free_buf(&target_proc->alloc, t->buffer);
>   err_binder_alloc_buf_failed:
>   err_bad_extra_size:
> -	if (secctx) {
> -		lsmcontext_init(&scaff, secctx, secctx_sz, 0);
> -		security_release_secctx(&scaff);
> -	}
> +	if (lsmctx.context)
> +		security_release_secctx(&lsmctx);
>   err_get_secctx_failed:
>   	kfree(tcomplete);
>   	binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 597d9802b89b..00421941f683 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -530,7 +530,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>   			 size_t size);
>   int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>   int security_ismaclabel(const char *name);
> -int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen);
> +int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp);
>   int security_secctx_to_secid(const char *secdata, u32 seclen,
>   			     struct lsmblob *blob);
>   void security_release_secctx(struct lsmcontext *cp);
> @@ -1335,7 +1335,7 @@ static inline int security_ismaclabel(const char *name)
>   }
>   
>   static inline int security_secid_to_secctx(struct lsmblob *blob,
> -					   char **secdata, u32 *seclen)
> +					   struct lsmcontext *cp)
>   {
>   	return -EOPNOTSUPP;
>   }
> diff --git a/include/net/scm.h b/include/net/scm.h
> index 30ba801c91bd..4a6ad8caf423 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -93,18 +93,14 @@ static __inline__ int scm_send(struct socket *sock, struct msghdr *msg,
>   static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
>   {
>   	struct lsmcontext context;
> -	char *secdata;
> -	u32 seclen;
>   	int err;
>   
>   	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
> -		err = security_secid_to_secctx(&scm->lsmblob, &secdata,
> -					       &seclen);
> +		err = security_secid_to_secctx(&scm->lsmblob, &context);
>   
>   		if (!err) {
> -			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
> -			/*scaffolding*/
> -			lsmcontext_init(&context, secdata, seclen, 0);
> +			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY,
> +				 context.len, context.context);
>   			security_release_secctx(&context);
>   		}
>   	}
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 3305c4af43a8..224c7b4a1bc0 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1178,9 +1178,8 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>   	struct audit_buffer	*ab;
>   	u16			msg_type = nlh->nlmsg_type;
>   	struct audit_sig_info   *sig_data;
> -	char			*ctx = NULL;
>   	u32			len;
> -	struct lsmcontext	scaff; /* scaffolding */
> +	struct lsmcontext	context = { };
>   
>   	err = audit_netlink_ok(skb, msg_type);
>   	if (err)
> @@ -1418,25 +1417,22 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>   	case AUDIT_SIGNAL_INFO:
>   		len = 0;
>   		if (lsmblob_is_set(&audit_sig_lsm)) {
> -			err = security_secid_to_secctx(&audit_sig_lsm, &ctx,
> -						       &len);
> +			err = security_secid_to_secctx(&audit_sig_lsm,
> +						       &context);
>   			if (err)
>   				return err;
>   		}
>   		sig_data = kmalloc(sizeof(*sig_data) + len, GFP_KERNEL);
>   		if (!sig_data) {
> -			if (lsmblob_is_set(&audit_sig_lsm)) {
> -				lsmcontext_init(&scaff, ctx, len, 0);
> -				security_release_secctx(&scaff);
> -			}
> +			if (lsmblob_is_set(&audit_sig_lsm))
> +				security_release_secctx(&context);
>   			return -ENOMEM;
>   		}
>   		sig_data->uid = from_kuid(&init_user_ns, audit_sig_uid);
>   		sig_data->pid = audit_sig_pid;
>   		if (lsmblob_is_set(&audit_sig_lsm)) {
> -			memcpy(sig_data->ctx, ctx, len);
> -			lsmcontext_init(&scaff, ctx, len, 0);
> -			security_release_secctx(&scaff);
> +			memcpy(sig_data->ctx, context.context, context.len);
> +			security_release_secctx(&context);
>   		}
>   		audit_send_reply(skb, seq, AUDIT_SIGNAL_INFO, 0, 0,
>   				 sig_data, sizeof(*sig_data) + len);
> @@ -2061,26 +2057,23 @@ void audit_log_key(struct audit_buffer *ab, char *key)
>   
>   int audit_log_task_context(struct audit_buffer *ab)
>   {
> -	char *ctx = NULL;
> -	unsigned len;
>   	int error;
>   	struct lsmblob blob;
> -	struct lsmcontext scaff; /* scaffolding */
> +	struct lsmcontext context;
>   
>   	security_task_getsecid(current, &blob);
>   	if (!lsmblob_is_set(&blob))
>   		return 0;
>   
> -	error = security_secid_to_secctx(&blob, &ctx, &len);
> +	error = security_secid_to_secctx(&blob, &context);
>   	if (error) {
>   		if (error != -EINVAL)
>   			goto error_path;
>   		return 0;
>   	}
>   
> -	audit_log_format(ab, " subj=%s", ctx);
> -	lsmcontext_init(&scaff, ctx, len, 0);
> -	security_release_secctx(&scaff);
> +	audit_log_format(ab, " subj=%s", context.context);
> +	security_release_secctx(&context);
>   	return 0;
>   
>   error_path:
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 8790e7aafa7d..6d273183dd87 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -962,9 +962,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>   				 struct lsmblob *blob, char *comm)
>   {
>   	struct audit_buffer *ab;
> -	struct lsmcontext lsmcxt;
> -	char *ctx = NULL;
> -	u32 len;
> +	struct lsmcontext lsmctx;
>   	int rc = 0;
>   
>   	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
> @@ -975,13 +973,12 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>   			 from_kuid(&init_user_ns, auid),
>   			 from_kuid(&init_user_ns, uid), sessionid);
>   	if (lsmblob_is_set(blob)) {
> -		if (security_secid_to_secctx(blob, &ctx, &len)) {
> +		if (security_secid_to_secctx(blob, &lsmctx)) {
>   			audit_log_format(ab, " obj=(none)");
>   			rc = 1;
>   		} else {
> -			audit_log_format(ab, " obj=%s", ctx);
> -			lsmcontext_init(&lsmcxt, ctx, len, 0); /*scaffolding*/
> -			security_release_secctx(&lsmcxt);
> +			audit_log_format(ab, " obj=%s", lsmctx.context);
> +			security_release_secctx(&lsmctx);
>   		}
>   	}
>   	audit_log_format(ab, " ocomm=");
> @@ -1194,7 +1191,6 @@ static void audit_log_fcaps(struct audit_buffer *ab, struct audit_names *name)
>   
>   static void show_special(struct audit_context *context, int *call_panic)
>   {
> -	struct lsmcontext lsmcxt;
>   	struct audit_buffer *ab;
>   	int i;
>   
> @@ -1218,17 +1214,15 @@ static void show_special(struct audit_context *context, int *call_panic)
>   				 from_kgid(&init_user_ns, context->ipc.gid),
>   				 context->ipc.mode);
>   		if (osid) {
> -			char *ctx = NULL;
> -			u32 len;
> +			struct lsmcontext lsmcxt;
>   			struct lsmblob blob;
>   
>   			lsmblob_init(&blob, osid);
> -			if (security_secid_to_secctx(&blob, &ctx, &len)) {
> +			if (security_secid_to_secctx(&blob, &lsmcxt)) {
>   				audit_log_format(ab, " osid=%u", osid);
>   				*call_panic = 1;
>   			} else {
> -				audit_log_format(ab, " obj=%s", ctx);
> -				lsmcontext_init(&lsmcxt, ctx, len, 0);
> +				audit_log_format(ab, " obj=%s", lsmcxt.context);
>   				security_release_secctx(&lsmcxt);
>   			}
>   		}
> @@ -1372,20 +1366,17 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
>   				 MAJOR(n->rdev),
>   				 MINOR(n->rdev));
>   	if (n->osid != 0) {
> -		char *ctx = NULL;
> -		u32 len;
>   		struct lsmblob blob;
> -		struct lsmcontext lsmcxt;
> +		struct lsmcontext lsmctx;
>   
>   		lsmblob_init(&blob, n->osid);
> -		if (security_secid_to_secctx(&blob, &ctx, &len)) {
> +		if (security_secid_to_secctx(&blob, &lsmctx)) {
>   			audit_log_format(ab, " osid=%u", n->osid);
>   			if (call_panic)
>   				*call_panic = 2;
>   		} else {
> -			audit_log_format(ab, " obj=%s", ctx);
> -			lsmcontext_init(&lsmcxt, ctx, len, 0); /* scaffolding */
> -			security_release_secctx(&lsmcxt);
> +			audit_log_format(ab, " obj=%s", lsmctx.context);
> +			security_release_secctx(&lsmctx);
>   		}
>   	}
>   
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index 96d56a30ecca..27af7a6b8780 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -132,20 +132,17 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
>   {
>   	struct lsmcontext context;
>   	struct lsmblob lb;
> -	char *secdata;
> -	u32 seclen;
>   	int err;
>   
>   	err = security_socket_getpeersec_dgram(NULL, skb, &lb);
>   	if (err)
>   		return;
>   
> -	err = security_secid_to_secctx(&lb, &secdata, &seclen);
> +	err = security_secid_to_secctx(&lb, &context);
>   	if (err)
>   		return;
>   
> -	put_cmsg(msg, SOL_IP, SCM_SECURITY, seclen, secdata);
> -	lsmcontext_init(&context, secdata, seclen, 0); /* scaffolding */
> +	put_cmsg(msg, SOL_IP, SCM_SECURITY, context.len, context.context);
>   	security_release_secctx(&context);
>   }
>   
> diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
> index 2f233f40c926..255bcb886a2f 100644
> --- a/net/netfilter/nf_conntrack_netlink.c
> +++ b/net/netfilter/nf_conntrack_netlink.c
> @@ -329,13 +329,12 @@ static int ctnetlink_dump_mark(struct sk_buff *skb, const struct nf_conn *ct)
>   static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
>   {
>   	struct nlattr *nest_secctx;
> -	int len, ret;
> -	char *secctx;
> +	int ret;
>   	struct lsmblob blob;
>   	struct lsmcontext context;
>   
>   	lsmblob_init(&blob, ct->secmark);
> -	ret = security_secid_to_secctx(&blob, &secctx, &len);
> +	ret = security_secid_to_secctx(&blob, &context);
>   	if (ret)
>   		return 0;
>   
> @@ -344,13 +343,12 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
>   	if (!nest_secctx)
>   		goto nla_put_failure;
>   
> -	if (nla_put_string(skb, CTA_SECCTX_NAME, secctx))
> +	if (nla_put_string(skb, CTA_SECCTX_NAME, context.context))
>   		goto nla_put_failure;
>   	nla_nest_end(skb, nest_secctx);
>   
>   	ret = 0;
>   nla_put_failure:
> -	lsmcontext_init(&context, secctx, len, 0); /* scaffolding */
>   	security_release_secctx(&context);
>   	return ret;
>   }
> @@ -648,12 +646,16 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
>   #ifdef CONFIG_NF_CONNTRACK_SECMARK
>   	int len, ret;
>   	struct lsmblob blob;
> +	struct lsmcontext context;
>   
>   	lsmblob_init(&blob, ct->secmark);
> -	ret = security_secid_to_secctx(&blob, NULL, &len);
> +	ret = security_secid_to_secctx(&blob, &context);
>   	if (ret)
>   		return 0;
>   
> +	len = context.len;
> +	security_release_secctx(&context);
> +
>   	return nla_total_size(0) /* CTA_SECCTX */
>   	       + nla_total_size(sizeof(char) * len); /* CTA_SECCTX_NAME */
>   #else
> diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
> index 8601fcb99f7a..8969754d7fe9 100644
> --- a/net/netfilter/nf_conntrack_standalone.c
> +++ b/net/netfilter/nf_conntrack_standalone.c
> @@ -173,19 +173,16 @@ static void ct_seq_stop(struct seq_file *s, void *v)
>   static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
>   {
>   	int ret;
> -	u32 len;
> -	char *secctx;
>   	struct lsmblob blob;
>   	struct lsmcontext context;
>   
>   	lsmblob_init(&blob, ct->secmark);
> -	ret = security_secid_to_secctx(&blob, &secctx, &len);
> +	ret = security_secid_to_secctx(&blob, &context);
>   	if (ret)
>   		return;
>   
> -	seq_printf(s, "secctx=%s ", secctx);
> +	seq_printf(s, "secctx=%s ", context.context);
>   
> -	lsmcontext_init(&context, secctx, len, 0); /* scaffolding */
>   	security_release_secctx(&context);
>   }
>   #else
> diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
> index cc3ef03ee198..2d6668fd026c 100644
> --- a/net/netfilter/nfnetlink_queue.c
> +++ b/net/netfilter/nfnetlink_queue.c
> @@ -306,6 +306,7 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
>   	u32 seclen = 0;
>   #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
>   	struct lsmblob blob;
> +	struct lsmcontext context = { };
>   
>   	if (!skb || !sk_fullsock(skb->sk))
>   		return 0;
> @@ -314,10 +315,12 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
>   
>   	if (skb->secmark) {
>   		lsmblob_init(&blob, skb->secmark);
> -		security_secid_to_secctx(&blob, secdata, &seclen);
> +		security_secid_to_secctx(&blob, &context);
> +		*secdata = context.context;
>   	}
>   
>   	read_unlock_bh(&skb->sk->sk_callback_lock);
> +	seclen = context.len;
>   #endif
>   	return seclen;
>   }
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index 288c005b44c7..c03fe9a4f7b9 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -374,8 +374,6 @@ int netlbl_unlhsh_add(struct net *net,
>   	struct netlbl_unlhsh_iface *iface;
>   	struct audit_buffer *audit_buf = NULL;
>   	struct lsmcontext context;
> -	char *secctx = NULL;
> -	u32 secctx_len;
>   	struct lsmblob blob;
>   
>   	if (addr_len != sizeof(struct in_addr) &&
> @@ -440,12 +438,9 @@ int netlbl_unlhsh_add(struct net *net,
>   	rcu_read_unlock();
>   	if (audit_buf != NULL) {
>   		lsmblob_init(&blob, secid);
> -		if (security_secid_to_secctx(&blob,
> -					     &secctx,
> -					     &secctx_len) == 0) {
> -			audit_log_format(audit_buf, " sec_obj=%s", secctx);
> -			/* scaffolding */
> -			lsmcontext_init(&context, secctx, secctx_len, 0);
> +		if (security_secid_to_secctx(&blob, &context) == 0) {
> +			audit_log_format(audit_buf, " sec_obj=%s",
> +					 context.context);
>   			security_release_secctx(&context);
>   		}
>   		audit_log_format(audit_buf, " res=%u", ret_val == 0 ? 1 : 0);
> @@ -478,8 +473,6 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>   	struct audit_buffer *audit_buf;
>   	struct net_device *dev;
>   	struct lsmcontext context;
> -	char *secctx;
> -	u32 secctx_len;
>   	struct lsmblob blob;
>   
>   	spin_lock(&netlbl_unlhsh_lock);
> @@ -503,11 +496,9 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>   		if (entry != NULL)
>   			lsmblob_init(&blob, entry->secid);
>   		if (entry != NULL &&
> -		    security_secid_to_secctx(&blob,
> -					     &secctx, &secctx_len) == 0) {
> -			audit_log_format(audit_buf, " sec_obj=%s", secctx);
> -			/* scaffolding */
> -			lsmcontext_init(&context, secctx, secctx_len, 0);
> +		    security_secid_to_secctx(&blob, &context) == 0) {
> +			audit_log_format(audit_buf, " sec_obj=%s",
> +					 context.context);
>   			security_release_secctx(&context);
>   		}
>   		audit_log_format(audit_buf, " res=%u", entry != NULL ? 1 : 0);
> @@ -546,8 +537,6 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>   	struct audit_buffer *audit_buf;
>   	struct net_device *dev;
>   	struct lsmcontext context;
> -	char *secctx;
> -	u32 secctx_len;
>   	struct lsmblob blob;
>   
>   	spin_lock(&netlbl_unlhsh_lock);
> @@ -570,10 +559,9 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>   		if (entry != NULL)
>   			lsmblob_init(&blob, entry->secid);
>   		if (entry != NULL &&
> -		    security_secid_to_secctx(&blob,
> -					     &secctx, &secctx_len) == 0) {
> -			audit_log_format(audit_buf, " sec_obj=%s", secctx);
> -			lsmcontext_init(&context, secctx, secctx_len, 0);
> +		    security_secid_to_secctx(&blob, &context) == 0) {
> +			audit_log_format(audit_buf, " sec_obj=%s",
> +					 context.context);
>   			security_release_secctx(&context);
>   		}
>   		audit_log_format(audit_buf, " res=%u", entry != NULL ? 1 : 0);
> @@ -1091,8 +1079,6 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>   	struct lsmcontext context;
>   	void *data;
>   	u32 secid;
> -	char *secctx;
> -	u32 secctx_len;
>   	struct lsmblob blob;
>   
>   	data = genlmsg_put(cb_arg->skb, NETLINK_CB(cb_arg->nl_cb->skb).portid,
> @@ -1149,15 +1135,13 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>   	}
>   
>   	lsmblob_init(&blob, secid);
> -	ret_val = security_secid_to_secctx(&blob, &secctx, &secctx_len);
> +	ret_val = security_secid_to_secctx(&blob, &context);
>   	if (ret_val != 0)
>   		goto list_cb_failure;
>   	ret_val = nla_put(cb_arg->skb,
>   			  NLBL_UNLABEL_A_SECCTX,
> -			  secctx_len,
> -			  secctx);
> -	/* scaffolding */
> -	lsmcontext_init(&context, secctx, secctx_len, 0);
> +			  context.len,
> +			  context.context);
>   	security_release_secctx(&context);
>   	if (ret_val != 0)
>   		goto list_cb_failure;
> diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
> index ef139d8ae7cd..951ba0639d20 100644
> --- a/net/netlabel/netlabel_user.c
> +++ b/net/netlabel/netlabel_user.c
> @@ -85,8 +85,6 @@ struct audit_buffer *netlbl_audit_start_common(int type,
>   {
>   	struct audit_buffer *audit_buf;
>   	struct lsmcontext context;
> -	char *secctx;
> -	u32 secctx_len;
>   	struct lsmblob blob;
>   
>   	if (audit_enabled == AUDIT_OFF)
> @@ -102,9 +100,8 @@ struct audit_buffer *netlbl_audit_start_common(int type,
>   
>   	lsmblob_init(&blob, audit_info->secid);
>   	if (audit_info->secid != 0 &&
> -	    security_secid_to_secctx(&blob, &secctx, &secctx_len) == 0) {
> -		audit_log_format(audit_buf, " subj=%s", secctx);
> -		lsmcontext_init(&context, secctx, secctx_len, 0);/*scaffolding*/
> +	    security_secid_to_secctx(&blob, &context) == 0) {
> +		audit_log_format(audit_buf, " subj=%s", context.context);
>   		security_release_secctx(&context);
>   	}
>   
> diff --git a/security/security.c b/security/security.c
> index 6310ca7e84ed..4ba1a6ed36e0 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2109,18 +2109,22 @@ int security_ismaclabel(const char *name)
>   }
>   EXPORT_SYMBOL(security_ismaclabel);
>   
> -int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
> +int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp)
>   {
>   	struct security_hook_list *hp;
>   	int display = lsm_task_display(current);
>   
> +	memset(cp, 0, sizeof(*cp));
> +
>   	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
>   		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>   			continue;
> -		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
> +		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot) {
> +			cp->slot = hp->lsmid->slot;
>   			return hp->hook.secid_to_secctx(
>   					blob->secid[hp->lsmid->slot],
> -					secdata, seclen);
> +					&cp->context, &cp->len);
> +		}
>   	}
>   	return 0;
>   }
> 

