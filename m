Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96DF1E5201
	for <selinux@vger.kernel.org>; Sun, 31 May 2026 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780252894; cv=none; b=EwWGc9wfF7QVjrByT/RotzE4ACPq157qqUbq8r4BchmIjT5dAsrqrC1AsJtLEUXkmOhueuAkUW2+o4rkA3pILEVMTYnBTj9/5LB1q4vm4N1MTEiUJHIJsFd2Ns0zwpG0F5JcmhmQeQNqmxewHXmbBQ2alWu6UUlv2R+zZGmgoro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780252894; c=relaxed/simple;
	bh=aydaJw6TfrwQKY6LqHl1KslEztaaXCqetc8V4xNP+VI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jk1VCdlPCq7yCvgeVLllWvcPOxqjb+zD+mYIhQ64le96zWMeoUGz2IFMQJ4p38mf3t786OObs0WkFCUVjKBKco4YA1+laFwCA+GjxhRb3PPGT6bxBHGAUakHRWjqFKSx3XMQUylsXao/gq6HaU8aJVzaIec4ytx98r28f+MtEGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk; spf=pass smtp.mailfrom=posteo.uk; dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b=NXUH3SF3; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b="NXUH3SF3"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 32333240103
	for <selinux@vger.kernel.org>; Sun, 31 May 2026 20:41:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.uk; s=2017;
	t=1780252889; bh=/n+gHOI94kevLkh9NEDKr+eBzz9pH9ydwdOyIo3sOTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=NXUH3SF36/Ss8PCyGZuXI5Brklv/ef5c/x5gLstbVj/6xmWte0jd3LbNnE7+anpEn
	 NaQvvtU8QBmRpYiEuB6UoLiFTg278cj5kCKVDWVQn9N1UmC2QvX0jHEy9L35PftRHE
	 GHTaPcO/gUuHrwNbIuXU35OnR1Hq14sAVcwP4FwGUCnsGKiHostwpIY/jVU7lEtcUQ
	 Z62pr11zxzrTkf8UZ5uzOFrModzTAWfcRgxNMfF0z/cr7TycZP6Lr/izlsCbhvzNN1
	 6wsac2leF5UhFpvknuVSFCfGrTWAZN2tUCv0hsY+kmpo5STyBVTKQDqMWQgpQ0Rt8d
	 SVOWExKYr8awg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gT5XR1RvMz9rxM;
	Sun, 31 May 2026 20:41:27 +0200 (CEST)
From: Rahul Sandhu <nvraxn@posteo.uk>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	Rahul Sandhu <nvraxn@posteo.uk>
Subject: [PATCH] libsepol: cil_resolve_ast: add in a CIL_SRC_INFO for the copied data
Date: Sun, 31 May 2026 18:41:27 +0000
Message-ID: <20260531184111.691569-2-nvraxn@posteo.uk>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2073; i=nvraxn@posteo.uk; h=from:subject; bh=aydaJw6TfrwQKY6LqHl1KslEztaaXCqetc8V4xNP+VI=; b=owGbwMvMwCmc0Xus8aefgg/jabUkhiyZhuN5Z018hfduj/N1FRLiaPy6l2VBTXK1vuzR06Ucu z8o2UZ2bGRhEOZksBRTZNm/j+1GydO5v48+ed0BM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ Ahk6RgxcnAIw1ftOMDbcFMw8s8EmpIBBMKUruVjmTdNhvakbf2fzchzrKZnSOn2ews2v5RbRtzU ONU4S0hd4tJSxhpPF2eOy3MPJD8/pXb9mnSt3+8lbzZv9rGvlA/YoiL0+9kV6h0/u53zp5R07kp kFhdfdBgA=
X-Developer-Key: i=nvraxn@posteo.uk; a=openpgp; fpr=BFBE06D874E59DFBC5E4EB88688DC681F94E204C
Content-Transfer-Encoding: 8bit

Ownership of the data copied in from an in statement currently resolves
up to the parent block. This is because when looking up a corrosponding
path with cil_tree_get_cil_path(), the chain is walked up until a valid
match is found from cil_tree_get_next_path(). However, as the content
that is inserted into the block does not originate from the same file
as the file where the block is instantiated, insert a CIL_SRC_INFO node
so that for said content it is a src_info node with the original file
attached that is matched.

Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>
---
 libsepol/cil/src/cil_resolve_ast.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 048b3aaa..af612f63 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -2375,6 +2375,8 @@ int cil_resolve_in(struct cil_tree_node *current, struct cil_db *db)
 	struct cil_in *in = current->data;
 	struct cil_symtab_datum *block_datum = NULL;
 	struct cil_tree_node *block_node = NULL;
+	struct cil_tree_node *src_node = NULL;
+	struct cil_src_info *info = NULL;
 	int rc = SEPOL_ERR;
 
 	rc = cil_resolve_name(current, in->block_str, CIL_SYM_BLOCKS, db, &block_datum);
@@ -2395,6 +2397,27 @@ int cil_resolve_in(struct cil_tree_node *current, struct cil_db *db)
 		}
 	}
 
+	char *path = cil_tree_get_cil_path(current);
+	if (path != NULL) {
+		cil_src_info_init(&info);
+		info->kind = CIL_KEY_SRC_CIL;
+		info->path = path;
+
+		cil_tree_node_init(&src_node);
+		src_node->parent = block_node;
+		src_node->flavor = CIL_SRC_INFO;
+		src_node->data = info;
+
+		if (block_node->cl_head == NULL) {
+			block_node->cl_head = src_node;
+		} else {
+			block_node->cl_tail->next = src_node;
+		}
+		block_node->cl_tail = src_node;
+
+		block_node = src_node;
+	}
+
 	rc = cil_copy_ast(db, current, block_node);
 	if (rc != SEPOL_OK) {
 		cil_tree_log(current, CIL_ERR, "Failed to copy in-statement");
-- 
2.54.0

