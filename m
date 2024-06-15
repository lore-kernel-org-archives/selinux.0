Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B114087C
	for <selinux@vger.kernel.org>; Sat, 15 Jun 2024 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718457949; cv=none; b=ni6mGfR7T6F/00jawR9e9LtQtbK6pSV3pdW7Y7czpJAWo4tkV6cnd+7Ruy7v3mmh1qNKMmewqB4rwQCTuQtrEzOXcxHqt9GSOgF1tLcDZSfeIAIMoMKA+qk8u2AHcsJiPBulDI0BYjDQ8zwsd9yX55TkL4Y54NSDZuuYRcEjQis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718457949; c=relaxed/simple;
	bh=vNg+qXFNck9HnjNzznKHnHAEFowFBNLDqJZHtX02+AY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n+6lLWajL2s05rnyjyudJqxJYanP9LtjBoJYt61wuGd+BISGMS+nMaqp2AAiWpLK+WVmKd5jE74Nltdm1+mjJH8ZglVUfBLeT1+w2pDJC6AEIGpgOH0fHgJZ6+ZVdYTlPaxpq5TWooSCQ85iphJHo/9YKgDdjl26ct+Hq2Lltk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=DTSYTZWP; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="DTSYTZWP"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1718457936;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=O0a52u5b++0bPWnFDNrNy8IiEpFxAG4qdw6juhDEyXw=;
	b=DTSYTZWPj1ZWncr4JdqT0dUmfmEWMSioVMuya0VQ/zMW7vM+KSfDRK8J4ELTzlAF4llVKa
	6QcYkRFeSJ9Gus9zG6MD/LxrqbY43wG1NcBKgw0/3kc5hRUNws7eqI0afaIl/Pilgo6E3d
	1ivuxnx3NlaX63xJz2UVI+EL7i7XPaGd+z7Ump7y2SzrWBGtXsbquMBaU/HEWb8GdNseuR
	uLXc8Tx1wQIMM4jtAzalS/rNC6pNy8UqSmsqGvV/KnrSgKQR4GUZWO2YHU/00I8PtUlNxJ
	KxkjBVv4HueuuaQV/viS1+O2Zbdd0Obk/riIRv8BCQLqvYaDLBRHoHWZJKzC6Q==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libsepol: check scope permissions refer to valid class
Date: Sat, 15 Jun 2024 15:25:25 +0200
Message-ID: <20240615132525.36358-1-cgoettsche@seltendoof.de>
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

Validate that the permission maps in the scope index refer to a valid
class datum.  Otherwise since commit 52e5c306 ("libsepol: move unchanged
data out of loop") this can lead to a NULL dereference in the class
existence check during linking.

Reported-by: oss-fuzz (issue 69655)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 9746f562..0216410c 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1467,6 +1467,8 @@ bad:
 
 static int validate_scope_index(sepol_handle_t *handle, const scope_index_t *scope_index, validate_t flavors[])
 {
+	uint32_t i;
+
 	if (!ebitmap_is_empty(&scope_index->scope[SYM_COMMONS]))
 		goto bad;
 	if (validate_ebitmap(&scope_index->p_classes_scope, &flavors[SYM_CLASSES]))
@@ -1483,8 +1485,10 @@ static int validate_scope_index(sepol_handle_t *handle, const scope_index_t *sco
 		goto bad;
 	if (validate_ebitmap(&scope_index->p_cat_scope, &flavors[SYM_CATS]))
 		goto bad;
-	if (scope_index->class_perms_len > flavors[SYM_CLASSES].nprim)
-		goto bad;
+
+	for (i = 0; i < scope_index->class_perms_len; i++)
+		if (validate_value(i + 1, &flavors[SYM_CLASSES]))
+			goto bad;
 
 	return 0;
 
-- 
2.45.1

