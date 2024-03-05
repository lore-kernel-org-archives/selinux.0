Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D2B17C6C
	for <selinux@vger.kernel.org>; Tue,  5 Mar 2024 03:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709608352; cv=none; b=Gg8SdsdyG1HwW0XKHMQZq7EsJ/mY+f4weWzBPGOmgkLai5VZlBELpeLil1nu8dro3tfGjlxYLa9qTGaqNDTtWSPLBFE8HQjtG6h3787eYN4HvXrmR9BU2wGuiUo0nplMSU3orTpgXeekh0vGGyKMzMPqVBjR9YiAabMj/CQfD/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709608352; c=relaxed/simple;
	bh=mETkIxplab3WJUfl/cLMWdWt1SyNxXDscQxFXz2WFqo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rSeDEjRlkEYI4YdCduYxuZyR7Ouk8tJqkWiW3taiHJioDYbpiJmmOzPWvU9F1A8Xmx2COURGpqPbPmtq9ms4wmiRTdZREylZBRR/Iuiep/YsjM8zZ194H2IAEsIpE4vtek1hGwHwoqqYaejo0MH/OLZChizB7clE96FvrhXy3Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IagjrSQY; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IagjrSQY"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60989ecd10fso31737857b3.2
        for <selinux@vger.kernel.org>; Mon, 04 Mar 2024 19:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1709608349; x=1710213149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qPsEbMZBkQTzhgUaxWR6vDUfunfbsZqgXDQMSfg+Jdw=;
        b=IagjrSQYEL5nn2lhLoWt1IdPmHzTfKRNCXu+iYg7I9QPhBBjUg5iRLDSJklhd+c4RQ
         bkE7bnaAt1wcWeRNGmUAY49h9e/DzfwKsNNvkzkp2kRjg2LqqnQmRMn12e19XAsKZZZb
         rQ4N7Ni/Q9KJIzc0U7sfqbDwD+SC3p1ht1/jLz0B2xeDFEVV8iF0ZBzF9WFGhvOwipuy
         LVXY8PfqDNcaudtQuaCJ67onSIoT7ol1xn8DF4FmnolMZv9Eoqiy06qK4GxvdSopvZbY
         10qxVW1YAHl9Yij1L7QCAGkjNgCS2BzgqM7vcGZglJp83RHJK0qr4sQ3wkywrUJz96+B
         oypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709608349; x=1710213149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qPsEbMZBkQTzhgUaxWR6vDUfunfbsZqgXDQMSfg+Jdw=;
        b=wto2nZCNLAcBlghpMjl1rNq1FycMDdWaNPz0A7efaeQyt3psJKxA6dds/rCR+2E4jU
         5Y7rmSIIfXg3Orzsymb4nc4AjP4ffmC24v9U134pvWfxznXL/T4xeYzMPbjf+ph86bgo
         QLibiiHCz/VppCMjndJKVtGBBzRzluOpB7LXFlxUJuBIFsxokIXhWnwTgeODPojKZd+Y
         IaMJsDpGfYhTRiF5i+9f+ea9H5f0ef3TQ7GbZqynAMzCNXqDUUQbjWToliJJ2QuG2I8H
         vjWmBi3Aq29Ne9q8pQWMbEBiw2wgNCX1X5OWqBRWqh3aQsY6QybkaUvXswVdJ+5zzWIo
         WIIw==
X-Gm-Message-State: AOJu0YxRgKDFufNYOrkwM3QfyWk2a7Pj/iB4CqvvpLKWsPCbJMqfmKem
	9FrF/xvvbh4RGr4m7U1+k5uyp+TAslV3c2ZRIln92vWxVnx103AhJeUEua08kGf1od0X/+xviAA
	=
