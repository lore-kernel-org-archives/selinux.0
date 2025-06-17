Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF2B2E3AF7;
	Tue, 17 Jun 2025 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169212; cv=none; b=YvefLm4MTCsWErQBT1629dAnJCUzvM69AxXrqrXHNVSUNKs2UzVQEragZth5UzGJZW10wGwiGIoUhLJRi1U3iIBVvBI29XNZx8MlumMIOjm/89zhyRkuozL5/Z/YjXXPsWh6RHNhDBZpFmfQBo3ciJFe+2hlTyCZRp3iTZY2qco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169212; c=relaxed/simple;
	bh=QanEo+QGGszDR0Sk/3PJwI0RgEt2GEePQCIZAobVUgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvL0dqHIEuyfKZKySIGRI3FZx9LUwVTX7A5PhB2Os1bbUxo2toWuZbMHz2+9Y2sAeswYP1DmLgfoCFNf2LR+nEcPo/dIVOe5ZAcER3z0s9Sq1Bvk5qfLI2SrZsjO15djtSu9FP5u6ZPahqXthPE3k6UzzUHQZ4iOoOYB9XIeMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZx5vJ+/; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZx5vJ+/"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7caeeef95d4so636294485a.2;
        Tue, 17 Jun 2025 07:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169210; x=1750774010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4snp8j5f16mfsjhTubK6LH83nFpMYq7LYKMK9jFRaxQ=;
        b=KZx5vJ+/J+RdjuxwRY3oxEImjY1l1C00fcC3R2KGvBueLzioHfm2FqeQV3odjGekC7
         MIGJ5ClaXrTK4AH4pdJD+QCEZePHBRshP2wJfeyc28HFQrhGjEjOn37nUbyFtZtXa6Mk
         BoE2Q/lDRLOM6quvEYzmr2v8/ggygf0Um9s08jVFw8cHdl14plMTTUYQODFF7TnSvUGd
         1uI+iKjWBlcEFtXmNB6r50emb6Y8fLGj86LsJD4hQG4J6SQ+9979LjsdrCyz5bpZ1sOl
         GqkPO2T67SCKHLAquORBCrV1fzlplIr4Krg6sYI5HgLFvu3EwWSomCDfv+w74pFZ3sOU
         K/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169210; x=1750774010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4snp8j5f16mfsjhTubK6LH83nFpMYq7LYKMK9jFRaxQ=;
        b=wJke2YhjLVdUoPATQGUb2HTjFjzxI10C3o+AE6wuMD/hq68AXS1zQK6a6+XSZLioqm
         yqMT/EGBE3FAbhBAKkWCXqpWGdhHkh8Hl6S6hT4BhgaDkJqz6Qi0EY1hfvVaX0GMkddp
         55gpXACJdq9hBup+i8o1iQwuJJI4KGNAWH58qeN8hv+YA70Fn/yQAI2zxx2cdqo26s/1
         Xil6ydP0zSVNHMcZhhMYo4amdowt06oXWdHOsHMTlb/87LpplRcz1qCNGza9j7VEwLaQ
         NnV7vG+WaCpVXRK78AwSyXXiAKufDGulT8bXs3R1BZ1J+VMJ2dFglZwM3UJpB9Ry2h8N
         6v2w==
X-Forwarded-Encrypted: i=1; AJvYcCV5PKQrua/0oinbiBhtSMizfpLd7tYiHzHDw2GpHdK/6mvZikhIDGUfbU4s/upqWZhCgbQhVJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Mi+NMTj3Zo8tRNC3oqIoz93MA4Jn8+cYblAajnIHnEmlmyFH
	jVj6ruFxnchGSAtNrAhiuXSRPL2syZ+h4yGujWUKUSUwfoDJilJCO6eDBYzvmA==
X-Gm-Gg: ASbGncs0M0AEMNStus+D8PgbdVaneIUDpwxPJjm5TrbOEpb1OCpI/TQVnvfoRrR3hxm
	FrWRPBbqcWYbIUpU8cQExkQyxLNJydKA/JS04eYKyqsf9tU9e0ukcHAQAGIQyhNhs7AmeeDFnus
	fw7Ul+DZRAw819J3qA6MqOzljK0y0SqzjnM7nFmL1F/wcM+PJEM8DomN4VajLMnNbnJa9YDmDfg
	t7kkcymqx8AG3HywJiUzIGGslHxy+xz/fx1FZb2J5WtRyguUg20wGBvGK/h5vH6cBXMpPdsrjHQ
	CYpuwin7/10NCmpwuv4k8Ld8TRElpSBlCOGTupx7xsjd9wpxFLBy0FuV0mBhYtvuCilLL4ZPiXk
	7oLgbwXI9oVuLNDR+HR3HXF/iY8LmysoAQ5Ep9g9iLkCcn7dzq9e5z2RYb78C4UtWfQ==
X-Google-Smtp-Source: AGHT+IG5EyN3lBwq2NuNBfMHQOOXGMkLduLruYNMnU6omd9FLTRXr3vVyQS0XyPcsJZmjoOZus0KZA==
X-Received: by 2002:a05:620a:2628:b0:7d3:8f51:a5a5 with SMTP id af79cd13be357-7d3c6cfe4efmr2253152585a.51.1750169209714;
        Tue, 17 Jun 2025 07:06:49 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:49 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 37/42] selinux: convert xfrm and netlabel permission checks
Date: Tue, 17 Jun 2025 10:05:24 -0400
Message-ID: <20250617140531.2036-38-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
References: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
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

