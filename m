Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38496253951;
	Tue, 10 Jun 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576209; cv=none; b=tEUyuoPgsOB8MwhlTJsNiWLoX178W/kXuxLCjRi/5Q3OCTHHWGkmicgVQFfiOYnC2QHRjph7fHdItin0F8M+c+QV/Wp1vXXtmUxjKrUWAX6h2AxNNLAba0gv+bj2vooSCm4jprICp8zhbj86mYe7N7TL0vVC5c14uTO/JqKoN7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576209; c=relaxed/simple;
	bh=EPqe27Qu2FeUZEwVGsMYQgvqMVcxwyluBB6heS4vieo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WanezpSzJwRzNjfANZ82aufIaZfvV+oITzwMPCKb7SsBjtP506JEFgqRit3G7PuK7XFgiGHxeYLCrMJNUriwtKrMkFt4VwJLTmYjgNBOU9cdi1er0bU8nCalCPPpoVZcSp15A+1hxMvhyzzpuiAZtZ4Gb8xTRHN+xMmv0dPwX+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5SkgCcg; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5SkgCcg"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a56cc0def0so100107911cf.3;
        Tue, 10 Jun 2025 10:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576207; x=1750181007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVJXcdSP1g79+6geTc00KPnHrJMruLMGcnVUd9tksgM=;
        b=e5SkgCcgGp+GhqOZsI6qwjoiMGcoyVQ81p2HMS6w7wM7RnfYVClIFOSX8nnjIBLPtb
         7rMVpnEVcDPepfpCwsyTYtGigJCl80zDdlVBAzXbCaoUQCyuw4kl3eVfhMAEYcypnHgN
         wfrlMWYQ6ieSMCy8H1CZaJOlXSfF6g6eI69ah15aqUfnaI0CLIgJ0QcPIRGHZ+vMDzu2
         DGDGZIzPqxl4VVT/zozki8ZxGA6myTnGHf50wIQ5/ccPEErxWPy491vClspHtMsCsUeo
         D+xpPF5EJsuvbcZfYyXozZ1WfKCMU2udv20Ler3na+9QVSbxL+HR5lpaM0FzmXJsz1IX
         L1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576207; x=1750181007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVJXcdSP1g79+6geTc00KPnHrJMruLMGcnVUd9tksgM=;
        b=rgdMGQdLJhwRCZMUOmd5fCbuDoBwn/w0GspMzMxyYc6L7EQO4ZIwqM1Y/aPkLEde7U
         ZZ5brd47ZiaNavMy5H/Nfv4bv22LubREdwINTsow07mdzkPaduLWeRMPXFVsTzySkb1Y
         ucpY7U8dLPPxlkUBolqvSQz8zrl2opjqHSm1j+T7JZ1MmGPOHsmwvfElXpXcXOpAgFeF
         0dBuNvvRrgBmToEUSQur+ymwTCearzsRsUS+/uJgPCldANVHCEFWAHkTsdzAhHcBTkNJ
         z2hFUELhJptqrpZz7JsX/dBjH9uNMjPawFpT1gRT/SaOLoifQD/xg3kfWJukvP7I+kQE
         vEBg==
X-Forwarded-Encrypted: i=1; AJvYcCXVhJ8JzJJzLmWqLotY5pt3yVtBRS3IHzSPFE80TuYu+SPHmH2SM/Bw37Ji7atyvGNMZMMYuuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoidWpnl+x5vcVXUK39sg8/CkU5eiG3UyOAgOPbKWhwUsoNiCN
	tcCpDaugmwyEuTU3nNFeu+Gapum9eTPrl82tYN2Jq+rNhZrCkF2xfYTX6gepXQ==
