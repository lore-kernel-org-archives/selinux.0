Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4721DC3524D
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 08:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0C220658
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 08:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ToZcqyaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgBCIua (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:50:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42296 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727509AbgBCIua (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 03:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580719829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vUM64qeKRuz8SHX3m3j5QVhSYQvKEaAvRv8Xf5ExScA=;
        b=ToZcqyaKJ9LhLXA8PiAcdjhYSZJ4uqNvY4YdmWbXQUZO1VoO4As/pqJNItv1w6HMlK1OxG
        NIjwCDM2aD9+cghDMxNhhX8MxTMEGM7hdxX61kZK2oplRS30NX1nEXtu/fy8Yx7s/FUPHP
        OzhLH55KwwSWCRmaoZ9kAYYXhZo/rb8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-PkEStXo8MCKGervhC4WNFQ-1; Mon, 03 Feb 2020 03:50:27 -0500
X-MC-Unique: PkEStXo8MCKGervhC4WNFQ-1
Received: by mail-wm1-f71.google.com with SMTP id s25so4533652wmj.3
        for <selinux@vger.kernel.org>; Mon, 03 Feb 2020 00:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vUM64qeKRuz8SHX3m3j5QVhSYQvKEaAvRv8Xf5ExScA=;
        b=EfKvrAZbTtS7QUvpUuKG6F4XQ2XzwE+xrf2Ew1dAYNSrFiRXWUcF5d4Xn8zeSPK/H/
         EIvCPgexAWImtt1VEk0A7gRkaNmgDekBvBEWBebTLVBLEL+1Gps1EL2AIRSmLhcOqatg
         nLeYycxtJRpiNOEsqhD5uCfrGfwicbgQzf0XY9Dd6C3u76ElfpErrC2d61wnYm7ulkFH
         FvzYVfm6Zoue97DxcRBQeK0H9bD4vqyn6E7tZ4sEGgpJu566Vf+RJLvu4WnnjNXUIqu6
         04UwiYhbU+sM1xAOOlCsM3i4IOnbiHiHWcrfsG6/f0l/DlV3RElcJaoE+vxJqJ+vvI0o
         W1Vw==
X-Gm-Message-State: APjAAAVqKEfHTA7PjTNASjabb9F5v2T1yxtNwFBlvEsoh2LGc/32IXdY
        dRq/0wELbyKgBdr5NlX3rJD8WPKNvPWKN644wkt+klFFnvhYgGv3POXNJNu9dH1Jbdd01BPKK+i
        eCDGjEZQp92OwuOTAPQ==
X-Received: by 2002:a1c:7dd4:: with SMTP id y203mr28224907wmc.67.1580719826319;
        Mon, 03 Feb 2020 00:50:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqwxkBx5ZvvxMhQtC2mKnre41XTTce83Hkq93+Jjazzf8u1gQ5s/ySIy99ZUj4OcUGtgooiEyg==
X-Received: by 2002:a1c:7dd4:: with SMTP id y203mr28224840wmc.67.1580719825713;
        Mon, 03 Feb 2020 00:50:25 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 133sm16265749wmd.5.2020.02.03.00.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 00:50:25 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com
Subject: [PATCH] selinux: fix sidtab string cache locking
Date:   Mon,  3 Feb 2020 09:50:23 +0100
Message-Id: <20200203085023.360612-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Avoiding taking a lock in an IRQ context is not enough to prevent
deadlocks, as discovered by syzbot:

===
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
5.5.0-syzkaller #0 Not tainted
-----------------------------------------------------
syz-executor.0/8927 [HC0[0]:SC0[2]:HE1:SE0] is trying to acquire:
ffff888027c94098 (&(&s->cache_lock)->rlock){+.+.}, at: spin_lock include/linux/spinlock.h:338 [inline]
ffff888027c94098 (&(&s->cache_lock)->rlock){+.+.}, at: sidtab_sid2str_put.part.0+0x36/0x880 security/selinux/ss/sidtab.c:533

and this task is already holding:
ffffffff898639b0 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: spin_lock include/linux/spinlock.h:338 [inline]
ffffffff898639b0 (&(&nf_conntrack_locks[i])->rlock){+.-.}, at: nf_conntrack_lock+0x17/0x70 net/netfilter/nf_conntrack_core.c:91
which would create a new lock dependency:
 (&(&nf_conntrack_locks[i])->rlock){+.-.} -> (&(&s->cache_lock)->rlock){+.+.}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&(&nf_conntrack_locks[i])->rlock){+.-.}

[...]

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&(&s->cache_lock)->rlock);
                               local_irq_disable();
                               lock(&(&nf_conntrack_locks[i])->rlock);
                               lock(&(&s->cache_lock)->rlock);
  <Interrupt>
    lock(&(&nf_conntrack_locks[i])->rlock);

 *** DEADLOCK ***
[...]
===

Fix this by simply locking with irqsave/irqrestore and stop giving up on
!in_task(). It makes the locking a bit slower, but it shouldn't make a
big difference in real workloads. Under the scenario from [1] (only
cache hits) it only increased the runtime overhead from the
security_secid_to_secctx() function from ~2% to ~3% (it was ~5-65%
before introducing the cache).

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1733259

Fixes: d97bd23c2d7d ("selinux: cache the SID -> context string translation")
Reported-by: syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/sidtab.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index a308ce1e6a13..f511ffccb131 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -518,19 +518,13 @@ void sidtab_sid2str_put(struct sidtab *s, struct sidtab_entry *entry,
 			const char *str, u32 str_len)
 {
 	struct sidtab_str_cache *cache, *victim = NULL;
+	unsigned long flags;
 
 	/* do not cache invalid contexts */
 	if (entry->context.len)
 		return;
 
-	/*
-	 * Skip the put operation when in non-task context to avoid the need
-	 * to disable interrupts while holding s->cache_lock.
-	 */
-	if (!in_task())
-		return;
-
-	spin_lock(&s->cache_lock);
+	spin_lock_irqsave(&s->cache_lock, flags);
 
 	cache = rcu_dereference_protected(entry->cache,
 					  lockdep_is_held(&s->cache_lock));
@@ -561,7 +555,7 @@ void sidtab_sid2str_put(struct sidtab *s, struct sidtab_entry *entry,
 	rcu_assign_pointer(entry->cache, cache);
 
 out_unlock:
-	spin_unlock(&s->cache_lock);
+	spin_unlock_irqrestore(&s->cache_lock, flags);
 	kfree_rcu(victim, rcu_member);
 }
 
-- 
2.24.1

