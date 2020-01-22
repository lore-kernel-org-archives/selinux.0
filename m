Return-Path: <SRS0=wfQh=3L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593DAC2D0DB
	for <selinux@archiver.kernel.org>; Wed, 22 Jan 2020 13:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE0824655
	for <selinux@archiver.kernel.org>; Wed, 22 Jan 2020 13:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="X8BdAJ47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgAVNzk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:55:40 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:25392 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgAVNzk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Jan 2020 08:55:40 -0500
X-EEMSG-check-017: 48317197|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,350,1574121600"; 
   d="scan'208";a="48317197"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Jan 2020 13:55:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579701337; x=1611237337;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=SNrCeswVHqi2y+dnuQWb0nq69AKBcfyKR+aXaGzA+5g=;
  b=X8BdAJ47zdkhb1DWLNT7YOjeclegrqqjLfHkn71etCtwD6fq+TNVbjeg
   MKHkVfE2SEbIV4kJFVY52F9ermYeju4NEv9+zzND/Nz08631Ud1aC1WiT
   F0m1IULZnuKjg3k/JQhbHhgJS5qumr/OLRh8K/DTTlW7cmCcKsMoGR8JM
   fpiRPPoiZuUwOtYNAxPzK5B+NhFRQSrRACO68BGSwdRxviLwsaTp0Rb2o
   K7M4QNKmY/1SRaYXRrfzQ+WMDHpIqKqB6monIMYDlZLddhiPKhXiLGhfM
   VTE2hbq+lggPdMpc0qooGD2X9qFYls1dbT4yFqDv5VMdUo7ldCruIjthq
   w==;
X-IronPort-AV: E=Sophos;i="5.70,350,1574121600"; 
   d="scan'208";a="32195158"
IronPort-PHdr: =?us-ascii?q?9a23=3AaDASAR80vJj5+f9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0+IVIJqq85mqBkHD//Il1AaPAdyHragcwLeM++C4ACpcuM3H6ChDOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjeu8UMn4duNqk9xx?=
 =?us-ascii?q?vXrnBVf+ha2X5kKUickhrh6Mq85oJv/zhVt/k868NOTKL2crgiQ7dFFjomKW?=
 =?us-ascii?q?c15MPqtRnHUwSC42YXX3sVnBRVHQXL9Qn2UZjtvCT0sOp9wzSaMtbtTb8oQz?=
 =?us-ascii?q?Si7rxkRwHuhSwaKjM26mDXish3jKJGvBKsogF0zoDIbI2JMvd1Y7jQds0GS2?=
 =?us-ascii?q?VfQslRVjRBAoKiYIsJE+oBJvtTo43kq1cTsReyGQygCeXhxT9Sgn/9wLM03e?=
 =?us-ascii?q?IvHwrb2AAsBtwDvXDRoNjzKawcU/26zLPQwDvecf1W1zfz5ovGfB8vrv6DX6?=
 =?us-ascii?q?5/f8XKxEkzFQ7IlEmcpZDrMj6X0OkGrmiV7/BnVeKqk2Mpth1xrSa3xscslI?=
 =?us-ascii?q?bJgJ8exE3B9SpjxIY1IcO3SU5matOjC5tfqjqaOpBqQsIiX25ouCE6xqcAuZ?=
 =?us-ascii?q?6gZicG0psnxxnBa/GedYWD/xztVOGUIThihXJlfqqyhxmz8Ui8yu38S9K73E?=
 =?us-ascii?q?xWoSpCl9nBsG0G2R/L6sWfV/dw8Uis1SyP2gzO8O1IP085mbTBJ5I8xLM7i4?=
 =?us-ascii?q?Advl7ZHiDsnUX7lKqWdkI59ee28+nnebDmpoOEN49zlwH+LrwimsyhDuQ8NQ?=
 =?us-ascii?q?gDR3Sb9v6m1L3i4E35W69GjvwwkqnXt5DaPtoUqbKjDw9J0ocs9xa/DzC83N?=
 =?us-ascii?q?QegXYHN05KdAiCj4joP1HCOPH4DfGhjFSwiDpn2v/LM7L7DpjNM3TPiqntcL?=
 =?us-ascii?q?lj50JG1QY/1dVf6IhVCrEFLvLzQEjxtNnAAx8iLgO02P3qCMl914wCWWKPBb?=
 =?us-ascii?q?WVMKXJsVCS/O4vLO6MZJENtDbnN/cl/+LujWM+mVIFZamp2YEYaG2kHvR8OE?=
 =?us-ascii?q?qWe2Hhgs0fHmgXvgoxVvDqhEeeXj5UYna4R7g86S0jCIK6EYfDQZiggKef0y?=
 =?us-ascii?q?e/H51WYH1GC1+XHHf2eIWLRe0MZDiRIsB/iDwEU6auS4s72RGprg/6xKJtLv?=
 =?us-ascii?q?DI9S0AqZLjyN916vXImhEz8Tx0C96R3H2XQ2FumWMHXCE53LpjoUxm0VqD3q?=
 =?us-ascii?q?14jOZZFdxX/f9GTgA6NZuPh9B9Xuj/RhiJWt6UVEysS96mSWUpStss38UEam?=
 =?us-ascii?q?5nFtmihwyF1C2vVftdjLGPBZop4orC0HXrYcVw0XDL0O8mlVZiCvROMWmnj6?=
 =?us-ascii?q?s3zQ/ZCpTViA3NnaeuceIXmjTK/mqZ0XGms0RRUQo2WqLACyMxfEzT+O/l61?=
 =?us-ascii?q?vCQrnmMrEuNg9M2IbWMadRQsH4hlVBAvH4MZLRZHznyDT4PgqB2r7ZNNmiQG?=
 =?us-ascii?q?4axiiITRFfwg0=3D?=
