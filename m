Return-Path: <SRS0=e1+f=3Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B145C2D0DB
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 15:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28882465B
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 15:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="FF4f82PK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgA0PzQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:55:16 -0500
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:24711 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbgA0PzQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jan 2020 10:55:16 -0500
X-EEMSG-check-017: 50153721|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,370,1574121600"; 
   d="scan'208";a="50153721"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Jan 2020 15:55:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580140511; x=1611676511;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=q/HVQm21tcrreweccjaolG3ksq+qJcbDQ+oqklXwexA=;
  b=FF4f82PKo52ZCPiCsD1x5pVok7sluQWjXdm+kIgkaB/aM3arFrD0wNFZ
   ZR8EKJFG/LHjMHCmBEI94Kh3CBlynsBX7jQR7w7Utl8bHljNVLWpCh2T8
   sRDGLBKTvhLhKE6FISjrwr/+V1dya9UgnE10zt3CX8TKcummEqtmVUXK7
   YWN1Jd2vZb1tpb/XBKhcypEnyx5yiZF7A6rw3J8CMMoAwK7GOWkQ6pjIV
   ME6rPCDd3tKaBbiacvpfYG/qCgw3uVmpHEFmnwkjTsItiPfrNyHRUv+wz
   qMCRA7ZCU34Cg88RuZ1PqZOoccP6t0gKrzfq9o76kgy9nk6E4ARq9XNI2
   A==;
X-IronPort-AV: E=Sophos;i="5.70,370,1574121600"; 
   d="scan'208";a="38285573"
IronPort-PHdr: =?us-ascii?q?9a23=3AVOfAhhM7xEfaDx0xOYAl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/X/rarrMEGX3/hxlliBBdydt6sYzbGM+P+wESxYuNDd6StEKMQNHz?=
 =?us-ascii?q?Y+yuwu1zQ6B8CEDUCpZNXLVAcdWPp4aVl+4nugOlJUEsutL3fbo3m18CJAUk?=
 =?us-ascii?q?6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uMRm6twrcutQZjId4JKs91B?=
 =?us-ascii?q?TFr3lLdu9LwW9kOU+fkwzz68ut8pNv6Thct+4k+8VdTaj0YqM0QKBCAj87KW?=
 =?us-ascii?q?41/srrtRfCTQuL+HQRV3gdnwRLDQbY8hz0R4/9vSTmuOVz3imaJtD2QqsvWT?=
 =?us-ascii?q?u+9adrSQTnhzkBOjUk7WzYkM1wjKZcoBK8uxxyxpPfbY+JOPZieK7WYMgXTn?=
 =?us-ascii?q?RdUMlPSyNBA5u8b4oRAOoHIeZYtJT2q18XoRejGQWgGObjxzlGiX/s2a0xzv?=
 =?us-ascii?q?ovHwfI0gc9G94CqXrZodHwOKoUTOu7zrTHzS/bYv1Lxzn95ojGfBMvr/6CUr?=
 =?us-ascii?q?1/c9bex0Y0GgPZjFids5DpMy+b2+kPtWWQ8upuVfioi24iswxxoDauyds2hY?=
 =?us-ascii?q?nTmoIZ1E3P+CJ7wIc7OdK3UlR7YcK6HJZLqyGbN5d5QsMlQ21yviY60acJtY?=
 =?us-ascii?q?S0fCgN1pQq3hjSYOGJfYiP5xLsTueRITFgiXJ5YrKwnQiy8Um7yuHlSsa00U?=
 =?us-ascii?q?xGri1fktnDrnwN2BrT6tWdRvt65Eeh1jCC3B3Q5OFcOU04iKXWJpE7zrMwi5?=
 =?us-ascii?q?Yfq1rPEyDolEnskaObcFgv9PKy5OT9eLrmo4eRN4pzig7jLKsjgte/AeEkMg?=
 =?us-ascii?q?gWWGib5Pi82KXj/ULnRLVKieU7krXDv5DAJMQbu7W5DxVU0oYl5Ra/CCym38?=
 =?us-ascii?q?oEknUdMFJEeA6Ij4juO13UJvD3Eey/jEi2nDduxvDGOqXtApTLLnfdjLfsZa?=
 =?us-ascii?q?tx5kFTxQYpzd1T+ohYBq8OLf7tQEP9qcTUDhojPAy1x+bnBs991oQbWW+XAK?=
 =?us-ascii?q?+YPr/dvkWS5uIzPeWBf5MVuTbhJPgl4P7il3k5mUQHcqWz0psXb264Eux8I0?=
 =?us-ascii?q?qFeXrsnssBEWASswo5Sezqj0aCUThJaHmuQa0x/Ss7B5y7AofDXI+tnKaN0z?=
 =?us-ascii?q?u8Hp1TfmpGEEyDEW/0d4WYXPcBcDmSLdFlkjwFU7ihVoAg2AqwtA/11bVnNP?=
 =?us-ascii?q?DY+i4GupL50th6+enTmQs19TxuAMTOm12KGkZyknkFRXcT27t5qEdwyR/X1q?=
 =?us-ascii?q?1/mPpRHtF7/f5FUg4mc5Xbyro+Q8v/XgPHY8ehVlmrWJOlDCs3Q9Z3xMUBMG?=
 =?us-ascii?q?hnHND3jA/I1jC2WfdBlaOADYYoqIrAznPxIIB70H+A264/2Qp1CvBTPHGr0/?=
 =?us-ascii?q?YsvzPYAJTExgDAzPen?=
