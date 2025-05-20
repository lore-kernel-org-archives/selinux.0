Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C60C26B2A9;
	Tue, 20 May 2025 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742465; cv=none; b=mopI828tDz87oLAcKqkf5R+IPEGokXfU9N4wy3nghLLRfcC+rPu9sBC/TV7UnXfTzhjCH9znUzUz/MuQU+u2e2rgq0eFqtWzFqdwSnWGothL5UITzLu2EcLWOuzEzoMmZNXTsN+lCh/J395oBXeqSHQv4Xc4gFe63XKZUiVKrUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742465; c=relaxed/simple;
	bh=gQ2jZtTu8SKVcIHNUVBgvaHxubI8di/Nqv4knE4s4lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENnFDKBaUQqfUwiMcScKf1PUIteg3vCY0lRnd4BS8Udubm5cgUrxAsKtm0Q12XHyPFzj4vMs5IKKr8i15w0lg3nxLfczFaEYWUr+G/LVPgsZQdAw9B/TUuWma04MSAI6g6S3HaZKZJV5X+dcaL+0Ehh0MNi5I6OeXXcIX5dpxsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m17T1D49; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m17T1D49"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5f720c717so781535785a.0;
        Tue, 20 May 2025 05:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742463; x=1748347263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d23Uue+6ZzGcEuFdQN4kHBs4Guv0u3YC4sJT46uDKEE=;
        b=m17T1D495S9bGOm+hLwjy8UQbLyap+FMNgaLU3qiAe3/ufCx2lCThILfKH/PLS7Ax3
         VRrvEQJd7ekxwu0fSQ1PPEpBDL3NiK5stTxTqXIVk5dA5Wc6V4cwMvihp+GbvSMtQSfL
         nxt5QhFPDp32varVGtMM0G0vbte8vgUvecSabs0D3yrkA1udjX+4sj9PW+z9buiBJOaB
         4kCi1kqM9RrMAr4f9mOy/hqSSixAcBTBieSVIqiKMaLa+kWZ2FHJ+eOQzDuMPEKLtm2F
         BoY1NV4F/27hJaMDNsj796BSsRPxqXcXa+1JAQlagmaE6P6p9VigvkCIQUKRWtWZNeFe
         PRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742463; x=1748347263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d23Uue+6ZzGcEuFdQN4kHBs4Guv0u3YC4sJT46uDKEE=;
        b=PkvG6V3FC+6yKu7yrOjcUMlUN7G/HxH0HN/E/+yUGLowI3n0gUwuZ5qUEiWimKMUUT
         MSlCYLinzgCMi3DMYafuhw0TN7oW5ymPwxV80rtAEYZPRnAcXG1x26OT5DQLPzGZ7ooM
         RbnInVwKb7PHIabFRs3T1uCpcqwa1m91d7lpYtPHiY6bvYGI3bt73w3S+4Z+nwFV3yPK
         pM5xQwd/fEWdxWN61Who8mqz5Mjzr+wBLLqzvNbGfoQyw0ybOL9eO8Opv0cwJY0V6dAT
         Xn4lHDWiwdnvmYWjupwk2DukKzXzKy4JGy2yXSdBTwWkTReevdqL5Fxn2yK8AeGgUiuQ
         mm/w==
X-Forwarded-Encrypted: i=1; AJvYcCWvkkihAj+9eFkmbXT/wjNkaIaMQzw2jY+JjAD65mwoNK5sbwkpcV1SI5k6/d9dkrXIpqXet+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwiIDDPdCaL4Bxe6tHBx+oJ8jjQym3uL1dCcV9x9q+ijXESSDx
	8sjZGSK3Iy3ex+d7FvKeAXw48q80Pd3Ki+EsFYK5P/PJaTbhK5qOBEvKkPMMKw==
X-Gm-Gg: ASbGncums/ROLkDuf1r/WuQGOkpfGX80QEVGQQ/ZSHYPGc7HkieFL86YaR8fXF9523E
	pmD0XGg3Pfz3EHW2cDxkA/TkTMW5lTwm2FFEjNHm80fBfcRqw3HjSs2yBxZeYckTwD3rGyEGsHu
	TgqxiaqyyS6R/dAXPcY6IEEvgQt7/RAoNp5870pw4qWG6W0AZH8mZRyJdUBIkPP/DNcPo/Zzhg5
	hNf7Qg6KPfZd4JQ6YRlRBiiUMUkWpt7yQ/lL3bEwLOpv6CfK2QhrRFNBDm0Vx9Ua8uU0dZDGWzL
	FjblPjpQL9MDleB/FKZbHch5lraJDe5CWyOuCGcXixodMhXqJPtkfdZTDkTqnlQ8Jct1siRVK6u
	bnec3U20S4D3D+x0hX5kKerxV0reocSDuAXtqSqOHAFa7TPIXyHgM2Q==
X-Google-Smtp-Source: AGHT+IFOIhmLnSkFllKMwxIFfvOlWNkjRJGir203FW681Alm1aX2MXLtDmhP8hsHZpQyDVAlMB8XVQ==
X-Received: by 2002:a05:620a:3720:b0:7ca:f4e8:9089 with SMTP id af79cd13be357-7cd46af8e03mr2603350285a.11.1747742462653;
        Tue, 20 May 2025 05:01:02 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:01 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 03/42] selinux: support multiple selinuxfs instances
Date: Tue, 20 May 2025 07:59:01 -0400
Message-ID: <20250520120000.25501-5-stephen.smalley.work@gmail.com>
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

Support multiple selinuxfs instances, one per selinux namespace.

The expected usage would be to unshare the SELinux namespace and
the mount namespace, and then mount a new selinuxfs instance.  The
new instance would then provide an interface for viewing and manipulating
the state of the new SELinux namespace and would not affect the parent
namespace in any manner.

This change by itself should have no effect on SELinux behavior or
APIs (userspace or LSM).

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 3a1217b6e322..aa59a93be5a5 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2152,9 +2152,33 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 	return ret;
 }
 
+static int selinuxfs_compare(struct super_block *sb, struct fs_context *fc)
+{
+	struct selinux_fs_info *fsi = sb->s_fs_info;
+
+	return (current_selinux_state == fsi->state);
+}
+
 static int sel_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, sel_fill_super);
+	struct super_block *sb;
+	int err;
+
+	sb = sget_fc(fc, selinuxfs_compare, set_anon_super_fc);
+	if (IS_ERR(sb))
+		return PTR_ERR(sb);
+
+	if (!sb->s_root) {
+		err = sel_fill_super(sb, fc);
+		if (err) {
+			deactivate_locked_super(sb);
+			return err;
+		}
+		sb->s_flags |= SB_ACTIVE;
+	}
+
+	fc->root = dget(sb->s_root);
+	return 0;
 }
 
 static const struct fs_context_operations sel_context_ops = {
-- 
2.49.0

