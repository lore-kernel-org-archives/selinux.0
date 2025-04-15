Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364CB27510F
	for <selinux@vger.kernel.org>; Tue, 15 Apr 2025 07:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744701036; cv=none; b=Yt+pOr4qPAzawTEhV8H4dLYNWREK3QJnOzj4g5EapUkSWPsIpt5AWi5NxdfVsjYGCUuQnPxIm4iBVkcj0z0Zyl+7wk2mGlcPQ8xXedXz7JnUUhTBaOMY9i9Fot/UKRZaKePDXHyy1SJo91ovdoBYtR0clZcxlLRkgHEdSc5nM8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744701036; c=relaxed/simple;
	bh=5/Q6wZAHlAFmRAc6PTdxw7FebEdY0c1THxnkixSJjak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuuFXh5Ss/iVReT4NbFIWdxN6HhwpyqwcEAwyEAXaYH5sUdQl5xzUt6zcJ7vz5AMYPB7Hal00zeGmNSu7r/DF/fw/P7FH8WRXN3ppd8j+jYrMfWi1FsnYt9AmgxrJl81QKQtmZn7CihXfVZsCPKVZuwzntXv5+1OtiEAPnS2H88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GMar4xyC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GMar4xyC"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso6324204b3a.2
        for <selinux@vger.kernel.org>; Tue, 15 Apr 2025 00:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744701033; x=1745305833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMq8j0+T2PKoYo9dFG4yyaez3NXQz/XEaR/01iGoF+0=;
        b=GMar4xyClu9m1y/TQ7v0sxLCogMMh2pPHp8Nt3sGNzWeN4f/YzWXhlAb1tQDw+qEKL
         DpwZIi3Xb2GrPME4y2c0agDCSFbhn/T73JQdKRPuxHknfkJcRpUOENmPfS98N+b0CBOV
         qQE5Y7yP1ZGT7Z8AKZywdnT7I4LWVcq0sZQfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744701033; x=1745305833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMq8j0+T2PKoYo9dFG4yyaez3NXQz/XEaR/01iGoF+0=;
        b=Pqp+4WndGjamsgRY3lmzqYchwNXjSzFrlEXosnE7EIJe8zQkJPpwe5UBNSpKhVMGLh
         JwjZtPG8JAdd+2w5bS9sazEHWOQ+OHhp6w1xx9+w9bRYyy6L8HN2p5JqEWCyoK8TQ3Mh
         IH7/ikl90dtCw66tfoF3Hkqz1dn5kZX7xYiDKyf0q6715Q0GCTkDV2WVVw3YupC6Lf7d
         7yp0eY+WPkYZ6XAZTN0fjbSY2SR6h/MiXIIirMSTDb2OXCd4+7bkprRqg5jKkzGbxEzY
         1SkNcyNQFTDigdHLCI9Vt34Y4KbgkTRMJwxlcl0cUBZbEc3CBI4vQ5cBTlqXCAqJcD5S
         mXWg==
X-Forwarded-Encrypted: i=1; AJvYcCWvDfaotGuzxDGWQXnHi2KxPX19AkrpItTbpGWbceYE3wMkyVEmwHgZKX89ZauUwcVyReIxM6U9@vger.kernel.org
X-Gm-Message-State: AOJu0YwMcH/o4TgUIRGbKaW7Xa21HTSMAppeahNP+P6srhdHvnnGbR5R
	eSg8lK5Ts895WI/+hfCZsXyIG2c2rPz7w8Jxs7vKkCl28Y1PY5opzhBzNFbErw==
X-Gm-Gg: ASbGnctxcFeBJ+VGV+1Ikzocv83GNems62RHProbhOD533ZdNnT+KUYbooqIFIFhm1d
	smszNWUSNsde/umAGj7W7YsRoTpgce+1fZfx1KvS+AGf5QAyiTpYGnvhs9sX3wudkOfbezAQozT
	L8sSv2qaww/5LM7O+ODAJGsBLKbn6tr9+Tod4tjY52COpI3vMwlZ8a9KCScD3VvE80J77jKTHOa
	jUhwrZJB4Btuxeh58CyCurb/EIFBWjyakqBjdxohc4Amkviu9ZPVMgqWEsTFzDPLjjFnU/R77/w
	eqhDtHZfL9B5+qgnuAKvlqq3NA0dfCUCSChylVsDIBiw8JVldElxe8Lrges5LY8CwPjGV3k7dly
	G3KXFeCvs5GDbjGSS8JUsazrGyeWuUu/A
X-Google-Smtp-Source: AGHT+IETMONHFj3vtnyzyN1Hl4JTwNESRGr7vfO1xrjSKAxvHZMIIVgKsrXxTSZx103zJLRD3NHWTQ==
X-Received: by 2002:a05:6a21:3a96:b0:1f5:730b:e09a with SMTP id adf61e73a8af0-201797ae1e3mr22020972637.20.1744701033333;
        Tue, 15 Apr 2025 00:10:33 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (132.197.125.34.bc.googleusercontent.com. [34.125.197.132])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a2d3a250sm8659543a12.62.2025.04.15.00.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:10:32 -0700 (PDT)
From: Li Li <dualli@chromium.org>
To: dualli@google.com,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joel@joelfernandes.org,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com,
	omosnace@redhat.com,
	shuah@kernel.org,
	arnd@arndb.de,
	masahiroy@kernel.org,
	bagasdotme@gmail.com,
	horms@kernel.org,
	tweek@google.com,
	paul@paul-moore.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	selinux@vger.kernel.org,
	hridya@google.com
Cc: smoreland@google.com,
	ynaffit@google.com,
	kernel-team@android.com
Subject: [PATCH v17 3/3] binder: transaction report binder_features flag
Date: Tue, 15 Apr 2025 00:10:17 -0700
Message-ID: <20250415071017.3261009-4-dualli@chromium.org>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
In-Reply-To: <20250415071017.3261009-1-dualli@chromium.org>
References: <20250415071017.3261009-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Li <dualli@google.com>

Add a flag to binder_features to indicate that the transaction report
feature via generic netlink is available.

Signed-off-by: Li Li <dualli@google.com>
---
 drivers/android/binderfs.c                                | 8 ++++++++
 .../selftests/filesystems/binderfs/binderfs_test.c        | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 98da8c4eea59..bf9c3becca1e 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -59,6 +59,7 @@ struct binder_features {
 	bool oneway_spam_detection;
 	bool extended_error;
 	bool freeze_notification;
+	bool transaction_report;
 };
 
 static const struct constant_table binderfs_param_stats[] = {
@@ -76,6 +77,7 @@ static struct binder_features binder_features = {
 	.oneway_spam_detection = true,
 	.extended_error = true,
 	.freeze_notification = true,
+	.transaction_report = true,
 };
 
 static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
@@ -619,6 +621,12 @@ static int init_binder_features(struct super_block *sb)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
+	dentry = binderfs_create_file(dir, "transaction_report",
+				      &binder_features_fops,
+				      &binder_features.transaction_report);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 81db85a5cc16..39a68078a79b 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -65,6 +65,7 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
 		"oneway_spam_detection",
 		"extended_error",
 		"freeze_notification",
+		"transaction_report",
 	};
 
 	change_mountns(_metadata);
-- 
2.49.0.604.gff1f9ca942-goog

