Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423352F19B0;
	Fri, 20 Jun 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441550; cv=none; b=R0NgfqOmpNBJXSw+MOlKW3Bjmc5xREkRPa3P9AGYsFqd+rN6Ts5X5dYBWt9ceUkrNsOQ2vbNPStcXeeZq6Glo8V2FGbXAbL0Q0+EdG+ZyVXvA+omZUfHzC6CS/rBfNw+5496Be485IxAtEti+18M45AqBHJoklGkU4YNGjQTSfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441550; c=relaxed/simple;
	bh=QanEo+QGGszDR0Sk/3PJwI0RgEt2GEePQCIZAobVUgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYkOM0eN5AsZJ4NQcUYYbltjkm19J9DDE5kQXKOApzetNY67Kg7pEO6eJpVXOcBXM4UmGIPaVu5TiKNgapd1MuYguQoNEaEvUoFVxeAdqAPbpj6994lmh+5gZOk1iR28v+2oPpxzgUayDwNt7kGPgP9jlXgI7l39C/TDicAy/n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiyvYhci; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiyvYhci"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a58ebece05so19069871cf.1;
        Fri, 20 Jun 2025 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441548; x=1751046348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4snp8j5f16mfsjhTubK6LH83nFpMYq7LYKMK9jFRaxQ=;
        b=iiyvYhci+wwmkQEK/Cd4W0ygFPXFu/4UVSgKr8+ZSn2/OzmfvkmtaWuxWzhPUyRYX1
         6OgIHWZSoJXob9G3tIvWXrAGjfwD1ULRSve8ggTR6/48ILD666vvTKRj3BooDGDtlPoA
         raJrUXuX+URnLBS1zencW5qYxiswMf8YIZuU0ZPj8qKGddrDrX81gwrEMSUZySxy2qDm
         9VQM7C/c/nT6uLCxflwpC/LPBHHRXE8XdVZA6sfTLuCPGozgQ/bM2d/WwXGy0Zz/ouLL
         kY5YtKqkrPAUy6jNWvqw7iX8q9mLHRskKYc92jnw0m2guj6kySgNq7l53V9Y5eirURe+
         AISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441548; x=1751046348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4snp8j5f16mfsjhTubK6LH83nFpMYq7LYKMK9jFRaxQ=;
        b=qLWLIt8bwoCeku2W+XXu6dlk1/PCjH34R5n3Dz6+IoyOKCDfpnzBwOOQmO7TmWRgxj
         1GZQI5YEKzyk+cRq3vEaQ+w9ApffGQVced9DeZrp6tf62bv6FtbgMz2sR34MEXlA9CRI
         UhYHYLt/EV2R3NPGts46CpQBVINaNZ/p/iwYAOWdiLiCa9oYCaSvuUxE54xSRkZwPGQp
         V0fp3Th76jF3QrR5kfT10ZXY+G8k4QWvHynsj8JUp2C48sDBurBvNHslNwFlGSsu8xIZ
         OU4EQ0MPBHaWFk/wIBxai4Zg+jbI1YlTXHmQuJykWIopCtMbv647eN2ynn0Ed3aZaVQe
         6WvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxILZOM2VyvLZWVpUBRDPS+otRH6ax5DMt2QO50OiZPQbDHCZRmX3xlrXLoHvc3WzfLlGrU7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEe6axi0fvkEv6ra3WMfO+N7RXssRqqWNwR0HgbMuACpFN9a7T
	tU+zfFc9VWgU3zlDs4XkpHiI6Sm+LVw0rqgS4YchI89JEORivbEZd2+gsMC+9Q==
X-Gm-Gg: ASbGncvgHY/9wYh3yqrl6Zt9AKFfsiOEq5JRE3qmYmMAfNwF86bAwG7N/MgZvkUDk72
	rdkAgGFucOUbcY6EAXvpwWZwL7FiDjjpXemz61Yi2KJI4/0E149ICWwEaGRHafybtt4t3S5/2X9
	E0in9bvQTIYJuM+NIPYvffOnQXunlUuw069dJnb5IuP46VEqTp4OvBMXHzL5GkYtNFHL/kJNTK4
	9Y5LzzQXnBf0EQ5NaIDNTnRka0bwP6ZO4kr+7MaxWJMroG0UJA9T6/sAe4LInh8ku5VSOw1A4a/
	jbzMZ5DJvCV7Q0M/smigP4JsNDskFQWgb2sqCQHdQWd9yKNkNWtiaHoYKdVfCZddOBp00nY+ZsM
	+Xq6ByE0OZiV81gmi41J4fO5AI5Xl+W26xa4yYrkgFW3TcEcIeq/UziQQhY7o6gfx1w==
X-Google-Smtp-Source: AGHT+IEbiZN+XF4sjITQ09ul1V2sn2j3I7qQtKWmkiIGwbLpTg34gq4PaG2LFmebuKNvq3EOi5gWyQ==
X-Received: by 2002:a05:6214:240d:b0:6fb:4b73:79f7 with SMTP id 6a1803df08f44-6fd0a5bbee5mr51063176d6.41.1750441547982;
        Fri, 20 Jun 2025 10:45:47 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:47 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 37/42] selinux: convert xfrm and netlabel permission checks
Date: Fri, 20 Jun 2025 13:44:49 -0400
Message-ID: <20250620174502.1838-38-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
References: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
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

