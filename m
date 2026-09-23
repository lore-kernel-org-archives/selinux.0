Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443AF47F3CF
	for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158434; cv=none; b=TSfYHJU3xu718vGnJQJY9GJLzWjbLTKI5g9m9ZcF3sB7gtjL0+Cn6xfmxeB3+Z24yot9b2sMynuV26xQiLftEatrR8ckeneIXJ7rzQyxkD7InURtgpbU9Woll5Ji2UQeYl6J63Y3UwlVgiXoPMjTAvKcH8P9J1oUIEISOHy7f9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158434; c=relaxed/simple;
	bh=3C8pI10yW6uwq9PBeNn9vMQJqwjRb0JE8Sw+1wjcqZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VBhCARIurLLGsyzmJsREwK8p7NShaxIahp39G/BHHpFaZDszGL+Q4zjlSWx6fqp1b6zOah/jNfMVGI/qT6ABDM7/y9pW1IQo14uw62rHweuIGIWhEr9/8WALp1BUzO3Q02l/DdMjivOAyLitKnSFn20dd1jCIg8MbKM0mB6AwB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=iN0L17y9; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="iN0L17y9"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790158414;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=rNTvPT4B4hikE6uzbauxK8by8QgdLT5H5DWeZQ6mh78=;
	b=iN0L17y9KtKzEEuc+VNhUsdG3+r9ugM8G8IZ/+6cL40aC4DSuojItATxuN17pdLSRK4Hw5
	ixMw+359XA2OcldMGSUmkOVwrbGcH+NHsM52gTSpzTcCXNr82ES67qZEQfKnN1RwjZzMH1
	lqgu8Z6GDUm7ziv99BE8qIrSxXEPq4ZBV3gE8gl5t3wdsWE7yotm2KK/oVABKi1z3S7Ezk
	VKRQzwTwW3yQZ/t3g7KhdYTpiX/PqMGFCV4aLpdIxQrjb4/VHZscVOTXu4dlMGV6Rl8I8p
	oUREznFcBrlFmdiISd+13z9kYd+kMdJWOacyC0yUygXhAmkBnKV5SqIxS1Pv2Q==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	syzbot+a7f7cb0737bd91aa698c@syzkaller.appspotmail.com
Subject: [PATCH v2] selinux: fix data race on AVC latest_notif
Date: Wed, 23 Sep 2026 12:13:23 +0200
Message-ID: <20260923101323.2996793-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

avc_policy_seqno() reads latest_notif without holding notif_lock, while
avc_latest_notif_update() can update it under that lock. KCSAN reports
these concurrent accesses during policy boolean updates and permission
checks.

Use READ_ONCE() for the lockless read and WRITE_ONCE() for the update.
The spinlock continues to serialize the comparison and update against
other writers. Reads made while holding notif_lock cannot race with a
writer and can remain plain accesses.

This marks both sides of the intentional concurrent access and constrains
compiler transformations, without suppressing checking with data_race().

Fixes: 788e7dd4c22e ("SELinux: Improve read/write performance")
Reported-by: syzbot+a7f7cb0737bd91aa698c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a7f7cb0737bd91aa698c
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
Changes in v2:
- mark the write as well
- drop data_race()
- i am not that familiar with the kernel concurrency model, so an AI
  claimed an RCU read-side critical section would not exclude an
  in-place update of this scalar
v1: https://lore.kernel.org/all/20260202134822.67476-1-cgoettsche@seltendoof.de/T/
 security/selinux/avc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index a9401d6c2e5f..e5d68ab2c331 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -578,7 +578,7 @@ static int avc_latest_notif_update(u32 seqno, int is_insert)
 		}
 	} else {
 		if (seqno > selinux_avc.avc_cache.latest_notif)
-			selinux_avc.avc_cache.latest_notif = seqno;
+			WRITE_ONCE(selinux_avc.avc_cache.latest_notif, seqno);
 	}
 	spin_unlock_irqrestore(&notif_lock, flag);
 
@@ -1203,5 +1203,6 @@ int avc_has_perm(u32 ssid, u32 tsid, u16 tclass,
 
 u32 avc_policy_seqno(void)
 {
-	return selinux_avc.avc_cache.latest_notif;
+	/* Writers hold notif_lock; readers only sample the sequence number. */
+	return READ_ONCE(selinux_avc.avc_cache.latest_notif);
 }
-- 
2.55.0

