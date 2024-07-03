Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8988F5B;
	Wed,  3 Jul 2024 02:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719975503; cv=none; b=m+p+4Jek8HtFxZWopM7jCHlZCTDDszise+E+yBLyLzi8eQ8TVJT2vxQO6/n+CI2D/362VmtFxQC45uyuC1k4wW6H6lCzh6ZzMYsTyjXBS2s5AuEdeZzmhjuJXLf79UdGvPUc7CJ9aJqcvjyEjCxhOu9aD3REMHFgIWog4agmj8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719975503; c=relaxed/simple;
	bh=KcTCKrGaxcWsbRGsaJI7Nl8Qg7Q+mVX2FSEUeNgm9Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kg7aDhhPcMTRFJdF5pCZ+yE8EBTwvS0qZIZ01x/wbAoR2zbhLkifqSt8uXC8iC+DWXJxqHQduTPimcQSfEvbx5wz33OTaFE3LozNGXFpor9Pp8MUHKWn00Het8Jq2a1XEVZQZtLPldiFgemTTxPz28PBoZjIOcWsq+6Gbgl37tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp80t1719975388tgk9xerx
X-QQ-Originating-IP: 87guXFkyR+wHKMub1bI8ofl5LcaUpedVsuolA7PCCZ4=
Received: from localhost.localdomain ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Jul 2024 10:56:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4390184663302030326
From: Canfeng Guo <guocanfeng@uniontech.com>
To: paul@paul-moore.com
Cc: stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Canfeng Guo <guocanfeng@uniontech.com>
Subject: [PATCH] selinux: Streamline type determination in security_compute_sid
Date: Wed,  3 Jul 2024 10:56:05 +0800
Message-Id: <20240703025605.63628-1-guocanfeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-0

Simplifies the logic for determining the security context type in
security_compute_sid, enhancing readability and efficiency.

Consolidates default type assignment logic next to type transition
checks, removing redundancy and improving code flow.

Signed-off-by: Canfeng Guo <guocanfeng@uniontech.com>
---
v2:
   Modify the format to follow the generally accepted style for
   multi-line comments in the Linux kernel.
---
 security/selinux/ss/services.c | 36 ++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e33e55384b75..a9830fbfc5c6 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1804,22 +1804,9 @@ static int security_compute_sid(u32 ssid,
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
-	/* Look for a type transition/member/change rule. */
+	/* Set the type.
+	 * Look for a type transition/member/change rule.
+	 */
 	avkey.source_type = scontext->type;
 	avkey.target_type = tcontext->type;
 	avkey.target_class = tclass;
@@ -1837,9 +1824,24 @@ static int security_compute_sid(u32 ssid,
 		}
 	}
 
+	/* If a permanent rule is found, use the type from
+	 * the type transition/member/change rule. Otherwise,
+	 * set the type to its default values.
+	 */
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

