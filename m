Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675991FF7DD;
	Tue, 18 Mar 2025 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286923; cv=none; b=ulgMyldHsu2CHQHXxCKDYGW02fW2SMhI73O9QnRvVLWZmMBCb3QVby/RK19yKsskiFL8274qnnfNFrTZpdzEjnK9+btVR5rk4oZVjW9NuwmsqAaW3QYQUjp1xc+0P6yivaMBkKWvPMikMwxf1p2l6S0sVL9mDX9n8wor9geOvuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286923; c=relaxed/simple;
	bh=DMypu84hUPCKk8cM3dl3hIRp0KNBfqijO2rHEs9V0Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mohM7ZC4RdHWuDU4B3Czn5+kfJ+w1uoJRw4X5RwHVzWQRDUFelAVjY0lTG0nrHlyg0DKMa/hwlKnDN27xx4fofvZQVQdNE/JTNrjqy1vpcRzBhzqoO/tuIdNcNHdzsIEtVZoEY/aWUNuSamOrP4MC1eAyU+55LTJ/NNedWb+7mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=rMKsFVsG; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="rMKsFVsG"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1742286919;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BDYLTpuSkx0XjSYvI9V7boQta4mwgXSpWwdwbRlgNcA=;
	b=rMKsFVsGqxH7v0XAe/ROD+Zuk9a2Mn2FVy/UzuW0fjJphQCP6EGTv1CJrLa/IpEQr3uhPF
	0yfdb3dpiVs/bOJFq4aflmqa2dvKnYIR5fhwi6A9nPuHrugDq7dHxHHQ09CRZRVIirdMKa
	nOdiciK/mVRg2c3rQGa3EgnWGXYm7znBregOjEpSsCo+wD4aSg9kaffGOsKa4o5xPqp8eJ
	gS8W9QXd0G6+87PeUh6MfNOQIi05yhF4WEXmoIbyWrWuan4ZdBQ3R5I8nssMScwH2SwHdv
	7I7nfdFK+Lz+Oe8TNWOdW98W5iN4J5TsQNa5WxhiFYTlv+hCXj2wHbz3mOPeGg==
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
Subject: [RFC PATCH 1/6] selinux: constify network address pointer
Date: Tue, 18 Mar 2025 09:33:34 +0100
Message-ID: <20250318083422.21489-6-cgoettsche@seltendoof.de>
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

The network address, either an IPv4 or IPv6 one, is not modified.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/include/netnode.h  | 2 +-
 security/selinux/include/security.h | 2 +-
 security/selinux/netnode.c          | 8 ++++----
 security/selinux/ss/services.c      | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/security/selinux/include/netnode.h b/security/selinux/include/netnode.h
index 9b8b655a8cd3..e4dc904c3585 100644
--- a/security/selinux/include/netnode.h
+++ b/security/selinux/include/netnode.h
@@ -21,6 +21,6 @@
 
 void sel_netnode_flush(void);
 
-int sel_netnode_sid(void *addr, u16 family, u32 *sid);
+int sel_netnode_sid(const void *addr, u16 family, u32 *sid);
 
 #endif
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index e7827ed7be5f..278c144c22d6 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -309,7 +309,7 @@ int security_ib_endport_sid(const char *dev_name, u8 port_num, u32 *out_sid);
 
 int security_netif_sid(const char *name, u32 *if_sid);
 
-int security_node_sid(u16 domain, void *addr, u32 addrlen, u32 *out_sid);
+int security_node_sid(u16 domain, const void *addr, u32 addrlen, u32 *out_sid);
 
 int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 				 u16 tclass);
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 5c8c77e50aad..b7900d5ae557 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -187,7 +187,7 @@ static void sel_netnode_insert(struct sel_netnode *node)
  * failure.
  *
  */
-static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
+static int sel_netnode_sid_slow(const void *addr, u16 family, u32 *sid)
 {
 	int ret;
 	struct sel_netnode *node;
@@ -207,13 +207,13 @@ static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
 		ret = security_node_sid(PF_INET,
 					addr, sizeof(struct in_addr), sid);
 		if (new)
-			new->nsec.addr.ipv4 = *(__be32 *)addr;
+			new->nsec.addr.ipv4 = *(const __be32 *)addr;
 		break;
 	case PF_INET6:
 		ret = security_node_sid(PF_INET6,
 					addr, sizeof(struct in6_addr), sid);
 		if (new)
-			new->nsec.addr.ipv6 = *(struct in6_addr *)addr;
+			new->nsec.addr.ipv6 = *(const struct in6_addr *)addr;
 		break;
 	default:
 		BUG();
@@ -247,7 +247,7 @@ static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
  * on failure.
  *
  */
-int sel_netnode_sid(void *addr, u16 family, u32 *sid)
+int sel_netnode_sid(const void *addr, u16 family, u32 *sid)
 {
 	struct sel_netnode *node;
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e431772c6168..ec9ddfccc7ee 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2643,7 +2643,7 @@ static bool match_ipv6_addrmask(const u32 input[4], const u32 addr[4], const u32
  * @out_sid: security identifier
  */
 int security_node_sid(u16 domain,
-		      void *addrp,
+		      const void *addrp,
 		      u32 addrlen,
 		      u32 *out_sid)
 {
@@ -2672,7 +2672,7 @@ int security_node_sid(u16 domain,
 		if (addrlen != sizeof(u32))
 			goto out;
 
-		addr = *((u32 *)addrp);
+		addr = *((const u32 *)addrp);
 
 		c = policydb->ocontexts[OCON_NODE];
 		while (c) {
-- 
2.49.0

