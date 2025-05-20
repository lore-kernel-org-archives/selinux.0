Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC43A280014;
	Tue, 20 May 2025 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742501; cv=none; b=ZFvobG87p5wbv47vD9IeNN00gx30ETWHkVn07I7kB/VCjTCVZHzcMfQlLDTZIk0LvTIrL1UvMbA3fJSAPirz3C3LHvkFDmk0dOQUY6iUjIGCRxN1zBduvnZtgpTBG7hAp19I9xkXqgDPT6mHbT3ZVkx3TpEVvxzuHLr3AyRwY8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742501; c=relaxed/simple;
	bh=EPqe27Qu2FeUZEwVGsMYQgvqMVcxwyluBB6heS4vieo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3PWiqPSIsQ51lHPGSjiyA//PiUdymGOrsqozauvqd+9MTe2Z/+OUm99SfXDZcxP3L+jpw2WJGcfBmZl0YDyCxlp2+guRE0lpoH2uQqwoi2Bpzeh9LlDC6q1B5B2Skd2nQmTcyAQbt9ly9HwVr/4o0tr9dWp2+u8qLy3AB7kYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGqIFJg/; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGqIFJg/"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c5e39d1db2so346931985a.3;
        Tue, 20 May 2025 05:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742498; x=1748347298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVJXcdSP1g79+6geTc00KPnHrJMruLMGcnVUd9tksgM=;
        b=dGqIFJg/ebswVzloPKhoRTWSKCbB6b7czAmBoDWM/G8eGS0jLYkuTtuvbgVmjLzlH6
         MVpJb4Y7hfBDge/gBWShpYSrrDhUK1wQrQvA4RVzw2Ju9l0trjR8mI4vQIZdEiYOI7a5
         AYzkrZ4I2/ZvUwAGJpkCNO9A1wEEHiGQ55osIEIFIrjW0OXjD0iki2UUd/mMsB/nudKh
         +vr6n2ULnZZ6EcGCRutAg9yAbtsmlVYf0cEjKI+MS52/V9yZLHHBEDAy1N4Tiby7ab7i
         2rqI5wSz6FFfSVp5RpGze/85EsFLdbqbNGi6ZFaSrCrxGgFS9IEMMiE9jeKmvGV72/po
         L4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742498; x=1748347298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVJXcdSP1g79+6geTc00KPnHrJMruLMGcnVUd9tksgM=;
        b=w2IuQb4neEn+yh3IWOmc+0J7pfEsUCZBPeyPjRWiG4FJpx/fHyn8eafp9qj/hSjBR+
         2k5KtWu+eniiAbXYnoMioRNuebsH9dOxbBbFvKlYL675eDzoZ6ZwEVmcSquedaWIpXAX
         ulOIrAZ0KZlH23QWD2zHzZQGwxTb5susI+7zm7VbmbKwPNZc75EnK992rW83lvOedHGx
         5nC7wfrjZaAjyUjBBMs4hojd2Iq3YFHVHJPht2EiA95hMLsgNAx0C2EyHZzyYf1qlGmb
         FsEOguMc0dm+1KsSWPUsKkDKCQ6bqZcXWyuVyE3kS9H4k5nHo6EQgp4pJeXIkq1e251I
         EK2g==
X-Forwarded-Encrypted: i=1; AJvYcCVgNbg++d3n5Oc3EHDlre4zgYbGvbX5ma9PC/T3rEkU4F2z3icvwzxwwuCq6t3YUXziDHos88Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/7DuVzkwJa9YpL1pmSpBG4TIDvzQs8B+juFhARlZ/O73lVyjt
	L39KvpwVMrYVQZcGM7hDUqNkA1rCEzLCToFM1GLhxQ7qco+tm5SA3CVlcmnvXQ==
X-Gm-Gg: ASbGncvJWaffkZGqfcxqpsshg+igjvMotheoz05PD4wwm4eozjNHzNCey2UarGmu1Oh
	XgpgUHGPof14uN+2YaR68s+lWb5MDkX0WDRrjiidbuLQLMKidko3W/Wzx3iqyhcmjBwkkZHnOHa
	3/C4cvTKelIEvdHMiP+WbS4lxcks4eIkwByZT/01W+3Hb0x+QAlCC3VB/K2irAnHlrIYPEO1Yhk
	2fzJjzrCf6icY7Gx2kwqC3UaIKh+eNCsfGsOeQ3YN5It4K8xBb3+O2krqPeWNyUMj54sW/Ww1dp
	WdNHRlkqajibxKmygKJHCPi3q0AhVtUdItIZ5NP+a2GtDfKRWSjgljsiRCcB7m/s0fXEYWjDYxG
	eakAGP4X0BB8Zk/BKW6/lxJaUqRZHNq6hBl6FjJRi8W1seT53REGBuw==
X-Google-Smtp-Source: AGHT+IEBAmdxdf2U2wYS3fyg+wI/J4N1JVAgT+rFuVwVyglNqQgoCfeVnQriVTJYTMUG4sZteGsRuA==
X-Received: by 2002:a05:620a:1984:b0:7c5:65ab:5001 with SMTP id af79cd13be357-7cd4677db22mr2029627085a.39.1747742498445;
        Tue, 20 May 2025 05:01:38 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:37 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 31/42] selinux: update cred_tsid_has_perm_noaudit() to return the combined avd
Date: Tue, 20 May 2025 07:59:29 -0400
Message-ID: <20250520120000.25501-33-stephen.smalley.work@gmail.com>
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

