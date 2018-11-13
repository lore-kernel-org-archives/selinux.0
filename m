Return-Path: <SRS0=smjq=NY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E44C43441
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 19:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A07C22419
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 19:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A07C22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbeKNFUi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:20:38 -0500
Received: from mout.gmx.net ([212.227.17.22]:56789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725750AbeKNFUi (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 14 Nov 2018 00:20:38 -0500
Received: from dhcp-41-57.bos.redhat.com ([66.187.233.206]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MVrQS-1fyVh13j7g-00WzyG; Tue, 13 Nov 2018 20:20:48 +0100
Message-ID: <1542136842.12945.21.camel@gmx.us>
Subject: Re: [PATCH] selinux: check length properly in SCTP bind hook
From:   Qian Cai <cai@gmx.us>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Richard Haines <richard_c_haines@btinternet.com>
Date:   Tue, 13 Nov 2018 14:20:42 -0500
In-Reply-To: <20181113151608.30424-1-omosnace@redhat.com>
References: <53491A18-DD21-4E34-BC2F-AB449C7844E8@gmx.us>
         <20181113151608.30424-1-omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zcjtEz72YNHgGW3khJ6TPsUfoyMSwiZTC0PJB1EoN7NoP7mSBTI
 1+5coXpIpc6T8ZLa1BjLT2gkQx+C9ttuLVBevnLm1Dpddb+JCx+/y8wnHr7jmiYgC+0tsFQ
 oLlWdFjYZu5rXYLvvEURnrVQx0Sau1jzAvNZmc815wuHwypWkq6DwKtjZH3u0Fxaym/Vfqu
 evWzNAquKs2LfudvqyjJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Yfqn9UQoyGY=:jjRCPrwgW2YRXii832Chra
 Dj3//5/l2DW/b+O1eDe54P5SFsA+DfUU7/Y9JIK1VpA/fPYD+BJ9akEtUvPWweV0kgWhy0P2L
 JwTs77mKSzNNUzrG823bIXXFdq62OZz8kQHFjcDbysAReVr7gr8OTsKY4fh9FSKvwXp2WqNxH
 fKiYFDfrjohIPy7sV2+NOlLidO8+XtGzc3A7G8eu1cVLxLEO2zzqlL+yRg5tFY74TQkfUl9rl
 uTzcx/tHY71n5zsBO1b3rvSFXSKf1f51NvAKvfibRtGm1cnZLzR9Vwk3xEydT1LdTcNpSHqYB
 vW2qSx0QF3fPBT11dcBb0O9kEKd6w4pDDCns5n86aMJMGnNikaxCMCzRkYfMkjTPcLGE2g4Q1
 C9o7QRXSA/tv0RTVOZpO6431mfARZ4prWHKEJ1hD8lRZL4NvG99yaOLY2EzYVCkEPcHg51QAE
 DFVYZbUsEUmhJ8eyidH8B95DF0AqDgfeosi4enUso1i5lezuTu9Nme4IJo5W/cHQ56rqpVXHz
 el2mIsK7g+ivoLaZyzKrPd5FlCeGp/w5ad5Wej7nsyXDxDdZydrvxuD17RmMnWihUd3Zc2yH3
 To+MpDBhNmCNTXaSuqpkCrTFJdZ/N2RCU1q1w0WUUqI2urxWvBlYnDOq+tKZZd2myBGEjx4yk
 mPmZ/FwbETBoFKhwV2UZws+Ykzyhob4/QL59q2V02AF9rLeY5R9t0p/vCUHm/Vq37V76QblNH
 YJYi4ymsx7yZQAmbugWlE6EkSJd7U3zxhVvGwb+fK7AllCYHdN5erpu0T1poWp93kLntU/iwW
 laH3JFHLLQjXuD8U0V1DTYZvTliv8AWKT02xxk0NDD5DScV6Wvz2uhHX+HE+7g+fg9kRSAqnI
 ccK0T+pODhypkUnW3ln6MC/eXNlyhppRARBG3RAl4dDB1KKvqWrqnGsp6MPDli
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2018-11-13 at 16:16 +0100, Ondrej Mosnacek wrote:
> selinux_sctp_bind_connect() must verify if the address buffer has
> sufficient length before accessing the 'sa_family' field. See
> __sctp_connect() for a similar check.
> 
> The length of the whole address ('len') is already checked in the
> callees.
> 
> Reported-by: Qian Cai <cai@gmx.us>
> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> Cc: <stable@vger.kernel.org> # 4.17+
> Cc: Richard Haines <richard_c_haines@btinternet.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Tested-by: Qian Cai <cai@gmx.us>
> ---
> Hi,
> 
> On Mon, Nov 12, 2018 at 8:39 PM Qian Cai <cai@gmx.us> wrote:
> > Running the trinity fuzzer on the latest mainline (rc2) generates this,
> > 
> > [15029.879626] BUG: KASAN: slab-out-of-bounds in
> > selinux_sctp_bind_connect+0x60/0x150
> > [15029.887275] Read of size 2 at addr ffff801ec53c5080 by task trinity-
> > main/18081
> > [15029.887294] 
> > [15029.887304] CPU: 28 PID: 18081 Comm: trinity-main Tainted:
> > G        W  OE     4.20.0-rc2+ #15
> > [15029.887311] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.50
> > 06/01/2018
> > [15000.084786] [15029.887320] Call trace:
> > [15029.915511]  dump_backtrace+0x0/0x2c8
> > [15029.920046]  show_stack+0x24/0x30
> > [15029.923367]  dump_stack+0x118/0x19c
> > [15029.927539]  print_address_description+0x68/0x2a0
> > [15029.932245]  kasan_report+0x1b4/0x348
> > [15029.938760]  __asan_load2+0x7c/0xa0
> > [15029.945098]  selinux_sctp_bind_connect+0x60/0x150
> > 
> > [15029.950571]  security_sctp_bind_connect+0x58/0x90
> > [15029.955493]  __sctp_setsockopt_connectx+0x68/0x128 [sctp]
> > [15029.960943]  sctp_setsockopt+0x764/0x2928 [sctp]
> > [15029.965564]  sock_common_setsockopt+0x6c/0x80
> > [15029.969923]  __arm64_sys_setsockopt+0x13c/0x1f0
> > [15029.974456]  el0_svc_handler+0xd4/0x198
> > [15029.978293]  el0_svc+0x8/0xc
> > [15029.981174] 
> > [15029.982667] Allocated by task 18081:
> > [15029.986245]  kasan_kmalloc.part.1+0x40/0x108
> > [15029.990517]  kasan_kmalloc+0xb4/0xc8
> > [15029.994094]  __kmalloc_node+0x1c4/0x638
> > [15029.997933]  kvmalloc_node+0x98/0xa8
> > [15030.001511]  vmemdup_user+0x34/0x128
> > [15030.005137]  __sctp_setsockopt_connectx+0x44/0x128 [sctp]
> > [15030.010586]  sctp_setsockopt+0x764/0x2928 [sctp]
> > [15030.015205]  sock_common_setsockopt+0x6c/0x80
> > [15030.019564]  __arm64_sys_setsockopt+0x13c/0x1f0
> > [15030.024096]  el0_svc_handler+0xd4/0x198
> > [15030.027933]  el0_svc+0x8/0xc
> > [15030.030814] 
> > [15030.032306] Freed by task 3025:
> > [15030.035451]  __kasan_slab_free+0x114/0x228
> > [15030.039548]  kasan_slab_free+0x10/0x18
> > [15030.043299]  kfree+0x114/0x408
> > [15030.046357]  selinux_sk_free_security+0x38/0x48
> > [15030.050888]  security_sk_free+0x3c/0x58
> > [15030.054727]  __sk_destruct+0x3e8/0x570
> > [15030.058478]  sk_destruct+0x4c/0x58
> > [15030.061881]  __sk_free+0x68/0x138
> > [15030.065197]  sk_free+0x3c/0x48
> > [15030.068255]  unix_release_sock+0x4a8/0x550
> > [15030.072353]  unix_release+0x34/0x50
> > [15030.075843]  __sock_release+0x74/0x110
> > [15030.079593]  sock_close+0x24/0x38
> > [15030.082913]  __fput+0x1b8/0x368
> > [15030.086055]  ____fput+0x20/0x30
> > [15030.089199]  task_work_run+0x14c/0x1a8
> > [15030.092951]  do_notify_resume+0x1e4/0x200
> > [15030.096961]  work_pending+0x8/0x14
> > [15030.100363] 
> > [15030.101856] The buggy address belongs to the object at ffff801ec53c5080
> > [15030.101856]  which belongs to the cache kmalloc-128 of size 128
> > [15030.114376] The buggy address is located 0 bytes inside of
> > [15030.114376]  128-byte region [ffff801ec53c5080, ffff801ec53c5100)
> > [15030.125939] The buggy address belongs to the page:
> > [15030.130732] page:ffff7fe007b14f00 count:1 mapcount:0
> > mapping:ffff8016c0010480 index:0x0
> > [15030.138738] flags: 0x5fffff0000000200(slab)
> > [15030.142926] raw: 5fffff0000000200 ffff7fe007980608 ffff801ec000fd60
> > ffff8016c0010480
> > [15030.150671] raw: 0000000000000000 0000000000660066 00000001ffffffff
> > 0000000000000000
> > [15030.158413] page dumped because: kasan: bad access detected
> > [15030.163984] 
> > [15030.165476] Memory state around the buggy address:
> > [15030.170269]  ffff801ec53c4f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > fc fc
> > [15030.177491]  ffff801ec53c5000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > fc fc
> > [15030.184714] >ffff801ec53c5080: 01 fc fc fc fc fc fc fc fc fc fc fc fc fc
> > fc fc
> > [15030.191934]                    ^
> > [15030.195164]  ffff801ec53c5100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > fc fc
> > [15030.202386]  ffff801ec53c5180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > fc fc
> > [15030.209607]
> > ==================================================================
> > [15030.216828] Disabling lock debugging due to kernel taint
> 
> I think I found the cause - Qian, can you test this patch if it fixes
> the problem?
> 
>  security/selinux/hooks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7ce683259357..a67459eb62d5 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5318,6 +5318,9 @@ static int selinux_sctp_bind_connect(struct sock *sk,
> int optname,
>  	addr_buf = address;
>  
>  	while (walk_size < addrlen) {
> +		if (walk_size + sizeof(sa_family_t) > addrlen)
> +			return -EINVAL;
> +
>  		addr = addr_buf;
>  		switch (addr->sa_family) {
>  		case AF_UNSPEC:
