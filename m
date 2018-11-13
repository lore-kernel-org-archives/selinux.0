Return-Path: <SRS0=smjq=NY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916DEC43441
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 03:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9AF223DD
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 03:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9AF223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbeKMNH0 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Nov 2018 08:07:26 -0500
Received: from mout.gmx.net ([212.227.17.22]:48179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeKMNH0 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 13 Nov 2018 08:07:26 -0500
Received: from [192.168.1.153] ([74.104.183.64]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MWxtA-1g1UaI3Pbo-00Vv0r; Tue, 13
 Nov 2018 04:11:11 +0100
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: BUG: KASAN: slab-out-of-bounds in
 selinux_sctp_bind_connect+0x60/0x150
From:   Qian Cai <cai@gmx.us>
In-Reply-To: <CAHC9VhRODL9JYjJ3QpExMaztA3PFv_Z1t=Q=4K8QMtJh7ntVuw@mail.gmail.com>
Date:   Mon, 12 Nov 2018 22:11:07 -0500
Cc:     linux kernel <linux-kernel@vger.kernel.org>,
        selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <989F5A08-F283-4BB7-B3D9-67E25EE05F69@gmx.us>
References: <53491A18-DD21-4E34-BC2F-AB449C7844E8@gmx.us>
 <CAHC9VhTiCPwQ51ciexRCp4M5rN2C=pTm=anRaMgTsZ9coX96Zw@mail.gmail.com>
 <7DE35AF4-20E1-4402-9B5A-4D8AACE15D56@gmx.us>
 <CAHC9VhRODL9JYjJ3QpExMaztA3PFv_Z1t=Q=4K8QMtJh7ntVuw@mail.gmail.com>
To:     Paul Moore <paul@paul-moore.com>
X-Mailer: Apple Mail (2.3445.100.39)
X-Provags-ID: V03:K1:INl21rVHApDBQMzoPbfnFc6zdGSwWdM56lnevX9g40eXh4QUrDf
 D+kdBLZGCjizE3r0K3v5EkDNzVvmQF2AFaQVcmRpS+YHMmq9vlipxG4N/D5sgAfpVDMT7gX
 zB8a4arMlyu0lvLBI4KgdRrcu4QZzcHYVJ2TN4dWj6C7rI0t+GIQY/Ab+GHLa/q5vpaWeGJ
 Jx8eu6DR/HPENW+QCIFnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ab5E1b19OpU=:w/NVF8yiJjKdT+fIwrkxkZ
 SL8hirk0fld2DLbmvEdmBzJhbKkclDNqtlpOZZjeZ8EErLoPx15iVNb6Nifc8jrgHrs8RTCjz
 6mNmAeUyjTsaGWO+/izkr57ZGAIgoE/DAV2dddkwKqZQeS/143RCtxHhLmCARQnzwXABdvDMj
 z0gl/abllkJYvGuqPAF8vH4IPmHsZ/f+LphVc2aIH3OW+tGIW+ZaIhuzBFblB8LfmdciOKIX7
 y2+PrAFnfk5icT5sejCrVbqcQk/6Ci4mJdKjTcGkLZJtUJ/J2YGqMrnA+sdt99yW8Z1n4bree
 BmT1V6MlfLMNuAZjXcOSNf8cPKtfF1BBCixX14Wwq9aa+0Cemc7zBgTvarhdIR2AKuLNlclM+
 GrVe5qdDqb2j6rNRWmkl5zMmit+uoD0B3Agn5Bx7ScHPfhQyp1cN38KybbzrQcDumbxV6UMSH
 DEF09PCr0Qz9UTfZWwxC858pHp3S6sWTUOJU2oucf6XNAashyonc+8w31KHj0+l7kN+F+wZI/
 33elEZY5zBqB07z73niaABjxEJJQuAgfNce21/x3b/cGch749N9r5REzaZ+b9VSh/UyoolkTd
 2HUkrz2LgrKLESu3kRVCp+xAbDfWpx+OF5ECcVUDGI8//4ezcFiiDRKIzh71VXuoU/VPDVt/K
 DCfPTscMuwXvprBrgLmtv/xxM9yRsYaUG5mr8Z62IGRXbS4d/MYgXzfYTVHCtTWkJ6OBZSKID
 UvsbplbsCyn0ZEJ7fBuf37oqTmSc86nUIKrWhfdfwJUtoOvB+vjN0k/IOVeWBeHlEiDDLe1Qd
 5LHqAgSlHcS6mCsPCP5So7ofTCwcF4UxiCcDHG5V0hGxQKxMDRMaJQqoGrSuZXu7VvCzyVXjI
 tujocTfs8zCbYEiQ/2g3yuRCOz3pUAzY+rKsB8SHYCuKKeaozLkp8diHFBCVrX
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



> On Nov 12, 2018, at 10:09 PM, Paul Moore <paul@paul-moore.com> wrote:
> 
> On Mon, Nov 12, 2018 at 7:59 PM Qian Cai <cai@gmx.us> wrote:
>>> On Nov 12, 2018, at 7:41 PM, Paul Moore <paul@paul-moore.com> wrote:
>>> On Mon, Nov 12, 2018 at 2:39 PM Qian Cai <cai@gmx.us> wrote:
>>>> 
>>>> Running the trinity fuzzer on the latest mainline (rc2) generates this,
>>>> 
>>>> [15029.879626] BUG: KASAN: slab-out-of-bounds in selinux_sctp_bind_connect+0x60/0x150
>>>> [15029.887275] Read of size 2 at addr ffff801ec53c5080 by task trinity-main/18081
>>>> [15029.887294]
>>>> [15029.887304] CPU: 28 PID: 18081 Comm: trinity-main Tainted: G        W  OE     4.20.0-rc2+ #15
>>>> [15029.887311] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.50 06/01/2018
>>>> [15000.084786] [15029.887320] Call trace:
>>>> [15029.915511]  dump_backtrace+0x0/0x2c8
>>>> [15029.920046]  show_stack+0x24/0x30
>>>> [15029.923367]  dump_stack+0x118/0x19c
>>>> [15029.927539]  print_address_description+0x68/0x2a0
>>>> [15029.932245]  kasan_report+0x1b4/0x348
>>>> [15029.938760]  __asan_load2+0x7c/0xa0
>>>> [15029.945098]  selinux_sctp_bind_connect+0x60/0x150
>>>> 
>>>> [15029.950571]  security_sctp_bind_connect+0x58/0x90
>>>> [15029.955493]  __sctp_setsockopt_connectx+0x68/0x128 [sctp]
>>>> [15029.960943]  sctp_setsockopt+0x764/0x2928 [sctp]
>>>> [15029.965564]  sock_common_setsockopt+0x6c/0x80
>>>> [15029.969923]  __arm64_sys_setsockopt+0x13c/0x1f0
>>>> [15029.974456]  el0_svc_handler+0xd4/0x198
>>>> [15029.978293]  el0_svc+0x8/0xc
>>>> [15029.981174]
>>>> [15029.982667] Allocated by task 18081:
>>>> [15029.986245]  kasan_kmalloc.part.1+0x40/0x108
>>>> [15029.990517]  kasan_kmalloc+0xb4/0xc8
>>>> [15029.994094]  __kmalloc_node+0x1c4/0x638
>>>> [15029.997933]  kvmalloc_node+0x98/0xa8
>>>> [15030.001511]  vmemdup_user+0x34/0x128
>>>> [15030.005137]  __sctp_setsockopt_connectx+0x44/0x128 [sctp]
>>>> [15030.010586]  sctp_setsockopt+0x764/0x2928 [sctp]
>>>> [15030.015205]  sock_common_setsockopt+0x6c/0x80
>>>> [15030.019564]  __arm64_sys_setsockopt+0x13c/0x1f0
>>>> [15030.024096]  el0_svc_handler+0xd4/0x198
>>>> [15030.027933]  el0_svc+0x8/0xc
>>>> [15030.030814]
>>>> [15030.032306] Freed by task 3025:
>>>> [15030.035451]  __kasan_slab_free+0x114/0x228
>>>> [15030.039548]  kasan_slab_free+0x10/0x18
>>>> [15030.043299]  kfree+0x114/0x408
>>>> [15030.046357]  selinux_sk_free_security+0x38/0x48
>>>> [15030.050888]  security_sk_free+0x3c/0x58
>>>> [15030.054727]  __sk_destruct+0x3e8/0x570
>>>> [15030.058478]  sk_destruct+0x4c/0x58
>>>> [15030.061881]  __sk_free+0x68/0x138
>>>> [15030.065197]  sk_free+0x3c/0x48
>>>> [15030.068255]  unix_release_sock+0x4a8/0x550
>>>> [15030.072353]  unix_release+0x34/0x50
>>>> [15030.075843]  __sock_release+0x74/0x110
>>>> [15030.079593]  sock_close+0x24/0x38
>>>> [15030.082913]  __fput+0x1b8/0x368
>>>> [15030.086055]  ____fput+0x20/0x30
>>>> [15030.089199]  task_work_run+0x14c/0x1a8
>>>> [15030.092951]  do_notify_resume+0x1e4/0x200
>>>> [15030.096961]  work_pending+0x8/0x14
>>> 
>>> Any chance you have a reproducer for this?  Or at the very least a
>>> line number inside selinux_sctp_bind_connect()?
>>> 
>> Yes, running trinity as non-root will trigger it all the time on this
>> aarch64 server so far.
> 
> Is it just aarch64, or are you seeing it on other arches as well?
I only have an aarch64 server to test so far.
> 
>> $ trinity
>> 
>> https://github.com/kernelslacker/trinity.git
>> 
>> If you have a debug patch I am happy to try that as well if you
>> need to gather more information.
> 
> -- 
> paul moore
> www.paul-moore.com

