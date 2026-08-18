Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE38369217
	for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 19:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787082528; cv=none; b=YLZfyNMRGFuVgdjbAtW1PVcQK9FwsxZuRv5hh6QvmyRC3binM29wRjUT+n18ubH92PzGQXG7y/GC7ht0Dm1jUpJvOYmr1OBfABRUBYmMI+z6OUrlaKlkPJPncIX/ytW1KD0+RNBbNuwoX7gcrPcJ2Nhl6XnaM9Cbkj1XN/Yv75M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787082528; c=relaxed/simple;
	bh=wM+1P4MHyGWN/m1ijj+5drZW1TzZlEBZ6sII9PBh58E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=etekMaVh9Z9J1ZCyK1mvVk1R/pdEBEchkTPlEy1kZd9bW46gOs4JJvWyIBVJO7ZVN1thhYj2uI/z8JqLWyGQhOWqXjPi7X5/X/Dxy7PIImRG38nGph4K1SZSygMKq1FBLJ7c+AZnMK1AD+6Z4FWFHML4gmrVojvdvr4EZBrkLCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s4JUMWBJ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4JUMWBJ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c0c45c580so1378191cf.0
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 12:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787082526; x=1787687326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OEPij6N9E3IVebs6EqBCkRVKoik7LNuZ/uDNtcEZn5w=;
        b=s4JUMWBJfYK0Q4F97A8dJ596DKyan78Y7KePNbhqcxfAN1yffydlywwZJtSPCTzgVx
         Qy1ieZanMaVa4kOvIvleOGWb9yAJYgBpZPTWHhOd7aEKPtiFPzW/8w/Te87PNNwBfGzQ
         HMHqG6dOZcISBcJF9TzX8IOKtde93PeoRcnRlO/w/iS7u9YjMpH/kjYhmxWQwKNwfoOB
         z/vP/TBWYKRuOITXCGS617ikwUgGCzx57mcPAHrcVOe6OV9w2GgMh7xv0rbf8Nt5VQCw
         eY2W4zL6g4YwCmfOthJgu+QwCMGjIlicKcbHSRAJqh/NYpVBBL9mx835pBi0JqvUjUN1
         pjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787082526; x=1787687326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OEPij6N9E3IVebs6EqBCkRVKoik7LNuZ/uDNtcEZn5w=;
        b=FEjn3PFBlblQ1STMGwDS3PVC+yUNXhpYuupQdkedfirndQlnCx9M790LFPb7S9RSrK
         VuN/LDe+3TxXK/Tinhqw7hqj1h3mVv6uVvaJpLed08mDgvm7l+dL5sLkcK+lLgZ4s0xc
         se9/NmC5FHhPxFg/T8c0wcV3BEFSvCmyewgDtXTvNrusG1e61mKn0a2+qgCZN5SutJHx
         e0FG0L7EfTt3tqbQXMvNWmZlzgA9Ol9BYFDB1cKXAn2nyKXTmRMQZoS/B/wW5MvEydNu
         unbjk7nF0ebwfd4abOtJ3aLqlIVui6k1YuXpWlf73spwv08XNXCQHPt425Z8aDUHLw/Y
         qVAg==
X-Gm-Message-State: AOJu0YydXmAtSScevGIpwctrQYk8ZGpCHp/VoUx5svK5DjT3MB+EHESq
	qlqK8XjdhgA060yVWUqo08X3oWh7kFhBgDynjBN5GACHbP8cXn8YThXqgeMPPg==
X-Gm-Gg: AR+sD107OKscPgX9hirRDsQXM70MCpBGB/Yo5ZISpmN0l17TuGH5WycMFWOQkdOBTGW
	QLJ9xx9WbdG37QdHvEm/OavzV02evd1qyFUjo52mdh0/e5n8gcLHyDlP/4tdzE6an9Bu34dhjNi
	54N0xLpO7WueOffLKQSEJyCo1Rui0Lhuoi9SJOwKHGBSop0Gq8dt/QR09jZEZcOjkFYudTLSbYy
	ba0NH3HXKMVrJxz/WjrLGxMHPzAsVZUNDk0RJ89dXhY448GSKU3D0arz0e2qpoDram3RMHyyynC
	JHyixtkFjKhHbRU+ujuiyC4fNJVWygERFSBMka/ryBJSnWmYzBoIvC9oaktx0ld1bt/nfGvj2Bp
	5tQWVP8SUmGIWUCin5L2WPzvMc+bZriKnbeaG5QReSZ25JHLBJtp/h0oVOi7mCzcjnKhUlQJ97a
	ne/8UnCuKFW4r8tJvvU9/Ajpp5hpuRKSF04vM5qvZuY4vWTZV/FyXVN+h3EI2Yi6N5Etq9Q5keD
	+Tvi0HJylA=
X-Received: by 2002:ac8:5716:0:b0:528:162e:29d3 with SMTP id d75a77b69052e-52dd32cbfecmr4205501cf.32.1787082526412;
        Tue, 18 Aug 2026 12:48:46 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52db612c2bfsm46638141cf.11.2026.08.18.12.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:48:45 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Use matching integer types in scope_write()
Date: Tue, 18 Aug 2026 15:48:27 -0400
Message-ID: <20260818194827.64744-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the variable "items" is used where a size_t is expected,
just make it a size_t.

Since the variable "i" is compared to an uint32_t, just make it a
uint32_t.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/write.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 4bb39f99..a0c9af85 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1947,7 +1947,8 @@ static int scope_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
 	struct policy_file *fp = pd->fp;
 	uint32_t static_buf[32], *dyn_buf = NULL, *buf;
 	size_t key_len = strlen(key);
-	unsigned int items = 2 + scope->decl_ids_len, i;
+	size_t items = 2 + scope->decl_ids_len;
+	uint32_t i;
 	int rc;
 
 	buf = static_buf;
-- 
2.55.0

