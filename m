Return-Path: <SRS0=OlHu=DK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45102C41604
	for <selinux@archiver.kernel.org>; Sat,  3 Oct 2020 13:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F067F206CD
	for <selinux@archiver.kernel.org>; Sat,  3 Oct 2020 13:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgJCNTp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 3 Oct 2020 09:19:45 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:59844 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgJCNTp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 3 Oct 2020 09:19:45 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id EC9AB564C4A
        for <selinux@vger.kernel.org>; Sat,  3 Oct 2020 15:19:41 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace] libsepol/cil: fix signed overflow caused by using (1 << 31) - 1
Date:   Sat,  3 Oct 2020 15:19:08 +0200
Message-Id: <20201003131908.1867282-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Oct  3 15:19:42 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When compiling SELinux userspace tools with -ftrapv (this option
generates traps for signed overflow on addition, subtraction,
multiplication operations, instead of silently wrapping around),
semodule crashes when running the tests from
scripts/ci/fedora-test-runner.sh in a Fedora 32 virtual machine:

    [root@localhost selinux-testsuite]# make test
    make -C policy load
    make[1]: Entering directory '/root/selinux-testsuite/policy'
    # Test for "expand-check = 0" in /etc/selinux/semanage.conf
    # General policy build
    make[2]: Entering directory '/root/selinux-testsuite/policy/test_policy'
    Compiling targeted test_policy module
    Creating targeted test_policy.pp policy package
    rm tmp/test_policy.mod.fc
    make[2]: Leaving directory '/root/selinux-testsuite/policy/test_policy'
    # General policy load
    domain_fd_use --> off
    /usr/sbin/semodule -i test_policy/test_policy.pp test_mlsconstrain.cil test_overlay_defaultrange.cil test_add_levels.cil test_glblub.cil
    make[1]: *** [Makefile:174: load] Aborted (core dumped)

Using "coredumpctl gdb" leads to the following strack trace:

    (gdb) bt
    #0  0x00007f608fe4fa25 in raise () from /lib64/libc.so.6
    #1  0x00007f608fe38895 in abort () from /lib64/libc.so.6
    #2  0x00007f6090028aca in __addvsi3.cold () from /lib64/libsepol.so.1
    #3  0x00007f6090096f59 in __avrule_xperm_setrangebits (low=30, high=30, xperms=0x8b9eea0)
        at ../cil/src/cil_binary.c:1551
    #4  0x00007f60900970dd in __cil_permx_bitmap_to_sepol_xperms_list (xperms=0xb650a30, xperms_list=0x7ffce2653b18)
        at ../cil/src/cil_binary.c:1596
    #5  0x00007f6090097286 in __cil_avrulex_ioctl_to_policydb (k=0xb8ec200 "@\023\214\022\006", datum=0xb650a30,
        args=0x239a640) at ../cil/src/cil_binary.c:1649
    #6  0x00007f609003f1e5 in hashtab_map (h=0x41f8710, apply=0x7f60900971da <__cil_avrulex_ioctl_to_policydb>,
        args=0x239a640) at hashtab.c:234
    #7  0x00007f609009ea19 in cil_binary_create_allocated_pdb (db=0x2394f10, policydb=0x239a640)
        at ../cil/src/cil_binary.c:4969
    #8  0x00007f609009d19d in cil_binary_create (db=0x2394f10, policydb=0x7ffce2653d30) at ../cil/src/cil_binary.c:4329
    #9  0x00007f609008ec23 in cil_build_policydb_create_pdb (db=0x2394f10, sepol_db=0x7ffce2653d30)
        at ../cil/src/cil.c:631
    #10 0x00007f608fff4bf3 in semanage_direct_commit () from /lib64/libsemanage.so.1
    #11 0x00007f608fff9fae in semanage_commit () from /lib64/libsemanage.so.1
    #12 0x0000000000403e2b in main (argc=7, argv=0x7ffce2655058) at semodule.c:753

    (gdb) f 3
    #3  0x00007f6090096f59 in __avrule_xperm_setrangebits (low=30, high=30, xperms=0x8b9eea0)
        at ../cil/src/cil_binary.c:1551
    1551     xperms->perms[i] |= XPERM_SETBITS(h) - XPERM_SETBITS(low);

A signed integer overflow therefore occurs in XPERM_SETBITS(h):

    #define XPERM_SETBITS(x) ((1 << (x & 0x1f)) - 1)

This macro is expanded with h=31, so "(1 << 31) - 1" is computed:

* (1 << 31) = -0x80000000 is the lowest signed 32-bit integer value
* (1 << 31) - 1 overflows the capacity of a signed 32-bit integer and
  results in 0x7fffffff (which is unsigned)

Using unsigned integers (with "1U") fixes the crash, as
(1U << 31) = 0x80000000U has no overflowing issues.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 checkpolicy/policy_define.c   | 2 +-
 libsepol/cil/src/cil_binary.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 395f62284e3c..bf6c3e68bef3 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -2147,7 +2147,7 @@ out:
 /* index of the u32 containing the permission */
 #define XPERM_IDX(x) (x >> 5)
 /* set bits 0 through x-1 within the u32 */
-#define XPERM_SETBITS(x) ((1 << (x & 0x1f)) - 1)
+#define XPERM_SETBITS(x) ((1U << (x & 0x1f)) - 1)
 /* low value for this u32 */
 #define XPERM_LOW(x) (x << 5)
 /* high value for this u32 */
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 36720eda4549..e417c5c28b8b 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1526,7 +1526,7 @@ int cil_avrule_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_
 /* index of the u32 containing the permission */
 #define XPERM_IDX(x) (x >> 5)
 /* set bits 0 through x-1 within the u32 */
-#define XPERM_SETBITS(x) ((1 << (x & 0x1f)) - 1)
+#define XPERM_SETBITS(x) ((1U << (x & 0x1f)) - 1)
 /* low value for this u32 */
 #define XPERM_LOW(x) (x << 5)
 /* high value for this u32 */
-- 
2.28.0

