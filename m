Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224A414830D;
	Wed,  7 Aug 2024 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723021375; cv=none; b=A95Tt8qBa6efPcyOBCsRxtL5RTCEOlh/O3se5Z3YTgJUfCu857/JUVuXmxLSgN+5GN7H7reD3Z+OmoAhOYYdR5AeNVgfk1fgT2yR3tV4azHqLInq6paW3Q5jT+vEnNTRHAERhIkJ/1PrjTwWuEIlKBfyMIb5MMUR+OmmExblsAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723021375; c=relaxed/simple;
	bh=xzhHFHcb7UuLRyfh0UFzP1f/dPS1wijKca0bb5EF7Wg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ny/rWXXH1H7SJWo9X553aZSpjc1pMHeHAnX9TFrrk9ekcoZxUzjwiUiOz3YvCbx+SWszREZpFIBAbN6AjeWDzAC2qo6o4ek2cg8TzRdM0DM69f98qLGZgLFQRh0a1RJeQkLsRkqXbGWYn+ZPgVYc8iGJBRKF90N6JnVHt8boDmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wf41y0B2Xz4f3jXS;
	Wed,  7 Aug 2024 17:02:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5AD531A0568;
	Wed,  7 Aug 2024 17:02:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UwOLNmv1QMBA--.20288S4;
	Wed, 07 Aug 2024 17:02:43 +0800 (CST)
From: thunder.leizhen@huaweicloud.com
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
	Nick Kralevich <nnk@google.com>,
	Jeff Vander Stoep <jeffv@google.com>
Subject: [PATCH 1/1] selinux: add the processing of the failure of avc_add_xperms_decision()
Date: Wed,  7 Aug 2024 17:00:56 +0800
Message-Id: <20240807090057.1334-1-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHr4UwOLNmv1QMBA--.20288S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JFy8Zr15JFy5Ww15WryDWrg_yoWkJrX_Ca
	4kuw1ktr18ZF4ftwsrAF4fZr1Sgr48Grn5C340yw1fA3W7Jws5Jrnaywn5XryUW3yrCrZx
	KFsxW3s2vwn7XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbckYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267
	AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
	ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUAVWU
	twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07U_HUDUUUUU=
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/

From: Zhen Lei <thunder.leizhen@huawei.com>

When avc_add_xperms_decision() fails, the information recorded by the new
avc node is incomplete. In this case, the new avc node should be released
instead of replacing the old avc node.

Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 security/selinux/avc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 7087cd2b802d8d8..b49c44869dc4627 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -907,7 +907,11 @@ static int avc_update_node(u32 event, u32 perms, u8 driver, u8 xperm, u32 ssid,
 		node->ae.avd.auditdeny &= ~perms;
 		break;
 	case AVC_CALLBACK_ADD_XPERMS:
-		avc_add_xperms_decision(node, xpd);
+		rc = avc_add_xperms_decision(node, xpd);
+		if (rc) {
+			avc_node_kill(node);
+			goto out_unlock;
+		}
 		break;
 	}
 	avc_node_replace(node, orig);
-- 
2.34.1

