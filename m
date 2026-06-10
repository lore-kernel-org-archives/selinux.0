Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2931B406834
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095374; cv=none; b=LajHLDvoS1pPEycDKzwvASKQVXu1rWVGX3usgod5txZGTPT4/utjMcT0+iIgKMRaELqSDw1KIbCjHazxsJO2Vhe7JnfPstMTtvWFj8I5uedNtKUPZ1V8WMu8vwBmGvO/4XHfm/T2/30pYB3KMekEchrmfzfmCRilX920vaoOW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095374; c=relaxed/simple;
	bh=rJYB0ZDNhK9YpzgOjuDNYkqLne28+o0ayshqW9N4U9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jqE1OtgHZJ8fcM6wFwqaYLNIk7I+xEQDk9IsS+4a1eySHEOrKXzU5csE0r89LfKwTB2r2rdD/ntadndFA97UaS+rVUdq7CkCObRU4Y64Zhv5X0QwnyRvn6faH9nqSHe806vRS4YVF5LpJlhdvU9wQKeyN4wau9wgUH4s0nf/sw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToM1VAKH; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToM1VAKH"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5176465a4a4so90403781cf.2
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 05:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095372; x=1781700172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1tJLLJQCZiazhu+C0uHqE8l1eITBY1UX84JARltNPFI=;
        b=ToM1VAKHDKwYVmrluGjOiOP3TI6mtrC6ViDztGhyyCOUkB3HpsrwGojgFtG59HARYy
         u1lTMi/52VwbEFe8XrNxiWauRw21o3td5Z+OPIvZdRr+av2fwrCVhjpV7TpuHpN9XPGq
         khmIH6C85TP/wRvV5YM+BlXpuv8Khn8FfujwrwY+e+cjdeQ6CcjwnyhtFKHVQ5SF8eoj
         XMnyWJCDreO20hNSB1s+ffFQWGx61Ig4EnPzqEepn6G2bp4B2wFg8GXmDE0NFDYPbUEU
         e+93xttf2ftHgsk8p2ym82NZ1CAV8I4etAy7l3mLhh5HsCMFr037ay2SCvNK62CPC/0e
         s3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095372; x=1781700172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tJLLJQCZiazhu+C0uHqE8l1eITBY1UX84JARltNPFI=;
        b=TUStURn2+U5zBEbaFHKlubvaOTtzkBtIxCQAa/Dn04DqC1NmmoqMd9TFneeiTY2YH5
         99hK0RlyDCAQSk0UfDPTjc2EgcBYluIT99/YWxkmS4HWpxeKvR8cfXF9bsvECudLQxei
         z4HVg7cB9+879J8+Kqovl+x4nLTajB7qsQQYa8lXvAbIi9xAURqWrlI9dKHCqhVWzfbb
         Qm0ST4UrJOH6/9dWRxL7KLy2mBdV/4EbZ3UML04Z+mJo2KFLVDjZ2if8gAMlU18x7eMy
         JSmE40kwytR5833VceQPNOMOqSd02mpVamw4OG+JbBOicXh2Ng5kkgPHwzWuebLjK6cd
         ZpYQ==
X-Gm-Message-State: AOJu0YyV9yaT8AaoiJzBKloB+CettyDQlThIU7Y0jyKuXQub9bV1zQ+2
	S3LG7V7xgltMOHaxh3PtSssmiuZuQPj3l8nICC/PFx4S0ARpbV7mFkqpFP4DCQ==
X-Gm-Gg: Acq92OH6lXAP+X68xRH/Fe1qB6YQPkzWBcsaBRHnV1k2xF1JVRl7bwGpRQc+3eWEU87
	WxRrcQ0nceVlXwTa3nAHc8wAvl4YeAsIJnd/CQ2v6Y6rlRzMlV/h3XcJs/nFutwUfQnET7eSQh+
	pYwegf18EL612go9g0OzyCHpZu4UTd+IL77PP8ZSl7EKkiY0sW61jJC94meeSxYaCoJr4HguWuW
	FobxBXaRFhJifZtapNSu7joweZvob5N199RqkMqDSI5s1PZVEh0MVPFZGE4MkkPW6NM5LAZcUtk
	LUdgtiIHfHUOcLhOXfhRBwfFZ1GSS/5EJh3LI61fI3tgIbKcKW9rO6z3Ww41ScozA87qZUETcMe
	zwsXr+xGPUPSks++5E+QYplVl/HMWUwwUxmVMgujme7uxf3zM7kdbuy+m+5f1BQQXnmthL7grUg
	8eHu0M+vjOZBlNDxdQhNt80s68/ibzu9KHZhOFdCzTE0yiRCe432pX1/Jj+r86USsN0otzlzSGQ
	SbBw0jvh64uFfyPgzAaIGe7h0Shu1IU/mun+Q==
X-Received: by 2002:a05:622a:1808:b0:517:96f0:5658 with SMTP id d75a77b69052e-51796f06eadmr352413211cf.14.1781095372015;
        Wed, 10 Jun 2026 05:42:52 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517940762fbsm158312171cf.18.2026.06.10.05.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 05:42:51 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	netliomax25-code <netliomax25@gmail.com>
Subject: [PATCH] sestatus: null-terminate process and file check entries
Date: Wed, 10 Jun 2026 08:42:29 -0400
Message-ID: <20260610124229.5628-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: netliomax25-code <netliomax25@gmail.com>

load_checks() copies each [process]/[files] entry with malloc(buf_len)
followed by memcpy(dst, bufp, buf_len), leaving no room for a
terminator. A config line without a trailing newline (such as the last
line of /etc/sestatus.conf) yields a buffer of exactly buf_len bytes
with no NUL, and the entries are later used as C strings in pidof(),
lgetfilecon(), lstat() and printf_tab(), producing a heap over-read.
Allocate one extra byte and terminate the copy.

Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
---
 policycoreutils/sestatus/sestatus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
index d83602fd..528cdcce 100644
--- a/policycoreutils/sestatus/sestatus.c
+++ b/policycoreutils/sestatus/sestatus.c
@@ -135,22 +135,24 @@ static void load_checks(char *pc[], int *npc, char *fc[], int *nfc)
 				case 0:
 					if (*npc >= MAX_CHECK)
 						break;
-					pc[*npc] = (char *)malloc((buf_len) *
+					pc[*npc] = (char *)malloc((buf_len + 1) *
 								  sizeof(char));
 					if (!pc[*npc])
 						break;
 					memcpy(pc[*npc], bufp, buf_len);
+					pc[*npc][buf_len] = '\0';
 					(*npc)++;
 					bufp = NULL;
 					break;
 				case 1:
 					if (*nfc >= MAX_CHECK)
 						break;
-					fc[*nfc] = (char *)malloc((buf_len) *
+					fc[*nfc] = (char *)malloc((buf_len + 1) *
 								  sizeof(char));
 					if (!fc[*nfc])
 						break;
 					memcpy(fc[*nfc], bufp, buf_len);
+					fc[*nfc][buf_len] = '\0';
 					(*nfc)++;
 					bufp = NULL;
 					break;
-- 
2.54.0

