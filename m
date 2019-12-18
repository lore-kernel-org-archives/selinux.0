Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902EBC43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 19:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DB521D7D
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 19:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ghPUJ6IR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLRTc4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:32:56 -0500
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:25982 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfLRTc4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 14:32:56 -0500
X-EEMSG-check-017: 37267671|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="37267671"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Dec 2019 19:32:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576697574; x=1608233574;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=LAJPcb+GVQofhaOcttxAuq+Yw9hpsRN8h7VuoMS4fb4=;
  b=ghPUJ6IRI2crERjE0kI2EJT9qddEnVhyB9yN1yM5Y1VLiL89MVQwm1hj
   fyexE1OxSYn6FR9EMgMmpIvF74ghXGaj1QJqhR5I2fJjsLIQ3hEp0yZ5f
   DgeGmZM7RG5gtHmjULNIwaoF3Rsar2gUqa/Xj8CEx52BH8xIJSTogl+61
   pfC0RVoHguIxirrhr17fUZXo7xQI4V40LV6Lhl0/oVDvitV7adt8MYYqH
   62oZf+9axZqHps+xCrzet637QpYMxcGk5uIJqWbFLtaqqpJBBdNwRMN7H
   5EvQoXDG0UINwCzrqMCQP1gpN6BIkwLX1dSWL+CW3yjHod9KUXIfYVjMD
   w==;
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="36932464"
IronPort-PHdr: =?us-ascii?q?9a23=3AdfHlrRKZACpZJcjD79mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXLvv/rarrMEGX3/hxlliBBdydt6sfzbCO4uu5AzRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+ooQnNssQajpZuJrgtxh?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipPDYOma4sEEvQPM+BWoYLgo1cCtAWyCA2pCO7p1zRGhGL53bci3u?=
 =?us-ascii?q?o8Dw/G0gwuEdEAvnvao9r6NrsdX++uwanUzzjOde9a1Svz5YXKdB0qvPGCXa?=
 =?us-ascii?q?h3ccrU0UQhCh/FgUuIqYzlITyV0PkGvXWe7+V6UeKvj3AoqgFsqTWo3ccjl5?=
 =?us-ascii?q?LJi5kJylHE6Sp5wIE1Kce+SE5ge9GoCpRQtyaEN4ZvRM4pXmJmuD4ix7Ebtp?=
 =?us-ascii?q?O2czIGxZQ6yxLFdfCKfJaE7gj+WOuXPDx2nmhqeKiliBa36UWgz+r8WdSq31?=
 =?us-ascii?q?tStSpFl8XMtmgK1xzO9siLUvt98Vml2TaIzw3T9vtLIVo1larGMJ4t2L8wlp?=
 =?us-ascii?q?wdsUTEBS/5hln5gLWKdkQk5ueo6+Pnbq/gppCALI97lhvyMqEvmsy7Geg4Mw?=
 =?us-ascii?q?4OUHaH+emkybHu8kL0TK9Kg/EriKXVrp/XKdoBqqKkGwNV15ws6xe7Dzeoyt?=
 =?us-ascii?q?QYmnwHIUpeeB2alIjkIE3OIfDkAve/hFSgijFrx+vcMbH7DZXNKWbDnK/7fb?=
 =?us-ascii?q?lh805c1BYzzddH6p1IEL4BO+z8W0/qudzDEhA5Mxa7w/vpCNV5yIweQ3uDDb?=
 =?us-ascii?q?ODP6/IrVCI4ecvKfGWZIAJoDb9N+Ql5/n2gHAlg1AdZrem3JsNZHCjAvtmI1?=
 =?us-ascii?q?+WYWfigtcFD2gKpBEzTO3siF2eTzFTY2y+UL475jE+EIimF5vMRpixgLyd2y?=
 =?us-ascii?q?e2Bp9WZmVBClCWC3fodp6EVuwKaC2IJ89ujD0EWaKmS4872hGkrBX6xKZ/Lu?=
 =?us-ascii?q?rI5i0Ysoru1Nx05+3ViBEz+iV4D9+D3G6RUmF0hGIIRyM23axmpEx9zUqM0b?=
 =?us-ascii?q?V8g/NGDtFT+fxJXRkgNZLGzOx1FcryWgTfcdeNUlqmRc+mAT4pRNIr39AOe1?=
 =?us-ascii?q?p9G8mljh3bxCqlHbsVl72NBJwp/aPRxGbxJ8ljxHbczqUhjEcpQtFJNWK4gq?=
 =?us-ascii?q?5z7Q/TB5TGk0+Bjaalabwc3DLR9GeE1WeOv19XXxBrUarZWnAfYUjWoM/l6U?=
 =?us-ascii?q?PCVb+uDrEnMgpcyc6HMKdKbcfpjVpeTvf5JNvee36xm3u3BRuQxLOMa4rqe2?=
 =?us-ascii?q?MH0CXfD0gEkxoc/XCdNQcgACesuH7RAyZoFVLoZUPs8PVxp2m/TkMu0w6KaE?=
 =?us-ascii?q?hh3aKv+hEJnfycV+8T3rUctSc5tTp0Glm938/XC9qGvgZhf7tTYck74FhZ0W?=
 =?us-ascii?q?LUrA19MoWkL6BlmF4RbR57v1j02BV0F4VAi9IloGkszAVsM66Y0ktBfSuC3Z?=
 =?us-ascii?q?/sIr3XNnXy/Be3Zq7OwF7ezdKW97wX6PsitlXjuBilFk8l83VgydlazWGQ6Y?=
 =?us-ascii?q?nNDAoXAtrNVRMc/gN3tvnhaSk0+o3Q2GckZaK9qTLT88kiBOI4xBKtZZJUOe?=
 =?us-ascii?q?WPEwqkV4URDtOjOaoxkFigcxwAMfp69agoMsfgfPyDnOapOeF6hjO9pWJO5Y?=
 =?us-ascii?q?18lEWW+G40Tu/OwoZA2PyTwxGGSya5iVCtr8T6sZ5LaCtUHWelzyXgQolLae?=
 =?us-ascii?q?k6ZosPCGGzM+WpydhkwZ3gQXhV8BikHVxV9tWufE+pc1Hl3QBWnX8SqHijlD?=
 =?us-ascii?q?rwmyd4iBk1v6Gf22rI2O2kex0ZbD0YDFJ+hEvhdNDnx+sRW1KlOk1wzkqo?=
