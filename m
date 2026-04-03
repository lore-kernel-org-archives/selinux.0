Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4193502B8
	for <selinux@vger.kernel.org>; Fri,  3 Apr 2026 06:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775199394; cv=none; b=uyWfM/jjlMnfaU12VZqhihzYNr5MlO99uzmISuRNe3HZ8mpYEUG3S7j/+MTJke9tjE+MxzDrHcmdGmpQtyEF0Qy1ldcbZIX+9UrfGqcNvffPgxblDRHH/kH9oJgqifgWB0LDL5U7hBTPofkY7iOF/TZvwPGh0b4ZkNRNnyrK2d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775199394; c=relaxed/simple;
	bh=fe+G56N1fkq47e9AXSJTiIV2rcXpQ7AcHCrvQQ7mN80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPcSEyq7O9hUEGDw1vCfVgjape/CsKfTTZrl2f0zvZTs0FyOpSBFDH+2Vv7nyeUePRbjR8TFga4/U04jLCqyfMbg/D9z/96OW252kL7WL4GXQb2S3RxuvvnIt9E3frfXJ3AL4AiYhqWktkAYpor6xpyYcvLpbEIg2ApZOeUvQvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk; spf=pass smtp.mailfrom=posteo.uk; dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b=Bo8BD6CD; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b="Bo8BD6CD"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 9AF51240027
	for <selinux@vger.kernel.org>; Fri,  3 Apr 2026 08:56:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.uk; s=2017;
	t=1775199391; bh=MW0RQjX8PoOn9aULro1VKqOggu+ci2nj+RoDOufhLb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=Bo8BD6CD/2objZXsn8gEJliUADVQobmOfA6A7oSQYW3Agw9IBWrz2eN8LeQHnWCpP
	 TC5zLKk9pJpNzeQjM6QkASi1v8ykhC8Vsm+sLlo17Zh7p7Cr/ZCARAY/3Ajg6Sz2ga
	 0+Em8pknLUAw2DU44mDXVF6I/d9eukcamRX8dS7AEP0m3D/kGIeu/yfv5MAGnkI1y6
	 j/S3MTPhNemXqlxbKHoBJtg+0r0+LFM7oQJrcoPcNgkB5n0UV9dBU4oQt0ECkT+l85
	 EFsF2Bez8l5jSh4mbjFz424RR4fDUrBzyGvi1M5WeEneENTwz9ejv+DPc+9ycjC6X6
	 3CPqP0FFiCqyA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fn8dq0tjbz9rxD;
	Fri,  3 Apr 2026 08:56:31 +0200 (CEST)
From: Rahul Sandhu <nvraxn@posteo.uk>
To: nvraxn@posteo.uk
Cc: nvraxn@gmail.com,
	selinux@vger.kernel.org
Subject: [PATCH v3] libsepol: policydb_read(): use a static string for policydb_str
Date: Fri, 03 Apr 2026 06:56:31 +0000
Message-ID: <20260403065618.2172556-2-nvraxn@posteo.uk>
In-Reply-To: <20260403065234.2172150-2-nvraxn@posteo.uk>
References: <20260403065234.2172150-2-nvraxn@posteo.uk>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2215; i=nvraxn@posteo.uk; h=from:subject; bh=fe+G56N1fkq47e9AXSJTiIV2rcXpQ7AcHCrvQQ7mN80=; b=owGbwMvMwCmc0Xus8aefgg/jabUkhszzKZM2nZTS1dV/d+3Xvt2KO34vf6ieNEto+t8HCxxOr g561nuHsWMjC4MwJ4OlmCLL/n1sN0qezv199MnrDpg5rEwgQ6RFGhiAgIWBLzcxr9RIx0jPVNtQ zxDI0DFi4OIUgKnedIaxYSGD+RKF6qJyD+mbSvdPG6V0aqc90dA7O6u0ttTmoGOiaNEX4SzOrTf FHiqGuh/9c3MFY8MpJsWm+rfGj77uPPv3f1Dpsa2zgn+esW/p/vFJWbBmy1G5B8r/78nunt4jcP hr1Uz/dXsB
X-Developer-Key: i=nvraxn@posteo.uk; a=openpgp; fpr=BFBE06D874E59DFBC5E4EB88688DC681F94E204C
Content-Transfer-Encoding: 8bit

We know the maximum possible size of policydb_str at compile time; it's
POLICYDB_STRING_MAX_LENGTH + 1 (with + 1 accounting for the null term).
As POLICYDB_STRING_MAX_LENGTH is trivially small, make it a static str,
avoiding an extra allocation.

Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>
---
 libsepol/src/policydb.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

v3: fix authorship mess

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 9760b164..8d290d86 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -4192,7 +4192,7 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 	unsigned int i, j, r_policyvers;
 	uint32_t buf[5], nprim;
 	size_t len, nel;
-	char *policydb_str;
+	char policydb_str[POLICYDB_STRING_MAX_LENGTH + 1];
 	const struct policydb_compat_info *info;
 	unsigned int policy_type, bufindex;
 	ebitmap_node_t *tnode;
@@ -4222,16 +4222,9 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 		return POLICYDB_ERROR;
 	}
 
-	policydb_str = malloc(len + 1);
-	if (!policydb_str) {
-		ERR(fp->handle, "unable to allocate memory for policydb "
-		    "string of length %zu", len);
-		return POLICYDB_ERROR;
-	}
 	rc = next_entry(policydb_str, fp, len);
 	if (rc < 0) {
 		ERR(fp->handle, "truncated policydb string identifier");
-		free(policydb_str);
 		return POLICYDB_ERROR;
 	}
 	policydb_str[len] = 0;
@@ -4248,22 +4241,16 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 		if (i == POLICYDB_TARGET_SZ) {
 			ERR(fp->handle, "cannot find a valid target for policy "
 				"string %s", policydb_str);
-			free(policydb_str);
 			return POLICYDB_ERROR;
 		}
 	} else {
 		if (strcmp(policydb_str, POLICYDB_MOD_STRING)) {
 			ERR(fp->handle, "invalid string identifier %s",
 				policydb_str);
-			free(policydb_str);
 			return POLICYDB_ERROR;
 		}
 	}
 
-	/* Done with policydb_str. */
-	free(policydb_str);
-	policydb_str = NULL;
-
 	/* Read the version, config, and table sizes (and policy type if it's a module). */
 	if (policy_type == POLICY_KERN)
 		nel = 4;
-- 
2.53.0

