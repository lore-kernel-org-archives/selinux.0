Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53A2C3404D
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 13:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772BA2465D
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 13:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="H/lD0Htn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgBSN3Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 08:29:16 -0500
Received: from UCOL19PA38.eemsg.mail.mil ([214.24.24.198]:45656 "EHLO
        UCOL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgBSN3Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 08:29:16 -0500
X-EEMSG-check-017: 78355433|UCOL19PA38_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,459,1574121600"; 
   d="scan'208";a="78355433"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Feb 2020 13:29:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582118953; x=1613654953;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=Qc5Th4KsaNM8+Gf+SfBeINhZjZnhrBtnkXd5apesa0k=;
  b=H/lD0Htn2MQhm2SathLawoEY9E7SUbT60EhpNUC43j+lxY23bTSVCGla
   PvXd9nSv6ZIje2YbLiHFg/egDqMq49IO/NrmrI9rvrtYmWzhA+YbW73g7
   /4d+qNpZeviRsBVJK64esyP2G8Qj0S/A01bnKJV1WHZY1r9s2Q6y8zAOq
   4RQU3xfV5ZT5qdKQLiSgv1DV74Q2TtgdFqq+jQ3leB5JUukN1ZSnykL2/
   JrAiHkl7Aj/hOVO8a1FRQc99+bbWuLLfPCbXTzpx6tHdK3JytGMr3jqTl
   ylEg5R/lLJ1Njd00OsSDri6lZr5UdwkW4gJ9Zxy28EtuQIin92P6b4Ejj
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,459,1574121600"; 
   d="scan'208";a="39276632"
IronPort-PHdr: =?us-ascii?q?9a23=3Apus/Rxak74kjRaa4A1V1Eh7/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZr8m8bnLW6fgltlLVR4KTs6sC17OK9fC4EjFYqb+681k8M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi5oAnLtcQanYRuJ6Ytxh?=
 =?us-ascii?q?DUvnZGZuNayH9nKl6Ugxvy/Nq78oR58yRXtfIh9spAXrv/cq8lU7FWDykoPn?=
 =?us-ascii?q?4s6sHzuhbNUQWA5n0HUmULiRVIGBTK7Av7XpjqrCT3sPd21TSAMs33SbA0Xi?=
 =?us-ascii?q?mi77tuRRT1hioLKyI1/WfKgcFrkqlVvAyuqAB+w47MYYGaKvx+fr/GfdgHQW?=
 =?us-ascii?q?ZNR9tdWzBdDo+5aYYAAfABPeJFpIfjoVUAowa1CQ21CO7vzjJEg3n71rA43e?=
 =?us-ascii?q?s8CwHLxBEuEcwAsHrUr9v7OqkdXu+3w6bUwjvOdO9W1DXn5YTUbhwsr/OBUL?=
 =?us-ascii?q?RtesTR00kvEAbFg02Np4z5ITyVzuQNvHad7+F9SOyvjnQoqwV1ojexxsYnl4?=
 =?us-ascii?q?7EhpkIxVDf7ih53IY0KsG4SE58e9KkFoBQuDuAO4t5RcMiXXhltSAnwbMFoZ?=
 =?us-ascii?q?62ZDUGxZsoyhLFa/GLbpKE7gzsWeqPOzt0mXRoc6+liRmo60iv0Oj8W9Gx0F?=
 =?us-ascii?q?ZNsyVKjMHBtmsI1xzP8siHTeZ9/lu51TaPyQ/T7uZELFgolaXBMZ4hw6Mwlo?=
 =?us-ascii?q?EJvUTCGC/2lkL2jLSIeUo44OSo9+Tmbanmpp+bLYN0jB3xMr8ylcClBOQ4Mw?=
 =?us-ascii?q?wOU3Ca+eS6yrLj4VX0TKhFg/A5iKXUsI3WKd4FqqO2HQNZyJsv5w66Dzi80d?=
 =?us-ascii?q?QYmXcHLEhCeBKCl4XpIEzBIOvjAPejg1WjjDdrx/fcMr3nGZXCNGLPkLjmfb?=
 =?us-ascii?q?Zj80Jc0hY8zchD55JIDbEMOOnzVVH1tNzZCB85LgO1zv35CNVyyIweQ3iDAq?=
 =?us-ascii?q?yHP6PIt1+H+OYvL/OLZI8PtzauY8QistzniHIi0XQUZ7Wkx9NDam+zF+56eW?=
 =?us-ascii?q?2FcHHshZEHCm5MsQ0gGqiik1CGUDhOd16sUK8moDI2EoSrCcHEXI/+rqaG2X?=
 =?us-ascii?q?KAApBOZm1AQmuJGHPsepTMD+wAcwqOM8RhlXoCTrHnRIg/g0L9/DTmwqZqe7?=
 =?us-ascii?q?KHshYTsojugZ0surze?=
X-IPAS-Result: =?us-ascii?q?A2CPAADBNk1e/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYF8gWwBMhYUhBSJA4gViXCRSgkBAQEBAQEBAQE3BAEBhEACgig3Bg4CE?=
 =?us-ascii?q?AEBAQUBAQEBAQUDAQFshUOCOykBgwEBAQEBAgEjBBFGCwsOCgICJgICVwYBD?=
 =?us-ascii?q?AYCAQGCYz8rAYIrBSCsYXV/M4VKg2uBPoEOKgGMPYIAgTgPgl0+h1uCXgSXV?=
 =?us-ascii?q?0aXdIJFglCUCgYcmystjkKdVSOBWCsIAhgIIQ+DJ1AYDZ0BIwMwjxMBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 19 Feb 2020 13:29:11 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01JDSAK0134600;
        Wed, 19 Feb 2020 08:28:11 -0500
Subject: Re: [PATCH] libsepol: Use ebitmap_length() to check for an empty
 ebitmap
To:     James Carter <jwcart2@tycho.nsa.gov>, selinux@vger.kernel.org
References: <20200218203911.30502-1-jwcart2@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1193c757-7b16-a8fc-5ae8-4e722fb56bb3@tycho.nsa.gov>
Date:   Wed, 19 Feb 2020 08:30:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218203911.30502-1-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/18/20 3:39 PM, James Carter wrote:
> When checking whether or not an ebitmap has any bits set, use
> ebitmap_length() instead of ebitmap_cardinality().
> 
> There is no need to find out how many bits are set, if all that is
> needed is to determine if any bits are set at all.
> 
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> ---

> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index e20c3d44..b1cbef08 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -2149,7 +2149,7 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
>   			}
>   		}
>   
> -		if (ebitmap_cardinality(&role->dominates) > 1) {
> +		if (ebitmap_length(&role->dominates) > 1) {
>   			log_err("Warning: role 'dominance' statement unsupported in CIL. Dropping from output.");
>   		}

Noticed that this test differs from the rest, checking > 1 rather than 
just comparing with 0.  Not sure if it matters but ebitmap_length() will 
be > 1 if role->dominates is non-empty even if it only has one bit set. 
So maybe this one is supposed to really be ebitmap_cardinality()?

