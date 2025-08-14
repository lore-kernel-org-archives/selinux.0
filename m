Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDE43090D5;
	Thu, 14 Aug 2025 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178059; cv=none; b=p7JB4bL1vs5hw0qOd/c4aQJXNCBns3ogaF8gHKfg5GZLMqMCLqoQ8lbvCRegmb8Q0Pr9B3QAReZpL4IJOEX0gYjSB3PNrnJmP4ezrJZAWI0YErHevwEEh+PmvSeY8VZgd630gLNS4aq261AA9xj0Bx7JF060zU8FhkDS9rVa7HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178059; c=relaxed/simple;
	bh=+XbHTGPNoSjFtIf/BG1h34x2533kCvMkdtmSWHyNesI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q26dtqW0WS38lqaiR8dVukYNoUI4+PFhQy7j/syg+xJWdnvw7hvSsOCT9CBDmc3RCF89XkqE+gSqFuIzyIcafwfEYcrhZddjPOtQPI4cjCBHglMtDq4efLtLPcWsL2/74gd0sbDoPPTNN2xbxounKtQC15f9HmqVE4XSTy3+UIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQ+ZYB2O; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ+ZYB2O"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109ae67fdso12844091cf.1;
        Thu, 14 Aug 2025 06:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178055; x=1755782855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2SVVKjjmVFjQRUC1vs8GPFvm73+gK9kNT8ItTeihwg=;
        b=LQ+ZYB2OL3eJSi5+P//XklKAtu7Fwd0yk9AQjXfhlaJX+nbJvf4z2sq31y56XrQFd4
         O8/yvUq6kHAsiHcm9r4spwMIeLbXDPx/vOe9kuK2R4O6eyCqoQHTQq2ZU6b30W70kxp9
         gu2UYMx3Mwnv/pha3PGy/pAWMl1B5POCdQN7+gcYw7fUM1w/VA7A8iCRIycP65rfZln0
         SDrBV50O7AJVoZ0z+Bb5HpevJI/fvpPDHgntlpXZs0Dwd5ldZJe29oDYsrhi5r+AOTna
         bTA5J3P9CcJwcCMWzc/848TQKsHAQmOoNyDNIHaf7jexTVyXcRfGeVSgC41d4pUCNC3p
         hjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178055; x=1755782855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2SVVKjjmVFjQRUC1vs8GPFvm73+gK9kNT8ItTeihwg=;
        b=cXIjiKpxJKdg3u2xGrF8EePzRaqLJjGryojTGDWeFSLHloGZqWa9wBQpGwceyZdWm5
         PzWQHO019HRoDLexcHedWVObLc3IQF313Jo1Uupq0+iuY3nYzVp790Lnr6ESFrUrAIo7
         ngJUAGa2H1DP5McKUpEb1ZK6D/41bnkWfpdZIrqVas2Ge5Kp3n8bKYg4yndN+FYq/Ph2
         tOEznUaiWBjEIZr+I7xz2DNc/nyYoAvX4lwMN2F8QG0KmDcrdvQ1IukuGWP7s3m3cf3Z
         OSwcezIQ6bHhA/uH87JA92sU8dTsMSZxrQ7xtotq0aP6i7lMuDriREKr/Orvr95Kx1Jq
         UqxA==
X-Forwarded-Encrypted: i=1; AJvYcCVAXX15yXbSblK7mgjKTcucfhHh8YaYa9x4GEkoWjV9rnHFil12g3aWqp6dcqxSI+JoXdxFG+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJJgD/7BRkzygyEglZXq5UaiCvDLE+SQt08Sd0jR7N2px/NQAI
	Db8QaOxQZemw2iM6SLIL+89bMrT3rM2DsYnEMx0jfdLx3GPm3nhvivLbDqRmTQ==
X-Gm-Gg: ASbGncte4BKhURXKdtRKhuvf9S73pAt4iDEW0olPyzGpuGeO8I+elBd0RBpjJTfqr1W
	nhdv2KOf1DrGTABBxx6BAfn0VDoMl4ph/UkGWVHaTz4kVnMjEg1xBuzWT/8HTBjaw7osaEsIGOV
	QFkXXADYtjwz/0lN7XL8/6l/f2p+De/1JKGTpbm18PSUDEApYiSC4tCHDBlizBQ2xg78cbFTv6a
	N3yo8zO3/h22vGLu4juy6zeyadtYajw4NgkZNz/3L0IM4TwNu6Zm6/4XZUuDWppO9Qu2OjpDIh8
	TcC86dmw46gapaEOy0E0A1TQYd+DIXBmPDn6CZVBinYKTxgio8FwyL0m5k+PNYEd/enuFm2qFxG
	8bwMavbbuoLeGJNCwJOfNRjaQiORbI3zLKHLYbHUiHdRpZGl4Ms1IZAxq9sU9XP+RfTHhY5hz21
	EboaQP4O8Mgfn2Ja2UPUUE2RV0ew==
X-Google-Smtp-Source: AGHT+IFZ4++3qawHtj4pPAUSzWbt1228v0ineTRL2roBn3n+DQ9PtO4FHZMWVLVOa5ApOtoa5qCuoQ==
X-Received: by 2002:a05:622a:8316:b0:4b0:7b08:b072 with SMTP id d75a77b69052e-4b10a920d94mr35012371cf.9.1755178054675;
        Thu, 14 Aug 2025 06:27:34 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:34 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 32/42] selinux: update cred_tsid_has_perm_noaudit() to return the combined avd
Date: Thu, 14 Aug 2025 09:26:23 -0400
Message-ID: <20250814132637.1659-33-stephen.smalley.work@gmail.com>
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
index e153f0122b4d..01405d1fb546 100644
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
2.50.1

