Return-Path: <SRS0=qBB/=XL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E74C49ED7
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 20:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0521E206C2
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 20:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="mVSuwPGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391157AbfIPUBy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Sep 2019 16:01:54 -0400
Received: from UHIL19PA38.eemsg.mail.mil ([214.24.21.197]:39036 "EHLO
        UHIL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfIPUBy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Sep 2019 16:01:54 -0400
X-EEMSG-check-017: 25772370|UHIL19PA38_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="25772370"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Sep 2019 20:01:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568664097; x=1600200097;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=bzyOg797xt1cVXIx7PWr5CuJSdMVw6BeKOze7mQI3FQ=;
  b=mVSuwPGF67bKtQAAMab7z9MWhHuk4+wA1E9hJoulr4ogzqIOssrmAyRH
   7DgDUyjWC8AlRcbBP3uNuJe+IAmuPy3z5WXr+Ol5HE2S8yAuNQaEC980c
   qX8bWGrzQYi7pudyCIGhB1xuZx/T653RiypXAcZErZs+9caAgRnPMutQ7
   U//jMJx3Zt5T1Tg4aTPBvkccDm6Ve/RAKmRNasEUJbeXZM+OVzVdS+eu1
   hHFd2ypUIPeYZs4Q7+T6Qm4JsaC9IEXzMvcCa0Pm03AhP5uERVQItSVsY
   okxU2EQDWtaJeK63nQAVBfiXqJNaAPrhtJyf/EbvNY+IVJt7eZPPKqc1O
   A==;
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="32914997"
IronPort-PHdr: =?us-ascii?q?9a23=3A+oQznReCbw/c6l8OLDFrWkbxlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcW/Yx7h7PlgxGXEQZ/co6odzbaP6Oa5AidZvcrJ8ChbNsAVDV?=
 =?us-ascii?q?ld0YRetjdjKfbNMVf8Iv/uYn5yN+V5f3ghwUuGN1NIEt31fVzYry76xzcTHh?=
 =?us-ascii?q?LiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyKwi9oRnMusUMjoZuN6g8xg?=
 =?us-ascii?q?HUrnZGdOha2GxlKF2OlBr4+su84YRv/itNt/4/7cJMTbn2c6ElRrFEEToqNH?=
 =?us-ascii?q?w46tf2vhfZVwuP4XUcUmQSkhVWBgXO8Q/3UJTsvCbkr+RxwCaVM9H4QrAyQj?=
 =?us-ascii?q?Si8rxkSAT0hycdNj4263/Yh8pth69Guh2hphh/w4nJYIGJMfd1Y63Qcc8GSW?=
 =?us-ascii?q?dHQ81cTDJKDJ+iYIQTDuoBJedYoJf7p1sSthu1GA2gCPryxjNUmnP62Ks33O?=
 =?us-ascii?q?o7EQHCwQcuAdQAvnrJp9nxLasfX+S4wKzOwD7ebf1ZxC395ZDVfB4/r/GCXb?=
 =?us-ascii?q?F+f8TfxkYgFQzKklqepJf5Pz6XzOkBr3SX4uRiWO+plmUpqxtxoj+qxso0l4?=
 =?us-ascii?q?fJmpwaykjE9SpnxoY+OMC2SEthbt6gFJtfqSGbPJZxT8M5Xm5ooz03yqEGuJ?=
 =?us-ascii?q?GnfCgKz44rxxjEa/OdaYSI7RXjVPiILDp+mXlre6q/ig6v/UWvxeDwTMm53E?=
 =?us-ascii?q?tQoiZbndTAqGoB2wHV58OaUPVy5F2h1iyK1w3L7+FEJl07mrTDJp46x74wio?=
 =?us-ascii?q?ITsUPeHi/qgEn2jLGZdkEj+uWw9+ToeK/mpp6BN49vkA3+LqQvldC/AeQ/KA?=
 =?us-ascii?q?QOWXSU+f+g27H5+E35QbFKguU3kqnfrp/aOdwWqrO2DgJayIou6wuzAy243N?=
 =?us-ascii?q?kXg3ULNk9JdAqCj4fzOlHOJP74De24g1SpiDpr3O3JPqb6D5XRLnnMjLfhfb?=
 =?us-ascii?q?Fn505a0wo818pT551TCrEfOP7zQFP+tMTEDh8lNAy52+PnCNR+1owAQ26PGr?=
 =?us-ascii?q?WWMKfXsV+J4eIvP/WMZIgOtTnhMfgl+vjugmM5mV4dYKamx4cXZ2qiEvt6JE?=
 =?us-ascii?q?WZZGLmgs0dHmcSogo+UOvqhUWZUTFNY3ayXqQ85iw0CY+9E4fDSZ6igKab0C?=
 =?us-ascii?q?e4AJJWfGZGBU6IEXvycIWEQfgMO2quJZpEkz8JHYCoT4og0g2ys0euzrtkI6?=
 =?us-ascii?q?zM8ykdtJX/yN9d7PfOkxoy5DB9E83b2GaIGSU8hW4MRjkrzIhhrkFnjFSOy6?=
 =?us-ascii?q?51h7pfD9MAyelOV1IBKZPEz+F8Q+v3UwbFc8bBHE2qWf26EDoxSZQ32NZIbE?=
 =?us-ascii?q?FjTYbxxivf1janVudG34eAA4Y5p+eFhCn8?=
X-IPAS-Result: =?us-ascii?q?A2DADgDK6H9d/wHyM5BmHQEBBQEHBQGBZ4FuKoE/ATIqh?=
 =?us-ascii?q?CGPCU0BAQEBAQEGgREliXORJwkBAQEBAQEBAQE0AQIBAYQ/AoJvIzgTAgwBA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIU6gjopAYJnAQUjFUYLCxgCAiYCAlcGAQwGAgEBgl8/g?=
 =?us-ascii?q?XcUrWOBMoVMgzeBSYEMKIt4GHiBB4E4DIJfPodPglgEjGeJCpZ5giyCLpJMB?=
 =?us-ascii?q?huCNYtsiniOCZsTIYFYKwgCGAghD4MnkSMkAzCBBgEBj24BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 16 Sep 2019 20:01:36 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8GK1aO7001030;
        Mon, 16 Sep 2019 16:01:36 -0400
Subject: Re: [PATCH] libselinux: fix string conversion of unknown perms
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>,
        selinux@vger.kernel.org
References: <20190910195353.973-1-mike.palmiotto@crunchydata.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <088debd8-0781-99ab-48a9-30bfa2e7a776@tycho.nsa.gov>
Date:   Mon, 16 Sep 2019 16:01:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910195353.973-1-mike.palmiotto@crunchydata.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/10/19 3:53 PM, Mike Palmiotto wrote:
> Commit c19395d72295f5e69275d98df5db22dfdf214b6c fixed some handling of unknown
> classes/permissions, but missed the case where an unknown permission is loaded
> and then subsequently logged, either via denial or auditallow. If a permission
> set has some valid values mixed with unknown values, say `{ read write foo }`,
> a check on `{ read write foo }` would fail to log the entire set.
> 
> To fix this, skip over the bad permissions/classes when expanding them to
> strings. The unknowns should be logged during `selinux_set_mapping`, so
> there is no need for further logging of the actual unknown permissions.
> 
> Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>
> ---
>   libselinux/src/stringrep.c | 28 ++++++++++++----------------
>   1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
> index ad29f76d..85579422 100644
> --- a/libselinux/src/stringrep.c
> +++ b/libselinux/src/stringrep.c
> @@ -276,19 +276,15 @@ int security_av_string(security_class_t tclass, access_vector_t av, char **res)
>   	char *ptr;
>   
>   	/* first pass computes the required length */
> -	while (tmp) {
> +	for (i = 0; tmp; tmp >>= 1, i++) {

Remove the redundant initialization in the declaration now that you are 
doing it here (which is better, I agree).

>   		if (tmp & 1) {
>   			str = security_av_perm_to_string(tclass, av & (1<<i));
> -			if (str)
> -				len += strlen(str) + 1;
> -			else {
> -				rc = -1;
> -				errno = EINVAL;
> -				goto out;
> +			if (!str) {
> +				continue;
>   			}

No need to bracket it when it is a single statement.

> +
> +			len += strlen(str) + 1;

Might be clearer as:
	if (str)
		len += strlen(str) + 1;
And just let it fall through to the end of the loop otherwise - no need 
for explicit continue here.

>   		}
> -		tmp >>= 1;
> -		i++;
>   	}
>   
>   	*res = malloc(len);
> @@ -298,7 +294,6 @@ int security_av_string(security_class_t tclass, access_vector_t av, char **res)
>   	}
>   
>   	/* second pass constructs the string */
> -	i = 0;
>   	tmp = av;
>   	ptr = *res;
>   
> @@ -308,12 +303,13 @@ int security_av_string(security_class_t tclass, access_vector_t av, char **res)
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
> +			if (str) {
> +				ptr += sprintf(ptr, "%s ", str);
> +			}

No need for { } around a single statement.

> +		}
>   	}
>   	sprintf(ptr, "}");
>   out:
> 

