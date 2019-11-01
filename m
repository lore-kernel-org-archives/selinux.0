Return-Path: <SRS0=ebWe=YZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58E1CA9ECF
	for <selinux@archiver.kernel.org>; Fri,  1 Nov 2019 13:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C07B217D9
	for <selinux@archiver.kernel.org>; Fri,  1 Nov 2019 13:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="CP55+RYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfKANu3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Nov 2019 09:50:29 -0400
Received: from UCOL19PA36.eemsg.mail.mil ([214.24.24.196]:11924 "EHLO
        UCOL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfKANu2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Nov 2019 09:50:28 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Nov 2019 09:50:28 EDT
X-EEMSG-check-017: 43793714|UCOL19PA36_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,255,1569283200"; 
   d="scan'208";a="43793714"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 01 Nov 2019 13:43:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1572615793; x=1604151793;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=8DWmi4tS5VlHzSQJNVYkjOSwZHlDYQ7G9LKpzv+rgSo=;
  b=CP55+RYPlX6eDHFr9pH7/vfLmhSgEUrt/9oxDsvCEcFExMBONya1l/Vd
   UE5XPvOxP8MutvX5nesRNlHzA3XbZlz/QePmt8jVO8lFUlhBPy410KgFQ
   +E3WqlASi+OyReyoTV6ipLj68rnm4cNXpKFzb8DsGYTOZZ8SbCDlzCFUO
   Vj4tSCWxjyYgX7sezIEIXGZDuqzWgfK6UdB3wXNe0EGC/14cBYq5IFhaC
   Np88RyZa38fNxq0zyPrf5fADAYyl7roMibK2PVwh4WMvTioHl7IeGg7DR
   VDQneekQLoG1LVpsx+dt3NlqiKBhpbIwX44GWYDTLgLS/sOUJ75dm4qbr
   g==;
X-IronPort-AV: E=Sophos;i="5.68,255,1569283200"; 
   d="scan'208";a="34989085"
IronPort-PHdr: =?us-ascii?q?9a23=3AD7pEyha+Mvd8PdeXgDH9QJT/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsy5YB7h7PlgxGXEQZ/co6odzbaP6Oa5ATNLvM3JmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/MusUKg4ZuJaY8xx?=
 =?us-ascii?q?XUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSW?=
 =?us-ascii?q?ZdQspdUipMDY2mb4sLEuEPI+BWoYfgrFcKtBezCw2hCObpxzRVhHH5wLc63v?=
 =?us-ascii?q?w8Hw/Y0gwuH9EAvnrao9r6NqgdTe+7wbLUzTjBdf5axSvx5YbKfx0nvPqCXa?=
 =?us-ascii?q?hwcc3UyUQ3FQPEgEmfppb/PzOJyOgGrm+W7+huVO2zkWEnsR1xria0y8cwio?=
 =?us-ascii?q?jGmoIVylfe+SV/24Y6P8e0SEF8Yd66CZZdsTyROYVxQsMnWW5ouSA6x6UJuZ?=
 =?us-ascii?q?66YCgKyIknyAXFZ/ObdIiI5xTuX/uSLzdgnH9pZb2yihmo/UWg1+HwTNe43V?=
 =?us-ascii?q?lUoiZfj9XBsG0G2QbJ5cidUPR9+1+s2TOI1w/O9O5JOVs0la/HK545xb4wi4?=
 =?us-ascii?q?YTvVzDHiDonEX2i7ebdlk+9eiy6uTnf67mqoWAN450lg7+MqMulta5AeskKQ?=
 =?us-ascii?q?gBQ3KX+eG91L3n5UH5QbNKgeMqkqTBrZzXKssWqrS5DgNIyIov9RmyAym83N?=
 =?us-ascii?q?gFhXUHKUhKeBODj4jnIVHOJ/X4AO+9g1WijDhk3erGPqH/DpjWMnjCkKvufb?=
 =?us-ascii?q?Z660JGzgoz1spQ64hbCrEGPvL/QlXxu8DADh8lLwy0xP7qCNN81owCXmKPBr?=
 =?us-ascii?q?WWMLjIvV+J4eIvJPKMZJQOtTb4JPUk6OTijXgjmV8SZaOpx4cYaGikHvR6JE?=
 =?us-ascii?q?WUeWLsgtMbHmcXogo+Vvflh0eZXD5JeXm9QqI86SsnCI68EYjDQYWtiqSb3C?=
 =?us-ascii?q?inBp1WenxGCleUHHfzaYqEX/YMaCSPIs5uiTEES7ehRJE71R20tw/11aBnLu?=
 =?us-ascii?q?zK9S0cr57j08J15+KA3S01oBp1BMOZ2nrFbmZzhXhAEzk316d7qFc7y1CEyr?=
 =?us-ascii?q?NQhqBIU9tJ6KUNGj83KYSU6+VnF8r4UwnBNoORTF+7Xs+sCBkrQ94xysNIaE?=
 =?us-ascii?q?F4TZHqtT3H3iy3E/cRlqeXTMgv/6bd2WXhD9hyxmyA16Q7iVQiBMxVOjv1qL?=
 =?us-ascii?q?R48l3RGIXAiVnD3/Koaq8VxjKX3HuSxmqJ+kdDWUh/VruTDiNXXVffsdmsvh?=
 =?us-ascii?q?CKdLSpE7lyd1IamMM=3D?=
X-IPAS-Result: =?us-ascii?q?A2AtBQAqNbxd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgX2Bd?=
 =?us-ascii?q?CxsVAEyKoQojwuBayWbJQkBAQEBAQEBAQErCQECAQGEQAKDeyQ4EwIOAQEBB?=
 =?us-ascii?q?AEBAQEBBQMBAWyFNwyCOykBgmwBAQEBAgEjFUYLCwkPAgImAgJXBgEMBgIBA?=
 =?us-ascii?q?YJfPwGCVyAPsSl1gTKFToM+gUIGgQ4ohRiGeYFXQIE4DIJfPoJiAoRxgl4Eg?=
 =?us-ascii?q?TsBi02JMYE2lgIGgiiHEY4eBhuCPIdaj0+KaoNWiC6TNyKBWCsKQYFogU5QE?=
 =?us-ascii?q?RSGeYpvJQMwgQUBAY1lAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 01 Nov 2019 13:43:12 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xA1DhBDO026027;
        Fri, 1 Nov 2019 09:43:11 -0400
Subject: Re: [Non-DoD Source] Re: ANN: SELinux userspace 3.0-rc1 release
 candidate
To:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
References: <pjd1rut9rnh.fsf@redhat.com>
 <CAJfZ7=nOVSMNZHCYexgEk=xAfMfEA1pVkvVs5YANurj86VNMug@mail.gmail.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <639285f9-495e-8d49-7445-21d5fbcc2204@tycho.nsa.gov>
Date:   Fri, 1 Nov 2019 09:43:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=nOVSMNZHCYexgEk=xAfMfEA1pVkvVs5YANurj86VNMug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/1/19 6:54 AM, Nicolas Iooss wrote:
> On Thu, Oct 31, 2019 at 10:43 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Hello,
>>
>> A 3.0-rc1 release candidate for the SELinux userspace is now
>> available at:
>>
>> https://github.com/SELinuxProject/selinux/wiki/Releases
>>
>> Please give it a test and let us know if there are any issues.
>>
>> If there are specific changes that you think should be called out
>> in release notes for packagers and users in the final release
>> announcement, let us know.
> 
> Hello, I started testing this RC on a test virtual machine (which uses
> Arch Linux and refpolicy) and something changed in a quite unexpected
> way: "semodule --verbose" is now a lot more noisy than 2.9. Here is an
> example of what I get when rebuilding the policy:
> 
> # semodule --verbose -B
> Committing changes:
> Disabling optional 'ada_optional_6' at
> /var/lib/selinux/refpolicy/tmp/modules/400/ada/cil:63
> Failed to resolve typeattributeset statement at
> /var/lib/selinux/refpolicy/tmp/modules/400/ada/cil:66
> Disabling optional 'anaconda_optional_9' at
> /var/lib/selinux/refpolicy/tmp/modules/400/anaconda/cil:183
> Failed to resolve typeattributeset statement at
> /var/lib/selinux/refpolicy/tmp/modules/400/anaconda/cil:189
> Disabling optional 'apache_optional_92' at
> /var/lib/selinux/refpolicy/tmp/modules/400/apache/cil:3449
> Failed to resolve typeattributeset statement at
> /var/lib/selinux/refpolicy/tmp/modules/400/apache/cil:3499
> ...
> 
> Such an output could be useful when debugging issues about optional
> modules, but they may make other issues harder to find among all the
> messages. Would it be possible to hide these specific messages by
> default in verbose mode?
> 

I can turn these into CIL_INFO messages rather than CIL_WARN messages. That will 
hide them.

Jim

> Thanks,
> Nicolas
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