X-Google-Smtp-Source: AGHT+IHZD5/Fczd7tde+tzlCtvlWc+PrU3LlBipIVTu4uFKvF1wYorT4xgcrQr8ejdOEAayB/Rpx0Q==
X-Received: by 2002:a81:8396:0:b0:607:910c:9cb3 with SMTP id t144-20020a818396000000b00607910c9cb3mr9061207ywf.36.1709608349138;
        Mon, 04 Mar 2024 19:12:29 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id az12-20020a05620a170c00b007882fcb6635sm921023qkb.96.2024.03.04.19.12.28
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 19:12:28 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH] selinux: improve error checking in sel_write_load()
Date: Mon,  4 Mar 2024 22:12:22 -0500
Message-ID: <20240305031221.492421-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2460; i=paul@paul-moore.com; h=from:subject; bh=mETkIxplab3WJUfl/cLMWdWt1SyNxXDscQxFXz2WFqo=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBl5o2Vv9KiEagXRugAJMNWywpKu5sBbhaIYXyey 6yntPxJOnGJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZeaNlQAKCRDqIPLalzeJ c7sZD/9yBMOgDq3MAOqW6Syh8y1H96JP54tpu2mpyTaaZTXXSFjboP2/Gl3lFOmfWZ6TKA6ryFy OF6tWMaAIRpqO0tD3T9mzeHTcsr7PP47eKLvDXTSzKjklcPHxxtU1MGu5JpCzvJE0rso87Ngft1 7VGotx61jZK6s5pZXC8HEXk+V8YXt4XbQjriFFb3U5nCbZT2JRcH0pYVEWSbHK4q3cPfX3trkAC QP/Oh3nEDhZBetp0URS0EEe+37KbU3qH526QMDA4u6B3ep37w+8BKQuNCufgZxSSTsfQo7V4fOA N+DmIJnzPqHSQ8PgLrEfPbLPjdWeiT94cVHmilYWIGzXYKPp7O2EJ1uTvPjliYjrZdJhEx4hKfN 8iDmQxtOVPCVobzJllpVW9FbqnIh6ubWSzOy/Q1z7yN0FT+WczHPaF2lk6Qy+VZUI8fz7n6cLV0 BTB0guYB4tuO8tvW1zB/XqKLDhiiUEsYzPSCS5JTS5TdbQfR6IZ8n3eb6Ztgt+jXVVvxrbRWVOw 7PcDz1nYvH5RWoI7SRHjQ/Ra4OkS/n/RqZ0s4Ytb1ZUYW1gyUJnQMl80kemH+KXwKCNofZnEKFE s6/c8x++X9ZBqdNGDxQntXUaMhp9uR+JqplSRwHZk8InG69JtLbCxmzK/C8gdBQzYGnX0tbGTHo vPTqOt2YmVJEOOg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Move our existing input sanity checking to the top of sel_write_load()
and add a check to ensure the buffer size is non-zero.

Move a local variable initialization from the declaration to before it
is used.

Minor style adjustments.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/selinuxfs.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 0619a1cbbfbe..d18581d741e8 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -571,11 +571,18 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 			      size_t count, loff_t *ppos)
 
 {
-	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_fs_info *fsi;
 	struct selinux_load_state load_state;
 	ssize_t length;
 	void *data = NULL;
 
+	/* no partial writes */
+	if (*ppos)
+		return -EINVAL;
+	/* no empty policies */
+	if (!count)
+		return -EINVAL;
+
 	mutex_lock(&selinux_state.policy_mutex);
 
 	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
@@ -583,26 +590,22 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (length)
 		goto out;
 
-	/* No partial writes. */
-	length = -EINVAL;
-	if (*ppos != 0)
-		goto out;
-
-	length = -ENOMEM;
 	data = vmalloc(count);
-	if (!data)
+	if (!data) {
+		length = -ENOMEM;
 		goto out;
-
-	length = -EFAULT;
-	if (copy_from_user(data, buf, count) != 0)
+	}
+	if (copy_from_user(data, buf, count) != 0) {
+		length = -EFAULT;
 		goto out;
+	}
 
 	length = security_load_policy(data, count, &load_state);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to load policy\n");
 		goto out;
 	}
-
+	fsi = file_inode(file)->i_sb->s_fs_info;
 	length = sel_make_policy_nodes(fsi, load_state.policy);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to initialize selinuxfs\n");
@@ -611,13 +614,12 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	}
 
 	selinux_policy_commit(&load_state);
-
 	length = count;
-
 	audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
 		"auid=%u ses=%u lsm=selinux res=1",
 		from_kuid(&init_user_ns, audit_get_loginuid(current)),
 		audit_get_sessionid(current));
+
 out:
 	mutex_unlock(&selinux_state.policy_mutex);
 	vfree(data);
-- 
2.44.0