X-IPAS-Result: =?us-ascii?q?A2AuBwCmBi9e/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVCESKoQUiQOIOZs4CQEBAQEBAQEBASsMAQGCE4FoRQKCSDgTAhABAQEEA?=
 =?us-ascii?q?QEBAQEFAwEBbIU3DII7KQGCegEFIxVRCwkFCgICJgICVwYBDAYCAQGCYz8Bg?=
 =?us-ascii?q?nsPrASBMoQ1AQMCgQ+DPoE4BoEOKo14QIE4D4JdPoJkBIRxgl4EgT8Bi3gki?=
 =?us-ascii?q?VhGl14Ggj2HQo5vBhuafI5giGSUOiKBWCsKQYFogU4TPRgNnHOFXSMDMAKOC?=
 =?us-ascii?q?gEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Jan 2020 15:55:10 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00RFsOr5258464;
        Mon, 27 Jan 2020 10:54:25 -0500
Subject: Re: [Non-DoD Source] [PATCH userspace v2 0/4] Fix build with
 -fno-common
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20200123125716.12662-1-omosnace@redhat.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <0477ff3c-41fc-23f2-1e8e-523ccfdd6c18@tycho.nsa.gov>
Date:   Mon, 27 Jan 2020 10:56:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200123125716.12662-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/23/20 7:57 AM, Ondrej Mosnacek wrote:
> GCC 10 is going to enable -fno-common by default [1], so fix all build
> errors uncovered by it and add it to global CFLAGS to avoid introducing
> new bugs.
> 
> Changes in v2:
>   - remove also struct te_assert definition, which is also useless
>   - redo cil_mem_error_handler to match commit 4459d635b8f1 as suggested
>     by Jim Carter
> 
> Travis build: [2]
> 
> [1] https://gcc.gnu.org/gcc-10/porting_to.html#common
> [2] https://travis-ci.org/WOnder93/selinux/builds/640875119
> 
> Ondrej Mosnacek (4):
>    libsepol: fix CIL_KEY_* build errors with -fno-common
>    libsepol: remove leftovers of cil_mem_error_handler
>    checkpolicy: remove unused te_assertions
>    Makefile: always build with -fno-common
> 
>   Makefile                        |   3 +-
>   checkpolicy/checkpolicy.h       |  14 --
>   libsepol/cil/src/cil.c          | 162 ++++++++++++++++
>   libsepol/cil/src/cil_internal.h | 322 ++++++++++++++++----------------
>   libsepol/cil/src/cil_mem.h      |   1 -
>   libsepol/cil/src/cil_strpool.c  |   8 +-
>   6 files changed, 329 insertions(+), 181 deletions(-)
> 

This whole series was applied.
Thanks,
Jim

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
