Return-Path: <SRS0=HWnL=XN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300B3C4CEC4
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 15:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBB9206C2
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 15:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="g45yIFub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfIRPl1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Sep 2019 11:41:27 -0400
Received: from UCOL19PA34.eemsg.mail.mil ([214.24.24.194]:52182 "EHLO
        UCOL19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfIRPl1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Sep 2019 11:41:27 -0400
X-EEMSG-check-017: 24273119|UCOL19PA34_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,521,1559520000"; 
   d="scan'208";a="24273119"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Sep 2019 15:41:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568821284; x=1600357284;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=7PxusmpUj0PaRi/5oNn4QxHPi9RIJqn2gLM3hxgsfDk=;
  b=g45yIFubCxs3HeH6e1FEMDiercSYsKx6eC72IbWQpMhAew/5ZlDIKpog
   ZS8MhlZ5TRKOq71VLHlL3S7z77rBt2X+Josev2+UC6/jg8101n0T9+Vs1
   d26QKmZyRuZFL97ed508TpatskpRpNlCR/IJRqombx4vlp5u0c45afTml
   LJlnh+US0kbWsVzeDvCJ2ghik0xkc26P4I5QCjNNjozS8f9lcVO5cc+tJ
   1srya2dQYLp3F3cVB2JgOovIxTmz85zZ89w9Y7sjqV0lcIzRq5gOosVw1
   7ZbgEpB62FdB/SorQGmqvk8Gg2XgyXvJwdl4bBw/Qf2u4ptEfbaCMBooq
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,521,1559520000"; 
   d="scan'208";a="28053432"
IronPort-PHdr: =?us-ascii?q?9a23=3ALxS4dBACXIbBN0HM3b1xUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP37oMywAkXT6L1XgUPTWs2DsrQY0rGQ6vCrCTxIoc7Y9ixbKtoUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIVvJrwsxh?=
 =?us-ascii?q?bKrXdFeOdbzn5sKV6Pghrw/Mi98IN9/yhKp/4t68tMWrjmcqolSrBVEC4oOH?=
 =?us-ascii?q?0v6s3xshnDQwqP5n8CXWgTjxFFHQvL4gzkU5noqif1ufZz1yecPc3tULA7Qi?=
 =?us-ascii?q?+i4LtxSB/pkygIKTg0+3zKh8NqjaJbpBWhpwFjw4PRfYqYOuZycr/bcNgHXm?=
 =?us-ascii?q?dKQNpfWDJdDYO9d4sPDvQOPeBEr4nmulACqQKyCRSwCO/zzzNFgHH53bc+0+?=
 =?us-ascii?q?88Dw/I2gIuFM8KvHjNotj4MKIeXOaox6fK0DrDdetb1yrj5ojGch4vov+CUr?=
 =?us-ascii?q?x/fsXT1UYhGBjIjkmSpIH/Iz+ZyuoAvmqd4uF9VeyvkWknqwRprzay2scjlJ?=
 =?us-ascii?q?HJhoILxVDC6C533YM1Kse8SE5/f9GlEIZbuiaBN4RrWcMvWH1ouSYmxb0Gvp?=
 =?us-ascii?q?63Zi4KyI89yBLFZPyHdJaI7wvlWe2MLzl4g3dld6i+hxa06UWgyfPzVtOy0F?=
 =?us-ascii?q?lUqipJiN7MtmoC1xHV98OJSeN981+81TuA2A3f8OFJLV0umabFJJMt3KQ8mo?=
 =?us-ascii?q?cVvE/eBCH5gl/2g7WTdkg8/+io7Pnobav+q5+HMo90lhn+MqMzmsyjGeg4Mh?=
 =?us-ascii?q?YBX2yc+emkyL3s51f5QLRXjv0tiKXZrJDbKtgbpq6+GQNV1Jos6w2jADu81d?=
 =?us-ascii?q?QYnH0HIEpEeBKBkYfpJ0nDLO33APqwmVihkCpny+rYMrDuHJnBNGXPnK/kfb?=
 =?us-ascii?q?ln6k5czAQzzcpY55JRErwBO+/8WlTqudzEDh42Lwy0w+H9BNV7zYMRQ3iDAq?=
 =?us-ascii?q?CeMKPMqVOI/P4gI/GQZI8JvzbwM+Il5//ygn85g1AdZ7Sm0oMLZ3+gHvRpOU?=
 =?us-ascii?q?SZYXzyjdcaCmoFpRY+TO3siF2eTzFTfXCyULwg5j0hFI2mCoLDTJi3gLOdxC?=
 =?us-ascii?q?e7AoFWZmdeB1CXD3joc4SEW/ERaCOdOcJhjDMEWqa7S4M71hGhqhX6y7x5Ie?=
 =?us-ascii?q?rQ4CEYsojj1Ndt7e3JiR4y7SB0D9ia02yVV2F7hH4IRzst0aBnu0N911OD3b?=
 =?us-ascii?q?F9g/xfEtxT/e1GXh0mOp7byuwpQ+z1DzjAddeAUlruYtynBzwqBoYrwtQOal?=
 =?us-ascii?q?xxLN6VjhnC2SexK7UJlrqXCYYy/76a1H/0cYI10HvC1a88n3E4TcZVc26rnK?=
 =?us-ascii?q?hy807UHYGN212QiqKCba0B2GvI82CZwCyFu0QLfhR3VPD+QX0HZkbQ5e/870?=
 =?us-ascii?q?fGQq7mXa8rKSNd2MWCLe1McdSvglJYEqSwcO/Can68zj/jTS2DwamBOc+zID?=
 =?us-ascii?q?QQ?=
X-IPAS-Result: =?us-ascii?q?A2AFAQBLT4Jd/wHyM5BmHAEBAQQBAQcEAQGBVgQBAQsBg?=
 =?us-ascii?q?WgFKm1TMiqEIo8OTQEBAQEBAQaBNol0kSgJAQEBAQEBAQEBLQcBAgEBhD8Cg?=
 =?us-ascii?q?wMjNwYOAgwBAQEEAQEBAQEFAwEBbIUtDII6KQGCZwEFIxVRCxgCAiYCAlcGA?=
 =?us-ascii?q?QwGAgEBgl8/AYFqAwkUD7BjgTKENwGBFIMxgUmBDCgBjAgYeIEHgTiCaz6CG?=
 =?us-ascii?q?oU1glgEjEuJMpcAgiyCLoRXjXkGG4I2cpV5jhCBOYZWkwsigVgrCAIYCCEPg?=
 =?us-ascii?q?ycJRxAUiUiBDIVbJAMwAQGBBAEBj24BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Sep 2019 15:41:23 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8IFfNUW026862;
        Wed, 18 Sep 2019 11:41:23 -0400
Subject: Re: [PATCH V4 0/3] selinux-testsuite: Add BPF tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, paul@paul-moore.com
References: <20190917145640.25629-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a43a310c-346e-60b8-bf45-9c7663e73c89@tycho.nsa.gov>
Date:   Wed, 18 Sep 2019 11:41:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190917145640.25629-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/17/19 10:56 AM, Richard Haines wrote:
> Patch 1 Runs basic checks for BPF with map_create, map_read, map_write,
> prog_load and prog_run permissions.
> V2 Change - Split BPF code into bpf_common.c for others to use.
> V3 Changes - Correct style, Fix typos
> V4 Changes - Fixes as discussed in [1]
> 
> Patch 2 Updates fdreceive to test BPF security_file_receive() path using
> the common BPF code in tests/bpf.
> V2 Change - Added to use tests/bpf/bpf_common.c for BPF tests.
> V3 Changes - Run tests under tests/bpf not tests/fdreceive, fix typos.
> V4 Changes - Update to work with changes in [1]
> 
> Patch 3 - Updates Binder to test BPF path security_binder_transfer_file()
> V4 Change - New patch

With this version of the patches, all of the tests pass for me, 
including the binder tests on a kernel with binder enabled.

The audit log output lined up correctly with the expected denials. 
There was a fair amount of noise that had to be filtered/ignored though 
due to the sys_admin checks (for bpf) and sys_nice checks (for binder), 
which apparently aren't fatal to the system calls.  We might want to 
have a look sometime at avoiding unnecessary CAP_SYS_ADMIN and 
CAP_SYS_NICE checks in the bpf and binder code to avoid polluting the 
audit logs and leading people to generate overly permissive policies. 
That's not your bug to fix though.


> 
> [1] https://lore.kernel.org/selinux/19b043bc4d5efbf2f1994958c0a74709a34e3ad0.camel@btinternet.com/
> 
> Richard Haines (3):
>    selinux-testsuite: Add BPF tests
>    selinux-testsuite: Add BPF support to fdreceive test
>    selinux-testsuite: Add BPF support to binder test
> 
>   README.md                       |   4 +-
>   defconfig                       |   5 +
>   policy/Makefile                 |   4 +
>   policy/test_binder_bpf.te       |  73 ++++++++++++
>   policy/test_bpf.te              |  78 +++++++++++++
>   policy/test_fdreceive_bpf.te    |  60 ++++++++++
>   tests/Makefile                  |   7 ++
>   tests/binder/Makefile           |   5 +
>   tests/binder/binder_common.c    |  10 +-
>   tests/binder/binder_common.h    |  17 ++-
>   tests/binder/client.c           |  28 ++++-
>   tests/binder/manager.c          |   2 +-
>   tests/binder/service_provider.c | 118 ++++++++++++++-----
>   tests/bpf/.gitignore            |   2 +
>   tests/bpf/Makefile              |  17 +++
>   tests/bpf/bpf_common.c          |  53 +++++++++
>   tests/bpf/bpf_common.h          |  34 ++++++
>   tests/bpf/bpf_test.c            |  77 ++++++++++++
>   tests/bpf/test                  | 199 ++++++++++++++++++++++++++++++++
>   tests/fdreceive/Makefile        |  14 ++-
>   tests/fdreceive/client.c        |  93 +++++++++++++--
>   21 files changed, 847 insertions(+), 53 deletions(-)
>   create mode 100644 policy/test_binder_bpf.te
>   create mode 100644 policy/test_bpf.te
>   create mode 100644 policy/test_fdreceive_bpf.te
>   create mode 100644 tests/bpf/.gitignore
>   create mode 100644 tests/bpf/Makefile
>   create mode 100644 tests/bpf/bpf_common.c
>   create mode 100644 tests/bpf/bpf_common.h
>   create mode 100644 tests/bpf/bpf_test.c
>   create mode 100755 tests/bpf/test
> 

