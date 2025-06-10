Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FFE24676A;
	Tue, 10 Jun 2025 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576217; cv=none; b=Ce5bvQQglibuEVp3xj8rFkKymgEO8hEDAaZmBD+fQlgUu1/rTfPssCB1zoB9/FX5j+WSq/m+6ngJ/bp6uBM7nOEn0gqynl1xbkdB6IwmaC/95Rb4es1gLAKQ8WS/wQ/zo0R+Oo/6p8OhEC4KRyuKOuGJr1zq3y16ZGsBOPPDLpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576217; c=relaxed/simple;
	bh=mOGDX97J7oPydwa9mkxx5aqzgviCKBjwnGibx9EpZBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ez754gOH9990JnRAjfhFfTEGm5/HQ6yej1Bc9pYWYOXnMl4xibfa/uq0hgwLI8nKCvZQTZno2DC4SV7NlSxjT/ZVqQGFH26m+3tSt0BPW0wLN7Zqn/hALrAshrZReI/0qTZPAgmLqpI0/cSJa536HRxHjIiLlGgXSxdidzbW6aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lU8U68Yb; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU8U68Yb"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d098f7bd77so8881685a.0;
        Tue, 10 Jun 2025 10:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576214; x=1750181014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7wrybr/Y1YisaCMiTrrVEfWzHGSHRhP8j7GfbuEVjM=;
        b=lU8U68YbbyFR7oFyWu0OH92JmBN8YIR+plT9HfT34AywvurGGUKnwVulzSZA9zLPCl
         YGmntEKUqQkDplfLjz3NcSX2+1obnkqynzVMVxxaZXwlT7MR58Aiq/XIseCDoWwaYxg0
         LieWElIbzEZW0L8fIzy2pJJKFS1qynWq8gUfBhiOLyu2E2HbX0yfie3Zgz+LiUlI1pet
         mHDmD6dLJnLmA8R4HBM1lgl5Mi2LegkW82CsjgvqYBwvqhwrLbOoG/rTvHyazkQMSyjw
         mUOG2E+ETKNvFL0yvcjzed4f8uFcm9qJHb6l6yaku/9JGQAoM/HoXzfxX5ir8l/fB29J
         Qz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576214; x=1750181014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7wrybr/Y1YisaCMiTrrVEfWzHGSHRhP8j7GfbuEVjM=;
        b=KGZHymj7qGXtJnkDRXeXZUddjBRcwAfPiOttOVawcDyPucVOB7ROiD3btVDpQLZ3XN
         Ci/Y2eQldb3rZPcM6KKYxosAzemrzVm836UI3coHaHh5/lyZOkI99H1QVnJeing6M+bQ
         pu9aiqOerudi5ZWLlOGjXXcQA5ISjIuzMW1Fj/BoGI19tFwcQEaf4pjGAISa8lLDSfLs
         EJ23lKYXpkDMfU84+3Oo8Zd8sycDLBUxCHhszo04Q6zq657XjWQ1EQ0mNGqg7ENrlhkx
         8XxU+RJc9HB/tOC6evzU8Gt7tm53nrp0xKq4mGkruGUbBIONjw+0AIcE5ci/FkdVM6Va
         vMJw==
X-Forwarded-Encrypted: i=1; AJvYcCWQOgRViZB4yucHsMdiRonaOcZjTN0/YuUAbUiTI5VfYmwH8sfpQt7iuWD9Ry9YfWptT2izkzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXi1gF0KVWS9UC8J4PwerPbIHh27Orr0t+4meiVl1aZ6xfFnKu
	ggtHubVpE4UhiOeO4VGfTn7ihaczFhDuLTqt5JTYDNdZssWvVTOMS6+twwy2EA==
X-Gm-Gg: ASbGncuj478yjclhTbn1hMmZAh0Ycip9i82obiuU1ypRJRE5MiMBtK6q8g1dpuS2MKI
	j+e2IW2aUx0phpDP7LdqDcpaNKHr9b6btBRBLQnyHwnJrU1XEp49fb6oAenPmSbZDOIJOsAv4v/
	e9y2YVYeZdAyqW7LEfNmbHNp6hhfibNhwO7slNygEbwjt3SNWOmIek3DfQUki0s4qSmIzFBM3XB
	4B7RkFoE6NB89JceYK+ZjO05JN4jejOv27V70P0bdYnN+HVAGF/BOppi8F2ZUDsaiGTQMxlyxxQ
	d2ToKGxhUXgZ/vUnhXTWLOXLhbrvMmczoKs8gY32MOogO3/warAqz2LOGRzBXBiwJz+mFjy2ayF
	7AngqsbKhpHcPTHL0A1fASawJ06cmx9Y6G/EXySK0HzF0ioXUAcY2Cjl3b9Qv/aLRwA==
X-Google-Smtp-Source: AGHT+IHDNECZri4tkAdl1JoSbHVeOblOX2/+Ta6DfZC8XwrAxV9NrssDmo7UfjOjH9dbnBpHrRLAyQ==
X-Received: by 2002:a05:620a:294a:b0:7d0:9a99:1bb1 with SMTP id af79cd13be357-7d3a8919680mr25693085a.25.1749576214168;
        Tue, 10 Jun 2025 10:23:34 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:33 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 42/42] selinux: disallow writes to /sys/fs/selinux/user in non-init namespaces
Date: Tue, 10 Jun 2025 13:22:13 -0400
Message-ID: <20250610172226.1470741-43-stephen.smalley.work@gmail.com>
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

Disallow writes to /sys/fs/selinux/user in non-init SELinux namespaces.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c7825db4e06f..7450ab7c92d0 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1371,10 +1371,20 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 	int rc;
 	u32 i, len, nsids;
 
-	pr_warn_ratelimited("SELinux: %s (%d) wrote to /sys/fs/selinux/user!"
-		" This will not be supported in the future; please update your"
-		" userspace.\n", current->comm, current->pid);
-	ssleep(5);
+	if (state == init_selinux_state) {
+		pr_warn_ratelimited("SELinux: %s (%d) wrote to"
+				" /sys/fs/selinux/user! This will not be"
+				" supported in the future; please update your"
+				" userspace.\n", current->comm, current->pid);
+		ssleep(5);
+	} else {
+		pr_warn_ratelimited("SELinux: %s (%d) tried to write to"
+				" /sys/fs/selinux/user! This is not supported"
+				" in non-init SELinux namespaces; please"
+				" update your userspace.\n", current->comm,
+				current->pid);
+		return -EPERM;
+	}
 
 	/*
 	 * Only check against the current namespace because
-- 
2.49.0

