Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9D23793B3
	for <selinux@vger.kernel.org>; Mon,  4 May 2026 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777905507; cv=none; b=KSfVYOBaOVNQt/UO0rzi2VHzxyqXpZA2Wdbe0ti7p/kHU4CrkmYS9U8JvnTK54L91MGGLxctWFi3atevNNiWubl67tjUJO0THU3vikOBkLNPJA8Hk2WqT2BU+QxFRqcXjMIjZ8YD7WqCF33uaJLDfEj2z9xuq/nDbg5c/1JNxVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777905507; c=relaxed/simple;
	bh=15gJJI+Oc7EYJgwkyQmMaY1wYsg50wLa3PHpHe/I1ns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WXdooUrcHFt6X3n0ZTWDgyrNt5jHYV5VyLa6uGWXebF4ffOqqeC+VeDSoNuDebJH2mG230iBWiwJpN+98Vsn2EvAOgdz4W8i69vhg0+gSl6Il/cWumUvTn2qteG1XieFDTJw5OL0x8pKuDtUw9+XBjxMLu0eEbOeiXMFrcqRJWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXm3yaN2; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXm3yaN2"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8acb856a674so56967916d6.0
        for <selinux@vger.kernel.org>; Mon, 04 May 2026 07:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777905505; x=1778510305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JP7RcmaaQunZijlBUlvHB1uI9JlJAP195dfw8EeDpW8=;
        b=bXm3yaN2Oy4wXMYUbwgasfEW6yU9QLhQwGD3tuZXZLVQhkVSWV8HQXsvZqdI1YIBrR
         bTNj7KZ0gyi7uSVW/9xDxGoJB1fmajUGnJHqc9bUAMbIx6NVJHmc3hh2/g9pGJH7KnpE
         0E/qO3LiFZTHChiw9s2qJFmrFnlC69QL/A/IMFRqp8S7xAOhxKDwAprp7yUGlVqpRYjA
         dvgVe/aWOU76z7QFWlfu6uL9OXG8iWk8ZV+fp+y8YDknWlSGKjqEqQ7nyYdQQnxePqhc
         gK3JZf12aj+KAsq3RfNbOkXUwyJ+U6TtgDG6EVdu+pGFcVaWa4boEOh9ewJvtumVEMHL
         kzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777905505; x=1778510305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JP7RcmaaQunZijlBUlvHB1uI9JlJAP195dfw8EeDpW8=;
        b=V6QhMW7BOsdHNnGYmM9icOtQT1iKD7vAFkRkBL78lOjyc0uM/dWQOHSU/osSTujIjf
         hMRgvLewtgelawrHE0POtVar/wecf3yk6BcgzoiscifXjqrj0v/Pxllw0xoySDus4XLL
         0bR0iL+qva556fwAbR2/Zc8q19QKnVjKTwdzNJIJUMAv2oHq7o821aVdZmjhFIY4pxEk
         38kcpikN2VFfZCUCdAXl43Gah+OhyP9AH1uM2uD29k9t3yPPquD0h11IFKUTLO1ipuqE
         UU/LhiI85jMnij28PyMSIjhtn/lAZ3pn5GtQ3GWQJ+MhhiKQbVM4I7Mrn+1KjE6K9koA
         +KNg==
X-Gm-Message-State: AOJu0YzrhVoGr6UqU5N8+OtVJ2JSJftPgpyjSNS8EtHd3eAFshRNKYBL
	zQPSt/5IAE5F/+tEpwPcN2UDU8HrLWG6NxOqJT3/MtNZpJdePgffp5xYYz5RyA==
X-Gm-Gg: AeBDieupUdq24CL4vnQRm8oRc0Wy6f2kPucZWbJcrSnn4HyKGcMa2qJva/n17rBoZs1
	MK/VsDGbWUFfkOidGtgycEbREh23ythwvlBp8aUbHv3Sk5CW1qZTCgvVKk7CZpUmPiKuBgdQ/u8
	BqOuDg0bzHvdoVRKwclV/Mud633nfhXvimCwegBO7EtCKcyKP8aEqV/34h/YXmH3i8p8RxhrDTM
	y7V/PjN00/YV0EiLVKBKkKS0+HNYQYBgXqU2c9Lq+RBddDgi695yjtr+isCWDYmBIn3yaiMIWvj
	qlr0b6wPtdBztWuUNz1iHiLH9QdxHhLI1cb7o7kDmtI+pKBg3RXhZucXwa0yP/Iaf+/gxFD0jm2
	aOZjDIQk4rHysK/WkuKinI/90BKKCWIa35QzVYiStEf4my4g+FyS5aZx7zoe7eX9DdE7auIcaCa
	5o/yaIR2Oi5QdA8tHI6CITBHsus59Avq+J2sLsRWlsK3BRxst91l7tjTdantFpNjXF26MYTUy/Y
	UBrhvUbldX9gB0waJdnrq67zgspc6qV0w2jmUK4beaU8w9Gcg1PZ7TqfNlJHM+0cQ==
X-Received: by 2002:a05:6214:29cc:b0:8ae:7124:cd86 with SMTP id 6a1803df08f44-8b3ffec3317mr259396236d6.0.1777905504847;
        Mon, 04 May 2026 07:38:24 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b538b1d8b3sm136200946d6.1.2026.05.04.07.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:38:24 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: allow multiple opens of /sys/fs/selinux/policy
Date: Mon,  4 May 2026 10:37:37 -0400
Message-ID: <20260504143736.14135-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently there can only be a single open of /sys/fs/selinux/policy
at any time. This allows any process to block any other process from
reading the kernel policy. The original motivation seems to have
been a mix of preventing an inconsistent view of the policy size
and preventing userspace from allocating kernel memory without
bound, but this is arguably equally bad.

Link: https://lore.kernel.org/selinux/20100726193414.19538.64028.stgit@paris.rdu.redhat.com/
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c4a68d623d40..3fd9e63d505c 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -76,7 +76,6 @@ struct selinux_fs_info {
 	int *bool_pending_values;
 	struct dentry *class_dir;
 	unsigned long last_class_ino;
-	bool policy_opened;
 	unsigned long last_ino;
 	struct super_block *sb;
 };
@@ -360,7 +359,6 @@ struct policy_load_memory {
 
 static int sel_open_policy(struct inode *inode, struct file *filp)
 {
-	struct selinux_fs_info *fsi = inode->i_sb->s_fs_info;
 	struct policy_load_memory *plm = NULL;
 	int rc;
 
@@ -373,10 +371,6 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 	if (rc)
 		goto err;
 
-	rc = -EBUSY;
-	if (fsi->policy_opened)
-		goto err;
-
 	rc = -ENOMEM;
 	plm = kzalloc_obj(*plm);
 	if (!plm)
@@ -392,8 +386,6 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 		inode_unlock(inode);
 	}
 
-	fsi->policy_opened = 1;
-
 	filp->private_data = plm;
 
 	mutex_unlock(&selinux_state.policy_mutex);
@@ -410,13 +402,10 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 
 static int sel_release_policy(struct inode *inode, struct file *filp)
 {
-	struct selinux_fs_info *fsi = inode->i_sb->s_fs_info;
 	struct policy_load_memory *plm = filp->private_data;
 
 	BUG_ON(!plm);
 
-	fsi->policy_opened = 0;
-
 	vfree(plm->data);
 	kfree(plm);
 
-- 
2.54.0

