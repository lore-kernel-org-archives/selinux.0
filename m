Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D5631E10C
	for <selinux@vger.kernel.org>; Fri, 29 Aug 2025 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756476792; cv=none; b=QO2GEfFJi360tLQgj433XGaEWxL/F/TWr7e8EmvBJXOs+SlN9mbeO8xLD30qxyQ9C5+6y91YzAmBTx5rujJ65D5YztnDMNHhumERbC1YNTp5gb2QcYgrglZnm2AnVrf621HEgr2bcrdwhgAARcew5VEhg3huuUgGkK2n2sHQDOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756476792; c=relaxed/simple;
	bh=SRvySb7urCk+pC66zQnfXxb0ngsXFtygfKdXrYdKbFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HQtUb1ZRDgE0LBHGjWnC4rEUQxBmdklbjp2QwGC5Ctsm3r22ru94OCw3GxPjOy2npHwaHLDKhfKSD/syvETq+4TKij6dFIdsihS6Kqy8vEIXC3o0GeMbqwopwZ9mf/mGAnzMRw4uKp5mqMIQ/AK88X4lKQOQaZwy+KDULaaSNOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f09Tg6dF; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f09Tg6dF"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70ddadde2e9so18160196d6.0
        for <selinux@vger.kernel.org>; Fri, 29 Aug 2025 07:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756476789; x=1757081589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4xX48SgJl+0SI+PRoRzXaFSC8jsYEwGziJDQMwJfaE=;
        b=f09Tg6dFdoF7/IW67X2KKiX7B+Gxo4+CvSnqQK+p/VPFx2vF+uXBtKUtCa4Owlh1hd
         X45xY/T1vDnRm9Ly3itaQj+XvdAlvse4tYroRgl0TCHt//t9j23Zan3mtWQjCc+5G76P
         mEjflnvaMd71auQ0O4blir17NxUCQBo+bZyJAWzPaQF0g6AakWDXyATXf1p4DbcKB+T0
         4f+RVBi0+tnCr4/XK7wa2RJMuvsEvJEu0aeOt2LbAqzirBCeVBwYInw3Djnoi5t719iX
         bbfvlFHGOYLRNd3/dPkT27cpGkghrGPIih6Wk/IKUKbdgCmkEx/RPwnR28SZD5mpKC/c
         Hkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756476789; x=1757081589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4xX48SgJl+0SI+PRoRzXaFSC8jsYEwGziJDQMwJfaE=;
        b=Q5aeoJfNQjEp6UvB6XOZsQ5zb45s0saxlJ70MIjCib/HvutWQ9QLRHbqNfo9qOBLuU
         Fr1uIzVxMtM4gGfot9zyWlhVZj3WH0Tu3SD+QHhvoGfYef7+0bJO55TwnoCqFsKh95JY
         a8shH5w8UMbejtW7y5jaaGaNe5yVZiaYre/0wO2k31HHXTy6Qcz8isGPfd4nP0RuvkDq
         ZDRh+qeDtGTFHW41dYldCtBUk0XU0kOWUsvT/irAQ36xZ62B220dAJrb06ggPkji1qTB
         EBYxpjvzJtI4HTnauyannVJEjv9REErecdfhn7rFBRBKPg62PMj5B1l4ZKGpVcoiphuF
         tF3Q==
X-Gm-Message-State: AOJu0YxI/952haqE7MlqvbumQZq4BFr0LdNVq/amfM0xoAjJAvW1q33P
	kQjRG+THN9J4g3Ur1Rz9vGhrvinkHu6poxU5YYCpVOWuV4TjKRB0VAzQXAH6mA==
X-Gm-Gg: ASbGncuicLEyUfHyGSxKbuuBhC6fC5fI0Lc8FwRJLXMbavoS/u9wGUwBm0DQdWU2+iz
	8f2KEyZwV7LHdsD604N0J7YO02KZWZe3s40es+7hyhUhhxVLOAb58oBXdiO2KJZ86lj4DAAzFfF
	GhUV9z/BwG+Yw3sHR0/DS+OcX4ezXdF1Ldqj1uZb+c+mNEdPKTO9+lecXVHTaSeoCiwKrctfTaW
	iikLQ++Lzf0tLQ1630k9NY26gRFQzxEvw2exWLHnVDefqm3TApQ3B2FmchaDTdYZavTgbYXy5ST
	offb9ITBeIxA2/8JCBTTjCGGTfcHePQElnmPbLufF2M9YGaIqtPdXJbJfdX66RypPyTgmBc8cNv
	anBZ7/wfddUBu8nV9kK9u6PUyYW2WpZlaJ+ebr68RhDkBnlynrEM0UnCd+dKs3Ogn2sdn01xROh
	jQdXqv2AmE6SUNcRtQSBMZ6EDzEexp2eP8pGzyZLJSuh+75QgrU4F9+OOPT7srbJctLsSeYy2o
X-Google-Smtp-Source: AGHT+IGmREpwD/o+qiNje5FtdF7dL6IEZ1MeuX/E6sXupShKP8CxREGvw0T3kRh6nTRBeQEUUcXNnA==
X-Received: by 2002:ad4:5de9:0:b0:70d:6de2:50c0 with SMTP id 6a1803df08f44-70d973509dbmr316089506d6.61.1756476789233;
        Fri, 29 Aug 2025 07:13:09 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70e57e484d5sm15997306d6.32.2025.08.29.07.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 07:13:08 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	willy@infradead.org,
	vishal.moola@gmail.com,
	david@redhat.com,
	mst@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: fix sel_read_bool() allocation and error handling
Date: Fri, 29 Aug 2025 10:10:01 -0400
Message-ID: <20250829141000.13795-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch sel_read_bool() from using get_zeroed_page() and free_page()
to kzalloc() and kfree(), and fix the error path to free the buffer
when security_get_bool_value() returns an error.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
Could likely just use kmalloc() as suggested but being conservative.
Double NOT also likely unnecessary since values are sanitized on
input but likewise being conservative. We obviously have more places
to fix in selinuxfs.

 security/selinux/selinuxfs.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 9aa1d03ab612..e90990c57bd1 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1203,7 +1203,8 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 			     size_t count, loff_t *ppos)
 {
 	struct selinux_fs_info *fsi = file_inode(filep)->i_sb->s_fs_info;
-	char *page = NULL;
+	char *buffer = NULL;
+	size_t size;
 	ssize_t length;
 	ssize_t ret;
 	int cur_enforcing;
@@ -1218,21 +1219,22 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 		goto out_unlock;
 
 	ret = -ENOMEM;
-	page = (char *)get_zeroed_page(GFP_KERNEL);
-	if (!page)
+	size = 4; /* 0|1 0|1 */
+	buffer = kzalloc(size, GFP_KERNEL);
+	if (!buffer)
 		goto out_unlock;
 
 	cur_enforcing = security_get_bool_value(index);
 	if (cur_enforcing < 0) {
 		ret = cur_enforcing;
-		goto out_unlock;
+		goto out_free;
 	}
-	length = scnprintf(page, PAGE_SIZE, "%d %d", cur_enforcing,
-			  fsi->bool_pending_values[index]);
+	length = scnprintf(buffer, size, "%d %d", !!cur_enforcing,
+			  !!fsi->bool_pending_values[index]);
 	mutex_unlock(&selinux_state.policy_mutex);
-	ret = simple_read_from_buffer(buf, count, ppos, page, length);
+	ret = simple_read_from_buffer(buf, count, ppos, buffer, length);
 out_free:
-	free_page((unsigned long)page);
+	kfree(buffer);
 	return ret;
 
 out_unlock:
-- 
2.51.0

