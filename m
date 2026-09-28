Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCFA4E325B
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617625; cv=none; b=K6VwnAL9O8IO9ylRBwt+LHAxfV/s2xro6qcFTqI99eh1KH1TS3IVEFJjGoMczNSv29a71sMPx9rqxsuzIw3iYgH6OhZxb0DLh2TWQUThF+uVIwnKq37mBxWtMJuwKC/jVVIgTL43kmAIT9Cyi8AkDik1gShU0rhKkiQM8O85kDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617625; c=relaxed/simple;
	bh=i4fJNFlKdDcsVw3AqD30msikdb4AG4l5L7t0VIxHDLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkDcZ4GAO0WxeGu87W+Et9/RvwppL4UeY3PkMvlecxB5VNeKljrSnEBmEDzUSGtQJQRMA9nPKtmkgF6ujxvrFASduhJ6+Fztpo6J8cHlO9nIimaeFde+7FGfJV5obfYXv3GjX2KrHsXnh50ZkmJdrcbo1u+VXqk+dnsFfRjq6UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=NBF0rYlg; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="NBF0rYlg"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617619;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yz/O8858Qq2P8IwuJFHfN84c3yr5c5HQgUN8WCfz7jk=;
	b=NBF0rYlgkzIjDkSj6AUoYsPDMZktY47yHlConivg34LQgZiFGYgTlu0NtSWyUCjzZ7lR3a
	i5hwAa4znI4kVoeHSlC2o+B7hdnaCZ9nkDGTbo2dTXBYgEsAG2GZdCzuzFOSw93KYyRwnc
	qSo0YLfjTA3oRyDve0wNgXjArl0NG1VY47Emim0rLGxnWaAK0Isw0d4yB9GgryubmbcgZH
	273U1ejX1kYalqqSnZMkwLOm4Mdi8rCxcAOyzE3Ut5tOvpmI/8N7t8inv99JoQl562ypQo
	ZI99O6zIJFSZvGQ86wvyOg4Cr8G5uwytS5adKRxMl10pgNZFTQU/Tt8R/lS6aw==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 11/32] selinux: use file table names to mark selinuxfs inodes immutable
Date: Mon, 28 Sep 2026 19:46:21 +0200
Message-ID: <20260928174643.2458710-10-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
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

Look up the status and policy files via their entries in the
selinux_files table instead of duplicating the name literals.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/selinuxfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 0fce6c0b0426..7236348a33dc 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1838,8 +1838,8 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (ret)
 		goto err;
 
-	sel_mark_immutable(sb->s_root, "status");
-	sel_mark_immutable(sb->s_root, "policy");
+	sel_mark_immutable(sb->s_root, selinux_files[SEL_STATUS].name);
+	sel_mark_immutable(sb->s_root, selinux_files[SEL_POLICY].name);
 
 	fsi = sb->s_fs_info;
 	fsi->bool_dir = sel_make_dir(sb->s_root, BOOL_DIR_NAME, &fsi->last_ino);
-- 
2.55.0

