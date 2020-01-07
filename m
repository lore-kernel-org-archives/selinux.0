Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBD4C33C8C
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 17:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672CF2087F
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 17:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="dmB5+eLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgAGRpj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:45:39 -0500
Received: from UCOL19PA35.eemsg.mail.mil ([214.24.24.195]:26086 "EHLO
        UCOL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgAGRpi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jan 2020 12:45:38 -0500
X-EEMSG-check-017: 63835464|UCOL19PA35_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,406,1571702400"; 
   d="scan'208";a="63835464"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Jan 2020 17:45:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578419114; x=1609955114;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=rFvglodUSgjWHD2As41dilf+4yLUpU9iPJso3MF1mJk=;
  b=dmB5+eLojeYgxe4f3+P11HrvdBB8LigPFQOnakKaib+GhwmHtYTTr9CN
   w7ja09XCXNgeO9sgtvkGKFjhPJVdWg2ADptI1IH00QDGJsR7m6/QD8Qey
   DaFsREQ8DPsJr5BlIS8tEpkKrXkRbNl88CKwrXIhKZprwKCMjaI3Os2hv
   1lB06VoVWgbLdxcK9odE+2O7ZaFpunvH3222VISBHqBtpbjtKUgIxAlkG
   DTur8QKnnzPfv20t7fNs+XHPIQcojdOmc/NHxYQMF/3Ws8O4VMhbwmiaI
   LFjo06G94n5UMh07Zfg5QIbZwnwwaASVRIhTjpuCBeIEugy9WPVq2WPlM
   g==;
X-IronPort-AV: E=Sophos;i="5.69,406,1571702400"; 
   d="scan'208";a="31683122"
IronPort-PHdr: =?us-ascii?q?9a23=3AFL/2qBxcgeJ2/QvXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0u4RK/ad9pjvdHbS+e9qxAeQG9mCsLQe1red6/+ocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalsIBi2rQjdudUajIl/Iast1x?=
 =?us-ascii?q?XFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0VbNXAigoPG?=
 =?us-ascii?q?Az/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VS?=
 =?us-ascii?q?i+46ptVRTlkzkMOSIn/27Li8xwlKNbrwynpxxj2I7ffYWZOONjcq/BYd8WQG?=
 =?us-ascii?q?xMUchLVyxFH4iycY0BAeQcNupctoXxuV8DoR64CAKxBu3g1yVIi2fr06Mk3e?=
 =?us-ascii?q?QvEQLI0gIuEN0BsnvbsNr7ObwOUe231qTE0SnPYv1U1Dr79YPGcgohofaJXb?=
 =?us-ascii?q?9obMTR1VcgFxvFjlqOr4zuIi6b1uEXvGif6+pvS+KugHMgpgFqvzev3dwhip?=
 =?us-ascii?q?XJh40JylDE8j91wIAuJdKiUkJ7btmkEIVJuiycKoB4QdsiTnl1tCs1xbAKo5?=
 =?us-ascii?q?62cDUQxJg5yBPTdeaLf5WO7xn+TuieOy14i2hgeL+nghay9lWvxfPkW8mv1V?=
 =?us-ascii?q?ZKsjJFkt7RtnARzxDT6taISv96/kq5xTaAzRrT6uBZIUAvj6bbKpghwrA3lp?=
 =?us-ascii?q?oIr0vMAjX6mFn2jaCKdkUk/fKk6+L7bbX9upCQLYp0igD6Mqg2m8y/B/o3Mh?=
 =?us-ascii?q?QWUmSG9umx26fv8E3kTLlQkPE7nbfVvIrHKcgDo662GQ5V0oIt6xalCDem1c?=
 =?us-ascii?q?wVnWIaI1JeYx+Hk4joNE3OIPD/F/u/hU+sny1xy/DJOb3hHI3BLmLfn7f5Yb?=
 =?us-ascii?q?Z990lcxRIvwt9F/JJbFLEALenoWkDttNzXFAI5MwKww+n5EtVxz58RVniVDq?=
 =?us-ascii?q?CFN6PStEeC5vgzLOmUeI8VpDH9JuA56PH0ln82h18ccbOy3ZQLaHC3BOlmI0?=
 =?us-ascii?q?udYXXymNcMCmYKvgwiTOP0jF2OSyJcZ3G3X6gk/DE0FJqmDZvfRoCqmLGB3i?=
 =?us-ascii?q?K7HppMZmBcC1CMCmzld4OeVPcJdi2SI9VtkjseVbiuU4Uhzw2htBfmy7p7Ke?=
 =?us-ascii?q?rZ4ikYtZPl1Nho6OzfjAoy+iJoAMSAyWGNTn10n2MRSz8z26BwvFF9ylOd3q?=
 =?us-ascii?q?VjnfxYGsJc5+lTXgc5K5Hc1ep6BM72Wg7bedeJUlmmSM28AT4tVtIx38MOY0?=
 =?us-ascii?q?FlFtW5kB/D2yuqA7kIl72EH5E07K3c0GbrJ8pnyHbJyrMhj184TctLL2Gmgb?=
 =?us-ascii?q?R/9wfLDY7Tj0qZj7qqdbgb3CPV92eM03SBvFpEXw53VqXFXmsSaVfWrdTj4U?=
 =?us-ascii?q?PCSr6uCakiMgdbzs6CMKRKYMXzjVpaXPfjJMjeY2WplmeyAhaIxrWMYJDoe2?=
 =?us-ascii?q?Ua3CXSEk4EkxsN8naALgUxGj2uo2TZDDxoFFLgf1nj8e1kpHynSU80yhmAb1?=
 =?us-ascii?q?d92Lqt5h4VmfucRusL3r0avichpCh0HFe7397PCNqPuRBhfKNCbtM5+1pH1H?=
 =?us-ascii?q?vVtwh6Ppy+Ma9unEUefB50v0PzzRV4EJ9Mkc40o38wzgpyMbqS0EldeDOAwZ?=
 =?us-ascii?q?DwJrrXJ3Hq/B+1dq7W3krT0M6M9acS7PQ0slDjvAauFko47XprycVa03yZ5s?=
 =?us-ascii?q?aCMA1HepvqX1d/zBN6rqzUZiQnr9ff3GZhIIGvuT/LxtwtCfFgwR/mdNBaZu?=
 =?us-ascii?q?fMHwbpHtxcHMOuIfEkn1WzRhMCIO1WsqUzOofudf6BwrSqJ85mlTerjCJA+o?=
 =?us-ascii?q?85mkaN8TdsD/XF1Isfwu2Jmw6AWyr4gX+/vc3t34NJfzcfGiy40yegTJVcYq?=
 =?us-ascii?q?x0YJYjF2ijOYu0y894ipqrXGRXp3C5AFZT49OkYRqfaRTG2ARU0UkG6Si8lT?=
 =?us-ascii?q?CQ0y1/kzZvqLGWmiPJ3bKxJ1I8JmdXSTw63h/XKo+ugoVfBRL5Yg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CYAwB2wxRe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXyBf?=
 =?us-ascii?q?YFtIBIqhAmJA4ZtBoE3iW6KJIU9gWcJAQEBAQEBAQEBNwEBhEACgg04EwIQA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIwQRQRALGAICJgICVwYBDAYCAQGCX?=
 =?us-ascii?q?z+CUyWtD38zhU+DMYE9gQ4ojDN5gQeBEScPgl0+hDGDKIJeBJY4YUaXQIJAg?=
 =?us-ascii?q?kWTUQYbml8tjiacciKBWCsIAhgIIQ87gmxQGA2NHheOQSMDMI1+XwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 07 Jan 2020 17:45:14 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 007HiXL5180637;
        Tue, 7 Jan 2020 12:44:34 -0500
Subject: Re: [PATCH v13 06/25] Use lsmblob in security_secctx_to_secid
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191224235939.7483-1-casey@schaufler-ca.com>
 <20191224235939.7483-7-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <553066a9-a638-cb2c-e8ae-cf7dccc57464@tycho.nsa.gov>
Date:   Tue, 7 Jan 2020 12:45:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191224235939.7483-7-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/24/19 6:59 PM, Casey Schaufler wrote:
> Change security_secctx_to_secid() to fill in a lsmblob instead
> of a u32 secid. Multiple LSMs may be able to interpret the
> string, and this allows for setting whichever secid is
> appropriate. In some cases there is scaffolding where other
> interfaces have yet to be converted.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

This addressed my comment on the previous version, so I'll add my ack. 
However, I noticed that even after the entire series is applied, at 
least some of the scaffolding remains.  Wondering whether that 
scaffolding is completely removed by the next series (i.e. full stacking 
for Smack) or still TBD.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   include/linux/security.h          |  5 +++--
>   kernel/cred.c                     |  4 +---
>   net/netfilter/nft_meta.c          | 12 +++++++-----
>   net/netfilter/xt_SECMARK.c        |  5 ++++-
>   net/netlabel/netlabel_unlabeled.c | 14 ++++++++------
>   security/security.c               | 18 +++++++++++++++---
>   6 files changed, 38 insertions(+), 20 deletions(-)
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
> index 9740b554fdb3..259c78d2f371 100644
> --- a/net/netfilter/nft_meta.c
> +++ b/net/netfilter/nft_meta.c
> @@ -625,21 +625,23 @@ static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
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
> +	if (!lsmblob_is_set(&blob))
>   		return -ENOENT;
>   
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
> index 33563963cd45..9dc0bbfe567e 100644
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

