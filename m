Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAF4C433DB
	for <selinux@archiver.kernel.org>; Tue, 23 Feb 2021 21:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 219CB64E6C
	for <selinux@archiver.kernel.org>; Tue, 23 Feb 2021 21:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhBWVoc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Feb 2021 16:44:32 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58856 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhBWVoa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Feb 2021 16:44:30 -0500
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5AC6120B6C40;
        Tue, 23 Feb 2021 13:43:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5AC6120B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614116628;
        bh=mXNZp5kuu013nEFFtEkVTtSEJapzdoKqTaVKKsifH18=;
        h=Date:From:To:Cc:Subject:From;
        b=ACbBMOO85JCt+3/dlCWpAY9GAleJcRATmicpnY9WNLqVAs99MKKShAEIoaSaPARvc
         Gn+mbDUOgmmDsLPwqVfUlawCP0Tvon6Fzqv4LRPgcqaRDrkq6TXBd1KH4QnBztvLYz
         jZNMwGrc0lKTofBTyLYv/5RXyqZPv1n+ebtvt97A=
Date:   Tue, 23 Feb 2021 15:43:46 -0600
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUG] Race between policy reload sidtab conversion and live
 conversion
Message-ID: <20210223214346.GB6000@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I'm seeing a race during policy load while the "regular" sidtab
conversion is happening and a live conversion starts to take place in
sidtab_context_to_sid().

We have an initial policy that's loaded by systemd ~0.6s into boot and
then another policy gets loaded ~2-3s into boot. That second policy load
is what hits the race condition situation because the sidtab is only
partially populated and there's a decent amount of filesystem operations
happening, at the same time, which are triggering live conversions.

