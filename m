Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFB124469A;
	Tue, 10 Jun 2025 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576187; cv=none; b=uujWagY8ai/6NMrDqwwOj+cT+j7sd7rrOxaXGyJxH9HPMfa61362Pn5Ur8vTXuhTrqKLSDS86BQG3Edb/vXsVwKi9d4lsUwEJMQhVguLBjfRz352cmvlkszFfXPk2VLY3WfQGp0CB7IoGriwE+/6X/0p8u/+Yf//+fe8KpqMxnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576187; c=relaxed/simple;
	bh=Vgdd62kQtHZhUV1xPbHRIBzBOV3HyEzrAFAVC6EVcdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srLRtOas+bL52STSj/wF4U8hnW/F0Lwq1epHC8fTVSF/odBHYjdIHa9wAotfJXShOqygKiD+Xvv73EPqaCSC9GLtZsY37LA4jSSSPWGGCvYv+00L71ykl8GWoEkbxTThzZh69tlMnqdy30HXRmbp9a/1CCBonIlz1PSXCvowlEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fg2QDMp8; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fg2QDMp8"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c59e7039eeso814168885a.2;
        Tue, 10 Jun 2025 10:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576184; x=1750180984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVnpAGVQ9IOljiZmwmCLJUNC1q/ixoo+OOZwgCeJjgc=;
        b=Fg2QDMp8mX3h4b+9Q5oyE6m/ffcyhTdTLngV64JPL/GyUXGY7e1AwCpqYstUAcLdXB
         jQ+nN7ycSpq8icgaSI2iSagNNoThNDLbE3Tg/wiB7h34YWTqSclz2zstvY4WS+RAfSXB
         RbsrWGPtzj1Mfp6JvOriQzjIjrmON+SXX4j2z0hJXo+DI0PQl+xJn0DUJb+TnJ1K0wr8
         OMRDuuqa1Y7r1hzifJvYyVGGBGAlPiP0OWE3NC45Fy27ayW35ImelsnGoiOT7YQcBxIy
         PVSrClaxFWIdgY274DIyFOw9wuUs+o2qrNnbX5hZK8WI+i49armkgeT38TaMc/lQlYSU
         24Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576184; x=1750180984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVnpAGVQ9IOljiZmwmCLJUNC1q/ixoo+OOZwgCeJjgc=;
        b=OsWcdQW3br+onMdpnJuG7bTpU7Hrq+FhQQI1B6EXgBeFM0tX9TFCkV6/RR5Tmz7Irj
         jQcJquZxh3sKvW6L0xW0Ig1EGxVMLahAsc8mbufuSGCYoAaDynYys8ytlzqFi6T3JS2W
         hb6T5wb1qRz+m99S4xqjlQHGQpWRSJJ67lJVXWdAVtfhQXi8nJPPfwBxiY70nXvPmRBb
         2tht/hJUUAAd7ihxnojRoEjtMZgG3zTbCGqAeRjBvmBeenhyY8nfTqKI1sy3VbZDtIcp
         HvinpzJxmzvXvKjNFw9rFhU/oTYdWT8w3EJQUekHYeniaHV3EdquN7bLmpvmYolmF3vc
         A+nw==
X-Forwarded-Encrypted: i=1; AJvYcCU6C4f/UPkywc76p6DOHf/pZcCTfq1d7fFVgzGLxkSmls7FR1AeSOKdWgrByl1vR6WuDGqJ08Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnGBn10iWcDDOEOwKG+sZbpvbsupEmDCoTSe096WGqjwyjOUG+
	w4X7kXS92WPSnqkjqpwKPexbWiSLLnMmZFI0wr45d5XCOtQMprHY+Z7etBm5Ow==
X-Gm-Gg: ASbGncsxNi599KoJz7aCI4wG4pxNrwFFA/L6Z4m9p0m3f7R2raLvxBTV4yHGpLB1jWu
	nN6PG0O2+4KBeY4BqNiUYhL6O0SPntsoB3tUwj0KkHC6YK21J9ynKJycTR06mITrpKP+OZE5M/H
	rpMTUEs90xp1R4KBk58hI5FN78Li5gkarz6/WvQJeJJELNFodr5L0Y8bN1z8gzu1ZHZL5stThR2
	e9byApKz4d+KFnXC2Xqb8kDoa1hUTgNVuyMAJQeAHaZHiOAaSk1JAUv8hmRzptBFTcTedmNfdmj
	VKBCnx4Mpeo3eHupdSkzyLaYn8Uem6NpQl2ducLTUenx7tlReKvk5arMfb2Sw1ig5svX3WjTaqO
	fh6+oBIterfpgQEwBZaPddJYXFyUr+2B0lNuULgX6/ilp2rZRA1ugX2aQnxSja/T4lbAdF/10o7
	jL
X-Google-Smtp-Source: AGHT+IEo1tUM0uAyCjOD7wfccSKmGlaqYpuQuBJNb1uaD83q42/Pfh0SAHSPBp6M7inNba1lUywZFg==
X-Received: by 2002:a05:620a:46a7:b0:7d2:1891:eef8 with SMTP id af79cd13be357-7d3a87fb71emr36339085a.25.1749576184047;
        Tue, 10 Jun 2025 10:23:04 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:03 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 03/42] selinux: support multiple selinuxfs instances
Date: Tue, 10 Jun 2025 13:21:34 -0400
Message-ID: <20250610172226.1470741-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
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
index 8340a53c6171..fd03ceb6c8de 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2153,9 +2153,33 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
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

