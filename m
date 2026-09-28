Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9E14EBAC3
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617629; cv=none; b=PexWF4pW++JiEVqnxk0xbP0Gu4yYK6tgrghKgCjDJZI6PudsZJv6KV1cLtmtp0OjFlpFibctaZJO9j1vHmHd8Bn/hb2dksBSUw8955XaDJDUIC7MZtLJXMj7M7sw1X246877zBjGorXUismoTgBb7Ebr7aeq1la9lDpkbghkNDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617629; c=relaxed/simple;
	bh=iNQg420vwA1bKLHiVEUeRD7ESOL6LbwHowukyCMxgDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hllkq4z9bkwmKUtmlEVvh3zVyor3/WidL++SLFI0hexrMGDMypaNXBzdY5KSkfjuDI6ptuDPts5jEwPIBmOyie9Z2b9PAmd81qG1UMTzQIpgJKw3c3ju+32mCGOUXA38mURzODb1Q2LQFl2LBF9x76b0rndymZX8F3wyz/Kjp5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Vzy6anif; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Vzy6anif"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617623;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=czAPHz5IDbhQVAFHLDhZ/D53MG+UHlbS4nFLFDuRyXI=;
	b=Vzy6anifp8jZ74rwTid6omv7X2f4xH0VX/TRXi90r4DVnSQ6M9fBk0VjBYudQ5Fkcqe6i0
	hXJp4wIQ2Fic9Nv4uOuPzPTSuMu37Zi7kgNra+t7Fb1ld8yiL8d2rTanTxPBi5LPCT+nyl
	KYinhhsxmicYtAmvdCbEVstpwyEeTTle+fdNXKB9Z7TV0RVRxXc6H/lCAQcIJeWjq6moZ4
	fra8scfbAyPvM01YJlZKv8IP+0zuSY2qZGWSCPm39iiKkSrZPQhp7b+4+LP68ynAsHUrft
	HJruZCnjgVsW6Azw5Ktd/2NBjRSNc9knQk/plSBWiCRrHJF9Pvm0Cd3xnwSuhg==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 23/32] selinux: simplify nlmsg_perm()
Date: Mon, 28 Sep 2026 19:46:33 +0200
Message-ID: <20260928174643.2458710-22-cgoettsche@seltendoof.de>
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

Pass the number of table entries instead of the table size in bytes,
return directly on a match and drop unreachable breaks after returns.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/nlmsgtab.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index 655d2616c9d2..41618c3f81c1 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -153,17 +153,16 @@ static const struct nlmsg_perm nlmsg_audit_perms[] = {
 static int nlmsg_perm(u16 nlmsg_type, u32 *perm, const struct nlmsg_perm *tab,
 		      size_t tabsize)
 {
-	unsigned int i;
-	int err = -EINVAL;
+	size_t i;
 
-	for (i = 0; i < tabsize / sizeof(struct nlmsg_perm); i++)
+	for (i = 0; i < tabsize; i++) {
 		if (nlmsg_type == tab[i].nlmsg_type) {
 			*perm = tab[i].perm;
-			err = 0;
-			break;
+			return 0;
 		}
+	}
 
-	return err;
+	return -EINVAL;
 }
 
 int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
@@ -189,16 +188,14 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
 			return 0;
 		}
 		return nlmsg_perm(nlmsg_type, perm, nlmsg_route_perms,
-				  sizeof(nlmsg_route_perms));
-		break;
+				  ARRAY_SIZE(nlmsg_route_perms));
 	case SECCLASS_NETLINK_TCPDIAG_SOCKET:
 		if (selinux_policycap_netlink_xperm()) {
 			*perm = NETLINK_TCPDIAG_SOCKET__NLMSG;
 			return 0;
 		}
 		return nlmsg_perm(nlmsg_type, perm, nlmsg_tcpdiag_perms,
-				  sizeof(nlmsg_tcpdiag_perms));
-		break;
+				  ARRAY_SIZE(nlmsg_tcpdiag_perms));
 	case SECCLASS_NETLINK_XFRM_SOCKET:
 		/* If the BUILD_BUG_ON() below fails you must update the
 		 * structures at the top of this file with the new mappings
@@ -211,8 +208,7 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
 			return 0;
 		}
 		return nlmsg_perm(nlmsg_type, perm, nlmsg_xfrm_perms,
-				  sizeof(nlmsg_xfrm_perms));
-		break;
+				  ARRAY_SIZE(nlmsg_xfrm_perms));
 	case SECCLASS_NETLINK_AUDIT_SOCKET:
 		if (selinux_policycap_netlink_xperm()) {
 			*perm = NETLINK_AUDIT_SOCKET__NLMSG;
@@ -225,8 +221,7 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
 			return 0;
 		}
 		return nlmsg_perm(nlmsg_type, perm, nlmsg_audit_perms,
-				  sizeof(nlmsg_audit_perms));
-		break;
+				  ARRAY_SIZE(nlmsg_audit_perms));
 	}
 
 	/* No messaging from userspace, or class unknown/unhandled */
-- 
2.55.0

