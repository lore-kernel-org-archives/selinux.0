Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299C44DE72D
	for <selinux@vger.kernel.org>; Thu, 17 Sep 2026 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654827; cv=none; b=OM0l3yJTITLqN5OJUHgoPSgajCByoKhn++CHuhsSqmtmgLQ49Kp9wzYXItTuIu6LzpgPF3Z5IGRF5+Na9WGCTnF4HnbqY5LLFxrDd3Vtvxb97bbb1vw8l0MckhxtExgqfWw+fQRUfGG6n5857By1MoHuJtJ2s3AhCGQ18CvVrkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654827; c=relaxed/simple;
	bh=koXMEHRUjAnM/w91n8REbP8CRTeI2GxAErKbLAJU2vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lo+a7K2PIB5oAiiCH/BYeiSiMGQEgouK+Kt0E+dM2up2m7QULMcVTlPDSFgvZVir9tAMowkKGs6X/6fQ9GVh2WYq8NQxKRhj4LS0OAzJP1no6MSemVlaRe2KodMkpai7wyEwBCxKgQoOgU9VKmwxcOUUBVwlYxAhjhMPeOXGM0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=GR3FfMEE; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="GR3FfMEE"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1789654410;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=E9L7dnCsRdiDf1+Yg8fUyNvdWsyP7XStAm2hwsYj1jA=;
	b=GR3FfMEExZD/8dbIs7r2nUbULuyni/GXM09B9NQH0y/ELGqx98Uypmoimw35DVJCudCJxN
	u/RDFlQootEBxsE+o6s0QK2r+AreR9Ux6B62tAJJdorjbxQPvtzA5Fq06pMiwBSfhwXdBq
	knkFj9qkPNwiRKTsJ95V05nf93WVlqHpMPMxQMNCSG8xBst08HCKkxs15m9ghTE8D7meKJ
	AWcNXnNvkn862RtJ6qPHVGm8sslo5uMXB5cM9ShQbFi0GSy7JNRSXpCe7Gf3FN2M2hFkta
	3Db78N686dP4kykbWZR6HHHBxjmSnSpgNI4C+mWByEcv6FonwZzD2cHzBLOshQ==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] selinux: constify avc function parameters
Date: Thu, 17 Sep 2026 16:13:16 +0200
Message-ID: <20260917141317.54719-1-cgoettsche@seltendoof.de>
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

Constify read-only decision structs to ease reasoning where decisions
are actually modified, and where only processed.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/avc.c         | 27 ++++++++++++++-------------
 security/selinux/include/avc.h |  4 ++--
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index a9401d6c2e5f..6b86e2b370fe 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -190,8 +190,8 @@ avc_xperms_decision_lookup(u8 driver, u8 base_perm,
 }
 
 static inline unsigned int
