Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFF6299AA5
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314646; cv=none; b=mYSn4SJkXEgrsqfxwMD3YEKy3yeW8qpH6DQO/S0jdqzFgHzZUPES9oTQl9Um6VDEZH9PO3fM9SqlaEFGlW1MC3qLY6JbaiBfE5sI+HuLrVlOCJ2oYPa40eRDNrtDgsg+n0++ujf5cWon4YFfUlvCuv3cK0kqwJALH2jEvhCpkZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314646; c=relaxed/simple;
	bh=CnauvQSzOtSWhIruTKt/M4l+Rv7KGntopVXIsy9jZGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5EXsdqwh+BEZ4PdgmFrsqrma/Zp6unmV2IvOHhirl9cIabX62ygEMxVaITpL11Th8OkSWxdbD6x8QbvKwX7XKj3f6HLJmiWMxb0d2lQ6qbOIXwGY4bRZQ4aKsTyLaC0xCKbrCimyT6RnitVYrd9P6nipXAjULBc0NIhEu9qSpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8PSmSKZ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8PSmSKZ"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4769bbc21b0so9317501cf.2
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314643; x=1747919443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woT5JwWiakzP+h7IHpWXOl9PLrWR+M7xam4D9oU8hKo=;
        b=X8PSmSKZgp8xPh8WtiP4YrAeleURX4+hCgXSJS0GagMvxqQqGxL6Kf3bMpec2s35dr
         MCZlerTv6H/lfRJwPZ/fRkLmOM1cGk4sievTNQHqBO6Z0sj9OLguhOP2aIcStAX2hivj
         38Vuk64SZZ1rnFYjfp6dlHHKncfINGHRKNx6WXfAfXW4zyXya+TMaImBHAUXj+ViEMXD
         oWpLc13wk+Zv4+hRJnzLaPJ18vfpAOFedS86CbzSmzNIxbYxqv1j3W19zfy3d765BXEe
         RC/MmfJ5zXdNM9+cXIG+deSw3ZUNcc+1NwLd7pBVA5hsgJKDjvf4Tv27peFmDI3rWVmp
         QIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314643; x=1747919443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woT5JwWiakzP+h7IHpWXOl9PLrWR+M7xam4D9oU8hKo=;
        b=K0q9m4giw1dUPr+d/yvKeY7JDzwMMOJCeKpVhmQbOVebRfZdBtHKPxY8qu/IJYziGi
         r1NM1EoSJcCOHWtHK0f8qrrlY/rwxB8uDVWq/KO8cfWq7HLbCJytyWY81IT8DNrEVrxS
         j7ON1tjkb4zcQf/+6thO2Dye+wufPTn/6Q2fYpom16hU7AgW6KO2PlNfZ4TI+Qy6ARC9
         rfg8SiSpyxUM6Gcj23H0RWaTz0FUcsVZqa/1SHyUsgVtwW2ROEjcA+ExIieOXrk7GuBU
         ljJKD5ZBo1179cN1qIGF43JCyeKAcYBksj+lSVdjcaF+0g9iKfuOLMZNtokDWv1yxW3K
         ylfw==
X-Gm-Message-State: AOJu0YxTtCd5/tppZxCQ6rcW6qbhE2nDleJRS87S3LiZplhEnAhJ9U9n
	i1N+GJAijb8iBX1rwk3A5Y4KPdvAQngMSjvlQMLey+hxoLfDFYZkQa8vzw==
X-Gm-Gg: ASbGncswEofoQ+yo7G2vkOTCM+Ahq1HCBNBBmH6l7sHH/XgVe3d5mxETyEbQyEEKe2C
	Cw3HPgiRqRqyu8i4r1y9pzdMeCmBrlZWyOi4Y99AYl5IwnHXwQbx9NvXP3icPAliL5NDBgliv1Q
	CvuKT8CKDA9W2gW+2qqm5nPggTAzr0CFH3jiO5MjFbk1zS+ib0dz8DxuIbUftakybM3ruCJ3lm+
	vUlAonLi5z+A+f9BkhyCZTMNNDKJ7zj2xA4XV55R4Uyr0KWUrZ2ign90IM8C7eH63wSUKdHw5Tw
	gzAg/1PRVP+c89jIA9rEhh1utjjVCns4DMMedWTfdYRgXf7nbYtXLZe9bXRU+P7ovRTPJ0khgQM
	eNKy5hNgXqT0oSShpAdWd+a5yLmu6jw4KdG0/XczsTJlrB6P+drkxpA==
X-Google-Smtp-Source: AGHT+IFxwPvhb43w6HzcVAwEkC7srhYEx3MWi/QkWdEfjLbRaQovvG9kfPcQQ2tz6Necf2HI2F4NQg==
X-Received: by 2002:a05:622a:4c06:b0:494:9455:5731 with SMTP id d75a77b69052e-49495cadc2cmr102549231cf.7.1747314642986;
        Thu, 15 May 2025 06:10:42 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:42 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 32/49] selinux: limit selinux netlink notifications to init namespace
Date: Thu, 15 May 2025 09:09:30 -0400
Message-ID: <20250515130947.52806-33-stephen.smalley.work@gmail.com>
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

To prevent modifying the enforcing status or resetting the AVC
in the userspace policy enforcers, do not deliver SELinux netlink
notifications to the init network namespace unless they were
generated by the init SELinux namespace. If you want to receive
SELinux netlink notifications in a non-init SELinux namespace,
then unshare your network namespace too. Otherwise, just map
the SELinux status page (/sys/fs/selinux/status) to check the
enforcing status and to detect policy reloads which is now the
default behavior in libselinux on any kernels that support it.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/netlink.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/security/selinux/netlink.c b/security/selinux/netlink.c
index 03678a76f4bb..fb55d3ba25f5 100644
--- a/security/selinux/netlink.c
+++ b/security/selinux/netlink.c
@@ -70,6 +70,17 @@ static void selnl_notify(int msgtype, void *data)
 	struct sk_buff *skb;
 	struct nlmsghdr *nlh;
 
+	/*
+	 * Do not deliver SELinux netlink notifications to the
+	 * init network namespace if they were not generated
+	 * by the init selinux namespace. Unshare network
+	 * namespace if you want to receive them; otherwise,
+	 * just get updates via the SELinux status page.
+	 */
+	if (current_selinux_state != init_selinux_state &&
+	    net_eq(current->nsproxy->net_ns, &init_net))
+		return;
+
 	len = selnl_msglen(msgtype);
 
 	skb = nlmsg_new(len, GFP_USER);
-- 
2.49.0

