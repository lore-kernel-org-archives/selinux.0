Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D04289379;
	Tue, 20 May 2025 12:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742518; cv=none; b=m1SeZsIkFX+Eu8BD6dMcHc704N/bV22jFrvf53COsFOjmHIQxQX/g75T4uFZaMwvDMMglpKJ4s1JxyMTrvpCN8xruc8AevUFPB+3ZWLBkIPjUg7HfB0SGdkLGypbFPdAOppsyB/GNaZRRPKfIwfqEiTe9J6+4syaEmiZ6MuKGIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742518; c=relaxed/simple;
	bh=cQWSNCWUkJCJA42LQqQGt+kfAcb7XhnvSfoCNByqB+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJD4c2CbtR0ElKPcYf4iGC+S9O5PPKGoaNSMm+SVB4LVIxjTflcruXBHqydx6ysJZhL9LiisH9VGhUwLR+HSI0I6AxtIgrIfCXEsdP6Drlhr7zXcbsJ73Qfn7J77KLUWroKvmCUsSbjNTEONavr9pye+WzCMVx92By9fa9NznAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cax0RwUd; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cax0RwUd"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c9376c4dbaso614658385a.0;
        Tue, 20 May 2025 05:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742515; x=1748347315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JONvGkPzVzfa8JGoQaqQDwVGasCfJWC491rYm0LO+YM=;
        b=cax0RwUdqOd9FEixhX8jz9+lt3oPebVzUYntgL0FR74f0npppi6VXDd69M6+MVLRCP
         i3CLPxTT0vI75V5IZUUOOt35WpwIw0gVo227d8wipF9kKVMRtfNC7n0OduGsc3J2RDCH
         VxMzJOz8uP14CCxESK2us8L7204OA1e1z5YmUDwfWrCGNhhx2aFPzKeXbkMkIoR16CRR
         0bWeXIF4LnTFZ9CrS7iw5QOC3cyFP+pNpBJsztljWe3iaWVC0jRaSww4SDbRFYs66/Bf
         1G50YHPtjU9rdfII+GuXlUVOr0Cj8i1KvA0KK0L99OeFwvh8SXGwtbjnuZIzQFXUDi6a
         Gdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742515; x=1748347315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JONvGkPzVzfa8JGoQaqQDwVGasCfJWC491rYm0LO+YM=;
        b=TliQ2eU/5GIY+gHz6nXFZDSmmjvdRW+a/ZtSVGLSh6Wzh7RoAK0v/UfwY3rBKrugrd
         dix91MK19WeNVEuFkkFmEo4ZzQeZ2MfSBJ6yOVaYZhffBfBvv10XREAa9KPKF+HC6sGC
         hhS2I5Lg7SUWH7DXjXGUkk6tQt6yuiHDhUQeqsy3nBea3Q/lS6cttm4gMNy5hktCuBvY
         1GT3LhjLPikFEEAHgO22hID3xOICMU3iVZtIAbx1+nMAr0BRfFr0erdvAzKKl5rxYsKL
         XBDgEjhIDjfu8ccNxZWUz9YBdIA3JvAYmQOhvwSOzd2Cd7HqIQzhlL5dZeapRM07+Czk
         EMsA==
X-Forwarded-Encrypted: i=1; AJvYcCUO6uRBclaf6eZSt8tG/MPuwHLGfssMXlskytI1yPMrWkiyoO9WH2DT3kiXgFCbIF6ngq9ED5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpXpumfGXTbE6fN31pwpbfkMOmmKodi/aFfYItzieiPAaPVEf1
	HnmjJs5lv1qmsArosjp0xswBuKtc5shViZdqUaIKRfXiUrlQ3lDUXiD4GBiDFg==
X-Gm-Gg: ASbGnctOxh/Kq3w74th3gMzl1Lu/OrAo5BKhG+9Jf9x0Pa9Qep6ZjMdth+VQueZtMUf
	GsreShbgSUiFSscWexL5aF/EU67vh8l9veV6KkCNToVVeIquTkVvQPmG+aYsYLDRsTj2ByPI4lB
	VAK9a3lNWrX1iykJ1HFAilpgtlj326uHd4ZvQ5E58QvykIcB/gbbRMApDqI7+t+cjmvbRfvXqpZ
	fRaty6rPU6LT47EXrtrXIfaK+YZF1UtqwEILiQesy+JbPeFV9Da6xVIcJiXniC7zpPgfJweDoHB
	vPT/YgZ5Ry5jcYdsjXio6wpu4pSx2WIaJPB3pkm5g4sU3DU2/ZEZ2M4wjd3yRrUhoHc5YcbedH5
	FUOgeeJ8C23hjfv4exKh/eNFTR2++kVcfn7fCDDCraru6VmQUiERvmw==
X-Google-Smtp-Source: AGHT+IEFeSCsp00BqyUPke8BvG6eBfXQx6NywOp8XpyrrXixvSqQy/Wwp2sMwHioZ8YAyorjSn/hTQ==
X-Received: by 2002:a05:620a:2806:b0:7c5:afc9:5144 with SMTP id af79cd13be357-7cd46b6c97bmr2028934285a.23.1747742515216;
        Tue, 20 May 2025 05:01:55 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:54 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 40/42] selinux: disallow writes to /sys/fs/selinux/user in non-init namespaces
Date: Tue, 20 May 2025 07:59:38 -0400
Message-ID: <20250520120000.25501-42-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
References: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
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
index 8dde8f865dda..d165379271f9 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1371,9 +1371,19 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
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

