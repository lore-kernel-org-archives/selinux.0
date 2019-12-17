Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5F3C43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 18:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F902072D
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 18:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="lRsPQVGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfLQSXn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:23:43 -0500
Received: from USAT19PA23.eemsg.mail.mil ([214.24.22.197]:58974 "EHLO
        USAT19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfLQSXn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 13:23:43 -0500
X-EEMSG-check-017: 61596879|USAT19PA23_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="61596879"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Dec 2019 18:23:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576607022; x=1608143022;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=GE/KR0O4y5EHDt1HLS6ZGti2V/DQFDlu6ktzChhA2D4=;
  b=lRsPQVGkrpQ1BBTYXtowOJhn/TJ6RupsLiBIi7WaROploEwyPmLWfIoZ
   rascn1ktroWXsFPdPiYXVT1zyLTmDYGQDmsaq8H/Ho+cCQucgZCH0J6ku
   tHQDfurfUqzz/YUqqg59mkafZ8iKjRXW5vWuekExQmocanO2OKWRI+VOp
   WGqBgIt9FAOaMLf0G/VLsf3dU8YUGeCltT85BhqEAOHLPZjC4J9/MdTOc
   dAv0RcZQjQ6Upc1oSUIJFyPGDdnD/mHTsGzD+7oAwB5eX94/L9o/Hg5OJ
   FWOWpNATmQsJktNgUGS4qaKcRq66HGd1efloV9avIL9WrtdGoxRqCiGMi
   A==;
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="31199890"
IronPort-PHdr: =?us-ascii?q?9a23=3AoqO61BISQXJQPVooNdmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXLvv/rarrMEGX3/hxlliBBdydt6sfzbCO7Ou5ADRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+ooQnNtMQajpZuJrstxh?=
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
X-IPAS-Result: =?us-ascii?q?A2AxAADSHPld/wHyM5BcCRsBAQEBAQEBBQEBAREBAQMDA?=
 =?us-ascii?q?QEBgW0DAQEBCwGBc4FtIBIqhASJA4Z3BoESJYlqiiKHIwkBAQEBAQEBAQE3A?=
 =?us-ascii?q?QGEQAKCPDcGDgIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCeQEBAQECASMVQQULC?=
 =?us-ascii?q?xgCAiYCAlcGAQwGAgEBgl8/glMFIK1SdYEyhU+DQoFIgQ4oAYwxeYEHgTgMA?=
 =?us-ascii?q?4JdPoQfgzqCXgSNQYlLRpczgj6CQpNIBhuaSS2OIJxdI4FYKwgCGAghD4MnU?=
 =?us-ascii?q?BEUm3YjAzCRfQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Dec 2019 18:23:31 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBHIN5Sn170535;
        Tue, 17 Dec 2019 13:23:08 -0500
Subject: Re: [PATCH v12 11/25] LSM: Use lsmblob in security_cred_getsecid
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-12-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <4b20d9c7-ae18-7ebf-8031-d2a522e51982@tycho.nsa.gov>
Date:   Tue, 17 Dec 2019 13:23:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-12-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:36 PM, Casey Schaufler wrote:
> Change the security_cred_getsecid() interface to fill in a
> lsmblob instead of a u32 secid. The associated data elements
> in the audit sub-system are changed from a secid to a lsmblob
> to accommodate multiple possible LSM audit users.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: linux-integrity@vger.kernel.org
> ---
>   include/linux/security.h          |  2 +-
>   kernel/audit.c                    | 19 +++++++-----------
>   kernel/audit.h                    |  5 +++--
>   kernel/auditsc.c                  | 33 +++++++++++--------------------
>   security/integrity/ima/ima_main.c |  8 ++++----
>   security/security.c               | 12 ++++++++---
>   6 files changed, 36 insertions(+), 43 deletions(-)
> 

> index 6ee53e43c986..69b52f25038a 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -124,7 +124,7 @@ static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
>   /* The identity of the user shutting down the audit system. */
>   kuid_t		audit_sig_uid = INVALID_UID;
>   pid_t		audit_sig_pid = -1;
> -u32		audit_sig_sid = 0;
> +struct lsmblob	audit_sig_lsm;

Not your bug but wondering why these variables aren't static; seemingly 
localized to audit.c.

> diff --git a/kernel/audit.h b/kernel/audit.h
> index 6fb7160412d4..af9bc09e656c 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -134,7 +135,7 @@ struct audit_context {
>   	kuid_t		    target_auid;
>   	kuid_t		    target_uid;
>   	unsigned int	    target_sessionid;
> -	u32		    target_sid;
> +	struct lsmblob   target_lsm;

Probably should be consistent with the indentation of the other fields.

>   	char		    target_comm[TASK_COMM_LEN];
>   
>   	struct audit_tree_refs *trees, *first_trees;

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 5752e51883d5..c1e3ac8eb1ad 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -112,7 +112,7 @@ struct audit_aux_data_pids {
>   	kuid_t			target_auid[AUDIT_AUX_PIDS];
>   	kuid_t			target_uid[AUDIT_AUX_PIDS];
>   	unsigned int		target_sessionid[AUDIT_AUX_PIDS];
> -	u32			target_sid[AUDIT_AUX_PIDS];
> +	struct lsmblob	target_lsm[AUDIT_AUX_PIDS];
>   	char 			target_comm[AUDIT_AUX_PIDS][TASK_COMM_LEN];
>   	int			pid_count;
>   };

Ditto

Other than those minor stylistic matters,
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
