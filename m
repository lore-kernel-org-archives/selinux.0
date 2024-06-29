Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77146138C;
	Sat, 29 Jun 2024 04:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719634389; cv=none; b=KciOtGJgg9cc1UYByjUN9NjR71FJVs1t0BJChD9mrfFXff1S7nUmyZrBaQt7F1mMn0BtLTk6w+w5i42PAbKCFjrkWbG+ynmMQfoDC4zWC6FW+3pPw6A7X4UocHHBPcPBFJJv2HpcwftrX68i6xhOSDiZOHeOTa+TDf2vZF54up8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719634389; c=relaxed/simple;
	bh=YFYlSgS1OV4lUJs8i78cTDN6i+WGxOp3JHAv3pxgc1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SSpbd4paqnraTyZ8EVW8/T7Qs84l7rcBg4oso0Ifs+f4Qvb6mq2y5v9jJIJE/nVDIIHVzAkOludiFkWxa20OqPZ5BK6MeDJzlqOIQwuDZVoC37ddqhrisunKi8+rJSRcPhV4meiKOdwtBemHzENK4KaiMhKcseSLQ13oijZsx5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtpip2t1719634293t5w3x04
X-QQ-Originating-IP: 9a1S6nUFmHgEmV9j1jtrBjMRv5FIfv6eaIKI+bpQbsU=
Received: from localhost.localdomain ( [255.2.228.3])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 29 Jun 2024 12:11:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9298459184651821106
From: Canfeng Guo <guocanfeng@uniontech.com>
To: paul@paul-moore.com
Cc: stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Canfeng Guo <guocanfeng@uniontech.com>
Subject: [PATCH] selinux: Streamline type determination in security_compute_sid
Date: Sat, 29 Jun 2024 12:11:24 +0800
Message-Id: <20240629041124.156720-1-guocanfeng@uniontech.com>
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

Simplifies the logic for determining the security context type in
security_compute_sid, enhancing readability and efficiency.

Consolidates default type assignment logic next to type transition
checks, removing redundancy and improving code flow.

Signed-off-by: Canfeng Guo <guocanfeng@uniontech.com>
---
 security/selinux/ss/services.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e33e55384b75..0c07ebf0b1e7 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1804,21 +1804,7 @@ static int security_compute_sid(u32 ssid,
 			newcontext.role = OBJECT_R_VAL;
 	}
 
-	/* Set the type to default values. */
-	if (cladatum && cladatum->default_type == DEFAULT_SOURCE) {
-		newcontext.type = scontext->type;
-	} else if (cladatum && cladatum->default_type == DEFAULT_TARGET) {
-		newcontext.type = tcontext->type;
-	} else {
-		if ((tclass == policydb->process_class) || sock) {
-			/* Use the type of process. */
-			newcontext.type = scontext->type;
-		} else {
-			/* Use the type of the related object. */
-			newcontext.type = tcontext->type;
-		}
-	}
-
+	/* Set the type. */
 	/* Look for a type transition/member/change rule. */
 	avkey.source_type = scontext->type;
 	avkey.target_type = tcontext->type;
@@ -1837,9 +1823,23 @@ static int security_compute_sid(u32 ssid,
 		}
 	}
 
+	/* If a permanent rule is found, use the type from */
+	/* the type transition/member/change rule. Otherwise, */
+	/* set the type to its default values. */
 	if (avnode) {
-		/* Use the type from the type transition/member/change rule. */
 		newcontext.type = avnode->datum.u.data;
+	} else if (cladatum && cladatum->default_type == DEFAULT_SOURCE) {
+		newcontext.type = scontext->type;
+	} else if (cladatum && cladatum->default_type == DEFAULT_TARGET) {
+		newcontext.type = tcontext->type;
+	} else {
+		if ((tclass == policydb->process_class) || sock) {
+			/* Use the type of process. */
+			newcontext.type = scontext->type;
+		} else {
+			/* Use the type of the related object. */
+			newcontext.type = tcontext->type;
+		}
 	}
 
 	/* if we have a objname this is a file trans check so check those rules */
-- 
2.20.1

