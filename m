Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811C54F3EB4
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614397; cv=none; b=HZCsraRtdnUqVN8Me57FtdPGmQiphTBQvDPkhJJ+QyQ5amXOcKF6phn2WJuo1OtAM3uvvBS9HCz/KCI07lwCXvAc31FXaXz+QZJZ7PVtnFEKLGijZ7fSgHJXajeDcqeE0X3wrNbbwZgKU+BRRRPIhZqn2xGt4DYb479jd9BDAYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614397; c=relaxed/simple;
	bh=B+FgRIiNMqhqkRxOEmRdIfRFrqH0RbLvVIljbgxSYMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ir3nwVmNVlqQNI9Ms7iN3bRR0n4AdgJcN3D4e1rmfHXyOXR/2QcRadzhu17r/NVwJZyvzbGdtpJnbd4WiWXUIznFRL9r1zFeIzoewj6ccLzYYhQCaiYsaWM002BwfAY3mMVdM6z8gxI1LjtnXafJLbYpyR0pYk1FZ1WvE6jBb4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=rYn5cGNF; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="rYn5cGNF"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790614392;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/os0Oc+6JSBc0FAWMdfILrDtPy3NvJOXKgUtRsS8uFs=;
	b=rYn5cGNFLMzE3efv3zjUAuANcoZbEkLAU1PGY5sLkqse8zTVKja1iMH31SQGJUpA9qw6vv
	cDQv7ki8yJ4KHPbg8ENUn+nxOZ31VIRAfyRA7hDNzvVDKSWi5cE7H26Vq3l5cpQxVpihhU
	pn2X54qGrcJQ/Bplh/UaBHgr775mdv6pmt2y9Ac/UT1DLuEVocTEi7Pdjy2kzQmYckSfVo
	nT4/zOdYJhU4Pu3TsNZx/cbLK9UEb8L9CdcuFLK9w16wgx+sZ/BNjweiAswzH7+78eL/Ar
	PBp1GMLLbcPW7iE6l81WB37rYFUeAKDRpXdVkiMKvPg5MsGH9MvR389MFKN6gg==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 3/3] selinux: validate permissive and neveraudit map types at load
Date: Mon, 28 Sep 2026 18:52:52 +0200
Message-ID: <20260928165253.2388012-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260928165253.2388012-1-cgoettsche@seltendoof.de>
References: <20260928165253.2388012-1-cgoettsche@seltendoof.de>
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

The permissive and neveraudit maps are read as ebitmaps and indexed by
type value, but their set bits are never checked. A bit that is not a
defined, non-attribute type is silently accepted. Validate every set bit
of both maps in policydb_index() with policydb_simpletype_isvalid().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: inline block scope
---
 security/selinux/ss/policydb.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index e51293e3ca8c..fe0c0792583f 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -818,8 +818,9 @@ static inline void symtab_hash_eval(struct symtab *s)
  */
 static int policydb_index(struct policydb *p)
 {
+	struct ebitmap_node *node;
 	int i, rc;
-	u32 v;
+	u32 bit, v;
 
 	if (p->mls_enabled)
 		pr_debug(
@@ -902,6 +903,23 @@ static int policydb_index(struct policydb *p)
 	if (rc)
 		goto out;
 
+	ebitmap_for_each_positive_bit(&p->permissive_map, node, bit) {
+		if (!policydb_simpletype_isvalid(p, bit)) {
+			pr_err("SELinux:  permissive map refers to invalid type %u\n",
+			       bit);
+			rc = -EINVAL;
+			goto out;
+		}
+	}
+	ebitmap_for_each_positive_bit(&p->neveraudit_map, node, bit) {
+		if (!policydb_simpletype_isvalid(p, bit)) {
+			pr_err("SELinux:  neveraudit map refers to invalid type %u\n",
+			       bit);
+			rc = -EINVAL;
+			goto out;
+		}
+	}
+
 	rc = 0;
 out:
 	return rc;
-- 
2.55.0

