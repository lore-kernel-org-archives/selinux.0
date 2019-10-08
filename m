Return-Path: <SRS0=qSAh=YB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA27C4360C
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 14:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427FE206C0
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 14:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="OwX4T8Lr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfJHOEE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:04:04 -0400
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:64866 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfJHOEE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Oct 2019 10:04:04 -0400
X-EEMSG-check-017: 15796614|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,270,1566864000"; 
   d="scan'208";a="15796614"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 08 Oct 2019 14:04:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1570543441; x=1602079441;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=jw0KAYTkTYgVbzc663p9KbMv0zJzhai6pLIp86aSOwM=;
  b=OwX4T8LrbA0MYSNRfHUQXUOwnawjkqqS7lb6niY1lQ+SY1HqdB56UlSK
   tMi6YQ3gWWWiupXihguoWRwB0sI3SogInlcCRpg2XhWMHcf/c2YEdf3zP
   jl6c02t4yCyM62t9FIa4BJB3x7JlWQoY+JOwJl5xo8GgDKiDcgHEyhL9f
   MskWdtYii92/idMJKad87+12Igv7ENQemyZnoLmDJ7xCIxywNwTBTze5f
   6zhNpBwc5ObG2z31mfM5yOKY1fXp3MIJ2AicDh+7wsXsCnXSddU0+7cG5
   TGz+5EXIH6SfUa9kN0rvIJy6VgWmN1qHUV3I4U0AKTSq79xofI+wHuqAC
   g==;
X-IronPort-AV: E=Sophos;i="5.67,270,1566864000"; 
   d="scan'208";a="28762270"
IronPort-PHdr: =?us-ascii?q?9a23=3A0nwiiRcJJhNMH+UBj5WW07jdlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcSyZB7h7PlgxGXEQZ/co6odzbaP6Oa9CCdfut6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6twXcu80ZjYZgJKs61w?=
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
 =?us-ascii?q?QEknkHK1JJYhSHj5PzNF3UL/D4Cum/j0y2kDh33/DGIqHhApLVI3nDirjheK?=
 =?us-ascii?q?xy61JbyAco19BQ+Y9bCrEbL/LvQEP+qNvYDhohOQyu3+nnEMl91p8ZWW+XGa?=
 =?us-ascii?q?+WLqfSsV6O5uIyLOiBf5EVuDnjJPg//fLujmE2mUUbfaa32Zsbcne4Hu5pIx?=
 =?us-ascii?q?bRXX25p94aGHsDvQd2fcXPoWGlGWpCbnO7Q6UU/Dw3CIu6S4zEQ9bpyKeM2C?=
 =?us-ascii?q?a9A41+eG9LEBaPHG3ueoHCXO0DOwyIJco0qSAJTbisTcca0BiqsALrg+58Iv?=
 =?us-ascii?q?H85jwTtZWl0sN8oeLUi0dhpnRPE82B3jTVHClPlWQSSmpzhfsurA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BOBADllZxd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBd?=
 =?us-ascii?q?CqBPwEyKoQjjmJNAQEBAQEBBoE2iXiRLgkBAQEBAQEBAQE0AQIBAYRAAoJFI?=
 =?us-ascii?q?zgTAgwBAQEEAQEBAQEFAwEBbIU5gjopAYJoAQUjFVELGAICJgICVwYBDAYCA?=
 =?us-ascii?q?QGCXz+BdxSuBYEyhU2DL4FIgQwojA4YeIEHgTiCaz6HUYJYBJYmlxyCLIIwk?=
 =?us-ascii?q?mQGG5lAji2bRyKBWCsIAhgIIQ+DJ1AQFIFbF44/JQMwgQYBAZBjAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 08 Oct 2019 14:03:59 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x98E3x3k024626;
        Tue, 8 Oct 2019 10:03:59 -0400
Subject: Re: [PATCH 1/5] dispol: extend usage() to take exit status
To:     Masatake YAMATO <yamato@redhat.com>, selinux@vger.kernel.org
References: <20191008064500.8651-1-yamato@redhat.com>
 <20191008064500.8651-3-yamato@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <301d34c5-21b6-e279-ba7f-e983eac12ea0@tycho.nsa.gov>
Date:   Tue, 8 Oct 2019 10:03:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191008064500.8651-3-yamato@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/8/19 2:44 AM, Masatake YAMATO wrote:
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>

You appear to have sent two slightly different versions of this patch?

> ---
>   checkpolicy/test/dispol.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> index d72d9fb3..6c4829c4 100644
> --- a/checkpolicy/test/dispol.c
> +++ b/checkpolicy/test/dispol.c
> @@ -36,10 +36,10 @@
>   
>   static policydb_t policydb;
>   
> -static __attribute__((__noreturn__)) void usage(const char *progname)
> +static __attribute__((__noreturn__)) void usage(const char *progname, int status)
>   {
>   	printf("usage:  %s binary_pol_file\n\n", progname);
> -	exit(1);
> +	exit(status);
>   }
>   
>   int render_access_mask(uint32_t mask, avtab_key_t * key, policydb_t * p,
> @@ -395,7 +395,7 @@ int main(int argc, char **argv)
>   	struct policy_file pf;
>   
>   	if (argc != 2)
> -		usage(argv[0]);
> +		usage(argv[0], 1);
>   
>   	fd = open(argv[1], O_RDONLY);
>   	if (fd < 0) {
> 

