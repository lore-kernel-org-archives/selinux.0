Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A4FC43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 18:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC9E21582
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 18:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="pKK/eiPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfLQSBY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:01:24 -0500
Received: from UCOL19PA36.eemsg.mail.mil ([214.24.24.196]:56424 "EHLO
        UCOL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfLQSBV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 13:01:21 -0500
X-EEMSG-check-017: 62359766|UCOL19PA36_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="62359766"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Dec 2019 18:01:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576605675; x=1608141675;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yTa6NRlgFc6EYDVKSMi1IT2gGWbnO5gHna740xQFpc0=;
  b=pKK/eiPKae9rmKYqbplBTTO9aGrQhJRl9Nk3bRnkJJP9KgEriq+XLW8d
   7Ytv/4uo4vBvHoIz1YI1kzUMNW/eJTIT5ULH1qeCo8Qc+TFPwtsZYswuV
   yOjIx7vDETPhtIvR3FEo0V9GtVy0JGMGKHmBqFcqXzUPC+/U/C3slmpy5
   t1w9Ai1Idzv94aHO2/eBigGEipTRypROijswhx1lnXC9pwOqV8APtfONs
   +NK+QDu+X9+7D1Z6u7U5YW60ZF17D2uyRPM0wCSqu6EouNkFs3agA7aR0
   w6FgTgflITnRYc70BMqqbfN8DWR4E7zn9fPVHN3bYvNDBvUxSwEnYVwAW
   A==;
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="31198251"
IronPort-PHdr: =?us-ascii?q?9a23=3ABLROZBeZ8rOl1kRkWzf+qc7OlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc2+YxCN2/xhgRfzUJnB7Loc0qyK6vumAzRfqs/Z6zgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNcajZdgJ6o+1x?=
 =?us-ascii?q?fFvnVFcPlKyG11Il6egwzy7dqq8p559CRQtfMh98peXqj/Yq81U79WAik4Pm?=
 =?us-ascii?q?4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WS?=
 =?us-ascii?q?m+76puVRTlhjsLOyI//WrKkcF7kr5Vrwy9qBx+247UYZ+aNPxifqPGYNgWQX?=
 =?us-ascii?q?NNUttNWyBdB4+xaYUAD/AFPe1FsYfzoVUApga6CQW1Gu/izjpEi3nr1qM4zu?=
 =?us-ascii?q?shCxnL0hE+EdIAsHrar9v7O6kdXu+30KbGwi7Ob+9U1Drn9ITEbh4srPOKUL?=
 =?us-ascii?q?ltccTR004vFwbdg1uNtYzqISuV1uQTvGid8uFuSOevhHQjqwF1vDeuxtonh4?=
 =?us-ascii?q?7Sho0I0VDJ7jl5wYYpKt24T053e9ikEIBKuC2AOIt2Rd0iTnhutS0nybMGoY?=
 =?us-ascii?q?a2cDUFxZko3RLSa+GLf5KW7h/sSuqdOyp0iXR4c7ylnRmy61KvyujkW8mx11?=
 =?us-ascii?q?ZFszRKn8HXtnAIyxzT8s+HSuZh/ku52TaAyQTT6uZcLEAoj6XbMZ8hwqMrlp?=
 =?us-ascii?q?YJsETDGCH2mELtjKCIakoo4PSo6uT7bbXmoZ+QLYl0hR3lMqsygMC/BOU4Mg?=
 =?us-ascii?q?wWU2ia/+SzyqHj8FXkTLhFgfA6iKnUvI3AKcgFqaO1HRVZ3ps75xa6FTim0d?=
 =?us-ascii?q?AYnXcdLFJCfRKKl5PpNEzVIP3jEfe+g0ijkDdsx/zcOL3hGY/CImLMkLfmY7?=
 =?us-ascii?q?Zx81RcxxYrzdBD+5JUDakML+7pVU/qqtPZDgQ0MxeozObnEtp9y40eWWaRDa?=
 =?us-ascii?q?+DKa/drUWH6vgzLOmLYY8foCz9JOQ95/7ykX85nkcQcrWz0psMdn+5Hu5qI1?=
 =?us-ascii?q?6FbnrsmNgBDGkKvg4gQ+zwk1CCUDhTZ2qsUKI4/D00FIWmDYLbTIC3nLOBxD?=
 =?us-ascii?q?u7HoFRZm1eCFCMFHDod5+eW/cNcyKfOclhnSYBVbe/So8tzxautBX1y7B/NO?=
 =?us-ascii?q?rb5jUYtY7/1Nhy/+DTkRAy9TppD8WSym2NVH97kX8VRz8s3aB/vUx8xk6G0a?=
 =?us-ascii?q?h/nvNYCNhT6O1SXwckOp7T0fZ6B8rxWg3fZNeJTkipQtG8DTE2VNIxzMcEY1?=
 =?us-ascii?q?xhFNW6khDDwy2qDqcOl7OVAJw086Tc32X+Jstm1XbG27cuj0M8TstMK2KmnK?=
 =?us-ascii?q?h/+BbXB4LTlEWZjamqf7wG3CHR7GeD0XaOvEZAXQ5zT6rKQ2sfaVfRrdT+5U?=
 =?us-ascii?q?PPVKOhCbQ9MgtGzM6CK7ZKatjzgVVBXvfjN8zUY3itlGeoGRaI2rSMYZLoe2?=
 =?us-ascii?q?Ua3CXdDlIIkwIU/XaGLwc+ADyhrHzYDDF1CV3geUXs8e54qHO6UkA71QWKY1?=
 =?us-ascii?q?d92Lqy/x4fneacRO8L3rIYpCchrC15HE6j0NLQBNqAugthfKNFbdM+/lhHz2?=
 =?us-ascii?q?TZuBJ5PpG7LqBun1oecwNpv0zwzRl3EZ9Pkcs3rHMw1gV+M6SY301bezOaxZ?=
 =?us-ascii?q?D6IqfXJXXq/BCzd67W3UnT0M6M9acS7PQ1sE3jsxu0Fkom6nln1t5V03yG5p?=
 =?us-ascii?q?rUFgYdTZXxUkNkvyR98prTeSQsr7jf1XRxP625qHeW0NsyCfoN0R2gdspRNK?=
 =?us-ascii?q?6eUQT7VcYdAp7qYOcjgFW4KAkPPOlP+qo5JeunceeL3OigO+Mk1DCjin5d4Z?=
 =?us-ascii?q?tV1EuJ+is6TfTHm94BwveFzk6cWjzhlla9o4XynoxZYTw6AGWy027nCZRXa6?=
 =?us-ascii?q?k0epwETS+1Lsm2wMhur4DiVmQe91O5AV4Cnsizdkm8dVv4iDZM2FwXrHrvoi?=
 =?us-ascii?q?6xyzh5gnl9taaE9DDfyOTlMhwcMyhEQ3c03gSkGpS9k91PBBvgVAMujhbwoB?=
 =?us-ascii?q?+glqU=3D?=
X-IPAS-Result: =?us-ascii?q?A2BMAAADF/ld/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBbSASKoQEiQOGeAaBEiWJaooihyMJAQEBAQEBAQEBNwEBh?=
 =?us-ascii?q?EACgjw4EwIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIwQRQRALGAICJgICV?=
 =?us-ascii?q?wYBDAYCAQGCXz+CUyWuN38zhU+DQIFIgQ4ojDJ5gQeBEScMA4JdPodZgl4El?=
 =?us-ascii?q?ithRpczgj6CQpNIBhuaSS2OIJxeIoFYKwgCGAghDzuCbFARFI0eF45BIwMwk?=
 =?us-ascii?q?X0BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Dec 2019 18:01:13 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBHI0me5156079;
        Tue, 17 Dec 2019 13:00:51 -0500
Subject: Re: [PATCH v12 07/25] LSM: Use lsmblob in security_secid_to_secctx
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-8-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a0d3ed20-d82d-6577-04a9-f58dc632e2ca@tycho.nsa.gov>
Date:   Tue, 17 Dec 2019 13:01:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-8-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:36 PM, Casey Schaufler wrote:
> Change security_secid_to_secctx() to take a lsmblob as input
> instead of a u32 secid. It will then call the LSM hooks
> using the lsmblob element allocated for that module. The
> callers have been updated as well. This allows for the
> possibility that more than one module may be called upon
> to translate a secid to a string, as can occur in the
> audit code.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: netdev@vger.kernel.org

Same question as earlier about netdev, but otherwise:
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   drivers/android/binder.c                |  4 +++-
>   include/linux/security.h                |  5 +++--
>   include/net/scm.h                       |  5 ++---
>   kernel/audit.c                          |  9 +++++++--
>   kernel/auditsc.c                        | 14 ++++++++++----
>   net/ipv4/ip_sockglue.c                  |  3 +--
>   net/netfilter/nf_conntrack_netlink.c    |  8 ++++++--
>   net/netfilter/nf_conntrack_standalone.c |  4 +++-
>   net/netfilter/nfnetlink_queue.c         |  8 ++++++--
>   net/netlabel/netlabel_unlabeled.c       | 18 ++++++++++++++----
>   net/netlabel/netlabel_user.c            |  6 +++---
>   security/security.c                     | 16 +++++++++++++---
>   12 files changed, 71 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index e9bc9fcc7ea5..cd7a5f446457 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3105,10 +3105,12 @@ static void binder_transaction(struct binder_proc *proc,
>   
>   	if (target_node && target_node->txn_security_ctx) {
>   		u32 secid;
> +		struct lsmblob blob;
>   		size_t added_size;
>   
>   		security_task_getsecid(proc->tsk, &secid);
> -		ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
> +		lsmblob_init(&blob, secid);
> +		ret = security_secid_to_secctx(&blob, &secctx, &secctx_sz);
>   		if (ret) {
>   			return_error = BR_FAILED_REPLY;
>   			return_error_param = ret;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 8cae9e4bd760..26b8cee65c64 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -495,7 +495,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>   			 size_t size);
>   int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>   int security_ismaclabel(const char *name);
> -int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
> +int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen);
>   int security_secctx_to_secid(const char *secdata, u32 seclen,
>   			     struct lsmblob *blob);
>   void security_release_secctx(char *secdata, u32 seclen);
> @@ -1296,7 +1296,8 @@ static inline int security_ismaclabel(const char *name)
>   	return 0;
>   }
>   
> -static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
> +static inline int security_secid_to_secctx(struct lsmblob *blob,
> +					   char **secdata, u32 *seclen)
>   {
>   	return -EOPNOTSUPP;
>   }
> diff --git a/include/net/scm.h b/include/net/scm.h
> index e2e71c4bf9d0..31ae605fcc0a 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -97,9 +97,8 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
>   	int err;
>   
>   	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
> -		/* Scaffolding - it has to be element 0 for now */
> -		err = security_secid_to_secctx(scm->lsmblob.secid[0],
> -					       &secdata, &seclen);
> +		err = security_secid_to_secctx(&scm->lsmblob, &secdata,
> +					       &seclen);
>   
>   		if (!err) {
>   			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 8e09f0f55b4b..e3e515158295 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1417,7 +1417,10 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>   	case AUDIT_SIGNAL_INFO:
>   		len = 0;
>   		if (audit_sig_sid) {
> -			err = security_secid_to_secctx(audit_sig_sid, &ctx, &len);
> +			struct lsmblob blob;
> +
> +			lsmblob_init(&blob, audit_sig_sid);
> +			err = security_secid_to_secctx(&blob, &ctx, &len);
>   			if (err)
>   				return err;
>   		}
> @@ -2060,12 +2063,14 @@ int audit_log_task_context(struct audit_buffer *ab)
>   	unsigned len;
>   	int error;
>   	u32 sid;
> +	struct lsmblob blob;
>   
>   	security_task_getsecid(current, &sid);
>   	if (!sid)
>   		return 0;
>   
> -	error = security_secid_to_secctx(sid, &ctx, &len);
> +	lsmblob_init(&blob, sid);
> +	error = security_secid_to_secctx(&blob, &ctx, &len);
>   	if (error) {
>   		if (error != -EINVAL)
>   			goto error_path;
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 7566e5b1c419..04803c3099b2 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -966,6 +966,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>   	char *ctx = NULL;
>   	u32 len;
>   	int rc = 0;
> +	struct lsmblob blob;
>   
>   	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
>   	if (!ab)
> @@ -975,7 +976,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>   			 from_kuid(&init_user_ns, auid),
>   			 from_kuid(&init_user_ns, uid), sessionid);
>   	if (sid) {
> -		if (security_secid_to_secctx(sid, &ctx, &len)) {
> +		lsmblob_init(&blob, sid);
> +		if (security_secid_to_secctx(&blob, &ctx, &len)) {
>   			audit_log_format(ab, " obj=(none)");
>   			rc = 1;
>   		} else {
> @@ -1218,7 +1220,10 @@ static void show_special(struct audit_context *context, int *call_panic)
>   		if (osid) {
>   			char *ctx = NULL;
>   			u32 len;
> -			if (security_secid_to_secctx(osid, &ctx, &len)) {
> +			struct lsmblob blob;
> +
> +			lsmblob_init(&blob, osid);
> +			if (security_secid_to_secctx(&blob, &ctx, &len)) {
>   				audit_log_format(ab, " osid=%u", osid);
>   				*call_panic = 1;
>   			} else {
> @@ -1368,9 +1373,10 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
>   	if (n->osid != 0) {
>   		char *ctx = NULL;
>   		u32 len;
> +		struct lsmblob blob;
>   
> -		if (security_secid_to_secctx(
> -			n->osid, &ctx, &len)) {
> +		lsmblob_init(&blob, n->osid);
> +		if (security_secid_to_secctx(&blob, &ctx, &len)) {
>   			audit_log_format(ab, " osid=%u", n->osid);
>   			if (call_panic)
>   				*call_panic = 2;
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index 6cf57d5ac899..1ca97d0cb4a9 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -139,8 +139,7 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
>   	if (err)
>   		return;
>   
> -	/* Scaffolding - it has to be element 0 */
> -	err = security_secid_to_secctx(lb.secid[0], &secdata, &seclen);
> +	err = security_secid_to_secctx(&lb, &secdata, &seclen);
>   	if (err)
>   		return;
>   
> diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
> index d8d33ef52ce0..873dbd95f84a 100644
> --- a/net/netfilter/nf_conntrack_netlink.c
> +++ b/net/netfilter/nf_conntrack_netlink.c
> @@ -331,8 +331,10 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
>   	struct nlattr *nest_secctx;
>   	int len, ret;
>   	char *secctx;
> +	struct lsmblob blob;
>   
> -	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
> +	lsmblob_init(&blob, ct->secmark);
> +	ret = security_secid_to_secctx(&blob, &secctx, &len);
>   	if (ret)
>   		return 0;
>   
> @@ -643,8 +645,10 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
>   {
>   #ifdef CONFIG_NF_CONNTRACK_SECMARK
>   	int len, ret;
> +	struct lsmblob blob;
>   
> -	ret = security_secid_to_secctx(ct->secmark, NULL, &len);
> +	lsmblob_init(&blob, ct->secmark);
> +	ret = security_secid_to_secctx(&blob, NULL, &len);
>   	if (ret)
>   		return 0;
>   
> diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
> index 410809c669e1..183a85412155 100644
> --- a/net/netfilter/nf_conntrack_standalone.c
> +++ b/net/netfilter/nf_conntrack_standalone.c
> @@ -175,8 +175,10 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
>   	int ret;
>   	u32 len;
>   	char *secctx;
> +	struct lsmblob blob;
>   
> -	ret = security_secid_to_secctx(ct->secmark, &secctx, &len);
> +	lsmblob_init(&blob, ct->secmark);
> +	ret = security_secid_to_secctx(&blob, &secctx, &len);
>   	if (ret)
>   		return;
>   
> diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
> index feabdfb22920..bfa7f12fde99 100644
> --- a/net/netfilter/nfnetlink_queue.c
> +++ b/net/netfilter/nfnetlink_queue.c
> @@ -305,13 +305,17 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
>   {
>   	u32 seclen = 0;
>   #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
> +	struct lsmblob blob;
> +
>   	if (!skb || !sk_fullsock(skb->sk))
>   		return 0;
>   
>   	read_lock_bh(&skb->sk->sk_callback_lock);
>   
> -	if (skb->secmark)
> -		security_secid_to_secctx(skb->secmark, secdata, &seclen);
> +	if (skb->secmark) {
> +		lsmblob_init(&blob, skb->secmark);
> +		security_secid_to_secctx(&blob, secdata, &seclen);
> +	}
>   
>   	read_unlock_bh(&skb->sk->sk_callback_lock);
>   #endif
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index 7a5a87f15736..0cda17cb44a0 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -375,6 +375,7 @@ int netlbl_unlhsh_add(struct net *net,
>   	struct audit_buffer *audit_buf = NULL;
>   	char *secctx = NULL;
>   	u32 secctx_len;
> +	struct lsmblob blob;
>   
>   	if (addr_len != sizeof(struct in_addr) &&
>   	    addr_len != sizeof(struct in6_addr))
> @@ -437,7 +438,8 @@ int netlbl_unlhsh_add(struct net *net,
>   unlhsh_add_return:
>   	rcu_read_unlock();
>   	if (audit_buf != NULL) {
> -		if (security_secid_to_secctx(secid,
> +		lsmblob_init(&blob, secid);
> +		if (security_secid_to_secctx(&blob,
>   					     &secctx,
>   					     &secctx_len) == 0) {
>   			audit_log_format(audit_buf, " sec_obj=%s", secctx);
> @@ -474,6 +476,7 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>   	struct net_device *dev;
>   	char *secctx;
>   	u32 secctx_len;
> +	struct lsmblob blob;
>   
>   	spin_lock(&netlbl_unlhsh_lock);
>   	list_entry = netlbl_af4list_remove(addr->s_addr, mask->s_addr,
> @@ -493,8 +496,10 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>   					  addr->s_addr, mask->s_addr);
>   		if (dev != NULL)
>   			dev_put(dev);
> +		if (entry != NULL)
> +			lsmblob_init(&blob, entry->secid);
>   		if (entry != NULL &&
> -		    security_secid_to_secctx(entry->secid,
> +		    security_secid_to_secctx(&blob,
>   					     &secctx, &secctx_len) == 0) {
>   			audit_log_format(audit_buf, " sec_obj=%s", secctx);
>   			security_release_secctx(secctx, secctx_len);
> @@ -536,6 +541,7 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>   	struct net_device *dev;
>   	char *secctx;
>   	u32 secctx_len;
> +	struct lsmblob blob;
>   
>   	spin_lock(&netlbl_unlhsh_lock);
>   	list_entry = netlbl_af6list_remove(addr, mask, &iface->addr6_list);
> @@ -554,8 +560,10 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>   					  addr, mask);
>   		if (dev != NULL)
>   			dev_put(dev);
> +		if (entry != NULL)
> +			lsmblob_init(&blob, entry->secid);
>   		if (entry != NULL &&
> -		    security_secid_to_secctx(entry->secid,
> +		    security_secid_to_secctx(&blob,
>   					     &secctx, &secctx_len) == 0) {
>   			audit_log_format(audit_buf, " sec_obj=%s", secctx);
>   			security_release_secctx(secctx, secctx_len);
> @@ -1076,6 +1084,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>   	u32 secid;
>   	char *secctx;
>   	u32 secctx_len;
> +	struct lsmblob blob;
>   
>   	data = genlmsg_put(cb_arg->skb, NETLINK_CB(cb_arg->nl_cb->skb).portid,
>   			   cb_arg->seq, &netlbl_unlabel_gnl_family,
> @@ -1130,7 +1139,8 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>   		secid = addr6->secid;
>   	}
>   
> -	ret_val = security_secid_to_secctx(secid, &secctx, &secctx_len);
> +	lsmblob_init(&blob, secid);
> +	ret_val = security_secid_to_secctx(&blob, &secctx, &secctx_len);
>   	if (ret_val != 0)
>   		goto list_cb_failure;
>   	ret_val = nla_put(cb_arg->skb,
> diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
> index 3ed4fea2a2de..893301ae0131 100644
> --- a/net/netlabel/netlabel_user.c
> +++ b/net/netlabel/netlabel_user.c
> @@ -86,6 +86,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
>   	struct audit_buffer *audit_buf;
>   	char *secctx;
>   	u32 secctx_len;
> +	struct lsmblob blob;
>   
>   	if (audit_enabled == AUDIT_OFF)
>   		return NULL;
> @@ -98,10 +99,9 @@ struct audit_buffer *netlbl_audit_start_common(int type,
>   			 from_kuid(&init_user_ns, audit_info->loginuid),
>   			 audit_info->sessionid);
>   
> +	lsmblob_init(&blob, audit_info->secid);
>   	if (audit_info->secid != 0 &&
> -	    security_secid_to_secctx(audit_info->secid,
> -				     &secctx,
> -				     &secctx_len) == 0) {
> +	    security_secid_to_secctx(&blob, &secctx, &secctx_len) == 0) {
>   		audit_log_format(audit_buf, " subj=%s", secctx);
>   		security_release_secctx(secctx, secctx_len);
>   	}
> diff --git a/security/security.c b/security/security.c
> index 03ac668c0c10..61571f5c7c5f 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1963,10 +1963,20 @@ int security_ismaclabel(const char *name)
>   }
>   EXPORT_SYMBOL(security_ismaclabel);
>   
> -int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
> +int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
>   {
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
>   }
>   EXPORT_SYMBOL(security_secid_to_secctx);
>   
> 

