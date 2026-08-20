Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92373AC0FA
	for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 06:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787206442; cv=none; b=pAFTibtJoovOveKxFXywLdP3JBPa0QKdKnIPya3y9r5TZQyWH2dmR1FqYgcRYSGWRIHi6swCgnjTwgX/MSxPjO2hI56E0qnVbuRSGbJPWNt+aC2c9l2sqsVH5cu+eBFNka/9aPh/hXHJihioiKobJPJgWzkobj19KBFjb9JG8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787206442; c=relaxed/simple;
	bh=5idfiA36NczW41si+OWGL51HGRsYJBjnWxO7ogXCc8M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bVjQSahS71mKv+V1oEpDuxUESmz8OeD3/fNjJDT3fRXQD2HvKlU8jUMe1XcN5H8CxFj7hql5l9TS+WbLzCSWJiFUy1pWJ53Emgd6ZcadlSSEoFGCXUULdoIi6E+nexCfdlBxmrnk51T3f7IWc5H85oBwOeqQaclGiDPyDVQ5yMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7AH9DAi; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7AH9DAi"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so21719095e9.2
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 23:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787206439; x=1787811239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+0zPOZ4cy1qU8zrYNcuVxcq7JUklUQqhNtrlV/MxG9w=;
        b=E7AH9DAi27mvWHXeWQF4pPTG34CIkQVMlXTwEpX059psgy3AeLgF1rtszHwT8LM6gF
         JpYRVv2kojq75qlK/voPyek23nZVE/GLYkm7tO567/s1a89KdohpXrWmqCfvkfQTnsjW
         P16plr8nwlfRaJL1wfxodV8RuiadRWSTqAkksPw8ENdlslmJmyAFiFXnEsh9Z+xDT9dJ
         dfUtl7khszq/iwm1UAqg5AgNa9vq82UWZ+me20UU41gotRzJ0TbvBrq249i62SFdzQ29
         Svvjs9lgODDmcYo9I0H/GcMrAG9QaX9ZrFJCzxPp3BeYGAXseJyDW/j1nts5ck6IVJ65
         cAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787206439; x=1787811239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+0zPOZ4cy1qU8zrYNcuVxcq7JUklUQqhNtrlV/MxG9w=;
        b=QAbhnTU/3LjQ8n77bjJd7/+dUH1K9bfYXLTFAH9OSrcwBdAn0JQjDTNyDJKz67x0zP
         TRUFFTmxwGuoAuHks7LxFhu7DISpBJUPMsqBQtmv09vWppAINWnbtImzwvWPKHWMZZDC
         NbKUvZyb8TkDZh2s/OmCa6FJ11/rnXrzwA6fJc4++aTw9igJWA1+HPKxUWc8NwOMZkM7
         RbyJ1QSpyCUYXUq5VU2K1gBoBEuX2h3wS4h2nNTMlJ8nBCZTgEWAqHIxdVYyKe0fKd60
         9GU7X2m4WlOk/TTpJWTfdPnJ9hKT+P7Byi2Wial8WohC59eC4HvM46ufg3lRTzh0o+nG
         HExA==
X-Gm-Message-State: AOJu0Yy/DN3mtVDhbZ2WqNn66d6fmMONHDZOqVQSrFk+TcbUTXir/vkU
	DeJLeLX3dT2VcTGFN5cxYESjgGcO9wteB2axFNsNKoaCbamY05oslVQYpdexbyF/
X-Gm-Gg: AR+sD10U4T/dryDAtGQlZd8y5b/v4NG0YuMVCF85QHVWP+LQJZtYaAlH50hlAajijw7
	q7bZFREHjVYYX8SugPiMi1MURYyhV5lMszAPPR3kFUa0t9/P4dzyZjqOdGNVdIjahCetumFtNjk
	pfA+wUM22Ya2ranSHp1clYNKryQZlFtThA3m26mLZhwVqxXrTY3Gxe6IEX7cOTSrfK9N+xRWsY9
	1asZio/ac3sq/dSNTBbpyA+HfsQo9IDJ7vTRcdbMFZzIirKNwYFHLVDjiq/uj/2SSeklX05DPqi
	jUAO7PLEUqZpSXuIncTUhp3fJKWV43qrFsFMX5NvmcNNs7xlqRXc2EgCSHtePZpZPeFF95QffHe
	rTf8/JBexR89JXW9e8NOvQVi/E8g0osTlxHc7/rmmKzAKftZnlAw2Vzn7DTujwq7yh4L+QxrYn8
	3Zf7nGXGl9aiG29tf0uSzd4Nw3LiaVow7WtSMqDtTIL8GdAVBqX0TOefvkEsgd7I2LUcgBy49i8
	Lswim+YLSUWsfFCurZxMmmy3kNvc0o8vCuhew7DYtyfwwiEmaeQizxMDs46DRw16Brso2G0do9m
	hyRGhohVwugFXujs3lOJagXObGbwJHS1V9momS8ryjEsLWF67L7ZC6Q7oKF4X9Hys0PuhiNaFaF
	0sb0=
X-Received: by 2002:a05:600c:c493:b0:499:7aa7:eaa7 with SMTP id 5b1f17b1804b1-499aa20c7b1mr165566735e9.15.1787206438796;
        Wed, 19 Aug 2026 23:13:58 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a476-1a01-141e-2b69-987c-d72d.310.pool.telefonica.de. [2a02:3100:a476:1a01:141e:2b69:987c:d72d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa17fc80sm129661355e9.14.2026.08.19.23.13.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Aug 2026 23:13:57 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: selinux@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] selinux: preserve user SID across nested backing files
Date: Thu, 20 Aug 2026 08:13:49 +0200
Message-Id: <20260820061349.10542-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access checks")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Tested on arm64 QEMU at fd6e2388a3ea with SELinux enforcing and two
nested overlayfs mounts. The policy omitted only
base_t -> mounter_t:fd { use } among the relevant cross-domain allows:

  baseline: mprotect(PROT_READ) returned EACCES with that denial
  patched:  mprotect(PROT_READ) succeeded; test exited 0

This patch fixes SID propagation only. backing_file_user_path() still
resolves to the middle layer for a nested mapping, so the audit path and
inode do not correspond to uf_sid, and that layer's mounter is not
re-checked. Preserving the full user path likely needs a VFS-side change,
such as having backing_file_open() store file_user_path(user_file).

 security/selinux/hooks.c          | 4 +++-
 security/selinux/include/objsec.h | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1ead2eee1944..8b96934e9992 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3849,7 +3849,9 @@ static int selinux_backing_file_alloc(struct file *backing_file,
 	struct backing_file_security_struct *bfsec;
 
 	bfsec = selinux_backing_file(backing_file);
-	bfsec->uf_sid = selinux_file(user_file)->sid;
+	bfsec->uf_sid = (user_file->f_mode & FMODE_BACKING) ?
+				selinux_backing_file(user_file)->uf_sid :
+				selinux_file(user_file)->sid;
 
 	return 0;
 }
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 3c0a16ec978b..853f7266ed18 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -87,7 +87,7 @@ struct file_security_struct {
 };
 
 struct backing_file_security_struct {
-	u32 uf_sid; /* associated user file fsec->sid */
+	u32 uf_sid; /* top-level user file fsec->sid */
 };
 
 struct superblock_security_struct {

base-commit: fd6e2388a3ea55e58cbbbef840c1d8aa2067dbb3
-- 
2.39.5 (Apple Git-154)

