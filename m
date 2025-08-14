Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6253093B1;
	Thu, 14 Aug 2025 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178062; cv=none; b=NXSDWl1vhoN+p52XhUrZPHlIpsw4f0jJbn57u/CMWeC2bXo0LUQL1jGDvNwdheizYYMvc6VFAwXgZLNXN5BzdQoPXZCdApd+KOz33YwOgtkOE6cucYhjmEr6uUP0ji56e+qJQzDQbGZm50/u0kfQuvepDjr2zXiMwIk3LO58rp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178062; c=relaxed/simple;
	bh=lMJO/bzFw3Ehtuk8dgYqJl/JLAfzStBZfEbSrLj51zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cst9UHwXA6AgyqL8jRDuctdXOXsMn/NP2DDT1s/WcQua5Ymta1W7TVR6moUB7Tk7RGSPzhr8EiLvN4oWNsttk3fQJ6TlVP44N1YWPubqiM1MALuKo8tP4EEBRMYBTRDZr0pRvwuaxaHods0wAFIqzsoXHYDzMX5HgnS5QTHthro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEJ3PXrJ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEJ3PXrJ"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b109add472so11104381cf.1;
        Thu, 14 Aug 2025 06:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178059; x=1755782859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrE8c5yzKV+e3vlFJYP/BGnFWdg/6yflw9dk/VcvmV0=;
        b=DEJ3PXrJarixd3hc4NyvL/09bZ0Ef+BU0kaaX1PgnBfDni8hrzxxzifc1l9T7sEmjh
         9F3Xld8Uj5oyQ2gBGIJ8lJzvaeYjc/QjJgTlA6N5ERZVNsNAUYjmdTJHFG7Z/O2w3t0m
         fVrP7k9NolXeB0P1opbNyakNoLut+ipZWQEW3hwd+ysyyoPigSJu38doIP5lEPrAEle2
         dFWJ2NyHJjVO2iHIPr6JL5TuXWZSVSxEs7hyHhuKKpVvjxX0A+ktNzJJWX9y1FndUZjQ
         Kkr1aSctu/5iBTYExqcAXJDawSPmjthvVximgm87HSx9yJnfQk2EhD/8PG3CT//oNPGb
         6Z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178059; x=1755782859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrE8c5yzKV+e3vlFJYP/BGnFWdg/6yflw9dk/VcvmV0=;
        b=TdojxAriauIQkKArFNVoZyBStnQaJZuzSYpKGIZQfRv7jVqwByOCZcf93ouYNiRzRH
         sFcHSnmM9NYO4sCJLJocrYSlpMjnEoygPEQcpU0fnjer3E5xcwsS3ssXbxrH4pQCXJBE
         ZQuEl1UxPN/MQFQszeakg3W/W8A9lme12LhV1wUvZjolUhDMZct+zP9rfVoRIXp88LnL
         lY/ycdGKjmgSae0lOb21jvGaR/wuwE8qBEg3apCMSJCMvNj03pnfPl1OxYgbuG87oR5V
         5I27IQ5r0GxP4nWgb5+VpNDur5jijvyJBtwyWIuaCHy2c0ZNMINsrCwzFHMdetN/wDWo
         mY1w==
X-Forwarded-Encrypted: i=1; AJvYcCW9YmGZID8iq2R1dRcXH8ESe2f9Zl1rXXz/ZloptdmEDvWy2BaBqen5/GPOJEanKCQyhUNFa6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjzB7Jdd7/3UQVbgkaxIW3/OBP4vxmt3dMU3ZZAzp7kk7Y993K
	TN7pBFh4satw0BSUiJIEi0F/uCTXRfaZ1TV0DNPKcw8jmot0PuBSFJPM8FKSLQ==
X-Gm-Gg: ASbGncu7fOpLZ9ywxtySeNePwqpbbS+oBdMrhxi4OJJKx0yVVinC4lf3EqnpPEihdLC
	l5Up45crocttJR90Evk7d1Qe1UVrdLJuRg2cWUaTf2cLy8Y9scQH8XCtrycpg8GzjwTVpP0r1BN
	O/t6RFektJE8LUxnuLbLFmRv2dJm903db/C6MuKczULCF9jI4tsFzKz9mW0nTtY5vx/9ra8bw2p
	neKx9z63ixbbyQvbCkdBbDbp40CpUoLhJXTnyi23bGuV1hDvzTox/Zj2J21pLekSGRegzO1e/gZ
	rx7TZAvJCMmZy+181TuEWFYrrvs37u2FQYlpXOjtQrj/1Vrtv6P49BH+3thOZQbjecOG/hcLNe3
	VJxnz5l/3IIEbSZfKAQh+mMuYHAp44hKOYUlxghsR1RFCcIH4va3/wvje3DS+M91Vot5BMZaPXq
	hwBzYniUspeFPSPcw9scJMYRxGz9G1b0QJ7UeL
X-Google-Smtp-Source: AGHT+IF6AD7+5lwvVh0cBd89q7l01x0gw0sftqH5STH5bLngXKSOg/Ecp1ThQ5SF/urqobGHr1tUVw==
X-Received: by 2002:a05:622a:514a:b0:4af:1765:8a1b with SMTP id d75a77b69052e-4b10c394a9fmr36188421cf.4.1755178059108;
        Thu, 14 Aug 2025 06:27:39 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:38 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 37/42] selinux: convert xfrm and netlabel permission checks
Date: Thu, 14 Aug 2025 09:26:28 -0400
Message-ID: <20250814132637.1659-38-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
References: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
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
index 411e1f1ba4cd..92fb31661e54 100644
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
2.50.1

