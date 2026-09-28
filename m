Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4591D547046
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617632; cv=none; b=AJhSurz4TJ/NLadt86YVsutyg49iFMFpkVGlhY8FjUlFZ1OKq8+l85rq37pXIYHb+wo9FursQXd8ccGETBkjj6OjgLrmUfPBzo0QBRE9avXIixa9wDvv0wbGx0XUBkelWGKnRYbpDtK1ZfgM8phLxiDy+f+XmrPZWeaS9OMG3pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617632; c=relaxed/simple;
	bh=3xbPLkIh5wQzcDCDgBSFLmdkxGQcyeEh9g0S9mnOuaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdkXopyNLh0DfnnYP34MGtr8ONA9eNGECd9+s88uyn8PJt5Ep4ljPZ0+IWdDIeuf1/mWBV0e7cTr7+GdMWzopCyIQGkLOsl+9HvZDhIqNtWyHFVCE8ZbYlFDc2F9NUTSJdz6KZVZ4igjcIFr+ul9Ft3xFOYOdGStkaa0h1XSVCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=LCymUrYA; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="LCymUrYA"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617627;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRxb6AS9m+R1dClUMaZklY4RbLDwHXldCYEUUE/sF/c=;
	b=LCymUrYA3Ij+tIkVfbtwIBxajWQceHlMDwiCjBz5+SRe85EZsV53wlHXRSmPcPDZC9hohj
	IuGC4mESu0Z07SeRfMxll7cdWtE/Y6+xO/Iy6mDKf9RAjdMf97pGlOFI9AmKZr5SOuZ086
	cYSApMSFR6ulPcTiQCvc0+QfSg6keu9sGxU9sLTpd6FS4o45Xnl+/yHcoA7AtirL2ZeMP8
	EQH0vE7XNYD/yy6F2OlUfNwpn5Bszw+1EAlnIjKt4OS1VM8mnzJ1jyVBGGoT8TjqWBRfuF
	MePbxaH6HNYklSQ6CxkCtLNPz0jD5HUiglx4nndnyPpHzII8800+u39PjymJLQ==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 01/32] selinux: remove unused AVC update events
Date: Mon, 28 Sep 2026 19:46:43 +0200
Message-ID: <20260928174643.2458710-32-cgoettsche@seltendoof.de>
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

avc_update_node() is only ever called with AVC_CALLBACK_GRANT or
AVC_CALLBACK_ADD_XPERMS.  Drop the unreachable revoke and audit toggle
cases and their now unused event macros.

Convert the remaining update events, which are only used within avc.c,
into a local enum.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/avc.c         | 26 ++++++++------------------
 security/selinux/include/avc.h |  8 --------
 2 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index dd8905648b6a..936e116b01fb 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -812,6 +812,11 @@ int __init avc_add_callback(int (*callback)(u32 event), u32 events)
 	return rc;
 }
 
+enum avc_update_event {
+	AVC_CALLBACK_GRANT,
+	AVC_CALLBACK_ADD_XPERMS,
+};
+
 /**
  * avc_update_node - Update an AVC entry
  * @event : Updating event
@@ -831,8 +836,9 @@ int __init avc_add_callback(int (*callback)(u32 event), u32 events)
  * otherwise, this function updates the AVC entry. The original AVC-entry object
  * will release later by RCU.
  */
-static int avc_update_node(u32 event, u32 perms, u8 driver, u8 base_perm,
-			   u8 xperm, u32 ssid, u32 tsid, u16 tclass, u32 seqno,
+static int avc_update_node(enum avc_update_event event, u32 perms, u8 driver,
+			   u8 base_perm, u8 xperm, u32 ssid, u32 tsid,
+			   u16 tclass, u32 seqno,
 			   const struct extended_perms_decision *xpd, u32 flags)
 {
 	u32 hvalue;
@@ -892,22 +898,6 @@ static int avc_update_node(u32 event, u32 perms, u8 driver, u8 base_perm,
 		if (node->ae.xp_node && (flags & AVC_EXTENDED_PERMS))
 			avc_xperms_allow_perm(node->ae.xp_node, driver, base_perm, xperm);
 		break;
-	case AVC_CALLBACK_TRY_REVOKE:
-	case AVC_CALLBACK_REVOKE:
-		node->ae.avd.allowed &= ~perms;
-		break;
-	case AVC_CALLBACK_AUDITALLOW_ENABLE:
-		node->ae.avd.auditallow |= perms;
-		break;
-	case AVC_CALLBACK_AUDITALLOW_DISABLE:
-		node->ae.avd.auditallow &= ~perms;
-		break;
-	case AVC_CALLBACK_AUDITDENY_ENABLE:
-		node->ae.avd.auditdeny |= perms;
-		break;
-	case AVC_CALLBACK_AUDITDENY_DISABLE:
-		node->ae.avd.auditdeny &= ~perms;
-		break;
 	case AVC_CALLBACK_ADD_XPERMS:
 		rc = avc_add_xperms_decision(node, xpd);
 		if (rc) {
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 87027a934a11..0f788dfc66e9 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -149,15 +149,7 @@ int avc_has_extended_perms(u32 ssid, u32 tsid, u16 tclass, u32 requested,
 
 u32 avc_policy_seqno(void);
 
-#define AVC_CALLBACK_GRANT		1
-#define AVC_CALLBACK_TRY_REVOKE		2
-#define AVC_CALLBACK_REVOKE		4
 #define AVC_CALLBACK_RESET		8
-#define AVC_CALLBACK_AUDITALLOW_ENABLE	16
-#define AVC_CALLBACK_AUDITALLOW_DISABLE 32
-#define AVC_CALLBACK_AUDITDENY_ENABLE	64
-#define AVC_CALLBACK_AUDITDENY_DISABLE	128
-#define AVC_CALLBACK_ADD_XPERMS		256
 
 int avc_add_callback(int (*callback)(u32 event), u32 events);
 
-- 
2.55.0

