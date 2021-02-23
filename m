Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B61C433DB
	for <selinux@archiver.kernel.org>; Tue, 23 Feb 2021 21:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C004064EAD
	for <selinux@archiver.kernel.org>; Tue, 23 Feb 2021 21:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhBWVvn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Feb 2021 16:51:43 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59696 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhBWVvj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Feb 2021 16:51:39 -0500
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2BF8920B57A0;
        Tue, 23 Feb 2021 13:50:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2BF8920B57A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614117056;
        bh=/FDgRyczYUTc1V/w1Z6FW2alV0DNZbytQBsd3UGv5GQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YOYoCrdvwpm2mjTzt1POBUKtveAp2lVOBu0GfubFrNkirQi+MDPCQ3EmnNnCcnBMm
         LpWH/LzQRfpSkSkUILBFH667ao2pVWtADS0kvExhpHKJqd/7zHPVAnyysVIhLxTKBR
         iUlZorcl0J3EJrCWhIOWUzjJ4G5U6eEjJfl4XkkI=
Date:   Tue, 23 Feb 2021 15:50:54 -0600
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Race between policy reload sidtab conversion and live
 conversion
Message-ID: <20210223215054.GC6000@sequoia>
References: <20210223214346.GB6000@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223214346.GB6000@sequoia>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2021-02-23 15:43:48, Tyler Hicks wrote:
> I'm seeing a race during policy load while the "regular" sidtab
> conversion is happening and a live conversion starts to take place in
> sidtab_context_to_sid().
> 
> We have an initial policy that's loaded by systemd ~0.6s into boot and
> then another policy gets loaded ~2-3s into boot. That second policy load
> is what hits the race condition situation because the sidtab is only
> partially populated and there's a decent amount of filesystem operations
> happening, at the same time, which are triggering live conversions.

Here are the relevant messages written to the ring buffer showing the initial
policy load, the second policy load, the sidtab conversion starting, and then
the stack trace:

