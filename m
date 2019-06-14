Return-Path: <SRS0=ZMzQ=UN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8836BC31E4B
	for <selinux@archiver.kernel.org>; Fri, 14 Jun 2019 19:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC712073F
	for <selinux@archiver.kernel.org>; Fri, 14 Jun 2019 19:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="IOsMBrLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfFNTkp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Jun 2019 15:40:45 -0400
Received: from usfb19pa15.eemsg.mail.mil ([214.24.26.86]:6850 "EHLO
        usfb19pa15.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfFNTko (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Jun 2019 15:40:44 -0400
X-EEMSG-check-017: 223288332|USFB19PA15_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by usfb19pa15.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Jun 2019 19:38:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1560541122; x=1592077122;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=5F0CNGupB5pznbEfZA1LbM70fLBcBrIVLuaFMlf6ERA=;
  b=IOsMBrLI9ykHViwxX11Iv1qCinEynpGBKcN/IeiCrSP8ml34rM27VXG4
   lZWlkuDh9g3FkIx558JcEdDqAqIPxOXAt1mdehzlVWpO0zmymDQmcUQVm
   fyQth/T4tQAm2hXE2SpCntEuNTVUkt4SHtHDnvnEpBi1ovJ/cuD6nfSLJ
   8Z1f3x1wsT32bQWvo6ZDvsSKn65I5aBMu3fDhT4Cyz5+rMS8Zglhtxvaf
   aPQftmOR4+Sl/AqvnqXHz1m13IOsNK4yyQ58raXpzNOz2ns/BZ1JOmY99
   E6Jagv0XDiwNXSokAWR61iT2hGuh77YxDybKDqmfmtI31cLM84P4U8bxn
   g==;
X-IronPort-AV: E=Sophos;i="5.63,373,1557187200"; 
   d="scan'208";a="29002320"
IronPort-PHdr: =?us-ascii?q?9a23=3AeT2AcROPAVDb3z8IPnYl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/74rarrMEGX3/hxlliBBdydt6sdzbOI6uu5BTRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfK5+IA+roQjQq8UajpZuJ6ktxh?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipPDYOma4sEEvQPM+BWoYLgo1cCtBuzCA2pCO7p1zRGhGL53bci3u?=
 =?us-ascii?q?o8Dw/G0gwuEdEAvnvao9r6NrsdX++uwanUzjjOde9a1Svz5YXKdB0qvPGCXa?=
 =?us-ascii?q?h3ccrU0UQhCh/FgUuIqYzlITyV0PkGvXWe7+V6UeKvj3AoqgFsqTWo3ccjl5?=
 =?us-ascii?q?LJi5kJylHE6Sp5wIE1Kce+SE5ge9GoCpRQtyaEN4ZvRM4pXmJmuD4ix7Ebtp?=
 =?us-ascii?q?O2czIGxZQ6yxLFdfCKfJaE7gj+WOuXPDx2nmhqeKiliBa36UWgz+r8WdSq31?=
 =?us-ascii?q?tStSpFl8XMtmgK1xzO9siLUvt98Vml2TaIzw3T9vtLIVo1larGMJ4t2KIwl5?=
 =?us-ascii?q?oPvkTDGS/6gkP2g7ONdko44OSo7uXnYrH+qp+dMY97lB3+P7wzlsGwDuk0KA?=
 =?us-ascii?q?gDU3WB9eii27Dv41f1TKhSgv0ziKbZsZTaJcoBpq6+Bg9Yyp0j5AukDzq9zN?=
 =?us-ascii?q?QZnWUILFJCeB6diYjpIEvBLOr3Dfe4nVSgiC1ryOzePr39HpXNKWDOkLXmfb?=
 =?us-ascii?q?Z+6E5T1hA/zdBF6JJREL4BJOj8Wk73tNPGCB80KA+0w+HjCNVhyoMeXmSPDb?=
 =?us-ascii?q?GfMK/Iv1+I5/olI/OQa48NpDb9N/8l6ub1jXAnnV8dfK+p3YYYaX2jAPRmLF?=
 =?us-ascii?q?uWYWD2jtcCD2gKpAw+Q/LuiFGYVj5TfXmyDOoA4WQZD4GlAM/jyoUhhDCA2i?=
 =?us-ascii?q?q9VslUYWNFBxaMGHLhc4yFXfoKQCGVJtN9lToJU/6vStllnQqjsA781qpPMO?=
 =?us-ascii?q?XZ4GsbuIjl2dwz4Pfcxj8o8jkhNNiQy2GASSlPm2oMQzInlPRkrVdV1kaI0a?=
 =?us-ascii?q?8+hedRU9NU+aUaAU8BKZfAwrkiWJjJUQXbc4LMEQv3Tw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BGAwCN9gNd/wHyM5BmHQEBBQEHBQGBVAUBCwGBZiqBP?=
 =?us-ascii?q?DKDfkCSdkwBAQEBAQEGgTWJUpEMCQEBAQEBAQEBATQBAgEBhEACgkwjNwYOA?=
 =?us-ascii?q?QMBAQEEAQEBAQMBAWwogjopAYJnAQQBDBcECwEFUQkCGgImAgJXBgEMCAEBg?=
 =?us-ascii?q?l8/gXcFD41Am2p+M4VHgyCBRoEMKAGLXBd4gQeBESeCaz6HToJYBJNLlgkJg?=
 =?us-ascii?q?hKCG5EwBhuCKIcCjggtjG+YaSKBWCsIAhgIIQ+DKIIaF44fHSMDgTYBAY9JA?=
 =?us-ascii?q?QE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 14 Jun 2019 19:38:39 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x5EJcbu7023409;
        Fri, 14 Jun 2019 15:38:38 -0400
Subject: Re: [PATCH] trivial kernel_to_conf.c checks
To:     =?UTF-8?B?Sm9ra2UgSMOkbcOkbMOkaW5lbg==?= 
        <jokke.hamalainen@kolttonen.fi>, selinux@vger.kernel.org
References: <alpine.LFD.2.21.1905250034390.11070@34-41-5D-CA-59-C7>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d6a21545-82e5-6e0d-e802-7be986a4e3b6@tycho.nsa.gov>
Date:   Fri, 14 Jun 2019 15:38:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1905250034390.11070@34-41-5D-CA-59-C7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/24/19 5:36 PM, Jokke Hämäläinen wrote:

Re-post with Signed-off-by line please.

> 
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
> index 4f84ee8b..930bafab 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -448,8 +448,12 @@ static int write_sids_to_conf(FILE *out, const char *const *sid_to_str,
>   		if (i < num_sids) {
>   			sid = (char *)sid_to_str[i];
>   		} else {
> -			snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
> +			snprintf(unknown, sizeof(unknown), "%s%u", "UNKNOWN", i);
>   			sid = strdup(unknown);
> +			if (!sid) {
> +				rc = -1;
> +				goto exit;
> +			}
>   		}
>   		rc = strs_add_at_index(strs, sid, i);
>   		if (rc != 0) {
> @@ -792,6 +796,10 @@ static int write_sensitivity_rules_to_conf(FILE *out, struct policydb *pdb)
>   			j = level->level->sens - 1;
>   			if (!sens_alias_map[j]) {
>   				sens_alias_map[j] = strdup(name);
> +				if (!sens_alias_map[j]) {
> +					rc = -1;
> +					goto exit;
> +				}
>   			} else {
>   				alias = sens_alias_map[j];
>   				sens_alias_map[j] = create_str("%s %s", 2, alias, name);
> @@ -919,6 +927,10 @@ static int write_category_rules_to_conf(FILE *out, struct policydb *pdb)
>   			j = cat->s.value - 1;
>   			if (!cat_alias_map[j]) {
>   				cat_alias_map[j] = strdup(name);
> +				if (!cat_alias_map[j]) {
> +					rc = -1;
> +					goto exit;
> +				}
>   			} else {
>   				alias = cat_alias_map[j];
>   				cat_alias_map[j] = create_str("%s %s", 2, alias, name);
> @@ -2364,7 +2376,7 @@ static int write_sid_context_rules_to_conf(FILE *out, struct policydb *pdb, cons
>   		if (i < num_sids) {
>   			sid = (char *)sid_to_str[i];
>   		} else {
> -			snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
> +			snprintf(unknown, sizeof(unknown), "%s%u", "UNKNOWN", i);
>   			sid = unknown;
>   		}
>   
> 

