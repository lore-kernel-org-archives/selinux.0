Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FB258F074
	for <selinux@vger.kernel.org>; Thu, 17 Sep 2026 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654827; cv=none; b=VQXwqaDSUvMUtPQIEtgPtvRDXi+Fa4CVKQJW9FhbNk/ERnHcGswx/xdyDKYYma+eRqXR/F+u4p9ab4ZkOD2K/V9hns/vkBWKq0FVBZnpn1nEJg4MJRMvxaMP/3Zcw7zj60vzlE7zB6DFpKWDoaHcj1PNPCDQAGyjsx98EnRZqw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654827; c=relaxed/simple;
	bh=RCff7iPohPE3ubcyILj0RKCOLf4w1zC1uo3jTvhUpKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DpM4DWbRbqpjps+pjRtJyWb+XgB2uVL1zTi2eLZx458RvZ8SyI5vS6sVyniPmp8R7eucHRINF6yLl8LsONdrfGn+84aqIbhFD4Ftyw71RdHp6DoA1DRF3ca6JjwcMyRDaiJd2COJvlI1NO+sjWTTBEadsTXovslxKAtFlghmJ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=EOKWYTH7; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="EOKWYTH7"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1789654413;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7loIHqo7Utu5TwDv4uKRMJzYfPzNIgTpF/sIYTx1pus=;
	b=EOKWYTH7bqOla0lfbhYhdZU8gEahg7ow1kmi39+Y3LoisLT+gTFvRkgBuZzs8tDGwiRnWL
	Ryn8SLdxBERXkHeJgpfb5L3/Z3D8YnBTUK+UHjJMMjkj/xkKRlxxnmMeZINs52HK3qzmtu
	dKcZgyqjS/PJG7WlxceOmjrXEKETabGjsbCSB2cz9WbsHeorZsiXw95Z9jXotqaK8NhxyS
	3s9ZGwsMDYjXDApH5U2F9t1Y2ChsChMNSVo4KJvlk6PSaMqB6djOv+RlU7E1l3N9T6nFIA
	SIMgtTPswisEiAtRjQBGpjW+uUnKw7JIJu8AiWFAOzU2eqydJzrUkorhWj62hg==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/2] selinux: check neveraudit in avc_xperms_audit_required()
Date: Thu, 17 Sep 2026 16:13:17 +0200
Message-ID: <20260917141317.54719-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260917141317.54719-1-cgoettsche@seltendoof.de>
References: <20260917141317.54719-1-cgoettsche@seltendoof.de>
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

avc_audit_required() returns early for a neveraudit domain, while
avc_xperms_audit_required() instead relies on security_compute_av()
(and security_compute_av_user()) having already zeroed
avd->auditallow and avd->auditdeny for such a domain.  That leaves
its "else if (result)" branch as the only way left to audit a
neveraudit domain, and makes the two helpers read differently for
the same rule.

Add the same early return to avc_xperms_audit_required(), so both
audit gates state the neveraudit rule directly and the extended
permission audit path no longer depends on the auditallow/auditdeny
mask having been zeroed elsewhere.

No behavior changes today: avc_has_extended_perms() only reaches the
"result" branch once the identically computed "denied" is already
nonzero, so that branch was already unreachable in practice.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/avc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index a9401d6c2e5f..4e06ac9d46bf 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -389,6 +389,9 @@ static inline u32 avc_xperms_audit_required(u32 requested,
 {
 	u32 denied, audited;
 
+	if (avd->flags & AVD_FLAGS_NEVERAUDIT)
+		return 0;
+
 	denied = requested & ~avd->allowed;
 	if (unlikely(denied)) {
 		audited = denied & avd->auditdeny;
-- 
2.55.0

