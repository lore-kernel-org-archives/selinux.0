Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4191A83E7
	for <selinux@vger.kernel.org>; Mon, 30 Dec 2024 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735567535; cv=none; b=qROxEeGd5BAAmhu0m2nKT3YMEnPmfogmglOiej4UuV2MUR7zz5+Tp11ibH/YjfNfEnsTSnCoR1LpYEOC1D2EGVv+unj4blHDwk/mMU/a2j2tCiKzHw6zEuVji4Kh+GcK8PyzbTAIXG6AVhCLhsW6cdWlDXXr2cUf6PmP47J8c54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735567535; c=relaxed/simple;
	bh=t9j0bou8E4Jpwa23Ft8QN4LCNDdloDHuQD3rkQ1XJIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dz0Jt1sTmAL2TWRWJBS170gNONFETf2UtQF3OFmKq9plFRfsrdwMl/b/YydMVoYEjxIAWppIMnyGG1TMtE/JPCLKn62EQq5ZSAEAlYrxPyikhM+wQLTLrQq5XkWaZuegcVQNQSS0CBp6dFH/1Wn9f/dSORzNKBAWCb70x1uGzyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ApkYmbJp; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ApkYmbJp"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1735567531;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YRz0r+U4EnvKxFThMEJu3SMjpLoeSGHYqw9Uf8yKv8Q=;
	b=ApkYmbJpttJaW4qSa02b4jzqge3PX1S0xwIkzTlbKaM6+USIF7vVaca8wo5O+MU9tKF0xH
	B+0aOczQSUX779rrtmCJpBWsnl8mqfPAdIP24m6fJK7Tbv3eN4CwQwpCkLog05n8Y49Moz
	zh9ITRTSP2n6tm0WwO1O3v221wz1Z2qo+8HnMxQQU4sYeLQPGHaFnksQhM7cX3KKMOXRt1
	PGUYbJULgPXLqa5Fx90j5a3MzYxjAwlgik8L/F12JT4MB4uzt2DLv11YQfROrRfKLw02KS
	1LY6gnL1BFn6aGUufvgeR8BnUgVTXoXicYTap9cZtznehUcL6Uqk/mfB+84QOQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/2] libsepol: fix typos
Date: Mon, 30 Dec 2024 15:05:23 +0100
Message-ID: <20241230140523.60053-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241230140523.60053-1-cgoettsche@seltendoof.de>
References: <20241230140523.60053-1-cgoettsche@seltendoof.de>
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

Found by codespell(1) and typos[1].

[1]: https://github.com/crate-ci/typos

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_cil.c | 2 +-
 libsepol/src/module_to_cil.c | 2 +-
 libsepol/src/policydb.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 2d563e7d..ddca2b62 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1802,7 +1802,7 @@ static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, avtab_dat
 		} else if (datum->xperms->specified == AVTAB_XPERMS_NLMSG) {
 			xperm = (char *) "nlmsg";
 		} else {
-			ERR(NULL, "Unknown extended permssion");
+			ERR(NULL, "Unknown extended permission");
 			goto exit;
 		}
 		rule = create_str("(%s %s %s (%s %s (%s)))",
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 0ede0c9b..ae9a2b5d 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -709,7 +709,7 @@ static int avrulex_to_cil(int indent, struct policydb *pdb, uint32_t type, const
 	} else if (xperms->specified == AVTAB_XPERMS_NLMSG) {
 		xperm = "nlmsg";
 	} else {
-		ERR(NULL, "Unkown avrule xperms->specified: %i", xperms->specified);
+		ERR(NULL, "Unknown avrule xperms->specified: %i", xperms->specified);
 		rc = -1;
 		goto exit;
 	}
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 0747e789..8443380b 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1662,7 +1662,7 @@ int policydb_load_isids(policydb_t * p, sidtab_t * s)
  *
  * arguments:
  *   policydb_t *pol       module policy to modify
- *   uint32_t sym          the symbole table for insertion (SYM_*)
+ *   uint32_t sym          the symbol table for insertion (SYM_*)
  *   hashtab_key_t key     the key for the symbol - not cloned
  *   hashtab_datum_t data  the data for the symbol - not cloned
  *   scope                 scope of this symbol, either SCOPE_REQ or SCOPE_DECL
-- 
2.45.2

