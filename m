Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BA726B948;
	Tue, 20 May 2025 12:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742514; cv=none; b=pxSHhEvIvIGmdquWaSn4qrZjfT1e1Mwc5RW34u7aU21SX5/cYhjv9gtwicVukXzIhEFW+KgP1OJpb/1ArbLEKHjYXBXhLOY4LCCNBMNCx6aBZn5VfO9EW2LiZxy9ejfIj8FsCchmR9p/7vG+MrAJotJl2DErZAdXktKf4nadcKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742514; c=relaxed/simple;
	bh=QanEo+QGGszDR0Sk/3PJwI0RgEt2GEePQCIZAobVUgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUg+aJuxIXEZgF2gudjgHXv58cvP7DIQ5o+Rh6S6hbzOYg0QZ1gDNgNenOd/r1/8KYhFfr2COx8eH99uxWGUm5208i1YMsB2lg2rJdCzUr01qyraAp5zGEfKVrCQspKgA0Ek7rJbVmbruKyOLlHpERhQ/N/ZTG+km/1PMifj8vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/TRNQKZ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/TRNQKZ"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7caeeef95d4so568642985a.2;
        Tue, 20 May 2025 05:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742511; x=1748347311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4snp8j5f16mfsjhTubK6LH83nFpMYq7LYKMK9jFRaxQ=;
        b=J/TRNQKZlKLApjoqJEQWw1LsokQLT2XHjVx0Pu1NZjoCxUuF4NleVWt9b4sm5dmeFf
         bRvIt5oHGp6MddVYPKg8J3eLW/xVfmsj6pbT7q9QC9ahNCKsv5YZnrby9QOw9BALibWk
         pYvqrP8b1hI0GsKkbnbA1srlbfL1G/tQXkk0ayrKDym2sH3PnKIhhcWrwAdsUwYT/XSL
         Ngxd5wSuStNcJR58n5wZu0phIQp9qolnLWXYeObBfZVo49UMEieoJxWv4u/PqGMlRopm
         jCbe+jrwI4F8AVb0QLTCj9tl5Om53hsqmM/gUtsikzKVtubv95HAODypfscTsY2MLk1N
         LNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742511; x=1748347311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4snp8j5f16mfsjhTubK6LH83nFpMYq7LYKMK9jFRaxQ=;
        b=OjF7T4juw5e2lDboZIYMzaRWkpWw4IdbSMNo+7eL8n4nANja0wDtQTE4y2eM5LXmot
         88Y2RXbvGb6OyLWBrE51UZX14HJ3hK8BUXsdbT3P6OopcNrUY2mLL3z+5TpR+DvaGCWS
         raYDYOYwz8vD9qK/05UnLp9DBxpxQgrvx7JzaAP4RpA3rNEObXRCiUWoDVbBHzrLak09
         D3Wmm6cv8S13Nv8wxHBtDZoOuqYDfu3g+5Cp83+opwdTDzQr1ckcmAybeSfdbDps4fcn
         nKOH7szrxNp1TFt3mJhv7qOMWGu3CyEWTRM5bm1KPObAqD31+UsDecQ3Ymo0dTXZ/QZP
         hjzA==
X-Forwarded-Encrypted: i=1; AJvYcCWuxZiVa5kmHgZ/bgXS/xoRNLO6oXdMROBOU6CLgEXQSbgvvChM400tFl0JRc5QVhWj3i+9iZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnOvmCCt80be9rdFKOfYBmKjoRNueXRTHZ+IOUcjVGwSmIvd1F
	csDcfNe/IZaAm5vktOzM8JDrR0Ii3qKhlUfneiFUllZg6+IH9S+n8TU2JAXcKg==
X-Gm-Gg: ASbGnctC2i1DqEqaX61ZGhohoR3FizEkU5QWmZViKRPpdSErqb42sq1QbuaPPUERdqC
	aqE96/dcxnfJNfg2H8csqNsmM2jFT7DhTP24S2dn7HPo17yz8lOiZPaPq0aYmUHGq1neWyGQbIr
	Nja4+lNvOuRvh9fX88DNl2QRdunPPnTTjUgha6cih5xouYBDmAsGJ7RjberC33DKtxuXpmag/H6
	+UKQesYoRPewYL8vlthFsJMJmY2soWMFY6B00r9rFCFd9GCGFdsUoPi5dEgYSmIvJhXXgJFf0aE
	Hnj/cmKOW57yT9RjxjPoVZkEO2DDl1GY2ngU2VbCinS48F9xq2hanpSPzgfjw84LGv82hIif407
	ZUeZV4tBK3Y94c1RyTKpDvc/hXvF4pjD9eUcc3pTS+ol1m6q+F7akHA==
X-Google-Smtp-Source: AGHT+IHmQWhrjCgqEd1FUb76Pxd+xR6FvlwBcJo2zbw573o2ZANqF2Ri/eWXg7S97BQIZi8lGw4jBQ==
X-Received: by 2002:a05:620a:11b0:b0:7cd:5b2a:979e with SMTP id af79cd13be357-7cd5b2a97eemr1952973585a.30.1747742504235;
        Tue, 20 May 2025 05:01:44 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:43 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 36/42] selinux: convert xfrm and netlabel permission checks
