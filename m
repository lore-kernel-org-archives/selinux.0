Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5933F44F6
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780345759; cv=none; b=ov8xarKKAiIecabU0PBFm1pT2K8ks/zQET5NF3Y6lm2flnay6BGBEXZqhVhMEsRE63otS4R6rIRr8lj96Fwok/78fzxsrXbcHDotUetP8zIMjjVqRl7U6vkV4+v0VLOMzxy+0kai59Dwu0o9sk0PwWhC5p0RFMV7os1NsT10Zt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780345759; c=relaxed/simple;
	bh=klbNdC7cfIgWIGDJw7QxUDyLLjUiO/IQRAMalru43Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FnMEW6m0qskz9lCQoL4YqLCx6CR3gFwI+DlQ5wpr2h5HBS7QCX8SgAvIETWNIW1q45LGFH2UqDnLiITIGxU8SejK+9H8fG6PAYMDq6LvB1uQZl+iM2DsmEQkkoki3YDkgjejGLB+CMTtUWgVnsUQqQNS+rpNlFx0HnKDcMJpGLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qmymQq27; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmymQq27"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4909e3fa4b2so34772125e9.0
        for <selinux@vger.kernel.org>; Mon, 01 Jun 2026 13:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780345757; x=1780950557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LmKuGESMYZ5+Ju4vxu+U0hLQEDKMalB9oV89YiAtJpU=;
        b=qmymQq27x53o9JNXcfDsU8QXYy1mQVrE7cb4baGTnbLX9NwY55QI7Mu/rGk10QQZYP
         4SZErDDhZ1zxSHw+tdaLSGnAi+6IL/+6xlzjpMbtOedEeBL73SfADTa37iKBlN0jutg0
         sB8N7gDynxxEhgCJxnv7uKxqp3BB+XZ85PE5zJvXD4Z3CZ6ZAj9v46BjelpITsRNGDXx
         aqM8hwIsmpd5R6ncedRneAykD6N62RzVN72FaNnRa1Zn1H2luRJe+M5NJInZqVTCBa2B
         QbTQ4CMymCs5PRgK7HDOiNX5ICJzSQeYBTeETdx/hoE6pJ/wQ/ghtzct0L8OTQBXIepj
         Ut/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780345757; x=1780950557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmKuGESMYZ5+Ju4vxu+U0hLQEDKMalB9oV89YiAtJpU=;
        b=m/EW73OobunIAHa3IPfrcfX+6iav3Pz1dNTewYkXz1Esz8okFnv9/N5BjhMI1I45Jb
         UlB30mzfSKvb90NxR2bezRSEg2pfvnsGt/+HAnuw8KeVASUYYIihfwu9IHI06vufEKQd
         /PjILibb8BvUeNXJS63qqr9o708uwXjScK/jASdzmhBPVXOkCavPasZ6tHfVYG1c9Nc/
         03ChUXsZzsrAZqGpH0YGlR9wq9NGYGif6XHIyAKZ/7RJNFlk8MH71JPl6qSHmXpoprfW
         vXraPEzGBWgxO0s0NcLgqhjSicTDaujpgPxawwr1ZGgJ7JSPUyIMEkiQtYb8dcVUjzs0
         F3rQ==
X-Gm-Message-State: AOJu0YxIpwxxzsilBF+rvIGuK6rnPis5zG7g0CTO/5JZ8njTo5obzMea
	eH6J7BCMK3bcq85q5MCWasqZXchi7Mj2OVn1s0R+vPDt/wwZ5O35TyUm9iDk5g==
X-Gm-Gg: Acq92OFlFTSJpBoV9MoF6wCRUBiLfW2Nq7UnitsoMUqtZQpIIsMc9UWsm+Jm55wQJyf
	YVSZYccP505XSS5onWdRSJYlUto9/sUkDw+am2/TzVeoteOPx+Z6OrTSL5nrl1PWhT87XATzgMh
	cqaBw0wb5TpITNk+bqI5WV5zTdx040kkENTiNjRY04VKcOP/rFiSGKz25xtNsdSuKl6Y9Rmhvrf
	2wdd04+x5dy5CGpdEUHBfphGULJ3hdWkzRClnBKtWG1usgyX6Opk5Bzy6yJta5woYqgHTXel8x5
	5CmqKth/It9cPlz3x7jnwwGEoPyH5CG3n913BJE7lWE2xsaBHEIxwZdkFLzGoglqSSCRXyEjyiF
	gOKcKZcKqGpbZigKntyU11s4gcQ9yBN3M/sf3BL0bOj7aqCeKhxnivfAECqo84RL76T1al28B1O
	1B/MidhrpEgBhVMFJDnuYSIw==
X-Received: by 2002:a05:600c:1992:b0:490:adb6:793d with SMTP id 5b1f17b1804b1-490adb67fc0mr69880515e9.26.1780345756539;
        Mon, 01 Jun 2026 13:29:16 -0700 (PDT)
Received: from nz.home ([5.80.177.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e37851sm16966725e9.13.2026.06.01.13.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 13:29:16 -0700 (PDT)
Received: by nz.home (Postfix, from userid 1000)
	id 6302545E4391A4; Mon, 01 Jun 2026 21:29:15 +0100 (BST)
From: Sergei Trofimovich <slyich@gmail.com>
To: selinux@vger.kernel.org
Cc: Sergei Trofimovich <slyich@gmail.com>
Subject: [PATCH] libselinux: drop long deprecated `-Wstrict-overflow=5` flag
Date: Mon,  1 Jun 2026 21:29:11 +0100
Message-ID: <20260601202911.1676130-1-slyich@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`gcc-17` formally deprecated `-Wstrict-overflow` options in
https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=b31a43560e88600d412318f75a43ac8e562ba8c5.

I only noticed it because `gcc-17` deprecated it slightly incorrectly and
started to fail `libselinux` build: https://gcc.gnu.org/PR125558

While it's a `gcc` bug `gcc` devs suggested removing use of the flag.
This change does the removal.
---
 libselinux/src/Makefile   | 2 +-
 libselinux/utils/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index c62ad1ed..373a6251 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -65,7 +65,7 @@ EXTRA_CFLAGS = -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand \
 	-Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const \
 	-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init \
 	-Wno-suggest-attribute=pure -Wno-suggest-attribute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 \
-	-Wstrict-overflow=5 -fno-semantic-interposition
+	-fno-semantic-interposition
 else
 EXTRA_CFLAGS = -Wunused-command-line-argument
 endif
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 20dc44eb..ddbd2445 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -33,7 +33,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
           -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 \
           -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
           -fasynchronous-unwind-tables -fdiagnostics-show-option \
-          -Werror -Wno-aggregate-return -Wno-redundant-decls -Wstrict-overflow=5 \
+          -Werror -Wno-aggregate-return -Wno-redundant-decls \
           $(EXTRA_CFLAGS)
 
 override CFLAGS += $(LFS_CFLAGS)
-- 
2.54.0