[    0.112159] SELinux:  Initializing.
...
[    0.624107] audit: type=1404 audit(0.492:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295 enabled=1 old-enabled=1 lsm=selinux res=1
[    0.664063] SELinux:  Permission perfmon in class capability2 not defined in policy.
[    0.664068] SELinux:  Permission bpf in class capability2 not defined in policy.
[    0.664070] SELinux:  Permission checkpoint_restore in class capability2 not defined in policy.
[    0.664077] SELinux:  Permission perfmon in class cap2_userns not defined in policy.
[    0.664079] SELinux:  Permission bpf in class cap2_userns not defined in policy.
[    0.664080] SELinux:  Permission checkpoint_restore in class cap2_userns not defined in policy.
[    0.664114] SELinux:  Class perf_event not defined in policy.
[    0.664115] SELinux:  Class lockdown not defined in policy.
[    0.664117] SELinux: the above unknown classes and permissions will be allowed
[    0.667863] SELinux:  policy capability network_peer_controls=1
[    0.667866] SELinux:  policy capability open_perms=1
[    0.667867] SELinux:  policy capability extended_socket_class=1
[    0.667868] SELinux:  policy capability always_check_network=0
[    0.667870] SELinux:  policy capability cgroup_seclabel=1
[    0.667871] SELinux:  policy capability nnp_nosuid_transition=1
[    0.667873] SELinux:  policy capability genfs_seclabel_symlinks=0
[    0.712152] audit: type=1403 audit(0.584:3): auid=4294967295 ses=4294967295 lsm=selinux res=1
[    0.714430] systemd[1]: Successfully loaded SELinux policy in 91.004ms.
...
[    3.042735] SELinux:  Permission perfmon in class capability2 not defined in policy.
[    3.042741] SELinux:  Permission bpf in class capability2 not defined in policy.
[    3.042743] SELinux:  Permission checkpoint_restore in class capability2 not defined in policy.
[    3.042750] SELinux:  Permission perfmon in class cap2_userns not defined in policy.
[    3.042751] SELinux:  Permission bpf in class cap2_userns not defined in policy.
[    3.042753] SELinux:  Permission checkpoint_restore in class cap2_userns not defined in policy.
[    3.042787] SELinux:  Class perf_event not defined in policy.
[    3.042789] SELinux:  Class lockdown not defined in policy.
[    3.042791] SELinux: the above unknown classes and permissions will be allowed
[    3.042801] SELinux:  Converting 208 SID table entries...
[    3.044951] Unable to handle kernel access to user memory outside uaccess routines at virtual address 0000000040000028
[    3.050919] SELinux:  policy capability network_peer_controls=1
[    3.055990] Mem abort info:
[    3.055992]   ESR = 0x96000004
[    3.055994]   EC = 0x25: DABT (current EL), IL = 32 bits
[    3.055995]   SET = 0, FnV = 0
[    3.055996]   EA = 0, S1PTW = 0
[    3.055997] Data abort info:
[    3.055998]   ISV = 0, ISS = 0x00000004
[    3.055999]   CM = 0, WnR = 0
[    3.056002] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000940ea000
[    3.056003] [0000000040000028] pgd=0000000000000000, p4d=0000000000000000
[    3.058894] SELinux:  policy capability open_perms=1
[    3.062037] 
[    3.062041] Internal error: Oops: 96000004 [#1] SMP
[    3.062044] Modules linked in: bnxt_en pcie_iproc_platform
[    3.067530] SELinux:  policy capability extended_socket_class=1
[    3.070674]  pcie_iproc diagbe(O)
[    3.070680] CPU: 1 PID: 512 Comm: (tservice) Tainted: G           O      5.10.17.1 #1
[    3.070683] Hardware name: redacted (DT)
[    3.073924] SELinux:  policy capability always_check_network=0
[    3.076890] pstate: 20400085 (nzCv daIf +PAN -UAO -TCO BTYPE=--)
[    3.076904] pc : sidtab_do_lookup+0x128/0x1b4
[    3.076908] lr : sidtab_context_to_sid+0x210/0x378
[    3.080864] SELinux:  policy capability cgroup_seclabel=1
[    3.083920] sp : ffff800011bfbaf0
[    3.083922] x29: ffff800011bfbaf0 
[    3.090570] SELinux:  policy capability nnp_nosuid_transition=1
[    3.097564] x28: 0000000000000000 
[    3.097566] x27: 0000000000000005 x26: ffffd1b6451f2000 
[    3.097568] x25: 00000000ffffffff x24: 0000000000000000 
[    3.102693] SELinux:  policy capability genfs_seclabel_symlinks=0
[    3.104225] x23: 0000000000000001 x22: 0000000000000005 
[    3.104227] x21: 0000000040000028 x20: 0000000000000001 
[    3.104230] x19: 00000000000000d0 x18: 5b00000000000000 
[    3.217640] x17: 0000000077493ecb x16: 00000000c2b2ae35 
[    3.223120] x15: 00000000639285d3 x14: 0000000000000010 
[    3.228600] x13: 00000000128b8525 x12: 000000005128b852 
[    3.234079] x11: 0000000049dd48c1 x10: 0000000000004e00 
[    3.239559] x9 : 00000000000000d1 x8 : 0000000000000005 
[    3.245039] x7 : 0000000000000001 x6 : 0000000000000000 
[    3.250518] x5 : ffff800011bfbc48 x4 : 0000000000000010 
[    3.255998] x3 : 0000000000000002 x2 : 0000000000000001 
[    3.261477] x1 : 00000000000000d0 x0 : 0000000040000000 
[    3.266957] Call trace:
[    3.269480]  sidtab_do_lookup+0x128/0x1b4
[    3.273615]  sidtab_context_to_sid+0x210/0x378
[    3.278198]  security_compute_sid+0x3f4/0x60c
[    3.282692]  security_transition_sid+0x30/0x38
[    3.287277]  selinux_bprm_creds_for_exec+0x11c/0x2e8
[    3.292398]  security_bprm_creds_for_exec+0x30/0x4c
[    3.297432]  bprm_execve+0x100/0x1d4
[    3.301118]  do_execveat_common+0x1e8/0x228
[    3.305432]  __arm64_sys_execve+0x3c/0x4c
[    3.309569]  do_el0_svc+0xec/0x154
[    3.313079]  el0_svc+0xc/0x14
[    3.316139]  el0_sync_handler+0x7c/0xd8
[    3.320095]  el0_sync+0x144/0x180
[    3.323516] Code: 51002718 340001d7 1ad82768 8b284c15 (f94002a0) 
[    3.329808] ---[ end trace 69ebb6381d57e49b ]---

Tyler
