Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAF930C14E
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767057; cv=none; b=AatdilP2lCxzb+2whDw/jvP//Lbp3/lpdwuGS4tHG99XmFvKEjCGRDdLE7GzIajmAIlm6gRJNB+sCVmiT5OYTwHyQrAFYpBtYhr2/pvkzN5JP7s5TbAnOKiDbnDcrYPtcudB/b+qG0LxkNiCCewVnPZjSpJZ84vprmcstUmD+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767057; c=relaxed/simple;
	bh=GvXuMcWFi7bC6vJj97VbrN1gcpg6ApKWlr34ApLFD6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZpKgux4Ot0EeppzGLpabJh7jY6XlJrtYJAiq38PX153/TlzZCyHDElhuvecqvK1I1de4Tl8aTf5yN7MCK8AB8AmQ5jLeNBSA97ogfEsLiCwSqEv3h4KOgvTVI82uSwkZ+R/kql11cP1a4KyZiCHZ/rYymx72oZBwUCFXFTZx3Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RL3UmIDA; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL3UmIDA"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-52b4e988c77so14408581cf.3
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 07:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785767055; x=1786371855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kL9RNowLXftHemxTN7dzDeiq+ZqEF0a12E8Ypd06dRg=;
        b=RL3UmIDAQ3HQBjXqNQdhm1ZwO/m3kUmuV8aA5pYwuXre6ZLSsCQWLfDpkT7f25+EmL
         W+VyMxQeATbGZoB0IHg42laHUwB4YP0CJhE2bCQJm4ujJ/9UuwdoUlXJgN22e8eycmbg
         8Lv53ScQQxq2FcTr8omJ6QacqoGaBwENoQ5TqyGoPz0e/XaGBB2jDy36MeuuPpGGIIuq
         da7KVi5IcjTIIt7syEo36bXcXZ75uZHNV3HUc2SoGn8Ex/0VY3/X8X8GnxSaZNIHoqaX
         3R2bc9v/qaxyMGz/p3bShKAmSI8j8x4z6rfbTi8tvnHtuib+0jOU9MV9ffdYhFro8wMx
         myTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785767055; x=1786371855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kL9RNowLXftHemxTN7dzDeiq+ZqEF0a12E8Ypd06dRg=;
        b=JDEAUD+fXsLOn7DY49kZgQdaCWdUiNIAe3xNB6i9fsgb3GT3RC5BS+IUJAQtK6fzy+
         HTHmIJBF24IE3hsQpEcUs97TsDjZL9cJNRn1LCswDQAUgMpCBzfQpz7T7WakfVCqEp8N
         RlOVt0u8wGazCq0/7DNUno/bKnwSvSHHokTbXX+utVSGXcRIIK2l2BsCqIY2oOGp4yD9
         jWWuS3125bcAX6Ab2Z4+hdwCpijCU1s5Yru6KDF8bZf6d7s447PgWimqDkye3XdqUOPG
         3c34ZLDtCZsexXJv/1HGGlkHmJGwKqYRBp/TmmjTwFBTrxfWZ2LtffagzXr2YjB6ZVqT
         4KWA==
X-Gm-Message-State: AOJu0Yy1iODRGetq4C+0t/bpC00L78QOZ77PSbldzfwbKD8iZiRUpexW
	YH0YC1U7P+RceM+FcGUCgYPr5Z0GvrKQ6+5Jfg0uvdmkbIOtNePaO2/Nf9eANg==
X-Gm-Gg: AR+sD12my8zf+YcspKDuaBHqzcSJxi76uBrjQqzpGX2AOgSiz8ndnelHoq3zbnSBzhp
	rf+7e2Go23Ysr+AfU2BUiwpdB0Ux49sXiG8BKJmngt0bdu0G8G+n+QEuGB9D+uRYFpVHR606xd3
	HLPH8wRBpsARFd7RV3tphDoJGnKmEYYAGrq2DDG9sqMx4UuQeuZmgn7kUyheP8HQ660KVh390kq
	GooUWa6e5YCh/UMd2pq3lPF2LeY60Cw+S66w9V2VVjkUp60YN+CTWkfQ6XGWn/MDC1FFwBKt0hv
	7Ni3I8D7OGWAg1Kw87wYHYFAG8NPIDTgTVCHDlWcQ1EMOBjfoUobS0tEnasrDW58AL2sa3sHk2x
	ocCNKNel54QWTSqW5fQowfP4Gy5nDwe0wKtnKqTBw1ozMMZ2gbubZIvp+zIi8zA7OdSDs0j/TtY
	qyiK9TA4zVLVD8CKBj7L/Nuy9kqtBisKyYtscEzT/PxrCc8cIJm//iWxNgXgI712/HCHC5pEone
	cST0r3Qpq21hd+4MNqh9e5hk26LCI2/Ot5s1HbiHfdd3tquT97G4zvoHzHXyfNr
X-Received: by 2002:a05:622a:1e09:b0:527:7d0f:863b with SMTP id d75a77b69052e-52b566b1503mr202156901cf.12.1785767055159;
        Mon, 03 Aug 2026 07:24:15 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4e7ee6fasm62695531cf.3.2026.08.03.07.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:24:14 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsepol: Cap max depth and processed nodes for cil_tree_walk()
