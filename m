Return-Path: <SRS0=smjq=NY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473D8C43441
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 13:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06640206BA
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 13:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06640206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733153AbeKMXvT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:51:19 -0500
Received: from mout.gmx.net ([212.227.17.22]:54927 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732959AbeKMXvT (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 13 Nov 2018 18:51:19 -0500
Received: from [74.104.183.64] ([74.104.183.64]) by
 msvc-mesg-gmx021.server.lan (via HTTP); Tue, 13 Nov 2018 14:52:43 +0100
MIME-Version: 1.0
Message-ID: <trinity-0b0183f4-440a-4989-9b0d-73986f051600-1542117163088@msvc-mesg-gmx021>
From:   "Qian Cai" <cai@gmx.us>
To:     "Paul Moore" <paul@paul-moore.com>
Cc:     "Eric Paris" <eparis@parisplace.org>, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org, "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: BUG: KASAN: slab-out-of-bounds in
 selinux_sctp_bind_connect+0x60/0x150
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 13 Nov 2018 14:52:43 +0100
In-Reply-To: <CAHC9VhS6UuYa_z_T04DddoGS3WhTnv4G3b_DdoEeipcJgqjziw@mail.gmail.com>
References: <53491A18-DD21-4E34-BC2F-AB449C7844E8@gmx.us>
 <CAHC9VhTiCPwQ51ciexRCp4M5rN2C=pTm=anRaMgTsZ9coX96Zw@mail.gmail.com>
 <7DE35AF4-20E1-4402-9B5A-4D8AACE15D56@gmx.us>
 <CAHC9VhRODL9JYjJ3QpExMaztA3PFv_Z1t=Q=4K8QMtJh7ntVuw@mail.gmail.com>
 <989F5A08-F283-4BB7-B3D9-67E25EE05F69@gmx.us>
 <CAHC9VhS6UuYa_z_T04DddoGS3WhTnv4G3b_DdoEeipcJgqjziw@mail.gmail.com>
X-Provags-ID: V03:K1:S3LDBzm3xgoOgwuMtu4oyOYGef5CBWiFDPudzpS9IOBM7y7bXW/i0VBeLoJcMhfm/+gWQ
 th9LD4gY/EBrQ11eqQz6bdoYrW8YCai4cGzPoTRuqD5OngCjrZKwiRzzRfXporinC3V7KryfNfkx
 e3Z2FOknu3GSN1fYyv0ToE6vPmbe7CvXfUxjAZWfcYp2ALStFN7oozNIU4jA0UScj/ZsYmMo0Aoc
 WLUEO7ECiBWcvmB77UTnmuIZBu+vcJdTXBl6MKAjxMMNzaMPW0K4eiygV03aL+M1E//Mt9c+xnt6
 /4ZOUq7hS8veiQyTPVE76tX
X-UI-Out-Filterresults: notjunk:1;V01:K0:i1F9HhRQ6FQ=:brKe3M80UP+5U4DIeIVWLm
 uZtEJkbb/S+m2X/6T023TGjcwJrPUdyC72pQx/2T8NY+/Ma+14eAx74xnT+P90q84hpcCb7Wa
 SrPVLhvrSc6WTfMZdX4ADEkp8hGDwg+Jn+o9Hkb8BESrEyLAomrjzw3BzRO9JVd1EA32lRmEz
 52KF6RxaljCUgOHDMPidCrMPMXRnlQa2wEiSfVFdNI5CI8+yzZ0vnZP1dGwmz2QijdtkQYdos
 r3r+AoXtnnm0lLmXLDRuC8RuKUkQExn2fmdgE6ULXC+NyoihBI5rHnPsT7RlSm+A3iyKAspvB
 phEzj1k2NI5SllnbT/WIlfr5KSydlbM38+lRRDNLo/TEqZYVQgJU1tmkRVH/GjO/IHGtti3pc
 N/ZWZeAOBIJ2GA0ANBvkRPSUa2JV4x6kxIVrXbjf0/a5P0hLlovpzyGYuwXMzzTELKDrk4C/l
 M8j+cAxPBo1lGMOzl8tfAXD0yW6/qCw3SiF/zUJc5l+psVQdXsIRrT6G3pyx1rkds1l+UJtRN
 HafcXqcZJjCC++SCdccd7UPuI9nZiKhUy8TXczQ61Ebee7442qqYgN3LWufLZ0l81QKB5uEX5
 p9PjSgEPwzkh0jF51qpc9Aw3zmhZ8CyyA+kL4qzrD2iHdj9IKAoOTaZh6a711SPQreS9RuSj7
 VY0gtRTieaT5hRFTHMmCBPCnXZGrQ4lNDfsDwXqwD30+3v3q8ClEdHnYUxkocH/rUkml+DQFW
 XL3hA75SHqGdzvq4vQrz6efgBHdzaDMEBwNCa2ZKdQfsgves430aJt32PtU=
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/13/18 at 8:33 AM, Paul Moore wrote:

> On Mon, Nov 12, 2018 at 10:11 PM Qian Cai <cai@gmx.us> wrote:
> > > On Nov 12, 2018, at 10:09 PM, Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On Mon, Nov 12, 2018 at 7:59 PM Qian Cai <cai@gmx.us> wrote:
> > >>> On Nov 12, 2018, at 7:41 PM, Paul Moore <paul@paul-moore.com> wrote:
> > >>> On Mon, Nov 12, 2018 at 2:39 PM Qian Cai <cai@gmx.us> wrote:
> > >>>>
> > >>>> Running the trinity fuzzer on the latest mainline (rc2) generates this,
> > >>>>
> > >>>> [15029.879626] BUG: KASAN: slab-out-of-bounds in selinux_sctp_bind_connect+0x60/0x150
> > >>>> [15029.887275] Read of size 2 at addr ffff801ec53c5080 by task trinity-main/18081
> > >>>> [15029.887294]
> > >>>> [15029.887304] CPU: 28 PID: 18081 Comm: trinity-main Tainted: G        W  OE     4.20.0-rc2+ #15
> > >>>> [15029.887311] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.50 06/01/2018
> > >>>> [15000.084786] [15029.887320] Call trace:
> > >>>> [15029.915511]  dump_backtrace+0x0/0x2c8
> > >>>> [15029.920046]  show_stack+0x24/0x30
> > >>>> [15029.923367]  dump_stack+0x118/0x19c
> > >>>> [15029.927539]  print_address_description+0x68/0x2a0
> > >>>> [15029.932245]  kasan_report+0x1b4/0x348
> > >>>> [15029.938760]  __asan_load2+0x7c/0xa0
> > >>>> [15029.945098]  selinux_sctp_bind_connect+0x60/0x150
> > >>>>
> > >>>> [15029.950571]  security_sctp_bind_connect+0x58/0x90
> > >>>> [15029.955493]  __sctp_setsockopt_connectx+0x68/0x128 [sctp]
> > >>>> [15029.960943]  sctp_setsockopt+0x764/0x2928 [sctp]
> > >>>> [15029.965564]  sock_common_setsockopt+0x6c/0x80
> > >>>> [15029.969923]  __arm64_sys_setsockopt+0x13c/0x1f0
> > >>>> [15029.974456]  el0_svc_handler+0xd4/0x198
> > >>>> [15029.978293]  el0_svc+0x8/0xc
> > >>>> [15029.981174]
> > >>>> [15029.982667] Allocated by task 18081:
> > >>>> [15029.986245]  kasan_kmalloc.part.1+0x40/0x108
> > >>>> [15029.990517]  kasan_kmalloc+0xb4/0xc8
> > >>>> [15029.994094]  __kmalloc_node+0x1c4/0x638
> > >>>> [15029.997933]  kvmalloc_node+0x98/0xa8
> > >>>> [15030.001511]  vmemdup_user+0x34/0x128
> > >>>> [15030.005137]  __sctp_setsockopt_connectx+0x44/0x128 [sctp]
> > >>>> [15030.010586]  sctp_setsockopt+0x764/0x2928 [sctp]
> > >>>> [15030.015205]  sock_common_setsockopt+0x6c/0x80
> > >>>> [15030.019564]  __arm64_sys_setsockopt+0x13c/0x1f0
> > >>>> [15030.024096]  el0_svc_handler+0xd4/0x198
> > >>>> [15030.027933]  el0_svc+0x8/0xc
> > >>>> [15030.030814]
> > >>>> [15030.032306] Freed by task 3025:
> > >>>> [15030.035451]  __kasan_slab_free+0x114/0x228
> > >>>> [15030.039548]  kasan_slab_free+0x10/0x18
> > >>>> [15030.043299]  kfree+0x114/0x408
> > >>>> [15030.046357]  selinux_sk_free_security+0x38/0x48
> > >>>> [15030.050888]  security_sk_free+0x3c/0x58
> > >>>> [15030.054727]  __sk_destruct+0x3e8/0x570
> > >>>> [15030.058478]  sk_destruct+0x4c/0x58
> > >>>> [15030.061881]  __sk_free+0x68/0x138
> > >>>> [15030.065197]  sk_free+0x3c/0x48
> > >>>> [15030.068255]  unix_release_sock+0x4a8/0x550
> > >>>> [15030.072353]  unix_release+0x34/0x50
> > >>>> [15030.075843]  __sock_release+0x74/0x110
> > >>>> [15030.079593]  sock_close+0x24/0x38
> > >>>> [15030.082913]  __fput+0x1b8/0x368
> > >>>> [15030.086055]  ____fput+0x20/0x30
> > >>>> [15030.089199]  task_work_run+0x14c/0x1a8
> > >>>> [15030.092951]  do_notify_resume+0x1e4/0x200
> > >>>> [15030.096961]  work_pending+0x8/0x14
> > >>>
> > >>> Any chance you have a reproducer for this?  Or at the very least a
> > >>> line number inside selinux_sctp_bind_connect()?
> > >>>
> > >> Yes, running trinity as non-root will trigger it all the time on this
> > >> aarch64 server so far.
> > >
> > > Is it just aarch64, or are you seeing it on other arches as well?
> >
> > I only have an aarch64 server to test so far.
> 
> Did you see similar problems with 4.20-rc1?
I did not test on -rc1.
> 
> > >> $ trinity
> > >>
> > >> https://github.com/kernelslacker/trinity.git
> > >>
> > >> If you have a debug patch I am happy to try that as well if you
> > >> need to gather more information.
> 
> -- 
> paul moore
> www.paul-moore.com
