Return-Path: <SRS0=8Fqr=NT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE93ECDE47
	for <selinux@archiver.kernel.org>; Thu,  8 Nov 2018 14:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27EB20827
	for <selinux@archiver.kernel.org>; Thu,  8 Nov 2018 14:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27EB20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeKHXyU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:54:20 -0500
Received: from ucol19pa09.eemsg.mail.mil ([214.24.24.82]:53122 "EHLO
        ucol19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeKHXyU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Nov 2018 18:54:20 -0500
X-EEMSG-check-008: 790445474|UCOL19PA09_EEMSG_MP7.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,478,1534809600"; 
   d="scan'208";a="790445474"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 08 Nov 2018 14:18:36 +0000
X-IronPort-AV: E=Sophos;i="5.54,478,1534809600"; 
   d="scan'208";a="17672973"
IronPort-PHdr: =?us-ascii?q?9a23=3AiH0fYxHOKGU9/XKPSqFCop1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7ypMSwAkXT6L1XgUPTWs2DsrQY07WQ6/iocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmDiwbaluIBmqsA7cqtQYjYx+J6gr1x?=
 =?us-ascii?q?DHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PG?=
 =?us-ascii?q?Au+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/VC?=
 =?us-ascii?q?+85Kl3VhDnlCYHNyY48G7JjMxwkLlbqw+lqxBm3oLYfJ2ZOP94c6zTZ9MaQX?=
 =?us-ascii?q?dKUNhXWSJPH4iwa5IDAusEMetesoLzpUYBrQGmCAexGu3vxD9GiHz406I03O?=
 =?us-ascii?q?suEx3J0gM7EtISsnnZtsn5OLscXO23yqTD0DXNb+lR2Tf48IXGbwwhru+UXb?=
 =?us-ascii?q?Jwb8XRz1QkGR7AjlqKrYzlOy2a1+QQuGWc9OpvSPmvhnU7qwBxvjevxsAshp?=
 =?us-ascii?q?PPhoIO0F/I7yp5wIErJdChTkNwfNCqEJxVty6ANot2RNsvQ25puCYmyr0GpI?=
 =?us-ascii?q?W0cDIWx5Qgwh7Tc+CHc5KS7RL9VeaROi50i25keL6lgBay60egxvX5Vsau1l?=
 =?us-ascii?q?ZHrDBJkt7WtnAC0RHY98uJSuNl80u81juC2Brf5+FZLUwui6bWJIAtzqQtmp?=
 =?us-ascii?q?cVrE/NBDX5mF/sg6+Tbkgk/++o5Pn5bbj+vZ+cMpN0ihn5MqQzhsyzGeQ4PR?=
 =?us-ascii?q?YKX2ic4em8yKfs/Vf4QLVXlf06iLXZsZDGKsQboa61GQlV3Zo46xmjFTum1d?=
 =?us-ascii?q?UYnX0fIFJEfhKIkZTpNknTLP33AvqzmVShnCpxy/zYMbDtHI/BImXbnLfkZ7?=
 =?us-ascii?q?l96kpcyAQpzdBY4pJZEqoBL+/oWkLqqNzZDgM2Mwyzw+r9DtV9zZkRVXiAAq?=
 =?us-ascii?q?+eLqPeqUWI6f43I+mQeI8Vvy7wK/4k5/Hyin85nUUSfbKz0ZsWb3C4Ge9mI1?=
 =?us-ascii?q?6CbHrpjdoAHn0Gvg0kTOzlkFeCSyJcZ26uX6Ig4TE2EJmmApnHRoCshryBwS?=
 =?us-ascii?q?i6E4ZIZmBJFF+MC23kd4aaVPcWbiKdPMthniYDVbi7RI9ynS2p4Sn7wL1jJ/?=
 =?us-ascii?q?Gc2yofromrgN507OrXnAp09DtzFN+11j2dCWZukTVbaSUx2fVEvUFlylqFmZ?=
 =?us-ascii?q?N9ivhcGM0bs+hFSS8mJJXcyKp8ENm0VQXfKITaAG26S8mrVGliBuk6xMUDNg?=
 =?us-ascii?q?MkQ4uv?=
X-IPAS-Result: =?us-ascii?q?A2CRAAA/ReRb/wHyM5BjHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VopZk8zJ4N4lBJNAQQGgQgtiRKQGjAIAYN6RgKDFiI3Cg0BAwEBAQEBAQIBb?=
 =?us-ascii?q?BwMgjYkAYJgAQUjFQ8yEAsYAgImAgJXBg0GAgEBgl4/AYF0DQ+nPIEugyqBA?=
 =?us-ascii?q?wGBDoRvgQuKbhd5gQeBESeCa4FUgUcCAYEpgzuCVwKJBwaGODNOjwIJhnKKH?=
 =?us-ascii?q?gYYgiOOSY0gjCkigVUrCAIYCCEPgycJCgyCMYM4hRSFXCEDMAGBBAEBihmCT?=
 =?us-ascii?q?QEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 08 Nov 2018 14:18:36 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wA8EIa11011850;
        Thu, 8 Nov 2018 09:18:36 -0500
Subject: Re: [PATCH] libsemanage: set selinux policy root to match semanage
 root or storename
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     selinux@vger.kernel.org
References: <20181106192021.17556-1-sds@tycho.nsa.gov>
 <CAJfZ7=kYppH2JjSkpcgX1FXnaRtHB7c561hkgRZ0XOym_T7_Ww@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a29de7d8-7efb-f8ce-1c29-01dd4c43bb73@tycho.nsa.gov>
Date:   Thu, 8 Nov 2018 09:20:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=kYppH2JjSkpcgX1FXnaRtHB7c561hkgRZ0XOym_T7_Ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/7/18 3:45 PM, Nicolas Iooss wrote:
> On Tue, Nov 6, 2018 at 8:18 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> As reported in #109, semodule -p /path/to/policyroot -s minimum -n -B
>> tries to use /etc/selinux/targeted/booleans.subs_dist.  This is because
>> it invokes the libselinux selinux_boolean_sub() interface, which uses
>> the active/installed policy files rather than the libsemanage ones.
>>
>> To fix, we need to set the selinux policy root when either the semanage
>> root or the semanage storename is set.  When setting the semanage root,
>> we need to prepend the semanage root to the selinux policy root.  When
>> setting the semanage storename, we need to replace the last component
>> of the selinux policy root with the new storename.
>>
>> Test:
>> strace semodule -p ~/policy-root -s minimum -n -B
>>
>> Before:
>> openat(AT_FDCWD, "/etc/selinux/targeted/booleans.subs_dist", O_RDONLY|O_CLOEXEC) = 5
>>
>> After:
>> openat(AT_FDCWD, "/home/sds/policy-root/etc/selinux/minimum/booleans.subs_dist", O_RDONLY|O_CLOEXEC) = 5
>>
>> Fixes https://github.com/SELinuxProject/selinux/issues/109
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>   libsemanage/src/handle.c | 29 ++++++++++++++++++++++++++++-
>>   1 file changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
>> index a6567bd4..c163e553 100644
>> --- a/libsemanage/src/handle.c
>> +++ b/libsemanage/src/handle.c
>> @@ -43,8 +43,21 @@ static char *private_semanage_root = NULL;
>>
>>   int semanage_set_root(const char *root)
>>   {
>> +       char *new_selinux_root = NULL;
>> +
>> +       asprintf(&new_selinux_root, "%s%s", root, selinux_policy_root());
>> +       if (!new_selinux_root)
>> +               return -1;
> 
> https://travis-ci.org/SELinuxProject/selinux/builds/451528669 failed
> because the return value of asprintf needs to be checked instead of
> new_selinux_root. http://man7.org/linux/man-pages/man3/asprintf.3.html
> states:
> 
>      If memory allocation wasn't possible, or some other error occurs,
> these functions will return -1, and the contents of strp are
> undefined.
> 
> [...]
> 
>> +
>> +       char *newroot = NULL;
>> +       asprintf(&newroot, "%s%s", root, storename);
>> +       assert(newroot);
> 
> Same here.

Unfortunately there are more fundamental problems with the patch as 
well, e.g.

1) Mutating selinux_policy_root breaks the test of whether we are 
installing to the active store in semanage_install_final_tmp(), which 
will cause policy reloads to be triggered when performing an operation 
on a different store, a different root, or both.

2) semanage_select_store() is supposed to only modify the per-handle 
state.  Changing selinux policy root is global state and would affect 
any other handles.

3) Multiple semanage_set_root() calls would yield the wrong result.

4) An allocation failure for private_semanage_root would leave the 
policy root modified.

Not sure of the best approach here.  Could possibly just modify the 
policy root around the selinux_boolean_sub() call and leave the rest 
unchanged...
