Received: from cloud35.hostingpalvelu.fi (mail35.hostingpalvelu.fi [31.217.192.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54876264FBD
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 01:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.192.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781660334; cv=none; b=mAjd3YdiPZF36q4JkKUeV6pVcZ+iJTA9zU1QL+JZgy6TT/auZEbPXx6ILkZc56fcOv2Ho6aPjZJbad1EmfnRp+oCJsliFoW1SuDqpeIRfeuf+mL7vY39O6A5kgg7/KvAmr1J+N5zPmbJA1moIzYonvKGb5FWojAwpbxyFRPmUQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781660334; c=relaxed/simple;
	bh=bpct/196vg5+qoaDevm0AQl6sidIVP0Yyh8wcN74fsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m9AfPk0Bi4ytgTIyHHL4sNnlnE2ZV0Z1bgsuVcxYR/jZFY2WVxEyDqoDdrS2n1+B/iifkwdBZXdhtaqL1mPP3sJ8AlfcgCaKImippun7QF2jcvsFeDHTRpdLflLTKooGHAitI1tN3up1otc15tienHEcKdeTa8KM6ZUdg0OWoxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi; spf=pass smtp.mailfrom=kolttonen.fi; dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b=j0bzrSMi; arc=none smtp.client-ip=31.217.192.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolttonen.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kolttonen.fi header.i=@kolttonen.fi header.b="j0bzrSMi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kolttonen.fi; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sYIj0/QdM00dNKngrngSOkniegokENa7NjXBMtDfUcQ=; b=j0bzrSMiO6QX4YHkPs1/6YwHg/
	h/EzwsPzLRLrS2ruT7aI/92On3khdsq+piL7FiNNP2EX4gytez6Du7OoQamUY3iZUaoBvQR6yAUcb
	xJb8cQi/5ZgrOdzVgvH6+IMY48RXpujPDqdzCnWnV3wT8jDt4U8mVztPZoAOFjsHXc9G+P9ZjprLw
	m/0Ec28NVvnEJRIj2RJ7G/MNeT96giRd3DMq7fGqvuyVNTzP7Xb7vYDW9XcNLyUQ93JR5e+PgphQG
	RCLINONqe8yJSdFAIRj8MQ9mGzZYm3nN38dky3htjUMCoZLi7yL77wWVfnWj0lLlH5oNWGBmF3YR3
	LyPSuRdA==;
Received: from 87-95-76-183.bb.dnainternet.fi ([87.95.76.183]:4546 helo=fbsd15.local)
	by cloud35.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <kalevi@kolttonen.fi>)
	id 1wZfEx-00000001utb-00h0;
	Wed, 17 Jun 2026 04:38:48 +0300
From: Kalevi Kolttonen <kalevi@kolttonen.fi>
To: selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: [PATCH] selinux: use bool instead of int in ss/services.c
Date: Wed, 17 Jun 2026 04:38:38 +0300
Message-ID: <20260617013838.82900-1-kalevi@kolttonen.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud35.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kolttonen.fi
X-Get-Message-Sender-Via: cloud35.hostingpalvelu.fi: authenticated_id: kalevi@kolttonen.fi
X-Authenticated-Sender: cloud35.hostingpalvelu.fi: kalevi@kolttonen.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
---
 security/selinux/ss/services.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e8e7ccbd1e44..2bc522ad88a3 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1354,8 +1354,8 @@ const char *security_get_initial_sid_context(u32 sid)
 }
 
 static int security_sid_to_context_core(u32 sid, char **scontext,
-					u32 *scontext_len, int force,
-					int only_invalid)
+					u32 *scontext_len, bool force,
+					bool only_invalid)
 {
 	struct selinux_policy *policy;
 	struct policydb *policydb;
@@ -1438,14 +1438,14 @@ static int security_sid_to_context_core(u32 sid, char **scontext,
 int security_sid_to_context(u32 sid, char **scontext, u32 *scontext_len)
 {
 	return security_sid_to_context_core(sid, scontext,
-					    scontext_len, 0, 0);
+					    scontext_len, false, false);
 }
 
 int security_sid_to_context_force(u32 sid,
 				  char **scontext, u32 *scontext_len)
 {
 	return security_sid_to_context_core(sid, scontext,
-					    scontext_len, 1, 0);
+					    scontext_len, true, false);
 }
 
 /**
@@ -1465,7 +1465,7 @@ int security_sid_to_context_inval(u32 sid,
 				  char **scontext, u32 *scontext_len)
 {
 	return security_sid_to_context_core(sid, scontext,
-					    scontext_len, 1, 1);
+					    scontext_len, true, true);
 }
 
 /*
@@ -1551,7 +1551,7 @@ static int string_to_context_struct(struct policydb *pol,
 
 static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
 					u32 *sid, u32 def_sid, gfp_t gfp_flags,
-					int force)
+					bool force)
 {
 	struct selinux_policy *policy;
 	struct policydb *policydb;
@@ -1640,7 +1640,7 @@ int security_context_to_sid(const char *scontext, u32 scontext_len, u32 *sid,
 			    gfp_t gfp)
 {
 	return security_context_to_sid_core(scontext, scontext_len,
-					    sid, SECSID_NULL, gfp, 0);
+					    sid, SECSID_NULL, gfp, false);
 }
 
 int security_context_str_to_sid(const char *scontext, u32 *sid, gfp_t gfp)
@@ -1672,14 +1672,14 @@ int security_context_to_sid_default(const char *scontext, u32 scontext_len,
 				    u32 *sid, u32 def_sid, gfp_t gfp_flags)
 {
 	return security_context_to_sid_core(scontext, scontext_len,
-					    sid, def_sid, gfp_flags, 1);
+					    sid, def_sid, gfp_flags, true);
 }
 
 int security_context_to_sid_force(const char *scontext, u32 scontext_len,
 				  u32 *sid)
 {
 	return security_context_to_sid_core(scontext, scontext_len,
-					    sid, SECSID_NULL, GFP_KERNEL, 1);
+					    sid, SECSID_NULL, GFP_KERNEL, true);
 }
 
 static int compute_sid_handle_invalid_context(
-- 
2.54.0

