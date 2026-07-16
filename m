Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356FF43784D
	for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212536; cv=none; b=RJb+RLPeAjwQitAwmKtIise9vVz2Cvw4TF3mjJx7kUhoI0q60hoVEFeSdzQMfEW9dLKk1LGLAW8jLR8A6y7SzDw4EJaLy0u0ndfHRYU37GLlwBhhiuTai/XufpN26dDen+UJUSMCfn8gldf44xCes6KS09EBhCq4BNy8Huvsw4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212536; c=relaxed/simple;
	bh=1Q77QGi20jqHIyjTNiG/+eB8NfPR2aBxfuqk1+E17Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X4pJX9XwmdHPqt6yq2QnVzzQzVE8ET7Qw7CqflGZF0WDUr2O8izvvmeZqVpcjDMy8VWwXDaVHNsWWoio5qgC01q+AierB0I1enKh1jZtxedGN8DSFsCLYsxYA0Z9BFgibV855AJz+Ho4+2oXUrWV0XX1F4w7ANnMiDMN2G4fbNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mtpyw7L/; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mtpyw7L/"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e99ef0902so465987385a.2
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 07:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784212534; x=1784817334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fiYVzznOc1RkJMgbrUEgJ6HjRDthBBLFqVFCEa+Wsls=;
        b=Mtpyw7L/veXoQOxqlBRp0qoQu2YLKIiLwkbMmt6XYu8QvIh/2Ua9TKZOTHnVSmLyOX
         FiEX6fGnCydP+pUNqQ905esByXTShEr2ypOJFOwiSIOL6tbA2PzmnWIsW5lvg4WCV2Vq
         EP8hvehNtxY7B/l/ffu9DXtjJ7Dd8YNkjzJiMVcbhRvII1plC5JPR6xaw7xY1NhTqQp2
         Wp3qS+Fc+ITTtrNe/o1lcgdeNxBwbm7BSqb5UG1r0t2ReVYmkENTRpsb10reW32KVA2n
         pnrNP0wVkkYFO8KMTiz58+BE8VG9G6/xodWgrA3wUMnU915DOces7sVKFHv7GJ/PAFRJ
         wmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212534; x=1784817334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fiYVzznOc1RkJMgbrUEgJ6HjRDthBBLFqVFCEa+Wsls=;
        b=ZmpCDsgAU0ygn2kh10rnD6vv11Q6reii8ps8TszcfF2fuvpGIXJPGHYb5V4FlyxGSF
         /n4UalKkuUt67AEFsc8Zs2IkkO3/CpfrQzAar1RE3F9mcnOg3RguG9fTAvS9SLK82B0R
         ttvXXqNCbTxeoDcbMhIIUBuxtPAl3P9I2uJhnYR7T1PIX17TWfMZjJLJ87AMxSZ1xdcB
         QDhHBl1EwZPE+AbqwOjVUTykHIsy7ltIFEDMvDGA4tSwqggQeHNGt9Lc2AbXqojd1RBA
         2j2/HEx1qLnBrMA6ggloooEtfELlaM/c9TzS0aFDAv50P2BKjGd4dZBdl3m0RBaLEs34
         Ej1g==
X-Gm-Message-State: AOJu0Yw++3oJ3ryncvP8nMbbBHv9BlY8bHW55vwEaZqI0wgP/ZdPZLVc
	wIzSlATVzY87y3U8wkH9n1F2dqfeuDTebyuv7MSTNZqW8TJ5Yx5VE75hjp4VIQ==
