Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4295C603
	for <selinux@vger.kernel.org>; Wed, 25 Sep 2024 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727295087; cv=none; b=k6bX3z2mrPoRwcXvrDVo/IRQVRzrgilXxd2VgY3jhwAgOnFlpSoxkpJ6zeUSpZvC7kHgn4gvV9a+FwK0S9SxcKtByu3f47K7FNdyHtkyDzpr4rzRyEg3zSPAEYLLLqBJ6BpwnWim8rVzcpwILmgDSZaFtnMRUylPhhz0n6TWxdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727295087; c=relaxed/simple;
	bh=bRCaExXn9SJy78GX6WWTPKudwEh0moYHW8c3sqQDsV0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=n0+uX1eAGKZEje8sKCYHkNugXr6NVAoc3SA8VphDe2sLZgo9l5SnEQZRDxKKxLbNp5huXSrl/LskeL3OIaw4BgU3ok0wZG2hx13qCzTUkM3ixaIB7PMcfwEbj3zcMWIPO0lP0aFBK1Nnv+hIoQm5H8jNw7Ygvfx2VzEs38QBZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=buVgg/ab; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="buVgg/ab"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6c54a5fbceeso1673146d6.2
        for <selinux@vger.kernel.org>; Wed, 25 Sep 2024 13:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727295084; x=1727899884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=v8OUFDaNsvebsCZrN+7fE1u7ofHj89SjASR+7VwOrCg=;
        b=buVgg/ab3jfC5lIB6lWmyUZkmFS9vf6mGBy2xR/8q1l2C8ugwE4YAQYN7zwYRz9+aF
         LwmnM1bD0xv34sdqlEAsSDVov6EJlaHAFdz58w62txe+aD7jH2GdTfnpeqMFAvewfqXl
         vrqzFOva7lMHBmKwozTijAOVTrRykEyyyBhOtY+T6iYI6mNif0VGSHxzyIkgkxZWxwlB
         CB87qt/NFBSY4dtGobj7OFXPZJJ2g0Pl7PR/TmzgfVT7CCyLGpWrIy4bxsdLPfOUH+RE
         ZIJ/bFvpk79UsI0DZ4HDyu2fj1g0Jwi9rca18+yyaiUMvy4Zul13BPLg2Uk54GCWm3mK
         fpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727295084; x=1727899884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8OUFDaNsvebsCZrN+7fE1u7ofHj89SjASR+7VwOrCg=;
        b=fvXBUgeU6N62vJommWotUvkuBg7nSjO8SObouIOO8CH0iWiQtzbLqoQJmYpYESxilY
         jNWdZgFpIsa+m93LHWNY7D2+D/LqvcDbozZNRUQeaj6HFvqgjHbJ7uztleLgQv6RyEQt
         M3wHIqy1IbkNIky6EyPj6dQG6LaCs1efuCKiut4RSUPnYC6x2MEEDBW2OFCTmnlRsPJF
         X8k+gtKHy0DQCrAeSyvFrw2RTRlo+CugL3inrUpB6B8jrJv1QEbyVS9vs2uqoH9hdojg
         MuC5qTXYoQ6aSAKbOLavYoRVCoBwqCou9OK2r9oWb+GqU67YlxgQTAdhssWpDvMyhJrJ
         FTrg==
X-Gm-Message-State: AOJu0Yw6Del6qgDZAELaaCVpQHPFicQdWSEoSHRsqreEz9g+Jdf2nxCk
	+WnyOJ4eWCnYoD4jjAEllZr03HFmojDzMIioIePdCIpLphkHFSDea8RsiccnuXWN+aHImzC0KJQ
	=
