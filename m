Return-Path: <SRS0=2vFY=3C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0C9C33CA9
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 16:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFA22073D
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 16:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="RNlcjIFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgAMQ4P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:56:15 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:45373 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgAMQ4O (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Jan 2020 11:56:14 -0500
X-EEMSG-check-017: 44956725|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,429,1571702400"; 
   d="scan'208";a="44956725"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Jan 2020 16:56:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578934572; x=1610470572;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=yZNQrgiOKpzKAS9sE5wn+sC8+2/NK4ZLIlbnF2W2rkw=;
  b=RNlcjIFQoAlLCG2SDUOGJkTj4laKgLtoC4IPOVlHEiEpRmi6yJYzKq+o
   0kzRVlZk070+8W2we8B+1ndPC6XdEo2abrsRasXwziPNb/Ak4X17Wb5bY
   8g2dj+ED3R7V9/P59UlLl7a8/xRE+WiAxeey0woKE+kL6omp72qXR56In
   21FUUbUCMB5c270gYxYHVKGVJuMzHwTVMcfyhafczcGlybq+6e2lQM1HT
   Wj/qBQ+Rrr3n/v0qiHLOHh810Ky6T/4hXBZiCBAT/RHUE8nNrXOKJBpDW
   CaxPrFu7P8e4mjiV5rv+jmtrtPzlHvo+DLsJzfGeKSjpzmrXTMB3xljk8
   w==;
X-IronPort-AV: E=Sophos;i="5.69,429,1571702400"; 
   d="scan'208";a="37692027"
IronPort-PHdr: =?us-ascii?q?9a23=3AFi5ZmxVDMpxRC32JyMFB2ZS0Fp3V8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbRCHt8tkgFKBZ4jH8fUM07OQ7/m7HzZfud3Q6TgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNcajIl+Jqo+zh?=
 =?us-ascii?q?bFv2ZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSsAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oSt0TDECj2mF7og6CKbEkk5uip5PjnYrXhvJOcMZN7ihriPag0n8y/AOA4Ph?=
 =?us-ascii?q?APX2id5+u8yKXu8VD2TbhFlPE7krTVvIrEKckUuKK1GRJZ3p4m6xmlDjem1N?=
 =?us-ascii?q?oYnWMALFJAYB+HlJXmO0rVLfDkDfawn1SskDBxy/DAJb3uGI/BLnfEkLf/Zb?=
 =?us-ascii?q?p98VJTyBIvzdBD4JJZEqsBIPPvVU/xrtPYFAI2PBSozOn/CNVyzIIeWWSRDa?=
 =?us-ascii?q?+CK67dqkOI5uMpI+mQeoAVojD9JOY55/L0kXA5nlodd7Gz3ZQLcHC4AuhmI0?=
 =?us-ascii?q?KBbHr3nNgBFWYKvgwjTO3lk1CCTzFTaGioX64m5TE0FpimDYHdSYCpmrCB2z?=
 =?us-ascii?q?27HpIFLlxBX2qNGnfhbYnMe/4Nbi+Japt7kzcEXKKtfIQW1RivsgLh47B7L+?=
 =?us-ascii?q?zI9zceuI6l399wsambjhw29DppH+yD3GyXCWJ5hGUFQ3kxxq8sj1Z6zwK4za?=
 =?us-ascii?q?Vgg/FeXedW7vdNXxZyYYXQ1MRmGtvyXUTHZd7PR1G4FIb1SQotR848loddK3?=
 =?us-ascii?q?12HM+v21Wagnun?=
X-IPAS-Result: =?us-ascii?q?A2ABAwAmoBxe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFsASAShDaJA4ZtBoE3iW6PYYFnCQEBAQEBAQEBATcBAYRAAoIcOBMCEAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshUOCOykBgnoBBSMVUQsYAgImAgJXBgEMCAEBgmM/glclq?=
 =?us-ascii?q?lSBMoVJg06BPYEOKIwzeYEHgTgPgl0+hDGDKII8IgSNMBqIemFGepZXgkGCS?=
 =?us-ascii?q?JNfBhuabI5bnQcigVgrCAIYCCEPgyhPGA2IChqOQSMDjU4BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 13 Jan 2020 16:56:11 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00DGtVw7065663;
        Mon, 13 Jan 2020 11:55:33 -0500
Subject: Re: [PATCH V3 0/1] selinux-testsuite: Add filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20200112192432.862800-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e0f09965-4e23-172f-568f-ea906672e5fd@tycho.nsa.gov>
Date:   Mon, 13 Jan 2020 11:57:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200112192432.862800-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/12/20 2:24 PM, Richard Haines wrote:
> These tests should cover all the areas in selinux/hooks.c that touch
> the 'filesystem' class. Each hooks.c function is listed in the 'test'
> script as there are some permissions that are checked in multiple places.
> 
> Tested on Fedora 31 and Rawhide (5.5 for the new watch perm).
> 
> V3 Changes:
> 1) Lots of minor updates.
> 2) Add 'udevadm settle' as suggested by Ondrej to resolve udisks(8) issue.
> 3) Add stopping udisks(8) daemon as a '-d' option.
> 4) Add file quotaon test.
> 5) Add test for name type_transition rule.
> 6) Fix setfscreatecon(3) test to create a directory and check context.
> 7) Use kernel_dontaudit_setsched() as explained in [1].
> 
> The only thing I have not done is cutting the clutter in the logs. Tried
> various things, all failed. Ideas !!!!

Looks like at least the y2038 warnings were removed in v5.4 so don't 
need to worry about those.  If they show up in a future kernel again, we 
can avoid them by creating ext4 filesystems with inodes > 128 bytes ala 
-I 256.