[    3.091910] Unable to handle kernel paging request at virtual address 001303e1aa140408
[    3.100083] Mem abort info:
[    3.102963]   ESR = 0x96000004
[    3.102965]   EC = 0x25: DABT (current EL), IL = 32 bits
[    3.102967]   SET = 0, FnV = 0
[    3.102968]   EA = 0, S1PTW = 0
[    3.102969] Data abort info:
[    3.102970]   ISV = 0, ISS = 0x00000004
[    3.102971]   CM = 0, WnR = 0
[    3.102973] [001303e1aa140408] address between user and kernel address ranges
[    3.102977] Internal error: Oops: 96000004 [#1] SMP
[    3.102981] Modules linked in:
[    3.111250]  bnxt_en pcie_iproc_platform pcie_iproc diagbe(O)
[    3.111259] CPU: 0 PID: 529 Comm: (tservice) Tainted: G           O      5.10.17.1 #1
[    3.119881] Hardware name: redacted (DT)
[    3.119884] pstate: 20400085 (nzCv daIf +PAN -UAO -TCO BTYPE=--)
[    3.119898] pc : sidtab_do_lookup (/usr/src/kernel/security/selinux/ss/sidtab.c:202)
[    3.119902] lr : sidtab_context_to_sid (/usr/src/kernel/security/selinux/ss/sidtab.c:312)
[    3.126105] sp : ffff800011ceb810
[    3.126106] x29: ffff800011ceb810 x28: 0000000000000000
[    3.126108] x27: 0000000000000005 x26: ffffda109f3f2000
[    3.126110] x25: 00000000ffffffff x24: 0000000000000000
[    3.126113] x23: 0000000000000001
[    3.133124] x22: 0000000000000005
[    3.133125] x21: aa1303e1aa140408 x20: 0000000000000001
[    3.133127] x19: 00000000000000cc x18: 0000000000000003
[    3.133128] x17: 000000000000003e x16: 000000000000003f
[    3.145519] x15: 0000000000000039 x14: 000000000000002e
[    3.145521] x13: 0000000058294db1 x12: 00000000158294db
[    3.145523] x11: 000000007f0b3af2 x10: 0000000000004e00
[    3.145525] x9 : 00000000000000cd x8 : 0000000000000005
[    3.281289] x7 : feff735e62647764 x6 : 00000000000080cc
[    3.286769] x5 : 0000000000000005 x4 : ffff3f47c5b20000
[    3.292249] x3 : ffff800011ceb900 x2 : 0000000000000001
[    3.297729] x1 : 00000000000000cc x0 : aa1303e1aa1403e0
[    3.303210] Call trace:
[    3.305733] sidtab_do_lookup (/usr/src/kernel/security/selinux/ss/sidtab.c:202)
[    3.309867] sidtab_context_to_sid (/usr/src/kernel/security/selinux/ss/sidtab.c:312)
[    3.314451] security_context_to_sid_core (/usr/src/kernel/security/selinux/ss/services.c:1557)
[    3.319661] security_context_to_sid_default (/usr/src/kernel/security/selinux/ss/services.c:1616)
[    3.324961] inode_doinit_use_xattr (/usr/src/kernel/security/selinux/hooks.c:1366)
[    3.329634] inode_doinit_with_dentry (/usr/src/kernel/security/selinux/hooks.c:1457)
[    3.334486] selinux_d_instantiate (/usr/src/kernel/security/selinux/hooks.c:6278)
[    3.338889] security_d_instantiate (/usr/src/kernel/security/security.c:2004)
[    3.343385] d_splice_alias (/usr/src/kernel/fs/dcache.c:3030)
[    3.347251] squashfs_lookup (/usr/src/kernel/fs/squashfs/namei.c:220)
[    3.385561] el0_sync_handler (/usr/src/kernel/arch/arm64/kernel/entry-common.c:428)
[    3.389517] el0_sync (/usr/src/kernel/arch/arm64/kernel/entry.S:671)
[ 3.392939] Code: 51002718 340001d7 1ad82768 8b284c15 (f94002a0)
All code
========
   0:   18 27                   sbb    %ah,(%rdi)
   2:   00 51 d7                add    %dl,-0x29(%rcx)
   5:   01 00                   add    %eax,(%rax)
   7:   34 68                   xor    $0x68,%al
   9:   27                      (bad)
   a:   d8 1a                   fcomps (%rdx)
   c:*  15 4c 28 8b a0          adc    $0xa08b284c,%eax         <-- trapping instruction
  11:   02 40 f9                add    -0x7(%rax),%al

Code starting with the faulting instruction
===========================================
   0:   a0                      .byte 0xa0
   1:   02 40 f9                add    -0x7(%rax),%al
[    3.399230] ---[ end trace cc1840b3ff2c7506 ]---

The corresponding source from sidtab.c:

   179  static struct sidtab_entry *sidtab_do_lookup(struct sidtab *s, u32 index,
   180                                               int alloc)
   181  {
   ...
   193          /* lookup inside the subtree */
   194          entry = &s->roots[level];
   195          while (level != 0) {
   196                  capacity_shift -= SIDTAB_INNER_SHIFT;
   197                  --level;
   198
   199                  entry = &entry->ptr_inner->entries[leaf_index >> capacity_shift];
   200                  leaf_index &= ((u32)1 << capacity_shift) - 1;
   201
   202                  if (!entry->ptr_inner) {
   203                          if (alloc)
   204                                  entry->ptr_inner = kzalloc(SIDTAB_NODE_ALLOC_SIZE,
   205                                                             GFP_ATOMIC); 
   206                          if (!entry->ptr_inner)
   207                                  return NULL;
   208                  }
   209          }
   210          if (!entry->ptr_leaf) {
   211                  if (alloc)
   212                          entry->ptr_leaf = kzalloc(SIDTAB_NODE_ALLOC_SIZE,
   213                                                    GFP_ATOMIC);
   214                  if (!entry->ptr_leaf)
   215                          return NULL;
   216          }
   217          return &entry->ptr_leaf->entries[index % SIDTAB_LEAF_ENTRIES];
   218  }

   ...

   263  int sidtab_context_to_sid(struct sidtab *s, struct context *context,
   264                            u32 *sid)
   265  {
   ...
   305          /*
   306           * if we are building a new sidtab, we need to convert the context
   307           * and insert it there as well
   308           */
   309          if (convert) {
   310                  rc = -ENOMEM;
   311                  dst_convert = sidtab_do_lookup(convert->target, count, 1);
   312                  if (!dst_convert) {
   313                          context_destroy(&dst->context);
   314                          goto out_unlock;
   315                  }
   ...

What I'm having trouble understanding is how the above call to
sidtab_do_lookup(), on the target sidtab that's undergoing a conversion
in sidtab_convert(), can be expected to work. sidtab_convert_tree() is
allocating and initializing ptr_inner sidtab nodes at the same time
sidtab_do_lookup() is trying to use them with no locking being performed
on the target sidtab.

Ondrej specifically mentions, in commit ee1a84fdfeed ("selinux: overhaul
sidtab to fix bug and improve performance"), that there's no need to
freeze the sidtab during policy reloads so I know that there's thought
given to these code paths running in parallel.

Can someone more knowledgeable on how the sidtab locking is expected to
work suggest a fix for this crash?

Tyler
