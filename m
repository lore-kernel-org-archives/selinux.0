Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6FDC33C9E
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 19:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798C320748
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 19:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="h4h7yY10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgAQTi5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jan 2020 14:38:57 -0500
Received: from UHIL19PA36.eemsg.mail.mil ([214.24.21.195]:24975 "EHLO
        UHIL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbgAQTi5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jan 2020 14:38:57 -0500
X-EEMSG-check-017: 67866312|UHIL19PA36_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,331,1574121600"; 
   d="scan'208";a="67866312"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Jan 2020 19:38:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579289935; x=1610825935;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=nQbiZItnFcTMS463ylFkDHhAZbsst0glNr3WOS2jGq0=;
  b=h4h7yY10HwyPKF05HpRrwUJo3vfwAaZbgPrFeD/2gpCieg9TS4C50qPH
   HK5I0ys14/01EiUIiii4PnnsySxepvpgcNkYnnrJyrVS7FgRuh59NQabx
   YLLzZZXwreaObnhFb92floXHXFkkmk06qUB8N1v/CYw1Aw08OLiKlx/9Q
   LDqHXVVV55ke5PCMGdB/bq3NF51Vbc2w1uNLFnHOaWZPR+vYspJZ4NoSc
   5Y4wen/pNnyAwIUbdGujj4kM/7bKVgxrh3Bghh4NB1dACrdP4MpRwBu7F
   s1IBKbT8VUz46H0MEP0VfuOzNveUofjqwYOUYWj7MNav+IQULG9FALWWv
   g==;
X-IronPort-AV: E=Sophos;i="5.70,331,1574121600"; 
   d="scan'208";a="37959059"
IronPort-PHdr: =?us-ascii?q?9a23=3ADNZV2hGz7lmuRrdLWt+x8p1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76p868bnLW6fgltlLVR4KTs6sC17OK9fiwEjdaqdbZ6TZeKccKD0?=
 =?us-ascii?q?dEwewt3CUYSPafDkP6KPO4JwcbJ+9lEGFfwnegLEJOE9z/bVCB6le77DoVBw?=
 =?us-ascii?q?mtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJxmqsAndrMYbjZZtJ6or1h?=
 =?us-ascii?q?fEoXREdupIyWh1IV6fgwvw6t2/8ZJ+/Slcoe4t+9JFXa7nY6k2ULtUASg8PW?=
 =?us-ascii?q?so/sPrrx7DTQWO5nsYTGoblwdDDhbG4h/nQJr/qzP2ueVh1iaUO832Vq00Vi?=
 =?us-ascii?q?+576h3Uh/oiTwIOCA//WrKl8F/lqNboBampxxi347ZZZyeOfRicq/Be94RWH?=
 =?us-ascii?q?FMVdhNWSNfHoy8bpMPD+sfMuZes4n9vEYFoR+nCQWxGO/j1jpEi3n40q0g1+?=
 =?us-ascii?q?QqDB/I0gouEdkTtHjYtdv4OaMXXe2z0aLGzyjMb+lO1Dng9obIfBAvr/KCU7?=
 =?us-ascii?q?1+fsXey1UgGQzeg1WMq4HoJS+Z2vgDvmWZ6edrSOKhi3QgqwF0ujWh29sshZ?=
 =?us-ascii?q?fRhoIV1F/E8zhyzpswJdKiTE57ZcCrEZtNvCydLIt5X9giTnp0uCc61rIGuZ?=
 =?us-ascii?q?m7cDIMyJQ83RHTcfOHc4+W4h/6UuuaPDR2hGp9db6iiBu//lKsx+3hWsWuzl?=
 =?us-ascii?q?pHoTRJnsPRun0Lyhfd8NKISuFn8UekwTuP0gfT5fxaLk0sjqrbLoIhwqY3lp?=
 =?us-ascii?q?oOrUTPBi/2l1vyjK+Rbkgk5vKn6/7mYrX7vZ+QLY50igfwMqQpgcywH/g3Ph?=
 =?us-ascii?q?ISX2mb5eu81Lrj8Vf/QLpWlf05jrPVsJXbJcQfvqK5AglV3Zg/6xunEjur39?=
 =?us-ascii?q?sVkWMHIV5YYh6LkYfkN0/ULPzlFfu/hk6jkDZvx/DIJL3hBZDNI2DYkLj8Zr?=
 =?us-ascii?q?Zw8FJcyQovwtBf4JJYELcBIOnpVUPru9zYCQE5PxSuw+n7ENV9yp8eWWWXD6?=
 =?us-ascii?q?+eNaPStkSI5uQ1LOaQeoAYoyz9JOY46P7ul3A5hUURcrWu3ZsScHq4BOhpI1?=
 =?us-ascii?q?2FYXrwhdcMCXwKsRQ6TOzrjl2CTDFSam2sX6Iz+D47EpiqDYTdSYC3hryOwi?=
 =?us-ascii?q?O7EodRZmBcBVCGCW3oeJmcW/cQdCKSJddskiQeWri8T48szgmuuxXny7pjN+?=
 =?us-ascii?q?bU/yoYtZX51Ndr/eHciRYy9TknR/iahkaLQ3t5nCstQCQw1atyogQpzVKEyq?=
 =?us-ascii?q?5xiPFwD9Ff5/pVFAw9MMiYh/d3D9H0RxLpYNiEUhClT8+gDDV3Scg+h5c2al?=
 =?us-ascii?q?t5U/CliQrOl36yCqIRv6SCGZhx96XbxXW3LMF4nSXozq4k2mI6T9NPOGvuva?=
 =?us-ascii?q?t28wzeFsadiEmCv7q7fqQbmijW/SGMynTY7xIQaxJ5TaiQBSNXXUDRt9msox?=
 =?us-ascii?q?qZHrI=3D?=
X-IPAS-Result: =?us-ascii?q?A2AWBACDDCJe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YINEiqEEYkDhmIGgRIliW6KJYckCQEBAQEBAQEBATcBAYRAAoIuOBMCEAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshUOCOykBgnoBBSMEEVELDgoCAiYCAlcGAQwGAgEBgmM/g?=
 =?us-ascii?q?lclrWV/M4VKgy+BPoEOKIwueYEHgTgMA4JdPodZgl4ElzBGl1aCQ4JJk2EGG?=
 =?us-ascii?q?5pyLY4vnRYigVgrCAIYCCEPO4JsUBgNiA0XjkEjAzCNZwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 17 Jan 2020 19:38:53 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00HJcG81012058;
        Fri, 17 Jan 2020 14:38:16 -0500
Subject: Re: [PATCH v2 5/5] selinux: generalize evaluate_cond_node()
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20200117085836.445797-1-omosnace@redhat.com>
 <20200117085836.445797-6-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <bf45fb6b-c262-d03e-5602-46cb1edb17ac@tycho.nsa.gov>
Date:   Fri, 17 Jan 2020 14:39:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200117085836.445797-6-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/17/20 3:58 AM, Ondrej Mosnacek wrote:
> Both callers iterate the cond_list and call it for each node - turn it
> into evaluate_cond_nodes(), which does the iteration for them.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/ss/conditional.c | 10 +++++++++-
>   security/selinux/ss/conditional.h |  2 +-
>   security/selinux/ss/services.c    |  6 ++----
>   3 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 8f9f2f3c86a0..ad709ccea036 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -86,7 +86,7 @@ static int cond_evaluate_expr(struct policydb *p, struct cond_expr *expr)
>    * list appropriately. If the result of the expression is undefined
>    * all of the rules are disabled for safety.
>    */
> -void evaluate_cond_node(struct policydb *p, struct cond_node *node)
> +static void evaluate_cond_node(struct policydb *p, struct cond_node *node)
>   {
>   	struct avtab_node *avnode;
>   	int new_state;
> @@ -117,6 +117,14 @@ void evaluate_cond_node(struct policydb *p, struct cond_node *node)
>   	}
>   }
>   
> +void evaluate_cond_nodes(struct policydb *p)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < p->cond_list_len; i++)
> +		evaluate_cond_node(p, &p->cond_list[i]);
> +}
> +
>   int cond_policydb_init(struct policydb *p)
>   {
>   	int rc;
> diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
> index 4677c6ff7450..b9eb888ffa76 100644
> --- a/security/selinux/ss/conditional.h
> +++ b/security/selinux/ss/conditional.h
> @@ -78,6 +78,6 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
>   		struct av_decision *avd, struct extended_perms *xperms);
>   void cond_compute_xperms(struct avtab *ctab, struct avtab_key *key,
>   		struct extended_perms_decision *xpermd);
> -void evaluate_cond_node(struct policydb *p, struct cond_node *node);
> +void evaluate_cond_nodes(struct policydb *p);
>   
>   #endif /* _CONDITIONAL_H_ */
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 8fc8ec317bb6..7fb7f2efe566 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2958,8 +2958,7 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
>   			policydb->bool_val_to_struct[i]->state = 0;
>   	}
>   
> -	for (i = 0; i < policydb->cond_list_len; i++)
> -		evaluate_cond_node(policydb, &policydb->cond_list[i]);
> +	evaluate_cond_nodes(policydb);
>   
>   	seqno = ++state->ss->latest_granting;
>   	rc = 0;
> @@ -3012,8 +3011,7 @@ static int security_preserve_bools(struct selinux_state *state,
>   		if (booldatum)
>   			booldatum->state = bvalues[i];
>   	}
> -	for (i = 0; i < policydb->cond_list_len; i++)
> -		evaluate_cond_node(policydb, &policydb->cond_list[i]);
> +	evaluate_cond_nodes(policydb);
>   
>   out:
>   	if (bnames) {
> 

