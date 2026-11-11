Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415275;
	b=4WDyoVzhJAIIesFbq/J0bH+IFDJXMsbDoRjCARZAoZwaralTYm6vXMflttOMNlauRvrE
	 g1SgD7ZWSTj7JZaQJMZpwYKnUqwj7CuC1KX0+x+PUpjb8+egZc7nK6AJVS7b0WCLQ8VfY
	 h5CCtUvDwdrAzR9jkWSIgFLG9ENSr0Gp2gr0kAdel8cD5mccN/IUi64wh9ddDugane3gs
	 VamNlRLLFVmS13Jv6t63MaH/Cfz4EodWBfrW6HCY5o7ReWpLtSJbBja2x+vubG7QqF+2O
	 BR0X71AujrzHRmWT5oDfQSaFBpiN2Kc3OE43DJWJ9IcAqsuGv0+0bk42g0dprUvhXtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415275;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=eigVJWTWEFhE1XDPiE5o3tNVRzMTgTLQNmHl2S3pTKc=;
	b=lej0liJIzrmkXBjKtDtlVbKXxyNFvEvx6UhK4Swr6dcJ7HFF/ZhqvBrNOrlZr+qhHZSH
	 HIa4/y6Le98Ruh5h7rzlYpDJJDQr0cHBCZ2THaMYd53A/v2gWXWHHQY3Fe7BOdGD9TOh5
	 GoF9wcbMtrCwhDBVdNN4s8xSjZSp97tuFxsXelqP3X0MveYneGQNa2hhjOC90Qam/yCtK
	 /y8y6epF/libx4mZWnx2Zz0LqVDQP6/oVh8cCGQOispwGYH+CP6XL/0VNF4Mej/Vp8lCS
	 OjTWSXkK3wuEz5DQ625kI+SfLQ6Y3vH8Sw59xJoIkaOTD8XBO1OKu0+qGUqwuYPUvDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="i/JQGOgo";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8301160A381B;
	Wed, 11 Nov 2026 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i/JQGOgo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C361F00A0A;
	Wed, 11 Nov 2026 16:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415275;
	bh=eigVJWTWEFhE1XDPiE5o3tNVRzMTgTLQNmHl2S3pTKc=;
	h=From:To:Cc:Subject:Date;
	b=i/JQGOgoId9WpcU4KJi5ApdT+ZjUXRoDWWIg8YCZZ1+bSpeORuc71AYOCb4LUGHkM
	 E35ZqEUzKRC9axBfyEeDcTN7x4HTHJQjcGc3QfbqhnCZiQXaYse2bynFrOS3Gc8FU5
	 E5YYP5rRcnS5wvGS696lkI7WnyIb3Yy92SmespOuI06jdEu8tPGuPe594dFvn9SUQ6
	 WRvbWjTeQsCtM7OSeOHUZj5wtuiEIgi+/R4woaYqQBPglv534tdNmy/3um4GdUU8IF
	 KpvVMTfr0rFJDBo3UCZ8QiCOQW6FztH1HS0E62p5SWD/LWs8UCsygqJAJnNCPEGhmJ
	 mUCTP7x5vTCFg==
From: Thorsten Blum <blum@kernel.org>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	=?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Cc: Thorsten Blum <blum@kernel.org>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] selinux: use isdigit() in selinux_genfs_get_sid()
Date: Wed, 11 Nov 2026 17:40:40 +0100
Message-ID: <20261111164040.77543-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=blum@kernel.org; h=from:subject; bh=NLR8mlax5fqJBDWZuTg06qZJtYQ0o2ULj1+y29yVkdc=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlfZnVwsH9zWsJo13C6WeYeTx9D3gk5yfV+ZxX/T/mzf 3nxxr5/HaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjARxQRGho8hNsYhMRNYM96/ nHj06BTtn1Ebt1gdUt3aGbb3Z8i8v+8Z/vD5/r4aELPs9NW/G6c6f9P6XFlg4NfVq3331qaV3em 1vAwA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Use isdigit() to replace the open-coded implementation.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 security/selinux/hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9950f89dfaa2..a6ef4083e671 100644
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
