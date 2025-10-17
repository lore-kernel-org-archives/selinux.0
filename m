Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B7726F285
	for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732967; cv=none; b=a15TXWJQpgq56EfMhNrbc0SoBUIVhgnfjbVeUZDAIAMYvN7/0U4UkTSHeJhK+t9ERDNX2x3vAucYzxJvv2LPt+qPYTP9RH/7av6h5B3dv3fwaFVuvOpjp9dAaU08eJsgQtyOe0+vXDZRplZ0fbeuE8YhpbVrIdZ7H+tbxucFWOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732967; c=relaxed/simple;
	bh=muxbOgaJg9v5tPWdzg/bAbRNyQbeJYHw0DoxAC0u+LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+ilsUpFdAGHBCaZ8s4tFurVG6KCjXYYDc8HZvYWKG6f7zGCjrfBk2xasjN7yGxrSysidZcnxvxQt23ACjRHYrh+MLOG1KUCdnXWcjMmRFu7dN3VazYeyL+8F/RKLkIo5YxjRUlOeOQTgnQ9t2+lok4PXF/TmnGPkm6evthuwho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q/qd64BP; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q/qd64BP"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-816ac9f9507so503291785a.1
        for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 13:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732965; x=1761337765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5DJxtIQfhKWC0mHs93epjwMCboY2q/zrsHtIm8xqcQ=;
        b=Q/qd64BPkqzOuaHX8yODyvAV5Wz9BaRdjbV+C3IH9Vm2LRl3qbe9qXSqe64sqz5DCY
         2wLnK7jOqdiQMLAunE7fEzxRvyZodXDA0A3yXydZYwb75AW3Z5tWXqFmPRX1rdceqkU1
         pOTx7TkMgK+hpJdjXg1D1p0CSbRZ5plgpLqCd22Y2DnuZ/5Kj8j/dBLAZvFvSOiu9KCI
         uAg6hZJN0PlaJD8eWe4h2rWmlALGGcUlyK24cTJlLUVOSJd3KTKU91sarAUB8aZmGbvQ
         2yeHTxJCJkSwIeFXt0RghqOgeuqh0CJjlUUY16afdkM4EJFmRreesiJSm5RIJ5iaEdAL
         4ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732965; x=1761337765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5DJxtIQfhKWC0mHs93epjwMCboY2q/zrsHtIm8xqcQ=;
        b=FsR2ZKqNuvbS1TQXPpQphwNlpMgKcb7pDVHf2uONlU+fAlgP1jd726wMuBcgobG+d3
         o/fm5DZvCiD+lHcMNuOgdBxyEiV3g0hoaU6luxoECwWhiyJI77GeWKT780CKSUW3a2Ub
         HmSknIUUG/sIdeppheIo/a6lo4aF+VJ9VdyO21di+/xh8yFObP0UEeTtAA1SqfUYyo0Z
         cxIjxQV+eSTtkRWmpubd3Cmagvjq6lexs1IJvKSQjerw80emnl1MbsRtPOH8xqtwQSe1
         rjIffL6J/zFu2oRavJAKTLjv87cFYwjwjDCwRef8mgNFJ1Bh4LotrsvkS1httniirt8G
         yP8w==
X-Forwarded-Encrypted: i=1; AJvYcCXpjPZft4nmmbP1ZjnKchdn06K9ZKEkRE3Mm3im9pZGrW8keGDT/SnEK3yqPYNv9v2eJvivNs/2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3zKhuElcq5X0xAE2nxjSxlfBU3LXBsafM8x545+s9CU5UNwfE
	qZRp8+u8ISImCydYuH162DJKmIPzr4OovqIWuBhX5NoDQ4E1HoGMJol84No30GnI4Q==
X-Gm-Gg: ASbGncscn5acclb2kuG2Q9BRG+VmJ7eYz1HeNVf3wHoFu/qaAWFZlIbrr6GDp9rzb6T
	tiXFFmTnPbnw2Obud+go9V+6zqBpuuqtZapQz6D6y2jICwR1tl2uJbKDQUcVV1sC6xIQ/5444Mi
	giTK7vcf3eFOHoFHAhnu0kHgElgcioB9Ent2kku8Q/sMkxKRuy8LEEzby/wFjJqwfz7hET2IN/F
	jQD97pTEtk7U39nRiE/ijjRGMcWROIqjrD9/IeJ/mkau4MCQe8tGDhZbh98Ja+z71tsnZ0rwRx7
	A7G49nEEYnrwMUTX8vOU+hWKGxfrPNZnUXAFUOBSEj+nq/qBt2IG4i/h6DlpN/yAfmTikL9Wk0N
	VksIGKzIwKpDEsiky6MOzOHUTBafybGbTUGjAuopCtCVtXUxXAhmrDQq1GzCCDHUdIY+plv/Exb
	jmDEc2AJBxv/33NufwZu3yMtl9CfXLUBLdY5wvkEg09ukmUKB4+9xTmfx+
