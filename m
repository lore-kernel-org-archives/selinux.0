Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C25619AA5D
	for <selinux@vger.kernel.org>; Thu, 17 Apr 2025 00:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849223; cv=none; b=FDfnrOL+9YXRKfaU3HUd7QGZ0C5U+XoGuZv8EM+a0wLSLKQjl1PnctvELynbL17stv5fLBlRVSc3t3xm8Aa/+YfPwszhCyeT4Xb9EBsqhMQu80+vQLAmWzc1iO7HKxTxWl1N/LTE9qCQlmX0v9aC5TptlI5pdWmdb0gws+yn85E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849223; c=relaxed/simple;
	bh=VP42e3JZfKvbDI0ooyfOHhztdSFzkob0S0fpP+PH/Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Slvsp1doUX2WNBnuX9PLMkXn6vKTJa7LOSIInvru47EhO18DLL8dqidT1F0X0+8o5LVwhajZRljMP4HukyQtJy9Fqj72BwoATa6UO5TaU6rCsIum/kuPXVovWicYg1L2O7WfhIKpxQ9z7K7xqvGYzPE+HHzY4rHssOmL8R92jGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F4zrrPWI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F4zrrPWI"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22438c356c8so2606345ad.1
        for <selinux@vger.kernel.org>; Wed, 16 Apr 2025 17:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744849220; x=1745454020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9d1zeenHo/WIdiHzlhPJ54CYp3ToWYLsArkbPVUXbsw=;
        b=F4zrrPWIcguk6SioFjSVXIiXyEy1gtu7ZE2ypRomNPScixTqH2uAXuJ9jTZf87VCmk
         Mh9p5vWCdxKR50xcZujHBmV1mC8RMhGpB6PBuX9zBON0wbo7Oa+J5Rbs2UzVH8zJnS1v
         MhTTbEvU9KnUTXI/4VTdZIJ1DjLslX+pb9z10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744849220; x=1745454020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9d1zeenHo/WIdiHzlhPJ54CYp3ToWYLsArkbPVUXbsw=;
        b=G3wyCSlGAKHYg7U8o/mC/MqDywVLD5V8yCt2u1mCjg5W7de49U6VOWzgQuayPGKWEe
         Ey6c4NsKYbBzU1YmXOLggcB28ubXl0w/gmd9xNzg9oP411eZNXsmYApFXc/80kp4GJoj
         D5viVJ6JqmK5u3MwkZeQNtsQJXdlfEGUpkMP99Q49prFZtx9JXT2XUw5yo6knQ7xH5Po
         bBWUVHiThJqgQeKWctyu0AXDGHRERKDHEX/wZL7hBcw3WoZahZsvi93rouAsMzjl0fOt
         hMXUVAlzA7xxQPDChI/QM12QeEqfMnW9nMCSk+ip9CzaOaTxVy/5VAkJcpxw67tPDB64
         pmNg==
X-Forwarded-Encrypted: i=1; AJvYcCVIDzioEEvOK1Vznib7Z/5QimBZawffptIgDz3osSlaYdR8I/Ul+/d8rgYvibmoK7VC5RrdLvg5@vger.kernel.org
X-Gm-Message-State: AOJu0YzjKHs/tn6Awi89Ex1KTV3m8DX0Euf58AP6L3Q964JeV+anrxgr
	ijtjQJFqIJmWaJbwC9b9ni+e+KRKnn8xPNZZ971Spj7aF7PW/JV3BzPkfvKoVw==
X-Gm-Gg: ASbGncsDE6p6dQioN+n1wb+I/rxAK3dKkPwWO6AIx+yuJctwMMiFxrYXDSkZ7WTX4vF
	3wptapCbjqltC0wokZbK8DThodIMzKq/yD5OufQZn6Oehh12m0vCJEO8INb3JWkW7qN2RayrQ+i
	RPCh/bWrYk5X2DnX0ojTGDvsnWaLsO3iNesCL75V7Rgv6RCnjdeo4ETvhfjxMjoEJpkj3RcU/5G
	UyLH0A4IUQbfUZmYJ0rcYBQNBYz84SxSmQ68UuSeFnBfD0W7gFpQKoqNF8w19jwVaRTsfwZ8udC
	jlRdQztXhcljXDtF/yZKjtZl/qcc9BYODafThAs0CqmIbIHJN94Ii5cicmymau6SQUcF/F3bIqE
	mprPmc8W2/0h5MrGqOUJhYHe/9B8kzPJu
X-Google-Smtp-Source: AGHT+IFzYIV/9mXR0m0O/AxlmrF16OfOBFQ+0jrJUZKzp7v11JEoGIiIxamuwnoqAODi21WwPq6gSg==
X-Received: by 2002:a17:903:19cf:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-22c3591883bmr62046785ad.29.1744849220600;
        Wed, 16 Apr 2025 17:20:20 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (132.197.125.34.bc.googleusercontent.com. [34.125.197.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1cd87sm20719205ad.73.2025.04.16.17.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 17:20:20 -0700 (PDT)
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
	linux-security-module@vger.kernel.org,
	hridya@google.com
Cc: smoreland@google.com,
	ynaffit@google.com,
	kernel-team@android.com
Subject: [PATCH RESEND v17 3/3] binder: transaction report binder_features flag
Date: Wed, 16 Apr 2025 17:20:04 -0700
Message-ID: <20250417002005.2306284-4-dualli@chromium.org>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
In-Reply-To: <20250417002005.2306284-1-dualli@chromium.org>
References: <20250417002005.2306284-1-dualli@chromium.org>
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
2.49.0.805.g082f7c87e0-goog