X-Gm-Gg: AfdE7ckqsmYXq3FjTKU1/nWUJnd1+RtNvL3yEUnrRTQOLb64bIB90YIhWsFo9G5rOfE
	9Q0enCMwqDaO+UcGqzn8U3VawN1zX+asIO7wpOvP8JNE/ubE7V3PuTmFxorU5Yn4Ecr78nqixvf
	Kx8F8VmyfOWUkk+FaWadxvVNHIrI4CEYPUQh3i0y6F3w6YTRyJk2tQmXtV1HsA5Ve/6hr0MRIn1
	GG4n0g03Pl7CGqxPUsUzigXlJp3dwlatVZ3kTDEucy4eLcqwBdCqmjIa6kAuEgLXdkBcFY3J2z0
	9Lle8hdwIcr0TSqX+U1IknN0jXIz/3oBsAbNABaxSyd1S6gKMXk0UyOIp4YtvFTrSENgk5+9pr/
	CUU3VvtQz8gfVqiygi4cRpyF4I+iaDImgiWekHyWJwHe/CLNNa8/2+TMNMwsZEvSO2igcVaVsW1
	QHzdnSD8zH0EgPiSNiaErQbrBckUIw45vghFRIlVZ2LaGqChJbxeVy6PhxIvLpTglBKMmM8k39T
	DhWlQ==
X-Received: by 2002:a05:620a:1a05:b0:92e:74a5:c70a with SMTP id af79cd13be357-93086a621f7mr1165774085a.33.1784212528831;
        Thu, 16 Jul 2026 07:35:28 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d6dac4sm2018528885a.47.2026.07.16.07.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:35:28 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] policycoreutils/run_init: fix EINTR/EAGAIN checking in open_init_pty
Date: Thu, 16 Jul 2026 10:35:15 -0400
Message-ID: <20260716143515.8392-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

open_init_pty was incorrectly checking the number of bytes
read/written against EINTR/EAGAIN. Check errno instead, and only check
it if the return value is less than 0 since otherwise errno could have
been set by an earlier operation.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policycoreutils/run_init/open_init_pty.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/policycoreutils/run_init/open_init_pty.c b/policycoreutils/run_init/open_init_pty.c
index a51320a5..bd65c991 100644
--- a/policycoreutils/run_init/open_init_pty.c
+++ b/policycoreutils/run_init/open_init_pty.c
@@ -371,7 +371,8 @@ int main(int argc, char *argv[])
 			fprintf(stderr, "stdout can be written\n");
 #endif
 			ssize_t n = rb_write(&outbuf, STDOUT_FILENO);
-			if (n <= 0 && n != EINTR && n != EAGAIN)
+			if (n == 0 ||
+			    (n < 0 && errno != EINTR && errno != EAGAIN))
 				err_n_stdout++;
 #ifdef DEBUG
 			if (n >= 0)
@@ -387,7 +388,8 @@ int main(int argc, char *argv[])
 			fprintf(stderr, "pty_master can be written\n");
 #endif
 			ssize_t n = rb_write(&inbuf, pty_master);
-			if (n <= 0 && n != EINTR && n != EAGAIN)
+			if (n == 0 ||
+			    (n < 0 && errno != EINTR && errno != EAGAIN))
 				err_n_wpty++;
 #ifdef DEBUG
 			if (n >= 0)
@@ -404,7 +406,8 @@ int main(int argc, char *argv[])
 			fprintf(stderr, "stdin can be read\n");
 #endif
 			ssize_t n = rb_read(&inbuf, STDIN_FILENO);
-			if (n <= 0 && n != EINTR && n != EAGAIN)
+			if (n == 0 ||
+			    (n < 0 && errno != EINTR && errno != EAGAIN))
 				err_n_stdin++;
 #ifdef DEBUG
 			if (n >= 0)
@@ -420,7 +423,8 @@ int main(int argc, char *argv[])
 			fprintf(stderr, "pty_master can be read\n");
 #endif
 			ssize_t n = rb_read(&outbuf, pty_master);
-			if (n <= 0 && n != EINTR && n != EAGAIN)
+			if (n == 0 ||
+			    (n < 0 && errno != EINTR && errno != EAGAIN))
 				err_n_rpty++;
 #ifdef DEBUG
 			if (n >= 0)
-- 
2.55.0