X-Google-Smtp-Source: AGHT+IE+j2fVZsQswXCdvfIWquJQ5ZGZIswl73bX1lz8S4ZzuxTPXlcCq5bfd1nvRoqrZhxuItOXfA==
X-Received: by 2002:a05:620a:4449:b0:843:69b0:29c6 with SMTP id af79cd13be357-88f0ec96859mr1355434285a.2.1760732965114;
        Fri, 17 Oct 2025 13:29:25 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cfb56807sm39397285a.63.2025.10.17.13.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:29:23 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH v5 21/34] lsm: output available LSMs when debugging
Date: Fri, 17 Oct 2025 16:24:49 -0400
Message-ID: <20251017202456.484010-57-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1658; i=paul@paul-moore.com; h=from:subject; bh=muxbOgaJg9v5tPWdzg/bAbRNyQbeJYHw0DoxAC0u+LE=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qZaXuPIMjruQi3evlea3BOAk7VHfw9UtI6cg ZPV4cdzrw6JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmWgAKCRDqIPLalzeJ czuYEACsVrztiycgCr/u6S4++lnKdEhkHuinpbKgsRtFTPfM5IDL9xcjMncjLDRDjctlkCGF9WL MToWHPA8hzQvZ4dbDHtJBIVeWLvs+M+npfb3jV/ITIazyBIxZ3Lpf99p9gMSbwk+R474f7dyxem wwADGZMIM1qrCm5YpQXDNUg9jaHmHNm3PT7FFivLzopvH938ET0wTaX4157hS6vi4TCXriDk5ha 9q3pfzh0TeR1psPA8XSqZWYQa0uFPk7NNT82TXRw23NiHkU9HFmNldXg6GcD2nsDp9gw+SxIEpz VbYfqVo1CfZ0sfCdV1k9dekmTtnnwbFhEdDu+hlxYK+mcAFr8k4NCbUykTrZsVDt7+uYC3Oraoc mdQXqIy0egfbDK1kpVfiY1xorS8Wn8OAhMSoWhjnl6oGIEDtt9hgVonrE9ogp5Fy+46e+ziUPxR tTyUL+/Qfbq0UYp7Nihqy7/+IN//zFgAroEaYL0J1s+DmbRrvnAYm5Bzg7K6MmTzvNlfjy8/SiZ 9w4CvH6l+kFJcyvUJ+AUXq1cl3IuU0uKMgunoiiGR/Py1r8V/nxnYBgHZrjoTAwISop3dCAXGyU ky9keWn4K7euDbET4LuWwTGOF87+fDUFka03fp+9ZOPVVE77fZGu/v7RpJ6kx6D4Mdxs8PuhNWE 4nSkmrjtaDjTa+Q==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

This will display all of the LSMs built into the kernel, regardless
of if they are enabled or not.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index cd1779e03497..cfcf3bf7127f 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -363,6 +363,8 @@ int __init early_security_init(void)
 {
 	struct lsm_info *lsm;
 
+	/* NOTE: lsm_pr_dbg() doesn't work here as lsm_debug is not yet set */
+
 	lsm_early_for_each_raw(lsm) {
 		lsm_enabled_set(lsm, true);
 		lsm_order_append(lsm, "early");
@@ -385,9 +387,24 @@ int __init security_init(void)
 	struct lsm_info **lsm;
 
 	if (lsm_debug) {
-		lsm_pr("built-in LSM list: %s\n", lsm_order_builtin);
+		struct lsm_info *i;
+
+		cnt = 0;
+		lsm_pr("available LSMs: ");
+		lsm_early_for_each_raw(i)
+			lsm_pr_cont("%s%s(E)", (cnt++ ? "," : ""), i->id->name);
+		lsm_for_each_raw(i)
+			lsm_pr_cont("%s%s", (cnt++ ? "," : ""), i->id->name);
+		lsm_pr_cont("\n");
+
+		lsm_pr("built-in LSM config: %s\n", lsm_order_builtin);
+
 		lsm_pr("legacy LSM parameter: %s\n", lsm_order_legacy);
 		lsm_pr("boot LSM parameter: %s\n", lsm_order_cmdline);
+
+		/* see the note about lsm_pr_dbg() in early_security_init() */
+		lsm_early_for_each_raw(i)
+			lsm_pr("enabled LSM early:%s\n", i->id->name);
 	}
 
 	if (lsm_order_cmdline) {
-- 
2.51.1.dirty

