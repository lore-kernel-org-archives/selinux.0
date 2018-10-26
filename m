Return-Path: <SRS0=niUd=NG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D81ECDE44
	for <selinux@archiver.kernel.org>; Fri, 26 Oct 2018 13:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF38520665
	for <selinux@archiver.kernel.org>; Fri, 26 Oct 2018 13:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF38520665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbeJZWbm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:31:42 -0400
Received: from ucol19pa11.eemsg.mail.mil ([214.24.24.84]:29856 "EHLO
        UCOL19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJZWbm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Oct 2018 18:31:42 -0400
X-EEMSG-check-008: 606265738|UCOL19PA11_EEMSG_MP9.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,428,1534809600"; 
   d="scan'208";a="606265738"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Oct 2018 13:54:30 +0000
X-IronPort-AV: E=Sophos;i="5.54,428,1534809600"; 
   d="scan'208";a="19915977"
IronPort-PHdr: =?us-ascii?q?9a23=3AdWYgvR2Zi6ibp47TsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWKv3xwZ3uMQTl6Ol3ixeRBMOHs60C07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwdFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
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
 =?us-ascii?q?4CkXkIK1JFZgqLj5L1NFHWPPD4EfC/jkyskTd2w/DGP6ftApbNLnjEjbjheq?=
 =?us-ascii?q?x9601byAot1tBf5JNUC7EaLf3vQE/xqdrYAQM5Mw203unoEsl92ZkEVW2TBa?=
 =?us-ascii?q?+ZNbvYsUWU6eI3P+mMeIgVtS7mK/c74/7ujHk5mUISfKSyw5sXZ263Hu58L0?=
 =?us-ascii?q?Waf3XsmNEBHnkOvgYkS+zqklKCWyZJZ3muR6I8+i07CIW+AIfBQYCtm7yB3D?=
 =?us-ascii?q?qhEZFMfW9GEFGMEXH1eIWARfgBcz6dItV8kjwCSbehS48g2gy0uw/m0bVrNP?=
 =?us-ascii?q?bb+iodtcGr6N8g1vDXlFkR9Tt4CN6e1H+WTGBl1jcZWjs3mqN/pkB60FSEz7?=
 =?us-ascii?q?N7gu1wHsZO4fhJQwszKZeaxOt/XZS6QQ/Ff9GUWH64Tdi8RzI8VNQ8x5kJeU?=
 =?us-ascii?q?kuNc+li0X4wyeyA7IT34eODZgw/7OUi2P9PO5h2n3G0+8nlFBgTcxRYz71zp?=
 =?us-ascii?q?Vj/hTeUtaa236SkLynIOFFhnbA?=
X-IPAS-Result: =?us-ascii?q?A2BTAABnG9Nb/wHyM5BjGgEBAQEBAgEBAQEHAgEBAQGBZ?=
 =?us-ascii?q?YFbKoFlKIN1lDBSBoE1iQuQDDgBhEACgxchOBYBAwEBAQEBAQIBbCiCNiQBg?=
 =?us-ascii?q?mABBSMVQRALGAICJgICVwYBDAYCAQGCXj+BdQ2mH4EuhTuEYIELil0XeYEHg?=
 =?us-ascii?q?REngmuIAoJXAoh4hiaPYQmQeQYYkEUsmEAhgVUrCAIYCCEPgyeQcyMwgQUBA?=
 =?us-ascii?q?Yw9AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 26 Oct 2018 13:54:29 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w9QDsRkH003235;
        Fri, 26 Oct 2018 09:54:28 -0400
Subject: Re: [PATCH v2] mcstrans: remove unused getpeercon_raw() call
To:     Yuli Khodorkovskiy <yuli.khodorkovskiy@crunchydata.com>,
        selinux@vger.kernel.org
Cc:     Joshua Brindle <joshua.brindle@crunchydata.com>
References: <20181024153519.22187-1-yuli@crunchydata.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2e0e0990-f469-fef1-5f6e-4911edcf2bbd@tycho.nsa.gov>
Date:   Fri, 26 Oct 2018 09:56:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181024153519.22187-1-yuli@crunchydata.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/24/2018 11:35 AM, Yuli Khodorkovskiy wrote:
> There is a call to getpeercon_raw() in mcstransd, but nothing is done
> with the context. The purpose of process_request() is to translate a
> context and we would like that to succeed even if, for some reason,
> getpeercon_raw() fails.
> 
> Signed-off-by: Yuli Khodorkovskiy <yuli@crunchydata.com>
> Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>

Thanks, applied.

> ---
>   mcstrans/src/mcstransd.c | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> v2:
> - Remove comment about MLS clearance check in peercon
> 
> diff --git a/mcstrans/src/mcstransd.c b/mcstrans/src/mcstransd.c
> index d7fc5dea..85899493 100644
> --- a/mcstrans/src/mcstransd.c
> +++ b/mcstrans/src/mcstransd.c
> @@ -142,17 +142,8 @@ process_request(int fd, uint32_t function, char *data1, char *UNUSED(data2))
>   {
>   	int32_t result;
>   	char *out = NULL;
> -	char *peercon = NULL;
>   	int ret;
>   
> -	ret = getpeercon_raw(fd, &peercon);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* TODO: Check if MLS clearance (in peercon) dominates the MLS label
> -	 * (in the request input).
> -	 */
> -
>   	switch (function) {
>   	case SETRANS_INIT:
>   		result = 0;
> @@ -184,7 +175,6 @@ process_request(int fd, uint32_t function, char *data1, char *UNUSED(data2))
>   	}
>   
>   	free(out);
> -	freecon(peercon);
>   
>   	return ret;
>   }
> 

