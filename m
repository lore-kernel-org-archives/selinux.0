Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0174CA295
	for <selinux@vger.kernel.org>; Thu, 22 Jan 2026 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097985; cv=none; b=hGjEokj76u4rExl8F+RN1Iz45zIsGJQ5ZlZNnfG6iUILd5HuCvT5wyCf7myWzEsQklcVWUMUgbkM20LGLEqfx5VkfAS6o+sS0zRrgqme8sDltjvbxsrc+kJ2LW6yexjXG5wL0h+ddcFHX/tu8HNPdKP5QISkEUSvFRQ6n/Hj9mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097985; c=relaxed/simple;
	bh=tv+nSYsMPty0z6gKW9OxWcOX2JhEgMg86J8YiWn0wCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNpjY2WZFWsr33ddwYXSa4ChNXQYkucZOtzvOwOekdcTA2owKKCnhzhybnsYd+xlpuRwKNmqcNjvSTC8LjfhmIjEDZIvHaOGMf/+DPM7YGauJlChhE+mR0HJF90TIj5C0yiPwbbA6yl8kZLChfJd3H0sADLKaPxF58MBNRPiz9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aK/TMB06; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK/TMB06"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c59bce68a1so82094285a.0
        for <selinux@vger.kernel.org>; Thu, 22 Jan 2026 08:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769097976; x=1769702776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zZBojMNUksU1oHYfdmmNreBj1bTByxP/lDz58YEKbU=;
        b=aK/TMB06/ieh2jQ5qVkC1oOCBNidwSvfXx4AWOabTZsm0sFs8RdrOJIRBPDh/cnKwd
         Z1agetp1ecE3G4GqJL3V/BmEgcU9C3S9fucLBPxL3o3acBwx5UL6mniQTwinfiGwuK2E
         XP0eJf8yx+DbGNpaBPeU+uQy5eCXe/zolmZkwtBtaKC5YwIEBMTwerC+zyCeKVG6xMoU
         0jSXqyirOd8cXMwhrR8Z1fSticNEBKW05GSWnmIOH2QDXjqprMG1jJNSmPXa3EeXrmuB
         sd9ljl130AJr7xjhQk37zfSqFjdSPoBwq+ZDOV50t7wJ45/LzMljX6TcLX7n75ELLp9H
         0Bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097976; x=1769702776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/zZBojMNUksU1oHYfdmmNreBj1bTByxP/lDz58YEKbU=;
        b=mKM/aB5RYLTAaGmf2UujMHgn7s76PnT57+JfgTeqhoRH5KgRgXV+cPE35pjd79OTA+
         kjlW2YthSKdBvxItcjO9C4+H4PCsADbhYSGvEaQI8F018XgACycGSy/qvi7xY5SFWrhw
         bHRYFntbTg33enjp6YbwyWo/wICH4fpkNm96Ph/fhEs4KXEpqcXFFtqWGLmikJtUI3NY
         PHVbXlmRiBk88fOg2eynhubK3Aupby3igQiy59+z8NLc1shSjwzI8kV+dGemqMiAE+sa
         2MuUkDTX0Hqb1qc6bR2R8FLsrSGF5C7CJ1eEfpBbRiYS0UcMpy2Y9Ot16bmORR7+wWlR
         3yrg==
X-Gm-Message-State: AOJu0YxJIei/wzxL0aP4rzrBWjgE0Ww4/fps7WBmoVxX6qEDCOYMLfYN
	NsXDpxRRnA60XZgX0/L2v2kLAVDyHBwzFt1KAg12zgLvHVBJERyD2aSsJLO2vA==
X-Gm-Gg: AZuq6aJo66ApjZcKyK5HTqh8Ot/p1GkHKTND7QhrJWVoOPK0r4jwtEcZDDP0kjxTifJ
	+ahKe/PM4/E2v/mf6f71V33SjG0WQv4J1ZLm2mg8eIMEAxdSmJZPDfMEiyqXZkWfrjEXbtOu4MP
	rDl0ctWgi8YWNqIVcpLCdg+rZwqIDbCWRjXjPRBxMCHcKZ642gOvgsCFNrO3BiZsqAE4venkYX2
	/FPVj7I2opzjMIVRSlap4gYOaDFz0ey7jZP2j6rxj1fVtwTKpNqffihc/owybCadClA3+Ep4y3o
	UnARPCDlxAB26F1P8JN+WQJaZ5ZOou+kCPC5QKzGwrmmPW33TCB1B5n7ELyzR4oDXMqK95T4wNr
	1T0qQPSIOluG6OHH+SWfUllyhmY4lzDFBR+tKxf9NOFVZLpyfN0UxsMBAqPTRrEXtugLraLYQl+
	4o/149tJi9UfLrIlpALNQ=
X-Received: by 2002:a05:620a:44c1:b0:8b2:e1bd:6b0 with SMTP id af79cd13be357-8c6ccf06c2cmr1155917885a.54.1769097975915;
        Thu, 22 Jan 2026 08:06:15 -0800 (PST)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a725e897sm1562127385a.38.2026.01.22.08.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 08:06:15 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/3] libsepol: Handled required users in module_to_cil
Date: Thu, 22 Jan 2026 11:06:02 -0500
Message-ID: <20260122160602.65567-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122160602.65567-1-jwcart2@gmail.com>
References: <20260122160602.65567-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In module_to_cil, required users are being treated like a
declared user. This causes a user that only appears in a require
block to be declared in the resulting CIL policy.

Instead, use the strategy used for types and roles and add the
required user to a userattribute rule. This will cause the
required user to be used and if it is not declared elsewhere the
optional block will be disabled.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/module_to_cil.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 56ebd9c8..89cd0b9b 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2332,13 +2332,21 @@ static int user_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 	struct ebitmap_node *node;
 	uint32_t i;
 
-	if (scope == SCOPE_DECL) {
-		cil_println(indent, "(user %s)", key);
-		// object_r is implicit in checkmodule, but not with CIL, create it
-		// as part of base
-		cil_println(indent, "(userrole %s " DEFAULT_OBJECT ")", key);
+	if (scope == SCOPE_REQ) {
+		// if a user is in the REQ scope, then it could cause an
+		// optional block to fail, even if it is never used. However in CIL,
+		// symbols must be used in order to cause an optional block to fail. So
+		// for symbols in the REQ scope, add them to a userattribute as a way
+		// to 'use' them in the optional without affecting the resulting policy.
+		cil_println(indent, "(userattributeset " GEN_REQUIRE_ATTR " %s)", key);
+		return 0;
 	}
 
+	cil_println(indent, "(user %s)", key);
+	// object_r is implicit in checkmodule, but not with CIL, create it
+	// as part of base
+	cil_println(indent, "(userrole %s " DEFAULT_OBJECT ")", key);
+
 	ebitmap_for_each_positive_bit(&roles, node, i) {
 		cil_println(indent, "(userrole %s %s)", key, pdb->p_role_val_to_name[i]);
 	}
-- 
2.52.0

