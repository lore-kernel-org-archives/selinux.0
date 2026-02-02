Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D78735EDC9;
	Mon,  2 Feb 2026 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770040145; cv=none; b=uYblyO4lQiSKyXD6PyaT2koY4ft/Lsp7eXlAVsk3FbTPSMj0mKjCU6Qe3hK5Drk+n6hfyP4VjmNPmj3R5mOLs74qtN9Js/VwnffTvUql+uhecoRpxNK4u0bXXfnVh4wM7m4B1tz+5Psqip2nVJgJWBcW4cWdqTu2t58rgPY7rbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770040145; c=relaxed/simple;
	bh=CxxMaAL4VPoqmLRtyCXLRcqzkQX2FqaQ/4IZgSmx5LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yqq49173Hg6D1tMth+izY7xrKYViayqPWJ4Q21+39z2F2paD0fe0u5fkMOotTUBdYK1CNL0fubRCv785If9+dFdMp3LLTWO2uWdt9MIYwOrGXMjsTAJiatEGgcZbgLli/O9Ma4DHF0+i8WXULu7yl+U564rkNfU2sH/HtUCUnaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=LknWs+8w; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="LknWs+8w"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1770040134;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9/8ginhElOV2d8Ibtb6w82xsh7qOI5z7zW67NUWMK9Y=;
	b=LknWs+8wBLsn9NariHO8XCGjSh+LuoFCETgfxPlKJ8ognale+I1QpEKzWq4fYWOrTdh3nf
	Ub95Qc8gtDVOXy+ba0Zd8worzv3nk/JilONZFN+vvoAvNUej5SW4DkBnh2oIZ7o664Ixvq
	syL571H9mHvWV/4GS2AboNuDlxqGRJPwieVcYZiD5G9iQipYY/A6lF4Gn+i0JXpgtzKQNS
	/2/KMxnus0XSCnRsiDupQghhkdDiGixxCD/aLoCggne/Uu0d6/m+zG9Cp1YfhlIgtogyJK
	h2U6/dfPDc/6yQ1NZtOdwor45VKdhBto8nXADKgFmYt+mO0eAw9DshSyD3Luxw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	syzbot+a7f7cb0737bd91aa698c@syzkaller.appspotmail.com,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org,
	syzbot+9ab96b38b76bec93939a@syzkaller.appspotmail.com
Subject: [RFC PATCH 1/2] selinux: annotate intentional data race in inode_doinit_with_dentry()
Date: Mon,  2 Feb 2026 14:48:03 +0100
Message-ID: <20260202134822.67476-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260202134822.67476-1-cgoettsche@seltendoof.de>
References: <20260202134822.67476-1-cgoettsche@seltendoof.de>
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

Like other `isec->initialized == LABEL_INITIALIZED` checks annotate the
check in inode_doinit_with_dentry() with data_race to please KCSAN.

The value is rechecked next with lock held.

Reported-by: syzbot+9ab96b38b76bec93939a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9ab96b38b76bec93939a
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index feda34b18d83..21064d45a910 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1436,7 +1436,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 	struct dentry *dentry;
 	int rc = 0;
 
-	if (isec->initialized == LABEL_INITIALIZED)
+	/* check below is racy, but we will recheck with lock held */
+	if (data_race(isec->initialized == LABEL_INITIALIZED))
 		return 0;
 
 	spin_lock(&isec->lock);
-- 
2.51.0

