Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633646BF;
	Sat, 29 Jun 2024 04:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719634365; cv=none; b=jAHS3Wt/QoYbYtKhRkq0foV1zKZt1OKaNMG+2Q+6gFhtWFydX+t0xZyal7ifC7NHxau0RpDPCDXMtb6qs4cJzRKdCe6Klt0OC3KgsUTkENQP4dL4PQA86BQzA6iW9BZDbDFRC7mKEwJWbZZqruwz9tOtXOTLt3rmOC5/slORJ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719634365; c=relaxed/simple;
	bh=7F44S04D8sO+SNIdtQW4MRiC44zEGnnyTJ3Sb0UzmK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nXVrV6bAxzrlv1NBp2ppzsHw8lPNWGerZcGvQMQoOkZmLLdIHQTZ8eWc64ligZ4IvBQodAApudM9qJJX3tyX4ya5Dfp25wm8ybDUZLJa7n8IU8YQm7VlVbsUSOTimKgcPzrOf5HpFEsd+RC93ZL6sEFXAbo/wJWm+tNrDEmXsvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtpip1t1719634224tq5bi0l
X-QQ-Originating-IP: bIqqh9CohlPIc1YcIiMrYopTDJj2nflXs3dX8lRFWDo=
Received: from localhost.localdomain ( [255.2.228.3])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 29 Jun 2024 12:10:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12981802212269830187
From: Canfeng Guo <guocanfeng@uniontech.com>
To: paul@paul-moore.com
Cc: stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Canfeng Guo <guocanfeng@uniontech.com>
Subject: [PATCH] selinux: Use 1UL for EBITMAP_BIT to match maps type
Date: Sat, 29 Jun 2024 12:10:12 +0800
Message-Id: <20240629041012.156495-1-guocanfeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-0

This patch modifies the definition of EBITMAP_BIT in
security/selinux/ss/ebitmap.h from 1ULL to 1UL to match the type
of elements in the ebitmap_node maps array.

This change does not affect the functionality or correctness of
the code but aims to enhance code quality by adhering to good
programming practices and avoiding unnecessary type conversions.

Signed-off-by: Canfeng Guo <guocanfeng@uniontech.com>
---
 security/selinux/ss/ebitmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index 24d7d8b3cda3..ba2ac3da1153 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -29,7 +29,7 @@
 	 sizeof(unsigned long))
 #define EBITMAP_UNIT_SIZE BITS_PER_LONG
 #define EBITMAP_SIZE	  (EBITMAP_UNIT_NUMS * EBITMAP_UNIT_SIZE)
-#define EBITMAP_BIT	  1ULL
+#define EBITMAP_BIT	  1UL
 #define EBITMAP_SHIFT_UNIT_SIZE(x) \
 	(((x) >> EBITMAP_UNIT_SIZE / 2) >> EBITMAP_UNIT_SIZE / 2)
 
-- 
2.20.1

