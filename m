Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A4842376B
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777874; cv=none; b=HaBZNLJ5TMj6DK6D7a3HFKP2LzWDa1JUZ8/mq+p+H/6Yy+vXzwFHYokhS59W1L11V/1sb/xG2p7UOIlp8DEaYYcLHAcjwpudIb4qzzULUvZ8KBakgNS0xp3XNEbTWrzRYF2bz5cK9hgZ86k8+wK6z52UdYJKC83dBr5hxLpzFWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777874; c=relaxed/simple;
	bh=F7XvJFOfUu5DGA86cNH3IjEYeQ7ctxRsxY1g7GUX4k0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R3AAcvK4Oz97N1O5JR3j6140K3SgHRPzbctum5T3aMaydXQqwD3qz4yNLU4REHlVIGnn/i1GpsKh0dtTHbkTpb7VgXu1AKDiMGvN+eEd1DSVqp38rzLp7ESC50WmYMDe3PgOoW5deAT6bOEqS3TVlxbNue3bw77IV/g378OkzlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnlpDSBJ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnlpDSBJ"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c5382806fso34663221cf.2
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 10:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785777871; x=1786382671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ebHR9rRaauLWNbjUxZcJBsqzSViYDb0NA0BiPMbRE6I=;
        b=lnlpDSBJJFQrvz1gJzGLvMelNkWcytH6akzdoqv3yRGg4085ToGM7i38AsX61fjr4q
         VG040fMHIAbNnWLv7zgffpHUnNYzby8CW1g85EidfvtIqdUCdG/uedxEgo4mOkHc+Ub3
         x+DAFphUra741M5d+QNYPq2D9gEv96jMhSp9boAjg7iXGfnnBAbmBu37RBrDvu7D7pSe
         UowowvRWA+6D9y+t628gABAF836td6GUL1B8x07xQ2Lio2irZBA88Tyq8FwRdq2Smd07
         DKK2gfe/b5ahn7slyBrmFYzhl9KI1lTB9TmzHJVHPX5/7kv0WsYWjKDFdG839nVNHrrC
         1Byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785777871; x=1786382671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ebHR9rRaauLWNbjUxZcJBsqzSViYDb0NA0BiPMbRE6I=;
        b=ZLMqY8SqUAi0BUgp8VHNT9ATFT41Z4ysC+b3x9XSwLii9LTl0vp9anFiTh4K/F5CGp
         PE8S2ZF7BuGN7tIAYwRhLqXynKQHV+QDqStEFn8IvnXLTWBlIYDn1wkeCeyphNX3pNTP
         i4jITxyqWWH786AddK4qCjrnUnnY2YwtNSNVSN4j9VSuUWqQkRtirSTRKaVMBw3tkqLz
         iFT6o16+hID6ldcnBvTLTBICCIOj81sPVotpsPokHnHPEW9w/eC+AaL7ugGANtotysLq
         qdsumYD78NrqlCQkWmKq1WbQNsS4aocpJRRtw6xlLQvK0QP9cUnEvAQ3vuVZZJ/3jR/n
         f4lQ==
X-Gm-Message-State: AOJu0Yz+7ZW5Jk9iyym3ZoQS+3GA90bn7OxiHAZjQL4juK2LVIbeg3Bf
	qgJkoSpSxM7n/WbUfLNl+6CAX7UiPfvKQZ77awGfKNzLZNfmS4h+XqTewBGcaQ==
X-Gm-Gg: AR+sD13bYrAmx7Fow/+uh1ndTMyyK4oqo2zQhVy/QwIMjMyQGmdPrew0emaGE0pK0rq
	r8X7RL/hDJDZOxGt9TwX8f1FaFL2OkABZ2AmKXa2YAzDNYxU40xGDFi22VAic5y0xXXqfc+U4SE
	Xpq73gjBkNYSLnpvEwPtg3vo79fQrxZpf/XoICAeJmwvFlPvRtR+j0293ohQ2EPTLpe7HXn5ako
	or9R/Gr1aIlaFTm8mMhR5QpMSnomqmFAAjKSn2VafJMbl9T8UB+e+IOrPI1iRXqbqQvr9KCRK8b
	Vl4uqY9QXn5C0oJui2QAI32L5LjTzMa74x26LiRUQJAvcYtAL3WB7RhWekFL/vhSCM/pctft1YY
	bF5TSMnxUEu41RtHBX2nI/zyL6ivCwfOW8dBn5gNj8JsVSJLHx+3elFRZT79C/Qt1RxuVGxC+30
	0llBobXcnBhG/ZgDzzpkB/c25BsF0nPpIlpMXG81UBEdK3jugSY2+K4ud9rjE5o5In9pRNmx0JO
	yZ4yg8fIAs=
X-Received: by 2002:a05:622a:5816:b0:51a:329:e802 with SMTP id d75a77b69052e-52b567d3c6emr216059501cf.41.1785777871567;
        Mon, 03 Aug 2026 10:24:31 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908435b6086sm80097116d6.29.2026.08.03.10.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 10:24:31 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] secilc: Use size_t for file sizes
Date: Mon,  3 Aug 2026 13:24:20 -0400
Message-ID: <20260803172420.23048-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The programs secil2conf, secilc2tree, and secilc use uint32_t for
the value of the size of the input files being read. This could
lead to a file larger than 4 GiB being truncated, so use size_t
instead.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/secil2conf.c | 2 +-
 secilc/secil2tree.c | 2 +-
 secilc/secilc.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/secilc/secil2conf.c b/secilc/secil2conf.c
index 9c028656..8378aceb 100644
--- a/secilc/secil2conf.c
+++ b/secilc/secil2conf.c
@@ -66,7 +66,7 @@ int main(int argc, char *argv[])
 	FILE *file = NULL;
 	char *buffer = NULL;
 	struct stat filedata;
-	uint32_t file_size;
+	size_t file_size;
 	char *output = NULL;
 	struct cil_db *db = NULL;
 	int mls = -1;
diff --git a/secilc/secil2tree.c b/secilc/secil2tree.c
index 039d1524..e7238a94 100644
--- a/secilc/secil2tree.c
+++ b/secilc/secil2tree.c
@@ -71,7 +71,7 @@ int main(int argc, char *argv[])
 	FILE *file = NULL;
 	char *buffer = NULL;
 	struct stat filedata;
-	uint32_t file_size;
+	size_t file_size;
 	char *output = NULL;
 	struct cil_db *db = NULL;
 	int preserve_tunables = 0;
diff --git a/secilc/secilc.c b/secilc/secilc.c
index 016ffef3..54a15767 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -88,7 +88,7 @@ int main(int argc, char *argv[])
 	FILE *file = NULL;
 	char *buffer = NULL;
 	struct stat filedata;
-	uint32_t file_size;
+	size_t file_size;
 	char *output = NULL;
 	char *filecontexts = NULL;
 	struct cil_db *db = NULL;
-- 
2.55.0