-avc_xperms_has_perm(struct extended_perms_decision *xpd,
-					u8 perm, u8 which)
+avc_xperms_has_perm(const struct extended_perms_decision *xpd,
+		    u8 perm, u8 which)
 {
 	unsigned int rc = 0;
 
@@ -247,7 +247,7 @@ static void avc_xperms_free(struct avc_xperms_node *xp_node)
 }
 
 static void avc_copy_xperms_decision(struct extended_perms_decision *dest,
-					struct extended_perms_decision *src)
+					const struct extended_perms_decision *src)
 {
 	dest->base_perm = src->base_perm;
 	dest->driver = src->driver;
@@ -269,7 +269,7 @@ static void avc_copy_xperms_decision(struct extended_perms_decision *dest,
  */
 static inline void avc_quick_copy_xperms_decision(u8 perm,
 			struct extended_perms_decision *dest,
-			struct extended_perms_decision *src)
+			const struct extended_perms_decision *src)
 {
 	/*
 	 * compute index of the u32 of the 256 bits (8 u32s) that contain this
@@ -323,7 +323,7 @@ static struct avc_xperms_decision_node
 }
 
 static int avc_add_xperms_decision(struct avc_node *node,
-			struct extended_perms_decision *src)
+			const struct extended_perms_decision *src)
 {
 	struct avc_xperms_decision_node *dest_xpd;
 
@@ -348,7 +348,7 @@ static struct avc_xperms_node *avc_xperms_alloc(void)
 }
 
 static int avc_xperms_populate(struct avc_node *node,
-				struct avc_xperms_node *src)
+				const struct avc_xperms_node *src)
 {
 	struct avc_xperms_node *dest;
 	struct avc_xperms_decision_node *dest_xpd;
@@ -381,8 +381,8 @@ static int avc_xperms_populate(struct avc_node *node,
 }
 
 static inline u32 avc_xperms_audit_required(u32 requested,
-					struct av_decision *avd,
-					struct extended_perms_decision *xpd,
+					const struct av_decision *avd,
+					const struct extended_perms_decision *xpd,
 					u8 perm,
 					int result,
 					u32 *deniedp)
@@ -411,8 +411,8 @@ static inline u32 avc_xperms_audit_required(u32 requested,
 }
 
 static inline int avc_xperms_audit(u32 ssid, u32 tsid, u16 tclass,
-				   u32 requested, struct av_decision *avd,
-				   struct extended_perms_decision *xpd,
+				   u32 requested, const struct av_decision *avd,
+				   const struct extended_perms_decision *xpd,
 				   u8 perm, int result,
 				   struct common_audit_data *ad)
 {
@@ -509,7 +509,8 @@ static struct avc_node *avc_alloc_node(void)
 	return node;
 }
 
-static void avc_node_populate(struct avc_node *node, u32 ssid, u32 tsid, u16 tclass, struct av_decision *avd)
+static void avc_node_populate(struct avc_node *node, u32 ssid, u32 tsid, u16 tclass,
+			      const struct av_decision *avd)
 {
 	node->ae.ssid = ssid;
 	node->ae.tsid = tsid;
@@ -603,7 +604,7 @@ static int avc_latest_notif_update(u32 seqno, int is_insert)
  * the access vectors into a cache entry.
  */
 static void avc_insert(u32 ssid, u32 tsid, u16 tclass,
-		       struct av_decision *avd, struct avc_xperms_node *xp_node)
+		       const struct av_decision *avd, const struct avc_xperms_node *xp_node)
 {
 	struct avc_node *pos, *node = NULL;
 	u32 hvalue;
@@ -828,7 +829,7 @@ int __init avc_add_callback(int (*callback)(u32 event), u32 events)
  */
 static int avc_update_node(u32 event, u32 perms, u8 driver, u8 base_perm,
 			   u8 xperm, u32 ssid, u32 tsid, u16 tclass, u32 seqno,
-			   struct extended_perms_decision *xpd, u32 flags)
+			   const struct extended_perms_decision *xpd, u32 flags)
 {
 	u32 hvalue;
 	int rc = 0;
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 01b5167fee1a..108d27f31c89 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -61,7 +61,7 @@ struct selinux_audit_data {
 
 void __init avc_init(void);
 
-static inline u32 avc_audit_required(u32 requested, struct av_decision *avd,
+static inline u32 avc_audit_required(u32 requested, const struct av_decision *avd,
 				     int result, u32 auditdeny, u32 *deniedp)
 {
 	u32 denied, audited;
@@ -121,7 +121,7 @@ int slow_avc_audit(u32 ssid, u32 tsid, u16 tclass, u32 requested, u32 audited,
  * before calling the auditing code.
  */
 static inline int avc_audit(u32 ssid, u32 tsid, u16 tclass, u32 requested,
-			    struct av_decision *avd, int result,
+			    const struct av_decision *avd, int result,
 			    struct common_audit_data *a)
 {
 	u32 audited, denied;
-- 
2.55.0

