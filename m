Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA55A433BD9
	for <selinux@vger.kernel.org>; Sat, 29 Aug 2026 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788039189; cv=none; b=aMZ7t48cI31SoE0rb21MbD33j9eqNVBSqQCCAZ20TQgVVPGgA/+DgWz56HILaEgArra/jBPZnbNUIfqUAqrg3W7aWpnSps7y6FgFkSRISBX9vVZKdMJqqXJtQNpyMGUzqua44T9c/nEiEXUEtQJExEcu9GimWbdlYizHmIa3458=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788039189; c=relaxed/simple;
	bh=LO1QiG+tuqYXw1xkU6kH+n25tHtzPNegmiTgVWdxIs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RM/49vWDY+JvBkavH5ABLq1G5sBky87ZiAK6973iPFQqVvV3Ug/LZWrEPERDDc6hN+eTzqlszGIXxDJqAKdmE+1C3g1NmCnlqIWxiA66+BEtueZaaU0sksrsXW/l/BLihmhL5f9KF8W38YE9CwpegX1g3uoHnP+QcU/oIHq6QnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5pzNf96; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5pzNf96"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48436668d20so124435f8f.3
        for <selinux@vger.kernel.org>; Sat, 29 Aug 2026 14:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788039186; x=1788643986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XPdTmo/psYzNVIunLzBuzuNQ62GIR7HvuoO8VwCkzsQ=;
        b=l5pzNf96MTYV8/moSN0WI9ZuXaKDZa5UHbuy16V1DyGljLFlTwV1CHBrDnvAO8Qoc6
         e+C1W9+hDhu6kCQH3ubu3UbQZt451RX8Ep+8ULGqms3kUVVwTBHdILpGtJiHJGnZ8pwA
         35c/HQWRfteLGTcX9XtWAkMXAJeeDsJf4Y+UrLVhUm0chhLm/uLoeHpesdV8dIhJj8QB
         c9vj+O7T8JjfDTo050/B90yPDpAuhcXoSR1NbwafUI+pCQDpkYTqCc3vbnMuGgeJ4X7T
         Meekeo+ASAzUBPAG4ShXUu7sVEjvZ50qmnrspoQHEWXGwh07mTlzE68n0o0+atq/FLIK
         oAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788039186; x=1788643986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XPdTmo/psYzNVIunLzBuzuNQ62GIR7HvuoO8VwCkzsQ=;
        b=LnJBpMt1Y+qcnq4/dGSB1MJO2u+tGwuSZmuGbwOOze3L6jKkuWEmavlYGUgV+gRty+
         gsJd+yOq6oOvGoQCP3j9deAgA39fzHMqwNrtOaXRf1kqeTOqvDc0Cwld6sL5po4LhRlc
         zLLT+9kbNPa1bzg3HmiVUJyIA44JyuH/wB/FIKgjwMLjjLJjYjYC9Z1cN6y5LyiwiEIh
         5fzfX5F8SDzbWq0vl4Z5snSoJHY8UK+JIkE5CQl/49P/vHiukBbLjVl/8sBxdq/G1Vtu
         Z+UjdGTZ6Tx6WKdgDNs9NXoUsVjxtRR0ORxdoPaAmRELGZPA4qwHxNLfu7BZN6IpMn3X
         DLkg==
X-Gm-Message-State: AFuF++kmFmZDkXCLw/YnDUDw5yGIb4f2gr/Ou0zdtAEW59B3tqOVkk5C
	dOV5m5qvf2NfnRGozs6NSfASDbwNYHblb3mp+f+nhssF+gT0Twa42K5w1Z/agfuv
