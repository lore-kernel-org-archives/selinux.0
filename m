Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62583AC0DE
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617621; cv=none; b=E4gf16ObCmqfiVScRH2/rpCUZS9FOFt3iMRkwGT39LoMjX+bJTxFcOcoeres68Ss9iVFdnE6GbCWpIk382/qwWBtu2WM8r1p9/YcNqf2FKxntTJIapMpNg++tiXqtvh/gGg+pyUXIGbYuP1a/aUYU70H5+l/rc2jStTUH44Efgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617621; c=relaxed/simple;
	bh=n96qLQq+VU8x9pRsg7zWY3iaPS/tk38wDGYsbeMdSXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBn9/6NAfGThoP56+4QS8YjKDNho+kBbR1gjzgpjOtuqvc2iwukHQf58L1S7EcOge6FvXWl2p/d6j2sY6T7jbE2FVQubMwxltZdaFkM9eZxtiAsw7OSTXSMScZZgbMAn58FXPFDHeO2jmLYhbKe13OtUyJqHOWPCCnPHN7qYnqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=aK2sRM92; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="aK2sRM92"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617617;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abz2AbpTRe9xOcMeX7fcW1VVX2ih4RXsbovvuUiwYwk=;
	b=aK2sRM92p74lBnCnptrm70NZzI8lZdnpMW+ulL1qgAdsOZTHEbK8SPXCgwUJH0zq6rIKcc
	VLkDPBr+zNyMBsD8s0OvzuVk7ACXWWpxDAxnUIVOhgtXZiT5shbsio59Z0/yAHmuvbz7n9
	cR2OqJ8e1wMYnh33zH8NySCB6UCThYQ0UM6QRYyyoVd1l6PXnnFmr2e88bpWxLS3Hx1zbh
	OyuLCcjtT+RhIB8VKEzNU3a3mIXSxWDGbrektUDpqXsgYfaGk/hkpcxbG1M6d74mPq6Ob7
	B8tRUqLVlNNOYp3qNf0B0EVRZrCspK/emSYRr/HPBRZTAxoI4DFg6GJV+D5DUg==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 06/32] selinux: use memcpy_{from,to}_le32() in avtab
Date: Mon, 28 Sep 2026 19:46:16 +0200
Message-ID: <20260928174643.2458710-5-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Replace the open-coded endianness conversion loops for extended
permissions with the generic helpers.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/avtab.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 0f94edd01f69..64f9da168f1e 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -479,8 +479,8 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 			pr_err("SELinux: avtab: truncated entry\n");
 			return rc;
 		}
-		for (i = 0; i < ARRAY_SIZE(xperms.perms.p); i++)
-			xperms.perms.p[i] = le32_to_cpu(buf32[i]);
+		memcpy_from_le32(xperms.perms.p, buf32,
+				 ARRAY_SIZE(xperms.perms.p));
 		datum.u.xperms = &xperms;
 	} else {
 		rc = next_entry(buf32, fp, sizeof(u32));
@@ -557,7 +557,6 @@ int avtab_write_item(struct policydb *p, const struct avtab_node *cur, struct po
 	__le16 buf16[4];
 	__le32 buf32[ARRAY_SIZE(cur->datum.u.xperms->perms.p)];
 	int rc;
-	unsigned int i;
 
 	buf16[0] = cpu_to_le16(cur->key.source_type);
 	buf16[1] = cpu_to_le16(cur->key.target_type);
@@ -575,8 +574,8 @@ int avtab_write_item(struct policydb *p, const struct avtab_node *cur, struct po
 		rc = put_entry(&cur->datum.u.xperms->driver, sizeof(u8), 1, fp);
 		if (rc)
 			return rc;
-		for (i = 0; i < ARRAY_SIZE(cur->datum.u.xperms->perms.p); i++)
-			buf32[i] = cpu_to_le32(cur->datum.u.xperms->perms.p[i]);
+		memcpy_to_le32(buf32, cur->datum.u.xperms->perms.p,
+			       ARRAY_SIZE(cur->datum.u.xperms->perms.p));
 		rc = put_entry(buf32, sizeof(u32),
 			       ARRAY_SIZE(cur->datum.u.xperms->perms.p), fp);
 	} else {
-- 
2.55.0

