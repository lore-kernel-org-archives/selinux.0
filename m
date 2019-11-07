Return-Path: <SRS0=6oqa=Y7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDFDC5DF61
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 18:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAD62178F
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 18:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="bDCIKxzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfKGSA5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:00:57 -0500
Received: from UCOL19PA36.eemsg.mail.mil ([214.24.24.196]:13666 "EHLO
        UCOL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfKGSA5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Nov 2019 13:00:57 -0500
X-EEMSG-check-017: 46699663|UCOL19PA36_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,278,1569283200"; 
   d="scan'208";a="46699663"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Nov 2019 17:59:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573149597; x=1604685597;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=N45vs1XiFuFhVr+9SzQLTd+HVR35ZF7d1qjuqTg3CGI=;
  b=bDCIKxzoIYJIJh69j4xJf5sPmJ4cIXQLV0dyOXw7XeN9yCIdIiqSHDR7
   oq8mwkwyQKFZC5AGX744iAe9hNbJwbQwHP+++wHm5EIhCwhJfQOymWa/5
   rbB2unk9nEcbiEvG374xhIhEz9WR3V+nlLJzykghmK+pzYus/znQi7BZ3
   pq69tODz4Nd6tuDU9TOx/062/SJupHcz02YF837v/TzhNB2rqp1zv39r1
   5RdotxkinfMijpNIzTpE2pf1G+2iby8aJJDkJrg6ru2UjGmL549IiQWnO
   6Rg5C5JrCWWH6wcFceBUiZauFsCPCOun1B3n86qWSOedYfzDXeTk3QLni
   g==;
X-IronPort-AV: E=Sophos;i="5.68,278,1569283200"; 
   d="scan'208";a="29880134"
IronPort-PHdr: =?us-ascii?q?9a23=3AJ/Eg/BV4EV+CWAKHlDBEpzaM1TfV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRSGvqdThVPEFb/W9+hDw7KP9fy5AipZuMfK6ShfOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjfu8UMnIduN6I8xh?=
 =?us-ascii?q?TUrndUe+ld2H9lK0+Ukxvg/Mm74YRt8z5Xu/Iv9s5AVbv1cqElRrFGDzooLn?=
 =?us-ascii?q?446tTzuRbMUQWA6H0cUn4LkhVTGAjK8Av6XpbqvSTksOd2xTSXMtf3TbAwXj?=
 =?us-ascii?q?Si8rtrRRr1gyoJKzI17GfagdFrgalFvByuuQBww4/MYIGUKvV+eL/dfcgHTm?=
 =?us-ascii?q?ZFR8pdSjBNDp+5Y4YJAeUBJ+JYpJTjqVUIoxW1GA2gCPrhxzJMg3P727Ax3e?=
 =?us-ascii?q?Y8HgHcxAEuAswAsHrUotv2OqkdX++6w6vUwjvMdP5WxTXw5ZLUfhw9r/yBX7?=
 =?us-ascii?q?R9etfRx0k1EAPFi02dp5H5PzyLzuQNs3aU7+x9Xuyyjm4osQVxojyxycYsl4?=
 =?us-ascii?q?LEgZkVxU3f9Shi3IY0JcG3SE58YdK+FptQrDuVO5F5QsMlXWFloSA3waAIt5?=
 =?us-ascii?q?68eSgF0pUnxxjHZvydbYeH/xLjW/yNITtimH1lf7e/ihCv+kaj0u3xTtS43V?=
 =?us-ascii?q?lFoyZfktTAq2oB2wLc58SZUPdx40Gs0iuV2Q/J8OFLO0U0mLLeK54m37E/iI?=
 =?us-ascii?q?IesV/GHi/qgEX2i7KWdlk89uio9evnZrLmq4eAN4BukAH+M7kumtelDeQkMg?=
 =?us-ascii?q?kBQ2ib+eOm2L3l4UL5W6lFguczkqnYtJDWPcUbpqinDA9Jyosv9hmyAji83N?=
 =?us-ascii?q?kYgHULNkxJdR2Zg4TzJl3COPX4Au2+g1Sonjdr3ffGPrj5D5XWM3fDi6zsfa?=
 =?us-ascii?q?p96kFAyAozyspT55RPCr4bOv7zVUjxtMLAAh8jLwO02/rnCMl61o4GXmKPB6?=
 =?us-ascii?q?iZMLjUsVCS+u0gPfKBZJULtzngK/gq/eLugWUlll8aeKmjxYEXZ2ygHvR6P0?=
 =?us-ascii?q?WZZmLhgswfHmcOvwo+SvHqiVKZXD5NaHa9Qbg86is4CI24F4fDQJ6igLib0C?=
 =?us-ascii?q?e8BJ1WaXhMCkqQHnfwa4WER/AMZTqKIsB7jzwEUaOsS5c72hGzsA/20r9nLu?=
 =?us-ascii?q?3T+i0Cq53vzsR65+rWlRsq7zx7E9yd032RT2Fzhm4IQiQ20758oUx51FiDzb?=
 =?us-ascii?q?J3judCFdNN+vxJUh01NYLGw+NmDNDyX1GJQtDcb1CqWNikSRQ2VdQ4yNINKx?=
 =?us-ascii?q?J6HtK5iBnI0gKwDrMVnqDND5sxpPHyxX/0cv1hxm7G2a9ptFwvRs9CJCXyna?=
 =?us-ascii?q?Jk3xTCDI7O1UOCnuClcrpKj32Fz3uK0Wfb5BIQawV3S6iQGClEN0Y=3D?=
X-IPAS-Result: =?us-ascii?q?A2CpAgAcW8Rd/wHyM5BkHAEBAQEBBwEBEQEEBAEBgX6Bd?=
 =?us-ascii?q?CxsVTIqhCmPbAEBBoERJX+IZY9cgWcJAQEBAQEBAQEBKwkBAgEBhEAChA4kO?=
 =?us-ascii?q?BMCDgEBAQQBAQEBAQUDAQFshTcMgjspAYJtAQUjBBFBEAsOCgICJgICVwYNB?=
 =?us-ascii?q?gIBAYJfPwGCUiUPswF/M4VOgzOBQgaBDiiMFBh4gQeBEScMgio1PoJiBBiBL?=
 =?us-ascii?q?4Mogl4EjHiJT0WWeIIugjaEYY4kBhuZcpZ3k0oigVgrCAIYCCEPO4JsUBEUk?=
 =?us-ascii?q?EIXg1CKcSMDMAGBBAEBkC4BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 07 Nov 2019 17:59:56 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xA7HxtXY003660;
        Thu, 7 Nov 2019 12:59:55 -0500
Subject: Re: [PATCH v2] selinux: cache the SID -> context string translation
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Michal Sekletar <msekleta@redhat.com>
References: <20191106082634.5173-1-omosnace@redhat.com>
 <b8d38817-80b8-fec1-fd5d-81c4e86e1001@tycho.nsa.gov>
 <9de8f6bd-a013-934f-d22f-0b324509cb13@tycho.nsa.gov>
 <0a6ddbc7-faa5-5f92-cb2d-b8df1c0b4270@tycho.nsa.gov>
 <CAFqZXNvfovdHTFaPH3QA2dRyibtf8Qhd_3G3HKP2qyex5c+yhg@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1ea02755-a124-d42f-5437-6c8c582ba420@tycho.nsa.gov>
Date:   Thu, 7 Nov 2019 12:59:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNvfovdHTFaPH3QA2dRyibtf8Qhd_3G3HKP2qyex5c+yhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/7/19 7:41 AM, Ondrej Mosnacek wrote:
> On Wed, Nov 6, 2019 at 8:48 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 11/6/19 2:22 PM, Stephen Smalley wrote:
>>> On 11/6/19 11:11 AM, Stephen Smalley wrote:
>>>> On 11/6/19 3:26 AM, Ondrej Mosnacek wrote:
>>>>> Translating a context struct to string can be quite slow, especially if
>>>>> the context has a lot of category bits set. This can cause quite
>>>>> noticeable performance impact in situations where the translation needs
>>>>> to be done repeatedly. A common example is a UNIX datagram socket with
>>>>> the SO_PASSSEC option enabled, which is used e.g. by systemd-journald
>>>>> when receiving log messages via datagram socket. This scenario can be
>>>>> reproduced with:
>>>>>
>>>>>       cat /dev/urandom | base64 | logger &
>>>>>       timeout 30s perf record -p $(pidof systemd-journald) -a -g
>>>>>       kill %1
>>>>>       perf report -g none --pretty raw | grep security_secid_to_secctx
>>>>>
>>>>> Before the caching introduced by this patch, computing the context
>>>>> string (security_secid_to_secctx() function) takes up ~65% of
>>>>> systemd-journald's CPU time (assuming a context with 1024 categories
>>>>> set and Fedora x86_64 release kernel configs). After this patch
>>>>> (assuming near-perfect cache hit ratio) this overhead is reduced to just
>>>>> ~2%.
>>>>>
>>>>> This patch addresses the issue by caching a certain number (compile-time
>>>>> configurable) of recently used context strings to speed up repeated
>>>>> translations of the same context, while using only a small amount of
>>>>> memory.
>>>>>
>>>>> The cache is integrated into the existing sidtab table by adding a field
>>>>> to each entry, which when not NULL contains an RCU-protected pointer to
>>>>> a cache entry containing the cached string. The cache entries are kept
>>>>> in a linked list sorted according to how recently they were used. On a
>>>>> cache miss when the cache is full, the least recently used entry is
>>>>> removed to make space for the new entry.
>>>>>
>>>>> The patch migrates security_sid_to_context_core() to use the cache (also
>>>>> a few other functions where it was possible without too much fuss, but
>>>>> these mostly use the translation for logging in case of error, which is
>>>>> rare).
>>>>>
>>>>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1733259
>>>>> Cc: Michal Sekletar <msekleta@redhat.com>
>>>>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>>>>
>>>> This looks good to me and didn't trigger any issues during testing.
>>>> Might want to run it by the RCU wizards, e.g. Paul McKenney, to
>>>> confirm that it is correct and optimal usage of RCU.  I didn't see
>>>> anywhere near the same degree of performance improvement in running
>>>> your reproducer above but I also have all the kernel debugging options
>>>> enabled so perhaps those are creating noise or perhaps the reproducer
>>>> doesn't yield stable results.
>>>
>>> Rebuilding with the stock Fedora x86_64 kernel config was closer to your
>>> results albeit still different, ~35% before and ~2% after.
>>
>> Ah, I can reproduce your ~65% result on the 5.3-based Fedora kernel, but
>> not with mainline 5.4.0-rc1.  Only SELinux change between those two that
>> seems potentially relevant is your "selinux: avoid atomic_t usage in
>> sidtab" patch.
> 
> Hm... did you use the stock Fedora kernel RPM as the baseline? If so,
> this could be because on stable Fedora releases the kernel package is
> built with release config and kernel-debug with debug config, while on
> Rawhide there is only one kernel package, which is built with debug
> config. Under debug Fedora config the numbers are completely different
> due to the overhead of various debug checks. I don't remember the
> "after" value that I got when testing the patched Rawhide kernel with
> the default debug config, but on stock Rawhide I got 43%, and on
> Rawhide kernel rebuild with release config I got 65% again.

I first built selinux/next (based on 5.4-rc1) before and after your 
patch using a config with many debug options enabled (including KASAN), 
which yielded wildly different percentages both before and after - don't 
remember the exact values (but still improved by your patch).

Then I built the same sources using the stock Fedora 31 release kernel 
config and got the 35% versus 2% figures, likewise an improvement.

Then I ran your reproducer just on the stock Fedora 31 release kernel, 
which happened to be 5.3-based, and got the 65% versus 2% figures that 
matched your results.  So I'm not sure what accounts for the difference 
in the before results between the stock Fedora 31 release kernel and 
selinux/next using the same config.  Could be a 5.3 vs 5.4-rc1 change, a 
change in selinux/next on top of 5.4-rc1, or something different in the 
build toolchain/environment used for the stock Fedora kernel versus my 
build host (which was running Fedora 31).

Regardless, I do see a significant improvement in all cases from the 
patch, only the degree of improvement differs.  So I'm fine with it. 
Might want to get a 2nd opinion from Paul McKenney all the same on the 
RCU bits.
