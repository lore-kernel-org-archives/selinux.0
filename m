Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01E914A08F;
	Thu, 22 Aug 2024 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724335805; cv=none; b=YhM3/2ZwY0PgJwECoPB924iIf680dojvro343AXhfh6Exc/4OHEQJhZzOto2YyECpGN358fnSXUgL07JwjVBx6ukzQXO0yxfp65Qh85H8BiuihEOWrDnLp1izX6YrUvFgDG7yUkhsJG9No4Y9iAlzwY3H/XwXa5ym8Y8nlsEcOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724335805; c=relaxed/simple;
	bh=3XzqPt5Wor/47stQV0ZO4HNZEv39caFPd1KPaBt65M0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t5bk0U3eEFHuOwcllJSxT7/cek++Dje3kgSD95ZncmgvrjOrbkMMfQ/L+n749gJZuPf5mSAnyTyFRlWYHTO1QmyyiF6pnRMZt+04WXZHmg74Ddhh8o9r42RGEIsN8YMwkC3G5nkZfJC24o4iQxa49YAMojMrkdtMtr9rAYCmTsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WqQ2M6VHzz20m3V;
	Thu, 22 Aug 2024 22:05:15 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id CD90514013B;
	Thu, 22 Aug 2024 22:09:58 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 Aug 2024 22:09:58 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley
	<stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>,
	<selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] selinux: simplify avc_xperms_audit_required()
Date: Thu, 22 Aug 2024 22:08:58 +0800
Message-ID: <20240822140858.1998-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100006.china.huawei.com (7.185.36.228)

By associative and commutative laws, the result of the two 'audited' is
zero. Take the second 'audited' as an example:
  1) audited = requested & avd->auditallow;
  2) audited &= ~requested;
  ==> audited = ~requested & (requested & avd->auditallow);
  ==> audited = (~requested & requested) & avd->auditallow;
  ==> audited = 0 & avd->auditallow;
  ==> audited = 0;

In fact, it is more readable to directly write zero. The value of the
first 'audited' is 0 because AUDIT is not allowed. The second 'audited'
is zero because there is no AUDITALLOW permission.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 security/selinux/avc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index b49c44869dc4627..21f5bbba50caaeb 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -396,7 +396,7 @@ static inline u32 avc_xperms_audit_required(u32 requested,
 		audited = denied & avd->auditdeny;
 		if (audited && xpd) {
 			if (avc_xperms_has_perm(xpd, perm, XPERMS_DONTAUDIT))
-				audited &= ~requested;
+				audited = 0;
 		}
 	} else if (result) {
 		audited = denied = requested;
@@ -404,7 +404,7 @@ static inline u32 avc_xperms_audit_required(u32 requested,
 		audited = requested & avd->auditallow;
 		if (audited && xpd) {
 			if (!avc_xperms_has_perm(xpd, perm, XPERMS_AUDITALLOW))
-				audited &= ~requested;
+				audited = 0;
 		}
 	}
 
-- 
2.34.1

