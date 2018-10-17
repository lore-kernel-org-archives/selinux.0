Return-Path: <SRS0=vIUq=M5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B98ECDE3B
	for <selinux@archiver.kernel.org>; Wed, 17 Oct 2018 21:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C58E208E4
	for <selinux@archiver.kernel.org>; Wed, 17 Oct 2018 21:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C58E208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeJRFSv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Oct 2018 01:18:51 -0400
Received: from upbd19pa12.eemsg.mail.mil ([214.24.27.87]:42990 "EHLO
        upbd19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeJRFSv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Oct 2018 01:18:51 -0400
X-EEMSG-check-008: 164328531|UPBD19PA12_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Oct 2018 21:21:14 +0000
X-IronPort-AV: E=Sophos;i="5.54,393,1534809600"; 
   d="scan'208";a="19557953"
IronPort-PHdr: =?us-ascii?q?9a23=3AFrKBzxzjpeyNFSfXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0uoVL/ad9pjvdHbS+e9qxAeQG9mDtLQc06L/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHPYQhEniaxba9vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb7Vq4/Vy?=
 =?us-ascii?q?i84Kh3SR/okCYHOCA/8GHLkcx7kaZXrAu8qxBj34LYZYeYO/RkfqPZYNgUW2?=
 =?us-ascii?q?xPUMhMXCBFG4+wcpcDA+8HMO1FrYfyukEOoAOjCweyCuPhyjxGiHH40qI10e?=
 =?us-ascii?q?suDQ7I0Rc8H98MqnnYsMn5OakQXO2z0aLGzS/Db/RT2Trl9YbIbg4uoemMXb?=
 =?us-ascii?q?1ud8ra1FQhFwbfgVWUrYzqITOU3fkKvmiA8uVgTvmii3Inqg5tojivwd0gio?=
 =?us-ascii?q?/Sho0P0FzE+iJ5wJgsKNC+VUV1b9mkEJ5KuCGbMYt7Wt8iQ3tytyYky70Goo?=
 =?us-ascii?q?e3czQLyJg9wB7fcfOHfo6V6RzgTOacOSp0iX1qdb6lhxu+7FKsxvPzW8Wqyl?=
 =?us-ascii?q?pGsyxImcTWuH8XzRzc8M2HR+N4/kemxDmAyRje6vpBIUAojarbLIMhwqIomp?=
 =?us-ascii?q?oTr0vDGij2lV3qjKCMbEUk+/Wo6//9brX6pp6TK490igbkPqQohsO/Gvg3Ph?=
 =?us-ascii?q?ILX2ia/eSwzLzj/UvnT7VWlvA6j6bUvZ/AKckbu6K1GRFZ34k95xqlEjuqyN?=
 =?us-ascii?q?EYkmMGLFJBdhKHlY/pO1TWLfDjEPi/mE+hkCtrxv/aPr3hBY/BLn7YkLj7Z7?=
 =?us-ascii?q?p95ElcyBQrwdBF+51UEq0BIO70WkLprNzXFAI5Mwivzub/Etp9y4ceVXuKAq?=
 =?us-ascii?q?+eN6PSq0GH6vgzLOmLYY8foCz9JOQ95/7ykX85nkcQcrKo3ZsTbHC0BOhpL1?=
 =?us-ascii?q?+DYXrrmdgOD30KvhYlTOHxh12CVCRcZ3e2X64m+j47D4emB5/ZRo+xmLyBwD?=
 =?us-ascii?q?u7HppOa2BBD1CMFmzod4OeVPgQdi2fOdVhnSIZWrihUYAhyQuiuxP9y7piNu?=
 =?us-ascii?q?DU4DEXtYr/1Nhp4O3ejQoy+iJwD8Sc1WGNUm51k3gWRz85wq9/u1ZxylSd3q?=
 =?us-ascii?q?hihfxXC9hT6+lOUgcgOp6Ph9B9Xuj7RwaJW9COUlvuFs2vHDUZVtssx5oLZE?=
 =?us-ascii?q?FnFpOpiRWVm2KgArsR0bfNHps+/7jAxFD+Is98zzDN06xyoUMhR550KWC+hq?=
 =?us-ascii?q?N5vzPWDorNnlTRw72mbowAzSXN8yGF1mPIs0ZGBl0jGZ7ZVGwSMxOF5e/y4V?=
 =?us-ascii?q?nPGvr3UOwq?=
X-IPAS-Result: =?us-ascii?q?A2AbAQD+psdb/wHyM5BkGwEBAQEDAQEBBwMBAQGBZYFbK?=
 =?us-ascii?q?mZ/KIN1lDFMAQEBAQEBBoE1iHYOkAIwCAGEQAKEfCE4FgEDAQEBAQEBAgFsH?=
 =?us-ascii?q?AyCNiQBgl8BBSMEEUEQCxgCAiYCAiE2BgEMBgIBAYJdPwGBaQMIDQ+meHszh?=
 =?us-ascii?q?CwBgQ2COg2CEwWBC4pBF3mBB4E5gmuCVkUBgTuDKoJXAoh0hguPBC4JhliDG?=
 =?us-ascii?q?YNOgx4GF5AijEh2ilchgVUrCAIYCCEPgycTiwWFWiMwAYEEAQGINoJNAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 17 Oct 2018 21:21:12 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w9HLLCcK018734;
        Wed, 17 Oct 2018 17:21:12 -0400
Subject: Re: [PATCH] libsepol: fix endianity in ibpkey range checks
To:     Paul Moore <paul@paul-moore.com>, bill.c.roberts@gmail.com
Cc:     omosnace@redhat.com, selinux@vger.kernel.org, selinux@tycho.nsa.gov
References: <20181017144659.10960-1-omosnace@redhat.com>
 <CAFftDdqKAHN3+Mb3QB2n=555PFKYntpKf_sXzWWppQ4tP=AdvQ@mail.gmail.com>
 <CAHC9VhT_npm4ix7kmN8GOOxUp8z7ySz0Z6LLKqd0VOMJPKcibA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ae98be54-7bcd-b501-a1ff-b9ab0ae3aa95@tycho.nsa.gov>
Date:   Wed, 17 Oct 2018 17:22:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhT_npm4ix7kmN8GOOxUp8z7ySz0Z6LLKqd0VOMJPKcibA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/17/2018 05:18 PM, Paul Moore wrote:
> On Wed, Oct 17, 2018 at 12:07 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
>> On Wed, Oct 17, 2018 at 7:48 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>>>
>>> We need to convert from little-endian before dong range checks on the
>>> ibpkey port numbers, otherwise we would be checking a wrong value.
>>>
>>> Fixes: 9fbb3112769a ("libsepol: Add ibpkey ocontext handling")
>>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>>> ---
>>>   libsepol/src/policydb.c | 14 ++++++++++----
>>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
>>> index a6d76ca3..dc201e2f 100644
>>> --- a/libsepol/src/policydb.c
>>> +++ b/libsepol/src/policydb.c
>>> @@ -2830,15 +2830,21 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
>>>                                  break;
>>>                          case OCON_IBPKEY:
>>>                                  rc = next_entry(buf, fp, sizeof(uint32_t) * 4);
>>> -                               if (rc < 0 || buf[2] > 0xffff || buf[3] > 0xffff)
>>> +                               if (rc < 0)
>>>                                          return -1;
>>>
>>> +                               c->u.ibpkey.low_pkey  = le32_to_cpu(buf[2]);
>>> +                               c->u.ibpkey.high_pkey = le32_to_cpu(buf[3]);
>>
>> Ahh you're assigning a 32 bit value to a 16 bit variable low|high_pkey. I think
>> you need to assign them to a uint32_t if you want to actually range check them.
> 
> If you can, give me a chance to look over the kernel changes first.  I
> doubt I'll see anything objectionable given the review the patches
> have already seen, but one never knows.

The kernel patch has the same bug, so it will also need a re-spin.  Good 
catch.

> 
>>> +
>>> +                               if (c->u.ibpkey.low_pkey  > 0xffff ||
>>> +                                   c->u.ibpkey.high_pkey > 0xffff)
>>> +                                       return -1;
>>> +
>>> +                               /* we want c->u.ibpkey.subnet_prefix in network
>>> +                                * (big-endian) order, just memcpy it */
>>>                                  memcpy(&c->u.ibpkey.subnet_prefix, buf,
>>>                                         sizeof(c->u.ibpkey.subnet_prefix));
>>>
>>> -                               c->u.ibpkey.low_pkey = le32_to_cpu(buf[2]);
>>> -                               c->u.ibpkey.high_pkey = le32_to_cpu(buf[3]);
>>> -
>>>                                  if (context_read_and_validate
>>>                                      (&c->context[0], p, fp))
>>>                                          return -1;
>>> --
>>> 2.17.2
>>>
>> See job: https://travis-ci.org/SELinuxProject/selinux/jobs/442750208
>>
>> Build fail with gcc:
>>
>> policydb.c:2839:31: error: comparison is always false due to limited
>> range of data type [-Werror=type-limits]
>>       if (c->u.ibpkey.low_pkey  > 0xffff ||
>>                                 ^
>> policydb.c:2840:31: error: comparison is always false due to limited
>> range of data type [-Werror=type-limits]
>>           c->u.ibpkey.high_pkey > 0xffff)
> 
> 
> 

