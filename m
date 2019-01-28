Return-Path: <SRS0=nwiU=QE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ED9C282C8
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 13:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC21C20857
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 13:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="DjrU2GTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfA1NXN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:23:13 -0500
Received: from uphb19pa12.eemsg.mail.mil ([214.24.26.86]:12179 "EHLO
        usfb19pa15.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726647AbfA1NXN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Jan 2019 08:23:13 -0500
X-EEMSG-check-017: 177659935|USFB19PA15_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by usfb19pa15.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Jan 2019 13:23:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1548681791; x=1580217791;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=iiwtOKjZBOTb2L9Rads3eBkPbOCzb3HFmqazOla47NI=;
  b=DjrU2GTe7e4OiRrL8FRegt73CODg1U0+9HFI2ltsZ/LYpoNJJhluV6Tg
   80Ll/zj7aXjUzDeRX/dCaLvlUIJw/wU2MchZBi6b+iMbS+wMvPFcGDEGW
   1NsYbsNzi7QIN/6UaLWHLZWsONf1fmroJTnc51gCZ5SirkKGnu2xyU1tq
   iLqT3YasPeruLCp04/Xls9TBT/Rb9F3WtzH2rsRAv0/7AAU7a0Z1mrAMQ
   t8FrVbkA/MIurmSm+49NnQtU6okYjBQc/44NQXBfE3NtVeS6YjsVn5iTH
   cbJfiRtMGAIpi/IUw9n5RlgntfBc8DF3hMz3xpalXzh9/5P2a6SrXRehN
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,534,1539648000"; 
   d="scan'208";a="23140964"
IronPort-PHdr: =?us-ascii?q?9a23=3Au/DMexEtGPPRdyg3vBZ6cZ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7yocmwAkXT6L1XgUPTWs2DsrQY07qQ6/iocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmDmwbaluIBmqsA7cqtQYjYx+J6gr1x?=
 =?us-ascii?q?DHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PG?=
 =?us-ascii?q?Au+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/VC?=
 =?us-ascii?q?+85Kl3VhDnlCYHNyY48G7JjMxwkLlbqw+lqxBm3oLYfJ2ZOP94c6zTZ9MaQX?=
 =?us-ascii?q?dKUNhXWSJPH4iwa5IDA/QdMepdqYT2ulkAogakBQS0Ge3h1DFIiH/106M03e?=
 =?us-ascii?q?suHgPJ0xAvEd8VrHTZrs/4OLsOXe27zqTFyyjIYfNM2Tf67YjFag0voe2SUr?=
 =?us-ascii?q?Joccre108vHB7YgFWVs4PlOzeV2foNsmOG6OdgTv+gi3U8pgFtojmg2scsio?=
 =?us-ascii?q?7TioIT0VDL7z91wIkyJd2mUUN2Z8OvHphItyyCKod7TcwvT3totSon0LEKp5?=
 =?us-ascii?q?G2cDYQxJg6wRPUduaJfJKS4h35UeacOTJ4hHV4d72hnxuy6k2gyvHkVsmzzV?=
 =?us-ascii?q?ZKsjJJktnSuXAJ0Bze8tSHReFn/kegxDaPzBrf6v1EIE8olarbLIQtwrgsmZ?=
 =?us-ascii?q?oIrUvPBCr2mETyjKOOd0Uk/Pan6/j/b7n7qZKROJV4hwHjPqg0hMCyDvo0Ph?=
 =?us-ascii?q?ITU2SD/OSzzrzj/Un3QLVQif02l7HUsIvHKsQAvaO5Hw9U3Zoj6xa4FTum1s?=
 =?us-ascii?q?8YkmMdIFJKfxKHkZDlO0vSL/DgEfe/n1OsnS9sx/DDOb3hGZPNIWLfn7j/Zr?=
 =?us-ascii?q?t98VBTxxczzd9F+5JYEK0OIPX2WkXprtzXEgc5MxCow+bgENh9zZ0RWWaOAq?=
 =?us-ascii?q?+fLaPTvkSF5vwgI+aSfo8ZojX9JOY/5/7ok3A5nUURfa6z3ZsYcHq4BOhpI1?=
 =?us-ascii?q?2FYXrwhdcMCX8KsRAjTOzuk1CCSSRcZ2u2X64l4zE7D4WmDZ3dSYy3nLOB2y?=
 =?us-ascii?q?K7TdVqYTVhDFyWHHWgUoKfXf4HZSHadshklScCXLOsY5Us2RGnqEnxzL8xaq?=
 =?us-ascii?q?LP9ykZs4/z/MZ66veVlhwo8zFwScOH3CXFd2hpmistQDgs0egruUVgzn+b2L?=
 =?us-ascii?q?V8xvlfEsZeofhOV1FpG4TbyrlBF93qWg/HNuyMQVKiT8TuVSo9Vfot0tQOZA?=
 =?us-ascii?q?B7ANzkgRfdiXn5S4QJnqCGUcRnupnX2GL8coMkkS7L?=
X-IPAS-Result: =?us-ascii?q?A2DaAgCDAU9c/wHyM5BlHAEBAQQBAQcEAQGBZYFbKYE4M?=
 =?us-ascii?q?ieEApRZAQEBAQEBBoEILYk1kE44AYRAAoMdIjgSAQMBAQEBAQECAWwogjopA?=
 =?us-ascii?q?YJmAQEBAQIBIxVRCw4KAgImAgJXBgEMBgIBAYJfP4F1BQipcIEvhUOEXoELi?=
 =?us-ascii?q?zYXeIEHgTiCa4gKglcCiVkShng5VpBVCZIoBhiSLC2JaJMUIYFWKwgCGAghD?=
 =?us-ascii?q?4MnkHohAzCBBQEBjjgBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 28 Jan 2019 13:23:10 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0SDN8xq006924;
        Mon, 28 Jan 2019 08:23:09 -0500
Subject: Re: [PATCH] selinux: replace BUG_ONs with WARN_ONs in avc.c
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20190126101816.1065-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9a9ed7ba-b4ab-34a9-4d14-81ac4a418eb4@tycho.nsa.gov>
Date:   Mon, 28 Jan 2019 08:26:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190126101816.1065-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/26/19 5:18 AM, Ondrej Mosnacek wrote:
> These checks are only guarding against programming errors that could
> silently grant too many permissions. These cases are better handled with
> WARN_ON(), since it doesn't really help much to crash the machine in
> this case.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   security/selinux/avc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 3a27418b20d7..84f108f4100a 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -1059,7 +1059,7 @@ int avc_has_extended_perms(struct selinux_state *state,
>   	int rc = 0, rc2;
>   
>   	xp_node = &local_xp_node;
> -	BUG_ON(!requested);
> +	WARN_ON(!requested);

Should this be:
	if (WARN_ON(!requested))
		return -EACCES;

>   
>   	rcu_read_lock();
>   
> @@ -1149,7 +1149,7 @@ inline int avc_has_perm_noaudit(struct selinux_state *state,
>   	int rc = 0;
>   	u32 denied;
>   
> -	BUG_ON(!requested);
> +	WARN_ON(!requested);

And likewise

>   
>   	rcu_read_lock();
>   
> 

