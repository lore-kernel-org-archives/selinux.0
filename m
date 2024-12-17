Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301211F6680;
	Tue, 17 Dec 2024 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443731; cv=none; b=gPDMjcN2SsxTRTwVCdTDxfH6GHIcv4nYGPjmmXzUho93f+vQh6f9dNtojLq1V6ybpaiMVjzZWYpjl+eNEUwQNFXftepcdIXl7MpjWGr9letk9WrrOz4JjTWOe7SfHgH9CN1m+OZGhALZTsNZhqeq3L6hHztee9zz2N9vBE3MNEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443731; c=relaxed/simple;
	bh=uF8BewMwaD3cn5+1ov5Hqor26jTBT7+OQAF0JaxtUwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wyzi4eeo/o3Ov7vdvUvTGLLUkyeqCXpPrBkhs89Hjjk+TXJRfaykaEFj2/jnopbFVJVvDYjRpQM/vNK9dQOq6IqPWtR0wmKYPYsp1i5oFu6s/hlPCxZ4+/K1AKtsR3MUDLDSx/7AoLxukAvrTV1o8gLzkIdvqLUNct4wY5VZJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=WjL0D1mv; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="WjL0D1mv"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734443724;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jgM7Zxn8uQMa75Yf9CuxrECzaG36pVrY1WipQDdWu7I=;
	b=WjL0D1mvI9ucx3WXRO/+5+jzhwnj+OHb7oyhyJ+UZaJKoNOTLqtKJxnzXF2DCfxqJGCCrM
	GxQW5iZNn6XgGr4iAaBb4zHJ8/sHtzjGIHZdtBF4YF47Trxc0YkDfpCiS2oYMDbk5+70vP
	ibsRQyF2QSMbsJT6ygfw9/Nr6lfM47vJPKgd0uZf6ayQD4bp2tSDcap6Qae7PQmo2uHlcl
	N2CRwvCJQrxW9HNNQBs9eNIpcLRS7JmwvnzeTmsjCkf52o6BYEc4OOuoqd6O/f1Q7/4mtO
	Wdo8/+po1xZIcNjnRIjy6ESPgpw95i1SUtybN9D5JG39q/PkFJLLe8UxkHzr6A==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	=?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	GUO Zihua <guozihua@huawei.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>
Subject: [RFC PATCH] selinux: support wildcard network interface names
Date: Tue, 17 Dec 2024 14:55:12 +0100
Message-ID: <20241217135517.534645-1-cgoettsche@seltendoof.de>
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

Add support for wildcard matching of network interface names.  This is
useful for auto-generated interfaces, for example podman creates network
interfaces for containers with the naming scheme podman0, podman1,
podman2, ...

Since the wildcard characters '?' and '*' should be very uncommon in
network interface names, and thus if netifcon definitions, avoid
introducing a new policy version or capability.

Netifcon definitions are compared against in the order given by the
policy, so userspace tools should sort them in a reasonable order.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/include/security.h | 2 +-
 security/selinux/ss/services.c      | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 10949df22fa4..f6e7ba57a1fc 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -298,7 +298,7 @@ int security_ib_pkey_sid(u64 subnet_prefix, u16 pkey_num, u32 *out_sid);
 
 int security_ib_endport_sid(const char *dev_name, u8 port_num, u32 *out_sid);
 
-int security_netif_sid(char *name, u32 *if_sid);
+int security_netif_sid(const char *name, u32 *if_sid);
 
 int security_node_sid(u16 domain, void *addr, u32 addrlen, u32 *out_sid);
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 55fdc7ca232b..2f878fa99692 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -46,6 +46,7 @@
 #include <linux/in.h>
 #include <linux/sched.h>
 #include <linux/audit.h>
+#include <linux/parser.h>
 #include <linux/vmalloc.h>
 #include <linux/lsm_hooks.h>
 #include <net/netlabel.h>
@@ -2554,7 +2555,7 @@ int security_ib_endport_sid(const char *dev_name, u8 port_num, u32 *out_sid)
  * @name: interface name
  * @if_sid: interface SID
  */
-int security_netif_sid(char *name, u32 *if_sid)
+int security_netif_sid(const char *name, u32 *if_sid)
 {
 	struct selinux_policy *policy;
 	struct policydb *policydb;
@@ -2576,7 +2577,7 @@ int security_netif_sid(char *name, u32 *if_sid)
 
 	c = policydb->ocontexts[OCON_NETIF];
 	while (c) {
-		if (strcmp(name, c->u.name) == 0)
+		if (match_wildcard(c->u.name, name))
 			break;
 		c = c->next;
 	}
-- 
2.45.2

