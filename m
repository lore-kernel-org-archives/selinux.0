Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E91729A9E5
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314656; cv=none; b=arC74bSuFMH05U5kwmw1T3o9iBy0DS/RunTy3/xofB6xeGJ9w+3lbuvvVICHaeRJZ7XbY8ABe2Z9mZ9MHt8Os2RBF8IFESzqCLWhMoXZooDovXAY+197IMNOIWo33z40UM1RqOCH7jE+aC5NmspoAGg5t8cBV4UiLHmbERBLnwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314656; c=relaxed/simple;
	bh=WbzIU4hVrVXrnxkK1hrkPSyd44r1ivIogaJsSznFTnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXEZJvFytbQGfbXHkoJ7hJFpQCrHEc94uLUadSdYzafCOeDYLFRJMeuxIfLDzG1SuUJTKyHqDcxRR0sfzRVRdDoCjbCtlKR3G9jyhOqF+zCYfiAJYldwpfPUFGgs8gIQ8fh5OKypzJ3HYrVK/QHCXro27l9BBrDsx4i2HOVW83s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S72qfVjR; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S72qfVjR"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f0c30a1cb6so6322516d6.2
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314653; x=1747919453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mJKiBa7U1C1WSohnUzzxrVbwLytwLFquZAGxqFJMnc=;
        b=S72qfVjR4J2S9AQUd369Gxx+cBGMv1f+Ipgl39ug1X8+Dh6RTcbsdyBYmjMLms+/GY
         YFD7CQBeNLoh9OdCZotxndhqHPiwHe16mh4JRRq6gH2QVLEwlbDW/vEX9tuyfZZUjLCD
         gnvVUY+ahgZGSNC2qAAON9mHTr0FnCRHjIurLYlV1CFUSWFJCvrqpWOdNhDyTxes7lHi
         lSn1zolW5P4e5zzzfqvlcyRsBkh2aoEQnbK593+DyZWk9O9DEYZtVkp/ekjq2ONqkKav
         GYte+36Zektlf42MSePQiFFzAUUiAXUoZw0861DH0dGnUqAjGrqaf2KbeKG/WDFI80Lo
         /1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314653; x=1747919453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mJKiBa7U1C1WSohnUzzxrVbwLytwLFquZAGxqFJMnc=;
        b=WvebOyvh+/0pr2FxRhSoi5FDx43q8p83FSVX/3AGghO2euh3Th9ZZw65si2AaUZtDd
         +sQtiFoxUsysb1F1cM2f4NvEYz9ce3j+IksGPo1e+ppwmsd35SwFugpcPc0Wp3CQ2n1g
         EzQIkDm1hp48gyLo1hglXdMcqXUdAhhd2JaZTbNuZZEPi40l4TPtUha03y+E9YfyJiGA
         Mm/plz91mxM8uczm4+sIaOymj1WW/sHGTMCbT+JAF9juYCEHISSL68bli62h2Z78az2U
         FSNtKH2mlFvJpld+r63/pgZnbub32mqh/kwGRiKf7ho0I11uX5QVVjDft+YDtmX1155s
         mDgw==
X-Gm-Message-State: AOJu0YyC+o3YzzYkZTwuSDT2bS+ltzNIsEeCPdsR8kONKJ3p5+wM+z+f
	IY2HK/2JB7OGqRBn1USA1hTOTwnzV6QtzKd5hlwFo6EaD5JxPMqHsUtXTw==
X-Gm-Gg: ASbGnctvutVXk7kXrKAED00uTObko+2PBqmvApU3eSTNW/AFDOqfu4GQwpv54zSjKh2
	BQ/pf1OQlVoI1RXNIjKV/qKY7ySD+IIgNsfTN8eQqkDZJfWPuZ9zTDCKsc6HU9trzJMvpalEi9g
	icbDRRd0N3PcGHdt+Q0n4QkPEfBdsoJneMfRt/IxGnU7hrs8xaNu9Aj2ul/1pqG+24by3TfP7e/
	6UsQNpVaet2mWRKivaFduf+2noalcw89pPiwH1npU1Lhjq/fL9mTWgfQ06q2fM9jvKbVeNvIDib
	95XQdyYDxz9htUlyidaOml8BsPBYkxu4PwEk7/yNcyU9Es2mTsfGNLF5UgFYkkdPiK74txD24OH
	136xzlaqONE3BOpqA2+oftd+o2MTqpCJhgwF8ACOMjtaNWr8/TV6NIA==
X-Google-Smtp-Source: AGHT+IGNtrQnHmRSV70JUvn/ra+Ot7he2oSbCh23SaCaWy0wFZkNDnjFINM4Q+QECLeeIgnQm7zPFA==
X-Received: by 2002:ad4:5def:0:b0:6e6:6089:4978 with SMTP id 6a1803df08f44-6f896e35fc7mr100516266d6.24.1747314653325;
        Thu, 15 May 2025 06:10:53 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:53 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 47/49] selinux: update cred_tsid_has_perm_noaudit() to return the combined avd
Date: Thu, 15 May 2025 09:09:45 -0400
Message-ID: <20250515130947.52806-48-stephen.smalley.work@gmail.com>
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
index 24263b0b8e03..9a76266e8305 100644
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

