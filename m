Return-Path: <SRS0=kJrL=Y5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DBBC010A2
	for <selinux@archiver.kernel.org>; Tue,  5 Nov 2019 11:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978A221D71
	for <selinux@archiver.kernel.org>; Tue,  5 Nov 2019 11:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/5t51o9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbfKELti (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Nov 2019 06:49:38 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36991 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730627AbfKELth (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Nov 2019 06:49:37 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so14886468lfp.4
        for <selinux@vger.kernel.org>; Tue, 05 Nov 2019 03:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kEhdoHWESB3TxaEvW6H/6VSPc9ovtGWhaUQi5SVv7IY=;
        b=c/5t51o9yU+Ng5j23ZJTzf+p1Ey3hCfSOdnb0xS30brMJPdrBJ9zmbSUIoppbIuasW
         lGxIIIb7fovuYbCGpbZwrF7rQ9hPMm2DyLxEmshBsMYxV12QlRFRm5j/MY1amWEkzV6X
         A/EtqbgOnnB8A7V3ll7M3xIhm/UBReghd2sgAeyS06IR5ZHNCx3MUZ8QF1jXzo2NBhGH
         34+REeKTlGjRS3EqSMzCn4Woblfe1XGn3G1NdujIYazcrjQ4z8IZAh71PBnGIqZJFUVP
         dFgs92AoTCzVfRlYkc7eVuXmoYxP5oAKdNxXqzPPbBLzYVfaPTHBcjCNBatCEMIMPv2c
         BiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kEhdoHWESB3TxaEvW6H/6VSPc9ovtGWhaUQi5SVv7IY=;
        b=WsN05PGqa3FYkLWilCuspJ5uUSB0QluGciGEgHdxXqT+53jqkvRtzzv2XLVsAPxVso
         TFHT2KUmQSGX9s/gGFa3Vh2RpEk2MGjlUCOPZBFOJWWBZx9f969AURZB1VvEogu6HZLL
         6QkDJkWgvbS/kO2WajUEjaRhp3/3fSgTL54QcoeJuqXjziQunT/IeYa+yjiHU4CAjzpJ
         E62GuBsZMlnyXqAhgO1hcnHuzT4CtDEWpLba0NGMmBd3TVJg766jsAu2I9eEUKrytCtT
         qrd4aGieNMxZKSX+IQ439xFnHSf16BY890GfLXpoFl0+7GeBQTPimgIV9zEzOKQ29qly
         t4Dg==
X-Gm-Message-State: APjAAAV7OQoGy2SKJ3UQOnFtR4nDWFl2c/+eDtDOqSXBqTu8woSxeVzZ
        uTQRDyH6cB6HeO5S0nzjl8Gc242a3e4YxHp89a0T4g==
X-Google-Smtp-Source: APXvYqy4VfzYeYLTKjwexdPLXIJ0zAt2R53QtA8CG93O6DOV8NQ+uxZLeUH1lzUdlwk7BcJ/NC6ePWSy3F4wMNoff28=
X-Received: by 2002:a05:6512:203:: with SMTP id a3mr20141633lfo.7.1572954574608;
 Tue, 05 Nov 2019 03:49:34 -0800 (PST)
MIME-Version: 1.0
References: <20191104191535.23642-1-jeffv@google.com> <f824ce20-99f7-9df5-541e-8d239c6f31b4@tycho.nsa.gov>
In-Reply-To: <f824ce20-99f7-9df5-541e-8d239c6f31b4@tycho.nsa.gov>
From:   Jeffrey Vander Stoep <jeffv@google.com>
Date:   Tue, 5 Nov 2019 12:49:23 +0100
Message-ID: <CABXk95D2wnuywPw6OvnQQ5kiqwN8LtpKTQQS6Lc5E2aZrB99iA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: sidtab: reverse lookup hash table
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Jovana Knezevic <jovanak@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Is it actually a deadlock, or just missing nesting annotation? I'm
unable to reproduce (and this was one of my test cases). On my device
I use:

while true; do load_policy /vendor/etc/selinux/precompiled_sepolicy;
echo -n .; sleep 0.1; done &
for i in $(seq 1 256);
do
  runcon u:r:untrusted_app:s0:c$i,c256 echo -n x || break
done

dmesg is full of:
<snip>
[   73.731342] c4   8041 SELinux:  Converting 1694 SID table entries...
[   73.740946] c4   8041 SELinux:  policy capability
network_peer_controls=1
 [   73.747800] c4   8041 SELinux:  policy capability open_perms=1
[   73.759296] c4   8041 SELinux:  policy capability
always_check_network=0
[   73.771677] c4   8041 SELinux:  policy capability nnp_nosuid_transition=1
[   73.957571] c3   8049 SELinux:  Converting 1700 SID table entries...
[   73.968435] c4   8049 SELinux:  policy capability network_peer_controls=1
[   73.975278] c4   8049 SELinux:  policy capability open_perms=1
[   73.986776] c4   8049 SELinux:  policy capability always_check_network=0
[   73.999145] c4   8049 SELinux:  policy capability nnp_nosuid_transition=1
<snip>


On Mon, Nov 4, 2019 at 9:44 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 11/4/19 2:15 PM, Jeff Vander Stoep wrote:
> > This replaces the reverse table lookup and reverse cache with a
> > hashtable which improves cache-miss reverese-lookup times from
> > O(n) to O(1)* and maintains the same performance as a reverse
> > cache hit.
> >
> > This reduces the time needed to add a new sidtab entry from ~500us
> > to 5us on a Pixel 3 when there are ~10,000 sidtab entries.
> >
> > The implementation uses the kernel's generic hashtable API,
> > It uses the context's string represtation as the hash source,
> > and the kernels generic string hashing algorithm full_name_hash()
> > to reduce the string to a 32 bit value.
> >
> > This change also maintains the improvement introduced in commit
> > ee1a84fd which removed the need to keep the current sidtab locked
> > during policy reload. It does however introduce periodic locking of
> > the target sidtab while converting the hashtable. Sidtab entries
> > are never modified or removed, so the context struct stored in the
> > sid_to_context tree can also be used for the context_to_sid
> > hashtable to reduce memory usage.
> >
> > This bug was reported by:
> > - Stephen Smally on the selinux bug tracker.
> >    BUG: kernel softlockup due to too many SIDs/contexts #37
> >    https://github.com/SELinuxProject/selinux-kernel/issues/37
> > - Jovana Knezevic on Android's bugtracker.
> >    Bug: 140252993
> >    "During multi-user performance testing, we create and remove users
> >    many times. selinux_android_restorecon_pkgdir goes from 1ms to over
> >    20ms after about 200 user creations and removals. Accumulated over
> >    ~280 packages, that adds a significant time to user creation,
> >    making perf benchmarks unreliable."
> >
> > * Hashtable lookup is only O(1) when n < the number of buckets.
> >
> > Changes in V2:
> > -The hashtable uses sidtab_entry_leaf objects directly so these
> > objects are shared between the sid_to_context lookup tree and the
> > context_to_sid hashtable.
> > -Move the hash_add() statement to after the smp_store_release()
> > to ensure that the contents have been written before the object
> > becomes available in the hashtable.
>
> Don't forget to cc Paul and anyone who commented previously (e.g. Ondrej).
>
> I could be wrong, but I think that only helps if we also do a
> smp_load_acquire() prior to reading/walking the hash table and if there
> is an actual data dependency between the target of the store/load and
> what we are trying to protect here.   I don't think that's the case
> here.  So I don't think you can or should piggyback on the existing
> load_acquire/store_release pair.  Ondrej can correct me if I am wrong
> (entirely possible).
>
> I also get this splat upon running Ondrej's reproducer for the bug fixed
> by his sidtab rewrite.
>
> Reproducer:
>
>        while true; do load_policy; echo -n .; sleep 0.1; done &
>          for (( i = 0; i < 1024; i++ )); do
>              runcon -l s0:c$i echo -n x || break
>              # or:
>              # chcon -l s0:c$i <some_file> || break
>          done
>
> Splat:
>
> 6>[ 1070.843961] SELinux:  Converting 3927 SID table entries...
> <4>[ 1070.858060]
> <4>[ 1070.858064] ============================================
> <4>[ 1070.858066] WARNING: possible recursive locking detected
> <4>[ 1070.858068] 5.4.0-rc1+ #50 Not tainted
> <4>[ 1070.858070] --------------------------------------------
> <4>[ 1070.858072] runcon/13122 is trying to acquire lock:
> <4>[ 1070.858074] ffff88869467c248 (&(&s->lock)->rlock){..-.}, at:
> sidtab_context_to_sid+0x379/0x700
> <4>[ 1070.858080]
> <4>[ 1070.858080] but task is already holding lock:
> <4>[ 1070.858082] ffff8886e608c248 (&(&s->lock)->rlock){..-.}, at:
> sidtab_context_to_sid+0x64/0x700
> <4>[ 1070.858086]
> <4>[ 1070.858086] other info that might help us debug this:
> <4>[ 1070.858088]  Possible unsafe locking scenario:
> <4>[ 1070.858088]
> <4>[ 1070.858089]        CPU0
> <4>[ 1070.858090]        ----
> <4>[ 1070.858091]   lock(&(&s->lock)->rlock);
> <4>[ 1070.858093]   lock(&(&s->lock)->rlock);
> <4>[ 1070.858095]
> <4>[ 1070.858095]  *** DEADLOCK ***
> <4>[ 1070.858095]
> <4>[ 1070.858097]  May be due to missing lock nesting notation
> <4>[ 1070.858097]
> <4>[ 1070.858099] 3 locks held by runcon/13122:
> <4>[ 1070.858100]  #0: ffff8887fa97c820 (sb_writers#9){.+.+}, at:
> vfs_write+0x215/0x280
> <4>[ 1070.858105]  #1: ffffffffae0230e8
> (&selinux_ss.policy_rwlock){.+.?}, at:
> security_context_to_sid_core+0x2c0/0x340
> <4>[ 1070.858109]  #2: ffff8886e608c248 (&(&s->lock)->rlock){..-.}, at:
> sidtab_context_to_sid+0x64/0x700
> <4>[ 1070.858113]
> <4>[ 1070.858113] stack backtrace:
> <4>[ 1070.858116] CPU: 1 PID: 13122 Comm: runcon Not tainted 5.4.0-rc1+ #50
> <4>[ 1070.858118] Hardware name: Dell Inc. OptiPlex 7050/0NW6H5, BIOS
> 1.8.3 03/23/2018
> <4>[ 1070.858120] Call Trace:
> <4>[ 1070.858124]  dump_stack+0x9a/0xf0
> <4>[ 1070.858128]  __lock_acquire.cold+0x12e/0x212
> <4>[ 1070.858136]  ? lockdep_hardirqs_on+0x260/0x260
> <4>[ 1070.858142]  lock_acquire+0xe5/0x210
> <4>[ 1070.858160]  ? sidtab_context_to_sid+0x379/0x700
> <4>[ 1070.858164]  _raw_spin_lock_irqsave+0x44/0x60
> <4>[ 1070.858166]  ? sidtab_context_to_sid+0x379/0x700
> <4>[ 1070.858169]  sidtab_context_to_sid+0x379/0x700
> <4>[ 1070.858173]  ? security_compute_sid.part.0+0x960/0x960
> <4>[ 1070.858177]  security_context_to_sid_core+0x177/0x340
> <4>[ 1070.858180]  ? context_to_sid.isra.0+0x60/0x60
> <4>[ 1070.858182]  ? match_held_lock+0x1b/0x240
> <4>[ 1070.858200]  ? __might_fault+0x6f/0xd0
> <4>[ 1070.858203]  security_context_to_sid+0x12/0x20
> <4>[ 1070.858206]  sel_write_context+0x19b/0x200
> <4>[ 1070.858209]  ? selinux_transaction_write+0xa0/0xa0
> <4>[ 1070.858213]  ? _copy_from_user+0xa1/0xd0
> <4>[ 1070.858216]  ? selinux_transaction_write+0xa0/0xa0
> <4>[ 1070.858218]  selinux_transaction_write+0x72/0xa0
> <4>[ 1070.858221]  vfs_write+0x12f/0x280
> <4>[ 1070.858224]  ksys_write+0xc3/0x160
> <4>[ 1070.858227]  ? __ia32_sys_read+0x50/0x50
> <4>[ 1070.858230]  ? lockdep_hardirqs_off+0xbe/0x100
> <4>[ 1070.858232]  ? mark_held_locks+0x24/0x90
> <4>[ 1070.858236]  do_syscall_64+0x74/0xd0
> <4>[ 1070.858239]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> <4>[ 1070.858242] RIP: 0033:0x7f7e94d3a467
> <4>[ 1070.858245] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00
> 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00
> 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> <4>[ 1070.858247] RSP: 002b:00007ffd48dbae78 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> <4>[ 1070.858250] RAX: ffffffffffffffda RBX: 00007ffd48dbc038 RCX:
> 00007f7e94d3a467
> <4>[ 1070.858252] RDX: 000000000000002f RSI: 000055e32f081600 RDI:
> 0000000000000003
> <4>[ 1070.858254] RBP: 000055e32f081600 R08: 00000000ffffffff R09:
> 00007ffd48dbad10
> <4>[ 1070.858255] R10: 0000000000000000 R11: 0000000000000246 R12:
> 0000000000000003
> <4>[ 1070.858257] R13: 00007ffd48dbbefc R14: 0000000000000000 R15:
> 0000000000000000
>
> > -The new sidtab hash stats file in selinuxfs has been moved out of
> > the avc dir and into a new "ss" dir.
> >
> > Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> > Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
> > Reported-by: Jovana Knezevic <jovanak@google.com>
> > ---
> >   security/selinux/Kconfig            |  12 ++
> >   security/selinux/include/security.h |   1 +
> >   security/selinux/selinuxfs.c        |  64 +++++++
> >   security/selinux/ss/context.h       |  11 +-
> >   security/selinux/ss/policydb.c      |   5 +
> >   security/selinux/ss/services.c      |  87 +++++++---
> >   security/selinux/ss/services.h      |   4 +-
> >   security/selinux/ss/sidtab.c        | 249 +++++++++++++---------------
> >   security/selinux/ss/sidtab.h        |  16 +-
> >   9 files changed, 287 insertions(+), 162 deletions(-)
> >
> <snip>
