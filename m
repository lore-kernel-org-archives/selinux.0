Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D5C298C12
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314623; cv=none; b=e1cAQo0/oChOzuiqBT7gEUQoywi+NYhSy1FEvSR/q04fhjZC2FjpBKynNIqIJbtq7T/k5zRuhssVkAuIwnC5G0n637vFz+Sae0RGz17Uy71PSlMUZwH80czeYhl6RuWaOFCZKOvyQFbhqeCn+1jon8RqF2hgwFoD4BBLDx0y4+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314623; c=relaxed/simple;
	bh=gQ2jZtTu8SKVcIHNUVBgvaHxubI8di/Nqv4knE4s4lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBcGbDAA4xYKZiILWCvS5/1sPr0vEX4xdCsidvoLa3QKkGed1750bk+RegIsC0vmzCN4B8da+ZKm0VZNF5Vo7XwzM0URvT9GfN683CXZEjIX+f2OR3+x4KpSuTi1os5Mag8GiyuR+EKsow2XlhKy8slO96GlvYLVW4oZeilyXNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4+x0A0l; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4+x0A0l"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6f6e398767eso26009036d6.1
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314620; x=1747919420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d23Uue+6ZzGcEuFdQN4kHBs4Guv0u3YC4sJT46uDKEE=;
        b=f4+x0A0lBn8TwAVCL0ks3vCjnwBxpQ64jSoJMX0UjLUgTdi3E4V0SrdvLhfU/Jw16R
         a9YagcR9i9jLXXMfbV1/+Ackw4zITMXDSV9JgTqVAc6aeWBm4P3++HdtqEF1AYE8BTmd
         AnXL4voXwhPT/3gE00gMJC1S9SdrK/SUOBL8aF2p9ceJV9LuXN1WquucD+UXblXxVn/K
         CCwjt+LwsPlzOSAvZMAl8tPULo+FB0t4A6wzmkPtUUDtCJThxguoiXjUxx/eS7MQ3zMR
         d94Tf+lILgOl29MEO3j1gjJmEtJPgYcQyD7XyZBr5FE5J2tz6F80XzIIT3CxFwyANVT/
         TaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314620; x=1747919420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d23Uue+6ZzGcEuFdQN4kHBs4Guv0u3YC4sJT46uDKEE=;
        b=VpQwPIePpceJE3YXgZFtqPGuEalbpIvLWPQ4yhwwrrZFT4ApaWmMsRvta7sAQMKg3C
         GjXY6v93G6k0dscL3zn2Drxmm8FjPzbMeIMNCGDyjIGz6jb0cL7AZ6I9kIS6lSAfukke
         XmV3k0TZW0qgPyZ08/V2LdjQgpRRnFMcV0jgfgjxgDxBRzxgVs/lTR89m7khRO64uWo4
         xeCYHSg9sQ7CpZTedukHIdyLi6msHRCvLkr3S1Q6TZ+2NMKvUtaALBSUbqiB9iPVJJAs
         aHxwfB6cKWIrd02+HO+ULPkUfkirSW/tQEFzWeyJbIsgI/Xw+m5HT7gE0wbdn6VJXdtN
         421A==
X-Gm-Message-State: AOJu0YyG3soCBIASLuq8xF56Mw/lIYNbUfc3QO0ZXjxuUsamD+8F2o/0
	LJzwQUfu++GlmI5upHSwkfOx7M8ULrx0GRGA2fgblAemnTODEq6oYQtSQg==
X-Gm-Gg: ASbGnctRgZJcDK9r7kKNBU1WrBfv2bjR2Z3WzVA40iw5COmN5SrF1vfCNLBRjKzC0An
	8j9BMZBCkes+Wpl9II0Pielk+oKCukOJg/B8ca3ZD2G6dfKUg9pp7UJNNRAR4GgL0gaWXmXntFC
	gGDjNX5Tx6MqVNPfgDa38PRhPhDZ8+yrnau9k2Y9UzMIT7Fo7m4rQUMrlBV/HV0QAqDgtR63a0G
	a0RIem5ApRWwVJuz7GMkaRd8plfPXM1QiAotkdwBZ+trTAaSxtHJNpWqHRvYPGQuUBhbKHiGt/h
	NZZFliSY2t/96XRZKLL0Lf45S8W3LexBg5IpYhfpF2D0HHUHBjshhj4m/GebLLWcHAxgq8lUPjd
	RkrMx5vaYuTSiamAYYdh8f1hidky/lWbIc2Jjc0LJMubaTlZP1dsnHg==
X-Google-Smtp-Source: AGHT+IE18Cmxyd6XZ6CZi0GNcpR+0ScNZ5aCzIbVNFrczCcOVlks3F8zSey9j9yhl3st9iomXx4qPw==
X-Received: by 2002:a05:6214:2386:b0:6e2:4da9:4e2d with SMTP id 6a1803df08f44-6f8a31b35a5mr59167986d6.9.1747314620425;
        Thu, 15 May 2025 06:10:20 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:20 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 03/49] selinux: support multiple selinuxfs instances
Date: Thu, 15 May 2025 09:09:01 -0400
Message-ID: <20250515130947.52806-4-stephen.smalley.work@gmail.com>
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

