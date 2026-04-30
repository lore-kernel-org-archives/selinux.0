Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD8A3090E8
	for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567257; cv=none; b=hXZGZLZ4k5Wl23DnMgjJAyjGoLR4g5HdmWqrl4rNdmTVL6BKsdYviVgSTxwhmcQPzhOjWj+fnn4OE+iZY9j9LFUgmmKs6rS2r9Vi3LqKHB56W0XVetpmHHPKR1RaRAmGLCWTIypskRQcELj6hAxzm3mXdtLvh3XNiy6M7dGGp5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567257; c=relaxed/simple;
	bh=4MYLRsdht+57IRyDrxLm3U/KCyHHDHSkBVyhScr7roU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uu322jN9LWjXhdnwoiu8D3kvDseB3xKPSl4hn9W1SDZIe/nzPRQ9sXDklWOXlIjI75kVl3g5/4xciQo8mFhqGyJ1gDsf/3tlL41aGQsuzBqvbUEoHdOVzkyIW23P2hCx87z5FYZ+tkwETNSvjbMak36Qk5EGpREMsvPvID2UJTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRmwhNRm; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRmwhNRm"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e614fdb42so8421531cf.3
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2026 09:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777567255; x=1778172055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QlFlNF4DCmRd36UTqGW8OMgPCTdap6oZ+caPzN+jjyw=;
        b=GRmwhNRm+e5vR/hHzzT5lz+jzTq2GpllujeXt56suVqXIjUrmwT46/kaBvJnDcuwGZ
         abZmU2Am1e+eawzgiO3/vW0GbkEsvfLwgZ0/B4JPy7NDrSVeaP2Rpa2OdQZiYoHCcn0+
         p3dKNr0He2EwcaYH2LI5ly1tXu12DSI06qYoEOoIIsOqZ5wSsIPGXkBFL40lHtdigtqf
         KRhIFUDFvkEI0CByr48O5GT4qvelFl/l0Mbyl6mnVUjImwGxev1l9uU/7IRf2mXTi1d+
         oiR9HHWAIfD9YRJswfTw0kL0MTlLB7bEseb7hQpVF+pIFMireKd4TpZjo4S3dS57+ggt
         0p9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777567255; x=1778172055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlFlNF4DCmRd36UTqGW8OMgPCTdap6oZ+caPzN+jjyw=;
        b=OATNgtI9CwA2B8P0okkrd1QKKY5p64ZHJB2l9Ss+NxtbaV0NgfRpNRctCvzdWgrSlW
         GA5cWE+5SW+hjOMJmOwC716cPLhpbsnHfIDo7yujcVtw1jGXE/4+nJ3kbJ7BmwoPbVML
         dIGelwkjWvvmOeetdK+Ak1h5SBywAj/UAnks8eHOBH/slIjs0rq6UJoF+3F9HMPJzkfG
         BR1y2W8+1JupnA/ovcqBrG/FaclCY/26+WGEyi5/dVOyyWqIlh3HALCEn/DEMkgszAPh
         FWvTTy+JrEEB8Q3TQ5g3p5VtCF70p/m3TezdCfzdt4On5bgRHw4aymL7FfkIG7OkMdWs
         cuMw==
X-Gm-Message-State: AOJu0YxOTfRgyeBDl2XJ9T0nVntkro95KepGdY9/s3FgVsf8y57TKWc4
	A6Bfs4Ns/ub7t/DnKMbJwoE8lie46f2foBfonLvZ90vEOUOD3dOUCenhv1M8cg==
X-Gm-Gg: AeBDievjAr3J1pPBg/ROr3xRd9x50pyD/B3PtA8g8N2zGG6vkxcbPNjHkNH+TVFubMz
	TA9KRZUNI0ZH1UGRcZnO9UoDXS0dl4RpViE0pkrFyN1Nv+ak2VfKlAQxYDZ/d6sQ3oKGydjhTM0
	g7WK4Pu4XqpzhmCo4zPkk8rNPQiwLtXSwr4AtqjCU3AqQGn6a7RBJ2Q3RS+b9HBK7pOaxrVavpE
	WKO4bvJDZJ3rsWfoEXKEbeCV7GKbjkf3d8dmDYyv6P4OjjVAX22OkeFcM8eP12MCSVX3qv9Imkl
	sB+h71v24MLdrK8HxNQB6xliVnDVNX/SpewqRWyU75XZVeYsBfeUE/n0RtRT+GKPXTlHErcK/3R
	NDzy5ygMYE9JkXUVVastr30rmtwJjZ2zAF2dRr1XkTl5yv9ur/khLYxEGilADHmefXGoQM+oJ8Q
	fiRyALJi9luyV7GjwAwsO5UYScJRY98oWKYPPBgeuxJxsEWO/Zlz4vee5VvyM4tgsLceF0BqBOp
	ycmvc5EmYJern4WexWxeUDRxi8erk6UqhVcvA==
X-Received: by 2002:a05:622a:4110:b0:50b:38c1:c6a with SMTP id d75a77b69052e-5102ab342c3mr53666191cf.19.1777567254886;
        Thu, 30 Apr 2026 09:40:54 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5103b604e48sm2254451cf.22.2026.04.30.09.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 09:40:54 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: shrink critical section in sel_write_load()
Date: Thu, 30 Apr 2026 12:40:34 -0400
Message-ID: <20260430164034.1904-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently sel_write_load() takes the policy mutex earlier than
necessary. Move the taking of the mutex later and drop it
as soon as we are done committing the new policy. This avoids
holding it unnecessarily across the vmalloc() and copy_from_user()
for the policy data.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c4a68d623d40..df8181a496c8 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -592,8 +592,6 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (!count)
 		return -EINVAL;
 
-	mutex_lock(&selinux_state.policy_mutex);
-
 	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__LOAD_POLICY, NULL);
 	if (length)
@@ -614,15 +612,21 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 		pr_warn_ratelimited("SELinux: failed to load policy\n");
 		goto out;
 	}
+
 	fsi = file_inode(file)->i_sb->s_fs_info;
+
+	mutex_lock(&selinux_state.policy_mutex);
 	length = sel_make_policy_nodes(fsi, load_state.policy);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to initialize selinuxfs\n");
 		selinux_policy_cancel(&load_state);
+		mutex_unlock(&selinux_state.policy_mutex);
 		goto out;
 	}
 
 	selinux_policy_commit(&load_state);
+	mutex_unlock(&selinux_state.policy_mutex);
+
 	length = count;
 	audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
 		"auid=%u ses=%u lsm=selinux res=1",
@@ -630,7 +634,6 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 		audit_get_sessionid(current));
 
 out:
-	mutex_unlock(&selinux_state.policy_mutex);
 	vfree(data);
 	return length;
 }
-- 
2.53.0

