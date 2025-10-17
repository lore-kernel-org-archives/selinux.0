Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9726354AE7
	for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732970; cv=none; b=jpKC3W/L2h19kdf8nNxG5pYCGjyRNgg61DeHyVD0W3ovI10D+ZrVJ5waYNhWOsS6IYFAn48+ZldnY5eCW0HSOJJadlc8sTaNlajbGTJn7W/9RSkSKDNfcv5ZqD63v0xyRbVDhEQUaGaKRofppCLdqmrqeLWi9zP0KJDZKxpcsU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732970; c=relaxed/simple;
	bh=buJBnNY6xRAiYvKynjWYzclkfyX8UJG0i5UEwl0AnV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7aoyH1mByZUUFnyoDotuR0p7tEH387bHDbbsy1VDWXSvZAHPxznEFhST4ZcQl3JzukYp79zAyaqreN4kRzkKr8THK9VmdMYz8bD7RC5yCsvyemIWaNwn3NtZTnGKk4EmOy4I5XTPGJ1fBAYNialnwwahlSS90IQgcbBU6BMI0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F1vEkAyg; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F1vEkAyg"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-87c1877b428so40369496d6.1
        for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 13:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732967; x=1761337767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmouHXyAlCdfISQnPeQnDz4oV75mD2MuR+ljlGK2IOQ=;
        b=F1vEkAyg1e6B5Yg/sE57JcdnfFjW3i7I0F+T0rJFNNgTHzySkxfiMgTkuBmsfZdaDo
         rok2NREvEFlzy7shzLqfoMvuk6JarOBOT0bxN95/bHzkwgP37xJe3PSnFtt+kP8tXOtk
         7qQjvkMO4ZFC/qX3+zIhidXB5Z9o3a7tmYvllpxMFtoz7a5vI+mqyQCtgcszfghuIfu4
         nBC0Y8q7/kJf1lybkUMRL8ejTNVJjNWNKO7PXgCrCvutS0CbmHZ2kBbMLLuvmjOvUamY
         /03dNZjPuQ/N/BC7qghzEbm7QXiyJAPMK4AvjKiyb+hOSrOCdagGeOcWTlpxiOKRjhU0
         poMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732967; x=1761337767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmouHXyAlCdfISQnPeQnDz4oV75mD2MuR+ljlGK2IOQ=;
        b=EjnM8GCE3cUx6vGXMwYfAdE8taSn454bHUxHDhmvG3Y6opzs9NqA/FCe5pCUwtO0Ql
         GyuKv9rxvl77XNHcGhsa+Gyt5mWioV46t0ykZBYKAmEHOzo/NCOoWijMV0n3grc+OBpP
         XHYLDOwIgHfOgMbxoPIwQ1QVjnHXgixEjfX3YuBov87HZSg7CtQ4Q1LyI95L2du6meqb
         smJddBb6mkXbME+df8OVRZPMKX1IomQcG4ur6pl0sb+v9sWdR7lLiSacYn7wbg/7IUAG
         hq9gdNpFyLeSRe+RiZ4N664cCmCQrTFxoP5ND6mkWALTf/nASrxIghdw80uz0lrlQWaf
         4Ekg==
X-Forwarded-Encrypted: i=1; AJvYcCXTK+OYQjMWBDkwTgJWl7bmUHZf2kQPw1tTurkwndJj4d4l+C7DL209BFTh3Sn9JW0pb/xOcegA@vger.kernel.org
X-Gm-Message-State: AOJu0YyJu7VkJiz+WC4KL0T8y4zT8TJ8bHFZvcbDqspn1C9ibUBAuS/j
	P66Rpex80dJzyvX6F8y6vXxPmqeEVXvh7mbQNkGe6JiUrlTHb0N6U9yHTgMq2Jw78g==
X-Gm-Gg: ASbGncsJ4Kk9JSTl+LvAYXjapc8hXsluiatDWzjZ7ZeQATRjcvcZkFL19UbRRx2/jiT
	gljkAWgFxw3Rt+vlSEp3NzGBtjWhLf76Ca53GMOHletpsH2XN2JbtHYi+OmNZiyfVgKNSvQQpDg
	/XViTjLHd4m4H/buxyuJcu4cN7LvcRbdK7l50cG9MMXQqeU4pLC6PWQOKpuMe4E1w4SeHYWPaXe
	ucZWJQ7ISurLvLQq8kLs48ttqK3+AeCI77hCjrsNnfVky10HkR6A19dDgQaJZ/Ji+jpu/zG4T4z
	jWnHWxIh8erWDTsxKVAygV+vh4cBf4Ze40IGypUPe4YlCx8FExVpCbCIfBiCUgv27HATrMYK1Gz
	MLXYmnLYs0XOGVdNdUZszCidgryRO9Wj7GIp8uxekHzRkZm05ZZX8trdhl3my7dKqy/qEXF2Aap
	aVjos8irzy8rKf/s1EH79zLWYBYSh7dRmkVaT48gVyie6RQA==
