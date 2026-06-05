Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC5F421A00
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687118; cv=none; b=lV1vnMystb7uy20bOdhzvDA8zmgEUUzVIK2rpNC1pVsdmlozpM9lJbLBeO/kV2YeM3c1gvqefkr9b4FDUPI1XjgxbT0NiWsTV+Nlie+jg8kS1kuhIRC6lHZgbNodZ8TTWIrUVoF0VXef6eotRL5A/QuuA3USn8hl14vfPXcZKQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687118; c=relaxed/simple;
	bh=Uc7fnjrxUurSzzx71TJqbjInLomUcFcCiEHKtPyWb+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qMZthTjW0/sdSqD5dbrTMlxha9ILuqvJnf79hZL4ayUnE7B2kiJDs1dqF2jAYjCG8n53vT8D4KkYmixhqKKST1Sj64RIsNOYdG+pw112BIVwO08M5nyzOIgqirFDLUWjT+1Q7KkfB0kXWCWNdOvmajUDYg5vy7/leU1pD8SeY+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBfRnRxl; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBfRnRxl"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ce9df31130so33182026d6.1
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 12:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780687112; x=1781291912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sEydAsP4kSC/jQFvTB/13cyMY9WIcXtVwWkjO94K+7g=;
        b=QBfRnRxlOzHo4aukHRHFSqfqcdXDNm9eerNz92SKKTrpzi11Rj9vTwe9qjY+x+efxN
         s8U7s2nNf3AiKNpZg39EitbQMQ6u+r9r2AplnNp68qm5RfWYNBd5YdBQqMVJzNRSWfQ5
         YGF4t6xHb+C35mhCxTxyjUPJqyi6v0aIxCHeEJHMjGnb0jMn7kftDUItSnuhY2crASsZ
         Cm5Hppvomuf6B0hNr3/PGbTX95nhb04QN1NrZ6pc8iVSGRTZGir1JsEO/CTY8pgMnIib
         ZWVGDa15OEYKJqE/Ez+1tdOYKK9ucn8XRVlNoEsAQ1FPg3ODR4D7b1O/HzcUqXm3p5xx
         7n2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780687112; x=1781291912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEydAsP4kSC/jQFvTB/13cyMY9WIcXtVwWkjO94K+7g=;
        b=nqKNPwoibPtUTo6uX0Giyoxf4jIpZKYQJBVlqB3FDrDqDT2AnZWC8q8y/nvQQ3bhYC
         JDz1QGsncNkL1qsOP3tWXfEwuFRn/NXHpjbBjjL0jjLaeo2OWivKcJZamp8BKbhECS+b
         DGwovWi9ikmgcuXXlU38VElFPimPAy4DtA5/XK+gCsQNSY4BqNEABQNk3cKRajq2hEet
         WiIvs/X4IO9fVp7mJlrWPI3vJpKfRU5CWZU2E2jhC+KBPnCgLCCCXIc1+D185P6pL54P
         W8KGouy4KarZYXX3HsAsAKdBEDIS+GdC9a4TkDcXqnjaSFPgGx+kRq1UhazQzsQP4zyR
         VRow==
X-Gm-Message-State: AOJu0YyxxJLyUfnbnFAExPIg7Y6zhJXGvI+y5Jv+4Ujc8JFyOe7nXmia
	avawbFc8ubyvQGIaAXQslp7FGpBxCExVykvmqP5b/W8RHudZxiW4OKcIVln6Qg==
X-Gm-Gg: Acq92OFJ45XXSgiUlvK28xVIcS78gjWqhvw6J9J6edR/Ka29Y//ab+yhzb91qBxk1rl
	QinaQPESoHEXqdsa7DN16ydQVl6k5kUwi95GAugsAp7aBG3XdNl1OyIMrwXbwpSyWPsyVefKqgD
	P2num99CSQvUXVIrBkwdaa77JdQ75I/I0CT01BrfxGkzF1hL1hhD0Yn4fhiyvRwNQuyIT8Clx/2
	wMBGuCbtkDmq2hhO3ZcnkxzT71JcSD5NTw+EpNR1czhdA1sJ7hceZUVo0dEk9FN1FGTDTLEiT38
	xXcuaxOvjNKEiHOVjnUkNMCaNM6kKH1osuJWP/LvJMrkyfqFqe0zHsu7pEh3+IAjHv4HCslx4C0
	Rvbyi3vT+WT3SJxiftXeuR5ajO6uFmrVQX3iN4RyB9cKoVEytm1BcFxrt4ksdDw8MgFd+hlVfR4
	h43VJR0+S6FuFkviQvn8ac7Z62UM74WdAs+dEQ/k36+6EJ0Q8JdtFQdBK+ymdzxKFr2S6S58Qri
	/b0xs+UZQNanxI++f8CB1BRsbZOvVxIHej90+0MEQLluR41
X-Received: by 2002:a0c:f146:0:20b0:8cc:f074:95e with SMTP id 6a1803df08f44-8cee61337camr72801806d6.30.1780687112253;
        Fri, 05 Jun 2026 12:18:32 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd26b9d5sm98405086d6.44.2026.06.05.12.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 12:18:31 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Marcos Freitas de Morais <1111marcosmorais@protonmail.com>
Subject: [PATCH] secilc/docs: Adjusted correct statement keyword.
Date: Fri,  5 Jun 2026 15:18:18 -0400
Message-ID: <20260605191818.281562-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcos Freitas de Morais <1111marcosmorais@protonmail.com>

Fixes: https://github.com/SELinuxProject/selinux/pull/515
Signed-off-by: Marcos Freitas de Morais <1111marcosmorais@protonmail.com>
---
 secilc/docs/cil_role_statements.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/secilc/docs/cil_role_statements.md b/secilc/docs/cil_role_statements.md
index 2e1b4047..3e0688db 100644
--- a/secilc/docs/cil_role_statements.md
+++ b/secilc/docs/cil_role_statements.md
@@ -51,7 +51,7 @@ Authorises a [`role`](cil_role_statements.md#role) to access a [`type`](cil_type
 **Statement definition:**
 
 ```secil
-    (role role_id type_id)
+    (roletype role_id type_id)
 ```
 
 **Where:**
-- 
2.54.0

