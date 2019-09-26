Return-Path: <SRS0=fLGi=XV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3899C4360C
	for <selinux@archiver.kernel.org>; Thu, 26 Sep 2019 12:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C756207FF
	for <selinux@archiver.kernel.org>; Thu, 26 Sep 2019 12:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="DrUqHqgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbfIZMYl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Sep 2019 08:24:41 -0400
Received: from USAT19PA24.eemsg.mail.mil ([214.24.22.198]:48377 "EHLO
        USAT19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfIZMYk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Sep 2019 08:24:40 -0400
X-EEMSG-check-017: 32535303|USAT19PA24_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,551,1559520000"; 
   d="scan'208";a="32535303"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Sep 2019 12:24:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569500677; x=1601036677;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=FRFUvdUdqyhDmtIHu0qjgXqItdZjM8HNUp85lCCrNkY=;
  b=DrUqHqgoWHZp6bZWxEQtqZw/ID0ce2ETr8lc40a5L3nB+gMdMifP8F6p
   dKEdjJFJKJxDJNSWjPPrSFbehdN/dxvNXxpT1eeMZDqbHM+TFY8u/010A
   Fld6FwMiMoJnDB+53UAcApwpox1QBdHUasxMI4QWnZTj0x6/x3NEEwgQh
   wDS0C8pKNio5ft2fMAIuC41SV29k9lscXbEZjl2fz3eo0Sy7fC8FH0kyH
   QG96Te1oNvyRV/nXHvMGzUUb89LK2sksP7k90xKUns5W05o3jtFaZ07iJ
   +fs/lzqQJO+vTbuKBCrpJUW2zekti50ELRcGci/s7iXCS1FsiRi//S/Sf
   A==;
X-IronPort-AV: E=Sophos;i="5.64,551,1559520000"; 
   d="scan'208";a="33381145"
IronPort-PHdr: =?us-ascii?q?9a23=3ATpY22RLzWqYsHKeTmdmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgeLfTxwZ3uMQTl6Ol3ixeRBMOHsqkC0Lad7/GocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbal8IRi5ogncuc0bipZ+J6gszR?=
 =?us-ascii?q?fEvmFGcPlMy2NyIlKTkRf85sOu85Nm7i9dpfEv+dNeXKvjZ6g3QqBWAzogM2?=
 =?us-ascii?q?Au+c3krgLDQheV5nsdSWoZjBxFCBXY4R7gX5fxtiz6tvdh2CSfIMb7Q6w4VS?=
 =?us-ascii?q?ik4qx2UxLjljsJOCAl/2HWksxwjbxUoBS9pxxk3oXYZJiZOOdicq/BeN8XQ2?=
 =?us-ascii?q?ROXtxVVydcHI2yaYUBBPcFMepBoYTwo14CoB2jDgeuGezv0CdFiGLo06000+?=
 =?us-ascii?q?ovEg/I0wIvEN0MrHvao874NLsQXO2v0KXE0TvOYvFQ1Dzg6IbIaBchofSUUL?=
 =?us-ascii?q?xtbcre11EvFwPbgVWWtIfrIjaV2f4Js2if8eVhVf+khmk8qw5suTii3dssi4?=
 =?us-ascii?q?nViYIVzVDI7yN5wJ0vKtGiR057ZsCkHYJWuiqHNIV2WtsvT3xntSs10LELuY?=
 =?us-ascii?q?O3cDIUxJko2RLTceGLfo6V6Rz5TumROy13hHd9dbK6gBa97Favx/XnVsmxzF?=
 =?us-ascii?q?ZKti1FksTQtnwV1xzc9MyHSvxl80e9wzmPzQHT6vxfIUwuiaraK4Iuwr43lp?=
 =?us-ascii?q?YJt0TMAjT2l1nsgK+Td0Uk/vCk6+XhYrr4up+RL5J4hw7xP6g0msGzHP40Ph?=
 =?us-ascii?q?YBUmSF4+iwyaXv/UjjT7VLiv02nLPZsJffJckDva62HhRV350/6xe/Ezim0N?=
 =?us-ascii?q?MYkWMBLFJeYh2LlYfpO1bQIPzgF/ewn0yskCt3x/DBJrDhHJDNLn/BkLbgfL?=
 =?us-ascii?q?Z98FVRyBAtwt9C55JbEK0BLOjvVU/2sdzSFgU5PBCsw+b7FNV90ZsTWXmRDa?=
 =?us-ascii?q?+dMaPSt0KI5+00LumSa48apiz9J+Im5/Hwl385n0ESfa2z0ZsQcnC4EacuH0?=
 =?us-ascii?q?LMX3vwyvIGE3ULpUJqUuntik+DShZJanqyVr567TY+XsbuForHR4awkJSf0y?=
 =?us-ascii?q?qhWJ5bfGZLDhaLC3i7WZ+DXqI3dC+KIsJn2gcBXLylRp5pgQqiryfm2rFnKa?=
 =?us-ascii?q?zS4SReupX9gosmr9bPnA0/oGQnR/+W1HuAGiQtxTIF?=
X-IPAS-Result: =?us-ascii?q?A2B9AQCirYxd/wHyM5BmHAEBAQQBAQwEAQGBVgQBAQsBg?=
 =?us-ascii?q?XMqgUAyKoQijw5NAQEBAQEBBoE2iXWRKAkBAQEBAQEBAQE0AQIBAYQ/AoMwI?=
 =?us-ascii?q?zcGDgIMAQEBBAEBAQEBBQMBAWyFOYI6KQGCZwEFIxVRCw4KAgImAgJXBgEMB?=
 =?us-ascii?q?gIBAYJfP4F3FK8KgTKFTIM7gUiBDCgBjAsYeIEHgTiCaz6EDYNCgjYiBJYEl?=
 =?us-ascii?q?wyCLIIuklYGG5krjhubJSKBWCsIAhgIIQ+DJ1AQFJAvJAMwgQYBAYsgglQBA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 26 Sep 2019 12:24:34 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8QCOX9m026053;
        Thu, 26 Sep 2019 08:24:34 -0400
Subject: Re: [PATCH] policycoreutils/fixfiles: Fix "verify" option
To:     Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
References: <f9727681-817e-ba7a-7ba7-7837bf7f0212@tycho.nsa.gov>
 <20190924064130.20399-1-vmojzis@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8eba1e45-fa52-a89d-1d8f-06759d17362c@tycho.nsa.gov>
Date:   Thu, 26 Sep 2019 08:24:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190924064130.20399-1-vmojzis@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/24/19 2:41 AM, Vit Mojzis wrote:
> "restorecon -n" (used in the "restore" function) has to be used with
> "-v" to display the files whose labels would be changed.
> 
> Fixes:
>     Fixfiles verify does not report misslabelled files unless "-v" option is
>     used.
> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Thanks, applied.

> ---
>   policycoreutils/scripts/fixfiles | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
> index 5be9ba6e..1a31e061 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -302,7 +302,7 @@ process() {
>   case "$1" in
>       restore) restore Relabel;;
>       check) VERBOSE="-v"; restore Check -n;;
> -    verify) restore Verify -n;;
> +    verify) VERBOSE="-v"; restore Verify -n;;
>       relabel) relabel;;
>       onboot)
>   	if [ "$RESTORE_MODE" != DEFAULT ]; then
> 

