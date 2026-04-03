Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E868A35C193
	for <selinux@vger.kernel.org>; Fri,  3 Apr 2026 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775199200; cv=none; b=S0DNZFk6DVQ4eueBJqZsSoxilmXOlo7CIMkHGhsrQJmySlk6cU9jLLusqVNQlgU3BHxqBv+7Hf5ZDgA72kCOkflKPVhWMnbzXVgcjdOOrNRZBNPHEelUqplemZvqkhpdimbvHciYm/oep8Lnb39BbxUw26KoLM4Ra4nWdy7aBSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775199200; c=relaxed/simple;
	bh=MMyiQhME4iBVwkt1ezU8CO2ZInwR+L6H+F70NqHsknQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lkIbAwSl+a3SDkFAwhCsGy0xP1hrVbw3FilldDfbEr0Y5SaODoU6lYpNK9grpOr+fFIiFkfEjqdv6C6ls8r5sx66rkzvJFil1M1WPd7tGKB0E5GaukdyO3Xdmk2epvFoOl33t54An2BdUwW7Ol8g/B8A1DrKu/Ag6PwOTxuEo4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk; spf=pass smtp.mailfrom=posteo.uk; dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b=pz+L5zYx; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b="pz+L5zYx"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 2E1FF240101
	for <selinux@vger.kernel.org>; Fri,  3 Apr 2026 08:53:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.uk; s=2017;
	t=1775199190; bh=EX58LQNklMeRCUFTVKvrPi16pd2mNeCSwmtlgTuoL68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=pz+L5zYx1ZTFU8OU6z9WqsyilHDsP0tVe2vJGkPqnV4Vu79OY2IbYVKOjbDWB1fTs
	 LK1pc/8n2wB1KQqMNkNFFA4LYxg6I/Qdbs8KaadYDKNyupcaUN0aNy6FpCMVCGR+lb
	 yiimVv1c35xmx3imVBGwPF5tRYfckK+y2wetNlqTMZLioaBk5acS3TxquKHEFmuMlH
	 gogjsjGEkx/6usmESgXfNs/VPIzEYiX7bKCDvjbMHFUEBPvP32izmh6Lxs1P8t1Av+
	 KzEjiRT3/tlo2UfAPwdWlyxVWv0WKPbDCycmyHcKkiyiGViqgThLoIKSCNJA6BGufW
	 xfVhOKBqaJJwQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fn8Yx3B4nz9rxG;
	Fri,  3 Apr 2026 08:53:09 +0200 (CEST)
From: Rahul Sandhu <nvraxn@posteo.uk>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>,
	Rahul Sandhu <nvraxn@posteo.uk>
Subject: [PATCH v2] libsepol: policydb_read(): use a static string for policydb_str
Date: Fri, 03 Apr 2026 06:53:09 +0000
Message-ID: <20260403065234.2172150-2-nvraxn@posteo.uk>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2188; i=nvraxn@posteo.uk; h=from:subject; bh=RTWkkB0uHuY3emvXEaA0HlE5aVZj/1wfeS2PhSGjoaY=; b=owGbwMvMwCmc0Xus8aefgg/jabUkhszzyZu6XSfv3cn8WCxhR4ZZ2/Jiz72rp0/tmHHiQnP3q x8rWP6Gd2xkYRDmZLAUU2TZv4/tRsnTub+PPnndATOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq GQIZOkYMXJwCMNVeeYwNs7TPlW37/eFeTvisi9MqVIvEL8aVpbn/92l5V6Mh/EeSe9OxaFbDbTq L/Uutqz8rvZdmbJi4Trg+UKRtkqzm/X3nj/2w+nPnds1qrUnCGr/e8D7USy03EBKt5+t9Wnmz1U X+rfoqdgA=
X-Developer-Key: i=nvraxn@posteo.uk; a=openpgp; fpr=BFBE06D874E59DFBC5E4EB88688DC681F94E204C
Content-Transfer-Encoding: 8bit

From: Rahul Sandhu <nvraxn@gmail.com>

We know the maximum possible size of policydb_str at compile time; it's
POLICYDB_STRING_MAX_LENGTH + 1 (with + 1 accounting for the null term).
As POLICYDB_STRING_MAX_LENGTH is trivially small, make it a static str,
avoiding an extra allocation.

Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>
---
 libsepol/src/policydb.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

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

