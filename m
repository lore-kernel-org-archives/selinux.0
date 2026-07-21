Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779A033F597
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640804; cv=none; b=TieMOdatkg2bTnjNtOo6poKCe7y4xgxd8Q5mjxM3Ob3VyRUDOgqn/mSOCmK+seG8parKI5fMMqXtVnphR3Jp+cx5bbKmmh/halHwZCy832hznraN7iVCQPNQD3B8syl/qVcIDH4KwZOccKVTcdlFIi4QauXwVao5ZAb3EZSZjGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640804; c=relaxed/simple;
	bh=dBPGz3tbfK4XopNFRwHyKmyEBpbJ1QDqWTbZ5Lv/xBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pe89Ft4BrjH5y3todBj9kd/hhQItnA8bILPP/q7+/Dwi9fuBhIBmLWlSNerL6y3n6zN7BY8b40FeBUbH87aJ6P0KQD/vybuKz9Or8awlZTSaPxwL11GUSHM/NtFTFPg+M9w2ejiB756hvMmja7DAbeInTpfXGSlGnZ3n/aykjss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV+a2hzS; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV+a2hzS"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c2149571dso67248491cf.3
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 06:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784640802; x=1785245602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7rgBVfna4wZf8fUqUFLRDHvyD+PY+0E/Wj356rRZVug=;
        b=YV+a2hzSTCikAwp32sfOc3RMKGoasM8c2VSRN9aPD+BApf9dOHld2qdQMo/YsD1h9t
         y+NZclIyb5WpAewOeTSow8cGEqC7tWdBByyu6Wdsgy3AFdfYbrNEZ8PdIunRSHRCmTPr
         Q/RDqbrdixxTFJ3DuVgdgSkNCxxnl27tDvymZ5TIvBlNQiPaiE3Iw3zFZW3v4+8iUhm+
         vx0Og6+lA4ztgQI3pV2KHNmm/t3WB+2w04oXdXu/Nwz5qpkP5ucymgDnqK6qWPtsf2CZ
         YQ1RqrsrlKAFw5Bjt5iqiS/I7cxiPEr9b3URYmflO/Zd5/N6ZjqJSiG4+kS+Lh58efEB
         uaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784640802; x=1785245602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7rgBVfna4wZf8fUqUFLRDHvyD+PY+0E/Wj356rRZVug=;
        b=KPq1Cl1a1HUpAsdubIwb7bCrZuuPjtuUlBdmoUlhau0PQUZhpBx6WMUDLyXBZ0RW/5
         RxYoXdrmhPciyf7XzJpjhxpsiFp8dnmwB0WQtmdEz5ufvYbdK4fIsA5jv5o4IzssYKMd
         TxmKjm3Wyhdfcb+lpIuRDZYKX0Q6m70D+PjC1+/WMGBLd+sP0sCJV3pn1b1vbus2eOiv
         Ff+13UQO31Hr/7sh5m3GZiZkhxsDh8IOgNZz9nP7sgKmjE7vOVMfBMXtRZG3ijsS7Yca
         zXB7aHmbf0eYcQyI5besEdLq2nfuVADngUpH0LoNAueBpBc6bgjHXfgZuxnxeX+KuL3A
         JuqA==
X-Gm-Message-State: AOJu0YycHVEROUOdyA3Fg6arhrE3PUG6tvebdT19GDfPJy6MoB/Avpya
	hbP3rWi8nfFT7Y92BGVQYgCeUpR5D2FScH1M4ilw4xRnq1AhBkhVQ5FqGKQJ1w==
X-Gm-Gg: AfdE7cmAg7FJkuBGJq7YaGcktXLmLGbPObFgea8rxr1PePy/JU3ZCfa4p/Ai0RvOHpT
	EDFwUQTahEVVHh8+l5KcFsYfLtUfIk+ruLKpCUVM7YhM79NdbaA4HZLLOZxjg3aQZOAg8KmSnMG
	Xn1fm+9irjiRMXLxe5GdtqHb9P+JNGEjwYn5pP+J7O//H24yusAGcpT3F6TClKKPKs5ReHzYTi9
	AQbP8ssSgcCtyyTDSbmUv0rCdDZIOrcSDsB1GPQVxtEJ8ctq+UV84i5OI6jXiUj5AMxhpZ/jdW0
	YOyl/Ncnl31SO0AD+6IZRVDauEBdkXzA4s/YEJYyesXooYTJ4qaRJJqhhV13ydxgeNC0/mwoVIN
	87GBchbMQrDEcG+IqIrZ07zxWptFf98j4x3zSWSJzLeoTnZh5yv33JJkwzGpS++hyYQKgdRSU9d
	lGnn1aV937skeZPi/gnuzQA5swnj5Z8TM4EY4dEpa+Mu/BO3samFkrm5mj0+yFxS1iPglw7xm1/
	gHmEA==
X-Received: by 2002:ac8:6f0a:0:b0:51a:8c97:fb9c with SMTP id d75a77b69052e-5213fc584a3mr170593151cf.69.1784640802325;
        Tue, 21 Jul 2026 06:33:22 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214f016aa5sm95848861cf.17.2026.07.21.06.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 06:33:21 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] sandbox/seunshare.8: Fix typo
Date: Tue, 21 Jul 2026 09:32:51 -0400
Message-ID: <20260721133250.55931-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
NB This is already merged, just posting it for the record.

 sandbox/seunshare.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sandbox/seunshare.8 b/sandbox/seunshare.8
index bad7e1dc..95eb9c88 100644
--- a/sandbox/seunshare.8
+++ b/sandbox/seunshare.8
@@ -23,7 +23,7 @@ Use alternate temporary directory to mount on XDG_RUNTIME_DIR (/run/user/$UID).
 .TP
 \fB\-C --capabilities\fR
 Retained for compatibility; has no effect. seunshare always drops all
-capabilities and sets the no-root seecurebits so setuid-root programs
+capabilities and sets the no-root securebits so setuid-root programs
 run without capabilities, but leaves the bounding set intact so
 programs with file capabilities continue to work.
 .TP
-- 
2.55.0

