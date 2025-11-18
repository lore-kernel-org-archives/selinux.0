Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1CB35BDD3
	for <selinux@vger.kernel.org>; Tue, 18 Nov 2025 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480833; cv=none; b=QGAx/bN4sInEIeronqP05a6pCGo1TvapDrf0Pjo5QhaHBhVFnU6sYpyXbZm7RMMo6hat36uNZPDv6WhZp5BBppYJuIOiLOcezSgqWhEOXl3bdJwqCiBBK9ZB03zoKZiaaARTh23VFPjt85XxdOZ9hCa2YNsTBNK3Sb80wliJp2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480833; c=relaxed/simple;
	bh=og5tQlUASlGUugUnXfvATxm83RPwNk6Z/mMuWghBu7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFFCiQwsy0U6bUToviAVlJlxw1EfZedOyTn8446SnbKvUMIn8nuR4JNv8PvljpDOLQfSHrf9xIQmlZ/k3mPBqjvF0wulHDELSLli3IuEQyNd0ZUkv6a5JRJhMJTfVVFoJ7bo/xlqeidnvJFLshGF7oA2Ect29NPXCtHtDmE21Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAC1gvNb; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAC1gvNb"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b21fc25ae1so561316585a.1
        for <selinux@vger.kernel.org>; Tue, 18 Nov 2025 07:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763480831; x=1764085631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaYTtEucY7fqPVYQJL9eKMoyLRsO2jawwJ/ol8KmkVw=;
        b=dAC1gvNbaSMQq2GbtFecnRwnkHw6PuS1jDK0YdTDdsVzKKJAMCBj+t0jjioBBNr7dz
         mp2JeZQu0HMtlMKnfrOhkSMiQLrnDc7c2O2+JP37vvB30YuoqdkZC7UaODm/DGXeVDjM
         cLXW0Z15fNraNZN7aiFPnD9ngOMK2dZV5PJTQvB/oM3WM/YGDEaaKvwkn/sbwGGmdZs+
         eXHl/nbIAtAW514G+bn19ZklBWAMVRMfLk8k9RavOy4GSjVrndoybRj8fDcw3Mwqcpao
         4A0b6JFYOY9auAsQ914OT2mkOhhYsK2QASTpe3mIAJ31UMARvgXzlhbSoSnXMoEPlgvg
         Ixtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480831; x=1764085631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eaYTtEucY7fqPVYQJL9eKMoyLRsO2jawwJ/ol8KmkVw=;
        b=C68+pBLJ0R7ECm6O1KhbFM5g5VpJRsBFlVQRjrDFigQxtD0Npkomv6+dwy4aYov6eO
         C8ztnTbMbCftG5BFnn0jUi+gYT+NTYyYsXYRKNaZnudnRtYxaFIfhhaSet7tyFhToU9D
         02M5SzyzIqsN71zW0Rw4lw6UscEhXLEDn/YRZo6rKFipqaMFfyIjheBU+ROUjRBQ9vk0
         pjTbV0foD65OdRiupiFjthdNAoZAGkXyufsr8vDmcxWcb8IJm/97AKwrS0ChdkebJkCI
         x6ITIxEr9VFIltuvGLdjaq0Xb9UBFBzxmXKULLzDJhXZgX/I0B1Vi0M8I2e3RoGAYq51
         L92g==
X-Gm-Message-State: AOJu0YzPEa//jJWtP4dR0Q0cF0fiIKoowyufXHaC6gWZaT3HgnA7xxW1
	Ik/YrnbjDq5q0zO6BiEcuIcaZwRwPOwsk8eO/XxNWMF9st3RtsLeGThhJS9KaQ==
X-Gm-Gg: ASbGncuwwmEPLsBioqmRCzja9iwS+rIgO+hEJHZsAvxVGq6GHOL6Edd7TUUzuvZpzE+
	3YKSFtFYrdCq2CRWuSXx5c3P3qVls3zQ/rvBx8zcwlgLPFHRHUIN6eaMqULZ9LrE/teyMdXlZVX
	3Bs3Olp1nWqrOfkyXNyLJ/uGfAbmqzsE5MTA4WuRpRKvHxie096JzSgocUM7D35+COKZ6Rwcavz
	a8iCwG81EPM+1lIQbdwKMY7rqNHClIiPxaqvuS5RAohGgVgRlzHSU9nHuA0Yoc2NLoulLlYB0zN
	FCMkkRSK6nOFjx0djUHE9ZRWQ+bLOMDszvLxgVqE9Z7xnxTnUYx48fgvCxco/ggPDKDf1bgsqER
	NTwOKe1wkHbwY/Ll5v3yDvLyCX2/RF+Tg22rs3a9v9SWzK+JfEmwdDoG3b5cZtQYuXLT1y4P5SU
	wQnmn5I+293IAHqrg5IODXYFGOHP01xONs8Va++K8prsJhshrFtXjQ7N9HX47budw6GWWxDyYZR
	elfZcURQILlhsYUMVYJH/owyw==
X-Google-Smtp-Source: AGHT+IGGjBNpkZWJQ/pxPnIX0l4ZVwyYuwM7ZJv7IAfhJUbtOVXQp7OtdH0hNQ4u1+Da023ygtLXXg==
X-Received: by 2002:ac8:7d14:0:b0:4e8:b980:4792 with SMTP id d75a77b69052e-4edf20b16b1mr205696521cf.37.1763480830828;
        Tue, 18 Nov 2025 07:47:10 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286312406sm115911066d6.19.2025.11.18.07.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 07:47:10 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: mertsas@cisco.com
Cc: selinux@vger.kernel.org,
	paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH selinuxns 3/3] selinux: ignore invalid contexts in kernfs_init_security in child namespace
Date: Tue, 18 Nov 2025 10:46:47 -0500
Message-ID: <20251118154647.14566-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118154647.14566-1-stephen.smalley.work@gmail.com>
References: <20251118154647.14566-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernfs_init_security() tries to propagate the parent directory's
SELinux xattr to the child (or compute a transition, depending on
policy) when a child node is created. In the case of cgroup2,
this can cause a hard failure when trying to create any files
in the cgroup2 mount for a child SELinux namespace if the
context in the parent is invalid in the child. Treat this
the same way as if the parent lacked a SELinux xattr and just
let the child be labeled based on policy.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5cfb7d8106fb..bdfa97e32c67 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3830,8 +3830,13 @@ static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
 	rc = security_context_to_sid(current_selinux_state, context, clen,
 				     &parent_sid, GFP_KERNEL);
 	kfree(context);
-	if (rc)
+	if (rc) {
+		if (rc == -EINVAL &&
+			current_selinux_state != init_selinux_state) {
+			return 0;
+		}
 		return rc;
+	}
 
 	if (tsec->create_sid) {
 		newsid = tsec->create_sid;
-- 
2.51.1

