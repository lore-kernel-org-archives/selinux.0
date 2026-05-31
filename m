Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1610F18E02A;
	Sun, 31 May 2026 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780240563; cv=none; b=j81pL5KVLzLxuOWSEJiENudCKBxU7EJ/0dyD2ERl/Xn+yOeg5BXNxrc9hgKtaC01kyc3+BuDQlxcKn4qFzuntl+B7ymybGhgMr5h7HvpbAV4/L+lQUnGmV1m0kBB/9ri33BBqtuCfr1Ef3KvySCOjPHMHPtEazx32Jk6UmEErAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780240563; c=relaxed/simple;
	bh=6GIeMUWLL42mC0pmtBIIiYZlfC5pVVlaldwbVnIj52E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WrblPki5fvCEVGKH7vp8YObmwAvaCvAQxHWXZj2vrDFCt/jsx8e3nTYW88DNbiVCk2TeCyorM+r9mrP4cxJf0A+4Tssd3QNaRJ5eunrxAEVRaa90Vk0qzCx4nndYSLAfglKOpNC3eedfWYjlM8C5kWxh5fDeWRYaxbQdnMV7A3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPK409mn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPK409mn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B248B1F00893;
	Sun, 31 May 2026 15:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780240561;
	bh=HUIMt2USvrXRNmCyTgVh4J7vtxhqsrK2FAMk63fD6kI=;
	h=From:To:Cc:Subject:Date;
	b=NPK409mnG19WePmtDeNtvdGBm5w0QAIpnGSb5ttKNwyFj5TnNMJ5ND4bt/qhCvC6o
	 up6I6eQIkxR0s7kfErgzVxauKQpLRbvzP6WkRmR+nrDYq15lx9WiwuGr99+MfRlzpR
	 8xSnVsEneNxKuh7L5GOBEZne582bIRPhXfyL2wPOP9gdCz7+2ufWDEudWS1ePe/OHm
	 L4IJAFy0lOzTg1KYiuSCl5DJ+Wxl2gKxWJxb2qYQJKu/L/vTOw8PKMfB+0IV0UW71f
	 xQv9bE5q8TAjacCSBVIuInSq8WuNSovGXac8k4AYDeqqZeF7gbkUt70LsJsHLstrAQ
	 FcfCby8fMTpcg==
From: Mike Rapoport <rppt@kernel.org>
To: John Johansen <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	apparmor@lists.ubuntu.com,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] apparmor: replace get_zeroed_page() with kzalloc()
Date: Sun, 31 May 2026 18:15:56 +0300
Message-ID: <20260531151556.1467596-1-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

multi_transaction_new() allocates memory with get_zeroed_page() and uses
it as struct multi_transaction.

The usage of that structure does not require struct page access and it is
better to allocate multi_transaction objects with kzalloc() that provides
better scalability and more debugging possibilities.

Replace use of get_zeroed_page() with kzalloc().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 security/apparmor/apparmorfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index ededaf46f3ca..e5c99c71e7ca 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/ctype.h>
+#include <linux/slab.h>
 #include <linux/security.h>
 #include <linux/vmalloc.h>
 #include <linux/init.h>
@@ -904,7 +905,7 @@ static void multi_transaction_kref(struct kref *kref)
 	struct multi_transaction *t;
 
 	t = container_of(kref, struct multi_transaction, count);
-	free_page((unsigned long) t);
+	kfree(t);
 }
 
 static struct multi_transaction *
@@ -947,7 +948,7 @@ static struct multi_transaction *multi_transaction_new(struct file *file,
 	if (size > MULTI_TRANSACTION_LIMIT - 1)
 		return ERR_PTR(-EFBIG);
 
-	t = (struct multi_transaction *)get_zeroed_page(GFP_KERNEL);
+	t = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!t)
 		return ERR_PTR(-ENOMEM);
 	kref_init(&t->count);
-- 
2.53.0

