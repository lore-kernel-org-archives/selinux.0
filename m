Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E71414A0F
	for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206387; cv=none; b=iH4/i77zO1coRERIBdDTkUeDyjCZZcj/4M799OQDZix4RKM8zfcZvVyMRZjL03oDx/mqDn47fvAO/kro727BE0FrjJe6iOkfERcOdZjlaMHGQmOgbVJ/aSfz5g5KH8OfZQBCabzCbLnfga6TVagz0XSRnSY3cCeilKgtWe/pFjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206387; c=relaxed/simple;
	bh=DbL4+xKoIVspbrlYLJiLzcsPULOojrsmCqbKTbotjfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diQXvCGhrwk+3zeV8ge6JfZ3xZhyY57L7ktWQFHa7WQ1sixcfioNWIwn4IRbRU6J2Mvv6P0AuWaHOF+34K2X7nEBuLpQaMOTuX//Kax7uHzI+687qjGM8ZqKlNpegCec/gjw1ARwTVysaaJQ45RwjGe5n8z4/m4/BAxMrQhSYTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jY7i5l0N; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY7i5l0N"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8eefd0c5f59so32858146d6.3
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 05:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784206385; x=1784811185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hxq9GQDJCF3XRlrIrdYfNDd9VfGwP+NLL8BEehFA9xU=;
        b=jY7i5l0NoI3QUNVuQdHk17GIJzuRpAduicMhqVwECNcgpJIqSvjXc8uboK+rmgrUU/
         ReeOOV1A1tr+x8dr8F1odjjWeWCDgyKuWgeJQxa7ZbjscO5tV3qom+G1y15PK1yLINlw
         bAlK9tVupyoW/HMAUavCaMT0GZ/r+mxEKD9+fBX6umBCOlsAMu5Bej4pT5mSoy11tAiN
         LXZ/Qy/GH75ZthAIHucc1RWdR81w9V82s2oOcd4O6t4mUDPzyOsDniIhJWZrQaGvPn4Z
         yRH+xlUcXp5dkNLZaTT7fpWXU9T8Ez5Fi3jUG1LzdUXYzRuhpYZiwYmeRuP8xen1vK/i
         D8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784206385; x=1784811185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hxq9GQDJCF3XRlrIrdYfNDd9VfGwP+NLL8BEehFA9xU=;
        b=NRV/RZR69jbH9E4FPzlSv6NFZFGZdbDCslw12KWpAMZUhv1gMlKutlGN6UtiXImvqR
         FFC/nWGPrm+S7iX4Lx+p3Dl68B6SWBG6Aan6p1rH+fZ1B9qb5e0rFjIsnqoR2jegfcNu
         n8jfBrvfJvzXBJp+aum5pM4bpsJkwQjkU9GhYet99+g+kZ6XO01CpT2+bPjg4UMaLyol
         MFl+8e4icB0D5cVZAq3/irwWLTbORMlUO0VXX/4NytUwYaP0LoN1eI2ZyVyv43+c9SMI
         5VXWxXkd9a8ywpI0eDkkCClitlM7GtuiIJCoHx/EHOFT4QxCfUmIhcGDsX1smM4ZlSx6
         DPcQ==
X-Gm-Message-State: AOJu0YwOnZ0Z95NwzCNtIAXAvbx6s9edYU+rurTJF+Equ27fesLMDyaY
	db5FtkzJIkhPGO14gPa03ojrWUc7nIGf7d/CMnRKxO7RvEkNZ8T3qTrd2nYMVQ==
X-Gm-Gg: AfdE7cnTiULkQYfkmazBHC1iRRBdysAQtYt2C5OQDmP7d/n1ELY3LYelck6Fog3o6Dq
	7zVN5Pp25pMGIHhbUwxTBwj50wXPRvtublojYlA8bDTu5D3slGY+SLeLrL8CTcgA4D0Mdm8nIq8
	TGwipYjIpxZnaHhho4UgVQT78gxUCedyxahwx3o3YeblYhbn6PB5T+rEC27X53SV3zFDo+UFBY7
	pyZF0p656rxeFO2ugqpwDKT7p+OSd1AdcM80KyPKETpn+ckuSKMAbMK1IB6jEvTvYUmHWcBNucT
	Kyt/wW2RTDsPNnr5xZQMPrT7iLg24ukkwIq1IDp2vn3Dvj0eEmqmNgrMQK5j6VnyC+SRKAkgTGx
	hFFshRqtgEFphL7aegC3MlZ9PKHdhkspZvPghhjSkotpQmPDkD9MaggQbjqcmi+ZEPSscncp2/d
	GtH6kyMgQVJVRjxuBLkjUaaV9jjrpFpKSOviDSoHPL+zjkzLg2+lF4IR2zk4pj1nY84unYdatDT
	SInew==
X-Received: by 2002:a05:6214:2127:b0:8fd:6df3:b376 with SMTP id 6a1803df08f44-90402a6ad32mr241232936d6.58.1784206385390;
        Thu, 16 Jul 2026 05:53:05 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-904116650b7sm196161866d6.8.2026.07.16.05.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:53:05 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] mcstrans: bound Include nesting depth
Date: Thu, 16 Jul 2026 08:52:49 -0400
Message-ID: <20260716125249.6872-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716125249.6872-1-stephen.smalley.work@gmail.com>
References: <20260716125249.6872-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

process_trans() handles Include directives by calling
read_translations() on each matched path, which in turn calls
process_trans() line by line. A configuration file that Includes
itself (directly or via a cycle) recurses until the daemon runs out of
file descriptors or stack. Cap the nesting depth at 32.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstrans.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index b5c8d54a..e79aa3d5 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -911,16 +911,23 @@ static int process_trans(char *buffer)
 
 int read_translations(const char *filename)
 {
+	static unsigned int depth;
 	size_t size = 0;
 	char *buffer = NULL;
 	int rval = 0;
 
+	if (depth >= 32) {
+		syslog(LOG_ERR, "%s: Include nesting too deep", filename);
+		return -1;
+	}
+
 	FILE *cfg = fopen(filename, "r");
 	if (!cfg) {
 		syslog(LOG_ERR, "%s file open failed", filename);
 		return -1;
 	}
 
+	depth++;
 	__fsetlocking(cfg, FSETLOCKING_BYCALLER);
 	while (getline(&buffer, &size, cfg) > 0) {
 		if (process_trans(buffer) < 0) {
@@ -931,6 +938,7 @@ int read_translations(const char *filename)
 	}
 	free(buffer);
 	fclose(cfg);
+	depth--;
 	return rval;
 }
 
-- 
2.55.0

