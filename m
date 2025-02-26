Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F023A9A3
	for <selinux@vger.kernel.org>; Wed, 26 Feb 2025 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597665; cv=none; b=W+TMaiL9ETEd+bIy55LfAYhm+gQIJ4do74nGtVjxHybqpEz7WdlkTvUDSUxeQCTPzASqsIk/8ZQo2GOLQ5q1gl5W2/59ZQ0HmsEGXAai6U3IegmncStFHYLGIBdVn6OThvH1B1ewDrZZVVPM7KBpG9zwdCJy7CgJgE5LUbZuKFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597665; c=relaxed/simple;
	bh=WpYr04p1UkLDWtl5dIg7zK3U1th+UqvFkMU1unWOfHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hw0txFNgnPkfzcPAFZjiDxSHmPdpuhL4DYWUaXG5Ob+i0kxoIk9HPZ2FItuYlKHY5VFTk0Fpcts7vSJCWyFmZE6p6YhuLz3UZHwwKw/Ij3ezvZMabFcgm+dBhpJIajTQOTkyKthRB66YEMtuN/YpUGjx61NfS2ubcGwoapMZWrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jtrJ28NW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jtrJ28NW"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2211cd4463cso1665235ad.2
        for <selinux@vger.kernel.org>; Wed, 26 Feb 2025 11:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740597663; x=1741202463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8N3fCiVrbRYJnsDcemalRElfbpkz7bQc2o4sOKvhYDA=;
        b=jtrJ28NWEq3+3bKSZhT4zVDOqQFdnr9bXCfdSJRkLhNwFa9eZETgqOh8kUBo/wNyHe
         Dy6pUxlZDCzqQYU0Rw2/SUk09ufzCimHjUL5EsARgjW8D383fLd8bX/fuaFVifqNFrFs
         jPbpJwAXjloMzODIX48KfqnyLElw1ZJO08wwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740597663; x=1741202463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8N3fCiVrbRYJnsDcemalRElfbpkz7bQc2o4sOKvhYDA=;
        b=KosxqX57zgZNWdxm4XOaesJz3H5TrkTSedfHrOAlwvdcs/25TQvduN/Dyi/gdF4dcR
         nuOfkkRa0OFpruqTyKIFho8Odxo9EdnW8N8WuL4tH6I5qkn219eOP/NJ3teqm+Un8S89
         5Q5suh83t7dIP8ilUHZgFwdWmGauv6ESNSeguxoB7nDB5SQlXhZ9BXxQoJ2HMVrWJmK7
         KuG7NcST/k++CrHc+0K/wIWHyjfE9dwNHhfCRKclmHw51NaI+bu/YG7AMXLBMUnTyNNS
         gCH5DGylFNEKEvjcrDO4z+o6EjY75qpLmbo9VjecrrVG5zJUx8YOHvjYeLTb/ZrhryTv
         LKyA==
X-Forwarded-Encrypted: i=1; AJvYcCUqP1HmGzE+GA85umAIoiffWZJFhlfNq0rZIpjj7fD12wzrz10uU11RSl0J2PmG52/jv530gL6a@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp8d/wOKx9L59U7S9jXfjCGzi5KGmgw5Qw4C8CSu9CxgI751RP
	ker/56cWTd25tkq9GtCMPC+MtHAVs9gv2E7Pj4HjPX+jgdzGMp9DI4f4Brq05w==
X-Gm-Gg: ASbGncstwXP6YATbEhAYRPvtWPy9/fjYI5k3ltcJUGhI2FcZe63fgiLDPmvQcJ/ODTC
	GNnDuyOtyHLsbZk4PPsq82ISZPWdyS2SrgbY2LmZRhUVqixnN3A1oNQvHr8aJsH7nbfTF9tJ0V7
	vSG3+pZXU2T8ezqR8jRms6VOkBeRbLLAiVF8qCdRRv+6O0BP5Ugp79a3ORBAC4GojL8kiguvyi7
	WhgmZgkKPovci/T4/+fD0BGPG357yFJl6qYHUqhPilPmQGZmlCW3UdW78KGA/KJ94/Ux+k/GM0q
	BPCrnGApNu18pAsDUsS/OkGWgguesmSu91pRzAe7eOoJb3SjsDs3ju2MWKAKn3daXiP4d/yH/TE
	vdUzrTpPcd0p6
X-Google-Smtp-Source: AGHT+IHloyY5llsRwZmYOAMtChiquooiL7oF22Jfz6xhil9TWQQpChOD8vyx6ebjqWqMfIQbsvyx2w==
X-Received: by 2002:a17:902:d48c:b0:216:7ee9:220b with SMTP id d9443c01a7336-22307b4cc17mr117990425ad.22.1740597663658;
        Wed, 26 Feb 2025 11:21:03 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (4.198.125.34.bc.googleusercontent.com. [34.125.198.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22341c04d16sm8473865ad.190.2025.02.26.11.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 11:21:03 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	selinux@vger.kernel.org,
	hridya@google.com
Cc: smoreland@google.com,
	ynaffit@google.com,
	kernel-team@android.com
Subject: [PATCH v15 3/3] binder: generic netlink binder_features flag
Date: Wed, 26 Feb 2025 11:20:47 -0800
Message-ID: <20250226192047.734627-4-dualli@chromium.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250226192047.734627-1-dualli@chromium.org>
References: <20250226192047.734627-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Li <dualli@google.com>

Add a flag to binder_features to indicate that the generic netlink
feature is available.

Signed-off-by: Li Li <dualli@google.com>
---
 drivers/android/binderfs.c                                | 8 ++++++++
 .../selftests/filesystems/binderfs/binderfs_test.c        | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 94c6446604fc..b3d21ccd81f2 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -59,6 +59,7 @@ struct binder_features {
 	bool oneway_spam_detection;
 	bool extended_error;
 	bool freeze_notification;
+	bool generic_netlink;
 };
 
 static const struct constant_table binderfs_param_stats[] = {
@@ -76,6 +77,7 @@ static struct binder_features binder_features = {
 	.oneway_spam_detection = true,
 	.extended_error = true,
 	.freeze_notification = true,
+	.generic_netlink = true,
 };
 
 static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
@@ -619,6 +621,12 @@ static int init_binder_features(struct super_block *sb)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
+	dentry = binderfs_create_file(dir, "generic_netlink",
+				      &binder_features_fops,
+				      &binder_features.generic_netlink);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 81db85a5cc16..96e64ebf910f 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -65,6 +65,7 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
 		"oneway_spam_detection",
 		"extended_error",
 		"freeze_notification",
+		"generic_netlink",
 	};
 
 	change_mountns(_metadata);
-- 
2.48.1.658.g4767266eb4-goog

