Return-Path: <SRS0=klO3=NE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8E5C67863
	for <selinux@archiver.kernel.org>; Wed, 24 Oct 2018 15:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0BB207DD
	for <selinux@archiver.kernel.org>; Wed, 24 Oct 2018 15:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0BB207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbeJXXpD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:45:03 -0400
Received: from upbd19pa08.eemsg.mail.mil ([214.24.27.83]:22180 "EHLO
        upbd19pa08.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbeJXXpC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Oct 2018 19:45:02 -0400
X-EEMSG-check-008: 176132954|UPBD19PA08_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa08.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 Oct 2018 15:16:28 +0000
X-IronPort-AV: E=Sophos;i="5.54,420,1534809600"; 
   d="scan'208";a="17161916"
IronPort-PHdr: =?us-ascii?q?9a23=3AnJan7hWqSSXZ8shBajM5Zd/NgQXV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRSHvKdThVPEFb/W9+hDw7KP9fy4BipYud6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9uLhi6txndutULioZ+N6g9zQ?=
 =?us-ascii?q?fErGFVcOpM32NoIlyTnxf45siu+ZNo7jpdtfE8+cNeSKv2Z6s3Q6BWAzQgKG?=
 =?us-ascii?q?A1+dbktQLfQguV53sTSXsZnxxVCAXY9h76X5Pxsizntuph3SSRIMP7QawoVT?=
 =?us-ascii?q?mk8qxmUwHjhjsZODEl8WHXks1wg7xdoBK9vBx03orYbJiIOPZiYq/ReNUXSm?=
 =?us-ascii?q?RbXsZVSidPHIWyYYUSBOYFJOpUsZXxq14IoBCjBwejGfnvxydViHHo06000+?=
 =?us-ascii?q?cvHw/I0wMvHd0BrHvaoc7pNKoQS+250LXEwDvBYv5QxDzz6JLIchckofyUQL?=
 =?us-ascii?q?xwbdTeyVEvFwzbiFWbtJHrPzaP2eQJt2iU8ephXv+ohm48tg5xuSOixtssi4?=
 =?us-ascii?q?bVhoIVzUrI9SNiwIkvP9G4R0l7YcC9HZZWqiqUNJN2T9s/T2xntys20L0LtY?=
 =?us-ascii?q?OhcCQUx5kr2QTTZ+GBfoOV+BzsTvyRLi19hH99fbK/gAu9/la4x+3nU8m0zE?=
 =?us-ascii?q?5Kri1YktnQrnwN1wLc6syASvZl4keuwyyP1wHO6uFfO0w0iaraJIIhwr43jJ?=
 =?us-ascii?q?YTt1jMHjTql0nsia+Wd0Ek9vCp6+ThfLrmuoeRO5J7hwzxKKgjmtGzDf4mPg?=
 =?us-ascii?q?UBQWSX4/mw2KXm/ULjQbVKivM2krPesJDfPckbvbO2AxRO34Y/6xewEzem0N?=
 =?us-ascii?q?MCkXkBN1JKYgiLj4fuO1HQOPz4F+uwg0ywkDd3wPDLJr3gAojJLnjCirvhfr?=
 =?us-ascii?q?Z960lBxwo019Bf5JVUCq8aIPLwW0/wtMfVAQMjMwypxeboFNV914MDVm2VHq?=
 =?us-ascii?q?+WKrnevkOP5uIqO+OMfpMauC7hK/g54P7jlWQ5lkEZfamo25sXdX+5E+94I0?=
 =?us-ascii?q?WWf3XsmM0NEWQUsQokSuzlllmCXSRUZ3aoUKI2/is7B56+DYffWoCth6SM3C?=
 =?us-ascii?q?W8Hp1NZmBGF0qDHW3zeIWeWvcMbj+dIst/nTEfSbehUZIh1Reyuw/6y7toM/?=
 =?us-ascii?q?Db+jECup75yNd14OjTxlkO8mlFEsCcm0KNSG1zhGAPWSQ13bE39V1gzlbF0q?=
 =?us-ascii?q?h/j/tCFttN/PBIQy8xL4PaxOxrB9nuU0TKedLfDB69T9GnBywhZsw+zsVIYE?=
 =?us-ascii?q?tnHdimyBfZ0HmEGbgQwoeXCYQ0/6SU5H34I8Jw2j6Sz6U6p0U3SctIc2u9j+?=
 =?us-ascii?q?hw8BaFVN2BqFmQi6v/LfdU5yXK7mrWiDPU5Ew=3D?=
X-IPAS-Result: =?us-ascii?q?A2ATAQBJjNBb/wHyM5BjGwEBAQEDAQEBBwMBAQGBZYFbK?=
 =?us-ascii?q?oFlKIN1lDBSBoEQJYkIkAc4AYRAAoMLITgWAQMBAQEBAQECAWwogjYkAYJfA?=
 =?us-ascii?q?QEBAQIBIxVBEAsYAgImAgJXBgEMBgIBAYJeP4F1BQipB4EuhTuEZ4ELilcXe?=
 =?us-ascii?q?YEHgREnDIJfiAGCVwKPDo9CCZBuBheQMCyYGSGBVSsIAhgIIQ+DJ5BzIzCBB?=
 =?us-ascii?q?QEBjCYBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 24 Oct 2018 15:16:27 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w9OFGRWY020520;
        Wed, 24 Oct 2018 11:16:27 -0400
Subject: Re: [PATCH] mcstrans: remove unused getpeercon_raw() call
To:     Yuli Khodorkovskiy <yuli.khodorkovskiy@crunchydata.com>,
        selinux@vger.kernel.org
Cc:     Joshua Brindle <joshua.brindle@crunchydata.com>
References: <20181024145915.20172-1-yuli@crunchydata.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <da69011b-3492-5b2f-f0fe-5e5979fefe8b@tycho.nsa.gov>
Date:   Wed, 24 Oct 2018 11:18:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181024145915.20172-1-yuli@crunchydata.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/24/2018 10:59 AM, Yuli Khodorkovskiy wrote:
> There is a call to getpeercon_raw() in mcstransd, but nothing is done
> with the context. The purpose of process_request() is to translate a
> context and we would like that to succeed even if, for some reason,
> getpeercon_raw() fails.

If we are going to remove that, then shouldn't we also remove the TODO 
comment about performing a check using the peercon?

> 
> Signed-off-by: Yuli Khodorkovskiy <yuli@crunchydata.com>
> Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
> ---
>   mcstrans/src/mcstransd.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/mcstrans/src/mcstransd.c b/mcstrans/src/mcstransd.c
> index d7fc5dea..abbdea7e 100644
> --- a/mcstrans/src/mcstransd.c
> +++ b/mcstrans/src/mcstransd.c
> @@ -142,13 +142,8 @@ process_request(int fd, uint32_t function, char *data1, char *UNUSED(data2))
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
>   	/* TODO: Check if MLS clearance (in peercon) dominates the MLS label
>   	 * (in the request input).
>   	 */
> @@ -184,7 +179,6 @@ process_request(int fd, uint32_t function, char *data1, char *UNUSED(data2))
>   	}
>   
>   	free(out);
> -	freecon(peercon);
>   
>   	return ret;
>   }
> 

