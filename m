Return-Path: <SRS0=o61S=RE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69975C4360F
	for <selinux@archiver.kernel.org>; Fri,  1 Mar 2019 14:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B52520850
	for <selinux@archiver.kernel.org>; Fri,  1 Mar 2019 14:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="fzAhEzT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfCAOGQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:06:16 -0500
Received: from upbd19pa11.eemsg.mail.mil ([214.24.27.86]:14207 "EHLO
        upbd19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388031AbfCAOGM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Mar 2019 09:06:12 -0500
X-EEMSG-check-017: 193415020|UPBD19PA11_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 01 Mar 2019 14:06:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1551449168; x=1582985168;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=1+1cttgpYVedGwAmaKBfIrKk8s0pDBxHDnRB9dIXm+Q=;
  b=fzAhEzT7GEUur6sQmTnJFdZr5vfnW+I9VzYmHG4QdLHhShiJ4I6fgKko
   FSOgSu6t86yjqcUsCxDZJF+y8LEdcv8tFpypj9WkfranxphijoTw4d6gM
   RzrFY9lWEyBeuwe57JZ1ucnXtckKhgNUzjR8HQaWFO+eAKYjKw5c5ek+d
   9uZvyhLchcSRUjyV2UwQDg+7p19HqpCHJCt/wP5S/6z6TZxwbj+vsijUk
   HB6yyfX/rC1X+q0gGRAdKsPhtZcdEe8z1YoPNgPT56d8v8TdEldDbE5eV
   X5PPOAcOfypM1qfvabmz0n8ZLZf3aLzWL6zz3xgMPQMHt3HsCQUT6llDM
   A==;
X-IronPort-AV: E=Sophos;i="5.58,427,1544486400"; 
   d="scan'208";a="24500474"
IronPort-PHdr: =?us-ascii?q?9a23=3AR5B8SBGXCdsxmauHv9U/qp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76pMm6bnLW6fgltlLVR4KTs6sC17KG9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa+bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?m58axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7Sc8kaRW?=
 =?us-ascii?q?5cVchPUSJPDJ63Y48WA+YfIepUqo/wrEYMoxSjHwmhHP7hxCFGhnH23qM03e?=
 =?us-ascii?q?ouHg7E0wM8ENwDq2jUodfvOasOTey4wqvFwDPeZP1Wwzf9743Ifwg8r/GQQ7?=
 =?us-ascii?q?1wacrRxlcpFwjYk1uQrJbqPzeR1usTs2mQ8u1tVfmyhG48sAxxvjiuydssio?=
 =?us-ascii?q?nOnI4VzEvE+j9jzIY6It24Vld2bNi5G5VTryGXL5Z6T8wtTm1yuCs216cKtY?=
 =?us-ascii?q?C0cSQU0pgr2hjSYOGdfYeS+BLsTuORLC99hHJiZb2wmQ6/8VOlyu3gTsm010?=
 =?us-ascii?q?tKrjZdntnMqH8N0xvT59CbSvRn5Eeh2CuP1xvJ5uFYIUE7iarbK5k7zr42ip?=
 =?us-ascii?q?UTqljMEjXzmEX3iK+abkQk+u625OT7erjqu5CROoBuhgz+L6gigNKzDOsmPg?=
 =?us-ascii?q?QUQmSX4eG826fi/U39TrVKlPo2kqzBvZDBOMsbvbW0AxNV04k/6xa/CC2q0N?=
 =?us-ascii?q?IDnXYdNl5FdxWHj5bxN1HUPP/4Feu/g0irkDpz2//JJKbhDYvNL3XYi7fuYb?=
 =?us-ascii?q?Z95FRByAo9ydBQ+YhUBqgdL/3pQEP+qNvYDhohOQyu3+nnEMl91p8ZWW+XAK?=
 =?us-ascii?q?+ZNaTSsUWS5uIuOOmBf4kVtyz4K/c75v7il3g5mUUSfaOxx5sYdGi4Huh6I0?=
 =?us-ascii?q?WeeXfshtYBEWEXvgsxVeDqk0ONXiJOZ3aoXqI8+jE6BJujDYfEW4+tnbiB0z?=
 =?us-ascii?q?mgE51IaWBJFEqMHW3rd4qaQfcMbjydIst7njwDT7ihRJcr1Quyuw/i17pnMu?=
 =?us-ascii?q?3U9zUDtZ390Nh15uvTlQw99DFvEcSd3H+CT3tukmMLWTA2xqZ/rlJ5yluZ1q?=
 =?us-ascii?q?h4mfNYH8RJ5/xVSgc6KYLcz+tiBtDxRA3OYMyJR0qhQtWhAjE8Vc4+w98UY0?=
 =?us-ascii?q?Z6HtWijw3D3y+wD78SjbyLC4Q+8rjA0HjpO8Z913HG2bEjj1khQstPM3eqhq?=
 =?us-ascii?q?x49wjTHYHJlV6ZmLisdakHwCHC7mGDzW2IvEFZTAF/S6HFUWoDaUvRqNTz/l?=
 =?us-ascii?q?nCQKO2CbQ7LgtBztaPKrNUZd3vglVGWfbjONLHb2KyhWiwHxCIya2IbIfxem?=
 =?us-ascii?q?URxSHdCE8akw8N53qGLhIxBiS8o2LEFjNiD1TvbF32/el8sHOxVlU0wB2Sb0?=
 =?us-ascii?q?19y7q1/QYYheSGRPMO2rIJoz8hpC9pHFa5xt7WDt2Apw17fKpCe98y/FBH1W?=
 =?us-ascii?q?eK/zB6a7epNK1zzmUVcw1qsUfjzV0jAYxbnNkCt3gqxRd8La+ClVhIMTif2M?=
 =?us-ascii?q?a0cr/SLXPo/QuHbafT11CY18yZvu8L6fIluxD4sQq0DEs+4jBi1NVI13a0+J?=
 =?us-ascii?q?rHFkwRXIj3X0Jx8AJ14/nBby084Z7E/WNjPLPysTLY3d8tQuw/xUWOZdBaZZ?=
 =?us-ascii?q?iYGRfyHstSPM2nLOgnihD9dR4fFPxD/64zecW9fr2J37D9b7Uopy6vkWkSuN?=
 =?us-ascii?q?M16UmL7ScpD7eSh5s=3D?=
X-IPAS-Result: =?us-ascii?q?A2BoAABJO3lc/wHyM5BlHAEBAQQBAQcEAQGBUgYBAQsBg?=
 =?us-ascii?q?VoqgTkyJ4QIlDUBAQEBAQEGgQgtiTyOZIF7OAGEQAKEICI1CA0BAwEBAQIBA?=
 =?us-ascii?q?wIBbCiCOikBgmcBBSMVQRALGAICJgICVwYBDAYCAQGCXz+BaQ2rQYEvhUSEb?=
 =?us-ascii?q?IELi0AXeIEHgTiCNjWIC4JXAolthz07khUJkmkGGZMhLYozlA4BNoFWKwgCG?=
 =?us-ascii?q?AghD4MnkHshAzCBBQEBjzwBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 01 Mar 2019 14:06:06 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x21E654E027657;
        Fri, 1 Mar 2019 09:06:05 -0500
Subject: Re: [PATCH 05/97] LSM: Create an lsm_export data structure.
To:     Casey Schaufler <casey@schaufler-ca.com>, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20190228221933.2551-1-casey@schaufler-ca.com>
 <20190228221933.2551-6-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7199670f-a38a-bf5e-4c3b-d340caa35071@tycho.nsa.gov>
Date:   Fri, 1 Mar 2019 09:00:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190228221933.2551-6-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/28/19 5:18 PM, Casey Schaufler wrote:
> When more than one security module is exporting data to
> audit and networking sub-systems a single 32 bit integer
> is no longer sufficient to represent the data. Add a
> structure to be used instead.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   include/linux/security.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 13537a49ae97..a79fe8ef9d84 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -73,6 +73,18 @@ enum lsm_event {
>   	LSM_POLICY_CHANGE,
>   };
>   
> +/* Data exported by the security modules */
> +struct lsm_export {
> +	u32	selinux;
> +	u32	smack;
> +	u32	apparmor;
> +	u32	flags;
> +};
> +#define LSM_EXPORT_NONE		0x00
> +#define LSM_EXPORT_SELINUX	0x01
> +#define LSM_EXPORT_SMACK	0x02
> +#define LSM_EXPORT_APPARMOR	0x04

Can this be generalized to avoid hardcoding the names of specific 
security modules in the field and symbol names?  Possibly just an array 
of secids with the indices dynamically assigned by the infrastructure at 
registration time?  We don't really want to have to patch this structure 
every time someone adds a new security module that needs audit and/or 
network facilities, right?

> +
>   /* These functions are in security/commoncap.c */
>   extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
>   		       int cap, unsigned int opts);
> 