X-Google-Smtp-Source: AGHT+IHt88Q+YL16jUiFmmJzbYiEQoNtpomEOX1cPRjTwZv3ZHJJRwPN8CCSxJ1NxsMWtIwIICJG6g==
X-Received: by 2002:ad4:5be2:0:b0:87c:1ec5:8424 with SMTP id 6a1803df08f44-87c2061009amr76069636d6.31.1760732967544;
        Fri, 17 Oct 2025 13:29:27 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028932d3sm4757226d6.41.2025.10.17.13.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:29:25 -0700 (PDT)
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
Subject: [PATCH v5 22/34] lsm: group lsm_order_parse() with the other lsm_order_*() functions
Date: Fri, 17 Oct 2025 16:24:50 -0400
Message-ID: <20251017202456.484010-58-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4966; i=paul@paul-moore.com; h=from:subject; bh=buJBnNY6xRAiYvKynjWYzclkfyX8UJG0i5UEwl0AnV8=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qZdkJO6Oogbr1vQS8mGfhhQxCbYl8GnYlQz1 729sjBbxCeJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmXQAKCRDqIPLalzeJ c8j3D/sFucwJ2ywzEBVUhSowcPHTVOF/6QaJIo9KtEII007FfdvHhxiDQLpVALzQzjQ+1+cYpHZ Efy6HmBmuZUCdG9xKUiNB32eRbB0fZ7PSfgFgOriR0Xl1JTijxIKYVmG7eBaUqvoycxKmCFUlTr NnXQ8/hSdMMFHY7VUT+rcBSVpU5Gk7zykFp6RnyqGVES/z1uG806a7dilAXXCC5UX87fgBdPeGi dsL7MsLUoGN0WpSbC6fNbv5g3la8WAE+AdHvYONwG8zTdt0EQC+hZ5fM8Z1CNlp52eiqfLyNFC2 9xZv0IpF65om3XmD86OsdAV0thxI7mahdthhn2uTugbKjOewx93A+zK4/XeVIKu/CGYJElt84r/ S7b7zOoMxtPlHl4REcuEKBKtbVfgORes+3canXRpZ8WzvKulF0rCHLIEPSRC/ENBixXfua/oDGx JdalhSykE1aMuE9Ej8kuvZ4AOo2ZBrZmiVcHRRTVD9HBc8J8HW68kTrBC2khwJhKap8pnDZqLKh NxrtpplQfUALhya/7/CYGJ+YcBwqIw6IZPvzmLeWfCn989gKJ8cRTvViEhIH045Zhn7WIg9pQYM ZLOQVxC/CkcHIeg70NgeTTuvQ0KsuP0Y0xURIIEBtCsrE9zMsgiM2HNSRfXuqtr0LwK14DUHe7M edhleZs7AQqFzEA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Move the lsm_order_parse() function near the other lsm_order_*()
functions to improve readability.

No code changes.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 140 ++++++++++++++++++++++----------------------
 1 file changed, 70 insertions(+), 70 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index cfcf3bf7127f..fd69bde9112e 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -169,6 +169,76 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 	lsm_pr_dbg("enabling LSM %s:%s\n", src, lsm->id->name);
 }
 
