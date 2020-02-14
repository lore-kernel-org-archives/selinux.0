Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213F9C35242
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 19:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4D620873
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 19:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Xc0RWOlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387557AbgBNTlw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:41:52 -0500
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:24006 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387571AbgBNTlw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 14:41:52 -0500
X-EEMSG-check-017: 59168369|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,441,1574121600"; 
   d="scan'208";a="59168369"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Feb 2020 19:41:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581709308; x=1613245308;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=Cid2LchZTKKHp5ARthEwa3D3NjdH6R7c/bKKG5kCPz0=;
  b=Xc0RWOlbuh1reuS/2+FXyDUM1cnFOaKMC0kiIGU1J9ge8/PMMUXdUqIu
   nQ+Qt8i7MIn0b1SQEQ3UfKYSvtIy+FXcojdo4Lwgu8pMSamKSQ+/ypPtF
   hKxDcLRNwWqDnWviPTkOcmqETy4iADHucsDPzlKFSu6uXNEwAX3G/3sku
   THjjTLPJxw/ouX8QOw3dlpmJhUsZtI/CocOCIyyObQzEBxulow+LLBV8r
   3T9P+2PDo5BTgr/DyAI8jYBWPuRuDGaInh9UmNUXDQQvTIjYG09YoHjsa
   nV54jyKNIBgs8R5d7bvTslalh9tDkb9S+2srMeBPz5I4HVna8AB4utI0a
   g==;
X-IronPort-AV: E=Sophos;i="5.70,441,1574121600"; 
   d="scan'208";a="33094192"
IronPort-PHdr: =?us-ascii?q?9a23=3A9+JFyhEeoaJMBtx23GQbyp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zr8mwAkXT6L1XgUPTWs2DsrQY0raQ7PirADZeqb+681k8M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi5oAnLtMQanYRuJrsvxh?=
 =?us-ascii?q?bIv3BFZ/lYyWR0KF2cmBrx+t2+94N5/SRKvPIh+c9AUaHkcKk9ULdVEjcoPX?=
 =?us-ascii?q?0r6cPyrRXMQheB6XUaUmUNjxpHGBPF4w3gXpfwqST1qOxw0zSHMMLsTLA0XT?=
 =?us-ascii?q?Oi77p3SBLtlSwKOSI1/H3Rh8dtgq1buhahrAFhzYDSbo+eKf5ycrrTcN4eQG?=
 =?us-ascii?q?ZMWNtaWS5cDYOmd4YBEvQPPehYoYf+qVUBoxSxCguwC+3g0TJImnz70Lcm3+?=
 =?us-ascii?q?g9HwzL3gotFM8OvnTOq9X1Mb8fX/2pzKbW1TXDb+1Z2THg44bVdxAuu/WMXb?=
 =?us-ascii?q?ZufsvR1EIiEBjFgUiLqYH+IzOU1vgCs2ic7+Z6U+KvkHQopxt+ojio2Mchk4?=
 =?us-ascii?q?/EjZ8WxFDc7Sh13Yk4KNKiREN7fNKoCoVcui6EO4dsX88vRXxjtjwgxb0co5?=
 =?us-ascii?q?G7eTAHyJEgxxHCdfOKa5OI4hf/VOaJJjd4mW5ldKq/hxms9UigzfXxVtWu31?=
 =?us-ascii?q?ZQrypFj8LMumoM1xzV5MiHTeB98Vm91jqVywDS6v1LIUAzlabBLZ4u3qUwmY?=
 =?us-ascii?q?YJvUTGHy/2nF36jK6Qdko65uil8/nrb7rpq5OGN4J4lxvyProhl8ChG+g0Lx?=
 =?us-ascii?q?ACX22B9uS90L3j81f5QLJPjvAuianWrYvaKN8Hpq+5HwBV0oEj5wy5Dze9yt?=
 =?us-ascii?q?sUh3YHLFVbeB6flYjmJ0nOIOzkDfe4m1mjjDhrxvHBPr3nHJrNNWPOkLjmfb?=
 =?us-ascii?q?Z65E5czBQ8zdVF6JJVDrENOu78Wkj0tNbAFB82LxS0w/r7CNV6zo4eQnyAAq?=
 =?us-ascii?q?uYMKPUrF+J6fkiI/eDZIALojbxMfsl6OD0jX8/h1AdebOl3ZwNaHC3TbxaJB?=
 =?us-ascii?q?CyYWDtmcsAGGE9kZQiUPfhiFDKBTVcdXG0UrkU6TY8B4arCI7CQsamh7nXmG?=
 =?us-ascii?q?+gE5lXYH1WIk6DHG2udIieXfoILiWILZxPiDsBAIO9Rpch2Bfmjwrzz75qP6?=
 =?us-ascii?q?KA4SEDnY7y39hyoevInFc98iIiXJfV6H2EU2whxjBAfDQxxq0q5Bcsxw=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2AsBABz9kZe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXsCg?=
 =?us-ascii?q?XuCDRIqhBSJA4ZcAQEBAwaBN4lwiieHIwkBAQEBAQEBAQE3BAEBhEACgiU4E?=
 =?us-ascii?q?wIQAQEBBQEBAQEBBQMBAWyFQ0IBEAGBZymDAwEFIw8BBVELGAICJgICVwYBD?=
 =?us-ascii?q?AYCAQGCYz+CSwMJJa5EgTKFSoJcDWKBPoEOKgGMPXmBB4E4D4IoNT6CG4VAg?=
 =?us-ascii?q?jwiBJgNl22CRIJPk3wGHJsYLY47nT8igVgrCAIYCCEPgydQGA2OKReOQSMDM?=
 =?us-ascii?q?IolhjMBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 14 Feb 2020 19:41:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01EJemDW012827;
        Fri, 14 Feb 2020 14:40:48 -0500