X-Gm-Gg: AYBFou0o074G1DOdUdEu+usMDjkCjWZ3hN2ZOBY5DQfAqJwWA97+gOQ4Y8klmGqh5ZP
	lPIB3YzuE371EyxpdMhBO77b+K05rD+ZRtq9/6RxVvAt/3RdYxy/pqe66jIP4Z/Ka4JcSOTF7a3
	xbgnEGLXzsOv8PbtkpZ+vEzMEPOaEltTGyYlvS9zpI7m0mcOWmjHNYTGJQksTn4ZZZ0nv/DaOqy
	m+Wg9z1yjWvx9YU0LFwRgjgl37dk3p/fE/CC4QPKDjsG135UXj3CfmBMPTdK/5f/KOVjzTWYzKN
	U8TsEhV1ZObXC3qGnXK60YSLe62+brOCfiY4lSezhWMgDn8qHaA+NIdScMRilOhV3D0qHIONbix
	wheaAT2baaux8oqVJ+S5rIra3FORXdJTDxpdTvw8Z+yIhCT3QBSIwRFeGjgs/EjJrW1BvIXpCTV
	GyEP45z25Ej6qith4McwVxOBsXorDzvlNCtLYhcvmDB3VinklMznC1IPCE3GmBku5PrImV9bxYZ
	m9eQ9h8xJQs4bMlVO5T/8ju4Z5mUmOeGv32r8wpYpKtDlWdKCtEkW6M2hr7Pzu2cPsHZNlWMyie
	oc85wqxPsDONTX/3gHuTzQwNwQWfRq0Mttax3Q06uVZ9cf0srOzZumLe1h0qJEiqiT8=
X-Received: by 2002:a05:6000:41e9:b0:484:3621:6340 with SMTP id ffacd0b85a97d-48436216a9bmr3184979f8f.16.1788039186041;
        Sat, 29 Aug 2026 14:33:06 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ae86-1b01-80e2-8851-4221-68d8.310.pool.telefonica.de. [2a02:3100:ae86:1b01:80e2:8851:4221:68d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb33070sm12540616f8f.36.2026.08.29.14.33.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 29 Aug 2026 14:33:05 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: selinux@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Baokun Li <libaokun@linux.alibaba.com>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] selinux: preserve user SID across nested backing files
Date: Sat, 29 Aug 2026 23:32:55 +0200
Message-Id: <20260829213256.51527-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260829213256.51527-1-kmehltretter@gmail.com>
References: <20260829213256.51527-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SELinux saves the user file SID in a backing-file security blob so it
remains available after mmap() replaces vma->vm_file with a backing file.

For nested backing files (overlayfs over overlayfs, or FUSE passthrough
backed by overlayfs), user_file may itself be a backing file.  Its
fsec->sid is the SID of the mounter that opened it, rather than the user
that opened the top-level file.  mprotect() then checks fd { use } against
the mounter SID.  This can incorrectly deny access without a domain
transition, or check the wrong target SID after one.

Copy the saved user SID when user_file is a backing file.  Keep using the
regular file SID for the first backing layer.

With two nested overlayfs mounts and SELinux enforcing,
mprotect(PROT_READ) returns EACCES with an fd { use } denial against the
mounter SID.  With this change, mprotect() succeeds.

Tested on arm64 QEMU with a small BusyBox initramfs and a purpose-built
SELinux policy.  The original test was also repeated with Fedora Cloud
Base 44 userspace and gave the same result.

Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access checks")
Cc: <stable@vger.kernel.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 security/selinux/hooks.c          | 9 ++++++++-
 security/selinux/include/objsec.h | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 035aaf113d1da..232b7e7bfcafd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3843,13 +3843,20 @@ static int selinux_file_alloc_security(struct file *file)
 	return 0;
 }
 
+static inline u32 selinux_file_user_sid(const struct file *file)
+{
+	if (unlikely(file->f_mode & FMODE_BACKING))
+		return selinux_backing_file(file)->uf_sid;
+	return selinux_file(file)->sid;
+}
+
 static int selinux_backing_file_alloc(struct file *backing_file,
 				      const struct file *user_file)
 {
 	struct backing_file_security_struct *bfsec;
 
 	bfsec = selinux_backing_file(backing_file);
-	bfsec->uf_sid = selinux_file(user_file)->sid;
+	bfsec->uf_sid = selinux_file_user_sid(user_file);
 
 	return 0;
 }
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 3c0a16ec978b0..853f7266ed189 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -87,7 +87,7 @@ struct file_security_struct {
 };
 
 struct backing_file_security_struct {
-	u32 uf_sid; /* associated user file fsec->sid */
+	u32 uf_sid; /* top-level user file fsec->sid */
 };
 
 struct superblock_security_struct {
-- 
2.53.0

