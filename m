Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B551C1547C0
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836359; cv=none; b=MMvaDc83Cb0iEax9TfdbyExFwUbB6ko2BSHn6aOD/VksE9hW2kmtCa4g220NJwYe8w8RxGWA6DskN/Aqe9C2f3Cg+zNKiq3ylTUCXLSrqDkj31RKmbLREm1NCAI+JsfUJW49iZSW+HD0ruGaZmDFcF2arsOJET5IfLiTV0TZMLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836359; c=relaxed/simple;
	bh=VIgkTQn0xV7x2gTfMKwPNCh4kXpuTR0cCqL0zdcMSgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DYtRZu/cmMf3VfgydEyFshal+5uNJnCMozkKfX4sPE6XKSCdCnlOFjrm0F8/xVPPXz8/rTeStkMxf6ZGL40dYfHrk0k5kJPMn6cav6D0WIyIA3nzkZd9Jj5AIPA5PhqtwqyqnC9om1qGXxp2QOk75gG3e57R4Hel0/h+h3y7Z/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aft3odXo; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aft3odXo"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6dd43b08674so73839536d6.3
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836354; x=1736441154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSH6OXioNwnoY/0Lz5QCJEkuvXAEGypy3/AMiwEK00M=;
        b=Aft3odXorlNvgIXOVFv4Ip3lX66yD7RumWXylN3nuFQSUhBDWv5+BaqTZGMIGiFXlq
         toqAVEDNgl+d+rByiy24CV3GdgQn8or+nJf6dNATYGVdfv75ic9dGJs1stNsaHOiwkrE
         /BqanYvTN3bzmsQWfCZmoIk+BjD8i0yw2v3F/SNHnk9VTr3AJpGtCgr2j56bfc4Dremj
         2nRRBHKljBkxOTFixdAbVNAZYsMJ0kYx4OF3MTzCAG7BUUhmpUs9WK/fpK4BIXoxqWCZ
         Bl6mS4/Vp6a3bjbn4u3aPPA1ZMyMbMOScJSdayp471aFIL5PEB3+1cBVHsPjAVfwaANB
         sK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836354; x=1736441154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSH6OXioNwnoY/0Lz5QCJEkuvXAEGypy3/AMiwEK00M=;
        b=mv2FNJQHam1CR9i1xs0g5QDqwDYT6uaMrMw2Vpd3CJgLTscmBTOyBJ4SzpebXpzGP6
         2w1iavq7c7qU5hoSxjXpegq3+dCIIEYe7VVGB8S1k2zuabb4m0Z7ffVrJPKc4Bwz5uWY
         bGd0q8V+3QnYO6XnaqoamYc4oNpL3uQ+OBgk4uxO7Jx/B4FS5UtytnjQKGMzXxEZQn2x
         nSJEIi8jaQmeRh1mpJwiGQE3jcjirFYwuJUZD7nQ8RjQnC3hrbd44PMDyUNw8gQRt3NE
         NG+sgdBwFTi0ZgvI0AilPmlDL7Cw5441b+7cBxatBfhh3kMKjtIKdm4OowCcGzEa4Ltk
         P0YA==
X-Gm-Message-State: AOJu0Yz7bt870rg9nVp+g2XTpHv0uZkQqDABg03oNCPINIYJ8u7mTzks
	s3ESgFmxEZRyvzFvJ+J2tTEIr6bewkwPoe4qYUCewFdEa9QxwGRsY616pg==
X-Gm-Gg: ASbGnculQS1NchbMlWzPOQCCyhdwoSpdKZH8JM1qvV7yy67IwlDH0yFi4fki0G+vkRN
	/YofDyRyYZg/hJD7qufxoSJtm7LTSI1Fc/+AEPQteiG7hE72KLotCF8oarmA9GUocUkps0VuERp
	U2oPlsc9CEKq8wwkguD8AEXfbkCOm1gYQP41B+a0Hy04S61k3jfbA0n9jpRLCq0vpra6wCCePW+
	KU4TOu1lm5mJX97QG0ZXtSbI7qcyjGaRUJ05MoKJDBigh7MIuN3rx/td62cZideYxQpctyYxKa7
	zpsS0xJ2ZQignynA4l/eUoi5DxuSRHehzhmCwWi2cxrkOYfwgL1WtnYlGMBkySDj1aApHA==
X-Google-Smtp-Source: AGHT+IGIl5nI2ch3XyG0iNf0jQzb9/9Y/dsYbnBCqQO8q+0by1yFo+hzPmc/u/9wVx0vyRpdF6RB/Q==
X-Received: by 2002:a05:6214:76f:b0:6d8:af37:ae5b with SMTP id 6a1803df08f44-6dd233acca7mr739055116d6.43.1735836354279;
        Thu, 02 Jan 2025 08:45:54 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:53 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 28/44] selinux: convert xfrm and netlabel permission checks
Date: Thu,  2 Jan 2025 11:44:53 -0500
Message-Id: <20250102164509.25606-29-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
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
2.47.1

