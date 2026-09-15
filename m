Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F45D455600;
	Tue, 15 Sep 2026 19:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789502256; cv=none; b=u6wreIc7yKQAchH7g7g7oqIU/qvZabWysLS4o3wh2y3Fpto+N1R7CqgqIE2edDAAqJ94T6litrqS/6T5q4RKoKKmLWrjIkSJ/NvOvkvGslW5XSnUEakwdxANhhxHKca4JwvmfsCCofhjDnnBEtLiyiZwxNrtK9Z8SqqFXMTBqYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789502256; c=relaxed/simple;
	bh=2CGS/t8DA8vfBtW4EHrRiuFBezhCMywT9x1eRe9O6wk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GzOTPpRVAWAWlAMFgtA2gtG9XoTRN/5FciXpBk0g6cceWMbGl5H21pxRnI23EwgLeq7zZbNxYbq9HFZwpKWcm/C6X69qfpHp0Mu0cf0NHM4Hl4uE5I/2PDbAoKh36vWXkqLhp2OwSR81kytLpXBXiHf6Cwhkw1C21V1jSlfqOnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMy6Rhhb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMy6Rhhb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C4A1F000FF;
	Tue, 15 Sep 2026 19:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789502253;
	bh=6xYx2jriqfg+A4oKe7ohrNrTOC4SS1hvaWMVgrCyzfY=;
	h=From:To:Cc:Subject:Date;
	b=aMy6Rhhb9A5CPk9Vt12ufwBIireiYpfSdjfnMWYhOObXtjgLeGkoA6fj4giOTk2A7
	 Vly2ewS4fphYImd9I684K0TuVr9FgBGbFsOePYcFYwCpHU0IrjxnkVeibDNvTPWPIY
	 tVTdGduJzyVNtIcmMivZSbd0hT0nJWpdGWJqH+tk9awIiV6NrAxjekGN3xsfqMw/Ng
	 tmud59qMhdGGpbRvwaqUs1AqtJfKbgB3ceE5R4U80/cJdwn1+1wTkv3LviiOmria1h
	 0r63Z8P0M+m+JwHDmwtLV2H3dzhB9jrQdlDL0Pqj1RHOB8pyT2ENaJpmvJjVg0jC7G
	 6lv5DZoF1rudw==
From: Arnd Bergmann <arnd@kernel.org>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: use explicit 64-bit division
Date: Tue, 15 Sep 2026 21:56:40 +0200
Message-ID: <20260915195728.3519469-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

On 32-bit targets, the division of a 64-bit integer by 33 causes a
function call:

arm-linux-gnueabi-ld: security/selinux/selinuxfs.o: in function `sel_read_class':
selinuxfs.c:(.text+0xdcc): undefined reference to `__aeabi_uldivmod'
arm-linux-gnueabi-ld: security/selinux/selinuxfs.o: in function `sel_read_perm':
selinuxfs.c:(.text+0xed0): undefined reference to `__aeabi_uldivmod'

Replace this with an explicit call to div_u64() and div_u64_rem() to
annotate that these are potentially very slow.

Fixes: fc68b6a45f16 ("selinux: convert selinuxfs inode numbers from unsigned long to u64")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/selinux/selinuxfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index f60f92e2ac34..7894a2f480f7 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1573,7 +1573,7 @@ static inline u64 sel_class_to_ino(u16 class)
 
 static inline u16 sel_ino_to_class(u64 ino)
 {
-	return (ino & SEL_INO_MASK) / (SEL_VEC_MAX + 1);
+	return div_u64(ino & SEL_INO_MASK, SEL_VEC_MAX + 1);
 }
 
 static inline u64 sel_perm_to_ino(u16 class, u32 perm)
@@ -1583,7 +1583,11 @@ static inline u64 sel_perm_to_ino(u16 class, u32 perm)
 
 static inline u32 sel_ino_to_perm(u64 ino)
 {
-	return (ino & SEL_INO_MASK) % (SEL_VEC_MAX + 1);
+	u32 rem;
+
+	div_u64_rem(ino & SEL_INO_MASK, SEL_VEC_MAX + 1, &rem);
+
+	return rem;
 }
 
 static ssize_t sel_read_class(struct file *file, char __user *buf,
-- 
2.53.0

