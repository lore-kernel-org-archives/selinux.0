Return-Path: <SRS0=yIcu=YI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93246ECE588
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 14:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666FE20873
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 14:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="qn0xI0lh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbfJOOWe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:22:34 -0400
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:12490 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732050AbfJOOWd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Oct 2019 10:22:33 -0400
X-EEMSG-check-017: 17673279|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="17673279"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Oct 2019 14:22:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571149352; x=1602685352;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=MaIHAyin/+ZDnRcbsLX5Bct7cjToViX4drW9/d1dHqs=;
  b=qn0xI0lhC6+Kl0epAsE6Gp6Nph8QtdiNpfRVe4+tFl/WsvCJ5FvdxxtA
   AITe18DGYPOkdmQTxeC+2fcFVYfav3h9YUhTQvqjEQXchsUSc8ewXRvRL
   IzXcszsobDPvRIg+1SCx9awpP9kRR3Q5Jet9CCJ8yo6GZpom/AOqSKymK
   6sxUcf0pzLuzztCVHdzQgm1oT0K5JsMKITDuD/fBSC+9z3BZRkiw4aWOw
   JcmKdRPJGHVOV2lfPPeyzFJpqe62Bslaat03Q/QqykykMTxaKOw/6QYOe
   amBCpuHL7V41RncM9jJUF8mHWzgypxoOtXGQv538s73XetSmZ5wBZVHbk
   w==;
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="34164108"
IronPort-PHdr: =?us-ascii?q?9a23=3ADRiFuhdH5x4N9AaKsh+B5GDnlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcSyYR7h7PlgxGXEQZ/co6odzbaP6Oa/Aidfu96oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6twfcu8cZjYZgNKo61w?=
 =?us-ascii?q?fErGZPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q6VAADspL2?=
 =?us-ascii?q?466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUj?=
 =?us-ascii?q?ms86tnVBnlgzocOjUn7G/YlNB/jKNDoBKguRN/xZLUYJqIP/Z6Z6/RYM8WSX?=
 =?us-ascii?q?ZEUstXWSNBGIe8ZJYRAeQHM+hTso3xq0IAoBa6AAWhAv7kxD1ViX/sxaA0zv?=
 =?us-ascii?q?ovEQ/G0gIjEdwBvnvbo9fpO6kdSu210KvFwC/fY/9K1zrw6o7FeQ0hr/GWWr?=
 =?us-ascii?q?JwdNLcx1QzFwzbllWQqZLqPzWI3eoQtmiU9e5gVeaxhG8ntgp8pSOvydo3io?=
 =?us-ascii?q?TSmoIUykzL9SV+wIovI924U1R0bcSrEJtXqSGXLo17Sd4hTWFwoCs217ILtJ?=
 =?us-ascii?q?GhcCUK1Zgr3QDTZvOZf4SS/x7uUvuaLy1ii3J/Yr2/gg6/8U2nyuLhSMa5yE?=
 =?us-ascii?q?1Kri9ZktnUsXANygDT5tCHSvRj+keh3i6C1xzJ5eFeIEA0iLHbJ4Q9wr8wip?=
 =?us-ascii?q?UTsUPDEjXwmErql6+Zal8o+u2p6+Tjernmp5mcOJFoigzmL6gjlcOyDf44Pw?=
 =?us-ascii?q?QTRWSX5+ux2KP58UHkWLlKi+c5kqjdsJDUP8Qboau5DhdO0ok+8BayFCum0d?=
 =?us-ascii?q?QEknkHK1JJYhSHj5PzNF3UL/D4Cum/j0y2kDh33/DGIqHhApLVI3jblLfuZ6?=
 =?us-ascii?q?t961JGyAUo199S/IhUBa8cL/LzQEDxqMbUAQM+Mwyx2+znEsly1psCWWKTBa?=
 =?us-ascii?q?+UKLjSvkGM5uIuJemMeYAUtS3jK/gq+fHul2U1mVwDcqmz25sYdnS4Eu5hI0?=
 =?us-ascii?q?WDbnq/yusGRF8HohB2aOX3lEeIWDVTLyKqW6sh+isxAaq8AIvDT5zri7uEim?=
 =?us-ascii?q?PzBZBSZ2ZbGniSHnryMYaJQfEBbGSVOMAyvCYDUO2aV4I51Ryo/DT/wr5jI/?=
 =?us-ascii?q?ucrjYUrrr/xdN14KvVjhh0+jtqWZfOm1qRRn15yztbDwQ927py9AkkkQaO?=
X-IPAS-Result: =?us-ascii?q?A2CrCACr1aVd/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBd?=
 =?us-ascii?q?CxsUwEyKoQljmFNAQEBAQEBBoE2iXiKDIcjCQEBAQEBAQEBASMRAQIBAYRAA?=
 =?us-ascii?q?oJuJDgTAgwBAQEEAQEBAQEFAwEBbIUtDII6KQGCaAEFIxVRCw4KAgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJfPwGCUiWvQ4EyhU2DMYFIgQwojA4YeIEHgTiCNjU+h1KCXgSWK?=
 =?us-ascii?q?5cfgiyCMYRZjgsGG4MslhUtjgSbTCKBWCsIAhgIIQ+DJwlHEBSCB4YRiBklA?=
 =?us-ascii?q?zCBBgEBkEEBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 15 Oct 2019 14:22:23 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9FEMNig017341;
        Tue, 15 Oct 2019 10:22:23 -0400
Subject: Re: [PATCH] libsepol: Use LIBSEPOL_3.0 and fix
 sepol_policydb_optimize symbol mapping
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20191011070716.198563-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8cecd4d2-7b46-6d41-62fe-fd33eda2376d@tycho.nsa.gov>
Date:   Tue, 15 Oct 2019 10:22:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011070716.198563-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/11/19 3:07 AM, Petr Lautrbach wrote:
> There's a typo in commit b8213acff837101 ("libsepol: add a function to optimize
> kernel policy") which added new function sepol_policydb_optimize(), but there's
> sepol_optimize_policy in libsepol.map.
> 
> LIBSEPOL_3.0 is used to follow the next release version libsepol-3.0
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   libsepol/src/libsepol.map.in | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
> index 6358e51f..f4946a79 100644
> --- a/libsepol/src/libsepol.map.in
> +++ b/libsepol/src/libsepol.map.in
> @@ -60,7 +60,7 @@ LIBSEPOL_1.1 {
>   	sepol_polcap_getname;
>   } LIBSEPOL_1.0;
>   
> -LIBSEPOL_1.2 {
> +LIBSEPOL_3.0 {
>     global:
> -	sepol_optimize_policy;
> +	sepol_policydb_optimize;
>   } LIBSEPOL_1.1;
> 

