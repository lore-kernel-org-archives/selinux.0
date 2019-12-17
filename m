Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C219EC43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 17:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C876206E0
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 17:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="eHmnCBTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLQRvT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 12:51:19 -0500
Received: from UHIL19PA39.eemsg.mail.mil ([214.24.21.198]:7924 "EHLO
        UHIL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfLQRvT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 12:51:19 -0500
X-EEMSG-check-017: 58264110|UHIL19PA39_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="58264110"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Dec 2019 17:51:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576605077; x=1608141077;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=xCqLk3wG5K1hPC3hZQ/p+I9h4C2UM/u3COfmpXC12sA=;
  b=eHmnCBTANUaNqrEj6HASoyHrRfEUbNdiCI9+eSdbpntrqqpOs5fP4hG+
   DP8kgCSDR8asJOJnGV+rh109TV71PHZSF9fvr3J8+Upkcz5rsH71SxzFJ
   ZBEyDIj5/7F4wgBLZITN2/guSugv9LhgdaHPZxf8gPyJhlmNqsPwbwHhv
   S4pgwdKn36W2U9RxSSMF6eG3fRIObJD6P5KHmMGQ5pps2gwYNUvGOM5HL
   7rm6+IJPlQ92sdqAJ8gNbNVn6PFsBARV3lLnEfYcYJb8hw9KP7NQrX+3u
   qenh6CxSLcKZb5hMCGRFJaNSSBuJ6SatBLbk+yu7pGnYj/EIY0Ex57U3G
   A==;
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="36856175"
IronPort-PHdr: =?us-ascii?q?9a23=3A0vT/TB+o1h0RTv9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+1+0SIJqq85mqBkHD//Il1AaPAdyAragc1KGP6/uocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalsIBmqrwjdudQajZdsJ60s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlTwKPCAl/m7JlsNwjbpboBO/qBx5347Ue5yeOP5ncq/AYd8WWW?=
 =?us-ascii?q?9NU8BfWCxbBoO3cpUBAewPM+1Fq4XxvkUCoB+7CQSqGejhyCJHhmXu0KMnze?=
 =?us-ascii?q?ohHwHI0g8uEd0Av3vbrsn6OqgJXOCpzqTF1ynPY+9Y1Dr/7oXDbxAvoeuLXb?=
 =?us-ascii?q?J1acff1FUvGB3djlWQt4PlOS6e2PkIs2eB6+pgUfygim46oAx2uTig29wsh5?=
 =?us-ascii?q?LVhoMV1l/E9SJ5zJwzJd2jUkF3e9GkEJxOtyyDMYZ9X8AsQ3lwtSonxbALto?=
 =?us-ascii?q?S3cSgXxJg92RLSZOKLf5KV7h/lSe2fOy13hGh/d7K6nxuy9E+gxfDiWcSsy1?=
 =?us-ascii?q?ZKqzZFksHLtnAQyxzf8siHReV5/kemwTuPyxrc6vtFIUApjqrXMZ8hwrg+lp?=
 =?us-ascii?q?oUqkTMADP5lF/qjK6Wakok+u+o5/7hYrr6vZ+TK5V4igT/MqQqgsC/AOI4PR?=
 =?us-ascii?q?YSX2WD5Oix27Lu8Vf5TblXlPE6jKbUvI7AKcgGvqK5BhVa0ocn6xaxFTem19?=
 =?us-ascii?q?EYkGEcLF1YYxKKlJTpOlHSL/D4CvezmVKskCxxyPzcMb3hBYvNImDZkLj9Zb?=
 =?us-ascii?q?Z991JcyA0rwN9D/Z1UEa8OIfLoV0/qqNPYDgU2MxG6w+bjFtp9zJoSVn6VDa?=
 =?us-ascii?q?ODLKzStlqI7Po1I+aQfI8VpCr9K/896vHyl3A5gkESfKmz0ZsMdH+4Hu5pI1?=
 =?us-ascii?q?iXYXronNgBC3wHvgs4TOz2llKCVSRfaGq1X6I5/js7Ep6pDZ/fRoCxh7yMxC?=
 =?us-ascii?q?W7HphRZmBcEFCMEGzoep6CW/gWbSKdPM5hniYDVbi7RI8rzQuuuxPiy7p7Mu?=
 =?us-ascii?q?rU/TUVtZbi1Nhz+u3Smgg+9SdqAMuBzmGNVWB0nn8IRjMv2aB/plFyykqH0a?=
 =?us-ascii?q?dmmPFYC9NT6O1TUgsgNp7T0fZ6C9bsVQLFZNuJT0ymQtq+CzErUt0x28MOY1?=
 =?us-ascii?q?p6G9i6lRDMwS6qA74Tl7yWC5056bzc33fvKMZn0XrG17cuj0MgQsRRMW2qnK?=
 =?us-ascii?q?l/9xLcB4TRiUWWi76qdbgA3C7K7GqDznSBs19DUAFsVqXFWnMfa1DKotT5/E?=
 =?us-ascii?q?PCSLquCbU6MgtE08KCLbFKatLxh1VcWPjjIMjeY362m2qoBxaIwbOMbIzwd2?=
 =?us-ascii?q?Uf2yXdCFILkwYI/XmYMwgzHTuurHjYDDxpE1LvYl/j/vN6qH+hUkA0yASKZV?=
 =?us-ascii?q?V717Wp4h4VmeCcS/QL07IcpighrTp0HEu839LQEtaApBRufL9aYdwj5FdKzm?=
 =?us-ascii?q?PZuxV5PpynMaBtmEQScx9tsEPtyhV3EJ9PndIsrHw01gZyK7qY2ktbdzyExZ?=
 =?us-ascii?q?DwJqHXKm7q8RC3caHWx1Xe3c2O+qgV9fQ4r0zvvASuFkol6XVozcNZ3Geb5p?=
 =?us-ascii?q?XPX0IuVsfaW1065lBBrLHTfyc56pmcgXZlKqSlmiTJ29s0Cu8o0FOrdpFUN6?=
 =?us-ascii?q?bSUEf5GtYXFo61I+wjhlatYwgsPeZO+apyNMSjM7OE3amxJud7tDSviGlGpo?=
 =?us-ascii?q?dn3QbE8yt6V/6NxJsO3uuZwhrCUjDwkVOsmt74lJoCZjwIGGe7jy/+C8oZfa?=
 =?us-ascii?q?B2fIAWGU+wLMCtgNZznZjgXzhf7lHwKUkB3ZqSZReKb1H7lTZV3EATrG3vzT?=
 =?us-ascii?q?C01BRogjopqeyZxyWIzOP8IklUclVXTXVv2A+/abO/iMoXCQ3xNVkk?=
X-IPAS-Result: =?us-ascii?q?A2ADAAAxFfld/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYFqBQEBAQELAYFzgW0gEiqEBIgjYIZ3BoE3iWqKIoUogXsJAQEBA?=
 =?us-ascii?q?QEBAQEBNwEBhEACgjw0CQ4CEAEBAQQBAQEBAQUDAQFshUOCOykBgnoBBSMEE?=
 =?us-ascii?q?UEQCxgCAiYCAlcGAQwGAgEBgl8/glMlrjV/M4VPgz6BSIEOKAGMMXmBB4ERJ?=
 =?us-ascii?q?w+CXT6HWYJeBJYrYUaXM4I+gkKTSAYbmkktjiCcRzmBWCsIAhgIIQ87gmxQE?=
 =?us-ascii?q?RSNHheOQSMDMJEeXwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 17 Dec 2019 17:51:16 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBHHoufY151707;
        Tue, 17 Dec 2019 12:50:56 -0500
Subject: Re: [PATCH v12 06/25] LSM: Use lsmblob in security_secctx_to_secid
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-7-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <95deb467-86a2-1b84-28fe-bd69dd250f8e@tycho.nsa.gov>
Date:   Tue, 17 Dec 2019 12:51:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-7-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:36 PM, Casey Schaufler wrote:
> Change security_secctx_to_secid() to fill in a lsmblob instead
> of a u32 secid. Multiple LSMs may be able to interpret the
> string, and this allows for setting whichever secid is
> appropriate. In some cases there is scaffolding where other
> interfaces have yet to be converted.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   include/linux/security.h          |  5 +++--
>   kernel/cred.c                     |  4 +---
>   net/netfilter/nft_meta.c          | 13 ++++++-------
>   net/netfilter/xt_SECMARK.c        |  5 ++++-
>   net/netlabel/netlabel_unlabeled.c | 14 ++++++++------
>   security/security.c               | 18 +++++++++++++++---
>   6 files changed, 37 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 995faba7393f..8cae9e4bd760 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -496,7 +496,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>   int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>   int security_ismaclabel(const char *name);
>   int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
> -int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
> +int security_secctx_to_secid(const char *secdata, u32 seclen,
> +			     struct lsmblob *blob);
>   void security_release_secctx(char *secdata, u32 seclen);
>   void security_inode_invalidate_secctx(struct inode *inode);
>   int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
> @@ -1302,7 +1303,7 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
>   
>   static inline int security_secctx_to_secid(const char *secdata,
>   					   u32 seclen,
> -					   u32 *secid)
> +					   struct lsmblob *blob)
>   {
>   	return -EOPNOTSUPP;
>   }
> diff --git a/kernel/cred.c b/kernel/cred.c
> index 846ac4b23c16..7fef90f3f10b 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -756,14 +756,12 @@ EXPORT_SYMBOL(set_security_override);
>   int set_security_override_from_ctx(struct cred *new, const char *secctx)
>   {
>   	struct lsmblob blob;
> -	u32 secid;
>   	int ret;
>   
> -	ret = security_secctx_to_secid(secctx, strlen(secctx), &secid);
> +	ret = security_secctx_to_secid(secctx, strlen(secctx), &blob);
>   	if (ret < 0)
>   		return ret;
>   
> -	lsmblob_init(&blob, secid);
>   	return set_security_override(new, &blob);
>   }
>   EXPORT_SYMBOL(set_security_override_from_ctx);
> diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
> index 9740b554fdb3..9b8066d02868 100644
> --- a/net/netfilter/nft_meta.c
> +++ b/net/netfilter/nft_meta.c
> @@ -625,21 +625,20 @@ static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
>   
>   static int nft_secmark_compute_secid(struct nft_secmark *priv)
>   {
> -	u32 tmp_secid = 0;
> +	struct lsmblob blob;
>   	int err;
>   
> -	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &tmp_secid);
> +	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &blob);
>   	if (err)
>   		return err;
>   
> -	if (!tmp_secid)
> -		return -ENOENT;

