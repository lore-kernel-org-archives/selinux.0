Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2464D4E4C51
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617627; cv=none; b=O4/6j87zT5GsNzx2zaSdm3Tqnr5qqIpSDUSsDtxHd/jIgCikQlGEpnEHnAc3He23jwlo9IRNcC2+/Bm2a8EG5yHDCYA8XCDzwGhgJ4YgxJ/A5gaM3M4Cm06t5t3x56sI9CREvL6Mc2PFpVILqHC+R/GGn5zURjcSxyCJqTRZJYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617627; c=relaxed/simple;
	bh=VxZfOhuH4dbVkRWeYpQ0QxTBqIc0etL2jLeM+zMKPmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GA7XA7O1uluCjOyfCx+jDgohj1Zny9qJ08DWVKYyrEl4SbvEecrrdMgwU/1dZ2ogbZuQxHIGd+qc2e2sDZ/Knh0xUUO5Tmxpy9N148/01GeYZXVrLCFAI7NHXrOwlclRO3KZxmScc85U8m5b565nd6sel75Axt3etDpRN8mya8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=DIpUz44+; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="DIpUz44+"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617622;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bgntR3PBJXFqRLaceDzn4/bld/ClGr83XEYqHADPMIM=;
	b=DIpUz44+Rn62jAaOTKSq76b9uHp37ujbsyWcd7HQNk9HUJNQEx2Qc3kBzFla3sba8zpHMB
	S32dqK+YdxIkqzs2OQtTTFrMT2MF5ytemfS7aFAeOPVhbfRv6VKaYtjFtSPxtXy5p+yghB
	oo685eZuggo17lY27Xd0LxET0NNPJzNaZfYHEZ5psojBoEt1uTsWZ5WjONlooNSTPdeDHf
	ulZWSq1NOQC6xTpLSjtaFejs9SbWZehVSFjh+jB+bpTgNhv2/NBym8AkkUn7ocCgAWMtL/
	D6BpiUzT+87ohOC60v3lR4duIaKrcCWGu3AOsOSLGV/wbvrL+Am0xaDWj9WtXA==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 18/32] selinux: drop dead NULL check in sel_open_policy()
Date: Mon, 28 Sep 2026 19:46:28 +0200
Message-ID: <20260928174643.2458710-17-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
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

plm is always non-NULL on the error path.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/selinuxfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 4982f9362e25..d86babad998c 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -327,7 +327,7 @@ struct policy_load_memory {
 
 static int sel_open_policy(struct inode *inode, struct file *filp)
 {
-	struct policy_load_memory *plm = NULL;
+	struct policy_load_memory *plm;
 	int rc;
 
 	rc = avc_has_perm(current_sid(), SECINITSID_SECURITY,
@@ -356,8 +356,7 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 err:
 	mutex_unlock(&selinux_state.policy_mutex);
 
-	if (plm)
-		vfree(plm->data);
+	vfree(plm->data);
 	kfree(plm);
 	return rc;
 }
-- 
2.55.0