+/**
+ * lsm_order_parse - Parse the comma delimited LSM list
+ * @list: LSM list
+ * @src: source of the list
+ */
+static void __init lsm_order_parse(const char *list, const char *src)
+{
+	struct lsm_info *lsm;
+	char *sep, *name, *next;
+
+	/* Handle any Legacy LSM exclusions if one was specified. */
+	if (lsm_order_legacy) {
+		/*
+		 * To match the original "security=" behavior, this explicitly
+		 * does NOT fallback to another Legacy Major if the selected
+		 * one was separately disabled: disable all non-matching
+		 * Legacy Major LSMs.
+		 */
+		lsm_for_each_raw(lsm) {
+			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
+			     strcmp(lsm->id->name, lsm_order_legacy)) {
+				lsm_enabled_set(lsm, false);
+				lsm_pr_dbg("skip legacy LSM conflict %s:%s\n",
+					   src, lsm->id->name);
+			}
+		}
+	}
+
+	/* LSM_ORDER_FIRST */
+	lsm_for_each_raw(lsm) {
+		if (lsm->order == LSM_ORDER_FIRST)
+			lsm_order_append(lsm, "first");
+	}
+
+	/* Normal or "mutable" LSMs */
+	sep = kstrdup(list, GFP_KERNEL);
+	next = sep;
+	/* Walk the list, looking for matching LSMs. */
+	while ((name = strsep(&next, ",")) != NULL) {
+		lsm_for_each_raw(lsm) {
+			if (!strcmp(lsm->id->name, name) &&
+			    lsm->order == LSM_ORDER_MUTABLE)
+				lsm_order_append(lsm, src);
+		}
+	}
+	kfree(sep);
+
+	/* Legacy LSM if specified. */
+	if (lsm_order_legacy) {
+		lsm_for_each_raw(lsm) {
+			if (!strcmp(lsm->id->name, lsm_order_legacy))
+				lsm_order_append(lsm, src);
+		}
+	}
+
+	/* LSM_ORDER_LAST */
+	lsm_for_each_raw(lsm) {
+		if (lsm->order == LSM_ORDER_LAST)
+			lsm_order_append(lsm, "last");
+	}
+
+	/* Disable all LSMs not previously enabled. */
+	lsm_for_each_raw(lsm) {
+		if (lsm_order_exists(lsm))
+			continue;
+		lsm_enabled_set(lsm, false);
+		lsm_pr_dbg("skip disabled LSM %s:%s\n", src, lsm->id->name);
+	}
+}
+
 /**
  * lsm_blob_size_update - Update the LSM blob size and offset information
  * @sz_req: the requested additional blob size
@@ -241,76 +311,6 @@ static void __init lsm_init_single(struct lsm_info *lsm)
 	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
 }
 
-/**
- * lsm_order_parse - Parse the comma delimited LSM list
- * @list: LSM list
- * @src: source of the list
- */
-static void __init lsm_order_parse(const char *list, const char *src)
-{
-	struct lsm_info *lsm;
-	char *sep, *name, *next;
-
-	/* Handle any Legacy LSM exclusions if one was specified. */
-	if (lsm_order_legacy) {
-		/*
-		 * To match the original "security=" behavior, this explicitly
-		 * does NOT fallback to another Legacy Major if the selected
-		 * one was separately disabled: disable all non-matching
-		 * Legacy Major LSMs.
-		 */
-		lsm_for_each_raw(lsm) {
-			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
-			     strcmp(lsm->id->name, lsm_order_legacy)) {
-				lsm_enabled_set(lsm, false);
-				lsm_pr_dbg("skip legacy LSM conflict %s:%s\n",
-					   src, lsm->id->name);
-			}
-		}
-	}
-
-	/* LSM_ORDER_FIRST */
-	lsm_for_each_raw(lsm) {
-		if (lsm->order == LSM_ORDER_FIRST)
-			lsm_order_append(lsm, "first");
-	}
-
-	/* Normal or "mutable" LSMs */
-	sep = kstrdup(list, GFP_KERNEL);
-	next = sep;
-	/* Walk the list, looking for matching LSMs. */
-	while ((name = strsep(&next, ",")) != NULL) {
-		lsm_for_each_raw(lsm) {
-			if (!strcmp(lsm->id->name, name) &&
-			    lsm->order == LSM_ORDER_MUTABLE)
-				lsm_order_append(lsm, src);
-		}
-	}
-	kfree(sep);
-
-	/* Legacy LSM if specified. */
-	if (lsm_order_legacy) {
-		lsm_for_each_raw(lsm) {
-			if (!strcmp(lsm->id->name, lsm_order_legacy))
-				lsm_order_append(lsm, src);
-		}
-	}
-
-	/* LSM_ORDER_LAST */
-	lsm_for_each_raw(lsm) {
-		if (lsm->order == LSM_ORDER_LAST)
-			lsm_order_append(lsm, "last");
-	}
-
-	/* Disable all LSMs not previously enabled. */
-	lsm_for_each_raw(lsm) {
-		if (lsm_order_exists(lsm))
-			continue;
-		lsm_enabled_set(lsm, false);
-		lsm_pr_dbg("skip disabled LSM %s:%s\n", src, lsm->id->name);
-	}
-}
-
 /**
  * lsm_static_call_init - Initialize a LSM's static calls
  * @hl: LSM hook list
-- 
2.51.1.dirty

