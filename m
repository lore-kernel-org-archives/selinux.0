Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4C958F074
	for <selinux@vger.kernel.org>; Thu, 17 Sep 2026 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654856; cv=none; b=ORA70BAhSe7uMyN8RkvkzKxEheslIG1IKS1WjU3mHQ8WuOl7SExBqwLOzPs6yUgvGDBGks+1Solhbz5VovOCZtODepFifuHnuLRd6fpO8YhGJhgxa/J6GhjRWeYxUH5FLc+4QdMXTa4tbTN4B18nI22mw9yOGOhzxz35yyhsdcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654856; c=relaxed/simple;
	bh=oCAZAKHORKsNU8EbeXmetOTIX0QkdUmY5UEpJXtWA1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lpFdNOvnl9M2ACXBRKQg7r9qGf47z08wiuRbo5os+SCbRe33gwmVDmx25NV7f0LADpDY52NT0Jl98zfPT3JFjYpsh7ZaLay8o8r3hnhUc4VtneQtkxvcxlZgmMoNj85GgxTFiXMaEAlhOltCAq7+FxcFLlYyHm2Pb9b3EVmXge8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=NNWW29BE; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="NNWW29BE"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1789654851;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=B0m5UMeRVessb/LdiR1k5MF6KZgOV+Fsv/vlAU6nNSY=;
	b=NNWW29BExqskWPGw3fgevxQ5KnJVTWJRykqrdkBBT4bSCOam3M9TvZpB4S4DKDVoD71HYG
	ZmVtqrI0/ViXQVyhPJ8iaTVaiXFTB6zHFDgM5KLGqSyUi4HEpFGayTrKeKAOy9RgrNkuo1
	/DVt5sZOHPvK51/198KKq/o4jfDKKJKDBnvtHZ6KnUHpilqFkn5qY9Xhbl3bf95PU+YSJ0
	DUu5zFQxcBrcoI4N2HkOeIV/TZmA6XGkn//tHdSiyja6at+ggQ5IBcT07ML6Zi/DbS+x33
	9fMUJp6pnl4vuwXNQ/kZS/sOHJcdJqrMp0FAE4HzU7GnY1i24NzBV4t9l+UbiA==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] selinux: reject a policy that both rejects and allows unknown classes
Date: Thu, 17 Sep 2026 16:20:38 +0200
Message-ID: <20260917142038.60637-1-cgoettsche@seltendoof.de>
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

handle-unknown is a single three-valued choice - deny, reject or allow -
but the policydb header spells it as two independent bits and
policydb_read() takes any combination of them.

libsepol writes exactly one of the three values
(POLICYDB_CONFIG_UNKNOWN_MASK & p->handle_unknown), so no policy built by
the reference toolchain carries this combination.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 4342258cb148..7eeaf7076c52 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2844,7 +2844,8 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 		goto bad;
 	}
 
-	if ((le32_to_cpu(buf[1]) & POLICYDB_CONFIG_MLS)) {
+	val = le32_to_cpu(buf[1]);
+	if (val & POLICYDB_CONFIG_MLS) {
 		p->mls_enabled = 1;
 
 		rc = -EINVAL;
@@ -2855,8 +2856,13 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 			goto bad;
 		}
 	}
-	p->reject_unknown = !!(le32_to_cpu(buf[1]) & REJECT_UNKNOWN);
-	p->allow_unknown = !!(le32_to_cpu(buf[1]) & ALLOW_UNKNOWN);
+	rc = -EINVAL;
+	if ((val & (REJECT_UNKNOWN | ALLOW_UNKNOWN)) == (REJECT_UNKNOWN | ALLOW_UNKNOWN)) {
+		pr_err("SELinux:  policydb configuration both rejects and allows unknown classes and permissions\n");
+		goto bad;
+	}
+	p->reject_unknown = !!(val & REJECT_UNKNOWN);
+	p->allow_unknown = !!(val & ALLOW_UNKNOWN);
 
 	if (p->policyvers >= POLICYDB_VERSION_POLCAP) {
 		rc = ebitmap_read(&p->policycaps, fp);
-- 
2.55.0

