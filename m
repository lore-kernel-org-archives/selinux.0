Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0198A3B4EA5;
	Wed, 20 May 2026 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779265167; cv=none; b=rjVcbPXAHKV2CZULk9yjpwm+A2tRF5F4/osbjJWqpoyWcCpQy+/GM6pQ3f/uBoLJj4Mkg+n91ddipZNCzQdLMmBm4fTcgQr8JGXdlKdCkhZss8VxuhgVignowIFZPhcxnaXAinPtcnD/GL8b+t5zqt5la0jBgil9nqSIHpd8tQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779265167; c=relaxed/simple;
	bh=+ey+joQwrn1qEqiykmTx8dcM/5TMNFhXgYB3MVPrqgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EqO36U48QLRZ/TE80EIabhU7HwjvmImGRRPlPHA5wX8tvmLsF7PPIk1S2SyORrjHw1WyIQRnGvz35N0n8rEfJbqrRrw+Rrn4IcGM9hF0jX9j9ejKkgBLixO1oxtq+7Q2AKuM2kljK/ASJCV66G6fYonJoSEDLLeA+ynwxWYObXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhrtBEWS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhrtBEWS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D39A1F00893;
	Wed, 20 May 2026 08:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779265164;
	bh=z/4rfPWQ5HkZJZbwpLmw5R+Mmu26rwOzXYpZdnVV9Dk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dhrtBEWShLy1GXu88WxKJts8sqyBs3VBaS/0WLRV9zaUqdWgXLHfayljVW97Fzzt4
	 7RtyF7wImuoFzhQU2h1L/9hdvim4iIBcz+tYzmJARLjMnGtyMGEVbK6TanLVgv5ezd
	 pl2W90AdTAhfQYtdHrNc/ZaD6QYOJsb+tmCa4s+FcbkkL1YVX+LulzmbDC0pnq4PMo
	 DOm/1SfLkw4tBV6zjcUB1mSnHQb6DFgEY8+1JAf3u3TUVlgsOTyhBBEs84dzpl+0hv
	 Io6iD2BfJBbqMYv94X1UXa0e+rWghxaGSLk/NiWOlAMkORwV4u37I9g6gA5eJAi3h2
	 jYSNBO2FU/hAg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 20 May 2026 11:18:57 +0300
Subject: [PATCH 3/3] apparmor: replace get_zeroed_page() with kzalloc()
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-security-v1-3-831bd8e21dd0@kernel.org>
References: <20260520-security-v1-0-831bd8e21dd0@kernel.org>
In-Reply-To: <20260520-security-v1-0-831bd8e21dd0@kernel.org>
To: James Morris <jmorris@namei.org>, 
 John Johansen <john.johansen@canonical.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>, apparmor@lists.ubuntu.com, 
 selinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-security-module@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580; i=rppt@kernel.org;
 h=from:subject:message-id; bh=+ey+joQwrn1qEqiykmTx8dcM/5TMNFhXgYB3MVPrqgk=;
 b=owEBbQGS/pANAwAKATkDhibLDv2RAcsmYgBqDW58nz384TTzPZOUrhMG7PeyvhDRvKQD8RIHd
 PLEfs78XJeJATMEAAEKAB0WIQR45VhVpZkvn3TRr+k5A4Ymyw79kQUCag1ufAAKCRA5A4Ymyw79
 kTbyCACtJ9ZYDN3YybRMNR2UBnLXfQyIAs1SRXhO192EBvmpN0Vt1m1sNk+uZlH2OVV5dTRBzer
 ZUVu6/sROZL71OF1VFySzWa2xD3gLaKVlDyPHe7gMBIdFhQXjQSEkzNGbSjvJOMChXiBsUYfHoP
 8/amlGCtmTomdv0rSvCj0jqMgMKqzQRqkZNjEH90UwnQthW1EMjaZxKlluFPBguq2912ZX3N37M
 39ADj+W0iqAhCINM5YCk/d6G5x1kKmOGD0cVEdms7dn/8CLb7b/5BGRj4tIG1uoK+Yn+hh31hYu
 1+YvsR3KShRortBO77alQvQ9eR/1ZUROdSNcuV07i91Ita/k
X-Developer-Key: i=rppt@kernel.org; a=openpgp;
 fpr=B8E96E880C4A40C3C1255AA8C532392DE6DA7CE9

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

