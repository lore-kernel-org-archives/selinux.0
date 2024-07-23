Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4708D155738
	for <selinux@vger.kernel.org>; Tue, 23 Jul 2024 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745732; cv=none; b=SgFYSP2PbVWJ9HM7a7nCFTOZE/bprckOY9c56TQPmloXAi+qe2hgFAUwegu0FEMpsgN72BkrXwO4Qi+GqIriU8RZMjo/TRCeS8wbt2HKqFu4RNBz0RrI4t3AZe515B5zxKmhmhUnJ+mrlQ218z0kmfQ30oxNyA5tcxbjyyrSOnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745732; c=relaxed/simple;
	bh=LFPf+1/ORWE4Xu/R6roAiUOeZlh9MW3bg6nZHc3byiM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AQqI+U3kFWKxRrTFbitOX4sF9fiF+REiJ+kmm5lv5jJl8XnxeZKGI7n5Sobf5x2q9YXXMLq1X1piqysi3dSBIk96V2VoArlSxC9dU73r6pk1rDDa8LxB3Hj0oqEDocOm9mvxZcv+WlH+RigA0vx/s8Xn3nABAq4KlZlacp4Li/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YXTCJg3o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXTCJg3o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721745730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rr9xu3RC97JecqDBFUZLRiZjzRLRL3WIK7JJac8zngE=;
	b=YXTCJg3o3yDzTlI5jBcwxvve4lTMWbDxRJxymoMxg4C82MMZNSJseiUjKS89lLtd3EItQt
	c7rwwAaTHpqru30Y69ZLMkuaX5YGk9FBrMKMm5LQfW0HpIlKB56arbq+Eckrl+Cy8CbVKl
	TRt+ev9DBtvCiN3X4E/duiTH1yt19kw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-DxkJqt-2PqKoyaU-0K9x8g-1; Tue,
 23 Jul 2024 10:42:08 -0400
X-MC-Unique: DxkJqt-2PqKoyaU-0K9x8g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC62A1955D4D
	for <selinux@vger.kernel.org>; Tue, 23 Jul 2024 14:42:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A6FEA1955D44
	for <selinux@vger.kernel.org>; Tue, 23 Jul 2024 14:42:06 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] libsepol/cil: Check that sym_index is within bounds
Date: Tue, 23 Jul 2024 16:41:57 +0200
Message-ID: <20240723144157.1242699-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Make sure sym_index is within the bounds of symtab array before using it
to index the array.

Fixes:
  Error: OVERRUN (CWE-119):
  libsepol-3.6/cil/src/cil_resolve_ast.c:3157: assignment: Assigning: "sym_index" = "CIL_SYM_UNKNOWN".
  libsepol-3.6/cil/src/cil_resolve_ast.c:3189: overrun-call: Overrunning callee's array of size 19 by passing argument "sym_index" (which evaluates to 20) in call to "cil_resolve_name".
  \# 3187|                   switch (curr->flavor) {
  \# 3188|                   case CIL_STRING:
  \# 3189|->                         rc = cil_resolve_name(parent, curr->data, sym_index, db, &res_datum);
  \# 3190|                           if (rc != SEPOL_OK) {
  \# 3191|                                   goto exit;

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 427a320c..da8863c4 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -4291,7 +4291,7 @@ int cil_resolve_name_keep_aliases(struct cil_tree_node *ast_node, char *name, en
 	int rc = SEPOL_ERR;
 	struct cil_tree_node *node = NULL;
 
-	if (name == NULL) {
+	if (name == NULL || sym_index >= CIL_SYM_NUM) {
 		cil_log(CIL_ERR, "Invalid call to cil_resolve_name\n");
 		goto exit;
 	}
-- 
2.43.0