X-IPAS-Result: =?us-ascii?q?A2DvAgBySyhe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVSASKoQSiQOGbwaBN4luiiWHJAkBAQEBAQEBAQErDAEBg3tFAoI+OBMCE?=
 =?us-ascii?q?AEBAQQBAQEBAQUDAQFshTcMgjspAYJ6AQUjFVELDgoCAiYCAlcGAQwGAgEBg?=
 =?us-ascii?q?mM/AYJWJQ+uXYEyhUqDN4E4BoEOKowweYEHgREnD4JdPoJkAoRzgl4EjVyJV?=
 =?us-ascii?q?kaXWoJDgkuEdI5uBhuady2OMYhilDcigVgrCAIYCCEPgydQGA2LdIpxIwMwj?=
 =?us-ascii?q?XEBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 22 Jan 2020 13:55:36 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00MDsswc159716;
        Wed, 22 Jan 2020 08:54:54 -0500
Subject: Re: [PATCH] libselinux: Eliminate use of security_compute_user()
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org,
        William Roberts <bill.c.roberts@gmail.com>
References: <20190509084204.26198-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55d1a26f-a5af-40d6-4de6-89a29ac9f42e@tycho.nsa.gov>
Date:   Wed, 22 Jan 2020 08:56:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20190509084204.26198-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/9/19 4:42 AM, Petr Lautrbach wrote:
> get_ordered_context_list() code used to ask the kernel to compute the complete
> set of reachable contexts using /sys/fs/selinux/user aka
> security_compute_user(). This set can be so huge so that it doesn't fit into a
> kernel page and security_compute_user() fails. Even if it doesn't fail,
> get_ordered_context_list() throws away the vast majority of the returned
> contexts because they don't match anything in
> /etc/selinux/targeted/contexts/default_contexts or
> /etc/selinux/targeted/contexts/users/
> 
> get_ordered_context_list() is rewritten to compute set of contexts based on
> /etc/selinux/targeted/contexts/users/ and
> /etc/selinux/targeted/contexts/default_contexts files and to return only valid
> contexts, using security_check_context(), from this set.
> 
> Fixes: https://github.com/SELinuxProject/selinux/issues/28
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>   libselinux/src/get_context_list.c | 185 ++++++++++--------------------
>   1 file changed, 60 insertions(+), 125 deletions(-)
> 
> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
> index 689e4658..a36c6253 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c
> @@ -180,7 +143,8 @@ static int get_context_order(FILE * fp,
>   		return -1;
>   	fromrole = context_role_get(con);
>   	fromtype = context_type_get(con);
> -	if (!fromrole || !fromtype) {
> +	fromlevel = context_range_get(con);
> +	if (!fromrole || !fromtype || !fromlevel) {
>   		context_free(con);
>   		return -1;
>   	}

One caveat here: MLS is still optional for SELinux and IIRC Gentoo 
doesn't enable it, so the from-context may not have any level and 
context_range_get() can legitimately return NULL in that case. 
context_range_set(con, NULL) is also legitimate and won't cause any 
errors.  So you don't need to check that fromlevel is non-NULL as long 
as you are only using it later in context_range_set().


