Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1951E260A;
	Wed, 12 Mar 2025 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766953; cv=none; b=JSWQVxbWAEDJaV1xg14MG2DpXUCeyk2LgFilT6t38y8nIYS0zDAj+aeIoXrlOgufsUY/bqQa1Ivure8SukyK7jAfbVHpbIjOYqzSvbo/nAXJMWlNWAPkYn5WOltfTScEPNSMzsFNmMTNrhNqKBLAnWRLrbW0Digy7sLIwctw2b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766953; c=relaxed/simple;
	bh=T0s4WbImmxmV4v+TQpzvwmw+owjCsVPQd4lFvoC3/iI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mC4Ca/qt8wzOuyu7sHpjvHhRyvQV2iEXZz5haZicFyqPu3peKQj7ZBWYVTKDw/1TEygeFrgwRv1Z+X4QAZ7X9yjdQnDgD13f/OScizGhRmY90pzqzYKqnNKaPM1r4dAK5CmKvzWMeHPw8N67VY80Tq0SsZNyLqSxzu/js+0IGTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=IhkY+w2C; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="IhkY+w2C"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1741766465;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Renm/KAKlpQS2R4mk9q0MjO8y4d8Dnc0mRE12HH93G8=;
	b=IhkY+w2Cu1gaH4fel+WbAv6QpcFO9XD4bT2hzJsGAMDTyHRUwjqipOR7X41phesTjQBzns
	htmToha3kOZgO8zihCpC5xar8Ifwl1apMGnWW8koZp8YW/p2ITmkS8jWNOChRiePCZNVtE
	3ZQdAAUms9A/imzPR6WkTvBica486FCqEwUMDgmqvrLa29jgLLfofnRuGSmO+kE7YnSiNQ
	jA4po186LR8X/KsX0pZB/bRI8zbdZ9c5KWxLHdQUsK8qt7IUmIMJQfSSxskpoVc4hY29tj
	qPIzhe4CoO0FFUZjpBHmozFYMEos39XLdwtlOVfVlBaTumw0PgR3/9bVRzS31A==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	GUO Zihua <guozihua@huawei.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: get netlabel_wildcard policycap from policy instead of cache
Date: Wed, 12 Mar 2025 09:00:48 +0100
Message-ID: <20250312080055.8950-1-cgoettsche@seltendoof.de>
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

Retrieve the netlabel_wildcard policy capability in security_netif_sid()
from the locked active policy instead of the cached value in
selinux_state.

Fixes: 8af43b61c17e ("selinux: support wildcard network interface names")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/services.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 1b11648d9b85..e431772c6168 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2587,14 +2587,13 @@ int security_netif_sid(const char *name, u32 *if_sid)
 		return 0;
 	}
 
-	wildcard_support = selinux_policycap_netif_wildcard();
-
 retry:
 	rc = 0;
 	rcu_read_lock();
 	policy = rcu_dereference(selinux_state.policy);
 	policydb = &policy->policydb;
 	sidtab = policy->sidtab;
+	wildcard_support = ebitmap_get_bit(&policydb->policycaps, POLICYDB_CAP_NETIF_WILDCARD);
 
 	c = policydb->ocontexts[OCON_NETIF];
 	while (c) {
-- 
2.47.2

