Return-Path: <SRS0=HWnL=XN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468A5C4CEC4
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 12:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA87205F4
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 12:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="EC/AixD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbfIRMTi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:19:38 -0400
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:22423 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730902AbfIRMTi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Sep 2019 08:19:38 -0400
X-EEMSG-check-017: 14951672|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,520,1559520000"; 
   d="scan'208";a="14951672"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Sep 2019 12:19:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568809173; x=1600345173;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=5VfuF4sPR6lFhcL/Iq9ra13Y3xdChxAKOhrNSA9EYYo=;
  b=EC/AixD/8MotPypTSWw5DGenMej3zd0hmugGnhpLeQk+N+duIUAap2jK
   SD/kR3MqFVbHCtoXpkldLDUf+AvC1NjXhDJyrcQ6rfdqFDIXLE49MIz/p
   RvKmZwxjcc+bt5K8tfEwgGCGmJy0sbCDZD6UDOZW4BnkZT4+CtJwcmus9
   rs/YF7emv26+efgN+nycVoyG63FCU1GlM5BeKESsPhZ0TX4kbdVT6FSYC
   0RdheCVDszTSKVub5v6cJygH0cWX+FKty73Ce/2cK2j3gv+jYeMT0W9FI
   bAp9rXPxIJrzmI14Od5HkeFL9ZXV/eeQtHSzUo0IGLwH+6jMaH8/7XuzG
   w==;
X-IronPort-AV: E=Sophos;i="5.64,520,1559520000"; 
   d="scan'208";a="28038833"
IronPort-PHdr: =?us-ascii?q?9a23=3AWBbfbRBx3ObacUKFc2VOUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX+o8bcNUDSrc9gkEXOFd2Cra4d0KyP4+u9ASRAuc/H7ClYNsQUFl?=
 =?us-ascii?q?cssoY/p0QYGsmLCEn2frbBThcRO4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF?=
 =?us-ascii?q?2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+MAi6oR/eu8ULj4ZuMLs9xx?=
 =?us-ascii?q?jGrnZIZ+hd2GdkKU6Okxrm6cq84YBv/z5Mt/498sJLTLn3cbk/QbFEFjotLn?=
 =?us-ascii?q?o75NfstRnNTAuP4mUTX2ALmRdWAAbL8Q/3UI7pviT1quRy1i+aPdbrTb8vQj?=
 =?us-ascii?q?St871rSB7zhygZMTMy7XzahdZxjKJfpxKhugB/zovJa4ybKPZyYqXQds4BSG?=
 =?us-ascii?q?FfQsheSTBOAoKkb4sOEeUBO/pYr5LgrFcKtBeyGBWgCP/qxjJOiHD2x6k62P?=
 =?us-ascii?q?k/Hw/A0gIrAtYCvG3aodjxMasfV/2+wqvVwjXZd/5YxCnz6IbIfB4ir/+DU7?=
 =?us-ascii?q?1/fsjNxkcgDA7FkledpJb5Mz+J2OkAsW6W5PdgW+K1jG4nrhl8rCWzxsgyko?=
 =?us-ascii?q?nJhpwaylbZ/itkxYY6P9m4SEplbt+kDZBdsDqaOJZtQs45X2FpuDo1yr0BuZ?=
 =?us-ascii?q?KheigK044oywTQa/yAbYiF+xTuX/uSLzdgnH9pZb2yihmo/UWg1+HwTNe43V?=
 =?us-ascii?q?lUoiZfj9XBsG0G2QbJ5cidUPR9+1+s2TOI1w/O9O5JOVs0la/HK545xb4wi4?=
 =?us-ascii?q?YTvVzDHiDonEX2i7ebdlk+9eiy6uTnf67mqoWAN450lg7+MqMulta5AeskKQ?=
 =?us-ascii?q?gBQ3KX+eG91L3n5UH5QbNKgeMqkqTBrZzXKssWqrS5DgNIyIov9RmyAym83N?=
 =?us-ascii?q?gFhXUHKUhKeBODj4jnIVHOJ/X4AO+kg1uxizdm3OzGP739DZXNKXjPirHhfa?=
 =?us-ascii?q?1n5EJGxwozys5f64pOCr4dOPLzRlPxtNvAAx88Mgy0wPjoBM9l1owEXWKPB6?=
 =?us-ascii?q?6ZMKTOsV+U4eIiOPWDZJUIuDb7N/cl5/7vgmIjll8BZ6alx4cYaHe9Hv5+OU?=
 =?us-ascii?q?WWfWLsgssdEWcNpgc+V/LliFmDUT5VenazULkx5i80CI24F4fPXIOtj6Kb3C?=
 =?us-ascii?q?e9AJJWYnpKCleWEXfnJM24XKIpaSGfavdoljkFUqS9TMd10BCtuUniwr5iL+?=
 =?us-ascii?q?3I5iowvoj+0tN19uHaiRh0/jtxWYDVyGyJTmdpjksWSDIsmqNyu0pwzhGEy6?=
 =?us-ascii?q?crreZfEIlo+/5RUgo8faXZxuh+BsG6DhnNZf+VWV2mRZOgGjh3QdUvlYxdK3?=
 =?us-ascii?q?1hEsmv20iQlxGhBKUYwvnSX805?=
