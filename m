Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D14142E000
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695545; cv=none; b=eyQyrdWFSL+Le6U37G4uyqNKer+SJARK1+85sNE0OVzEOthychJBbtEsHKq5JULElTEw8/hLGPE4RaaSICm7PUqyJeZHcdnaOH8V9KxmdYv6gelqoEaVxDGqR0UGD7EP4jV9drWcyniTq9hS0fW45JsuTU7QbYYQeMBb4B4KElc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695545; c=relaxed/simple;
	bh=FE8A64iidfVw4A2IvmYWSV7KY9NgQ3FU4Gd6q/jNYtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bDrbYebKnm5bVGi3wnrArqcXiB2GGSq7EMlVD0gisbtxUb62AQxLwbN5lcC1ZN8jNdjOsd2+VxEcD/rh27cfTZk+HldFq0gRzfmOViVpfcof+jvm7bmqeagIT0Zrun4DVn0LFreco3WzcxI678aLSSVsC6ZbMp5kSrXmGa/HHvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlHEiF38; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlHEiF38"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56739adfa1aso4768797e0c.0
        for <selinux@vger.kernel.org>; Wed, 13 May 2026 11:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778695523; x=1779300323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uHWxc9xR0xx+1aooy6fDyaqeRR6HlXhTTExD4xHXTUA=;
        b=YlHEiF38RFdG8LkHiHd67pUrDkjGzZK6+6RRpTNkfFvfJCAc/ZZ92Ne4aJturuHF99
         meSD0DXHp981tPbUzrlc0d3ugknByePh8uf3Kznt+DpX59uUWyasicYDY8EZUIq702Iv
         romyh0XDLR3wUBJpHvtAsTDbDEsHq5ZqiJ8o03Iktb+k6buFZ1HEdHIyVS15vqtvohJf
         vs1qRN3wqpoZjCnBkdqWjgYYCVfYLzpmtoxlFbcikWiE/X98s7tSkVBOXHkIArMcBSqK
         zXracIwlQ/v0nQwdRx22FSgGhtOFpOuR0MkEK3OPncpAQ1l4ZTSFjllUy8CHkHmUIZB6
         t8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778695523; x=1779300323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHWxc9xR0xx+1aooy6fDyaqeRR6HlXhTTExD4xHXTUA=;
        b=PpfkhHOK368cEUq2FSy7gSELlVtpisIPps/mS7cH6whI1F5xZtc+TYlQanDWx+GKfG
         xvBzZ6rHFB6WjtDG2POWFjukdJH9tbIF22DxWdzn6fCUew3SqxqVZ/FNPvKThF8+5x16
         MGRdMl74XyAs1LDcD9eas82pQdT5qKh6UR38yqfY7JO+G3czdvzcVoa6QhJWORxBdSVp
         2Bc4Nv8koHFGvU5xVaqoeS+ytoyqlGN+ynBaRB7iow/dVsBC3RJ8CmFkD/YfjSGja01B
         EfPj/i7i2refaNWcC7HC8ObSscGDXWZbtSgN/zEkZq5hP2eftpB1mrBodSi8PXQRAB98
         jXtg==
X-Gm-Message-State: AOJu0YxJQYp1viKCKdUpajEyOrgphNHseHPM9/cTL+Af+Y+5ahqEuT1Y
	RSi5cQOS4GIcTOSGjofGDkCTGIqc98zeN31299VuT6JPa9d45SQ/CBYELJsuwA==
X-Gm-Gg: Acq92OHP+7V0jX89RMhkpzFKmGkhZ4hV2HKFA3rNEwaWsDqGSgplMrV9iOGG4yEng8S
	sPh0XxR3Dezffo2v3xUQJbTSW9NW5BDFCVD2qt9cg0YlVjQref1N3kVuRNJjW449hAsCu5V/tCb
	3+I/rqmIq0M5GRytuyEk4ni/mWyftH0He4MjsshXgLRhqQ1eBFFuKOyB5saLJuARygHx+gDLT6r
	yLyq5bDtK2GDKtQUV/gLY57gVkM/xlcznREDuSi+pwH0tbJuGjQBiMRfkyIhfRplTm+7ljoB1GY
	Yy4g+P37bRFecxUW0boP284HoIvR4GOF/005H1PqacC+3AES7W7D/+4woVvsmYJdTUC99RcjUyc
	PuP/l7iYG1dBRPHlkv9OdDemYtGModO8uso5AY+2lJ5mGzUXDgsB3c0nb2xb0INgPUy1NJce4YY
	Lc8l37Ul9U6OB/QN5lSrZeCemwASHryvAtRy6Z7IUguzP10bBIqEZDb21DXfTVMF3QfbtsdI81P
	cyJsmNkDOzsdK45kBMWaou3Rq/Bf0DlU5neKNEmuj413YxQlKkqY4HBccC/gRPVTVKBHQsgRTe1
X-Received: by 2002:a05:6122:6187:b0:567:4e8a:fb13 with SMTP id 71dfb90a1353d-575e6fc03eamr1897242e0c.8.1778695523093;
        Wed, 13 May 2026 11:05:23 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908562931sm2523326d6.3.2026.05.13.11.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:05:22 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	casey@schaufler-ca.com,
	serge@hallyn.com,
	john.johansen@canonical.com,
	linux-security-module@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] lsm: hold cred_guard_mutex for lsm_set_self_attr()
Date: Wed, 13 May 2026 14:05:06 -0400
Message-ID: <20260513180506.760657-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just as proc_pid_attr_write() already does before calling the LSM
hook. This only matters for SELinux and AppArmor which check
whether the process is being ptraced and if so, whether to
allow the transition.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/lsm_syscalls.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index 5648b1f0ce9c..08a017669c02 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -57,7 +57,14 @@ u64 lsm_name_to_attr(const char *name)
 SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct lsm_ctx __user *,
 		ctx, u32, size, u32, flags)
 {
-	return security_setselfattr(attr, ctx, size, flags);
+	int rc;
+
+	rc = mutex_lock_interruptible(&current->signal->cred_guard_mutex);
+	if (rc < 0)
+		return rc;
+	rc = security_setselfattr(attr, ctx, size, flags);
+	mutex_unlock(&current->signal->cred_guard_mutex);
+	return rc;
 }
 
 /**
-- 
2.54.0