X-IPAS-Result: =?us-ascii?q?A2BKAACXffpd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF8gXaBbSASKoQEiQOGWgaBN4lqiiKHIwkBAQEBAQEBAQE3AQGEQ?=
 =?us-ascii?q?AKCPTgTAhABAQEEAQEBAQEFAwEBbIVDgjspAYJ5AQEBAQIBIwQRQQULCxgCA?=
 =?us-ascii?q?iYCAlcGAQwGAgEBgl8/glMFIK0XdX8zhU+DPoFBgQ4ojDJ5gQeBEScPgl0+h?=
 =?us-ascii?q?1mCXgSXDkaXNYI/gkOTSgYbgkOTS4RALY4hgUabGSKBWCsIAhgIIQ+DJ1AYD?=
 =?us-ascii?q?Y0eF45BIwMwjy0BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Dec 2019 19:32:52 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBIJWL6E113766;
        Wed, 18 Dec 2019 14:32:22 -0500
Subject: Re: [PATCH v12 15/25] LSM: Use lsmcontext in security_secid_to_secctx
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-16-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <dd598a2d-716f-8bf5-fe71-9c46b6d1814b@tycho.nsa.gov>
Date:   Wed, 18 Dec 2019 14:33:01 -0500
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

Sorry, have to retract my ack.  See below.

> ---
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

You forgot to update this kmalloc() to use context.len, so you'll end up 
allocating too small a buffer and then writing out of bounds upon the 
memcpy below.

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