X-IPAS-Result: =?us-ascii?q?A2CoCgDyH4Jd/wHyM5BmHgEGDYFcC4FuKoFAMiqEIo8OU?=
 =?us-ascii?q?AEBAQaBESV+iHaRKAkBAQEBAQEBAQE0AQIBAYQ/AoMDIzcGDgIMAQEBBAEBA?=
 =?us-ascii?q?QEBBQMBAWyFOYI6KQGCZgEBAQECASMVUQsYAgImAgJXBgEMBgIBAYJfP4F3B?=
 =?us-ascii?q?Q+wToEyhUyDL4FJgQwojAkYeIEHgREnDIIqNT6HT4JYBIxqA4kNln6CLIIuk?=
 =?us-ascii?q?k8GG4I2i3CKeo4PmxkigVgrCAIYCCEPgydQEBSQLyQDMIEGAQGPbgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Sep 2019 12:19:32 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8ICJVZt007514;
        Wed, 18 Sep 2019 08:19:32 -0400
Subject: Re: [PATCH v2] libselinux: fix string conversion of unknown perms
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>,
        selinux@vger.kernel.org
References: <20190916203015.19474-1-mike.palmiotto@crunchydata.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <629b332a-eaf7-2107-a243-62b5b66ef061@tycho.nsa.gov>
Date:   Wed, 18 Sep 2019 08:19:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190916203015.19474-1-mike.palmiotto@crunchydata.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/16/19 4:30 PM, Mike Palmiotto wrote:
> Commit c19395d72295f5e69275d98df5db22dfdf214b6c fixed some handling of unknown
> classes/permissions, but missed the case where an unknown permission is loaded
> and then subsequently logged, either via denial or auditallow. If a permission
> set has some valid values mixed with unknown values, say `{ read write foo }`,
> a check on `{ read write foo }` would fail to log the entire set.
> 
> To fix this, skip over the bad permissions/classes when expanding them to
> strings. The unknowns should be logged during `selinux_set_mapping`, so
> there is no need for further logging of the actual unknown permissions.

It seems like we have a similar pattern in print_access_vector(), 
avc_dump_av(); if security_av_perm_to_string() returns NULL, we break 
out of the loops and skip the remaining bits.  We do however log the hex 
value of the any remaining bits set in the av, so we don't lose all 
information.  I think we can still take this patch as is but was 
wondering whether the other cases ought to be similarly handled?

> 
> Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>
> ---
>   libselinux/src/stringrep.c | 24 ++++++++----------------
>   1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
> index ad29f76d..b9bf3ee6 100644
> --- a/libselinux/src/stringrep.c
> +++ b/libselinux/src/stringrep.c
> @@ -268,7 +268,7 @@ const char *security_av_perm_to_string(security_class_t tclass,
>   
>   int security_av_string(security_class_t tclass, access_vector_t av, char **res)
>   {
> -	unsigned int i = 0;
> +	unsigned int i;
>   	size_t len = 5;
>   	access_vector_t tmp = av;
>   	int rc = 0;
> @@ -276,19 +276,12 @@ int security_av_string(security_class_t tclass, access_vector_t av, char **res)
>   	char *ptr;
>   
>   	/* first pass computes the required length */
> -	while (tmp) {
> +	for (i = 0; tmp; tmp >>= 1, i++) {
>   		if (tmp & 1) {
>   			str = security_av_perm_to_string(tclass, av & (1<<i));
>   			if (str)
>   				len += strlen(str) + 1;
> -			else {
> -				rc = -1;
> -				errno = EINVAL;
> -				goto out;
> -			}
>   		}
> -		tmp >>= 1;
> -		i++;
>   	}
>   
>   	*res = malloc(len);
> @@ -298,7 +291,6 @@ int security_av_string(security_class_t tclass, access_vector_t av, char **res)
>   	}
>   
>   	/* second pass constructs the string */
> -	i = 0;
>   	tmp = av;
>   	ptr = *res;
>   
> @@ -308,12 +300,12 @@ int security_av_string(security_class_t tclass, access_vector_t av, char **res)
>   	}
>   
>   	ptr += sprintf(ptr, "{ ");
> -	while (tmp) {
> -		if (tmp & 1)
> -			ptr += sprintf(ptr, "%s ", security_av_perm_to_string(
> -					       tclass, av & (1<<i)));
> -		tmp >>= 1;
> -		i++;
> +	for (i = 0; tmp; tmp >>= 1, i++) {
> +		if (tmp & 1) {
> +			str = security_av_perm_to_string(tclass, av & (1<<i));
> +			if (str)
> +				ptr += sprintf(ptr, "%s ", str);
> +		}
>   	}
>   	sprintf(ptr, "}");
>   out:
> 

