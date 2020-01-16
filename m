Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1BCC3F68F
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 16:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7BD2087E
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 16:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="R6Bh5Ilt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgAPQC3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:02:29 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:36243 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgAPQC3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 11:02:29 -0500
X-EEMSG-check-017: 46497600|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,326,1574121600"; 
   d="scan'208";a="46497600"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Jan 2020 16:02:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579190545; x=1610726545;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=tvHD+axbdgNHMTClBu7ZAOnDN8vDHOJP+Mx4Xb9vmxM=;
  b=R6Bh5IltR5R3zsx3Ipu4orOeJgLTTj+vWFPstc16eezfWKnG63m/p8X+
   YH/wEg0S27aiX6D9nVwYwkeAkMEPKmCocECZAC1Oqrb9OVe55DtEaKr7w
   BNDveSVcGmgFZdmdHTHAp8OdZBLtJROl4qy8YiGyhTBb5NRuKCoTVaO5m
   XQd1OelwmkoIdWxea5E44SMLXJIxQxG5OiQH9IcvYWbcU83JoGfOPNGnW
   MSatY0dOFTTeYzZFv2ukbG2UY67k35yGNdFFtLvByAIR3NtbAvsDWQyiK
   pt9RGEzFFSL65mNuZR87t8V0g7NQXMQoT/oywStRVfuFpkLI1DUlAbNAi
   A==;
X-IronPort-AV: E=Sophos;i="5.70,326,1574121600"; 
   d="scan'208";a="37880459"
IronPort-PHdr: =?us-ascii?q?9a23=3A0EUbShfC5n8aOHa2uLKbTSP1lGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc26YxyN2/xhgRfzUJnB7Loc0qyK6vymATFLsc7J8ChbNsAVDF?=
 =?us-ascii?q?ld0YRetjdjKfbNMVf8Iv/uYn5yN+V5f3ghwUuGN1NIEt31fVzYry76xzcTHh?=
 =?us-ascii?q?LiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyKwi9oRnMusUMjoZuN6k8xg?=
 =?us-ascii?q?HVrnZIdOhbxn9kLk+Xkxrg+8u85pFu/zletv4768JMTaD2dLkkQLJFCzgrL3?=
 =?us-ascii?q?o779DxuxnZSguP6HocUmEInRdNHgPI8hL0UIrvvyXjruZy1zWUMsPwTbAvRD?=
 =?us-ascii?q?St9LxrRwPyiCcGLDE27mfagdFtga1BoRKhoxt/w5PIYIyQKfFzcL/Rcc8cSG?=
 =?us-ascii?q?FcRctaSTBPDZ2gYIsOF+oBPPhXr4/hp1sVsBCyARCgCP7zxjNUg3P726M10/?=
 =?us-ascii?q?4lEQrbwgIuGdwAu2nQoNnsOqofVeW5wa/VxjvBcvxWwy/w5pXWfBAvof+CXr?=
 =?us-ascii?q?x+fsTexkYtCwzLgU6dqZDnMj6PyugBr2aW4uhmWOmyi2AnsQZxoj23y8kxlo?=
 =?us-ascii?q?nGmJoVylDa+iV/3Y07ONi4R1R/Yd6gDpRRtzyROoxtQsw/WGFlozo6y70atp?=
 =?us-ascii?q?67eygG0pInxwXFZPCdfIiI5QzjWf+XLDxlinxlf7e/iAyz8Uim0uD8TtO70E?=
 =?us-ascii?q?pWoSpFiNXAr2kB2wXI6seZVvR9412h2TeT1wHT7OxPPEM6lbLDJpI8zbM9mY?=
 =?us-ascii?q?AfvETeEiPshkn7g7Gael859uWu9u/peK/ppoWGOI9xkgz+N6MuldGhDukgKQ?=
 =?us-ascii?q?gOWnSb+fy71L3+4U31WLVKgeMykqneqJ3aOd4UprS4Aw9IyYYv8Re/DzGo0N?=
 =?us-ascii?q?QfhnkIMk5KdAibj4npJ17OIPf4Ae25g1uwizdk2+rKPrjgApXJNnTDkbHhcq?=
 =?us-ascii?q?hh60NE1QY+wt9S64hUB70cOv7/RED8uMLCAhMkKwC0xvzoCNR51oMQQ2KPBa?=
 =?us-ascii?q?qZPbvJsVCV/eIiOPWMZY8Jtzb9LPgp/fjujWQjllMHcqmp2oUXZGiiHvt6O0?=
 =?us-ascii?q?WZfWbsgtAZHGcNuwo+S/fqiFuYXjFPeXm/RLg86S8mB4KmF4jDWpqhj6CG3C?=
 =?us-ascii?q?e+BpdWfHxJCkiQEXf0cIWJQ+wMZzyWIs9glDwESLegRpQ/1RGhqgD60aBrLu?=
 =?us-ascii?q?nK9S0Cs5Lsytx16/fUlREo+jx+F96d3H2VT2FogmMIQCc73LhlrkxgzleOyr?=
 =?us-ascii?q?B4jOZFFdxX/v9JVwA6NZnGz+NkEdz9RgXBftLaAGqhF/KgDSs8TJoUxMQIak?=
 =?us-ascii?q?1wGJ32iRXExCyjCLI9jbGHBJUotKnb2i61b91wz3fAybkJkVYrWI1MOHegi6?=
 =?us-ascii?q?o58BLcQ8bxmlid34Otcr4RlHrV/XqH5XKHoUUdVQl3S6iDVncaMBj4t9P8s3?=
 =?us-ascii?q?jeQqeuBLJvCQ5IzcqPO+MecdHypUlXT/fkftLFaiS+nHnmVkXA/a+FcIe/Iz?=
 =?us-ascii?q?ZV5y7aEkVR1llIrHs=3D?=
