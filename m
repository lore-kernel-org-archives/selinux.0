Return-Path: <SRS0=09KC=QN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADBBC169C4
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 14:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05E320844
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 14:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Q97ypGWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfBFOFs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:05:48 -0500
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:48565 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbfBFOFs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Feb 2019 09:05:48 -0500
X-EEMSG-check-017: 682996658|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.58,340,1544486400"; 
   d="scan'208";a="682996658"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Feb 2019 14:05:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1549461905; x=1580997905;
  h=subject:to:references:from:cc:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=hQEK9itWzIS/bYz5IWZOrdcQ8dy5xCJ21Gvq+zy2E6s=;
  b=Q97ypGWQADwUSVbJzymHsjbYwFxfCbdfQyZB1cccqtCvX0IQsc5SHnI3
   SOZF0IwWRIfSNYD3pMvXQyDJRhYN6LmLci8g9I4/vi2hEuemIHEFvjdFv
   fyIFYV9aaHpv81lSRoOBy1SPfnjw8KnxSsZL/zISfPpllclrqxgdTIYsP
   xmK/ExKnZgMpQYDLrK/GE7Yra1z9ydnRvrXahUQPuN33tbgPJohss0gEC
   Lf9PtwrnOLp9srB3wDvLEHfTTOu3XN9s3jCkhxitLUgJQhaTR3kJDzyCR
   dK+GaIEG6z1bNf/lVTtTC2w7e7jNj6WZZGnMJuqqkma7jyCvTiWu3sc6c
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,340,1544486400"; 
   d="scan'208";a="23564244"
IronPort-PHdr: =?us-ascii?q?9a23=3AyCMtJxKhOs97KHRTP9mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfL/nxwZ3uMQTl6Ol3ixeRBMOHs6IC07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwZFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUj?=
 =?us-ascii?q?q+8ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfVwZKPdec4RS3?=
 =?us-ascii?q?RHUMhfSidNBpqwY5UTA+YEO+tTsovzqEYUrRamGAeiGu3vxD9LiHH406I13O?=
 =?us-ascii?q?YuHh3J0gE7A9IDsm7ZoMnpOKocU+24yrTDwzXZb/NR3Dfw8JXGcgw/rvGUXb?=
 =?us-ascii?q?J/b8zRwlQyGQPAlFqQrYjlMC2V1+8QtGWb9PdvVfm0hm47qwB+vjivxsA2ho?=
 =?us-ascii?q?nPnYIa0ErI9Sp+wIYrPNC1TlNwb928EJZIqi2XOIR7TtkiTm11oio21LILtY?=
 =?us-ascii?q?ChcCQXzpks2gTRZOadc4eS5xLuTOORITBli317YL+/nBOy8VS4yu37S8m0zE?=
 =?us-ascii?q?5GripbndnIsXAAzwDT5dKdSvt840ehwiyD1xzT6+5YIUA0krDXK5g9zb4rip?=
 =?us-ascii?q?Ufq0HDHi7ymEnuja+WcFsr+vSw5uj6bbjrqYWQOo9phg3kLKgjldKzDf4lPg?=
 =?us-ascii?q?QWWmiU4+W81Lnt/U3jR7VKi+U7krLEv5DBPskbuq64DBNV0oYk8Rq/CSym38?=
 =?us-ascii?q?4CkXkIK1JFZgqLj5L1NFHWPPD4EfC/jkyikTdqw/DGOrzhDY/ILnXYnrbhfq?=
 =?us-ascii?q?hy60hayAoyy9Bf6I5UCrYHIP7pRkDxs9nYBAcjMwOo2+bnFMl91oQGVGKUHK?=
 =?us-ascii?q?CZNKLSsVmV5uMgOOSMeoAVtyjnK/Q/5P7hk2U5mVkDcqmtx5cXb2q4Hvt+KU?=
 =?us-ascii?q?WDfXXsmssBEXsNvgcmVOzlkkCCUTpIanaqRa08+zU7BJujDYfEQYCtmqKO0D?=
 =?us-ascii?q?2nEZ1RY2AVQmyLRD3XdoGAWv4JIAvUauxslDoFU7e9TIlp9DCP/keu1LtjKu?=
 =?us-ascii?q?vd/wUHtp/l0tlz6PHUk1c58jkiS4yG3mWMSXxktn0HSiVw361lp0F5jFCZ3v?=
 =?us-ascii?q?tWmftdQOdP6utJXwFyDpvVy+h3GpimQQ7aVsuYQ1ahBNO9CHc+ScxnkIxGWF?=
 =?us-ascii?q?p0B9j31kOL5CGtGbJA0uXRXJE=3D?=
X-IPAS-Result: =?us-ascii?q?A2DhAwC46Fpc/wHyM5BlHAEBAQQBAQcEAQGBZYFbKWdQA?=
 =?us-ascii?q?TInhAOUUQEBAQEBAQaBCC2JNZBVKBABhEACgxoiOBIBAwEBAQEBAQIBbBwMg?=
 =?us-ascii?q?jopAYJmAQEBAQIBIxVBEAsYAgImAgJXBgEMBgIBAYJfPwGBdAUIrH6BL4VEh?=
 =?us-ascii?q?HiBC4s4F3iBB4ERJ4JrhEqDQIJXApEAOpFOCYc3iwYGGYI+kBCKLJNLIYFWK?=
 =?us-ascii?q?wgCGAghD4MnCYtDhS8hAzCBBQEBiyaCTQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Feb 2019 14:04:58 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x16E4vaY024450;
        Wed, 6 Feb 2019 09:04:58 -0500
Subject: Re: [PATCH] selinux: Fix classmap for BPF
To:     "William A. Kennington III" <william@wkennington.com>,
        selinux@vger.kernel.org
References: <20190206041747.11377-1-william@wkennington.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>
Message-ID: <cebc12f0-5fb0-218c-331a-a785e2eece70@tycho.nsa.gov>
Date:   Wed, 6 Feb 2019 09:04:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206041747.11377-1-william@wkennington.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/5/19 11:17 PM, William A. Kennington III wrote:
> Entries in the secclass_map are expexted to be null terminated. The BPF
> entry was added without the NULL terminating and incosistent formatting.
> This patch cleans that up.

Thanks.  A few minor nits:

A couple of spelling errors above (expected, inconsistent).  Also, per 
Documentation/process/submitting-patches.rst, rather than say "This 
patch cleans that up", say "Clean that up" or similar.

Can add a:
Fixes:  ec27c3568a34c7f ("selinux: bpf: Add selinux check for eBPF 
syscall operations")

> 
> Signed-off-by: William A. Kennington III <william@wkennington.com>
> ---
>   security/selinux/include/classmap.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index bd5fe0d3204a..7ff68a5e4c58 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -239,7 +239,7 @@ struct security_class_mapping secclass_map[] = {
>   	{ "infiniband_endport",
>   	  { "manage_subnet", NULL } },
>   	{ "bpf",
> -	  {"map_create", "map_read", "map_write", "prog_load", "prog_run"} },
> +	  { "map_create", "map_read", "map_write", "prog_load", "prog_run", NULL } },

Should likely break the line to make checkpatch.pl happy:

$ ./scripts/checkpatch.pl -g HEAD
WARNING: line over 80 characters
#24: FILE: security/selinux/include/classmap.h:242:
+	  { "map_create", "map_read", "map_write", "prog_load", "prog_run", 
NULL } },


>   	{ "xdp_socket",
>   	  { COMMON_SOCK_PERMS, NULL } },
>   	{ NULL }
> 

