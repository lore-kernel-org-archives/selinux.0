Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6522797BE
	for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734154; cv=none; b=qHOUuU0bLLWo+qHbhnr7IL7UH01Zwb9ZvZ+3kWz/9xRcjDZT79+POsAc7OtxYiRdbQGBKLQKb2xnv6kkBBev6IhSWv9tKWTEPQozzI82cq4pWsmP/UWfourNEY9r6VrEVyZCUI0jTxL+baQ5GgwU8WjVzgbBPOsqL5s9x8hT+YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734154; c=relaxed/simple;
	bh=WKicIXmz7bnIQGhAXSwDfAouRuhWgFryW5dnjoIl1Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIf8TIN9mD55uzRZFnd2XcLUdEC+OkBJt/1cus0noJzprTvVvIKzucrltBFWuXLjohI9qqGNCmbosOdJUAIBfzKndFDxghTWVffTOd6BI6shC88z6FMcu39C3ufJjEifsq9LVt4StPTc1vpFTNBvcjfo0xWr5IpJkANmU2huHQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Va/+6G0Z; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Va/+6G0Z"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-88f86727622so348745685a.1
        for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 13:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760734152; x=1761338952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKtz/vkc290/v3y7dFkvXfjVdcrtyl+E7FWTxNg0D5A=;
        b=Va/+6G0Zj56SaC38gysg7S+eb+skTwu7auy03obW0Z5qPB2XTruqVQb+D1UW4i4ovH
         Cule3L7QynhW2TudzCK3Fj5PO4yGwO7MhZO6YSLD6QlvUkHrOimxEdfhrj1YKviMGwOa
         GFONhMgAhfd9LWoBDPaWoLFXi/VhUZ0pt2x9sitPfDLA0MrpuPetstL4YYG+DTk3+5kV
         qYV9sNQLQZlmrofmNvZcS3eFwTBAIaaYw+LSaD//UX3PYg8Dlxss2ie6tSDETuaMDemK
         qHdnlKP52Pd8Lrao63e2MSkB3omxjGyoWW2PdJgcmmgX6PJItVZEsO9CTWZSGCnSMqRy
         z74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734152; x=1761338952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKtz/vkc290/v3y7dFkvXfjVdcrtyl+E7FWTxNg0D5A=;
        b=UUJunhx8n1f9Z5S74lHO9a9aCBRzyyTnsC4I3Htp5YO+5hybVlRJ2tj3Tx6ZKgOJkb
         rnlw7WABbYOTrL5fWDdiPSDW66w3KjM+YSH3kY6vQiEoF7oqBDTYAzuY6m9ZTuU9UnH8
         Yk7K9IxvPs2l7eRrxhY5PHk1Z+tGpYDTl9aA0laqNuwDev03oM8U1l4fwxeuw23/lGWo
         wTNAgChzW+wEm4McVUNfitQckUGTjnbymdllvJ+CAwPLcrk/wtg90J2g1XtLEt+ocq6R
         T/hNj+KbjJk4rlxP+7Hedbb5neHHf7gwPS+ly3ybH8anhpJct7QuFnFkJQqnGgFD5DJQ
         1DBg==
X-Forwarded-Encrypted: i=1; AJvYcCUwgNbdftp+S0dW1n+SVzwYtdWURU+zV+GHVT2h5bBL9yr2AW1vPrfq7V3W0L0aBZd9jPHCJja2@vger.kernel.org
X-Gm-Message-State: AOJu0YwyONKH8dYQUy7CkRUZdoNzfi5X12RwLFYe/tqDNh+g2vE2lfFh
	r4f1NYqetI0g+vANN/jPUGeiJQ2aBjzOfGz5eWYqE7F8HfUh/Byob96QjSz5mhLU6w==
X-Gm-Gg: ASbGncuvjqXKMUIAnEuC4Kst3dNk55xRmtDJq44Dt8zfDFaAT90vDvZrfAFIypt86Fe
	D6b2SSuQfFjxc0kH5SZ9Meftieh/vmSeQHgwKfxjTqGBHy9Hp236RaLFig1g0sy/3x3sb5oRsqL
	rieOHiLoN/YLd/hJG0+X4BWIAc+ijABNDuM9opqMpyfCVY3EE3GqeBcRcLSisn2ooaGofyJ/WzS
	1apVrqbxp72QAVRlHMdIxglE5+mMycCQk7Cg92jXgr/MzOXjRscwPoN/I8xcecB0dJ20fRPz816
	25aVv8U6jLh2hFLSPI910uU1fL6ie97Ekm1b8My1PI06z3LoVSxLuyKpctfuaUB5xzvjdsjD1GO
	EiNDDufFluxGGuHkm4KIqKlNSguuoep7IoEl0U5qSSB5X2r6i1RhkPesNQ9stHukZOFDOsVIH+k
	M/JXOmt7M16cnLnpLIfQRYWf7uvbJrNC9fWfFC6Be7bwGZlB/zVS7e+jLU
