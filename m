Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA581D63F0;
	Sun,  2 Mar 2025 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740930083; cv=none; b=OLICc/MeX1I4BG188b/UQx8e4U0lD7brENjjgKozC4ha8V1n8vuDqRtoQ79Z/22hbjmHiyowTuEhLKutOrLNr4owF6Oht9tNmkqGgeA5M01JZlXzKVzQULSMQ/LAu5/kHCOHAIXraplmaZkNcBRbp6ob1b0ZnwMsyNueiIRXjtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740930083; c=relaxed/simple;
	bh=yhQk3Pbb52st/bbzs4WnIeH8nwzRmTAFjWB2hel6aB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YMWFkmm588LktRbL9eABFB8ayfkq7R5D8E/j4rrOWPpaB/JsScNEU3agHjA7Q4EoLZwRZv0B3mODPgrIyqUWjk1XE0neDrIpir56PPaDWw1YihUuj2/YfNO25Gv98npfeVfC62LBDsjWtC3G7MMEv6Lpwv7frJGi/yJfqiHqfEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=TRBQPFj8; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="TRBQPFj8"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740930070;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mI6NCFLfMJhS8kSQLRZK0yfbCZWW+b8aeok3MnZ7SYI=;
	b=TRBQPFj82yhUsU3MP9fKUINUruIX9ZCLxfXBtVxaLC0Ao6lzszYQr3doij6prq8Hx0Tcft
	rLujKNKm6Bx9j1do+ZveELIRboxe037APZNL73mZtzrzmvCSDzXDA5SqErXeX2V0cC/+IH
	ruJP3BylyDK4wAPzjLxtBlquK1WgbAol62vz6bzSYyvBqJGTT82bBmlOTcKw1fbmwaGFdA
	g5yhFfQJ5BW1g18CHOCOan/hz0aZOuqDxw0/c/PB3uuPykRuKhWtjDNh1ChQ8/ANp3m4QY
	ZA+CZ7J6Nt47YOnyUng7+XrhswJgq3tHu8ib29lowa7SEatQslltyPdftwYvrg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	=?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	GUO Zihua <guozihua@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: support wildcard network interface names
Date: Sun,  2 Mar 2025 16:40:45 +0100
Message-ID: <20250302154100.104746-1-cgoettsche@seltendoof.de>
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

To maintain backward compatibility guard this feature with a new policy
capability 'netif_wildcard'.

Netifcon definitions are compared against in the order given by the
policy, so userspace tools should sort them in a reasonable order.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: add policy capability netif_wildcard
---
 security/selinux/include/policycap.h       |  1 +
 security/selinux/include/policycap_names.h |  1 +
 security/selinux/include/security.h        |  8 +++++++-
 security/selinux/ss/services.c             | 16 +++++++++++++---
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
index 079679fe7254..bd402d3fd3ae 100644
--- a/security/selinux/include/policycap.h
+++ b/security/selinux/include/policycap.h
@@ -15,6 +15,7 @@ enum {
 	POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
 	POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
 	POLICYDB_CAP_NETLINK_XPERM,
+	POLICYDB_CAP_NETIF_WILDCARD,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
index e080827408c4..ac1342d6d5bb 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -18,6 +18,7 @@ const char *const selinux_policycap_names[__POLICYDB_CAP_MAX] = {
 	"ioctl_skip_cloexec",
 	"userspace_initial_context",
 	"netlink_xperm",
+	"netif_wildcard",
 };
 /* clang-format on */
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 8b4c2aa35839..e7827ed7be5f 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -202,6 +202,12 @@ static inline bool selinux_policycap_netlink_xperm(void)
 		selinux_state.policycap[POLICYDB_CAP_NETLINK_XPERM]);
 }
 
+static inline bool selinux_policycap_netif_wildcard(void)
+{
+	return READ_ONCE(
+		selinux_state.policycap[POLICYDB_CAP_NETIF_WILDCARD]);
+}
+
 struct selinux_policy_convert_data;
 
 struct selinux_load_state {
@@ -301,7 +307,7 @@ int security_ib_pkey_sid(u64 subnet_prefix, u16 pkey_num, u32 *out_sid);
 
 int security_ib_endport_sid(const char *dev_name, u8 port_num, u32 *out_sid);
 
-int security_netif_sid(char *name, u32 *if_sid);
+int security_netif_sid(const char *name, u32 *if_sid);
 
 int security_node_sid(u16 domain, void *addr, u32 addrlen, u32 *out_sid);
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 8478842fbf9e..1b11648d9b85 100644
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
@@ -2572,19 +2573,22 @@ int security_ib_endport_sid(const char *dev_name, u8 port_num, u32 *out_sid)
  * @name: interface name
  * @if_sid: interface SID
  */
-int security_netif_sid(char *name, u32 *if_sid)
+int security_netif_sid(const char *name, u32 *if_sid)
 {
 	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	int rc;
 	struct ocontext *c;
+	bool wildcard_support;
 
 	if (!selinux_initialized()) {
 		*if_sid = SECINITSID_NETIF;
 		return 0;
 	}
 
+	wildcard_support = selinux_policycap_netif_wildcard();
+
 retry:
 	rc = 0;
 	rcu_read_lock();
@@ -2594,8 +2598,14 @@ int security_netif_sid(char *name, u32 *if_sid)
 
 	c = policydb->ocontexts[OCON_NETIF];
 	while (c) {
-		if (strcmp(name, c->u.name) == 0)
-			break;
+		if (wildcard_support) {
+			if (match_wildcard(c->u.name, name))
+				break;
+		} else {
+			if (strcmp(c->u.name, name) == 0)
+				break;
+		}
+
 		c = c->next;
 	}
 
-- 
2.47.2

