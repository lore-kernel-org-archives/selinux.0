Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA687299AA1
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314642; cv=none; b=Q1JK4XG3AZ7lHKqPD253H0UvjAy3VMiGZrLILibzb4K9AhPm+nZEy/SXSBeDMHFChsaCjuAI7LUljSHVHEhIAsVb/CQM8JjRFqQCzUHTc5QHEJ8g7HvL9UES851V4oVoowtftnyUGphOMiO1KyIVIKf4T8uS/FTJDU8SZXsOXqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314642; c=relaxed/simple;
	bh=QanEo+QGGszDR0Sk/3PJwI0RgEt2GEePQCIZAobVUgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNBiK7GkRQSvLqUli0Ry4bspGQ3bflYxCCC4ZLoyFNunyHCdqCIo1NiHo1z+odJUD++qkZTrBuORlkShhIHAMHzHMOwagKdmZFB9ib34QCo1Llr6usW9hUHdUp0tn5pzsKAG4A4Nzs6tNkS12n1VhbInabGTwiJlhGgValuWY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5iAPgSJ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5iAPgSJ"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c58974ed57so91778585a.2
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314640; x=1747919440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4snp8j5f16mfsjhTubK6LH83nFpMYq7LYKMK9jFRaxQ=;
        b=f5iAPgSJhHoc3JelzFp1CezDX2eYgp0WqKHOnPYE5HUesclL+rgmy5c2L/IiALB3ja
         OAjznpWwAflSKK/+M4ogb7YpM4yFvnx4WJKatlDv342F0aQzpa5T6cKrUtGxNREr6Emg
         12SgNUmVdXK8wEYD4+lExatAMvDCB+m8hLwhuYeXm7Y62Q9g7PB+kroxyv5vPpJnfOMd
         6tNPh+lO66gMXZwx8GUZS95TMe886tnFu5djv1UC+4cMK9hz8oSjQeg3XWx1VlhMpzPb
         +iloLTEi3P4rwa9RpMVK5c4bIEHI1x2D/S43tKQJNbP+3I1oAqgeiuugM5AYxhyPi7UW
         tajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314640; x=1747919440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4snp8j5f16mfsjhTubK6LH83nFpMYq7LYKMK9jFRaxQ=;
        b=mjPS5+AHB0URcFU/Opma9WIclzv3miEUxjdoaf2l6dh+df/RBQFr+o1cURscBDjvh9
         KN9ijWZnHzftwGxgUk0WcCm/dyHuV1graUFtXBs/eJYJ8IH5SxQ3TQXmfhSi8860Fk+J
         Pu6pEDr/AWHRqRnYuJ8dSvtdgXCbbyLFQM5uR/eTU/o9i5z2FlUe3kdoZGDUsGBYNuj+
         IikvvjW3mde5GIhIf7gGs042L++OabGVba6ulU1i5PQYTDA5zqvzZYjIUrz2mRiNd8Ut
         OKuPRiWs/QN53djMPydtLvQekuOjLhN1DDfH79rbaWKEXIc1t6x0nhywtYyPeeutqpa9
         BCHQ==
X-Gm-Message-State: AOJu0Ywed1X9K6b0fzR+s0mk6gSjUqy+BMyj9xqHotRGe/9ztlqk58Mx
	ipR2+XHm2hwNtp3rPz1rcerNJdIXqQCZA2BT5ii+wRHX8nlYHBnFG74eIw==
X-Gm-Gg: ASbGncudsu8K+ea2HXXJyzT4XM8hrdhhKqxGfxPVc9JuOvsQ5AinREAminkd5swozm4
	9iumMpJ53i/fCHo4Faw9bWc8PBI4cFcVe7DnBVgzn4vCvg8PdxZhkHVRK0/Uq7rk121/WIBBAPT
	I5A5P9a7W+wno6gxipBmfvZfT4Tj6XQNc+jo9DrutLMkcmGQ7aIqaIpxOg9CUZ6utCAQJ92g5sn
	0bPzV6DoNggr3kDgVn3TMiCf3OCOnR+tT8cVUwYaMlim8CCuqYA1z+1dyO9Rltu3YIgmHVXgMtZ
	XUTQUcFUmxCOro5D0mqDa38xTZcbiBdsBe1WsrP/2pyVppHhCo7I5t01SxEC5jBQbLiJePiFpOw
	mw9MGT2ImuFAqYSda/TALKfuEnpkueY5+0VKQ/J9VkUXoZHAjgZm/Og==
X-Google-Smtp-Source: AGHT+IHDnPTxAYf+/UF0QRs7wE9pUnOQ0qE98YZvkK+vcr/Ch8SLHvXmXcTrHQa5AnDXfn3lP98tog==
X-Received: by 2002:ac8:4a87:0:b0:494:9ffc:fcd7 with SMTP id d75a77b69052e-4949ffcfd25mr46845921cf.12.1747314639463;
        Thu, 15 May 2025 06:10:39 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:39 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 28/49] selinux: convert xfrm and netlabel permission checks
Date: Thu, 15 May 2025 09:09:26 -0400
Message-ID: <20250515130947.52806-29-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
References: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
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

