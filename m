Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EC53C3F4A
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141380; cv=none; b=nTOur+ldjAFqnSDzFdQA/Gzc4QkDB9EVxfoHSpY24qrhL0HYx6/QbJkL90xyUBG5nRA0JMbhrhPq0YWWEcFyxjCTQWmW73w72tarUHwRKOCaVzsJCPUQ2yIM+iRtPDY0E7O/aUAiIBDNn+KrzGpPm9cxOUAFmrW/+DSEfk9aiPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141380; c=relaxed/simple;
	bh=Wq97+XW+f9tPNX8ANdrOWjWJMM74Q9LDvloMtUQHMcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLUyE3wkG/MPiO0dIMW6RYtnHPotqjCNkzV0AlCjLiZCtMSMW+e2g0EFPk6F/SMDucyVxPLBf9+89Xzy09L4ENjxL4q0qYTMTHcTTg1QMxaRt8wZB9dgFXTSy9D2W5Vj5E3Zz0dG8xxYoeWA+ph63GkezMoOHRf6G55OFzXNplA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLskyhCO; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLskyhCO"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8f29ec73064so52319016d6.1
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 11:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784141376; x=1784746176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mlXapX/IrB6b6EMgDeJp1+nZEvUQKSdek9MdLGq99b4=;
        b=dLskyhCOyqU6E4HsML7qs1exfdOct97tczaz1VAxrHlOCQ2yrsnG+5Yx/eBNIzrKJP
         uw2JZ7/N/yHbpZyBc3DHF0Lbhtt7vSyKskem4d+YJypa4o7Rrq6qwPtgsiicg0OpZnJt
         TATpOVG+tGxyDDx8kuSojyPy1hNSpTwAz+dbCNoYAmCLmTX6ZunFpQkSSTVuxXcCUX6+
         tbd8jEe+VhbKS+qJG95Zc98T/srO0B94IOWP2wbBZi1h8cUCjNDVSD8vMg9V0EJgp0uA
         77lAudTawMmCWMDaAUVc5celJXFWVJ3yCkhneoYETNvuB9M9y4XExtBHtpIXJOADbQFH
         ATew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784141376; x=1784746176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mlXapX/IrB6b6EMgDeJp1+nZEvUQKSdek9MdLGq99b4=;
        b=BhbNoUMICFGR2tlERPhHBli3KNdjFmFq8VKoSXnttMRFaw3njkFb0GGPm65Y1CYLVr
         vOzDSTh3MhHtotP25F4ZYgcbPgctVSE6r2U0XHLl9h/KZwnCh99hHtSiNz8nX2Hzl9wS
         euug+vPJxcV+51R3v8uggKAg+/fFy2FpRhZaHQ0w3K6VQFH2RnNrZa4a1rE3rAOUVmNN
         7hgjyPsDhMwOfi3SAOYL6o+TXcbcHhMT0/FzFpWmhMGhFLJwjj9jFarbj2qdj53kpdjp
         3y+Y7Asf46mO5LGPfHHlewtIhly3jeuGIW84xGoQfukgEB7OkFzf19BZyBAuIzBhhbyE
         EiQQ==
X-Gm-Message-State: AOJu0YwlYMavBUGovVFtrNh5lM7XFo2xtHgUKononhlHo1t1azxNN5nV
	MEns35IxxnyuSyze3tunzVrb7gx6Qps1FzdOSZhz1wQhIBYU8Urvb5Y9xkxZcA==
X-Gm-Gg: AfdE7ck3PenXdaP1Olq0Cpq/JJ0Uxqetf/3hjIfZ5gLRUfVkJKLcCZAc9Pcuofj0cPA
	k5Gz8g7JewgGfWcbpUmPvzSRB5NLdLQJQ5NkdAShdDMT/V5iOftXJIOL/acCtyYOKHelILeqj0J
	f65ZHiFzC1yrbr+gC2GLYg9iwV0pAT8K2GpLCJ62taFyPThsvXmFXv1Q39VXoqioFHjxQkk9/2v
	6cxcNUSU9LX9Yu0DcRqiUN18zl1dSNVv/d7CmuXE0Ugr3ONzcDzyyV4ABaR75zyAdRUBOGMd7qj
	X21RRmpOpeRVY4b52KIS8TJbPkaSBbrt46EbL1XG877RogSRBtC/5uQH6oHdFmLfiObPXVUV4LR
	Vu7jMb4bifStDg/+KxYLZf9RV53wthiO217XIhwMTxGc3KSH4K+fqHn3Yk/PhxO7X4j8+805dHL
	imm0YYFIW4XTNP7eJBf48vQg58rp3+yDPhxa8laJD7XBt/3EuWgsEryCv8Aa1IwHJxyYiNajixu
	V4KgjAUOPrLeGua
X-Received: by 2002:a05:6214:320a:b0:8fe:5a1:c97e with SMTP id 6a1803df08f44-9074c772289mr91513246d6.29.1784141375991;
        Wed, 15 Jul 2026 11:49:35 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd82ea9casm198015696d6.42.2026.07.15.11.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:49:35 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 4/5] libselinux: label_file: fstat after open in open_file()
Date: Wed, 15 Jul 2026 14:49:13 -0400
Message-ID: <20260715184914.45524-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715184914.45524-1-stephen.smalley.work@gmail.com>
References: <20260715184914.45524-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Obtain the file stats via fstat() after opening it to ensure that we
use the correct size for the file that was actually opened. The
earlier stat() by path is still required to obtain and compare mtimes
when picking the newest file.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_file.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 427e4071..1d80dd68 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1240,8 +1240,20 @@ static FILE *open_file(const char *path, const char *suffix, char *save_path,
 		return NULL;
 	}
 
-	memcpy(sb, &found->sb, sizeof(*sb));
-	return fopen(save_path, "re");
+	FILE *fp = fopen(save_path, "re");
+	if (!fp)
+		return NULL;
+
+	/*
+	 * Re-stat to ensure we use the same file size
+	 * as the file we just opened.
+	 */
+	if (fstat(fileno(fp), sb) < 0) {
+		fclose_errno_safe(fp);
+		return NULL;
+	}
+
+	return fp;
 }
 
 static int process_file(const char *path, const char *suffix,
-- 
2.55.0

