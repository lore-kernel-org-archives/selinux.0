Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEAB254845;
	Tue, 10 Jun 2025 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576214; cv=none; b=uNMjHvXkknActZ3rV8snU3kMrJRamD3Gv3YM7x8JnyfIFDkvC5ikqXnvdeinjEmmWDuJIl3TaYRYzN2EnpWUrxbPM3xFXwBnZpCY6Hn4V5orC6/D5501Q3LrHuJB4xPm43QYB/N689w+RuxRExHuX4yDFhsRI17QlUoPhw7bxoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576214; c=relaxed/simple;
	bh=QanEo+QGGszDR0Sk/3PJwI0RgEt2GEePQCIZAobVUgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFzDqbJc+d/KzXi5bKt2L9uT5LxxPxbqIM+778uCIwitb/1O9Q8VyrWH8qBANqQe+RQfPiwfHEQvMP1XO1p+ZwG4BEWDiwEZLt0emr6NnQD1Wh79Iq+eaIf1vsfsfGYVAg3/+t0ocjbRKt1Ue2J27R4vVInORWvHyOzWrhYs6xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZulVaIAY; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZulVaIAY"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d20451c016so309513785a.1;
        Tue, 10 Jun 2025 10:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576211; x=1750181011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4snp8j5f16mfsjhTubK6LH83nFpMYq7LYKMK9jFRaxQ=;
        b=ZulVaIAYc5HrHHTlQPXSQPjpoE/Px6mO+d0Xpy+ktixsxZyjrl3GxySnb6ZhFQeziv
         KxER1NaV2+USH9266/KADzcVENix8CoqBkfbF8xmfe0Tcx6ZsUQ8T9NpypLOIBww4+NV
         TplA0oBs0A+wF0surNz1CKnH7LSODoQHP/tMcP5uqIhkggYyQCjrZ91vyuEnK2oPUpBy
         NFGmOYcP3ll1B6S/v22Ci+WwUmqQSe3XM7kCof6ltn1Ptt560hTOR5nlVpAe/gZJmmTo
         rpZ8AHkX8tTYM+0gePZSO5eJJ7ky1IGlB/8hwM/ChmRuDE3kSMq8bXf1B+bWJJY+tGO8
         UfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576211; x=1750181011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4snp8j5f16mfsjhTubK6LH83nFpMYq7LYKMK9jFRaxQ=;
        b=EnCRhpoukAKOG80sPHp+qJS3zIj/pBR5PioNQaw5J5r6LYM+WafxVqgAPIg+4aZqeV
         ZXwSKhNdNex3ZkNtoasX0YZo4svpjvTweNKncMkr+TwWLYJK9etIP+hrWvyq4VzPX4fU
         xb/zOFDpZ4FVJ/tXn/BUeb/LC9C4ikHm80PWGpfPfRtcy8lnA4WiD+Evp3xQnDWmFKHi
         qI5OiF8Iyn0p4iE7FWKYKJRvSL54PVP6p6mlKFYOtKy0b/EE27ZlXt+xuWzz8qKqX8yy
         nfwb7fsKRZoEUimh6162xHG9VRDER/6ceQKCUq6H4LHBro9pFrllPCm8codN4opgaO27
         uwkA==
X-Forwarded-Encrypted: i=1; AJvYcCWUmym/gRaPJzUdR7xq6PM7RnuJ0B5OIDTLS7scknJ8PzrJ/rVB7JsqFq+oJ72TovZwFJWdiTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ZCzxvdMflEFVZp15zOBw0t46geTSRhoyIcGqrdvpNYxIRcYz
	M30iU6i5lc/vynv1cT1kbZ0aa0WzITmMmYpHV9A72Uuf682TujL9p/5cp3o6NQ==
X-Gm-Gg: ASbGncsmW+l97VKd+pYsziPqgcN1nhQmsY/iXGQH7D25GwQ0eKIF8fAGhokNr4jWVBD
	kz6EM0edIaXemfqifuSVrIBSw52IJd3IM5931E+gcm6aFrRIGewU5Me2yX/ITY02IXNDYZF7qeL
	CH0/h01dx+YydOP2SB60KIOinHSpknzg7h8i9NfGG1WKb+7VZuoMJ5xsBH7CFsxqsVs3vIJb0Fb
	mELJ/c51c54cDBQJ6absUgTx/psqljJiiDiLPcSwmtaLHipYxDFh2e95vmeX4XtxVvO5jx3xKnV
	HN313ZEvD2iLopX4C13ZAzbl2Vk6LyWQ2hp7l9Iin/KCDsXXqjqfkiWZbhV0vkEoHD7k7Dx9EHS
	JAoGn2OjHh9DqfrrAc5S9bFLk84xXir6KNK8pWGlJo1r+ci1dr9s2tMAw0EZr2O6/kgqvsELJcz
	OK
X-Google-Smtp-Source: AGHT+IHKBSlKL6lN+hvI9m6LoE+FYW3eO0ZgMDz+zmICxOARy8Hap0MdHNVb71GJK+9YLNJAQ/WVZQ==
X-Received: by 2002:a05:620a:2714:b0:7ce:b4d4:395a with SMTP id af79cd13be357-7d3a88232afmr35856785a.18.1749576210640;
        Tue, 10 Jun 2025 10:23:30 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:30 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 37/42] selinux: convert xfrm and netlabel permission checks
Date: Tue, 10 Jun 2025 13:22:08 -0400
Message-ID: <20250610172226.1470741-38-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
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

