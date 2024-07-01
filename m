Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79314206C
	for <selinux@vger.kernel.org>; Mon,  1 Jul 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858460; cv=none; b=JrK4gu66cR4fUi2L+kLoWGwQO9WXC2x8+Ej6U2iN/hBVdY1qzjvy3VoGgPPciSRB6n7wac22zY/UhwZ6YXI7ksMMtj/7l1bkFWgG8W4Ggz1kY+CEOSO9nqjBdvAhoHa84rHrEiLRmlo5ADLU0K45KXmnqI2B7zYxpAF7kvZPUg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858460; c=relaxed/simple;
	bh=ge++MP9IylO/J4XgzRQJ7i3hhNbiH1o9zvEDsO02LFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gk7qIQcvYLcBI8k/Hsei9EMuYuOL4SnEXNmf0N3P+7DXMNuCBvLKKsNfsQDusUQ+QWIY3R3NZwKhIg/6FyinV/VMMa/qSnXrPP5j7YTDieYhEi00vho++BQPRYo4jNHPmu3Mync7Sp4c7T/2dl0rPSMjWzTa3VCiZvnsLoenqZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgnbvjjS; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgnbvjjS"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dfde5ae0aaeso3375218276.1
        for <selinux@vger.kernel.org>; Mon, 01 Jul 2024 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719858457; x=1720463257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nr4YjTB5DpmnxdXYsV1IiucrCCQ6YsV4lNFsa6ygUxI=;
        b=dgnbvjjSWE9FwwYzSk7lV9WLarTB/Kl7JVuR8Y5duppbyOLjrAL5sYFhWoBV6aortX
         J3x+/g+Vvc07eFzGSTK4RbibjPhhcRDsbYr23I9XuJbuf7L1OMmuo1T1nZcH7fljfGVm
         H3/94Oq8npICcEW5apqBvWGJ0JxYauHVNEGodeWsgpBiOcGqwEBTcTjKl0cxHLqZy4oi
         X0vGIAzdXRCnfIwxXZW2NDl1fpY6LKoCV/+bohs/bDCoXSY0U2vTcst3DeLcOU8Js3fi
         X18HwXgXasLOesGDoow9KU0On30QmdF2fLZ9hiMAWMjVRNyQXIe4mjVJ26NOWD/aAbpq
         sYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719858457; x=1720463257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nr4YjTB5DpmnxdXYsV1IiucrCCQ6YsV4lNFsa6ygUxI=;
        b=M6Phr3PCfVpjdSg1yIA+vFhynkGGlcFiB8mvxfrxzO6CeCe9Fxk5zBb6ZFY5x7h5as
         8w8skUY0A5HM5DdhY6feqJBaAxE13P/pGZ45Kfk5ivF0qDyiGWYw0ZSXfIc8+ZUiUL41
         KFWNtLcn3ztpefUS9JBXJsfTI+O55N5iCFuGCEbLvIa9A8SSOC5dsCg5dFvr/QoM7UqE
         HSZSpPtqLJqvo71mph6K3KwwEA84d4c3nB28EY+LfH7RjVhiNzFaef0ghIM/h0ZkY2yl
         tsRvj1eYRfRKrgcQ2Cy4fvugd8UkIG4Koe/rzhMTLb7orvlXwcRqk+aIjw3YC6KFqIHI
         EveA==
X-Gm-Message-State: AOJu0YyoDsliMd99oot4PiVrUfzwAqqBjoMGWk6AeEWPTxWcD0iPFgu4
	oWE1EFVKGxtzzPO6T1P0sRXuc4vmn/g1oaoGRVkD5gqr6elpSEB1LBWCKQ==
X-Google-Smtp-Source: AGHT+IH6gL5lpaEejCaSEYX2PcaoZd3vdcaeLCsAGO9ZeUMVv7CiqOf6iS/sKUISkdxKqmLKAcGaew==
X-Received: by 2002:a25:9201:0:b0:e02:bde0:f2ce with SMTP id 3f1490d57ef6-e036eb6c471mr7106605276.31.1719858456637;
        Mon, 01 Jul 2024 11:27:36 -0700 (PDT)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0353f5f30esm1418405276.57.2024.07.01.11.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:27:36 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] libselinux: Fix integer comparison issues when compiling for 32-bit
Date: Mon,  1 Jul 2024 14:27:32 -0400
Message-ID: <20240701182732.85548-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Trying to compile libselinux for 32-bit produces the following error:

selinux_restorecon.c:1194:31: error: comparison of integer expressions of different signedness: ‘__fsword_t’ {aka ‘int’} and ‘unsigned int’ [-Werror=sign-compare]
 1194 |         if (state.sfsb.f_type == RAMFS_MAGIC || state.sfsb.f_type == TMPFS_MAGIC ||
      |                               ^~

Since RAMFS_MAGIC = 0x858458f6 == 2240043254, which > 2^31, but < 2^32,
cast both as uint32_t for the comparison.

Reported-by: Daniel Schepler
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libselinux/src/selinux_restorecon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index acb729c8..bc6ed935 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -1191,8 +1191,8 @@ static int selinux_restorecon_common(const char *pathname_orig,
 	}
 
 	/* Skip digest on in-memory filesystems and /sys */
-	if (state.sfsb.f_type == RAMFS_MAGIC || state.sfsb.f_type == TMPFS_MAGIC ||
-	    state.sfsb.f_type == SYSFS_MAGIC)
+	if ((uint32_t)state.sfsb.f_type == (uint32_t)RAMFS_MAGIC ||
+		state.sfsb.f_type == TMPFS_MAGIC || state.sfsb.f_type == SYSFS_MAGIC)
 		state.setrestorecondigest = false;
 
 	if (state.flags.set_xdev)
@@ -1490,7 +1490,7 @@ int selinux_restorecon_xattr(const char *pathname, unsigned int xattr_flags,
 
 	if (!recurse) {
 		if (statfs(pathname, &sfsb) == 0) {
-			if (sfsb.f_type == RAMFS_MAGIC ||
+			if ((uint32_t)sfsb.f_type == (uint32_t)RAMFS_MAGIC ||
 			    sfsb.f_type == TMPFS_MAGIC)
 				return 0;
 		}
@@ -1525,7 +1525,7 @@ int selinux_restorecon_xattr(const char *pathname, unsigned int xattr_flags,
 			continue;
 		case FTS_D:
 			if (statfs(ftsent->fts_path, &sfsb) == 0) {
-				if (sfsb.f_type == RAMFS_MAGIC ||
+				if ((uint32_t)sfsb.f_type == (uint32_t)RAMFS_MAGIC ||
 				    sfsb.f_type == TMPFS_MAGIC)
 					continue;
 			}
-- 
2.45.2

