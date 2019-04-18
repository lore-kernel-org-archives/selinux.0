Return-Path: <SRS0=jmdh=SU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B82EC10F0E
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 17:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13215218EA
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 17:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="boUdAgOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390096AbfDRR7R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:59:17 -0400
Received: from usfb19pa12.eemsg.mail.mil ([214.24.26.83]:25660 "EHLO
        USFB19PA12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390089AbfDRR7Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 13:59:16 -0400
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Apr 2019 13:59:16 EDT
X-EEMSG-check-017: 273997052|USFB19PA12_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Apr 2019 17:49:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1555609760; x=1587145760;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=dlNwdWMXfuLnitSJQ4szcBbAGDwWr9BLhnHyZJrGaT4=;
  b=boUdAgOIP0/ZRqwrmOUhCA9Js018Y67Dv7qoTP/kNFfeiHp9ulH5o93O
   TgrBDc1+AY/02tAMqyhTcPw0IsHVMegacqYFMJPf6dNjDBGphDucSrq6J
   z+ZV7DeubfUuS6n163bwTCrO19sNjOba2akXCwjPsbszY915edV5hSpG5
   HcWzASZL1/pnZZg2HkY70RW5LQqlwPP1jtiBNmMG1hRnxoEATz796wxnS
   we4O1VJUrpoGFWNq7dNhUvQrLLtxWLVKi2qgn4hgKtLjXL8GwSlYO7FbD
   PntAS5No6ahlhUEzWEzxHiLa3jZ8tBG9YL39QGBuRVGdZVYwYmSUm1Nj8
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,366,1549929600"; 
   d="scan'208";a="22678211"
IronPort-PHdr: =?us-ascii?q?9a23=3Ai9yC7hSA7REb3o2bkFix2S997tpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zYxCN2/xhgRfzUJnB7Loc0qyK6vmmAjFLvM3J8ChbNsAVD1?=
 =?us-ascii?q?ld0YRetjdjKfbNMVf8Iv/uYn5yN+V5f3ghwUuGN1NIEt31fVzYry76xzcTHh?=
 =?us-ascii?q?LiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyKwi9oRnMusUMjoZuN7s9xg?=
 =?us-ascii?q?HHr3ZIdOhbxW1lLk+Xkxrg+8u85pFu/zlMt/4768JMTaD2dLkkQLJFCzgrL3?=
 =?us-ascii?q?o779DxuxnZSguP6HocUmEInRdNHgPI8hL0UIrvvyXjruZy1zWUMsPwTbAvRD?=
 =?us-ascii?q?St9LxrRwPyiCcGLDE27mfagdFtga1BoRKhoxt/w5PIYIyQKfFzcL/Rcc8cSG?=
 =?us-ascii?q?FcRctaSTBPDZ2gYIsOF+oBPPhXr4/hp1sVsBCyARCgCP7zxjNUg3P726M10/?=
 =?us-ascii?q?4lEQrbwgIuGdwAu2nQoNnsNKofVeW5wa/VxjvBcvxWwy/w5pXWfBAvof+CXr?=
 =?us-ascii?q?x+fsTexkYtCwzLgU6dqZDnMj6PyugBr2aW4uhmWOmyi2AnsQZxoj23y8cuhI?=
 =?us-ascii?q?jGmpgaykrY9Sln3Y04It+4SUBnbtG+CptQqz+WOpBqQsIiX25ouCE6xqcAuZ?=
 =?us-ascii?q?6gZicG0psnxxnBa/GedYWD/xHtVP6JLDtli39od6izihav/US61OHxWde43E?=
 =?us-ascii?q?xXoidDj9LCrGoC1wbJ5ciCUvZ9+0Ch1iuR2A3L8eFEJFw0lbLcK5483r48jp?=
 =?us-ascii?q?oTvlrHHi/xgEj2kLWZdl8l+ui18OTreKnmp5+AOI90jQHyKKIuldCkAeskKA?=
 =?us-ascii?q?QOWmmb+eCk2L3i+032XqlKg+UrnqTWv53WP8QWqrOjDwNL3Ysv9QyzAyq+3N?=
 =?us-ascii?q?Qdh3YHLVZFeBydj4juPlHDOPL4DPmjjFu2ijdr2+7KM6b9ApTNMnfDkLDhca?=
 =?us-ascii?q?x7605H0gU/199f55VKCr0ZOvL8RlfxtMDEDh8+KwG72OfnCNF51o8ERW2DGL?=
 =?us-ascii?q?WZMKTJvlCW/OIvP/KMaZQauDb4Mfcl5vrugWUlll8aeKmjxYEXZ2ygHvR6P0?=
 =?us-ascii?q?WZZmLhgtgbHmcQvgsyVvDqiFycXj5JYXa9QaI96yo1CI28FofDWoWtj6aA3C?=
 =?us-ascii?q?e/BJFZemdGClWUG3fya4qEQ+sMaD6VIsJ5iTwLS7yhS44n1RGzuw730KRnLu?=
 =?us-ascii?q?XK9S0Cr57j18Z65/fVlR4s8Tx4FcOd03uCTzI8omRdeD4y2KF2pARHzV2Oy7?=
 =?us-ascii?q?Rjy6hSFNhXofgPSAAwOITA1MR1DtnzXkTKedLfG3i8RdDzAy46R8gtmZdaYV?=
 =?us-ascii?q?l2Es++1DjfziGqBPkTjLXNC5sqpPGPl0PtLtpwni6VnJIqiEMrF44WaDyr?=
X-IPAS-Result: =?us-ascii?q?A2DMAQBVt7hc/wHyM5BlHQEBBQEHBQGBUwYBCwGBZiqBO?=
 =?us-ascii?q?QEyKIQOiHuMO5hKgXs8AYISgi4ChhkjNgcOAQMBAQEEAQEBAQIBbCiCOikBg?=
 =?us-ascii?q?mcBBSMVQRALCQUKAgImAgJXBg0GAgEBgl8/ggmpOoEvhUeEaoELJwGLSYFWQ?=
 =?us-ascii?q?IE4gms+h06CVwSBKwGQWU+TdAYDggiFPYxhBhuCC4oIiHSiIgUsgVYrCkGBa?=
 =?us-ascii?q?IFOgkWOJyMDMIEGAQGPagEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Apr 2019 17:49:19 +0000
Received: from localhost.localdomain (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x3IHnIvA013734;
        Thu, 18 Apr 2019 13:49:18 -0400
Subject: Re: [Non-DoD Source] [PATCH 0/2] checkmodule: allow building modules
 of a specific version
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Gary Tierney <gary.tierney@fastmail.com>, selinux@vger.kernel.org,
        Steve Smalley <sds@tycho.nsa.gov>
References: <20190417163731.3434-1-gary.tierney@fastmail.com>
 <3ef5bbf3-4d1b-26a2-aa18-d32044259064@tycho.nsa.gov>
 <CAFftDdroVYV232N7c997SgP0Owi0J+uFEnzVCdEaJAiKSz86Qw@mail.gmail.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <b845d25a-53bf-97f9-0f8d-fc9df477ad53@tycho.nsa.gov>
Date:   Thu, 18 Apr 2019 13:49:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFftDdroVYV232N7c997SgP0Owi0J+uFEnzVCdEaJAiKSz86Qw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/18/19 11:18 AM, William Roberts wrote:
> On Thu, Apr 18, 2019 at 6:27 AM jwcart2 <jwcart2@tycho.nsa.gov> wrote:
>>
>> On 4/17/19 12:37 PM, Gary Tierney wrote:
>>> These changes come from a report by a user on the Freenode IRC channel that
>>> they were unable to build policies for a machine that has an older version of
>>> libsepol installed.
>>>
>>> A new `-c` option that mirrors checkpolicy's own has been added to checkmodule,
>>> and the output of a simple test is shown below:
>>>
>>> $ cat > test.te <<EOF
>>> module test 1.0;
>>>
>>> require {
>>>       type domain;
>>>       type file_type;
>>>       class file { read write };
>>> }
>>>
>>> allow domain file_type : file { read write };
>>> EOF
>>> $ obj/usr/bin/checkmodule -m -M -c 10 -o test.mod test.te
>>> $ checkpolicy/test/dismod test.mod
>>> Reading policy...
>>> ... snip ...
>>> Binary policy module file loaded.
>>> Module name: test
>>> Module version: 1.0
>>> Policy version: 10
>>>
>>> Worthy of note, however, is that these policy version numbers differ from those
>>> used by the kernel policy format.
>>>
>>> Gary Tierney (2):
>>>     checkmodule: add support for specifying module policy version
>>>     dismod: print policy version of loaded modules
>>>
>>>    checkpolicy/checkmodule.8 |  5 ++++-
>>>    checkpolicy/checkmodule.c | 29 +++++++++++++++++++++++++++--
>>>    checkpolicy/test/dismod.c |  4 ++--
>>>    3 files changed, 33 insertions(+), 5 deletions(-)
>>>
>>
>> Acked-by: James Carter <jwcart2@tycho.nsa.gov>
> 
> James there's a superfluous newline between strtol() and errno.
> 

Thanks, I missed that.

I don't see the need for another version of the patches. I can fix that minor 
issue when I merge the patches tomorrow.

>>
>> --
>> James Carter <jwcart2@tycho.nsa.gov>
>> National Security Agency
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