X-IPAS-Result: =?us-ascii?q?A2CuBABJiCBe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBCJA4ZfAQEBBoE3iW6RSQkBAQEBAQEBAQE3AQGEQAKCJjgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjBBFRCw4KAgImAgJXBgEMBgIBAYJjP?=
 =?us-ascii?q?4JXJawbfzOFSoNWgT6BDiiMNnmBB4E4D4JdPodZgl4EjVqJVkaXVoJDgkmTY?=
 =?us-ascii?q?QYbmnCOXJ0VIoFYKwgCGAghD4MnUBgNiA0XjkEjAzCNbAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 16 Jan 2020 16:02:19 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00GG1SZw009272;
        Thu, 16 Jan 2020 11:01:40 -0500
Subject: Re: [PATCH 1/6] selinux: do not allocate ancillary buffer on first
 load
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20200116120439.303034-1-omosnace@redhat.com>
 <20200116120439.303034-2-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e2af6353-25a0-30ea-8d81-30ec0d67e7d2@tycho.nsa.gov>
Date:   Thu, 16 Jan 2020 11:02:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116120439.303034-2-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/16/20 7:04 AM, Ondrej Mosnacek wrote:
> In security_load_policy(), we can defer allocating the newpolicydb
> ancillary array to after checking state->initialized, thereby avoiding
> the pointless allocation when loading policy the first time.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

What are these relative to, because they don't apply for me on 
selinux/next?  In particular they conflict with your 'treat atomic flags 
more carefully' patch.

> ---
>   security/selinux/ss/services.c | 28 +++++++++++++---------------
>   1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 55cf42945cba..42ca9f6dbbf4 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2183,26 +2183,17 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   	int rc = 0;
>   	struct policy_file file = { data, len }, *fp = &file;
>   
> -	oldpolicydb = kcalloc(2, sizeof(*oldpolicydb), GFP_KERNEL);
> -	if (!oldpolicydb) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> -	newpolicydb = oldpolicydb + 1;
> -
>   	policydb = &state->ss->policydb;
>   
>   	newsidtab = kmalloc(sizeof(*newsidtab), GFP_KERNEL);
> -	if (!newsidtab) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> +	if (!newsidtab)
> +		return -ENOMEM;
>   
>   	if (!state->initialized) {
>   		rc = policydb_read(policydb, fp);
>   		if (rc) {
>   			kfree(newsidtab);
> -			goto out;
> +			return rc;
>   		}
>   
>   		policydb->len = len;
> @@ -2211,14 +2202,14 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   		if (rc) {
>   			kfree(newsidtab);
>   			policydb_destroy(policydb);
> -			goto out;
> +			return rc;
>   		}
>   
>   		rc = policydb_load_isids(policydb, newsidtab);
>   		if (rc) {
>   			kfree(newsidtab);
>   			policydb_destroy(policydb);
> -			goto out;
> +			return rc;
>   		}
>   
>   		state->ss->sidtab = newsidtab;
> @@ -2231,9 +2222,16 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   		selinux_status_update_policyload(state, seqno);
>   		selinux_netlbl_cache_invalidate();
>   		selinux_xfrm_notify_policyload();
> -		goto out;
> +		return 0;
>   	}
>   
> +	oldpolicydb = kcalloc(2, sizeof(*oldpolicydb), GFP_KERNEL);
> +	if (!oldpolicydb) {
> +		kfree(newsidtab);
> +		return -ENOMEM;
> +	}
> +	newpolicydb = oldpolicydb + 1;
> +
>   	rc = policydb_read(newpolicydb, fp);
>   	if (rc) {
>   		kfree(newsidtab);
> 

