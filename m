Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEFA477981
	for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777574513; cv=none; b=cBRewBtA8gpqFdCpQhC0LMhhkQcHCuP/mM28BfQL5YqCA0LGIgNYuuNWPH8pawpCCypMwaZJ2GIvVh1lvb3NOUNazhfje94n3+v1NDk8J/zwrY+6w1IbMuUAYYiaQPprVleX3OcT9QNpxVS+YxJSED2ADCIYYczY2UdVnZ5Tv3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777574513; c=relaxed/simple;
	bh=s/GGy8+MJ9Ezpqc9akjkP6PXOMy4vI9QuMaNQPJmFNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oc/kQw9EtcZIrf8Y9sd0KHXu8n0dMpXN1BQHrguVQz3PsEb7X8Rjfj+GhT3f0xWp4pjvhOBBdYQyxsD6c2hkmILwLJjnM6wwiR719c6bXq3OqouLsHoAVmEXxKPI5vM7pSs+cHBE+jM3am0Xa8n/eBAE338iQ0zg5zMz/i8GrrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkc4nioR; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkc4nioR"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8eb5ad01402so133081685a.2
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 11:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777574510; x=1778179310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=INEGn37U2FYpqBwYygR3k5kN7Lv8e4dmkzF0VKnzodM=;
        b=gkc4nioRuIuY0XA3DAKE2u6S2vx/3wS4fJAwqHZ/QK7Id0TJJkYFj9ZEN6tAI1jRYo
         LSldp9IDNu6Sd0zTsyLJRX2JU6lCUJ3M2v9i/W917t0AdpEKMy4PBL4bfLMkXixkucyV
         bc75Ig/j6ceKpOQgshQ6alsMPZt6gFy8x3s6/KZmuw+jzbxVcBV3NR/bHEwM/Vi/NpDB
         tkxCL4BPQFRemmG8X2qzo8qNX/yF6gwNchaeARSljCIC5IjJbL7m6HwFgcdWPP4MLbfE
         KCQN+O4fqua6zslZQ/dWyA2pvxTwUBCcZ1eZS23vsIGQypPnl3MspUcvuBF4OunQmHlK
         znoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777574510; x=1778179310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INEGn37U2FYpqBwYygR3k5kN7Lv8e4dmkzF0VKnzodM=;
        b=grM9q4TZcT1E7ewnNgymlKPReCGmYnhBBpnDiTYsTbqs3SpO3cYft2eX7e1+D6WhsP
         evv1cf5QnnHbgmeBeMCu+JaW3xzO4ryORv1Mr+f8ewgSzPSp/mdhfPL4OkXediCb6VBU
         iLoN4ekQikpmmRkVb99QoU9JT/K66fz3/73CMnYQobcpSmNfVqZm4L8FBHvrEmFcEGwd
         cV2vVdWZ1rA4xDOzTyregk84thaE0BUoErwS5T7ifn/wTti0TV86PvZONKHa7BrFO40V
         3pY8/LVc59773uH37RuP3bYkj9Pm0Ubse3AXK3EfePgslwPBYGxc1CANTNiOhjxz0Zqs
         Evxg==
X-Gm-Message-State: AOJu0Yya6AWACJSvD8lQ02E02XbuEwaNiCqP0+nfGjdq7mIilCbSb2Dk
	KNotoNN8JrZroQHJwT6JYwShohT15IHHdocFk93fivBHT9v3QEyaPy1ZzZytOg==
X-Gm-Gg: AeBDievIbiRhbpaSJtmub4F9OeVeooDPTK2UZDxq+ubXXidfMmTKgC38TI5XpU6jwKp
	8zNAiG3bn7Oi1vgnjj/oYvyIBnUOG8NCuGZEgKxdTOfkSj4lCksKlcP/6Q/ICsY7XfIk61ELYkN
	KXCAqIddLVtXdzMcm38EBxHHEuMxut6UNdcFtxGhgaW/NpybaXbjlvHSJezEzqP46rtbwh6JA5B
	iibZCG43aKKV2wlyrpcHW+L7uQJ//TDuBmV718vaekI27rb0CcaHazft29UyBCHV4hEdC2Anj+i
	tW0DlbQ4lGp6eDddEB4r2WAJNVyhG09dz/2BFB+6c960KX3tbHBijeqSlI/08Eay7mBVTcPY6Mv
	ZITmEfhizPbvcJY/Xh3Nqkpv34xR2n8e1MxGzrdd1UWcRsXM89XdYAn1i9olM2BQMJ/mCzsv4pe
	+5SGOopPcmd5Co2IbHzeOu4ATpz7RGtxCOQSM9mUuJPm1YlJEUnA0nTFCflSHd8y8t9qPH20JR0
	DfGPXu91iAz+gd4wJAZjlLjuXVZby0M38sEOA==
X-Received: by 2002:a05:620a:454b:b0:8f8:eee1:9bf1 with SMTP id af79cd13be357-8fa862e633bmr615768885a.10.1777574510226;
        Thu, 30 Apr 2026 11:41:50 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3ff057fb7sm25505086d6.0.2026.04.30.11.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 11:41:49 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] selinux: shrink critical section in sel_write_load()
Date: Thu, 30 Apr 2026 14:36:52 -0400
Message-ID: <20260430183651.1707-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently sel_write_load() takes the policy mutex earlier than
necessary. Move the taking of the mutex later. This avoids
holding it unnecessarily across the vmalloc() and copy_from_user()
of the policy data.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 moves the taking of the policy mutex just before
security_load_policy() is called. This is required by
security_load_policy() to protect the old policy during
its own operation and until the new policy is committed.
There is already a lockdep_is_held() check for this 
inside of security_load_policy(). v2 also simplifies and
unifies the error paths, at a cost of not releasing the
policy mutex until after the audit message is logged.

 security/selinux/selinuxfs.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c4a68d623d40..d34649cbe228 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -592,34 +592,31 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (!count)
 		return -EINVAL;
 
-	mutex_lock(&selinux_state.policy_mutex);
-
 	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__LOAD_POLICY, NULL);
 	if (length)
-		goto out;
+		return length;
 
 	data = vmalloc(count);
-	if (!data) {
-		length = -ENOMEM;
-		goto out;
-	}
+	if (!data)
+		return -ENOMEM;
 	if (copy_from_user(data, buf, count) != 0) {
 		length = -EFAULT;
 		goto out;
 	}
 
+	mutex_lock(&selinux_state.policy_mutex);
 	length = security_load_policy(data, count, &load_state);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to load policy\n");
-		goto out;
+		goto out_unlock;
 	}
 	fsi = file_inode(file)->i_sb->s_fs_info;
 	length = sel_make_policy_nodes(fsi, load_state.policy);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to initialize selinuxfs\n");
 		selinux_policy_cancel(&load_state);
-		goto out;
+		goto out_unlock;
 	}
 
 	selinux_policy_commit(&load_state);
@@ -629,8 +626,9 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 		from_kuid(&init_user_ns, audit_get_loginuid(current)),
 		audit_get_sessionid(current));
 
-out:
+out_unlock:
 	mutex_unlock(&selinux_state.policy_mutex);
+out:
 	vfree(data);
 	return length;
 }
-- 
2.53.0

