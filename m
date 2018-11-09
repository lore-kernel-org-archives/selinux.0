Return-Path: <SRS0=0L3W=NU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68961C43441
	for <selinux@archiver.kernel.org>; Fri,  9 Nov 2018 15:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAF720825
	for <selinux@archiver.kernel.org>; Fri,  9 Nov 2018 15:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAF720825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeKJB3Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:29:16 -0500
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:57933 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbeKJB3Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Nov 2018 20:29:16 -0500
X-EEMSG-check-008: 655092576|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,483,1534809600"; 
   d="scan'208";a="655092576"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Nov 2018 15:47:59 +0000
X-IronPort-AV: E=Sophos;i="5.54,483,1534809600"; 
   d="scan'208";a="17721242"
IronPort-PHdr: =?us-ascii?q?9a23=3Al2PGpRIv3iDj1G1hdNmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgeL/7xwZ3uMQTl6Ol3ixeRBMOHs60C07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwdFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUj?=
 =?us-ascii?q?q+8ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfVwZKPdec4RS3?=
 =?us-ascii?q?RHUMhfSidNBpqwY5UTA+YEO+tTsovzqEYUrRamGAeiGu3vxD9LiHH406I13O?=
 =?us-ascii?q?YuHh3J0gE7A9IDsm7ZoMnpOKocU+24yrTDwzXZb/NR3Dfw8IrIcx49rv6WR7?=
 =?us-ascii?q?JwbdTdwlQoGgPHgFSftZbqPymJ1ugTqGWb8+phWv6vi24gsQ1xpCOvyd02ho?=
 =?us-ascii?q?nGgYIV1EnJ+CNky4g2Pd21UFN3bNGrHZdKtyyWKpF6Tt0tTm12oio217sLso?=
 =?us-ascii?q?OhcicQ0pQo3RvfZuSCc4iP/x3sSv6cISx9hHJ5YLK/gAuy8VS4xu38SMa01F?=
 =?us-ascii?q?FKozJZktbWrHAN1gHT6tOdRvth/kauxTaP1wfJ5uFCPU80jrbUJ4Qkwr4xkp?=
 =?us-ascii?q?ofqUXDHinol0XqlKKaa0op9+ey5+nnf7nqvIGQOoBqhg3kL6gigsm/Dv45Mg?=
 =?us-ascii?q?gKUWib4+O81Lj78E37TrRFkuc5krPFsJzEPskbuq64DBNV0oYk8Rq/CSym38?=
 =?us-ascii?q?4CkXkIK1JFZgqLj5L1NFHWPPD4EfC/jkyqkDdq2//GObnhDY/WLnTZkbfher?=
 =?us-ascii?q?F961VHyAcoyNBS6J1VBqsGIPLpVU/7rMbYAQMhMwyo3+bnD81w1pgAVmKLA6?=
 =?us-ascii?q?+ZNr7SsFCT6+IxLOmDepUVtCz+K/c7/f7ui2E2mVsHcamux5sXZyPwIvMzBU?=
 =?us-ascii?q?SSZn7lmZ8gFmARpUJqSu3hj1mLSnhSYHGpRIo5uiF9D5ipW9TtXIeo1b6e1y?=
 =?us-ascii?q?6hAsceMmJZAVmWDS3Aa5SPW/BKbjmbZMBmjGpXBvCaV4Y92ET250fBwL19I7?=
 =?us-ascii?q?+Ro3dAuA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2B/AAAPq+Vb/wHyM5BkGgEBAQEBAgEBAQEHAgEBAQGBZ?=
 =?us-ascii?q?YFbKWl/J4N4lBKCDZksOAGEQAKDJCI4FgEDAQEBAQEBAgFsKII2JAGCXwEBA?=
 =?us-ascii?q?QECASMEEUEFCwsJDwICJgICVwYNBgIBAYJeP4F6CKdWezOFPoRjgQuKcYFXQ?=
 =?us-ascii?q?IE4gmuIAoJXAoEqAY4aM49UBgOKGYZ6BhiBV4UBgnwmhnSZSyGBVSsKQYFog?=
 =?us-ascii?q?U6CUI4oIQMwgQUBAYwKAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 09 Nov 2018 15:47:59 +0000
Received: from [192.168.25.4] (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wA9FlwKR003507;
        Fri, 9 Nov 2018 10:47:58 -0500
Subject: Re: [Non-DoD Source] Re: [PATCH 1/1] libsepol: mark permissive types
 when loading a binary policy
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
References: <20181105210001.31499-1-nicolas.iooss@m4x.org>
 <e5aece95-c1b5-073c-8add-510ee908df57@tycho.nsa.gov>
 <ac49729e-3125-9e0d-36d3-a839ce552339@tycho.nsa.gov>
 <CAJfZ7=mjowLxSb70MACUN+-8kq_nMDGxsk0WO56pb3R0+P3+2A@mail.gmail.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <780246d0-18f8-7bd4-b44c-38f7b1c4a53d@tycho.nsa.gov>
Date:   Fri, 9 Nov 2018 10:48:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=mjowLxSb70MACUN+-8kq_nMDGxsk0WO56pb3R0+P3+2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/7/18 3:39 PM, Nicolas Iooss wrote:
> On Tue, Nov 6, 2018 at 8:19 PM jwcart2 <jwcart2@tycho.nsa.gov> wrote:
>>
>> On 11/6/18 11:22 AM, Stephen Smalley wrote:
>>> On 11/5/18 4:00 PM, Nicolas Iooss wrote:
>>>> When using checkpolicy to read a binary policy, permissive types are not
>>>> written in the output file. In order to reproduce this issue, a test
>>>> policy can be written from minimal.cil with the following commands:
>>>>
>>>>       $ cd secilc/test/
>>>>       $ cp minimum.cil my_policy.cil
>>>>       $ echo '(typepermissive TYPE)' >> my_policy.cil
>>>>       $ secilc my_policy.cil
>>>>       $ checkpolicy -bC -o /dev/stdout policy.31
>>>>
>>>>       # There is no "(typepermissive TYPE)" in checkpolicy output.
>>>>
>>>> This is because TYPE_FLAGS_PERMISSIVE is added to typdatum->flags only
>>>> when loading a module, which uses the permissive flag in the type
>>>> properties. A kernel policy defines permissive types in a dedicated
>>>> bitmap, which gets loaded as p->permissive_map before the types are
>>>> loaded. Use this bitmap to mark permissive types in the loaded policy.
>>>>
>>>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>>>
>>> Or we could directly use the permissive_map in kernel_to_cil/kernel_to_conf?
>>
>> I think that this is the more natural way to do it.
>> Jim
> 
> I agree. Please drop my patch and keep yours.
> 
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>


Merged my patch.
Thanks,
Jim

> Thanks,
> Nicolas
> 
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