Subject: Re: [PATCH] libselinux: drop error return from is_selinux_enabled
 documentation
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
References: <20200207143744.9944-1-cgzones@googlemail.com>
 <20200214184751.8211-1-cgzones@googlemail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c62a2099-fa22-2ff8-bf14-0350e786864d@tycho.nsa.gov>
Date:   Fri, 14 Feb 2020 14:42:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214184751.8211-1-cgzones@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/14/20 1:47 PM, Christian Göttsche wrote:
> Since commit e3cab998b48ab293a9962faf9779d70ca339c65d ("libselinux
> mountpoint changing patch.") for version 20120216 is_selinux_enabled()
> does never return -1; drop mentions in the man-page and header file.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   libselinux/include/selinux/selinux.h     | 2 +-
>   libselinux/man/man3/is_selinux_enabled.3 | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
> index 7922d96b..883d8b85 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -8,7 +8,7 @@
>   extern "C" {
>   #endif
>   
> -/* Return 1 if we are running on a SELinux kernel, or 0 if not or -1 if we get an error. */
> +/* Return 1 if we are running on a SELinux kernel, or 0 otherwise. */
>   extern int is_selinux_enabled(void);
>   /* Return 1 if we are running on a SELinux MLS kernel, or 0 otherwise. */
>   extern int is_selinux_mls_enabled(void);
> diff --git a/libselinux/man/man3/is_selinux_enabled.3 b/libselinux/man/man3/is_selinux_enabled.3
> index df62c225..a887b48c 100644
> --- a/libselinux/man/man3/is_selinux_enabled.3
> +++ b/libselinux/man/man3/is_selinux_enabled.3
> @@ -15,7 +15,6 @@ is_selinux_mls_enabled \- check whether SELinux is enabled for (Multi Level Secu
>   .SH "DESCRIPTION"
>   .BR is_selinux_enabled ()
>   returns 1 if SELinux is running or 0 if it is not.
> -On error, \-1 is returned.
>   
>   .BR is_selinux_mls_enabled ()
>   returns 1 if SELinux is capable of running in MLS mode or 0 if it is not. To
> 

