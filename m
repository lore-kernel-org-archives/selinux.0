Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29362E06E6
	for <selinux@vger.kernel.org>; Wed, 22 Apr 2026 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861095; cv=none; b=ihqwUpyQOlgak9sJlwHhXERfzMVPmc+oOXweSBELu1hs9ywjHVOhDXbAmRxRB6JIv/vxoVHJVkuqj+Zb6Y2SzCiVJBXb/5A5XGEMwuHUKImp5tE8TE5YsbRToFpVsiedFACREV6Xj2EKvQU+IqIVnVwOcvk5eIAUwwtACNAxPik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861095; c=relaxed/simple;
	bh=PQV5e3P+iGAGSd2ipdezzuemftUGnUjd+ijnxmGSIPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XMnXNGQogb2IzKA/D+d/mmglBMdsJ4fqxma2ezMUj2V/M0DLnjq8Lp7t3WBPo5wBzaXiQ+AJJf8+gExQWVmAxwbMLv6RLqBIP/hhhX8KZ9fi1MVtGOACw6e/ihOy2KGsUEcAQwI5HcqsHETyDCfoAXOGfv7Vw318aoWz2iV01HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JpUt/ijR; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JpUt/ijR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776861091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2tE9Vj4jOyB73NaDxE4KPkou4uRk7xe0CW6/jvEFcVM=;
	b=JpUt/ijRMAHSqLMf01F41FJM2U7MUkhFolUPEKnKyYVb8CnXfO4pdGKvM/8y69f1iaQwsq
	/fgZTXRYnexI9AjtFkipWMN+J5CUfF8YftPTGEGyVJfD9wYPkCZC2xu5fVaUd0ZVzhI4Mj
	8XwVrd981ejJ1Uiztkxh0Wz2E4HlLzU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: use QSTR() instead of QSTR_INIT() in init_sel_fs
Date: Wed, 22 Apr 2026 14:31:06 +0200
Message-ID: <20260422123104.100014-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=680; i=thorsten.blum@linux.dev; h=from:subject; bh=PQV5e3P+iGAGSd2ipdezzuemftUGnUjd+ijnxmGSIPk=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJkv9necYcptWWktUpz4kDn+a/5u4XXrfWo2turvclzm3 d6cfmNyRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEzkkB7D/+SY3Zuko5iz8qwU JgfMrGJZwTdt35Toe+3nVtWapCvO+crIcPFNcu6lnTcvS/48fObnx+jLqnJvZk4KOCG982BAgPz Zd5wA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Drop the length argument and use the simpler QSTR().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/selinux/selinuxfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 83aa765a09f9..8c107af5140e 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2107,8 +2107,7 @@ struct path selinux_null __ro_after_init;
 
 int __init init_sel_fs(void)
 {
-	struct qstr null_name = QSTR_INIT(NULL_FILE_NAME,
-					  sizeof(NULL_FILE_NAME)-1);
+	struct qstr null_name = QSTR(NULL_FILE_NAME);
 	int err;
 
 	if (!selinux_enabled_boot)
