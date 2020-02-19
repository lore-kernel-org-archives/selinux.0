Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C34C34053
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 15:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36DD24654
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 15:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Fk2mrpL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgBSPmM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:42:12 -0500
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:45065 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgBSPmM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 10:42:12 -0500
X-EEMSG-check-017: 57421712|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,461,1574121600"; 
   d="scan'208";a="57421712"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Feb 2020 15:42:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582126929; x=1613662929;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=yTUFeTKu+j04/o24yp3i2KuS559+Z/IK3RsLa9wv0RY=;
  b=Fk2mrpL4IuBC8IuUU5AB6WYg0BbmWNW/XE+ZSjJE7dvSIR0Cj8ROBWuF
   PubiRyPwzm5yW61StxqegwzDgpvC7k0W5zxJKW0D2ij63Z2Z3u9AEyqTA
   Gdn2b3po6uk6T7Utf50gPxMxMZOberxEbWy1K1iG14o4RfkYqkMH8paae
   oNboIrxodCl6CKjdl/V4vSkg9VCpx65GskP/hswTwQyyK1dLxtxhld+f4
   KtWjinkYuXHakBq6LoWVaBg1ywo+QVllQLfkhscZWXpYFja3PhX1irz1e
   ZT+rjMXoLI437587F4LV3DgTDSaamMCfzDAPJ4qFCCG76q9QFeeYOgxYx
   w==;
X-IronPort-AV: E=Sophos;i="5.70,461,1574121600"; 
   d="scan'208";a="33211055"
IronPort-PHdr: =?us-ascii?q?9a23=3ApyW43B2y/uct40uXsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMXK/ad9pjvdHbS+e9qxAeQG9mCt7QU06GJ4+jJYi8p39WoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagbr5+Nha7oRneusQUgoZpN7o8xA?=
 =?us-ascii?q?bOrnZUdOtawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSW?=
 =?us-ascii?q?ZdQspdUipMDY2mb4sLEuEPI+BWoYfgrFcKtBezCw2hCObpxzRVhHH5wLc63v?=
 =?us-ascii?q?w8Hw/Y0gwuH9EAvnrao9r6NqgdTe+7wbLUzTjBdf5axSvx5YbKfx0nvPqCXa?=
 =?us-ascii?q?hwcc3UyUQ3Cg3FkkufqZTlPzyL0OQGrnWV7+96WuKrj24otQFwqSWoy8c3l4?=
 =?us-ascii?q?bJnZkYykzE9CplwIY1Ise0SEhgYdG+CpdQuCaaN5VvT84kXmpmuz46x6UbtZ?=
 =?us-ascii?q?O0cyUG0pQqywPFZ/CZfIWE/AjvWPuXLDxlnnxqYqi/iAy38UW4z+38UdS730?=
 =?us-ascii?q?hSoypel9nMqmgN1xvO6sibUvd9/lmu2TKI1w3L9uFLO1o0lavGK5462LIwl5?=
 =?us-ascii?q?wTsUrEHi/thkr5kLWadlkk++e06+TnZa/qppmAOI9vlg7yKKEums27AeggMw?=
 =?us-ascii?q?gOWXaU+fik2bH+8kD0T69Gg/0rnqXDrpzXKtoXqrSkDwNN14Ys8Re/DzOo0N?=
 =?us-ascii?q?QCmnkHKUpIeAmagIjyIFzOPPD5Auu/g1SrijtrwevGMaf7DpXCKXjDjq/tfa?=
 =?us-ascii?q?xh5E5E1Aoz0ddf6opTCrEEJ/LzQUnxu8bEARAnKAG02fjoB8h91owERWKDGL?=
 =?us-ascii?q?OWMKTXsVWQ/OIgP/GMZJMJuDb6M/Ul/ODhjXs4mV8bYKmo0oAaaG63Hvt4OU?=
 =?us-ascii?q?WVe3nsjckbEWcMoAU+SPbmiFqYUT5cND6OWPcb4D0hBYDuKIDYQImmjb/JiC?=
 =?us-ascii?q?C+GYZQb2tLIkqBHXfha8OPXPJaLGqJL8tglCEUfaauRpVn1hy0sgL+jb19Ib?=
 =?us-ascii?q?n64Cod4Kn/2cB16uubrhQ78Th5HozJyG2WZ31llWMPATkt1eZwplIrmQTL6r?=
 =?us-ascii?q?Rxn/ENTY8b3PhOSApvcMeHnuE=3D?=
X-IPAS-Result: =?us-ascii?q?A2BbAgCVVk1e/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFsATIqhBSJA4ZSAQEBAQEBBoE3iXCRSgkBAQEBAQEBAQE3BAEBhEACgig4E?=
 =?us-ascii?q?wIQAQEBBQEBAQEBBQMBAWyFQ4I7KQGDAgEFIxVRCw4KAgImAgJXBgEMBgIBA?=
 =?us-ascii?q?YJjP4JXJa15gTKFSoNpgT6BDiqMPnmBB4E4D4JdPodbgl4El1dGl3SCRYJQl?=
 =?us-ascii?q?AoGHII5mHKOb51WIoFYKwgCGAghD4MnUBgNnQEjAzCPEwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 19 Feb 2020 15:42:07 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01JFf4DP203307;
        Wed, 19 Feb 2020 10:41:04 -0500
Subject: Re: [PATCH 2/2] libsepol: grow hashtab dynamically
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20200219134522.230822-1-omosnace@redhat.com>
 <20200219134522.230822-3-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8f880fdb-2a7b-a52d-be84-5c3e501873de@tycho.nsa.gov>
Date:   Wed, 19 Feb 2020 10:43:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219134522.230822-3-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/19/20 8:45 AM, Ondrej Mosnacek wrote:
> Detect when the hashtab's load factor gets too high and try to grow it
> and rehash it in such case. If the reallocation fails, just keep the
> hashtab at its current size, since this is not a fatal error (it will
> just be slower).
> 
> This speeds up semodule -BN on Fedora from ~8.9s to ~7.2s (1.7 seconds
> saved).
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