Date: Tue, 20 May 2025 07:59:34 -0400
Message-ID: <20250520120000.25501-38-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
References: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the xfrm and netlabel permission checks to use the appropriate
namespace-aware helper for each check. When in process context, use
cred_tsid_has_perm() to check permission; when not in process context,
use selinux_state_has_perm().

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/netlabel.c |  6 +++---
 security/selinux/xfrm.c     | 33 ++++++++++++++++++---------------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 9c360f2ee7fc..06ce45f628f8 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -137,7 +137,7 @@ void selinux_netlbl_cache_invalidate(void)
  * @gateway: true if host is acting as a gateway, false otherwise
  *
  * Description:
- * When a packet is dropped due to a call to avc_has_perm() pass the error
+ * When a packet is dropped due to a permission denial, pass the error
  * code to the NetLabel subsystem so any protocol specific processing can be
  * done.  This is safe to call even if you are unsure if NetLabel labeling is
  * present on the packet, NetLabel is smart enough to only act when it should.
@@ -478,8 +478,8 @@ int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
 		perm = RAWIP_SOCKET__RECVFROM;
 	}
 
-	rc = avc_has_perm(sksec->state, sksec->sid, nlbl_sid, sksec->sclass,
-			  perm, ad);
+	rc = selinux_state_has_perm(sksec->state, sksec->sid, nlbl_sid,
+				    sksec->sclass, perm, ad);
 	if (rc == 0)
 		return 0;
 
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 855f77630bdb..be91a28ab47b 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -102,9 +102,9 @@ static int selinux_xfrm_alloc_user(struct xfrm_sec_ctx **ctxp,
 	if (rc)
 		goto err;
 
-	rc = avc_has_perm(current_selinux_state,
-			  current_sid(), ctx->ctx_sid,
-			  SECCLASS_ASSOCIATION, ASSOCIATION__SETCONTEXT, NULL);
+	rc = cred_tsid_has_perm(current_cred(), ctx->ctx_sid,
+				SECCLASS_ASSOCIATION, ASSOCIATION__SETCONTEXT,
+				NULL);
 	if (rc)
 		goto err;
 
@@ -137,10 +137,9 @@ static int selinux_xfrm_delete(struct xfrm_sec_ctx *ctx)
 	if (!ctx)
 		return 0;
 
-	return avc_has_perm(current_selinux_state,
-			    current_sid(), ctx->ctx_sid,
-			    SECCLASS_ASSOCIATION, ASSOCIATION__SETCONTEXT,
-			    NULL);
+	return cred_tsid_has_perm(current_cred(), ctx->ctx_sid,
+				  SECCLASS_ASSOCIATION,
+				  ASSOCIATION__SETCONTEXT, NULL);
 }
 
 /*
@@ -162,8 +161,9 @@ int selinux_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid)
 	if (!selinux_authorizable_ctx(ctx))
 		return -EINVAL;
 
-	rc = avc_has_perm(state, fl_secid, ctx->ctx_sid,
-			  SECCLASS_ASSOCIATION, ASSOCIATION__POLMATCH, NULL);
+	rc = selinux_state_has_perm(state, fl_secid, ctx->ctx_sid,
+				    SECCLASS_ASSOCIATION,
+				    ASSOCIATION__POLMATCH, NULL);
 	return (rc == -EACCES ? -ESRCH : rc);
 }
 
@@ -205,8 +205,9 @@ int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	/* We don't need a separate SA Vs. policy polmatch check since the SA
 	 * is now of the same label as the flow and a flow Vs. policy polmatch
 	 * check had already happened in selinux_xfrm_policy_lookup() above. */
-	return (avc_has_perm(state, flic_sid, state_sid, SECCLASS_ASSOCIATION,
-			     ASSOCIATION__SENDTO, NULL) ? 0 : 1);
+	return (selinux_state_has_perm(state, flic_sid, state_sid,
+				       SECCLASS_ASSOCIATION,
+				       ASSOCIATION__SENDTO, NULL) ? 0 : 1);
 }
 
 static u32 selinux_xfrm_skb_sid_egress(struct sk_buff *skb)
@@ -425,8 +426,9 @@ int selinux_xfrm_sock_rcv_skb(struct sk_security_struct *sksec, struct sk_buff *
 	/* This check even when there's no association involved is intended,
 	 * according to Trent Jaeger, to make sure a process can't engage in
 	 * non-IPsec communication unless explicitly allowed by policy. */
-	return avc_has_perm(sksec->state, sk_sid, peer_sid,
-			    SECCLASS_ASSOCIATION, ASSOCIATION__RECVFROM, ad);
+	return selinux_state_has_perm(sksec->state, sk_sid, peer_sid,
+				      SECCLASS_ASSOCIATION,
+				      ASSOCIATION__RECVFROM, ad);
 }
 
 /*
@@ -469,6 +471,7 @@ int selinux_xfrm_postroute_last(u32 sk_sid, struct sk_buff *skb,
 	/* This check even when there's no association involved is intended,
 	 * according to Trent Jaeger, to make sure a process can't engage in
 	 * non-IPsec communication unless explicitly allowed by policy. */
-	return avc_has_perm(state, sk_sid, SECINITSID_UNLABELED,
-			    SECCLASS_ASSOCIATION, ASSOCIATION__SENDTO, ad);
+	return selinux_state_has_perm(state, sk_sid, SECINITSID_UNLABELED,
+				      SECCLASS_ASSOCIATION,
+				      ASSOCIATION__SENDTO, ad);
 }
-- 
2.49.0