X-Gm-Gg: ASbGncuPTYyT9mPPv6bJYa5U5GJV6DJPn617Dc6GiyOZ/sqzwbEoiOttpLHZ2QH9It4
	zvAQxzZLqc8WBkI3cWVry9VUb31G605eLiBbATSb/Y6g9t/VzJuMsIFeiZaRY2DR1Z9bu0yU2IF
	tqjiQZHX+t48AzC3h/kiRDuosmroNjRXxuW9Q9af6SgDs7fs9V2COe8K/Ta6SuR10hj8yQ7zyi9
	nHGZKTkW5o0vemisX2nQab2bcx6JBm16vXg7vZ1NOfAxWm6kEfxo741PDAA4oY6ytvQmkMOvL4b
	d2PRU+gH2qLpB+o/UZLF5bhUpJZl40ebyGAJCW85hhha6if44ROtRCd3E+y/hM2cIMBZHixRT/h
	ownBEcPd4YO8NlxcM1OqN4XM5nb7Ly7Io8yb2jIQDbckWchSIpi6wAcstxQVApp32UA==
X-Google-Smtp-Source: AGHT+IH3zAVk7Nqm4fD5KyIqFUEhEpQvMhTlaLo90P+u2x3d3V7S84zg+/NcG+Er3jF1ehSQ8ARjnw==
X-Received: by 2002:ac8:5cc7:0:b0:494:7e69:137f with SMTP id d75a77b69052e-4a713c456f3mr4171141cf.42.1749576206666;
        Tue, 10 Jun 2025 10:23:26 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:26 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 32/42] selinux: update cred_tsid_has_perm_noaudit() to return the combined avd
Date: Tue, 10 Jun 2025 13:22:03 -0400
Message-ID: <20250610172226.1470741-33-stephen.smalley.work@gmail.com>
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

cred_tsid_has_perm_noaudit() currently just returns the last computed
av_decision (avd) structure, which in the case of multiple SELinux
namespaces will only contain the decisions from the init SELinux
namespace. Generally this has no effect since a permission denial
by any namespace will cause an immediate error return with -EACCES,
but in the case where permission is allowed and the caller caches
the avd itself for later reuse, it could lead to the caller
incorrectly only using the cached decisions from the init namespace.
Change cred_tsid_has_perm_noaudit() to combine the results from any
avc_has_perm_noaudit() calls to produce the final avd that is returned
to the caller to avoid this problem. The combining logic varies
for different fields of the avd, e.g. intersection for allowed
and flags (per-domain permissive), union for auditallow and auditdeny,
and the seqno is always set from the current namespace only.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index efafe8a06908..c81b511ed1f8 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1557,28 +1557,38 @@ int cred_tsid_has_perm_noaudit(const struct cred *cred, u32 tsid, u16 tclass,
 {
 	struct task_security_struct *tsec;
 	struct selinux_state *state;
+	struct av_decision tmp_avd;
 	u32 ssid;
 	int rc;
 
-	do {
+	tsec = selinux_cred(cred);
+	ssid = tsec->sid;
+	state = tsec->state;
+
+	rc = avc_has_perm_noaudit(state, ssid, tsid, tclass,
+				requested, 0, avd);
+	if (rc)
+		return rc;
+
+	cred = tsec->parent_cred;
+	while (cred) {
 		tsec = selinux_cred(cred);
 		ssid = tsec->sid;
 		state = tsec->state;
 
-		/*
-		 * TODO Do we need to use a tmp avd for each
-		 * avc_has_perm_noaudit() call and intersect/union
-		 * the sets as appropriate as we go? Or can we
-		 * simply use the last result since we generally
-		 * only care when there is a denial?
-		 */
 		rc = avc_has_perm_noaudit(state, ssid, tsid, tclass,
-					  requested, 0, avd);
+					  requested, 0, &tmp_avd);
+
+		avd->allowed &= tmp_avd.allowed;
+		avd->auditallow |= tmp_avd.auditallow;
+		avd->auditdeny |= tmp_avd.auditdeny;
+		avd->flags &= tmp_avd.flags;
+
 		if (rc)
 			return rc;
 
 		cred = tsec->parent_cred;
-	} while (cred);
+	}
 
 	return 0;
 }
-- 
2.49.0

