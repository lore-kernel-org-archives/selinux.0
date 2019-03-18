Return-Path: <SRS0=cHrg=RV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF00C43381
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 21:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14A920872
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 21:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="rpXeMlCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfCRVbs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:31:48 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33603 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfCRVbs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Mar 2019 17:31:48 -0400
Received: by mail-lf1-f65.google.com with SMTP id v14so12302387lfi.0
        for <selinux@vger.kernel.org>; Mon, 18 Mar 2019 14:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=M5/ApUvDUc1E9i+YB/jObtBn2XgQS2RmXoil81eBU30=;
        b=rpXeMlCXXkGtbJPPBRzv9HG2lVIG/93DRtcXFIiuigVipJmA5Zwlhg9AML6yJou5kM
         z76ZJAGj3eMgN8FyxZZb8QAJRO1GVr6fnOOmjVn8HGJFyQBFtpn6C4EyZMjWlyB13DjA
         Z3jmEmaGOCYL3AxwaJU+IcWTRMyGylkq0arUXhwmpPQfdeAF5znEyW9BUZ0Sm8FqSIzy
         r9PpOUP85ZgYLt2sfhmQU9GAdBrYzLXDWtVNzutCTdd9m3E9wC0S/OEx3W6BZacBr22n
         FN//fCvq3JOhefPDD+IBZs4SKlUcf4Cm5EyG7p4+yk31lS/T8wNihNHPzNQ6k27+vPdh
         zOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=M5/ApUvDUc1E9i+YB/jObtBn2XgQS2RmXoil81eBU30=;
        b=MybTK3I6iXDy4nioz9u4OZgRKOZ6t3gdHf5YgsN8hP4CKPKjX2MbtfCPejAROtqnl2
         CeyCCwUE+Qbweoq3DhZawR96FLW3aoBRYXztXA4Opo/VvFGJShSYhMCqMQt3uaswn8cV
         unyAqUnX4d7EJvxSiQpgLAZck2/+Svrm3QE70TNOR8ggvx0Q9+ZC+p+aV8ORDQSPckuY
         SaUU9RLJ1u6QJWFi1r+9yYbU0ErMWIgrSL3XEsWPUnIe/RHhJKRSu9iQtFSgCTar1cCk
         B1e4p4niE9HHcGCtKiE55WCKH3r7VqYT/CV45lQgif9x7R+hcZvD4ggPgTfLZUmkXkOv
         B3NQ==
X-Gm-Message-State: APjAAAXMzG0JOR2/hOUFun6FnAlGsxC2yXFmGaZXRDRIIze4r3kLhcZM
        dVNRlZsFSoNVXQEyc7fdfFIYapg0gUhc/neQV+26
X-Google-Smtp-Source: APXvYqyYtDOHvUUAhzSxk8L343k9C8Vax2hmQrIDv/JbIhLWveh1S2OqD5TLZgJJQsZtamU7icZIayOgBlRIAAPgMEk=
X-Received: by 2002:a19:7613:: with SMTP id c19mr10669956lff.105.1552944705458;
 Mon, 18 Mar 2019 14:31:45 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 18 Mar 2019 17:31:34 -0400
Message-ID: <CAHC9VhS1vRJuxxdzVsvkBVVVzt-3g9Q3qHSeeVPB9=JH+nNXbg@mail.gmail.com>
Subject: v5.1-rc1 binder_alloc_do_buffer_copy() BUG_ON triggered by selinux-testsuite
To:     Todd Kjos <tkjos@android.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello all.

When running the selinux-testsuite (link below) against v5.1-rc1 I hit
the BUG_ON() at the top of binder_alloc_do_buffer_copy() (trace
below).  I'm hoping this is a known issue with a fix already in the
works?

* https://github.com/SELinuxProject/selinux-testsuite

