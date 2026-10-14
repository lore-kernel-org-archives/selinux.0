Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9893EA977;
	Wed, 14 Oct 2026 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791994239; cv=none; b=XokS/emBCuHjVBc26e20E3UPfij317AA0aQYvuP/WGf9jsfKHv2auloQtxDbEKjI1M8jYiJHfqi630xNb4aPM8mVbPFkju+dfBrEmhXeoJ/dA5oal8tJjTdu+6ZZ4QkidBXCirzBRoCRa7i8iJ2SIwkpm5rdvLgo3LyZ7zneOiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791994239; c=relaxed/simple;
	bh=+I1Q1wVT/gtlgef1HcOhpCOSbbpgt+qGbTbhyzBcrzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pSZud000YLVxVlqK4VTx3GjcHx1Gwjrt+GEaR50snlRv1aFgU+0D8SSw+XTmLJFic5DjQ0abZ5BCIg8KYJxItHwo4uO/TopqvSPtvmQmjAhbhLXYGBHhX5pTCIprgaaRhm1nmkesdtha8BqnfXeN3xh5aTSyyueamY3ZapLrj6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUqo0vAH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUqo0vAH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DECF1F000C4;
	Wed, 14 Oct 2026 16:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791994232;
	bh=94VUBlLPz7MezejTIONPbCndltZq95yxwtKCOBgExF8=;
	h=From:To:Cc:Subject:Date;
	b=MUqo0vAH0WQn8P3UrwA6iCts55pBUXSDLe9lChTsIUzeXfifsPnv09sVQexk2B5Ur
	 WsIKTNpctvapBPiwyxGccVxvHqiS5grqLhXfGPUji0rT5/jkgLscvmjotVaAAkw4J5
	 gsn8ro7WzbHZDFuGdnY1w2yG/s6QUI0pV0Mg/bCfYfMf9FriBL0Yw0wVVX9hzgRO+1
	 PySbH6YuJ+IzIEQiHdtAkx6GRtjE0d01FjUhH/6t556IY9/slu1yBcW2PtRXTXxM3p
	 KyhiUhofcUUUKPNirt8ot49yGl3ORRSzX0pLt7BrSxD/1vgCnZRkrfy7wvGFrL5VVc
	 hlAFSMvi+5c8w==
From: Thorsten Blum <blum@kernel.org>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	=?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Cc: Thorsten Blum <blum@kernel.org>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: use isdigit() in selinux_genfs_get_sid()
Date: Wed, 14 Oct 2026 18:07:43 +0200
Message-ID: <20261014160741.222219-3-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=blum@kernel.org; h=from:subject; bh=+I1Q1wVT/gtlgef1HcOhpCOSbbpgt+qGbTbhyzBcrzE=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnnV5wtkEzrblvgr6IkLfDpZZ7V7iDn7Yukxb+pRztad 5fNZVbsKGVhEONikBVTZHkw68cM39Kayk0mETth5rAygQxh4OIUgIk4hDIyXGbQPR7zVWLtwtlB TjNsJpoVeCemuQbxrrSaftxhl8eyt4wMc6dr3q0NY8wNX8flfCWyjNlDdo1dkNiyivq6Y953ftq wAgA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Use isdigit() to replace the open-coded implementation.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 security/selinux/hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 30776b0107f2..d1304afa42fd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -31,6 +31,7 @@
 #include <linux/lsm_hooks.h>
 #include <linux/xattr.h>
 #include <linux/capability.h>
+#include <linux/ctype.h>
 #include <linux/unistd.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
@@ -1357,7 +1358,7 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 			/* each process gets a /proc/PID/ entry. Strip off the
 			 * PID part to get a valid selinux labeling.
 			 * e.g. /proc/1/net/rpc/nfs -> /net/rpc/nfs */
-			while (path[1] >= '0' && path[1] <= '9') {
+			while (isdigit(path[1])) {
 				path[1] = '/';
 				path++;
 			}
