Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78771FF7CD;
	Tue, 18 Mar 2025 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286896; cv=none; b=c9PT6fdFgp3/vDtlX1nmjwnWeTGizaTXrjrvkUarsJ+FHm+tjVC+7fZji0VrazptHC7u+gB5W0AcOSfgcMYVuRhqFQklaVkcK5JuR0oZi0cfRdnPD87EGDu9QyYR+Ob2Rusapyc9JhUNRdIhpZrPMbqq64oJsrkgZBT1MxihRdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286896; c=relaxed/simple;
	bh=kBVHht6WxUyAZRBWC0FXhX0pMnJ+PhbFwV3C7vq8ALY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pj79niOiSMmYdm75oxseK1Fw628NwPbBQLdl1Mi491+NBv76z4dcl2hdwPB7fecTJ+BV4AF6yZnMI7tnIKWvtY7+SE9xpETtoqIF4XL+hc70buwfwcnrGL5pAuzG2nLJ/xBcwL5EUhsquDaX/Rirz2X9zOkN4R0Xk01HMF1HwbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=AnEvAOxs; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="AnEvAOxs"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1742286890;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRAcXX/kDNCEMotPxD3KkkStBQuxDq+ovFAm2BtKgAE=;
	b=AnEvAOxsVA7Qhg8XwrofPsvtSPesLccYhkSGz4w6XUTBgwbyvRHp6umwoem0rS86z9+din
	UQmQvybum9dl4nu7mFGjGCvIJP+JfqOzfe81hAwdCeO19eZbvF3EhJDxvmfR7hQiAjW+Y7
	ZldMEYeyCS6UO+FfU+k79rQZEKiP/DHTzC6S/0TsxZuQGWqHbfDTrOivqx1MX8TXlW0ZQn
	0YenHHqHCcC3WCBS9mtKHdBWVDUaFagKoM2WvnG8wEmTx8G4V97+m0W04j8xS3nNieeu6p
	rTzSDjccQKQl74+QKcUBHw48O9+s9tXPKdUYpwnAzflfdLGejjqG8jfHE4LBdg==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	=?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	GUO Zihua <guozihua@huawei.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/6] selinux: add likely hints for fast paths
Date: Tue, 18 Mar 2025 09:33:30 +0100
Message-ID: <20250318083422.21489-2-cgoettsche@seltendoof.de>
In-Reply-To: <20250318083422.21489-1-cgoettsche@seltendoof.de>
References: <20250318083422.21489-1-cgoettsche@seltendoof.de>
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

In the network hashtable lookup code add likely() compiler hints in the
fast path, like already done in sel_netif_sid().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ibpkey.c  | 2 +-
 security/selinux/netnode.c | 2 +-
 security/selinux/netport.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ibpkey.c b/security/selinux/ibpkey.c
index 48f537b41c58..94f3eef22bad 100644
--- a/security/selinux/ibpkey.c
+++ b/security/selinux/ibpkey.c
@@ -184,7 +184,7 @@ int sel_ib_pkey_sid(u64 subnet_prefix, u16 pkey_num, u32 *sid)
 
 	rcu_read_lock();
 	pkey = sel_ib_pkey_find(subnet_prefix, pkey_num);
-	if (pkey) {
+	if (likely(pkey)) {
 		*sid = pkey->psec.sid;
 		rcu_read_unlock();
 		return 0;
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index b7900d5ae557..8bb456d80dd5 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -253,7 +253,7 @@ int sel_netnode_sid(const void *addr, u16 family, u32 *sid)
 
 	rcu_read_lock();
 	node = sel_netnode_find(addr, family);
-	if (node != NULL) {
+	if (likely(node != NULL)) {
 		*sid = node->nsec.sid;
 		rcu_read_unlock();
 		return 0;
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index 2e22ad9c2bd0..7d2207384d40 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -186,7 +186,7 @@ int sel_netport_sid(u8 protocol, u16 pnum, u32 *sid)
 
 	rcu_read_lock();
 	port = sel_netport_find(protocol, pnum);
-	if (port != NULL) {
+	if (likely(port != NULL)) {
 		*sid = port->psec.sid;
 		rcu_read_unlock();
 		return 0;
-- 
2.49.0