Unless I missed it, it seems like this test has been lost in the new logic?

> -
> -	err = security_secmark_relabel_packet(tmp_secid);
> +	/* Using le[0] is scaffolding */
> +	err = security_secmark_relabel_packet(blob.secid[0]);
>   	if (err)
>   		return err;
>   
> -	priv->secid = tmp_secid;
> +	/* Using le[0] is scaffolding */
> +	priv->secid = blob.secid[0];
>   	return 0;
>   }
>   
> diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
> index 2317721f3ecb..2d68416b4552 100644
> --- a/net/netfilter/xt_SECMARK.c
> +++ b/net/netfilter/xt_SECMARK.c
> @@ -45,13 +45,14 @@ secmark_tg(struct sk_buff *skb, const struct xt_action_param *par)
>   
>   static int checkentry_lsm(struct xt_secmark_target_info *info)
>   {
> +	struct lsmblob blob;
>   	int err;
>   
>   	info->secctx[SECMARK_SECCTX_MAX - 1] = '\0';
>   	info->secid = 0;
>   
>   	err = security_secctx_to_secid(info->secctx, strlen(info->secctx),
> -				       &info->secid);
> +				       &blob);
>   	if (err) {
>   		if (err == -EINVAL)
>   			pr_info_ratelimited("invalid security context \'%s\'\n",
> @@ -59,6 +60,8 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
>   		return err;
>   	}
>   
> +	/* scaffolding during the transition */
> +	info->secid = blob.secid[0];
>   	if (!info->secid) {
>   		pr_info_ratelimited("unable to map security context \'%s\'\n",
>   				    info->secctx);
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index d2e4ab8d1cb1..7a5a87f15736 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -881,7 +881,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
>   	void *addr;
>   	void *mask;
>   	u32 addr_len;
> -	u32 secid;
> +	struct lsmblob blob;
>   	struct netlbl_audit audit_info;
>   
>   	/* Don't allow users to add both IPv4 and IPv6 addresses for a
> @@ -905,12 +905,13 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
>   	ret_val = security_secctx_to_secid(
>   		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
>   				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
> -				  &secid);
> +				  &blob);
>   	if (ret_val != 0)
>   		return ret_val;
>   
> +	/* scaffolding with the [0] */
>   	return netlbl_unlhsh_add(&init_net,
> -				 dev_name, addr, mask, addr_len, secid,
> +				 dev_name, addr, mask, addr_len, blob.secid[0],
>   				 &audit_info);
>   }
>   
> @@ -932,7 +933,7 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
>   	void *addr;
>   	void *mask;
>   	u32 addr_len;
> -	u32 secid;
> +	struct lsmblob blob;
>   	struct netlbl_audit audit_info;
>   
>   	/* Don't allow users to add both IPv4 and IPv6 addresses for a
> @@ -954,12 +955,13 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
>   	ret_val = security_secctx_to_secid(
>   		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
>   				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
> -				  &secid);
> +				  &blob);
>   	if (ret_val != 0)
>   		return ret_val;
>   
> +	/* scaffolding with the [0] */
>   	return netlbl_unlhsh_add(&init_net,
> -				 NULL, addr, mask, addr_len, secid,
> +				 NULL, addr, mask, addr_len, blob.secid[0],
>   				 &audit_info);
>   }
>   
> diff --git a/security/security.c b/security/security.c
> index a3be3929a60a..03ac668c0c10 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1970,10 +1970,22 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>   }
>   EXPORT_SYMBOL(security_secid_to_secctx);
>   
> -int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
> +int security_secctx_to_secid(const char *secdata, u32 seclen,
> +			     struct lsmblob *blob)
>   {
> -	*secid = 0;
> -	return call_int_hook(secctx_to_secid, 0, secdata, seclen, secid);
> +	struct security_hook_list *hp;
> +	int rc;
> +
> +	lsmblob_init(blob, 0);
> +	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
> +		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +			continue;
> +		rc = hp->hook.secctx_to_secid(secdata, seclen,
> +					      &blob->secid[hp->lsmid->slot]);
> +		if (rc != 0)
> +			return rc;
> +	}
> +	return 0;
>   }
>   EXPORT_SYMBOL(security_secctx_to_secid);
>   
> 