Date: Mon,  3 Aug 2026 10:23:59 -0400
Message-ID: <20260803142359.44099-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cap the max tree depth and number of processed nodes for
cil_tree_walk() to avoid stack overflows and OOM conditions.

Reported-by: oss-fuzz (issue 471608794)
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/cil/src/cil_tree.c | 65 ++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 63dd33dd..17f19256 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -41,6 +41,9 @@
 #include "cil_parser.h"
 #include "cil_strpool.h"
 
+#define MAX_DEPTH (256)
+#define MAX_NODES (1U << 20)
+
 struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node,
 					     char **info_kind,
 					     uint32_t *hll_line, char **path)
@@ -311,25 +314,41 @@ void cil_tree_node_remove(struct cil_tree_node *node)
    extra_args:               any additional data to be passed to the helper functions
 */
 
+static int cil_tree_walk_helper(
+	struct cil_tree_node *node,
+	int (*process_node)(struct cil_tree_node *node, uint32_t *finished,
+			    void *extra_args),
+	int (*first_child)(struct cil_tree_node *node, void *extra_args),
+	int (*last_child)(struct cil_tree_node *node, void *extra_args),
+	void *extra_args, unsigned depth, unsigned *processed);
+
 static int cil_tree_walk_core(
 	struct cil_tree_node *node,
 	int (*process_node)(struct cil_tree_node *node, uint32_t *finished,
 			    void *extra_args),
 	int (*first_child)(struct cil_tree_node *node, void *extra_args),
 	int (*last_child)(struct cil_tree_node *node, void *extra_args),
-	void *extra_args)
+	void *extra_args, unsigned depth, unsigned *processed)
 {
 	int rc = SEPOL_ERR;
 
 	while (node) {
 		uint32_t finished = CIL_TREE_SKIP_NOTHING;
 
+		if (*processed >= MAX_NODES) {
+			cil_tree_log(node, CIL_ERR,
+				     "Exceeded max tree processed nodes (%u)",
+				     MAX_NODES);
+			return SEPOL_ERR;
+		}
+
 		if (process_node != NULL) {
 			rc = (*process_node)(node, &finished, extra_args);
 			if (rc != SEPOL_OK) {
 				cil_tree_log(node, CIL_INFO, "Problem");
 				return rc;
 			}
+			(*processed)++;
 		}
 
 		if (finished & CIL_TREE_SKIP_NEXT) {
@@ -337,8 +356,10 @@ static int cil_tree_walk_core(
 		}
 
 		if (node->cl_head != NULL && !(finished & CIL_TREE_SKIP_HEAD)) {
-			rc = cil_tree_walk(node, process_node, first_child,
-					   last_child, extra_args);
+			rc = cil_tree_walk_helper(node, process_node,
+						  first_child, last_child,
+						  extra_args, depth + 1,
+						  processed);
 			if (rc != SEPOL_OK) {
 				return rc;
 			}
@@ -350,17 +371,22 @@ static int cil_tree_walk_core(
 	return SEPOL_OK;
 }
 
-int cil_tree_walk(struct cil_tree_node *node,
-		  int (*process_node)(struct cil_tree_node *node,
-				      uint32_t *finished, void *extra_args),
-		  int (*first_child)(struct cil_tree_node *node,
-				     void *extra_args),
-		  int (*last_child)(struct cil_tree_node *node,
-				    void *extra_args),
-		  void *extra_args)
+static int cil_tree_walk_helper(
+	struct cil_tree_node *node,
+	int (*process_node)(struct cil_tree_node *node, uint32_t *finished,
+			    void *extra_args),
+	int (*first_child)(struct cil_tree_node *node, void *extra_args),
+	int (*last_child)(struct cil_tree_node *node, void *extra_args),
+	void *extra_args, unsigned depth, unsigned *processed)
 {
 	int rc = SEPOL_ERR;
 
+	if (depth >= MAX_DEPTH) {
+		cil_tree_log(node, CIL_ERR, "Exceeded max tree depth (%u)",
+			     MAX_DEPTH);
+		return SEPOL_ERR;
+	}
+
 	if (!node || !node->cl_head) {
 		return SEPOL_OK;
 	}
@@ -374,7 +400,7 @@ int cil_tree_walk(struct cil_tree_node *node,
 	}
 
 	rc = cil_tree_walk_core(node->cl_head, process_node, first_child,
-				last_child, extra_args);
+				last_child, extra_args, depth, processed);
 	if (rc != SEPOL_OK) {
 		return rc;
 	}
@@ -389,3 +415,18 @@ int cil_tree_walk(struct cil_tree_node *node,
 
 	return SEPOL_OK;
 }
+
+int cil_tree_walk(struct cil_tree_node *node,
+		  int (*process_node)(struct cil_tree_node *node,
+				      uint32_t *finished, void *extra_args),
+		  int (*first_child)(struct cil_tree_node *node,
+				     void *extra_args),
+		  int (*last_child)(struct cil_tree_node *node,
+				    void *extra_args),
+		  void *extra_args)
+{
+	unsigned processed = 0;
+
+	return cil_tree_walk_helper(node, process_node, first_child, last_child,
+				    extra_args, 0, &processed);
+}
-- 
2.55.0

