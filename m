Return-Path: <SRS0=Zaf8=NX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F03C43441
	for <selinux@archiver.kernel.org>; Mon, 12 Nov 2018 19:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AD822419
	for <selinux@archiver.kernel.org>; Mon, 12 Nov 2018 19:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1AD822419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbeKMFds convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:33:48 -0500
Received: from mout.gmx.net ([212.227.17.21]:45875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeKMFds (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 13 Nov 2018 00:33:48 -0500
Received: from [192.168.1.153] ([74.104.183.64]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0M6ioC-1falSi0xvQ-00wU9S; Mon, 12
 Nov 2018 20:39:00 +0100
From:   Qian Cai <cai@gmx.us>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: BUG: KASAN: slab-out-of-bounds in
 selinux_sctp_bind_connect+0x60/0x150
Message-Id: <53491A18-DD21-4E34-BC2F-AB449C7844E8@gmx.us>
Date:   Mon, 12 Nov 2018 14:38:56 -0500
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
To:     linux kernel <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.100.39)
X-Provags-ID: V03:K1:W31OApVa4iCaqiuh1lGc5K3sBHh7AJPxC1/RbnUfFtBnVJFqvWp
 Qw7t3uqNDresxmn2tcwOM/XkEzI5tsX5G9QEnN+b5KrkFBheP6S4XeeekdOXEmBA8tTiuyQ
 KRfXxwy+JmIfLZNFImhLu3kuKuc1OHJleySZI8PeKl/Hi1dTe6r1D/nn36yFw5w05Q28azD
 +gLpyRadwjURbK/iM5NGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w2y1lBYEzFc=:A8SFXIdkKqD+oVLpbAFFTD
 eq7U4ldnVnMMdcEo3c8+FhO/dHhvP+22qjGWFTwHkjiBG5GWmljkR/yOUmJhECUX3xLA4Cc6s
 BMWN2+K4zQdRg8s9QzrSix+u5RscmcJBUj1zr4i3qsw/MJlr/3NsoZHV9Ah3hvqo3nPyVEx10
 poahEOOJB+nSopu7ptdqB0R7dzhb91/NiPPrUNc9/cKIvfZJ15YQzDunvwKbmP66k/pqwWdC9
 XX9HKRuxm8Vs19UAtaJAUuPhn8EFhi8ybt+e01QMDtfA2Z37Kowe06MWICpYzoAos0t8Ukjwg
 Ad+E2jpbS/DNXUMRF5gX8Py+QlpW2Ih1t+uD4yeecvArxdDHj+e+uQH0Bx/IIZy2p6XOYONEO
 K+Y92WqufdQbl3IKJxQRg4BCSdhmqihCaidJCnRDi1HCAlPzvcxb9Vz3MPN9n2FqSclONV4ii
 ahWWs4CfRh3K6sNETd5VYD7CMphRRXCPw9F55DbiN4RbrbC/jSyh7lsWwrY7D+SR4nof8oB2W
 Eq5bO7kWjJYe/N5dW5x2sOKZpNEpvD+rPobwWgU/k5ssJrCozLftw06bRa2tzXgP+BCR9QI8g
 SxTLEh1GWYuzM7i+rxq1+OkmFK6W0giV1zsSsvK/V0rBzlgyfrloP+E9nxhBpfERJaSdT2hyY
 h8Y7vOIlNWonUz77BiI2IjeooIkWdSXUsTxBkQYC2fDq0012TlpRyhdbAa/W8JP6XS8e3o8Co
 8RogPAumqkCetjEqggOE781oixtBS29jpxo7Xtd+qd1RFgNh+VyG2Fz+fJjTBG/GyQcCb2cbF
 Jkx0O3UpwX4lhblq9mbFazxhsGuS0X55IpkZbDuTUZZKsxW4wyX0I3aQfNsQ95Zl521bWcc2H
 rRUwQ0+VEOPtecbEbXRFXCOF7uzV/22xu+Gx9Z4qdRjVydjawD53gRnzGCsn0T
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Running the trinity fuzzer on the latest mainline (rc2) generates this,

[15029.879626] BUG: KASAN: slab-out-of-bounds in selinux_sctp_bind_connect+0x60/0x150
[15029.887275] Read of size 2 at addr ffff801ec53c5080 by task trinity-main/18081
[15029.887294] 
[15029.887304] CPU: 28 PID: 18081 Comm: trinity-main Tainted: G        W  OE     4.20.0-rc2+ #15
[15029.887311] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.50 06/01/2018
[15000.084786] [15029.887320] Call trace:
[15029.915511]  dump_backtrace+0x0/0x2c8
[15029.920046]  show_stack+0x24/0x30
[15029.923367]  dump_stack+0x118/0x19c
[15029.927539]  print_address_description+0x68/0x2a0
[15029.932245]  kasan_report+0x1b4/0x348
[15029.938760]  __asan_load2+0x7c/0xa0
[15029.945098]  selinux_sctp_bind_connect+0x60/0x150

[15029.950571]  security_sctp_bind_connect+0x58/0x90
[15029.955493]  __sctp_setsockopt_connectx+0x68/0x128 [sctp]
[15029.960943]  sctp_setsockopt+0x764/0x2928 [sctp]
[15029.965564]  sock_common_setsockopt+0x6c/0x80
[15029.969923]  __arm64_sys_setsockopt+0x13c/0x1f0
[15029.974456]  el0_svc_handler+0xd4/0x198
[15029.978293]  el0_svc+0x8/0xc
[15029.981174] 
[15029.982667] Allocated by task 18081:
[15029.986245]  kasan_kmalloc.part.1+0x40/0x108
[15029.990517]  kasan_kmalloc+0xb4/0xc8
[15029.994094]  __kmalloc_node+0x1c4/0x638
[15029.997933]  kvmalloc_node+0x98/0xa8
[15030.001511]  vmemdup_user+0x34/0x128
[15030.005137]  __sctp_setsockopt_connectx+0x44/0x128 [sctp]
[15030.010586]  sctp_setsockopt+0x764/0x2928 [sctp]
[15030.015205]  sock_common_setsockopt+0x6c/0x80
[15030.019564]  __arm64_sys_setsockopt+0x13c/0x1f0
[15030.024096]  el0_svc_handler+0xd4/0x198
[15030.027933]  el0_svc+0x8/0xc
[15030.030814] 
[15030.032306] Freed by task 3025:
[15030.035451]  __kasan_slab_free+0x114/0x228
[15030.039548]  kasan_slab_free+0x10/0x18
[15030.043299]  kfree+0x114/0x408
[15030.046357]  selinux_sk_free_security+0x38/0x48
[15030.050888]  security_sk_free+0x3c/0x58
[15030.054727]  __sk_destruct+0x3e8/0x570
[15030.058478]  sk_destruct+0x4c/0x58
[15030.061881]  __sk_free+0x68/0x138
[15030.065197]  sk_free+0x3c/0x48
[15030.068255]  unix_release_sock+0x4a8/0x550
[15030.072353]  unix_release+0x34/0x50
[15030.075843]  __sock_release+0x74/0x110
[15030.079593]  sock_close+0x24/0x38
[15030.082913]  __fput+0x1b8/0x368
[15030.086055]  ____fput+0x20/0x30
[15030.089199]  task_work_run+0x14c/0x1a8
[15030.092951]  do_notify_resume+0x1e4/0x200
[15030.096961]  work_pending+0x8/0x14
[15030.100363] 
[15030.101856] The buggy address belongs to the object at ffff801ec53c5080
[15030.101856]  which belongs to the cache kmalloc-128 of size 128
[15030.114376] The buggy address is located 0 bytes inside of
[15030.114376]  128-byte region [ffff801ec53c5080, ffff801ec53c5100)
[15030.125939] The buggy address belongs to the page:
[15030.130732] page:ffff7fe007b14f00 count:1 mapcount:0 mapping:ffff8016c0010480 index:0x0
[15030.138738] flags: 0x5fffff0000000200(slab)
[15030.142926] raw: 5fffff0000000200 ffff7fe007980608 ffff801ec000fd60 ffff8016c0010480
[15030.150671] raw: 0000000000000000 0000000000660066 00000001ffffffff 0000000000000000
[15030.158413] page dumped because: kasan: bad access detected
[15030.163984] 
[15030.165476] Memory state around the buggy address:
[15030.170269]  ffff801ec53c4f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[15030.177491]  ffff801ec53c5000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[15030.184714] >ffff801ec53c5080: 01 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[15030.191934]                    ^
[15030.195164]  ffff801ec53c5100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[15030.202386]  ffff801ec53c5180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[15030.209607] ==================================================================
[15030.216828] Disabling lock debugging due to kernel taint