[  823.232432] ------------[ cut here ]------------
[  823.234746] kernel BUG at drivers/android/binder_alloc.c:1141!
[  823.237447] invalid opcode: 0000 [#1] SMP PTI
[  823.239421] CPU: 1 PID: 3644 Comm: test_binder Not tainted
5.1.0-0.rc1.git0.1.2.secnext.fc31.x86_64 #1
[  823.243538] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[  823.246079] RIP: 0010:binder_alloc_do_buffer_copy+0x34/0x210
[  823.248613] Code: 0a 41 55 49 89 fb 41 54 41 89 f4 48 8d 77 38 48
8b 42 58 55 53 48 39 f1 0f 84 17 01 00 00 48 8b 49 58 48 29 c1 49 39
c9 76 02 <0f> 0b 4c 29 c9 49 39 ca 77 f6 41 f6 c2 03 75 f0 0f b6 4a 28
f6 c1
[  823.256404] RSP: 0018:ffffb04e41093b68 EFLAGS: 00010202
[  823.258513] RAX: 00007fb600c52000 RBX: a0d48e24a0213e28 RCX: 0000000000000020
[  823.261375] RDX: ffff9c09b058a9c0 RSI: ffff9c09189165b0 RDI: ffff9c0918916578
[  823.264225] RBP: ffff9c09b058a9c0 R08: ffffb04e41093c80 R09: 0000000000000028
[  823.267044] R10: a0d48e24a0213e28 R11: ffff9c0918916578 R12: 0000000000000000
[  823.269758] R13: ffff9c09b67c9660 R14: ffff9c09b116fb40 R15: ffffffff8acd4d08
[  823.272482] FS:  00007fbeb3438800(0000) GS:ffff9c09b7a80000(0000)
knlGS:0000000000000000
[  823.275595] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  823.277676] CR2: 000055b102d31cc9 CR3: 0000000234648000 CR4: 00000000001406e0
[  823.280347] Call Trace:
[  823.281287]  binder_get_object+0x60/0xf0
[  823.282728]  binder_transaction+0xc2e/0x2370
[  823.284268]  ? __check_object_size+0x41/0x15d
[  823.285849]  ? binder_thread_read+0x9e2/0x1460
[  823.287342]  ? binder_update_ref_for_handle+0x83/0x1a0
[  823.289066]  binder_thread_write+0x2ae/0xfc0
[  823.290513]  ? finish_wait+0x80/0x80
[  823.291729]  binder_ioctl+0x659/0x836
[  823.292980]  do_vfs_ioctl+0x40a/0x670
[  823.294234]  ksys_ioctl+0x5e/0x90
[  823.295364]  __x64_sys_ioctl+0x16/0x20
[  823.296609]  do_syscall_64+0x5b/0x150
[  823.297796]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  823.299423] RIP: 0033:0x7fbeb35e782b
[  823.300580] Code: 0f 1e fa 48 8b 05 5d 96 0c 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2d 96 0c 00 f7 d8 64 89
01 48
[  823.306473] RSP: 002b:00007ffdfae2f198 EFLAGS: 00000287 ORIG_RAX:
0000000000000010
[  823.308868] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbeb35e782b
[  823.311029] RDX: 00007ffdfae2f1b0 RSI: 00000000c0306201 RDI: 0000000000000003
[  823.313206] RBP: 00007ffdfae30210 R08: 00000000010fa330 R09: 0000000000000000
[  823.315379] R10: 0000000000400644 R11: 0000000000000287 R12: 0000000000401190
[  823.317459] R13: 00007ffdfae304c0 R14: 0000000000000000 R15: 0000000000000000
[  823.319510] Modules linked in: crypto_user nfnetlink xt_multiport
bluetooth ecdh_generic rfkill sctp overlay ip6table_security
xt_CONNSECMARK xt_SECMARK xt_state xt_conntrack nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_security ah6
xfrm6_mode_transport ah4 xfrm4_mode_transport ip6table_mangle
ip6table_filter ip6_tables iptable_mangle xt_mark xt_AUDIT ib_isert
iscsi_target_mod ib_srpt target_core_mod ib_srp scsi_transport_srp
rpcrdma rdma_ucm ib_iser ib_umad ib_ipoib rdma_cm iw_cm libiscsi
scsi_transport_iscsi ib_cm mlx5_ib ib_uverbs ib_core sunrpc
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel joydev
virtio_balloon i2c_piix4 drm_kms_helper virtio_net net_failover
failover ttm drm mlx5_core crc32c_intel virtio_blk ata_generic
virtio_console mlxfw serio_raw pata_acpi qemu_fw_cfg [last unloaded:
arp_tables]
[  823.339786] ---[ end trace 6f761f654b297775 ]---

-- 
paul moore
www.paul-moore.com