X-Google-Smtp-Source: AGHT+IHGZu78yRyhIKfalS/+sm4s6XszeQNLh4vmUvi7QqFzyQmuCMuSpemEdlt2MRk8WCsOPnaUQQ==
X-Received: by 2002:ac8:5707:0:b0:4dd:ca89:8d7d with SMTP id d75a77b69052e-4e89d3a27dcmr76029711cf.56.1760734152046;
        Fri, 17 Oct 2025 13:49:12 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028a9987sm5018766d6.44.2025.10.17.13.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:49:10 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: john.johansen@canonical.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	wufan@kernel.org,
	mic@digikod.net,
	gnoack@google.com,
	kees@kernel.org,
	mortonm@chromium.org,
	casey@schaufler-ca.com,
	penguin-kernel@I-love.SAKURA.ne.jp,
	nicolas.bouchinet@oss.cyber.gouv.fr,
	xiujianfeng@huawei.com
Subject: [PATCH v5 11/11] lsm: add a LSM_STARTED_ALL notification event
Date: Fri, 17 Oct 2025 16:48:25 -0400
Message-ID: <20251017204815.505363-22-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017204815.505363-12-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
 <20251017204815.505363-12-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; i=paul@paul-moore.com; h=from:subject; bh=WKicIXmz7bnIQGhAXSwDfAouRuhWgFryW5dnjoIl1Z4=; b=kA0DAAoB6iDy2pc3iXMByyZiAGjyq6+ghB3O3BYguG+6jVCkggcsRoWS+8eeqUiOeWQsm4zWI IkCMwQAAQoAHRYhBEtCqM8H8pnVVJd+7+og8tqXN4lzBQJo8quvAAoJEOog8tqXN4lz4uIQAMhf t1D9gT3dBoizePCN9guhDI5Dz5nrvexVFzSF+5Ry9flh2HBkmO1QUy8OXtndsXa/76/yKY9UPF7 q632ClOg56jdniSVdfcVfwoFO4lizUTBLkIOfuf/LZy5f4dZHDrRHMUC1h4DmqTQWvSnwWyYYhx NJOaTYTcPxObVnE+3dVNvmOiD1baRVgZNiBs5iV46+mwZqUoHqDAynp6JuI53jgQCJdJkr7m37b 3YxgMPmqVbxLWDDwuQP9HrRT8ZKHpUWvxVU12NjBOnkOVcdGQG269vB6dIF8sEEuGLYM8+YIngp NbltnD3w3eQLTnaWa7m2DUlrNdUIvOKg3iKCcvxigKEKshMTyGBRZ+kFy9g7HCWm4JcRxO42Ywm 8yOBvHex8RMVG1xJRFCjM06PzEm1vL5YAcEua9YDlGydnIn2c52Yje7IWIfSSnW6DKx2wLILP/C sSl4ZIMfiLrfoVUO1UEyTD5AvkBSU75xB4OFDZrE6/EV1ZoMENUCzBT0Om68W7bN+Nmmk+EmoDK 6KWfyQX3Lw2ZWdARXMDydi/CdjDVlVO6ILKzQNFH90NgIKo1evEIlOXwLU1HKYjD1MweSH+/NBV 7tQTirmn8wPbfUniGN3mlB7+7kIZoWWGiRVfYmutFXI/FC24cfGwUAvY8ERLT3quHblGSlssfnN QWPH7
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Add a new LSM notifier event, LSM_STARTED_ALL, which is fired once at
boot when all of the LSMs have been started.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h | 1 +
 security/lsm_init.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 556890ea2e83..eb36451ce41f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -85,6 +85,7 @@ struct timezone;
 
 enum lsm_event {
 	LSM_POLICY_CHANGE,
+	LSM_STARTED_ALL,
 };
 
 struct dm_verity_digest {
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 0f668bca98f9..6bb67d41ce52 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -556,6 +556,7 @@ static int __init security_initcall_late(void)
 
 	rc = lsm_initcall(late);
 	lsm_pr_dbg("all enabled LSMs fully activated\n");
+	call_blocking_lsm_notifier(LSM_STARTED_ALL, NULL);
 
 	return rc;
 }
-- 
2.51.1.dirty

