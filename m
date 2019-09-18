Return-Path: <SRS0=HWnL=XN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F63AC4CEC4
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 17:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D396821907
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 17:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Hqgibj2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfIRRn4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:43:56 -0400
Received: from UHIL19PA37.eemsg.mail.mil ([214.24.21.196]:55958 "EHLO
        UHIL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfIRRn4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Sep 2019 13:43:56 -0400
X-EEMSG-check-017: 26873249|UHIL19PA37_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,521,1559520000"; 
   d="scan'208";a="26873249"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Sep 2019 17:43:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568828634; x=1600364634;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yYF3PHaaUqk0D7NY0HSN+CLL/MLYqXH/L2u2IoIVufY=;
  b=Hqgibj2z2aD+S+9gLCcd+zSVEvcFsz+3Sjz++m3AXtnNrZ47dk5p5l4u
   ySiN5+zHkQW7VOxSDcKwRWRLOI6SuPW7QaYC4NaHZYThQuY1oy4r9tQx+
   vrardjFb6Zz7FJ62IY1sajvtYoVv3g6jCQzMW3V3L9/kF3Lihz0pIkYmS
   p0sjT4UIuuHvzX01mYaA1sHBHggwakllUFxUC3DCKCUFsd8buBog3SYPG
   PERIsZZpy9Fq1L4kA0Rb5mc89myZS7ziyXvJoiSeGdDsoRCEOkQKbeJ+P
   ZH2SkXF71yJQ/c/Ebu+bEV4ECo8cuTY3ZSzh7icwMSQktYRRsaWWaUV1K
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,521,1559520000"; 
   d="scan'208";a="33027536"
IronPort-PHdr: =?us-ascii?q?9a23=3Af/zdARP7E/HSDR8UQlwl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/jypsbcNUDSrc9gkEXOFd2Cra4d0KyP4+u5ADBIoc7Y9ixbKtoUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIVvJrwsxh?=
 =?us-ascii?q?bKrXdEZvlayGx1Ll6Xgxrw+9288ZF+/yhOof4t69JMXaDndKkkULJUCygrPX?=
 =?us-ascii?q?oo78PxrxnDSgWP5noYUmoIlxdDHhbI4hLnUJrvqyX2ruVy1jWUMs3wVrA0RC?=
 =?us-ascii?q?+t77x3Rx/yiScILCA2/WfKgcFtlq1boRahpxtiw47IZYyeKfRzcr/Bcd4cWG?=
 =?us-ascii?q?FMRdhaWTBfDYygbosPF+sBMvher4nhvFsFsB+yCRCxCO/z1jNEg3n70qMg0+?=
 =?us-ascii?q?QlDArIwgouEdwTu3jQtdn4OqMfXeWzwaLVzzvMculW1C/g5obWfBAvofKCU7?=
 =?us-ascii?q?x+fsXey0YgCwzLg06MqYHnJT6ZyvgBvmaZ4udmSOmhi3QnqwZ0ojW328kslp?=
 =?us-ascii?q?fGhpoVyl/a8yVy3Zs7JdiiR05/Zd6rDptRvDydOottX8wiWHpluDo6y7IauZ?=
 =?us-ascii?q?67ezIGyJI8xxHFcfCHfI+I4gz6WeuXPDx2h2pldaqiixu9/kWs0O3xWtSu3F?=
 =?us-ascii?q?pUoSdJjMPAum0L2hfO8MaIUOF98V2k2TuX0gDT7fxLLl4smKrALp4h3qYwlp?=
 =?us-ascii?q?0OsUTfBiP2mFv5jKuRdkg85uin8f7nYrT7pp+HLYN0lgH/Pbgumsy4G+g4NB?=
 =?us-ascii?q?QBX3OH9uim0b3j/En5TK1Ljv0wjKbZrIjXKdkUq6O2GQNY0psv5wyhAzqpzt?=
 =?us-ascii?q?gUh2QLIEpAeB2djojpP1/OIOr/Dfe6m1msiypkx+vdM739ApTCMnjDkLD7cb?=
 =?us-ascii?q?Z78E5T0hA/zd9Y55JKEr0BOu78WlfttNzECR80KxC7zPz8CNpj1oITQnmPDb?=
 =?us-ascii?q?OZMKzIrF+I6OYvLPeWZIMMpDnyMeIp6OLpjX88gVUdZ7Wm3YMLaHCkGfRrO1?=
 =?us-ascii?q?mWbmD3gtgfEWYGpBE+Q/DqiFKYTD5TaXKyULwm5jwgCYKmC5vDSZ6pgLCbwC?=
 =?us-ascii?q?i7GZhWbHhcCl+QCXfoa5mEW/AUZSKQJ89hlSYEVaKgS486zhyushX1y795Ie?=
 =?us-ascii?q?rV4CEYsojj1Ndt7e3JiR4y7SB0D9ia02yVS2F0n2UIRyI53axmukxy1EuM0b?=
 =?us-ascii?q?Vig/xZCdxS5+pFUgI9NZHB0ux6D879VxnffteGVlmmWM+qATIvQdIrxd8BfU?=
 =?us-ascii?q?J9F8+ljhDZ0CqgG6UVmKCTBJwo7qLc2GD8J91jxHbC1akhiUQmQ8RUOG24ia?=
 =?us-ascii?q?5w6RLTC5TKk0qHjaaqc7oT3CrX+GeE12qOs1lSUBRsXqXdQXAfekzWoMz65k?=
 =?us-ascii?q?zcUbCuEqgoMgxGyc6BMaZFdt3pjU9BRPfmOdTefmexl323BRaSybOGdJDqdH?=
 =?us-ascii?q?kF3CXBFEgElBge/XSBNQg+ACetuWDeDDtuFV31ZUPs6vdxqHWgQ0Ao1Q6KaU?=
 =?us-ascii?q?ph17y0+hEJn/OcT+kf0a4DuCcksz90Bkqy38rKC9qcoApsZL1cbs074FdIyG?=
 =?us-ascii?q?LZtgp9MoWjL698nF4edRp4v0f12hV2E4lAlc8qrG00wwZoMqKXylBBdy6C3Z?=
 =?us-ascii?q?/qILHXLHf98Aqta67OwlveysqZ+r8T6PQkrFXupBmpGVA/83VjyNRVy2GT5o?=
 =?us-ascii?q?jODAYLVJLxVUE39wJkqL3AfiY94IbUhjVQNvyfuyTPypoSD+ss1xikcs0XZK?=
 =?us-ascii?q?iNDwLjO9YRB8GzJugngR2iZ1QPO+UEsOY/NtirZr2d066iIehkkSiOjGJb7Y?=
 =?us-ascii?q?Q72UWJs2J+T+nSxZce6/eR2waGETDmgxPptsHxhJABfjwZA3C+1TmhAYlde6?=
 =?us-ascii?q?l/VZgEBH3oIMCtwNh6wZn3VDoQ71OnBlUbyOe3dheIKV/wxwtd0QIQu3P0tz?=
 =?us-ascii?q?G/ymlPjzwxrqeZlBfLyuDmeQtPbnVHX0F+nFzsJs6ylNlcU0+2OVt63CC57F?=
 =?us-ascii?q?r3kvAI7J90KHPeFAIRJHn7?=
X-IPAS-Result: =?us-ascii?q?A2B/AwDPa4Jd/wHyM5BmHAEBAQQBAQcEAQGBZ4FuKoFAM?=
 =?us-ascii?q?iqEIo9eAQEBAQEBBoERJYl0kSgJAQEBAQEBAQEBNAECAQGEPwKDAyM4EwIMA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFOYI6KQGCZwEFIwQRQRALGAICJgICVwYBDAYCAQGCX?=
 =?us-ascii?q?z+BdxSxCH8zhUyDLYFJgQwojAkYeIEHgREnDIIxLj6ELoMhglgEjEuJMpcAg?=
 =?us-ascii?q?iyCLpJQBhuZIY4QlhGFCiGBWCsIAhgIIQ+DJ1AQFJAvJAMwgQYBAY9uAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Sep 2019 17:43:53 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8IHhmuc030228;
        Wed, 18 Sep 2019 13:43:48 -0400
Subject: Re: [PATCH v8 22/28] SELinux: Verify LSM display sanity in binder
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20190829232935.7099-1-casey@schaufler-ca.com>
 <20190829232935.7099-23-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <972d4dfd-74fd-0747-8c2d-ad74842ed067@tycho.nsa.gov>
Date:   Wed, 18 Sep 2019 13:43:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190829232935.7099-23-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/29/19 7:29 PM, Casey Schaufler wrote:
> Verify that the tasks on the ends of a binder transaction
> use LSM display values that don't cause SELinux contexts
> to be interpreted by another LSM or another LSM's context
> to be interpreted by SELinux. No judgement is made in cases
> that where SELinux contexts are not used in the binder
> transaction.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   include/linux/security.h |  1 +
>   security/selinux/hooks.c | 34 ++++++++++++++++++++++++++++++++++
>   2 files changed, 35 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index c16aea55be97..7fcc94ec8e04 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -125,6 +125,7 @@ struct lsmblob {
>   	u32     secid[LSMBLOB_ENTRIES];
>   };
>   
> +#define LSMBLOB_FIRST		0	/* First valid LSM slot number */
>   #define LSMBLOB_INVALID		-1	/* Not a valid LSM slot number */
>   #define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
>   #define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 352be16a887d..2844f2ab7706 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2009,6 +2009,28 @@ static inline u32 open_file_to_av(struct file *file)
>   	return av;
>   }
>   
> +/*
> + * Verify that if the "display" LSM is SELinux for either task
> + * that it is for both tasks.
> + */
> +static inline bool compatible_task_displays(struct task_struct *here,
> +					    struct task_struct *there)
> +{
> +	int h = lsm_task_display(here);
> +	int t = lsm_task_display(there);
> +
> +	if (h == t)
> +		return true;
> +
> +	/* unspecified is only ok if SELinux isn't going to be involved */
> +	if (selinux_lsmid.slot == LSMBLOB_FIRST)
> +		return ((h == LSMBLOB_FIRST && t == LSMBLOB_INVALID) ||
> +			(t == LSMBLOB_FIRST && h == LSMBLOB_INVALID));
> +
> +	/* it's ok only if neither display is SELinux */
> +	return (h != selinux_lsmid.slot && t != selinux_lsmid.slot);
> +}
> +
>   /* Hook functions begin here. */
>   
>   static int selinux_binder_set_context_mgr(struct task_struct *mgr)
> @@ -2016,6 +2038,9 @@ static int selinux_binder_set_context_mgr(struct task_struct *mgr)
>   	u32 mysid = current_sid();
>   	u32 mgrsid = task_sid(mgr);
>   
> +	if (!compatible_task_displays(current, mgr))
> +		return -EINVAL;
> +
>   	return avc_has_perm(&selinux_state,
>   			    mysid, mgrsid, SECCLASS_BINDER,
>   			    BINDER__SET_CONTEXT_MGR, NULL);
> @@ -2029,6 +2054,9 @@ static int selinux_binder_transaction(struct task_struct *from,
>   	u32 tosid = task_sid(to);
>   	int rc;
>   
> +	if (!compatible_task_displays(from, to))
> +		return -EINVAL;
> +
>   	if (mysid != fromsid) {
>   		rc = avc_has_perm(&selinux_state,
>   				  mysid, fromsid, SECCLASS_BINDER,
> @@ -2048,6 +2076,9 @@ static int selinux_binder_transfer_binder(struct task_struct *from,
>   	u32 fromsid = task_sid(from);
>   	u32 tosid = task_sid(to);
>   
> +	if (!compatible_task_displays(from, to))
> +		return -EINVAL;
> +
>   	return avc_has_perm(&selinux_state,
>   			    fromsid, tosid, SECCLASS_BINDER, BINDER__TRANSFER,
>   			    NULL);
> @@ -2064,6 +2095,9 @@ static int selinux_binder_transfer_file(struct task_struct *from,
>   	struct common_audit_data ad;
>   	int rc;
>   
> +	if (!compatible_task_displays(from, to))
> +		return -EINVAL;
> +
>   	ad.type = LSM_AUDIT_DATA_PATH;
>   	ad.u.path = file->f_path;
>   
> 

The only hook that approximates where/when you want to do this check is 
security_binder_transaction(), so you don't need to insert the check 
into the other hooks.  Further, the check is only needed if the server 
has requested peer contexts, which is indicated by the flag bit 
target_node->txn_security_ctx, so if you amended the hook interface to 
also pass that flag value, then you could avoid the check except in that 
situation.

As soon as any other LSM implements the binder hooks, it will also 
likely want an equivalent check, so sooner or later you'll probably want 
to take the logic to the framework and not just the security module.

