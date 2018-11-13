Return-Path: <SRS0=smjq=NY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDEEC43441
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 01:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CCB224E0
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 01:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92CCB224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeKMK5t convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:57:49 -0500
Received: from mout.gmx.net ([212.227.17.20]:49589 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbeKMK5t (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 13 Nov 2018 05:57:49 -0500
Received: from [192.168.1.153] ([74.104.183.64]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MH4Os-1gHPEa0wkc-00DpKQ; Tue, 13
 Nov 2018 01:59:02 +0100
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: BUG: KASAN: slab-out-of-bounds in
 selinux_sctp_bind_connect+0x60/0x150
From:   Qian Cai <cai@gmx.us>
In-Reply-To: <CAHC9VhTiCPwQ51ciexRCp4M5rN2C=pTm=anRaMgTsZ9coX96Zw@mail.gmail.com>
Date:   Mon, 12 Nov 2018 19:58:57 -0500
Cc:     linux kernel <linux-kernel@vger.kernel.org>,
        selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <7DE35AF4-20E1-4402-9B5A-4D8AACE15D56@gmx.us>
References: <53491A18-DD21-4E34-BC2F-AB449C7844E8@gmx.us>
 <CAHC9VhTiCPwQ51ciexRCp4M5rN2C=pTm=anRaMgTsZ9coX96Zw@mail.gmail.com>
To:     Paul Moore <paul@paul-moore.com>
X-Mailer: Apple Mail (2.3445.100.39)
X-Provags-ID: V03:K1:9MoOqgNYEfq5x98DZk3Vl1660v0OZa3Afk6wWOuXtUjLIfJd+eF
 2vS1rpo3cs7iJD9jQ23ePE98sgTzB4jNepJAl/20B+Kv3paJIsrkJMgv7UdOX21JrvgnofG
 KzD2KfhSkWPis8IaVoRN8xDAakdQSmtUY1FN8LKwd4ETHdYGxubn06LdsVtd9NkfDmqG2vj
 eKhQ10ejg+YcQe1C43Lug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JP0qzaoz7KI=:GJ6+d8a1ISXxGS15XQ915C
 DtP30yrHVNeSh7L0fOiICgTmy1E2vknfJoJey5XGHNzZofdCwpPMKsABrpTMjpWNT6ULJKheU
 02s+vbkA6IA0HOLLnXfz+7BE/XGIxNgXaKwsU55ssRkQIMK+Nm+ZHLU0gu3DizHAudq9yH6TT
 Kjta6pnoUklTJE/Illc572UF6XE6sjdp/iTpQR4LI0j3BXD2M9CmtKWZ+WljAPLF45xAT+hBx
 ojcULKhH0K6w7lRYSEV4Pu9PERIeCBzmY0XGvkFF8XddJk5SAf0QGRLcfGHT6s5Dlqgq/Dd26
 3UaLaTPHRjaWX6xSmUUDqoFu25cw2F/av6/X1xJ8ChgK84yxtMXFqw57zfCtPbZnuF7aTfcFq
 QGUb0xU0Zjw/J9tmesdow4db/H3M6Alnkb8selRXK26tBXOMjkDAZfa5wd+5cLw6wYR1NvGtu
 HNYzppUUcv39RveSilQAD83LAQC/wbyV9TAkeyH8oij6e/m6KAg3jbLVYGcvAg1VT8YJ6e7EH
 OCIiRY86DfGkuFnA4EGV/2DcbD9uEQ5w8f+rvsrc/uF6fyWTff0RVU53BYoP7lPL+YEpo8lwA
 xyZwUssdu0ahmHxYj0KJOXwC7ZwZbBtgnhVST8nGx7V68x26kmp4AyeQArD49PXkJZVCdwDAb
 NvGFKwE+kyfyIJ0qe4D0RCFyoMTFAekZA91sjgJzRg3dqlcZaAgKSTcnYocjP71KmIxgUqj8s
 V9DRxfhLjL+YFgBx8JsVittFFqw7YPwSrLgCeTahosA6O4ZOP5wrcdsNj1S1mKozrWwEJGe1S
 YNRV/HIq7Sg1A5ab4Gw6c7MincolDlmKkDxDaA0h1TbklpZHbkcijQNNv2p6Elbq+qv+rsId6
 eQPx8F1MCfjJMUMF531eM6paBgTbRsOJeedDTOjz0M0AAhsFQ1UJvwX2vKwnol
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



> On Nov 12, 2018, at 7:41 PM, Paul Moore <paul@paul-moore.com> wrote:
> 
> On Mon, Nov 12, 2018 at 2:39 PM Qian Cai <cai@gmx.us> wrote:
>> 
>> Running the trinity fuzzer on the latest mainline (rc2) generates this,
>> 
>> [15029.879626] BUG: KASAN: slab-out-of-bounds in selinux_sctp_bind_connect+0x60/0x150
>> [15029.887275] Read of size 2 at addr ffff801ec53c5080 by task trinity-main/18081
>> [15029.887294]
>> [15029.887304] CPU: 28 PID: 18081 Comm: trinity-main Tainted: G        W  OE     4.20.0-rc2+ #15
>> [15029.887311] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.50 06/01/2018
>> [15000.084786] [15029.887320] Call trace:
>> [15029.915511]  dump_backtrace+0x0/0x2c8
>> [15029.920046]  show_stack+0x24/0x30
>> [15029.923367]  dump_stack+0x118/0x19c
>> [15029.927539]  print_address_description+0x68/0x2a0
>> [15029.932245]  kasan_report+0x1b4/0x348
>> [15029.938760]  __asan_load2+0x7c/0xa0
>> [15029.945098]  selinux_sctp_bind_connect+0x60/0x150
>> 
>> [15029.950571]  security_sctp_bind_connect+0x58/0x90
>> [15029.955493]  __sctp_setsockopt_connectx+0x68/0x128 [sctp]
>> [15029.960943]  sctp_setsockopt+0x764/0x2928 [sctp]
>> [15029.965564]  sock_common_setsockopt+0x6c/0x80
>> [15029.969923]  __arm64_sys_setsockopt+0x13c/0x1f0
>> [15029.974456]  el0_svc_handler+0xd4/0x198
>> [15029.978293]  el0_svc+0x8/0xc
>> [15029.981174]
>> [15029.982667] Allocated by task 18081:
>> [15029.986245]  kasan_kmalloc.part.1+0x40/0x108
>> [15029.990517]  kasan_kmalloc+0xb4/0xc8
>> [15029.994094]  __kmalloc_node+0x1c4/0x638
>> [15029.997933]  kvmalloc_node+0x98/0xa8
>> [15030.001511]  vmemdup_user+0x34/0x128
>> [15030.005137]  __sctp_setsockopt_connectx+0x44/0x128 [sctp]
>> [15030.010586]  sctp_setsockopt+0x764/0x2928 [sctp]
>> [15030.015205]  sock_common_setsockopt+0x6c/0x80
>> [15030.019564]  __arm64_sys_setsockopt+0x13c/0x1f0
>> [15030.024096]  el0_svc_handler+0xd4/0x198
>> [15030.027933]  el0_svc+0x8/0xc
>> [15030.030814]
>> [15030.032306] Freed by task 3025:
>> [15030.035451]  __kasan_slab_free+0x114/0x228
>> [15030.039548]  kasan_slab_free+0x10/0x18
>> [15030.043299]  kfree+0x114/0x408
>> [15030.046357]  selinux_sk_free_security+0x38/0x48
>> [15030.050888]  security_sk_free+0x3c/0x58
>> [15030.054727]  __sk_destruct+0x3e8/0x570
>> [15030.058478]  sk_destruct+0x4c/0x58
>> [15030.061881]  __sk_free+0x68/0x138
>> [15030.065197]  sk_free+0x3c/0x48
>> [15030.068255]  unix_release_sock+0x4a8/0x550
>> [15030.072353]  unix_release+0x34/0x50
>> [15030.075843]  __sock_release+0x74/0x110
>> [15030.079593]  sock_close+0x24/0x38
>> [15030.082913]  __fput+0x1b8/0x368
>> [15030.086055]  ____fput+0x20/0x30
>> [15030.089199]  task_work_run+0x14c/0x1a8
>> [15030.092951]  do_notify_resume+0x1e4/0x200
>> [15030.096961]  work_pending+0x8/0x14
> 
> Any chance you have a reproducer for this?  Or at the very least a
> line number inside selinux_sctp_bind_connect()?
> 
Yes, running trinity as non-root will trigger it all the time on this
aarch64 server so far.

$ trinity

https://github.com/kernelslacker/trinity.git

If you have a debug patch I am happy to try that as well if you
need to gather more information.
