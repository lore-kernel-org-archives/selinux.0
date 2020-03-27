Return-Path: <SRS0=745E=5M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BD9C43331
	for <selinux@archiver.kernel.org>; Fri, 27 Mar 2020 19:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17A5206E6
	for <selinux@archiver.kernel.org>; Fri, 27 Mar 2020 19:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Z2q4dAbQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgC0TT5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Mar 2020 15:19:57 -0400
Received: from UCOL19PA39.eemsg.mail.mil ([214.24.24.199]:5642 "EHLO
        UCOL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgC0TT5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Mar 2020 15:19:57 -0400
X-EEMSG-check-017: 92941870|UCOL19PA39_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.72,313,1580774400"; 
   d="scan'208";a="92941870"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Mar 2020 19:19:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1585336795; x=1616872795;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=AYuej97mX3NeEbqBUty32wRlj3Ukiy7XDKdGJb/8PoQ=;
  b=Z2q4dAbQbVy+ste1exBFP3Syd2sH5ASup+dOBwBynFSobKYl2/lXfUzA
   ggVD3w8Vyu+CSok9FTjsxAa8qL0Hw380SkRXXHBViPVYG9NwO6jUuCw04
   EzTj6PyO77Al7KhVGxrbFZi5bYjilKIGxlDnmc5cNzhWhv28eTtj5pRfj
   pOQ1xfdsCZqOjH0/6U6lZjHMR1rxsCdBHT11ER/6EyFg/12XCh/ssFmL9
   lLXA6fIPsA2Cg/3oWmJh3R1ugbV2EhKXq5V1t79qDbILFu4HYcx02dZ9d
   E6sysyEWixw/v/TmLXuOrTd1/Or37KDmr5cBXRbAXAYpcDRuA56lXecSs
   Q==;
X-IronPort-AV: E=Sophos;i="5.72,313,1580774400"; 
   d="scan'208";a="41155208"
IronPort-PHdr: =?us-ascii?q?9a23=3Aqv841x9XntB0Rf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B21uscTK2v8tzYMVDF4r011RmVBNmdsq8VwLOP4+jJYi8p39WoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagbr5+Ngi6oAXVu8UZnIduN6U8wQ?=
 =?us-ascii?q?bVr3VVfOhb2WxnKVWPkhjm+8y+5oRj8yNeu/Ig885PT6D3dLkmQLJbETorLX?=
 =?us-ascii?q?k76NXkuhffQwSP4GAcUngNnRpTHwfF9hD6UYzvvSb8q+FwxTOVPczyTbAzRD?=
 =?us-ascii?q?Si86JmQwLmhSsbKzI09nzch9duh6xHvh2uux1/w5bVYI6LMvp+Yrjdds4eSW?=
 =?us-ascii?q?ZYQ8pdSzBNDoa6YoQBFeoBOftToZf7qVUAsBCyARCgCePrxzNNgHL9wK803P?=
 =?us-ascii?q?k7EQzewQIuAdwOvnTXotv7OqgdXuK6w7XHwzjYc/Nb2y3w5JTUfh0vo/yBW6?=
 =?us-ascii?q?97f8rLyUkoEgPIlkieqZD7MDON1uQCrW6b5Pd9W+KqkWEnrwVxrSavx8wxjY?=
 =?us-ascii?q?TJnZ8aykvf+CVlwIc6Od24SElhbd6iC5tfrTuWN4RxQsM8WmxlvjsxxL4euZ?=
 =?us-ascii?q?OjYSQHx5sqywTfZvCaaYSE/B3uWPiLLTtlgn9uZaixiAyo8Ue6z+3xTsy00F?=
 =?us-ascii?q?FXoSVbitTMrXUN1wDL6siAV/t94l+t2TaR2ADX7eFJOVw0mrDBK54g374wjY?=
 =?us-ascii?q?AfsVjDHyDqmEX2i7WadkM49eiz9+vreLDmpp6YN4NsiwH+NLohmtCnDOglPQ?=
 =?us-ascii?q?UDUHKX9OSh2LH540H0T6tGgucrnqXBtZDVP8Ubpqq3Aw9P1YYj7g6yDyy739?=
 =?us-ascii?q?QDhnQHMFJEdw6Hj4juIV3OJuv4Au2lj1Sjlzdr2ejKPqf9DZXVMnjDjLDhcK?=
 =?us-ascii?q?56605Zzwoz1tZf6IhIBb4fO//zQFH+u8HYDhAjLwy42froCNJ41okGQ2KAHr?=
 =?us-ascii?q?eZML/OsV+P/u8vOPeDZIsUuDb7Nvgk6OXjjWE2mVADZ6mlx5gXZ26iHvRgPU?=
 =?us-ascii?q?qZZWDggtAbEWcFpgA+VvDliEWeUT5PYHa/R7o86S8gB424C4fDR5ytgLua0S?=
 =?us-ascii?q?e6AJJZeH5JBkqLEXfyeIXXE8sLPQWULtVskHQhUqOnQoQs1ln6swr90LxuJe?=
 =?us-ascii?q?f84CAUtZv/ktNy4ruX3Qo/8T1yEtS1zW6AVSd3k3kOSjtw27pw8mJnzVLW6r?=
 =?us-ascii?q?R1m/xVE5Ro4vpNVgorfcrHw/dSF8H5WgWHeMyADlmhXIP1UnkKUtstzopWMA?=
 =?us-ascii?q?5GENK4g0WGhnf7Dg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CsAgAEUX5e/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?SyBQTKERI9TBoEKLYl7kU0KAQEBAQEBAQEBNAECBAEBhEQCgjEkOBMCEAEBA?=
 =?us-ascii?q?QUBAQEBAQUDAQFshWKCOykBgwwBBSMVQRALDgoCAiYCAlcGAQwIAQGCYz+CW?=
 =?us-ascii?q?CWtWYEyhUuDW4E+gQ4qjDEaeYEHgREnD4IwLj6EOIMogjwiBI1riheYW4JGg?=
 =?us-ascii?q?laUMAYdm2mPFJ4LIoFYKwgCGAghD4MoTxgNnQElA4E2AQGLU4JCAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Mar 2020 19:19:54 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 02RJKFLh104372;
        Fri, 27 Mar 2020 15:20:15 -0400
Subject: Re: [PATCH 0/2] userspace: Implement new format of filename trans
 rules
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     Chris PeBenito <pebenito@ieee.org>
References: <20200327152107.95915-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <daeae1d9-de29-aae0-6bde-3ad3427a5d42@tycho.nsa.gov>
Date:   Fri, 27 Mar 2020 15:21:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327152107.95915-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/27/20 11:21 AM, Ondrej Mosnacek wrote:
> These patches are the userspace side of the kernel change posted at [1].
> 
> The first patch changes libsepol's internal representation of filename
> transition rules in a way similar to kernel commit c3a276111ea2
> ("selinux: optimize storage of filename transitions") [2].
> 
> The second patch then builds upon that and implements reading and
> writing of a new binary policy format that uses this representation also
> in the data layout.
> 
> See individual patches for more details.
> 
> NOTE: This series unfortunately breaks the build of setools. Moreover,
> when an existing build of setools dynamically links against the new
> libsepol, it segfaults. Sadly, there doesn't seem to be a nice way of
> handling this, since setools relies on non-public libsepol policydb
> API/ABI.

I think this has happened before a few years ago when we made a 
different change to those structures, and required updates on the 
setools side.

Maybe we need to figure out what setools needs to be encapsulated and 
exported as part of the libsepol public ABI/API, and then stop having it 
peer into libsepol internals?

