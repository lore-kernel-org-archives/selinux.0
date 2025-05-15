Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC7729A9EB
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314659; cv=none; b=dSoCI3v1HJkYjbTFdUxtkxtBorfSCToHQxJG4ysJuwJSATkiow4HfRqF2YCmy0ybqs3Trs5FflcHLI7/47Fz1PLLq3swUHqe16jNH/kuxiA901o8+xZbTEsDI+aPXpzOaK5NRmJcEsMGJWaswqjMKomj+p/2bVViw9EG/o7T/dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314659; c=relaxed/simple;
	bh=FrN/tEVHq7bdNd4VkNKbBf1aIaebdqqt6QSP3ez7OpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTMQU3P3J8Zq4396Ik6y8pZDatW5XXre8z4TuTgfcDY68xpoTWhHQVGiliQwWYeXq4mTCZ76ZaHICuX74bWNNhIe79+0D4Nk0ROFB1HOBm5GN4stdBtc+YDOB/3spRr6OoANb4bZmi3Xe/8+hGLqYcrWY8yW+OGqAP5QMOvXaC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnE28ogt; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnE28ogt"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-231c86bffc1so3324985ad.0
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314657; x=1747919457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uh1h8SBbPmj5dakUkLKvZm9Ns6nmL6Yu4yUwsZY8SU=;
        b=XnE28ogt2WhLZ18XZCX8OsuXKf/sDngUGWWJLu5+fB5JzLQ+mk80A68CAiB9kC8Tdm
         lozFmOCq7+eYQCrhcjudRubGkrdSeoF8MzeGpGC+xE63CAASUluSRYDnRMgYIsbpvVFp
         vHcMNb3Em8J6O0pJkfw+PPBkFlEOe0a+6Tv+VTBvCgLV1CSXVEXNsiAr1DsbxKtaZGcI
         D0K3CXJ/0BQ3HsBaXmwUkW12o/2RA139ZiLtH8sTK3OfswRUBLlnB5CGUb5k4Ab8jISk
         2MEzsfVvoovyQaDlr67EtwrAvS3JUIguLQHUbMA/r/4g9onWBbifcD6DiUPZ8urXSKyf
         iUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314657; x=1747919457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uh1h8SBbPmj5dakUkLKvZm9Ns6nmL6Yu4yUwsZY8SU=;
        b=JexNkaWgShLvJZogTsyu46IwjTCsdKuDpG0ekC39ljl9u6MFPX1h4ed2L7M+XrH7+r
         x6Xl0s6PBXI3f0rjiS9s2MsdAD/QFC2OY/8WsF2l27gTQV3uq66RRUZFcWuexqL/aA1x
         kODQB3irFSfctS6Yv+rLwJtwezNX7U5KzJFEkEvA3M6cOH7eWUjIp3M8LbPh3BXBUOHV
         wvoVbA0dO/J/ofbfarg3yvc5kOKdPtEVUnxjmpwVLas3yJt+kjFS54gL7V7J6BJU6P64
         Dorm5g+XnOMvghmPAekLnAHZas1diqe43y1xO6n6yX1Ka+lmNb46P5UgCdZHO9khmbWn
         zwfw==
X-Gm-Message-State: AOJu0YyZVqZwddLBKVxdgyT95Fq+NdnwuqxNd4NCykNY+64EIxRvhZUz
	IWnz0MxmzcGSbVkKb2taIxZKVihQgJdrA+IZ5oCeMLt86rD1GUtYvjrcIw==
X-Gm-Gg: ASbGncuN2AUw11KoJnN9Kb08EU0iUBDscWns6ZB45TW7shatK22QfmmlmYf7Rpoxmjw
	yepTf1CUtZizBQyIsmCXI4mxA1b4wlGHFKTRVccpSJLwLIxKQ3LqRA2hoOskiYeOYu/4Gfwkqf+
	rsiN6+5AAsAFAb2WaZdlVzyCClVQHxNIQ1RMf8NkFjd0YO4sZMjFO1EnaHdcgAz/KGQIp4RgOnt
	W6ANqhQoc5SrKj9C2OzJPgMp75obskQeHLXhR6RDTPKcFWyusvJkHE43SMv6W5+tsW2XaUe9wFM
	pCHgbTtiZzlcefHK/UzCOP2lR2SrN1mQR/AL27ur3s1CpmPbULfAV8+kDhSFI1Itg1XoETuNq+1
	StLGnD3LG4OcVvnADlzwj+22+0Bk6NzCLCXbZptJZyjFJ32pgbqT3tQ==
X-Google-Smtp-Source: AGHT+IFlnX1l7xnt/4kmxbwEtpw0V1wyMX9m3PzM3DxpZtnrECuT08lxCyhAOPxwj+5p4L9qQaNd9A==
X-Received: by 2002:a05:622a:5816:b0:47b:4d3:5d12 with SMTP id d75a77b69052e-494a3674026mr50790581cf.49.1747314646427;
        Thu, 15 May 2025 06:10:46 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:46 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 37/49] selinux: disallow writes to /sys/fs/selinux/user in non-init namespaces
Date: Thu, 15 May 2025 09:09:35 -0400
Message-ID: <20250515130947.52806-38-stephen.smalley.work@gmail.com>
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

Disallow writes to /sys/fs/selinux/user in non-init SELinux namespaces.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 259502f4059f..831a326e79de 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1354,9 +1354,19 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 	int rc;
 	u32 i, len, nsids;
 
-	pr_warn_ratelimited("SELinux: %s (%d) wrote to /sys/fs/selinux/user!"
-		" This will not be supported in the future; please update your"
-		" userspace.\n", current->comm, current->pid);
+	if (state == init_selinux_state) {
+		pr_warn_ratelimited("SELinux: %s (%d) wrote to"
+				" /sys/fs/selinux/user! This will not be"
+				" supported in the future; please update your"
+				" userspace.\n", current->comm, current->pid);
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