X-Google-Smtp-Source: AGHT+IHYC02Rtr9sXnIbiv0xGGHSg6NBXpv+1JjOaGTWSfp1J5AomNto6I5HiX/RK88QvF4075lRKg==
X-Received: by 2002:a05:6214:3287:b0:6cb:2ad6:78ef with SMTP id 6a1803df08f44-6cb2ad67dd6mr25635526d6.4.1727295084370;
        Wed, 25 Sep 2024 13:11:24 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4c2f51sm19135376d6.31.2024.09.25.13.11.23
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 13:11:23 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 1/2] selinux: streamline selinux_nlmsg_lookup()
Date: Wed, 25 Sep 2024 16:11:07 -0400
Message-ID: <20240925201106.16134-3-paul@paul-moore.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4491; i=paul@paul-moore.com; h=from:subject; bh=bRCaExXn9SJy78GX6WWTPKudwEh0moYHW8c3sqQDsV0=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBm9G5a3e6LIVkkyYpFKpY+rLQdpHZl2t8K9gIuH aVcovpHkJiJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZvRuWgAKCRDqIPLalzeJ cxPzD/0f5mVGBWvo+cTx+V8HrZxjF/P98q6IR88PFyZLvZPmRf//unFXupfh/0PbeOIZKXHX8YR HsznyD3mJkGIS4Dk4LvarzVhOPXtUbJyqrfGCIDwa1nrNChuQ/9mPHtoRe4EkzgSuaUiE5htk7k /Ar97IYTNM9kH3bOhTFpqh/G/zXsoseLWqkkyRHOz9Mo40iqWDfhBa0XWWWlO1+U64t/NIUTxlR 5JjHj9om7KSI0DW+4KIzl8+T1MHNwf18KOpip4VZD/YUHZY/MZ5aSElGkzv8VBt5jVGxMREnL9e K3xjk+5xgA0mw7AbKCNoEShVxr0/pVsAjgyoV9PIPrbf1D7KykoBGiCstEiZkOi/75k58LozGp5 qBXFvgoSGI7eenDMN23gzzoVZPvzClSVzM8nftWNtt0ovuTNr3EDaTKh70FXiWkvL8kMQeL0OeI pwoJ3Q8XP9NFQiGg7970vaBCO3siMc34x9Xqcwbe4FxUNtq9pxUOLn+MeoDGp6wQ7Ma0OeQ8RfI GfJUzI9+dWE79amOFCGm5O3qJSSfqIBD0brMRilbEr9RgpWSIEkJI6xyxgQbBNQm+OMdvOXhdpR gzDiC1VNlUtnH3zuW4TSSFm12WQKPSwOf2o0caBJbkD0+BMOQmZNMPSUIOt6C0NSPRvLDUc2E97 OOiBAhIimKEcAtA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Streamline the code in selinux_nlmsg_lookup() to improve the code flow,
readability, and remove the unnecessary local variables.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/nlmsgtab.c | 90 ++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 51 deletions(-)

diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index acc7d74b99d5..f68b4f493de6 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -168,34 +168,12 @@ static int nlmsg_perm(u16 nlmsg_type, u32 *perm, const struct nlmsg_perm *tab, s
 
 int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
 {
-	int err = 0;
-
-	if (selinux_policycap_netlink_xperm()) {
-		switch (sclass) {
-		case SECCLASS_NETLINK_ROUTE_SOCKET:
-			*perm = NETLINK_ROUTE_SOCKET__NLMSG;
-			break;
-		case SECCLASS_NETLINK_TCPDIAG_SOCKET:
-			*perm = NETLINK_TCPDIAG_SOCKET__NLMSG;
-			break;
-		case SECCLASS_NETLINK_XFRM_SOCKET:
-			*perm = NETLINK_XFRM_SOCKET__NLMSG;
-			break;
-		case SECCLASS_NETLINK_AUDIT_SOCKET:
-			*perm = NETLINK_AUDIT_SOCKET__NLMSG;
-			break;
-		/* While it is possible to add a similar permission to other
-		 * netlink classes, note that the extended permission value is
-		 * matched against the nlmsg_type field. Notably,
-		 * SECCLASS_NETLINK_GENERIC_SOCKET uses dynamic values for this
-		 * field, which means that it cannot be added as-is.
-		 */
-		default:
-			err = -ENOENT;
-			break;
-		}
-		return err;
-	}
+	/* While it is possible to add a similar permission to other netlink
+	 * classes, note that the extended permission value is matched against
+	 * the nlmsg_type field. Notably, SECCLASS_NETLINK_GENERIC_SOCKET uses
+	 * dynamic values for this field, which means that it cannot be added
+	 * as-is.
+	 */
 
 	switch (sclass) {
 	case SECCLASS_NETLINK_ROUTE_SOCKET:
@@ -205,42 +183,52 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
 		 * before updating the BUILD_BUG_ON() macro!
 		 */
 		BUILD_BUG_ON(RTM_MAX != (RTM_NEWTUNNEL + 3));
-		err = nlmsg_perm(nlmsg_type, perm, nlmsg_route_perms,
-				 sizeof(nlmsg_route_perms));
-		break;
 
+		if (selinux_policycap_netlink_xperm()) {
+			*perm = NETLINK_ROUTE_SOCKET__NLMSG;
+			return 0;
+		}
+		return nlmsg_perm(nlmsg_type, perm, nlmsg_route_perms,
+				  sizeof(nlmsg_route_perms));
+		break;
 	case SECCLASS_NETLINK_TCPDIAG_SOCKET:
-		err = nlmsg_perm(nlmsg_type, perm, nlmsg_tcpdiag_perms,
-				 sizeof(nlmsg_tcpdiag_perms));
+		if (selinux_policycap_netlink_xperm()) {
+			*perm = NETLINK_TCPDIAG_SOCKET__NLMSG;
+			return 0;
+		}
+		return nlmsg_perm(nlmsg_type, perm, nlmsg_tcpdiag_perms,
+				  sizeof(nlmsg_tcpdiag_perms));
 		break;
-
 	case SECCLASS_NETLINK_XFRM_SOCKET:
 		/* If the BUILD_BUG_ON() below fails you must update the
 		 * structures at the top of this file with the new mappings
 		 * before updating the BUILD_BUG_ON() macro!
 		 */
 		BUILD_BUG_ON(XFRM_MSG_MAX != XFRM_MSG_GETDEFAULT);
-		err = nlmsg_perm(nlmsg_type, perm, nlmsg_xfrm_perms,
-				 sizeof(nlmsg_xfrm_perms));
-		break;
 
-	case SECCLASS_NETLINK_AUDIT_SOCKET:
-		if ((nlmsg_type >= AUDIT_FIRST_USER_MSG &&
-		     nlmsg_type <= AUDIT_LAST_USER_MSG) ||
-		    (nlmsg_type >= AUDIT_FIRST_USER_MSG2 &&
-		     nlmsg_type <= AUDIT_LAST_USER_MSG2)) {
-			*perm = NETLINK_AUDIT_SOCKET__NLMSG_RELAY;
-		} else {
-			err = nlmsg_perm(nlmsg_type, perm, nlmsg_audit_perms,
-					 sizeof(nlmsg_audit_perms));
+		if (selinux_policycap_netlink_xperm()) {
+			*perm = NETLINK_XFRM_SOCKET__NLMSG;
+			return 0;
 		}
+		return nlmsg_perm(nlmsg_type, perm, nlmsg_xfrm_perms,
+				  sizeof(nlmsg_xfrm_perms));
 		break;
-
-	/* No messaging from userspace, or class unknown/unhandled */
-	default:
-		err = -ENOENT;
+	case SECCLASS_NETLINK_AUDIT_SOCKET:
+		if (selinux_policycap_netlink_xperm()) {
+			*perm = NETLINK_XFRM_SOCKET__NLMSG;
+			return 0;
+		} else if ((nlmsg_type >= AUDIT_FIRST_USER_MSG &&
+			    nlmsg_type <= AUDIT_LAST_USER_MSG) ||
+			   (nlmsg_type >= AUDIT_FIRST_USER_MSG2 &&
+			    nlmsg_type <= AUDIT_LAST_USER_MSG2)) {
+			*perm = NETLINK_AUDIT_SOCKET__NLMSG_RELAY;
+			return 0;
+		}
+		return nlmsg_perm(nlmsg_type, perm, nlmsg_audit_perms,
+				  sizeof(nlmsg_audit_perms));
 		break;
 	}
 
-	return err;
+	/* No messaging from userspace, or class unknown/unhandled */
+	return -ENOENT;
 }
-- 
2.46.1

